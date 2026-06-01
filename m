Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D7739A4BA
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309566; cv=none; b=FXHYJFYfar6ze+YBUXCP9QksOmNv+1120WGzEC1AvfcyL3pyd6ry+TGrR74L7Ao29OZX8JgOf0wf3NUtuuLazbNFR5zclMCqmZvXe9jyZJSN2SXePIkkFxpuey+gbEufvpuPZYUsJhaqcBbN9mVRvjnzAbwtjYc9Ajy3Ep/Ita0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309566; c=relaxed/simple;
	bh=xl/2NDb6XDtSj94bV7D6pcUmu3hS6xqReuwHukJDHWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khyxUbFULucJvMuMkPoXWsP7jU/bME97wfA21waPcHjlJ97SVlehz9xofWtJWBkM1kKVhhlM0mxPINQmYtw0H/UcJTxHD2SzdU67sAH+thuNsLXdWOzDKOU+y3gWlTCI+4N92a4c2oMiCjNfFok6fC0jswWwKlCiHrMZG1daHhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gk9l5Een; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OoB56akN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gk9l5Een";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OoB56akN"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780309561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8PfwKeLo1K3+CVdeWoQTBbeYfNSRXf9W5OTBJyknmDg=;
	b=gk9l5Een9L9I3WFzUo7apCHDeoRY4hHUYF0FgYkqxAkcmvXjmdpHcCezWNuzicq+7mZz/L
	ra9ZS/KEC9iGmx1PkMUWfDKbUgNyuFbiwTmi/7yKuQni8LZ4vrGnPQBorFuqa8tqXhh4kf
	7wdoOLnBAFDbAw6SigXoA1T8YmrMI6yxmegjELNGi+mLKyZyEoN9Un9wK7TSCCQVH5gGmC
	3izwmp3iLb81MN7mJd3Ei0gZ17CgyHRFiK18+IyDuimFcqF7FhOwKUaSEG92Z8QJbv7hdf
	FqYyRIIOIVOspaeqb0i9j9iZ0RaZzEOlBiMzJQcAbLJADEEk0gCr/jKechOW1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780309561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8PfwKeLo1K3+CVdeWoQTBbeYfNSRXf9W5OTBJyknmDg=;
	b=OoB56akNdkgNG9rhQEhnuW46zBh0M6e28cY2D8ec5sg0/z6bmSsbJdxcDrUBOQAMfy2MNi
	+y859ULI5B5r8GCA==
To: stable@vger.kernel.org
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v6.12-stable v2 11/15] arm64: debug: split hardware watchpoint exception entry
Date: Mon,  1 Jun 2026 12:25:50 +0200
Message-ID: <20260601102554.233076-12-bigeasy@linutronix.de>
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

Upstream commit 413f0bba005dacf2484bb8ecce212fab9be79d81

Currently all debug exceptions share common entry code and are routed
to `do_debug_exception()`, which calls dynamically-registered
handlers for each specific debug exception. This is unfortunate as
different debug exceptions have different entry handling requirements,
and it would be better to handle these distinct requirements earlier.

Hardware watchpoints are the only debug exceptions that will write
FAR_EL1, so we need to preserve it and pass it down.
However, they cannot be used to maliciously train branch predictors, so
we can omit calling `arm64_bp_hardening()`, nor do they need to handle
the Cortex-A76 erratum #1463225, as it only applies to single stepping
exceptions.

As the hardware watchpoint handler only returns 0 and never triggers
the call to `arm64_notify_die()`, we can call it directly from
`entry-common.c`.
Split the hardware watchpoint exception entry and adjust the behaviour
to match the lack of needed mitigations.

Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Tested-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Reviewed-by: Will Deacon <will@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20250707114109.35672-11-ada.coupriediaz@arm=
.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
---
 arch/arm64/include/asm/exception.h |  4 ++++
 arch/arm64/kernel/entry-common.c   | 31 ++++++++++++++++++++++++++++++
 arch/arm64/kernel/hw_breakpoint.c  | 17 +++++-----------
 3 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/ex=
ception.h
index 6d40efc28be40..594350e552e11 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -61,8 +61,12 @@ void do_debug_exception(unsigned long addr_if_watchpoint=
, unsigned long esr,
 			struct pt_regs *regs);
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 void do_breakpoint(unsigned long esr, struct pt_regs *regs);
+void do_watchpoint(unsigned long addr, unsigned long esr,
+			struct pt_regs *regs);
 #else
 static inline void do_breakpoint(unsigned long esr, struct pt_regs *regs) =
{}
+static inline void do_watchpoint(unsigned long addr, unsigned long esr,
+			struct pt_regs *regs) {}
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 void do_el0_softstep(unsigned long esr, struct pt_regs *regs);
 void do_el1_softstep(unsigned long esr, struct pt_regs *regs);
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-com=
mon.c
index c22cc4d0052d5..b90babcf2e2b1 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -535,6 +535,18 @@ static void noinstr el1_softstp(struct pt_regs *regs, =
unsigned long esr)
 	arm64_exit_el1_dbg(regs);
 }
