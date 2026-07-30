Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D945E42DA26
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439784; cv=none; b=Q8aqg0CjMdhvk4ZdA1/aaSdrolKv0UoHRWaidVoP0aYOg/o9i7BnKng+5TEVGP8Ke97d+/lBPF2t6jRrTqV8jp4BSZ2F23pFypgTbVcLbZ8Enzrv+mb76HGDPaEG4NkOWYnKhAfv5R6J+NkjHjr1jvvWpO5/vzfSO/zPK4tMbRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439784; c=relaxed/simple;
	bh=T0Wk0SqlRraVGHlb8KwkwJ17mGuoYmE675MAGTaVTJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wnn7eDlPF4zK1sKK+5pvUYDj8djdGu/ZgOQt+4h3SEdKHdzirJmBLK6vUf+w5jiI7MZW2p7JkJJb95eBGW7MOYpBFoaP1SDecCB65jBmi3RFzFrVdjerRp70mAr3Jm+L1RrFFvVxXVsr3KBd3w783giSIVV1UxWTAkg148u0hbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8o/mV/T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8o/mV/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6D21F00A3A;
	Thu, 30 Jul 2026 19:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785439780;
	bh=WdVEUzNR7OT+9fB0B0xhj18eF6Ia9UIOMOazdV1IMO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M8o/mV/T1DN2eyNjY/rfy9O15L9xRDBDo7EqM0aBOPrJl3MZ6gieepIwUiWYxCG/P
	 YB9rfwwoHZjow8JikwrZ9kdIW++A29joxEQBmMhxRJsrZAJEytzf4cxL95W+BkWlZG
	 hFrk85L0GgXgNxe2RDu/00Xp8MOSr8mR21r9wHRYNhYL3V/j6MR4fbynEEGpclwSfp
	 zLQsvRnHwkjBFbLYeXowjg3AYiqsL5VDpyGkqTRqNQ4m27GPWFSkQ6++KJlYEWq0lc
	 Sf09DGZT8r01ONKKHpW1ZPpDHuTixVo+84emY8iruDIn3jj8jLXDNjBIi2NC/DRdpg
	 jUu7E2PX4HVVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/5] KVM: x86: Move "apicv_active" into "struct kvm_lapic"
Date: Thu, 30 Jul 2026 15:29:35 -0400
Message-ID: <20260730192937.3123765-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730192937.3123765-1-sashal@kernel.org>
References: <2026072512-swept-john-385a@gregkh>
 <20260730192937.3123765-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit ce0a58f4756c14d7646cfdf279dbaada9d7712a0 ]

