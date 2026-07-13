Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908D838F633;
	Mon, 13 Jul 2026 07:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928050; cv=none; b=X9z5CwdgMDRJKUvpbUG8jqrh5AVx0IZdNYEfQzAuXEloYf1EyZAoVGXxV7dlN4ElfQcEM2qe8alHCgrcp5yf2IAzvfv6ljJMOJ5MOSaeiFuOLz9mWzU1+PtQRoeC0RBbHXBY+lob8KEUdTczkmyHDnjBZEzHgodW62ET/CWevJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928050; c=relaxed/simple;
	bh=JwSqLnuyEJlVhm0PNUxoFoZErFDI8hb4mSxJUvIDi80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5EHJQN0YueJzPUIUP0MgrVbSMiB983pPnlUOKaja7wj3tLIZ5wbRrY5kMTjfCU8GJXi3RmV5gbPSo2vncx+mCPRbaPup0UgVR0zcVgs1362LvtQm3Qud21KF04Rfkl+O2Oc5mLCORsaBvUh778jjlwkox+NBKeGdOCBqoRCJdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=DyokYb9O; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="DyokYb9O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=LaxjQ7yn/bVNQVUfDjntXPU9prJ6LiT/DV
	oanSiUwLw=; b=DyokYb9OciUVTyZFBra/lpdIuYZmlc3S1JxdmDjNhlfZmNoBqQ
	FWZJnXbl/gSWPplX6CIP0VYpQsQoPCOivY2GaKi/2r5kR3QA1xBUhABDZ/A+gY8N
	kGNTbHjfEqNZ5Z1OHjy1OJisWx4HHqWJTxhssfTkKxck4YuxelrWtVVaM=
Received: from ur-dp1000 (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnYUL5lFRqtIEQAA--.16562S3;
	Mon, 13 Jul 2026 15:34:25 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: Anup Patel <anup@brainfault.org>
Cc: Xie Bo <xb@ultrarisc.com>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4] RISC-V: KVM: Serialize virtual interrupt pending state updates
Date: Mon, 13 Jul 2026 15:33:37 +0800
Message-ID: <20260713073346.1293408-2-xb@ultrarisc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713073346.1293408-1-xb@ultrarisc.com>
References: <178159067899.108868.8176174463274678253@ultrarisc.com> <CAAhSdy3_YnzNiSE=KykriwSWU8X2CLhdr2E8CB=32JxA_L7caA@mail.gmail.com>
 <20260713073346.1293408-1-xb@ultrarisc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAnYUL5lFRqtIEQAA--.16562S3
X-Coremail-Antispam: 1UD129KBjvAXoW3KFyrJF1fur1rKrWftr45Awb_yoW8Wr18Zo
	WfCF4vqaykGryrGrZ8Z3y2ga48W3yvgw4xXa1FyFWrZr1UX343XFyUKrsxJFy3XF45WF9F
	ya45Xw43GFZrJFykn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOf7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M28IrcIa0x
	kI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
	jcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJw
	A2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUeuWJUUUUU=
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQAHB2pUYNAAEwAKsW

RISC-V KVM tracks guest interrupt state with two bitmaps:

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
                                      clears irqs_pending
    set_bit(VS_SOFT, irqs_pending_mask)
    kvm_vcpu_kick()

After that interleaving, a later flush can update HVIP without VSSIP
even though a new virtual interrupt was injected. In practice, the
guest can remain blocked in WFI with work pending.

The same pending/mask protocol is shared by VS soft interrupts, PMU
overflow delivery, and AIA high interrupt synchronization, so the race
is not limited to one interrupt source.

Fix this by serializing all updates to irqs_pending and
irqs_pending_mask with a per-vCPU raw spinlock. This keeps the pending
bit and the dirty mask as one state transition across:

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
---
Changes in v4:
- Split the AIA pending bitmap check from the IMSIC VS-file check.
- Release irqs_pending_lock before the IMSIC check takes vsfile_lock,
  avoiding sleep-in-atomic on PREEMPT_RT and an ABBA lock ordering cycle.

Changes in v3:
- Rebase onto Linux 7.2-rc3.
- Use non-atomic bitmap operations under irqs_pending_lock.
- Hold irqs_pending_lock across the AIA sync/flush helpers and add
  lockdep assertions for their locking contract.
- Protect kvm_riscv_vcpu_has_interrupts() with irqs_pending_lock.

Changes in v2:
- Expand the race description and user-visible failure mode.

 arch/riscv/include/asm/kvm_aia.h  |  2 +
 arch/riscv/include/asm/kvm_host.h | 10 ++---
 arch/riscv/kvm/aia.c              | 45 +++++++++++++++-----
 arch/riscv/kvm/vcpu.c             | 69 +++++++++++++++++++++----------
 arch/riscv/kvm/vcpu_onereg.c      | 13 ++++--
 5 files changed, 99 insertions(+), 40 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/kvm_aia.h
