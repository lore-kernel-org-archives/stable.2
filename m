Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F903A3835
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.128.198.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688476; cv=none; b=IlALuxO7sMCj488mo3A9U+vihNp2oUCzRpAq+oIcomuPCxyXWH29eLz92tBCno+1g8NB4yjkdWP33wz3MA1Sv0z2cHVshvGUAElQrhd+XbnkbtR3OvU+Df2usd8mlJmmWQIBhlMCBMu3z0YY++x11WL6Fy4Al6L7Ky2W3aKRvCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688476; c=relaxed/simple;
	bh=0Wi4VND4r4E1pakjygZAS6dMK3K0uZlOkgHC1P8B/O4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FC3LjhQGKLJoxOAnyW04UJ15w9QJDD7hxhYs9MRByl2WHF4LPORZWJf8k2tyFasNo3d4xDU2Rd5C5c2AbM2JAaTTPzKlIcvB6H9TuZlv1kI0/7zYYeILsGbht/vz7Kw65fELhmIzYUgnK0lviMXyyXqZAD6g0M/XLSKkNDi3psE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=220.128.198.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 65H9RH19094856
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 17:27:17 +0800 (+08)
	(envelope-from tim609@andestech.com)
Received: from swlinux01.andestech.com (10.0.15.55) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Wed, 17 Jun 2026
 17:27:17 +0800
From: Tim Ouyang <tim609@andestech.com>
To: <tim609@andestech.com>, <oyst.lnx@gmail.com>
CC: <sun409@gmail.com>, Atish Patra <atish.patra@linux.dev>,
        <stable@vger.kernel.org>, Xie Bo <xb@ultrarisc.com>
Subject: Fwd: [PATCH] RISC-V: KVM: Fix lost virtual interrupts during IRQ sync
Date: Wed, 17 Jun 2026 17:26:49 +0800
Message-ID: <20260617092714.2559636-1-tim609@andestech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 65H9RH19094856

=== >8 ===
From: Xie Bo <xb@ultrarisc.com>
To: Anup Patel <anup@brainfault.org>, kvm-riscv@lists.infradead.org
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>, kvm@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Xie Bo <xb@ultrarisc.com>
Message-Id: <178159067899.108868.8176174463274678253@ultrarisc.com>
Date: Tue, 16 Jun 2026 14:17:58 +0800
Local-Date: 2026-06-16 14:17:58+08:00
Subject: [PATCH] RISC-V: KVM: Fix lost virtual interrupts during IRQ sync

RISC-V KVM tracks guest pending interrupts with irqs_pending and
irqs_pending_mask. The existing code uses atomic bitops and models the
state as a multiple-producer, single-consumer queue where the vCPU is
the consumer.

The atomic bitops make each individual bitmap operation atomic, but
they do not make the pair of irqs_pending and irqs_pending_mask an
atomic state transition. The vCPU interrupt sync path is also not a
pure consumer: it writes both bitmaps when it reflects guest-visible
HVIP changes back into KVM state.

For example, kvm_riscv_vcpu_set_interrupt() can set IRQ_VS_SOFT in
irqs_pending while the target vCPU is concurrently syncing a
guest-cleared HVIP.VSSIP bit. If sync observes irqs_pending_mask before
the producer sets it, sync can set the mask and clear irqs_pending. The
producer then sets the mask and kicks the vCPU, but the pending bit has
already been lost. A subsequent flush updates HVIP without VSSIP, and
the guest can remain blocked in WFI even though it has work queued.

Serialize all updates to irqs_pending and irqs_pending_mask with a
per-vCPU raw spinlock. This intentionally replaces the lockless
pending/mask protocol with one small critical section per vCPU, so the
pending bit and the dirty mask are updated as one state transition.
Use the same lock for sync, flush, reset, and userspace CSR writes that
clear the dirty mask, so a newly injected interrupt cannot be
overwritten by a concurrent HVIP sync.

