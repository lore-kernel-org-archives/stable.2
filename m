Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936AB4EFFBA
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698883; cv=none; b=jwyslqnw2eczWsmYmRYIpo6OzX7Io1yzfN2hMc3sUsXfCFGn+MNAwp3KlUlBCmAJCnHRFGSFWXsr2FgD70hbnfGEcRmjGK9kJo87fIZeoMv14X7rTSd6Xr/8OR0OU4Ko1/x9pIppP9JI1yVEe1i/A982aKZr7JTeNpjgNbNXb/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698883; c=relaxed/simple;
	bh=RqJVI6Il+/2UaN2r27HIbdIiThzfoXgr0yqrn+erPg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkjRMy0UPbLzagGTsQNIkxiS+mqrYEd+/Nau3euCDoGL6OEhnzaQFLgtUagb/kFPP9bZdVw+LaYiCEAnagcCmK+ha1aijCRSSairAr2NfXaTiML3ocPB4TMDRgSGXz9QsyDf7lHO8qi7YICkvR5S+7tnCK4KKzaRU6LG/Kne6Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGNlS6Cq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGNlS6Cq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80761F00893;
	Tue, 29 Sep 2026 16:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790698881;
	bh=vZXG+q9cHzCJmPXqHp0kykhEUnoASckoupPWBD6LhhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SGNlS6CqYh13APPjV9MeGPCUSW2kpKq7nb2IvNfzP+SmqaDLFEZ4Fl/frJlFRR8xV
	 3hPxioCCtGzgFwP1MHwlbCQHzG8d0gy+h/hn/3cokDDDuiaOvlgCykUsEYIxi0Sg5e
	 26az9vT8uyd8hwLtg3KrE5fycOpMOIamZ0B1q8pqEx0mVNzgmpnQhMVolrDOz3nvl3
	 o3b0t3t7qhi1oHfcx5In9+bCeKmGxMUsawtZs7Q89ixB9CAS2cmTz0AcgZfs8Q9yAj
	 RBl9KmQmyNLDGY3GniHuK3fQMylq8hGjsE4TrQPHjczj9mYFWftqJ+YLeDsbzG5tY/
	 126uZH5tn6K/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Borislav Petkov <bp@suse.de>,
	Tony Luck <tony.luck@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] x86/mce: Get rid of machine_check_vector
Date: Tue, 29 Sep 2026 12:21:18 -0400
Message-ID: <20260929162119.4190350-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092919-precut-headboard-8c2f@gregkh>
References: <2026092919-precut-headboard-8c2f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Borislav Petkov <bp@suse.de>

[ Upstream commit cbe1de162d8297e941f01ac7dd399a11251352bc ]

Get rid of the indirect function pointer and use flags settings instead
to steer execution.

Now that it is not an indirect call any longer, drop the instrumentation
annotation for objtool too.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20210922165101.18951-3-bp@alien8.de

Stable 5.10 adaptation:
- Keep the existing kill_it recovery state when moving declarations.
- Rely on irqentry_nmi_enter()/irqentry_nmi_exit() for IRQ tracing, removing
  the duplicate tracing and indirect-call instrumentation from the wrapper.
- Guard direct legacy-handler calls with CONFIG_X86_ANCIENT_MCE and retain
  the existing initialization declarations in asm/mce.h. This avoids adding
  no-op handler functions for configurations without ancient MCE support.
- Publish the P5/Winchip handler flags in their existing initialization
  functions, retaining the write barrier before enabling machine checks.
  P5 opt-in and feature checks therefore still precede handler selection.

