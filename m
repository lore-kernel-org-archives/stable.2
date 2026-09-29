Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3243D9DB6
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 06:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664033; cv=none; b=cPyhu0QWoMYt5/7HbkivHaHUy/1z8/C7sybGuLot9yb+YSc+aCb4GSmO4201u+q3oQ38rorpDUXUAYs7LfBj7DJ/MDTqzCZFPuwCZNyjll+S1oOZPWRj2xQ8OYh1L477CJKi+aneqMMLgbXqWWvshEdarcbffvh4NFD8lR/po2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664033; c=relaxed/simple;
	bh=vduWlPfiyeVlggv1YPkoNJK7BQocVLYKkB8uZbY0cTw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DGSJRFZgx/q9Toiue0+XpXd7cI3GKYW+Cbk4ho91K6zfkjkcQPGZ/2vQE8YkZ1YJoLDA1l39Ycdpyxq/kvJSgLBpQ/DKqz6ZGcOvECJy4BXthGaAk2kE4CfQzcwour4Zk5wg27WHJZ/Q2I3kwKnpO0TR5cGJF+/3xZJOWldpHKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BLeVVg3A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BLeVVg3A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF3B1F00893;
	Tue, 29 Sep 2026 06:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790664031;
	bh=gBQNpMJf6LcWZeEjsTD9qWSuRZkFkVBa9VUxq7XJYmY=;
	h=Subject:To:Cc:From:Date;
	b=BLeVVg3AxTqU2H6xjY+1QAPGjfRV7uCMzrumGDrGE/pMsMN2OtD8oclSNTzq0wKz5
	 LdFIMthmO7qQbE0J9juGBTqCoo1IsCbhj0Tl8AHV7CP/mwi5nV7fGwWPv8XXsDob+h
	 KEGEqaGdroBNl6bTFbMgsfj7NEELdbI0Sxz+mtnU=
Subject: FAILED: patch "[PATCH] x86/mce: Fix hardware debug register corruption on task" failed to apply to 6.1-stable tree
To: mhiramat@kernel.org,bp@alien8.de,peterz@infradead.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 08:40:18 +0200
Message-ID: <2026092918-scavenger-recite-1f38@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b8d1d5b63a8ef532038eebd9d97d406860385668
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092918-scavenger-recite-1f38@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b8d1d5b63a8ef532038eebd9d97d406860385668 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Tue, 22 Sep 2026 13:24:55 +0900
Subject: [PATCH] x86/mce: Fix hardware debug register corruption on task
 migration

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

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index ab469605fc89..39f238952e14 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2108,6 +2108,9 @@ bool filter_mce(struct mce *m)
 static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 {
 	irqentry_state_t irq_state;
+	unsigned long dr7;
+
+	dr7 = local_db_save();
 
 	WARN_ON_ONCE(user_mode(regs));
 
@@ -2116,20 +2119,26 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 	 * mce_check_crashing_cpu() for details.
 	 */
 	if (mca_cfg.initialized && mce_check_crashing_cpu())
-		return;
+		goto out;
 
 	irq_state = irqentry_nmi_enter(regs);
 
 	do_machine_check(regs);
 
 	irqentry_nmi_exit(regs, irq_state);
+out:
+	local_db_restore(dr7);
 }
 
 static __always_inline void exc_machine_check_user(struct pt_regs *regs)
 {
+	unsigned long dr7;
+
 	irqentry_enter_from_user_mode(regs);
 
+	dr7 = local_db_save();
 	do_machine_check(regs);
+	local_db_restore(dr7);
 
 	irqentry_exit_to_user_mode(regs);
 }
@@ -2138,21 +2147,13 @@ static __always_inline void exc_machine_check_user(struct pt_regs *regs)
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
 
 #ifdef CONFIG_X86_FRED
@@ -2169,28 +2170,20 @@ DEFINE_IDTENTRY_MCE_USER(exc_machine_check)
  */
 DEFINE_FREDENTRY_MCE(exc_machine_check)
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
 

