Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACEE390CB9
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309567; cv=none; b=t5iNFb5WDjSS5yogxNU7wPJ8At5/6ZKDMOAYjkRynH4iLxG57ZwzDkYw5xIbi5YpF9JG+PhwMe0cidDJkEUcjcGWHcYQGw3m+mZFGYa0iF7svjmuuTnOD6/c/52Dh12/SO4zD1XeKJMqoV/QtZoMI5XLtrK6at3Db2aFcKmydyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309567; c=relaxed/simple;
	bh=cxfGfIPwTPz99dnZqc2Wz7HbuxHjgqmUM3JWwfXWvgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nL3hGFPkU6k9w4ZQZB5D/mI9sLyadt6TJuEqFj5/1AzjQECo8RhYR9iakfRtQZJbJNqvuKGxgves8vc8nHsB+eZfircgs1B6Ua9mELZlm5tKxsIehfd2Az4acyYTtteqcuO4PZkCDtClCAvlT2ckImKMJCc7FyaadgB4qgLCXtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mGKKTTSq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SM2Y8LFL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mGKKTTSq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SM2Y8LFL"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780309562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29QdKgEjRtb1sCRyp/Y8n1K9aCYRCTe0B8jTvxroClo=;
	b=mGKKTTSq75YoV2/xyVTx82s0Vm9sXgKXXve4erWXZs5fP99N1IrFoBkFARbPkq+e8o410f
	6eGvjGMfE8quxSOfwRUPevGDh9i0FezynlzjFUnU97YZAItIYUvEJ75C0VCPA9RkSMGR/+
	u/gxHY1EG4KNvHW4hsm/EW6TCehQioz9wLn5hEig5VgBOTdeHFyPdtdLdeG4dFRa9fbJlJ
	HfXSbQfm+epstrtwVTByKJ0Dfb6GGanJd/WiLxSccb5FcQzf6T95oMw6BwE2lF9URb2ZGC
	8km48mpDtowLAP4svYnjIltNkLW1CyvfuG5uN1F6K5O8JyWfRI8pcOP3ycVwjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780309562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29QdKgEjRtb1sCRyp/Y8n1K9aCYRCTe0B8jTvxroClo=;
	b=SM2Y8LFLkmXyHvnf79NIIx4ZXb28c9eD8CFzUDaTBZyHtoKPsRntTqVAwZofEB4UW7xIKm
	/b2Vsy7et6obeeDw==
To: stable@vger.kernel.org
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v6.12-stable v2 14/15] arm64: debug: remove debug exception registration infrastructure
Date: Mon,  1 Jun 2026 12:25:53 +0200
Message-ID: <20260601102554.233076-15-bigeasy@linutronix.de>
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

Upstream commit a8b8cce9d96d65dfe3d89abf02033151f8b7d670

Now that debug exceptions are handled individually and without the need
for dynamic registration, remove the unused registration infrastructure.

This removes the external caller for `debug_exception_enter()` and
`debug_exception_exit()`.
Make them static again and remove them from the header.

Remove `early_brk64()` as it has been made redundant by
(arm64: debug: split brk64 exception entry) and is not used anymore.
Note : in `early_brk64()` `bug_brk_handler()` is called unconditionally
as a fall-through, but now `call_break_hook()` only calls it if the
immediate matches.
This does not change the behaviour in early boot, as if
`bug_brk_handler()` was called on a non-BUG immediate it would return
DBG_HOOK_ERROR anyway, which `call_break_hook()` will do if no immediate
matches.

Remove `trap_init()`, as it would be empty and a weak definition already
exists in `init/main.c`.

Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Tested-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Reviewed-by: Will Deacon <will@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20250707114109.35672-14-ada.coupriediaz@arm=
.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
---
 arch/arm64/include/asm/debug-monitors.h |  2 -
 arch/arm64/include/asm/exception.h      |  6 ---
 arch/arm64/include/asm/system_misc.h    |  4 --
 arch/arm64/kernel/debug-monitors.c      |  3 --
 arch/arm64/kernel/entry-common.c        |  4 +-
 arch/arm64/kernel/traps.c               | 27 -------------
 arch/arm64/mm/fault.c                   | 53 -------------------------
 7 files changed, 2 insertions(+), 97 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/a=