[ sashal: Reduced backport -- upstream cbe1de162d829 touches 5 file(s), this
  backport carries 4. Not backported here:
  arch/x86/include/asm/mce.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: b8d1d5b63a8e ("x86/mce: Fix hardware debug register corruption on task migration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/mce/core.c     | 64 +++++++++++++++---------------
 arch/x86/kernel/cpu/mce/internal.h | 20 +++++++---
 arch/x86/kernel/cpu/mce/p5.c       |  6 +--
 arch/x86/kernel/cpu/mce/winchip.c  |  6 +--
 4 files changed, 52 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 3199dfcb757c4..716c828aa9084 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1312,6 +1312,15 @@ static void queue_task_work(struct mce *m, char *msg, int kill_current_task)
 	task_work_add(current, &current->mce_kill_me, TWA_RESUME);
 }
 
+/* Handle unconfigured int18 (should never happen) */
+static noinstr void unexpected_machine_check(struct pt_regs *regs)
+{
+	instrumentation_begin();
+	pr_err("CPU#%d: Unexpected int18 (Machine Check)\n",
+	       smp_processor_id());
+	instrumentation_end();
+}
+
 /*
  * The actual machine check handler. This only handles real
  * exceptions when something got corrupted coming in through int 18.
@@ -1332,36 +1341,45 @@ static void queue_task_work(struct mce *m, char *msg, int kill_current_task)
  */
 noinstr void do_machine_check(struct pt_regs *regs)
 {
+	int worst = 0, order, no_way_out, kill_it, lmce;
 	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
 	struct mca_config *cfg = &mca_cfg;
 	struct mce m, *final;
 	char *msg = NULL;
-	int worst = 0;
+
+#ifdef CONFIG_X86_ANCIENT_MCE
+	if (unlikely(mce_flags.p5))
+		return pentium_machine_check(regs);
+	else if (unlikely(mce_flags.winchip))
+		return winchip_machine_check(regs);
+#endif
+	if (unlikely(!mca_cfg.initialized))
+		return unexpected_machine_check(regs);
 
 	/*
 	 * Establish sequential order between the CPUs entering the machine
 	 * check handler.
 	 */
-	int order = -1;
+	order = -1;
 
 	/*
 	 * If no_way_out gets set, there is no safe way to recover from this
 	 * MCE.  If mca_cfg.tolerant is cranked up, we'll try anyway.
 	 */
-	int no_way_out = 0;
+	no_way_out = 0;
 
 	/*
 	 * If kill_it gets set, there might be a way to recover from this
 	 * error.
 	 */
-	int kill_it = 0;
+	kill_it = 0;
 
 	/*
 	 * MCEs are always local on AMD. Same is determined by MCG_STATUS_LMCES
 	 * on Intel.
 	 */
-	int lmce = 1;
+	lmce = 1;
 
 	this_cpu_inc(mce_exception_count);
 
@@ -2009,18 +2027,6 @@ bool filter_mce(struct mce *m)
 	return false;
 }
 
-/* Handle unconfigured int18 (should never happen) */
-static noinstr void unexpected_machine_check(struct pt_regs *regs)
-{
-	instrumentation_begin();
-	pr_err("CPU#%d: Unexpected int18 (Machine Check)\n",
-	       smp_processor_id());
-	instrumentation_end();
-}
-
-/* Call the installed machine check handler for this CPU setup. */
-void (*machine_check_vector)(struct pt_regs *) = unexpected_machine_check;
-
 static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 {
 	irqentry_state_t irq_state;
@@ -2031,30 +2037,22 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 	 * Only required when from kernel mode. See
 	 * mce_check_crashing_cpu() for details.
 	 */
-	if (machine_check_vector == do_machine_check &&
-	    mce_check_crashing_cpu())
+	if (mca_cfg.initialized && mce_check_crashing_cpu())
 		return;
 
 	irq_state = irqentry_nmi_enter(regs);
-	/*
-	 * The call targets are marked noinstr, but objtool can't figure
-	 * that out because it's an indirect call. Annotate it.
-	 */
-	instrumentation_begin();
-	trace_hardirqs_off_finish();
-	machine_check_vector(regs);
-	if (regs->flags & X86_EFLAGS_IF)
-		trace_hardirqs_on_prepare();
-	instrumentation_end();
+
+	do_machine_check(regs);
+
 	irqentry_nmi_exit(regs, irq_state);
 }
 
 static __always_inline void exc_machine_check_user(struct pt_regs *regs)
 {
 	irqentry_enter_from_user_mode(regs);
-	instrumentation_begin();
-	machine_check_vector(regs);
-	instrumentation_end();
+
+	do_machine_check(regs);
+
 	irqentry_exit_to_user_mode(regs);
 }
 
@@ -2121,7 +2119,7 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 		return;
 	}
 
