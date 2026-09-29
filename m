Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0159F53A885
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694943; cv=none; b=DoHtaW3QY4dzHu24BYMkwJPzuVTzT8OzzQQEZoI4Fvak5gBKMhZg3wMQ8fazcy9dn1ApHuRv5xfd94IE73qb7zMubHpxIWmdTF0BGjCevpAxSDqU/zVHIKRS9XyTrSlTZDWZDQ35q6+j3niWDGJJJzo0kK65WpX+Kl0u3F+Rk4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694943; c=relaxed/simple;
	bh=niYOrwhyBs7fbIPMHfmipWJ1nUwu/Pelze9v2WW0KBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o6XzYPZ4RkT01YXmOVtq7gICDHR9SmG1ohVOuE8bb4gZO6fxRLKgFemF1BkpnWyLDZlM3b4V+5KG2zLdHXoF3Oi1Xl34dlYsCz4TMneEr0msXjL6y2S6NFSI1jCu83D4XgY6rCY/8h8NvX/ruUiGnlvjh2/1OgPq6V9CEZnzMn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0lD2Iye; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0lD2Iye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACB91F00893;
	Tue, 29 Sep 2026 15:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790694930;
	bh=gzLr839hGAuH5t8yg9Q4KjFI1dCykhiBPvj2QW/FgNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k0lD2IyeRCV3NihkfNX/3+DM/+Mno0FO85OWgOP4kRTyZpQQNVFjVLt+O6HcNIyDy
	 5ZpPnBtCrEPvs42h5JoaP3w466GAvBiCeB4Lco6Tu8f3rGl2rNtX/SFK741z5J6V9n
	 RJffsxKzSJmsDDJpM4ijH/qqM8DaCp96ewxd3SjRNynk0MY+etASc2CookSDChfRCu
	 AVqGZfId0jAyHsUxM7NRnf4q+hSZ7UaaCqUFlanuDRse1MmOZOlceCHne07Msnq7X8
	 ym5PAgjaBblE3dCuAdRo2lrkdrQsVAyHKbVPmgCR5tgB+RXkSiEpwGO7jdsjjvDZ3p
	 oPrXsB1jMX9Ig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] x86/mce: Fix hardware debug register corruption on task migration
Date: Tue, 29 Sep 2026 11:15:28 -0400
Message-ID: <20260929151528.3865159-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092918-powwow-spookily-ebba@gregkh>
References: <2026092918-powwow-spookily-ebba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit b8d1d5b63a8ef532038eebd9d97d406860385668 ]

In exc_machine_check_user(), local_db_save() and local_db_restore() are
invoked in the outer entry stubs (DEFINE_IDTENTRY_MCE_USER,
DEFINE_FREDENTRY_MCE, and DEFINE_IDTENTRY_RAW), surrounding
exc_machine_check_user().

However, exc_machine_check_user() calls irqentry_exit_to_user_mode(), which
handles pending thread work and may schedule() if TIF_NEED_RESCHED is set. If
the task migrates to another CPU during schedule(), local_db_restore() runs on
the new CPU with the dr7 state saved from the old CPU. This corrupts the new
CPU's DR7 hardware debug register and leaves the old CPU's DR7 disabled.  In
short, local_db_save() and local_db_restore() pair must be run on the same
CPU.

To fix this, move local_db_save() and local_db_restore() inside
exc_machine_check_user() and exc_machine_check_kernel(). In
exc_machine_check_user(), DR7 is saved and restored strictly around
do_machine_check() to avoid schedule() during migration. In
exc_machine_check_kernel(), local_db_save() is called at the entry point to
prevent early memory accesses from triggering nested #DB exceptions, and
restored on all exits.

Fixes: cd840e424f27 ("x86/entry, mce: Disallow #DB during #MC")
Assisted-by: LLM
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@kernel.org>
Link: https://patch.msgid.link/179005109564.388919.3937970081044095776.stgit@devnote2
[ Adapted direct do_machine_check() calls to 5.15’s machine_check_vector() dispatch. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/mce/core.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index e8a25b3c02722..d829da1622a70 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2017,6 +2017,9 @@ void (*machine_check_vector)(struct pt_regs *) = unexpected_machine_check;
 static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 {
 	irqentry_state_t irq_state;
+	unsigned long dr7;
+
+	dr7 = local_db_save();
 
 	WARN_ON_ONCE(user_mode(regs));
 
@@ -2026,7 +2029,7 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 	 */
 	if (machine_check_vector == do_machine_check &&
 	    mce_check_crashing_cpu())
-		return;
+		goto out;
 
 	irq_state = irqentry_nmi_enter(regs);
 	/*
@@ -2039,14 +2042,20 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 
 	instrumentation_end();
 	irqentry_nmi_exit(regs, irq_state);
+out:
+	local_db_restore(dr7);
 }
 
 static __always_inline void exc_machine_check_user(struct pt_regs *regs)
 {
+	unsigned long dr7;
+
 	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
 
+	dr7 = local_db_save();
 	machine_check_vector(regs);
+	local_db_restore(dr7);
 
 	instrumentation_end();
 	irqentry_exit_to_user_mode(regs);
@@ -2056,34 +2065,22 @@ static __always_inline void exc_machine_check_user(struct pt_regs *regs)
 /* MCE hit kernel mode */
 DEFINE_IDTENTRY_MCE(exc_machine_check)
 {
-	unsigned long dr7;
-
-	dr7 = local_db_save();
 	exc_machine_check_kernel(regs);
-	local_db_restore(dr7);
 }
 
 /* The user mode variant. */
 DEFINE_IDTENTRY_MCE_USER(exc_machine_check)
 {
-	unsigned long dr7;
-
-	dr7 = local_db_save();
 	exc_machine_check_user(regs);
-	local_db_restore(dr7);
 }
 #else
 /* 32bit unified entry point */
 DEFINE_IDTENTRY_RAW(exc_machine_check)
 {
-	unsigned long dr7;
-
-	dr7 = local_db_save();
 	if (user_mode(regs))
 		exc_machine_check_user(regs);
 	else
 		exc_machine_check_kernel(regs);
-	local_db_restore(dr7);
 }
 #endif
 
-- 
2.53.0

