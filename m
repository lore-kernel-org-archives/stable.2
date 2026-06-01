Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F24390606
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309565; cv=none; b=ozoPSphMD6xFhVa0ZCccKGA+/pga2VSC4C7MOwQup5EknpYNAevnaSNuxhpj2U4uBKQD8bhZD2y3dcfpM3YIZMeqn2yO6lguvWQT89m+Zc3y1MnPttSq0iXAt5K/o6hELI3aqc52l9ax/j0ssYLVuXoMXrn6lsGoGGD/oFC4mdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309565; c=relaxed/simple;
	bh=KwVHSsEbuRtoO9/N7EQKgcJfmycZLaceq2p28YpY7xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqb1azmKgqR7ICptH8Vgl3Qr/UHvqOkCY0HFiSSlJeKMuBq3tznYXMoaeOmxr8G9ssBCPWFxDyN0L/Bxvqbz+YwKiSl2YvoT2dgfyyGzxdk1ZADhf4+NgsTJndk7se+HNBhEMYtIBrQDk1dxjAzbnX7KrGhntsPTdSMWfZLd/6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GYVyfy5t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a3TvGFKI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GYVyfy5t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a3TvGFKI"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780309561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YeuWsfMPYi4mzyOvOgRg3fAtP60VcdiXH+YutGfgxtw=;
	b=GYVyfy5tgldoKtET4Kh1PIsQBOqTKCZDa9fQLXDkjUsgR4n1akg5XCt3Fs4AoM9B0MVXr7
	O8rckz/mCVhnq6v0c4Di4fySMDPso+yp6Zy2qLv4bd3QKKBNgXXqt6uxL+iOQoLh6tduAx
	+H/cVgxusC4PSkGeWaBiOCr7iCGUyV/j2igRYZh3XSDR0Eig7kjmeV9ZZMdqV2xhBa5z04
	7svHQiIiweVeIOENNbGsn46RekNZRd52DKxq47ZTFsvOrCYteTFRXyuwPeCEieuJfljNZO
	k9+nRFBDm9LUYi9iJ312j7kyYEmAHNGxB25HihQxFpF+m5Eacnt5vyqASBiw6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780309561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YeuWsfMPYi4mzyOvOgRg3fAtP60VcdiXH+YutGfgxtw=;
	b=a3TvGFKIz4Efw0MfNLCTCG+b8/k24J+4zVZkCwF+cqz0NclXv0L+6DOFgS5WoSdsgzIdhX
	5fGofep76ytUN5CQ==
To: stable@vger.kernel.org
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v6.12-stable v2 10/15] arm64: debug: split single stepping exception entry
Date: Mon,  1 Jun 2026 12:25:49 +0200
Message-ID: <20260601102554.233076-11-bigeasy@linutronix.de>
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

Upstream commit 0ac7584c08ceff13fc1e3082a0104548688d6b00

Currently all debug exceptions share common entry code and are routed
to `do_debug_exception()`, which calls dynamically-registered
handlers for each specific debug exception. This is unfortunate as
different debug exceptions have different entry handling requirements,
and it would be better to handle these distinct requirements earlier.

The single stepping exception has the most constraints : it can be
exploited to train branch predictors and it needs special handling at EL1
for the Cortex-A76 erratum #1463225. We need to conserve all those
mitigations.
However, it does not write an address at FAR_EL1, as only hardware
watchpoints do so.

The single-step handler does its own signaling if it needs to and only
returns 0, so we can call it directly from `entry-common.c`.

Split the single stepping exception entry, adjust the function signature,
keep the security mitigation and erratum handling.
Further, as the EL0 and EL1 code paths are cleanly separated, we can split
`do_softstep()` into `do_el0_softstep()` and `do_el1_softstep()` and
call them directly from the relevant entry paths.
We can also remove `NOKPROBE_SYMBOL` for the EL0 path, as it cannot
lead to a kprobe recursion.

Move the call to `arm64_apply_bp_hardening()` to `entry-common.c` so that
we can do it as early as possible, and only for the exceptions coming
from EL0, where it is needed.
This is safe to do as it is `noinstr`, as are all the functions it
may call. `el0_ia()` and `el0_pc()` already call it this way.

When taking a soft-step exception from EL0, most of the single stepping
handling is safely preemptible : the only possible handler is
`uprobe_single_step_handler()`. It only operates on task-local data and
properly checks its validity, then raises a Thread Information Flag,
processed before returning to userspace in `do_notify_resume()`, which
is already preemptible.
However, the soft-step handler first calls `reinstall_suspended_bps()`
to check if there is any hardware breakpoint or watchpoint pending
or already stepped through.
This cannot be preempted as it manipulates the hardware breakpoint and
watchpoint registers.