-	machine_check_vector = do_machine_check;
+	mca_cfg.initialized = 1;
 
 	__mcheck_cpu_init_early(c);
 	__mcheck_cpu_init_generic();
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 3a485c0d5791b..65d3e14147599 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -8,9 +8,6 @@
 #include <linux/device.h>
 #include <asm/mce.h>
 
-/* Pointer to the installed machine check handler for this CPU setup. */
-extern void (*machine_check_vector)(struct pt_regs *);
-
 enum severity_level {
 	MCE_NO_SEVERITY,
 	MCE_DEFERRED_SEVERITY,
@@ -127,7 +124,9 @@ struct mca_config {
 	      ser			: 1,
 	      recovery			: 1,
 	      bios_cmci_threshold	: 1,
-	      __reserved		: 59;
+	      /* Proper #MC exception handler is set */
+	      initialized		: 1,
+	      __reserved		: 58;
 
 	s8 bootlog;
 	int tolerant;
@@ -163,7 +162,13 @@ struct mce_vendor_flags {
 	/* AMD-style error thresholding banks present. */
 	amd_threshold		: 1,
 
-	__reserved_0		: 60;
+	/* Pentium, family 5-style MCA */
+	p5			: 1,
+
+	/* Centaur Winchip C6-style MCA */
+	winchip			: 1,
+
+	__reserved_0		: 58;
 };
 
 extern struct mce_vendor_flags mce_flags;
@@ -196,4 +201,9 @@ __visible bool ex_handler_wrmsr_fault(const struct exception_table_entry *fixup,
 				      unsigned long error_code,
 				      unsigned long fault_addr);
 
+#ifdef CONFIG_X86_ANCIENT_MCE
+noinstr void pentium_machine_check(struct pt_regs *regs);
+noinstr void winchip_machine_check(struct pt_regs *regs);
+#endif
+
 #endif /* __X86_MCE_INTERNAL_H__ */
diff --git a/arch/x86/kernel/cpu/mce/p5.c b/arch/x86/kernel/cpu/mce/p5.c
index 19e90cae8e97d..97d47082c245e 100644
--- a/arch/x86/kernel/cpu/mce/p5.c
+++ b/arch/x86/kernel/cpu/mce/p5.c
@@ -21,7 +21,7 @@
 int mce_p5_enabled __read_mostly;
 
 /* Machine check handler for Pentium class Intel CPUs: */
-static noinstr void pentium_machine_check(struct pt_regs *regs)
+noinstr void pentium_machine_check(struct pt_regs *regs)
 {
 	u32 loaddr, hi, lotype;
 
@@ -54,8 +54,8 @@ void intel_p5_mcheck_init(struct cpuinfo_x86 *c)
 	if (!cpu_has(c, X86_FEATURE_MCE))
 		return;
 
-	machine_check_vector = pentium_machine_check;
-	/* Make sure the vector pointer is visible before we enable MCEs: */
+	mce_flags.p5 = 1;
+	/* Make sure the handler flag is visible before we enable MCEs: */
 	wmb();
 
 	/* Read registers before enabling: */
diff --git a/arch/x86/kernel/cpu/mce/winchip.c b/arch/x86/kernel/cpu/mce/winchip.c
index 9c9f0abd2d7fd..df1ac587cceb3 100644
--- a/arch/x86/kernel/cpu/mce/winchip.c
+++ b/arch/x86/kernel/cpu/mce/winchip.c
@@ -17,7 +17,7 @@
 #include "internal.h"
 
 /* Machine check handler for WinChip C6: */
-static noinstr void winchip_machine_check(struct pt_regs *regs)
+noinstr void winchip_machine_check(struct pt_regs *regs)
 {
 	instrumentation_begin();
 	pr_emerg("CPU0: Machine Check Exception.\n");
@@ -30,8 +30,8 @@ void winchip_mcheck_init(struct cpuinfo_x86 *c)
 {
 	u32 lo, hi;
 
-	machine_check_vector = winchip_machine_check;
-	/* Make sure the vector pointer is visible before we enable MCEs: */
+	mce_flags.winchip = 1;
+	/* Make sure the handler flag is visible before we enable MCEs: */
 	wmb();
 
 	rdmsr(MSR_IDT_FCR1, lo, hi);
-- 
2.53.0

