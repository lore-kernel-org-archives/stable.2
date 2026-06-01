Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711D5390606
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309563; cv=none; b=J7+h3obn9vdkNHVR2Qai3oM1ny2XyhA0GLEci9AwYD6EivD5yzwir6OENPEAQKkmR1YxRMQ+u/yputrArcZjongzRS6OEHEy4wzgUergStC9gQqJ55UAwNaD0Yt6GSDXdCeeKO0tz6ndJ05b94sN1XP2BarkPiO/Je5AfyrTIvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309563; c=relaxed/simple;
	bh=bhR3DAlzSxuy+gEBClzTveQvxAC9qaLV9VF2c7vmHJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ww1b7DgdpjqiVgDEspF66xh7zi2Ui+1HmUrqnH28UoAVdd304+FDtU1RprLi/UKtSkGBQge/WqQYfnOuqF1e+u49B8P3h3rrw7vc4KiS50B8PYFXSWHd9Scm7ssBWTfaLgZHr+6env8eVa6ykrjYBlhkftPPLE4dWDNzLzmBTvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jXLAUWlm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aRPkwuwc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jXLAUWlm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aRPkwuwc"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780309560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6mmU0pU0KssKdhqVHnq8n+QRl+/KNUxN2J+Bu0TAWZg=;
	b=jXLAUWlm3u8/4OqRZ4NcqMepb/5SynzaKanDbMfZ5Y0hB6/tjeKy7H8rdU4wlMqQsrHtI7
	epbco6uPNUWuizQ0NLI/lldTb6qM+mhasm0hqEtWJL1t2n0yflxPGZpbmoEQMhm7T5cO0I
	VfqyLKotkE96xjuL9CSz6cnPQeGLhvfcIacKzSYIZ/Br7uLGViwqpqPsRYOuoVZdNN6+qO
	L3glcgWBjfA0hKhSKpk6fbAQrcC1zmCUImOt6t45+HTLG6EF2B1P/HGsvsjfGo90dgJtpt
	KlW8Xnt5ngRmD5+y1FTbHpDxZSNJ/5HzYqkpcYIWS7IeLn0wqwUBN63c6H116w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780309560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6mmU0pU0KssKdhqVHnq8n+QRl+/KNUxN2J+Bu0TAWZg=;
	b=aRPkwuwc6vWvF5OJl4zhXyfZaf2Ib+MeQHpwhFZaAGytY6Xf4VpPQZdynI3MBalPJng/wj
	0DkwJZoS9NzSPQCA==
To: stable@vger.kernel.org
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v6.12-stable v2 04/15] arm64: debug: call software breakpoint handlers statically
Date: Mon,  1 Jun 2026 12:25:43 +0200
Message-ID: <20260601102554.233076-5-bigeasy@linutronix.de>
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

Upstream commit 6adfdc5e2ef9c71a76d8d127a2eb54f0fbe9be5e

Software breakpoints pass an immediate value in ESR ("comment") that can
be used to call a specialized handler (KGDB, KASAN...).
We do so in two different ways :
 - During early boot, `early_brk64` statically checks against known
   immediates and calls the corresponding handler,
 - During init, handlers are dynamically registered into a list. When
   called, the generic software breakpoint handler will iterate over
   the list to find the appropriate handler.

The dynamic registration does not provide any benefit here as it is not
exported and all its uses are within the arm64 tree. It also depends on an
RCU list, whose safe access currently relies on the non-preemptible state
of `do_debug_exception`.

Replace the list iteration logic in `call_break_hooks` to call
the breakpoint handlers statically if they are enabled, like in
`early_brk64`.
Expose the handlers in their respective headers to be reachable from
`arch/arm64/kernel/debug-monitors.c` at link time.

Unify the naming of the software breakpoint handlers to XXX_brk_handler(),
making it clear they are related and to differentiate from the
hardware breakpoints.

Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Tested-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Reviewed-by: Will Deacon <will@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20250707114109.35672-4-ada.coupriediaz@arm.=
com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
---
 arch/arm64/include/asm/kgdb.h                 |  3 +
 arch/arm64/include/asm/kprobes.h              |  8 +++
 arch/arm64/include/asm/traps.h                |  6 ++
 arch/arm64/include/asm/uprobes.h              |  2 +
 arch/arm64/kernel/debug-monitors.c            | 57 +++++++++++++-----
 arch/arm64/kernel/kgdb.c                      | 22 ++-----
 arch/arm64/kernel/probes/kprobes.c            | 31 ++--------
 arch/arm64/kernel/probes/kprobes_trampoline.S |  2 +-
 arch/arm64/kernel/probes/uprobes.c            |  9 +--
 arch/arm64/kernel/traps.c                     | 59 ++++---------------
 10 files changed, 84 insertions(+), 115 deletions(-)

