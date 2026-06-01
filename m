Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C7439A07E
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309566; cv=none; b=G0lf6iEzHBSJBkxj0c/PD6MDKSkrnX8rnoHG8bb/AVaklNCftif1smyJsPO+0nv2ut0i8spmTacPepd6HCQmSvaDJUrwAUOCHfdZIshLDe55r2rC9t4aZbD0nJsjCvtgg/Zk/ZzXc2pMAzMJOSEJ6HzcGDRbwFDPuN87jRvHYlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309566; c=relaxed/simple;
	bh=w8Dv5Jl+ljnCHYp4v/+llNrwy5U48sS4Tay3S/7Dg7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZZciXWF3PsINgleP7AbRnsYlVbRfFabvi4z6anb+hgbWrLDhWSuQaSm+5tKuaSu+0dGfvd2hQi8np5RW+LeRJftCXCBj54EkRI/2sdW0Y9d/RceJmKeKjuNtwl58xRE1sl8FFJ4oufNnScPAGhXDPdz2DcU0PE5+XwHL7Q/LQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4ldA3DRA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZPHPj7rY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4ldA3DRA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZPHPj7rY"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780309561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BSMIcf8jvVo3uRuYqg1hshl7jyP02C5LhTtDLWTqZxQ=;
	b=4ldA3DRAUmXvUAEKTmbJpG9yDAZ9MPl6vC7caxwgsBFckxiBSSFLAu2pUXEHSogHEvaWFi
	iSqF02js7i3kNBf8sdO/o29QCyVUhF0FPtOFTTRmYM8N7KPt+GSJ+X1S6h5rYQD0bbiAkf
	GQJzy3zjXZ1+zubYjEOGOs692YtB9VbT2eRXnj4i3GllCTe9uedpYh9pHZXAYeTzyBvNYy
	Eah0A6Ep21oENInCRK0pfhg8/KegqMnRRoRfdelMlNuE4hlZzTobTmvheZ0wZWtz5NFL10
	pbDf2/cLwMZWsGj6Qw5ttU2RTKP3RY4VE4s82+vWPf52VPdsv+YKZk6KHMxWIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780309561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BSMIcf8jvVo3uRuYqg1hshl7jyP02C5LhTtDLWTqZxQ=;
	b=ZPHPj7rYuVxM4IgG7ZJ1FWayYSkkTjhqtQ8G89/BmJKSUOEpOM++lBnsLGJgAt4gsT1cf/
	F6s1uz/kcu0m7nCg==
To: stable@vger.kernel.org
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v6.12-stable v2 12/15] arm64: debug: split brk64 exception entry
Date: Mon,  1 Jun 2026 12:25:51 +0200
Message-ID: <20260601102554.233076-13-bigeasy@linutronix.de>
In-Reply-To: <20260601102554.233076-1-bigeasy@linutronix.de>
References: <20260601102554.233076-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Ada Couprie Diaz <ada.coupriediaz@arm.com>

Upstream commit 31575e11ecf7e44face72d1e624cb147a9283733

Currently all debug exceptions share common entry code and are routed
to `do_debug_exception()`, which calls dynamically-registered
handlers for each specific debug exception. This is unfortunate as
different debug exceptions have different entry handling requirements,
and it would be better to handle these distinct requirements earlier.

The BRK64 instruction can only be triggered by a BRK instruction. Thus,
we know that the PC is a legitimate address and isn't being used to train
a branch predictor with a bogus address : we don't need to call
`arm64_apply_bp_hardening()`.

We do not need to handle the Cortex-A76 erratum #1463225 either, as it
only relevant for single stepping at EL1.
BRK64 does not write FAR_EL1 either, as only hardware watchpoints do so.

Split the BRK64 exception entry, adjust the function signature, and its
behaviour to match the lack of needed mitigations.
Further, as the EL0 and EL1 code paths are cleanly separated, we can split
`do_brk64()` into `do_el0_brk64()` and `do_el1_brk64()`, and call them
directly from the relevant entry paths.
Use `die()` directly for the EL1 error path, as in `do_el1_bti()` and
`do_el1_undef()`.
We can also remove `NOKRPOBE_SYMBOL` for the EL0 path, as it cannot
lead to a kprobe recursion.