Move the per-vCPU apicv_active flag into KVM's local APIC instance.
APICv is fully dependent on an in-kernel local APIC, but that's not at
all clear when reading the current code due to the flag being stored in
the generic kvm_vcpu_arch struct.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20220614230548.3852141-5-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: e800decd9c0a ("KVM: x86: Only reset TSC Deadline Timer in apic_timer_expired on KVM_RUN")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/lapic.c            | 31 ++++++++++---------------------
 arch/x86/kvm/lapic.h            |  3 ++-
 arch/x86/kvm/svm/avic.c         |  2 +-
 arch/x86/kvm/vmx/vmx.c          |  7 ++++---
 arch/x86/kvm/x86.c              | 12 ++++++------
 6 files changed, 23 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 38ede873d1f5..d13db9173603 100644
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
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index d5aafddc3b57..37042ad41c1a 100644
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
@@ -507,19 +503,15 @@ EXPORT_SYMBOL_GPL(kvm_apic_clear_irr);
 
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
+	if (unlikely(apic->apicv_active))
 		kvm_x86_ops.hwapic_isr_update(vec);
 	else {
 		++apic->isr_count;
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
@@ -567,7 +556,7 @@ static inline void apic_clear_isr(int vec, struct kvm_lapic *apic)
 	 * on the other hand isr_count and highest_isr_cache are unused
 	 * and must be left alone.
 	 */
-	if (unlikely(vcpu->arch.apicv_active))
+	if (unlikely(apic->apicv_active))
 		kvm_x86_ops.hwapic_isr_update(apic_find_highest_isr(apic));
 	else {
 		--apic->isr_count;
@@ -706,7 +695,7 @@ static void pv_eoi_clr_pending(struct kvm_vcpu *vcpu)
 static int apic_has_interrupt_for_ppr(struct kvm_lapic *apic, u32 ppr)
 {
 	int highest_irr;
-	if (apic->vcpu->arch.apicv_active)
+	if (apic->apicv_active)
 		highest_irr = kvm_x86_ops.sync_pir_to_irr(apic->vcpu);
 	else
 		highest_irr = apic_find_highest_irr(apic);
@@ -1538,7 +1527,7 @@ static bool lapic_timer_int_injected(struct kvm_vcpu *vcpu)
 		int vec = reg & APIC_VECTOR_MASK;
 		void *bitmap = apic->regs + APIC_ISR;
 
-		if (vcpu->arch.apicv_active)
+		if (apic->apicv_active)
 			bitmap = apic->regs + APIC_IRR;
 
 		if (apic_test_vector(vec, bitmap))
@@ -1647,7 +1636,7 @@ static void apic_timer_expired(struct kvm_lapic *apic, bool from_timer_fn)
 	if (apic_lvtt_tscdeadline(apic) || ktimer->hv_timer_in_use)
 		ktimer->expired_tscdeadline = ktimer->tscdeadline;
 
-	if (!from_timer_fn && vcpu->arch.apicv_active) {
+	if (!from_timer_fn && apic->apicv_active) {
 		WARN_ON(kvm_get_running_vcpu() != vcpu);
 		kvm_apic_inject_pending_timer_irqs(apic);
 		return;
@@ -2317,7 +2306,7 @@ void kvm_apic_update_apicv(struct kvm_vcpu *vcpu)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
 
-	if (vcpu->arch.apicv_active) {
+	if (apic->apicv_active) {
 		/* irr_pending is always true when apicv is activated. */
 		apic->irr_pending = true;
 		apic->isr_count = 1;
@@ -2379,7 +2368,7 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
 				vcpu->arch.apic_base | MSR_IA32_APICBASE_BSP);
 	vcpu->arch.pv_eoi.msr_val = 0;
 	apic_update_ppr(apic);
-	if (vcpu->arch.apicv_active) {
+	if (apic->apicv_active) {
 		kvm_x86_ops.apicv_post_state_restore(vcpu);
 		kvm_x86_ops.hwapic_irr_update(vcpu, -1);
 		kvm_x86_ops.hwapic_isr_update(-1);
@@ -2646,7 +2635,7 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
 	__start_apic_timer(apic, APIC_TMCCT);
 	kvm_apic_update_apicv(vcpu);
 	apic->highest_isr_cache = -1;
-	if (vcpu->arch.apicv_active) {
+	if (apic->apicv_active) {
 		kvm_x86_ops.apicv_post_state_restore(vcpu);
 		kvm_x86_ops.hwapic_irr_update(vcpu,
 				apic_find_highest_irr(apic));
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
index 0ed2fc0f9713..6f01a29aeec5 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -673,7 +673,7 @@ void svm_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
 
 int svm_deliver_avic_intr(struct kvm_vcpu *vcpu, int vec)
 {
-	if (!vcpu->arch.apicv_active)
+	if (!kvm_vcpu_apicv_active(vcpu))
 		return -1;
 
 	kvm_lapic_set_irr(vec, vcpu->arch.apic);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index edc1a71d0160..0fb9cdc01212 100644
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
index c490f4005149..f9cfba9ec644 100644
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
@@ -10254,7 +10254,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 		if (r < 0)
 			goto fail_mmu_destroy;
 		if (kvm_apicv_activated(vcpu->kvm))
-			vcpu->arch.apicv_active = true;
+			vcpu->arch.apic->apicv_active = true;
 	} else
 		static_key_slow_inc(&kvm_no_apic_vcpu);
 
-- 
2.53.0