diff --git a/arch/arm64/include/asm/kgdb.h b/arch/arm64/include/asm/kgdb.h
index 21fc85e9d2bed..82a76b2102fb6 100644
--- a/arch/arm64/include/asm/kgdb.h
+++ b/arch/arm64/include/asm/kgdb.h
@@ -24,6 +24,9 @@ static inline void arch_kgdb_breakpoint(void)
 extern void kgdb_handle_bus_error(void);
 extern int kgdb_fault_expected;
=20
+int kgdb_brk_handler(struct pt_regs *regs, unsigned long esr);
+int kgdb_compiled_brk_handler(struct pt_regs *regs, unsigned long esr);
+
 #endif /* !__ASSEMBLY__ */
=20
 /*
diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kpro=
bes.h
index be7a3680dadff..f2782560647be 100644
--- a/arch/arm64/include/asm/kprobes.h
+++ b/arch/arm64/include/asm/kprobes.h
@@ -41,4 +41,12 @@ void __kretprobe_trampoline(void);
 void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
=20
 #endif /* CONFIG_KPROBES */
+
+int __kprobes kprobe_brk_handler(struct pt_regs *regs,
+				 unsigned long esr);
+int __kprobes kprobe_ss_brk_handler(struct pt_regs *regs,
+				 unsigned long esr);
+int __kprobes kretprobe_brk_handler(struct pt_regs *regs,
+				 unsigned long esr);
+
 #endif /* _ARM_KPROBES_H */
diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index 82cf1f879c61d..e3e8944a71c3e 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -29,6 +29,12 @@ void arm64_force_sig_fault_pkey(unsigned long far, const=
 char *str, int pkey);
 void arm64_force_sig_mceerr(int code, unsigned long far, short lsb, const =
char *str);
 void arm64_force_sig_ptrace_errno_trap(int errno, unsigned long far, const=
 char *str);
=20
+int bug_brk_handler(struct pt_regs *regs, unsigned long esr);
+int cfi_brk_handler(struct pt_regs *regs, unsigned long esr);
+int reserved_fault_brk_handler(struct pt_regs *regs, unsigned long esr);
+int kasan_brk_handler(struct pt_regs *regs, unsigned long esr);
+int ubsan_brk_handler(struct pt_regs *regs, unsigned long esr);
+
 int early_brk64(unsigned long addr, unsigned long esr, struct pt_regs *reg=
s);
=20
 /*
diff --git a/arch/arm64/include/asm/uprobes.h b/arch/arm64/include/asm/upro=
bes.h
index 014b02897f8e2..3659a79a9f325 100644
--- a/arch/arm64/include/asm/uprobes.h
+++ b/arch/arm64/include/asm/uprobes.h
@@ -28,4 +28,6 @@ struct arch_uprobe {
 	bool simulate;
 };
=20
+int uprobe_brk_handler(struct pt_regs *regs, unsigned long esr);
+
 #endif
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-m=
onitors.c
index 8275b7f575462..5e89244803000 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -21,8 +21,11 @@
 #include <asm/cputype.h>
 #include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
+#include <asm/kgdb.h>
+#include <asm/kprobes.h>
 #include <asm/system_misc.h>
 #include <asm/traps.h>
+#include <asm/uprobes.h>
=20
 /* Determine debug architecture. */
 u8 debug_monitors_arch(void)
