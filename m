Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9931A9FBD
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 02:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785120154; cv=none; b=UCG7mevkBNNqpOcbjmYuYN86dpyyiDtPfiEZq53T2kybkmYUo+EN+4hiqiB/N1QOhAJlbdi4G35JKbicTtj45FAgdklDfPEvM54xVUnVdbUQEzx8kAfp2Z9OyLOMN6kIzrUIljKOND+aKbyPcOFKHT46vaVGOBVf+jkY8Z+Ntlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785120154; c=relaxed/simple;
	bh=Jg6PQe3OTGdf97d24CxLxGmSE2J4+SMCYiH7S7tfFwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2dvaaizVBBKcmPoY3oaHbdwluW+gs88U4zDKd48sTdXJbtHDcdld4AdNld8PoIMehk2e5+OBC9HQgNcbLUojhhzA359EgsdwBlSjtMKz3k13qk/jhvukvRhr/DRbbmv2+XGHwxrx5QvGi4RJfHgbPNpr+srHJE2kl1dZlf8uSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=qsVKjAYP; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="qsVKjAYP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=llTuUILFdYYihkx+G/S0v/7TUthzA4jZFZ
	5yx4zb7VE=; b=qsVKjAYPYVXv/C18BlT3LxEmI9liDsBcfqZlJQNBgruaPK+Mhn
	hM58aZ3bMQ3D+tiUUcmarybD7GNY1HohxYpBCKLq02dpCNwtbQJ6HYbkji8NITl6
	tAxMKCyMSSjtqjxpJqDfrWZ99r18W/wxLHAjPrw3c0KNakzjRwnt7w1XE=
