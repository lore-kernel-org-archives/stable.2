Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F442EC0A7
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788830581; cv=none; b=gFu+AMkiv1wQ+VRQboq1ZrBHr0Dt4RLIG1+zaulExrX7xlXq16Mc0tXiNYzTGN78sneZbnTYGh0Bm3ZzsaQh22pQm6KfCNj1VNl39GOiAKsIdG/e4boXHQdwcVeD1zSOi/udw/AC55iPsKsvudfvNH5YGvXbKBZgXuBQfXg+IcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788830581; c=relaxed/simple;
	bh=/QsPImSXPCIKdJtSZSG6rFk3GFoSb40BF+cIiP4KVQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eT9ELbXfhBLvxY5Sxr44XFIRr+3Xm4b3KO36dRs9y//LtgxPn5AEsJjYFNGBandTHoWsOkto8rS6BuBv7D5vsmG907ertUNKvpmUR1YjfkiohZXxotF0IMSsz5hk3jML9R61U47RisOYkBSsrotJoW8SEXkJn6Ctn9GpTH2STVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myCZ6cc9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myCZ6cc9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7031A1F00AC4;
	Tue,  8 Sep 2026 01:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788830575;
	bh=zFfrWGI6hQNbflnnU5sIDJbpxvvgHel3r31ceJPkA9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=myCZ6cc9BU+W8/Uob7d265OKDrkq4cXOPRk3GcDFE7GcNKJYXywbgKPi7I8CA2XRN
	 JpRvkT45fMQj8DY3nnXUdQdhS6jIsOHkqjBePXKBSUNkcv2f2qfikSdlhpqII/+fdB
	 IHF5MuxcxcBZwmpQqHikfvElq2eRW7hcCdZTqnRmIXegaPe0Z7DrxIJprGrlYN3AYq
	 ViqjtC9YeQUunS9LfmLU1Hxv0M2vy0yKr+RSfvyIou9dJrkVdDRXJtL2uYfpLTcdMe
	 TZu15IUbhYRgrlpcq6ECEyHz86gMv0a4HRopswmy4OgEEJgu0UL4nuvBnpxrTIP4am
	 kYqogNNPshRCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/5] entry: Remove syscall_enter_from_user_mode_prepare()
Date: Mon,  7 Sep 2026 21:22:48 -0400
Message-ID: <20260908012250.1760990-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908012250.1760990-1-sashal@kernel.org>
References: <2026090330-squeak-freehand-d54a@gregkh>
 <20260908012250.1760990-1-sashal@kernel.org>
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
index 047983310291f..7f05293bf8ee1 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -89,23 +89,6 @@ static __always_inline long syscall_trace_enter(struct pt_regs *regs, long sysca
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
@@ -113,8 +96,8 @@ void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
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
@@ -150,8 +133,9 @@ static __always_inline long syscall_enter_from_user_mode_work(struct pt_regs *re
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
index 27a523eb85058..5bb8f47ee7859 100644
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

