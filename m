Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B461045FFC7
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439783; cv=none; b=Uy3vB3D9Z5SOW7VtkPRWcCozwDgSsUwb8JB9iAvtRHP9M5s4ZF7Wa57vl0jRKfgov4wAEgc/r4GBWW98T49DTy1+dYJohiOmuR8JZZ1WlHElG6rfuknf6Ghft8C03kNK48DJzu/wtHMf0YpD0SCRTzPCcR45L1UM3SFk3McoSXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439783; c=relaxed/simple;
	bh=Lxk0jnGxGpBXrZ1TTkCHjZ3l88llwWnvwJX4xS21kMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rz+ZLkk3lFM070UTD1RsbOvUL9S16QApih0GaG5q7TnwEfBIX5SCETrX/uuvULrC2oRMO+QTb7T+cUoF94TpItpRpZdTtjTNA8JGoRz6i15LOhc0IJwRn8XS2b8FNHyGxgXTtuzGRK1ySbqocSf6CiImtCYUg3GHStQHBWAYQKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9NwF04l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9NwF04l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3AB1F000E9;
	Thu, 30 Jul 2026 19:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785439779;
	bh=f7lsEuUS4sH7AD40HafdqZj1VwBvc8qzEqw8xOz0C3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n9NwF04lBbQ+Jdj7T9PTMp1aAZ/ShYjoHLPGfnc9tCnsenoJ9RPh0erUuOxu+OrA+
	 kZDJVZMm8yJ9FPEWhpk4nqPhqu5D4lsdMxKpQgq1rA60knQK085K6oRCssI0e9ZS21
	 xuModJIHNzbJ52JRURbagqyyNppJc5RvyBCKvjH76GeKnEM/yBFfUUxUG6d0sWL/FV
	 Nb7WM/oO6Tbs3aazDFMMPR5pwhZdkm36Ie4TX49jizgRBXnJUi4MSKZT/VHzAneNfg
	 kh1bzN/87nTYBNHqob+/d+UbbK6iBTg3+M8u3N1aoaaP9Q6yD26M/NeOA6icwMSMui
	 X7IWAvhrqriSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/5] KVM: x86: Drop @vcpu parameter from kvm_x86_ops.hwapic_isr_update()
Date: Thu, 30 Jul 2026 15:29:33 -0400
Message-ID: <20260730192937.3123765-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072512-swept-john-385a@gregkh>
References: <2026072512-swept-john-385a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit d39850f57d2102c6b46feb21237bc23bc42de4f7 ]

Drop the unused @vcpu parameter from hwapic_isr_update().  AMD/AVIC is
unlikely to implement the helper, and VMX/APICv doesn't need the vCPU as
it operates on the current VMCS.  The result is somewhat odd, but allows
for a decent amount of (future) cleanup in the APIC code.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20220614230548.3852141-3-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: e800decd9c0a ("KVM: x86: Only reset TSC Deadline Timer in apic_timer_expired on KVM_RUN")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/lapic.c            | 10 ++++------
 arch/x86/kvm/svm/avic.c         |  2 +-
 arch/x86/kvm/svm/svm.h          |  2 +-
 arch/x86/kvm/vmx/vmx.c          |  2 +-
 5 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3e9f1c820edb..38ede873d1f5 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1179,7 +1179,7 @@ struct kvm_x86_ops {
 	void (*pre_update_apicv_exec_ctrl)(struct kvm *kvm, bool activate);
 	void (*refresh_apicv_exec_ctrl)(struct kvm_vcpu *vcpu);
 	void (*hwapic_irr_update)(struct kvm_vcpu *vcpu, int max_irr);
-	void (*hwapic_isr_update)(struct kvm_vcpu *vcpu, int isr);
+	void (*hwapic_isr_update)(int isr);
 	bool (*guest_apic_has_interrupt)(struct kvm_vcpu *vcpu);
 	void (*load_eoi_exitmap)(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
 	void (*set_virtual_apic_mode)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 79679dd7ec86..d5aafddc3b57 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -520,7 +520,7 @@ static inline void apic_set_isr(int vec, struct kvm_lapic *apic)
 	 * just set SVI.
 	 */
 	if (unlikely(vcpu->arch.apicv_active))
-		kvm_x86_ops.hwapic_isr_update(vcpu, vec);
+		kvm_x86_ops.hwapic_isr_update(vec);
 	else {
 		++apic->isr_count;
 		BUG_ON(apic->isr_count > MAX_APIC_VECTOR);
@@ -568,8 +568,7 @@ static inline void apic_clear_isr(int vec, struct kvm_lapic *apic)
 	 * and must be left alone.
 	 */
 	if (unlikely(vcpu->arch.apicv_active))
-		kvm_x86_ops.hwapic_isr_update(vcpu,
-					       apic_find_highest_isr(apic));
+		kvm_x86_ops.hwapic_isr_update(apic_find_highest_isr(apic));
 	else {
 		--apic->isr_count;
 		BUG_ON(apic->isr_count < 0);
@@ -2383,7 +2382,7 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
 	if (vcpu->arch.apicv_active) {
 		kvm_x86_ops.apicv_post_state_restore(vcpu);
 		kvm_x86_ops.hwapic_irr_update(vcpu, -1);
-		kvm_x86_ops.hwapic_isr_update(vcpu, -1);
+		kvm_x86_ops.hwapic_isr_update(-1);
 	}
 
 	vcpu->arch.apic_arb_prio = 0;
@@ -2651,8 +2650,7 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
 		kvm_x86_ops.apicv_post_state_restore(vcpu);
 		kvm_x86_ops.hwapic_irr_update(vcpu,
 				apic_find_highest_irr(apic));
-		kvm_x86_ops.hwapic_isr_update(vcpu,
-				apic_find_highest_isr(apic));
+		kvm_x86_ops.hwapic_isr_update(apic_find_highest_isr(apic));
 	}
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 	if (ioapic_in_kernel(vcpu->kvm))
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index a5c5eb3fea22..0ed2fc0f9713 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -603,7 +603,7 @@ void svm_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr)
 {
 }
 
-void svm_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr)
+void svm_hwapic_isr_update(int max_isr)
 {
 }
 
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
index cf4a08f2b756..edc1a71d0160 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6403,7 +6403,7 @@ static void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
 	put_page(page);
 }
 
-static void vmx_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr)
+static void vmx_hwapic_isr_update(int max_isr)
 {
 	u16 status;
 	u8 old;
-- 
2.53.0