Received: from ur-dp1000 (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnEkOqxWZqzYQVAA--.17791S2;
	Mon, 27 Jul 2026 10:42:54 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Xie Bo <xb@ultrarisc.com>,
	Anup Patel <anup@brainfault.org>
Subject: [PATCH 6.18.y] RISC-V: KVM: Serialize virtual interrupt pending state updates
Date: Mon, 27 Jul 2026 10:42:22 +0800
Message-ID: <20260727024222.2180660-1-xb@ultrarisc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026072559-overprice-frantic-d5d5@gregkh>
References: <2026072559-overprice-frantic-d5d5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAnEkOqxWZqzYQVAA--.17791S2
X-Coremail-Antispam: 1UD129KBjvAXoW3ZFW5tryrCw4rAFy3JF1DJrb_yoW8GFyrXo
	WfGF4kXay8Gr1rGrZ8Z3y2ga48W34vgw48Xa1FyFWrZF1UX345XFWUKrsxXFy3JF45WasF
	ya45Xa13Ga9rJFyUn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYy7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWU
	JVW8JwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
	W8Jr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	MxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUSNtxUUUUU=
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQATB2pkMtIAAQAJsz

KVM RISC-V tracks guest local interrupt state with two bitmaps:

  - irqs_pending: interrupts that should be visible to the guest
  - irqs_pending_mask: interrupts whose pending state changed

The current code updates those bitmaps with independent atomic bitops
and assumes a multiple-producer, single-consumer protocol. That model
does not actually hold.

kvm_riscv_vcpu_sync_interrupts() is not a pure consumer. When the guest
changes guest-visible HVIP state, sync_interrupts() writes both
irqs_pending and irqs_pending_mask to reflect the new guest state back
into KVM state. As a result, irqs_pending and irqs_pending_mask form a
single logical state transition, but they are not updated atomically as
a pair.

This allows a race where a newly injected interrupt is lost. For
example:

  CPU0                              CPU1
  ----                              ----
  kvm_riscv_vcpu_set_interrupt(VS_SOFT)
    set_bit(VS_SOFT, irqs_pending)
                                    kvm_riscv_vcpu_sync_interrupts()
                                      sees guest-cleared HVIP.VSSIP
                                      sets irqs_pending_mask
                                      clear_bit(IRQ_VS_SOFT, irqs_pending)
    set_bit(VS_SOFT, irqs_pending_mask)
    kvm_vcpu_kick()

After that interleaving, a later flush can update HVIP without VSSIP
even though a new virtual interrupt was injected. In practice, the
guest can remain blocked in WFI with work pending.

The same pending/mask protocol is shared by VS soft interrupts, PMU
overflow delivery, and AIA high interrupt synchronization, so the race
is not limited to one interrupt source.

Fix this by serializing all updates to irqs_pending and irqs_pending_mask
with a per-vCPU raw spinlock. This keeps the pending bit and the dirty
mask as one state transition across:

  - set/unset interrupt
  - guest HVIP sync
  - interrupt flush to guest CSR state
  - vCPU reset
  - AIA CSR writes that clear dirty state

Use non-atomic bitmap operations while holding the lock. Hold the lock
across the AIA sync, flush, and pending checks as well, so both bitmap
words share the same serialization domain.

This intentionally replaces the existing lockless protocol instead of
trying to repair it with additional barriers. The problem is not memory
ordering on a single field; it is that two separate bitmaps encode one
shared state machine while both producers and sync paths can modify
them. A per-vCPU raw spinlock keeps the fix small, local, and suitable
for backporting.

Fixes: cce69aff689e ("RISC-V: KVM: Implement VCPU interrupts and requests handling")
Cc: stable@vger.kernel.org
Signed-off-by: Xie Bo <xb@ultrarisc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/r/20260715020359.1521354-2-xb@ultrarisc.com
Signed-off-by: Anup Patel <anup@brainfault.org>

[ bo: Adapt the AIA and general CSR helpers to their 6.18.y layout. ]
(cherry picked from commit d024a0a7879e6f37c0152aacf6d8e37b214a1738)
---
 arch/riscv/include/asm/kvm_host.h | 10 ++---
 arch/riscv/kvm/aia.c              | 35 ++++++++++++----
 arch/riscv/kvm/vcpu.c             | 68 ++++++++++++++++++++++---------
 arch/riscv/kvm/vcpu_onereg.c      |  8 +++-
 4 files changed, 87 insertions(+), 34 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 4d79457..fd3ba18 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -220,13 +220,13 @@ struct kvm_vcpu_arch {
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
index dad3181..b8b5060 100644
--- a/arch/riscv/kvm/aia.c
+++ b/arch/riscv/kvm/aia.c
@@ -50,12 +50,15 @@ void kvm_riscv_vcpu_aia_flush_interrupts(struct kvm_vcpu *vcpu)
 	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
 	unsigned long mask, val;
 
+	lockdep_assert_held(&vcpu->arch.irqs_pending_lock);
+
 	if (!kvm_riscv_aia_available())
 		return;
 
-	if (READ_ONCE(vcpu->arch.irqs_pending_mask[1])) {
-		mask = xchg_acquire(&vcpu->arch.irqs_pending_mask[1], 0);
-		val = READ_ONCE(vcpu->arch.irqs_pending[1]) & mask;
+	mask = vcpu->arch.irqs_pending_mask[1];
+	if (mask) {
+		vcpu->arch.irqs_pending_mask[1] = 0;
+		val = vcpu->arch.irqs_pending[1] & mask;
 
 		csr->hviph &= ~mask;
 		csr->hviph |= val;
@@ -66,6 +69,8 @@ void kvm_riscv_vcpu_aia_sync_interrupts(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
 
+	lockdep_assert_held(&vcpu->arch.irqs_pending_lock);
+
 	if (kvm_riscv_aia_available())
 		csr->vsieh = ncsr_read(CSR_VSIEH);
 }
@@ -74,13 +79,22 @@ void kvm_riscv_vcpu_aia_sync_interrupts(struct kvm_vcpu *vcpu)
 bool kvm_riscv_vcpu_aia_has_interrupts(struct kvm_vcpu *vcpu, u64 mask)
 {
 	unsigned long seip;
+#ifdef CONFIG_32BIT
+	unsigned long flags;
+	bool pending;
+#endif
 
 	if (!kvm_riscv_aia_available())
 		return false;
 
 #ifdef CONFIG_32BIT
-	if (READ_ONCE(vcpu->arch.irqs_pending[1]) &
-	    (vcpu->arch.aia_context.guest_csr.vsieh & upper_32_bits(mask)))
+	raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
+	pending = vcpu->arch.irqs_pending[1] &
+		  (vcpu->arch.aia_context.guest_csr.vsieh &
+		   upper_32_bits(mask));
+	raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
+
+	if (pending)
 		return true;
 #endif
 
@@ -198,6 +212,9 @@ int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcpu,
 			       unsigned long val)
 {
 	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
+#ifdef CONFIG_32BIT
+	unsigned long flags;
+#endif
 
 	if (reg_num >= sizeof(struct kvm_riscv_aia_csr) / sizeof(unsigned long))
 		return -ENOENT;
@@ -206,8 +223,12 @@ int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcpu,
 		((unsigned long *)csr)[reg_num] = val;
 
 #ifdef CONFIG_32BIT
-		if (reg_num == KVM_REG_RISCV_CSR_AIA_REG(siph))
-			WRITE_ONCE(vcpu->arch.irqs_pending_mask[1], 0);
+		if (reg_num == KVM_REG_RISCV_CSR_AIA_REG(siph)) {
+			raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
+			vcpu->arch.irqs_pending_mask[1] = 0;
+			raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock,
+						   flags);
+		}
 #endif
 	}
 
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index d26c496..6f8e9b1 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -78,6 +78,7 @@ static void kvm_riscv_vcpu_context_reset(struct kvm_vcpu *vcpu,
 
 static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu, bool kvm_sbi_reset)
 {
+	unsigned long flags;
 	bool loaded;
 
 	/**
@@ -102,8 +103,10 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu, bool kvm_sbi_reset)
 
 	kvm_riscv_vcpu_aia_reset(vcpu);
 
+	raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
 	bitmap_zero(vcpu->arch.irqs_pending, KVM_RISCV_VCPU_NR_IRQS);
 	bitmap_zero(vcpu->arch.irqs_pending_mask, KVM_RISCV_VCPU_NR_IRQS);
+	raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
 
 	kvm_riscv_vcpu_pmu_reset(vcpu);
 
@@ -147,6 +150,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 	/* Setup VCPU hfence queue */
 	spin_lock_init(&vcpu->arch.hfence_lock);
+	raw_spin_lock_init(&vcpu->arch.irqs_pending_lock);
 
 	spin_lock_init(&vcpu->arch.reset_state.lock);
 
@@ -348,10 +352,14 @@ void kvm_riscv_vcpu_flush_interrupts(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
 	unsigned long mask, val;
+	unsigned long flags;
 
-	if (READ_ONCE(vcpu->arch.irqs_pending_mask[0])) {
-		mask = xchg_acquire(&vcpu->arch.irqs_pending_mask[0], 0);
-		val = READ_ONCE(vcpu->arch.irqs_pending[0]) & mask;
+	raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
+
+	mask = vcpu->arch.irqs_pending_mask[0];
+	if (mask) {
+		vcpu->arch.irqs_pending_mask[0] = 0;
+		val = vcpu->arch.irqs_pending[0] & mask;
 
 		csr->hvip &= ~mask;
 		csr->hvip |= val;
@@ -359,11 +367,14 @@ void kvm_riscv_vcpu_flush_interrupts(struct kvm_vcpu *vcpu)
 
 	/* Flush AIA high interrupts */
 	kvm_riscv_vcpu_aia_flush_interrupts(vcpu);
+
+	raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
 }
 
 void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu)
 {
 	unsigned long hvip;
+	unsigned long flags;
 	struct kvm_vcpu_arch *v = &vcpu->arch;
 	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
 
@@ -372,34 +383,41 @@ void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu)
 
 	/* Sync-up HVIP.VSSIP bit changes does by Guest */
 	hvip = ncsr_read(CSR_HVIP);
+
+	raw_spin_lock_irqsave(&v->irqs_pending_lock, flags);
+
 	if ((csr->hvip ^ hvip) & (1UL << IRQ_VS_SOFT)) {
 		if (hvip & (1UL << IRQ_VS_SOFT)) {
-			if (!test_and_set_bit(IRQ_VS_SOFT,
-					      v->irqs_pending_mask))
-				set_bit(IRQ_VS_SOFT, v->irqs_pending);
+			if (!__test_and_set_bit(IRQ_VS_SOFT,
+						v->irqs_pending_mask))
+				__set_bit(IRQ_VS_SOFT, v->irqs_pending);
 		} else {
-			if (!test_and_set_bit(IRQ_VS_SOFT,
-					      v->irqs_pending_mask))
-				clear_bit(IRQ_VS_SOFT, v->irqs_pending);
+			if (!__test_and_set_bit(IRQ_VS_SOFT,
+						v->irqs_pending_mask))
+				__clear_bit(IRQ_VS_SOFT, v->irqs_pending);
 		}
 	}
 
 	/* Sync up the HVIP.LCOFIP bit changes (only clear) by the guest */
 	if ((csr->hvip ^ hvip) & (1UL << IRQ_PMU_OVF)) {
 		if (!(hvip & (1UL << IRQ_PMU_OVF)) &&
-		    !test_and_set_bit(IRQ_PMU_OVF, v->irqs_pending_mask))
-			clear_bit(IRQ_PMU_OVF, v->irqs_pending);
+		    !__test_and_set_bit(IRQ_PMU_OVF, v->irqs_pending_mask))
+			__clear_bit(IRQ_PMU_OVF, v->irqs_pending);
 	}
 
 	/* Sync-up AIA high interrupts */
 	kvm_riscv_vcpu_aia_sync_interrupts(vcpu);
 
+	raw_spin_unlock_irqrestore(&v->irqs_pending_lock, flags);
+
 	/* Sync-up timer CSRs */
 	kvm_riscv_vcpu_timer_sync(vcpu);
 }
 
 int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
 {
+	unsigned long flags;
+
 	/*
 	 * We only allow VS-mode software, timer, and external
 	 * interrupts when irq is one of the local interrupts
@@ -412,9 +430,10 @@ int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
 	    irq != IRQ_PMU_OVF)
 		return -EINVAL;
 
-	set_bit(irq, vcpu->arch.irqs_pending);
-	smp_mb__before_atomic();
-	set_bit(irq, vcpu->arch.irqs_pending_mask);
+	raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
+	__set_bit(irq, vcpu->arch.irqs_pending);
+	__set_bit(irq, vcpu->arch.irqs_pending_mask);
+	raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
 
 	kvm_vcpu_kick(vcpu);
 
@@ -423,6 +442,8 @@ int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
 
 int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
 {
+	unsigned long flags;
+
 	/*
 	 * We only allow VS-mode software, timer, counter overflow and external
 	 * interrupts when irq is one of the local interrupts
@@ -435,26 +456,33 @@ int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
 	    irq != IRQ_PMU_OVF)
 		return -EINVAL;
 
-	clear_bit(irq, vcpu->arch.irqs_pending);
-	smp_mb__before_atomic();
-	set_bit(irq, vcpu->arch.irqs_pending_mask);
+	raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
+	__clear_bit(irq, vcpu->arch.irqs_pending);
+	__set_bit(irq, vcpu->arch.irqs_pending_mask);
+	raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
 
 	return 0;
 }
 
 bool kvm_riscv_vcpu_has_interrupts(struct kvm_vcpu *vcpu, u64 mask)
 {
+	unsigned long flags;
 	unsigned long ie;
+	bool ret;
 
+	raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
 	ie = ((vcpu->arch.guest_csr.vsie & VSIP_VALID_MASK)
 		<< VSIP_TO_HVIP_SHIFT) & (unsigned long)mask;
 	ie |= vcpu->arch.guest_csr.vsie & ~IRQ_LOCAL_MASK &
 		(unsigned long)mask;
-	if (READ_ONCE(vcpu->arch.irqs_pending[0]) & ie)
-		return true;
+	ret = vcpu->arch.irqs_pending[0] & ie;
+	raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
 
 	/* Check AIA high interrupts */
-	return kvm_riscv_vcpu_aia_has_interrupts(vcpu, mask);
+	if (!ret)
+		ret = kvm_riscv_vcpu_aia_has_interrupts(vcpu, mask);
+
+	return ret;
 }
 
 void __kvm_riscv_vcpu_power_off(struct kvm_vcpu *vcpu)
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index 865dae9..3e8f9a2 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -522,6 +522,7 @@ static int kvm_riscv_vcpu_general_set_csr(struct kvm_vcpu *vcpu,
 					  unsigned long reg_val)
 {
 	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
+	unsigned long flags;
 
 	if (reg_num >= sizeof(struct kvm_riscv_csr) / sizeof(unsigned long))
 		return -ENOENT;
@@ -533,8 +534,11 @@ static int kvm_riscv_vcpu_general_set_csr(struct kvm_vcpu *vcpu,
 
 	((unsigned long *)csr)[reg_num] = reg_val;
 
-	if (reg_num == KVM_REG_RISCV_CSR_REG(sip))
-		WRITE_ONCE(vcpu->arch.irqs_pending_mask[0], 0);
+	if (reg_num == KVM_REG_RISCV_CSR_REG(sip)) {
+		raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
+		vcpu->arch.irqs_pending_mask[0] = 0;
+		raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
+	}
 
 	return 0;
 }
-- 
2.54.0