Fixes: cce69aff689e ("RISC-V: KVM: Implement VCPU interrupts and requests handling")
Cc: stable@vger.kernel.org
Signed-off-by: Xie Bo <xb@ultrarisc.com>
---
 arch/riscv/include/asm/kvm_host.h | 10 +++++-----
 arch/riscv/kvm/aia.c              | 28 +++++++++++++++++++++-------
 arch/riscv/kvm/vcpu.c             | 27 ++++++++++++++++++++++-----
 arch/riscv/kvm/vcpu_onereg.c      | 13 +++++++++----
 4 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 75b0a951c..97e42645c 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -207,13 +207,13 @@ struct kvm_vcpu_arch {
 	/*
 	 * VCPU interrupts
 	 *
-	 * We have a lockless approach for tracking pending VCPU interrupts
-	 * implemented using atomic bitops. The irqs_pending bitmap represent
-	 * pending interrupts whereas irqs_pending_mask represent bits changed
-	 * in irqs_pending. Our approach is modeled around multiple producer
-	 * and single consumer problem where the consumer is the VCPU itself.
+	 * The irqs_pending bitmap represents pending interrupts whereas
+	 * irqs_pending_mask represents bits changed in irqs_pending. Updates
+	 * to these bitmaps are serialized so vcpu interrupt sync/flush cannot
+	 * drop a newly injected interrupt while syncing guest-visible HVIP.
 	 */
 #define KVM_RISCV_VCPU_NR_IRQS	64
+	raw_spinlock_t irqs_pending_lock;
 	DECLARE_BITMAP(irqs_pending, KVM_RISCV_VCPU_NR_IRQS);
 	DECLARE_BITMAP(irqs_pending_mask, KVM_RISCV_VCPU_NR_IRQS);
 
diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
index 5ec503288..821d2cb6d 100644
--- a/arch/riscv/kvm/aia.c
+++ b/arch/riscv/kvm/aia.c
@@ -50,17 +50,21 @@ void kvm_riscv_vcpu_aia_flush_interrupts(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
 	unsigned long mask, val;
+	unsigned long flags;
 
 	if (!kvm_riscv_aia_available())
 		return;
 
-	if (READ_ONCE(vcpu->arch.irqs_pending_mask[1])) {
-		mask = xchg_acquire(&vcpu->arch.irqs_pending_mask[1], 0);
-		val = READ_ONCE(vcpu->arch.irqs_pending[1]) & mask;
+	raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
+	mask = vcpu->arch.irqs_pending_mask[1];
+	if (mask) {
+		vcpu->arch.irqs_pending_mask[1] = 0;
+		val = vcpu->arch.irqs_pending[1] & mask;
 
 		csr->hviph &= ~mask;
 		csr->hviph |= val;
 	}
+	raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
 }
 
 void kvm_riscv_vcpu_aia_sync_interrupts(struct kvm_vcpu *vcpu)
@@ -205,6 +209,9 @@ int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcpu,
 {
 	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
 	unsigned long regs_max = sizeof(struct kvm_riscv_aia_csr) / sizeof(unsigned long);
+#ifdef CONFIG_32BIT
+	unsigned long flags;
+#endif
 
 	if (!riscv_isa_extension_available(vcpu->arch.isa, SSAIA))
 		return -ENOENT;
@@ -214,11 +221,18 @@ int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcpu,
 	reg_num = array_index_nospec(reg_num, regs_max);
 
 	if (kvm_riscv_aia_available()) {
-		((unsigned long *)csr)[reg_num] = val;
-
 #ifdef CONFIG_32BIT
-		if (reg_num == KVM_REG_RISCV_CSR_AIA_REG(siph))
-			WRITE_ONCE(vcpu->arch.irqs_pending_mask[1], 0);
+		if (reg_num == KVM_REG_RISCV_CSR_AIA_REG(siph)) {
+			raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
+			((unsigned long *)csr)[reg_num] = val;
+			vcpu->arch.irqs_pending_mask[1] = 0;
+			raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock,
+						   flags);
+		} else {
+			((unsigned long *)csr)[reg_num] = val;
+		}
+#else
+		((unsigned long *)csr)[reg_num] = val;
 #endif
 	}
 
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index a73690eda..b04730ccd 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -80,6 +80,7 @@ static void kvm_riscv_vcpu_context_reset(struct kvm_vcpu *vcpu,
 
 static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu, bool kvm_sbi_reset)
 {
+	unsigned long flags;
 	bool loaded;
 
 	/**
@@ -104,8 +105,10 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu, bool kvm_sbi_reset)
 
 	kvm_riscv_vcpu_aia_reset(vcpu);
 
+	raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
 	bitmap_zero(vcpu->arch.irqs_pending, KVM_RISCV_VCPU_NR_IRQS);
 	bitmap_zero(vcpu->arch.irqs_pending_mask, KVM_RISCV_VCPU_NR_IRQS);
+	raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
 
 	kvm_riscv_vcpu_pmu_reset(vcpu);
 
@@ -151,6 +154,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 	/* Setup VCPU hfence queue */
 	spin_lock_init(&vcpu->arch.hfence_lock);
+	raw_spin_lock_init(&vcpu->arch.irqs_pending_lock);
 
 	spin_lock_init(&vcpu->arch.reset_state.lock);
 
@@ -352,14 +356,18 @@ void kvm_riscv_vcpu_flush_interrupts(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
 	unsigned long mask, val;
+	unsigned long flags;
 
-	if (READ_ONCE(vcpu->arch.irqs_pending_mask[0])) {
-		mask = xchg_acquire(&vcpu->arch.irqs_pending_mask[0], 0);
-		val = READ_ONCE(vcpu->arch.irqs_pending[0]) & mask;
+	raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
+	mask = vcpu->arch.irqs_pending_mask[0];
+	if (mask) {
+		vcpu->arch.irqs_pending_mask[0] = 0;
+		val = vcpu->arch.irqs_pending[0] & mask;
 
 		csr->hvip &= ~mask;
 		csr->hvip |= val;
 	}
+	raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
 
 	/* Flush AIA high interrupts */
 	kvm_riscv_vcpu_aia_flush_interrupts(vcpu);
@@ -368,6 +376,7 @@ void kvm_riscv_vcpu_flush_interrupts(struct kvm_vcpu *vcpu)
 void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu)
 {
 	unsigned long hvip;
+	unsigned long flags;
 	struct kvm_vcpu_arch *v = &vcpu->arch;
 	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
 
@@ -376,6 +385,7 @@ void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu)
 
 	/* Sync-up HVIP.VSSIP bit changes does by Guest */
 	hvip = ncsr_read(CSR_HVIP);
+	raw_spin_lock_irqsave(&v->irqs_pending_lock, flags);
 	if ((csr->hvip ^ hvip) & (1UL << IRQ_VS_SOFT)) {
 		if (hvip & (1UL << IRQ_VS_SOFT)) {
 			if (!test_and_set_bit(IRQ_VS_SOFT,
@@ -394,6 +404,7 @@ void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu)
 		    !test_and_set_bit(IRQ_PMU_OVF, v->irqs_pending_mask))
 			clear_bit(IRQ_PMU_OVF, v->irqs_pending);
 	}
+	raw_spin_unlock_irqrestore(&v->irqs_pending_lock, flags);
 
 	/* Sync-up AIA high interrupts */
 	kvm_riscv_vcpu_aia_sync_interrupts(vcpu);
@@ -404,6 +415,8 @@ void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu)
 
 int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
 {
+	unsigned long flags;
+
 	/*
 	 * We only allow VS-mode software, timer, and external
 	 * interrupts when irq is one of the local interrupts
@@ -416,9 +429,10 @@ int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
 	    irq != IRQ_PMU_OVF)
 		return -EINVAL;
 
+	raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
 	set_bit(irq, vcpu->arch.irqs_pending);
-	smp_mb__before_atomic();
 	set_bit(irq, vcpu->arch.irqs_pending_mask);
+	raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
 
 	kvm_vcpu_kick(vcpu);
 
@@ -427,6 +441,8 @@ int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
 
 int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
 {
+	unsigned long flags;
+
 	/*
 	 * We only allow VS-mode software, timer, counter overflow and external
 	 * interrupts when irq is one of the local interrupts
@@ -439,9 +455,10 @@ int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
 	    irq != IRQ_PMU_OVF)
 		return -EINVAL;
 
+	raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
 	clear_bit(irq, vcpu->arch.irqs_pending);
-	smp_mb__before_atomic();
 	set_bit(irq, vcpu->arch.irqs_pending_mask);
+	raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
 
 	return 0;
 }
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index bb920e892..cba368294 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -298,6 +298,7 @@ static int kvm_riscv_vcpu_general_set_csr(struct kvm_vcpu *vcpu,
 {
 	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
 	unsigned long regs_max = sizeof(struct kvm_riscv_csr) / sizeof(unsigned long);
+	unsigned long flags;
 
 	if (reg_num >= regs_max)
 		return -ENOENT;
@@ -309,10 +310,14 @@ static int kvm_riscv_vcpu_general_set_csr(struct kvm_vcpu *vcpu,
 		reg_val <<= VSIP_TO_HVIP_SHIFT;
 	}
 
-	((unsigned long *)csr)[reg_num] = reg_val;
-
-	if (reg_num == KVM_REG_RISCV_CSR_REG(sip))
-		WRITE_ONCE(vcpu->arch.irqs_pending_mask[0], 0);
+	if (reg_num == KVM_REG_RISCV_CSR_REG(sip)) {
+		raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
+		((unsigned long *)csr)[reg_num] = reg_val;
+		vcpu->arch.irqs_pending_mask[0] = 0;
+		raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
+	} else {
+		((unsigned long *)csr)[reg_num] = reg_val;
+	}
 
 	return 0;
 }

base-commit: 481329ec5b31d2c48ac6b8b703c8008133884c7e
-- 
2.54.0


_______________________________________________
linux-riscv mailing list
linux-riscv@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-riscv

Sent using hkml (https://github.com/sjp38/hackermail)