sm/debug-monitors.h
index 24c7981abeb0b..4f3901884c5d8 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -93,7 +93,5 @@ static inline bool try_step_suspended_breakpoints(struct =
pt_regs *regs)
=20
 bool try_handle_aarch32_break(struct pt_regs *regs);
=20
-void debug_traps_init(void);
-
 #endif	/* __ASSEMBLY */
 #endif	/* __ASM_DEBUG_MONITORS_H */
diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/ex=
ception.h
index 9b05c6f487ccf..50c5329ff2eda 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -57,8 +57,6 @@ void do_el0_undef(struct pt_regs *regs, unsigned long esr=
);
 void do_el1_undef(struct pt_regs *regs, unsigned long esr);
 void do_el0_bti(struct pt_regs *regs);
 void do_el1_bti(struct pt_regs *regs, unsigned long esr);
-void do_debug_exception(unsigned long addr_if_watchpoint, unsigned long es=
r,
-			struct pt_regs *regs);
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 void do_breakpoint(unsigned long esr, struct pt_regs *regs);
 void do_watchpoint(unsigned long addr, unsigned long esr,
@@ -91,8 +89,4 @@ void do_serror(struct pt_regs *regs, unsigned long esr);
 void do_signal(struct pt_regs *regs);
=20
 void __noreturn panic_bad_stack(struct pt_regs *regs, unsigned long esr, u=
nsigned long far);
-
-void debug_exception_enter(struct pt_regs *regs);
-void debug_exception_exit(struct pt_regs *regs);
-
 #endif	/* __ASM_EXCEPTION_H */
diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/=
system_misc.h
index c343442567625..344b1c1a4bbb6 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -25,10 +25,6 @@ void arm64_notify_die(const char *str, struct pt_regs *r=
egs,
 		      int signo, int sicode, unsigned long far,
 		      unsigned long err);
=20
-void hook_debug_fault_code(int nr, int (*fn)(unsigned long, unsigned long,
-					     struct pt_regs *),
-			   int sig, int code, const char *name);
-
 struct mm_struct;
 extern void __show_regs(struct pt_regs *);
=20
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-m=
onitors.c
index ed03270fa3437..16390fd4ba5ed 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -316,9 +316,6 @@ bool try_handle_aarch32_break(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(try_handle_aarch32_break);
=20
-void __init debug_traps_init(void)
-{}
-
 /* Re-enable single step for syscall restarting. */
 void user_rewind_single_step(struct task_struct *task)
 {
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-com=
mon.c
index 9a1ea5a6e6b72..b98d6d1a1dfd6 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -448,7 +448,7 @@ static __always_inline void fpsimd_syscall_exit(void)
  * accidentally schedule in exception context and it will force a warning
  * if we somehow manage to schedule by accident.
  */
-void debug_exception_enter(struct pt_regs *regs)
+static void debug_exception_enter(struct pt_regs *regs)
 {
 	preempt_disable();
=20
@@ -457,7 +457,7 @@ void debug_exception_enter(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(debug_exception_enter);
=20
-void debug_exception_exit(struct pt_regs *regs)
+static void debug_exception_exit(struct pt_regs *regs)
 {
 	preempt_enable_no_resched();
 }
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 013159bc0882e..e6e815ef03c77 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -1091,30 +1091,3 @@ int ubsan_brk_handler(struct pt_regs *regs, unsigned=
 long esr)
 	return DBG_HOOK_HANDLED;
 }
 #endif
-
-/*
- * Initial handler for AArch64 BRK exceptions
- * This handler only used until debug_traps_init().
- */
-int __init early_brk64(unsigned long addr, unsigned long esr,
-		struct pt_regs *regs)
-{
-#ifdef CONFIG_CFI_CLANG
-	if (esr_is_cfi_brk(esr))
-		return cfi_brk_handler(regs, esr) !=3D DBG_HOOK_HANDLED;
-#endif
-#ifdef CONFIG_KASAN_SW_TAGS
-	if ((esr_brk_comment(esr) & ~KASAN_BRK_MASK) =3D=3D KASAN_BRK_IMM)
-		return kasan_brk_handler(regs, esr) !=3D DBG_HOOK_HANDLED;
-#endif
-#ifdef CONFIG_UBSAN_TRAP
-	if (esr_is_ubsan_brk(esr))
-		return ubsan_brk_handler(regs, esr) !=3D DBG_HOOK_HANDLED;
-#endif
-	return bug_brk_handler(regs, esr) !=3D DBG_HOOK_HANDLED;
-}
-
-void __init trap_init(void)
-{
-	debug_traps_init();
-}
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 7c87d2b3b06ea..9ee5a2d2b3215 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -53,18 +53,12 @@ struct fault_info {
 };
=20
 static const struct fault_info fault_info[];
-static struct fault_info debug_fault_info[];
=20
 static inline const struct fault_info *esr_to_fault_info(unsigned long esr)
 {
 	return fault_info + (esr & ESR_ELx_FSC);
 }
=20
-static inline const struct fault_info *esr_to_debug_fault_info(unsigned lo=
ng esr)
-{
-	return debug_fault_info + DBG_ESR_EVT(esr);
-}
-
 static void data_abort_decode(unsigned long esr)
 {
 	unsigned long iss2 =3D ESR_ELx_ISS2(esr);
@@ -911,53 +905,6 @@ void do_sp_pc_abort(unsigned long addr, unsigned long =
esr, struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(do_sp_pc_abort);
=20
-/*
- * __refdata because early_brk64 is __init, but the reference to it is
- * clobbered at arch_initcall time.
- * See traps.c and debug-monitors.c:debug_traps_init().
- */
-static struct fault_info __refdata debug_fault_info[] =3D {
-	{ do_bad,	SIGTRAP,	TRAP_HWBKPT,	"hardware breakpoint"	},
-	{ do_bad,	SIGTRAP,	TRAP_HWBKPT,	"hardware single-step"	},
-	{ do_bad,	SIGTRAP,	TRAP_HWBKPT,	"hardware watchpoint"	},
-	{ do_bad,	SIGKILL,	SI_KERNEL,	"unknown 3"		},
-	{ do_bad,	SIGTRAP,	TRAP_BRKPT,	"aarch32 BKPT"		},
-	{ do_bad,	SIGKILL,	SI_KERNEL,	"aarch32 vector catch"	},
-	{ early_brk64,	SIGTRAP,	TRAP_BRKPT,	"aarch64 BRK"		},
-	{ do_bad,	SIGKILL,	SI_KERNEL,	"unknown 7"		},
-};
-
-void __init hook_debug_fault_code(int nr,
-				  int (*fn)(unsigned long, unsigned long, struct pt_regs *),
-				  int sig, int code, const char *name)
-{
-	BUG_ON(nr < 0 || nr >=3D ARRAY_SIZE(debug_fault_info));
-
-	debug_fault_info[nr].fn		=3D fn;
-	debug_fault_info[nr].sig	=3D sig;
-	debug_fault_info[nr].code	=3D code;
-	debug_fault_info[nr].name	=3D name;
-}
-
-void do_debug_exception(unsigned long addr_if_watchpoint, unsigned long es=
r,
-			struct pt_regs *regs)
-{
-	const struct fault_info *inf =3D esr_to_debug_fault_info(esr);
-	unsigned long pc =3D instruction_pointer(regs);
-
-	debug_exception_enter(regs);
-
-	if (user_mode(regs) && !is_ttbr0_addr(pc))
-		arm64_apply_bp_hardening();
-
-	if (inf->fn(addr_if_watchpoint, esr, regs)) {
-		arm64_notify_die(inf->name, regs, inf->sig, inf->code, pc, esr);
-	}
-
-	debug_exception_exit(regs);
-}
-NOKPROBE_SYMBOL(do_debug_exception);
-
 /*
  * Used during anonymous page fault handling.
  */
--=20
2.53.0