@@ -299,22 +302,48 @@ void unregister_kernel_break_hook(struct break_hook *=
hook)
=20
 static int call_break_hook(struct pt_regs *regs, unsigned long esr)
 {
-	struct break_hook *hook;
-	struct list_head *list;
-	int (*fn)(struct pt_regs *regs, unsigned long esr) =3D NULL;
-
-	list =3D user_mode(regs) ? &user_break_hook : &kernel_break_hook;
-
-	/*
-	 * Since brk exception disables interrupt, this function is
-	 * entirely not preemptible, and we can use rcu list safely here.
-	 */
-	list_for_each_entry_rcu(hook, list, node) {
-		if ((esr_brk_comment(esr) & ~hook->mask) =3D=3D hook->imm)
-			fn =3D hook->fn;
+	if (user_mode(regs)) {
+		if (IS_ENABLED(CONFIG_UPROBES) &&
+			esr_brk_comment(esr) =3D=3D UPROBES_BRK_IMM)
+			return uprobe_brk_handler(regs, esr);
+		return DBG_HOOK_ERROR;
 	}
=20
-	return fn ? fn(regs, esr) : DBG_HOOK_ERROR;
+	if (esr_brk_comment(esr) =3D=3D BUG_BRK_IMM)
+		return bug_brk_handler(regs, esr);
+
+	if (IS_ENABLED(CONFIG_CFI_CLANG) && esr_is_cfi_brk(esr))
+		return cfi_brk_handler(regs, esr);
+
+	if (esr_brk_comment(esr) =3D=3D FAULT_BRK_IMM)
+		return reserved_fault_brk_handler(regs, esr);
+
+	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) &&
+		(esr_brk_comment(esr) & ~KASAN_BRK_MASK) =3D=3D KASAN_BRK_IMM)
+		return kasan_brk_handler(regs, esr);
+
+	if (IS_ENABLED(CONFIG_UBSAN_TRAP) && esr_is_ubsan_brk(esr))
+		return ubsan_brk_handler(regs, esr);
+
+	if (IS_ENABLED(CONFIG_KGDB)) {
+		if (esr_brk_comment(esr) =3D=3D KGDB_DYN_DBG_BRK_IMM)
+			return kgdb_brk_handler(regs, esr);
+		if (esr_brk_comment(esr) =3D=3D KGDB_COMPILED_DBG_BRK_IMM)
+			return kgdb_compiled_brk_handler(regs, esr);
+	}
+
+	if (IS_ENABLED(CONFIG_KPROBES)) {
+		if (esr_brk_comment(esr) =3D=3D KPROBES_BRK_IMM)
+			return kprobe_brk_handler(regs, esr);
+		if (esr_brk_comment(esr) =3D=3D KPROBES_BRK_SS_IMM)
+			return kprobe_ss_brk_handler(regs, esr);
+	}
+
+	if (IS_ENABLED(CONFIG_KRETPROBES) &&
+		esr_brk_comment(esr) =3D=3D KRETPROBES_BRK_IMM)
+		return kretprobe_brk_handler(regs, esr);
+
+	return DBG_HOOK_ERROR;
 }
 NOKPROBE_SYMBOL(call_break_hook);
=20
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 4e1f983df3d1c..e3c9e6e11a318 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -234,21 +234,21 @@ int kgdb_arch_handle_exception(int exception_vector, =
int signo,
 	return err;
 }
=20
-static int kgdb_brk_fn(struct pt_regs *regs, unsigned long esr)
+int kgdb_brk_handler(struct pt_regs *regs, unsigned long esr)
 {
 	kgdb_handle_exception(1, SIGTRAP, 0, regs);
 	return DBG_HOOK_HANDLED;
 }
-NOKPROBE_SYMBOL(kgdb_brk_fn)
+NOKPROBE_SYMBOL(kgdb_brk_handler)
=20
-static int kgdb_compiled_brk_fn(struct pt_regs *regs, unsigned long esr)
+int kgdb_compiled_brk_handler(struct pt_regs *regs, unsigned long esr)
 {
 	compiled_break =3D 1;
 	kgdb_handle_exception(1, SIGTRAP, 0, regs);
=20
 	return DBG_HOOK_HANDLED;
 }
-NOKPROBE_SYMBOL(kgdb_compiled_brk_fn);
+NOKPROBE_SYMBOL(kgdb_compiled_brk_handler);
=20
 static int kgdb_step_brk_fn(struct pt_regs *regs, unsigned long esr)
 {
@@ -260,16 +260,6 @@ static int kgdb_step_brk_fn(struct pt_regs *regs, unsi=
gned long esr)
 }
 NOKPROBE_SYMBOL(kgdb_step_brk_fn);