Move the call to `try_step_suspended_breakpoints()` to `entry-common.c`
and adjust the relevant comments.
We can now safely unmask interrupts before handling the step itself,
fixing a PREEMPT_RT issue where the handler could call a sleeping function
with preemption disabled.

Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Closes: https://lore.kernel.org/linux-arm-kernel/Z6YW_Kx4S2tmj2BP@uudg.org/
Tested-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Reviewed-by: Will Deacon <will@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20250707114109.35672-10-ada.coupriediaz@arm=
.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
---
 arch/arm64/include/asm/exception.h |  2 +
 arch/arm64/kernel/debug-monitors.c | 77 +++++++++++-------------------
 arch/arm64/kernel/entry-common.c   | 43 +++++++++++++++++
 arch/arm64/kernel/hw_breakpoint.c  |  2 +-
 4 files changed, 75 insertions(+), 49 deletions(-)

diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/ex=
ception.h
index 94f46e9651516..6d40efc28be40 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -64,6 +64,8 @@ void do_breakpoint(unsigned long esr, struct pt_regs *reg=
s);
 #else
 static inline void do_breakpoint(unsigned long esr, struct pt_regs *regs) =
{}
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
+void do_el0_softstep(unsigned long esr, struct pt_regs *regs);
+void do_el1_softstep(unsigned long esr, struct pt_regs *regs);
 void do_fpsimd_acc(unsigned long esr, struct pt_regs *regs);
 void do_sve_acc(unsigned long esr, struct pt_regs *regs);
 void do_sme_acc(unsigned long esr, struct pt_regs *regs);
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-m=
onitors.c
index b95a135ef10a9..10d2bc51a32f7 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -21,6 +21,7 @@
 #include <asm/cputype.h>
 #include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
+#include <asm/exception.h>
 #include <asm/kgdb.h>
 #include <asm/kprobes.h>
 #include <asm/system_misc.h>
@@ -159,21 +160,6 @@ NOKPROBE_SYMBOL(clear_user_regs_spsr_ss);
 #define set_regs_spsr_ss(r)	set_user_regs_spsr_ss(&(r)->user_regs)
 #define clear_regs_spsr_ss(r)	clear_user_regs_spsr_ss(&(r)->user_regs)
=20
-/*
- * Call single step handlers
- * There is no Syndrome info to check for determining the handler.
- * However, there is only one possible handler for user and kernel modes, =
so
- * check and call the appropriate one.
- */
-static int call_step_hook(struct pt_regs *regs, unsigned long esr)
-{
-	if (user_mode(regs))
-		return uprobe_single_step_handler(regs, esr);
-
-	return kgdb_single_step_handler(regs, esr);
-}
-NOKPROBE_SYMBOL(call_step_hook);
-
 static void send_user_sigtrap(int si_code)
 {
 	struct pt_regs *regs =3D current_pt_regs();
@@ -188,41 +174,38 @@ static void send_user_sigtrap(int si_code)
 			      "User debug trap");
 }
=20
-static int single_step_handler(unsigned long unused, unsigned long esr,
-			       struct pt_regs *regs)
+/*
+ * We have already unmasked interrupts and enabled preemption
+ * when calling do_el0_softstep() from entry-common.c.
+ */
+void do_el0_softstep(unsigned long esr, struct pt_regs *regs)
 {
+	if (uprobe_single_step_handler(regs, esr) =3D=3D DBG_HOOK_HANDLED)
+		return;
+
+	send_user_sigtrap(TRAP_TRACE);
 	/*
-	 * If we are stepping a pending breakpoint, call the hw_breakpoint
-	 * handler first.
+	 * ptrace will disable single step unless explicitly
+	 * asked to re-enable it. For other clients, it makes
+	 * sense to leave it enabled (i.e. rewind the controls
+	 * to the active-not-pending state).
 	 */
-	if (try_step_suspended_breakpoints(regs))
-		return 0;
-
-	if (call_step_hook(regs, esr) =3D=3D DBG_HOOK_HANDLED)
-		return 0;
-
-	if (user_mode(regs)) {
-		send_user_sigtrap(TRAP_TRACE);
-
-		/*
-		 * ptrace will disable single step unless explicitly
-		 * asked to re-enable it. For other clients, it makes
-		 * sense to leave it enabled (i.e. rewind the controls
-		 * to the active-not-pending state).
-		 */
-		user_rewind_single_step(current);
-	} else {
-		pr_warn("Unexpected kernel single-step exception at EL1\n");
-		/*
-		 * Re-enable stepping since we know that we will be
-		 * returning to regs.
-		 */
-		set_regs_spsr_ss(regs);
-	}
-
-	return 0;
+	user_rewind_single_step(current);
 }
