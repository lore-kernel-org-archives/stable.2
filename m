Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2534BAA11
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870038; cv=none; b=c7yGwPEwhWqwoH6SagueMJQrxvB0x8JyFC7Wb7g7sFDUM5m+ur3MgN0SdEywAggHZa6CiRXteeSDEgWBImqjFRn9tBSbbySc8L1Pko02fk5mS4TFoBTTpYvJCz8U/MZfVpWmW6dNrvZMPhz9RJ7HbylsV/Rm48WSk0XhXuFxIbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870038; c=relaxed/simple;
	bh=JqE+OQ9ndhQM/qgmnYqPDdtSGBh9PzjmkhYU7M6LgwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dENUG2MOxlPiKL1DjRPffH/W2UbuITpv2/N7vm6ki7WaPUTkV+ihLKxK1j+MGM1uDlIa5n0CPBVNei7BWuKjcCycc1nMS24w9QMlYkNAlxQqhoNMcPon5vzCKVyLEqZlxHuSyQ+5AOkyi5DA+i26Ag7ewhfA0g/BtCn4iVKIP1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312E71F00ADE;
	Tue,  8 Sep 2026 12:20:34 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/5] entry: Remove syscall_enter_from_user_mode_prepare()
Date: Tue,  8 Sep 2026 08:20:28 -0400
Message-ID: <20260908122030.2052577-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908122030.2052577-1-sashal@kernel.org>
References: <2026090331-spouse-sprawl-968e@gregkh>
 <20260908122030.2052577-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 54a5ab56242f96555999aaa41228f77b4a76e386 ]

Open code the only user in the x86 syscall code and reduce the zoo of
functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084306.652839989@linutronix.de

[ Stable: Open-code the helper in arch/x86/entry/common.c, where the
  32-bit syscall entry code still resides. ]

[ sashal: Reduced backport -- upstream 54a5ab56242f9 touches 3 file(s), this
  backport carries 3. Not backported here:
  arch/x86/entry/syscall_32.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 4a3591287fb7 ("entry: Fix seccomp bypass after ptrace with TSYNC")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/entry/common.c       |  3 ++-
 include/linux/entry-common.h  | 26 +++++---------------------
 kernel/entry/syscall-common.c |  8 --------
 3 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 3c88bdf96e7a5..cbc335c61df1d 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -236,9 +236,10 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 	 * fetch EBP before invoking any of the syscall entry work
 	 * functions.
 	 */
-	syscall_enter_from_user_mode_prepare(regs);
+	enter_from_user_mode(regs);
 
 	instrumentation_begin();
+	local_irq_enable();
 	/* Fetch EBP from where the vDSO stashed it. */
 	if (IS_ENABLED(CONFIG_X86_64)) {
 		/*
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index ed08489e1d329..0d5dc199ed8ca 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -88,23 +88,6 @@ static __always_inline long syscall_trace_enter(struct pt_regs *regs, long sysca
 	return syscall_enter_audit(regs, syscall, work);
 }
 
-/**
- * syscall_enter_from_user_mode_prepare - Establish state and enable interrupts
- * @regs:	Pointer to currents pt_regs
- *
- * Invoked from architecture specific syscall entry code with interrupts
- * disabled. The calling code has to be non-instrumentable. When the
- * function returns all state is correct, interrupts are enabled and the
- * subsequent functions can be instrumented.
- *
- * This handles lockdep, RCU (context tracking) and tracing state, i.e.
- * the functionality provided by enter_from_user_mode().
- *
- * This is invoked when there is extra architecture specific functionality
- * to be done between establishing state and handling user mode entry work.
- */
-void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
-
 /**
  * syscall_enter_from_user_mode_work - Check and handle work before invoking
  *				       a syscall
@@ -112,8 +95,8 @@ void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
  * @syscall:	The syscall number
  *
  * Invoked from architecture specific syscall entry code with interrupts
- * enabled after invoking syscall_enter_from_user_mode_prepare() and extra
- * architecture specific work.
+ * enabled after invoking enter_from_user_mode(), enabling interrupts and
+ * extra architecture specific work.
  *
  * Returns: The original or a modified syscall number
  *
@@ -149,8 +132,9 @@ static __always_inline long syscall_enter_from_user_mode_work(struct pt_regs *re
  * function returns all state is correct, interrupts are enabled and the
  * subsequent functions can be instrumented.
  *
- * This is combination of syscall_enter_from_user_mode_prepare() and
- * syscall_enter_from_user_mode_work().
+ * This is the combination of enter_from_user_mode() and
+ * syscall_enter_from_user_mode_work() to be used when there is no
+ * architecture specific work to be done between the two.
  *
  * Returns: The original or a modified syscall number. See
  * syscall_enter_from_user_mode_work() for further explanation.
diff --git a/kernel/entry/syscall-common.c b/kernel/entry/syscall-common.c
index 5bc39874b0b00..1570b2f221460 100644
--- a/kernel/entry/syscall-common.c
+++ b/kernel/entry/syscall-common.c
@@ -29,14 +29,6 @@ long syscall_enter_audit(struct pt_regs *regs, long syscall,
 	return syscall;
 }
 
-noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
-{
-	enter_from_user_mode(regs);
-	instrumentation_begin();
-	local_irq_enable();
-	instrumentation_end();
-}
-
 /*
  * If SYSCALL_EMU is set, then the only reason to report is when
  * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
-- 
2.53.0