=20
-static struct break_hook kgdb_brkpt_hook =3D {
-	.fn		=3D kgdb_brk_fn,
-	.imm		=3D KGDB_DYN_DBG_BRK_IMM,
-};
-
-static struct break_hook kgdb_compiled_brkpt_hook =3D {
-	.fn		=3D kgdb_compiled_brk_fn,
-	.imm		=3D KGDB_COMPILED_DBG_BRK_IMM,
-};
-
 static struct step_hook kgdb_step_hook =3D {
 	.fn		=3D kgdb_step_brk_fn
 };
@@ -316,8 +306,6 @@ int kgdb_arch_init(void)
 	if (ret !=3D 0)
 		return ret;
=20
-	register_kernel_break_hook(&kgdb_brkpt_hook);
-	register_kernel_break_hook(&kgdb_compiled_brkpt_hook);
 	register_kernel_step_hook(&kgdb_step_hook);
 	return 0;
 }
@@ -329,8 +317,6 @@ int kgdb_arch_init(void)
  */
 void kgdb_arch_exit(void)
 {
-	unregister_kernel_break_hook(&kgdb_brkpt_hook);
-	unregister_kernel_break_hook(&kgdb_compiled_brkpt_hook);
 	unregister_kernel_step_hook(&kgdb_step_hook);
 	unregister_die_notifier(&kgdb_notifier);
 }
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/=
kprobes.c
index b0e0f0aed748a..8661cd4064732 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -306,8 +306,8 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs=
, unsigned int fsr)
 	return 0;
 }
=20
-static int __kprobes
-kprobe_breakpoint_handler(struct pt_regs *regs, unsigned long esr)
+int __kprobes
+kprobe_brk_handler(struct pt_regs *regs, unsigned long esr)
 {
 	struct kprobe *p, *cur_kprobe;
 	struct kprobe_ctlblk *kcb;
@@ -350,13 +350,8 @@ kprobe_breakpoint_handler(struct pt_regs *regs, unsign=
ed long esr)
 	return DBG_HOOK_HANDLED;
 }
=20
-static struct break_hook kprobes_break_hook =3D {
-	.imm =3D KPROBES_BRK_IMM,
-	.fn =3D kprobe_breakpoint_handler,
-};
-
-static int __kprobes
-kprobe_breakpoint_ss_handler(struct pt_regs *regs, unsigned long esr)
+int __kprobes
+kprobe_ss_brk_handler(struct pt_regs *regs, unsigned long esr)
 {
 	struct kprobe_ctlblk *kcb =3D get_kprobe_ctlblk();
 	unsigned long addr =3D instruction_pointer(regs);
@@ -374,13 +369,8 @@ kprobe_breakpoint_ss_handler(struct pt_regs *regs, uns=
igned long esr)
 	return DBG_HOOK_ERROR;
 }
=20
-static struct break_hook kprobes_break_ss_hook =3D {
-	.imm =3D KPROBES_BRK_SS_IMM,
-	.fn =3D kprobe_breakpoint_ss_handler,
-};
-
-static int __kprobes
-kretprobe_breakpoint_handler(struct pt_regs *regs, unsigned long esr)
+int __kprobes
+kretprobe_brk_handler(struct pt_regs *regs, unsigned long esr)
 {
 	if (regs->pc !=3D (unsigned long)__kretprobe_trampoline)
 		return DBG_HOOK_ERROR;
@@ -389,11 +379,6 @@ kretprobe_breakpoint_handler(struct pt_regs *regs, uns=
igned long esr)
 	return DBG_HOOK_HANDLED;
 }
