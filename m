Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D883D6484;
	Sun, 23 Aug 2026 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787489122; cv=none; b=mfWEjxYpCMZzkPYjJufTPhE9+gPqN1pObZyWwxzCvdWDlCA1lT4pKbfih5CEUFuwqlFJnbdEoo/+StdmAwSjZ+FlI1YFq6yYcvHYEou2ytlpLApbosZ75W96n2YCdtWgySXTsQlEWyyHsuQVA4y5JDxogssYexk4ELZjQvYg2ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787489122; c=relaxed/simple;
	bh=EH3MmMh8cVUemUCoDw52ZALXznnklZAz9hIbOdVgjsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g893R3om4tIshL2qRXGUKrYcwdRE/d5Qb0Be7YC2LF1kEwEATJg0BPmG7+7XJU/9C0AsxIfyWkK19zUGeosh6eubaIRS1ZDvboS26aNL0EUEaOtM4E04T3u/x2FHgJIY1NKsWrVp/v8l5/Fjgm9GXFjJTYZaVnOe/sXdmI/QIPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IkNiWvp/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IkNiWvp/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A871F00A3D;
	Sun, 23 Aug 2026 12:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787489101;
	bh=v+8QjjwZeazOkUMunZhsesU2TtXFcIH4E5qAd7aF62A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IkNiWvp/ACDhGuoHzGAqEFeLHpKiOm1AQalPhLs8ccemKC8NMq32CcnZsG3AfDoq3
	 093pQBQ07KnkQibvgg5WH+9zZHQRJuNsIlws9YLAlIgjEyZWdlOeZ+Kl13iqx2khJa
	 xt8kB7MkP6PdNGCOLhmN3cA8WHTAbySbLpDzLyJI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.266
Date: Sun, 23 Aug 2026 14:43:13 +0200
Message-ID: <2026082312-catnip-immorally-834e@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026082312-bribe-scalping-3ef9@gregkh>
References: <2026082312-bribe-scalping-3ef9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 1773020dec8d..8a3a5b5ffbdf 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 265
+SUBLEVEL = 266
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 05cf606b85c9..b38c16f25f1f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -2375,6 +2375,8 @@ timer {
 			     <GIC_PPI 11
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 15
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 		interrupt-parent = <&gic>;
 		always-on;
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index afe8be2fef88..309a925c2e7a 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -686,7 +686,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 			return ret;
 	}
 
-	if (run->immediate_exit)
+	if (!vcpu->wants_to_run)
 		return -EINTR;
 
 	vcpu_load(vcpu);
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 3d6a7f5827b1..e70b8a5793e0 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -464,7 +464,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		vcpu->mmio_needed = 0;
 	}
 
-	if (vcpu->run->immediate_exit)
+	if (!vcpu->wants_to_run)
 		goto out;
 
 	lose_fpu(1);
diff --git a/arch/openrisc/include/asm/processor.h b/arch/openrisc/include/asm/processor.h
index ad53b3184885..9976727753e8 100644
--- a/arch/openrisc/include/asm/processor.h
+++ b/arch/openrisc/include/asm/processor.h
@@ -26,6 +26,8 @@
 		   | SPR_SR_DCE | SPR_SR_SM)
 #define USER_SR   (SPR_SR_DME | SPR_SR_IME | SPR_SR_ICE \
 		   | SPR_SR_DCE | SPR_SR_IEE | SPR_SR_TEE)
+/* SR bits user space may change via sigreturn, the rest stay kernel owned */
+#define SPR_SR_USER_MASK  (SPR_SR_F | SPR_SR_CY | SPR_SR_OV)
 
 /*
  * User space process size. This is hardcoded into a few places,
diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
index 1ebcff271096..8163ca3533fc 100644
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -39,6 +39,7 @@ struct rt_sigframe {
 static int restore_sigcontext(struct pt_regs *regs,
 			      struct sigcontext __user *sc)
 {
+	unsigned long old_sr = regs->sr;
 	int err = 0;
 
 	/* Always make any pending restarted system calls return -EINTR */
@@ -53,8 +54,8 @@ static int restore_sigcontext(struct pt_regs *regs,
 	err |= __copy_from_user(&regs->pc, &sc->regs.pc, sizeof(unsigned long));
 	err |= __copy_from_user(&regs->sr, &sc->regs.sr, sizeof(unsigned long));
 
-	/* make sure the SM-bit is cleared so user-mode cannot fool us */
-	regs->sr &= ~SPR_SR_SM;
+	/* keep the privileged SR bits kernel owned, restore only user flags */
+	regs->sr = (old_sr & ~SPR_SR_USER_MASK) | (regs->sr & SPR_SR_USER_MASK);
 
 	regs->orig_gpr11 = -1;	/* Avoid syscall restart checks */
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 0f5ebec660a7..103d389b59b5 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1832,7 +1832,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 	kvm_sigset_activate(vcpu);
 
-	if (run->immediate_exit)
+	if (!vcpu->wants_to_run)
 		r = -EINTR;
 	else
 		r = kvmppc_vcpu_run(vcpu);
diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index e0c5fc9ab242..593aac9937f1 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -639,7 +639,7 @@ static ssize_t lparcfg_write(struct file *file, const char __user * buf,
 	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
 		return -EINVAL;
 
-	if (count > sizeof(kbuf))
+	if (count == 0 || count > sizeof(kbuf))
 		return -EINVAL;
 
 	if (copy_from_user(kbuf, buf, count))
diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 911534b89c85..647bc8c7bf8a 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -161,7 +161,7 @@ int pseries_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 
 	/* First integer stores max config */
 	max_config_vfs = of_read_number(&max_vfs[0], 1);
-	if (max_config_vfs < num_vfs && num_vfs > MAX_VFS_FOR_MAP_PE) {
+	if (max_config_vfs < num_vfs || num_vfs > MAX_VFS_FOR_MAP_PE) {
 		dev_err(&pdev->dev,
 			"Num VFs %x > %x Configurable VFs\n",
 			num_vfs, (num_vfs > MAX_VFS_FOR_MAP_PE) ?
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f6c27b44766f..15cd2c22ed00 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4373,7 +4373,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	struct kvm_run *kvm_run = vcpu->run;
 	int rc;
 
-	if (kvm_run->immediate_exit)
+	if (!vcpu->wants_to_run)
 		return -EINTR;
 
 	if (kvm_run->kvm_valid_regs & ~KVM_SYNC_S390_VALID_FIELDS ||
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3e9f1c820edb..d13db9173603 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -544,7 +544,6 @@ struct kvm_vcpu_arch {
 	u64 efer;
 	u64 apic_base;
 	struct kvm_lapic *apic;    /* kernel irqchip context */
-	bool apicv_active;
 	bool load_eoi_exitmap_pending;
 	DECLARE_BITMAP(ioapic_handled_vectors, 256);
 	unsigned long apic_attention;
@@ -1179,7 +1178,7 @@ struct kvm_x86_ops {
 	void (*pre_update_apicv_exec_ctrl)(struct kvm *kvm, bool activate);
 	void (*refresh_apicv_exec_ctrl)(struct kvm_vcpu *vcpu);
 	void (*hwapic_irr_update)(struct kvm_vcpu *vcpu, int max_irr);
-	void (*hwapic_isr_update)(struct kvm_vcpu *vcpu, int isr);
+	void (*hwapic_isr_update)(int isr);
 	bool (*guest_apic_has_interrupt)(struct kvm_vcpu *vcpu);
 	void (*load_eoi_exitmap)(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
 	void (*set_virtual_apic_mode)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1e73b6fae3b4..f0e879d3ac30 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2376,10 +2376,6 @@ static void rmdir_all_sub(void)
 		if (rdtgrp == &rdtgroup_default)
 			continue;
 
-		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
-		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)
-			rdtgroup_pseudo_lock_remove(rdtgrp);
-
 		/*
 		 * Give any CPUs back to the default group. We cannot copy
 		 * cpu_online_mask because a CPU might have executed the
@@ -2388,7 +2384,13 @@ static void rmdir_all_sub(void)
 		cpumask_or(&rdtgroup_default.cpu_mask,
 			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
 
-		free_rmid(rdtgrp->mon.rmid);
+		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
+		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
+			rdtgroup_pseudo_lock_remove(rdtgrp);
+		} else {
+			/* Pseudo-locked group's RMID is freed during setup. */
+			free_rmid(rdtgrp->mon.rmid);
+		}
 
 		kernfs_remove(rdtgrp->kn);
 		list_del(&rdtgrp->rdtgroup_list);
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 79679dd7ec86..8b7c3f773d70 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -482,14 +482,10 @@ static inline int apic_find_highest_irr(struct kvm_lapic *apic)
 
 static inline void apic_clear_irr(int vec, struct kvm_lapic *apic)
 {
-	struct kvm_vcpu *vcpu;
-
-	vcpu = apic->vcpu;
-
-	if (unlikely(vcpu->arch.apicv_active)) {
+	if (unlikely(apic->apicv_active)) {
 		/* need to update RVI */
 		kvm_lapic_clear_vector(vec, apic->regs + APIC_IRR);
-		kvm_x86_ops.hwapic_irr_update(vcpu,
+		kvm_x86_ops.hwapic_irr_update(apic->vcpu,
 				apic_find_highest_irr(apic));
 	} else {
 		apic->irr_pending = false;
@@ -507,20 +503,16 @@ EXPORT_SYMBOL_GPL(kvm_apic_clear_irr);
 
 static inline void apic_set_isr(int vec, struct kvm_lapic *apic)
 {
-	struct kvm_vcpu *vcpu;
-
 	if (__apic_test_and_set_vector(vec, apic->regs + APIC_ISR))
 		return;
 
-	vcpu = apic->vcpu;
-
 	/*
 	 * With APIC virtualization enabled, all caching is disabled
 	 * because the processor can modify ISR under the hood.  Instead
 	 * just set SVI.
 	 */
-	if (unlikely(vcpu->arch.apicv_active))
-		kvm_x86_ops.hwapic_isr_update(vcpu, vec);
+	if (unlikely(apic->apicv_active))
+		kvm_x86_ops.hwapic_isr_update(vec);
 	else {
 		++apic->isr_count;
 		BUG_ON(apic->isr_count > MAX_APIC_VECTOR);
@@ -554,12 +546,9 @@ static inline int apic_find_highest_isr(struct kvm_lapic *apic)
 
 static inline void apic_clear_isr(int vec, struct kvm_lapic *apic)
 {
-	struct kvm_vcpu *vcpu;
 	if (!__apic_test_and_clear_vector(vec, apic->regs + APIC_ISR))
 		return;
 
-	vcpu = apic->vcpu;
-
 	/*
 	 * We do get here for APIC virtualization enabled if the guest
 	 * uses the Hyper-V APIC enlightenment.  In this case we may need
@@ -567,9 +556,8 @@ static inline void apic_clear_isr(int vec, struct kvm_lapic *apic)
 	 * on the other hand isr_count and highest_isr_cache are unused
 	 * and must be left alone.
 	 */
-	if (unlikely(vcpu->arch.apicv_active))
-		kvm_x86_ops.hwapic_isr_update(vcpu,
-					       apic_find_highest_isr(apic));
+	if (unlikely(apic->apicv_active))
+		kvm_x86_ops.hwapic_isr_update(apic_find_highest_isr(apic));
 	else {
 		--apic->isr_count;
 		BUG_ON(apic->isr_count < 0);
@@ -707,7 +695,7 @@ static void pv_eoi_clr_pending(struct kvm_vcpu *vcpu)
 static int apic_has_interrupt_for_ppr(struct kvm_lapic *apic, u32 ppr)
 {
 	int highest_irr;
-	if (apic->vcpu->arch.apicv_active)
+	if (apic->apicv_active)
 		highest_irr = kvm_x86_ops.sync_pir_to_irr(apic->vcpu);
 	else
 		highest_irr = apic_find_highest_irr(apic);
@@ -1539,7 +1527,7 @@ static bool lapic_timer_int_injected(struct kvm_vcpu *vcpu)
 		int vec = reg & APIC_VECTOR_MASK;
 		void *bitmap = apic->regs + APIC_ISR;
 
-		if (vcpu->arch.apicv_active)
+		if (apic->apicv_active)
 			bitmap = apic->regs + APIC_IRR;
 
 		if (apic_test_vector(vec, bitmap))
@@ -1648,7 +1636,7 @@ static void apic_timer_expired(struct kvm_lapic *apic, bool from_timer_fn)
 	if (apic_lvtt_tscdeadline(apic) || ktimer->hv_timer_in_use)
 		ktimer->expired_tscdeadline = ktimer->tscdeadline;
 
-	if (!from_timer_fn && vcpu->arch.apicv_active) {
+	if (!from_timer_fn && apic->apicv_active && vcpu->wants_to_run) {
 		WARN_ON(kvm_get_running_vcpu() != vcpu);
 		kvm_apic_inject_pending_timer_irqs(apic);
 		return;
@@ -2318,7 +2306,7 @@ void kvm_apic_update_apicv(struct kvm_vcpu *vcpu)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
 
-	if (vcpu->arch.apicv_active) {
+	if (apic->apicv_active) {
 		/* irr_pending is always true when apicv is activated. */
 		apic->irr_pending = true;
 		apic->isr_count = 1;
@@ -2380,10 +2368,10 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
 				vcpu->arch.apic_base | MSR_IA32_APICBASE_BSP);
 	vcpu->arch.pv_eoi.msr_val = 0;
 	apic_update_ppr(apic);
-	if (vcpu->arch.apicv_active) {
+	if (apic->apicv_active) {
 		kvm_x86_ops.apicv_post_state_restore(vcpu);
 		kvm_x86_ops.hwapic_irr_update(vcpu, -1);
-		kvm_x86_ops.hwapic_isr_update(vcpu, -1);
+		kvm_x86_ops.hwapic_isr_update(-1);
 	}
 
 	vcpu->arch.apic_arb_prio = 0;
@@ -2647,12 +2635,11 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
 	__start_apic_timer(apic, APIC_TMCCT);
 	kvm_apic_update_apicv(vcpu);
 	apic->highest_isr_cache = -1;
-	if (vcpu->arch.apicv_active) {
+	if (apic->apicv_active) {
 		kvm_x86_ops.apicv_post_state_restore(vcpu);
 		kvm_x86_ops.hwapic_irr_update(vcpu,
 				apic_find_highest_irr(apic));
-		kvm_x86_ops.hwapic_isr_update(vcpu,
-				apic_find_highest_isr(apic));
+		kvm_x86_ops.hwapic_isr_update(apic_find_highest_isr(apic));
 	}
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 	if (ioapic_in_kernel(vcpu->kvm))
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 4fb86e3a9dd3..c72fdafa4604 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -47,6 +47,7 @@ struct kvm_lapic {
 	struct kvm_timer lapic_timer;
 	u32 divide_count;
 	struct kvm_vcpu *vcpu;
+	bool apicv_active;
 	bool sw_enabled;
 	bool irr_pending;
 	bool lvt0_in_nmi_mode;
@@ -216,7 +217,7 @@ static inline int apic_x2apic_mode(struct kvm_lapic *apic)
 
 static inline bool kvm_vcpu_apicv_active(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.apic && vcpu->arch.apicv_active;
+	return vcpu->arch.apic && vcpu->arch.apic->apicv_active;
 }
 
 static inline bool kvm_apic_has_events(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index a5c5eb3fea22..6f01a29aeec5 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -603,7 +603,7 @@ void svm_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr)
 {
 }
 
-void svm_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr)
+void svm_hwapic_isr_update(int max_isr)
 {
 }
 
@@ -673,7 +673,7 @@ void svm_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
 
 int svm_deliver_avic_intr(struct kvm_vcpu *vcpu, int vec)
 {
-	if (!vcpu->arch.apicv_active)
+	if (!kvm_vcpu_apicv_active(vcpu))
 		return -1;
 
 	kvm_lapic_set_irr(vec, vcpu->arch.apic);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index f62d13fc6e01..cdae2dc1315a 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -457,7 +457,7 @@ bool svm_check_apicv_inhibit_reasons(ulong bit);
 void svm_pre_update_apicv_exec_ctrl(struct kvm *kvm, bool activate);
 void svm_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
 void svm_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr);
-void svm_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr);
+void svm_hwapic_isr_update(int max_isr);
 int svm_deliver_avic_intr(struct kvm_vcpu *vcpu, int vec);
 bool svm_dy_apicv_has_pending_interrupt(struct kvm_vcpu *vcpu);
 int svm_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cf4a08f2b756..0fb9cdc01212 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4116,7 +4116,8 @@ static int vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector)
 	if (!r)
 		return 0;
 
-	if (!vcpu->arch.apicv_active)
+	/* Note, this is called iff the local APIC is in-kernel. */
+	if (!vcpu->arch.apic->apicv_active)
 		return -1;
 
 	if (pi_test_and_set_pir(vector, &vmx->pi_desc))
@@ -6403,7 +6404,7 @@ static void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
 	put_page(page);
 }
 
-static void vmx_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr)
+static void vmx_hwapic_isr_update(int max_isr)
 {
 	u16 status;
 	u8 old;
@@ -6457,7 +6458,7 @@ static int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu)
 	int max_irr;
 	bool max_irr_updated;
 
-	WARN_ON(!vcpu->arch.apicv_active);
+	WARN_ON(!kvm_vcpu_apicv_active(vcpu));
 	if (pi_test_on(&vmx->pi_desc)) {
 		pi_clear_on(&vmx->pi_desc);
 		/*
@@ -6983,7 +6984,7 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 			 * but it would incur the cost of a retpoline for now.
 			 * Revisit once static calls are available.
 			 */
-			if (vcpu->arch.apicv_active)
+			if (kvm_vcpu_apicv_active(vcpu))
 				vmx_sync_pir_to_irr(vcpu);
 			goto reenter_guest;
 		}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index dcf774db73a9..1b8860a1c7c2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4182,7 +4182,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 static int kvm_vcpu_ioctl_get_lapic(struct kvm_vcpu *vcpu,
 				    struct kvm_lapic_state *s)
 {
-	if (vcpu->arch.apicv_active)
+	if (kvm_vcpu_apicv_active(vcpu))
 		kvm_x86_ops.sync_pir_to_irr(vcpu);
 
 	return kvm_apic_get_state(vcpu, s);
@@ -8504,7 +8504,7 @@ static void update_cr8_intercept(struct kvm_vcpu *vcpu)
 	if (!lapic_in_kernel(vcpu))
 		return;
 
-	if (vcpu->arch.apicv_active)
+	if (vcpu->arch.apic->apicv_active)
 		return;
 
 	if (!vcpu->arch.apic->vapic_addr)
@@ -8967,7 +8967,7 @@ void kvm_vcpu_update_apicv(struct kvm_vcpu *vcpu)
 	if (!lapic_in_kernel(vcpu))
 		return;
 
-	vcpu->arch.apicv_active = kvm_apicv_activated(vcpu->kvm);
+	vcpu->arch.apic->apicv_active = kvm_apicv_activated(vcpu->kvm);
 	kvm_apic_update_apicv(vcpu);
 	kvm_x86_ops.refresh_apicv_exec_ctrl(vcpu);
 }
@@ -9031,7 +9031,7 @@ static void vcpu_scan_ioapic(struct kvm_vcpu *vcpu)
 	if (irqchip_split(vcpu->kvm))
 		kvm_scan_ioapic_routes(vcpu, vcpu->arch.ioapic_handled_vectors);
 	else {
-		if (vcpu->arch.apicv_active)
+		if (kvm_vcpu_apicv_active(vcpu))
 			kvm_x86_ops.sync_pir_to_irr(vcpu);
 		if (ioapic_in_kernel(vcpu->kvm))
 			kvm_ioapic_scan_entry(vcpu, vcpu->arch.ioapic_handled_vectors);
@@ -9275,7 +9275,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	 * This handles the case where a posted interrupt was
 	 * notified with kvm_vcpu_kick.
 	 */
-	if (kvm_lapic_enabled(vcpu) && vcpu->arch.apicv_active)
+	if (kvm_lapic_enabled(vcpu) && kvm_vcpu_apicv_active(vcpu))
 		kvm_x86_ops.sync_pir_to_irr(vcpu);
 
 	if (kvm_vcpu_exit_request(vcpu)) {
@@ -9648,7 +9648,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	kvm_load_guest_fpu(vcpu);
 
 	if (unlikely(vcpu->arch.mp_state == KVM_MP_STATE_UNINITIALIZED)) {
-		if (kvm_run->immediate_exit) {
+		if (!vcpu->wants_to_run) {
 			r = -EINTR;
 			goto out;
 		}
@@ -9692,7 +9692,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	} else
 		WARN_ON(vcpu->arch.pio.count || vcpu->mmio_needed);
 
-	if (kvm_run->immediate_exit)
+	if (!vcpu->wants_to_run)
 		r = -EINTR;
 	else
 		r = vcpu_run(vcpu);
@@ -10254,7 +10254,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 		if (r < 0)
 			goto fail_mmu_destroy;
 		if (kvm_apicv_activated(vcpu->kvm))
-			vcpu->arch.apicv_active = true;
+			vcpu->arch.apic->apicv_active = true;
 	} else
 		static_key_slow_inc(&kvm_no_apic_vcpu);
 
@@ -11122,7 +11122,8 @@ bool kvm_arch_dy_runnable(struct kvm_vcpu *vcpu)
 		 kvm_test_request(KVM_REQ_EVENT, vcpu))
 		return true;
 
-	if (vcpu->arch.apicv_active && kvm_x86_ops.dy_apicv_has_pending_interrupt(vcpu))
+	if (kvm_vcpu_apicv_active(vcpu) &&
+	    kvm_x86_ops.dy_apicv_has_pending_interrupt(vcpu))
 		return true;
 
 	return false;
diff --git a/crypto/ccm.c b/crypto/ccm.c
index 494d70901186..52ace42e11e8 100644
--- a/crypto/ccm.c
+++ b/crypto/ccm.c
@@ -752,7 +752,7 @@ static int crypto_rfc4309_create(struct crypto_template *tmpl,
 
 	inst->alg.ivsize = 8;
 	inst->alg.chunksize = crypto_aead_alg_chunksize(alg);
-	inst->alg.maxauthsize = 16;
+	inst->alg.maxauthsize = crypto_aead_alg_maxauthsize(alg);
 
 	inst->alg.base.cra_ctxsize = sizeof(struct crypto_rfc4309_ctx);
 
diff --git a/drivers/base/property.c b/drivers/base/property.c
index cbd0c2f1a041..4b16531d7791 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1042,6 +1042,35 @@ int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
 }
 EXPORT_SYMBOL(fwnode_irq_get);
 
+/**
+ * fwnode_irq_get_byname - Get IRQ from a fwnode using its name
+ * @fwnode:	Pointer to the firmware node
+ * @name:	IRQ name
+ *
+ * Description:
+ * Find a match to the string @name in the 'interrupt-names' string array
+ * in _DSD for ACPI, or of_node for Device Tree. Then get the Linux IRQ
+ * number of the IRQ resource corresponding to the index of the matched
+ * string.
+ *
+ * Return:
+ * Linux IRQ number on success, or negative errno otherwise.
+ */
+int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name)
+{
+	int index;
+
+	if (!name)
+		return -EINVAL;
+
+	index = fwnode_property_match_string(fwnode, "interrupt-names",  name);
+	if (index < 0)
+		return index;
+
+	return fwnode_irq_get(fwnode, index);
+}
+EXPORT_SYMBOL(fwnode_irq_get_byname);
+
 /**
  * fwnode_graph_get_next_endpoint - Get next endpoint firmware node
  * @fwnode: Pointer to the parent firmware node
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 16e486337ecb..88f73e1b749d 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -49,10 +49,11 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		bool check_cancel)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	unsigned long stop;
-	long rc;
 	u8 status;
 	bool canceled = false;
+	int ret;
 
 	/* check current status */
 	status = chip->ops->status(chip);
@@ -62,23 +63,32 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 	stop = jiffies + timeout;
 
 	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
+		ret = -ETIME;
+		add_wait_queue(queue, &wait);
 again:
+		if (wait_for_tpm_stat_cond(chip, mask, check_cancel,
+					   &canceled)) {
+			ret = canceled ? -ECANCELED : 0;
+			goto out;
+		}
+
 		timeout = stop - jiffies;
 		if ((long)timeout <= 0)
-			return -ETIME;
-		rc = wait_event_interruptible_timeout(*queue,
-			wait_for_tpm_stat_cond(chip, mask, check_cancel,
-					       &canceled),
-			timeout);
-		if (rc > 0) {
-			if (canceled)
-				return -ECANCELED;
-			return 0;
-		}
-		if (rc == -ERESTARTSYS && freezing(current)) {
-			clear_thread_flag(TIF_SIGPENDING);
-			goto again;
+			goto out;
+
+		if (signal_pending(current)) {
+			if (freezing(current)) {
+				clear_thread_flag(TIF_SIGPENDING);
+				goto again;
+			}
+			goto out;
 		}
+
+		wait_woken(&wait, TASK_INTERRUPTIBLE, timeout);
+		goto again;
+out:
+		remove_wait_queue(queue, &wait);
+		return ret;
 	} else {
 		do {
 			usleep_range(priv->timeout_min,
diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 92233b9a5501..82a6d51dae47 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -52,7 +52,7 @@ static int qce_register_algs(struct qce_device *qce)
 		ret = ops->register_algs(qce);
 		if (ret) {
 			for (j = i - 1; j >= 0; j--)
-				ops->unregister_algs(qce);
+				qce_ops[j]->unregister_algs(qce);
 			return ret;
 		}
 	}
diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index 72e87380b61a..1a1dab99a11f 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -173,7 +173,7 @@ void dma_resv_fini(struct dma_resv *obj)
 EXPORT_SYMBOL(dma_resv_fini);
 
 /**
- * dma_resv_reserve_shared - Reserve space to add shared fences to
+ * dma_resv_reserve_fences - Reserve space to add shared fences to
  * a dma_resv.
  * @obj: reservation object
  * @num_fences: number of fences we want to add
@@ -184,7 +184,7 @@ EXPORT_SYMBOL(dma_resv_fini);
  * RETURNS
  * Zero for success, or -errno
  */
-int dma_resv_reserve_shared(struct dma_resv *obj, unsigned int num_fences)
+int dma_resv_reserve_fences(struct dma_resv *obj, unsigned int num_fences)
 {
 	struct dma_resv_list *old, *new;
 	unsigned int i, j, k, max;
@@ -250,7 +250,7 @@ int dma_resv_reserve_shared(struct dma_resv *obj, unsigned int num_fences)
 
 	return 0;
 }
-EXPORT_SYMBOL(dma_resv_reserve_shared);
+EXPORT_SYMBOL(dma_resv_reserve_fences);
 
 /**
  * dma_resv_add_shared_fence - Add a fence to a shared slot
@@ -258,7 +258,7 @@ EXPORT_SYMBOL(dma_resv_reserve_shared);
  * @fence: the shared fence to add
  *
  * Add a fence to a shared slot, obj->lock must be held, and
- * dma_resv_reserve_shared() has been called.
+ * dma_resv_reserve_fences() has been called.
  */
 void dma_resv_add_shared_fence(struct dma_resv *obj, struct dma_fence *fence)
 {
diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 95bc8cef5dbd..4673c524c930 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -66,14 +66,16 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 					0, ubuf->pagecount << PAGE_SHIFT,
 					GFP_KERNEL);
 	if (ret < 0)
-		goto err;
-	ret = dma_map_sgtable(dev, sg, direction, 0);
+		goto err_alloc;
+
+	ret = dma_map_sgtable(dev, sg, direction, DMA_ATTR_SKIP_CPU_SYNC);
 	if (ret < 0)
-		goto err;
+		goto err_map;
 	return sg;
 
-err:
+err_map:
 	sg_free_table(sg);
+err_alloc:
 	kfree(sg);
 	return ERR_PTR(ret);
 }
@@ -81,7 +83,7 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 static void put_sg_table(struct device *dev, struct sg_table *sg,
 			 enum dma_data_direction direction)
 {
-	dma_unmap_sgtable(dev, sg, direction, 0);
+	dma_unmap_sgtable(dev, sg, direction, DMA_ATTR_SKIP_CPU_SYNC);
 	sg_free_table(sg);
 	kfree(sg);
 }
@@ -119,21 +121,22 @@ static int begin_cpu_udmabuf(struct dma_buf *buf,
 {
 	struct udmabuf *ubuf = buf->priv;
 	struct device *dev = ubuf->device->this_device;
-	int ret = 0;
 
 	if (!ubuf->sg) {
 		ubuf->sg = get_sg_table(dev, buf, direction);
 		if (IS_ERR(ubuf->sg)) {
+			int ret;
+
 			ret = PTR_ERR(ubuf->sg);
 			ubuf->sg = NULL;
+			return ret;
 		} else {
 			ubuf->sg_dir = direction;
 		}
-	} else {
-		dma_sync_sgtable_for_cpu(dev, ubuf->sg, direction);
 	}
 
-	return ret;
+	dma_sync_sgtable_for_cpu(dev, ubuf->sg, direction);
+	return 0;
 }
 
 static int end_cpu_udmabuf(struct dma_buf *buf,
diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index df2874f6f462..3830e9e989dd 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -81,8 +81,13 @@ static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 	 *  - Even chunks originate CB equal to 1
 	 */
 	chunk->cb = !(desc->chunks_alloc % 2);
-	chunk->ll_region.paddr = dw->ll_region.paddr + chan->ll_off;
-	chunk->ll_region.vaddr = dw->ll_region.vaddr + chan->ll_off;
+	if (chan->dir == EDMA_DIR_WRITE) {
+		chunk->ll_region.paddr = dw->ll_region_wr[chan->id].paddr;
+		chunk->ll_region.vaddr = dw->ll_region_wr[chan->id].vaddr;
+	} else {
+		chunk->ll_region.paddr = dw->ll_region_rd[chan->id].paddr;
+		chunk->ll_region.vaddr = dw->ll_region_rd[chan->id].vaddr;
+	}
 
 	if (desc->chunk) {
 		/* Create and add new element into the linked list */
@@ -669,24 +674,13 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
 	struct device *dev = chip->dev;
 	struct dw_edma *dw = chip->dw;
 	struct dw_edma_chan *chan;
-	size_t ll_chunk, dt_chunk;
 	struct dw_edma_irq *irq;
 	struct dma_device *dma;
-	u32 i, j, cnt, ch_cnt;
 	u32 alloc, off_alloc;
+	u32 i, j, cnt;
 	int err = 0;
 	u32 pos;
 
-	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
-	ll_chunk = dw->ll_region.sz;
-	dt_chunk = dw->dt_region.sz;
-
-	/* Calculate linked list chunk for each channel */
-	ll_chunk /= roundup_pow_of_two(ch_cnt);
-
-	/* Calculate linked list chunk for each channel */
-	dt_chunk /= roundup_pow_of_two(ch_cnt);
-
 	if (write) {
 		i = 0;
 		cnt = dw->wr_ch_cnt;
@@ -712,20 +706,21 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
 		chan->vc.chan.private = dt_region;
 
 		chan->chip = chip;
+		chan->dw = dw;
 		chan->id = j;
 		chan->dir = write ? EDMA_DIR_WRITE : EDMA_DIR_READ;
 		chan->configured = false;
 		chan->request = EDMA_REQ_NONE;
 		chan->status = EDMA_ST_IDLE;
 
-		chan->ll_off = (ll_chunk * i);
-		chan->ll_max = (ll_chunk / EDMA_LL_SZ) - 1;
-
-		chan->dt_off = (dt_chunk * i);
+		if (write)
+			chan->ll_max = (dw->ll_region_wr[j].sz / EDMA_LL_SZ);
+		else
+			chan->ll_max = (dw->ll_region_rd[j].sz / EDMA_LL_SZ);
+		chan->ll_max -= 1;
 
-		dev_vdbg(dev, "L. List:\tChannel %s[%u] off=0x%.8lx, max_cnt=%u\n",
-			 write ? "write" : "read", j,
-			 chan->ll_off, chan->ll_max);
+		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
+			 write ? "write" : "read", j, chan->ll_max);
 
 		if (dw->nr_irqs == 1)
 			pos = 0;
@@ -750,12 +745,15 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
 		chan->vc.desc_free = vchan_free_desc;
 		vchan_init(&chan->vc, dma);
 
-		dt_region->paddr = dw->dt_region.paddr + chan->dt_off;
-		dt_region->vaddr = dw->dt_region.vaddr + chan->dt_off;
-		dt_region->sz = dt_chunk;
-
-		dev_vdbg(dev, "Data:\tChannel %s[%u] off=0x%.8lx\n",
-			 write ? "write" : "read", j, chan->dt_off);
+		if (write) {
+			dt_region->paddr = dw->dt_region_wr[j].paddr;
+			dt_region->vaddr = dw->dt_region_wr[j].vaddr;
+			dt_region->sz = dw->dt_region_wr[j].sz;
+		} else {
+			dt_region->paddr = dw->dt_region_rd[j].paddr;
+			dt_region->vaddr = dw->dt_region_rd[j].vaddr;
+			dt_region->sz = dw->dt_region_rd[j].sz;
+		}
 
 		dw_edma_v0_core_device_config(chan);
 	}
@@ -824,7 +822,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 
 	if (dw->nr_irqs == 1) {
 		/* Common IRQ shared among all channels */
-		irq = dw->ops->irq_vector(dev, 0);
+		irq = dw->core->irq_vector(dev, 0);
 		err = request_irq(irq, dw_edma_interrupt_common,
 				  IRQF_SHARED, dw->name, &dw->irq[0]);
 		if (err) {
@@ -847,7 +845,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 		dw_edma_add_irq_mask(&rd_mask, *rd_alloc, dw->rd_ch_cnt);
 
 		for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
-			irq = dw->ops->irq_vector(dev, i);
+			irq = dw->core->irq_vector(dev, i);
 			err = request_irq(irq,
 					  i < *wr_alloc ?
 						dw_edma_interrupt_write :
@@ -885,19 +883,20 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 		return -EINVAL;
 
 	dw = chip->dw;
-	if (!dw || !dw->irq || !dw->ops || !dw->ops->irq_vector)
+	if (!dw || !dw->irq || !dw->core || !dw->core->irq_vector)
 		return -EINVAL;
 
 	raw_spin_lock_init(&dw->lock);
 
-	/* Find out how many write channels are supported by hardware */
-	dw->wr_ch_cnt = dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE);
-	if (!dw->wr_ch_cnt)
-		return -EINVAL;
+	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt,
+			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE));
+	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
+
+	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt,
+			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ));
+	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
 
-	/* Find out how many read channels are supported by hardware */
-	dw->rd_ch_cnt = dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ);
-	if (!dw->rd_ch_cnt)
+	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
 		return -EINVAL;
 
 	dev_vdbg(dev, "Channels:\twrite=%d, read=%d\n",
@@ -939,7 +938,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 
 err_irq_free:
 	for (i = (dw->nr_irqs - 1); i >= 0; i--)
-		free_irq(dw->ops->irq_vector(dev, i), &dw->irq[i]);
+		free_irq(dw->core->irq_vector(dev, i), &dw->irq[i]);
 
 	dw->nr_irqs = 0;
 
@@ -959,7 +958,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 
 	/* Free irqs */
 	for (i = (dw->nr_irqs - 1); i >= 0; i--)
-		free_irq(dw->ops->irq_vector(dev, i), &dw->irq[i]);
+		free_irq(dw->core->irq_vector(dev, i), &dw->irq[i]);
 
 	/* Power management */
 	pm_runtime_disable(dev);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 31fc50d31792..e9d199107668 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -15,6 +15,8 @@
 #include "../virt-dma.h"
 
 #define EDMA_LL_SZ					24
+#define EDMA_MAX_WR_CH					8
+#define EDMA_MAX_RD_CH					8
 
 enum dw_edma_dir {
 	EDMA_DIR_WRITE = 0,
@@ -40,6 +42,7 @@ enum dw_edma_status {
 
 struct dw_edma_chan;
 struct dw_edma_chunk;
+struct dw_edma;
 
 struct dw_edma_burst {
 	struct list_head		list;
@@ -79,14 +82,12 @@ struct dw_edma_desc {
 struct dw_edma_chan {
 	struct virt_dma_chan		vc;
 	struct dw_edma_chip		*chip;
+	struct dw_edma			*dw;
 	int				id;
 	enum dw_edma_dir		dir;
 
-	off_t				ll_off;
 	u32				ll_max;
 
-	off_t				dt_off;
-
 	struct msi_msg			msi;
 
 	enum dw_edma_request		request;
@@ -117,8 +118,10 @@ struct dw_edma {
 	u16				rd_ch_cnt;
 
 	struct dw_edma_region		rg_region;	/* Registers */
-	struct dw_edma_region		ll_region;	/* Linked list */
-	struct dw_edma_region		dt_region;	/* Data */
+	struct dw_edma_region		ll_region_wr[EDMA_MAX_WR_CH];
+	struct dw_edma_region		ll_region_rd[EDMA_MAX_RD_CH];
+	struct dw_edma_region		dt_region_wr[EDMA_MAX_WR_CH];
+	struct dw_edma_region		dt_region_rd[EDMA_MAX_RD_CH];
 
 	struct dw_edma_irq		*irq;
 	int				nr_irqs;
@@ -127,9 +130,12 @@ struct dw_edma {
 	enum dw_edma_mode		mode;
 
 	struct dw_edma_chan		*chan;
-	const struct dw_edma_core_ops	*ops;
 
-	raw_spinlock_t			lock;		/* Only for legacy */
+	raw_spinlock_t			lock;		/* Protect v0 shared registers */
+
+	struct dw_edma_chip             *chip;
+
+	const struct dw_edma_core_ops	*core;
 };
 
 struct dw_edma_sg {
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 1eafc602e17e..987ede1087dd 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -16,42 +16,73 @@
 
 #include "dw-edma-core.h"
 
+#define DW_BLOCK(a, b, c) \
+	{ \
+		.bar = a, \
+		.off = b, \
+		.sz = c, \
+	},
+
+struct dw_edma_block {
+	enum pci_barno			bar;
+	off_t				off;
+	size_t				sz;
+};
+
 struct dw_edma_pcie_data {
 	/* eDMA registers location */
-	enum pci_barno			rg_bar;
-	off_t				rg_off;
-	size_t				rg_sz;
+	struct dw_edma_block		rg;
 	/* eDMA memory linked list location */
-	enum pci_barno			ll_bar;
-	off_t				ll_off;
-	size_t				ll_sz;
+	struct dw_edma_block		ll_wr[EDMA_MAX_WR_CH];
+	struct dw_edma_block		ll_rd[EDMA_MAX_RD_CH];
 	/* eDMA memory data location */
-	enum pci_barno			dt_bar;
-	off_t				dt_off;
-	size_t				dt_sz;
+	struct dw_edma_block		dt_wr[EDMA_MAX_WR_CH];
+	struct dw_edma_block		dt_rd[EDMA_MAX_RD_CH];
 	/* Other */
 	u32				version;
 	enum dw_edma_mode		mode;
 	u8				irqs;
+	u16				wr_ch_cnt;
+	u16				rd_ch_cnt;
 };
 
 static const struct dw_edma_pcie_data snps_edda_data = {
 	/* eDMA registers location */
-	.rg_bar				= BAR_0,
-	.rg_off				= 0x00001000,	/*  4 Kbytes */
-	.rg_sz				= 0x00002000,	/*  8 Kbytes */
+	.rg.bar				= BAR_0,
+	.rg.off				= 0x00001000,	/*  4 Kbytes */
+	.rg.sz				= 0x00002000,	/*  8 Kbytes */
 	/* eDMA memory linked list location */
-	.ll_bar				= BAR_2,
-	.ll_off				= 0x00000000,	/*  0 Kbytes */
-	.ll_sz				= 0x00800000,	/*  8 Mbytes */
+	.ll_wr = {
+		/* Channel 0 - BAR 2, offset 0 Mbytes, size 2 Mbytes */
+		DW_BLOCK(BAR_2, 0x00000000, 0x00200000)
+		/* Channel 1 - BAR 2, offset 2 Mbytes, size 2 Mbytes */
+		DW_BLOCK(BAR_2, 0x00200000, 0x00200000)
+	},
+	.ll_rd = {
+		/* Channel 0 - BAR 2, offset 4 Mbytes, size 2 Mbytes */
+		DW_BLOCK(BAR_2, 0x00400000, 0x00200000)
+		/* Channel 1 - BAR 2, offset 6 Mbytes, size 2 Mbytes */
+		DW_BLOCK(BAR_2, 0x00600000, 0x00200000)
+	},
 	/* eDMA memory data location */
-	.dt_bar				= BAR_2,
-	.dt_off				= 0x00800000,	/*  8 Mbytes */
-	.dt_sz				= 0x03800000,	/* 56 Mbytes */
+	.dt_wr = {
+		/* Channel 0 - BAR 2, offset 8 Mbytes, size 14 Mbytes */
+		DW_BLOCK(BAR_2, 0x00800000, 0x00e00000)
+		/* Channel 1 - BAR 2, offset 22 Mbytes, size 14 Mbytes */
+		DW_BLOCK(BAR_2, 0x01600000, 0x00e00000)
+	},
+	.dt_rd = {
+		/* Channel 0 - BAR 2, offset 36 Mbytes, size 14 Mbytes */
+		DW_BLOCK(BAR_2, 0x02400000, 0x00e00000)
+		/* Channel 1 - BAR 2, offset 50 Mbytes, size 14 Mbytes */
+		DW_BLOCK(BAR_2, 0x03200000, 0x00e00000)
+	},
 	/* Other */
 	.version			= 0,
 	.mode				= EDMA_MODE_UNROLL,
 	.irqs				= 1,
+	.wr_ch_cnt			= 2,
+	.rd_ch_cnt			= 2,
 };
 
 static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
@@ -71,6 +102,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	struct dw_edma_chip *chip;
 	int err, nr_irqs;
 	struct dw_edma *dw;
+	int i, mask;
 
 	/* Enable PCI device */
 	err = pcim_enable_device(pdev);
@@ -80,10 +112,16 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	}
 
 	/* Mapping PCI BAR regions */
-	err = pcim_iomap_regions(pdev, BIT(pdata->rg_bar) |
-				       BIT(pdata->ll_bar) |
-				       BIT(pdata->dt_bar),
-				 pci_name(pdev));
+	mask = BIT(pdata->rg.bar);
+	for (i = 0; i < pdata->wr_ch_cnt; i++) {
+		mask |= BIT(pdata->ll_wr[i].bar);
+		mask |= BIT(pdata->dt_wr[i].bar);
+	}
+	for (i = 0; i < pdata->rd_ch_cnt; i++) {
+		mask |= BIT(pdata->ll_rd[i].bar);
+		mask |= BIT(pdata->dt_rd[i].bar);
+	}
+	err = pcim_iomap_regions(pdev, mask, pci_name(pdev));
 	if (err) {
 		pci_err(pdev, "eDMA BAR I/O remapping failed\n");
 		return err;
@@ -137,30 +175,58 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->dw = dw;
 	chip->dev = dev;
 	chip->id = pdev->devfn;
-	chip->irq = pdev->irq;
-
-	dw->rg_region.vaddr = pcim_iomap_table(pdev)[pdata->rg_bar];
-	dw->rg_region.vaddr += pdata->rg_off;
-	dw->rg_region.paddr = pdev->resource[pdata->rg_bar].start;
-	dw->rg_region.paddr += pdata->rg_off;
-	dw->rg_region.sz = pdata->rg_sz;
-
-	dw->ll_region.vaddr = pcim_iomap_table(pdev)[pdata->ll_bar];
-	dw->ll_region.vaddr += pdata->ll_off;
-	dw->ll_region.paddr = pdev->resource[pdata->ll_bar].start;
-	dw->ll_region.paddr += pdata->ll_off;
-	dw->ll_region.sz = pdata->ll_sz;
-
-	dw->dt_region.vaddr = pcim_iomap_table(pdev)[pdata->dt_bar];
-	dw->dt_region.vaddr += pdata->dt_off;
-	dw->dt_region.paddr = pdev->resource[pdata->dt_bar].start;
-	dw->dt_region.paddr += pdata->dt_off;
-	dw->dt_region.sz = pdata->dt_sz;
 
+	dw->chip = chip;
 	dw->version = pdata->version;
 	dw->mode = pdata->mode;
 	dw->nr_irqs = nr_irqs;
-	dw->ops = &dw_edma_pcie_core_ops;
+	dw->core = &dw_edma_pcie_core_ops;
+	dw->wr_ch_cnt = pdata->wr_ch_cnt;
+	dw->rd_ch_cnt = pdata->rd_ch_cnt;
+
+	dw->rg_region.vaddr = pcim_iomap_table(pdev)[pdata->rg.bar];
+	dw->rg_region.vaddr += pdata->rg.off;
+	dw->rg_region.paddr = pdev->resource[pdata->rg.bar].start;
+	dw->rg_region.paddr += pdata->rg.off;
+	dw->rg_region.sz = pdata->rg.sz;
+
+	for (i = 0; i < dw->wr_ch_cnt; i++) {
+		struct dw_edma_region *ll_region = &dw->ll_region_wr[i];
+		struct dw_edma_region *dt_region = &dw->dt_region_wr[i];
+		const struct dw_edma_block *ll_block = &pdata->ll_wr[i];
+		const struct dw_edma_block *dt_block = &pdata->dt_wr[i];
+
+		ll_region->vaddr = pcim_iomap_table(pdev)[ll_block->bar];
+		ll_region->vaddr += ll_block->off;
+		ll_region->paddr = pdev->resource[ll_block->bar].start;
+		ll_region->paddr += ll_block->off;
+		ll_region->sz = ll_block->sz;
+
+		dt_region->vaddr = pcim_iomap_table(pdev)[dt_block->bar];
+		dt_region->vaddr += dt_block->off;
+		dt_region->paddr = pdev->resource[dt_block->bar].start;
+		dt_region->paddr += dt_block->off;
+		dt_region->sz = dt_block->sz;
+	}
+
+	for (i = 0; i < dw->rd_ch_cnt; i++) {
+		struct dw_edma_region *ll_region = &dw->ll_region_rd[i];
+		struct dw_edma_region *dt_region = &dw->dt_region_rd[i];
+		const struct dw_edma_block *ll_block = &pdata->ll_rd[i];
+		const struct dw_edma_block *dt_block = &pdata->dt_rd[i];
+
+		ll_region->vaddr = pcim_iomap_table(pdev)[ll_block->bar];
+		ll_region->vaddr += ll_block->off;
+		ll_region->paddr = pdev->resource[ll_block->bar].start;
+		ll_region->paddr += ll_block->off;
+		ll_region->sz = ll_block->sz;
+
+		dt_region->vaddr = pcim_iomap_table(pdev)[dt_block->bar];
+		dt_region->vaddr += dt_block->off;
+		dt_region->paddr = pdev->resource[dt_block->bar].start;
+		dt_region->paddr += dt_block->off;
+		dt_region->sz = dt_block->sz;
+	}
 
 	/* Debug info */
 	pci_dbg(pdev, "Version:\t%u\n", dw->version);
@@ -169,16 +235,32 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		dw->mode == EDMA_MODE_LEGACY ? "Legacy" : "Unroll");
 
 	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
-		pdata->rg_bar, pdata->rg_off, pdata->rg_sz,
+		pdata->rg.bar, pdata->rg.off, pdata->rg.sz,
 		dw->rg_region.vaddr, &dw->rg_region.paddr);
 
-	pci_dbg(pdev, "L. List:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
-		pdata->ll_bar, pdata->ll_off, pdata->ll_sz,
-		dw->ll_region.vaddr, &dw->ll_region.paddr);
+	for (i = 0; i < dw->wr_ch_cnt; i++) {
+		pci_dbg(pdev, "L. List:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
+			i, pdata->ll_wr[i].bar, pdata->ll_wr[i].off,
+			dw->ll_region_wr[i].sz, dw->ll_region_wr[i].vaddr,
+			&dw->ll_region_wr[i].paddr);
+
+		pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
+			i, pdata->dt_wr[i].bar, pdata->dt_wr[i].off,
+			dw->dt_region_wr[i].sz, dw->dt_region_wr[i].vaddr,
+			&dw->dt_region_wr[i].paddr);
+	}
 
-	pci_dbg(pdev, "Data:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
-		pdata->dt_bar, pdata->dt_off, pdata->dt_sz,
-		dw->dt_region.vaddr, &dw->dt_region.paddr);
+	for (i = 0; i < dw->rd_ch_cnt; i++) {
+		pci_dbg(pdev, "L. List:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
+			i, pdata->ll_rd[i].bar, pdata->ll_rd[i].off,
+			dw->ll_region_rd[i].sz, dw->ll_region_rd[i].vaddr,
+			&dw->ll_region_rd[i].paddr);
+
+		pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
+			i, pdata->dt_rd[i].bar, pdata->dt_rd[i].off,
+			dw->dt_region_rd[i].sz, dw->dt_region_rd[i].vaddr,
+			&dw->dt_region_rd[i].paddr);
+	}
 
 	pci_dbg(pdev, "Nr. IRQs:\t%u\n", dw->nr_irqs);
 
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 692de47b1670..b021f6d96430 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -34,7 +34,7 @@ static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
 #define GET(dw, name)					\
 	readl(&(__dw_regs(dw)->name))
 
-#define SET_RW(dw, dir, name, value)			\
+#define SET_RW_32(dw, dir, name, value)			\
 	do {						\
 		if ((dir) == EDMA_DIR_WRITE)		\
 			SET(dw, wr_##name, value);	\
@@ -42,7 +42,7 @@ static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
 			SET(dw, rd_##name, value);	\
 	} while (0)
 
-#define GET_RW(dw, dir, name)				\
+#define GET_RW_32(dw, dir, name)			\
 	((dir) == EDMA_DIR_WRITE			\
 	  ? GET(dw, wr_##name)				\
 	  : GET(dw, rd_##name))
@@ -115,7 +115,7 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 	return value;
 }
 
-#define SET_CH(dw, dir, ch, name, value) \
+#define SET_CH_32(dw, dir, ch, name, value) \
 	writel_ch(dw, dir, ch, value, &(__dw_ch_regs(dw, dir, ch)->name))
 
 #define GET_CH(dw, dir, ch, name) \
@@ -167,26 +167,26 @@ void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->chip->dw;
 
-	SET_RW(dw, chan->dir, int_clear,
-	       FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id)));
+	SET_RW_32(dw, chan->dir, int_clear,
+		  FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id)));
 }
 
 void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->chip->dw;
 
-	SET_RW(dw, chan->dir, int_clear,
-	       FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id)));
+	SET_RW_32(dw, chan->dir, int_clear,
+		  FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id)));
 }
 
 u32 dw_edma_v0_core_status_done_int(struct dw_edma *dw, enum dw_edma_dir dir)
 {
-	return FIELD_GET(EDMA_V0_DONE_INT_MASK, GET_RW(dw, dir, int_status));
+	return FIELD_GET(EDMA_V0_DONE_INT_MASK, GET_RW_32(dw, dir, int_status));
 }
 
 u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
 {
-	return FIELD_GET(EDMA_V0_ABORT_INT_MASK, GET_RW(dw, dir, int_status));
+	return FIELD_GET(EDMA_V0_ABORT_INT_MASK, GET_RW_32(dw, dir, int_status));
 }
 
 static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
@@ -236,35 +236,41 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma *dw = chan->dw;
+	unsigned long flags;
 	u32 tmp;
 
 	dw_edma_v0_core_write_chunk(chunk);
 
 	if (first) {
 		/* Enable engine */
-		SET_RW(dw, chan->dir, engine_en, BIT(0));
+		SET_RW_32(dw, chan->dir, engine_en, BIT(0));
 		/* Interrupt unmask - done, abort */
-		tmp = GET_RW(dw, chan->dir, int_mask);
+		raw_spin_lock_irqsave(&dw->lock, flags);
+
+		tmp = GET_RW_32(dw, chan->dir, int_mask);
 		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
 		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
-		SET_RW(dw, chan->dir, int_mask, tmp);
+		SET_RW_32(dw, chan->dir, int_mask, tmp);
 		/* Linked list error */
-		tmp = GET_RW(dw, chan->dir, linked_list_err_en);
+		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
 		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
-		SET_RW(dw, chan->dir, linked_list_err_en, tmp);
+		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
+
+		raw_spin_unlock_irqrestore(&dw->lock, flags);
+
 		/* Channel control */
-		SET_CH(dw, chan->dir, chan->id, ch_control1,
-		       (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
+		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
+			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
 		/* Linked list - low, high */
-		SET_CH(dw, chan->dir, chan->id, llp_low,
-		       lower_32_bits(chunk->ll_region.paddr));
-		SET_CH(dw, chan->dir, chan->id, llp_high,
-		       upper_32_bits(chunk->ll_region.paddr));
+		SET_CH_32(dw, chan->dir, chan->id, llp_low,
+			  lower_32_bits(chunk->ll_region.paddr));
+		SET_CH_32(dw, chan->dir, chan->id, llp_high,
+			  upper_32_bits(chunk->ll_region.paddr));
 	}
 	/* Doorbell */
-	SET_RW(dw, chan->dir, doorbell,
-	       FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
+	SET_RW_32(dw, chan->dir, doorbell,
+		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
 }
 
 int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
@@ -273,31 +279,31 @@ int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
 	u32 tmp = 0;
 
 	/* MSI done addr - low, high */
-	SET_RW(dw, chan->dir, done_imwr_low, chan->msi.address_lo);
-	SET_RW(dw, chan->dir, done_imwr_high, chan->msi.address_hi);
+	SET_RW_32(dw, chan->dir, done_imwr_low, chan->msi.address_lo);
+	SET_RW_32(dw, chan->dir, done_imwr_high, chan->msi.address_hi);
 	/* MSI abort addr - low, high */
-	SET_RW(dw, chan->dir, abort_imwr_low, chan->msi.address_lo);
-	SET_RW(dw, chan->dir, abort_imwr_high, chan->msi.address_hi);
+	SET_RW_32(dw, chan->dir, abort_imwr_low, chan->msi.address_lo);
+	SET_RW_32(dw, chan->dir, abort_imwr_high, chan->msi.address_hi);
 	/* MSI data - low, high */
 	switch (chan->id) {
 	case 0:
 	case 1:
-		tmp = GET_RW(dw, chan->dir, ch01_imwr_data);
+		tmp = GET_RW_32(dw, chan->dir, ch01_imwr_data);
 		break;
 
 	case 2:
 	case 3:
-		tmp = GET_RW(dw, chan->dir, ch23_imwr_data);
+		tmp = GET_RW_32(dw, chan->dir, ch23_imwr_data);
 		break;
 
 	case 4:
 	case 5:
-		tmp = GET_RW(dw, chan->dir, ch45_imwr_data);
+		tmp = GET_RW_32(dw, chan->dir, ch45_imwr_data);
 		break;
 
 	case 6:
 	case 7:
-		tmp = GET_RW(dw, chan->dir, ch67_imwr_data);
+		tmp = GET_RW_32(dw, chan->dir, ch67_imwr_data);
 		break;
 	}
 
@@ -316,22 +322,22 @@ int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
 	switch (chan->id) {
 	case 0:
 	case 1:
-		SET_RW(dw, chan->dir, ch01_imwr_data, tmp);
+		SET_RW_32(dw, chan->dir, ch01_imwr_data, tmp);
 		break;
 
 	case 2:
 	case 3:
-		SET_RW(dw, chan->dir, ch23_imwr_data, tmp);
+		SET_RW_32(dw, chan->dir, ch23_imwr_data, tmp);
 		break;
 
 	case 4:
 	case 5:
-		SET_RW(dw, chan->dir, ch45_imwr_data, tmp);
+		SET_RW_32(dw, chan->dir, ch45_imwr_data, tmp);
 		break;
 
 	case 6:
 	case 7:
-		SET_RW(dw, chan->dir, ch67_imwr_data, tmp);
+		SET_RW_32(dw, chan->dir, ch67_imwr_data, tmp);
 		break;
 	}
 
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 753cda4b2568..b85e0624ab8f 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -707,6 +707,9 @@ afu_ioctl_dma_map(struct dfl_feature_platform_data *pdata, void __user *arg)
 	if (map.argsz < minsz || map.flags)
 		return -EINVAL;
 
+	if (map.length >> PAGE_SHIFT > (u64)INT_MAX)
+		return -EINVAL;
+
 	ret = afu_dma_map_region(pdata, map.user_addr, map.length, &map.iova);
 	if (ret)
 		return ret;
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 86568154cdb3..4a3f2fe7a3a8 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -168,18 +168,11 @@ static int tegra_gpio_direction_input(struct gpio_chip *chip,
 				      unsigned int offset)
 {
 	struct tegra_gpio_info *tgi = gpiochip_get_data(chip);
-	int ret;
 
 	tegra_gpio_mask_write(tgi, GPIO_MSK_OE(tgi, offset), offset, 0);
 	tegra_gpio_enable(tgi, offset);
 
-	ret = pinctrl_gpio_direction_input(chip->base + offset);
-	if (ret < 0)
-		dev_err(tgi->dev,
-			"Failed to set pinctrl input direction of GPIO %d: %d",
-			 chip->base + offset, ret);
-
-	return ret;
+	return 0;
 }
 
 static int tegra_gpio_direction_output(struct gpio_chip *chip,
@@ -187,19 +180,12 @@ static int tegra_gpio_direction_output(struct gpio_chip *chip,
 				       int value)
 {
 	struct tegra_gpio_info *tgi = gpiochip_get_data(chip);
-	int ret;
 
 	tegra_gpio_set(chip, offset, value);
 	tegra_gpio_mask_write(tgi, GPIO_MSK_OE(tgi, offset), offset, 1);
 	tegra_gpio_enable(tgi, offset);
 
-	ret = pinctrl_gpio_direction_output(chip->base + offset);
-	if (ret < 0)
-		dev_err(tgi->dev,
-			"Failed to set pinctrl output direction of GPIO %d: %d",
-			 chip->base + offset, ret);
-
-	return ret;
+	return 0;
 }
 
 static int tegra_gpio_get_direction(struct gpio_chip *chip,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index ad89377404dd..a574c89193bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -950,7 +950,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 				  AMDGPU_FENCE_OWNER_KFD, false);
 	if (ret)
 		goto wait_pd_fail;
-	ret = dma_resv_reserve_shared(vm->root.base.bo->tbo.base.resv, 1);
+	ret = dma_resv_reserve_fences(vm->root.base.bo->tbo.base.resv, 1);
 	if (ret)
 		goto reserve_shared_fail;
 	amdgpu_bo_fence(vm->root.base.bo,
@@ -2205,7 +2205,7 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
 	 * Add process eviction fence to bo so they can
 	 * evict each other.
 	 */
-	ret = dma_resv_reserve_shared(gws_bo->tbo.base.resv, 1);
+	ret = dma_resv_reserve_fences(gws_bo->tbo.base.resv, 1);
 	if (ret)
 		goto reserve_shared_fail;
 	amdgpu_bo_fence(gws_bo, &process_info->eviction_fence->base, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 6aa9fd9cb83b..543a2d12cf89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -197,6 +197,25 @@ void amdgpu_gem_object_close(struct drm_gem_object *obj,
 	ttm_eu_backoff_reservation(&ticket, &list);
 }
 
+static bool amdgpu_gem_are_domains_valid(u32 domains)
+{
+	u32 normal = AMDGPU_GEM_DOMAIN_CPU |
+		     AMDGPU_GEM_DOMAIN_GTT |
+		     AMDGPU_GEM_DOMAIN_VRAM;
+	/* Treat all non CPU/GTT/VRAM domains as special domains. */
+	u32 special = AMDGPU_GEM_DOMAIN_MASK & ~normal;
+	u32 normal_mask = domains & normal;
+	u32 special_mask = domains & special;
+
+	if (!special_mask)
+		return true;
+
+	if (normal_mask)
+		return false;
+
+	return !(special_mask & (special_mask - 1));
+}
+
 /*
  * GEM ioctls.
  */
@@ -228,6 +247,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	/* reject invalid gem domains */
 	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
 		return -EINVAL;
+	if (!amdgpu_gem_are_domains_valid(args->in.domains))
+		return -EINVAL;
 
 	if (!amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
 		DRM_NOTE_ONCE("Cannot allocate secure buffer since TMZ is disabled\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 25095536b8ca..e2127ac7a409 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -567,8 +567,8 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 	unsigned image_size, tmp, min_dpb_size, num_dpb_buffer;
 	unsigned min_ctx_size = ~0;
 
-	/* Reject invalid dimensions to prevent division by zero */
-	if (width < 16 || height < 16) {
+	/* Reject invalid dimensions */
+	if (width < 16 || height < 16 || width > 4096 || height > 4096) {
 		dev_WARN_ONCE(adev->dev, 1,
 			      "Invalid UVD decoding dimensions (%dx%d)!\n",
 			      width, height);
@@ -715,6 +715,9 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 		image_size = ALIGN(image_size, 256);
 
 		num_dpb_buffer = (le32_to_cpu(msg[59]) & 0xff) + 2;
+		if (num_dpb_buffer > 17)
+			return -EINVAL;
+
 		min_dpb_size = image_size * num_dpb_buffer;
 		min_ctx_size = ((width + 255) / 16) * ((height + 255) / 16)
 					   * 16 * num_dpb_buffer + 52 * 1024;
@@ -725,7 +728,7 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 		return -EINVAL;
 	}
 
-	if (width > pitch) {
+	if (width > pitch || pitch > 4096) {
 		DRM_ERROR("Invalid UVD decoding target pitch!\n");
 		return -EINVAL;
 	}
@@ -737,7 +740,7 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 	}
 
 	buf_sizes[0x1] = dpb_size;
-	buf_sizes[0x2] = image_size;
+	buf_sizes[0x2] = (pitch * height) * 3 / 2;
 	buf_sizes[0x4] = min_ctx_size;
 	/* store image width to adjust nb memory pstate */
 	adev->uvd.decode_image_width = width;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ad3de971a087..499e8c842809 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2904,7 +2904,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_free_root;
 
-	r = dma_resv_reserve_shared(root->tbo.base.resv, 1);
+	r = dma_resv_reserve_fences(root->tbo.base.resv, 1);
 	if (r)
 		goto error_unreserve;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 6d9108fa22e0..89f5bdf7f2c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -846,6 +846,23 @@ static void vce_v3_0_ring_emit_ib(struct amdgpu_ring *ring,
 	amdgpu_ring_write(ring, ib->length_dw);
 }
 
+static void vce_v3_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
+			u64 seq, unsigned flags)
+{
+	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
+
+	amdgpu_ring_write(ring, VCE_CMD_FENCE);
+	amdgpu_ring_write(ring, addr);
+	amdgpu_ring_write(ring, upper_32_bits(addr));
+	amdgpu_ring_write(ring, seq);
+	amdgpu_ring_write(ring, VCE_CMD_TRAP);
+}
+
+static void vce_v3_0_ring_insert_end(struct amdgpu_ring *ring)
+{
+	amdgpu_ring_write(ring, VCE_CMD_END);
+}
+
 static void vce_v3_0_emit_vm_flush(struct amdgpu_ring *ring,
 				   unsigned int vmid, uint64_t pd_addr)
 {
@@ -855,7 +872,6 @@ static void vce_v3_0_emit_vm_flush(struct amdgpu_ring *ring,
 
 	amdgpu_ring_write(ring, VCE_CMD_FLUSH_TLB);
 	amdgpu_ring_write(ring, vmid);
-	amdgpu_ring_write(ring, VCE_CMD_END);
 }
 
 static void vce_v3_0_emit_pipeline_sync(struct amdgpu_ring *ring)
@@ -925,17 +941,19 @@ static const struct amdgpu_ring_funcs vce_v3_0_ring_vm_funcs = {
 	.set_wptr = vce_v3_0_ring_set_wptr,
 	.parse_cs = amdgpu_vce_ring_parse_cs_vm,
 	.emit_frame_size =
-		6 + /* vce_v3_0_emit_vm_flush */
+		5 + /* vce_v3_0_emit_vm_flush */
 		4 + /* vce_v3_0_emit_pipeline_sync */
-		6 + 6, /* amdgpu_vce_ring_emit_fence x2 vm fence */
+		5 + 5 + /* vce_v3_0_ring_emit_fence x2 vm fence */
+		1, /* vce_v3_0_ring_insert_end */
 	.emit_ib_size = 5, /* vce_v3_0_ring_emit_ib */
 	.emit_ib = vce_v3_0_ring_emit_ib,
 	.emit_vm_flush = vce_v3_0_emit_vm_flush,
 	.emit_pipeline_sync = vce_v3_0_emit_pipeline_sync,
-	.emit_fence = amdgpu_vce_ring_emit_fence,
+	.emit_fence = vce_v3_0_ring_emit_fence,
 	.test_ring = amdgpu_vce_ring_test_ring,
 	.test_ib = amdgpu_vce_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
+	.insert_end = vce_v3_0_ring_insert_end,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.begin_use = amdgpu_vce_ring_begin_use,
 	.end_use = amdgpu_vce_ring_end_use,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index fb1aaf959e7c..edda4081bd03 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1994,20 +1994,18 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 		return ret;
 	}
 
+	mutex_lock(&adev->pm.mutex);
 	if (is_support_sw_smu(adev))
 		size = smu_sys_get_gpu_metrics(&adev->smu, &gpu_metrics);
 	else if (adev->powerplay.pp_funcs->get_gpu_metrics)
 		size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
 
-	if (size <= 0)
-		goto out;
-
-	if (size >= PAGE_SIZE)
-		size = PAGE_SIZE - 1;
-
-	memcpy(buf, gpu_metrics, size);
+	if (size > 0) {
+		size = min_t(ssize_t, size, PAGE_SIZE - 1);
+		memcpy(buf, gpu_metrics, size);
+	}
+	mutex_unlock(&adev->pm.mutex);
 
-out:
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index db8ede9d56d1..37f51bdf4795 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2586,7 +2586,7 @@ EXPORT_SYMBOL(drm_mode_put_tile_group);
 /**
  * drm_mode_get_tile_group - get a reference to an existing tile group
  * @dev: DRM device
- * @topology: 8-bytes unique per monitor.
+ * @topology_id: 9-byte unique ID per monitor.
  *
  * Use the unique bytes to get a reference to an existing tile group.
  *
@@ -2594,14 +2594,14 @@ EXPORT_SYMBOL(drm_mode_put_tile_group);
  * tile group or NULL if not found.
  */
 struct drm_tile_group *drm_mode_get_tile_group(struct drm_device *dev,
-					       const char topology[8])
+					       const char topology_id[9])
 {
 	struct drm_tile_group *tg;
 	int id;
 
 	mutex_lock(&dev->mode_config.idr_mutex);
 	idr_for_each_entry(&dev->mode_config.tile_idr, tg, id) {
-		if (!memcmp(tg->group_data, topology, 8)) {
+		if (!memcmp(tg->group_data, topology_id, sizeof(tg->group_data))) {
 			if (!kref_get_unless_zero(&tg->refcount))
 				tg = NULL;
 			mutex_unlock(&dev->mode_config.idr_mutex);
@@ -2616,7 +2616,7 @@ EXPORT_SYMBOL(drm_mode_get_tile_group);
 /**
  * drm_mode_create_tile_group - create a tile group from a displayid description
  * @dev: DRM device
- * @topology: 8-bytes unique per monitor.
+ * @topology_id: 9-byte unique ID per monitor.
  *
  * Create a tile group for the unique monitor, and get a unique
  * identifier for the tile group.
@@ -2625,7 +2625,7 @@ EXPORT_SYMBOL(drm_mode_get_tile_group);
  * new tile group or NULL.
  */
 struct drm_tile_group *drm_mode_create_tile_group(struct drm_device *dev,
-						  const char topology[8])
+						  const char topology_id[9])
 {
 	struct drm_tile_group *tg;
 	int ret;
@@ -2635,7 +2635,7 @@ struct drm_tile_group *drm_mode_create_tile_group(struct drm_device *dev,
 		return NULL;
 
 	kref_init(&tg->refcount);
-	memcpy(tg->group_data, topology, 8);
+	memcpy(tg->group_data, topology_id, sizeof(tg->group_data));
 	tg->dev = dev;
 
 	mutex_lock(&dev->mode_config.idr_mutex);
diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 702ab6148425..7e6c74ba143e 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -778,6 +778,12 @@ static bool drm_dp_sideband_append_payload(struct drm_dp_sideband_msg_rx *msg,
 {
 	u8 crc4;
 
+	/* curchunk_len must be >= 1 (min 1 CRC byte) and fit in chunk[] */
+	if (!msg->curchunk_len ||
+	    msg->curchunk_len > ARRAY_SIZE(msg->chunk) ||
+	    msg->curchunk_idx + replybuflen > ARRAY_SIZE(msg->chunk))
+		return false;
+
 	memcpy(&msg->chunk[msg->curchunk_idx], replybuf, replybuflen);
 	msg->curchunk_idx += replybuflen;
 
@@ -788,6 +794,9 @@ static bool drm_dp_sideband_append_payload(struct drm_dp_sideband_msg_rx *msg,
 			print_hex_dump(KERN_DEBUG, "wrong crc",
 				       DUMP_PREFIX_NONE, 16, 1,
 				       msg->chunk,  msg->curchunk_len, false);
+		/* Guard against accumulated msg[] overflow */
+		if (msg->curlen + msg->curchunk_len - 1 > ARRAY_SIZE(msg->msg))
+			return false;
 		/* copy chunk into bigger msg */
 		memcpy(&msg->msg[msg->curlen], msg->chunk, msg->curchunk_len - 1);
 		msg->curlen += msg->curchunk_len - 1;
@@ -859,7 +868,7 @@ static bool drm_dp_sideband_parse_remote_dpcd_read(struct drm_dp_sideband_msg_rx
 		goto fail_len;
 	repmsg->u.remote_dpcd_read_ack.num_bytes = raw->msg[idx];
 	idx++;
-	if (idx > raw->curlen)
+	if (idx + repmsg->u.remote_dpcd_read_ack.num_bytes > raw->curlen)
 		goto fail_len;
 
 	memcpy(repmsg->u.remote_dpcd_read_ack.bytes, &raw->msg[idx], repmsg->u.remote_dpcd_read_ack.num_bytes);
@@ -895,7 +904,9 @@ static bool drm_dp_sideband_parse_remote_i2c_read_ack(struct drm_dp_sideband_msg
 		goto fail_len;
 	repmsg->u.remote_i2c_read_ack.num_bytes = raw->msg[idx];
 	idx++;
-	/* TODO check */
+	if (idx + repmsg->u.remote_i2c_read_ack.num_bytes > raw->curlen)
+		goto fail_len;
+
 	memcpy(repmsg->u.remote_i2c_read_ack.bytes, &raw->msg[idx], repmsg->u.remote_i2c_read_ack.num_bytes);
 	return true;
 fail_len:
@@ -911,16 +922,13 @@ static bool drm_dp_sideband_parse_enum_path_resources_ack(struct drm_dp_sideband
 	repmsg->u.path_resources.port_number = (raw->msg[idx] >> 4) & 0xf;
 	repmsg->u.path_resources.fec_capable = raw->msg[idx] & 0x1;
 	idx++;
-	if (idx > raw->curlen)
+	if (idx + 2 > raw->curlen)
 		goto fail_len;
 	repmsg->u.path_resources.full_payload_bw_number = (raw->msg[idx] << 8) | (raw->msg[idx+1]);
 	idx += 2;
-	if (idx > raw->curlen)
+	if (idx + 2 > raw->curlen)
 		goto fail_len;
 	repmsg->u.path_resources.avail_payload_bw_number = (raw->msg[idx] << 8) | (raw->msg[idx+1]);
-	idx += 2;
-	if (idx > raw->curlen)
-		goto fail_len;
 	return true;
 fail_len:
 	DRM_DEBUG_KMS("enum resource parse length fail %d %d\n", idx, raw->curlen);
@@ -938,12 +946,9 @@ static bool drm_dp_sideband_parse_allocate_payload_ack(struct drm_dp_sideband_ms
 		goto fail_len;
 	repmsg->u.allocate_payload.vcpi = raw->msg[idx];
 	idx++;
-	if (idx > raw->curlen)
+	if (idx + 2 > raw->curlen)
 		goto fail_len;
 	repmsg->u.allocate_payload.allocated_pbn = (raw->msg[idx] << 8) | (raw->msg[idx+1]);
-	idx += 2;
-	if (idx > raw->curlen)
-		goto fail_len;
 	return true;
 fail_len:
 	DRM_DEBUG_KMS("allocate payload parse length fail %d %d\n", idx, raw->curlen);
@@ -957,12 +962,9 @@ static bool drm_dp_sideband_parse_query_payload_ack(struct drm_dp_sideband_msg_r
 
 	repmsg->u.query_payload.port_number = (raw->msg[idx] >> 4) & 0xf;
 	idx++;
-	if (idx > raw->curlen)
+	if (idx + 2 > raw->curlen)
 		goto fail_len;
 	repmsg->u.query_payload.allocated_pbn = (raw->msg[idx] << 8) | (raw->msg[idx + 1]);
-	idx += 2;
-	if (idx > raw->curlen)
-		goto fail_len;
 	return true;
 fail_len:
 	DRM_DEBUG_KMS("query payload parse length fail %d %d\n", idx, raw->curlen);
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
index ddf539f26f2d..9ff895c615df 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
@@ -180,7 +180,7 @@ static int submit_fence_sync(struct etnaviv_gem_submit *submit)
 		struct dma_resv *robj = bo->obj->base.resv;
 
 		if (!(bo->flags & ETNA_SUBMIT_BO_WRITE)) {
-			ret = dma_resv_reserve_shared(robj, 1);
+			ret = dma_resv_reserve_fences(robj, 1);
 			if (ret)
 				return ret;
 		}
diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index 17a8c2e73a82..e16527e74b52 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -1534,9 +1534,10 @@ int hdcp2_authenticate_repeater_topology(struct intel_connector *connector)
 		return -EINVAL;
 	}
 
-	if (seq_num_v < hdcp->seq_num_v) {
-		/* Roll over of the seq_num_v from repeater. Reauthenticate. */
-		drm_dbg_kms(&dev_priv->drm, "Seq_num_v roll over.\n");
+	if (hdcp->hdcp2_encrypted && seq_num_v <= hdcp->seq_num_v) {
+		/* Reauthenticate on Seq_num_v repeat or rollover */
+		drm_dbg_kms(&dev_priv->drm, "Seq_num_v %s\n",
+			    seq_num_v == hdcp->seq_num_v ? "repeat" : "rollover");
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/i915/i915_vma.c b/drivers/gpu/drm/i915/i915_vma.c
index 50a86fd89d00..991dacd28c03 100644
--- a/drivers/gpu/drm/i915/i915_vma.c
+++ b/drivers/gpu/drm/i915/i915_vma.c
@@ -1241,7 +1241,7 @@ int i915_vma_move_to_active(struct i915_vma *vma,
 		obj->write_domain = I915_GEM_DOMAIN_RENDER;
 		obj->read_domains = 0;
 	} else {
-		err = dma_resv_reserve_shared(vma->resv, 1);
+		err = dma_resv_reserve_fences(vma->resv, 1);
 		if (unlikely(err))
 			return err;
 
diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
index 894175f2ed49..9c1a2c2d2bcd 100644
--- a/drivers/gpu/drm/lima/lima_gem.c
+++ b/drivers/gpu/drm/lima/lima_gem.c
@@ -263,7 +263,7 @@ static int lima_gem_sync_bo(struct lima_sched_task *task, struct lima_bo *bo,
 	int err = 0;
 
 	if (!write) {
-		err = dma_resv_reserve_shared(lima_bo_resv(bo), 1);
+		err = dma_resv_reserve_fences(lima_bo_resv(bo), 1);
 		if (err)
 			return err;
 	}
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index c4e5037512b9..817e1c2d7f64 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -230,7 +230,7 @@ static int submit_fence_sync(struct msm_gem_submit *submit, bool no_implicit)
 			 * strange place to call it.  OTOH this is a
 			 * convenient can-fail point to hook it in.
 			 */
-			ret = dma_resv_reserve_shared(msm_obj->base.resv,
+			ret = dma_resv_reserve_fences(msm_obj->base.resv,
 								1);
 			if (ret)
 				return ret;
diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
index d31bf9e49bcd..12e32a061586 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -349,7 +349,7 @@ nouveau_fence_sync(struct nouveau_bo *nvbo, struct nouveau_channel *chan, bool e
 	int ret = 0, i;
 
 	if (!exclusive) {
-		ret = dma_resv_reserve_shared(resv, 1);
+		ret = dma_resv_reserve_fences(resv, 1);
 
 		if (ret)
 			return ret;
diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index b2a475a0ca4a..c157ac9b0849 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -239,7 +239,7 @@ static int qxl_release_validate_bo(struct qxl_bo *bo)
 			return ret;
 	}
 
-	ret = dma_resv_reserve_shared(bo->tbo.base.resv, 1);
+	ret = dma_resv_reserve_fences(bo->tbo.base.resv, 1);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index 32070e94f6c4..eb7c4d162856 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -71,6 +71,7 @@ void radeon_driver_unload_kms(struct drm_device *dev)
 	if (radeon_is_px(dev)) {
 		pm_runtime_get_sync(dev->dev);
 		pm_runtime_forbid(dev->dev);
+		pm_runtime_dont_use_autosuspend(dev->dev);
 	}
 
 	radeon_acpi_fini(rdev);
diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/radeon_vm.c
index cb75ff1f6f2c..75a3f7d41b8e 100644
--- a/drivers/gpu/drm/radeon/radeon_vm.c
+++ b/drivers/gpu/drm/radeon/radeon_vm.c
@@ -831,7 +831,7 @@ static int radeon_vm_update_ptes(struct radeon_device *rdev,
 		int r;
 
 		radeon_sync_resv(rdev, &ib->sync, pt->tbo.base.resv, true);
-		r = dma_resv_reserve_shared(pt->tbo.base.resv, 1);
+		r = dma_resv_reserve_fences(pt->tbo.base.resv, 1);
 		if (r)
 			return r;
 
diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
index 2040dbfed7e2..ab88a53d07c5 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -211,7 +211,6 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
 	struct drm_mode_fb_cmd2 cmd = { 0 };
 	unsigned int bytes_per_pixel;
 	struct drm_framebuffer *fb;
-	unsigned long offset;
 	struct fb_info *info;
 	struct tegra_bo *bo;
 	size_t size;
@@ -257,9 +256,6 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
 
 	drm_fb_helper_fill_info(info, helper, sizes);
 
-	offset = info->var.xoffset * bytes_per_pixel +
-		 info->var.yoffset * fb->pitches[0];
-
 	if (bo->pages) {
 		bo->vaddr = vmap(bo->pages, bo->num_pages, VM_MAP,
 				 pgprot_writecombine(PAGE_KERNEL));
@@ -271,9 +267,9 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
 	}
 
 	drm->mode_config.fb_base = (resource_size_t)bo->iova;
-	info->screen_base = (void __iomem *)bo->vaddr + offset;
+	info->screen_base = (void __iomem *)bo->vaddr;
 	info->screen_size = size;
-	info->fix.smem_start = (unsigned long)(bo->iova + offset);
+	info->fix.smem_start = (unsigned long)(bo->iova);
 	info->fix.smem_len = size;
 
 	return 0;
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 8fe3be20af62..bf9fd5e8a381 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -830,7 +830,7 @@ static int ttm_bo_add_move_fence(struct ttm_buffer_object *bo,
 
 	dma_resv_add_shared_fence(bo->base.resv, fence);
 
-	ret = dma_resv_reserve_shared(bo->base.resv, 1);
+	ret = dma_resv_reserve_fences(bo->base.resv, 1);
 	if (unlikely(ret)) {
 		dma_fence_put(fence);
 		return ret;
@@ -950,7 +950,7 @@ int ttm_bo_mem_space(struct ttm_buffer_object *bo,
 	bool type_found = false;
 	int i, ret;
 
-	ret = dma_resv_reserve_shared(bo->base.resv, 1);
+	ret = dma_resv_reserve_fences(bo->base.resv, 1);
 	if (unlikely(ret))
 		return ret;
 
diff --git a/drivers/gpu/drm/ttm/ttm_execbuf_util.c b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
index 8a8f1a6a83a6..1e22f6ce817a 100644
--- a/drivers/gpu/drm/ttm/ttm_execbuf_util.c
+++ b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
@@ -106,7 +106,7 @@ int ttm_eu_reserve_buffers(struct ww_acquire_ctx *ticket,
 			if (!entry->num_shared)
 				continue;
 
-			ret = dma_resv_reserve_shared(bo->base.resv,
+			ret = dma_resv_reserve_fences(bo->base.resv,
 								entry->num_shared);
 			if (!ret)
 				continue;
@@ -123,7 +123,7 @@ int ttm_eu_reserve_buffers(struct ww_acquire_ctx *ticket,
 		}
 
 		if (!ret && entry->num_shared)
-			ret = dma_resv_reserve_shared(bo->base.resv,
+			ret = dma_resv_reserve_fences(bo->base.resv,
 								entry->num_shared);
 
 		if (unlikely(ret != 0)) {
diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index e4f20b93c33e..82b413ae11ac 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -644,7 +644,7 @@ vc4_lock_bo_reservations(struct drm_device *dev,
 	for (i = 0; i < exec->bo_count; i++) {
 		bo = &exec->bo[i]->base;
 
-		ret = dma_resv_reserve_shared(bo->resv, 1);
+		ret = dma_resv_reserve_fences(bo->resv, 1);
 		if (ret) {
 			vc4_unlock_bo_reservations(dev, exec, acquire_ctx);
 			return ret;
diff --git a/drivers/gpu/drm/vgem/vgem_fence.c b/drivers/gpu/drm/vgem/vgem_fence.c
index f860ff1db648..84b0c73bcf0c 100644
--- a/drivers/gpu/drm/vgem/vgem_fence.c
+++ b/drivers/gpu/drm/vgem/vgem_fence.c
@@ -162,7 +162,7 @@ int vgem_fence_attach_ioctl(struct drm_device *dev,
 	dma_resv_lock(resv, NULL);
 	if (arg->flags & VGEM_FENCE_WRITE)
 		dma_resv_add_excl_fence(resv, fence);
-	else if ((ret = dma_resv_reserve_shared(resv, 1)) == 0)
+	else if ((ret = dma_resv_reserve_fences(resv, 1)) == 0)
 		dma_resv_add_shared_fence(resv, fence);
 	dma_resv_unlock(resv);
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 55c34b4fc3e9..7c4f721621f3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -259,6 +259,7 @@ virtio_gpu_array_from_handles(struct drm_file *drm_file, u32 *handles, u32 nents
 void virtio_gpu_array_add_obj(struct virtio_gpu_object_array *objs,
 			      struct drm_gem_object *obj);
 int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs);
+int virtio_gpu_lock_one_resv_uninterruptible(struct virtio_gpu_object_array *objs);
 void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs);
 void virtio_gpu_array_add_fence(struct virtio_gpu_object_array *objs,
 				struct dma_fence *fence);
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 8502400b2f9c..2fb41be0f3c9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -217,6 +217,23 @@ int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs)
 	return ret;
 }
 
+int virtio_gpu_lock_one_resv_uninterruptible(struct virtio_gpu_object_array *objs)
+{
+	int ret;
+
+	if (objs->nents != 1)
+		return -EINVAL;
+
+	dma_resv_lock(objs->objs[0]->resv, NULL);
+
+	ret = dma_resv_reserve_fences(objs->objs[0]->resv, 1);
+	if (ret) {
+		virtio_gpu_array_unlock_resv(objs);
+		return ret;
+	}
+	return 0;
+}
+
 void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs)
 {
 	if (objs->nents == 1) {
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index e6de62734269..e782b804301c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -260,7 +260,10 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 		if (!objs)
 			return;
 		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
-		virtio_gpu_array_lock_resv(objs);
+		if (virtio_gpu_lock_one_resv_uninterruptible(objs)) {
+			virtio_gpu_array_put_free(objs);
+			return;
+		}
 		virtio_gpu_cmd_transfer_to_host_2d
 			(vgdev, 0,
 			 plane->state->crtc_w,
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index e98a29d243c0..d20ffb314d89 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -329,7 +329,7 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 		if (fence && vbuf->objs)
 			virtio_gpu_array_unlock_resv(vbuf->objs);
 		free_vbuf(vgdev, vbuf);
-		return -1;
+		return -ENODEV;
 	}
 
 	if (vgdev->has_indirect)
@@ -393,7 +393,7 @@ static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 			if (!sgt) {
 				if (fence && vbuf->objs)
 					virtio_gpu_array_unlock_resv(vbuf->objs);
-				return -1;
+				return -ENOMEM;
 			}
 
 			elemcnt += sg_ents;
@@ -724,8 +724,9 @@ static int virtio_get_edid_block(void *data, u8 *buf,
 	struct virtio_gpu_resp_edid *resp = data;
 	size_t start = block * EDID_LENGTH;
 
-	if (start + len > le32_to_cpu(resp->size))
-		return -1;
+	if (start + len > le32_to_cpu(resp->size) ||
+	    start + len > sizeof(resp->edid))
+		return -EINVAL;
 	memcpy(buf, resp->edid + start, len);
 	return 0;
 }
diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
index 11a28609da3c..dd34009c9400 100644
--- a/drivers/hwmon/npcm750-pwm-fan.c
+++ b/drivers/hwmon/npcm750-pwm-fan.c
@@ -360,6 +360,11 @@ static void npcm7xx_fan_polling(struct timer_list *t)
 	add_timer(&data->fan_timer);
 }
 
+static void npcm7xx_fan_cleanup(void *timer)
+{
+	timer_delete_sync(timer);
+}
+
 static inline void npcm7xx_fan_compute(struct npcm7xx_pwm_fan_data *data,
 				       u8 fan, u8 cmp, u8 fan_id, u8 flag_int,
 				       u8 flag_mode, u8 flag_clear)
@@ -1003,6 +1008,12 @@ static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
 				msecs_to_jiffies(NPCM7XX_FAN_POLL_TIMER_200MS);
 			timer_setup(&data->fan_timer,
 				    npcm7xx_fan_polling, 0);
+			ret = devm_add_action_or_reset(dev,
+						       npcm7xx_fan_cleanup,
+						       &data->fan_timer);
+			if (ret)
+				return ret;
+
 			add_timer(&data->fan_timer);
 			break;
 		}
diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index a524d2cd1142..a9cbdd0e2f46 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -789,7 +789,16 @@ static int bcm_iproc_i2c_xfer_wait(struct bcm_iproc_i2c_dev *iproc_i2c,
 	}
 
 	if (!time_left && !iproc_i2c->xfer_is_done) {
-		dev_err(iproc_i2c->device, "transaction timed out\n");
+		/*
+		 * The controller may fail to clear START_BUSY after a timeout,
+		 * reset the controller to recover in that case.
+		 */
+		if (!!(iproc_i2c_rd_reg(iproc_i2c, M_CMD_OFFSET) &
+		       BIT(M_CMD_START_BUSY_SHIFT))) {
+			bcm_iproc_i2c_enable_disable(iproc_i2c, false);
+			bcm_iproc_i2c_init(iproc_i2c);
+			bcm_iproc_i2c_enable_disable(iproc_i2c, true);
+		}
 
 		/* flush both TX/RX FIFOs */
 		val = BIT(M_FIFO_RX_FLUSH_SHIFT) | BIT(M_FIFO_TX_FLUSH_SHIFT);
diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 232a7679b69b..c965a3999698 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -877,13 +877,15 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	adap->nr = pdev->id;
 	r = i2c_add_numbered_adapter(adap);
 	if (r)
-		goto err_unuse_clocks;
+		goto err_cpufreq;
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
 
 	return 0;
 
+err_cpufreq:
+	i2c_davinci_cpufreq_deregister(dev);
 err_unuse_clocks:
 	pm_runtime_dont_use_autosuspend(dev->dev);
 	pm_runtime_put_sync(dev->dev);
diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index b4fb4336b4e8..b9d26a2c9dd9 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -717,6 +717,43 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
 	return i2c_imx_acked(i2c_imx);
 }
 
+static int i2c_imx_prepare_read(struct imx_i2c_struct *i2c_imx,
+				struct i2c_msg *msgs, bool atomic,
+				bool use_dma)
+{
+	int result;
+	unsigned int temp = 0;
+
+	/* write slave address */
+	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
+	result = i2c_imx_trx_complete(i2c_imx, atomic);
+	if (result)
+		return result;
+	result = i2c_imx_acked(i2c_imx);
+	if (result)
+		return result;
+
+	dev_dbg(&i2c_imx->adapter.dev, "<%s> setup bus\n", __func__);
+
+	/* setup bus to read data */
+	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
+	temp &= ~I2CR_MTX;
+
+	/*
+	 * Reset the I2CR_TXAK flag initially for SMBus block read since the
+	 * length is unknown
+	 */
+	if (msgs->len - 1)
+		temp &= ~I2CR_TXAK;
+	if (use_dma)
+		temp |= I2CR_DMAEN;
+
+	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
+	imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR); /* dummy read */
+
+	return 0;
+}
+
 static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
 			struct i2c_msg *msgs, bool is_lastmsg)
 {
@@ -727,6 +764,11 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
 	struct imx_i2c_dma *dma = i2c_imx->dma;
 	struct device *dev = &i2c_imx->adapter.dev;
 
+	result = i2c_imx_prepare_read(i2c_imx, msgs, false, true);
+	if (result)
+		return result;
+
+	dev_dbg(&i2c_imx->adapter.dev, "<%s> read data\n", __func__);
 
 	dma->chan_using = dma->chan_rx;
 	dma->dma_transfer_dir = DMA_DEV_TO_MEM;
@@ -837,50 +879,25 @@ static int i2c_imx_write(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
 	return 0;
 }
 
+static int i2c_imx_atomic_write(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
+{
+	return i2c_imx_write(i2c_imx, msgs, true);
+}
+
 static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
 			bool is_lastmsg, bool atomic)
 {
 	int i, result;
 	unsigned int temp;
 	int block_data = msgs->flags & I2C_M_RECV_LEN;
-	int use_dma = i2c_imx->dma && msgs->flags & I2C_M_DMA_SAFE &&
-		msgs->len >= DMA_THRESHOLD && !block_data;
-
-	dev_dbg(&i2c_imx->adapter.dev,
-		"<%s> write slave address: addr=0x%x\n",
-		__func__, i2c_8bit_addr_from_msg(msgs));
+	int block_err = 0;
 
-	/* write slave address */
-	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
-	result = i2c_imx_trx_complete(i2c_imx, atomic);
+	result = i2c_imx_prepare_read(i2c_imx, msgs, atomic, false);
 	if (result)
 		return result;
-	result = i2c_imx_acked(i2c_imx);
-	if (result)
-		return result;
-
-	dev_dbg(&i2c_imx->adapter.dev, "<%s> setup bus\n", __func__);
-
-	/* setup bus to read data */
-	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
-	temp &= ~I2CR_MTX;
-
-	/*
-	 * Reset the I2CR_TXAK flag initially for SMBus block read since the
-	 * length is unknown
-	 */
-	if ((msgs->len - 1) || block_data)
-		temp &= ~I2CR_TXAK;
-	if (use_dma)
-		temp |= I2CR_DMAEN;
-	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
-	imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR); /* dummy read */
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> read data\n", __func__);
 
-	if (use_dma)
-		return i2c_imx_dma_read(i2c_imx, msgs, is_lastmsg);
-
 	/* read data */
 	for (i = 0; i < msgs->len; i++) {
 		u8 len = 0;
@@ -895,8 +912,20 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
 		 */
 		if ((!i) && block_data) {
 			len = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
-			if ((len == 0) || (len > I2C_SMBUS_BLOCK_MAX))
-				return -EPROTO;
+			if ((len == 0) || (len > I2C_SMBUS_BLOCK_MAX)) {
+				/*
+				 * SMBus 3.1 6.5.7: support count byte of 0.
+				 * I2C_SMBUS_BLOCK_MAX case should not hold the SDA either.
+				 */
+				if (len > I2C_SMBUS_BLOCK_MAX)
+					block_err = -EPROTO;
+				temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
+				temp |= I2CR_TXAK;
+				imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
+				msgs->buf[0] = 0;
+				msgs->len = 2;
+				continue;
+			}
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> read length: 0x%X\n",
 				__func__, len);
@@ -944,7 +973,13 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
 			"<%s> read byte: B%d=0x%X\n",
 			__func__, i, msgs->buf[i]);
 	}
-	return 0;
+	return block_err;
+}
+
+static int i2c_imx_atomic_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
+			       bool is_lastmsg)
+{
+	return i2c_imx_read(i2c_imx, msgs, is_lastmsg, true);
 }
 
 static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
@@ -954,6 +989,7 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
 	int result;
 	bool is_lastmsg = false;
 	struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(adapter);
+	int use_dma = 0;
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
 
@@ -1008,15 +1044,25 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
 			(temp & I2SR_SRW ? 1 : 0), (temp & I2SR_IIF ? 1 : 0),
 			(temp & I2SR_RXAK ? 1 : 0));
 #endif
+
+		use_dma = i2c_imx->dma && msgs[i].len >= DMA_THRESHOLD &&
+			msgs[i].flags & I2C_M_DMA_SAFE;
 		if (msgs[i].flags & I2C_M_RD) {
-			result = i2c_imx_read(i2c_imx, &msgs[i], is_lastmsg, atomic);
+			int block_data = msgs->flags & I2C_M_RECV_LEN;
+
+			if (atomic)
+				result = i2c_imx_atomic_read(i2c_imx, &msgs[i], is_lastmsg);
+			else if (use_dma && !block_data)
+				result = i2c_imx_dma_read(i2c_imx, &msgs[i], is_lastmsg);
+			else
+				result = i2c_imx_read(i2c_imx, &msgs[i], is_lastmsg, false);
 		} else {
-			if (!atomic &&
-			    i2c_imx->dma && msgs[i].len >= DMA_THRESHOLD &&
-				msgs[i].flags & I2C_M_DMA_SAFE)
+			if (atomic)
+				result = i2c_imx_atomic_write(i2c_imx, &msgs[i]);
+			else if (use_dma)
 				result = i2c_imx_dma_write(i2c_imx, &msgs[i]);
 			else
-				result = i2c_imx_write(i2c_imx, &msgs[i], atomic);
+				result = i2c_imx_write(i2c_imx, &msgs[i], false);
 		}
 		if (result)
 			goto fail0;
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index cf7c91df21d5..2fa62d3ec43f 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1478,7 +1478,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 		goto err_put_adap;
 	}
 
-	res = of_i2c_setup_smbus_alert(adap);
+	res = i2c_setup_smbus_alert(adap);
 	if (res)
 		goto out_reg;
 
diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index f5c9787992e9..14a21359f116 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/i2c-smbus.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 #include "i2c-core.h"
@@ -699,13 +700,17 @@ struct i2c_client *i2c_new_smbus_alert_device(struct i2c_adapter *adapter,
 }
 EXPORT_SYMBOL_GPL(i2c_new_smbus_alert_device);
 
-#if IS_ENABLED(CONFIG_I2C_SMBUS) && IS_ENABLED(CONFIG_OF)
-int of_i2c_setup_smbus_alert(struct i2c_adapter *adapter)
+#if IS_ENABLED(CONFIG_I2C_SMBUS)
+int i2c_setup_smbus_alert(struct i2c_adapter *adapter)
 {
+	struct device *parent = adapter->dev.parent;
 	int irq;
 
-	irq = of_property_match_string(adapter->dev.of_node, "interrupt-names",
-				       "smbus_alert");
+	/* Adapter instantiated without parent, skip the SMBus alert setup */
+	if (!parent)
+		return 0;
+
+	irq = device_property_match_string(parent, "interrupt-names", "smbus_alert");
 	if (irq == -EINVAL || irq == -ENODATA)
 		return 0;
 	else if (irq < 0)
@@ -713,5 +718,5 @@ int of_i2c_setup_smbus_alert(struct i2c_adapter *adapter)
 
 	return PTR_ERR_OR_ZERO(i2c_new_smbus_alert_device(adapter, NULL));
 }
-EXPORT_SYMBOL_GPL(of_i2c_setup_smbus_alert);
+EXPORT_SYMBOL_GPL(i2c_setup_smbus_alert);
 #endif
diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index 44582cf29e16..cacdadb9415c 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -13,7 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_irq.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
@@ -178,7 +178,8 @@ static int smbalert_probe(struct i2c_client *ara,
 	if (setup) {
 		irq = setup->irq;
 	} else {
-		irq = of_irq_get_byname(adapter->dev.of_node, "smbus_alert");
+		irq = fwnode_irq_get_byname(dev_fwnode(adapter->dev.parent),
+					    "smbus_alert");
 		if (irq <= 0)
 			return irq;
 	}
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index bb19bbc56441..0558ea8f874c 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -258,8 +258,9 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 	/* WR will fail with length error
 	 * if this is 0
 	 */
-	if (unlikely(plist->length == 0)) {
-		rtrs_err(s, "Invalid RDMA-Write sg list length 0\n");
+	if (unlikely(plist->length == 0 || plist->length > max_chunk_size)) {
+		rtrs_err(s, "Invalid RDMA-Write sg list length %u\n",
+			 plist->length);
 		return -EINVAL;
 	}
 
diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index 9f7ba41a947b..b9fd6d3be99f 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -161,6 +161,9 @@ void iforce_process_packet(struct iforce *iforce,
 	switch (packet_id) {
 
 	case 0x01:	/* joystick position data */
+		if (len < 7)
+			break;
+
 		input_report_abs(dev, ABS_X,
 				 (__s16) get_unaligned_le16(data));
 		input_report_abs(dev, ABS_Y,
@@ -176,6 +179,9 @@ void iforce_process_packet(struct iforce *iforce,
 		break;
 
 	case 0x03:	/* wheel position data */
+		if (len < 7)
+			break;
+
 		input_report_abs(dev, ABS_WHEEL,
 				 (__s16) get_unaligned_le16(data));
 		input_report_abs(dev, ABS_GAS,   255 - data[2]);
@@ -187,6 +193,9 @@ void iforce_process_packet(struct iforce *iforce,
 		break;
 
 	case 0x02:	/* status report */
+		if (len < 2)
+			break;
+
 		input_report_key(dev, BTN_DEAD, data[0] & 0x02);
 		input_sync(dev);
 
@@ -206,7 +215,7 @@ void iforce_process_packet(struct iforce *iforce,
 			}
 		}
 
-		for (j = 3; j < len; j += 2)
+		for (j = 3; j + sizeof(u16) <= len; j += sizeof(u16))
 			mark_core_as_ready(iforce, get_unaligned_le16(data + j));
 
 		break;
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index cba92bd590a8..927c1378b21a 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -159,6 +159,9 @@ static void iforce_usb_irq(struct urb *urb)
 		goto exit;
 	}
 
+	if (!urb->actual_length)
+		goto exit;
+
 	iforce_process_packet(iforce, iforce_usb->data_in[0],
 			      iforce_usb->data_in + 1, urb->actual_length - 1);
 
diff --git a/drivers/input/joystick/psxpad-spi.c b/drivers/input/joystick/psxpad-spi.c
index a32656064f39..cde33a2ca696 100644
--- a/drivers/input/joystick/psxpad-spi.c
+++ b/drivers/input/joystick/psxpad-spi.c
@@ -366,6 +366,7 @@ static int psxpad_spi_probe(struct spi_device *spi)
 		return err;
 	}
 
+	spi_set_drvdata(spi, pad);
 	pm_runtime_enable(&spi->dev);
 
 	return 0;
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 50199d95919f..baaa40f1efb0 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1954,6 +1954,14 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		/* Xiaomi Book Pro 14 (TM2424) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "XIAOMI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Xiaomi Book Pro 14"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{ }
 };
 
diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 0214c3bb2b09..1df5e773a1f3 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -964,9 +964,10 @@ static int ims_pcu_handle_firmware_update(struct ims_pcu *pcu,
 	return retval;
 }
 
-static void ims_pcu_process_async_firmware(const struct firmware *fw,
+static void ims_pcu_process_async_firmware(const struct firmware *_fw,
 					   void *context)
 {
+	const struct firmware *fw __free(firmware) = _fw;
 	struct ims_pcu *pcu = context;
 	int error;
 
@@ -987,8 +988,6 @@ static void ims_pcu_process_async_firmware(const struct firmware *fw,
 	ims_pcu_handle_firmware_update(pcu, fw);
 	mutex_unlock(&pcu->cmd_mutex);
 
-	release_firmware(fw);
-
 out:
 	complete(&pcu->async_firmware_done);
 }
@@ -1193,6 +1192,8 @@ static ssize_t ims_pcu_reset_device(struct device *dev,
 
 	dev_info(pcu->dev, "Attempting to reset device\n");
 
+	guard(mutex)(&pcu->cmd_mutex);
+
 	error = ims_pcu_execute_command(pcu, PCU_RESET, &reset_byte, 1);
 	if (error) {
 		dev_info(pcu->dev,
diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
index c74b99077d16..2ca5ac1836dd 100644
--- a/drivers/input/mouse/focaltech.c
+++ b/drivers/input/mouse/focaltech.c
@@ -197,7 +197,7 @@ static void focaltech_process_rel_packet(struct psmouse *psmouse,
 {
 	struct focaltech_data *priv = psmouse->private;
 	struct focaltech_hw_state *state = &priv->state;
-	int finger1, finger2;
+	unsigned int finger1, finger2;
 
 	state->pressed = packet[0] >> 7;
 	finger1 = ((packet[0] >> 4) & 0x7) - 1;
diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index 828b7a8c381b..c440ff6d45d6 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -98,7 +98,9 @@ struct f54_data {
 
 	enum rmi_f54_report_type report_type;
 	u8 *report_data;
+	size_t max_report_size;
 	int report_size;
+	int report_error;
 
 	bool is_busy;
 	struct mutex status_mutex;
@@ -333,6 +335,12 @@ static void rmi_f54_buffer_queue(struct vb2_buffer *vb)
 		mutex_lock(&f54->data_mutex);
 	}
 
+	if (f54->report_error) {
+		dev_err(&f54->fn->dev, "Error acquiring report: %d\n", f54->report_error);
+		state = VB2_BUF_STATE_ERROR;
+		goto data_done;
+	}
+
 	ptr = vb2_plane_vaddr(vb, 0);
 	if (!ptr) {
 		dev_err(&f54->fn->dev, "Error acquiring frame ptr\n");
@@ -440,7 +448,12 @@ static int rmi_f54_set_input(struct f54_data *f54, unsigned int i)
 
 static int rmi_f54_vidioc_s_input(struct file *file, void *priv, unsigned int i)
 {
-	return rmi_f54_set_input(video_drvdata(file), i);
+	struct f54_data *f54 = video_drvdata(file);
+
+	if (vb2_is_busy(&f54->queue))
+		return -EBUSY;
+
+	return rmi_f54_set_input(f54, i);
 }
 
 static int rmi_f54_vidioc_g_input(struct file *file, void *priv,
@@ -541,7 +554,14 @@ static void rmi_f54_work(struct work_struct *work)
 		dev_err(&fn->dev, "Bad report size, report type=%d\n",
 				f54->report_type);
 		error = -EINVAL;
-		goto error;     /* retry won't help */
+		goto out;     /* retry won't help */
+	}
+
+	if (report_size > f54->max_report_size) {
+		dev_err(&fn->dev, "Report size %d exceeds buffer size %zu\n",
+			report_size, f54->max_report_size);
+		error = -EINVAL;
+		goto out;
 	}
 
 	/*
@@ -552,7 +572,7 @@ static void rmi_f54_work(struct work_struct *work)
 			 &command);
 	if (error) {
 		dev_err(&fn->dev, "Failed to read back command\n");
-		goto error;
+		goto out;
 	}
 	if (command & F54_GET_REPORT) {
 		if (time_after(jiffies, f54->timeout)) {
@@ -560,7 +580,7 @@ static void rmi_f54_work(struct work_struct *work)
 			error = -ETIMEDOUT;
 		}
 		report_size = 0;
-		goto error;
+		goto out;
 	}
 
 	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "Get report command completed, reading data\n");
@@ -575,7 +595,7 @@ static void rmi_f54_work(struct work_struct *work)
 					fifo, sizeof(fifo));
 		if (error) {
 			dev_err(&fn->dev, "Failed to set fifo start offset\n");
-			goto abort;
+			goto out;
 		}
 
 		error = rmi_read_block(fn->rmi_dev, fn->fd.data_base_addr +
@@ -584,16 +604,17 @@ static void rmi_f54_work(struct work_struct *work)
 		if (error) {
 			dev_err(&fn->dev, "%s: read [%d bytes] returned %d\n",
 				__func__, size, error);
-			goto abort;
+			goto out;
 		}
 	}
 
-abort:
-	f54->report_size = error ? 0 : report_size;
-error:
+out:
 	if (error)
 		report_size = 0;
 
+	f54->report_size = report_size;
+	f54->report_error = error;
+
 	if (report_size == 0 && !error) {
 		queue_delayed_work(f54->workqueue, &f54->work,
 				   msecs_to_jiffies(1));
@@ -674,8 +695,8 @@ static int rmi_f54_probe(struct rmi_function *fn)
 
 	rx = f54->num_rx_electrodes;
 	tx = f54->num_tx_electrodes;
-	f54->report_data = devm_kzalloc(&fn->dev,
-					array3_size(tx, rx, sizeof(u16)),
+	f54->max_report_size = array3_size(tx, rx, sizeof(u16));
+	f54->report_data = devm_kzalloc(&fn->dev, f54->max_report_size,
 					GFP_KERNEL);
 	if (f54->report_data == NULL)
 		return -ENOMEM;
diff --git a/drivers/input/rmi4/rmi_f55.c b/drivers/input/rmi4/rmi_f55.c
index 488adaca4dd0..a0877d32a914 100644
--- a/drivers/input/rmi4/rmi_f55.c
+++ b/drivers/input/rmi4/rmi_f55.c
@@ -54,10 +54,10 @@ static int rmi_f55_detect(struct rmi_function *fn)
 	f55->num_tx_electrodes = f55->qry[F55_NUM_TX_OFFSET];
 
 	f55->cfg_num_rx_electrodes = f55->num_rx_electrodes;
-	f55->cfg_num_tx_electrodes = f55->num_rx_electrodes;
+	f55->cfg_num_tx_electrodes = f55->num_tx_electrodes;
 
 	drv_data->num_rx_electrodes = f55->cfg_num_rx_electrodes;
-	drv_data->num_tx_electrodes = f55->cfg_num_rx_electrodes;
+	drv_data->num_tx_electrodes = f55->cfg_num_tx_electrodes;
 
 	if (f55->qry[F55_PHYS_CHAR_OFFSET] & F55_CAP_SENSOR_ASSIGN) {
 		int i, total;
diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 0b129c245d9e..97e80aa10a9d 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -209,6 +209,12 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 	if (packet_size <= 0)
 		goto out;
 
+	if (packet_size > sizeof(touch)) {
+		dev_err(&data->client->dev, "Invalid packet size %d (max %zu)\n",
+			packet_size, sizeof(touch));
+		goto out;
+	}
+
 	touch_size = packet_size / MMS114_PACKET_NUM;
 
 	error = __mms114_read_reg(data, MMS114_INFORMATION, packet_size,
diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 12f2562b0141..3ab20b2a54e2 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -725,21 +725,13 @@ static int sur40_probe(struct usb_interface *interface,
 		goto err_free_input;
 	}
 
-	/* register the polled input device */
-	error = input_register_device(input);
-	if (error) {
-		dev_err(&interface->dev,
-			"Unable to register polled input device.");
-		goto err_free_buffer;
-	}
-
 	/* register the video master device */
 	snprintf(sur40->v4l2.name, sizeof(sur40->v4l2.name), "%s", DRIVER_LONG);
 	error = v4l2_device_register(sur40->dev, &sur40->v4l2);
 	if (error) {
 		dev_err(&interface->dev,
 			"Unable to register video master device.");
-		goto err_unreg_v4l2;
+		goto err_free_buffer;
 	}
 
 	/* initialize the lock and subdevice */
@@ -795,6 +787,14 @@ static int sur40_probe(struct usb_interface *interface,
 	if (error) {
 		dev_err(&interface->dev,
 			"Unable to register video subdevice.");
+		goto err_free_ctrl;
+	}
+
+	/* register the polled input device */
+	error = input_register_device(input);
+	if (error) {
+		dev_err(&interface->dev,
+			"Unable to register polled input device.");
 		goto err_unreg_video;
 	}
 
@@ -806,6 +806,8 @@ static int sur40_probe(struct usb_interface *interface,
 
 err_unreg_video:
 	video_unregister_device(&sur40->vdev);
+err_free_ctrl:
+	v4l2_ctrl_handler_free(&sur40->hdl);
 err_unreg_v4l2:
 	v4l2_device_unregister(&sur40->v4l2);
 err_free_buffer:
@@ -823,11 +825,12 @@ static void sur40_disconnect(struct usb_interface *interface)
 {
 	struct sur40_state *sur40 = usb_get_intfdata(interface);
 
+	input_unregister_device(sur40->input);
+
 	v4l2_ctrl_handler_free(&sur40->hdl);
 	video_unregister_device(&sur40->vdev);
 	v4l2_device_unregister(&sur40->v4l2);
 
-	input_unregister_device(sur40->input);
 	kfree(sur40->bulk_in_buffer);
 	kfree(sur40);
 
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 227ed3b46873..eb13b98ba0a9 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1377,10 +1377,6 @@ static int dm_integrity_rw_tag(struct dm_integrity_c *ic, unsigned char *tag, se
 			*metadata_offset = 0;
 		}
 
-		if (unlikely(!is_power_of_2(ic->tag_size))) {
-			hash_offset = (hash_offset + to_copy) % ic->tag_size;
-		}
-
 		total_size -= to_copy;
 	} while (unlikely(total_size));
 
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 21ef7168cc0b..926a8c990163 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -217,14 +217,16 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
 	char *envp[] = { verity_env, NULL };
 	const char *type_str = "";
 	struct mapped_device *md = dm_table_get_md(v->ti->table);
+	int ce;
 
 	/* Corruption should be visible in device status in all modes */
 	v->hash_failed = 1;
 
-	if (v->corrupted_errs >= DM_VERITY_MAX_CORRUPTED_ERRS)
-		goto out;
-
-	v->corrupted_errs++;
+	ce = atomic_read(&v->corrupted_errs);
+	do {
+		if (ce >= DM_VERITY_MAX_CORRUPTED_ERRS)
+			goto out;
+	} while (!atomic_try_cmpxchg(&v->corrupted_errs, &ce, ce + 1));
 
 	switch (type) {
 	case DM_VERITY_BLOCK_TYPE_DATA:
@@ -240,7 +242,7 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
 	DMERR_LIMIT("%s: %s block %llu is corrupted", v->data_dev->name,
 		    type_str, block);
 
-	if (v->corrupted_errs == DM_VERITY_MAX_CORRUPTED_ERRS)
+	if (ce + 1 == DM_VERITY_MAX_CORRUPTED_ERRS)
 		DMERR("%s: reached maximum errors", v->data_dev->name);
 
 	snprintf(verity_env, DM_VERITY_ENV_LENGTH, "%s=%d,%llu",
diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
index f61c89c79cf5..ad5104daddb5 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -55,7 +55,7 @@ struct dm_verity {
 	unsigned int ahash_reqsize;/* the size of temporary space for crypto */
 	int hash_failed;	/* set to 1 if hash of any block failed */
 	enum verity_mode mode;	/* mode for handling verification errors */
-	unsigned corrupted_errs;/* Number of errors for corrupted blocks */
+	atomic_t corrupted_errs;/* Number of errors for corrupted blocks */
 
 	struct workqueue_struct *verify_wq;
 
diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index fa2e4cca0268..fc68810d591e 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -47,22 +47,6 @@
 
 #define IMX219_DEFAULT_LINK_FREQ	456000000
 
-/* V_TIMING internal */
-#define IMX219_REG_VTS			0x0160
-#define IMX219_VTS_15FPS		0x0dc6
-#define IMX219_VTS_30FPS_1080P		0x06e3
-#define IMX219_VTS_30FPS_BINNED		0x06e3
-#define IMX219_VTS_30FPS_640x480	0x06e3
-#define IMX219_VTS_MAX			0xffff
-
-#define IMX219_VBLANK_MIN		4
-
-/*Frame Length Line*/
-#define IMX219_FLL_MIN			0x08a6
-#define IMX219_FLL_MAX			0xffff
-#define IMX219_FLL_STEP			1
-#define IMX219_FLL_DEFAULT		0x0c98
-
 /* HBLANK control - read only */
 #define IMX219_PPL_DEFAULT		3448
 
@@ -87,6 +71,11 @@
 #define IMX219_DGTL_GAIN_DEFAULT	0x0100
 #define IMX219_DGTL_GAIN_STEP		1
 
+/* V_TIMING internal */
+#define IMX219_REG_FRM_LENGTH_A		0x0160
+#define IMX219_FLL_MAX			0xfffe
+#define IMX219_VBLANK_MIN		32
+
 #define IMX219_REG_ORIENTATION		0x0172
 
 /* Binning  Mode */
@@ -145,7 +134,7 @@ struct imx219_mode {
 	struct v4l2_rect crop;
 
 	/* V-timing */
-	unsigned int vts_def;
+	unsigned int fll_def;
 
 	/* Default register values */
 	struct imx219_reg_list reg_list;
@@ -382,7 +371,7 @@ static const struct imx219_mode supported_modes[] = {
 			.width = 3280,
 			.height = 2464
 		},
-		.vts_def = IMX219_VTS_15FPS,
+		.fll_def = 3526,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_3280x2464_regs),
 			.regs = mode_3280x2464_regs,
@@ -399,7 +388,7 @@ static const struct imx219_mode supported_modes[] = {
 			.width = 1920,
 			.height = 1080
 		},
-		.vts_def = IMX219_VTS_30FPS_1080P,
+		.fll_def = 1763,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_1920_1080_regs),
 			.regs = mode_1920_1080_regs,
@@ -416,7 +405,7 @@ static const struct imx219_mode supported_modes[] = {
 			.width = 3280,
 			.height = 2464
 		},
-		.vts_def = IMX219_VTS_30FPS_BINNED,
+		.fll_def = 1763,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_1640_1232_regs),
 			.regs = mode_1640_1232_regs,
@@ -433,7 +422,7 @@ static const struct imx219_mode supported_modes[] = {
 			.width = 1280,
 			.height = 960
 		},
-		.vts_def = IMX219_VTS_30FPS_640x480,
+		.fll_def = 1763,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_640_480_regs),
 			.regs = mode_640_480_regs,
@@ -670,7 +659,7 @@ static int imx219_set_ctrl(struct v4l2_ctrl *ctrl)
 				       imx219->vflip->val << 1);
 		break;
 	case V4L2_CID_VBLANK:
-		ret = imx219_write_reg(imx219, IMX219_REG_VTS,
+		ret = imx219_write_reg(imx219, IMX219_REG_FRM_LENGTH_A,
 				       IMX219_REG_VALUE_16BIT,
 				       imx219->mode->height + ctrl->val);
 		break;
@@ -829,12 +818,12 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 		imx219->mode = mode;
 		/* Update limits and set FPS to default */
 		__v4l2_ctrl_modify_range(imx219->vblank, IMX219_VBLANK_MIN,
-					 IMX219_VTS_MAX - mode->height, 1,
-					 mode->vts_def - mode->height);
+					 IMX219_FLL_MAX - mode->height, 1,
+					 mode->fll_def - mode->height);
 		__v4l2_ctrl_s_ctrl(imx219->vblank,
-				   mode->vts_def - mode->height);
+				   mode->fll_def - mode->height);
 		/* Update max exposure while meeting expected vblanking */
-		exposure_max = mode->vts_def - 4;
+		exposure_max = mode->fll_def - 4;
 		exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
 			exposure_max : IMX219_EXPOSURE_DEFAULT;
 		__v4l2_ctrl_modify_range(imx219->exposure,
@@ -1246,15 +1235,15 @@ static int imx219_init_controls(struct imx219 *imx219)
 	/* Initial vblank/hblank/exposure parameters based on current mode */
 	imx219->vblank = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
 					   V4L2_CID_VBLANK, IMX219_VBLANK_MIN,
-					   IMX219_VTS_MAX - height, 1,
-					   imx219->mode->vts_def - height);
+					   IMX219_FLL_MAX - height, 1,
+					   imx219->mode->fll_def - height);
 	hblank = IMX219_PPL_DEFAULT - imx219->mode->width;
 	imx219->hblank = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
 					   V4L2_CID_HBLANK, hblank, hblank,
 					   1, hblank);
 	if (imx219->hblank)
 		imx219->hblank->flags |= V4L2_CTRL_FLAG_READ_ONLY;
-	exposure_max = imx219->mode->vts_def - 4;
+	exposure_max = imx219->mode->fll_def - 4;
 	exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
 		exposure_max : IMX219_EXPOSURE_DEFAULT;
 	imx219->exposure = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 9d9124308f6a..56fe20ba8041 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -1724,6 +1724,7 @@ static int aspeed_video_probe(struct platform_device *pdev)
 	rc = aspeed_video_setup_video(video);
 	if (rc) {
 		aspeed_video_free_buf(video, &video->jpeg);
+		of_reserved_mem_device_release(&pdev->dev);
 		clk_unprepare(video->vclk);
 		clk_unprepare(video->eclk);
 		return rc;
diff --git a/drivers/media/platform/marvell-ccic/cafe-driver.c b/drivers/media/platform/marvell-ccic/cafe-driver.c
index 00f623d62c96..062155ccfe91 100644
--- a/drivers/media/platform/marvell-ccic/cafe-driver.c
+++ b/drivers/media/platform/marvell-ccic/cafe-driver.c
@@ -600,6 +600,7 @@ static void cafe_pci_remove(struct pci_dev *pdev)
 		return;
 	}
 	cafe_shutdown(cam);
+	pci_disable_device(pdev);
 	kfree(cam);
 }
 
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c
index d8e66b645bd8..199a64c853bc 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c
@@ -65,6 +65,11 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(struct mtk_vcodec_dev *dev)
 	}
 
 	fw = devm_kzalloc(&dev->plat_dev->dev, sizeof(*fw), GFP_KERNEL);
+	if (!fw) {
+		scp_put(scp);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	fw->type = SCP;
 	fw->ops = &mtk_vcodec_rproc_msg;
 	fw->scp = scp;
diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 33babe6e8b3a..fc741182f2d9 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -747,7 +747,7 @@ v4l2_async_notifier_add_devname_subdev(struct v4l2_async_notifier *notifier,
 }
 EXPORT_SYMBOL_GPL(v4l2_async_notifier_add_devname_subdev);
 
-int v4l2_async_register_subdev(struct v4l2_subdev *sd)
+int __v4l2_async_register_subdev(struct v4l2_subdev *sd, struct module *module)
 {
 	struct v4l2_async_notifier *subdev_notifier;
 	struct v4l2_async_notifier *notifier;
@@ -761,6 +761,8 @@ int v4l2_async_register_subdev(struct v4l2_subdev *sd)
 	if (!sd->fwnode && sd->dev)
 		sd->fwnode = dev_fwnode(sd->dev);
 
+	sd->owner = module;
+
 	mutex_lock(&list_lock);
 
 	INIT_LIST_HEAD(&sd->async_list);
@@ -811,9 +813,11 @@ int v4l2_async_register_subdev(struct v4l2_subdev *sd)
 
 	mutex_unlock(&list_lock);
 
+	sd->owner = NULL;
+
 	return ret;
 }
-EXPORT_SYMBOL(v4l2_async_register_subdev);
+EXPORT_SYMBOL(__v4l2_async_register_subdev);
 
 void v4l2_async_unregister_subdev(struct v4l2_subdev *sd)
 {
diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 1977ce0195fe..754ee332f689 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -1337,7 +1337,8 @@ int v4l2_async_notifier_parse_fwnode_sensor_common(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(v4l2_async_notifier_parse_fwnode_sensor_common);
 
-int v4l2_async_register_subdev_sensor_common(struct v4l2_subdev *sd)
+int __v4l2_async_register_subdev_sensor_common(struct v4l2_subdev *sd,
+					       struct module *module)
 {
 	struct v4l2_async_notifier *notifier;
 	int ret;
@@ -1360,7 +1361,7 @@ int v4l2_async_register_subdev_sensor_common(struct v4l2_subdev *sd)
 	if (ret < 0)
 		goto out_cleanup;
 
-	ret = v4l2_async_register_subdev(sd);
+	ret = __v4l2_async_register_subdev(sd, module);
 	if (ret < 0)
 		goto out_unregister;
 
@@ -1377,7 +1378,7 @@ int v4l2_async_register_subdev_sensor_common(struct v4l2_subdev *sd)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(v4l2_async_register_subdev_sensor_common);
+EXPORT_SYMBOL_GPL(__v4l2_async_register_subdev_sensor_common);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Sakari Ailus <sakari.ailus@linux.intel.com>");
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 098075449ccd..d4613ddb54b8 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1363,7 +1363,7 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host *host, struct mmc_request *req)
 	if (req->data == NULL) {
 		OMAP_HSMMC_WRITE(host->base, BLK, 0);
 		if (req->cmd->flags & MMC_RSP_BUSY) {
-			timeout = req->cmd->busy_timeout * NSEC_PER_MSEC;
+			timeout = (u64)req->cmd->busy_timeout * NSEC_PER_MSEC;
 
 			/*
 			 * Set an arbitrary 100ms data timeout for commands with
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f3b481fa777c..a9d5d64eb01f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4103,6 +4103,14 @@ void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
 }
 EXPORT_SYMBOL_GPL(__sdhci_read_caps);
 
+static void sdhci_unmap_bounce_buffer(void *data)
+{
+	struct sdhci_host *host = data;
+
+	dma_unmap_single(mmc_dev(host->mmc), host->bounce_addr,
+			 host->bounce_buffer_size, DMA_BIDIRECTIONAL);
+}
+
 static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
@@ -4153,6 +4161,14 @@ static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 		/* Again fall back to max_segs == 1 */
 		return;
 	host->bounce_buffer_size = bounce_size;
+	ret = devm_add_action_or_reset(mmc_dev(mmc),
+				       sdhci_unmap_bounce_buffer, host);
+	if (ret) {
+		devm_kfree(mmc_dev(mmc), host->bounce_buffer);
+		host->bounce_buffer = NULL;
+		host->bounce_buffer_size = 0;
+		return;
+	}
 
 	/* Lie about this since we're bouncing */
 	mmc->max_segs = max_blocks;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index a188bf241a11..721785db9632 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -594,7 +594,7 @@ struct sdhci_host {
 
 	unsigned int		tuning_count;	/* Timer count for re-tuning */
 	unsigned int		tuning_mode;	/* Re-tuning mode supported by host */
-	unsigned int		tuning_err;	/* Error code for re-tuning */
+	int			tuning_err;	/* Error code for re-tuning */
 #define SDHCI_TUNING_MODE_1	0
 #define SDHCI_TUNING_MODE_2	1
 #define SDHCI_TUNING_MODE_3	2
diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 38024cc2d5e0..a3f285d3253f 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2116,19 +2116,19 @@ static int vub300_probe(struct usb_interface *interface,
 	command_out_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!command_out_urb) {
 		retval = -ENOMEM;
-		goto error0;
+		goto err_put_udev;
 	}
 	command_res_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!command_res_urb) {
 		retval = -ENOMEM;
-		goto error1;
+		goto err_free_out_urb;
 	}
 	/* this also allocates memory for our VUB300 mmc host device */
 	mmc = mmc_alloc_host(sizeof(struct vub300_mmc_host), &udev->dev);
 	if (!mmc) {
 		retval = -ENOMEM;
 		dev_err(&udev->dev, "not enough memory for the mmc_host\n");
-		goto error4;
+		goto err_free_res_urb;
 	}
 	/* MMC core transfer sizes tunable parameters */
 	mmc->caps = 0;
@@ -2281,7 +2281,7 @@ static int vub300_probe(struct usb_interface *interface,
 		dev_err(&vub300->udev->dev,
 		    "Could not find two sets of bulk-in/out endpoint pairs\n");
 		retval = -EINVAL;
-		goto error5;
+		goto err_free_host;
 	}
 	retval =
 		usb_control_msg(vub300->udev, usb_rcvctrlpipe(vub300->udev, 0),
@@ -2290,14 +2290,14 @@ static int vub300_probe(struct usb_interface *interface,
 				0x0000, 0x0000, &vub300->hc_info,
 				sizeof(vub300->hc_info), 1000);
 	if (retval < 0)
-		goto error5;
+		goto err_free_host;
 	retval =
 		usb_control_msg(vub300->udev, usb_sndctrlpipe(vub300->udev, 0),
 				SET_ROM_WAIT_STATES,
 				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 				firmware_rom_wait_states, 0x0000, NULL, 0, 1000);
 	if (retval < 0)
-		goto error5;
+		goto err_free_host;
 	dev_info(&vub300->udev->dev,
 		 "operating_mode = %s %s %d MHz %s %d byte USB packets\n",
 		 (mmc->caps & MMC_CAP_SDIO_IRQ) ? "IRQs" : "POLL",
@@ -2312,7 +2312,7 @@ static int vub300_probe(struct usb_interface *interface,
 				0x0000, 0x0000, &vub300->system_port_status,
 				sizeof(vub300->system_port_status), 1000);
 	if (retval < 0) {
-		goto error5;
+		goto err_free_host;
 	} else if (sizeof(vub300->system_port_status) == retval) {
 		vub300->card_present =
 			(0x0001 & vub300->system_port_status.port_flags) ? 1 : 0;
@@ -2320,7 +2320,7 @@ static int vub300_probe(struct usb_interface *interface,
 			(0x0010 & vub300->system_port_status.port_flags) ? 1 : 0;
 	} else {
 		retval = -EINVAL;
-		goto error5;
+		goto err_free_host;
 	}
 	usb_set_intfdata(interface, vub300);
 	INIT_DELAYED_WORK(&vub300->pollwork, vub300_pollwork_thread);
@@ -2345,23 +2345,29 @@ static int vub300_probe(struct usb_interface *interface,
 			 interface_to_InterfaceNumber(interface));
 	retval = mmc_add_host(mmc);
 	if (retval)
-		goto error6;
+		goto err_stop_io;
 
 	return 0;
-error6:
-	del_timer_sync(&vub300->inactivity_timer);
-error5:
+
+err_stop_io:
+	vub300->interface = NULL;
+	kref_put(&vub300->kref, vub300_delete);
+
+	return retval;
+
+err_free_host:
 	mmc_free_host(mmc);
 	/*
 	 * and hence also frees vub300
 	 * which is contained at the end of struct mmc
 	 */
-error4:
+err_free_res_urb:
 	usb_free_urb(command_res_urb);
-error1:
+err_free_out_urb:
 	usb_free_urb(command_out_urb);
-error0:
+err_put_udev:
 	usb_put_dev(udev);
+
 	return retval;
 }
 
diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
index f96a165fccc7..ad10f7887dfa 100644
--- a/drivers/mtd/maps/vmu-flash.c
+++ b/drivers/mtd/maps/vmu-flash.c
@@ -610,7 +610,7 @@ static int vmu_connect(struct maple_device *mdev)
 
 	basic_flash_data = be32_to_cpu(mdev->devinfo.function_data[c - 1]);
 
-	card = kmalloc(sizeof(struct memcard), GFP_KERNEL);
+	card = kzalloc_obj(struct memcard);
 	if (!card) {
 		error = -ENOMEM;
 		goto fail_nomem;
@@ -628,15 +628,13 @@ static int vmu_connect(struct maple_device *mdev)
 	* Not sure there are actually any multi-partition devices in the
 	* real world, but the hardware supports them, so, so will we
 	*/
-	card->parts = kmalloc_array(card->partitions, sizeof(struct vmupart),
-				    GFP_KERNEL);
+	card->parts = kzalloc_objs(struct vmupart, card->partitions);
 	if (!card->parts) {
 		error = -ENOMEM;
 		goto fail_partitions;
 	}
 
-	card->mtd = kmalloc_array(card->partitions, sizeof(struct mtd_info),
-				  GFP_KERNEL);
+	card->mtd = kzalloc_objs(struct mtd_info, card->partitions);
 	if (!card->mtd) {
 		error = -ENOMEM;
 		goto fail_mtd_info;
diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 653923896205..da05b03f28d2 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-spi-nor-objs			:= core.o sfdp.o
+spi-nor-objs			:= core.o sfdp.o swp.o
 spi-nor-objs			+= atmel.o
 spi-nor-objs			+= catalyst.o
 spi-nor-objs			+= eon.o
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 09e112f37691..1312b72712a5 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -276,7 +276,7 @@ int spi_nor_write_disable(struct spi_nor *nor)
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
+int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
 {
 	int ret;
 
@@ -1550,376 +1550,6 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 	return ret;
 }
 
-static u8 spi_nor_get_sr_bp_mask(struct spi_nor *nor)
-{
-	u8 mask = SR_BP2 | SR_BP1 | SR_BP0;
-
-	if (nor->flags & SNOR_F_HAS_SR_BP3_BIT6)
-		return mask | SR_BP3_BIT6;
-
-	if (nor->flags & SNOR_F_HAS_4BIT_BP)
-		return mask | SR_BP3;
-
-	return mask;
-}
-
-static u8 spi_nor_get_sr_tb_mask(struct spi_nor *nor)
-{
-	if (nor->flags & SNOR_F_HAS_SR_TB_BIT6)
-		return SR_TB_BIT6;
-	else
-		return SR_TB_BIT5;
-}
-
-static u64 spi_nor_get_min_prot_length_sr(struct spi_nor *nor)
-{
-	unsigned int bp_slots, bp_slots_needed;
-	u8 mask = spi_nor_get_sr_bp_mask(nor);
-
-	/* Reserved one for "protect none" and one for "protect all". */
-	bp_slots = (1 << hweight8(mask)) - 2;
-	bp_slots_needed = ilog2(nor->info->n_sectors);
-
-	if (bp_slots_needed > bp_slots)
-		return nor->info->sector_size <<
-			(bp_slots_needed - bp_slots);
-	else
-		return nor->info->sector_size;
-}
-
-static void spi_nor_get_locked_range_sr(struct spi_nor *nor, u8 sr, loff_t *ofs,
-					uint64_t *len)
-{
-	struct mtd_info *mtd = &nor->mtd;
-	u64 min_prot_len;
-	u8 mask = spi_nor_get_sr_bp_mask(nor);
-	u8 tb_mask = spi_nor_get_sr_tb_mask(nor);
-	u8 bp, val = sr & mask;
-
-	if (nor->flags & SNOR_F_HAS_SR_BP3_BIT6 && val & SR_BP3_BIT6)
-		val = (val & ~SR_BP3_BIT6) | SR_BP3;
-
-	bp = val >> SR_BP_SHIFT;
-
-	if (!bp) {
-		/* No protection */
-		*ofs = 0;
-		*len = 0;
-		return;
-	}
-
-	min_prot_len = spi_nor_get_min_prot_length_sr(nor);
-	*len = min_prot_len << (bp - 1);
-
-	if (*len > mtd->size)
-		*len = mtd->size;
-
-	if (nor->flags & SNOR_F_HAS_SR_TB && sr & tb_mask)
-		*ofs = 0;
-	else
-		*ofs = mtd->size - *len;
-}
-
-/*
- * Return 1 if the entire region is locked (if @locked is true) or unlocked (if
- * @locked is false); 0 otherwise
- */
-static int spi_nor_check_lock_status_sr(struct spi_nor *nor, loff_t ofs,
-					uint64_t len, u8 sr, bool locked)
-{
-	loff_t lock_offs;
-	uint64_t lock_len;
-
-	if (!len)
-		return 1;
-
-	spi_nor_get_locked_range_sr(nor, sr, &lock_offs, &lock_len);
-
-	if (locked)
-		/* Requested range is a sub-range of locked range */
-		return (ofs + len <= lock_offs + lock_len) && (ofs >= lock_offs);
-	else
-		/* Requested range does not overlap with locked range */
-		return (ofs >= lock_offs + lock_len) || (ofs + len <= lock_offs);
-}
-
-static int spi_nor_is_locked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
-				u8 sr)
-{
-	return spi_nor_check_lock_status_sr(nor, ofs, len, sr, true);
-}
-
-static int spi_nor_is_unlocked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
-				  u8 sr)
-{
-	return spi_nor_check_lock_status_sr(nor, ofs, len, sr, false);
-}
-
-/*
- * Lock a region of the flash. Compatible with ST Micro and similar flash.
- * Supports the block protection bits BP{0,1,2}/BP{0,1,2,3} in the status
- * register
- * (SR). Does not support these features found in newer SR bitfields:
- *   - SEC: sector/block protect - only handle SEC=0 (block protect)
- *   - CMP: complement protect - only support CMP=0 (range is not complemented)
- *
- * Support for the following is provided conditionally for some flash:
- *   - TB: top/bottom protect
- *
- * Sample table portion for 8MB flash (Winbond w25q64fw):
- *
- *   SEC  |  TB   |  BP2  |  BP1  |  BP0  |  Prot Length  | Protected Portion
- *  --------------------------------------------------------------------------
- *    X   |   X   |   0   |   0   |   0   |  NONE         | NONE
- *    0   |   0   |   0   |   0   |   1   |  128 KB       | Upper 1/64
- *    0   |   0   |   0   |   1   |   0   |  256 KB       | Upper 1/32
- *    0   |   0   |   0   |   1   |   1   |  512 KB       | Upper 1/16
- *    0   |   0   |   1   |   0   |   0   |  1 MB         | Upper 1/8
- *    0   |   0   |   1   |   0   |   1   |  2 MB         | Upper 1/4
- *    0   |   0   |   1   |   1   |   0   |  4 MB         | Upper 1/2
- *    X   |   X   |   1   |   1   |   1   |  8 MB         | ALL
- *  ------|-------|-------|-------|-------|---------------|-------------------
- *    0   |   1   |   0   |   0   |   1   |  128 KB       | Lower 1/64
- *    0   |   1   |   0   |   1   |   0   |  256 KB       | Lower 1/32
- *    0   |   1   |   0   |   1   |   1   |  512 KB       | Lower 1/16
- *    0   |   1   |   1   |   0   |   0   |  1 MB         | Lower 1/8
- *    0   |   1   |   1   |   0   |   1   |  2 MB         | Lower 1/4
- *    0   |   1   |   1   |   1   |   0   |  4 MB         | Lower 1/2
- *
- * Returns negative on errors, 0 on success.
- */
-static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
-{
-	struct mtd_info *mtd = &nor->mtd;
-	u64 min_prot_len;
-	int ret, status_old, status_new;
-	u8 mask = spi_nor_get_sr_bp_mask(nor);
-	u8 tb_mask = spi_nor_get_sr_tb_mask(nor);
-	u8 pow, val;
-	loff_t lock_len;
-	bool can_be_top = true, can_be_bottom = nor->flags & SNOR_F_HAS_SR_TB;
-	bool use_top;
-
-	ret = spi_nor_read_sr(nor, nor->bouncebuf);
-	if (ret)
-		return ret;
-
-	status_old = nor->bouncebuf[0];
-
-	/* If nothing in our range is unlocked, we don't need to do anything */
-	if (spi_nor_is_locked_sr(nor, ofs, len, status_old))
-		return 0;
-
-	/* If anything below us is unlocked, we can't use 'bottom' protection */
-	if (!spi_nor_is_locked_sr(nor, 0, ofs, status_old))
-		can_be_bottom = false;
-
-	/* If anything above us is unlocked, we can't use 'top' protection */
-	if (!spi_nor_is_locked_sr(nor, ofs + len, mtd->size - (ofs + len),
-				  status_old))
-		can_be_top = false;
-
-	if (!can_be_bottom && !can_be_top)
-		return -EINVAL;
-
-	/* Prefer top, if both are valid */
-	use_top = can_be_top;
-
-	/* lock_len: length of region that should end up locked */
-	if (use_top)
-		lock_len = mtd->size - ofs;
-	else
-		lock_len = ofs + len;
-
-	if (lock_len == mtd->size) {
-		val = mask;
-	} else {
-		min_prot_len = spi_nor_get_min_prot_length_sr(nor);
-		pow = ilog2(lock_len) - ilog2(min_prot_len) + 1;
-		val = pow << SR_BP_SHIFT;
-
-		if (nor->flags & SNOR_F_HAS_SR_BP3_BIT6 && val & SR_BP3)
-			val = (val & ~SR_BP3) | SR_BP3_BIT6;
-
-		if (val & ~mask)
-			return -EINVAL;
-
-		/* Don't "lock" with no region! */
-		if (!(val & mask))
-			return -EINVAL;
-	}
-
-	status_new = (status_old & ~mask & ~tb_mask) | val;
-
-	/* Disallow further writes if WP pin is asserted */
-	status_new |= SR_SRWD;
-
-	if (!use_top)
-		status_new |= tb_mask;
-
-	/* Don't bother if they're the same */
-	if (status_new == status_old)
-		return 0;
-
-	/* Only modify protection if it will not unlock other areas */
-	if ((status_new & mask) < (status_old & mask))
-		return -EINVAL;
-
-	return spi_nor_write_sr_and_check(nor, status_new);
-}
-
-/*
- * Unlock a region of the flash. See spi_nor_sr_lock() for more info
- *
- * Returns negative on errors, 0 on success.
- */
-static int spi_nor_sr_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
-{
-	struct mtd_info *mtd = &nor->mtd;
-	u64 min_prot_len;
-	int ret, status_old, status_new;
-	u8 mask = spi_nor_get_sr_bp_mask(nor);
-	u8 tb_mask = spi_nor_get_sr_tb_mask(nor);
-	u8 pow, val;
-	loff_t lock_len;
-	bool can_be_top = true, can_be_bottom = nor->flags & SNOR_F_HAS_SR_TB;
-	bool use_top;
-
-	ret = spi_nor_read_sr(nor, nor->bouncebuf);
-	if (ret)
-		return ret;
-
-	status_old = nor->bouncebuf[0];
-
-	/* If nothing in our range is locked, we don't need to do anything */
-	if (spi_nor_is_unlocked_sr(nor, ofs, len, status_old))
-		return 0;
-
-	/* If anything below us is locked, we can't use 'top' protection */
-	if (!spi_nor_is_unlocked_sr(nor, 0, ofs, status_old))
-		can_be_top = false;
-
-	/* If anything above us is locked, we can't use 'bottom' protection */
-	if (!spi_nor_is_unlocked_sr(nor, ofs + len, mtd->size - (ofs + len),
-				    status_old))
-		can_be_bottom = false;
-
-	if (!can_be_bottom && !can_be_top)
-		return -EINVAL;
-
-	/* Prefer top, if both are valid */
-	use_top = can_be_top;
-
-	/* lock_len: length of region that should remain locked */
-	if (use_top)
-		lock_len = mtd->size - (ofs + len);
-	else
-		lock_len = ofs;
-
-	if (lock_len == 0) {
-		val = 0; /* fully unlocked */
-	} else {
-		min_prot_len = spi_nor_get_min_prot_length_sr(nor);
-		pow = ilog2(lock_len) - ilog2(min_prot_len) + 1;
-		val = pow << SR_BP_SHIFT;
-
-		if (nor->flags & SNOR_F_HAS_SR_BP3_BIT6 && val & SR_BP3)
-			val = (val & ~SR_BP3) | SR_BP3_BIT6;
-
-		/* Some power-of-two sizes are not supported */
-		if (val & ~mask)
-			return -EINVAL;
-	}
-
-	status_new = (status_old & ~mask & ~tb_mask) | val;
-
-	/* Don't protect status register if we're fully unlocked */
-	if (lock_len == 0)
-		status_new &= ~SR_SRWD;
-
-	if (!use_top)
-		status_new |= tb_mask;
-
-	/* Don't bother if they're the same */
-	if (status_new == status_old)
-		return 0;
-
-	/* Only modify protection if it will not lock other areas */
-	if ((status_new & mask) > (status_old & mask))
-		return -EINVAL;
-
-	return spi_nor_write_sr_and_check(nor, status_new);
-}
-
-/*
- * Check if a region of the flash is (completely) locked. See spi_nor_sr_lock()
- * for more info.
- *
- * Returns 1 if entire region is locked, 0 if any portion is unlocked, and
- * negative on errors.
- */
-static int spi_nor_sr_is_locked(struct spi_nor *nor, loff_t ofs, uint64_t len)
-{
-	int ret;
-
-	ret = spi_nor_read_sr(nor, nor->bouncebuf);
-	if (ret)
-		return ret;
-
-	return spi_nor_is_locked_sr(nor, ofs, len, nor->bouncebuf[0]);
-}
-
-static const struct spi_nor_locking_ops spi_nor_sr_locking_ops = {
-	.lock = spi_nor_sr_lock,
-	.unlock = spi_nor_sr_unlock,
-	.is_locked = spi_nor_sr_is_locked,
-};
-
-static int spi_nor_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
-{
-	struct spi_nor *nor = mtd_to_spi_nor(mtd);
-	int ret;
-
-	ret = spi_nor_lock_and_prep(nor);
-	if (ret)
-		return ret;
-
-	ret = nor->params->locking_ops->lock(nor, ofs, len);
-
-	spi_nor_unlock_and_unprep(nor);
-	return ret;
-}
-
-static int spi_nor_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
-{
-	struct spi_nor *nor = mtd_to_spi_nor(mtd);
-	int ret;
-
-	ret = spi_nor_lock_and_prep(nor);
-	if (ret)
-		return ret;
-
-	ret = nor->params->locking_ops->unlock(nor, ofs, len);
-
-	spi_nor_unlock_and_unprep(nor);
-	return ret;
-}
-
-static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
-{
-	struct spi_nor *nor = mtd_to_spi_nor(mtd);
-	int ret;
-
-	ret = spi_nor_lock_and_prep(nor);
-	if (ret)
-		return ret;
-
-	ret = nor->params->locking_ops->is_locked(nor, ofs, len);
-
-	spi_nor_unlock_and_unprep(nor);
-	return ret;
-}
-
 /**
  * spi_nor_sr1_bit6_quad_enable() - Set the Quad Enable BIT(6) in the Status
  * Register 1.
@@ -2858,7 +2488,7 @@ static void spi_nor_late_init_params(struct spi_nor *nor)
 	 * the default ones.
 	 */
 	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params->locking_ops)
-		nor->params->locking_ops = &spi_nor_sr_locking_ops;
+		spi_nor_init_default_locking_ops(nor);
 }
 
 /**
@@ -2937,30 +2567,6 @@ static int spi_nor_quad_enable(struct spi_nor *nor)
 	return nor->params->quad_enable(nor);
 }
 
-/**
- * spi_nor_try_unlock_all() - Tries to unlock the entire flash memory array.
- * @nor:	pointer to a 'struct spi_nor'.
- *
- * Some SPI NOR flashes are write protected by default after a power-on reset
- * cycle, in order to avoid inadvertent writes during power-up. Backward
- * compatibility imposes to unlock the entire flash memory array at power-up
- * by default.
- *
- * Unprotecting the entire flash array will fail for boards which are hardware
- * write-protected. Thus any errors are ignored.
- */
-static void spi_nor_try_unlock_all(struct spi_nor *nor)
-{
-	int ret;
-
-	if (!(nor->flags & SNOR_F_HAS_LOCK))
-		return;
-
-	ret = spi_nor_unlock(&nor->mtd, 0, nor->params->size);
-	if (ret)
-		dev_dbg(nor->dev, "Failed to unlock the entire flash memory array\n");
-}
-
 static int spi_nor_init(struct spi_nor *nor)
 {
 	int err;
@@ -3212,12 +2818,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	mtd->_get_device = spi_nor_get_device;
 	mtd->_put_device = spi_nor_put_device;
 
-	if (nor->params->locking_ops) {
-		mtd->_lock = spi_nor_lock;
-		mtd->_unlock = spi_nor_unlock;
-		mtd->_is_locked = spi_nor_is_locked;
-	}
-
 	if (info->flags & USE_FSR)
 		nor->flags |= SNOR_F_USE_FSR;
 	if (info->flags & SPI_NOR_HAS_TB) {
@@ -3264,6 +2864,8 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	if (ret)
 		return ret;
 
+	spi_nor_register_locking_ops(nor);
+
 	/* Send all the required SPI flash commands to initialize device */
 	ret = spi_nor_init(nor);
 	if (ret)
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 788775bb6795..ae59600138c5 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -409,6 +409,7 @@ void spi_nor_unlock_and_unprep(struct spi_nor *nor);
 int spi_nor_sr1_bit6_quad_enable(struct spi_nor *nor);
 int spi_nor_sr2_bit1_quad_enable(struct spi_nor *nor);
 int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor);
+int spi_nor_read_sr(struct spi_nor *nor, u8 *sr);
 int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 sr1);
 
 int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr);
@@ -435,6 +436,10 @@ int spi_nor_post_bfpt_fixups(struct spi_nor *nor,
 			     const struct sfdp_bfpt *bfpt,
 			     struct spi_nor_flash_parameter *params);
 
+void spi_nor_init_default_locking_ops(struct spi_nor *nor);
+void spi_nor_try_unlock_all(struct spi_nor *nor);
+void spi_nor_register_locking_ops(struct spi_nor *nor);
+
 static struct spi_nor __maybe_unused *mtd_to_spi_nor(struct mtd_info *mtd)
 {
 	return mtd->priv;
diff --git a/drivers/mtd/spi-nor/intel.c b/drivers/mtd/spi-nor/intel.c
index d8196f101368..6c31bef3fc60 100644
--- a/drivers/mtd/spi-nor/intel.c
+++ b/drivers/mtd/spi-nor/intel.c
@@ -10,23 +10,13 @@
 
 static const struct flash_info intel_parts[] = {
 	/* Intel/Numonyx -- xxxs33b */
-	{ "160s33b",  INFO(0x898911, 0, 64 * 1024,  32, 0) },
-	{ "320s33b",  INFO(0x898912, 0, 64 * 1024,  64, 0) },
-	{ "640s33b",  INFO(0x898913, 0, 64 * 1024, 128, 0) },
-};
-
-static void intel_default_init(struct spi_nor *nor)
-{
-	nor->flags |= SNOR_F_HAS_LOCK;
-}
-
-static const struct spi_nor_fixups intel_fixups = {
-	.default_init = intel_default_init,
+	{ "160s33b",  INFO(0x898911, 0, 64 * 1024,  32, SPI_NOR_HAS_LOCK) },
+	{ "320s33b",  INFO(0x898912, 0, 64 * 1024,  64, SPI_NOR_HAS_LOCK) },
+	{ "640s33b",  INFO(0x898913, 0, 64 * 1024, 128, SPI_NOR_HAS_LOCK) },
 };
 
 const struct spi_nor_manufacturer spi_nor_intel = {
 	.name = "intel",
 	.parts = intel_parts,
 	.nparts = ARRAY_SIZE(intel_parts),
-	.fixups = &intel_fixups,
 };
diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 777c8225f5bd..2fd2a162ab3b 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -11,27 +11,27 @@
 static const struct flash_info sst_parts[] = {
 	/* SST -- large erase sizes are "overlays", "sectors" are 4K */
 	{ "sst25vf040b", INFO(0xbf258d, 0, 64 * 1024,  8,
-			      SECT_4K | SST_WRITE) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
 	{ "sst25vf080b", INFO(0xbf258e, 0, 64 * 1024, 16,
-			      SECT_4K | SST_WRITE) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
 	{ "sst25vf016b", INFO(0xbf2541, 0, 64 * 1024, 32,
-			      SECT_4K | SST_WRITE) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
 	{ "sst25vf032b", INFO(0xbf254a, 0, 64 * 1024, 64,
-			      SECT_4K | SST_WRITE) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
 	{ "sst25vf064c", INFO(0xbf254b, 0, 64 * 1024, 128,
-			      SECT_4K | SPI_NOR_4BIT_BP) },
+			      SECT_4K | SPI_NOR_4BIT_BP | SPI_NOR_HAS_LOCK) },
 	{ "sst25wf512",  INFO(0xbf2501, 0, 64 * 1024,  1,
-			      SECT_4K | SST_WRITE) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
 	{ "sst25wf010",  INFO(0xbf2502, 0, 64 * 1024,  2,
-			      SECT_4K | SST_WRITE) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
 	{ "sst25wf020",  INFO(0xbf2503, 0, 64 * 1024,  4,
-			      SECT_4K | SST_WRITE) },
-	{ "sst25wf020a", INFO(0x621612, 0, 64 * 1024,  4, SECT_4K) },
-	{ "sst25wf040b", INFO(0x621613, 0, 64 * 1024,  8, SECT_4K) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
+	{ "sst25wf020a", INFO(0x621612, 0, 64 * 1024,  4, SECT_4K | SPI_NOR_HAS_LOCK) },
+	{ "sst25wf040b", INFO(0x621613, 0, 64 * 1024,  8, SECT_4K | SPI_NOR_HAS_LOCK) },
 	{ "sst25wf040",  INFO(0xbf2504, 0, 64 * 1024,  8,
-			      SECT_4K | SST_WRITE) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
 	{ "sst25wf080",  INFO(0xbf2505, 0, 64 * 1024, 16,
-			      SECT_4K | SST_WRITE) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
 	{ "sst26wf016b", INFO(0xbf2651, 0, 64 * 1024, 32,
 			      SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
@@ -141,11 +141,6 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 	return ret;
 }
 
-static void sst_default_init(struct spi_nor *nor)
-{
-	nor->flags |= SNOR_F_HAS_LOCK;
-}
-
 static void sst_post_sfdp_fixups(struct spi_nor *nor)
 {
 	if (nor->info->flags & SST_WRITE)
@@ -153,7 +148,6 @@ static void sst_post_sfdp_fixups(struct spi_nor *nor)
 }
 
 static const struct spi_nor_fixups sst_fixups = {
-	.default_init = sst_default_init,
 	.post_sfdp = sst_post_sfdp_fixups,
 };
 
diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
new file mode 100644
index 000000000000..8aca0203a621
--- /dev/null
+++ b/drivers/mtd/spi-nor/swp.c
@@ -0,0 +1,426 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SPI NOR Software Write Protection logic.
+ *
+ * Copyright (C) 2005, Intec Automation Inc.
+ * Copyright (C) 2014, Freescale Semiconductor, Inc.
+ */
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/spi-nor.h>
+
+#include "core.h"
+
+static u8 spi_nor_get_sr_bp_mask(struct spi_nor *nor)
+{
+	u8 mask = SR_BP2 | SR_BP1 | SR_BP0;
+
+	if (nor->flags & SNOR_F_HAS_SR_BP3_BIT6)
+		return mask | SR_BP3_BIT6;
+
+	if (nor->flags & SNOR_F_HAS_4BIT_BP)
+		return mask | SR_BP3;
+
+	return mask;
+}
+
+static u8 spi_nor_get_sr_tb_mask(struct spi_nor *nor)
+{
+	if (nor->flags & SNOR_F_HAS_SR_TB_BIT6)
+		return SR_TB_BIT6;
+	else
+		return SR_TB_BIT5;
+}
+
+static u64 spi_nor_get_min_prot_length_sr(struct spi_nor *nor)
+{
+	unsigned int bp_slots, bp_slots_needed;
+	u8 mask = spi_nor_get_sr_bp_mask(nor);
+
+	/* Reserved one for "protect none" and one for "protect all". */
+	bp_slots = (1 << hweight8(mask)) - 2;
+	bp_slots_needed = ilog2(nor->info->n_sectors);
+
+	if (bp_slots_needed > bp_slots)
+		return nor->info->sector_size <<
+			(bp_slots_needed - bp_slots);
+	else
+		return nor->info->sector_size;
+}
+
+static void spi_nor_get_locked_range_sr(struct spi_nor *nor, u8 sr, loff_t *ofs,
+					uint64_t *len)
+{
+	u64 min_prot_len;
+	u8 mask = spi_nor_get_sr_bp_mask(nor);
+	u8 tb_mask = spi_nor_get_sr_tb_mask(nor);
+	u8 bp, val = sr & mask;
+
+	if (nor->flags & SNOR_F_HAS_SR_BP3_BIT6 && val & SR_BP3_BIT6)
+		val = (val & ~SR_BP3_BIT6) | SR_BP3;
+
+	bp = val >> SR_BP_SHIFT;
+
+	if (!bp) {
+		/* No protection */
+		*ofs = 0;
+		*len = 0;
+		return;
+	}
+
+	min_prot_len = spi_nor_get_min_prot_length_sr(nor);
+	*len = min_prot_len << (bp - 1);
+
+	if (*len > nor->params->size)
+		*len = nor->params->size;
+
+	if (nor->flags & SNOR_F_HAS_SR_TB && sr & tb_mask)
+		*ofs = 0;
+	else
+		*ofs = nor->params->size - *len;
+}
+
+/*
+ * Return 1 if the entire region is locked (if @locked is true) or unlocked (if
+ * @locked is false); 0 otherwise
+ */
+static int spi_nor_check_lock_status_sr(struct spi_nor *nor, loff_t ofs,
+					uint64_t len, u8 sr, bool locked)
+{
+	loff_t lock_offs;
+	uint64_t lock_len;
+
+	if (!len)
+		return 1;
+
+	spi_nor_get_locked_range_sr(nor, sr, &lock_offs, &lock_len);
+
+	if (locked)
+		/* Requested range is a sub-range of locked range */
+		return (ofs + len <= lock_offs + lock_len) && (ofs >= lock_offs);
+	else
+		/* Requested range does not overlap with locked range */
+		return (ofs >= lock_offs + lock_len) || (ofs + len <= lock_offs);
+}
+
+static int spi_nor_is_locked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
+				u8 sr)
+{
+	return spi_nor_check_lock_status_sr(nor, ofs, len, sr, true);
+}
+
+static int spi_nor_is_unlocked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
+				  u8 sr)
+{
+	return spi_nor_check_lock_status_sr(nor, ofs, len, sr, false);
+}
+
+/*
+ * Lock a region of the flash. Compatible with ST Micro and similar flash.
+ * Supports the block protection bits BP{0,1,2}/BP{0,1,2,3} in the status
+ * register
+ * (SR). Does not support these features found in newer SR bitfields:
+ *   - SEC: sector/block protect - only handle SEC=0 (block protect)
+ *   - CMP: complement protect - only support CMP=0 (range is not complemented)
+ *
+ * Support for the following is provided conditionally for some flash:
+ *   - TB: top/bottom protect
+ *
+ * Sample table portion for 8MB flash (Winbond w25q64fw):
+ *
+ *   SEC  |  TB   |  BP2  |  BP1  |  BP0  |  Prot Length  | Protected Portion
+ *  --------------------------------------------------------------------------
+ *    X   |   X   |   0   |   0   |   0   |  NONE         | NONE
+ *    0   |   0   |   0   |   0   |   1   |  128 KB       | Upper 1/64
+ *    0   |   0   |   0   |   1   |   0   |  256 KB       | Upper 1/32
+ *    0   |   0   |   0   |   1   |   1   |  512 KB       | Upper 1/16
+ *    0   |   0   |   1   |   0   |   0   |  1 MB         | Upper 1/8
+ *    0   |   0   |   1   |   0   |   1   |  2 MB         | Upper 1/4
+ *    0   |   0   |   1   |   1   |   0   |  4 MB         | Upper 1/2
+ *    X   |   X   |   1   |   1   |   1   |  8 MB         | ALL
+ *  ------|-------|-------|-------|-------|---------------|-------------------
+ *    0   |   1   |   0   |   0   |   1   |  128 KB       | Lower 1/64
+ *    0   |   1   |   0   |   1   |   0   |  256 KB       | Lower 1/32
+ *    0   |   1   |   0   |   1   |   1   |  512 KB       | Lower 1/16
+ *    0   |   1   |   1   |   0   |   0   |  1 MB         | Lower 1/8
+ *    0   |   1   |   1   |   0   |   1   |  2 MB         | Lower 1/4
+ *    0   |   1   |   1   |   1   |   0   |  4 MB         | Lower 1/2
+ *
+ * Returns negative on errors, 0 on success.
+ */
+static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	u64 min_prot_len;
+	int ret, status_old, status_new;
+	u8 mask = spi_nor_get_sr_bp_mask(nor);
+	u8 tb_mask = spi_nor_get_sr_tb_mask(nor);
+	u8 pow, val;
+	loff_t lock_len;
+	bool can_be_top = true, can_be_bottom = nor->flags & SNOR_F_HAS_SR_TB;
+	bool use_top;
+
+	ret = spi_nor_read_sr(nor, nor->bouncebuf);
+	if (ret)
+		return ret;
+
+	status_old = nor->bouncebuf[0];
+
+	/* If nothing in our range is unlocked, we don't need to do anything */
+	if (spi_nor_is_locked_sr(nor, ofs, len, status_old))
+		return 0;
+
+	/* If anything below us is unlocked, we can't use 'bottom' protection */
+	if (!spi_nor_is_locked_sr(nor, 0, ofs, status_old))
+		can_be_bottom = false;
+
+	/* If anything above us is unlocked, we can't use 'top' protection */
+	if (!spi_nor_is_locked_sr(nor, ofs + len, nor->params->size - (ofs + len),
+				  status_old))
+		can_be_top = false;
+
+	if (!can_be_bottom && !can_be_top)
+		return -EINVAL;
+
+	/* Prefer top, if both are valid */
+	use_top = can_be_top;
+
+	/* lock_len: length of region that should end up locked */
+	if (use_top)
+		lock_len = nor->params->size - ofs;
+	else
+		lock_len = ofs + len;
+
+	if (lock_len == nor->params->size) {
+		val = mask;
+	} else {
+		min_prot_len = spi_nor_get_min_prot_length_sr(nor);
+		pow = ilog2(lock_len) - ilog2(min_prot_len) + 1;
+		val = pow << SR_BP_SHIFT;
+
+		if (nor->flags & SNOR_F_HAS_SR_BP3_BIT6 && val & SR_BP3)
+			val = (val & ~SR_BP3) | SR_BP3_BIT6;
+
+		if (val & ~mask)
+			return -EINVAL;
+
+		/* Don't "lock" with no region! */
+		if (!(val & mask))
+			return -EINVAL;
+	}
+
+	status_new = (status_old & ~mask & ~tb_mask) | val;
+
+	/* Disallow further writes if WP pin is asserted */
+	status_new |= SR_SRWD;
+
+	if (!use_top)
+		status_new |= tb_mask;
+
+	/* Don't bother if they're the same */
+	if (status_new == status_old)
+		return 0;
+
+	/* Only modify protection if it will not unlock other areas */
+	if ((status_new & mask) < (status_old & mask))
+		return -EINVAL;
+
+	return spi_nor_write_sr_and_check(nor, status_new);
+}
+
+/*
+ * Unlock a region of the flash. See spi_nor_sr_lock() for more info
+ *
+ * Returns negative on errors, 0 on success.
+ */
+static int spi_nor_sr_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	u64 min_prot_len;
+	int ret, status_old, status_new;
+	u8 mask = spi_nor_get_sr_bp_mask(nor);
+	u8 tb_mask = spi_nor_get_sr_tb_mask(nor);
+	u8 pow, val;
+	loff_t lock_len;
+	bool can_be_top = true, can_be_bottom = nor->flags & SNOR_F_HAS_SR_TB;
+	bool use_top;
+
+	ret = spi_nor_read_sr(nor, nor->bouncebuf);
+	if (ret)
+		return ret;
+
+	status_old = nor->bouncebuf[0];
+
+	/* If nothing in our range is locked, we don't need to do anything */
+	if (spi_nor_is_unlocked_sr(nor, ofs, len, status_old))
+		return 0;
+
+	/* If anything below us is locked, we can't use 'top' protection */
+	if (!spi_nor_is_unlocked_sr(nor, 0, ofs, status_old))
+		can_be_top = false;
+
+	/* If anything above us is locked, we can't use 'bottom' protection */
+	if (!spi_nor_is_unlocked_sr(nor, ofs + len, nor->params->size - (ofs + len),
+				    status_old))
+		can_be_bottom = false;
+
+	if (!can_be_bottom && !can_be_top)
+		return -EINVAL;
+
+	/* Prefer top, if both are valid */
+	use_top = can_be_top;
+
+	/*
+	 * lock_len: length of region that should remain locked.
+	 *
+	 * When can_be_top and can_be_bottom booleans are true, both adjacent
+	 * regions are unlocked, thus the entire flash can be unlocked.
+	 */
+	if (can_be_top && can_be_bottom)
+		lock_len = 0;
+	else if (use_top)
+		lock_len = nor->params->size - (ofs + len);
+	else
+		lock_len = ofs;
+
+	if (lock_len == 0) {
+		val = 0; /* fully unlocked */
+	} else {
+		min_prot_len = spi_nor_get_min_prot_length_sr(nor);
+		pow = ilog2(lock_len) - ilog2(min_prot_len) + 1;
+		val = pow << SR_BP_SHIFT;
+
+		if (nor->flags & SNOR_F_HAS_SR_BP3_BIT6 && val & SR_BP3)
+			val = (val & ~SR_BP3) | SR_BP3_BIT6;
+
+		/* Some power-of-two sizes are not supported */
+		if (val & ~mask)
+			return -EINVAL;
+	}
+
+	status_new = (status_old & ~mask & ~tb_mask) | val;
+
+	/* Don't protect status register if we're fully unlocked */
+	if (lock_len == 0)
+		status_new &= ~SR_SRWD;
+
+	if (!use_top)
+		status_new |= tb_mask;
+
+	/* Don't bother if they're the same */
+	if (status_new == status_old)
+		return 0;
+
+	/* Only modify protection if it will not lock other areas */
+	if ((status_new & mask) > (status_old & mask))
+		return -EINVAL;
+
+	return spi_nor_write_sr_and_check(nor, status_new);
+}
+
+/*
+ * Check if a region of the flash is (completely) locked. See spi_nor_sr_lock()
+ * for more info.
+ *
+ * Returns 1 if entire region is locked, 0 if any portion is unlocked, and
+ * negative on errors.
+ */
+static int spi_nor_sr_is_locked(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	int ret;
+
+	ret = spi_nor_read_sr(nor, nor->bouncebuf);
+	if (ret)
+		return ret;
+
+	return spi_nor_is_locked_sr(nor, ofs, len, nor->bouncebuf[0]);
+}
+
+static const struct spi_nor_locking_ops spi_nor_sr_locking_ops = {
+	.lock = spi_nor_sr_lock,
+	.unlock = spi_nor_sr_unlock,
+	.is_locked = spi_nor_sr_is_locked,
+};
+
+void spi_nor_init_default_locking_ops(struct spi_nor *nor)
+{
+	nor->params->locking_ops = &spi_nor_sr_locking_ops;
+}
+
+static int spi_nor_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	int ret;
+
+	ret = spi_nor_lock_and_prep(nor);
+	if (ret)
+		return ret;
+
+	ret = nor->params->locking_ops->lock(nor, ofs, len);
+
+	spi_nor_unlock_and_unprep(nor);
+	return ret;
+}
+
+static int spi_nor_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	int ret;
+
+	ret = spi_nor_lock_and_prep(nor);
+	if (ret)
+		return ret;
+
+	ret = nor->params->locking_ops->unlock(nor, ofs, len);
+
+	spi_nor_unlock_and_unprep(nor);
+	return ret;
+}
+
+static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	int ret;
+
+	ret = spi_nor_lock_and_prep(nor);
+	if (ret)
+		return ret;
+
+	ret = nor->params->locking_ops->is_locked(nor, ofs, len);
+
+	spi_nor_unlock_and_unprep(nor);
+	return ret;
+}
+
+/**
+ * spi_nor_try_unlock_all() - Tries to unlock the entire flash memory array.
+ * @nor:	pointer to a 'struct spi_nor'.
+ *
+ * Some SPI NOR flashes are write protected by default after a power-on reset
+ * cycle, in order to avoid inadvertent writes during power-up. Backward
+ * compatibility imposes to unlock the entire flash memory array at power-up
+ * by default.
+ *
+ * Unprotecting the entire flash array will fail for boards which are hardware
+ * write-protected. Thus any errors are ignored.
+ */
+void spi_nor_try_unlock_all(struct spi_nor *nor)
+{
+	int ret;
+
+	if (!(nor->flags & SNOR_F_HAS_LOCK))
+		return;
+
+	ret = spi_nor_unlock(&nor->mtd, 0, nor->params->size);
+	if (ret)
+		dev_dbg(nor->dev, "Failed to unlock the entire flash memory array\n");
+}
+
+void spi_nor_register_locking_ops(struct spi_nor *nor)
+{
+	struct mtd_info *mtd = &nor->mtd;
+
+	if (!nor->params->locking_ops)
+		return;
+
+	mtd->_lock = spi_nor_lock;
+	mtd->_unlock = spi_nor_unlock;
+	mtd->_is_locked = spi_nor_is_locked;
+}
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index ce5676845f28..87322bbd1325 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -332,7 +332,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	if (hf->echo_id == -1) { /* normal rx */
 		skb = alloc_can_skb(dev->netdev, &cf);
 		if (!skb)
-			return;
+			goto resubmit_urb;
 
 		cf->can_id = le32_to_cpu(hf->can_id);
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index 4063d4a6f47e..685fb78846c6 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -314,6 +314,31 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
 	return !!budget;
 }
 
+void aq_ring_tx_deinit(struct aq_ring_s *self)
+{
+	if (!self)
+		return;
+
+	for (; self->sw_head != self->sw_tail;
+		self->sw_head = aq_ring_next_dx(self, self->sw_head)) {
+		struct aq_ring_buff_s *buff = &self->buff_ring[self->sw_head];
+		struct device *ndev = aq_nic_get_dev(self->aq_nic);
+
+		if (buff->is_mapped) {
+			if (buff->is_sop) {
+				dma_unmap_single(ndev, buff->pa, buff->len,
+						 DMA_TO_DEVICE);
+			} else {
+				dma_unmap_page(ndev, buff->pa, buff->len,
+					       DMA_TO_DEVICE);
+			}
+		}
+
+		if (buff->is_eop && buff->skb)
+			dev_kfree_skb_any(buff->skb);
+	}
+}
+
 static void aq_rx_checksum(struct aq_ring_s *self,
 			   struct aq_ring_buff_s *buff,
 			   struct sk_buff *skb)
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
index 93659e58f1ce..3be56a4fc5bb 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
@@ -182,6 +182,7 @@ void aq_ring_update_queue_state(struct aq_ring_s *ring);
 void aq_ring_queue_wake(struct aq_ring_s *ring);
 void aq_ring_queue_stop(struct aq_ring_s *ring);
 bool aq_ring_tx_clean(struct aq_ring_s *self);
+void aq_ring_tx_deinit(struct aq_ring_s *self);
 int aq_ring_rx_clean(struct aq_ring_s *self,
 		     struct napi_struct *napi,
 		     int *work_done,
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
index 6ab1f3212d24..2d77554d1b81 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
@@ -270,7 +270,7 @@ void aq_vec_deinit(struct aq_vec_s *self)
 
 	for (i = 0U; self->tx_rings > i; ++i) {
 		ring = self->ring[i];
-		aq_ring_tx_clean(&ring[AQ_VEC_TX_ID]);
+		aq_ring_tx_deinit(&ring[AQ_VEC_TX_ID]);
 		aq_ring_rx_deinit(&ring[AQ_VEC_RX_ID]);
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 7f1bf71844bc..8083b63c4b31 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -478,18 +478,18 @@ static int ice_lbtest_prepare_rings(struct ice_vsi *vsi)
 
 	status = ice_vsi_cfg(vsi);
 	if (status)
-		goto err_setup_rx_ring;
+		goto err_cfg_lan;
 
 	status = ice_vsi_start_all_rx_rings(vsi);
 	if (status)
-		goto err_start_rx_ring;
+		goto err_cfg_lan;
 
 	return status;
 
-err_start_rx_ring:
-	ice_vsi_free_rx_rings(vsi);
-err_setup_rx_ring:
+err_cfg_lan:
 	ice_vsi_stop_lan_tx_rings(vsi, ICE_NO_RESET, 0);
+err_setup_rx_ring:
+	ice_vsi_free_rx_rings(vsi);
 err_setup_tx_ring:
 	ice_vsi_free_tx_rings(vsi);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 107cfa93a80f..fea565f481db 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1261,6 +1261,30 @@ static bool ice_is_vf_disabled(struct ice_vf *vf)
 		test_bit(ICE_VF_STATE_DIS, vf->vf_states));
 }
 
+/**
+ * ice_reset_interrupts - clear all queue interrupt configuration for a VSI
+ * @vsi: the VSI whose interrupt registers should be cleared
+ *
+ * Zero the QINT_RQCTL and QINT_TQCTL registers for all allocated queues
+ * in the VSI. This clears the entire register including MSIX_INDX, ITR_INDX,
+ * CAUSE_ENA and NEXTQ fields, unlike ice_vf_dis_rxq_interrupt() which only
+ * clears the CAUSE_ENA bit.
+ */
+static void ice_reset_interrupts(struct ice_vsi *vsi)
+{
+	struct ice_pf *pf = vsi->back;
+	struct ice_hw *hw = &pf->hw;
+	int i;
+
+	ice_for_each_alloc_rxq(vsi, i)
+		wr32(hw, QINT_RQCTL(vsi->rxq_map[i]), 0);
+
+	ice_for_each_alloc_txq(vsi, i)
+		wr32(hw, QINT_TQCTL(vsi->txq_map[i]), 0);
+
+	ice_flush(hw);
+}
+
 /**
  * ice_reset_vf - Reset a particular VF
  * @vf: pointer to the VF structure
@@ -1304,6 +1328,9 @@ bool ice_reset_vf(struct ice_vf *vf, bool is_vflr)
 
 	ice_dis_vf_qs(vf);
 
+	/* cleanup interrupt registers */
+	ice_reset_interrupts(vsi);
+
 	/* Call Disable LAN Tx queue AQ whether or not queues are
 	 * enabled. This is needed for successful completion of VFR.
 	 */
@@ -2581,6 +2608,24 @@ static void ice_vf_ena_rxq_interrupt(struct ice_vsi *vsi, u32 q_idx)
 	wr32(hw, QINT_RQCTL(pfq), reg | QINT_RQCTL_CAUSE_ENA_M);
 }
 
+/**
+ * ice_vf_dis_rxq_interrupt - disable Rx queue interrupt via QINT_RQCTL
+ * @vsi: VSI of the VF to configure
+ * @q_idx: VF queue index used to determine the queue in the PF's space
+ */
+static void ice_vf_dis_rxq_interrupt(struct ice_vsi *vsi, u32 q_idx)
+{
+	struct ice_hw *hw = &vsi->back->hw;
+	u32 pfq = vsi->rxq_map[q_idx];
+	u32 reg;
+
+	reg = rd32(hw, QINT_RQCTL(pfq));
+	reg &= ~QINT_RQCTL_CAUSE_ENA_M;
+	wr32(hw, QINT_RQCTL(pfq), reg);
+
+	ice_flush(hw);
+}
+
 /**
  * ice_vc_ena_qs_msg
  * @vf: pointer to the VF info
@@ -2753,6 +2798,8 @@ static int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 			goto error_param;
 		}
 
+		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF)
+			ice_vf_dis_rxq_interrupt(vsi, vf_q_id);
 		bitmap_zero(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF);
 	} else if (q_map) {
 		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
@@ -2773,6 +2820,7 @@ static int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 				goto error_param;
 			}
 
+			ice_vf_dis_rxq_interrupt(vsi, vf_q_id);
 			/* Clear enabled queues flag */
 			clear_bit(vf_q_id, vf->rxq_ena);
 		}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index ca2b8ae98bd2..c423f44850d2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -593,7 +593,7 @@ static int otx2_pfvf_mbox_init(struct otx2_nic *pf, int numvfs)
 	if (!pf->mbox_pfvf_wq)
 		return -ENOMEM;
 
-	base = readq((void __iomem *)((u64)pf->reg_base + RVU_PF_VF_BAR4_ADDR));
+	base = readq(pf->reg_base + RVU_PF_VF_BAR4_ADDR);
 	hwbase = ioremap_wc(base, MBOX_SIZE * pf->total_vfs);
 
 	if (!hwbase) {
@@ -979,6 +979,9 @@ static int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
 	char *irq_name;
 	int err;
 
+	/* Clear stale mailbox interrupt state before installing the handler. */
+	otx2_write64(pf, RVU_PF_INT, BIT_ULL(0));
+
 	/* Register mailbox interrupt handler */
 	irq_name = &hw->irq_name[RVU_PF_INT_VEC_AFPF_MBOX * NAME_SIZE];
 	snprintf(irq_name, NAME_SIZE, "RVUPFAF Mbox");
@@ -990,10 +993,7 @@ static int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
 		return err;
 	}
 
-	/* Enable mailbox interrupt for msgs coming from AF.
-	 * First clear to avoid spurious interrupts, if any.
-	 */
-	otx2_write64(pf, RVU_PF_INT, BIT_ULL(0));
+	/* Enable mailbox interrupt for msgs coming from AF. */
 	otx2_write64(pf, RVU_PF_INT_ENA_W1S, BIT_ULL(0));
 
 	if (!probe_af)
@@ -1357,14 +1357,13 @@ static int otx2_init_hw_resources(struct otx2_nic *pf)
 	return err;
 
 err_free_nix_queues:
-	otx2_free_sq_res(pf);
 	otx2_free_cq_res(pf);
 	otx2_ctx_disable(mbox, NIX_AQ_CTYPE_RQ, false);
 err_free_txsch:
 	if (otx2_txschq_stop(pf))
 		dev_err(pf->dev, "%s failed to stop TX schedulers\n", __func__);
 err_free_sq_ptrs:
-	otx2_sq_free_sqbs(pf);
+	otx2_free_sq_res(pf);
 err_free_rq_ptrs:
 	otx2_free_aura_ptr(pf, AURA_NIX_RQ);
 	otx2_ctx_disable(mbox, NPA_AQ_CTYPE_POOL, true);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 5310b71795ec..c0d4a8f72628 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -230,6 +230,9 @@ static int otx2vf_register_mbox_intr(struct otx2_nic *vf, bool probe_pf)
 	char *irq_name;
 	int err;
 
+	/* Clear stale mailbox interrupt state before installing the handler. */
+	otx2_write64(vf, RVU_VF_INT, BIT_ULL(0));
+
 	/* Register mailbox interrupt handler */
 	irq_name = &hw->irq_name[RVU_VF_INT_VEC_MBOX * NAME_SIZE];
 	snprintf(irq_name, NAME_SIZE, "RVUVFAF Mbox");
@@ -241,10 +244,7 @@ static int otx2vf_register_mbox_intr(struct otx2_nic *vf, bool probe_pf)
 		return err;
 	}
 
-	/* Enable mailbox interrupt for msgs coming from PF.
-	 * First clear to avoid spurious interrupts, if any.
-	 */
-	otx2_write64(vf, RVU_VF_INT, BIT_ULL(0));
+	/* Enable mailbox interrupt for msgs coming from PF. */
 	otx2_write64(vf, RVU_VF_INT_ENA_W1S, BIT_ULL(0));
 
 	if (!probe_pf)
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 8ab7e591b66a..86b7642f1668 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3549,8 +3549,91 @@ static int mlxsw_sp_port_lag_index_get(struct mlxsw_sp *mlxsw_sp,
 	return -EBUSY;
 }
 
+static int mlxsw_sp_lag_uppers_bridge_join(struct mlxsw_sp_port *mlxsw_sp_port,
+					   struct net_device *lag_dev,
+					   struct netlink_ext_ack *extack)
+{
+	struct net_device *upper_dev;
+	struct net_device *master;
+	struct list_head *iter;
+	int done = 0;
+	int err;
+
+	master = netdev_master_upper_dev_get(lag_dev);
+	if (master && netif_is_bridge_master(master)) {
+		err = mlxsw_sp_port_bridge_join(mlxsw_sp_port, lag_dev, master,
+						extack);
+		if (err)
+			return err;
+	}
+
+	netdev_for_each_upper_dev_rcu(lag_dev, upper_dev, iter) {
+		if (!is_vlan_dev(upper_dev))
+			continue;
+
+		master = netdev_master_upper_dev_get(upper_dev);
+		if (master && netif_is_bridge_master(master)) {
+			err = mlxsw_sp_port_bridge_join(mlxsw_sp_port,
+							upper_dev, master,
+							extack);
+			if (err)
+				goto err_port_bridge_join;
+		}
+
+		++done;
+	}
+
+	return 0;
+
+err_port_bridge_join:
+	netdev_for_each_upper_dev_rcu(lag_dev, upper_dev, iter) {
+		if (!is_vlan_dev(upper_dev))
+			continue;
+
+		master = netdev_master_upper_dev_get(upper_dev);
+		if (!master || !netif_is_bridge_master(master))
+			continue;
+
+		if (!done--)
+			break;
+
+		mlxsw_sp_port_bridge_leave(mlxsw_sp_port, upper_dev, master);
+	}
+
+	master = netdev_master_upper_dev_get(lag_dev);
+	if (master && netif_is_bridge_master(master))
+		mlxsw_sp_port_bridge_leave(mlxsw_sp_port, lag_dev, master);
+
+	return err;
+}
+
+static void
+mlxsw_sp_lag_uppers_bridge_leave(struct mlxsw_sp_port *mlxsw_sp_port,
+				 struct net_device *lag_dev)
+{
+	struct net_device *upper_dev;
+	struct net_device *master;
+	struct list_head *iter;
+
+	netdev_for_each_upper_dev_rcu(lag_dev, upper_dev, iter) {
+		if (!is_vlan_dev(upper_dev))
+			continue;
+
+		master = netdev_master_upper_dev_get(upper_dev);
+		if (!master)
+			continue;
+
+		mlxsw_sp_port_bridge_leave(mlxsw_sp_port, upper_dev, master);
+	}
+
+	master = netdev_master_upper_dev_get(lag_dev);
+	if (master)
+		mlxsw_sp_port_bridge_leave(mlxsw_sp_port, lag_dev, master);
+}
+
 static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
-				  struct net_device *lag_dev)
+				  struct net_device *lag_dev,
+				  struct netlink_ext_ack *extack)
 {
 	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
 	struct mlxsw_sp_upper *lag;
@@ -3571,7 +3654,13 @@ static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
 
 	err = mlxsw_sp_port_lag_index_get(mlxsw_sp, lag_id, &port_index);
 	if (err)
-		return err;
+		goto err_lag_uppers_bridge_join;
+
+	err = mlxsw_sp_lag_uppers_bridge_join(mlxsw_sp_port, lag_dev,
+					      extack);
+	if (err)
+		goto err_lag_uppers_bridge_join;
+
 	err = mlxsw_sp_lag_col_port_add(mlxsw_sp_port, lag_id, port_index);
 	if (err)
 		goto err_col_port_add;
@@ -3586,9 +3675,23 @@ static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
 	if (mlxsw_sp_port->default_vlan->fid)
 		mlxsw_sp_port_vlan_router_leave(mlxsw_sp_port->default_vlan);
 
+	/* Join a router interface configured on the LAG, if exists */
+	err = mlxsw_sp_port_vlan_router_join(mlxsw_sp_port->default_vlan,
+					     lag_dev, extack);
+	if (err)
+		goto err_router_join;
+
 	return 0;
 
+err_router_join:
+	lag->ref_count--;
+	mlxsw_sp_port->lagged = 0;
+	mlxsw_core_lag_mapping_clear(mlxsw_sp->core, lag_id,
+				     mlxsw_sp_port->local_port);
+	mlxsw_sp_lag_col_port_remove(mlxsw_sp_port, lag_id);
 err_col_port_add:
+	mlxsw_sp_lag_uppers_bridge_leave(mlxsw_sp_port, lag_dev);
+err_lag_uppers_bridge_join:
 	if (!lag->ref_count)
 		mlxsw_sp_lag_destroy(mlxsw_sp, lag_id);
 	return err;
@@ -3920,7 +4023,7 @@ static int mlxsw_sp_netdevice_port_upper_event(struct net_device *lower_dev,
 		} else if (netif_is_lag_master(upper_dev)) {
 			if (info->linking) {
 				err = mlxsw_sp_port_lag_join(mlxsw_sp_port,
-							     upper_dev);
+							     upper_dev, extack);
 			} else {
 				mlxsw_sp_port_lag_col_dist_disable(mlxsw_sp_port);
 				mlxsw_sp_port_lag_leave(mlxsw_sp_port,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index 3e7576e671df..4f0af7636344 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -665,6 +665,10 @@ mlxsw_sp_netdevice_ipip_ul_event(struct mlxsw_sp *mlxsw_sp,
 				 struct net_device *l3_dev,
 				 unsigned long event,
 				 struct netdev_notifier_info *info);
+int
+mlxsw_sp_port_vlan_router_join(struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan,
+			       struct net_device *l3_dev,
+			       struct netlink_ext_ack *extack);
 void
 mlxsw_sp_port_vlan_router_leave(struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan);
 void mlxsw_sp_rif_destroy_by_dev(struct mlxsw_sp *mlxsw_sp,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 2efe45a27a0c..95b0f9c01e1c 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -6676,9 +6676,9 @@ static void mlxsw_sp_rif_subport_put(struct mlxsw_sp_rif *rif)
 }
 
 static int
-mlxsw_sp_port_vlan_router_join(struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan,
-			       struct net_device *l3_dev,
-			       struct netlink_ext_ack *extack)
+__mlxsw_sp_port_vlan_router_join(struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan,
+				 struct net_device *l3_dev,
+				 struct netlink_ext_ack *extack)
 {
 	struct mlxsw_sp_port *mlxsw_sp_port = mlxsw_sp_port_vlan->mlxsw_sp_port;
 	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
@@ -6743,6 +6743,27 @@ __mlxsw_sp_port_vlan_router_leave(struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan)
 	mlxsw_sp_rif_subport_put(rif);
 }
 
+int
+mlxsw_sp_port_vlan_router_join(struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan,
+			       struct net_device *l3_dev,
+			       struct netlink_ext_ack *extack)
+{
+	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port_vlan->mlxsw_sp_port->mlxsw_sp;
+	struct mlxsw_sp_rif *rif;
+	int err = 0;
+
+	mutex_lock(&mlxsw_sp->router->lock);
+	rif = mlxsw_sp_rif_find_by_dev(mlxsw_sp, l3_dev);
+	if (!rif)
+		goto out;
+
+	err = __mlxsw_sp_port_vlan_router_join(mlxsw_sp_port_vlan, l3_dev,
+					       extack);
+out:
+	mutex_unlock(&mlxsw_sp->router->lock);
+	return err;
+}
+
 void
 mlxsw_sp_port_vlan_router_leave(struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan)
 {
@@ -6767,8 +6788,8 @@ static int mlxsw_sp_inetaddr_port_vlan_event(struct net_device *l3_dev,
 
 	switch (event) {
 	case NETDEV_UP:
-		return mlxsw_sp_port_vlan_router_join(mlxsw_sp_port_vlan,
-						      l3_dev, extack);
+		return __mlxsw_sp_port_vlan_router_join(mlxsw_sp_port_vlan,
+							l3_dev, extack);
 	case NETDEV_DOWN:
 		__mlxsw_sp_port_vlan_router_leave(mlxsw_sp_port_vlan);
 		break;
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 2dc3e5be1d71..6228faa1a8c3 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -270,8 +270,8 @@ static int am65_cpsw_nuss_ndo_slave_kill_vid(struct net_device *ndev,
 	return ret;
 }
 
-static void am65_cpsw_slave_set_promisc_2g(struct am65_cpsw_port *port,
-					   bool promisc)
+static void am65_cpsw_slave_set_promisc(struct am65_cpsw_port *port,
+					bool promisc)
 {
 	struct am65_cpsw_common *common = port->common;
 
@@ -296,7 +296,7 @@ static void am65_cpsw_nuss_ndo_slave_set_rx_mode(struct net_device *ndev)
 	bool promisc;
 
 	promisc = !!(ndev->flags & IFF_PROMISC);
-	am65_cpsw_slave_set_promisc_2g(port, promisc);
+	am65_cpsw_slave_set_promisc(port, promisc);
 
 	if (promisc)
 		return;
@@ -627,13 +627,13 @@ static int am65_cpsw_nuss_ndo_slave_open(struct net_device *ndev)
 
 	am65_cpsw_port_set_sl_mac(port, ndev->dev_addr);
 
-	if (port->slave.mac_only)
+	if (port->slave.mac_only) {
 		/* enable mac-only mode on port */
 		cpsw_ale_control_set(common->ale, port->port_id,
 				     ALE_PORT_MACONLY, 1);
-	if (AM65_CPSW_IS_CPSW2G(common))
 		cpsw_ale_control_set(common->ale, port->port_id,
 				     ALE_PORT_NOLEARN, 1);
+	}
 
 	port_mask = BIT(port->port_id) | ALE_PORT_HOST;
 	cpsw_ale_add_ucast(common->ale, ndev->dev_addr,
@@ -779,6 +779,8 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_common *common,
 	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
 	pkt_len = cppi5_hdesc_get_pktlen(desc_rx);
 	cppi5_desc_get_tags_ids(&desc_rx->hdr, &port_id, NULL);
+	/* Port ID is contained in the lower 8-bits of the 16-bit Source Tag */
+	port_id &= 0xFF;
 	dev_dbg(dev, "%s rx port_id:%d\n", __func__, port_id);
 	port = am65_common_get_port(common, port_id);
 	ndev = port->ndev;
@@ -1367,7 +1369,7 @@ static void am65_cpsw_nuss_ndo_get_stats(struct net_device *dev,
 	stats->tx_dropped	= dev->stats.tx_dropped;
 }
 
-static const struct net_device_ops am65_cpsw_nuss_netdev_ops_2g = {
+static const struct net_device_ops am65_cpsw_nuss_netdev_ops = {
 	.ndo_open		= am65_cpsw_nuss_ndo_slave_open,
 	.ndo_stop		= am65_cpsw_nuss_ndo_slave_stop,
 	.ndo_start_xmit		= am65_cpsw_nuss_ndo_slave_xmit,
@@ -1389,7 +1391,6 @@ static void am65_cpsw_nuss_slave_disable_unused(struct am65_cpsw_port *port)
 	if (!port->disabled)
 		return;
 
-	common->disabled_ports_mask |= BIT(port->port_id);
 	cpsw_ale_control_set(common->ale, port->port_id,
 			     ALE_PORT_STATE, ALE_PORT_STATE_DISABLE);
 
@@ -1578,7 +1579,6 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 		};
 		struct k3_ring_cfg fdqring_cfg = {
 			.elm_size = K3_RINGACC_RING_ELSIZE_8,
-			.mode = K3_RINGACC_RING_MODE_MESSAGE,
 			.flags = K3_RINGACC_RING_SHARED,
 		};
 		struct k3_udma_glue_rx_flow_cfg rx_flow_cfg = {
@@ -1592,6 +1592,7 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 		rx_flow_cfg.ring_rxfdq0_id = fdqring_id;
 		rx_flow_cfg.rx_cfg.size = max_desc_num;
 		rx_flow_cfg.rxfdq_cfg.size = max_desc_num;
+		rx_flow_cfg.rxfdq_cfg.mode = common->pdata.fdqring_mode;
 
 		ret = k3_udma_glue_rx_flow_init(rx_chn->rx_chn,
 						i, &rx_flow_cfg);
@@ -1754,8 +1755,10 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 		}
 
 		port->disabled = !of_device_is_available(port_np);
-		if (port->disabled)
+		if (port->disabled) {
+			common->disabled_ports_mask |= BIT(port->port_id);
 			continue;
+		}
 
 		port->slave.ifphy = devm_of_phy_get(dev, port_np, NULL);
 		if (IS_ERR(port->slave.ifphy)) {
@@ -1810,6 +1813,12 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 	}
 	of_node_put(node);
 
+	/* is there at least one ext.port */
+	if (!(~common->disabled_ports_mask & GENMASK(common->port_num, 1))) {
+		dev_err(dev, "No Ext. port are available\n");
+		return -ENODEV;
+	}
+
 	return 0;
 
 of_node_put:
@@ -1825,14 +1834,18 @@ static void am65_cpsw_pcpu_stats_free(void *data)
 	free_percpu(stats);
 }
 
-static int am65_cpsw_nuss_init_ndev_2g(struct am65_cpsw_common *common)
+static int
+am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
 {
 	struct am65_cpsw_ndev_priv *ndev_priv;
 	struct device *dev = common->dev;
 	struct am65_cpsw_port *port;
 	int ret;
 
-	port = am65_common_get_port(common, 1);
+	port = &common->ports[port_idx];
+
+	if (port->disabled)
+		return 0;
 
 	/* alloc netdev */
 	port->ndev = devm_alloc_etherdev_mqs(common->dev,
@@ -1862,7 +1875,7 @@ static int am65_cpsw_nuss_init_ndev_2g(struct am65_cpsw_common *common)
 	port->ndev->features = port->ndev->hw_features |
 			       NETIF_F_HW_VLAN_CTAG_FILTER;
 	port->ndev->vlan_features |=  NETIF_F_SG;
-	port->ndev->netdev_ops = &am65_cpsw_nuss_netdev_ops_2g;
+	port->ndev->netdev_ops = &am65_cpsw_nuss_netdev_ops;
 	port->ndev->ethtool_ops = &am65_cpsw_ethtool_ops_slave;
 
 	/* Disable TX checksum offload by default due to HW bug */
@@ -1875,29 +1888,41 @@ static int am65_cpsw_nuss_init_ndev_2g(struct am65_cpsw_common *common)
 
 	ret = devm_add_action_or_reset(dev, am65_cpsw_pcpu_stats_free,
 				       ndev_priv->stats);
-	if (ret) {
-		dev_err(dev, "Failed to add percpu stat free action %d\n", ret);
-		return ret;
+	if (ret)
+		dev_err(dev, "failed to add percpu stat free action %d\n", ret);
+
+	if (!common->dma_ndev)
+		common->dma_ndev = port->ndev;
+
+	return ret;
+}
+
+static int am65_cpsw_nuss_init_ndevs(struct am65_cpsw_common *common)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < common->port_num; i++) {
+		ret = am65_cpsw_nuss_init_port_ndev(common, i);
+		if (ret)
+			return ret;
 	}
 
-	netif_napi_add(port->ndev, &common->napi_rx,
+	netif_napi_add(common->dma_ndev, &common->napi_rx,
 		       am65_cpsw_nuss_rx_poll, NAPI_POLL_WEIGHT);
 
 	return ret;
 }
 
-static int am65_cpsw_nuss_ndev_add_napi_2g(struct am65_cpsw_common *common)
+static int am65_cpsw_nuss_ndev_add_tx_napi(struct am65_cpsw_common *common)
 {
 	struct device *dev = common->dev;
-	struct am65_cpsw_port *port;
 	int i, ret = 0;
 
-	port = am65_common_get_port(common, 1);
-
 	for (i = 0; i < common->tx_ch_num; i++) {
 		struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];
 
-		netif_tx_napi_add(port->ndev, &tx_chn->napi_tx,
+		netif_tx_napi_add(common->dma_ndev, &tx_chn->napi_tx,
 				  am65_cpsw_nuss_tx_poll, NAPI_POLL_WEIGHT);
 
 		ret = devm_request_irq(dev, tx_chn->irq,
@@ -1915,16 +1940,27 @@ static int am65_cpsw_nuss_ndev_add_napi_2g(struct am65_cpsw_common *common)
 	return ret;
 }
 
-static int am65_cpsw_nuss_ndev_reg_2g(struct am65_cpsw_common *common)
+static void am65_cpsw_nuss_cleanup_ndev(struct am65_cpsw_common *common)
+{
+	struct am65_cpsw_port *port;
+	int i;
+
+	for (i = 0; i < common->port_num; i++) {
+		port = &common->ports[i];
+		if (port->ndev && port->ndev->reg_state == NETREG_REGISTERED)
+			unregister_netdev(port->ndev);
+	}
+}
+
+static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
 {
 	struct device *dev = common->dev;
 	struct am65_cpsw_port *port;
-	int ret = 0;
+	int ret = 0, i;
 
-	port = am65_common_get_port(common, 1);
-	ret = am65_cpsw_nuss_ndev_add_napi_2g(common);
+	ret = am65_cpsw_nuss_ndev_add_tx_napi(common);
 	if (ret)
-		goto err;
+		return ret;
 
 	ret = devm_request_irq(dev, common->rx_chns.irq,
 			       am65_cpsw_nuss_rx_irq,
@@ -1932,17 +1968,31 @@ static int am65_cpsw_nuss_ndev_reg_2g(struct am65_cpsw_common *common)
 	if (ret) {
 		dev_err(dev, "failure requesting rx irq %u, %d\n",
 			common->rx_chns.irq, ret);
-		goto err;
+		return ret;
+	}
+
+	for (i = 0; i < common->port_num; i++) {
+		port = &common->ports[i];
+
+		if (!port->ndev)
+			continue;
+
+		ret = register_netdev(port->ndev);
+		if (ret) {
+			dev_err(dev, "error registering slave net device%i %d\n",
+				i, ret);
+			goto err_cleanup_ndev;
+		}
 	}
 
-	ret = register_netdev(port->ndev);
-	if (ret)
-		dev_err(dev, "error registering slave net device %d\n", ret);
 
 	/* can't auto unregister ndev using devm_add_action() due to
 	 * devres release sequence in DD core for DMA
 	 */
-err:
+	return 0;
+
+err_cleanup_ndev:
+	am65_cpsw_nuss_cleanup_ndev(common);
 	return ret;
 }
 
@@ -1955,19 +2005,7 @@ int am65_cpsw_nuss_update_tx_chns(struct am65_cpsw_common *common, int num_tx)
 	if (ret)
 		return ret;
 
-	return am65_cpsw_nuss_ndev_add_napi_2g(common);
-}
-
-static void am65_cpsw_nuss_cleanup_ndev(struct am65_cpsw_common *common)
-{
-	struct am65_cpsw_port *port;
-	int i;
-
-	for (i = 0; i < common->port_num; i++) {
-		port = &common->ports[i];
-		if (port->ndev)
-			unregister_netdev(port->ndev);
-	}
+	return am65_cpsw_nuss_ndev_add_tx_napi(common);
 }
 
 struct am65_cpsw_soc_pdata {
@@ -1988,10 +2026,14 @@ static const struct soc_device_attribute am65_cpsw_socinfo[] = {
 
 static const struct am65_cpsw_pdata am65x_sr1_0 = {
 	.quirks = AM65_CPSW_QUIRK_I2027_NO_TX_CSUM,
+	.ale_dev_id = "am65x-cpsw2g",
+	.fdqring_mode = K3_RINGACC_RING_MODE_MESSAGE,
 };
 
 static const struct am65_cpsw_pdata j721e_pdata = {
 	.quirks = 0,
+	.ale_dev_id = "am65x-cpsw2g",
+	.fdqring_mode = K3_RINGACC_RING_MODE_MESSAGE,
 };
 
 static const struct of_device_id am65_cpsw_nuss_of_mtable[] = {
@@ -2051,9 +2093,6 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 	if (common->port_num < 1 || common->port_num > AM65_CPSW_MAX_PORTS)
 		return -ENOENT;
 
-	if (common->port_num != 1)
-		return -EOPNOTSUPP;
-
 	common->rx_flow_id_base = -1;
 	init_completion(&common->tdown_complete);
 	common->tx_ch_num = 1;
@@ -2123,7 +2162,7 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 	ale_params.ale_ageout = AM65_CPSW_ALE_AGEOUT_DEFAULT;
 	ale_params.ale_ports = common->port_num + 1;
 	ale_params.ale_regs = common->cpsw_base + AM65_CPSW_NU_ALE_BASE;
-	ale_params.dev_id = "am65x-cpsw2g";
+	ale_params.dev_id = common->pdata.ale_dev_id;
 	ale_params.bus_freq = common->bus_freq;
 
 	common->ale = cpsw_ale_create(&ale_params);
@@ -2143,11 +2182,11 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, common);
 
-	ret = am65_cpsw_nuss_init_ndev_2g(common);
+	ret = am65_cpsw_nuss_init_ndevs(common);
 	if (ret)
 		goto err_of_clear;
 
-	ret = am65_cpsw_nuss_ndev_reg_2g(common);
+	ret = am65_cpsw_nuss_register_ndevs(common);
 	if (ret)
 		goto err_of_clear;
 
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
index 993e1d4d3222..b5da51bfecd8 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
@@ -11,6 +11,7 @@
 #include <linux/netdevice.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
+#include <linux/soc/ti/k3-ringacc.h>
 #include "am65-cpsw-qos.h"
 
 struct am65_cpts;
@@ -77,6 +78,8 @@ struct am65_cpsw_rx_chn {
 
 struct am65_cpsw_pdata {
 	u32	quirks;
+	enum k3_ring_mode fdqring_mode;
+	const char	*ale_dev_id;
 };
 
 struct am65_cpsw_common {
@@ -91,6 +94,7 @@ struct am65_cpsw_common {
 	struct am65_cpsw_host   host;
 	struct am65_cpsw_port	*ports;
 	u32			disabled_ports_mask;
+	struct net_device	*dma_ndev;
 
 	int			usage_count; /* number of opened ports */
 	struct cpsw_ale		*ale;
diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
index a5f7a79a1923..20758612582b 100644
--- a/drivers/net/ipa/ipa_smp2p.c
+++ b/drivers/net/ipa/ipa_smp2p.c
@@ -222,19 +222,27 @@ int ipa_smp2p_init(struct ipa *ipa, bool modem_init)
 					  &valid_bit);
 	if (IS_ERR(valid_state))
 		return PTR_ERR(valid_state);
-	if (valid_bit >= 32)		/* BITS_PER_U32 */
-		return -EINVAL;
+	if (valid_bit >= 32) {		/* BITS_PER_U32 */
+		ret = -EINVAL;
+		goto err_valid_state_put;
+	}
 
 	enabled_state = qcom_smem_state_get(dev, "ipa-clock-enabled",
 					    &enabled_bit);
-	if (IS_ERR(enabled_state))
-		return PTR_ERR(enabled_state);
-	if (enabled_bit >= 32)		/* BITS_PER_U32 */
-		return -EINVAL;
+	if (IS_ERR(enabled_state)) {
+		ret = PTR_ERR(enabled_state);
+		goto err_valid_state_put;
+	}
+	if (enabled_bit >= 32) {		/* BITS_PER_U32 */
+		ret = -EINVAL;
+		goto err_enabled_state_put;
+	}
 
 	smp2p = kzalloc(sizeof(*smp2p), GFP_KERNEL);
-	if (!smp2p)
-		return -ENOMEM;
+	if (!smp2p) {
+		ret = -ENOMEM;
+		goto err_enabled_state_put;
+	}
 
 	smp2p->ipa = ipa;
 
@@ -279,6 +287,10 @@ int ipa_smp2p_init(struct ipa *ipa, bool modem_init)
 	ipa->smp2p = NULL;
 	mutex_destroy(&smp2p->mutex);
 	kfree(smp2p);
+err_enabled_state_put:
+	qcom_smem_state_put(enabled_state);
+err_valid_state_put:
+	qcom_smem_state_put(valid_state);
 
 	return ret;
 }
@@ -295,6 +307,8 @@ void ipa_smp2p_exit(struct ipa *ipa)
 	ipa_smp2p_clock_release(ipa);
 	ipa->smp2p = NULL;
 	mutex_destroy(&smp2p->mutex);
+	qcom_smem_state_put(smp2p->enabled_state);
+	qcom_smem_state_put(smp2p->valid_state);
 	kfree(smp2p);
 }
 
diff --git a/drivers/net/thunderbolt.c b/drivers/net/thunderbolt.c
index e05bcf86306c..d2457d799759 100644
--- a/drivers/net/thunderbolt.c
+++ b/drivers/net/thunderbolt.c
@@ -724,8 +724,12 @@ static bool tbnet_check_frame(struct tbnet *net, const struct tbnet_frame *tf,
 		return true;
 	}
 
-	/* Start of packet, validate the frame header */
-	if (frame_count == 0 || frame_count > TBNET_RING_SIZE / 4) {
+	/* Start of packet, validate the frame header. tbnet_poll() puts the
+	 * first frame in the skb linear area and every further frame in a page
+	 * fragment, so a packet may not span more than MAX_SKB_FRAGS + 1 frames
+	 * without overflowing skb_shinfo()->frags[].
+	 */
+	if (frame_count == 0 || frame_count > MAX_SKB_FRAGS + 1) {
 		net->stats.rx_length_errors++;
 		return false;
 	}
diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/ath/ath6kl/txrx.c
index 5be0c62ec019..feeeb8b76cfa 100644
--- a/drivers/net/wireless/ath/ath6kl/txrx.c
+++ b/drivers/net/wireless/ath/ath6kl/txrx.c
@@ -1829,7 +1829,7 @@ void aggr_reset_state(struct aggr_info_conn *aggr_conn)
 		return;
 
 	if (aggr_conn->timer_scheduled) {
-		del_timer(&aggr_conn->timer);
+		timer_delete_sync(&aggr_conn->timer);
 		aggr_conn->timer_scheduled = false;
 	}
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 106804b93f1a..f7c18304a0e8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -1042,6 +1042,7 @@ static int brcmf_ops_sdio_probe(struct sdio_func *func,
 	bus_if = kzalloc(sizeof(struct brcmf_bus), GFP_KERNEL);
 	if (!bus_if)
 		return -ENOMEM;
+	mutex_init(&bus_if->bus_reset_lock);
 	sdiodev = kzalloc(sizeof(struct brcmf_sdio_dev), GFP_KERNEL);
 	if (!sdiodev) {
 		kfree(bus_if);
@@ -1101,6 +1102,14 @@ static void brcmf_ops_sdio_remove(struct sdio_func *func)
 		if (func->num != 1)
 			return;
 
+		/* Drain bus_reset before the shared brcmf_sdiod_remove()
+		 * teardown, which the SDIO reset callback also reaches.  The
+		 * data worker can arm bus_reset via brcmf_fw_crashed(); cancel
+		 * it first.
+		 */
+		brcmf_sdio_cancel_datawork(sdiodev->bus);
+		brcmf_bus_cancel_reset_work(bus_if);
+
 		/* only proceed with rest of cleanup if func 1 */
 		brcmf_sdiod_remove(sdiodev);
 
@@ -1162,6 +1171,8 @@ static int brcmf_ops_sdio_suspend(struct device *dev)
 	} else {
 		/* power will be cut so remove device, probe again in resume */
 		brcmf_sdiod_intr_unregister(sdiodev);
+		brcmf_sdio_cancel_datawork(sdiodev->bus);
+		brcmf_bus_cancel_reset_work(bus_if);
 		ret = brcmf_sdiod_remove(sdiodev);
 		if (ret)
 			brcmf_err("Failed to remove device on suspend\n");
@@ -1187,6 +1198,8 @@ static int brcmf_ops_sdio_resume(struct device *dev)
 		ret = brcmf_sdiod_probe(sdiodev);
 		if (ret)
 			brcmf_err("Failed to probe device on resume\n");
+		else
+			brcmf_bus_allow_reset_work(bus_if);
 	} else {
 		if (sdiodev->wowl_enabled &&
 		    sdiodev->settings->bus.sdio.oob_irq_supported)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
index 3f5da3bb6aa5..b606094af2a3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
@@ -6,6 +6,7 @@
 #ifndef BRCMFMAC_BUS_H
 #define BRCMFMAC_BUS_H
 
+#include <linux/mutex.h>
 #include "debug.h"
 
 /* IDs of the 6 default common rings of msgbuf protocol */
@@ -149,11 +150,16 @@ struct brcmf_bus {
 	u32 chiprev;
 	bool always_use_fws_queue;
 	bool wowl_supported;
+	bool removing;		/* device removal in progress; quiesce async work */
+	struct mutex bus_reset_lock;
 
 	const struct brcmf_bus_ops *ops;
 	struct brcmf_bus_msgbuf *msgbuf;
 };
 
+void brcmf_bus_cancel_reset_work(struct brcmf_bus *bus_if);
+void brcmf_bus_allow_reset_work(struct brcmf_bus *bus_if);
+
 /*
  * callback wrappers
  */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 35dd99dd7dfd..e33f9edceb5f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -1166,6 +1166,35 @@ static int brcmf_revinfo_read(struct seq_file *s, void *data)
 	return 0;
 }
 
+/*
+ * Serialize arming from debugfs reset and brcmf_fw_crashed() against
+ * teardown.  The remove path sets ->removing and drains the work while
+ * holding bus_reset_lock, so a racing armer is either drained or skips it.
+ */
+static void brcmf_bus_schedule_reset(struct brcmf_bus *bus_if)
+{
+	mutex_lock(&bus_if->bus_reset_lock);
+	if (bus_if->drvr && bus_if->drvr->bus_reset.func && !bus_if->removing)
+		schedule_work(&bus_if->drvr->bus_reset);
+	mutex_unlock(&bus_if->bus_reset_lock);
+}
+
+void brcmf_bus_cancel_reset_work(struct brcmf_bus *bus_if)
+{
+	mutex_lock(&bus_if->bus_reset_lock);
+	bus_if->removing = true;
+	if (bus_if->drvr)
+		cancel_work_sync(&bus_if->drvr->bus_reset);
+	mutex_unlock(&bus_if->bus_reset_lock);
+}
+
+void brcmf_bus_allow_reset_work(struct brcmf_bus *bus_if)
+{
+	mutex_lock(&bus_if->bus_reset_lock);
+	bus_if->removing = false;
+	mutex_unlock(&bus_if->bus_reset_lock);
+}
+
 static void brcmf_core_bus_reset(struct work_struct *work)
 {
 	struct brcmf_pub *drvr = container_of(work, struct brcmf_pub,
@@ -1186,7 +1215,7 @@ static ssize_t bus_reset_write(struct file *file, const char __user *user_buf,
 	if (value != 1)
 		return -EINVAL;
 
-	schedule_work(&drvr->bus_reset);
+	brcmf_bus_schedule_reset(drvr->bus_if);
 
 	return count;
 }
@@ -1404,13 +1433,23 @@ void brcmf_dev_coredump(struct device *dev)
 void brcmf_fw_crashed(struct device *dev)
 {
 	struct brcmf_bus *bus_if = dev_get_drvdata(dev);
-	struct brcmf_pub *drvr = bus_if->drvr;
+	struct brcmf_pub *drvr;
+
+	/* May fire before brcmf_attach() wires up drvr, or after removal
+	 * has cleared it; guard the derefs below (and the arming gate in
+	 * brcmf_bus_schedule_reset() already checks drvr/->removing).
+	 */
+	if (!bus_if)
+		return;
+	drvr = bus_if->drvr;
+	if (!drvr)
+		return;
 
 	bphy_err(drvr, "Firmware has halted or crashed\n");
 
 	brcmf_dev_coredump(dev);
 
-	schedule_work(&drvr->bus_reset);
+	brcmf_bus_schedule_reset(bus_if);
 }
 
 void brcmf_detach(struct device *dev)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 6152c83f721c..d96539bd62ad 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -1892,6 +1892,7 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		ret = -ENOMEM;
 		goto fail;
 	}
+	mutex_init(&bus->bus_reset_lock);
 	bus->msgbuf = kzalloc(sizeof(*bus->msgbuf), GFP_KERNEL);
 	if (!bus->msgbuf) {
 		ret = -ENOMEM;
@@ -1963,6 +1964,11 @@ brcmf_pcie_remove(struct pci_dev *pdev)
 	if (devinfo->ci)
 		brcmf_pcie_intr_disable(devinfo);
 
+	if (devinfo->irq_allocated)
+		synchronize_irq(pdev->irq);
+
+	brcmf_bus_cancel_reset_work(bus);
+
 	brcmf_detach(&pdev->dev);
 	brcmf_free(&pdev->dev);
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 5338d93e5b22..c10c8abb29fa 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -4530,6 +4530,12 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 	return NULL;
 }
 
+void brcmf_sdio_cancel_datawork(struct brcmf_sdio *bus)
+{
+	if (bus)
+		cancel_work_sync(&bus->datawork);
+}
+
 /* Detach and free everything */
 void brcmf_sdio_remove(struct brcmf_sdio *bus)
 {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
index 15d2c02fa3ec..3c68ebf8efaa 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
@@ -373,6 +373,7 @@ int brcmf_sdiod_remove(struct brcmf_sdio_dev *sdiodev);
 struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev);
 void brcmf_sdio_remove(struct brcmf_sdio *bus);
 void brcmf_sdio_isr(struct brcmf_sdio *bus, bool in_isr);
+void brcmf_sdio_cancel_datawork(struct brcmf_sdio *bus);
 
 void brcmf_sdio_wd_timer(struct brcmf_sdio *bus, bool active);
 void brcmf_sdio_wowl_config(struct device *dev, bool enabled);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 8c12aaffe719..29824caa9d4d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -1273,6 +1273,7 @@ static int brcmf_usb_probe_cb(struct brcmf_usbdev_info *devinfo)
 		ret = -ENOMEM;
 		goto fail;
 	}
+	mutex_init(&bus->bus_reset_lock);
 
 	bus->dev = dev;
 	bus_pub->bus = bus;
@@ -1338,6 +1339,8 @@ brcmf_usb_disconnect_cb(struct brcmf_usbdev_info *devinfo)
 		return;
 	brcmf_dbg(USB, "Enter, bus_pub %p\n", devinfo);
 
+	brcmf_bus_cancel_reset_work(devinfo->bus_pub.bus);
+
 	brcmf_detach(devinfo->dev);
 	brcmf_free(devinfo->dev);
 	kfree(devinfo->bus_pub.bus);
diff --git a/drivers/net/wireless/marvell/libertas_tf/main.c b/drivers/net/wireless/marvell/libertas_tf/main.c
index 71492211904b..b726e7e0b260 100644
--- a/drivers/net/wireless/marvell/libertas_tf/main.c
+++ b/drivers/net/wireless/marvell/libertas_tf/main.c
@@ -174,7 +174,7 @@ static void lbtf_free_adapter(struct lbtf_private *priv)
 {
 	lbtf_deb_enter(LBTF_DEB_MAIN);
 	lbtf_free_cmd_buffer(priv);
-	del_timer(&priv->command_timer);
+	timer_delete_sync(&priv->command_timer);
 	lbtf_deb_leave(LBTF_DEB_MAIN);
 }
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8ed2c9fb263a..6658bba9717d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -690,6 +690,36 @@ int pci_find_ht_capability(struct pci_dev *dev, int ht_cap)
 }
 EXPORT_SYMBOL_GPL(pci_find_ht_capability);
 
+/**
+ * pci_find_vsec_capability - Find a vendor-specific extended capability
+ * @dev: PCI device to query
+ * @vendor: Vendor ID for which capability is defined
+ * @cap: Vendor-specific capability ID
+ *
+ * If @dev has Vendor ID @vendor, search for a VSEC capability with
+ * VSEC ID @cap. If found, return the capability offset in
+ * config space; otherwise return 0.
+ */
+u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap)
+{
+	u16 vsec = 0;
+	u32 header;
+
+	if (vendor != dev->vendor)
+		return 0;
+
+	while ((vsec = pci_find_next_ext_capability(dev, vsec,
+						     PCI_EXT_CAP_ID_VNDR))) {
+		if (pci_read_config_dword(dev, vsec + PCI_VNDR_HEADER,
+					  &header) == PCIBIOS_SUCCESSFUL &&
+		    PCI_VNDR_HEADER_ID(header) == cap)
+			return vsec;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_find_vsec_capability);
+
 /**
  * pci_find_parent_resource - return resource region of parent bus of given
  *			      region
diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 8d1b2771c1aa..4da85df9f781 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -371,11 +371,9 @@ static void ccwchain_cda_free(struct ccwchain *chain, int idx)
 static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
 {
 	struct ccw1 *ccw = cp->guest_cp;
-	int cnt = 0;
-
-	do {
-		cnt++;
+	int cnt;
 
+	for (cnt = 1; cnt <= CCWCHAIN_LEN_MAX; cnt++, ccw++) {
 		/*
 		 * As we don't want to fail direct addressing even if the
 		 * orb specified one of the unsupported formats, we defer
@@ -393,15 +391,10 @@ static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
 		 * after the TIC, depending on the results of its operation.
 		 */
 		if (!ccw_is_chain(ccw) && !is_tic_within_range(ccw, iova, cnt))
-			break;
-
-		ccw++;
-	} while (cnt < CCWCHAIN_LEN_MAX + 1);
-
-	if (cnt == CCWCHAIN_LEN_MAX + 1)
-		cnt = -EINVAL;
+			return cnt;
+	}
 
-	return cnt;
+	return -EINVAL;
 }
 
 static int tic_target_chain_exists(struct ccw1 *tic, struct channel_program *cp)
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 73d564906d04..08971af62e31 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4748,6 +4748,9 @@ static int qeth_snmp_command(struct qeth_card *card, char __user *udata)
 	if (req_len > QETH_BUFSIZE)
 		return -EINVAL;
 
+	if (qinfo.udata_len < sizeof(struct qeth_snmp_ureq_hdr))
+		return -EINVAL;
+
 	iob = qeth_get_adapter_cmd(card, IPA_SETADP_SET_SNMP_CONTROL, req_len);
 	if (!iob)
 		return -ENOMEM;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 8876aff82fb9..11a8f97abb87 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1435,6 +1435,11 @@ static int qeth_l3_arp_query(struct qeth_card *card, char __user *udata)
 		rc = -EFAULT;
 		goto out;
 	}
+
+	if (qinfo.udata_len < QETH_QARP_ENTRIES_OFFSET) {
+		rc = -EINVAL;
+		goto out;
+	}
 	qinfo.udata = kzalloc(qinfo.udata_len, GFP_KERNEL);
 	if (!qinfo.udata) {
 		rc = -ENOMEM;
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 0f144fbf2a6c..e9d332a223b6 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -6811,6 +6811,7 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 			goto out_free_bsmbx;
 		}
 	}
+	mempool_free(mboxq, phba->mbox_mem_pool);
 
 	/*
 	 * 1 for cmd, 1 for rsp, NVME adds an extra one
@@ -6932,8 +6933,6 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 	if (!phba->lpfc_cmd_rsp_buf_pool)
 		goto out_free_sg_dma_buf;
 
-	mempool_free(mboxq, phba->mbox_mem_pool);
-
 	/* Verify OAS is supported */
 	lpfc_sli4_oas_verify(phba);
 
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index c3cbaeb514fc..5af545b12007 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -250,9 +250,9 @@ static const char *sdebug_version_date = "20200710";
 
 /* Zone types (zbcr05 table 25) */
 enum sdebug_z_type {
-	ZBC_ZONE_TYPE_CNV	= 0x1,
-	ZBC_ZONE_TYPE_SWR	= 0x2,
-	ZBC_ZONE_TYPE_SWP	= 0x3,
+	ZBC_ZTYPE_CNV	= 0x1,
+	ZBC_ZTYPE_SWR	= 0x2,
+	ZBC_ZTYPE_SWP	= 0x3,
 };
 
 /* enumeration names taken from table 26, zbcr05 */
@@ -2681,7 +2681,7 @@ static struct sdeb_zone_state *zbc_zone(struct sdebug_dev_info *devip,
 
 static inline bool zbc_zone_is_conv(struct sdeb_zone_state *zsp)
 {
-	return zsp->z_type == ZBC_ZONE_TYPE_CNV;
+	return zsp->z_type == ZBC_ZTYPE_CNV;
 }
 
 static void zbc_close_zone(struct sdebug_dev_info *devip,
@@ -2780,7 +2780,7 @@ static void zbc_inc_wp(struct sdebug_dev_info *devip,
 	if (zbc_zone_is_conv(zsp))
 		return;
 
-	if (zsp->z_type == ZBC_ZONE_TYPE_SWR) {
+	if (zsp->z_type == ZBC_ZTYPE_SWR) {
 		zsp->z_wp += num;
 		if (zsp->z_wp >= zend)
 			zbc_set_zone_full(devip, zsp);
@@ -2847,7 +2847,7 @@ static int check_zbc_access_params(struct scsi_cmnd *scp,
 		return 0;
 	}
 
-	if (zsp->z_type == ZBC_ZONE_TYPE_SWR) {
+	if (zsp->z_type == ZBC_ZTYPE_SWR) {
 		/* Writes cannot cross sequential zone boundaries */
 		if (zsp_end != zsp) {
 			mk_sense_buffer(scp, ILLEGAL_REQUEST,
@@ -4320,6 +4320,7 @@ static int resp_report_zones(struct scsi_cmnd *scp,
 	u32 alloc_len, rep_opts, rep_len;
 	bool partial;
 	u64 lba, zs_lba;
+	u64 arr_len;
 	u8 *arr = NULL, *desc;
 	u8 *cmd = scp->cmnd;
 	struct sdeb_zone_state *zsp;
@@ -4343,10 +4344,12 @@ static int resp_report_zones(struct scsi_cmnd *scp,
 	}
 
 	max_zones = devip->nr_zones - (zs_lba >> devip->zsize_shift);
-	rep_max_zones = min((alloc_len - 64) >> ilog2(RZONES_DESC_HD),
-			    max_zones);
+	rep_max_zones = (ALIGN((u64)alloc_len, RZONES_DESC_HD) - RZONES_DESC_HD) >>
+			ilog2(RZONES_DESC_HD);
+	rep_max_zones = min_t(unsigned int, rep_max_zones, max_zones);
+	arr_len = (u64)RZONES_DESC_HD * (rep_max_zones + 1);
 
-	arr = kzalloc(alloc_len, GFP_ATOMIC | __GFP_NOWARN);
+	arr = kzalloc(arr_len, GFP_ATOMIC | __GFP_NOWARN);
 	if (!arr) {
 		mk_sense_buffer(scp, ILLEGAL_REQUEST, INSUFF_RES_ASC,
 				INSUFF_RES_ASCQ);
@@ -4913,14 +4916,14 @@ static int sdebug_device_create_zones(struct sdebug_dev_info *devip)
 		zsp->z_start = zstart;
 
 		if (i < devip->nr_conv_zones) {
-			zsp->z_type = ZBC_ZONE_TYPE_CNV;
+			zsp->z_type = ZBC_ZTYPE_CNV;
 			zsp->z_cond = ZBC_NOT_WRITE_POINTER;
 			zsp->z_wp = (sector_t)-1;
 		} else {
 			if (devip->zmodel == BLK_ZONED_HM)
-				zsp->z_type = ZBC_ZONE_TYPE_SWR;
+				zsp->z_type = ZBC_ZTYPE_SWR;
 			else
-				zsp->z_type = ZBC_ZONE_TYPE_SWP;
+				zsp->z_type = ZBC_ZTYPE_SWP;
 			zsp->z_cond = ZC1_EMPTY;
 			zsp->z_wp = zsp->z_start;
 		}
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index b59136c4125b..33cc01f98c6a 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -217,7 +217,7 @@ static inline int sd_is_zoned(struct scsi_disk *sdkp)
 #ifdef CONFIG_BLK_DEV_ZONED
 
 void sd_zbc_release_disk(struct scsi_disk *sdkp);
-int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buffer);
+int sd_zbc_read_zones(struct scsi_disk *sdkp, u8 buf[SD_BUF_SIZE]);
 int sd_zbc_revalidate_zones(struct scsi_disk *sdkp);
 blk_status_t sd_zbc_setup_zone_mgmt_cmnd(struct scsi_cmnd *cmd,
 					 unsigned char op, bool all);
@@ -233,8 +233,7 @@ blk_status_t sd_zbc_prepare_zone_append(struct scsi_cmnd *cmd, sector_t *lba,
 
 static inline void sd_zbc_release_disk(struct scsi_disk *sdkp) {}
 
-static inline int sd_zbc_read_zones(struct scsi_disk *sdkp,
-				    unsigned char *buf)
+static inline int sd_zbc_read_zones(struct scsi_disk *sdkp, u8 buf[SD_BUF_SIZE])
 {
 	return 0;
 }
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 9b5dca0b6cf9..d5991d905d5f 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -20,6 +20,12 @@
 
 #include "sd.h"
 
+/**
+ * sd_zbc_get_zone_wp_offset - Get zone write pointer offset.
+ * @zone: Zone for which to return the write pointer offset.
+ *
+ * Return: offset of the write pointer from the start of the zone.
+ */
 static unsigned int sd_zbc_get_zone_wp_offset(struct blk_zone *zone)
 {
 	if (zone->type == ZBC_ZONE_TYPE_CONV)
@@ -44,7 +50,21 @@ static unsigned int sd_zbc_get_zone_wp_offset(struct blk_zone *zone)
 	}
 }
 
-static int sd_zbc_parse_report(struct scsi_disk *sdkp, u8 *buf,
+/**
+ * sd_zbc_parse_report - Parse a SCSI zone descriptor
+ * @sdkp: SCSI disk pointer.
+ * @buf: SCSI zone descriptor.
+ * @idx: Index of the zone relative to the first zone reported by the current
+ *	sd_zbc_report_zones() call.
+ * @cb: Callback function pointer.
+ * @data: Second argument passed to @cb.
+ *
+ * Return: Value returned by @cb.
+ *
+ * Convert a SCSI zone descriptor into struct blk_zone format. Additionally,
+ * call @cb(blk_zone, @data).
+ */
+static int sd_zbc_parse_report(struct scsi_disk *sdkp, const u8 buf[64],
 			       unsigned int idx, report_zones_cb cb, void *data)
 {
 	struct scsi_device *sdp = sdkp->device;
@@ -189,11 +209,22 @@ static inline sector_t sd_zbc_zone_sectors(struct scsi_disk *sdkp)
 	return logical_to_sectors(sdkp->device, sdkp->zone_blocks);
 }
 
+/**
+ * sd_zbc_report_zones - SCSI .report_zones() callback.
+ * @disk: Disk to report zones for.
+ * @sector: Start sector.
+ * @nr_zones: Maximum number of zones to report.
+ * @cb: Callback function called to report zone information.
+ * @data: Second argument passed to @cb.
+ *
+ * Called by the block layer to iterate over zone information. See also the
+ * disk->fops->report_zones() calls in block/blk-zoned.c.
+ */
 int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data)
 {
 	struct scsi_disk *sdkp = scsi_disk(disk);
-	sector_t capacity = logical_to_sectors(sdkp->device, sdkp->capacity);
+	sector_t lba = sectors_to_logical(sdkp->device, sector);
 	unsigned int nr, i;
 	unsigned char *buf;
 	size_t offset, buflen = 0;
@@ -204,7 +235,7 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 		/* Not a zoned device */
 		return -EOPNOTSUPP;
 
-	if (!capacity)
+	if (!sdkp->capacity)
 		/* Device gone or invalid */
 		return -ENODEV;
 
@@ -212,9 +243,8 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 	if (!buf)
 		return -ENOMEM;
 
-	while (zone_idx < nr_zones && sector < capacity) {
-		ret = sd_zbc_do_report_zones(sdkp, buf, buflen,
-				sectors_to_logical(sdkp->device, sector), true);
+	while (zone_idx < nr_zones && lba < sdkp->capacity) {
+		ret = sd_zbc_do_report_zones(sdkp, buf, buflen, lba, true);
 		if (ret)
 			goto out;
 
@@ -232,7 +262,7 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 			zone_idx++;
 		}
 
-		sector += sd_zbc_zone_sectors(sdkp) * i;
+		lba += sdkp->zone_blocks * i;
 	}
 
 	ret = zone_idx;
@@ -276,6 +306,10 @@ static int sd_zbc_update_wp_offset_cb(struct blk_zone *zone, unsigned int idx,
 	return 0;
 }
 
+/*
+ * An attempt to append a zone triggered an invalid write pointer error.
+ * Reread the write pointer of the zone(s) in which the append failed.
+ */
 static void sd_zbc_update_wp_offset_workfn(struct work_struct *work)
 {
 	struct scsi_disk *sdkp;
@@ -557,14 +591,15 @@ static int sd_zbc_check_zoned_characteristics(struct scsi_disk *sdkp,
 		sdkp->zones_optimal_open = get_unaligned_be32(&buf[8]);
 		sdkp->zones_optimal_nonseq = get_unaligned_be32(&buf[12]);
 		sdkp->zones_max_open = 0;
-	} else {
-		/* Host-managed */
-		sdkp->urswrz = buf[4] & 1;
-		sdkp->zones_optimal_open = 0;
-		sdkp->zones_optimal_nonseq = 0;
-		sdkp->zones_max_open = get_unaligned_be32(&buf[16]);
+		return 0;
 	}
 
+	/* Host-managed */
+	sdkp->urswrz = buf[4] & 1;
+	sdkp->zones_optimal_open = 0;
+	sdkp->zones_optimal_nonseq = 0;
+	sdkp->zones_max_open = get_unaligned_be32(&buf[16]);
+
 	/*
 	 * Check for unconstrained reads: host-managed devices with
 	 * constrained reads (drives failing read after write pointer)
@@ -584,7 +619,7 @@ static int sd_zbc_check_zoned_characteristics(struct scsi_disk *sdkp,
  * sd_zbc_check_capacity - Check the device capacity
  * @sdkp: Target disk
  * @buf: command buffer
- * @zblocks: zone size in number of blocks
+ * @zblocks: zone size in logical blocks
  *
  * Get the device zone size and check that the device capacity as reported
  * by READ CAPACITY matches the max_lba value (plus one) of the report zones
@@ -679,6 +714,11 @@ static void sd_zbc_revalidate_zones_cb(struct gendisk *disk)
 	swap(sdkp->zones_wp_offset, sdkp->rev_wp_offset);
 }
 
+/*
+ * Call blk_revalidate_disk_zones() if any of the zoned disk properties have
+ * changed that make it necessary to call that function. Called by
+ * sd_revalidate_disk() after the gendisk capacity has been set.
+ */
 int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)
 {
 	struct gendisk *disk = sdkp->disk;
@@ -757,7 +797,16 @@ int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)
 	return ret;
 }
 
-int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
+/**
+ * sd_zbc_read_zones - Read zone information and update the request queue
+ * @sdkp: SCSI disk pointer.
+ * @buf: 512 byte buffer used for storing SCSI command output.
+ *
+ * Read zone information and update the request queue zone characteristics and
+ * also the zoned device information in *sdkp. Called by sd_revalidate_disk()
+ * before the gendisk capacity has been set.
+ */
+int sd_zbc_read_zones(struct scsi_disk *sdkp, u8 buf[SD_BUF_SIZE])
 {
 	struct gendisk *disk = sdkp->disk;
 	struct request_queue *q = disk->queue;
diff --git a/drivers/target/target_core_fabric_lib.c b/drivers/target/target_core_fabric_lib.c
index 6600ae44f29d..8deadabca888 100644
--- a/drivers/target/target_core_fabric_lib.c
+++ b/drivers/target/target_core_fabric_lib.c
@@ -257,15 +257,56 @@ static int iscsi_get_pr_transport_id_len(
 	return len;
 }
 
-static char *iscsi_parse_pr_out_transport_id(
+static void sas_parse_pr_out_transport_id(char *buf, char *i_str)
+{
+	char hex[17] = {};
+
+	bin2hex(hex, buf + 4, 8);
+	snprintf(i_str, TRANSPORT_IQN_LEN, "naa.%s", hex);
+}
+
+static void srp_parse_pr_out_transport_id(char *buf, char *i_str)
+{
+	char hex[33] = {};
+
+	bin2hex(hex, buf + 8, 16);
+	snprintf(i_str, TRANSPORT_IQN_LEN, "0x%s", hex);
+}
+
+static void fcp_parse_pr_out_transport_id(char *buf, char *i_str)
+{
+	snprintf(i_str, TRANSPORT_IQN_LEN, "%8phC", buf + 8);
+}
+
+static void sbp_parse_pr_out_transport_id(char *buf, char *i_str)
+{
+	char hex[17] = {};
+
+	bin2hex(hex, buf + 8, 8);
+	snprintf(i_str, TRANSPORT_IQN_LEN, "%s", hex);
+}
+
+static bool iscsi_parse_pr_out_transport_id(
 	struct se_portal_group *se_tpg,
 	char *buf,
+	u32 buf_len,
 	u32 *out_tid_len,
-	char **port_nexus_ptr)
+	char **port_nexus_ptr,
+	char *i_str)
 {
 	char *p;
+	u32 tid_len;
 	int i;
-	u8 format_code = (buf[0] & 0xc0);
+	u8 format_code;
+
+	/*
+	 * The 4-byte iSCSI TransportID header (FORMAT CODE + 2-byte ADDITIONAL
+	 * LENGTH) must be present before any of it can be parsed.
+	 */
+	if (buf_len < 4)
+		return false;
+
+	format_code = buf[0] & 0xc0;
 	/*
 	 * Check for FORMAT CODE 00b or 01b from spc4r17, section 7.5.4.6:
 	 *
@@ -282,18 +323,20 @@ static char *iscsi_parse_pr_out_transport_id(
 	if ((format_code != 0x00) && (format_code != 0x40)) {
 		pr_err("Illegal format code: 0x%02x for iSCSI"
 			" Initiator Transport ID\n", format_code);
-		return NULL;
+		return false;
 	}
 	/*
-	 * If the caller wants the TransportID Length, we set that value for the
-	 * entire iSCSI Tarnsport ID now.
+	 * Reconstruct the self-described TransportID length from the ADDITIONAL
+	 * LENGTH field plus the 4-byte header.  Reject it if it is below the
+	 * spc4r17 section 7.5.4.6 minimum (ADDITIONAL LENGTH shall be at least
+	 * 20) or if it runs past the bytes actually received, so that every
+	 * access below stays inside the TransportID.
 	 */
-	if (out_tid_len) {
-		/* The shift works thanks to integer promotion rules */
-		*out_tid_len = get_unaligned_be16(&buf[2]);
-		/* Add four bytes for iSCSI Transport ID header */
-		*out_tid_len += 4;
-	}
+	tid_len = get_unaligned_be16(&buf[2]) + 4;
+	if (tid_len < 24 || tid_len > buf_len)
+		return false;
+	if (out_tid_len)
+		*out_tid_len = tid_len;
 
 	/*
 	 * Check for ',i,0x' separator between iSCSI Name and iSCSI Initiator
@@ -301,16 +344,32 @@ static char *iscsi_parse_pr_out_transport_id(
 	 * format.
 	 */
 	if (format_code == 0x40) {
-		p = strstr(&buf[4], ",i,0x");
+		p = strnstr(&buf[4], ",i,0x", tid_len - 4);
 		if (!p) {
-			pr_err("Unable to locate \",i,0x\" separator"
-				" for Initiator port identifier: %s\n",
-				&buf[4]);
-			return NULL;
+			pr_err("Unable to locate \",i,0x\" separator in iSCSI TransportID\n");
+			return false;
+		}
+		/*
+		 * The iSCSI name runs from &buf[4] up to the separator; reject it
+		 * if it cannot fit in i_str[TRANSPORT_IQN_LEN].
+		 */
+		if (p - &buf[4] >= TRANSPORT_IQN_LEN) {
+			pr_err("iSCSI Initiator port name too long in TransportID\n");
+			return false;
 		}
 		*p = '\0'; /* Terminate iSCSI Name */
 		p += 5; /* Skip over ",i,0x" separator */
 
+		/*
+		 * The ISID must follow the separator.  A ",i,0x" sitting at the
+		 * very end of the TransportID leaves no ISID and would point the
+		 * port nexus at buf + tid_len, i.e. past the descriptor, which
+		 * the registration code then reads as the ISID string.
+		 */
+		if (p >= buf + tid_len) {
+			pr_err("Missing ISID in iSCSI Initiator port TransportID\n");
+			return false;
+		}
 		*port_nexus_ptr = p;
 		/*
 		 * Go ahead and do the lower case conversion of the received
@@ -318,7 +377,7 @@ static char *iscsi_parse_pr_out_transport_id(
 		 * for comparison against the running iSCSI session's ISID from
 		 * iscsi_target.c:lio_sess_get_initiator_sid()
 		 */
-		for (i = 0; i < 12; i++) {
+		for (i = 0; i < 12 && p < buf + tid_len; i++) {
 			/*
 			 * The first ISCSI INITIATOR SESSION ID field byte
 			 * containing an ASCII null character terminates the
@@ -336,10 +395,23 @@ static char *iscsi_parse_pr_out_transport_id(
 			*p = tolower(*p);
 			p++;
 		}
-	} else
+		strscpy(i_str, &buf[4], TRANSPORT_IQN_LEN);
+	} else {
 		*port_nexus_ptr = NULL;
-
-	return &buf[4];
+		/*
+		 * FORMAT CODE 00b: the name occupies buf[4..tid_len-1].  The
+		 * declared length tid_len - 4 must fit in i_str[TRANSPORT_IQN_LEN].
+		 * (For 01b the same tid_len bound would be over-restrictive: the
+		 * descriptor also carries the separator and ISID, so a legal
+		 * <=223-byte name gives tid_len up to 244.)
+		 */
+		if (tid_len - 4 >= TRANSPORT_IQN_LEN) {
+			pr_err("iSCSI Initiator port name too long in TransportID\n");
+			return false;
+		}
+		strscpy(i_str, &buf[4], tid_len - 4);
+	}
+	return true;
 }
 
 int target_get_pr_transport_id_len(struct se_node_acl *nacl,
@@ -387,10 +459,16 @@ int target_get_pr_transport_id(struct se_node_acl *nacl,
 	}
 }
 
-const char *target_parse_pr_out_transport_id(struct se_portal_group *tpg,
-		char *buf, u32 *out_tid_len, char **port_nexus_ptr)
+bool target_parse_pr_out_transport_id(struct se_portal_group *tpg,
+		char *buf, u32 buf_len, u32 *out_tid_len,
+		char **port_nexus_ptr, char *i_str)
 {
-	u32 offset;
+	/*
+	 * The fixed-length SAS/SRP/FCP/SBP TransportIDs are 24 bytes; the iSCSI
+	 * format is variable and bounds itself against buf_len below.
+	 */
+	if (tpg->proto_id != SCSI_PROTOCOL_ISCSI && buf_len < 24)
+		return false;
 
 	switch (tpg->proto_id) {
 	case SCSI_PROTOCOL_SAS:
@@ -398,22 +476,26 @@ const char *target_parse_pr_out_transport_id(struct se_portal_group *tpg,
 		 * Assume the FORMAT CODE 00b from spc4r17, 7.5.4.7 TransportID
 		 * for initiator ports using SCSI over SAS Serial SCSI Protocol.
 		 */
-		offset = 4;
+		sas_parse_pr_out_transport_id(buf, i_str);
 		break;
-	case SCSI_PROTOCOL_SBP:
 	case SCSI_PROTOCOL_SRP:
+		srp_parse_pr_out_transport_id(buf, i_str);
+		break;
 	case SCSI_PROTOCOL_FCP:
-		offset = 8;
+		fcp_parse_pr_out_transport_id(buf, i_str);
+		break;
+	case SCSI_PROTOCOL_SBP:
+		sbp_parse_pr_out_transport_id(buf, i_str);
 		break;
 	case SCSI_PROTOCOL_ISCSI:
-		return iscsi_parse_pr_out_transport_id(tpg, buf, out_tid_len,
-					port_nexus_ptr);
+		return iscsi_parse_pr_out_transport_id(tpg, buf, buf_len,
+					out_tid_len, port_nexus_ptr, i_str);
 	default:
 		pr_err("Unknown proto_id: 0x%02x\n", tpg->proto_id);
-		return NULL;
+		return false;
 	}
 
 	*port_nexus_ptr = NULL;
 	*out_tid_len = 24;
-	return buf + offset;
+	return true;
 }
diff --git a/drivers/target/target_core_internal.h b/drivers/target/target_core_internal.h
index e4f072a680d4..91d3e2044c42 100644
--- a/drivers/target/target_core_internal.h
+++ b/drivers/target/target_core_internal.h
@@ -102,8 +102,9 @@ int	target_get_pr_transport_id_len(struct se_node_acl *nacl,
 int	target_get_pr_transport_id(struct se_node_acl *nacl,
 		struct t10_pr_registration *pr_reg, int *format_code,
 		unsigned char *buf);
-const char *target_parse_pr_out_transport_id(struct se_portal_group *tpg,
-		char *buf, u32 *out_tid_len, char **port_nexus_ptr);
+bool target_parse_pr_out_transport_id(struct se_portal_group *tpg,
+		char *buf, u32 buf_len, u32 *out_tid_len,
+		char **port_nexus_ptr, char *i_str);
 
 /* target_core_hba.c */
 struct se_hba *core_alloc_hba(const char *, u32, u32);
diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
index 5e5a7d104945..cf8d536fa3e7 100644
--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -895,9 +895,8 @@ static void core_scsi3_aptpl_reserve(
 	struct se_node_acl *node_acl,
 	struct t10_pr_registration *pr_reg)
 {
-	char i_buf[PR_REG_ISID_ID_LEN];
+	char i_buf[PR_REG_ISID_ID_LEN] = { };
 
-	memset(i_buf, 0, PR_REG_ISID_ID_LEN);
 	core_pr_dump_initiator_port(pr_reg, i_buf, PR_REG_ISID_ID_LEN);
 
 	spin_lock(&dev->dev_reservation_lock);
@@ -927,12 +926,10 @@ static int __core_scsi3_check_aptpl_registration(
 {
 	struct t10_pr_registration *pr_reg, *pr_reg_tmp;
 	struct t10_reservation *pr_tmpl = &dev->t10_pr;
-	unsigned char i_port[PR_APTPL_MAX_IPORT_LEN];
-	unsigned char t_port[PR_APTPL_MAX_TPORT_LEN];
+	unsigned char i_port[PR_APTPL_MAX_IPORT_LEN] = { };
+	unsigned char t_port[PR_APTPL_MAX_TPORT_LEN] = { };
 	u16 tpgt;
 
-	memset(i_port, 0, PR_APTPL_MAX_IPORT_LEN);
-	memset(t_port, 0, PR_APTPL_MAX_TPORT_LEN);
 	/*
 	 * Copy Initiator Port information from struct se_node_acl
 	 */
@@ -1022,9 +1019,8 @@ static void __core_scsi3_dump_registration(
 	enum register_type register_type)
 {
 	struct se_portal_group *se_tpg = nacl->se_tpg;
-	char i_buf[PR_REG_ISID_ID_LEN];
+	char i_buf[PR_REG_ISID_ID_LEN] = { };
 
-	memset(&i_buf[0], 0, PR_REG_ISID_ID_LEN);
 	core_pr_dump_initiator_port(pr_reg, i_buf, PR_REG_ISID_ID_LEN);
 
 	pr_debug("SPC-3 PR [%s] Service Action: REGISTER%s Initiator"
@@ -1203,10 +1199,10 @@ static struct t10_pr_registration *core_scsi3_locate_pr_reg(
 	struct se_session *sess)
 {
 	struct se_portal_group *tpg = nacl->se_tpg;
-	unsigned char buf[PR_REG_ISID_LEN], *isid_ptr = NULL;
+	unsigned char buf[PR_REG_ISID_LEN] = { };
+	unsigned char *isid_ptr = NULL;
 
 	if (tpg->se_tpg_tfo->sess_get_initiator_sid != NULL) {
-		memset(&buf[0], 0, PR_REG_ISID_LEN);
 		tpg->se_tpg_tfo->sess_get_initiator_sid(sess, &buf[0],
 					PR_REG_ISID_LEN);
 		isid_ptr = &buf[0];
@@ -1284,11 +1280,10 @@ static void __core_scsi3_free_registration(
 	struct t10_reservation *pr_tmpl = &dev->t10_pr;
 	struct se_node_acl *nacl = pr_reg->pr_reg_nacl;
 	struct se_dev_entry *deve;
-	char i_buf[PR_REG_ISID_ID_LEN];
+	char i_buf[PR_REG_ISID_ID_LEN] = { };
 
 	lockdep_assert_held(&pr_tmpl->registration_lock);
 
-	memset(i_buf, 0, PR_REG_ISID_ID_LEN);
 	core_pr_dump_initiator_port(pr_reg, i_buf, PR_REG_ISID_ID_LEN);
 
 	if (!list_empty(&pr_reg->pr_reg_list))
@@ -1491,11 +1486,12 @@ core_scsi3_decode_spec_i_port(
 	LIST_HEAD(tid_dest_list);
 	struct pr_transport_id_holder *tidh_new, *tidh, *tidh_tmp;
 	unsigned char *buf, *ptr, proto_ident;
-	const unsigned char *i_str = NULL;
+	unsigned char i_str[TRANSPORT_IQN_LEN];
 	char *iport_ptr = NULL, i_buf[PR_REG_ISID_ID_LEN];
 	sense_reason_t ret;
 	u32 tpdl, tid_len = 0;
 	u32 dest_rtpi = 0;
+	bool tid_found;
 
 	/*
 	 * Allocate a struct pr_transport_id_holder and setup the
@@ -1584,9 +1580,9 @@ core_scsi3_decode_spec_i_port(
 			dest_rtpi = tmp_lun->lun_rtpi;
 
 			iport_ptr = NULL;
-			i_str = target_parse_pr_out_transport_id(tmp_tpg,
-					ptr, &tid_len, &iport_ptr);
-			if (!i_str)
+			tid_found = target_parse_pr_out_transport_id(tmp_tpg,
+					ptr, tpdl, &tid_len, &iport_ptr, i_str);
+			if (!tid_found)
 				continue;
 			/*
 			 * Determine if this SCSI device server requires that
@@ -2060,7 +2056,8 @@ core_scsi3_emulate_pro_register(struct se_cmd *cmd, u64 res_key, u64 sa_res_key,
 	struct se_portal_group *se_tpg;
 	struct t10_pr_registration *pr_reg, *pr_reg_p, *pr_reg_tmp;
 	struct t10_reservation *pr_tmpl = &dev->t10_pr;
-	unsigned char isid_buf[PR_REG_ISID_LEN], *isid_ptr = NULL;
+	unsigned char isid_buf[PR_REG_ISID_LEN] = { };
+	unsigned char *isid_ptr = NULL;
 	sense_reason_t ret = TCM_NO_SENSE;
 	int pr_holder = 0, type;
 
@@ -2071,7 +2068,6 @@ core_scsi3_emulate_pro_register(struct se_cmd *cmd, u64 res_key, u64 sa_res_key,
 	se_tpg = se_sess->se_tpg;
 
 	if (se_tpg->se_tpg_tfo->sess_get_initiator_sid) {
-		memset(&isid_buf[0], 0, PR_REG_ISID_LEN);
 		se_tpg->se_tpg_tfo->sess_get_initiator_sid(se_sess, &isid_buf[0],
 				PR_REG_ISID_LEN);
 		isid_ptr = &isid_buf[0];
@@ -2283,11 +2279,9 @@ core_scsi3_pro_reserve(struct se_cmd *cmd, int type, int scope, u64 res_key)
 	struct se_lun *se_lun = cmd->se_lun;
 	struct t10_pr_registration *pr_reg, *pr_res_holder;
 	struct t10_reservation *pr_tmpl = &dev->t10_pr;
-	char i_buf[PR_REG_ISID_ID_LEN];
+	char i_buf[PR_REG_ISID_ID_LEN] = { };
 	sense_reason_t ret;
 
-	memset(i_buf, 0, PR_REG_ISID_ID_LEN);
-
 	if (!se_sess || !se_lun) {
 		pr_err("SPC-3 PR: se_sess || struct se_lun is NULL!\n");
 		return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
@@ -2458,12 +2452,11 @@ static void __core_scsi3_complete_pro_release(
 	int unreg)
 {
 	const struct target_core_fabric_ops *tfo = se_nacl->se_tpg->se_tpg_tfo;
-	char i_buf[PR_REG_ISID_ID_LEN];
+	char i_buf[PR_REG_ISID_ID_LEN] = { };
 	int pr_res_type = 0, pr_res_scope = 0;
 
 	lockdep_assert_held(&dev->dev_reservation_lock);
 
-	memset(i_buf, 0, PR_REG_ISID_ID_LEN);
 	core_pr_dump_initiator_port(pr_reg, i_buf, PR_REG_ISID_ID_LEN);
 	/*
 	 * Go ahead and release the current PR reservation holder.
@@ -2769,11 +2762,10 @@ static void __core_scsi3_complete_pro_preempt(
 {
 	struct se_node_acl *nacl = pr_reg->pr_reg_nacl;
 	const struct target_core_fabric_ops *tfo = nacl->se_tpg->se_tpg_tfo;
-	char i_buf[PR_REG_ISID_ID_LEN];
+	char i_buf[PR_REG_ISID_ID_LEN] = { };
 
 	lockdep_assert_held(&dev->dev_reservation_lock);
 
-	memset(i_buf, 0, PR_REG_ISID_ID_LEN);
 	core_pr_dump_initiator_port(pr_reg, i_buf, PR_REG_ISID_ID_LEN);
 	/*
 	 * Do an implicit RELEASE of the existing reservation.
@@ -3158,20 +3150,20 @@ core_scsi3_emulate_pro_register_and_move(struct se_cmd *cmd, u64 res_key,
 	struct t10_pr_registration *pr_reg, *pr_res_holder, *dest_pr_reg;
 	struct t10_reservation *pr_tmpl = &dev->t10_pr;
 	unsigned char *buf;
-	const unsigned char *initiator_str;
-	char *iport_ptr = NULL, i_buf[PR_REG_ISID_ID_LEN];
+	unsigned char initiator_str[TRANSPORT_IQN_LEN];
+	char *iport_ptr = NULL, i_buf[PR_REG_ISID_ID_LEN] = { };
 	u32 tid_len, tmp_tid_len;
 	int new_reg = 0, type, scope, matching_iname;
 	sense_reason_t ret;
 	unsigned short rtpi;
 	unsigned char proto_ident;
+	bool tid_found;
 
 	if (!se_sess || !se_lun) {
 		pr_err("SPC-3 PR: se_sess || struct se_lun is NULL!\n");
 		return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
 	}
 
-	memset(i_buf, 0, PR_REG_ISID_ID_LEN);
 	se_tpg = se_sess->se_tpg;
 	tf_ops = se_tpg->se_tpg_tfo;
 	/*
@@ -3284,9 +3276,9 @@ core_scsi3_emulate_pro_register_and_move(struct se_cmd *cmd, u64 res_key,
 		ret = TCM_INVALID_PARAMETER_LIST;
 		goto out;
 	}
-	initiator_str = target_parse_pr_out_transport_id(dest_se_tpg,
-			&buf[24], &tmp_tid_len, &iport_ptr);
-	if (!initiator_str) {
+	tid_found = target_parse_pr_out_transport_id(dest_se_tpg,
+			&buf[24], tid_len, &tmp_tid_len, &iport_ptr, initiator_str);
+	if (!tid_found) {
 		pr_err("SPC-3 PR REGISTER_AND_MOVE: Unable to locate"
 			" initiator_str from Transport ID\n");
 		ret = TCM_INVALID_PARAMETER_LIST;
diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 4414d44953d7..22f2f57b1327 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -823,6 +823,36 @@ int tb_domain_disconnect_all_paths(struct tb *tb)
 	return bus_for_each_dev(&tb_bus_type, NULL, tb, disconnect_xdomain);
 }
 
+struct unregister_context {
+	const struct tb *tb;
+	int n;
+};
+
+static int unregister_unplugged_xdomain(struct device *dev, void *data)
+{
+	struct unregister_context *ctx = data;
+	struct tb_xdomain *xd;
+
+	xd = tb_to_xdomain(dev);
+	if (xd && xd->tb == ctx->tb && xd->is_unplugged) {
+		tb_xdomain_unregister(xd);
+		ctx->n++;
+	}
+	return 0;
+}
+
+int tb_domain_unregister_unplugged_xdomains(struct tb *tb)
+{
+	struct unregister_context ctx;
+
+	ctx.tb = tb_domain_get(tb);
+	ctx.n = 0;
+	bus_for_each_dev(&tb_bus_type, NULL, &ctx, unregister_unplugged_xdomain);
+	tb_domain_put(tb);
+
+	return ctx.n;
+}
+
 int tb_domain_init(void)
 {
 	int ret;
diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 51e3ac78c022..96c03f79c01b 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -695,6 +695,7 @@ static void remove_xdomain(struct tb_xdomain *xd)
 
 	sw = tb_to_switch(xd->dev.parent);
 	tb_port_at(xd->route, sw)->xdomain = NULL;
+	xd->is_unplugged = true;
 	tb_xdomain_remove(xd);
 }
 
@@ -1682,6 +1683,8 @@ static void icm_handle_notification(struct work_struct *work)
 
 	kfree(n->pkg);
 	kfree(n);
+
+	tb_domain_unregister_unplugged_xdomains(tb);
 }
 
 static void icm_handle_event(struct tb *tb, enum tb_cfg_pkg_type type,
@@ -2023,6 +2026,8 @@ static void icm_rescan_work(struct work_struct *work)
 	if (tb->root_switch)
 		icm_free_unplugged_children(tb->root_switch);
 	mutex_unlock(&tb->lock);
+
+	tb_domain_unregister_unplugged_xdomains(tb);
 }
 
 static void icm_complete(struct tb *tb)
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 3a65650c82ce..0b9a4b7d5900 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2737,6 +2737,20 @@ int tb_switch_resume(struct tb_switch *sw, bool runtime)
 				tb_port_warn(port,
 					     "lost during suspend, disconnecting\n");
 				tb_sw_set_unplugged(port->remote->sw);
+			} else if (port->xdomain) {
+				/*
+				 * If the user replaced the XDomain with
+				 * another router, this will succeed in
+				 * which case we must remove the XDomain
+				 * before adding the new router.
+				 */
+				err = tb_cfg_get_upstream_port(sw->tb->ctl,
+							       port->xdomain->route);
+				if (err > 0) {
+					tb_port_warn(port,
+						     "XDomain was disconnected\n");
+					port->xdomain->is_unplugged = true;
+				}
 			}
 		}
 	}
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 26a78847985b..545ed25b705d 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1208,6 +1208,8 @@ static void tb_handle_hotplug(struct work_struct *work)
 out:
 	mutex_unlock(&tb->lock);
 
+	tb_domain_unregister_unplugged_xdomains(tb);
+
 	pm_runtime_mark_last_busy(&tb->dev);
 	pm_runtime_put_autosuspend(&tb->dev);
 
@@ -1375,6 +1377,24 @@ static void tb_restore_children(struct tb_switch *sw)
 	}
 }
 
+static void tb_free_unplugged_xdomains(struct tb_switch *sw)
+{
+	struct tb_port *port;
+
+	tb_switch_for_each_port(sw, port) {
+		if (tb_is_upstream_port(port))
+			continue;
+		if (port->xdomain && port->xdomain->is_unplugged) {
+			tb_retimer_remove_all(port);
+			tb_xdomain_remove(port->xdomain);
+			tb_port_unconfigure_xdomain(port);
+			port->xdomain = NULL;
+		} else if (port->remote) {
+			tb_free_unplugged_xdomains(port->remote->sw);
+		}
+	}
+}
+
 static int tb_resume_noirq(struct tb *tb)
 {
 	struct tb_cm *tcm = tb_priv(tb);
@@ -1388,6 +1408,7 @@ static int tb_resume_noirq(struct tb *tb)
 	tb_switch_resume(tb->root_switch, false);
 	tb_free_invalid_tunnels(tb);
 	tb_free_unplugged_children(tb->root_switch);
+	tb_free_unplugged_xdomains(tb->root_switch);
 	tb_restore_children(tb->root_switch);
 	list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list)
 		tb_tunnel_restart(tunnel);
@@ -1406,28 +1427,6 @@ static int tb_resume_noirq(struct tb *tb)
 	return 0;
 }
 
-static int tb_free_unplugged_xdomains(struct tb_switch *sw)
-{
-	struct tb_port *port;
-	int ret = 0;
-
-	tb_switch_for_each_port(sw, port) {
-		if (tb_is_upstream_port(port))
-			continue;
-		if (port->xdomain && port->xdomain->is_unplugged) {
-			tb_retimer_remove_all(port);
-			tb_xdomain_remove(port->xdomain);
-			tb_port_unconfigure_xdomain(port);
-			port->xdomain = NULL;
-			ret++;
-		} else if (port->remote) {
-			ret += tb_free_unplugged_xdomains(port->remote->sw);
-		}
-	}
-
-	return ret;
-}
-
 static int tb_freeze_noirq(struct tb *tb)
 {
 	struct tb_cm *tcm = tb_priv(tb);
@@ -1447,14 +1446,15 @@ static int tb_thaw_noirq(struct tb *tb)
 static void tb_complete(struct tb *tb)
 {
 	/*
-	 * Release any unplugged XDomains and if there is a case where
+	 * Unregister unplugged XDomains and if there is a case where
 	 * another domain is swapped in place of unplugged XDomain we
 	 * need to run another rescan.
 	 */
-	mutex_lock(&tb->lock);
-	if (tb_free_unplugged_xdomains(tb->root_switch))
+	if (tb_domain_unregister_unplugged_xdomains(tb)) {
+		mutex_lock(&tb->lock);
 		tb_scan_switch(tb->root_switch);
-	mutex_unlock(&tb->lock);
+		mutex_unlock(&tb->lock);
+	}
 }
 
 static int tb_runtime_suspend(struct tb *tb)
@@ -1475,11 +1475,11 @@ static void tb_remove_work(struct work_struct *work)
 	struct tb *tb = tcm_to_tb(tcm);
 
 	mutex_lock(&tb->lock);
-	if (tb->root_switch) {
+	if (tb->root_switch)
 		tb_free_unplugged_children(tb->root_switch);
-		tb_free_unplugged_xdomains(tb->root_switch);
-	}
 	mutex_unlock(&tb->lock);
+
+	tb_free_unplugged_xdomains(tb->root_switch);
 }
 
 static int tb_runtime_resume(struct tb *tb)
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index f3df5655f7a1..90a284112668 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -623,6 +623,7 @@ int tb_domain_disconnect_pcie_paths(struct tb *tb);
 int tb_domain_approve_xdomain_paths(struct tb *tb, struct tb_xdomain *xd);
 int tb_domain_disconnect_xdomain_paths(struct tb *tb, struct tb_xdomain *xd);
 int tb_domain_disconnect_all_paths(struct tb *tb);
+int tb_domain_unregister_unplugged_xdomains(struct tb *tb);
 
 static inline struct tb *tb_domain_get(struct tb *tb)
 {
@@ -939,6 +940,7 @@ struct tb_xdomain *tb_xdomain_alloc(struct tb *tb, struct device *parent,
 				    const uuid_t *remote_uuid);
 void tb_xdomain_add(struct tb_xdomain *xd);
 void tb_xdomain_remove(struct tb_xdomain *xd);
+void tb_xdomain_unregister(struct tb_xdomain *xd);
 struct tb_xdomain *tb_xdomain_find_by_link_depth(struct tb *tb, u8 link,
 						 u8 depth);
 
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 8e79c20e4807..47ccebf42c5a 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -604,8 +604,12 @@ static void tb_xdp_handle_request(struct work_struct *work)
 		 */
 		xd = tb_xdomain_find_by_uuid_locked(tb, &xchg->src_uuid);
 		if (xd) {
-			queue_delayed_work(tb->wq, &xd->get_properties_work,
-					   msecs_to_jiffies(50));
+			mutex_lock(&xd->lock);
+			if (!xd->removing)
+				queue_delayed_work(tb->wq,
+						   &xd->get_properties_work,
+						   msecs_to_jiffies(50));
+			mutex_unlock(&xd->lock);
 			tb_xdomain_put(xd);
 		}
 
@@ -784,6 +788,7 @@ static void tb_service_release(struct device *dev)
 	ida_simple_remove(&xd->service_ids, svc->id);
 	kfree(svc->key);
 	kfree(svc);
+	tb_xdomain_put(xd);
 }
 
 struct device_type tb_service_type = {
@@ -892,7 +897,7 @@ static void enumerate_services(struct tb_xdomain *xd)
 		svc->id = id;
 		svc->dev.bus = &tb_bus_type;
 		svc->dev.type = &tb_service_type;
-		svc->dev.parent = &xd->dev;
+		svc->dev.parent = get_device(&xd->dev);
 		dev_set_name(&svc->dev, "%s.%d", dev_name(&xd->dev), svc->id);
 
 		if (device_register(&svc->dev)) {
@@ -1357,32 +1362,50 @@ static int unregister_service(struct device *dev, void *data)
 }
 
 /**
- * tb_xdomain_remove() - Remove XDomain from the bus
+ * tb_xdomain_remove() - Remove XDomain
  * @xd: XDomain to remove
  *
- * This will stop all ongoing configuration work and remove the XDomain
- * along with any services from the bus. When the last reference to @xd
- * is released the object will be released as well.
+ * This will stop all ongoing configuration work. XDomain is not removed
+ * from the bus if it was added. That needs to be done separately by
+ * calling tb_xdomain_unregister().
+ *
+ * Called with @tb->lock held.
  */
 void tb_xdomain_remove(struct tb_xdomain *xd)
 {
+	mutex_lock(&xd->lock);
+	xd->removing = true;
+	mutex_unlock(&xd->lock);
+
 	stop_handshake(xd);
 
-	device_for_each_child_reverse(&xd->dev, xd, unregister_service);
+	if (!device_is_registered(&xd->dev)) {
+		/*
+		 * Undo runtime PM here explicitly because it is
+		 * possible that the XDomain was never added to the bus
+		 * and thus device_del() is not called for it
+		 * (device_del() would handle this otherwise).
+		 */
+		pm_runtime_disable(&xd->dev);
+		pm_runtime_put_noidle(&xd->dev);
+		pm_runtime_set_suspended(&xd->dev);
+		put_device(&xd->dev);
+	}
+}
 
-	/*
-	 * Undo runtime PM here explicitly because it is possible that
-	 * the XDomain was never added to the bus and thus device_del()
-	 * is not called for it (device_del() would handle this otherwise).
-	 */
-	pm_runtime_disable(&xd->dev);
-	pm_runtime_put_noidle(&xd->dev);
-	pm_runtime_set_suspended(&xd->dev);
+/**
+ * tb_xdomain_unregister() - Unregister XDomain
+ * @xd: XDomain to unregister
+ *
+ * This will unregister the XDomain along with any services from the
+ * bus. When the last reference to @xd is released the object will be
+ * released as well.
+ */
+void tb_xdomain_unregister(struct tb_xdomain *xd)
+{
+	device_for_each_child_reverse(&xd->dev, xd, unregister_service);
 
-	if (!device_is_registered(&xd->dev))
-		put_device(&xd->dev);
-	else
-		device_unregister(&xd->dev);
+	device_unregister(&xd->dev);
 }
 
 /**
@@ -1631,8 +1654,12 @@ static int update_xdomain(struct device *dev, void *data)
 
 	xd = tb_to_xdomain(dev);
 	if (xd) {
-		queue_delayed_work(xd->tb->wq, &xd->properties_changed_work,
-				   msecs_to_jiffies(50));
+		mutex_lock(&xd->lock);
+		if (!xd->removing)
+			queue_delayed_work(xd->tb->wq,
+					   &xd->properties_changed_work,
+					   msecs_to_jiffies(50));
+		mutex_unlock(&xd->lock);
 	}
 
 	return 0;
diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index 9a4c6466ab02..5f67bf4ce0fa 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -339,7 +339,8 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err:
-	mid->board->exit(mid);
+	if (mid->board->exit)
+		mid->board->exit(mid);
 	return ret;
 }
 
@@ -349,7 +350,8 @@ static void mid8250_remove(struct pci_dev *pdev)
 
 	serial8250_unregister_port(mid->line);
 
-	mid->board->exit(mid);
+	if (mid->board->exit)
+		mid->board->exit(mid);
 }
 
 static const struct mid8250_board pnw_board = {
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 4ef2762347f6..9cbfaa0c0b05 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1215,7 +1215,7 @@ static int __maybe_unused max310x_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(max310x_pm_ops, max310x_suspend, max310x_resume);
 
 #ifdef CONFIG_GPIOLIB
-static int max310x_gpio_get(struct gpio_chip *chip, unsigned offset)
+static int max310x_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	unsigned int val;
 	struct max310x_port *s = gpiochip_get_data(chip);
@@ -1226,7 +1226,7 @@ static int max310x_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return !!((val >> 4) & (1 << (offset % 4)));
 }
 
-static void max310x_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+static void max310x_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct max310x_port *s = gpiochip_get_data(chip);
 	struct uart_port *port = &s->p[offset / 4].port;
@@ -1235,7 +1235,18 @@ static void max310x_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 			    value ? 1 << (offset % 4) : 0);
 }
 
-static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+static int max310x_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	struct max310x_port *s = gpiochip_get_data(chip);
+	struct uart_port *port = &s->p[offset / 4].port;
+	unsigned int val;
+
+	val = max310x_port_read(port, MAX310X_GPIOCFG_REG);
+
+	return val & BIT(offset % 4) ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
+}
+
+static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
 	struct max310x_port *s = gpiochip_get_data(chip);
 	struct uart_port *port = &s->p[offset / 4].port;
@@ -1246,7 +1257,7 @@ static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 }
 
 static int max310x_gpio_direction_output(struct gpio_chip *chip,
-					 unsigned offset, int value)
+					 unsigned int offset, int value)
 {
 	struct max310x_port *s = gpiochip_get_data(chip);
 	struct uart_port *port = &s->p[offset / 4].port;
@@ -1441,6 +1452,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	s->gpio.owner		= THIS_MODULE;
 	s->gpio.parent		= dev;
 	s->gpio.label		= devtype->name;
+	s->gpio.get_direction	= max310x_gpio_get_direction;
 	s->gpio.direction_input	= max310x_gpio_direction_input;
 	s->gpio.get		= max310x_gpio_get;
 	s->gpio.direction_output= max310x_gpio_direction_output;
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 758537381d77..e177df2c4ea2 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -237,7 +237,8 @@
 
 /* IOControl register bits (Only 750/760) */
 #define SC16IS7XX_IOCONTROL_LATCH_BIT	(1 << 0) /* Enable input latching */
-#define SC16IS7XX_IOCONTROL_MODEM_BIT	(1 << 1) /* Enable GPIO[7:4] as modem pins */
+#define SC16IS7XX_IOCONTROL_MODEM_A_BIT	(1 << 1) /* Enable GPIO[7:4] as modem A pins */
+#define SC16IS7XX_IOCONTROL_MODEM_B_BIT	(1 << 2) /* Enable GPIO[3:0] as modem B pins */
 #define SC16IS7XX_IOCONTROL_SRESET_BIT	(1 << 3) /* Software Reset */
 
 /* EFCR register bits */
@@ -294,6 +295,7 @@
 /* Misc definitions */
 #define SC16IS7XX_FIFO_SIZE		(64)
 #define SC16IS7XX_REG_SHIFT		2
+#define SC16IS7XX_GPIOS_PER_BANK	4
 
 struct sc16is7xx_devtype {
 	char	name[10];
@@ -307,7 +309,8 @@ struct sc16is7xx_devtype {
 
 struct sc16is7xx_one_config {
 	unsigned int			flags;
-	u8				ier_clear;
+	u8				ier_mask;
+	u8				ier_val;
 };
 
 struct sc16is7xx_one {
@@ -325,7 +328,9 @@ struct sc16is7xx_port {
 	struct clk			*clk;
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip		gpio;
+	unsigned long			gpio_valid_mask;
 #endif
+	u8				mctrl_mask;
 	unsigned char			buf[SC16IS7XX_FIFO_SIZE];
 	struct kthread_worker		kworker;
 	struct task_struct		*kworker_task;
@@ -341,6 +346,9 @@ static struct uart_driver sc16is7xx_uart = {
 	.nr		= SC16IS7XX_MAX_DEVS,
 };
 
+static void sc16is7xx_ier_set(struct uart_port *port, u8 bit);
+static void sc16is7xx_stop_tx(struct uart_port *port);
+
 #define to_sc16is7xx_port(p,e)	((container_of((p), struct sc16is7xx_port, e)))
 #define to_sc16is7xx_one(p,e)	((container_of((p), struct sc16is7xx_one, e)))
 
@@ -650,6 +658,7 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	struct circ_buf *xmit = &port->state->xmit;
 	unsigned int txlen, to_send, i;
+	unsigned long flags;
 
 	if (unlikely(port->x_char)) {
 		sc16is7xx_port_write(port, SC16IS7XX_THR_REG, port->x_char);
@@ -658,8 +667,12 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 		return;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+		spin_lock_irqsave(&port->lock, flags);
+		sc16is7xx_stop_tx(port);
+		spin_unlock_irqrestore(&port->lock, flags);
 		return;
+	}
 
 	/* Get length of data pending in circular buffer */
 	to_send = uart_circ_chars_pending(xmit);
@@ -686,8 +699,13 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 		sc16is7xx_fifo_write(port, to_send);
 	}
 
+	spin_lock_irqsave(&port->lock, flags);
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
+
+	if (uart_circ_empty(xmit))
+		sc16is7xx_stop_tx(port);
+	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
@@ -762,6 +780,7 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 {
 	struct uart_port *port = &(to_sc16is7xx_one(ws, tx_work)->port);
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
+	unsigned long flags;
 
 	if ((port->rs485.flags & SER_RS485_ENABLED) &&
 	    (port->rs485.delay_rts_before_send > 0))
@@ -770,6 +789,10 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 	mutex_lock(&s->efr_lock);
 	sc16is7xx_handle_tx(port);
 	mutex_unlock(&s->efr_lock);
+
+	spin_lock_irqsave(&port->lock, flags);
+	sc16is7xx_ier_set(port, SC16IS7XX_IER_THRI_BIT);
+	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static void sc16is7xx_reconf_rs485(struct uart_port *port)
@@ -819,7 +842,7 @@ static void sc16is7xx_reg_proc(struct kthread_work *ws)
 	}
 	if (config.flags & SC16IS7XX_RECONF_IER)
 		sc16is7xx_port_update(&one->port, SC16IS7XX_IER_REG,
-				      config.ier_clear, 0);
+				      config.ier_mask, config.ier_val);
 
 	if (config.flags & SC16IS7XX_RECONF_RS485)
 		sc16is7xx_reconf_rs485(&one->port);
@@ -830,8 +853,24 @@ static void sc16is7xx_ier_clear(struct uart_port *port, u8 bit)
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
+	lockdep_assert_held_once(&port->lock);
+
+	one->config.flags |= SC16IS7XX_RECONF_IER;
+	one->config.ier_mask |= bit;
+	one->config.ier_val &= ~bit;
+	kthread_queue_work(&s->kworker, &one->reg_work);
+}
+
+static void sc16is7xx_ier_set(struct uart_port *port, u8 bit)
+{
+	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+
+	lockdep_assert_held_once(&port->lock);
+
 	one->config.flags |= SC16IS7XX_RECONF_IER;
-	one->config.ier_clear |= bit;
+	one->config.ier_mask |= bit;
+	one->config.ier_val |= bit;
 	kthread_queue_work(&s->kworker, &one->reg_work);
 }
 
@@ -1059,8 +1098,8 @@ static int sc16is7xx_startup(struct uart_port *port)
 			      SC16IS7XX_EFCR_TXDISABLE_BIT,
 			      0);
 
-	/* Enable RX, TX interrupts */
-	val = SC16IS7XX_IER_RDI_BIT | SC16IS7XX_IER_THRI_BIT;
+	/* Enable RX interrupt */
+	val = SC16IS7XX_IER_RDI_BIT;
 	sc16is7xx_port_write(port, SC16IS7XX_IER_REG, val);
 
 	return 0;
@@ -1165,6 +1204,17 @@ static void sc16is7xx_gpio_set(struct gpio_chip *chip, unsigned offset, int val)
 			      val ? BIT(offset) : 0);
 }
 
+static int sc16is7xx_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	struct sc16is7xx_port *s = gpiochip_get_data(chip);
+	struct uart_port *port = &s->p[0].port;
+	unsigned int val;
+
+	val = sc16is7xx_port_read(port, SC16IS7XX_IODIR_REG);
+
+	return val & BIT(offset) ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
+}
+
 static int sc16is7xx_gpio_direction_input(struct gpio_chip *chip,
 					  unsigned offset)
 {
@@ -1202,8 +1252,105 @@ static int sc16is7xx_gpio_direction_output(struct gpio_chip *chip,
 
 	return 0;
 }
+
+static int sc16is7xx_gpio_init_valid_mask(struct gpio_chip *chip,
+					  unsigned long *valid_mask,
+					  unsigned int ngpios)
+{
+	struct sc16is7xx_port *s = gpiochip_get_data(chip);
+
+	*valid_mask = s->gpio_valid_mask;
+
+	return 0;
+}
+
+static int sc16is7xx_setup_gpio_chip(struct sc16is7xx_port *s)
+{
+	struct device *dev = s->p[0].port.dev;
+
+	if (!s->devtype->nr_gpio)
+		return 0;
+
+	switch (s->mctrl_mask) {
+	case 0:
+		s->gpio_valid_mask = GENMASK(7, 0);
+		break;
+	case SC16IS7XX_IOCONTROL_MODEM_A_BIT:
+		s->gpio_valid_mask = GENMASK(3, 0);
+		break;
+	case SC16IS7XX_IOCONTROL_MODEM_B_BIT:
+		s->gpio_valid_mask = GENMASK(7, 4);
+		break;
+	default:
+		break;
+	}
+
+	if (s->gpio_valid_mask == 0)
+		return 0;
+
+	s->gpio.owner		 = THIS_MODULE;
+	s->gpio.parent		 = dev;
+	s->gpio.label		 = dev_name(dev);
+	s->gpio.init_valid_mask	 = sc16is7xx_gpio_init_valid_mask;
+	s->gpio.get_direction	 = sc16is7xx_gpio_get_direction;
+	s->gpio.direction_input	 = sc16is7xx_gpio_direction_input;
+	s->gpio.get		 = sc16is7xx_gpio_get;
+	s->gpio.direction_output = sc16is7xx_gpio_direction_output;
+	s->gpio.set		 = sc16is7xx_gpio_set;
+	s->gpio.base		 = -1;
+	s->gpio.ngpio		 = s->devtype->nr_gpio;
+	s->gpio.can_sleep	 = 1;
+
+	return gpiochip_add_data(&s->gpio, s);
+}
 #endif
 
+/*
+ * Configure ports designated to operate as modem control lines.
+ */
+static int sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s)
+{
+	int i;
+	int ret;
+	int count;
+	u32 mctrl_port[2];
+	struct device *dev = s->p[0].port.dev;
+
+	count = device_property_count_u32(dev, "nxp,modem-control-line-ports");
+	if (count < 0 || count > ARRAY_SIZE(mctrl_port))
+		return 0;
+
+	ret = device_property_read_u32_array(dev, "nxp,modem-control-line-ports",
+					     mctrl_port, count);
+	if (ret)
+		return ret;
+
+	s->mctrl_mask = 0;
+
+	for (i = 0; i < count; i++) {
+		/* Use GPIO lines as modem control lines */
+		if (mctrl_port[i] == 0)
+			s->mctrl_mask |= SC16IS7XX_IOCONTROL_MODEM_A_BIT;
+		else if (mctrl_port[i] == 1)
+			s->mctrl_mask |= SC16IS7XX_IOCONTROL_MODEM_B_BIT;
+	}
+
+	if (s->mctrl_mask)
+		regmap_update_bits(
+			s->regmap,
+			SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
+			SC16IS7XX_IOCONTROL_MODEM_A_BIT |
+			SC16IS7XX_IOCONTROL_MODEM_B_BIT, s->mctrl_mask);
+
+	return 0;
+}
+
+static const struct serial_rs485 sc16is7xx_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND,
+	.delay_rts_before_send = 1,
+	.delay_rts_after_send = 1,	/* Not supported but keep returning -EINVAL */
+};
+
 static int sc16is7xx_probe(struct device *dev,
 			   const struct sc16is7xx_devtype *devtype,
 			   struct regmap *regmap, int irq)
@@ -1291,6 +1438,7 @@ static int sc16is7xx_probe(struct device *dev,
 		s->p[i].port.iotype	= UPIO_PORT;
 		s->p[i].port.uartclk	= freq;
 		s->p[i].port.rs485_config = sc16is7xx_config_rs485;
+		s->p[i].port.rs485_supported = &sc16is7xx_rs485_supported;
 		s->p[i].port.ops	= &sc16is7xx_ops;
 		s->p[i].port.line	= sc16is7xx_alloc_line();
 		if (s->p[i].port.line >= SC16IS7XX_MAX_DEVS) {
@@ -1304,6 +1452,7 @@ static int sc16is7xx_probe(struct device *dev,
 		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_EFCR_REG,
 				     SC16IS7XX_EFCR_RXDISABLE_BIT |
 				     SC16IS7XX_EFCR_TXDISABLE_BIT);
+
 		/* Initialize kthread work structs */
 		kthread_init_work(&s->p[i].tx_work, sc16is7xx_tx_proc);
 		kthread_init_work(&s->p[i].reg_work, sc16is7xx_reg_proc);
@@ -1340,23 +1489,14 @@ static int sc16is7xx_probe(struct device *dev,
 				s->p[u].irda_mode = true;
 	}
 
+	ret = sc16is7xx_setup_mctrl_ports(s);
+	if (ret)
+		goto out_ports;
+
 #ifdef CONFIG_GPIOLIB
-	if (devtype->nr_gpio) {
-		/* Setup GPIO cotroller */
-		s->gpio.owner		 = THIS_MODULE;
-		s->gpio.parent		 = dev;
-		s->gpio.label		 = dev_name(dev);
-		s->gpio.direction_input	 = sc16is7xx_gpio_direction_input;
-		s->gpio.get		 = sc16is7xx_gpio_get;
-		s->gpio.direction_output = sc16is7xx_gpio_direction_output;
-		s->gpio.set		 = sc16is7xx_gpio_set;
-		s->gpio.base		 = -1;
-		s->gpio.ngpio		 = devtype->nr_gpio;
-		s->gpio.can_sleep	 = 1;
-		ret = gpiochip_add_data(&s->gpio, s);
-		if (ret)
-			goto out_thread;
-	}
+	ret = sc16is7xx_setup_gpio_chip(s);
+	if (ret)
+		goto out_ports;
 #endif
 
 	/*
@@ -1379,10 +1519,8 @@ static int sc16is7xx_probe(struct device *dev,
 		return 0;
 
 #ifdef CONFIG_GPIOLIB
-	if (devtype->nr_gpio)
+	if (s->gpio_valid_mask)
 		gpiochip_remove(&s->gpio);
-
-out_thread:
 #endif
 
 out_ports:
@@ -1406,7 +1544,7 @@ static int sc16is7xx_remove(struct device *dev)
 	int i;
 
 #ifdef CONFIG_GPIOLIB
-	if (s->devtype->nr_gpio)
+	if (s->gpio_valid_mask)
 		gpiochip_remove(&s->gpio);
 #endif
 
diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index cbab39a5e753..0db98fc40b15 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -2065,31 +2065,158 @@ static int tcm_bind(struct usb_configuration *c, struct usb_function *f)
 	return -ENOTSUPP;
 }
 
-struct guas_setup_wq {
-	struct work_struct work;
-	struct f_uas *fu;
-	unsigned int alt;
-};
+static void tcm_cleanup_old_alt(struct f_uas *fu)
+{
+	if (fu->flags & USBG_IS_UAS)
+		uasp_cleanup_old_alt(fu);
+	else if (fu->flags & USBG_IS_BOT)
+		bot_cleanup_old_alt(fu);
+	fu->flags = 0;
+}
+
+static void tcm_delayed_set_alt_done(struct f_uas *fu)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
+	fu->delayed_set_alt_state = USBG_DELAYED_SET_ALT_IDLE;
+	fu->delayed_set_alt_cancel = false;
+	spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
+}
+
+static bool tcm_delayed_set_alt_cancelled(struct f_uas *fu)
+{
+	bool cancelled;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
+	cancelled = fu->delayed_set_alt_cancel;
+	spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
+
+	return cancelled;
+}
+
+static bool tcm_complete_delayed_status(struct f_uas *fu)
+{
+	struct usb_composite_dev *cdev = fu->function.config->cdev;
+	struct usb_request *req = cdev->req;
+	unsigned long cdev_flags;
+	bool cancelled;
+	int ret;
+
+	spin_lock_irqsave(&cdev->lock, cdev_flags);
+	spin_lock(&fu->delayed_set_alt_lock);
+	cancelled = fu->delayed_set_alt_cancel;
+	if (!cancelled) {
+		fu->delayed_set_alt_state = USBG_DELAYED_SET_ALT_IDLE;
+		fu->delayed_set_alt_cancel = false;
+	}
+	spin_unlock(&fu->delayed_set_alt_lock);
+
+	if (cancelled) {
+		spin_unlock_irqrestore(&cdev->lock, cdev_flags);
+		return false;
+	}
+
+	if (cdev->delayed_status == 0) {
+		WARN(cdev, "%s: Unexpected call\n", __func__);
+	} else if (--cdev->delayed_status == 0) {
+		req->length = 0;
+		req->context = cdev;
+		ret = usb_ep_queue(cdev->gadget->ep0, req, GFP_ATOMIC);
+		if (ret == 0) {
+			cdev->setup_pending = true;
+		} else {
+			req->status = 0;
+			req->complete(cdev->gadget->ep0, req);
+		}
+	}
+
+	spin_unlock_irqrestore(&cdev->lock, cdev_flags);
+
+	return true;
+}
+
+static bool tcm_cancel_delayed_set_alt(struct f_uas *fu)
+{
+	bool cleanup = false;
+	bool cancel = false;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
+	switch (fu->delayed_set_alt_state) {
+	case USBG_DELAYED_SET_ALT_IDLE:
+		cleanup = true;
+		break;
+	case USBG_DELAYED_SET_ALT_QUEUED:
+	case USBG_DELAYED_SET_ALT_RUNNING:
+		fu->delayed_set_alt_cancel = true;
+		cancel = true;
+		break;
+	}
+	spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
+
+	if (cancel && cancel_work(&fu->delayed_set_alt)) {
+		spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
+		if (fu->delayed_set_alt_state == USBG_DELAYED_SET_ALT_QUEUED) {
+			fu->delayed_set_alt_state = USBG_DELAYED_SET_ALT_IDLE;
+			fu->delayed_set_alt_cancel = false;
+			cleanup = true;
+		}
+		spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
+	}
+
+	return cleanup;
+}
+
+static void tcm_cancel_delayed_set_alt_sync(struct f_uas *fu)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
+	if (fu->delayed_set_alt_state != USBG_DELAYED_SET_ALT_IDLE)
+		fu->delayed_set_alt_cancel = true;
+	spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
+
+	cancel_work_sync(&fu->delayed_set_alt);
+
+	spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
+	fu->delayed_set_alt_state = USBG_DELAYED_SET_ALT_IDLE;
+	fu->delayed_set_alt_cancel = false;
+	spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
+}
 
 static void tcm_delayed_set_alt(struct work_struct *wq)
 {
-	struct guas_setup_wq *work = container_of(wq, struct guas_setup_wq,
-			work);
-	struct f_uas *fu = work->fu;
-	int alt = work->alt;
+	struct f_uas *fu = container_of(wq, struct f_uas, delayed_set_alt);
+	unsigned long flags;
+	unsigned int alt;
 
-	kfree(work);
+	spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
+	if (fu->delayed_set_alt_state != USBG_DELAYED_SET_ALT_QUEUED) {
+		spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
+		return;
+	}
+	fu->delayed_set_alt_state = USBG_DELAYED_SET_ALT_RUNNING;
+	alt = fu->delayed_alt;
+	spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
 
-	if (fu->flags & USBG_IS_BOT)
-		bot_cleanup_old_alt(fu);
-	if (fu->flags & USBG_IS_UAS)
-		uasp_cleanup_old_alt(fu);
+	tcm_cleanup_old_alt(fu);
+
+	if (tcm_delayed_set_alt_cancelled(fu))
+		goto out_done;
 
 	if (alt == USB_G_ALT_INT_BBB)
 		bot_set_alt(fu);
 	else if (alt == USB_G_ALT_INT_UAS)
 		uasp_set_alt(fu);
-	usb_composite_setup_continue(fu->function.config->cdev);
+
+	if (tcm_complete_delayed_status(fu))
+		return;
+
+	tcm_cleanup_old_alt(fu);
+out_done:
+	tcm_delayed_set_alt_done(fu);
 }
 
 static int tcm_get_alt(struct usb_function *f, unsigned intf)
@@ -2115,15 +2242,20 @@ static int tcm_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 		return -EOPNOTSUPP;
 
 	if ((alt == USB_G_ALT_INT_BBB) || (alt == USB_G_ALT_INT_UAS)) {
-		struct guas_setup_wq *work;
+		unsigned long flags;
 
-		work = kmalloc(sizeof(*work), GFP_ATOMIC);
-		if (!work)
-			return -ENOMEM;
-		INIT_WORK(&work->work, tcm_delayed_set_alt);
-		work->fu = fu;
-		work->alt = alt;
-		schedule_work(&work->work);
+		spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
+		if (fu->delayed_set_alt_state != USBG_DELAYED_SET_ALT_IDLE) {
+			spin_unlock_irqrestore(&fu->delayed_set_alt_lock,
+					       flags);
+			return -EBUSY;
+		}
+		fu->delayed_alt = alt;
+		fu->delayed_set_alt_cancel = false;
+		fu->delayed_set_alt_state = USBG_DELAYED_SET_ALT_QUEUED;
+		spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
+
+		schedule_work(&fu->delayed_set_alt);
 		return USB_GADGET_DELAYED_STATUS;
 	}
 	return -EOPNOTSUPP;
@@ -2133,11 +2265,8 @@ static void tcm_disable(struct usb_function *f)
 {
 	struct f_uas *fu = to_f_uas(f);
 
-	if (fu->flags & USBG_IS_UAS)
-		uasp_cleanup_old_alt(fu);
-	else if (fu->flags & USBG_IS_BOT)
-		bot_cleanup_old_alt(fu);
-	fu->flags = 0;
+	if (tcm_cancel_delayed_set_alt(fu))
+		tcm_cleanup_old_alt(fu);
 }
 
 static int tcm_setup(struct usb_function *f,
@@ -2285,11 +2414,16 @@ static void tcm_free(struct usb_function *f)
 {
 	struct f_uas *tcm = to_f_uas(f);
 
+	tcm_cancel_delayed_set_alt_sync(tcm);
 	kfree(tcm);
 }
 
 static void tcm_unbind(struct usb_configuration *c, struct usb_function *f)
 {
+	struct f_uas *fu = to_f_uas(f);
+
+	tcm_cancel_delayed_set_alt_sync(fu);
+	tcm_cleanup_old_alt(fu);
 	usb_free_all_descriptors(f);
 }
 
@@ -2322,6 +2456,8 @@ static struct usb_function *tcm_alloc(struct usb_function_instance *fi)
 	fu->function.disable = tcm_disable;
 	fu->function.free_func = tcm_free;
 	fu->tpg = tpg_instances[i].tpg;
+	INIT_WORK(&fu->delayed_set_alt, tcm_delayed_set_alt);
+	spin_lock_init(&fu->delayed_set_alt_lock);
 	mutex_unlock(&tpg_instances_lock);
 
 	return &fu->function;
diff --git a/drivers/usb/gadget/function/tcm.h b/drivers/usb/gadget/function/tcm.h
index 3cd565794ad7..6c9bdbeed3c8 100644
--- a/drivers/usb/gadget/function/tcm.h
+++ b/drivers/usb/gadget/function/tcm.h
@@ -3,6 +3,7 @@
 #define __TARGET_USB_GADGET_H__
 
 #include <linux/kref.h>
+#include <linux/spinlock.h>
 /* #include <linux/usb/uas.h> */
 #include <linux/usb/composite.h>
 #include <linux/usb/uas.h>
@@ -26,6 +27,12 @@ enum {
 
 #define USB_G_DEFAULT_SESSION_TAGS	128
 
+enum {
+	USBG_DELAYED_SET_ALT_IDLE = 0,
+	USBG_DELAYED_SET_ALT_QUEUED,
+	USBG_DELAYED_SET_ALT_RUNNING,
+};
+
 struct tcm_usbg_nexus {
 	struct se_session *tvn_se_sess;
 };
@@ -117,6 +124,12 @@ struct f_uas {
 #define USBG_IS_BOT		(1 << 3)
 #define USBG_BOT_CMD_PEND	(1 << 4)
 
+	struct work_struct	delayed_set_alt;
+	spinlock_t		delayed_set_alt_lock; /* protects delayed_set_alt_* */
+	unsigned int		delayed_alt;
+	unsigned int		delayed_set_alt_state;
+	bool			delayed_set_alt_cancel;
+
 	struct usbg_cdb		cmd;
 	struct usb_ep		*ep_in;
 	struct usb_ep		*ep_out;
diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index 69d11b703c8d..d9383b0f4d15 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -586,9 +586,29 @@ static int bdc_probe(struct platform_device *pdev)
 static int bdc_remove(struct platform_device *pdev)
 {
 	struct bdc *bdc;
+	unsigned long flags;
+	u32 temp;
 
 	bdc  = platform_get_drvdata(pdev);
 	dev_dbg(bdc->dev, "%s ()\n", __func__);
+	/*
+	 * Disable the device interrupt source before freeing the IRQ:
+	 * clear BDC_GIE so the controller stops asserting interrupts,
+	 * then free_irq drains any in-flight handler.
+	 */
+	spin_lock_irqsave(&bdc->lock, flags);
+	temp = bdc_readl(bdc->regs, BDC_BDCSC);
+	temp &= ~BDC_GIE;
+	bdc_writel(bdc->regs, BDC_BDCSC, temp);
+	spin_unlock_irqrestore(&bdc->lock, flags);
+	free_irq(bdc->irq, bdc);
+	/*
+	 * Drain func_wake_notify after free_irq: the IRQ handler arms this
+	 * delayed_work via bdc_sr_uspc -> handle_link_state_change ->
+	 * schedule_delayed_work (self-rearmed in bdc_func_wake_timer), so
+	 * the IRQ must be released first to prevent re-arm after cancel.
+	 */
+	cancel_delayed_work_sync(&bdc->func_wake_notify);
 	bdc_udc_exit(bdc);
 	bdc_hw_exit(bdc);
 	bdc_phy_exit(bdc);
diff --git a/drivers/usb/gadget/udc/bdc/bdc_udc.c b/drivers/usb/gadget/udc/bdc/bdc_udc.c
index 5f0b3fd93631..5a0e011065c2 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_udc.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_udc.c
@@ -530,8 +530,8 @@ int bdc_udc_init(struct bdc *bdc)
 
 
 	bdc->gadget.name = BRCM_BDC_NAME;
-	ret = devm_request_irq(bdc->dev, bdc->irq, bdc_udc_interrupt,
-				IRQF_SHARED , BRCM_BDC_NAME, bdc);
+	ret = request_irq(bdc->irq, bdc_udc_interrupt, IRQF_SHARED,
+			  BRCM_BDC_NAME, bdc);
 	if (ret) {
 		dev_err(bdc->dev,
 			"failed to request irq #%d %d\n",
@@ -542,7 +542,7 @@ int bdc_udc_init(struct bdc *bdc)
 	ret = bdc_init_ep(bdc);
 	if (ret) {
 		dev_err(bdc->dev, "bdc init ep fail: %d\n", ret);
-		return ret;
+		goto err0;
 	}
 
 	ret = usb_add_gadget_udc(bdc->dev, &bdc->gadget);
@@ -571,6 +571,7 @@ int bdc_udc_init(struct bdc *bdc)
 err1:
 	usb_del_gadget_udc(&bdc->gadget);
 err0:
+	free_irq(bdc->irq, bdc);
 	bdc_free_ep(bdc);
 
 	return ret;
diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index aec32bf06e01..21dfd9bdc150 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -5,12 +5,12 @@
  * Copyright (C) 1999 - 2001 Greg Kroah-Hartman	<greg@kroah.com>
  * Copyright (C) 1999, 2000 Brian Warner	<warner@lothar.com>
  * Copyright (C) 2000 Al Borchers		<borchers@steinerpoint.com>
+ * Copyright (C) 2020 Johan Hovold <johan@kernel.org>
  *
  * See Documentation/usb/usb-serial.rst for more information on using this
  * driver
  */
 
-
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
@@ -37,19 +37,21 @@
 	#undef XIRCOM
 #endif
 
-#define DRIVER_AUTHOR "Brian Warner <warner@lothar.com>"
+#define DRIVER_AUTHOR "Brian Warner <warner@lothar.com>, Johan Hovold <johan@kernel.org>"
 #define DRIVER_DESC "USB Keyspan PDA Converter driver"
 
 #define KEYSPAN_TX_THRESHOLD	16
 
 struct keyspan_pda_private {
 	int			tx_room;
-	int			tx_throttled;
 	struct work_struct	unthrottle_work;
 	struct usb_serial	*serial;
 	struct usb_serial_port	*port;
+	bool			throttled;
+	bool			throttle_req;
 };
 
+static int keyspan_pda_write_start(struct usb_serial_port *port);
 
 #define KEYSPAN_VENDOR_ID		0x06cd
 #define KEYSPAN_PDA_FAKE_ID		0x0103
@@ -98,15 +100,57 @@ static const struct usb_device_id id_table_fake_xircom[] = {
 };
 #endif
 
+static int keyspan_pda_get_write_room(struct keyspan_pda_private *priv)
+{
+	struct usb_serial_port *port = priv->port;
+	struct usb_serial *serial = priv->serial;
+	u8 *room;
+	int rc;
+
+	room = kmalloc(1, GFP_KERNEL);
+	if (!room)
+		return -ENOMEM;
+
+	rc = usb_control_msg(serial->dev,
+			     usb_rcvctrlpipe(serial->dev, 0),
+			     6, /* write_room */
+			     USB_TYPE_VENDOR | USB_RECIP_INTERFACE
+			     | USB_DIR_IN,
+			     0, /* value: 0 means "remaining room" */
+			     0, /* index */
+			     room,
+			     1,
+			     2000);
+	if (rc != 1) {
+		if (rc >= 0)
+			rc = -EIO;
+		dev_dbg(&port->dev, "roomquery failed: %d\n", rc);
+		goto out_free;
+	}
+
+	dev_dbg(&port->dev, "roomquery says %d\n", *room);
+	rc = *room;
+out_free:
+	kfree(room);
+
+	return rc;
+}
+
 static void keyspan_pda_request_unthrottle(struct work_struct *work)
 {
 	struct keyspan_pda_private *priv =
 		container_of(work, struct keyspan_pda_private, unthrottle_work);
+	struct usb_serial_port *port = priv->port;
 	struct usb_serial *serial = priv->serial;
+	unsigned long flags;
 	int result;
 
-	/* ask the device to tell us when the tx buffer becomes
-	   sufficiently empty */
+	dev_dbg(&port->dev, "%s\n", __func__);
+
+	/*
+	 * Ask the device to tell us when the tx buffer becomes
+	 * sufficiently empty.
+	 */
 	result = usb_control_msg(serial->dev,
 				 usb_sndctrlpipe(serial->dev, 0),
 				 7, /* request_unthrottle */
@@ -120,8 +164,19 @@ static void keyspan_pda_request_unthrottle(struct work_struct *work)
 	if (result < 0)
 		dev_dbg(&serial->dev->dev, "%s - error %d from usb_control_msg\n",
 			__func__, result);
-}
+	/*
+	 * Need to check available space after requesting notification in case
+	 * buffer is already empty so that no notification is sent.
+	 */
+	result = keyspan_pda_get_write_room(priv);
+	if (result > KEYSPAN_TX_THRESHOLD) {
+		spin_lock_irqsave(&port->lock, flags);
+		priv->tx_room = max(priv->tx_room, result);
+		spin_unlock_irqrestore(&port->lock, flags);
 
+		usb_serial_port_softint(port);
+	}
+}
 
 static void keyspan_pda_rx_interrupt(struct urb *urb)
 {
@@ -131,6 +186,7 @@ static void keyspan_pda_rx_interrupt(struct urb *urb)
 	int retval;
 	int status = urb->status;
 	struct keyspan_pda_private *priv;
+	bool throttled = false;
 	unsigned long flags;
 
 	priv = usb_get_serial_port_data(port);
@@ -176,10 +232,11 @@ static void keyspan_pda_rx_interrupt(struct urb *urb)
 			break;
 		case 2: /* tx unthrottle interrupt */
 			spin_lock_irqsave(&port->lock, flags);
-			priv->tx_throttled = 0;
 			priv->tx_room = max(priv->tx_room, KEYSPAN_TX_THRESHOLD);
 			spin_unlock_irqrestore(&port->lock, flags);
-			/* queue up a wakeup at scheduler time */
+
+			keyspan_pda_write_start(port);
+
 			usb_serial_port_softint(port);
 			break;
 		default:
@@ -191,38 +248,58 @@ static void keyspan_pda_rx_interrupt(struct urb *urb)
 	}
 
 exit:
-	retval = usb_submit_urb(urb, GFP_ATOMIC);
-	if (retval)
-		dev_err(&port->dev,
-			"%s - usb_submit_urb failed with result %d\n",
-			__func__, retval);
-}
+	spin_lock_irqsave(&port->lock, flags);
+	if (priv->throttle_req) {
+		priv->throttled = true;
+		throttled = true;
+	}
+	spin_unlock_irqrestore(&port->lock, flags);
 
+	if (!throttled) {
+		retval = usb_submit_urb(urb, GFP_ATOMIC);
+		if (retval)
+			dev_err(&port->dev, "failed to resubmit in urb: %d\n", retval);
+	}
+}
 
 static void keyspan_pda_rx_throttle(struct tty_struct *tty)
 {
-	/* stop receiving characters. We just turn off the URB request, and
-	   let chars pile up in the device. If we're doing hardware
-	   flowcontrol, the device will signal the other end when its buffer
-	   fills up. If we're doing XON/XOFF, this would be a good time to
-	   send an XOFF, although it might make sense to foist that off
-	   upon the device too. */
 	struct usb_serial_port *port = tty->driver_data;
+	struct keyspan_pda_private *priv = usb_get_serial_port_data(port);
 
-	usb_kill_urb(port->interrupt_in_urb);
+	/*
+	 * Stop receiving characters. We just turn off the URB request, and
+	 * let chars pile up in the device. If we're doing hardware
+	 * flowcontrol, the device will signal the other end when its buffer
+	 * fills up. If we're doing XON/XOFF, this would be a good time to
+	 * send an XOFF, although it might make sense to foist that off upon
+	 * the device too.
+	 */
+	spin_lock_irq(&port->lock);
+	priv->throttle_req = true;
+	spin_unlock_irq(&port->lock);
 }
 
-
 static void keyspan_pda_rx_unthrottle(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
-	/* just restart the receive interrupt URB */
-
-	if (usb_submit_urb(port->interrupt_in_urb, GFP_KERNEL))
-		dev_dbg(&port->dev, "usb_submit_urb(read urb) failed\n");
+	struct keyspan_pda_private *priv = usb_get_serial_port_data(port);
+	bool throttled;
+	int ret;
+
+	spin_lock_irq(&port->lock);
+	throttled = priv->throttled;
+	priv->throttled = false;
+	priv->throttle_req = false;
+	spin_unlock_irq(&port->lock);
+
+	if (throttled) {
+		ret = usb_submit_urb(port->interrupt_in_urb, GFP_KERNEL);
+		if (ret)
+			dev_err(&port->dev, "failed to submit in urb: %d\n", ret);
+	}
 }
 
-
 static speed_t keyspan_pda_setbaud(struct usb_serial *serial, speed_t baud)
 {
 	int rc;
@@ -264,8 +341,6 @@ static speed_t keyspan_pda_setbaud(struct usb_serial *serial, speed_t baud)
 		baud = 9600;
 	}
 
-	/* rather than figure out how to sleep while waiting for this
-	   to complete, I just use the "legacy" API. */
 	rc = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
 			     0, /* set baud */
 			     USB_TYPE_VENDOR
@@ -278,10 +353,10 @@ static speed_t keyspan_pda_setbaud(struct usb_serial *serial, speed_t baud)
 			     2000); /* timeout */
 	if (rc < 0)
 		return 0;
+
 	return baud;
 }
 
-
 static void keyspan_pda_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
@@ -293,6 +368,7 @@ static void keyspan_pda_break_ctl(struct tty_struct *tty, int break_state)
 		value = 1; /* start break */
 	else
 		value = 0; /* clear break */
+
 	result = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
 			4, /* set break */
 			USB_TYPE_VENDOR | USB_RECIP_INTERFACE | USB_DIR_OUT,
@@ -300,39 +376,35 @@ static void keyspan_pda_break_ctl(struct tty_struct *tty, int break_state)
 	if (result < 0)
 		dev_dbg(&port->dev, "%s - error %d from usb_control_msg\n",
 			__func__, result);
-	/* there is something funky about this.. the TCSBRK that 'cu' performs
-	   ought to translate into a break_ctl(-1),break_ctl(0) pair HZ/4
-	   seconds apart, but it feels like the break sent isn't as long as it
-	   is on /dev/ttyS0 */
 }
 
-
 static void keyspan_pda_set_termios(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
 	struct usb_serial *serial = port->serial;
 	speed_t speed;
 
-	/* cflag specifies lots of stuff: number of stop bits, parity, number
-	   of data bits, baud. What can the device actually handle?:
-	   CSTOPB (1 stop bit or 2)
-	   PARENB (parity)
-	   CSIZE (5bit .. 8bit)
-	   There is minimal hw support for parity (a PSW bit seems to hold the
-	   parity of whatever is in the accumulator). The UART either deals
-	   with 10 bits (start, 8 data, stop) or 11 bits (start, 8 data,
-	   1 special, stop). So, with firmware changes, we could do:
-	   8N1: 10 bit
-	   8N2: 11 bit, extra bit always (mark?)
-	   8[EOMS]1: 11 bit, extra bit is parity
-	   7[EOMS]1: 10 bit, b0/b7 is parity
-	   7[EOMS]2: 11 bit, b0/b7 is parity, extra bit always (mark?)
-
-	   HW flow control is dictated by the tty->termios.c_cflags & CRTSCTS
-	   bit.
-
-	   For now, just do baud. */
-
+	/*
+	 * cflag specifies lots of stuff: number of stop bits, parity, number
+	 * of data bits, baud. What can the device actually handle?:
+	 * CSTOPB (1 stop bit or 2)
+	 * PARENB (parity)
+	 * CSIZE (5bit .. 8bit)
+	 * There is minimal hw support for parity (a PSW bit seems to hold the
+	 * parity of whatever is in the accumulator). The UART either deals
+	 * with 10 bits (start, 8 data, stop) or 11 bits (start, 8 data,
+	 * 1 special, stop). So, with firmware changes, we could do:
+	 * 8N1: 10 bit
+	 * 8N2: 11 bit, extra bit always (mark?)
+	 * 8[EOMS]1: 11 bit, extra bit is parity
+	 * 7[EOMS]1: 10 bit, b0/b7 is parity
+	 * 7[EOMS]2: 11 bit, b0/b7 is parity, extra bit always (mark?)
+	 *
+	 * HW flow control is dictated by the tty->termios.c_cflags & CRTSCTS
+	 * bit.
+	 *
+	 * For now, just do baud.
+	 */
 	speed = tty_get_baud_rate(tty);
 	speed = keyspan_pda_setbaud(serial, speed);
 
@@ -341,17 +413,19 @@ static void keyspan_pda_set_termios(struct tty_struct *tty,
 		/* It hasn't changed so.. */
 		speed = tty_termios_baud_rate(old_termios);
 	}
-	/* Only speed can change so copy the old h/w parameters
-	   then encode the new speed */
+	/*
+	 * Only speed can change so copy the old h/w parameters then encode
+	 * the new speed.
+	 */
 	tty_termios_copy_hw(&tty->termios, old_termios);
 	tty_encode_baud_rate(tty, speed, speed);
 }
 
-
-/* modem control pins: DTR and RTS are outputs and can be controlled.
-   DCD, RI, DSR, CTS are inputs and can be read. All outputs can also be
-   read. The byte passed is: DTR(b7) DCD RI DSR CTS RTS(b2) unused unused */
-
+/*
+ * Modem control pins: DTR and RTS are outputs and can be controlled.
+ * DCD, RI, DSR, CTS are inputs and can be read. All outputs can also be
+ * read. The byte passed is: DTR(b7) DCD RI DSR CTS RTS(b2) unused unused.
+ */
 static int keyspan_pda_get_modem_info(struct usb_serial *serial,
 				      unsigned char *value)
 {
@@ -375,7 +449,6 @@ static int keyspan_pda_get_modem_info(struct usb_serial *serial,
 	return rc;
 }
 
-
 static int keyspan_pda_set_modem_info(struct usb_serial *serial,
 				      unsigned char value)
 {
@@ -433,170 +506,108 @@ static int keyspan_pda_tiocmset(struct tty_struct *tty,
 	return rc;
 }
 
-static int keyspan_pda_write(struct tty_struct *tty,
-	struct usb_serial_port *port, const unsigned char *buf, int count)
+static int keyspan_pda_write_start(struct usb_serial_port *port)
 {
-	struct usb_serial *serial = port->serial;
-	int request_unthrottle = 0;
-	int rc = 0;
-	struct keyspan_pda_private *priv;
+	struct keyspan_pda_private *priv = usb_get_serial_port_data(port);
 	unsigned long flags;
+	struct urb *urb;
+	int count;
+	int room;
+	int rc;
 
-	priv = usb_get_serial_port_data(port);
-	/* guess how much room is left in the device's ring buffer, and if we
-	   want to send more than that, check first, updating our notion of
-	   what is left. If our write will result in no room left, ask the
-	   device to give us an interrupt when the room available rises above
-	   a threshold, and hold off all writers (eventually, those using
-	   select() or poll() too) until we receive that unthrottle interrupt.
-	   Block if we can't write anything at all, otherwise write as much as
-	   we can. */
-	if (count == 0) {
-		dev_dbg(&port->dev, "write request of 0 bytes\n");
-		return 0;
-	}
-
-	/* we might block because of:
-	   the TX urb is in-flight (wait until it completes)
-	   the device is full (wait until it says there is room)
-	*/
+	/*
+	 * Guess how much room is left in the device's ring buffer. If our
+	 * write will result in no room left, ask the device to give us an
+	 * interrupt when the room available rises above a threshold but also
+	 * query how much room is currently available (in case our guess was
+	 * too conservative and the buffer is already empty when the
+	 * unthrottle work is scheduled).
+	 */
+
+	/*
+	 * We might block because of:
+	 * the TX urb is in-flight (wait until it completes)
+	 * the device is full (wait until it says there is room)
+	 */
 	spin_lock_irqsave(&port->lock, flags);
-	if (!test_bit(0, &port->write_urbs_free) || priv->tx_throttled) {
+
+	room = priv->tx_room;
+	count = kfifo_len(&port->write_fifo);
+
+	if (!test_bit(0, &port->write_urbs_free) || count == 0 || room == 0) {
 		spin_unlock_irqrestore(&port->lock, flags);
 		return 0;
 	}
-	clear_bit(0, &port->write_urbs_free);
-	spin_unlock_irqrestore(&port->lock, flags);
+	__clear_bit(0, &port->write_urbs_free);
 
-	/* At this point the URB is in our control, nobody else can submit it
-	   again (the only sudden transition was the one from EINPROGRESS to
-	   finished).  Also, the tx process is not throttled. So we are
-	   ready to write. */
+	if (count > room)
+		count = room;
+	if (count > port->bulk_out_size)
+		count = port->bulk_out_size;
 
-	count = (count > port->bulk_out_size) ? port->bulk_out_size : count;
+	urb = port->write_urb;
+	count = kfifo_out(&port->write_fifo, urb->transfer_buffer, count);
+	urb->transfer_buffer_length = count;
 
-	/* Check if we might overrun the Tx buffer.   If so, ask the
-	   device how much room it really has.  This is done only on
-	   scheduler time, since usb_control_msg() sleeps. */
-	if (count > priv->tx_room && !in_interrupt()) {
-		u8 *room;
+	port->tx_bytes += count;
+	priv->tx_room -= count;
 
-		room = kmalloc(1, GFP_KERNEL);
-		if (!room) {
-			rc = -ENOMEM;
-			goto exit;
-		}
-
-		rc = usb_control_msg(serial->dev,
-				     usb_rcvctrlpipe(serial->dev, 0),
-				     6, /* write_room */
-				     USB_TYPE_VENDOR | USB_RECIP_INTERFACE
-				     | USB_DIR_IN,
-				     0, /* value: 0 means "remaining room" */
-				     0, /* index */
-				     room,
-				     1,
-				     2000);
-		if (rc > 0) {
-			dev_dbg(&port->dev, "roomquery says %d\n", *room);
-			priv->tx_room = *room;
-		}
-		kfree(room);
-		if (rc < 0) {
-			dev_dbg(&port->dev, "roomquery failed\n");
-			goto exit;
-		}
-		if (rc == 0) {
-			dev_dbg(&port->dev, "roomquery returned 0 bytes\n");
-			rc = -EIO; /* device didn't return any data */
-			goto exit;
-		}
-	}
+	spin_unlock_irqrestore(&port->lock, flags);
 
-	if (count >= priv->tx_room) {
-		/* we're about to completely fill the Tx buffer, so
-		   we'll be throttled afterwards. */
-		count = priv->tx_room;
-		request_unthrottle = 1;
-	}
+	dev_dbg(&port->dev, "%s - count = %d, txroom = %d\n", __func__, count, room);
 
-	if (count) {
-		/* now transfer data */
-		memcpy(port->write_urb->transfer_buffer, buf, count);
-		/* send the data out the bulk port */
-		port->write_urb->transfer_buffer_length = count;
+	rc = usb_submit_urb(urb, GFP_ATOMIC);
+	if (rc) {
+		dev_dbg(&port->dev, "usb_submit_urb(write bulk) failed\n");
 
-		priv->tx_room -= count;
+		spin_lock_irqsave(&port->lock, flags);
+		port->tx_bytes -= count;
+		priv->tx_room = max(priv->tx_room, room + count);
+		__set_bit(0, &port->write_urbs_free);
+		spin_unlock_irqrestore(&port->lock, flags);
 
-		rc = usb_submit_urb(port->write_urb, GFP_ATOMIC);
-		if (rc) {
-			dev_dbg(&port->dev, "usb_submit_urb(write bulk) failed\n");
-			goto exit;
-		}
-	} else {
-		/* There wasn't any room left, so we are throttled until
-		   the buffer empties a bit */
-		request_unthrottle = 1;
+		return rc;
 	}
 
-	if (request_unthrottle) {
-		priv->tx_throttled = 1; /* block writers */
+	if (count == room)
 		schedule_work(&priv->unthrottle_work);
-	}
 
-	rc = count;
-exit:
-	if (rc <= 0)
-		set_bit(0, &port->write_urbs_free);
-	return rc;
+	return 0;
 }
 
-
 static void keyspan_pda_write_bulk_callback(struct urb *urb)
 {
 	struct usb_serial_port *port = urb->context;
-
-	set_bit(0, &port->write_urbs_free);
-
-	/* queue up a wakeup at scheduler time */
-	usb_serial_port_softint(port);
-}
-
-
-static int keyspan_pda_write_room(struct tty_struct *tty)
-{
-	struct usb_serial_port *port = tty->driver_data;
-	struct keyspan_pda_private *priv = usb_get_serial_port_data(port);
 	unsigned long flags;
-	int room = 0;
 
 	spin_lock_irqsave(&port->lock, flags);
-	if (test_bit(0, &port->write_urbs_free) && !priv->tx_throttled)
-		room = priv->tx_room;
+	port->tx_bytes -= urb->transfer_buffer_length;
+	__set_bit(0, &port->write_urbs_free);
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	return room;
+	keyspan_pda_write_start(port);
+
+	usb_serial_port_softint(port);
 }
 
-static int keyspan_pda_chars_in_buffer(struct tty_struct *tty)
+static int keyspan_pda_write(struct tty_struct *tty, struct usb_serial_port *port,
+		const unsigned char *buf, int count)
 {
-	struct usb_serial_port *port = tty->driver_data;
-	struct keyspan_pda_private *priv;
-	unsigned long flags;
-	int ret = 0;
+	int rc;
 
-	priv = usb_get_serial_port_data(port);
+	dev_dbg(&port->dev, "%s - count = %d\n", __func__, count);
 
-	/* when throttled, return at least WAKEUP_CHARS to tell select() (via
-	   n_tty.c:normal_poll() ) that we're not writeable. */
+	if (!count)
+		return 0;
 
-	spin_lock_irqsave(&port->lock, flags);
-	if (!test_bit(0, &port->write_urbs_free) || priv->tx_throttled)
-		ret = 256;
-	spin_unlock_irqrestore(&port->lock, flags);
-	return ret;
-}
+	count = kfifo_in_locked(&port->write_fifo, buf, count, &port->lock);
 
+	rc = keyspan_pda_write_start(port);
+	if (rc)
+		return rc;
+
+	return 0;
+}
 
 static void keyspan_pda_dtr_rts(struct usb_serial_port *port, int on)
 {
@@ -612,58 +623,46 @@ static void keyspan_pda_dtr_rts(struct usb_serial_port *port, int on)
 static int keyspan_pda_open(struct tty_struct *tty,
 					struct usb_serial_port *port)
 {
-	struct usb_serial *serial = port->serial;
-	u8 *room;
-	int rc = 0;
-	struct keyspan_pda_private *priv;
+	struct keyspan_pda_private *priv = usb_get_serial_port_data(port);
+	int rc;
 
 	/* find out how much room is in the Tx ring */
-	room = kmalloc(1, GFP_KERNEL);
-	if (!room)
-		return -ENOMEM;
+	rc = keyspan_pda_get_write_room(priv);
+	if (rc < 0)
+		return rc;
 
-	rc = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
-			     6, /* write_room */
-			     USB_TYPE_VENDOR | USB_RECIP_INTERFACE
-			     | USB_DIR_IN,
-			     0, /* value */
-			     0, /* index */
-			     room,
-			     1,
-			     2000);
-	if (rc < 0) {
-		dev_dbg(&port->dev, "%s - roomquery failed\n", __func__);
-		goto error;
-	}
-	if (rc == 0) {
-		dev_dbg(&port->dev, "%s - roomquery returned 0 bytes\n", __func__);
-		rc = -EIO;
-		goto error;
-	}
-	priv = usb_get_serial_port_data(port);
-	priv->tx_room = *room;
-	priv->tx_throttled = *room ? 0 : 1;
+	spin_lock_irq(&port->lock);
+	priv->tx_room = rc;
+	priv->throttled = false;
+	priv->throttle_req = false;
+	spin_unlock_irq(&port->lock);
 
-	/*Start reading from the device*/
 	rc = usb_submit_urb(port->interrupt_in_urb, GFP_KERNEL);
 	if (rc) {
 		dev_dbg(&port->dev, "%s - usb_submit_urb(read int) failed\n", __func__);
-		goto error;
+		return rc;
 	}
-error:
-	kfree(room);
-	return rc;
+
+	return 0;
 }
+
 static void keyspan_pda_close(struct usb_serial_port *port)
 {
 	struct keyspan_pda_private *priv = usb_get_serial_port_data(port);
 
-	usb_kill_urb(port->write_urb);
+	/*
+	 * Stop the interrupt URB first as its completion handler may submit
+	 * the write URB.
+	 */
 	usb_kill_urb(port->interrupt_in_urb);
+	usb_kill_urb(port->write_urb);
 
 	cancel_work_sync(&priv->unthrottle_work);
-}
 
+	spin_lock_irq(&port->lock);
+	kfifo_reset(&port->write_fifo);
+	spin_unlock_irq(&port->lock);
+}
 
 /* download the firmware to a "fake" device (pre-renumeration) */
 static int keyspan_pda_fake_startup(struct usb_serial *serial)
@@ -695,10 +694,12 @@ static int keyspan_pda_fake_startup(struct usb_serial *serial)
 		return -ENOENT;
 	}
 
-	/* after downloading firmware Renumeration will occur in a
-	  moment and the new device will bind to the real driver */
+	/*
+	 * After downloading firmware renumeration will occur in a moment and
+	 * the new device will bind to the real driver.
+	 */
 
-	/* we want this device to fail to have a driver assigned to it. */
+	/* We want this device to fail to have a driver assigned to it. */
 	return 1;
 }
 
@@ -777,10 +778,8 @@ static struct usb_serial_driver keyspan_pda_device = {
 	.open =			keyspan_pda_open,
 	.close =		keyspan_pda_close,
 	.write =		keyspan_pda_write,
-	.write_room =		keyspan_pda_write_room,
-	.write_bulk_callback = 	keyspan_pda_write_bulk_callback,
+	.write_bulk_callback =	keyspan_pda_write_bulk_callback,
 	.read_int_callback =	keyspan_pda_rx_interrupt,
-	.chars_in_buffer =	keyspan_pda_chars_in_buffer,
 	.throttle =		keyspan_pda_rx_throttle,
 	.unthrottle =		keyspan_pda_rx_unthrottle,
 	.set_termios =		keyspan_pda_set_termios,
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 4ffb0750c79b..74ecf2c9dcbd 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -516,10 +516,19 @@ static int v9fs_at_to_dotl_flags(int flags)
  * - ext4 (with dir_nlink feature enabled) sets nlink to 1 if a dir has more
  *   than EXT4_LINK_MAX (65000) links.
  *
+ * In cacheless mode the server is the source of truth for nlink and the
+ * inode is going away immediately, so locally adjusting i_nlink buys
+ * nothing and races with concurrent metadata fetches that may already
+ * have observed the post-unlink value (nlink == 0).
+ *
  * @inode: inode whose nlink is being dropped
  */
 static void v9fs_dec_count(struct inode *inode)
 {
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
+
+	if (v9ses->cache != CACHE_LOOSE && v9ses->cache != CACHE_FSCACHE)
+		return;
 	if (!S_ISDIR(inode->i_mode) || inode->i_nlink > 2)
 		drop_nlink(inode);
 }
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 11dc833ca2c4..ba1031433165 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1243,7 +1243,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		}
 		reloc_func_desc = interp_load_addr;
 
-		allow_write_access(interpreter);
+		exe_file_allow_write_access(interpreter);
 		fput(interpreter);
 
 		kfree(interp_elf_ex);
@@ -1332,7 +1332,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	kfree(interp_elf_ex);
 	kfree(interp_elf_phdata);
 out_free_file:
-	allow_write_access(interpreter);
+	exe_file_allow_write_access(interpreter);
 	if (interpreter)
 		fput(interpreter);
 out_free_ph:
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 1ea46ffba049..9b9689a9e94c 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -398,7 +398,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 			goto error;
 		}
 
-		allow_write_access(interpreter);
+		exe_file_allow_write_access(interpreter);
 		fput(interpreter);
 		interpreter = NULL;
 	}
@@ -471,7 +471,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 
 error:
 	if (interpreter) {
-		allow_write_access(interpreter);
+		exe_file_allow_write_access(interpreter);
 		fput(interpreter);
 	}
 	kfree(interpreter_name);
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index d8d373149119..ab14522dcd5b 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -163,8 +163,10 @@ static Node *get_binfmt_handler(struct linux_binprm *bprm)
 static void put_binfmt_handler(Node *e)
 {
 	if (refcount_dec_and_test(&e->users)) {
-		if (e->flags & MISC_FMT_OPEN_FILE)
+		if (e->flags & MISC_FMT_OPEN_FILE) {
+			exe_file_allow_write_access(e->interp_file);
 			filp_close(e->interp_file, NULL);
+		}
 		kfree(e);
 	}
 }
@@ -218,8 +220,14 @@ static int load_misc_binary(struct linux_binprm *bprm)
 
 	if (fmt->flags & MISC_FMT_OPEN_FILE) {
 		interp_file = file_clone_open(fmt->interp_file);
-		if (!IS_ERR(interp_file))
-			deny_write_access(interp_file);
+		if (!IS_ERR(interp_file)) {
+			int err = exe_file_deny_write_access(interp_file);
+
+			if (err) {
+				fput(interp_file);
+				interp_file = ERR_PTR(err);
+			}
+		}
 	} else {
 		interp_file = open_exec(fmt->interpreter);
 	}
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 2362f2591f4a..4e247e65bd07 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -178,7 +178,7 @@ static int ceph_do_readpage(struct file *filp, struct page *page)
 {
 	struct inode *inode = file_inode(filp);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	struct ceph_osd_request *req;
 	struct ceph_vino vino = ceph_vino(inode);
@@ -266,7 +266,7 @@ static int ceph_readpage(struct file *filp, struct page *page)
 static void finish_read(struct ceph_osd_request *req)
 {
 	struct inode *inode = req->r_inode;
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_osd_data *osd_data;
 	int rc = req->r_result <= 0 ? req->r_result : 0;
 	int bytes = req->r_result >= 0 ? req->r_result : 0;
@@ -275,7 +275,7 @@ static void finish_read(struct ceph_osd_request *req)
 
 	dout("finish_read %p req %p rc %d bytes %d\n", inode, req, rc, bytes);
 	if (rc == -EBLOCKLISTED)
-		ceph_inode_to_client(inode)->blocklisted = true;
+		ceph_inode_to_fs_client(inode)->blocklisted = true;
 
 	/* unlock all pages, zeroing any data we didn't read */
 	osd_data = osd_req_op_extent_osd_data(req, 0);
@@ -319,7 +319,7 @@ static int start_read(struct inode *inode, struct ceph_rw_context *rw_ctx,
 		      struct list_head *page_list, int max)
 {
 	struct ceph_osd_client *osdc =
-		&ceph_inode_to_client(inode)->client->osdc;
+		&ceph_inode_to_fs_client(inode)->client->osdc;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct page *page = lru_to_page(page_list);
 	struct ceph_vino vino;
@@ -453,7 +453,7 @@ static int ceph_readpages(struct file *file, struct address_space *mapping,
 			  struct list_head *page_list, unsigned nr_pages)
 {
 	struct inode *inode = file_inode(file);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_file_info *fi = file->private_data;
 	struct ceph_rw_context *rw_ctx;
 	int rc = 0;
@@ -591,7 +591,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 {
 	struct inode *inode = page->mapping->host;
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_snap_context *snapc, *oldest;
 	loff_t page_off = page_offset(page);
 	int err;
@@ -733,7 +733,7 @@ static void writepages_finish(struct ceph_osd_request *req)
 	int rc = req->r_result;
 	struct ceph_snap_context *snapc = req->r_snapc;
 	struct address_space *mapping = inode->i_mapping;
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	bool remove_page;
 
 	dout("writepages_finish %p rc %d\n", inode, rc);
@@ -815,7 +815,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_vino vino = ceph_vino(inode);
 	pgoff_t index, start_index, end = -1;
 	struct ceph_snap_context *snapc = NULL, *last_snapc = NULL, *pgsnapc;
@@ -1252,7 +1252,7 @@ static struct ceph_snap_context *
 ceph_find_incompatible(struct page *page)
 {
 	struct inode *inode = page->mapping->host;
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
 	if (READ_ONCE(fsc->mount_state) == CEPH_MOUNT_SHUTDOWN) {
@@ -1739,7 +1739,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 {
 	struct inode *inode = file_inode(filp);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_osd_request *req;
 	struct page *page = NULL;
 	u64 len, inline_version;
@@ -1896,7 +1896,7 @@ enum {
 static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 				s64 pool, struct ceph_string *pool_ns)
 {
-	struct ceph_fs_client *fsc = ceph_inode_to_client(&ci->vfs_inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(&ci->vfs_inode);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_osd_request *rd_req = NULL, *wr_req = NULL;
 	struct rb_node **p, *parent;
@@ -2085,7 +2085,7 @@ int ceph_pool_perm_check(struct inode *inode, int need)
 		return 0;
 	}
 
-	if (ceph_test_mount_opt(ceph_inode_to_client(inode),
+	if (ceph_test_mount_opt(ceph_inode_to_fs_client(inode),
 				NOPOOLPERM))
 		return 0;
 
diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index 2f5cb6bc78e1..e0edef8c66bc 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -138,7 +138,7 @@ static const struct fscache_cookie_def ceph_fscache_inode_object_def = {
 void ceph_fscache_register_inode_cookie(struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_aux_inode aux;
 
 	/* No caching for filesystem */
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 91dc79bc8c66..e5dbff244ea4 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -633,7 +633,7 @@ void ceph_add_cap(struct inode *inode,
 		  unsigned seq, unsigned mseq, u64 realmino, int flags,
 		  struct ceph_cap **new_cap)
 {
-	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_inode_to_fs_client(inode)->mdsc;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_cap *cap;
 	int mds = session->s_mds;
@@ -940,7 +940,7 @@ int __ceph_caps_issued_mask(struct ceph_inode_info *ci, int mask, int touch)
 int __ceph_caps_issued_mask_metric(struct ceph_inode_info *ci, int mask,
 				   int touch)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(ci->vfs_inode.i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(ci->vfs_inode.i_sb);
 	int r;
 
 	r = __ceph_caps_issued_mask(ci, mask, touch);
@@ -1014,7 +1014,7 @@ int __ceph_caps_file_wanted(struct ceph_inode_info *ci)
 	const int WR_SHIFT = ffs(CEPH_FILE_MODE_WR);
 	const int LAZY_SHIFT = ffs(CEPH_FILE_MODE_LAZY);
 	struct ceph_mount_options *opt =
-		ceph_inode_to_client(&ci->vfs_inode)->mount_options;
+		ceph_inode_to_fs_client(&ci->vfs_inode)->mount_options;
 	unsigned long used_cutoff = jiffies - opt->caps_wanted_delay_max * HZ;
 	unsigned long idle_cutoff = jiffies - opt->caps_wanted_delay_min * HZ;
 
@@ -1126,7 +1126,7 @@ static void drop_inode_snap_realm(struct ceph_inode_info *ci)
 	if (realm->ino == ci->i_vino.ino)
 		realm->inode = NULL;
 	spin_unlock(&realm->inodes_with_caps_lock);
-	ceph_put_snap_realm(ceph_sb_to_client(ci->vfs_inode.i_sb)->mdsc,
+	ceph_put_snap_realm(ceph_sb_to_fs_client(ci->vfs_inode.i_sb)->mdsc,
 			    realm);
 }
 
@@ -1151,7 +1151,7 @@ void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 
 	dout("__ceph_remove_cap %p from %p\n", cap, &ci->vfs_inode);
 
-	mdsc = ceph_inode_to_client(&ci->vfs_inode)->mdsc;
+	mdsc = ceph_inode_to_fs_client(&ci->vfs_inode)->mdsc;
 
 	/* remove from inode's cap rbtree, and clear auth cap */
 	rb_erase(&cap->ci_node, &ci->i_caps);
@@ -1635,7 +1635,7 @@ void ceph_flush_snaps(struct ceph_inode_info *ci,
 		      struct ceph_mds_session **psession)
 {
 	struct inode *inode = &ci->vfs_inode;
-	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_inode_to_fs_client(inode)->mdsc;
 	struct ceph_mds_session *session = NULL;
 	bool need_put = false;
 	int mds;
@@ -1707,7 +1707,7 @@ int __ceph_mark_dirty_caps(struct ceph_inode_info *ci, int mask,
 			   struct ceph_cap_flush **pcf)
 {
 	struct ceph_mds_client *mdsc =
-		ceph_sb_to_client(ci->vfs_inode.i_sb)->mdsc;
+		ceph_sb_to_fs_client(ci->vfs_inode.i_sb)->mdsc;
 	struct inode *inode = &ci->vfs_inode;
 	int was = ci->i_dirty_caps;
 	int dirty = 0;
@@ -1830,7 +1830,7 @@ static u64 __mark_caps_flushing(struct inode *inode,
 				struct ceph_mds_session *session, bool wake,
 				u64 *oldest_flush_tid)
 {
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_cap_flush *cf = NULL;
 	int flushing;
@@ -2211,7 +2211,7 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags,
  */
 static int try_flush_caps(struct inode *inode, u64 *ptid)
 {
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_session *session = NULL;
 	int flushing = 0;
@@ -2301,7 +2301,7 @@ static int caps_are_flushed(struct inode *inode, u64 flush_tid)
  */
 static int unsafe_request_wait(struct inode *inode)
 {
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_request *req1 = NULL, *req2 = NULL;
 	int ret, err = 0;
@@ -2480,7 +2480,7 @@ int ceph_write_inode(struct inode *inode, struct writeback_control *wbc)
 				       caps_are_flushed(inode, flush_tid));
 	} else {
 		struct ceph_mds_client *mdsc =
-			ceph_sb_to_client(inode->i_sb)->mdsc;
+			ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 
 		spin_lock(&ci->i_ceph_lock);
 		if (__ceph_caps_dirty(ci))
@@ -2729,7 +2729,7 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 			    loff_t endoff, int flags, int *got)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_inode_to_fs_client(inode)->mdsc;
 	int ret = 0;
 	int have, implemented;
 	bool snap_rwsem_locked = false;
@@ -2949,7 +2949,7 @@ int ceph_get_caps(struct file *filp, int need, int want,
 	struct ceph_file_info *fi = filp->private_data;
 	struct inode *inode = file_inode(filp);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	int ret, _got, flags;
 
 	ret = ceph_pool_perm_check(inode, need);
@@ -2995,7 +2995,19 @@ int ceph_get_caps(struct file *filp, int need, int want,
 					ret = -ERESTARTSYS;
 					break;
 				}
-				wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
+
+				/*
+				 * If a cap update is lost after
+				 * mds_wanted was raised, waiting
+				 * forever will never make progress.
+				 * Retry the renew path periodically
+				 * so we can resend synchronously.
+				 */
+				if (!wait_woken(&wait, TASK_INTERRUPTIBLE,
+						CEPH_GET_CAPS_WAIT_TIMEOUT)) {
+					ret = -ESTALE;
+					break;
+				}
 			}
 
 			remove_wait_queue(&ci->i_cap_wq, &wait);
@@ -3027,7 +3039,8 @@ int ceph_get_caps(struct file *filp, int need, int want,
 				continue;
 			}
 			if (ret == -ESTALE) {
-				/* session was killed, try renew caps */
+				/* session was killed or a waited cap
+				 * request needs a retry */
 				ret = ceph_renew_caps(inode, flags);
 				if (ret == 0)
 					continue;
@@ -3651,7 +3664,7 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
 	__releases(ci->i_ceph_lock)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	struct ceph_cap_flush *cf, *tmp_cf;
 	LIST_HEAD(to_remove);
 	unsigned seq = le32_to_cpu(m->seq);
@@ -3757,7 +3770,7 @@ void __ceph_remove_capsnap(struct inode *inode, struct ceph_cap_snap *capsnap,
 			   bool *wake_ci, bool *wake_mdsc)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	bool ret;
 
 	lockdep_assert_held(&ci->i_ceph_lock);
@@ -3801,7 +3814,7 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
 				     struct ceph_mds_session *session)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	u64 follows = le64_to_cpu(m->snap_follows);
 	struct ceph_cap_snap *capsnap;
 	bool flushed = false;
@@ -3885,7 +3898,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 			      struct ceph_mds_cap_peer *ph,
 			      struct ceph_mds_session *session)
 {
-	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_inode_to_fs_client(inode)->mdsc;
 	struct ceph_mds_session *tsession = NULL;
 	struct ceph_cap *cap, *tcap, *new_cap = NULL;
 	struct ceph_inode_info *ci = ceph_inode(inode);
@@ -4504,7 +4517,7 @@ int ceph_drop_caps_for_unlink(struct inode *inode)
 
 		if (__ceph_caps_dirty(ci)) {
 			struct ceph_mds_client *mdsc =
-				ceph_inode_to_client(inode)->mdsc;
+				ceph_inode_to_fs_client(inode)->mdsc;
 			__cap_delay_requeue_front(mdsc, ci);
 		}
 	}
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 852bcbd8b88f..52a441f86ee3 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -307,7 +307,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 	struct ceph_dir_file_info *dfi = file->private_data;
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	int i;
 	int err;
@@ -677,7 +677,7 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
 int ceph_handle_snapdir(struct ceph_mds_request *req,
 			struct dentry *dentry, int err)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(dentry->d_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dentry->d_sb);
 	struct inode *parent = d_inode(dentry->d_parent); /* we hold i_mutex */
 
 	/* .snap dir? */
@@ -746,7 +746,7 @@ static bool is_root_ceph_dentry(struct inode *inode, struct dentry *dentry)
 static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 				  unsigned int flags)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dir->i_sb);
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
 	struct ceph_mds_request *req;
 	int op;
@@ -1128,7 +1128,7 @@ static int get_caps_for_async_unlink(struct inode *dir, struct dentry *dentry)
  */
 static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dir->i_sb);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct inode *inode = d_inode(dentry);
 	struct ceph_inode_info *ci = ceph_inode(inode);
@@ -1288,7 +1288,7 @@ void __ceph_dentry_lease_touch(struct ceph_dentry_info *di)
 		return;
 	}
 
-	mdsc = ceph_sb_to_client(dn->d_sb)->mdsc;
+	mdsc = ceph_sb_to_fs_client(dn->d_sb)->mdsc;
 	spin_lock(&mdsc->dentry_list_lock);
 	list_move_tail(&di->lease_list, &mdsc->dentry_leases);
 	spin_unlock(&mdsc->dentry_list_lock);
@@ -1335,7 +1335,7 @@ void __ceph_dentry_dir_lease_touch(struct ceph_dentry_info *di)
 		return;
 	}
 
-	mdsc = ceph_sb_to_client(dn->d_sb)->mdsc;
+	mdsc = ceph_sb_to_fs_client(dn->d_sb)->mdsc;
 	spin_lock(&mdsc->dentry_list_lock);
 	__dentry_dir_lease_touch(mdsc, di),
 	spin_unlock(&mdsc->dentry_list_lock);
@@ -1349,7 +1349,7 @@ static void __dentry_lease_unlist(struct ceph_dentry_info *di)
 	if (list_empty(&di->lease_list))
 		return;
 
-	mdsc = ceph_sb_to_client(di->dentry->d_sb)->mdsc;
+	mdsc = ceph_sb_to_fs_client(di->dentry->d_sb)->mdsc;
 	spin_lock(&mdsc->dentry_list_lock);
 	list_del_init(&di->lease_list);
 	spin_unlock(&mdsc->dentry_list_lock);
@@ -1704,7 +1704,7 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 	dout("d_revalidate %p '%pd' inode %p offset 0x%llx\n", dentry,
 	     dentry, inode, ceph_dentry(dentry)->offset);
 
-	mdsc = ceph_sb_to_client(dir->i_sb)->mdsc;
+	mdsc = ceph_sb_to_fs_client(dir->i_sb)->mdsc;
 
 	/* always trust cached snapped dentries, snapdir dentry */
 	if (ceph_snap(dir) != CEPH_NOSNAP) {
@@ -1810,7 +1810,7 @@ static int ceph_d_delete(const struct dentry *dentry)
 static void ceph_d_release(struct dentry *dentry)
 {
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
-	struct ceph_fs_client *fsc = ceph_sb_to_client(dentry->d_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dentry->d_sb);
 
 	dout("d_release %p\n", dentry);
 
@@ -1879,7 +1879,7 @@ static ssize_t ceph_read_dir(struct file *file, char __user *buf, size_t size,
 	int left;
 	const int bufsize = 1024;
 
-	if (!ceph_test_mount_opt(ceph_sb_to_client(inode->i_sb), DIRSTAT))
+	if (!ceph_test_mount_opt(ceph_sb_to_fs_client(inode->i_sb), DIRSTAT))
 		return -EISDIR;
 
 	if (!dfi->dir_info) {
diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 042bb4a02c0a..66d8afdd417d 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -122,7 +122,7 @@ static int ceph_encode_fh(struct inode *inode, u32 *rawfh, int *max_len,
 
 static struct inode *__lookup_inode(struct super_block *sb, u64 ino)
 {
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(sb)->mdsc;
 	struct inode *inode;
 	struct ceph_vino vino;
 	int err;
@@ -198,7 +198,7 @@ static struct dentry *__snapfh_to_dentry(struct super_block *sb,
 					  struct ceph_nfs_snapfh *sfh,
 					  bool want_parent)
 {
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(sb)->mdsc;
 	struct ceph_mds_request *req;
 	struct inode *inode;
 	struct ceph_vino vino;
@@ -304,7 +304,7 @@ static struct dentry *ceph_fh_to_dentry(struct super_block *sb,
 static struct dentry *__get_parent(struct super_block *sb,
 				   struct dentry *child, u64 ino)
 {
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(sb)->mdsc;
 	struct ceph_mds_request *req;
 	struct inode *inode;
 	int mask;
@@ -426,7 +426,7 @@ static int __get_snap_name(struct dentry *parent, char *name,
 {
 	struct inode *inode = d_inode(child);
 	struct inode *dir = d_inode(parent);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_mds_request *req = NULL;
 	char *last_name = NULL;
 	unsigned next_offset = 2;
@@ -529,7 +529,7 @@ static int ceph_get_name(struct dentry *parent, char *name,
 	if (ceph_snap(inode) != CEPH_NOSNAP)
 		return __get_snap_name(parent, name, child);
 
-	mdsc = ceph_inode_to_client(inode)->mdsc;
+	mdsc = ceph_inode_to_fs_client(inode)->mdsc;
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_LOOKUPNAME,
 				       USE_ANY_MDS);
 	if (IS_ERR(req))
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index fcc9b1ad314a..4d0bdda8d8f0 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -233,7 +233,7 @@ static int ceph_init_file_info(struct inode *inode, struct file *file,
 
 	spin_lock_init(&fi->rw_contexts_lock);
 	INIT_LIST_HEAD(&fi->rw_contexts);
-	fi->filp_gen = READ_ONCE(ceph_inode_to_client(inode)->filp_gen);
+	fi->filp_gen = READ_ONCE(ceph_inode_to_fs_client(inode)->filp_gen);
 
 	return 0;
 }
@@ -277,21 +277,22 @@ static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
 }
 
 /*
- * try renew caps after session gets killed.
+ * Retry cap acquisition after a stale session or a lost cap update.
  */
 int ceph_renew_caps(struct inode *inode, int fmode)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_request *req;
-	int err, flags, wanted;
+	int err, flags, wanted, issued;
 
 	spin_lock(&ci->i_ceph_lock);
 	__ceph_touch_fmode(ci, mdsc, fmode);
 	wanted = __ceph_caps_file_wanted(ci);
+	issued = __ceph_caps_issued(ci, NULL);
 	if (__ceph_is_any_real_caps(ci) &&
-	    (!(wanted & CEPH_CAP_ANY_WR) || ci->i_auth_cap)) {
-		int issued = __ceph_caps_issued(ci, NULL);
+	    (!(wanted & CEPH_CAP_ANY_WR) || ci->i_auth_cap) &&
+	    (issued & wanted) == wanted) {
 		spin_unlock(&ci->i_ceph_lock);
 		dout("renew caps %p want %s issued %s updating mds_wanted\n",
 		     inode, ceph_cap_string(wanted), ceph_cap_string(issued));
@@ -338,7 +339,7 @@ int ceph_renew_caps(struct inode *inode, int fmode)
 int ceph_open(struct inode *inode, struct file *file)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_sb_to_client(inode->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(inode->i_sb);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	struct ceph_file_info *fi = file->private_data;
@@ -687,7 +688,7 @@ static int ceph_finish_async_create(struct inode *dir, struct dentry *dentry,
 int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		     struct file *file, unsigned flags, umode_t mode)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dir->i_sb);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	struct dentry *dn;
@@ -869,7 +870,7 @@ static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *to,
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	ssize_t ret;
 	u64 off = iocb->ki_pos;
@@ -1089,7 +1090,7 @@ static void ceph_aio_complete_req(struct ceph_osd_request *req)
 		if (aio_work) {
 			INIT_WORK(&aio_work->work, ceph_aio_retry_work);
 			aio_work->req = req;
-			queue_work(ceph_inode_to_client(inode)->inode_wq,
+			queue_work(ceph_inode_to_fs_client(inode)->inode_wq,
 				   &aio_work->work);
 			return;
 		}
@@ -1208,7 +1209,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client_metric *metric = &fsc->mdsc->metric;
 	struct ceph_vino vino;
 	struct ceph_osd_request *req;
@@ -1418,7 +1419,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_vino vino;
 	struct ceph_osd_request *req;
 	struct page **pages;
@@ -1703,7 +1704,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct ceph_file_info *fi = file->private_data;
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	struct ceph_cap_flush *prealloc_cf;
 	ssize_t count, written = 0;
@@ -1897,7 +1898,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 static loff_t ceph_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file->f_mapping->host;
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	loff_t i_size;
 	loff_t ret;
 
@@ -1990,7 +1991,7 @@ static int ceph_zero_partial_object(struct inode *inode,
 				    loff_t offset, loff_t *length)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_osd_request *req;
 	struct ceph_snap_context *snapc;
 	int ret = 0;
@@ -2324,7 +2325,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	struct ceph_inode_info *src_ci = ceph_inode(src_inode);
 	struct ceph_inode_info *dst_ci = ceph_inode(dst_inode);
 	struct ceph_cap_flush *prealloc_cf;
-	struct ceph_fs_client *src_fsc = ceph_inode_to_client(src_inode);
+	struct ceph_fs_client *src_fsc = ceph_inode_to_fs_client(src_inode);
 	loff_t size;
 	ssize_t ret = -EIO, bytes;
 	u64 src_objnum, dst_objnum, src_objoff, dst_objoff;
@@ -2332,7 +2333,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	int src_got = 0, dst_got = 0, err, dirty;
 
 	if (src_inode->i_sb != dst_inode->i_sb) {
-		struct ceph_fs_client *dst_fsc = ceph_inode_to_client(dst_inode);
+		struct ceph_fs_client *dst_fsc = ceph_inode_to_fs_client(dst_inode);
 
 		if (ceph_fsid_compare(&src_fsc->client->fsid,
 				      &dst_fsc->client->fsid)) {
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 36e3342d3633..57132f8331eb 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1240,7 +1240,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 	struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
 	struct inode *in = NULL;
 	struct ceph_vino tvino, dvino;
-	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 	int err = 0;
 
 	dout("fill_trace %p is_dentry %d is_target %d\n", req,
@@ -1815,7 +1815,7 @@ void ceph_async_iput(struct inode *inode)
 	for (;;) {
 		if (atomic_add_unless(&inode->i_count, -1, 1))
 			break;
-		if (queue_work(ceph_inode_to_client(inode)->inode_wq,
+		if (queue_work(ceph_inode_to_fs_client(inode)->inode_wq,
 			       &ceph_inode(inode)->i_work))
 			break;
 		/* queue work failed, i_count must be at least 2 */
@@ -1832,7 +1832,7 @@ void ceph_queue_writeback(struct inode *inode)
 	set_bit(CEPH_I_WORK_WRITEBACK, &ci->i_work_mask);
 
 	ihold(inode);
-	if (queue_work(ceph_inode_to_client(inode)->inode_wq,
+	if (queue_work(ceph_inode_to_fs_client(inode)->inode_wq,
 		       &ci->i_work)) {
 		dout("ceph_queue_writeback %p\n", inode);
 	} else {
@@ -1851,7 +1851,7 @@ void ceph_queue_invalidate(struct inode *inode)
 	set_bit(CEPH_I_WORK_INVALIDATE_PAGES, &ci->i_work_mask);
 
 	ihold(inode);
-	if (queue_work(ceph_inode_to_client(inode)->inode_wq,
+	if (queue_work(ceph_inode_to_fs_client(inode)->inode_wq,
 		       &ceph_inode(inode)->i_work)) {
 		dout("ceph_queue_invalidate %p\n", inode);
 	} else {
@@ -1871,7 +1871,7 @@ void ceph_queue_vmtruncate(struct inode *inode)
 	set_bit(CEPH_I_WORK_VMTRUNCATE, &ci->i_work_mask);
 
 	ihold(inode);
-	if (queue_work(ceph_inode_to_client(inode)->inode_wq,
+	if (queue_work(ceph_inode_to_fs_client(inode)->inode_wq,
 		       &ci->i_work)) {
 		dout("ceph_queue_vmtruncate %p\n", inode);
 	} else {
@@ -1884,7 +1884,7 @@ void ceph_queue_vmtruncate(struct inode *inode)
 static void ceph_do_invalidate_pages(struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	u32 orig_gen;
 	int check = 0;
 
@@ -2033,7 +2033,7 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	unsigned int ia_valid = attr->ia_valid;
 	struct ceph_mds_request *req;
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	struct ceph_cap_flush *prealloc_cf;
 	int issued;
 	int release = 0, dirtied = 0;
@@ -2248,7 +2248,7 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 int ceph_setattr(struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	int err;
 
 	if (ceph_snap(inode) != CEPH_NOSNAP)
@@ -2281,7 +2281,7 @@ int ceph_setattr(struct dentry *dentry, struct iattr *attr)
 int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
 		      int mask, bool force)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(inode->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(inode->i_sb);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	int mode;
@@ -2401,7 +2401,7 @@ int ceph_getattr(const struct path *path, struct kstat *stat,
 		stat->dev = ci->i_snapid_map ? ci->i_snapid_map->dev : 0;
 
 	if (S_ISDIR(inode->i_mode)) {
-		if (ceph_test_mount_opt(ceph_sb_to_client(inode->i_sb),
+		if (ceph_test_mount_opt(ceph_sb_to_fs_client(inode->i_sb),
 					RBYTES))
 			stat->size = ci->i_rbytes;
 		else
diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 6e061bf62ad4..7ba8bb520e84 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -64,7 +64,7 @@ static long __validate_layout(struct ceph_mds_client *mdsc,
 static long ceph_ioctl_set_layout(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	struct ceph_mds_request *req;
 	struct ceph_ioctl_layout l;
 	struct ceph_inode_info *ci = ceph_inode(file_inode(file));
@@ -139,7 +139,7 @@ static long ceph_ioctl_set_layout_policy (struct file *file, void __user *arg)
 	struct ceph_mds_request *req;
 	struct ceph_ioctl_layout l;
 	int err;
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 
 	/* copy and validate */
 	if (copy_from_user(&l, arg, sizeof(l)))
@@ -182,7 +182,7 @@ static long ceph_ioctl_get_dataloc(struct file *file, void __user *arg)
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_osd_client *osdc =
-		&ceph_sb_to_client(inode->i_sb)->client->osdc;
+		&ceph_sb_to_fs_client(inode->i_sb)->client->osdc;
 	struct ceph_object_locator oloc;
 	CEPH_DEFINE_OID_ONSTACK(oid);
 	u32 xlen;
@@ -243,7 +243,7 @@ static long ceph_ioctl_lazyio(struct file *file)
 	struct ceph_file_info *fi = file->private_data;
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_inode_to_fs_client(inode)->mdsc;
 
 	if ((fi->fmode & CEPH_FILE_MODE_LAZY) == 0) {
 		spin_lock(&ci->i_ceph_lock);
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index f411e3551246..165a0ec892ac 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -6,6 +6,7 @@
 #include <linux/slab.h>
 #include <linux/gfp.h>
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/ratelimit.h>
@@ -3126,6 +3127,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	struct ceph_mds_reply_head *head = msg->front.iov_base;
 	struct ceph_mds_reply_info_parsed *rinfo;  /* parsed reply info */
 	struct ceph_snap_realm *realm;
+	unsigned int nofs_flags;
 	u64 tid;
 	int err, result;
 	int mds = session->s_mds;
@@ -3258,6 +3260,14 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 
 	/* insert trace into our cache */
 	mutex_lock(&req->r_fill_mutex);
+
+	/* disable fs reclaim while we are using current->journal_info
+	 * for our own purposes, or else shrinkers of other
+	 * filesystems might dereference this pointer as a different
+	 * type
+	 */
+	nofs_flags = memalloc_nofs_save();
+
 	current->journal_info = req;
 	err = ceph_fill_trace(mdsc->fsc->sb, req);
 	if (err == 0) {
@@ -3266,6 +3276,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 			ceph_readdir_prepopulate(req, req->r_session);
 	}
 	current->journal_info = NULL;
+	memalloc_nofs_restore(nofs_flags);
 	mutex_unlock(&req->r_fill_mutex);
 
 	up_read(&mdsc->snap_rwsem);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 1c958510f00f..b1939f916228 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -61,6 +61,8 @@ enum ceph_feature_type {
 struct ceph_fs_client;
 struct ceph_cap;
 
+#define CEPH_GET_CAPS_WAIT_TIMEOUT (5 * HZ)
+
 /*
  * parsed info about a single inode.  pointers are into the encoded
  * on-wire structures within the mds reply message payload.
diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index 47f2903bacb9..9699de85a15e 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -14,7 +14,7 @@
 #include "super.h"
 
 #define CEPH_MDS_IS_READY(i, ignore_laggy) \
-	(m->m_info[i].state > 0 && ignore_laggy ? true : !m->m_info[i].laggy)
+	(m->m_info[i].state > 0 && (ignore_laggy ? true : !m->m_info[i].laggy))
 
 static int __mdsmap_get_random_mds(struct ceph_mdsmap *m, bool ignore_laggy)
 {
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 3ef197742430..a7ec8d99dc45 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -41,7 +41,7 @@ static LIST_HEAD(ceph_fsc_list);
  */
 static void ceph_put_super(struct super_block *s)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(s);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(s);
 
 	dout("put_super\n");
 	ceph_mdsc_close_sessions(fsc->mdsc);
@@ -49,7 +49,7 @@ static void ceph_put_super(struct super_block *s)
 
 static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
-	struct ceph_fs_client *fsc = ceph_inode_to_client(d_inode(dentry));
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(d_inode(dentry));
 	struct ceph_mon_client *monc = &fsc->client->monc;
 	struct ceph_statfs st;
 	int i, err;
@@ -112,7 +112,7 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 static int ceph_sync_fs(struct super_block *sb, int wait)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 
 	if (!wait) {
 		dout("sync_fs (non-blocking)\n");
@@ -529,7 +529,7 @@ static int compare_mount_options(struct ceph_mount_options *new_fsopt,
  */
 static int ceph_show_options(struct seq_file *m, struct dentry *root)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(root->d_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(root->d_sb);
 	struct ceph_mount_options *fsopt = fsc->mount_options;
 	size_t pos;
 	int ret;
@@ -841,7 +841,7 @@ static void destroy_caches(void)
  */
 static void ceph_umount_begin(struct super_block *sb)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 
 	dout("ceph_umount_begin - starting forced umount\n");
 	if (!fsc)
@@ -1001,7 +1001,7 @@ static int ceph_compare_super(struct super_block *sb, struct fs_context *fc)
 	struct ceph_fs_client *new = fc->s_fs_info;
 	struct ceph_mount_options *fsopt = new->mount_options;
 	struct ceph_options *opt = new->client->options;
-	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 
 	dout("ceph_compare_super %p\n", sb);
 
@@ -1094,9 +1094,9 @@ static int ceph_get_tree(struct fs_context *fc)
 		goto out;
 	}
 
-	if (ceph_sb_to_client(sb) != fsc) {
+	if (ceph_sb_to_fs_client(sb) != fsc) {
 		destroy_fs_client(fsc);
-		fsc = ceph_sb_to_client(sb);
+		fsc = ceph_sb_to_fs_client(sb);
 		dout("get_sb got existing client %p\n", fsc);
 	} else {
 		dout("get_sb using new client %p\n", fsc);
@@ -1147,7 +1147,7 @@ static int ceph_reconfigure_fc(struct fs_context *fc)
 {
 	struct ceph_parse_opts_ctx *pctx = fc->fs_private;
 	struct ceph_mount_options *fsopt = pctx->opts;
-	struct ceph_fs_client *fsc = ceph_sb_to_client(fc->root->d_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(fc->root->d_sb);
 
 	if (fsopt->flags & CEPH_MOUNT_OPT_ASYNC_DIROPS)
 		ceph_set_mount_opt(fsc, ASYNC_DIROPS);
@@ -1218,7 +1218,7 @@ static int ceph_init_fs_context(struct fs_context *fc)
 
 static void ceph_kill_sb(struct super_block *s)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(s);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(s);
 
 	dout("kill_sb %p\n", s);
 
@@ -1256,7 +1256,7 @@ MODULE_ALIAS_FS("ceph");
 
 int ceph_force_reconnect(struct super_block *sb)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 	int err = 0;
 
 	ceph_umount_begin(sb);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 8716cb618cbb..ef1f253292b2 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -440,13 +440,13 @@ ceph_inode(const struct inode *inode)
 }
 
 static inline struct ceph_fs_client *
-ceph_inode_to_client(const struct inode *inode)
+ceph_inode_to_fs_client(const struct inode *inode)
 {
 	return (struct ceph_fs_client *)inode->i_sb->s_fs_info;
 }
 
 static inline struct ceph_fs_client *
-ceph_sb_to_client(const struct super_block *sb)
+ceph_sb_to_fs_client(const struct super_block *sb)
 {
 	return (struct ceph_fs_client *)sb->s_fs_info;
 }
@@ -454,7 +454,7 @@ ceph_sb_to_client(const struct super_block *sb)
 static inline struct ceph_mds_client *
 ceph_sb_to_mdsc(const struct super_block *sb)
 {
-	return (struct ceph_mds_client *)ceph_sb_to_client(sb)->mdsc;
+	return (struct ceph_mds_client *)ceph_sb_to_fs_client(sb)->mdsc;
 }
 
 static inline struct ceph_vino
@@ -510,7 +510,7 @@ static inline u64 ceph_snap(struct inode *inode)
  */
 static inline u64 ceph_present_ino(struct super_block *sb, u64 ino)
 {
-	if (unlikely(ceph_test_mount_opt(ceph_sb_to_client(sb), INO32)))
+	if (unlikely(ceph_test_mount_opt(ceph_sb_to_fs_client(sb), INO32)))
 		return ceph_ino_to_ino32(ino);
 	return ino;
 }
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index d1fd81b1b541..f42632ae4122 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -56,7 +56,7 @@ static bool ceph_vxattrcb_layout_exists(struct ceph_inode_info *ci)
 static ssize_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
 				    size_t size)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(ci->vfs_inode.i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(ci->vfs_inode.i_sb);
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	struct ceph_string *pool_ns;
 	s64 pool = ci->i_layout.pool_id;
@@ -160,7 +160,7 @@ static ssize_t ceph_vxattrcb_layout_pool(struct ceph_inode_info *ci,
 					 char *val, size_t size)
 {
 	ssize_t ret;
-	struct ceph_fs_client *fsc = ceph_sb_to_client(ci->vfs_inode.i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(ci->vfs_inode.i_sb);
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	s64 pool = ci->i_layout.pool_id;
 	const char *pool_name;
@@ -954,7 +954,7 @@ ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
 static int ceph_sync_setxattr(struct inode *inode, const char *name,
 			      const char *value, size_t size, int flags)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(inode->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(inode->i_sb);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_request *req;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
@@ -1021,7 +1021,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 {
 	struct ceph_vxattr *vxattr;
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	struct ceph_cap_flush *prealloc_cf = NULL;
 	struct ceph_buffer *old_blob = NULL;
 	int issued;
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 51f8ea0c8906..a520e90adf3e 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3568,7 +3568,7 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 	if (rc)
 		goto out;
 
-	buf = kzalloc(1024 * 1024, GFP_KERNEL);
+	buf = kvzalloc(1024 * 1024, GFP_KERNEL);
 	if (buf == NULL) {
 		rc = -ENOMEM;
 		goto out;
@@ -3635,7 +3635,7 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 
  out:
 	kfree(out_data);
-	kfree(buf);
+	kvfree(buf);
 	return rc;
 }
 
diff --git a/fs/exec.c b/fs/exec.c
index 0ea96114fcf7..9796ba95e3ea 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -929,7 +929,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	    path_noexec(&file->f_path))
 		goto exit;
 
-	err = deny_write_access(file);
+	err = exe_file_deny_write_access(file);
 	if (err)
 		goto exit;
 
@@ -1485,7 +1485,7 @@ static void free_bprm(struct linux_binprm *bprm)
 		abort_creds(bprm->cred);
 	}
 	if (bprm->file) {
-		allow_write_access(bprm->file);
+		exe_file_allow_write_access(bprm->file);
 		fput(bprm->file);
 	}
 	if (bprm->executable)
@@ -1773,7 +1773,7 @@ static int exec_binprm(struct linux_binprm *bprm)
 		bprm->file = bprm->interpreter;
 		bprm->interpreter = NULL;
 
-		allow_write_access(exec);
+		exe_file_allow_write_access(exec);
 		if (unlikely(bprm->have_execfd)) {
 			if (bprm->executable) {
 				fput(exec);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 945cb6145dbb..2933b32032e7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -968,7 +968,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	if (fio->io_wbc)
 		wbc_account_cgroup_owner(fio->io_wbc, fio->page, PAGE_SIZE);
 
-	inc_page_count(fio->sbi, WB_DATA_TYPE(page));
+	inc_page_count(fio->sbi, WB_DATA_TYPE(fio->page));
 
 	*fio->last_block = fio->new_blkaddr;
 	*fio->bio = bio;
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 14b176d63482..526d2971f12e 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1884,9 +1884,7 @@ static int load_superblock(journal_t *journal)
 
 	if (jbd2_has_feature_fast_commit(journal)) {
 		journal->j_fc_last = be32_to_cpu(sb->s_maxlen);
-		num_fc_blocks = be32_to_cpu(sb->s_num_fc_blks);
-		if (!num_fc_blocks)
-			num_fc_blocks = JBD2_MIN_FC_BLOCKS;
+		num_fc_blocks = jbd2_journal_get_num_fc_blks(sb);
 		if (journal->j_last - num_fc_blocks >= JBD2_MIN_JOURNAL_BLOCKS)
 			journal->j_last = journal->j_fc_last - num_fc_blocks;
 		journal->j_fc_first = journal->j_last + 1;
@@ -2117,9 +2115,9 @@ jbd2_journal_initialize_fast_commit(journal_t *journal)
 	journal_superblock_t *sb = journal->j_superblock;
 	unsigned long long num_fc_blks;
 
-	num_fc_blks = be32_to_cpu(sb->s_num_fc_blks);
-	if (num_fc_blks == 0)
-		num_fc_blks = JBD2_MIN_FC_BLOCKS;
+	num_fc_blks = jbd2_journal_get_num_fc_blks(sb);
+	if (num_fc_blks > journal->j_last)
+		return -EFSCORRUPTED;
 	if (journal->j_last - num_fc_blks < JBD2_MIN_JOURNAL_BLOCKS)
 		return -ENOSPC;
 
diff --git a/fs/namei.c b/fs/namei.c
index debebcbe702f..6ffa898ea3c8 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2439,6 +2439,48 @@ static struct filename *filename_parentat(int dfd, struct filename *name,
 	return name;
 }
 
+/**
+ * kern_path_parent: lookup path returning parent and target
+ * @name: path name
+ * @path: path to store parent in
+ *
+ * The path @name should end with a normal component, not "." or ".." or "/".
+ * A lookup is performed and if successful the parent information
+ * is store in @parent and the dentry is returned.
+ *
+ * The dentry maybe negative, the parent will be positive.
+ *
+ * Returns:  dentry or error.
+ */
+struct dentry *kern_path_parent(const char *name, struct path *path)
+{
+	struct filename *filename;
+	struct path parent_path;
+	struct dentry *d;
+	struct qstr last;
+	int type;
+
+	filename = filename_parentat(AT_FDCWD, getname_kernel(name), 0,
+				     &parent_path, &last, &type);
+	if (IS_ERR(filename))
+		return ERR_CAST(filename);
+	if (unlikely(type != LAST_NORM)) {
+		path_put(&parent_path);
+		d = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
+	d = lookup_one_len_unlocked(last.name, parent_path.dentry, last.len);
+	if (IS_ERR(d)) {
+		path_put(&parent_path);
+		goto out;
+	}
+	*path = parent_path;
+out:
+	putname(filename);
+	return d;
+}
+
 /* does lookup, returns the object with parent locked */
 struct dentry *kern_path_locked(const char *name, struct path *path)
 {
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index a1ec45fc77d8..018867303a93 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -648,7 +648,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 {
 	struct inode *udir = d_inode(c->destdir);
-	struct dentry *temp, *upper;
+	struct dentry *temp, *upper, *newdentry = NULL;
 	struct ovl_cu_creds cc;
 	int err;
 
@@ -672,6 +672,14 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 	err = PTR_ERR(upper);
 	if (!IS_ERR(upper)) {
 		err = ovl_do_link(temp, udir, upper);
+		if (!err) {
+			/*
+			 * Record the linked dentry -- not the disconnected
+			 * O_TMPFILE dentry -- so that ->d_revalidate() on
+			 * the upper fs sees the real parent/name.
+			 */
+			newdentry = dget(upper);
+		}
 		dput(upper);
 	}
 	inode_unlock(udir);
@@ -681,9 +689,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 
 	if (!c->metacopy)
 		ovl_set_upperdata(d_inode(c->dentry));
-	ovl_inode_update(d_inode(c->dentry), temp);
-
-	return 0;
+	ovl_inode_update(d_inode(c->dentry), newdentry);
 
 out_dput:
 	dput(temp);
diff --git a/fs/super.c b/fs/super.c
index 3d040c09f723..eb33ea08f472 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1048,13 +1048,24 @@ void emergency_remount(void)
 
 static void do_thaw_all_callback(struct super_block *sb)
 {
+	bool active = false;
+
 	down_write(&sb->s_umount);
-	if (sb->s_root && sb->s_flags & SB_BORN) {
-		emergency_thaw_bdev(sb);
+	if (sb->s_root && sb->s_flags & SB_BORN)
+		active = atomic_inc_not_zero(&sb->s_active);
+	up_write(&sb->s_umount);
+	if (!active)
+		return;
+
+	/* thaw_bdev() acquires s_umount so it must not be held here */
+	emergency_thaw_bdev(sb);
+
+	down_write(&sb->s_umount);
+	if (sb->s_root && sb->s_flags & SB_BORN)
 		thaw_super_locked(sb);
-	} else {
+	else
 		up_write(&sb->s_umount);
-	}
+	deactivate_super(sb);
 }
 
 static void do_thaw_all(struct work_struct *work)
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index c4fee38f0398..40b31fa6687b 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -804,10 +804,10 @@ xfs_sb_read_verify(
 	 * because _verify_common checks the on-disk values.
 	 */
 	__xfs_sb_from_disk(&sb, dsb, false);
-	error = xfs_validate_sb_common(mp, bp, &sb);
+	error = xfs_validate_sb_read(mp, &sb);
 	if (error)
 		goto out_error;
-	error = xfs_validate_sb_read(mp, &sb);
+	error = xfs_validate_sb_common(mp, bp, &sb);
 
 out_error:
 	if (error == -EFSCORRUPTED || error == -EFSBADCRC)
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 03d39532c708..425a579e89a4 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1689,13 +1689,13 @@ struct drm_tile_group {
 	struct kref refcount;
 	struct drm_device *dev;
 	int id;
-	u8 group_data[8];
+	u8 group_data[9];
 };
 
 struct drm_tile_group *drm_mode_create_tile_group(struct drm_device *dev,
-						  const char topology[8]);
+						  const char topology_id[9]);
 struct drm_tile_group *drm_mode_get_tile_group(struct drm_device *dev,
-					       const char topology[8]);
+					       const char topology_id[9]);
 void drm_mode_put_tile_group(struct drm_device *dev,
 			     struct drm_tile_group *tg);
 
diff --git a/include/drm/drm_displayid.h b/include/drm/drm_displayid.h
index 77941efb5426..8cfb1a0adce2 100644
--- a/include/drm/drm_displayid.h
+++ b/include/drm/drm_displayid.h
@@ -71,7 +71,7 @@ struct displayid_tiled_block {
 	u8 topo[3];
 	u8 tile_size[4];
 	u8 tile_pixel_bezel[5];
-	u8 topology_id[8];
+	u8 topology_id[9];
 } __packed;
 
 struct displayid_detailed_timings_1 {
diff --git a/include/linux/audit.h b/include/linux/audit.h
index 199274cc7615..a830f0bee965 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -14,7 +14,7 @@
 #include <uapi/linux/audit.h>
 #include <uapi/linux/netfilter/nf_tables.h>
 
-#define AUDIT_INO_UNSET ((unsigned long)-1)
+#define AUDIT_INO_UNSET ((u64)-1)
 #define AUDIT_DEV_UNSET ((dev_t)-1)
 
 struct audit_sig_info {
@@ -120,17 +120,17 @@ enum audit_nfcfgop {
 
 extern int is_audit_feature_set(int which);
 
-extern int __init audit_register_class(int class, unsigned *list);
-extern int audit_classify_syscall(int abi, unsigned syscall);
+extern int __init audit_register_class(int class, unsigned int *list);
+extern int audit_classify_syscall(int abi, unsigned int syscall);
 extern int audit_classify_arch(int arch);
 /* only for compat system calls */
-extern unsigned compat_write_class[];
-extern unsigned compat_read_class[];
-extern unsigned compat_dir_class[];
-extern unsigned compat_chattr_class[];
-extern unsigned compat_signal_class[];
+extern unsigned int compat_write_class[];
+extern unsigned int compat_read_class[];
+extern unsigned int compat_dir_class[];
+extern unsigned int compat_chattr_class[];
+extern unsigned int compat_signal_class[];
 
-extern int audit_classify_compat_syscall(int abi, unsigned syscall);
+extern int audit_classify_compat_syscall(int abi, unsigned int syscall);
 
 /* audit_names->type values */
 #define	AUDIT_TYPE_UNKNOWN	0	/* we don't know yet */
diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index df9cbf02d030..39d2e2468c23 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -202,6 +202,9 @@ static inline struct xbc_node * __init xbc_find_node(const char *key)
 int __init xbc_node_compose_key_after(struct xbc_node *root,
 			struct xbc_node *node, char *buf, size_t size);
 
+/* Render key/value pairs under @root as a flat cmdline string */
+int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root);
+
 /**
  * xbc_node_compose_key() - Compose full key string of the XBC node
  * @node: An XBC node.
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index aaacb6aafc87..df992a81e311 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -12,6 +12,8 @@
 
 #ifdef CONFIG_BPF_LSM
 
+extern bool bpf_lsm_initialized __ro_after_init;
+
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	RET bpf_lsm_##NAME(__VA_ARGS__);
 #include <linux/lsm_hook_defs.h>
@@ -41,6 +43,8 @@ void bpf_inode_storage_free(struct inode *inode);
 
 #else /* !CONFIG_BPF_LSM */
 
+#define bpf_lsm_initialized false
+
 static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 				      const struct bpf_prog *prog)
 {
diff --git a/include/linux/ceph/ceph_debug.h b/include/linux/ceph/ceph_debug.h
index d5a5da838caf..11a92a946016 100644
--- a/include/linux/ceph/ceph_debug.h
+++ b/include/linux/ceph/ceph_debug.h
@@ -19,12 +19,25 @@
 	pr_debug("%.*s %12.12s:%-4d : " fmt,				\
 		 8 - (int)sizeof(KBUILD_MODNAME), "    ",		\
 		 kbasename(__FILE__), __LINE__, ##__VA_ARGS__)
+#  define doutc(client, fmt, ...)					\
+	pr_debug("%.*s %12.12s:%-4d : [%pU %llu] " fmt,			\
+		 8 - (int)sizeof(KBUILD_MODNAME), "    ",		\
+		 kbasename(__FILE__), __LINE__,				\
+		 &client->fsid, client->monc.auth->global_id,		\
+		 ##__VA_ARGS__)
 # else
 /* faux printk call just to see any compiler warnings. */
 #  define dout(fmt, ...)	do {				\
 		if (0)						\
 			printk(KERN_DEBUG fmt, ##__VA_ARGS__);	\
 	} while (0)
+#  define doutc(client, fmt, ...)	do {			\
+		if (0)						\
+			printk(KERN_DEBUG "[%pU %llu] " fmt,	\
+			&client->fsid,				\
+			client->monc.auth->global_id,		\
+			##__VA_ARGS__);				\
+		} while (0)
 # endif
 
 #else
@@ -33,7 +46,32 @@
  * or, just wrap pr_debug
  */
 # define dout(fmt, ...)	pr_debug(" " fmt, ##__VA_ARGS__)
+# define doutc(client, fmt, ...)					\
+	pr_debug(" [%pU %llu] %s: " fmt, &client->fsid,			\
+		 client->monc.auth->global_id, __func__, ##__VA_ARGS__)
 
 #endif
 
+#define pr_notice_client(client, fmt, ...)				\
+	pr_notice("[%pU %llu]: " fmt, &client->fsid,			\
+		  client->monc.auth->global_id, ##__VA_ARGS__)
+#define pr_info_client(client, fmt, ...)				\
+	pr_info("[%pU %llu]: " fmt, &client->fsid,			\
+		client->monc.auth->global_id, ##__VA_ARGS__)
+#define pr_warn_client(client, fmt, ...)				\
+	pr_warn("[%pU %llu]: " fmt, &client->fsid,			\
+		client->monc.auth->global_id, ##__VA_ARGS__)
+#define pr_warn_once_client(client, fmt, ...)				\
+	pr_warn_once("[%pU %llu]: " fmt, &client->fsid,			\
+		     client->monc.auth->global_id, ##__VA_ARGS__)
+#define pr_err_client(client, fmt, ...)					\
+	pr_err("[%pU %llu]: " fmt, &client->fsid,			\
+	       client->monc.auth->global_id, ##__VA_ARGS__)
+#define pr_warn_ratelimited_client(client, fmt, ...)			\
+	pr_warn_ratelimited("[%pU %llu]: " fmt, &client->fsid,		\
+			    client->monc.auth->global_id, ##__VA_ARGS__)
+#define pr_err_ratelimited_client(client, fmt, ...)			\
+	pr_err_ratelimited("[%pU %llu]: " fmt, &client->fsid,		\
+			   client->monc.auth->global_id, ##__VA_ARGS__)
+
 #endif
diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
index d44a77e8a7e3..f35f264cac1a 100644
--- a/include/linux/dma-resv.h
+++ b/include/linux/dma-resv.h
@@ -273,7 +273,7 @@ dma_resv_get_excl_rcu(struct dma_resv *obj)
 
 void dma_resv_init(struct dma_resv *obj);
 void dma_resv_fini(struct dma_resv *obj);
-int dma_resv_reserve_shared(struct dma_resv *obj, unsigned int num_fences);
+int dma_resv_reserve_fences(struct dma_resv *obj, unsigned int num_fences);
 void dma_resv_add_shared_fence(struct dma_resv *obj, struct dma_fence *fence);
 
 void dma_resv_add_excl_fence(struct dma_resv *obj, struct dma_fence *fence);
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index cab6e18773da..d4333e721588 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -18,13 +18,11 @@ struct dw_edma;
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
  * @id:			 instance ID
- * @irq:		 irq line
  * @dw:			 struct dw_edma that is filed by dw_edma_probe()
  */
 struct dw_edma_chip {
 	struct device		*dev;
 	int			id;
-	int			irq;
 	struct dw_edma		*dw;
 };
 
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index 84e346ae766e..2235ffec3fae 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/cleanup.h>
 #include <linux/gfp.h>
 
 #define FW_ACTION_NOHOTPLUG 0
@@ -118,4 +119,6 @@ static inline int request_partial_firmware_into_buf
 
 int firmware_request_cache(struct device *device, const char *name);
 
+DEFINE_FREE(firmware, struct firmware *, release_firmware(_T))
+
 #endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 11294a89a53b..5417515c4111 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -178,6 +178,12 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File supports async buffered reads */
 #define FMODE_BUF_RASYNC	((__force fmode_t)0x40000000)
 
+/*
+ * fsnotify pre-content events do not exist in this kernel, so a file is never
+ * watched by a pre-content event listener.
+ */
+#define FMODE_FSNOTIFY_HSM(mode)	0
+
 /*
  * Attribute flags.  These should be or-ed together to figure out what
  * has been changed!
@@ -2981,6 +2987,28 @@ static inline void allow_write_access(struct file *file)
 	if (file)
 		atomic_inc(&file_inode(file)->i_writecount);
 }
+
+/*
+ * Do not prevent write to executable file when watched by pre-content events.
+ *
+ * Note that FMODE_FSNOTIFY_HSM mode is set depending on pre-content watches at
+ * the time of file open and remains constant for entire lifetime of the file,
+ * so if pre-content watches are added post execution or removed before the end
+ * of the execution, it will not cause i_writecount reference leak.
+ */
+static inline int exe_file_deny_write_access(struct file *exe_file)
+{
+	if (unlikely(FMODE_FSNOTIFY_HSM(exe_file->f_mode)))
+		return 0;
+	return deny_write_access(exe_file);
+}
+static inline void exe_file_allow_write_access(struct file *exe_file)
+{
+	if (unlikely(!exe_file || FMODE_FSNOTIFY_HSM(exe_file->f_mode)))
+		return;
+	allow_write_access(exe_file);
+}
+
 static inline bool inode_is_open_for_write(const struct inode *inode)
 {
 	return atomic_read(&inode->i_writecount) > 0;
diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
index 1ef421818d3a..95cf902e0bda 100644
--- a/include/linux/i2c-smbus.h
+++ b/include/linux/i2c-smbus.h
@@ -30,10 +30,10 @@ struct i2c_client *i2c_new_smbus_alert_device(struct i2c_adapter *adapter,
 					      struct i2c_smbus_alert_setup *setup);
 int i2c_handle_smbus_alert(struct i2c_client *ara);
 
-#if IS_ENABLED(CONFIG_I2C_SMBUS) && IS_ENABLED(CONFIG_OF)
-int of_i2c_setup_smbus_alert(struct i2c_adapter *adap);
+#if IS_ENABLED(CONFIG_I2C_SMBUS)
+int i2c_setup_smbus_alert(struct i2c_adapter *adap);
 #else
-static inline int of_i2c_setup_smbus_alert(struct i2c_adapter *adap)
+static inline int i2c_setup_smbus_alert(struct i2c_adapter *adap)
 {
 	return 0;
 }
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 80f573d1b3b8..f5826f99fe9a 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -68,7 +68,7 @@ extern void *jbd2_alloc(size_t size, gfp_t flags);
 extern void jbd2_free(void *ptr, size_t size);
 
 #define JBD2_MIN_JOURNAL_BLOCKS 1024
-#define JBD2_MIN_FC_BLOCKS	256
+#define JBD2_DEFAULT_FAST_COMMIT_BLOCKS 256
 
 #ifdef __KERNEL__
 
@@ -1686,6 +1686,13 @@ static inline int jbd2_journal_has_csum_v2or3(journal_t *journal)
 	return journal->j_chksum_driver != NULL;
 }
 
+static inline int jbd2_journal_get_num_fc_blks(journal_superblock_t *jsb)
+{
+	int num_fc_blocks = be32_to_cpu(jsb->s_num_fc_blks);
+
+	return num_fc_blocks ? num_fc_blocks : JBD2_DEFAULT_FAST_COMMIT_BLOCKS;
+}
+
 /*
  * Return number of free blocks in the log. Must be called under j_state_lock.
  */
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 1e6a377af368..5b9c303876a5 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -318,6 +318,7 @@ struct kvm_vcpu {
 		bool dy_eligible;
 	} spin_loop;
 #endif
+	bool wants_to_run;
 	bool preempted;
 	bool ready;
 	struct kvm_vcpu_arch arch;
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index bbf9c8c7bd9c..5d8d8d18169f 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1563,6 +1563,7 @@ struct lsm_blob_sizes {
 	int	lbs_cred;
 	int	lbs_file;
 	int	lbs_inode;
+	int	lbs_sock;
 	int	lbs_ipc;
 	int	lbs_msg_msg;
 	int	lbs_task;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index b9605b2b46e7..2fcc99e28d44 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -61,6 +61,7 @@ static inline int user_path_at(int dfd, const char __user *name, unsigned flags,
 }
 
 extern int kern_path(const char *, unsigned, struct path *);
+struct dentry *kern_path_parent(const char *name, struct path *parent);
 
 extern struct dentry *kern_path_create(int, const char *, struct path *, unsigned int);
 extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6018d7eace6b..47c53bbf3f9d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1101,6 +1101,7 @@ int pci_find_next_ext_capability(struct pci_dev *dev, int pos, int cap);
 int pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
 int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap);
 struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
+u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap);
 
 u64 pci_get_dsn(struct pci_dev *dev);
 
diff --git a/include/linux/property.h b/include/linux/property.h
index 0604bb73e628..98227dbac953 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -120,6 +120,7 @@ struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
 void fwnode_handle_put(struct fwnode_handle *fwnode);
 
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
+int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);
 
 unsigned int device_get_child_node_count(struct device *dev);
 
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 667de403b2eb..01eb7bc4e84b 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2317,6 +2317,8 @@ static inline void *skb_pull_inline(struct sk_buff *skb, unsigned int len)
 	return unlikely(len > skb->len) ? NULL : __skb_pull(skb, len);
 }
 
+void *skb_pull_data(struct sk_buff *skb, size_t len);
+
 void *__pskb_pull_tail(struct sk_buff *skb, int delta);
 
 static inline void *__pskb_pull(struct sk_buff *skb, unsigned int len)
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index 5db2b11ab085..e6f60d411e2a 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -181,6 +181,8 @@ void tb_unregister_property_dir(const char *key, struct tb_property_dir *dir);
  * @device_name: Name of the device (or %NULL if not known)
  * @is_unplugged: The XDomain is unplugged
  * @resume: The XDomain is being resumed
+ * @removing: Set by tb_xdomain_remove() under @lock to prevent
+ *	      concurrent delayed work queueing
  * @needs_uuid: If the XDomain does not have @remote_uuid it will be
  *		queried first
  * @transmit_path: HopID which the remote end expects us to transmit
@@ -225,6 +227,7 @@ struct tb_xdomain {
 	const char *device_name;
 	bool is_unplugged;
 	bool resume;
+	bool removing;
 	bool needs_uuid;
 	u16 transmit_path;
 	u16 transmit_ring;
diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
index 92cd9f038fed..4174a7ea3f1e 100644
--- a/include/media/v4l2-async.h
+++ b/include/media/v4l2-async.h
@@ -298,7 +298,9 @@ void v4l2_async_notifier_cleanup(struct v4l2_async_notifier *notifier);
  *
  * @sd: pointer to &struct v4l2_subdev
  */
-int v4l2_async_register_subdev(struct v4l2_subdev *sd);
+#define v4l2_async_register_subdev(sd) \
+	__v4l2_async_register_subdev(sd, THIS_MODULE)
+int __v4l2_async_register_subdev(struct v4l2_subdev *sd, struct module *module);
 
 /**
  * v4l2_async_register_subdev_sensor_common - registers a sensor sub-device to
@@ -319,8 +321,11 @@ int v4l2_async_register_subdev(struct v4l2_subdev *sd);
  * An error is returned if the module is no longer loaded on any attempts
  * to register it.
  */
+#define v4l2_async_register_subdev_sensor_common(sd) \
+	__v4l2_async_register_subdev_sensor_common(sd, THIS_MODULE)
 int __must_check
-v4l2_async_register_subdev_sensor_common(struct v4l2_subdev *sd);
+__v4l2_async_register_subdev_sensor_common(struct v4l2_subdev *sd,
+					   struct module *module);
 
 /**
  * v4l2_async_unregister_subdev - unregisters a sub-device to the asynchronous
diff --git a/include/net/act_api.h b/include/net/act_api.h
index bbc4ab5e04f7..fcf5ac9faf19 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -240,6 +240,26 @@ int tcf_action_check_ctrlact(int action, struct tcf_proto *tp,
 			     struct netlink_ext_ack *newchain);
 struct tcf_chain *tcf_action_set_ctrlact(struct tc_action *a, int action,
 					 struct tcf_chain *newchain);
+
+/* Range check for a control action supplied by user space.
+ *
+ * This is the same test tcf_action_check_ctrlact() applies to the primary
+ * control action, factored out for the *fallback* control actions
+ * (act_gact's TCA_GACT_PROB.paction and act_police's TCA_POLICE_RESULT),
+ * which must not reach tcf_action_check_ctrlact() because they have no
+ * goto_chain to allocate.  Without it, user space can store kernel-internal
+ * verdicts such as TC_ACT_CONSUMED, which is TC_ACT_VALUE_MAX + 1 and is
+ * deliberately not part of the UAPI value range.
+ */
+static inline bool tcf_action_valid(int action)
+{
+	int opcode = TC_ACT_EXT_OPCODE(action);
+
+	if (!opcode)
+		return action <= TC_ACT_VALUE_MAX;
+	return opcode <= TC_ACT_EXT_OPCODE_MAX || action == TC_ACT_UNSPEC;
+}
+
 #endif /* CONFIG_NET_CLS_ACT */
 
 static inline void tcf_action_stats_update(struct tc_action *a, u64 bytes,
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index d7a037d32bcc..b4be1f90f149 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -297,6 +297,9 @@ int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
 		      struct ip_tunnel_parm *p, __u32 fwmark);
 void ip_tunnel_setup(struct net_device *dev, unsigned int net_id);
 
+bool ip_tunnel_netlink_encap_parms(struct nlattr *data[],
+				   struct ip_tunnel_encap *encap);
+
 extern const struct header_ops ip_tunnel_header_ops;
 __be16 ip_tunnel_parse_protocol(const struct sk_buff *skb);
 
diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index 9f4224eb18a3..d9a2e1e080fd 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -33,6 +33,12 @@
 #define IP_VS_HDR_INVERSE	1
 #define IP_VS_HDR_ICMP		2
 
+/* Destination Server Flags */
+#define IP_VS_DEST_F_OVERLOAD	0x0002		/* server is overloaded */
+
+/* Destination Server Config Flags */
+#define IP_VS_DEST_CF_AVAILABLE	0x0001		/* server is available */
+
 /* Generic access of ipvs struct */
 static inline struct netns_ipvs *net_ipvs(struct net* net)
 {
@@ -664,6 +670,7 @@ struct ip_vs_dest {
 	volatile unsigned int	flags;		/* dest status flags */
 	atomic_t		conn_flags;	/* flags to copy to conn */
 	atomic_t		weight;		/* server weight */
+	unsigned long		cflags;		/* config flags */
 	atomic_t		last_weight;	/* server latest weight */
 	__u16			tun_type;	/* tunnel type */
 	__be16			tun_port;	/* tunnel port */
diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 6cde10ae4445..c22e72eb5f6e 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -134,6 +134,7 @@ enum rxrpc_recvmsg_trace {
 	rxrpc_recvmsg_return,
 	rxrpc_recvmsg_terminal,
 	rxrpc_recvmsg_to_be_accepted,
+	rxrpc_recvmsg_unqueue,
 	rxrpc_recvmsg_wait,
 };
 
@@ -333,6 +334,7 @@ enum rxrpc_tx_point {
 	EM(rxrpc_recvmsg_return,		"RETN") \
 	EM(rxrpc_recvmsg_terminal,		"TERM") \
 	EM(rxrpc_recvmsg_to_be_accepted,	"TBAC") \
+	EM(rxrpc_recvmsg_unqueue,		"UNQU") \
 	E_(rxrpc_recvmsg_wait,			"WAIT")
 
 #define rxrpc_rtt_tx_traces \
diff --git a/include/uapi/linux/ip_vs.h b/include/uapi/linux/ip_vs.h
index 4102ddcb4e14..9e4a762f31d8 100644
--- a/include/uapi/linux/ip_vs.h
+++ b/include/uapi/linux/ip_vs.h
@@ -28,12 +28,6 @@
 #define IP_VS_SVC_F_SCHED_SH_FALLBACK	IP_VS_SVC_F_SCHED1 /* SH fallback */
 #define IP_VS_SVC_F_SCHED_SH_PORT	IP_VS_SVC_F_SCHED2 /* SH use port */
 
-/*
- *      Destination Server Flags
- */
-#define IP_VS_DEST_F_AVAILABLE	0x0001		/* server is available */
-#define IP_VS_DEST_F_OVERLOAD	0x0002		/* server is overloaded */
-
 /*
  *      IPVS sync daemon states
  */
diff --git a/init/main.c b/init/main.c
index cbb7ad93d7fa..d23d1a8d5393 100644
--- a/init/main.c
+++ b/init/main.c
@@ -314,45 +314,6 @@ static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
 
 #ifdef CONFIG_BOOT_CONFIG
 
-static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
-
-#define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
-
-static int __init xbc_snprint_cmdline(char *buf, size_t size,
-				      struct xbc_node *root)
-{
-	struct xbc_node *knode, *vnode;
-	char *end = buf + size;
-	const char *val;
-	int ret;
-
-	xbc_node_for_each_key_value(root, knode, val) {
-		ret = xbc_node_compose_key_after(root, knode,
-					xbc_namebuf, XBC_KEYLEN_MAX);
-		if (ret < 0)
-			return ret;
-
-		vnode = xbc_node_get_child(knode);
-		if (!vnode) {
-			ret = snprintf(buf, rest(buf, end), "%s ", xbc_namebuf);
-			if (ret < 0)
-				return ret;
-			buf += ret;
-			continue;
-		}
-		xbc_array_for_each_value(vnode, val) {
-			ret = snprintf(buf, rest(buf, end), "%s=\"%s\" ",
-				       xbc_namebuf, val);
-			if (ret < 0)
-				return ret;
-			buf += ret;
-		}
-	}
-
-	return buf - (end - size);
-}
-#undef rest
-
 /* Make an extra command line under given key word */
 static char * __init xbc_make_cmdline(const char *key)
 {
diff --git a/kernel/audit.c b/kernel/audit.c
index eec8fc5006fd..907ed7b147c6 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1989,7 +1989,7 @@ static void audit_log_vformat(struct audit_buffer *ab, const char *fmt,
 		 * here and AUDIT_BUFSIZ is at least 1024, then we can
 		 * log everything that printk could have logged. */
 		avail = audit_expand(ab,
-			max_t(unsigned, AUDIT_BUFSIZ, 1+len-avail));
+			max_t(unsigned int, AUDIT_BUFSIZ, 1+len-avail));
 		if (!avail)
 			goto out_va_end;
 		len = vsnprintf(skb_tail_pointer(skb), avail, fmt, args2);
diff --git a/kernel/audit.h b/kernel/audit.h
index 1918019e6aaf..54cc424bfc4f 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -71,7 +71,7 @@ struct audit_names {
 	int			name_len;	/* number of chars to log */
 	bool			hidden;		/* don't log this record */
 
-	unsigned long		ino;
+	u64			ino;
 	dev_t			dev;
 	umode_t			mode;
 	kuid_t			uid;
@@ -209,15 +209,15 @@ extern int auditd_test_task(struct task_struct *task);
 #define AUDIT_INODE_BUCKETS	32
 extern struct list_head audit_inode_hash[AUDIT_INODE_BUCKETS];
 
-static inline int audit_hash_ino(u32 ino)
+static inline int audit_hash_ino(u64 ino)
 {
-	return (ino & (AUDIT_INODE_BUCKETS-1));
+	return ((u32)ino & (AUDIT_INODE_BUCKETS-1));
 }
 
 /* Indicates that audit should log the full pathname. */
 #define AUDIT_NAME_FULL -1
 
-extern int audit_match_class(int class, unsigned syscall);
+extern int audit_match_class(int class, unsigned int syscall);
 extern int audit_comparator(const u32 left, const u32 op, const u32 right);
 extern int audit_uid_comparator(kuid_t left, u32 op, kuid_t right);
 extern int audit_gid_comparator(kgid_t left, u32 op, kgid_t right);
@@ -242,8 +242,13 @@ extern int audit_del_rule(struct audit_entry *entry);
 extern void audit_free_rule_rcu(struct rcu_head *head);
 extern struct list_head audit_filter_list[];
 
-extern struct audit_entry *audit_dupe_rule(struct audit_krule *old);
+struct audit_watch_ctx {
+	struct inode *dir;
+	struct inode *child;
+};
 
+extern struct audit_entry *audit_dupe_rule(struct audit_krule *old,
+					   struct audit_watch_ctx *ctx);
 extern void audit_log_d_path_exe(struct audit_buffer *ab,
 				 struct mm_struct *mm);
 
@@ -263,17 +268,18 @@ extern int audit_to_watch(struct audit_krule *krule, char *path, int len,
 extern int audit_add_watch(struct audit_krule *krule, struct list_head **list);
 extern void audit_remove_watch_rule(struct audit_krule *krule);
 extern char *audit_watch_path(struct audit_watch *watch);
-extern int audit_watch_compare(struct audit_watch *watch, unsigned long ino,
-			       dev_t dev);
+extern int audit_watch_compare(struct audit_watch *watch, u64 ino, dev_t dev);
 
 extern struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule,
-						    char *pathname, int len);
+						    char *pathname, int len,
+						    struct audit_watch_ctx *ctx);
 extern char *audit_mark_path(struct audit_fsnotify_mark *mark);
 extern void audit_remove_mark(struct audit_fsnotify_mark *audit_mark);
 extern void audit_remove_mark_rule(struct audit_krule *krule);
-extern int audit_mark_compare(struct audit_fsnotify_mark *mark,
-			      unsigned long ino, dev_t dev);
-extern int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old);
+extern int audit_mark_compare(struct audit_fsnotify_mark *mark, u64 ino,
+			      dev_t dev);
+extern int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old,
+			  struct audit_watch_ctx *ctx);
 extern int audit_exe_compare(struct task_struct *tsk,
 			     struct audit_fsnotify_mark *mark);
 
@@ -304,13 +310,13 @@ extern struct list_head *audit_killed_trees(void);
 #define audit_watch_path(w) ""
 #define audit_watch_compare(w, i, d) 0
 
-#define audit_alloc_mark(k, p, l) (ERR_PTR(-EINVAL))
+#define audit_alloc_mark(k, p, l, c) (ERR_PTR(-EINVAL))
 #define audit_mark_path(m) ""
 #define audit_remove_mark(m)
 #define audit_remove_mark_rule(k)
 #define audit_mark_compare(m, i, d) 0
 #define audit_exe_compare(t, m) (-EINVAL)
-#define audit_dupe_exe(n, o) (-EINVAL)
+#define audit_dupe_exe(n, o, c) (-EINVAL)
 
 #define audit_remove_tree_rule(rule) BUG()
 #define audit_add_tree_rule(rule) -EINVAL
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index 691f90dd09d2..e62066bf0b0a 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -25,7 +25,7 @@
  */
 struct audit_fsnotify_mark {
 	dev_t dev;		/* associated superblock device */
-	unsigned long ino;	/* associated inode number */
+	u64 ino;		/* associated inode number */
 	char *path;		/* insertion path */
 	struct fsnotify_mark mark; /* fsnotify mark on the inode */
 	struct audit_krule *rule;
@@ -57,7 +57,7 @@ char *audit_mark_path(struct audit_fsnotify_mark *mark)
 	return mark->path;
 }
 
-int audit_mark_compare(struct audit_fsnotify_mark *mark, unsigned long ino, dev_t dev)
+int audit_mark_compare(struct audit_fsnotify_mark *mark, u64 ino, dev_t dev)
 {
 	if (mark->ino == AUDIT_INO_UNSET)
 		return 0;
@@ -71,22 +71,30 @@ static void audit_update_mark(struct audit_fsnotify_mark *audit_mark,
 	audit_mark->ino = inode ? inode->i_ino : AUDIT_INO_UNSET;
 }
 
-struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pathname, int len)
+struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pathname,
+					     int len, struct audit_watch_ctx *ctx)
 {
 	struct audit_fsnotify_mark *audit_mark;
 	struct path path;
 	struct dentry *dentry;
-	struct inode *inode;
-	int ret;
+	struct inode *dir, *child;
+	int ret, allow_dups;
 
 	if (pathname[0] != '/' || pathname[len-1] == '/')
 		return ERR_PTR(-EINVAL);
 
-	dentry = kern_path_locked(pathname, &path);
-	if (IS_ERR(dentry))
-		return (void *)dentry; /* returning an error */
-	inode = path.dentry->d_inode;
-	inode_unlock(inode);
+	if (!ctx) {
+		dentry = kern_path_parent(pathname, &path);
+		if (IS_ERR(dentry))
+			return ERR_CAST(dentry); /* returning an error */
+		dir = d_inode(path.dentry);
+		child = d_inode(dentry);
+		allow_dups = 0;
+	} else {
+		dir = ctx->dir;
+		child = ctx->child;
+		allow_dups = 1;
+	}
 
 	audit_mark = kzalloc(sizeof(*audit_mark), GFP_KERNEL);
 	if (unlikely(!audit_mark)) {
@@ -97,18 +105,21 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
 	fsnotify_init_mark(&audit_mark->mark, audit_fsnotify_group);
 	audit_mark->mark.mask = AUDIT_FS_EVENTS;
 	audit_mark->path = pathname;
-	audit_update_mark(audit_mark, dentry->d_inode);
 	audit_mark->rule = krule;
 
-	ret = fsnotify_add_inode_mark(&audit_mark->mark, inode, 0);
+	audit_update_mark(audit_mark, child);
+	ret = fsnotify_add_inode_mark(&audit_mark->mark, dir, allow_dups);
+
 	if (ret < 0) {
 		audit_mark->path = NULL;
 		fsnotify_put_mark(&audit_mark->mark);
 		audit_mark = ERR_PTR(ret);
 	}
 out:
-	dput(dentry);
-	path_put(&path);
+	if (!ctx) {
+		dput(dentry);
+		path_put(&path);
+	}
 	return audit_mark;
 }
 
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index 0c35879bbf7c..ee702e32e62c 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -33,7 +33,7 @@ struct audit_chunk {
 	struct node {
 		struct list_head list;
 		struct audit_tree *owner;
-		unsigned index;		/* index; upper bit indicates 'will prune' */
+		unsigned int index;	/* index; upper bit indicates 'will prune' */
 	} owners[];
 };
 
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 5cf22fe30149..c449c2af1fa0 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -37,7 +37,7 @@ struct audit_watch {
 	refcount_t		count;	/* reference count */
 	dev_t			dev;	/* associated superblock device */
 	char			*path;	/* insertion path */
-	unsigned long		ino;	/* associated inode number */
+	u64			ino;	/* associated inode number */
 	struct audit_parent	*parent; /* associated parent */
 	struct list_head	wlist;	/* entry in parent->watches list */
 	struct list_head	rules;	/* anchor for krule->rlist */
@@ -125,7 +125,7 @@ char *audit_watch_path(struct audit_watch *watch)
 	return watch->path;
 }
 
-int audit_watch_compare(struct audit_watch *watch, unsigned long ino, dev_t dev)
+int audit_watch_compare(struct audit_watch *watch, u64 ino, dev_t dev)
 {
 	return (watch->ino != AUDIT_INO_UNSET) &&
 		(watch->ino == ino) &&
@@ -243,7 +243,8 @@ static void audit_watch_log_rule_change(struct audit_krule *r, struct audit_watc
 /* Update inode info in audit rules based on filesystem event. */
 static void audit_update_watch(struct audit_parent *parent,
 			       const struct qstr *dname, dev_t dev,
-			       unsigned long ino, unsigned invalidating)
+			       u64 ino, unsigned int invalidating,
+			       struct audit_watch_ctx *ctx)
 {
 	struct audit_watch *owatch, *nwatch, *nextw;
 	struct audit_krule *r, *nextr;
@@ -279,12 +280,12 @@ static void audit_update_watch(struct audit_parent *parent,
 			list_del(&oentry->rule.rlist);
 			list_del_rcu(&oentry->list);
 
-			nentry = audit_dupe_rule(&oentry->rule);
+			nentry = audit_dupe_rule(&oentry->rule, ctx);
 			if (IS_ERR(nentry)) {
 				list_del(&oentry->rule.list);
 				audit_panic("error updating watch, removing");
 			} else {
-				int h = audit_hash_ino((u32)ino);
+				int h = audit_hash_ino(ino);
 
 				/*
 				 * nentry->rule.watch == oentry->rule.watch so
@@ -346,15 +347,18 @@ static void audit_remove_parent_watches(struct audit_parent *parent)
 /* Get path information necessary for adding watches. */
 static int audit_get_nd(struct audit_watch *watch, struct path *parent)
 {
-	struct dentry *d = kern_path_locked(watch->path, parent);
+	struct dentry *d;
+
+	d = kern_path_parent(watch->path, parent);
 	if (IS_ERR(d))
 		return PTR_ERR(d);
+
 	if (d_is_positive(d)) {
 		/* update watch filter fields */
 		watch->dev = d->d_sb->s_dev;
 		watch->ino = d_backing_inode(d)->i_ino;
 	}
-	inode_unlock(d_backing_inode(parent->dentry));
+
 	dput(d);
 	return 0;
 }
@@ -435,7 +439,7 @@ int audit_add_watch(struct audit_krule *krule, struct list_head **list)
 
 	audit_add_to_parent(krule, parent);
 
-	h = audit_hash_ino((u32)watch->ino);
+	h = audit_hash_ino(watch->ino);
 	*list = &audit_inode_hash[h];
 error:
 	path_put(&parent_path);
@@ -475,10 +479,17 @@ static int audit_watch_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
 	if (WARN_ON_ONCE(inode_mark->group != audit_watch_group))
 		return 0;
 
-	if (mask & (FS_CREATE|FS_MOVED_TO) && inode)
-		audit_update_watch(parent, dname, inode->i_sb->s_dev, inode->i_ino, 0);
-	else if (mask & (FS_DELETE|FS_MOVED_FROM))
-		audit_update_watch(parent, dname, AUDIT_DEV_UNSET, AUDIT_INO_UNSET, 1);
+	if (mask & (FS_CREATE|FS_MOVED_TO) && inode) {
+		struct audit_watch_ctx ctx = { .dir = dir, .child = inode };
+
+		audit_update_watch(parent, dname, inode->i_sb->s_dev, inode->i_ino, 0,
+				   &ctx);
+	} else if (mask & (FS_DELETE|FS_MOVED_FROM)) {
+		struct audit_watch_ctx ctx = { .dir = dir, .child = NULL };
+
+		audit_update_watch(parent, dname, AUDIT_DEV_UNSET, AUDIT_INO_UNSET, 1,
+				   &ctx);
+	}
 	else if (mask & (FS_DELETE_SELF|FS_UNMOUNT|FS_MOVE_SELF))
 		audit_remove_parent_watches(parent);
 
@@ -501,7 +512,8 @@ static int __init audit_watch_init(void)
 }
 device_initcall(audit_watch_init);
 
-int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old)
+int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old,
+		   struct audit_watch_ctx *ctx)
 {
 	struct audit_fsnotify_mark *audit_mark;
 	char *pathname;
@@ -510,7 +522,7 @@ int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old)
 	if (!pathname)
 		return -ENOMEM;
 
-	audit_mark = audit_alloc_mark(new, pathname, strlen(pathname));
+	audit_mark = audit_alloc_mark(new, pathname, strlen(pathname), ctx);
 	if (IS_ERR(audit_mark)) {
 		kfree(pathname);
 		return PTR_ERR(audit_mark);
@@ -523,7 +535,7 @@ int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old)
 int audit_exe_compare(struct task_struct *tsk, struct audit_fsnotify_mark *mark)
 {
 	struct file *exe_file;
-	unsigned long ino;
+	u64 ino;
 	dev_t dev;
 
 	/* only do exe filtering if we are recording @current events/records */
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index f1346bf5943f..f951d93698e6 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -162,13 +162,13 @@ static inline int audit_to_inode(struct audit_krule *krule,
 
 static __u32 *classes[AUDIT_SYSCALL_CLASSES];
 
-int __init audit_register_class(int class, unsigned *list)
+int __init audit_register_class(int class, unsigned int *list)
 {
 	__u32 *p = kcalloc(AUDIT_BITMASK_SIZE, sizeof(__u32), GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 	while (*list != ~0U) {
-		unsigned n = *list++;
+		unsigned int n = *list++;
 		if (n >= AUDIT_BITMASK_SIZE * 32 - AUDIT_SYSCALL_CLASSES) {
 			kfree(p);
 			return -EINVAL;
@@ -183,7 +183,7 @@ int __init audit_register_class(int class, unsigned *list)
 	return 0;
 }
 
-int audit_match_class(int class, unsigned syscall)
+int audit_match_class(int class, unsigned int syscall)
 {
 	if (unlikely(syscall >= AUDIT_BITMASK_SIZE * 32))
 		return 0;
@@ -234,7 +234,7 @@ static int audit_match_signal(struct audit_entry *entry)
 /* Common user-space to kernel rule translation. */
 static inline struct audit_entry *audit_to_entry_common(struct audit_rule_data *rule)
 {
-	unsigned listnr;
+	unsigned int listnr;
 	struct audit_entry *entry;
 	int i, err;
 
@@ -582,7 +582,7 @@ static struct audit_entry *audit_data_to_entry(struct audit_rule_data *data,
 				err = PTR_ERR(str);
 				goto exit_free;
 			}
-			audit_mark = audit_alloc_mark(&entry->rule, str, f_val);
+			audit_mark = audit_alloc_mark(&entry->rule, str, f_val, NULL);
 			if (IS_ERR(audit_mark)) {
 				kfree(str);
 				err = PTR_ERR(audit_mark);
@@ -809,7 +809,8 @@ static inline int audit_dupe_lsm_field(struct audit_field *df,
  * rule with the new rule in the filterlist, then free the old rule.
  * The rlist element is undefined; list manipulations are handled apart from
  * the initial copy. */
-struct audit_entry *audit_dupe_rule(struct audit_krule *old)
+struct audit_entry *audit_dupe_rule(struct audit_krule *old,
+				    struct audit_watch_ctx *ctx)
 {
 	u32 fcount = old->field_count;
 	struct audit_entry *entry;
@@ -868,7 +869,7 @@ struct audit_entry *audit_dupe_rule(struct audit_krule *old)
 				new->filterkey = fk;
 			break;
 		case AUDIT_EXE:
-			err = audit_dupe_exe(new, old);
+			err = audit_dupe_exe(new, old, ctx);
 			break;
 		}
 		if (err) {
@@ -1400,7 +1401,7 @@ static int update_lsm_rule(struct audit_krule *r)
 	if (!security_audit_rule_known(r))
 		return 0;
 
-	nentry = audit_dupe_rule(r);
+	nentry = audit_dupe_rule(r, NULL);
 	if (entry->rule.exe)
 		audit_remove_mark(entry->rule.exe);
 	if (IS_ERR(nentry)) {
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 9f233616748a..95d41514720e 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -161,7 +161,7 @@ static const struct audit_nfcfgop_tab audit_nfcfgs[] = {
 
 static int audit_match_perm(struct audit_context *ctx, int mask)
 {
-	unsigned n;
+	unsigned int n;
 	if (unlikely(!ctx))
 		return 0;
 	n = ctx->major;
@@ -837,7 +837,7 @@ static enum audit_state audit_filter_syscall(struct task_struct *tsk,
 static int audit_filter_inode_name(struct task_struct *tsk,
 				   struct audit_names *n,
 				   struct audit_context *ctx) {
-	int h = audit_hash_ino((u32)n->ino);
+	int h = audit_hash_ino(n->ino);
 	struct list_head *list = &audit_inode_hash[h];
 	struct audit_entry *e;
 	enum audit_state state;
@@ -1431,7 +1431,7 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 		audit_log_format(ab, " name=(null)");
 
 	if (n->ino != AUDIT_INO_UNSET)
-		audit_log_format(ab, " inode=%lu dev=%02x:%02x mode=%#ho ouid=%u ogid=%u rdev=%02x:%02x",
+		audit_log_format(ab, " inode=%llu dev=%02x:%02x mode=%#ho ouid=%u ogid=%u rdev=%02x:%02x",
 				 n->ino,
 				 MAJOR(n->dev),
 				 MINOR(n->dev),
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index a4ac48c7dada..4fd82425feba 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -223,6 +223,16 @@ static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
 {
 	struct bpf_local_storage_map *smap;
 
+	/*
+	 * Do not allow allocation of BPF_MAP_TYPE_INODE_STORAGE if the BPF LSM
+	 * was not initialized by the LSM framework at boot. Without proper
+	 * initialization, the BPF inode security blob offset remains unprepared,
+	 * causing bpf_inode() to calculate an invalid memory offset and corrupt
+	 * inode->i_security.
+	 */
+	if (!bpf_lsm_initialized)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	smap = bpf_local_storage_map_alloc(attr);
 	if (IS_ERR(smap))
 		return ERR_CAST(smap);
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index debaeb07ae53..f31ae8834775 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -950,6 +950,12 @@ void psi_cgroup_free(struct cgroup *cgroup)
 		return;
 
 	cancel_delayed_work_sync(&cgroup->psi.avgs_work);
+	/*
+	 * A psi_schedule_poll_work() call racing the last trigger's
+	 * destruction may have re-armed the timer after psi_trigger_destroy()
+	 * deleted it. Spurious firing while the group is alive is harmless.
+	 */
+	timer_delete_sync(&cgroup->psi.poll_timer);
 	free_percpu(cgroup->psi.pcpu);
 	/* All triggers must be removed by now */
 	WARN_ONCE(cgroup->psi.poll_states, "psi: trigger leak\n");
diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 14c65293a865..a2d24fb7cf40 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -188,13 +188,39 @@ static int fill_stats_for_pid(pid_t pid, struct taskstats *stats)
 	return 0;
 }
 
+static void tgid_stats_add_task(struct taskstats *stats,
+				struct task_struct *tsk, u64 now_ns)
+{
+	u64 delta, utime, stime;
+
+	/*
+	 * Each accounting subsystem calls its functions here to
+	 * accumulate its per-task stats for tsk, into the per-tgid structure
+	 *
+	 *	per-task-foo(stats, tsk);
+	 */
+	delayacct_add_tsk(stats, tsk);
+
+	/* calculate task elapsed time in nsec */
+	delta = now_ns - tsk->start_time;
+	/* Convert to micro seconds */
+	do_div(delta, NSEC_PER_USEC);
+	stats->ac_etime += delta;
+
+	task_cputime(tsk, &utime, &stime);
+	stats->ac_utime += div_u64(utime, NSEC_PER_USEC);
+	stats->ac_stime += div_u64(stime, NSEC_PER_USEC);
+
+	stats->nvcsw += tsk->nvcsw;
+	stats->nivcsw += tsk->nivcsw;
+}
+
 static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
 {
 	struct task_struct *tsk, *first;
 	unsigned long flags;
 	int rc = -ESRCH;
-	u64 delta, utime, stime;
-	u64 start_time;
+	u64 now_ns;
 
 	/*
 	 * Add additional stats from live tasks except zombie thread group
@@ -211,32 +237,13 @@ static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
 	else
 		memset(stats, 0, sizeof(*stats));
 
-	tsk = first;
-	start_time = ktime_get_ns();
-	do {
+	now_ns = ktime_get_ns();
+	for_each_thread(first, tsk) {
 		if (tsk->exit_state)
 			continue;
-		/*
-		 * Accounting subsystem can call its functions here to
-		 * fill in relevant parts of struct taskstsats as follows
-		 *
-		 *	per-task-foo(stats, tsk);
-		 */
-		delayacct_add_tsk(stats, tsk);
-
-		/* calculate task elapsed time in nsec */
-		delta = start_time - tsk->start_time;
-		/* Convert to micro seconds */
-		do_div(delta, NSEC_PER_USEC);
-		stats->ac_etime += delta;
 
-		task_cputime(tsk, &utime, &stime);
-		stats->ac_utime += div_u64(utime, NSEC_PER_USEC);
-		stats->ac_stime += div_u64(stime, NSEC_PER_USEC);
-
-		stats->nvcsw += tsk->nvcsw;
-		stats->nivcsw += tsk->nivcsw;
-	} while_each_thread(first, tsk);
+		tgid_stats_add_task(stats, tsk, now_ns);
+	}
 
 	unlock_task_sighand(first, &flags);
 	rc = 0;
@@ -254,18 +261,14 @@ static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
 static void fill_tgid_exit(struct task_struct *tsk)
 {
 	unsigned long flags;
+	u64 now_ns;
 
 	spin_lock_irqsave(&tsk->sighand->siglock, flags);
 	if (!tsk->signal->stats)
 		goto ret;
 
-	/*
-	 * Each accounting subsystem calls its functions here to
-	 * accumalate its per-task stats for tsk, into the per-tgid structure
-	 *
-	 *	per-task-foo(tsk->signal->stats, tsk);
-	 */
-	delayacct_add_tsk(tsk->signal->stats, tsk);
+	now_ns = ktime_get_ns();
+	tgid_stats_add_task(tsk->signal->stats, tsk, now_ns);
 ret:
 	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
 	return;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index e62bbeb94faf..f45022df3f81 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1042,6 +1042,12 @@ struct ftrace_ops global_ops = {
 					  FTRACE_OPS_FL_PID,
 };
 
+/*
+ * parser_lock - Protects trace_parser state against concurrent operations.
+ * Held across trace_get_user() and subsequent buffer parsing to prevent races.
+ */
+static DEFINE_MUTEX(parser_lock);
+
 /*
  * Used by the stack undwinder to know about dynamic ftrace trampolines.
  */
@@ -4934,6 +4940,8 @@ ftrace_regex_write(struct file *file, const char __user *ubuf,
 	/* iter->hash is a local copy, so we don't need regex_lock */
 
 	parser = &iter->parser;
+
+	mutex_lock(&parser_lock);
 	read = trace_get_user(parser, ubuf, cnt, ppos);
 
 	if (read >= 0 && trace_parser_loaded(parser) &&
@@ -4947,6 +4955,7 @@ ftrace_regex_write(struct file *file, const char __user *ubuf,
 
 	ret = read;
  out:
+	mutex_unlock(&parser_lock);
 	return ret;
 }
 
@@ -5682,12 +5691,14 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 		iter = file->private_data;
 
 	parser = &iter->parser;
+	mutex_lock(&parser_lock);
 	if (trace_parser_loaded(parser)) {
 		int enable = !(iter->flags & FTRACE_ITER_NOTRACE);
 
 		ftrace_process_regex(iter, parser->buffer,
 				     parser->idx, enable);
 	}
+	mutex_unlock(&parser_lock);
 
 	trace_parser_put(parser);
 
@@ -6005,10 +6016,12 @@ ftrace_graph_release(struct inode *inode, struct file *file)
 
 		parser = &fgd->parser;
 
+		mutex_lock(&parser_lock);
 		if (trace_parser_loaded((parser))) {
 			ret = ftrace_graph_set_hash(fgd->new_hash,
 						    parser->buffer);
 		}
+		mutex_unlock(&parser_lock);
 
 		trace_parser_put(parser);
 
@@ -6127,6 +6140,7 @@ ftrace_graph_write(struct file *file, const char __user *ubuf,
 
 	parser = &fgd->parser;
 
+	mutex_lock(&parser_lock);
 	read = trace_get_user(parser, ubuf, cnt, ppos);
 
 	if (read >= 0 && trace_parser_loaded(parser) &&
@@ -6139,6 +6153,7 @@ ftrace_graph_write(struct file *file, const char __user *ubuf,
 
 	if (!ret)
 		ret = read;
+	mutex_unlock(&parser_lock);
 
 	return ret;
 }
@@ -6844,7 +6859,8 @@ static void add_to_clear_hash_list(struct list_head *clear_list,
 void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 {
 	unsigned long start = (unsigned long)(start_ptr);
-	unsigned long end = (unsigned long)(end_ptr);
+	/* end is inclusive and end_ptr is exclusive */
+	unsigned long end = (unsigned long)(end_ptr) - 1;
 	struct ftrace_page **last_pg = &ftrace_pages_start;
 	struct ftrace_page *tmp_page = NULL;
 	struct ftrace_page *pg;
@@ -6856,6 +6872,9 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 
 	INIT_LIST_HEAD(&clear_hash);
 
+	if (start_ptr >= end_ptr)
+		return;
+
 	key.ip = start;
 	key.flags = end;	/* overload flags, as it is unsigned long */
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 40b3332e0c12..1c1b4139c472 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5234,32 +5234,30 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 {
 	struct ring_buffer_per_cpu *cpu_buffer_a;
 	struct ring_buffer_per_cpu *cpu_buffer_b;
-	int ret = -EINVAL;
+	int ret = -EBUSY;
 
 	if (!cpumask_test_cpu(cpu, buffer_a->cpumask) ||
 	    !cpumask_test_cpu(cpu, buffer_b->cpumask))
-		goto out;
+		return -EINVAL;
 
 	cpu_buffer_a = buffer_a->buffers[cpu];
 	cpu_buffer_b = buffer_b->buffers[cpu];
 
 	/* At least make sure the two buffers are somewhat the same */
 	if (cpu_buffer_a->nr_pages != cpu_buffer_b->nr_pages)
-		goto out;
-
-	ret = -EAGAIN;
+		return -EINVAL;
 
 	if (atomic_read(&buffer_a->record_disabled))
-		goto out;
+		return -EAGAIN;
 
 	if (atomic_read(&buffer_b->record_disabled))
-		goto out;
+		return -EAGAIN;
 
 	if (atomic_read(&cpu_buffer_a->record_disabled))
-		goto out;
+		return -EAGAIN;
 
 	if (atomic_read(&cpu_buffer_b->record_disabled))
-		goto out;
+		return -EAGAIN;
 
 	/*
 	 * We can't do a synchronize_rcu here because this
@@ -5270,10 +5268,10 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 	atomic_inc(&cpu_buffer_a->record_disabled);
 	atomic_inc(&cpu_buffer_b->record_disabled);
 
-	ret = -EBUSY;
-	if (local_read(&cpu_buffer_a->committing))
+	/* Do not swap if either buffer is in the process of writing */
+	if (cpu_buffer_a->current_context)
 		goto out_dec;
-	if (local_read(&cpu_buffer_b->committing))
+	if (cpu_buffer_b->current_context)
 		goto out_dec;
 
 	/*
@@ -5296,7 +5294,6 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 out_dec:
 	atomic_dec(&cpu_buffer_a->record_disabled);
 	atomic_dec(&cpu_buffer_b->record_disabled);
-out:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_swap_cpu);
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index b4c0c34cee13..f6bede03c692 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -329,6 +329,71 @@ const char * __init xbc_node_find_next_key_value(struct xbc_node *root,
 		return "";	/* No value key */
 }
 
+static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
+
+#define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
+
+/**
+ * xbc_snprint_cmdline() - Render bootconfig keys under @root as a cmdline string
+ * @buf: Destination buffer (may be NULL when @size is 0 to query the length)
+ * @size: Size of @buf in bytes
+ * @root: Subtree root whose key=value pairs should be rendered
+ *
+ * Walk all key/value pairs under @root and emit them as a space-separated
+ * cmdline string into @buf. Values containing whitespace are quoted with
+ * double quotes. Returns the number of bytes that would be written if @buf
+ * were large enough (matching snprintf semantics), or a negative errno on
+ * failure.
+ */
+int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
+{
+	struct xbc_node *knode, *vnode;
+	const char *val, *q;
+	size_t len = 0;
+	int ret;
+
+	/*
+	 * Track the running written length rather than advancing @buf, so we
+	 * never form "buf + size" or "buf += ret" while @buf is NULL (the
+	 * size-probe call passes buf=NULL, size=0). NULL pointer arithmetic
+	 * is undefined behavior and trips host UBSan / FORTIFY_SOURCE when
+	 * this renderer runs at kernel build time. snprintf(NULL, 0, ...)
+	 * itself is well defined and returns the would-be length.
+	 */
+	xbc_node_for_each_key_value(root, knode, val) {
+		ret = xbc_node_compose_key_after(root, knode,
+					xbc_namebuf, XBC_KEYLEN_MAX);
+		if (ret < 0)
+			return ret;
+
+		vnode = xbc_node_get_child(knode);
+		if (!vnode) {
+			ret = snprintf(buf ? buf + len : NULL, rest(len, size),
+				       "%s ", xbc_namebuf);
+			if (ret < 0)
+				return ret;
+			len += ret;
+			continue;
+		}
+		xbc_array_for_each_value(vnode, val) {
+			/*
+			 * For prettier and more readable /proc/cmdline, only
+			 * quote the value when necessary, i.e. when it contains
+			 * whitespace.
+			 */
+			q = strpbrk(val, " \t\r\n") ? "\"" : "";
+			ret = snprintf(buf ? buf + len : NULL, rest(len, size),
+				       "%s=%s%s%s ", xbc_namebuf, q, val, q);
+			if (ret < 0)
+				return ret;
+			len += ret;
+		}
+	}
+
+	return len;
+}
+#undef rest
+
 /* XBC parse and tree build */
 
 static int __init xbc_init_node(struct xbc_node *node, char *data, u32 flag)
diff --git a/lib/compat_audit.c b/lib/compat_audit.c
index 77eabad69b4a..fb4e86dc664c 100644
--- a/lib/compat_audit.c
+++ b/lib/compat_audit.c
@@ -3,32 +3,32 @@
 #include <linux/types.h>
 #include <asm/unistd32.h>
 
-unsigned compat_dir_class[] = {
+unsigned int compat_dir_class[] = {
 #include <asm-generic/audit_dir_write.h>
 ~0U
 };
 
-unsigned compat_read_class[] = {
+unsigned int compat_read_class[] = {
 #include <asm-generic/audit_read.h>
 ~0U
 };
 
-unsigned compat_write_class[] = {
+unsigned int compat_write_class[] = {
 #include <asm-generic/audit_write.h>
 ~0U
 };
 
-unsigned compat_chattr_class[] = {
+unsigned int compat_chattr_class[] = {
 #include <asm-generic/audit_change_attr.h>
 ~0U
 };
 
-unsigned compat_signal_class[] = {
+unsigned int compat_signal_class[] = {
 #include <asm-generic/audit_signal.h>
 ~0U
 };
 
-int audit_classify_compat_syscall(int abi, unsigned syscall)
+int audit_classify_compat_syscall(int abi, unsigned int syscall)
 {
 	switch (syscall) {
 #ifdef __NR_open
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 553b0705dce8..7629952530e2 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -894,7 +894,7 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid)
 			alloc_percpu(struct per_cpu_nodestat);
 		arch_refresh_nodedata(nid, pgdat);
 	} else {
-		int cpu;
+		int cpu, i;
 		/*
 		 * Reset the nr_zones, order and highest_zoneidx before reuse.
 		 * Note that kswapd will init kswapd_highest_zoneidx properly
@@ -903,10 +903,17 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid)
 		pgdat->nr_zones = 0;
 		pgdat->kswapd_order = 0;
 		pgdat->kswapd_highest_zoneidx = 0;
-		for_each_online_cpu(cpu) {
-			struct per_cpu_nodestat *p;
+		/*
+		 * Hot-unplug can leave per-cpu vmstat deltas unfolded (folders skip
+		 * offline nodes) - reconcile this at online. Foreign access to counters
+		 * is safe: the node is not online yet and we hold the hotplug lock.
+		 */
+		for_each_possible_cpu(cpu) {
+			struct per_cpu_nodestat *p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
 
-			p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
+			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
+				if (p->vm_node_stat_diff[i])
+					node_page_state_add(p->vm_node_stat_diff[i], pgdat, i);
 			memset(p, 0, sizeof(*p));
 		}
 	}
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 3f5cbd6eb4e1..da5888d5397a 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -457,6 +457,14 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 		return -EINVAL;
 
 	mmap_assert_write_locked(walk.mm);
+	/*
+	 * x86, arm64 ptdump allow walks of efi mm's and x86 ptdump allows walks
+	 * of arbitrary mm's.
+	 *
+	 * However, they both must also hold the init_mm lock to account for
+	 * concurrent kernel page table freeing.
+	 */
+	mmap_assert_write_locked(&init_mm);
 
 	return walk_pgd_range(start, end, &walk);
 }
diff --git a/mm/ptdump.c b/mm/ptdump.c
index adbc141083c7..9e11894393d6 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -143,11 +143,18 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
 
 	get_online_mems();
 	mmap_write_lock(mm);
+	/* To stabilise kernel page tables we must hold the init_mm lock too. */
+	if (mm != &init_mm)
+		mmap_write_lock_nested(&init_mm, SINGLE_DEPTH_NESTING);
+
 	while (range->start != range->end) {
 		walk_page_range_novma(mm, range->start, range->end,
 				      &ptdump_ops, pgd, st);
 		range++;
 	}
+
+	if (mm != &init_mm)
+		mmap_write_unlock(&init_mm);
 	mmap_write_unlock(mm);
 	put_online_mems();
 
diff --git a/net/9p/client.c b/net/9p/client.c
index f49f5fd98ad8..1bcab7176e5f 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -771,6 +771,8 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 
 	if ((err == -ERESTARTSYS) && (c->status == Connected)
 				  && (type == P9_TFLUSH)) {
+		if (fatal_signal_pending(current))
+			goto recalc_sigpending;
 		sigpending = 1;
 		clear_thread_flag(TIF_SIGPENDING);
 		goto again;
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 225f5305cbcb..153cda4ed820 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -551,16 +551,18 @@ static int hidp_process_data(struct hidp_session *session, struct sk_buff *skb,
 static void hidp_recv_ctrl_frame(struct hidp_session *session,
 					struct sk_buff *skb)
 {
-	unsigned char hdr, type, param;
+	unsigned char type, param;
+	u8 *hdr;
 	int free_skb = 1;
 
 	BT_DBG("session %p skb %p len %d", session, skb, skb->len);
 
-	hdr = skb->data[0];
-	skb_pull(skb, 1);
+	hdr = skb_pull_data(skb, 1);
+	if (!hdr)
+		goto free;
 
-	type = hdr & HIDP_HEADER_TRANS_MASK;
-	param = hdr & HIDP_HEADER_PARAM_MASK;
+	type = *hdr & HIDP_HEADER_TRANS_MASK;
+	param = *hdr & HIDP_HEADER_PARAM_MASK;
 
 	switch (type) {
 	case HIDP_TRANS_HANDSHAKE:
@@ -581,6 +583,7 @@ static void hidp_recv_ctrl_frame(struct hidp_session *session,
 		break;
 	}
 
+free:
 	if (free_skb)
 		kfree_skb(skb);
 }
@@ -588,14 +591,15 @@ static void hidp_recv_ctrl_frame(struct hidp_session *session,
 static void hidp_recv_intr_frame(struct hidp_session *session,
 				struct sk_buff *skb)
 {
-	unsigned char hdr;
+	u8 *hdr;
 
 	BT_DBG("session %p skb %p len %d", session, skb, skb->len);
 
-	hdr = skb->data[0];
-	skb_pull(skb, 1);
+	hdr = skb_pull_data(skb, 1);
+	if (!hdr)
+		goto free;
 
-	if (hdr == (HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT)) {
+	if (*hdr == (HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT)) {
 		hidp_set_timer(session);
 
 		if (session->input)
@@ -607,9 +611,10 @@ static void hidp_recv_intr_frame(struct hidp_session *session,
 			BT_DBG("report len %d", skb->len);
 		}
 	} else {
-		BT_DBG("Unsupported protocol header 0x%02x", hdr);
+		BT_DBG("Unsupported protocol header 0x%02x", *hdr);
 	}
 
+free:
 	kfree_skb(skb);
 }
 
diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
index 17447c19d937..7f4ab0234427 100644
--- a/net/ceph/cls_lock_client.c
+++ b/net/ceph/cls_lock_client.c
@@ -253,7 +253,8 @@ static int decode_locker(void **p, void *end, struct ceph_locker *locker)
 	if (ret)
 		return ret;
 
-	ceph_decode_copy(p, &locker->id.name, sizeof(locker->id.name));
+	ceph_decode_copy_safe(p, end, &locker->id.name,
+			      sizeof(locker->id.name), bad);
 	s = ceph_extract_encoded_string(p, end, NULL, GFP_NOIO);
 	if (IS_ERR(s))
 		return PTR_ERR(s);
@@ -264,19 +265,23 @@ static int decode_locker(void **p, void *end, struct ceph_locker *locker)
 	if (ret)
 		return ret;
 
-	*p += sizeof(struct ceph_timespec); /* skip expiration */
+	/* skip expiration */
+	ceph_decode_skip_n(p, end, sizeof(struct ceph_timespec), bad);
 
 	ret = ceph_decode_entity_addr(p, end, &locker->info.addr);
 	if (ret)
 		return ret;
 
-	len = ceph_decode_32(p);
-	*p += len; /* skip description */
+	/* skip description */
+	ceph_decode_skip_string(p, end, bad);
 
 	dout("%s %s%llu cookie %s addr %s\n", __func__,
 	     ENTITY_NAME(locker->id.name), locker->id.cookie,
 	     ceph_pr_addr(&locker->info.addr));
 	return 0;
+
+bad:
+	return -EINVAL;
 }
 
 static int decode_lockers(void **p, void *end, u8 *type, char **tag,
@@ -293,7 +298,7 @@ static int decode_lockers(void **p, void *end, u8 *type, char **tag,
 	if (ret)
 		return ret;
 
-	*num_lockers = ceph_decode_32(p);
+	ceph_decode_32_safe(p, end, *num_lockers, err_inval);
 	*lockers = kcalloc(*num_lockers, sizeof(**lockers), GFP_NOIO);
 	if (!*lockers)
 		return -ENOMEM;
@@ -304,7 +309,8 @@ static int decode_lockers(void **p, void *end, u8 *type, char **tag,
 			goto err_free_lockers;
 	}
 
-	*type = ceph_decode_8(p);
+	ret = -EINVAL;
+	ceph_decode_8_safe(p, end, *type, err_free_lockers);
 	s = ceph_extract_encoded_string(p, end, NULL, GFP_NOIO);
 	if (IS_ERR(s)) {
 		ret = PTR_ERR(s);
@@ -314,6 +320,9 @@ static int decode_lockers(void **p, void *end, u8 *type, char **tag,
 	*tag = s;
 	return 0;
 
+err_inval:
+	return -EINVAL;
+
 err_free_lockers:
 	ceph_free_lockers(*lockers, *num_lockers);
 	return ret;
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index f7be6b68dfc8..031da5a2132e 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1424,7 +1424,7 @@ static struct ceph_pg_mapping *__decode_pg_temp(void **p, void *end,
 	ceph_decode_32_safe(p, end, len, e_inval);
 	if (len == 0 && incremental)
 		return NULL;	/* new_pg_temp: [] to remove */
-	if (len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
+	if (len > CEPH_PG_MAX_SIZE)
 		return ERR_PTR(-EINVAL);
 
 	ceph_decode_need(p, end, len * sizeof(u32), e_inval);
@@ -1607,7 +1607,7 @@ static struct ceph_pg_mapping *__decode_pg_upmap_items(void **p, void *end,
 	u32 len, i;
 
 	ceph_decode_32_safe(p, end, len, e_inval);
-	if (len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
+	if (len > CEPH_PG_MAX_SIZE)
 		return ERR_PTR(-EINVAL);
 
 	ceph_decode_need(p, end, 2 * len * sizeof(u32), e_inval);
@@ -2772,9 +2772,10 @@ static void get_temp_osds(struct ceph_osdmap *osdmap,
 		}
 	}
 
-	/* primary_temp? */
+	/* primary_temp? (shouldn't ever be a nonexistent or down OSD) */
 	pg = lookup_pg_mapping(&osdmap->primary_temp, pgid);
-	if (pg)
+	if (pg && !WARN_ON_ONCE(ceph_osd_is_down(osdmap,
+						 pg->primary_temp.osd)))
 		temp->primary = pg->primary_temp.osd;
 }
 
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 57502e862846..571b657ff266 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -275,7 +275,8 @@ struct pktgen_dev {
 	int pkt_overhead;	/* overhead for MPLS, VLANs, IPSEC etc */
 	int nfrags;
 	int removal_mark;	/* non-zero => the device is marked for
-				 * removal by worker thread */
+				 * removal by worker thread
+				 */
 
 	struct page *page;
 	u64 delay;		/* nano-seconds */
@@ -338,10 +339,12 @@ struct pktgen_dev {
 	__u16 udp_dst_max;	/* exclusive, dest UDP port */
 
 	/* DSCP + ECN */
-	__u8 tos;            /* six MSB of (former) IPv4 TOS
-				are for dscp codepoint */
-	__u8 traffic_class;  /* ditto for the (former) Traffic Class in IPv6
-				(see RFC 3260, sec. 4) */
+	__u8 tos;		/* six MSB of (former) IPv4 TOS
+				 * are for dscp codepoint
+				 */
+	__u8 traffic_class;	/* ditto for the (former) Traffic Class in IPv6
+				 * (see RFC 3260, sec. 4)
+				 */
 
 	/* MPLS */
 	unsigned int nr_labels;	/* Depth of stack, 0 = no MPLS */
@@ -375,12 +378,12 @@ struct pktgen_dev {
 
 	__u8 hh[14];
 	/* = {
-	   0x00, 0x80, 0xC8, 0x79, 0xB3, 0xCB,
-
-	   We fill in SRC address later
-	   0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	   0x08, 0x00
-	   };
+	 * 0x00, 0x80, 0xC8, 0x79, 0xB3, 0xCB,
+	 *
+	 * We fill in SRC address later
+	 * 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	 * 0x08, 0x00
+	 * };
 	 */
 	__u16 pad;		/* pad out the hh struct to an even 16 bytes */
 
@@ -443,7 +446,8 @@ struct pktgen_thread {
 	char result[512];
 
 	/* Field for thread to receive "posted" events terminate,
-	   stop ifs etc. */
+	 * stop ifs etc.
+	 */
 
 	u32 control;
 	int cpu;
@@ -2235,7 +2239,7 @@ static inline int f_pick(struct pktgen_dev *pkt_dev)
 #ifdef CONFIG_XFRM
 /* If there was already an IPSEC SA, we keep it as is, else
  * we go look for it ...
-*/
+ */
 #define DUMMY_MARK 0
 static void get_ipsec_sa(struct pktgen_dev *pkt_dev, int flow)
 {
@@ -2506,7 +2510,8 @@ static int pktgen_output_ipsec(struct sk_buff *skb, struct pktgen_dev *pkt_dev)
 	if (!x)
 		return 0;
 	/* XXX: we dont support tunnel mode for now until
-	 * we resolve the dst issue */
+	 * we resolve the dst issue
+	 */
 	if ((x->props.mode != XFRM_MODE_TRANSPORT) && (pkt_dev->spi == 0))
 		return 0;
 
@@ -3569,7 +3574,8 @@ static int add_dev_to_thread(struct pktgen_thread *t,
 	 * userspace on another CPU than the kthread.  The if_lock()
 	 * is used here to sync with concurrent instances of
 	 * _rem_dev_from_if_list() invoked via kthread, which is also
-	 * updating the if_list */
+	 * updating the if_list
+	 */
 	if_lock(t);
 
 	if (pkt_dev->pg_thread) {
@@ -3739,6 +3745,7 @@ static void _rem_dev_from_if_list(struct pktgen_thread *t,
 	struct pktgen_dev *p;
 
 	if_lock(t);
+	proc_remove(pkt_dev->entry);
 	list_for_each_safe(q, n, &t->if_list) {
 		p = list_entry(q, struct pktgen_dev, list);
 		if (p == pkt_dev)
@@ -3766,10 +3773,8 @@ static int pktgen_remove_device(struct pktgen_thread *t,
 
 	/* Remove proc before if_list entry, because add_device uses
 	 * list to determine if interface already exist, avoid race
-	 * with proc_create_data() */
-	proc_remove(pkt_dev->entry);
-
-	/* And update the thread if_list */
+	 * with proc_create_data()
+	 */
 	_rem_dev_from_if_list(t, pkt_dev);
 
 #ifdef CONFIG_XFRM
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 90a63c356aff..793b58979e5c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1976,6 +1976,30 @@ void *skb_pull(struct sk_buff *skb, unsigned int len)
 }
 EXPORT_SYMBOL(skb_pull);
 
+/**
+ *	skb_pull_data - remove data from the start of a buffer returning its
+ *	original position.
+ *	@skb: buffer to use
+ *	@len: amount of data to remove
+ *
+ *	This function removes data from the start of a buffer, returning
+ *	the memory to the headroom. A pointer to the original data in the buffer
+ *	is returned after checking if there is enough data to pull. Once the
+ *	data has been pulled future pushes will overwrite the old data.
+ */
+void *skb_pull_data(struct sk_buff *skb, size_t len)
+{
+	void *data = skb->data;
+
+	if (skb->len < len)
+		return NULL;
+
+	skb_pull(skb, len);
+
+	return data;
+}
+EXPORT_SYMBOL(skb_pull_data);
+
 /**
  *	skb_trim - remove end from a buffer
  *	@skb: buffer to alter
@@ -3830,7 +3854,9 @@ EXPORT_SYMBOL_GPL(skb_segment_list);
 
 int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 {
-	if (unlikely(p->len + skb->len >= 65536))
+	/* make sure to check flush flag and to not merge */
+	if (unlikely(p->len + skb->len >= 65536 ||
+		     NAPI_GRO_CB(skb)->flush))
 		return -E2BIG;
 
 	if (NAPI_GRO_CB(p)->last == p)
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 712555c56a18..b35153758fdf 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -1099,3 +1099,38 @@ EXPORT_SYMBOL(ip_tunnel_parse_protocol);
 
 const struct header_ops ip_tunnel_header_ops = { .parse_protocol = ip_tunnel_parse_protocol };
 EXPORT_SYMBOL(ip_tunnel_header_ops);
+
+/* This function returns true when ENCAP attributes are present in the nl msg */
+bool ip_tunnel_netlink_encap_parms(struct nlattr *data[],
+				   struct ip_tunnel_encap *encap)
+{
+	bool ret = false;
+
+	memset(encap, 0, sizeof(*encap));
+
+	if (!data)
+		return ret;
+
+	if (data[IFLA_IPTUN_ENCAP_TYPE]) {
+		ret = true;
+		encap->type = nla_get_u16(data[IFLA_IPTUN_ENCAP_TYPE]);
+	}
+
+	if (data[IFLA_IPTUN_ENCAP_FLAGS]) {
+		ret = true;
+		encap->flags = nla_get_u16(data[IFLA_IPTUN_ENCAP_FLAGS]);
+	}
+
+	if (data[IFLA_IPTUN_ENCAP_SPORT]) {
+		ret = true;
+		encap->sport = nla_get_be16(data[IFLA_IPTUN_ENCAP_SPORT]);
+	}
+
+	if (data[IFLA_IPTUN_ENCAP_DPORT]) {
+		ret = true;
+		encap->dport = nla_get_be16(data[IFLA_IPTUN_ENCAP_DPORT]);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ip_tunnel_netlink_encap_parms);
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index 75d35e76bec2..714de14f0d88 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -446,40 +446,6 @@ static void ipip_netlink_parms(struct nlattr *data[],
 		*fwmark = nla_get_u32(data[IFLA_IPTUN_FWMARK]);
 }
 
-/* This function returns true when ENCAP attributes are present in the nl msg */
-static bool ipip_netlink_encap_parms(struct nlattr *data[],
-				     struct ip_tunnel_encap *ipencap)
-{
-	bool ret = false;
-
-	memset(ipencap, 0, sizeof(*ipencap));
-
-	if (!data)
-		return ret;
-
-	if (data[IFLA_IPTUN_ENCAP_TYPE]) {
-		ret = true;
-		ipencap->type = nla_get_u16(data[IFLA_IPTUN_ENCAP_TYPE]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_FLAGS]) {
-		ret = true;
-		ipencap->flags = nla_get_u16(data[IFLA_IPTUN_ENCAP_FLAGS]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_SPORT]) {
-		ret = true;
-		ipencap->sport = nla_get_be16(data[IFLA_IPTUN_ENCAP_SPORT]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_DPORT]) {
-		ret = true;
-		ipencap->dport = nla_get_be16(data[IFLA_IPTUN_ENCAP_DPORT]);
-	}
-
-	return ret;
-}
-
 static int ipip_newlink(struct net *src_net, struct net_device *dev,
 			struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
@@ -489,7 +455,7 @@ static int ipip_newlink(struct net *src_net, struct net_device *dev,
 	struct ip_tunnel_encap ipencap;
 	__u32 fwmark = 0;
 
-	if (ipip_netlink_encap_parms(data, &ipencap)) {
+	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		int err = ip_tunnel_encap_setup(t, &ipencap);
 
 		if (err < 0)
@@ -510,7 +476,10 @@ static int ipip_changelink(struct net_device *dev, struct nlattr *tb[],
 	bool collect_md;
 	__u32 fwmark = t->fwmark;
 
-	if (ipip_netlink_encap_parms(data, &ipencap)) {
+	if (!rtnl_dev_link_net_capable(dev, t->net))
+		return -EPERM;
+
+	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		int err = ip_tunnel_encap_setup(t, &ipencap);
 
 		if (err < 0)
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 148a9bac4ed5..b4c09cf33af8 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2037,39 +2037,6 @@ static void ip6_tnl_netlink_parms(struct nlattr *data[],
 		parms->fwmark = nla_get_u32(data[IFLA_IPTUN_FWMARK]);
 }
 
-static bool ip6_tnl_netlink_encap_parms(struct nlattr *data[],
-					struct ip_tunnel_encap *ipencap)
-{
-	bool ret = false;
-
-	memset(ipencap, 0, sizeof(*ipencap));
-
-	if (!data)
-		return ret;
-
-	if (data[IFLA_IPTUN_ENCAP_TYPE]) {
-		ret = true;
-		ipencap->type = nla_get_u16(data[IFLA_IPTUN_ENCAP_TYPE]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_FLAGS]) {
-		ret = true;
-		ipencap->flags = nla_get_u16(data[IFLA_IPTUN_ENCAP_FLAGS]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_SPORT]) {
-		ret = true;
-		ipencap->sport = nla_get_be16(data[IFLA_IPTUN_ENCAP_SPORT]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_DPORT]) {
-		ret = true;
-		ipencap->dport = nla_get_be16(data[IFLA_IPTUN_ENCAP_DPORT]);
-	}
-
-	return ret;
-}
-
 static int ip6_tnl_newlink(struct net *src_net, struct net_device *dev,
 			   struct nlattr *tb[], struct nlattr *data[],
 			   struct netlink_ext_ack *extack)
@@ -2082,7 +2049,7 @@ static int ip6_tnl_newlink(struct net *src_net, struct net_device *dev,
 
 	nt = netdev_priv(dev);
 
-	if (ip6_tnl_netlink_encap_parms(data, &ipencap)) {
+	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		err = ip6_tnl_encap_setup(nt, &ipencap);
 		if (err < 0)
 			return err;
@@ -2116,10 +2083,13 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
 
+	if (!rtnl_dev_link_net_capable(dev, net))
+		return -EPERM;
+
 	if (dev == ip6n->fb_tnl_dev)
 		return -EINVAL;
 
-	if (ip6_tnl_netlink_encap_parms(data, &ipencap)) {
+	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		int err = ip6_tnl_encap_setup(t, &ipencap);
 
 		if (err < 0)
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 89581010a152..1027bd104941 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1536,40 +1536,6 @@ static void ipip6_netlink_parms(struct nlattr *data[],
 		*fwmark = nla_get_u32(data[IFLA_IPTUN_FWMARK]);
 }
 
-/* This function returns true when ENCAP attributes are present in the nl msg */
-static bool ipip6_netlink_encap_parms(struct nlattr *data[],
-				      struct ip_tunnel_encap *ipencap)
-{
-	bool ret = false;
-
-	memset(ipencap, 0, sizeof(*ipencap));
-
-	if (!data)
-		return ret;
-
-	if (data[IFLA_IPTUN_ENCAP_TYPE]) {
-		ret = true;
-		ipencap->type = nla_get_u16(data[IFLA_IPTUN_ENCAP_TYPE]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_FLAGS]) {
-		ret = true;
-		ipencap->flags = nla_get_u16(data[IFLA_IPTUN_ENCAP_FLAGS]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_SPORT]) {
-		ret = true;
-		ipencap->sport = nla_get_be16(data[IFLA_IPTUN_ENCAP_SPORT]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_DPORT]) {
-		ret = true;
-		ipencap->dport = nla_get_be16(data[IFLA_IPTUN_ENCAP_DPORT]);
-	}
-
-	return ret;
-}
-
 #ifdef CONFIG_IPV6_SIT_6RD
 /* This function returns true when 6RD attributes are present in the nl msg */
 static bool ipip6_netlink_6rd_parms(struct nlattr *data[],
@@ -1621,7 +1587,7 @@ static int ipip6_newlink(struct net *src_net, struct net_device *dev,
 
 	nt = netdev_priv(dev);
 
-	if (ipip6_netlink_encap_parms(data, &ipencap)) {
+	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		err = ip_tunnel_encap_setup(nt, &ipencap);
 		if (err < 0)
 			return err;
@@ -1676,7 +1642,7 @@ static int ipip6_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (dev == sitn->fb_tunnel_dev)
 		return -EINVAL;
 
-	if (ipip6_netlink_encap_parms(data, &ipencap)) {
+	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		err = ip_tunnel_encap_setup(t, &ipencap);
 		if (err < 0)
 			return err;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8bc8812f7526..e77d9f3fde3f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -142,17 +142,11 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		 */
 		mp_opt->mpc_map = 0;
 		flags = (*ptr++) & MPTCP_DSS_FLAG_MASK;
-		mp_opt->data_fin = (flags & MPTCP_DSS_DATA_FIN) != 0;
 		mp_opt->dsn64 = (flags & MPTCP_DSS_DSN64) != 0;
 		mp_opt->use_map = (flags & MPTCP_DSS_HAS_MAP) != 0;
 		mp_opt->ack64 = (flags & MPTCP_DSS_ACK64) != 0;
 		mp_opt->use_ack = (flags & MPTCP_DSS_HAS_ACK);
 
-		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d\n",
-			 mp_opt->data_fin, mp_opt->dsn64,
-			 mp_opt->use_map, mp_opt->ack64,
-			 mp_opt->use_ack);
-
 		expected_opsize = TCPOLEN_MPTCP_DSS_BASE;
 
 		if (mp_opt->use_ack) {
@@ -163,20 +157,32 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		}
 
 		if (mp_opt->use_map) {
+			mp_opt->data_fin = (flags & MPTCP_DSS_DATA_FIN) != 0;
 			if (mp_opt->dsn64)
 				expected_opsize += TCPOLEN_MPTCP_DSS_MAP64;
 			else
 				expected_opsize += TCPOLEN_MPTCP_DSS_MAP32;
 		}
 
+		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d\n",
+			 mp_opt->data_fin, mp_opt->dsn64,
+			 mp_opt->use_map, mp_opt->ack64,
+			 mp_opt->use_ack);
+
 		/* RFC 6824, Section 3.3:
 		 * If a checksum is present, but its use had
 		 * not been negotiated in the MP_CAPABLE handshake,
 		 * the checksum field MUST be ignored.
 		 */
 		if (opsize != expected_opsize &&
-		    opsize != expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM)
+		    opsize != expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM) {
+			mp_opt->dsn64 = 0;
+			mp_opt->use_map = 0;
+			mp_opt->ack64 = 0;
+			mp_opt->use_ack = 0;
+			mp_opt->data_fin = 0;
 			break;
+		}
 
 		mp_opt->dss = 1;
 
@@ -300,6 +306,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 	mp_opt->port = 0;
 	mp_opt->rm_addr = 0;
 	mp_opt->dss = 0;
+	mp_opt->data_fin = 0;
 
 	length = (th->doff * 4) - sizeof(struct tcphdr);
 	ptr = (const unsigned char *)(th + 1);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a9595eb2b5fe..2c6aef813473 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2663,8 +2663,10 @@ bool mptcp_finish_join(struct sock *sk)
 	if (ret && !WARN_ON_ONCE(!list_empty(&subflow->node)))
 		list_add_tail(&subflow->node, &msk->join_list);
 	spin_unlock_bh(&msk->join_list_lock);
-	if (!ret)
+	if (!ret) {
+		mptcp_pm_close_subflow(msk);
 		return false;
+	}
 
 	/* attach to msk socket only after we are sure he will deal with us
 	 * at close time
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 313c8898b3b2..ac064c44079d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -498,6 +498,20 @@ void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 
+/* called under PM lock */
+static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
+{
+	if (--msk->pm.subflows < msk->pm.subflows_max)
+		WRITE_ONCE(msk->pm.accept_subflow, true);
+}
+
+static inline void mptcp_pm_close_subflow(struct mptcp_sock *msk)
+{
+	spin_lock_bh(&msk->pm.lock);
+	__mptcp_pm_close_subflow(msk);
+	spin_unlock_bh(&msk->pm.lock);
+}
+
 static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
 {
 	return (struct mptcp_ext *)skb_ext_find(skb, SKB_EXT_MPTCP);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9a8d0d877bd1..b13cd310882d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1122,18 +1122,18 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	struct sockaddr_storage addr;
 	int remote_id = remote->id;
 	int local_id = loc->id;
+	int err = -ENOTCONN;
 	struct socket *sf;
 	struct sock *ssk;
 	u32 remote_token;
 	int addrlen;
-	int err;
 
 	if (!mptcp_is_fully_established(sk))
-		return -ENOTCONN;
+		goto err_out;
 
 	err = mptcp_subflow_create_socket(sk, &sf);
 	if (err)
-		return err;
+		goto err_out;
 
 	ssk = sf->sk;
 	subflow = mptcp_subflow_ctx(ssk);
@@ -1187,6 +1187,12 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 
 failed:
 	sock_release(sf);
+
+err_out:
+	/* we account subflows before the creation, and this failures will not
+	 * be caught by sk_state_change()
+	 */
+	mptcp_pm_close_subflow(msk);
 	return err;
 }
 
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 11e5536d8b26..dcf23460b6df 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -679,11 +679,18 @@ __ip_set_get(struct ip_set *set)
 }
 
 static void
-__ip_set_put(struct ip_set *set)
+__ip_set_put_locked(struct ip_set *set)
 {
-	write_lock_bh(&ip_set_ref_lock);
+	lockdep_assert_held(&ip_set_ref_lock);
 	BUG_ON(set->ref == 0);
 	set->ref--;
+}
+
+static void
+__ip_set_put(struct ip_set *set)
+{
+	write_lock_bh(&ip_set_ref_lock);
+	__ip_set_put_locked(set);
 	write_unlock_bh(&ip_set_ref_lock);
 }
 
@@ -856,11 +863,11 @@ __ip_set_put_byindex(struct ip_set_net *inst, ip_set_id_t index)
 {
 	struct ip_set *set;
 
-	rcu_read_lock();
-	set = rcu_dereference(inst->ip_set_list)[index];
+	write_lock_bh(&ip_set_ref_lock);
+	set = ip_set(inst, index);
 	if (set)
-		__ip_set_put(set);
-	rcu_read_unlock();
+		__ip_set_put_locked(set);
+	write_unlock_bh(&ip_set_ref_lock);
 }
 
 void
diff --git a/net/netfilter/ipset/ip_set_list_set.c b/net/netfilter/ipset/ip_set_list_set.c
index 7d1ba6ad514f..25cfa8693f1a 100644
--- a/net/netfilter/ipset/ip_set_list_set.c
+++ b/net/netfilter/ipset/ip_set_list_set.c
@@ -301,9 +301,12 @@ list_set_uadd(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 	e->set = set;
 	INIT_LIST_HEAD(&e->list);
 	list_set_init_extensions(set, ext, e);
-	if (n)
+	if (n) {
 		list_set_replace(set, e, n);
-	else if (next)
+		return 0;
+	}
+
+	if (next)
 		list_add_tail_rcu(&e->list, &next->list);
 	else if (prev)
 		list_add_rcu(&e->list, &prev->list);
diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
index f4506bc166ce..90efb3c3760c 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -759,7 +759,7 @@ int ip_vs_check_template(struct ip_vs_conn *ct, struct ip_vs_dest *cdest)
 	 * Checking the dest server status.
 	 */
 	if ((dest == NULL) ||
-	    !(dest->flags & IP_VS_DEST_F_AVAILABLE) ||
+	    !(dest->cflags & IP_VS_DEST_CF_AVAILABLE) ||
 	    expire_quiescent_template(ipvs, dest) ||
 	    (cdest && (dest != cdest))) {
 		IP_VS_DBG_BUF(9, "check_template: dest not available for "
@@ -1402,7 +1402,7 @@ void ip_vs_expire_nodest_conn_flush(struct netns_ipvs *ipvs)
 				continue;
 
 			dest = cp->dest;
-			if (!dest || (dest->flags & IP_VS_DEST_F_AVAILABLE))
+			if (!dest || (dest->cflags & IP_VS_DEST_CF_AVAILABLE))
 				continue;
 
 			if (atomic_read(&cp->n_control))
diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index ea9b5f434ec0..c3d2e70bb007 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -136,7 +136,7 @@ ip_vs_in_stats(struct ip_vs_conn *cp, struct sk_buff *skb)
 	struct ip_vs_dest *dest = cp->dest;
 	struct netns_ipvs *ipvs = cp->ipvs;
 
-	if (dest && (dest->flags & IP_VS_DEST_F_AVAILABLE)) {
+	if (dest && (dest->cflags & IP_VS_DEST_CF_AVAILABLE)) {
 		struct ip_vs_cpu_stats *s;
 		struct ip_vs_service *svc;
 
@@ -172,7 +172,7 @@ ip_vs_out_stats(struct ip_vs_conn *cp, struct sk_buff *skb)
 	struct ip_vs_dest *dest = cp->dest;
 	struct netns_ipvs *ipvs = cp->ipvs;
 
-	if (dest && (dest->flags & IP_VS_DEST_F_AVAILABLE)) {
+	if (dest && (dest->cflags & IP_VS_DEST_CF_AVAILABLE)) {
 		struct ip_vs_cpu_stats *s;
 		struct ip_vs_service *svc;
 
@@ -2096,7 +2096,7 @@ ip_vs_in(struct netns_ipvs *ipvs, unsigned int hooknum, struct sk_buff *skb, int
 	}
 
 	/* Check the server status */
-	if (cp && cp->dest && !(cp->dest->flags & IP_VS_DEST_F_AVAILABLE)) {
+	if (cp && cp->dest && !(cp->dest->cflags & IP_VS_DEST_CF_AVAILABLE)) {
 		/* the destination server is not available */
 		if (sysctl_expire_nodest_conn(ipvs)) {
 			bool old_ct = ip_vs_conn_uses_old_conntrack(cp, skb);
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 025512d76db0..2ded17b67819 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -961,7 +961,7 @@ __ip_vs_update_dest(struct ip_vs_service *svc, struct ip_vs_dest *dest,
 	}
 
 	/* set the dest status flags */
-	dest->flags |= IP_VS_DEST_F_AVAILABLE;
+	dest->cflags |= IP_VS_DEST_CF_AVAILABLE;
 
 	if (READ_ONCE(dest->u_threshold) != udest->u_threshold ||
 	    READ_ONCE(dest->l_threshold) != udest->l_threshold) {
@@ -1240,7 +1240,7 @@ static void __ip_vs_unlink_dest(struct ip_vs_service *svc,
 				struct ip_vs_dest *dest,
 				int svcupd)
 {
-	dest->flags &= ~IP_VS_DEST_F_AVAILABLE;
+	dest->cflags &= ~IP_VS_DEST_CF_AVAILABLE;
 
 	/*
 	 *  Remove it from the d-linked destination list.
diff --git a/net/netfilter/ipvs/ip_vs_dh.c b/net/netfilter/ipvs/ip_vs_dh.c
index 5e6ec32aff2b..6d88bb4bf4ae 100644
--- a/net/netfilter/ipvs/ip_vs_dh.c
+++ b/net/netfilter/ipvs/ip_vs_dh.c
@@ -220,8 +220,8 @@ ip_vs_dh_schedule(struct ip_vs_service *svc, const struct sk_buff *skb,
 
 	s = (struct ip_vs_dh_state *) svc->sched_data;
 	dest = ip_vs_dh_get(svc->af, s, &iph->daddr);
-	if (!dest
-	    || !(dest->flags & IP_VS_DEST_F_AVAILABLE)
+	if (!dest ||
+	    !(dest->cflags & IP_VS_DEST_CF_AVAILABLE)
 	    || atomic_read(&dest->weight) <= 0
 	    || is_overloaded(dest)) {
 		ip_vs_scheduler_err(svc, "no destination available");
diff --git a/net/netfilter/ipvs/ip_vs_lblc.c b/net/netfilter/ipvs/ip_vs_lblc.c
index 7ac7473e3804..e2480f33a196 100644
--- a/net/netfilter/ipvs/ip_vs_lblc.c
+++ b/net/netfilter/ipvs/ip_vs_lblc.c
@@ -503,7 +503,7 @@ ip_vs_lblc_schedule(struct ip_vs_service *svc, const struct sk_buff *skb,
 		 */
 
 		dest = en->dest;
-		if ((dest->flags & IP_VS_DEST_F_AVAILABLE) &&
+		if ((dest->cflags & IP_VS_DEST_CF_AVAILABLE) &&
 		    atomic_read(&dest->weight) > 0 && !is_overloaded(dest, svc))
 			goto out;
 	}
diff --git a/net/netfilter/ipvs/ip_vs_lblcr.c b/net/netfilter/ipvs/ip_vs_lblcr.c
index 77c323c36a88..7469547c8a44 100644
--- a/net/netfilter/ipvs/ip_vs_lblcr.c
+++ b/net/netfilter/ipvs/ip_vs_lblcr.c
@@ -170,8 +170,8 @@ static inline struct ip_vs_dest *ip_vs_dest_set_min(struct ip_vs_dest_set *set)
 		if (least->flags & IP_VS_DEST_F_OVERLOAD)
 			continue;
 
-		if ((atomic_read(&least->weight) > 0)
-		    && (least->flags & IP_VS_DEST_F_AVAILABLE)) {
+		if ((atomic_read(&least->weight) > 0) &&
+		    (least->cflags & IP_VS_DEST_CF_AVAILABLE)) {
 			loh = ip_vs_dest_conn_overhead(least);
 			goto nextstage;
 		}
@@ -187,8 +187,8 @@ static inline struct ip_vs_dest *ip_vs_dest_set_min(struct ip_vs_dest_set *set)
 
 		doh = ip_vs_dest_conn_overhead(dest);
 		if (((__s64)loh * atomic_read(&dest->weight) >
-		     (__s64)doh * atomic_read(&least->weight))
-		    && (dest->flags & IP_VS_DEST_F_AVAILABLE)) {
+		     (__s64)doh * atomic_read(&least->weight)) &&
+		    (dest->cflags & IP_VS_DEST_CF_AVAILABLE)) {
 			least = dest;
 			loh = doh;
 		}
diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index 0f6147ea9e67..7a9c07fff57a 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -947,10 +947,8 @@ static int set_expected_rtp_rtcp(struct sk_buff *skb, unsigned int protoff,
 			return NF_ACCEPT;
 		saddr = &ct->tuplehash[!dir].tuple.src.u3;
 	} else if (sip_external_media) {
-		struct net_device *dev = skb_dst(skb)->dev;
-		struct net *net = dev_net(dev);
-		struct flowi fl;
 		struct dst_entry *dst = NULL;
+		struct flowi fl;
 
 		memset(&fl, 0, sizeof(fl));
 
@@ -970,7 +968,11 @@ static int set_expected_rtp_rtcp(struct sk_buff *skb, unsigned int protoff,
 		 * through the same interface as the signalling peer.
 		 */
 		if (dst) {
-			bool external_media = (dst->dev == dev);
+			const struct dst_entry *this_dst = skb_dst(skb);
+			bool external_media = false;
+
+			if (this_dst && dst->dev == this_dst->dev)
+				external_media = true;
 
 			dst_release(dst);
 			if (external_media)
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index e05e09c07b97..8f6b791918ae 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -228,17 +228,18 @@ int flow_offload_add(struct nf_flowtable *flow_table, struct flow_offload *flow)
 	flow->timeout = nf_flowtable_time_stamp + NF_FLOW_TIMEOUT;
 
 	err = rhashtable_insert_fast(&flow_table->rhashtable,
-				     &flow->tuplehash[0].node,
+				     &flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].node,
 				     nf_flow_offload_rhash_params);
 	if (err < 0)
 		return err;
 
+	/* GC only iterates original-direction entries; publish original last. */
 	err = rhashtable_insert_fast(&flow_table->rhashtable,
-				     &flow->tuplehash[1].node,
+				     &flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].node,
 				     nf_flow_offload_rhash_params);
 	if (err < 0) {
 		rhashtable_remove_fast(&flow_table->rhashtable,
-				       &flow->tuplehash[0].node,
+				       &flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].node,
 				       nf_flow_offload_rhash_params);
 		return err;
 	}
diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index 5cfbb29d8a34..f975df48ea62 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -522,7 +522,7 @@ static void nft_flow_rule_offload_abort(struct net *net,
 			break;
 		}
 
-		if (WARN_ON_ONCE(err))
+		if (WARN_ON_ONCE(err && err != -ENOMEM))
 			break;
 	}
 }
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index f73e2c3b813d..b040b20b5e92 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1945,13 +1945,13 @@ static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
 	    sock->type == SOCK_RAW)
 		skb->protocol = dev_parse_header_protocol(skb);
 
+	skb_probe_transport_header(skb);
+
 	/* Move network header to the right position for VLAN tagged packets */
 	if (likely(skb->dev->type == ARPHRD_ETHER) &&
 	    eth_type_vlan(skb->protocol) &&
 	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
 		skb_set_network_header(skb, depth);
-
-	skb_probe_transport_header(skb);
 }
 
 /*
@@ -2649,6 +2649,9 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 		len = ((to_write > len_max) ? len_max : to_write);
 	}
 
+	if (unlikely(!skb->len))
+		return -EINVAL;
+
 	packet_parse_headers(skb, sock);
 
 	return tp_len;
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index b96af42a1b04..d6fbaac0b6c6 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -220,6 +220,7 @@ void rxrpc_discard_prealloc(struct rxrpc_sock *rx)
 	tail = b->call_backlog_tail;
 	while (CIRC_CNT(head, tail, size) > 0) {
 		struct rxrpc_call *call = b->call_backlog[tail];
+		rxrpc_see_call(call);
 		rcu_assign_pointer(call->socket, rx);
 		if (rx->discard_new_call) {
 			_debug("discard %lx", call->user_call_ID);
@@ -481,14 +482,27 @@ int rxrpc_kernel_charge_accept(struct socket *sock,
 			       unsigned long user_call_ID, gfp_t gfp,
 			       unsigned int debug_id)
 {
-	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
-	struct rxrpc_backlog *b = rx->backlog;
+	struct rxrpc_backlog *b;
+	struct rxrpc_sock *rx;
+	struct sock *sk;
+	int ret;
+
+	sk = sock->sk;
+	rx = rxrpc_sk(sk);
+
+	lock_sock(sk);
+	if (sk->sk_state != RXRPC_SERVER_LISTENING || !rx->backlog) {
+		ret = -ESHUTDOWN;
+		goto out;
+	}
 
-	if (sock->sk->sk_state == RXRPC_CLOSE)
-		return -ESHUTDOWN;
+	b = rx->backlog;
+	ret = rxrpc_service_prealloc_one(rx, b, notify_rx,
+					 user_attach_call, user_call_ID,
+					 gfp, debug_id);
 
-	return rxrpc_service_prealloc_one(rx, b, notify_rx,
-					  user_attach_call, user_call_ID,
-					  gfp, debug_id);
+out:
+	release_sock(sk);
+	return ret;
 }
 EXPORT_SYMBOL(rxrpc_kernel_charge_accept);
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 2240e93b0048..9a0fbce9ee83 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -529,7 +529,6 @@ void rxrpc_release_call(struct rxrpc_sock *rx, struct rxrpc_call *call)
 {
 	const void *here = __builtin_return_address(0);
 	struct rxrpc_connection *conn = call->conn;
-	bool put = false;
 
 	_enter("{%d,%d}", call->debug_id, refcount_read(&call->ref));
 
@@ -547,23 +546,13 @@ void rxrpc_release_call(struct rxrpc_sock *rx, struct rxrpc_call *call)
 	rxrpc_put_call_slot(call);
 	rxrpc_delete_call_timer(call);
 
-	/* Make sure we don't get any more notifications */
+	/* Note that at this point, the call may still be on or may have been
+	 * added back on to the socket receive queue.  recvmsg() must discard
+	 * released calls.  The CALL_RELEASED flag should prevent further
+	 * notifications.
+	 */
 	write_lock_bh(&rx->recvmsg_lock);
-
-	if (!list_empty(&call->recvmsg_link)) {
-		_debug("unlinking once-pending call %p { e=%lx f=%lx }",
-		       call, call->events, call->flags);
-		list_del(&call->recvmsg_link);
-		put = true;
-	}
-
-	/* list_empty() must return false in rxrpc_notify_socket() */
-	call->recvmsg_link.next = NULL;
-	call->recvmsg_link.prev = NULL;
-
 	write_unlock_bh(&rx->recvmsg_lock);
-	if (put)
-		rxrpc_put_call(call, rxrpc_call_put);
 
 	write_lock(&rx->call_lock);
 
@@ -612,6 +601,12 @@ void rxrpc_release_calls_on_socket(struct rxrpc_sock *rx)
 		rxrpc_put_call(call, rxrpc_call_put);
 	}
 
+	while ((call = list_first_entry_or_null(&rx->recvmsg_q,
+						struct rxrpc_call, recvmsg_link))) {
+		list_del_init(&call->recvmsg_link);
+		rxrpc_put_call(call, rxrpc_call_put);
+	}
+
 	_leave("");
 }
 
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 301b8acf78f5..4fb39d765717 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -27,8 +27,10 @@ void rxrpc_notify_socket(struct rxrpc_call *call)
 
 	_enter("%d", call->debug_id);
 
-	if (!list_empty(&call->recvmsg_link))
+	if (test_bit(RXRPC_CALL_RELEASED, &call->flags)) {
+		rxrpc_see_call(call);
 		return;
+	}
 
 	rcu_read_lock();
 
@@ -546,6 +548,16 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	write_lock_bh(&rx->recvmsg_lock);
 	l = rx->recvmsg_q.next;
 	call = list_entry(l, struct rxrpc_call, recvmsg_link);
+
+	rxrpc_see_call(call);
+	if (test_bit(RXRPC_CALL_RELEASED, &call->flags)) {
+		list_del_init(&call->recvmsg_link);
+		write_unlock_bh(&rx->recvmsg_lock);
+		release_sock(&rx->sk);
+		trace_rxrpc_recvmsg(call, rxrpc_recvmsg_unqueue, 0, 0, 0, 0);
+		rxrpc_put_call(call, rxrpc_call_put);
+		goto try_again;
+	}
 	if (!(flags & MSG_PEEK))
 		list_del_init(&call->recvmsg_link);
 	else
@@ -568,8 +580,13 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	release_sock(&rx->sk);
 
-	if (test_bit(RXRPC_CALL_RELEASED, &call->flags))
-		BUG();
+	if (test_bit(RXRPC_CALL_RELEASED, &call->flags)) {
+		rxrpc_see_call(call);
+		mutex_unlock(&call->user_mutex);
+		if (!(flags & MSG_PEEK))
+			rxrpc_put_call(call, rxrpc_call_put);
+		goto try_again;
+	}
 
 	if (test_bit(RXRPC_CALL_HAS_USERID, &call->flags)) {
 		if (flags & MSG_CMSG_COMPAT) {
diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
index 73c3926358a0..f8a62a5c8cdd 100644
--- a/net/sched/act_gact.c
+++ b/net/sched/act_gact.c
@@ -89,6 +89,11 @@ static int tcf_gact_init(struct net *net, struct nlattr *nla,
 		p_parm = nla_data(tb[TCA_GACT_PROB]);
 		if (p_parm->ptype >= MAX_RAND)
 			return -EINVAL;
+		if (!tcf_action_valid(p_parm->paction)) {
+			NL_SET_ERR_MSG(extack,
+				       "invalid fallback control action");
+			return -EINVAL;
+		}
 		if (TC_ACT_EXT_CMP(p_parm->paction, TC_ACT_GOTO_CHAIN)) {
 			NL_SET_ERR_MSG(extack,
 				       "goto chain not allowed on fallback");
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index c30cd3ecb391..35868e2a406b 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -134,6 +134,12 @@ static int tcf_police_init(struct net *net, struct nlattr *nla,
 
 	if (tb[TCA_POLICE_RESULT]) {
 		tcfp_result = nla_get_u32(tb[TCA_POLICE_RESULT]);
+		if (!tcf_action_valid(tcfp_result)) {
+			NL_SET_ERR_MSG(extack,
+				       "invalid fallback control action");
+			err = -EINVAL;
+			goto failure;
+		}
 		if (TC_ACT_EXT_CMP(tcfp_result, TC_ACT_GOTO_CHAIN)) {
 			NL_SET_ERR_MSG(extack,
 				       "goto chain not allowed on fallback");
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 932c98b5b347..34229be42c47 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -410,12 +410,13 @@ static __u8 __detect_linklayer(struct tc_ratespec *r, __u32 *rtab)
 }
 
 static struct qdisc_rate_table *qdisc_rtab_list;
+static DEFINE_SPINLOCK(qdisc_rtab_lock);
 
 struct qdisc_rate_table *qdisc_get_rtab(struct tc_ratespec *r,
 					struct nlattr *tab,
 					struct netlink_ext_ack *extack)
 {
-	struct qdisc_rate_table *rtab;
+	struct qdisc_rate_table *rtab, *new_rtab;
 
 	if (tab == NULL || r->rate == 0 ||
 	    r->cell_log == 0 || r->cell_log >= 32 ||
@@ -424,15 +425,20 @@ struct qdisc_rate_table *qdisc_get_rtab(struct tc_ratespec *r,
 		return NULL;
 	}
 
+	new_rtab = kmalloc(sizeof(*new_rtab), GFP_KERNEL);
+
+	spin_lock(&qdisc_rtab_lock);
 	for (rtab = qdisc_rtab_list; rtab; rtab = rtab->next) {
 		if (!memcmp(&rtab->rate, r, sizeof(struct tc_ratespec)) &&
 		    !memcmp(&rtab->data, nla_data(tab), 1024)) {
 			rtab->refcnt++;
+			spin_unlock(&qdisc_rtab_lock);
+			kfree(new_rtab);
 			return rtab;
 		}
 	}
 
-	rtab = kmalloc(sizeof(*rtab), GFP_KERNEL);
+	rtab = new_rtab;
 	if (rtab) {
 		rtab->rate = *r;
 		rtab->refcnt = 1;
@@ -444,6 +450,7 @@ struct qdisc_rate_table *qdisc_get_rtab(struct tc_ratespec *r,
 	} else {
 		NL_SET_ERR_MSG(extack, "Failed to allocate new qdisc rate table");
 	}
+	spin_unlock(&qdisc_rtab_lock);
 	return rtab;
 }
 EXPORT_SYMBOL(qdisc_get_rtab);
@@ -452,18 +459,25 @@ void qdisc_put_rtab(struct qdisc_rate_table *tab)
 {
 	struct qdisc_rate_table *rtab, **rtabp;
 
-	if (!tab || --tab->refcnt)
+	if (!tab)
 		return;
 
+	spin_lock(&qdisc_rtab_lock);
+	if (--tab->refcnt) {
+		spin_unlock(&qdisc_rtab_lock);
+		return;
+	}
+
 	for (rtabp = &qdisc_rtab_list;
 	     (rtab = *rtabp) != NULL;
 	     rtabp = &rtab->next) {
 		if (rtab == tab) {
 			*rtabp = rtab->next;
-			kfree(rtab);
-			return;
+			break;
 		}
 	}
+	spin_unlock(&qdisc_rtab_lock);
+	kfree(tab);
 }
 EXPORT_SYMBOL(qdisc_put_rtab);
 
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 50f430280337..d0b25ab5ff9a 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -559,12 +559,8 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
 	if (unlikely(!child))
 		return NULL;
 
-	if (TXTIME_ASSIST_IS_ENABLED(q->flags)) {
-		skb = child->ops->dequeue(child);
-		if (!skb)
-			return NULL;
-		goto skb_found;
-	}
+	if (TXTIME_ASSIST_IS_ENABLED(q->flags))
+		goto skip_peek_checks;
 
 	skb = child->ops->peek(child);
 	if (!skb)
@@ -591,11 +587,11 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
 	    atomic_sub_return(len, &entry->budget) < 0)
 		return NULL;
 
-	skb = child->ops->dequeue(child);
+skip_peek_checks:
+	skb = qdisc_dequeue_peeked(child);
 	if (unlikely(!skb))
 		return NULL;
 
-skb_found:
 	qdisc_bstats_update(sch, skb);
 	qdisc_qstats_backlog_dec(sch, skb);
 	sch->q.qlen--;
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 6e4ca837e91d..6e3d0872491a 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1286,10 +1286,6 @@ static int __net_init sctp_defaults_init(struct net *net)
 	/* Initialize maximum autoclose timeout. */
 	net->sctp.max_autoclose		= INT_MAX / HZ;
 
-	status = sctp_sysctl_net_register(net);
-	if (status)
-		goto err_sysctl_register;
-
 	/* Allocate and initialise sctp mibs.  */
 	status = init_sctp_mibs(net);
 	if (status)
@@ -1323,8 +1319,6 @@ static int __net_init sctp_defaults_init(struct net *net)
 	cleanup_sctp_mibs(net);
 #endif
 err_init_mibs:
-	sctp_sysctl_net_unregister(net);
-err_sysctl_register:
 	return status;
 }
 
@@ -1339,7 +1333,6 @@ static void __net_exit sctp_defaults_exit(struct net *net)
 	net->sctp.proc_net_sctp = NULL;
 #endif
 	cleanup_sctp_mibs(net);
-	sctp_sysctl_net_unregister(net);
 }
 
 static struct pernet_operations sctp_defaults_ops = {
@@ -1353,16 +1346,27 @@ static int __net_init sctp_ctrlsock_init(struct net *net)
 
 	/* Initialize the control inode/socket for handling OOTB packets.  */
 	status = sctp_ctl_sock_init(net);
-	if (status)
+	if (status) {
 		pr_err("Failed to initialize the SCTP control sock\n");
+		return status;
+	}
+
+	status = sctp_sysctl_net_register(net);
+	if (status) {
+		inet_ctl_sock_destroy(net->sctp.ctl_sock);
+		net->sctp.ctl_sock = NULL;
+	}
 
 	return status;
 }
 
 static void __net_exit sctp_ctrlsock_exit(struct net *net)
 {
+	sctp_sysctl_net_unregister(net);
+
 	/* Free the control endpoint.  */
 	inet_ctl_sock_destroy(net->sctp.ctl_sock);
+	net->sctp.ctl_sock = NULL;
 }
 
 static struct pernet_operations sctp_ctrlsock_ops = {
diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 82b736843c9d..6f3afa763d6e 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -515,11 +515,16 @@ int sctp_sysctl_net_register(struct net *net)
 
 void sctp_sysctl_net_unregister(struct net *net)
 {
+	struct ctl_table_header *header = net->sctp.sysctl_header;
 	struct ctl_table *table;
 
-	table = net->sctp.sysctl_header->ctl_table_arg;
-	unregister_net_sysctl_table(net->sctp.sysctl_header);
+	if (!header)
+		return;
+
+	table = header->ctl_table_arg;
+	unregister_net_sysctl_table(header);
 	kfree(table);
+	net->sctp.sysctl_header = NULL;
 }
 
 static struct ctl_table_header *sctp_sysctl_header;
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 8e1e38bc0df4..e9dabe758a31 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -863,7 +863,8 @@ smc_v2_determine_accepted_chid(struct smc_clc_msg_accept_confirm_v2 *aclc,
 	int i;
 
 	for (i = 0; i < ini->ism_offered_cnt + 1; i++) {
-		if (ini->ism_chid[i] == ntohs(aclc->chid)) {
+		if (ini->ism_dev[i] &&
+			ini->ism_chid[i] == ntohs(aclc->chid)) {
 			ini->ism_selected = i;
 			return 0;
 		}
diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index 0845905520f8..343bdab3b507 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -144,7 +144,12 @@ static const struct pipe_buf_operations smc_pipe_ops = {
 static void smc_rx_spd_release(struct splice_pipe_desc *spd,
 			       unsigned int i)
 {
+	struct smc_spd_priv *priv = (struct smc_spd_priv *)spd->partial[i].private;
+	struct sock *sk = &priv->smc->sk;
+
+	kfree(priv);
 	put_page(spd->pages[i]);
+	sock_put(sk);
 }
 
 static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
@@ -164,6 +169,8 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
 	partial.len = len;
 	partial.private = (unsigned long)priv;
 
+	get_page(smc->conn.rmb_desc->pages);
+	sock_hold(&smc->sk);
 	spd.nr_pages_max = 1;
 	spd.nr_pages = 1;
 	spd.pages = &smc->conn.rmb_desc->pages;
@@ -172,11 +179,8 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
 	spd.spd_release = smc_rx_spd_release;
 
 	bytes = splice_to_pipe(pipe, &spd);
-	if (bytes > 0) {
-		sock_hold(&smc->sk);
-		get_page(smc->conn.rmb_desc->pages);
+	if (bytes > 0)
 		atomic_add(bytes, &smc->conn.splice_pending);
-	}
 
 	return bytes;
 }
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 2429f9fc7e0e..3a2748bc4bea 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -320,12 +320,20 @@ static int smcr_tx_rdma_writes(struct smc_connection *conn, size_t len,
 	int rc;
 
 	for (dstchunk = 0; dstchunk < 2; dstchunk++) {
-		struct ib_sge *sge =
-			wr_rdma_buf->wr_tx_rdma[dstchunk].wr.sg_list;
+		struct ib_rdma_wr *wr = &wr_rdma_buf->wr_tx_rdma[dstchunk];
+		struct ib_sge *sge = wr->wr.sg_list;
+		u64 base_addr = dma_addr;
+
+		if (dst_len < link->qp_attr.cap.max_inline_data) {
+			base_addr = (uintptr_t)conn->sndbuf_desc->cpu_addr;
+			wr->wr.send_flags |= IB_SEND_INLINE;
+		} else {
+			wr->wr.send_flags &= ~IB_SEND_INLINE;
+		}
 
 		num_sges = 0;
 		for (srcchunk = 0; srcchunk < 2; srcchunk++) {
-			sge[srcchunk].addr = dma_addr + src_off;
+			sge[srcchunk].addr = base_addr + src_off;
 			sge[srcchunk].length = src_len;
 			num_sges++;
 
@@ -339,8 +347,7 @@ static int smcr_tx_rdma_writes(struct smc_connection *conn, size_t len,
 			src_len = dst_len - src_len; /* remainder */
 			src_len_sum += src_len;
 		}
-		rc = smc_tx_rdma_write(conn, dst_off, num_sges,
-				       &wr_rdma_buf->wr_tx_rdma[dstchunk]);
+		rc = smc_tx_rdma_write(conn, dst_off, num_sges, wr);
 		if (rc)
 			return rc;
 		if (dst_len_sum == len)
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index f41e9b51f468..19ec8cf45e03 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2455,17 +2455,17 @@ static void tipc_sk_enqueue(struct sk_buff_head *inputq, struct sock *sk,
 			atomic_set(dcnt, 0);
 		lim = rcvbuf_limit(sk, skb) + atomic_read(dcnt);
 		if (likely(!sk_add_backlog(sk, skb, lim))) {
-			trace_tipc_sk_overlimit1(sk, skb, TIPC_DUMP_ALL,
+			trace_tipc_sk_overlimit1(sk, skb, TIPC_DUMP_SK_BKLGQ,
 						 "bklg & rcvq >90% allocated!");
 			continue;
 		}
 
-		trace_tipc_sk_dump(sk, skb, TIPC_DUMP_ALL, "err_overload!");
+		trace_tipc_sk_dump(sk, skb, TIPC_DUMP_SK_BKLGQ, "err_overload!");
 		/* Overload => reject message back to sender */
 		onode = tipc_own_addr(sock_net(sk));
 		atomic_inc(&sk->sk_drops);
 		if (tipc_msg_reverse(onode, &skb, TIPC_ERR_OVERLOAD)) {
-			trace_tipc_sk_rej_msg(sk, skb, TIPC_DUMP_ALL,
+			trace_tipc_sk_rej_msg(sk, skb, TIPC_DUMP_SK_BKLGQ,
 					      "@sk_enqueue!");
 			__skb_queue_tail(xmitq, skb);
 		}
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 2ee078156ded..6fb89a83d363 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -208,41 +208,21 @@ static int espintcp_sendskmsg_locked(struct sock *sk,
 {
 	struct sk_msg *skmsg = &emsg->skmsg;
 	struct scatterlist *sg;
-	int done = 0;
 	int ret;
 
 	flags |= MSG_SENDPAGE_NOTLAST;
-	sg = &skmsg->sg.data[skmsg->sg.start];
 	do {
-		size_t size = sg->length - emsg->offset;
-		int offset = sg->offset + emsg->offset;
-		struct page *p;
-
-		emsg->offset = 0;
-
+		sg = &skmsg->sg.data[skmsg->sg.start];
 		if (sg_is_last(sg))
 			flags &= ~MSG_SENDPAGE_NOTLAST;
 
-		p = sg_page(sg);
-retry:
-		ret = do_tcp_sendpages(sk, p, offset, size, flags);
-		if (ret < 0) {
-			emsg->offset = offset - sg->offset;
-			skmsg->sg.start += done;
+		ret = do_tcp_sendpages(sk, sg_page(sg), sg->offset,
+				       sg->length, flags);
+		if (ret < 0)
 			return ret;
-		}
-
-		if (ret != size) {
-			offset += ret;
-			size -= ret;
-			goto retry;
-		}
 
-		done++;
-		put_page(p);
-		sk_mem_uncharge(sk, sg->length);
-		sg = sg_next(sg);
-	} while (sg);
+		sk_msg_free_partial(sk, skmsg, ret);
+	} while (skmsg->sg.size);
 
 	memset(emsg, 0, sizeof(*emsg));
 
diff --git a/security/apparmor/include/net.h b/security/apparmor/include/net.h
index 2431c011800d..719a31000677 100644
--- a/security/apparmor/include/net.h
+++ b/security/apparmor/include/net.h
@@ -51,8 +51,12 @@ struct aa_sk_ctx {
 	struct aa_label *peer;
 };
 
-#define SK_CTX(X) ((X)->sk_security)
 #define SOCK_ctx(X) SOCK_INODE(X)->i_security
+static inline struct aa_sk_ctx *aa_sock(const struct sock *sk)
+{
+	return sk->sk_security + apparmor_blob_sizes.lbs_sock;
+}
+
 #define DEFINE_AUDIT_NET(NAME, OP, SK, F, T, P)				  \
 	struct lsm_network_audit NAME ## _net = { .sk = (SK),		  \
 						  .family = (F)};	  \
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 6b2592035579..51f09d68dc26 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -766,33 +766,15 @@ static int apparmor_task_kill(struct task_struct *target, struct kernel_siginfo
 	return error;
 }
 
-/**
- * apparmor_sk_alloc_security - allocate and attach the sk_security field
- */
-static int apparmor_sk_alloc_security(struct sock *sk, int family, gfp_t flags)
-{
-	struct aa_sk_ctx *ctx;
-
-	ctx = kzalloc(sizeof(*ctx), flags);
-	if (!ctx)
-		return -ENOMEM;
-
-	SK_CTX(sk) = ctx;
-
-	return 0;
-}
-
 /**
  * apparmor_sk_free_security - free the sk_security field
  */
 static void apparmor_sk_free_security(struct sock *sk)
 {
-	struct aa_sk_ctx *ctx = SK_CTX(sk);
+	struct aa_sk_ctx *ctx = aa_sock(sk);
 
-	SK_CTX(sk) = NULL;
 	aa_put_label(ctx->label);
 	aa_put_label(ctx->peer);
-	kfree(ctx);
 }
 
 /**
@@ -801,8 +783,8 @@ static void apparmor_sk_free_security(struct sock *sk)
 static void apparmor_sk_clone_security(const struct sock *sk,
 				       struct sock *newsk)
 {
-	struct aa_sk_ctx *ctx = SK_CTX(sk);
-	struct aa_sk_ctx *new = SK_CTX(newsk);
+	struct aa_sk_ctx *ctx = aa_sock(sk);
+	struct aa_sk_ctx *new = aa_sock(newsk);
 
 	if (new->label)
 		aa_put_label(new->label);
@@ -858,7 +840,7 @@ static int apparmor_socket_post_create(struct socket *sock, int family,
 		label = aa_get_current_label();
 
 	if (sock->sk) {
-		struct aa_sk_ctx *ctx = SK_CTX(sock->sk);
+		struct aa_sk_ctx *ctx = aa_sock(sock->sk);
 
 		aa_put_label(ctx->label);
 		ctx->label = aa_get_label(label);
@@ -1059,7 +1041,7 @@ static int apparmor_socket_shutdown(struct socket *sock, int how)
  */
 static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
-	struct aa_sk_ctx *ctx = SK_CTX(sk);
+	struct aa_sk_ctx *ctx = aa_sock(sk);
 
 	if (!skb->secmark)
 		return 0;
@@ -1079,7 +1061,7 @@ static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 
 static struct aa_label *sk_peer_label(struct sock *sk)
 {
-	struct aa_sk_ctx *ctx = SK_CTX(sk);
+	struct aa_sk_ctx *ctx = aa_sock(sk);
 
 	if (ctx->peer)
 		return ctx->peer;
@@ -1160,7 +1142,7 @@ static int apparmor_socket_getpeersec_dgram(struct socket *sock,
  */
 static void apparmor_sock_graft(struct sock *sk, struct socket *parent)
 {
-	struct aa_sk_ctx *ctx = SK_CTX(sk);
+	struct aa_sk_ctx *ctx = aa_sock(sk);
 
 	if (!ctx->label)
 		ctx->label = aa_get_current_label();
@@ -1170,7 +1152,7 @@ static void apparmor_sock_graft(struct sock *sk, struct socket *parent)
 static int apparmor_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 				      struct request_sock *req)
 {
-	struct aa_sk_ctx *ctx = SK_CTX(sk);
+	struct aa_sk_ctx *ctx = aa_sock(sk);
 
 	if (!skb->secmark)
 		return 0;
@@ -1187,6 +1169,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
 	.lbs_cred = sizeof(struct aa_label *),
 	.lbs_file = sizeof(struct aa_file_ctx),
 	.lbs_task = sizeof(struct aa_task_ctx),
+	.lbs_sock = sizeof(struct aa_sk_ctx),
 };
 
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
@@ -1223,7 +1206,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(getprocattr, apparmor_getprocattr),
 	LSM_HOOK_INIT(setprocattr, apparmor_setprocattr),
 
-	LSM_HOOK_INIT(sk_alloc_security, apparmor_sk_alloc_security),
 	LSM_HOOK_INIT(sk_free_security, apparmor_sk_free_security),
 	LSM_HOOK_INIT(sk_clone_security, apparmor_sk_clone_security),
 
@@ -1774,7 +1756,7 @@ static unsigned int apparmor_ip_postroute(void *priv,
 	if (sk == NULL)
 		return NF_ACCEPT;
 
-	ctx = SK_CTX(sk);
+	ctx = aa_sock(sk);
 	if (!apparmor_secmark_check(ctx->label, OP_SENDMSG, AA_MAY_SEND,
 				    skb->secmark, sk))
 		return NF_ACCEPT;
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 788667d582ae..18f6ceccbfba 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -6,6 +6,8 @@
 #include <linux/lsm_hooks.h>
 #include <linux/bpf_lsm.h>
 
+bool bpf_lsm_initialized __ro_after_init;
+
 static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
@@ -17,6 +19,7 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
 static int __init bpf_lsm_init(void)
 {
 	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");
+	bpf_lsm_initialized = true;
 	pr_info("LSM support for eBPF active\n");
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index 6de10b6699a4..5637dbd5e717 100644
--- a/security/security.c
+++ b/security/security.c
@@ -29,6 +29,7 @@
 #include <linux/string.h>
 #include <linux/msg.h>
 #include <net/flow.h>
+#include <net/sock.h>
 
 #define MAX_LSM_EVM_XATTR	2
 
@@ -206,6 +207,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
 	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
 	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
+	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
 	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
 }
 
@@ -341,6 +343,7 @@ static void __init ordered_lsm_init(void)
 	init_debug("inode blob size    = %d\n", blob_sizes.lbs_inode);
 	init_debug("ipc blob size      = %d\n", blob_sizes.lbs_ipc);
 	init_debug("msg_msg blob size  = %d\n", blob_sizes.lbs_msg_msg);
+	init_debug("sock blob size     = %d\n", blob_sizes.lbs_sock);
 	init_debug("task blob size     = %d\n", blob_sizes.lbs_task);
 
 	/*
@@ -710,14 +713,14 @@ static void __init lsm_early_task(struct task_struct *task)
 			P->hook.FUNC(__VA_ARGS__);		\
 	} while (0)
 
-#define call_int_hook(FUNC, IRC, ...) ({			\
-	int RC = IRC;						\
+#define call_int_hook(FUNC, ...) ({				\
+	int RC = LSM_RET_DEFAULT(FUNC);				\
 	do {							\
 		struct security_hook_list *P;			\
 								\
 		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
 			RC = P->hook.FUNC(__VA_ARGS__);		\
-			if (RC != 0)				\
+			if (RC != LSM_RET_DEFAULT(FUNC))	\
 				break;				\
 		}						\
 	} while (0);						\
@@ -728,35 +731,35 @@ static void __init lsm_early_task(struct task_struct *task)
 
 int security_binder_set_context_mgr(const struct cred *mgr)
 {
-	return call_int_hook(binder_set_context_mgr, 0, mgr);
+	return call_int_hook(binder_set_context_mgr, mgr);
 }
 
 int security_binder_transaction(const struct cred *from,
 				const struct cred *to)
 {
-	return call_int_hook(binder_transaction, 0, from, to);
+	return call_int_hook(binder_transaction, from, to);
 }
 
 int security_binder_transfer_binder(const struct cred *from,
 				    const struct cred *to)
 {
-	return call_int_hook(binder_transfer_binder, 0, from, to);
+	return call_int_hook(binder_transfer_binder, from, to);
 }
 
 int security_binder_transfer_file(const struct cred *from,
 				  const struct cred *to, struct file *file)
 {
-	return call_int_hook(binder_transfer_file, 0, from, to, file);
+	return call_int_hook(binder_transfer_file, from, to, file);
 }
 
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode)
 {
-	return call_int_hook(ptrace_access_check, 0, child, mode);
+	return call_int_hook(ptrace_access_check, child, mode);
 }
 
 int security_ptrace_traceme(struct task_struct *parent)
 {
-	return call_int_hook(ptrace_traceme, 0, parent);
+	return call_int_hook(ptrace_traceme, parent);
 }
 
 int security_capget(struct task_struct *target,
@@ -764,7 +767,7 @@ int security_capget(struct task_struct *target,
 		     kernel_cap_t *inheritable,
 		     kernel_cap_t *permitted)
 {
-	return call_int_hook(capget, 0, target,
+	return call_int_hook(capget, target,
 				effective, inheritable, permitted);
 }
 
@@ -773,7 +776,7 @@ int security_capset(struct cred *new, const struct cred *old,
 		    const kernel_cap_t *inheritable,
 		    const kernel_cap_t *permitted)
 {
-	return call_int_hook(capset, 0, new, old,
+	return call_int_hook(capset, new, old,
 				effective, inheritable, permitted);
 }
 
@@ -782,27 +785,27 @@ int security_capable(const struct cred *cred,
 		     int cap,
 		     unsigned int opts)
 {
-	return call_int_hook(capable, 0, cred, ns, cap, opts);
+	return call_int_hook(capable, cred, ns, cap, opts);
 }
 
 int security_quotactl(int cmds, int type, int id, struct super_block *sb)
 {
-	return call_int_hook(quotactl, 0, cmds, type, id, sb);
+	return call_int_hook(quotactl, cmds, type, id, sb);
 }
 
 int security_quota_on(struct dentry *dentry)
 {
-	return call_int_hook(quota_on, 0, dentry);
+	return call_int_hook(quota_on, dentry);
 }
 
 int security_syslog(int type)
 {
-	return call_int_hook(syslog, 0, type);
+	return call_int_hook(syslog, type);
 }
 
 int security_settime64(const struct timespec64 *ts, const struct timezone *tz)
 {
-	return call_int_hook(settime, 0, ts, tz);
+	return call_int_hook(settime, ts, tz);
 }
 
 int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
@@ -830,19 +833,19 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 
 int security_bprm_creds_for_exec(struct linux_binprm *bprm)
 {
-	return call_int_hook(bprm_creds_for_exec, 0, bprm);
+	return call_int_hook(bprm_creds_for_exec, bprm);
 }
 
 int security_bprm_creds_from_file(struct linux_binprm *bprm, struct file *file)
 {
-	return call_int_hook(bprm_creds_from_file, 0, bprm, file);
+	return call_int_hook(bprm_creds_from_file, bprm, file);
 }
 
 int security_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
 
-	ret = call_int_hook(bprm_check_security, 0, bprm);
+	ret = call_int_hook(bprm_check_security, bprm);
 	if (ret)
 		return ret;
 	return ima_bprm_check(bprm);
@@ -860,7 +863,7 @@ void security_bprm_committed_creds(struct linux_binprm *bprm)
 
 int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
 {
-	return call_int_hook(fs_context_dup, 0, fc, src_fc);
+	return call_int_hook(fs_context_dup, fc, src_fc);
 }
 
 int security_fs_context_parse_param(struct fs_context *fc,
@@ -883,7 +886,7 @@ int security_fs_context_parse_param(struct fs_context *fc,
 
 int security_sb_alloc(struct super_block *sb)
 {
-	return call_int_hook(sb_alloc_security, 0, sb);
+	return call_int_hook(sb_alloc_security, sb);
 }
 
 void security_sb_free(struct super_block *sb)
@@ -902,46 +905,46 @@ EXPORT_SYMBOL(security_free_mnt_opts);
 
 int security_sb_eat_lsm_opts(char *options, void **mnt_opts)
 {
-	return call_int_hook(sb_eat_lsm_opts, 0, options, mnt_opts);
+	return call_int_hook(sb_eat_lsm_opts, options, mnt_opts);
 }
 EXPORT_SYMBOL(security_sb_eat_lsm_opts);
 
 int security_sb_remount(struct super_block *sb,
 			void *mnt_opts)
 {
-	return call_int_hook(sb_remount, 0, sb, mnt_opts);
+	return call_int_hook(sb_remount, sb, mnt_opts);
 }
 EXPORT_SYMBOL(security_sb_remount);
 
 int security_sb_kern_mount(struct super_block *sb)
 {
-	return call_int_hook(sb_kern_mount, 0, sb);
+	return call_int_hook(sb_kern_mount, sb);
 }
 
 int security_sb_show_options(struct seq_file *m, struct super_block *sb)
 {
-	return call_int_hook(sb_show_options, 0, m, sb);
+	return call_int_hook(sb_show_options, m, sb);
 }
 
 int security_sb_statfs(struct dentry *dentry)
 {
-	return call_int_hook(sb_statfs, 0, dentry);
+	return call_int_hook(sb_statfs, dentry);
 }
 
 int security_sb_mount(const char *dev_name, const struct path *path,
                        const char *type, unsigned long flags, void *data)
 {
-	return call_int_hook(sb_mount, 0, dev_name, path, type, flags, data);
+	return call_int_hook(sb_mount, dev_name, path, type, flags, data);
 }
 
 int security_sb_umount(struct vfsmount *mnt, int flags)
 {
-	return call_int_hook(sb_umount, 0, mnt, flags);
+	return call_int_hook(sb_umount, mnt, flags);
 }
 
 int security_sb_pivotroot(const struct path *old_path, const struct path *new_path)
 {
-	return call_int_hook(sb_pivotroot, 0, old_path, new_path);
+	return call_int_hook(sb_pivotroot, old_path, new_path);
 }
 
 int security_sb_set_mnt_opts(struct super_block *sb,
@@ -949,9 +952,17 @@ int security_sb_set_mnt_opts(struct super_block *sb,
 				unsigned long kern_flags,
 				unsigned long *set_kern_flags)
 {
-	return call_int_hook(sb_set_mnt_opts,
-				mnt_opts ? -EOPNOTSUPP : 0, sb,
-				mnt_opts, kern_flags, set_kern_flags);
+	struct security_hook_list *hp;
+	int rc = mnt_opts ? -EOPNOTSUPP : LSM_RET_DEFAULT(sb_set_mnt_opts);
+
+	hlist_for_each_entry(hp, &security_hook_heads.sb_set_mnt_opts,
+			     list) {
+		rc = hp->hook.sb_set_mnt_opts(sb, mnt_opts, kern_flags,
+					      set_kern_flags);
+		if (rc != LSM_RET_DEFAULT(sb_set_mnt_opts))
+			break;
+	}
+	return rc;
 }
 EXPORT_SYMBOL(security_sb_set_mnt_opts);
 
@@ -960,7 +971,7 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 				unsigned long kern_flags,
 				unsigned long *set_kern_flags)
 {
-	return call_int_hook(sb_clone_mnt_opts, 0, oldsb, newsb,
+	return call_int_hook(sb_clone_mnt_opts, oldsb, newsb,
 				kern_flags, set_kern_flags);
 }
 EXPORT_SYMBOL(security_sb_clone_mnt_opts);
@@ -968,20 +979,28 @@ EXPORT_SYMBOL(security_sb_clone_mnt_opts);
 int security_add_mnt_opt(const char *option, const char *val, int len,
 			 void **mnt_opts)
 {
-	return call_int_hook(sb_add_mnt_opt, -EINVAL,
-					option, val, len, mnt_opts);
+	struct security_hook_list *hp;
+	int rc = -EINVAL;
+
+	hlist_for_each_entry(hp, &security_hook_heads.sb_add_mnt_opt,
+			     list) {
+		rc = hp->hook.sb_add_mnt_opt(option, val, len, mnt_opts);
+		if (rc != LSM_RET_DEFAULT(sb_add_mnt_opt))
+			break;
+	}
+	return rc;
 }
 EXPORT_SYMBOL(security_add_mnt_opt);
 
 int security_move_mount(const struct path *from_path, const struct path *to_path)
 {
-	return call_int_hook(move_mount, 0, from_path, to_path);
+	return call_int_hook(move_mount, from_path, to_path);
 }
 
 int security_path_notify(const struct path *path, u64 mask,
 				unsigned int obj_type)
 {
-	return call_int_hook(path_notify, 0, path, mask, obj_type);
+	return call_int_hook(path_notify, path, mask, obj_type);
 }
 
 int security_inode_alloc(struct inode *inode)
@@ -990,7 +1009,7 @@ int security_inode_alloc(struct inode *inode)
 
 	if (unlikely(rc))
 		return rc;
-	rc = call_int_hook(inode_alloc_security, 0, inode);
+	rc = call_int_hook(inode_alloc_security, inode);
 	if (unlikely(rc))
 		security_inode_free(inode);
 	return rc;
@@ -1026,8 +1045,17 @@ int security_dentry_init_security(struct dentry *dentry, int mode,
 					const struct qstr *name, void **ctx,
 					u32 *ctxlen)
 {
-	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
-				name, ctx, ctxlen);
+	struct security_hook_list *hp;
+	int rc = -EOPNOTSUPP;
+
+	hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security,
+			     list) {
+		rc = hp->hook.dentry_init_security(dentry, mode, name,
+						   ctx, ctxlen);
+		if (rc != LSM_RET_DEFAULT(dentry_init_security))
+			break;
+	}
+	return rc;
 }
 EXPORT_SYMBOL(security_dentry_init_security);
 
@@ -1035,7 +1063,7 @@ int security_dentry_create_files_as(struct dentry *dentry, int mode,
 				    struct qstr *name,
 				    const struct cred *old, struct cred *new)
 {
-	return call_int_hook(dentry_create_files_as, 0, dentry, mode,
+	return call_int_hook(dentry_create_files_as, dentry, mode,
 				name, old, new);
 }
 EXPORT_SYMBOL(security_dentry_create_files_as);
@@ -1046,20 +1074,35 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 {
 	struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
 	struct xattr *lsm_xattr, *evm_xattr, *xattr;
+	struct security_hook_list *hp;
 	int ret;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
 
-	if (!initxattrs)
-		return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
-				     dir, qstr, NULL, NULL, NULL);
+	if (!initxattrs) {
+		ret = -EOPNOTSUPP;
+		hlist_for_each_entry(hp, &security_hook_heads.inode_init_security,
+				     list) {
+			ret = hp->hook.inode_init_security(inode, dir, qstr,
+							   NULL, NULL, NULL);
+			if (ret != LSM_RET_DEFAULT(inode_init_security))
+				break;
+		}
+		return ret;
+	}
 	memset(new_xattrs, 0, sizeof(new_xattrs));
 	lsm_xattr = new_xattrs;
-	ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
-						&lsm_xattr->name,
-						&lsm_xattr->value,
-						&lsm_xattr->value_len);
+	ret = -EOPNOTSUPP;
+	hlist_for_each_entry(hp, &security_hook_heads.inode_init_security,
+			     list) {
+		ret = hp->hook.inode_init_security(inode, dir, qstr,
+						   &lsm_xattr->name,
+						   &lsm_xattr->value,
+						   &lsm_xattr->value_len);
+		if (ret != LSM_RET_DEFAULT(inode_init_security))
+			break;
+	}
 	if (ret)
 		goto out;
 
@@ -1079,10 +1122,19 @@ int security_old_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len)
 {
+	struct security_hook_list *hp;
+	int rc = -EOPNOTSUPP;
+
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
-	return call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir,
-			     qstr, name, value, len);
+	hlist_for_each_entry(hp, &security_hook_heads.inode_init_security,
+			     list) {
+		rc = hp->hook.inode_init_security(inode, dir, qstr, name,
+						  value, len);
+		if (rc != LSM_RET_DEFAULT(inode_init_security))
+			break;
+	}
+	return rc;
 }
 EXPORT_SYMBOL(security_old_inode_init_security);
 
@@ -1092,7 +1144,7 @@ int security_path_mknod(const struct path *dir, struct dentry *dentry, umode_t m
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
 		return 0;
-	return call_int_hook(path_mknod, 0, dir, dentry, mode, dev);
+	return call_int_hook(path_mknod, dir, dentry, mode, dev);
 }
 EXPORT_SYMBOL(security_path_mknod);
 
@@ -1100,7 +1152,7 @@ int security_path_mkdir(const struct path *dir, struct dentry *dentry, umode_t m
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
 		return 0;
-	return call_int_hook(path_mkdir, 0, dir, dentry, mode);
+	return call_int_hook(path_mkdir, dir, dentry, mode);
 }
 EXPORT_SYMBOL(security_path_mkdir);
 
@@ -1108,14 +1160,14 @@ int security_path_rmdir(const struct path *dir, struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
 		return 0;
-	return call_int_hook(path_rmdir, 0, dir, dentry);
+	return call_int_hook(path_rmdir, dir, dentry);
 }
 
 int security_path_unlink(const struct path *dir, struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
 		return 0;
-	return call_int_hook(path_unlink, 0, dir, dentry);
+	return call_int_hook(path_unlink, dir, dentry);
 }
 EXPORT_SYMBOL(security_path_unlink);
 
@@ -1124,7 +1176,7 @@ int security_path_symlink(const struct path *dir, struct dentry *dentry,
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
 		return 0;
-	return call_int_hook(path_symlink, 0, dir, dentry, old_name);
+	return call_int_hook(path_symlink, dir, dentry, old_name);
 }
 
 int security_path_link(struct dentry *old_dentry, const struct path *new_dir,
@@ -1132,7 +1184,7 @@ int security_path_link(struct dentry *old_dentry, const struct path *new_dir,
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry))))
 		return 0;
-	return call_int_hook(path_link, 0, old_dentry, new_dir, new_dentry);
+	return call_int_hook(path_link, old_dentry, new_dir, new_dentry);
 }
 
 int security_path_rename(const struct path *old_dir, struct dentry *old_dentry,
@@ -1144,13 +1196,13 @@ int security_path_rename(const struct path *old_dir, struct dentry *old_dentry,
 		return 0;
 
 	if (flags & RENAME_EXCHANGE) {
-		int err = call_int_hook(path_rename, 0, new_dir, new_dentry,
+		int err = call_int_hook(path_rename, new_dir, new_dentry,
 					old_dir, old_dentry);
 		if (err)
 			return err;
 	}
 
-	return call_int_hook(path_rename, 0, old_dir, old_dentry, new_dir,
+	return call_int_hook(path_rename, old_dir, old_dentry, new_dir,
 				new_dentry);
 }
 EXPORT_SYMBOL(security_path_rename);
@@ -1159,26 +1211,26 @@ int security_path_truncate(const struct path *path)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
 		return 0;
-	return call_int_hook(path_truncate, 0, path);
+	return call_int_hook(path_truncate, path);
 }
 
 int security_path_chmod(const struct path *path, umode_t mode)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
 		return 0;
-	return call_int_hook(path_chmod, 0, path, mode);
+	return call_int_hook(path_chmod, path, mode);
 }
 
 int security_path_chown(const struct path *path, kuid_t uid, kgid_t gid)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
 		return 0;
-	return call_int_hook(path_chown, 0, path, uid, gid);
+	return call_int_hook(path_chown, path, uid, gid);
 }
 
 int security_path_chroot(const struct path *path)
 {
-	return call_int_hook(path_chroot, 0, path);
+	return call_int_hook(path_chroot, path);
 }
 #endif
 
@@ -1186,7 +1238,7 @@ int security_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode
 {
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
-	return call_int_hook(inode_create, 0, dir, dentry, mode);
+	return call_int_hook(inode_create, dir, dentry, mode);
 }
 EXPORT_SYMBOL_GPL(security_inode_create);
 
@@ -1195,14 +1247,14 @@ int security_inode_link(struct dentry *old_dentry, struct inode *dir,
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry))))
 		return 0;
-	return call_int_hook(inode_link, 0, old_dentry, dir, new_dentry);
+	return call_int_hook(inode_link, old_dentry, dir, new_dentry);
 }
 
 int security_inode_unlink(struct inode *dir, struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	return call_int_hook(inode_unlink, 0, dir, dentry);
+	return call_int_hook(inode_unlink, dir, dentry);
 }
 
 int security_inode_symlink(struct inode *dir, struct dentry *dentry,
@@ -1210,14 +1262,14 @@ int security_inode_symlink(struct inode *dir, struct dentry *dentry,
 {
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
-	return call_int_hook(inode_symlink, 0, dir, dentry, old_name);
+	return call_int_hook(inode_symlink, dir, dentry, old_name);
 }
 
 int security_inode_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
-	return call_int_hook(inode_mkdir, 0, dir, dentry, mode);
+	return call_int_hook(inode_mkdir, dir, dentry, mode);
 }
 EXPORT_SYMBOL_GPL(security_inode_mkdir);
 
@@ -1225,14 +1277,14 @@ int security_inode_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	return call_int_hook(inode_rmdir, 0, dir, dentry);
+	return call_int_hook(inode_rmdir, dir, dentry);
 }
 
 int security_inode_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
 {
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
-	return call_int_hook(inode_mknod, 0, dir, dentry, mode, dev);
+	return call_int_hook(inode_mknod, dir, dentry, mode, dev);
 }
 
 int security_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
@@ -1244,13 +1296,13 @@ int security_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
 		return 0;
 
 	if (flags & RENAME_EXCHANGE) {
-		int err = call_int_hook(inode_rename, 0, new_dir, new_dentry,
+		int err = call_int_hook(inode_rename, new_dir, new_dentry,
 						     old_dir, old_dentry);
 		if (err)
 			return err;
 	}
 
-	return call_int_hook(inode_rename, 0, old_dir, old_dentry,
+	return call_int_hook(inode_rename, old_dir, old_dentry,
 					   new_dir, new_dentry);
 }
 
@@ -1258,7 +1310,7 @@ int security_inode_readlink(struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	return call_int_hook(inode_readlink, 0, dentry);
+	return call_int_hook(inode_readlink, dentry);
 }
 
 int security_inode_follow_link(struct dentry *dentry, struct inode *inode,
@@ -1266,14 +1318,14 @@ int security_inode_follow_link(struct dentry *dentry, struct inode *inode,
 {
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
-	return call_int_hook(inode_follow_link, 0, dentry, inode, rcu);
+	return call_int_hook(inode_follow_link, dentry, inode, rcu);
 }
 
 int security_inode_permission(struct inode *inode, int mask)
 {
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
-	return call_int_hook(inode_permission, 0, inode, mask);
+	return call_int_hook(inode_permission, inode, mask);
 }
 
 int security_inode_setattr(struct dentry *dentry, struct iattr *attr)
@@ -1282,7 +1334,7 @@ int security_inode_setattr(struct dentry *dentry, struct iattr *attr)
 
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	ret = call_int_hook(inode_setattr, 0, dentry, attr);
+	ret = call_int_hook(inode_setattr, dentry, attr);
 	if (ret)
 		return ret;
 	return evm_inode_setattr(dentry, attr);
@@ -1293,12 +1345,13 @@ int security_inode_getattr(const struct path *path)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
 		return 0;
-	return call_int_hook(inode_getattr, 0, path);
+	return call_int_hook(inode_getattr, path);
 }
 
 int security_inode_setxattr(struct dentry *dentry, const char *name,
 			    const void *value, size_t size, int flags)
 {
+	struct security_hook_list *hp;
 	int ret;
 
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
@@ -1307,8 +1360,14 @@ int security_inode_setxattr(struct dentry *dentry, const char *name,
 	 * SELinux and Smack integrate the cap call,
 	 * so assume that all LSMs supplying this call do so.
 	 */
-	ret = call_int_hook(inode_setxattr, 1, dentry, name, value, size,
-				flags);
+	ret = 1;
+	hlist_for_each_entry(hp, &security_hook_heads.inode_setxattr,
+			     list) {
+		ret = hp->hook.inode_setxattr(dentry, name, value, size,
+					      flags);
+		if (ret != LSM_RET_DEFAULT(inode_setxattr))
+			break;
+	}
 
 	if (ret == 1)
 		ret = cap_inode_setxattr(dentry, name, value, size, flags);
@@ -1333,18 +1392,19 @@ int security_inode_getxattr(struct dentry *dentry, const char *name)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	return call_int_hook(inode_getxattr, 0, dentry, name);
+	return call_int_hook(inode_getxattr, dentry, name);
 }
 
 int security_inode_listxattr(struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	return call_int_hook(inode_listxattr, 0, dentry);
+	return call_int_hook(inode_listxattr, dentry);
 }
 
 int security_inode_removexattr(struct dentry *dentry, const char *name)
 {
+	struct security_hook_list *hp;
 	int ret;
 
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
@@ -1353,7 +1413,13 @@ int security_inode_removexattr(struct dentry *dentry, const char *name)
 	 * SELinux and Smack integrate the cap call,
 	 * so assume that all LSMs supplying this call do so.
 	 */
-	ret = call_int_hook(inode_removexattr, 1, dentry, name);
+	ret = 1;
+	hlist_for_each_entry(hp, &security_hook_heads.inode_removexattr,
+			     list) {
+		ret = hp->hook.inode_removexattr(dentry, name);
+		if (ret != LSM_RET_DEFAULT(inode_removexattr))
+			break;
+	}
 	if (ret == 1)
 		ret = cap_inode_removexattr(dentry, name);
 	if (ret)
@@ -1366,12 +1432,12 @@ int security_inode_removexattr(struct dentry *dentry, const char *name)
 
 int security_inode_need_killpriv(struct dentry *dentry)
 {
-	return call_int_hook(inode_need_killpriv, 0, dentry);
+	return call_int_hook(inode_need_killpriv, dentry);
 }
 
 int security_inode_killpriv(struct dentry *dentry)
 {
-	return call_int_hook(inode_killpriv, 0, dentry);
+	return call_int_hook(inode_killpriv, dentry);
 }
 
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc)
@@ -1415,7 +1481,7 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 {
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
-	return call_int_hook(inode_listsecurity, 0, inode, buffer, buffer_size);
+	return call_int_hook(inode_listsecurity, inode, buffer, buffer_size);
 }
 EXPORT_SYMBOL(security_inode_listsecurity);
 
@@ -1426,7 +1492,7 @@ void security_inode_getsecid(struct inode *inode, u32 *secid)
 
 int security_inode_copy_up(struct dentry *src, struct cred **new)
 {
-	return call_int_hook(inode_copy_up, 0, src, new);
+	return call_int_hook(inode_copy_up, src, new);
 }
 EXPORT_SYMBOL(security_inode_copy_up);
 
@@ -1454,14 +1520,14 @@ EXPORT_SYMBOL(security_inode_copy_up_xattr);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
 				  struct kernfs_node *kn)
 {
-	return call_int_hook(kernfs_init_security, 0, kn_dir, kn);
+	return call_int_hook(kernfs_init_security, kn_dir, kn);
 }
 
 int security_file_permission(struct file *file, int mask)
 {
 	int ret;
 
-	ret = call_int_hook(file_permission, 0, file, mask);
+	ret = call_int_hook(file_permission, file, mask);
 	if (ret)
 		return ret;
 
@@ -1474,7 +1540,7 @@ int security_file_alloc(struct file *file)
 
 	if (rc)
 		return rc;
-	rc = call_int_hook(file_alloc_security, 0, file);
+	rc = call_int_hook(file_alloc_security, file);
 	if (unlikely(rc))
 		security_file_free(file);
 	return rc;
@@ -1495,7 +1561,7 @@ void security_file_free(struct file *file)
 
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	return call_int_hook(file_ioctl, 0, file, cmd, arg);
+	return call_int_hook(file_ioctl, file, cmd, arg);
 }
 EXPORT_SYMBOL_GPL(security_file_ioctl);
 
@@ -1513,7 +1579,7 @@ EXPORT_SYMBOL_GPL(security_file_ioctl);
 int security_file_ioctl_compat(struct file *file, unsigned int cmd,
 			       unsigned long arg)
 {
-	return call_int_hook(file_ioctl_compat, 0, file, cmd, arg);
+	return call_int_hook(file_ioctl_compat, file, cmd, arg);
 }
 EXPORT_SYMBOL_GPL(security_file_ioctl_compat);
 
@@ -1556,7 +1622,7 @@ int security_mmap_file(struct file *file, unsigned long prot,
 	unsigned long prot_adj = mmap_prot(file, prot);
 	int ret;
 
-	ret = call_int_hook(mmap_file, 0, file, prot, prot_adj, flags);
+	ret = call_int_hook(mmap_file, file, prot, prot_adj, flags);
 	if (ret)
 		return ret;
 	return ima_file_mmap(file, prot, prot_adj, flags);
@@ -1564,7 +1630,7 @@ int security_mmap_file(struct file *file, unsigned long prot,
 
 int security_mmap_addr(unsigned long addr)
 {
-	return call_int_hook(mmap_addr, 0, addr);
+	return call_int_hook(mmap_addr, addr);
 }
 
 int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
@@ -1572,7 +1638,7 @@ int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 {
 	int ret;
 
-	ret = call_int_hook(file_mprotect, 0, vma, reqprot, prot);
+	ret = call_int_hook(file_mprotect, vma, reqprot, prot);
 	if (ret)
 		return ret;
 	return ima_file_mprotect(vma, prot);
@@ -1580,12 +1646,12 @@ int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 
 int security_file_lock(struct file *file, unsigned int cmd)
 {
-	return call_int_hook(file_lock, 0, file, cmd);
+	return call_int_hook(file_lock, file, cmd);
 }
 
 int security_file_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	return call_int_hook(file_fcntl, 0, file, cmd, arg);
+	return call_int_hook(file_fcntl, file, cmd, arg);
 }
 
 void security_file_set_fowner(struct file *file)
@@ -1596,19 +1662,19 @@ void security_file_set_fowner(struct file *file)
 int security_file_send_sigiotask(struct task_struct *tsk,
 				  struct fown_struct *fown, int sig)
 {
-	return call_int_hook(file_send_sigiotask, 0, tsk, fown, sig);
+	return call_int_hook(file_send_sigiotask, tsk, fown, sig);
 }
 
 int security_file_receive(struct file *file)
 {
-	return call_int_hook(file_receive, 0, file);
+	return call_int_hook(file_receive, file);
 }
 
 int security_file_open(struct file *file)
 {
 	int ret;
 
-	ret = call_int_hook(file_open, 0, file);
+	ret = call_int_hook(file_open, file);
 	if (ret)
 		return ret;
 
@@ -1621,7 +1687,7 @@ int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 
 	if (rc)
 		return rc;
-	rc = call_int_hook(task_alloc, 0, task, clone_flags);
+	rc = call_int_hook(task_alloc, task, clone_flags);
 	if (unlikely(rc))
 		security_task_free(task);
 	return rc;
@@ -1642,7 +1708,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 	if (rc)
 		return rc;
 
-	rc = call_int_hook(cred_alloc_blank, 0, cred, gfp);
+	rc = call_int_hook(cred_alloc_blank, cred, gfp);
 	if (unlikely(rc))
 		security_cred_free(cred);
 	return rc;
@@ -1670,7 +1736,7 @@ int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp)
 	if (rc)
 		return rc;
 
-	rc = call_int_hook(cred_prepare, 0, new, old, gfp);
+	rc = call_int_hook(cred_prepare, new, old, gfp);
 	if (unlikely(rc))
 		security_cred_free(new);
 	return rc;
@@ -1690,19 +1756,19 @@ EXPORT_SYMBOL(security_cred_getsecid);
 
 int security_kernel_act_as(struct cred *new, u32 secid)
 {
-	return call_int_hook(kernel_act_as, 0, new, secid);
+	return call_int_hook(kernel_act_as, new, secid);
 }
 
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
 {
-	return call_int_hook(kernel_create_files_as, 0, new, inode);
+	return call_int_hook(kernel_create_files_as, new, inode);
 }
 
 int security_kernel_module_request(char *kmod_name)
 {
 	int ret;
 
-	ret = call_int_hook(kernel_module_request, 0, kmod_name);
+	ret = call_int_hook(kernel_module_request, kmod_name);
 	if (ret)
 		return ret;
 	return integrity_kernel_module_request(kmod_name);
@@ -1713,7 +1779,7 @@ int security_kernel_read_file(struct file *file, enum kernel_read_file_id id,
 {
 	int ret;
 
-	ret = call_int_hook(kernel_read_file, 0, file, id, contents);
+	ret = call_int_hook(kernel_read_file, file, id, contents);
 	if (ret)
 		return ret;
 	return ima_read_file(file, id, contents);
@@ -1725,7 +1791,7 @@ int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 {
 	int ret;
 
-	ret = call_int_hook(kernel_post_read_file, 0, file, buf, size, id);
+	ret = call_int_hook(kernel_post_read_file, file, buf, size, id);
 	if (ret)
 		return ret;
 	return ima_post_read_file(file, buf, size, id);
@@ -1736,7 +1802,7 @@ int security_kernel_load_data(enum kernel_load_data_id id, bool contents)
 {
 	int ret;
 
-	ret = call_int_hook(kernel_load_data, 0, id, contents);
+	ret = call_int_hook(kernel_load_data, id, contents);
 	if (ret)
 		return ret;
 	return ima_load_data(id, contents);
@@ -1749,7 +1815,7 @@ int security_kernel_post_load_data(char *buf, loff_t size,
 {
 	int ret;
 
-	ret = call_int_hook(kernel_post_load_data, 0, buf, size, id,
+	ret = call_int_hook(kernel_post_load_data, buf, size, id,
 			    description);
 	if (ret)
 		return ret;
@@ -1760,28 +1826,28 @@ EXPORT_SYMBOL_GPL(security_kernel_post_load_data);
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags)
 {
-	return call_int_hook(task_fix_setuid, 0, new, old, flags);
+	return call_int_hook(task_fix_setuid, new, old, flags);
 }
 
 int security_task_fix_setgid(struct cred *new, const struct cred *old,
 				 int flags)
 {
-	return call_int_hook(task_fix_setgid, 0, new, old, flags);
+	return call_int_hook(task_fix_setgid, new, old, flags);
 }
 
 int security_task_setpgid(struct task_struct *p, pid_t pgid)
 {
-	return call_int_hook(task_setpgid, 0, p, pgid);
+	return call_int_hook(task_setpgid, p, pgid);
 }
 
 int security_task_getpgid(struct task_struct *p)
 {
-	return call_int_hook(task_getpgid, 0, p);
+	return call_int_hook(task_getpgid, p);
 }
 
 int security_task_getsid(struct task_struct *p)
 {
-	return call_int_hook(task_getsid, 0, p);
+	return call_int_hook(task_getsid, p);
 }
 
 void security_task_getsecid(struct task_struct *p, u32 *secid)
@@ -1793,50 +1859,50 @@ EXPORT_SYMBOL(security_task_getsecid);
 
 int security_task_setnice(struct task_struct *p, int nice)
 {
-	return call_int_hook(task_setnice, 0, p, nice);
+	return call_int_hook(task_setnice, p, nice);
 }
 
 int security_task_setioprio(struct task_struct *p, int ioprio)
 {
-	return call_int_hook(task_setioprio, 0, p, ioprio);
+	return call_int_hook(task_setioprio, p, ioprio);
 }
 
 int security_task_getioprio(struct task_struct *p)
 {
-	return call_int_hook(task_getioprio, 0, p);
+	return call_int_hook(task_getioprio, p);
 }
 
 int security_task_prlimit(const struct cred *cred, const struct cred *tcred,
 			  unsigned int flags)
 {
-	return call_int_hook(task_prlimit, 0, cred, tcred, flags);
+	return call_int_hook(task_prlimit, cred, tcred, flags);
 }
 
 int security_task_setrlimit(struct task_struct *p, unsigned int resource,
 		struct rlimit *new_rlim)
 {
-	return call_int_hook(task_setrlimit, 0, p, resource, new_rlim);
+	return call_int_hook(task_setrlimit, p, resource, new_rlim);
 }
 
 int security_task_setscheduler(struct task_struct *p)
 {
-	return call_int_hook(task_setscheduler, 0, p);
+	return call_int_hook(task_setscheduler, p);
 }
 
 int security_task_getscheduler(struct task_struct *p)
 {
-	return call_int_hook(task_getscheduler, 0, p);
+	return call_int_hook(task_getscheduler, p);
 }
 
 int security_task_movememory(struct task_struct *p)
 {
-	return call_int_hook(task_movememory, 0, p);
+	return call_int_hook(task_movememory, p);
 }
 
 int security_task_kill(struct task_struct *p, struct kernel_siginfo *info,
 			int sig, const struct cred *cred)
 {
-	return call_int_hook(task_kill, 0, p, info, sig, cred);
+	return call_int_hook(task_kill, p, info, sig, cred);
 }
 
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
@@ -1864,7 +1930,7 @@ void security_task_to_inode(struct task_struct *p, struct inode *inode)
 
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 {
-	return call_int_hook(ipc_permission, 0, ipcp, flag);
+	return call_int_hook(ipc_permission, ipcp, flag);
 }
 
 void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
@@ -1879,7 +1945,7 @@ int security_msg_msg_alloc(struct msg_msg *msg)
 
 	if (unlikely(rc))
 		return rc;
-	rc = call_int_hook(msg_msg_alloc_security, 0, msg);
+	rc = call_int_hook(msg_msg_alloc_security, msg);
 	if (unlikely(rc))
 		security_msg_msg_free(msg);
 	return rc;
@@ -1898,7 +1964,7 @@ int security_msg_queue_alloc(struct kern_ipc_perm *msq)
 
 	if (unlikely(rc))
 		return rc;
-	rc = call_int_hook(msg_queue_alloc_security, 0, msq);
+	rc = call_int_hook(msg_queue_alloc_security, msq);
 	if (unlikely(rc))
 		security_msg_queue_free(msq);
 	return rc;
@@ -1913,24 +1979,24 @@ void security_msg_queue_free(struct kern_ipc_perm *msq)
 
 int security_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
 {
-	return call_int_hook(msg_queue_associate, 0, msq, msqflg);
+	return call_int_hook(msg_queue_associate, msq, msqflg);
 }
 
 int security_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
 {
-	return call_int_hook(msg_queue_msgctl, 0, msq, cmd);
+	return call_int_hook(msg_queue_msgctl, msq, cmd);
 }
 
 int security_msg_queue_msgsnd(struct kern_ipc_perm *msq,
 			       struct msg_msg *msg, int msqflg)
 {
-	return call_int_hook(msg_queue_msgsnd, 0, msq, msg, msqflg);
+	return call_int_hook(msg_queue_msgsnd, msq, msg, msqflg);
 }
 
 int security_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *msg,
 			       struct task_struct *target, long type, int mode)
 {
-	return call_int_hook(msg_queue_msgrcv, 0, msq, msg, target, type, mode);
+	return call_int_hook(msg_queue_msgrcv, msq, msg, target, type, mode);
 }
 
 int security_shm_alloc(struct kern_ipc_perm *shp)
@@ -1939,7 +2005,7 @@ int security_shm_alloc(struct kern_ipc_perm *shp)
 
 	if (unlikely(rc))
 		return rc;
-	rc = call_int_hook(shm_alloc_security, 0, shp);
+	rc = call_int_hook(shm_alloc_security, shp);
 	if (unlikely(rc))
 		security_shm_free(shp);
 	return rc;
@@ -1954,17 +2020,17 @@ void security_shm_free(struct kern_ipc_perm *shp)
 
 int security_shm_associate(struct kern_ipc_perm *shp, int shmflg)
 {
-	return call_int_hook(shm_associate, 0, shp, shmflg);
+	return call_int_hook(shm_associate, shp, shmflg);
 }
 
 int security_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
 {
-	return call_int_hook(shm_shmctl, 0, shp, cmd);
+	return call_int_hook(shm_shmctl, shp, cmd);
 }
 
 int security_shm_shmat(struct kern_ipc_perm *shp, char __user *shmaddr, int shmflg)
 {
-	return call_int_hook(shm_shmat, 0, shp, shmaddr, shmflg);
+	return call_int_hook(shm_shmat, shp, shmaddr, shmflg);
 }
 
 int security_sem_alloc(struct kern_ipc_perm *sma)
@@ -1973,7 +2039,7 @@ int security_sem_alloc(struct kern_ipc_perm *sma)
 
 	if (unlikely(rc))
 		return rc;
-	rc = call_int_hook(sem_alloc_security, 0, sma);
+	rc = call_int_hook(sem_alloc_security, sma);
 	if (unlikely(rc))
 		security_sem_free(sma);
 	return rc;
@@ -1988,18 +2054,18 @@ void security_sem_free(struct kern_ipc_perm *sma)
 
 int security_sem_associate(struct kern_ipc_perm *sma, int semflg)
 {
-	return call_int_hook(sem_associate, 0, sma, semflg);
+	return call_int_hook(sem_associate, sma, semflg);
 }
 
 int security_sem_semctl(struct kern_ipc_perm *sma, int cmd)
 {
-	return call_int_hook(sem_semctl, 0, sma, cmd);
+	return call_int_hook(sem_semctl, sma, cmd);
 }
 
 int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
 			unsigned nsops, int alter)
 {
-	return call_int_hook(sem_semop, 0, sma, sops, nsops, alter);
+	return call_int_hook(sem_semop, sma, sops, nsops, alter);
 }
 
 void security_d_instantiate(struct dentry *dentry, struct inode *inode)
@@ -2038,12 +2104,12 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 
 int security_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
-	return call_int_hook(netlink_send, 0, sk, skb);
+	return call_int_hook(netlink_send, sk, skb);
 }
 
 int security_ismaclabel(const char *name)
 {
-	return call_int_hook(ismaclabel, 0, name);
+	return call_int_hook(ismaclabel, name);
 }
 EXPORT_SYMBOL(security_ismaclabel);
 
@@ -2069,7 +2135,7 @@ EXPORT_SYMBOL(security_secid_to_secctx);
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
 	*secid = 0;
-	return call_int_hook(secctx_to_secid, 0, secdata, seclen, secid);
+	return call_int_hook(secctx_to_secid, secdata, seclen, secid);
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
@@ -2087,13 +2153,13 @@ EXPORT_SYMBOL(security_inode_invalidate_secctx);
 
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
-	return call_int_hook(inode_notifysecctx, 0, inode, ctx, ctxlen);
+	return call_int_hook(inode_notifysecctx, inode, ctx, ctxlen);
 }
 EXPORT_SYMBOL(security_inode_notifysecctx);
 
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
-	return call_int_hook(inode_setsecctx, 0, dentry, ctx, ctxlen);
+	return call_int_hook(inode_setsecctx, dentry, ctx, ctxlen);
 }
 EXPORT_SYMBOL(security_inode_setsecctx);
 
@@ -2120,14 +2186,14 @@ int security_post_notification(const struct cred *w_cred,
 			       const struct cred *cred,
 			       struct watch_notification *n)
 {
-	return call_int_hook(post_notification, 0, w_cred, cred, n);
+	return call_int_hook(post_notification, w_cred, cred, n);
 }
 #endif /* CONFIG_WATCH_QUEUE */
 
 #ifdef CONFIG_KEY_NOTIFICATIONS
 int security_watch_key(struct key *key)
 {
-	return call_int_hook(watch_key, 0, key);
+	return call_int_hook(watch_key, key);
 }
 #endif
 
@@ -2135,93 +2201,93 @@ int security_watch_key(struct key *key)
 
 int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk)
 {
-	return call_int_hook(unix_stream_connect, 0, sock, other, newsk);
+	return call_int_hook(unix_stream_connect, sock, other, newsk);
 }
 EXPORT_SYMBOL(security_unix_stream_connect);
 
 int security_unix_may_send(struct socket *sock,  struct socket *other)
 {
-	return call_int_hook(unix_may_send, 0, sock, other);
+	return call_int_hook(unix_may_send, sock, other);
 }
 EXPORT_SYMBOL(security_unix_may_send);
 
 int security_socket_create(int family, int type, int protocol, int kern)
 {
-	return call_int_hook(socket_create, 0, family, type, protocol, kern);
+	return call_int_hook(socket_create, family, type, protocol, kern);
 }
 
 int security_socket_post_create(struct socket *sock, int family,
 				int type, int protocol, int kern)
 {
-	return call_int_hook(socket_post_create, 0, sock, family, type,
+	return call_int_hook(socket_post_create, sock, family, type,
 						protocol, kern);
 }
 
 int security_socket_socketpair(struct socket *socka, struct socket *sockb)
 {
-	return call_int_hook(socket_socketpair, 0, socka, sockb);
+	return call_int_hook(socket_socketpair, socka, sockb);
 }
 EXPORT_SYMBOL(security_socket_socketpair);
 
 int security_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
 {
-	return call_int_hook(socket_bind, 0, sock, address, addrlen);
+	return call_int_hook(socket_bind, sock, address, addrlen);
 }
 
 int security_socket_connect(struct socket *sock, struct sockaddr *address, int addrlen)
 {
-	return call_int_hook(socket_connect, 0, sock, address, addrlen);
+	return call_int_hook(socket_connect, sock, address, addrlen);
 }
 
 int security_socket_listen(struct socket *sock, int backlog)
 {
-	return call_int_hook(socket_listen, 0, sock, backlog);
+	return call_int_hook(socket_listen, sock, backlog);
 }
 
 int security_socket_accept(struct socket *sock, struct socket *newsock)
 {
-	return call_int_hook(socket_accept, 0, sock, newsock);
+	return call_int_hook(socket_accept, sock, newsock);
 }
 
 int security_socket_sendmsg(struct socket *sock, struct msghdr *msg, int size)
 {
-	return call_int_hook(socket_sendmsg, 0, sock, msg, size);
+	return call_int_hook(socket_sendmsg, sock, msg, size);
 }
 
 int security_socket_recvmsg(struct socket *sock, struct msghdr *msg,
 			    int size, int flags)
 {
-	return call_int_hook(socket_recvmsg, 0, sock, msg, size, flags);
+	return call_int_hook(socket_recvmsg, sock, msg, size, flags);
 }
 
 int security_socket_getsockname(struct socket *sock)
 {
-	return call_int_hook(socket_getsockname, 0, sock);
+	return call_int_hook(socket_getsockname, sock);
 }
 
 int security_socket_getpeername(struct socket *sock)
 {
-	return call_int_hook(socket_getpeername, 0, sock);
+	return call_int_hook(socket_getpeername, sock);
 }
 
 int security_socket_getsockopt(struct socket *sock, int level, int optname)
 {
-	return call_int_hook(socket_getsockopt, 0, sock, level, optname);
+	return call_int_hook(socket_getsockopt, sock, level, optname);
 }
 
 int security_socket_setsockopt(struct socket *sock, int level, int optname)
 {
-	return call_int_hook(socket_setsockopt, 0, sock, level, optname);
+	return call_int_hook(socket_setsockopt, sock, level, optname);
 }
 
 int security_socket_shutdown(struct socket *sock, int how)
 {
-	return call_int_hook(socket_shutdown, 0, sock, how);
+	return call_int_hook(socket_shutdown, sock, how);
 }
 
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
-	return call_int_hook(socket_sock_rcv_skb, 0, sk, skb);
+	return call_int_hook(socket_sock_rcv_skb, sk, skb);
 }
 EXPORT_SYMBOL(security_sock_rcv_skb);
 
@@ -2262,14 +2328,56 @@ int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
+/**
+ * lsm_sock_alloc - allocate a composite sock blob
+ * @sock: the sock that needs a blob
+ * @priority: allocation mode
+ *
+ * Allocate the sock blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+static int lsm_sock_alloc(struct sock *sock, gfp_t priority)
+{
+	if (blob_sizes.lbs_sock == 0) {
+		sock->sk_security = NULL;
+		return 0;
+	}
+
+	sock->sk_security = kzalloc(blob_sizes.lbs_sock, priority);
+	if (sock->sk_security == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
+/**
+ * security_sk_alloc() - Allocate and initialize a sock's LSM blob
+ * @sk: sock
+ * @family: protocol family
+ * @priority: gfp flags
+ *
+ * Allocate and attach a security structure to the sk->sk_security field, which
+ * is used to copy security attributes between local stream sockets.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority)
 {
-	return call_int_hook(sk_alloc_security, 0, sk, family, priority);
+	int rc = lsm_sock_alloc(sk, priority);
+
+	if (unlikely(rc))
+		return rc;
+	rc = call_int_hook(sk_alloc_security, sk, family, priority);
+	if (unlikely(rc))
+		security_sk_free(sk);
+	return rc;
 }
 
 void security_sk_free(struct sock *sk)
 {
 	call_void_hook(sk_free_security, sk);
+	kfree(sk->sk_security);
+	sk->sk_security = NULL;
 }
 
 void security_sk_clone(const struct sock *sk, struct sock *newsk)
@@ -2300,7 +2408,7 @@ EXPORT_SYMBOL(security_sock_graft);
 int security_inet_conn_request(struct sock *sk,
 			struct sk_buff *skb, struct request_sock *req)
 {
-	return call_int_hook(inet_conn_request, 0, sk, skb, req);
+	return call_int_hook(inet_conn_request, sk, skb, req);
 }
 EXPORT_SYMBOL(security_inet_conn_request);
 
@@ -2319,7 +2427,7 @@ EXPORT_SYMBOL(security_inet_conn_established);
 
 int security_secmark_relabel_packet(u32 secid)
 {
-	return call_int_hook(secmark_relabel_packet, 0, secid);
+	return call_int_hook(secmark_relabel_packet, secid);
 }
 EXPORT_SYMBOL(security_secmark_relabel_packet);
 
@@ -2337,7 +2445,7 @@ EXPORT_SYMBOL(security_secmark_refcount_dec);
 
 int security_tun_dev_alloc_security(void **security)
 {
-	return call_int_hook(tun_dev_alloc_security, 0, security);
+	return call_int_hook(tun_dev_alloc_security, security);
 }
 EXPORT_SYMBOL(security_tun_dev_alloc_security);
 
@@ -2349,38 +2457,38 @@ EXPORT_SYMBOL(security_tun_dev_free_security);
 
 int security_tun_dev_create(void)
 {
-	return call_int_hook(tun_dev_create, 0);
+	return call_int_hook(tun_dev_create);
 }
 EXPORT_SYMBOL(security_tun_dev_create);
 
 int security_tun_dev_attach_queue(void *security)
 {
-	return call_int_hook(tun_dev_attach_queue, 0, security);
+	return call_int_hook(tun_dev_attach_queue, security);
 }
 EXPORT_SYMBOL(security_tun_dev_attach_queue);
 
 int security_tun_dev_attach(struct sock *sk, void *security)
 {
-	return call_int_hook(tun_dev_attach, 0, sk, security);
+	return call_int_hook(tun_dev_attach, sk, security);
 }
 EXPORT_SYMBOL(security_tun_dev_attach);
 
 int security_tun_dev_open(void *security)
 {
-	return call_int_hook(tun_dev_open, 0, security);
+	return call_int_hook(tun_dev_open, security);
 }
 EXPORT_SYMBOL(security_tun_dev_open);
 
 int security_sctp_assoc_request(struct sctp_endpoint *ep, struct sk_buff *skb)
 {
-	return call_int_hook(sctp_assoc_request, 0, ep, skb);
+	return call_int_hook(sctp_assoc_request, ep, skb);
 }
 EXPORT_SYMBOL(security_sctp_assoc_request);
 
 int security_sctp_bind_connect(struct sock *sk, int optname,
 			       struct sockaddr *address, int addrlen)
 {
-	return call_int_hook(sctp_bind_connect, 0, sk, optname,
+	return call_int_hook(sctp_bind_connect, sk, optname,
 			     address, addrlen);
 }
 EXPORT_SYMBOL(security_sctp_bind_connect);
@@ -2398,19 +2506,19 @@ EXPORT_SYMBOL(security_sctp_sk_clone);
 
 int security_ib_pkey_access(void *sec, u64 subnet_prefix, u16 pkey)
 {
-	return call_int_hook(ib_pkey_access, 0, sec, subnet_prefix, pkey);
+	return call_int_hook(ib_pkey_access, sec, subnet_prefix, pkey);
 }
 EXPORT_SYMBOL(security_ib_pkey_access);
 
 int security_ib_endport_manage_subnet(void *sec, const char *dev_name, u8 port_num)
 {
-	return call_int_hook(ib_endport_manage_subnet, 0, sec, dev_name, port_num);
+	return call_int_hook(ib_endport_manage_subnet, sec, dev_name, port_num);
 }
 EXPORT_SYMBOL(security_ib_endport_manage_subnet);
 
 int security_ib_alloc_security(void **sec)
 {
-	return call_int_hook(ib_alloc_security, 0, sec);
+	return call_int_hook(ib_alloc_security, sec);
 }
 EXPORT_SYMBOL(security_ib_alloc_security);
 
@@ -2427,14 +2535,14 @@ int security_xfrm_policy_alloc(struct xfrm_sec_ctx **ctxp,
 			       struct xfrm_user_sec_ctx *sec_ctx,
 			       gfp_t gfp)
 {
-	return call_int_hook(xfrm_policy_alloc_security, 0, ctxp, sec_ctx, gfp);
+	return call_int_hook(xfrm_policy_alloc_security, ctxp, sec_ctx, gfp);
 }
 EXPORT_SYMBOL(security_xfrm_policy_alloc);
 
 int security_xfrm_policy_clone(struct xfrm_sec_ctx *old_ctx,
 			      struct xfrm_sec_ctx **new_ctxp)
 {
-	return call_int_hook(xfrm_policy_clone_security, 0, old_ctx, new_ctxp);
+	return call_int_hook(xfrm_policy_clone_security, old_ctx, new_ctxp);
 }
 
 void security_xfrm_policy_free(struct xfrm_sec_ctx *ctx)
@@ -2445,25 +2553,25 @@ EXPORT_SYMBOL(security_xfrm_policy_free);
 
 int security_xfrm_policy_delete(struct xfrm_sec_ctx *ctx)
 {
-	return call_int_hook(xfrm_policy_delete_security, 0, ctx);
+	return call_int_hook(xfrm_policy_delete_security, ctx);
 }
 
 int security_xfrm_state_alloc(struct xfrm_state *x,
 			      struct xfrm_user_sec_ctx *sec_ctx)
 {
-	return call_int_hook(xfrm_state_alloc, 0, x, sec_ctx);
+	return call_int_hook(xfrm_state_alloc, x, sec_ctx);
 }
 EXPORT_SYMBOL(security_xfrm_state_alloc);
 
 int security_xfrm_state_alloc_acquire(struct xfrm_state *x,
 				      struct xfrm_sec_ctx *polsec, u32 secid)
 {
-	return call_int_hook(xfrm_state_alloc_acquire, 0, x, polsec, secid);
+	return call_int_hook(xfrm_state_alloc_acquire, x, polsec, secid);
 }
 
 int security_xfrm_state_delete(struct xfrm_state *x)
 {
-	return call_int_hook(xfrm_state_delete_security, 0, x);
+	return call_int_hook(xfrm_state_delete_security, x);
 }
 EXPORT_SYMBOL(security_xfrm_state_delete);
 
@@ -2474,7 +2582,7 @@ void security_xfrm_state_free(struct xfrm_state *x)
 
 int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir)
 {
-	return call_int_hook(xfrm_policy_lookup, 0, ctx, fl_secid, dir);
+	return call_int_hook(xfrm_policy_lookup, ctx, fl_secid, dir);
 }
 
 int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
@@ -2503,12 +2611,12 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 
 int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
 {
-	return call_int_hook(xfrm_decode_session, 0, skb, secid, 1);
+	return call_int_hook(xfrm_decode_session, skb, secid, 1);
 }
 
 void security_skb_classify_flow(struct sk_buff *skb, struct flowi_common *flic)
 {
-	int rc = call_int_hook(xfrm_decode_session, 0, skb, &flic->flowic_secid,
+	int rc = call_int_hook(xfrm_decode_session, skb, &flic->flowic_secid,
 				0);
 
 	BUG_ON(rc);
@@ -2522,7 +2630,7 @@ EXPORT_SYMBOL(security_skb_classify_flow);
 int security_key_alloc(struct key *key, const struct cred *cred,
 		       unsigned long flags)
 {
-	return call_int_hook(key_alloc, 0, key, cred, flags);
+	return call_int_hook(key_alloc, key, cred, flags);
 }
 
 void security_key_free(struct key *key)
@@ -2533,13 +2641,13 @@ void security_key_free(struct key *key)
 int security_key_permission(key_ref_t key_ref, const struct cred *cred,
 			    enum key_need_perm need_perm)
 {
-	return call_int_hook(key_permission, 0, key_ref, cred, need_perm);
+	return call_int_hook(key_permission, key_ref, cred, need_perm);
 }
 
 int security_key_getsecurity(struct key *key, char **_buffer)
 {
 	*_buffer = NULL;
-	return call_int_hook(key_getsecurity, 0, key, _buffer);
+	return call_int_hook(key_getsecurity, key, _buffer);
 }
 
 #endif	/* CONFIG_KEYS */
@@ -2549,13 +2657,13 @@ int security_key_getsecurity(struct key *key, char **_buffer)
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
 			     gfp_t gfp)
 {
-	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule,
+	return call_int_hook(audit_rule_init, field, op, rulestr, lsmrule,
 			     gfp);
 }
 
 int security_audit_rule_known(struct audit_krule *krule)
 {
-	return call_int_hook(audit_rule_known, 0, krule);
+	return call_int_hook(audit_rule_known, krule);
 }
 
 void security_audit_rule_free(void *lsmrule)
@@ -2565,30 +2673,30 @@ void security_audit_rule_free(void *lsmrule)
 
 int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
 {
-	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
+	return call_int_hook(audit_rule_match, secid, field, op, lsmrule);
 }
 #endif /* CONFIG_AUDIT */
 
 #ifdef CONFIG_BPF_SYSCALL
 int security_bpf(int cmd, union bpf_attr *attr, unsigned int size)
 {
-	return call_int_hook(bpf, 0, cmd, attr, size);
+	return call_int_hook(bpf, cmd, attr, size);
 }
 int security_bpf_map(struct bpf_map *map, fmode_t fmode)
 {
-	return call_int_hook(bpf_map, 0, map, fmode);
+	return call_int_hook(bpf_map, map, fmode);
 }
 int security_bpf_prog(struct bpf_prog *prog)
 {
-	return call_int_hook(bpf_prog, 0, prog);
+	return call_int_hook(bpf_prog, prog);
 }
 int security_bpf_map_alloc(struct bpf_map *map)
 {
-	return call_int_hook(bpf_map_alloc_security, 0, map);
+	return call_int_hook(bpf_map_alloc_security, map);
 }
 int security_bpf_prog_alloc(struct bpf_prog_aux *aux)
 {
-	return call_int_hook(bpf_prog_alloc_security, 0, aux);
+	return call_int_hook(bpf_prog_alloc_security, aux);
 }
 void security_bpf_map_free(struct bpf_map *map)
 {
@@ -2602,19 +2710,19 @@ void security_bpf_prog_free(struct bpf_prog_aux *aux)
 
 int security_locked_down(enum lockdown_reason what)
 {
-	return call_int_hook(locked_down, 0, what);
+	return call_int_hook(locked_down, what);
 }
 EXPORT_SYMBOL(security_locked_down);
 
 #ifdef CONFIG_PERF_EVENTS
 int security_perf_event_open(struct perf_event_attr *attr, int type)
 {
-	return call_int_hook(perf_event_open, 0, attr, type);
+	return call_int_hook(perf_event_open, attr, type);
 }
 
 int security_perf_event_alloc(struct perf_event *event)
 {
-	return call_int_hook(perf_event_alloc, 0, event);
+	return call_int_hook(perf_event_alloc, event);
 }
 
 void security_perf_event_free(struct perf_event *event)
@@ -2624,11 +2732,11 @@ void security_perf_event_free(struct perf_event *event)
 
 int security_perf_event_read(struct perf_event *event)
 {
-	return call_int_hook(perf_event_read, 0, event);
+	return call_int_hook(perf_event_read, event);
 }
 
 int security_perf_event_write(struct perf_event *event)
 {
-	return call_int_hook(perf_event_write, 0, event);
+	return call_int_hook(perf_event_write, event);
 }
 #endif /* CONFIG_PERF_EVENTS */
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 90935ed3d8d8..ae71959e7351 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4522,7 +4522,7 @@ static int socket_sockcreate_sid(const struct task_security_struct *tsec,
 
 static int sock_has_perm(struct sock *sk, u32 perms)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
 
@@ -4579,7 +4579,7 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 	isec->initialized = LABEL_INITIALIZED;
 
 	if (sock->sk) {
-		sksec = sock->sk->sk_security;
+		sksec = selinux_sock(sock->sk);
 		sksec->sclass = sclass;
 		sksec->sid = sid;
 		/* Allows detection of the first association on this socket */
@@ -4595,8 +4595,8 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 static int selinux_socket_socketpair(struct socket *socka,
 				     struct socket *sockb)
 {
-	struct sk_security_struct *sksec_a = socka->sk->sk_security;
-	struct sk_security_struct *sksec_b = sockb->sk->sk_security;
+	struct sk_security_struct *sksec_a = selinux_sock(socka->sk);
+	struct sk_security_struct *sksec_b = selinux_sock(sockb->sk);
 
 	sksec_a->peer_sid = sksec_b->sid;
 	sksec_b->peer_sid = sksec_a->sid;
@@ -4608,10 +4608,9 @@ static int selinux_socket_socketpair(struct socket *socka,
    Need to determine whether we should perform a name_bind
    permission check between the socket and the port number. */
 
-static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
+static int __selinux_socket_bind(struct sock *sk, struct sockaddr *address, int addrlen)
 {
-	struct sock *sk = sock->sk;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family;
 	int err;
 
@@ -4746,14 +4745,18 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 	return -EAFNOSUPPORT;
 }
 
+static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
+{
+	return __selinux_socket_bind(sock->sk, address, addrlen);
+}
+
 /* This supports connect(2) and SCTP connect services such as sctp_connectx(3)
  * and sctp_sendmsg(3) as described in Documentation/security/SCTP.rst
  */
-static int selinux_socket_connect_helper(struct socket *sock,
+static int selinux_socket_connect_helper(struct sock *sk,
 					 struct sockaddr *address, int addrlen)
 {
-	struct sock *sk = sock->sk;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	int err;
 
 	err = sock_has_perm(sk, SOCKET__CONNECT);
@@ -4846,7 +4849,7 @@ static int selinux_socket_connect(struct socket *sock,
 	int err;
 	struct sock *sk = sock->sk;
 
-	err = selinux_socket_connect_helper(sock, address, addrlen);
+	err = selinux_socket_connect_helper(sk, address, addrlen);
 	if (err)
 		return err;
 
@@ -4932,9 +4935,9 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 					      struct sock *other,
 					      struct sock *newsk)
 {
-	struct sk_security_struct *sksec_sock = sock->sk_security;
-	struct sk_security_struct *sksec_other = other->sk_security;
-	struct sk_security_struct *sksec_new = newsk->sk_security;
+	struct sk_security_struct *sksec_sock = selinux_sock(sock);
+	struct sk_security_struct *sksec_other = selinux_sock(other);
+	struct sk_security_struct *sksec_new = selinux_sock(newsk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
 	int err;
@@ -4966,8 +4969,8 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 static int selinux_socket_unix_may_send(struct socket *sock,
 					struct socket *other)
 {
-	struct sk_security_struct *ssec = sock->sk->sk_security;
-	struct sk_security_struct *osec = other->sk->sk_security;
+	struct sk_security_struct *ssec = selinux_sock(sock->sk);
+	struct sk_security_struct *osec = selinux_sock(other->sk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
 
@@ -5009,7 +5012,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 				       u16 family)
 {
 	int err = 0;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	u32 sk_sid = sksec->sid;
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
@@ -5042,7 +5045,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
 	int err;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family = sk->sk_family;
 	u32 sk_sid = sksec->sid;
 	struct common_audit_data ad;
@@ -5117,7 +5120,7 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
 	int err = 0;
 	char *scontext = NULL;
 	u32 scontext_len;
-	struct sk_security_struct *sksec = sock->sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sock->sk);
 	u32 peer_sid = SECSID_NULL;
 
 	if (sksec->sclass == SECCLASS_UNIX_STREAM_SOCKET ||
@@ -5175,34 +5178,27 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *
 
 static int selinux_sk_alloc_security(struct sock *sk, int family, gfp_t priority)
 {
-	struct sk_security_struct *sksec;
-
-	sksec = kzalloc(sizeof(*sksec), priority);
-	if (!sksec)
-		return -ENOMEM;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	sksec->peer_sid = SECINITSID_UNLABELED;
 	sksec->sid = SECINITSID_UNLABELED;
 	sksec->sclass = SECCLASS_SOCKET;
 	selinux_netlbl_sk_security_reset(sksec);
-	sk->sk_security = sksec;
 
 	return 0;
 }
 
 static void selinux_sk_free_security(struct sock *sk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
-	sk->sk_security = NULL;
 	selinux_netlbl_sk_security_free(sksec);
-	kfree(sksec);
 }
 
 static void selinux_sk_clone_security(const struct sock *sk, struct sock *newsk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
+	struct sk_security_struct *newsksec = selinux_sock(newsk);
 
 	newsksec->sid = sksec->sid;
 	newsksec->peer_sid = sksec->peer_sid;
@@ -5216,7 +5212,7 @@ static void selinux_sk_getsecid(struct sock *sk, u32 *secid)
 	if (!sk)
 		*secid = SECINITSID_ANY_SOCKET;
 	else {
-		struct sk_security_struct *sksec = sk->sk_security;
+		struct sk_security_struct *sksec = selinux_sock(sk);
 
 		*secid = sksec->sid;
 	}
@@ -5226,7 +5222,7 @@ static void selinux_sock_graft(struct sock *sk, struct socket *parent)
 {
 	struct inode_security_struct *isec =
 		inode_security_novalidate(SOCK_INODE(parent));
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	if (sk->sk_family == PF_INET || sk->sk_family == PF_INET6 ||
 	    sk->sk_family == PF_UNIX)
@@ -5241,7 +5237,7 @@ static void selinux_sock_graft(struct sock *sk, struct socket *parent)
 static int selinux_sctp_assoc_request(struct sctp_endpoint *ep,
 				      struct sk_buff *skb)
 {
-	struct sk_security_struct *sksec = ep->base.sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(ep->base.sk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
 	u8 peerlbl_active;
@@ -5317,13 +5313,11 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 	int len, err = 0, walk_size = 0;
 	void *addr_buf;
 	struct sockaddr *addr;
-	struct socket *sock;
 
 	if (!selinux_policycap_extsockclass())
 		return 0;
 
 	/* Process one or more addresses that may be IPv4 or IPv6 */
-	sock = sk->sk_socket;
 	addr_buf = address;
 
 	while (walk_size < addrlen) {
@@ -5352,14 +5346,14 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 		case SCTP_PRIMARY_ADDR:
 		case SCTP_SET_PEER_PRIMARY_ADDR:
 		case SCTP_SOCKOPT_BINDX_ADD:
-			err = selinux_socket_bind(sock, addr, len);
+			err = __selinux_socket_bind(sk, addr, len);
 			break;
 		/* Connect checks */
 		case SCTP_SOCKOPT_CONNECTX:
 		case SCTP_PARAM_SET_PRIMARY:
 		case SCTP_PARAM_ADD_IP:
 		case SCTP_SENDMSG_CONNECT:
-			err = selinux_socket_connect_helper(sock, addr, len);
+			err = selinux_socket_connect_helper(sk, addr, len);
 			if (err)
 				return err;
 
@@ -5392,8 +5386,8 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 static void selinux_sctp_sk_clone(struct sctp_endpoint *ep, struct sock *sk,
 				  struct sock *newsk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
+	struct sk_security_struct *newsksec = selinux_sock(newsk);
 
 	/* If policy does not support SECCLASS_SCTP_SOCKET then call
 	 * the non-sctp clone version.
@@ -5410,7 +5404,7 @@ static void selinux_sctp_sk_clone(struct sctp_endpoint *ep, struct sock *sk,
 static int selinux_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 				     struct request_sock *req)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	int err;
 	u16 family = req->rsk_ops->family;
 	u32 connsid;
@@ -5431,7 +5425,7 @@ static int selinux_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 static void selinux_inet_csk_clone(struct sock *newsk,
 				   const struct request_sock *req)
 {
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *newsksec = selinux_sock(newsk);
 
 	newsksec->sid = req->secid;
 	newsksec->peer_sid = req->peer_secid;
@@ -5448,7 +5442,7 @@ static void selinux_inet_csk_clone(struct sock *newsk,
 static void selinux_inet_conn_established(struct sock *sk, struct sk_buff *skb)
 {
 	u16 family = sk->sk_family;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	/* handle mapped IPv4 packets arriving via IPv6 sockets */
 	if (family == PF_INET6 && skb->protocol == htons(ETH_P_IP))
@@ -5532,7 +5526,7 @@ static int selinux_tun_dev_attach_queue(void *security)
 static int selinux_tun_dev_attach(struct sock *sk, void *security)
 {
 	struct tun_security_struct *tunsec = security;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	/* we don't currently perform any NetLabel based labeling here and it
 	 * isn't clear that we would want to do so anyway; while we could apply
@@ -5676,7 +5670,7 @@ static unsigned int selinux_ip_output(struct sk_buff *skb,
 			return NF_ACCEPT;
 
 		/* standard practice, label using the parent socket */
-		sksec = sk->sk_security;
+		sksec = selinux_sock(sk);
 		sid = sksec->sid;
 	} else
 		sid = SECINITSID_KERNEL;
@@ -5715,7 +5709,7 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 
 	if (sk == NULL)
 		return NF_ACCEPT;
-	sksec = sk->sk_security;
+	sksec = selinux_sock(sk);
 
 	ad.type = LSM_AUDIT_DATA_NET;
 	ad.u.net = &net;
@@ -5807,7 +5801,7 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb,
 		u32 skb_sid;
 		struct sk_security_struct *sksec;
 
-		sksec = sk->sk_security;
+		sksec = selinux_sock(sk);
 		if (selinux_skb_peerlbl_sid(skb, family, &skb_sid))
 			return NF_DROP;
 		/* At this point, if the returned skb peerlbl is SECSID_NULL
@@ -5836,7 +5830,7 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb,
 	} else {
 		/* Locally generated packet, fetch the security label from the
 		 * associated socket. */
-		struct sk_security_struct *sksec = sk->sk_security;
+		struct sk_security_struct *sksec = selinux_sock(sk);
 		peer_sid = sksec->sid;
 		secmark_perm = PACKET__SEND;
 	}
@@ -5901,7 +5895,7 @@ static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 	unsigned int data_len = skb->len;
 	unsigned char *data = skb->data;
 	struct nlmsghdr *nlh;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 sclass = sksec->sclass;
 	u32 perm;
 
@@ -6927,6 +6921,7 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
 	.lbs_inode = sizeof(struct inode_security_struct),
 	.lbs_ipc = sizeof(struct ipc_security_struct),
 	.lbs_msg_msg = sizeof(struct msg_security_struct),
+	.lbs_sock = sizeof(struct sk_security_struct),
 };
 
 #ifdef CONFIG_PERF_EVENTS
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 330b7b6d44e0..9ca41988281f 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -189,4 +189,9 @@ static inline u32 current_sid(void)
 	return tsec->sid;
 }
 
+static inline struct sk_security_struct *selinux_sock(const struct sock *sock)
+{
+	return sock->sk_security + selinux_blob_sizes.lbs_sock;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index abaab7683840..6a94b31b5472 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -17,6 +17,7 @@
 #include <linux/gfp.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/lsm_hooks.h>
 #include <net/sock.h>
 #include <net/netlabel.h>
 #include <net/ip.h>
@@ -67,7 +68,7 @@ static int selinux_netlbl_sidlookup_cached(struct sk_buff *skb,
 static struct netlbl_lsm_secattr *selinux_netlbl_sock_genattr(struct sock *sk)
 {
 	int rc;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr *secattr;
 
 	if (sksec->nlbl_secattr != NULL)
@@ -100,7 +101,7 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_getattr(
 							const struct sock *sk,
 							u32 sid)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr *secattr = sksec->nlbl_secattr;
 
 	if (secattr == NULL)
@@ -235,7 +236,7 @@ int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
 	 * being labeled by it's parent socket, if it is just exit */
 	sk = skb_to_full_sk(skb);
 	if (sk != NULL) {
-		struct sk_security_struct *sksec = sk->sk_security;
+		struct sk_security_struct *sksec = selinux_sock(sk);
 
 		if (sksec->nlbl_state != NLBL_REQSKB)
 			return 0;
@@ -273,7 +274,7 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_endpoint *ep,
 {
 	int rc;
 	struct netlbl_lsm_secattr secattr;
-	struct sk_security_struct *sksec = ep->base.sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(ep->base.sk);
 	struct sockaddr_in addr4;
 	struct sockaddr_in6 addr6;
 
@@ -352,7 +353,7 @@ int selinux_netlbl_inet_conn_request(struct request_sock *req, u16 family)
  */
 void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	if (family == PF_INET)
 		sksec->nlbl_state = NLBL_LABELED;
@@ -370,8 +371,8 @@ void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
  */
 void selinux_netlbl_sctp_sk_clone(struct sock *sk, struct sock *newsk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
+	struct sk_security_struct *newsksec = selinux_sock(newsk);
 
 	newsksec->nlbl_state = sksec->nlbl_state;
 }
@@ -389,7 +390,7 @@ void selinux_netlbl_sctp_sk_clone(struct sock *sk, struct sock *newsk)
 int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
 {
 	int rc;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr *secattr;
 
 	if (family != PF_INET && family != PF_INET6)
@@ -504,7 +505,7 @@ int selinux_netlbl_socket_setsockopt(struct socket *sock,
 {
 	int rc = 0;
 	struct sock *sk = sock->sk;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr secattr;
 
 	if (selinux_netlbl_option(level, optname) &&
@@ -542,7 +543,7 @@ static int selinux_netlbl_socket_connect_helper(struct sock *sk,
 						struct sockaddr *addr)
 {
 	int rc;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr *secattr;
 
 	/* connected sockets are allowed to disconnect when the address family
@@ -581,7 +582,7 @@ static int selinux_netlbl_socket_connect_helper(struct sock *sk,
 int selinux_netlbl_socket_connect_locked(struct sock *sk,
 					 struct sockaddr *addr)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	if (sksec->nlbl_state != NLBL_REQSKB &&
 	    sksec->nlbl_state != NLBL_CONNLABELED)
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 82cfeab16217..3ef24a266a80 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -718,6 +718,7 @@ static inline void hash_eval(struct hashtab *h, char *hash_name)
 static int policydb_index(struct policydb *p)
 {
 	int i, rc;
+	u32 v;
 
 	if (p->mls_enabled)
 		pr_debug("SELinux:  %d users, %d roles, %d types, %d bools, %d sens, %d cats\n",
@@ -775,6 +776,24 @@ static int policydb_index(struct policydb *p)
 		if (rc)
 			goto out;
 	}
+
+	/*
+	 * A sparse class value is absorbed by policydb_class_isvalid() and
+	 * its siblings, but no such predicate exists for booleans: every
+	 * user of bool_val_to_struct[] walks it by index and dereferences
+	 * each entry -- cond_evaluate_expr(), the two getters and
+	 * security_set_bools() -- so an unclaimed one has no consumer that
+	 * can tolerate it.
+	 */
+	for (v = 0; v < p->p_bools.nprim; v++) {
+		if (!p->bool_val_to_struct[v]) {
+			pr_err("SELinux:  boolean %u is declared but not defined\n",
+			       v + 1);
+			rc = -EINVAL;
+			goto out;
+		}
+	}
+
 	rc = 0;
 out:
 	return rc;
@@ -1337,6 +1356,18 @@ static int class_read(struct policydb *p, struct symtab *s, void *fp)
 			       cladatum->comkey);
 			goto bad;
 		}
+
+		/*
+		 * security_get_permissions() maps the common's permissions
+		 * into an array sized by this class's nprim, so a class must
+		 * declare at least as many as the common it inherits.
+		 */
+		if (cladatum->permissions.nprim <
+		    cladatum->comdatum->permissions.nprim) {
+			pr_err("SELinux:  class %s has fewer permissions than common %s\n",
+			       key, cladatum->comkey);
+			goto bad;
+		}
 	}
 	for (i = 0; i < nel; i++) {
 		rc = perm_read(p, &cladatum->permissions, fp);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 69db4720e2a9..4008aa566f02 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2194,7 +2194,9 @@ void selinux_policy_cancel(struct selinux_state *state,
 	oldpolicy = rcu_dereference_protected(state->policy,
 					lockdep_is_held(&state->policy_mutex));
 
-	sidtab_cancel_convert(oldpolicy->sidtab);
+	/* a first load has no outgoing policy and converted nothing */
+	if (oldpolicy)
+		sidtab_cancel_convert(oldpolicy->sidtab);
 	selinux_policy_free(load_state->policy);
 	kfree(load_state->convert_data);
 }
diff --git a/security/smack/smack.h b/security/smack/smack.h
index b5187915e074..c830d2e111da 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -358,6 +358,11 @@ static inline struct smack_known **smack_ipc(const struct kern_ipc_perm *ipc)
 	return ipc->security + smack_blob_sizes.lbs_ipc;
 }
 
+static inline struct socket_smack *smack_sock(const struct sock *sock)
+{
+	return sock->sk_security + smack_blob_sizes.lbs_sock;
+}
+
 /*
  * Is the directory transmuting?
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index b88bd37a6b3d..074c7ebfffd0 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1469,7 +1469,7 @@ static int smack_inode_getsecurity(struct inode *inode,
 		if (sock == NULL || sock->sk == NULL)
 			return -EOPNOTSUPP;
 
-		ssp = sock->sk->sk_security;
+		ssp = smack_sock(sock->sk);
 
 		if (strcmp(name, XATTR_SMACK_IPIN) == 0)
 			isp = ssp->smk_in;
@@ -1856,7 +1856,7 @@ static int smack_file_receive(struct file *file)
 
 	if (inode->i_sb->s_magic == SOCKFS_MAGIC) {
 		sock = SOCKET_I(inode);
-		ssp = sock->sk->sk_security;
+		ssp = smack_sock(sock->sk);
 		tsp = smack_cred(current_cred());
 		/*
 		 * If the receiving process can't write to the
@@ -2263,11 +2263,7 @@ static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
 static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
 {
 	struct smack_known *skp = smk_of_current();
-	struct socket_smack *ssp;
-
-	ssp = kzalloc(sizeof(struct socket_smack), gfp_flags);
-	if (ssp == NULL)
-		return -ENOMEM;
+	struct socket_smack *ssp = smack_sock(sk);
 
 	/*
 	 * Sockets created by kernel threads receive web label.
@@ -2281,11 +2277,10 @@ static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
 	}
 	ssp->smk_packet = NULL;
 
-	sk->sk_security = ssp;
-
 	return 0;
 }
 
+#ifdef SMACK_IPV6_PORT_LABELING
 /**
  * smack_sk_free_security - Free a socket blob
  * @sk: the socket
@@ -2294,7 +2289,6 @@ static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
  */
 static void smack_sk_free_security(struct sock *sk)
 {
-#ifdef SMACK_IPV6_PORT_LABELING
 	struct smk_port_label *spp;
 
 	if (sk->sk_family == PF_INET6) {
@@ -2307,9 +2301,8 @@ static void smack_sk_free_security(struct sock *sk)
 		}
 		rcu_read_unlock();
 	}
-#endif
-	kfree(sk->sk_security);
 }
+#endif
 
 /**
 * smack_ipv4host_label - check host based restrictions
@@ -2422,7 +2415,7 @@ static struct smack_known *smack_ipv6host_label(struct sockaddr_in6 *sip)
  */
 static int smack_netlbl_add(struct sock *sk)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp = ssp->smk_out;
 	int rc;
 
@@ -2454,7 +2447,7 @@ static int smack_netlbl_add(struct sock *sk)
  */
 static void smack_netlbl_delete(struct sock *sk)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 
 	/*
 	 * Take the label off the socket if one is set.
@@ -2486,7 +2479,7 @@ static int smk_ipv4_check(struct sock *sk, struct sockaddr_in *sap)
 	struct smack_known *skp;
 	int rc = 0;
 	struct smack_known *hkp;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smk_audit_info ad;
 
 	rcu_read_lock();
@@ -2559,7 +2552,7 @@ static void smk_ipv6_port_label(struct socket *sock, struct sockaddr *address)
 {
 	struct sock *sk = sock->sk;
 	struct sockaddr_in6 *addr6;
-	struct socket_smack *ssp = sock->sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sock->sk);
 	struct smk_port_label *spp;
 	unsigned short port = 0;
 
@@ -2648,7 +2641,7 @@ static int smk_ipv6_port_check(struct sock *sk, struct sockaddr_in6 *address,
 				int act)
 {
 	struct smk_port_label *spp;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp = NULL;
 	unsigned short port;
 	struct smack_known *object;
@@ -2750,7 +2743,7 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 	if (sock == NULL || sock->sk == NULL)
 		return -EOPNOTSUPP;
 
-	ssp = sock->sk->sk_security;
+	ssp = smack_sock(sock->sk);
 
 	if (strcmp(name, XATTR_SMACK_IPIN) == 0)
 		ssp->smk_in = skp;
@@ -2798,7 +2791,7 @@ static int smack_socket_post_create(struct socket *sock, int family,
 	 * Sockets created by kernel threads receive web label.
 	 */
 	if (unlikely(current->flags & PF_KTHREAD)) {
-		ssp = sock->sk->sk_security;
+		ssp = smack_sock(sock->sk);
 		ssp->smk_in = &smack_known_web;
 		ssp->smk_out = &smack_known_web;
 	}
@@ -2823,8 +2816,8 @@ static int smack_socket_post_create(struct socket *sock, int family,
 static int smack_socket_socketpair(struct socket *socka,
 		                   struct socket *sockb)
 {
-	struct socket_smack *asp = socka->sk->sk_security;
-	struct socket_smack *bsp = sockb->sk->sk_security;
+	struct socket_smack *asp = smack_sock(socka->sk);
+	struct socket_smack *bsp = smack_sock(sockb->sk);
 
 	asp->smk_packet = bsp->smk_out;
 	bsp->smk_packet = asp->smk_out;
@@ -2887,7 +2880,7 @@ static int smack_socket_connect(struct socket *sock, struct sockaddr *sap,
 		if (__is_defined(SMACK_IPV6_SECMARK_LABELING))
 			rsp = smack_ipv6host_label(sip);
 		if (rsp != NULL) {
-			struct socket_smack *ssp = sock->sk->sk_security;
+			struct socket_smack *ssp = smack_sock(sock->sk);
 
 			rc = smk_ipv6_check(ssp->smk_out, rsp, sip,
 					    SMK_CONNECTING);
@@ -3628,9 +3621,9 @@ static int smack_unix_stream_connect(struct sock *sock,
 {
 	struct smack_known *skp;
 	struct smack_known *okp;
-	struct socket_smack *ssp = sock->sk_security;
-	struct socket_smack *osp = other->sk_security;
-	struct socket_smack *nsp = newsk->sk_security;
+	struct socket_smack *ssp = smack_sock(sock);
+	struct socket_smack *osp = smack_sock(other);
+	struct socket_smack *nsp = smack_sock(newsk);
 	struct smk_audit_info ad;
 	int rc = 0;
 #ifdef CONFIG_AUDIT
@@ -3682,8 +3675,8 @@ static int smack_unix_stream_connect(struct sock *sock,
  */
 static int smack_unix_may_send(struct socket *sock, struct socket *other)
 {
-	struct socket_smack *ssp = sock->sk->sk_security;
-	struct socket_smack *osp = other->sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sock->sk);
+	struct socket_smack *osp = smack_sock(other->sk);
 	struct smk_audit_info ad;
 	int rc;
 
@@ -3720,7 +3713,7 @@ static int smack_socket_sendmsg(struct socket *sock, struct msghdr *msg,
 	struct sockaddr_in6 *sap = (struct sockaddr_in6 *) msg->msg_name;
 #endif
 #ifdef SMACK_IPV6_SECMARK_LABELING
-	struct socket_smack *ssp = sock->sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sock->sk);
 	struct smack_known *rsp;
 #endif
 	int rc = 0;
@@ -3933,7 +3926,7 @@ static struct smack_known *smack_from_netlbl(struct sock *sk, u16 family,
 	netlbl_secattr_init(&secattr);
 
 	if (sk)
-		ssp = sk->sk_security;
+		ssp = smack_sock(sk);
 
 	if (netlbl_skbuff_getattr(skb, family, &secattr) == 0) {
 		skp = smack_from_secattr(&secattr, ssp);
@@ -3955,7 +3948,7 @@ static struct smack_known *smack_from_netlbl(struct sock *sk, u16 family,
  */
 static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp = NULL;
 	int rc = 0;
 	struct smk_audit_info ad;
@@ -4059,7 +4052,7 @@ static int smack_socket_getpeersec_stream(struct socket *sock,
 	u32 slen = 1;
 	int rc = 0;
 
-	ssp = sock->sk->sk_security;
+	ssp = smack_sock(sock->sk);
 	if (ssp->smk_packet != NULL) {
 		rcp = ssp->smk_packet->smk_known;
 		slen = strlen(rcp) + 1;
@@ -4109,7 +4102,7 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 
 	switch (family) {
 	case PF_UNIX:
-		ssp = sock->sk->sk_security;
+		ssp = smack_sock(sock->sk);
 		s = ssp->smk_out->smk_secid;
 		break;
 	case PF_INET:
@@ -4158,7 +4151,7 @@ static void smack_sock_graft(struct sock *sk, struct socket *parent)
 	    (sk->sk_family != PF_INET && sk->sk_family != PF_INET6))
 		return;
 
-	ssp = sk->sk_security;
+	ssp = smack_sock(sk);
 	ssp->smk_in = skp;
 	ssp->smk_out = skp;
 	/* cssp->smk_packet is already set in smack_inet_csk_clone() */
@@ -4178,7 +4171,7 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 {
 	u16 family = sk->sk_family;
 	struct smack_known *skp;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct sockaddr_in addr;
 	struct iphdr *hdr;
 	struct smack_known *hskp;
@@ -4264,7 +4257,7 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 static void smack_inet_csk_clone(struct sock *sk,
 				 const struct request_sock *req)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp;
 
 	if (req->peer_secid != 0) {
@@ -4761,6 +4754,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 	.lbs_inode = sizeof(struct inode_smack),
 	.lbs_ipc = sizeof(struct smack_known *),
 	.lbs_msg_msg = sizeof(struct smack_known *),
+	.lbs_sock = sizeof(struct socket_smack),
 };
 
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
@@ -4871,7 +4865,9 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(socket_getpeersec_stream, smack_socket_getpeersec_stream),
 	LSM_HOOK_INIT(socket_getpeersec_dgram, smack_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sk_alloc_security, smack_sk_alloc_security),
+#ifdef SMACK_IPV6_PORT_LABELING
 	LSM_HOOK_INIT(sk_free_security, smack_sk_free_security),
+#endif
 	LSM_HOOK_INIT(sock_graft, smack_sock_graft),
 	LSM_HOOK_INIT(inet_conn_request, smack_inet_conn_request),
 	LSM_HOOK_INIT(inet_csk_clone, smack_inet_csk_clone),
diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index fc7399b45373..2648856c47e9 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -28,8 +28,8 @@ static unsigned int smack_ipv6_output(void *priv,
 	struct socket_smack *ssp;
 	struct smack_known *skp;
 
-	if (sk && sk->sk_security) {
-		ssp = sk->sk_security;
+	if (sk) {
+		ssp = smack_sock(sk);
 		skp = ssp->smk_out;
 		skb->secmark = skp->smk_secid;
 	}
@@ -46,8 +46,8 @@ static unsigned int smack_ipv4_output(void *priv,
 	struct socket_smack *ssp;
 	struct smack_known *skp;
 
-	if (sk && sk->sk_security) {
-		ssp = sk->sk_security;
+	if (sk) {
+		ssp = smack_sock(sk);
 		skp = ssp->smk_out;
 		skb->secmark = skp->smk_secid;
 	}
diff --git a/sound/core/seq/seq_timer.c b/sound/core/seq/seq_timer.c
index 9863be6fd43e..50581120f282 100644
--- a/sound/core/seq/seq_timer.c
+++ b/sound/core/seq/seq_timer.c
@@ -58,12 +58,23 @@ struct snd_seq_timer *snd_seq_timer_new(void)
 void snd_seq_timer_delete(struct snd_seq_timer **tmr)
 {
 	struct snd_seq_timer *t = *tmr;
-	*tmr = NULL;
+	struct snd_timer_instance *ti;
 
 	if (t == NULL) {
 		pr_debug("ALSA: seq: snd_seq_timer_delete() called with NULL timer\n");
 		return;
 	}
+
+	spin_lock_irq(&t->lock);
+	ti = t->timeri;
+	t->timeri = NULL;
+	spin_unlock_irq(&t->lock);
+	if (ti) {
+		snd_timer_close(ti);
+		snd_timer_instance_free(ti);
+	}
+
+	*tmr = NULL;
 	t->running = 0;
 
 	/* reset time */
diff --git a/sound/hda/hdac_regmap.c b/sound/hda/hdac_regmap.c
index bf35acca5ea0..5c7ac8e8de0d 100644
--- a/sound/hda/hdac_regmap.c
+++ b/sound/hda/hdac_regmap.c
@@ -215,7 +215,7 @@ static int hda_reg_read_coef(struct hdac_device *codec, unsigned int reg,
 	err = snd_hdac_exec_verb(codec, verb, 0, NULL);
 	if (err < 0)
 		return err;
-	verb = (reg & ~0xfffff) | (AC_VERB_GET_COEF_INDEX << 8);
+	verb = (reg & ~0xfffff) | (AC_VERB_GET_PROC_COEF << 8);
 	return snd_hdac_exec_verb(codec, verb, 0, val);
 }
 
@@ -233,7 +233,7 @@ static int hda_reg_write_coef(struct hdac_device *codec, unsigned int reg,
 	err = snd_hdac_exec_verb(codec, verb, 0, NULL);
 	if (err < 0)
 		return err;
-	verb = (reg & ~0xfffff) | (AC_VERB_GET_COEF_INDEX << 8) |
+	verb = (reg & ~0xfffff) | (AC_VERB_SET_PROC_COEF << 8) |
 		(val & 0xffff);
 	return snd_hdac_exec_verb(codec, verb, 0, NULL);
 }
diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
index 36b9e4fab099..287d8d734e44 100644
--- a/sound/soc/codecs/cs4265.c
+++ b/sound/soc/codecs/cs4265.c
@@ -46,11 +46,11 @@ static const struct reg_default cs4265_reg_defaults[] = {
 	{ CS4265_DAC_CHA_VOL, 0x00 },
 	{ CS4265_DAC_CHB_VOL, 0x00 },
 	{ CS4265_DAC_CTL2, 0xC0 },
-	{ CS4265_SPDIF_CTL1, 0x00 },
-	{ CS4265_SPDIF_CTL2, 0x00 },
 	{ CS4265_INT_MASK, 0x00 },
 	{ CS4265_STATUS_MODE_MSB, 0x00 },
 	{ CS4265_STATUS_MODE_LSB, 0x00 },
+	{ CS4265_SPDIF_CTL1, 0x00 },
+	{ CS4265_SPDIF_CTL2, 0x00 },
 };
 
 static bool cs4265_readable_register(struct device *dev, unsigned int reg)
diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
index 14e77df06b01..03936c85541c 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -1143,17 +1143,21 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	/* enable clock for regcache get default value from hw */
 	afe_priv->pm_runtime_bypass_reg_ctl = true;
-	pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret) {
+		afe_priv->pm_runtime_bypass_reg_ctl = false;
+		goto err_pm_disable;
+	}
 
 	ret = regmap_reinit_cache(afe->regmap, &mt8183_afe_regmap_config);
+	pm_runtime_put_sync(dev);
+	afe_priv->pm_runtime_bypass_reg_ctl = false;
+
 	if (ret) {
 		dev_err(dev, "regmap_reinit_cache fail, ret %d\n", ret);
 		goto err_pm_disable;
 	}
 
-	pm_runtime_put_sync(&pdev->dev);
-	afe_priv->pm_runtime_bypass_reg_ctl = false;
-
 	regcache_cache_only(afe->regmap, true);
 	regcache_mark_dirty(afe->regmap);
 
diff --git a/sound/soc/xilinx/xlnx_formatter_pcm.c b/sound/soc/xilinx/xlnx_formatter_pcm.c
index 5c4158069a5a..dccc056e0e0a 100644
--- a/sound/soc/xilinx/xlnx_formatter_pcm.c
+++ b/sound/soc/xilinx/xlnx_formatter_pcm.c
@@ -281,8 +281,7 @@ static irqreturn_t xlnx_mm2s_irq_handler(int irq, void *arg)
 {
 	u32 val;
 	void __iomem *reg;
-	struct device *dev = arg;
-	struct xlnx_pcm_drv_data *adata = dev_get_drvdata(dev);
+	struct xlnx_pcm_drv_data *adata = arg;
 
 	reg = adata->mmio + XLNX_MM2S_OFFSET + XLNX_AUD_STS;
 	val = readl(reg);
@@ -300,8 +299,7 @@ static irqreturn_t xlnx_s2mm_irq_handler(int irq, void *arg)
 {
 	u32 val;
 	void __iomem *reg;
-	struct device *dev = arg;
-	struct xlnx_pcm_drv_data *adata = dev_get_drvdata(dev);
+	struct xlnx_pcm_drv_data *adata = arg;
 
 	reg = adata->mmio + XLNX_S2MM_OFFSET + XLNX_AUD_STS;
 	val = readl(reg);
@@ -637,7 +635,7 @@ static int xlnx_formatter_pcm_probe(struct platform_device *pdev)
 		}
 		ret = devm_request_irq(dev, aud_drv_data->mm2s_irq,
 				       xlnx_mm2s_irq_handler, 0,
-				       "xlnx_formatter_pcm_mm2s_irq", dev);
+				       "xlnx_formatter_pcm_mm2s_irq", aud_drv_data);
 		if (ret) {
 			dev_err(dev, "xlnx audio mm2s irq request failed\n");
 			goto clk_err;
@@ -664,7 +662,7 @@ static int xlnx_formatter_pcm_probe(struct platform_device *pdev)
 		ret = devm_request_irq(dev, aud_drv_data->s2mm_irq,
 				       xlnx_s2mm_irq_handler, 0,
 				       "xlnx_formatter_pcm_s2mm_irq",
-				       dev);
+				       aud_drv_data);
 		if (ret) {
 			dev_err(dev, "xlnx audio s2mm irq request failed\n");
 			goto clk_err;
diff --git a/sound/usb/usx2y/usX2Yhwdep.c b/sound/usb/usx2y/usX2Yhwdep.c
index 2d4e943be2da..eeafe580d038 100644
--- a/sound/usb/usx2y/usX2Yhwdep.c
+++ b/sound/usb/usx2y/usX2Yhwdep.c
@@ -29,6 +29,8 @@ static vm_fault_t snd_us428ctls_vm_fault(struct vm_fault *vmf)
 		   vmf->pgoff);
 
 	offset = vmf->pgoff << PAGE_SHIFT;
+	if (offset >= US428_SHAREDMEM_PAGES)
+		return VM_FAULT_SIGBUS;
 	vaddr = (char *)((struct usx2ydev *)vmf->vma->vm_private_data)->us428ctls_sharedmem + offset;
 	page = virt_to_page(vaddr);
 	get_page(page);
@@ -55,17 +57,17 @@ static int snd_us428ctls_mmap(struct snd_hwdep *hw, struct file *filp, struct vm
 		return -EBUSY;
 
 	/* if userspace tries to mmap beyond end of our buffer, fail */
-	if (size > PAGE_ALIGN(sizeof(struct us428ctls_sharedmem))) {
-		snd_printd("%lu > %lu\n", size, (unsigned long)sizeof(struct us428ctls_sharedmem));
+	if (size > US428_SHAREDMEM_PAGES) {
+		snd_printd("%lu > %lu\n", size, (unsigned long)US428_SHAREDMEM_PAGES);
 		return -EINVAL;
 	}
 
 	if (!us428->us428ctls_sharedmem) {
 		init_waitqueue_head(&us428->us428ctls_wait_queue_head);
-		us428->us428ctls_sharedmem = alloc_pages_exact(sizeof(struct us428ctls_sharedmem), GFP_KERNEL);
+		us428->us428ctls_sharedmem = alloc_pages_exact(US428_SHAREDMEM_PAGES, GFP_KERNEL);
 		if (!us428->us428ctls_sharedmem)
 			return -ENOMEM;
-		memset(us428->us428ctls_sharedmem, -1, sizeof(struct us428ctls_sharedmem));
+		memset(us428->us428ctls_sharedmem, -1, US428_SHAREDMEM_PAGES);
 		us428->us428ctls_sharedmem->ctl_snapshot_last = -2;
 	}
 	area->vm_ops = &us428ctls_vm_ops;
diff --git a/sound/usb/usx2y/usbus428ctldefs.h b/sound/usb/usx2y/usbus428ctldefs.h
index 06b27d23d3c2..9ba15d974e63 100644
--- a/sound/usb/usx2y/usbus428ctldefs.h
+++ b/sound/usb/usx2y/usbus428ctldefs.h
@@ -89,3 +89,5 @@ struct us428ctls_sharedmem {
 	struct us428_p4out	p4out[N_US428_P4OUT_BUFS];
 	int			p4out_last, p4out_sent;
 };
+
+#define US428_SHAREDMEM_PAGES	PAGE_ALIGN(sizeof(struct us428ctls_sharedmem))
diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index 34d5f5379632..ac584795606c 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -376,7 +376,7 @@ static void snd_usx2y_card_private_free(struct snd_card *card)
 	usb_free_urb(usx2y->in04_urb);
 	if (usx2y->us428ctls_sharedmem)
 		free_pages_exact(usx2y->us428ctls_sharedmem,
-				 sizeof(*usx2y->us428ctls_sharedmem));
+				 US428_SHAREDMEM_PAGES);
 	if (usx2y->card_index >= 0 && usx2y->card_index < SNDRV_CARDS)
 		snd_usx2y_card_used[usx2y->card_index] = 0;
 }
diff --git a/sound/usb/usx2y/usx2yhwdeppcm.c b/sound/usb/usx2y/usx2yhwdeppcm.c
index 9219341d71c7..3f6e87f30f7e 100644
--- a/sound/usb/usx2y/usx2yhwdeppcm.c
+++ b/sound/usb/usx2y/usx2yhwdeppcm.c
@@ -485,6 +485,9 @@ static int usx2y_usbpcm_urbs_start(struct snd_usx2y_substream *subs)
 	return err;
 }
 
+#define USX2Y_HWDEP_PCM_PAGES	\
+	PAGE_ALIGN(sizeof(struct snd_usx2y_hwdep_pcm_shm))
+
 /*
  * prepare callback
  *
@@ -501,11 +504,11 @@ static int snd_usx2y_usbpcm_prepare(struct snd_pcm_substream *substream)
 	snd_printdd("snd_usx2y_pcm_prepare(%p)\n", substream);
 
 	if (!usx2y->hwdep_pcm_shm) {
-		usx2y->hwdep_pcm_shm = alloc_pages_exact(sizeof(struct snd_usx2y_hwdep_pcm_shm),
+		usx2y->hwdep_pcm_shm = alloc_pages_exact(USX2Y_HWDEP_PCM_PAGES,
 							 GFP_KERNEL);
 		if (!usx2y->hwdep_pcm_shm)
 			return -ENOMEM;
-		memset(usx2y->hwdep_pcm_shm, 0, sizeof(struct snd_usx2y_hwdep_pcm_shm));
+		memset(usx2y->hwdep_pcm_shm, 0, USX2Y_HWDEP_PCM_PAGES);
 	}
 
 	mutex_lock(&usx2y->pcm_mutex);
@@ -671,6 +674,8 @@ static vm_fault_t snd_usx2y_hwdep_pcm_vm_fault(struct vm_fault *vmf)
 	void *vaddr;
 
 	offset = vmf->pgoff << PAGE_SHIFT;
+	if (offset >= USX2Y_HWDEP_PCM_PAGES)
+		return VM_FAULT_SIGBUS;
 	vaddr = (char *)((struct usx2ydev *)vmf->vma->vm_private_data)->hwdep_pcm_shm + offset;
 	vmf->page = virt_to_page(vaddr);
 	get_page(vmf->page);
@@ -692,8 +697,8 @@ static int snd_usx2y_hwdep_pcm_mmap(struct snd_hwdep *hw, struct file *filp, str
 		return -EBUSY;
 
 	/* if userspace tries to mmap beyond end of our buffer, fail */
-	if (size > PAGE_ALIGN(sizeof(struct snd_usx2y_hwdep_pcm_shm))) {
-		snd_printd("%lu > %lu\n", size, (unsigned long)sizeof(struct snd_usx2y_hwdep_pcm_shm));
+	if (size > USX2Y_HWDEP_PCM_PAGES) {
+		snd_printd("%lu > %lu\n", size, (unsigned long)USX2Y_HWDEP_PCM_PAGES);
 		return -EINVAL;
 	}
 
@@ -711,7 +716,7 @@ static void snd_usx2y_hwdep_pcm_private_free(struct snd_hwdep *hwdep)
 	struct usx2ydev *usx2y = hwdep->private_data;
 
 	if (usx2y->hwdep_pcm_shm)
-		free_pages_exact(usx2y->hwdep_pcm_shm, sizeof(struct snd_usx2y_hwdep_pcm_shm));
+		free_pages_exact(usx2y->hwdep_pcm_shm, USX2Y_HWDEP_PCM_PAGES);
 }
 
 int usx2y_hwdep_pcm_new(struct snd_card *card)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b340be2d81a3..ae961d487f94 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3366,7 +3366,10 @@ static long kvm_vcpu_ioctl(struct file *filp,
 				synchronize_rcu();
 			put_pid(oldpid);
 		}
+		vcpu->wants_to_run = !READ_ONCE(vcpu->run->immediate_exit);
 		r = kvm_arch_vcpu_ioctl_run(vcpu);
+		vcpu->wants_to_run = false;
+
 		trace_kvm_userspace_exit(vcpu->run->exit_reason, r);
 		break;
 	}