=20
+static void noinstr el1_watchpt(struct pt_regs *regs, unsigned long esr)
+{
+	/* Watchpoints are the only debug exception to write FAR_EL1 */
+	unsigned long far =3D read_sysreg(far_el1);
+
+	arm64_enter_el1_dbg(regs);
+	debug_exception_enter(regs);
+	do_watchpoint(far, esr, regs);
+	debug_exception_exit(regs);
+	arm64_exit_el1_dbg(regs);
+}
+
 static void noinstr el1_dbg(struct pt_regs *regs, unsigned long esr)
 {
 	unsigned long far =3D read_sysreg(far_el1);
@@ -584,6 +596,8 @@ asmlinkage void noinstr el1h_64_sync_handler(struct pt_=
regs *regs)
 		el1_softstp(regs, esr);
 		break;
 	case ESR_ELx_EC_WATCHPT_CUR:
+		el1_watchpt(regs, esr);
+		break;
 	case ESR_ELx_EC_BRK64:
 		el1_dbg(regs, esr);
 		break;
@@ -800,6 +814,19 @@ static void noinstr el0_softstp(struct pt_regs *regs, =
unsigned long esr)
 	exit_to_user_mode(regs);
 }
=20
+static void noinstr el0_watchpt(struct pt_regs *regs, unsigned long esr)
+{
+	/* Watchpoints are the only debug exception to write FAR_EL1 */
+	unsigned long far =3D read_sysreg(far_el1);
+
+	enter_from_user_mode(regs);
+	debug_exception_enter(regs);
+	do_watchpoint(far, esr, regs);
+	debug_exception_exit(regs);
+	local_daif_restore(DAIF_PROCCTX);
+	exit_to_user_mode(regs);
+}
+
 static void noinstr el0_dbg(struct pt_regs *regs, unsigned long esr)
 {
 	/* Only watchpoints write FAR_EL1, otherwise its UNKNOWN */
@@ -882,6 +909,8 @@ asmlinkage void noinstr el0t_64_sync_handler(struct pt_=
regs *regs)
 		el0_softstp(regs, esr);
 		break;
 	case ESR_ELx_EC_WATCHPT_LOW:
+		el0_watchpt(regs, esr);
+		break;
 	case ESR_ELx_EC_BRK64:
 		el0_dbg(regs, esr);
 		break;
@@ -1006,6 +1035,8 @@ asmlinkage void noinstr el0t_32_sync_handler(struct p=
t_regs *regs)
 		el0_softstp(regs, esr);
 		break;
 	case ESR_ELx_EC_WATCHPT_LOW:
+		el0_watchpt(regs, esr);
+		break;
 	case ESR_ELx_EC_BKPT32:
 		el0_dbg(regs, esr);
 		break;
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_break=
point.c
index 8a80e13347c88..ab76b36dce820 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -750,8 +750,7 @@ static int watchpoint_report(struct perf_event *wp, uns=
igned long addr,
 	return step;
 }
=20
-static int watchpoint_handler(unsigned long addr, unsigned long esr,
-			      struct pt_regs *regs)
+void do_watchpoint(unsigned long addr, unsigned long esr, struct pt_regs *=
regs)
 {
 	int i, step =3D 0, *kernel_step, access, closest_match =3D 0;
 	u64 min_dist =3D -1, dist;
@@ -806,7 +805,7 @@ static int watchpoint_handler(unsigned long addr, unsig=
ned long esr,
 	rcu_read_unlock();
=20
 	if (!step)
-		return 0;
+		return;
=20
 	/*
 	 * We always disable EL0 watchpoints because the kernel can
@@ -819,7 +818,7 @@ static int watchpoint_handler(unsigned long addr, unsig=
ned long esr,
=20
 		/* If we're already stepping a breakpoint, just return. */
 		if (debug_info->bps_disabled)
-			return 0;
+			return;
=20
 		if (test_thread_flag(TIF_SINGLESTEP))
 			debug_info->suspended_step =3D 1;
@@ -830,7 +829,7 @@ static int watchpoint_handler(unsigned long addr, unsig=
ned long esr,
 		kernel_step =3D this_cpu_ptr(&stepping_kernel_bp);
=20
 		if (*kernel_step !=3D ARM_KERNEL_STEP_NONE)
-			return 0;
+			return;
=20
 		if (kernel_active_single_step()) {
 			*kernel_step =3D ARM_KERNEL_STEP_SUSPEND;
@@ -839,10 +838,8 @@ static int watchpoint_handler(unsigned long addr, unsi=
gned long esr,
 			kernel_enable_single_step(regs);
 		}
 	}
-
-	return 0;
 }
-NOKPROBE_SYMBOL(watchpoint_handler);
+NOKPROBE_SYMBOL(do_watchpoint);
=20
 /*
  * Handle single-step exception.
@@ -984,10 +981,6 @@ static int __init arch_hw_breakpoint_init(void)
 	pr_info("found %d breakpoint and %d watchpoint registers.\n",
 		core_num_brps, core_num_wrps);
=20
-	/* Register debug fault handlers. */
-	hook_debug_fault_code(DBG_ESR_EVT_HWWP, watchpoint_handler, SIGTRAP,
-			      TRAP_HWBKPT, "hw-watchpoint handler");
-
 	/*
 	 * Reset the breakpoint resources. We assume that a halting
 	 * debugger will leave the world in a nice state for us.
--=20
2.53.0