index c67ec5ac0a1..1fe146675e2 100644
--- a/arch/riscv/include/asm/kvm_aia.h
+++ b/arch/riscv/include/asm/kvm_aia.h
@@ -124,6 +124,8 @@ static inline void kvm_riscv_vcpu_aia_sync_interrupts(struct kvm_vcpu *vcpu)
 {
 }
 #endif
+bool kvm_riscv_vcpu_aia_has_pending_interrupts(struct kvm_vcpu *vcpu,
+					       u64 mask);
 bool kvm_riscv_vcpu_aia_has_interrupts(struct kvm_vcpu *vcpu, u64 mask);
 
 void kvm_riscv_vcpu_aia_update_hvip(struct kvm_vcpu *vcpu);
diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 60017ceec9d..e2d5808169e 100644
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
index bafb009c5ce..001e83032f6 100644
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
@@ -69,23 +72,35 @@ void kvm_riscv_vcpu_aia_sync_interrupts(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
 
+	lockdep_assert_held(&vcpu->arch.irqs_pending_lock);
+
 	if (kvm_riscv_aia_available())
 		csr->vsieh = ncsr_read(CSR_VSIEH);
 }
 #endif
 
-bool kvm_riscv_vcpu_aia_has_interrupts(struct kvm_vcpu *vcpu, u64 mask)
+bool kvm_riscv_vcpu_aia_has_pending_interrupts(struct kvm_vcpu *vcpu,
+					       u64 mask)
 {
-	unsigned long seip;
+	lockdep_assert_held(&vcpu->arch.irqs_pending_lock);
 
 	if (!kvm_riscv_aia_available())
 		return false;
 
 #ifdef CONFIG_32BIT
-	if (READ_ONCE(vcpu->arch.irqs_pending[1]) &
+	if (vcpu->arch.irqs_pending[1] &
 	    (vcpu->arch.aia_context.guest_csr.vsieh & upper_32_bits(mask)))
 		return true;
 #endif
+	return false;
+}
+
+bool kvm_riscv_vcpu_aia_has_interrupts(struct kvm_vcpu *vcpu, u64 mask)
+{
+	unsigned long seip;
+
+	if (!kvm_riscv_aia_available())
+		return false;
 
 	seip = vcpu->arch.guest_csr.vsie;
 	seip &= (unsigned long)mask;
@@ -207,6 +222,9 @@ int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcpu,
 {
 	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
 	unsigned long regs_max = sizeof(struct kvm_riscv_aia_csr) / sizeof(unsigned long);
+#ifdef CONFIG_32BIT
+	unsigned long flags;
+#endif
 
 	if (!riscv_isa_extension_available(vcpu->arch.isa, SSAIA))
 		return -ENOENT;
@@ -216,11 +234,18 @@ int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcpu,
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
index cf6e231e76e..99c929ec0ac 100644
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
 
@@ -352,10 +356,13 @@ void kvm_riscv_vcpu_flush_interrupts(struct kvm_vcpu *vcpu)
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
@@ -363,11 +370,13 @@ void kvm_riscv_vcpu_flush_interrupts(struct kvm_vcpu *vcpu)
 
 	/* Flush AIA high interrupts */
 	kvm_riscv_vcpu_aia_flush_interrupts(vcpu);
+	raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
 }
 
 void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu)
 {
 	unsigned long hvip;
+	unsigned long flags;
 	struct kvm_vcpu_arch *v = &vcpu->arch;
 	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
 
@@ -376,27 +385,29 @@ void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu)
 
 	/* Sync-up HVIP.VSSIP bit changes does by Guest */
 	hvip = ncsr_read(CSR_HVIP);
+	raw_spin_lock_irqsave(&v->irqs_pending_lock, flags);
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
 
 	/* Sync-up timer CSRs */
 	kvm_riscv_vcpu_timer_sync(vcpu);
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
 
-	set_bit(irq, vcpu->arch.irqs_pending);
-	smp_mb__before_atomic();
-	set_bit(irq, vcpu->arch.irqs_pending_mask);
+	raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
+	__set_bit(irq, vcpu->arch.irqs_pending);
+	__set_bit(irq, vcpu->arch.irqs_pending_mask);
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
@@ -439,26 +455,37 @@ int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
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
+
+	/* Check AIA high pending bitmap while holding irqs_pending_lock */
+	if (!ret)
+		ret = kvm_riscv_vcpu_aia_has_pending_interrupts(vcpu, mask);
+	raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
 
-	/* Check AIA high interrupts */
-	return kvm_riscv_vcpu_aia_has_interrupts(vcpu, mask);
+	/* IMSIC interrupt check takes vsfile_lock, which can sleep on RT. */
+	if (!ret)
+		ret = kvm_riscv_vcpu_aia_has_interrupts(vcpu, mask);
+
+	return ret;
 }
 
 void __kvm_riscv_vcpu_power_off(struct kvm_vcpu *vcpu)
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index bb920e8923c..cba3682944b 100644
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
-- 
2.54.0