When taking a BRK64 exception from EL0, the exception handling is safely
preemptible : the only possible handler is `uprobe_brk_handler()`.
It only operates on task-local data and properly checks its validity,
then raises a Thread Information Flag, processed before returning
to userspace in `do_notify_resume()`, which is already preemptible.
Thus we can safely unmask interrupts and enable preemption before
handling the break itself, fixing a PREEMPT_RT issue where the handler
could call a sleeping function with preemption disabled.

Given that the break hook registration is handled statically in
`call_break_hook` since
(arm64: debug: call software break handlers statically)
and that we now bypass the exception handler registration, this change
renders `early_brk64` redundant : its functionality is now handled through
the post-init path.

This also removes the last usage of `el1_dbg()`.

This also removes the last usage of `el0_dbg()` without `CONFIG_COMPAT`.
Mark it `__maybe_unused`, to prevent a warning when building this patch
without `CONFIG_COMPAT`, as the following patch removes `el0_dbg()`.

Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Tested-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Reviewed-by: Will Deacon <will@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20250707114109.35672-12-ada.coupriediaz@arm=
.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
---
 arch/arm64/include/asm/exception.h |  2 ++
 arch/arm64/kernel/debug-monitors.c | 48 ++++++++++++++----------------
 arch/arm64/kernel/entry-common.c   | 24 ++++++++++-----
 3 files changed, 40 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/ex=
ception.h
index 594350e552e11..7bc79602840fd 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -70,6 +70,8 @@ static inline void do_watchpoint(unsigned long addr, unsi=
gned long esr,
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 void do_el0_softstep(unsigned long esr, struct pt_regs *regs);
 void do_el1_softstep(unsigned long esr, struct pt_regs *regs);
+void do_el0_brk64(unsigned long esr, struct pt_regs *regs);
+void do_el1_brk64(unsigned long esr, struct pt_regs *regs);
 void do_fpsimd_acc(unsigned long esr, struct pt_regs *regs);
 void do_sve_acc(unsigned long esr, struct pt_regs *regs);
 void do_sme_acc(unsigned long esr, struct pt_regs *regs);
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-m=
onitors.c
index 10d2bc51a32f7..45e0dbe17c82f 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -207,15 +207,8 @@ void do_el1_softstep(unsigned long esr, struct pt_regs=
 *regs)
 }
 NOKPROBE_SYMBOL(do_el1_softstep);
=20
-static int call_break_hook(struct pt_regs *regs, unsigned long esr)
+static int call_el1_break_hook(struct pt_regs *regs, unsigned long esr)
 {
-	if (user_mode(regs)) {
-		if (IS_ENABLED(CONFIG_UPROBES) &&
-			esr_brk_comment(esr) =3D=3D UPROBES_BRK_IMM)
-			return uprobe_brk_handler(regs, esr);
-		return DBG_HOOK_ERROR;
-	}
-
 	if (esr_brk_comment(esr) =3D=3D BUG_BRK_IMM)
 		return bug_brk_handler(regs, esr);
=20
@@ -252,24 +245,30 @@ static int call_break_hook(struct pt_regs *regs, unsi=
gned long esr)
=20
 	return DBG_HOOK_ERROR;
 }
-NOKPROBE_SYMBOL(call_break_hook);
+NOKPROBE_SYMBOL(call_el1_break_hook);
=20
-static int brk_handler(unsigned long unused, unsigned long esr,
-		       struct pt_regs *regs)
+/*
+ * We have already unmasked interrupts and enabled preemption
+ * when calling do_el0_brk64() from entry-common.c.
+ */
+void do_el0_brk64(unsigned long esr, struct pt_regs *regs)
 {
-	if (call_break_hook(regs, esr) =3D=3D DBG_HOOK_HANDLED)
-		return 0;
+	if (IS_ENABLED(CONFIG_UPROBES) &&
+		esr_brk_comment(esr) =3D=3D UPROBES_BRK_IMM &&
+		uprobe_brk_handler(regs, esr) =3D=3D DBG_HOOK_HANDLED)
+		return;
=20
-	if (user_mode(regs)) {
-		send_user_sigtrap(TRAP_BRKPT);
-	} else {
-		pr_warn("Unexpected kernel BRK exception at EL1\n");
-		return -EFAULT;
-	}
-
-	return 0;
+	send_user_sigtrap(TRAP_BRKPT);
 }