=20
-static struct break_hook kretprobes_break_hook =3D {
-	.imm =3D KRETPROBES_BRK_IMM,
-	.fn =3D kretprobe_breakpoint_handler,
-};
-
 /*
  * Provide a blacklist of symbols identifying ranges which cannot be kprob=
ed.
  * This blacklist is exposed to userspace via debugfs (kprobes/blacklist).
@@ -436,9 +421,5 @@ int __kprobes arch_trampoline_kprobe(struct kprobe *p)
=20
 int __init arch_init_kprobes(void)
 {
-	register_kernel_break_hook(&kprobes_break_hook);
-	register_kernel_break_hook(&kprobes_break_ss_hook);
-	register_kernel_break_hook(&kretprobes_break_hook);
-
 	return 0;
 }
diff --git a/arch/arm64/kernel/probes/kprobes_trampoline.S b/arch/arm64/ker=
nel/probes/kprobes_trampoline.S
index a362f3dbb3d11..b60739d3983f6 100644
--- a/arch/arm64/kernel/probes/kprobes_trampoline.S
+++ b/arch/arm64/kernel/probes/kprobes_trampoline.S
@@ -12,7 +12,7 @@
 SYM_CODE_START(__kretprobe_trampoline)
 	/*
 	 * Trigger a breakpoint exception. The PC will be adjusted by
-	 * kretprobe_breakpoint_handler(), and no subsequent instructions will
+	 * kretprobe_brk_handler(), and no subsequent instructions will
 	 * be executed from the trampoline.
 	 */
 	brk #KRETPROBES_BRK_IMM
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/=
uprobes.c
index a2f137a595fc1..fc1bd19c827e6 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -165,7 +165,7 @@ int arch_uprobe_exception_notify(struct notifier_block =
*self,
 	return NOTIFY_DONE;
 }
