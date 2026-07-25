Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B09E4908D7
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 06:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784962332; cv=none; b=fnB47DbztAMeJjHu0W+PEKHUmx5V31bKHCzJrUtDjvs/XdhSgAtFaQRAP0tNDtJdsSuBWrtC7TT0Tvi0FGAK2EpYBQgtVPQVMV2RuCCcVYFhSmrlWbsGrM6dfDJOycWvLY+HYU/BCV1w6/C8GQEyCdeqJ4ophN+RdBAhFkRQ27A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784962332; c=relaxed/simple;
	bh=FG4BncPbcHZ5RbhJlM0QNqt7lHLcRPx7ezphYk8ymfM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=u2Lxr7HHT+8y3/Nz5hOOj9HdhyI0VZf7qzktGxofeiqTbrUQ7ngSFQ8yP0Ev9eeA8VQBSOdRhzCeg4w/jQknqgCnUpKRqJg04cEtsXuP7FZy3mg1Mh+/U84L487fhjXHKFQN17T8BTHsW46KFyg14gwsk9sqjjQUPO/PnYJe8aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rbdAbHYO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rbdAbHYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1721F000E9;
	Sat, 25 Jul 2026 06:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784962330;
	bh=UdLlcdHCG8NE+9rMEOdMK/6LIE4+9SGzgoHFyKTFszw=;
	h=Subject:To:Cc:From:Date;
	b=rbdAbHYOET2bgFJm27gFXpASBZMkQP99Z6efVJMPyVllOgUMdtk879a7epLHUYafq
	 cnkU4O19aXlRtzVfwHTXgtFVNIyHyRnU6ZEUQvCMJ+U5QiWsao1WgopR9lGHL4o8fa
	 YRrK2QLtAY7k9cvensY+tdEBZoBTPlULUwCHggjw=
Subject: FAILED: patch "[PATCH] RISC-V: KVM: Serialize virtual interrupt pending state" failed to apply to 6.18-stable tree
To: xb@ultrarisc.com,anup@brainfault.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 25 Jul 2026 08:51:59 +0200
Message-ID: <2026072559-overprice-frantic-d5d5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x d024a0a7879e6f37c0152aacf6d8e37b214a1738
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072559-overprice-frantic-d5d5@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d024a0a7879e6f37c0152aacf6d8e37b214a1738 Mon Sep 17 00:00:00 2001
From: Xie Bo <xb@ultrarisc.com>
Date: Wed, 15 Jul 2026 10:03:59 +0800
Subject: [PATCH] RISC-V: KVM: Serialize virtual interrupt pending state
 updates

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

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 60017ceec9d2..e2d5808169e4 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -209,13 +209,13 @@ struct kvm_vcpu_arch {
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
index bafb009c5ce5..9a653b4ad40a 100644
--- a/arch/riscv/kvm/aia.c
+++ b/arch/riscv/kvm/aia.c
@@ -53,12 +53,15 @@ void kvm_riscv_vcpu_aia_flush_interrupts(struct kvm_vcpu *vcpu)
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
@@ -69,6 +72,8 @@ void kvm_riscv_vcpu_aia_sync_interrupts(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
 
+	lockdep_assert_held(&vcpu->arch.irqs_pending_lock);
+
 	if (kvm_riscv_aia_available())
 		csr->vsieh = ncsr_read(CSR_VSIEH);
 }
@@ -77,13 +82,22 @@ void kvm_riscv_vcpu_aia_sync_interrupts(struct kvm_vcpu *vcpu)
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
 
@@ -207,6 +221,9 @@ int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcpu,
 {
 	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
 	unsigned long regs_max = sizeof(struct kvm_riscv_aia_csr) / sizeof(unsigned long);
+#ifdef CONFIG_32BIT
+	unsigned long flags;
+#endif
 
 	if (!riscv_isa_extension_available(vcpu->arch.isa, SSAIA))
 		return -ENOENT;
@@ -219,8 +236,12 @@ int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcpu,
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
index cf6e231e76e2..977e36ab83d3 100644
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
 
@@ -352,10 +356,14 @@ void kvm_riscv_vcpu_flush_interrupts(struct kvm_vcpu *vcpu)
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
@@ -363,11 +371,14 @@ void kvm_riscv_vcpu_flush_interrupts(struct kvm_vcpu *vcpu)
 
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
 
@@ -376,34 +387,41 @@ void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu)
 
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
@@ -416,9 +434,10 @@ int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
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
 
@@ -427,6 +446,8 @@ int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
 
 int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
 {
+	unsigned long flags;
+
 	/*
 	 * We only allow VS-mode software, timer, counter overflow and external
 	 * interrupts when irq is one of the local interrupts
@@ -439,26 +460,33 @@ int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
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
index 61988382570f..99b9107b1ac1 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -286,6 +286,7 @@ static int kvm_riscv_vcpu_general_set_csr(struct kvm_vcpu *vcpu,
 {
 	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
 	unsigned long regs_max = sizeof(struct kvm_riscv_csr) / sizeof(unsigned long);
+	unsigned long flags;
 
 	if (reg_num >= regs_max)
 		return -ENOENT;
@@ -299,8 +300,11 @@ static int kvm_riscv_vcpu_general_set_csr(struct kvm_vcpu *vcpu,
 
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