-NOKPROBE_SYMBOL(brk_handler);
+
+void do_el1_brk64(unsigned long esr, struct pt_regs *regs)
+{
+	if (call_el1_break_hook(regs, esr) =3D=3D DBG_HOOK_HANDLED)
+		return;
+
+	die("Oops - BRK", regs, esr);
+}
+NOKPROBE_SYMBOL(do_el1_brk64);
=20
 bool try_handle_aarch32_break(struct pt_regs *regs)
 {
@@ -311,10 +310,7 @@ bool try_handle_aarch32_break(struct pt_regs *regs)
 NOKPROBE_SYMBOL(try_handle_aarch32_break);
=20
 void __init debug_traps_init(void)
-{
-	hook_debug_fault_code(DBG_ESR_EVT_BRK, brk_handler, SIGTRAP,
-			      TRAP_BRKPT, "BRK handler");
-}
+{}
=20
 /* Re-enable single step for syscall restarting. */
 void user_rewind_single_step(struct task_struct *task)
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-com=
mon.c
index b90babcf2e2b1..ba114bfdb32b5 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -547,13 +547,12 @@ static void noinstr el1_watchpt(struct pt_regs *regs,=
 unsigned long esr)
 	arm64_exit_el1_dbg(regs);
 }
=20
-static void noinstr el1_dbg(struct pt_regs *regs, unsigned long esr)
+static void noinstr el1_brk64(struct pt_regs *regs, unsigned long esr)
 {
-	unsigned long far =3D read_sysreg(far_el1);
-
 	arm64_enter_el1_dbg(regs);
-	if (!cortex_a76_erratum_1463225_debug_handler(regs))
-		do_debug_exception(far, esr, regs);
+	debug_exception_enter(regs);
+	do_el1_brk64(esr, regs);
+	debug_exception_exit(regs);
 	arm64_exit_el1_dbg(regs);
 }
=20
@@ -599,7 +598,7 @@ asmlinkage void noinstr el1h_64_sync_handler(struct pt_=
regs *regs)
 		el1_watchpt(regs, esr);
 		break;
 	case ESR_ELx_EC_BRK64:
-		el1_dbg(regs, esr);
+		el1_brk64(regs, esr);
 		break;
 	case ESR_ELx_EC_FPAC:
 		el1_fpac(regs, esr);
@@ -827,7 +826,16 @@ static void noinstr el0_watchpt(struct pt_regs *regs, =
unsigned long esr)
 	exit_to_user_mode(regs);
 }
=20
-static void noinstr el0_dbg(struct pt_regs *regs, unsigned long esr)
+static void noinstr el0_brk64(struct pt_regs *regs, unsigned long esr)
+{
+	enter_from_user_mode(regs);
+	local_daif_restore(DAIF_PROCCTX);
+	do_el0_brk64(esr, regs);
+	exit_to_user_mode(regs);
+}
+
+static void noinstr __maybe_unused
+el0_dbg(struct pt_regs *regs, unsigned long esr)
 {
 	/* Only watchpoints write FAR_EL1, otherwise its UNKNOWN */
 	unsigned long far =3D read_sysreg(far_el1);
@@ -912,7 +920,7 @@ asmlinkage void noinstr el0t_64_sync_handler(struct pt_=
regs *regs)
 		el0_watchpt(regs, esr);
 		break;
 	case ESR_ELx_EC_BRK64:
-		el0_dbg(regs, esr);
+		el0_brk64(regs, esr);
 		break;
 	case ESR_ELx_EC_FPAC:
 		el0_fpac(regs, esr);
--=20
2.53.0