=20
-static int uprobe_breakpoint_handler(struct pt_regs *regs,
+int uprobe_brk_handler(struct pt_regs *regs,
 				     unsigned long esr)
 {
 	if (uprobe_pre_sstep_notifier(regs))
@@ -186,12 +186,6 @@ static int uprobe_single_step_handler(struct pt_regs *=
regs,
 	return DBG_HOOK_ERROR;
 }
=20
-/* uprobe breakpoint handler hook */
-static struct break_hook uprobes_break_hook =3D {
-	.imm =3D UPROBES_BRK_IMM,
-	.fn =3D uprobe_breakpoint_handler,
-};
-
 /* uprobe single step handler hook */
 static struct step_hook uprobes_step_hook =3D {
 	.fn =3D uprobe_single_step_handler,
@@ -199,7 +193,6 @@ static struct step_hook uprobes_step_hook =3D {
=20
 static int __init arch_init_uprobes(void)
 {
-	register_user_break_hook(&uprobes_break_hook);
 	register_user_step_hook(&uprobes_step_hook);
=20
 	return 0;
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index c38ebf715be76..013159bc0882e 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -978,7 +978,7 @@ void do_serror(struct pt_regs *regs, unsigned long esr)
 int is_valid_bugaddr(unsigned long addr)
 {
 	/*
-	 * bug_handler() only called for BRK #BUG_BRK_IMM.
+	 * bug_brk_handler() only called for BRK #BUG_BRK_IMM.
 	 * So the answer is trivial -- any spurious instances with no
 	 * bug table entry will be rejected by report_bug() and passed
 	 * back to the debug-monitors code and handled as a fatal
@@ -988,7 +988,7 @@ int is_valid_bugaddr(unsigned long addr)
 }
 #endif
=20
-static int bug_handler(struct pt_regs *regs, unsigned long esr)
+int bug_brk_handler(struct pt_regs *regs, unsigned long esr)
 {
 	switch (report_bug(regs->pc, regs)) {
 	case BUG_TRAP_TYPE_BUG:
@@ -1008,13 +1008,8 @@ static int bug_handler(struct pt_regs *regs, unsigne=
d long esr)
 	return DBG_HOOK_HANDLED;
 }
=20
-static struct break_hook bug_break_hook =3D {
-	.fn =3D bug_handler,
-	.imm =3D BUG_BRK_IMM,
-};
-
 #ifdef CONFIG_CFI_CLANG
-static int cfi_handler(struct pt_regs *regs, unsigned long esr)
+int cfi_brk_handler(struct pt_regs *regs, unsigned long esr)
 {
 	unsigned long target;
 	u32 type;
@@ -1037,15 +1032,9 @@ static int cfi_handler(struct pt_regs *regs, unsigne=
d long esr)
 	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
 	return DBG_HOOK_HANDLED;
 }
-
-static struct break_hook cfi_break_hook =3D {
-	.fn =3D cfi_handler,
-	.imm =3D CFI_BRK_IMM_BASE,
-	.mask =3D CFI_BRK_IMM_MASK,
-};
 #endif /* CONFIG_CFI_CLANG */
=20
-static int reserved_fault_handler(struct pt_regs *regs, unsigned long esr)
+int reserved_fault_brk_handler(struct pt_regs *regs, unsigned long esr)
 {
 	pr_err("%s generated an invalid instruction at %pS!\n",
 		"Kernel text patching",
@@ -1055,11 +1044,6 @@ static int reserved_fault_handler(struct pt_regs *re=
gs, unsigned long esr)
 	return DBG_HOOK_ERROR;
 }
=20
-static struct break_hook fault_break_hook =3D {
-	.fn =3D reserved_fault_handler,
-	.imm =3D FAULT_BRK_IMM,
-};
-
 #ifdef CONFIG_KASAN_SW_TAGS
=20
 #define KASAN_ESR_RECOVER	0x20
@@ -1067,7 +1051,7 @@ static struct break_hook fault_break_hook =3D {
 #define KASAN_ESR_SIZE_MASK	0x0f
 #define KASAN_ESR_SIZE(esr)	(1 << ((esr) & KASAN_ESR_SIZE_MASK))
=20
-static int kasan_handler(struct pt_regs *regs, unsigned long esr)
+int kasan_brk_handler(struct pt_regs *regs, unsigned long esr)
 {
 	bool recover =3D esr & KASAN_ESR_RECOVER;
 	bool write =3D esr & KASAN_ESR_WRITE;
@@ -1098,26 +1082,14 @@ static int kasan_handler(struct pt_regs *regs, unsi=
gned long esr)
 	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
 	return DBG_HOOK_HANDLED;
 }
-
-static struct break_hook kasan_break_hook =3D {
-	.fn	=3D kasan_handler,
-	.imm	=3D KASAN_BRK_IMM,
-	.mask	=3D KASAN_BRK_MASK,
-};
 #endif
=20
 #ifdef CONFIG_UBSAN_TRAP
-static int ubsan_handler(struct pt_regs *regs, unsigned long esr)
+int ubsan_brk_handler(struct pt_regs *regs, unsigned long esr)
 {
 	die(report_ubsan_failure(regs, esr & UBSAN_BRK_MASK), regs, esr);
 	return DBG_HOOK_HANDLED;
 }
-
-static struct break_hook ubsan_break_hook =3D {
-	.fn	=3D ubsan_handler,
-	.imm	=3D UBSAN_BRK_IMM,
-	.mask	=3D UBSAN_BRK_MASK,
-};
 #endif
=20
 /*
@@ -1129,31 +1101,20 @@ int __init early_brk64(unsigned long addr, unsigned=
 long esr,
 {
 #ifdef CONFIG_CFI_CLANG
 	if (esr_is_cfi_brk(esr))
-		return cfi_handler(regs, esr) !=3D DBG_HOOK_HANDLED;
+		return cfi_brk_handler(regs, esr) !=3D DBG_HOOK_HANDLED;
 #endif
 #ifdef CONFIG_KASAN_SW_TAGS
 	if ((esr_brk_comment(esr) & ~KASAN_BRK_MASK) =3D=3D KASAN_BRK_IMM)
-		return kasan_handler(regs, esr) !=3D DBG_HOOK_HANDLED;
+		return kasan_brk_handler(regs, esr) !=3D DBG_HOOK_HANDLED;
 #endif
 #ifdef CONFIG_UBSAN_TRAP
 	if (esr_is_ubsan_brk(esr))
-		return ubsan_handler(regs, esr) !=3D DBG_HOOK_HANDLED;
+		return ubsan_brk_handler(regs, esr) !=3D DBG_HOOK_HANDLED;
 #endif
-	return bug_handler(regs, esr) !=3D DBG_HOOK_HANDLED;
+	return bug_brk_handler(regs, esr) !=3D DBG_HOOK_HANDLED;
 }
=20
 void __init trap_init(void)
 {
-	register_kernel_break_hook(&bug_break_hook);
-#ifdef CONFIG_CFI_CLANG
-	register_kernel_break_hook(&cfi_break_hook);
-#endif
-	register_kernel_break_hook(&fault_break_hook);
-#ifdef CONFIG_KASAN_SW_TAGS
-	register_kernel_break_hook(&kasan_break_hook);
-#endif
-#ifdef CONFIG_UBSAN_TRAP
-	register_kernel_break_hook(&ubsan_break_hook);
-#endif
 	debug_traps_init();
 }
--=20
2.53.0