-NOKPROBE_SYMBOL(single_step_handler);
+
+void do_el1_softstep(unsigned long esr, struct pt_regs *regs)
+{
+	if (kgdb_single_step_handler(regs, esr) =3D=3D DBG_HOOK_HANDLED)
+		return;
+
+	pr_warn("Unexpected kernel single-step exception at EL1\n");
+	/*
+	 * Re-enable stepping since we know that we will be
+	 * returning to regs.
+	 */
+	set_regs_spsr_ss(regs);
+}
+NOKPROBE_SYMBOL(do_el1_softstep);
=20
 static int call_break_hook(struct pt_regs *regs, unsigned long esr)
 {
@@ -329,8 +312,6 @@ NOKPROBE_SYMBOL(try_handle_aarch32_break);
=20
 void __init debug_traps_init(void)
 {
-	hook_debug_fault_code(DBG_ESR_EVT_HWSS, single_step_handler, SIGTRAP,
-			      TRAP_TRACE, "single-step handler");
 	hook_debug_fault_code(DBG_ESR_EVT_BRK, brk_handler, SIGTRAP,
 			      TRAP_BRKPT, "BRK handler");
 }
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-com=
mon.c
index af0d7575dcfd9..c22cc4d0052d5 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -517,6 +517,24 @@ static void noinstr el1_breakpt(struct pt_regs *regs, =
unsigned long esr)
 	arm64_exit_el1_dbg(regs);
 }
=20
+static void noinstr el1_softstp(struct pt_regs *regs, unsigned long esr)
+{
+	arm64_enter_el1_dbg(regs);
+	if (!cortex_a76_erratum_1463225_debug_handler(regs)) {
+		debug_exception_enter(regs);
+		/*
+		 * After handling a breakpoint, we suspend the breakpoint
+		 * and use single-step to move to the next instruction.
+		 * If we are stepping a suspended breakpoint there's nothing more to do:
+		 * the single-step is complete.
+		 */
+		if (!try_step_suspended_breakpoints(regs))
+			do_el1_softstep(esr, regs);
+		debug_exception_exit(regs);
+	}
+	arm64_exit_el1_dbg(regs);
+}
+
 static void noinstr el1_dbg(struct pt_regs *regs, unsigned long esr)
 {
 	unsigned long far =3D read_sysreg(far_el1);
@@ -563,6 +581,8 @@ asmlinkage void noinstr el1h_64_sync_handler(struct pt_=
regs *regs)
 		el1_breakpt(regs, esr);
 		break;
 	case ESR_ELx_EC_SOFTSTP_CUR:
+		el1_softstp(regs, esr);
+		break;
 	case ESR_ELx_EC_WATCHPT_CUR:
 	case ESR_ELx_EC_BRK64:
 		el1_dbg(regs, esr);
@@ -761,6 +781,25 @@ static void noinstr el0_breakpt(struct pt_regs *regs, =
unsigned long esr)
 	exit_to_user_mode(regs);
 }
=20
+static void noinstr el0_softstp(struct pt_regs *regs, unsigned long esr)
+{
+	if (!is_ttbr0_addr(regs->pc))
+		arm64_apply_bp_hardening();
+
+	enter_from_user_mode(regs);
+	/*
+	 * After handling a breakpoint, we suspend the breakpoint
+	 * and use single-step to move to the next instruction.
+	 * If we are stepping a suspended breakpoint there's nothing more to do:
+	 * the single-step is complete.
+	 */
+	if (!try_step_suspended_breakpoints(regs)) {
+		local_daif_restore(DAIF_PROCCTX);
+		do_el0_softstep(esr, regs);
+	}
+	exit_to_user_mode(regs);
+}
+
 static void noinstr el0_dbg(struct pt_regs *regs, unsigned long esr)
 {
 	/* Only watchpoints write FAR_EL1, otherwise its UNKNOWN */
@@ -840,6 +879,8 @@ asmlinkage void noinstr el0t_64_sync_handler(struct pt_=
regs *regs)
 		el0_breakpt(regs, esr);
 		break;
 	case ESR_ELx_EC_SOFTSTP_LOW:
+		el0_softstp(regs, esr);
+		break;
 	case ESR_ELx_EC_WATCHPT_LOW:
 	case ESR_ELx_EC_BRK64:
 		el0_dbg(regs, esr);
@@ -962,6 +1003,8 @@ asmlinkage void noinstr el0t_32_sync_handler(struct pt=
_regs *regs)
 		el0_breakpt(regs, esr);
 		break;
 	case ESR_ELx_EC_SOFTSTP_LOW:
+		el0_softstp(regs, esr);
+		break;
 	case ESR_ELx_EC_WATCHPT_LOW:
 	case ESR_ELx_EC_BKPT32:
 		el0_dbg(regs, esr);
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_break=
point.c
index 309ae24d45480..8a80e13347c88 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -854,7 +854,7 @@ bool try_step_suspended_breakpoints(struct pt_regs *reg=
s)
 	bool handled_exception =3D false;
=20
 	/*
-	 * Called from single-step exception handler.
+	 * Called from single-step exception entry.
 	 * Return true if we stepped a breakpoint and can resume execution,
 	 * false if we need to handle a single-step.
 	 */
--=20
2.53.0

