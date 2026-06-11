Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3400230C158
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185387; cv=none; b=eVW0iYT2q9Iid+6okP6wp9FkWyj1Luvc4aWJY1plauP5y0qXRcbpBQRknIuK/5746o7pjtlhm6s8nBssjyW2U2uaf4Mht8gDrPScBBzGp2FbKW0ubUEFuugOZxuB2uFQeflxf9ni7z5tfvvOxNjKqWue9CJ+UNV/U35+90h6cJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185387; c=relaxed/simple;
	bh=T8ZYwlFcC/gok2xHb7bcM2FoV3plHDRkQe2yL2LI1jg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kGCoKoPQNj+6pJvTQoqDEPiO6aw0EBVkEjFnvn/zLhyqoiW/s9/YAzcfaN60b7ZVIUwQKWqBrsXtfN2Vhi5+9eVCncJLwSkIclCnoefEtkH7kkqK/YEOf2Kk5y+mVGu/kMBAt4M/CeMM068gfIRV+BzO9JPz0G8eJDet9KqD5jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HWOFYVXR; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HWOFYVXR"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB8571DB5;
	Thu, 11 Jun 2026 06:42:59 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DD7D33FAF5;
	Thu, 11 Jun 2026 06:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781185384; bh=T8ZYwlFcC/gok2xHb7bcM2FoV3plHDRkQe2yL2LI1jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HWOFYVXRjK5bVlFSbyfzpJ5Eztfl7dLRRMMxWjEHYjod755K8HKtyH3lwFmy8+/Ee
	 R5OX3G1EySoTDYbIkYiB5Urv1JVuz0Ny5btHyaZx4mvd9i5dH6VqDPbj5SLAJ+3t45
	 d91GPydeBiWFVGRawnNHAqXjEMc7rwuKa39KYA0Q=
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	gregkh@linuxfoundation.org,
	lee@kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	oupton@kernel.org,
	ryan.roberts@arm.com,
	will@kernel.org,
	yuzenghui@huawei.com
Subject: [PATCH 6.6.y 3/3] arm64: tlb: Optimize ARM64_WORKAROUND_REPEAT_TLBI
Date: Thu, 11 Jun 2026 14:42:48 +0100
Message-Id: <20260611134248.1700496-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260611134248.1700496-1-mark.rutland@arm.com>
References: <20260611134248.1700496-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit a8f78680ee6bf795086384e8aea159a52814f827 upstream.

The ARM64_WORKAROUND_REPEAT_TLBI workaround is used to mitigate several
errata where broadcast TLBI;DSB sequences don't provide all the
architecturally required synchronization. The workaround performs more
work than necessary, and can have significant overhead. This patch
optimizes the workaround, as explained below.

The workaround was originally added for Qualcomm Falkor erratum 1009 in
commit:

  d9ff80f83ecb ("arm64: Work around Falkor erratum 1009")

As noted in the message for that commit, the workaround is applied even
in cases where it is not strictly necessary.

The workaround was later reused without changes for:

* Arm Cortex-A76 erratum #1286807
  SDEN v33: https://developer.arm.com/documentation/SDEN-885749/33-0/

* Arm Cortex-A55 erratum #2441007
  SDEN v16: https://developer.arm.com/documentation/SDEN-859338/1600/

* Arm Cortex-A510 erratum #2441009
  SDEN v19: https://developer.arm.com/documentation/SDEN-1873351/1900/

The important details to note are as follows:

1. All relevant errata only affect the ordering and/or completion of
   memory accesses which have been translated by an invalidated TLB
   entry. The actual invalidation of TLB entries is unaffected.

2. The existing workaround is applied to both broadcast and local TLB
   invalidation, whereas for all relevant errata it is only necessary to
   apply a workaround for broadcast invalidation.

3. The existing workaround replaces every TLBI with a TLBI;DSB;TLBI
   sequence, whereas for all relevant errata it is only necessary to
   execute a single additional TLBI;DSB sequence after any number of
   TLBIs are completed by a DSB.

   For example, for a sequence of batched TLBIs:

       TLBI <op1>[, <arg1>]
       TLBI <op2>[, <arg2>]
       TLBI <op3>[, <arg3>]
       DSB ISH

   ... the existing workaround will expand this to:

       TLBI <op1>[, <arg1>]
       DSB ISH                  // additional
       TLBI <op1>[, <arg1>]     // additional
       TLBI <op2>[, <arg2>]
       DSB ISH                  // additional
       TLBI <op2>[, <arg2>]     // additional
       TLBI <op3>[, <arg3>]
       DSB ISH                  // additional
       TLBI <op3>[, <arg3>]     // additional
       DSB ISH

   ... whereas it is sufficient to have:

       TLBI <op1>[, <arg1>]
       TLBI <op2>[, <arg2>]
       TLBI <op3>[, <arg3>]
       DSB ISH
       TLBI <opX>[, <argX>]     // additional
       DSB ISH                  // additional

   Using a single additional TBLI and DSB at the end of the sequence can
   have significantly lower overhead as each DSB which completes a TLBI
   must synchronize with other PEs in the system, with potential
   performance effects both locally and system-wide.

4. The existing workaround repeats each specific TLBI operation, whereas
   for all relevant errata it is sufficient for the additional TLBI to
   use *any* operation which will be broadcast, regardless of which
   translation regime or stage of translation the operation applies to.

   For example, for a single TLBI:

       TLBI ALLE2IS
       DSB ISH

   ... the existing workaround will expand this to:

       TLBI ALLE2IS
       DSB ISH
       TLBI ALLE2IS             // additional
       DSB ISH                  // additional

   ... whereas it is sufficient to have:

       TLBI ALLE2IS
       DSB ISH
       TLBI VALE1IS, XZR        // additional
       DSB ISH                  // additional

   As the additional TLBI doesn't have to match a specific earlier TLBI,
   the additional TLBI can be implemented in separate code, with no
   memory of the earlier TLBIs. The additional TLBI can also use a
   cheaper TLBI operation.

5. The existing workaround is applied to both Stage-1 and Stage-2 TLB
   invalidation, whereas for all relevant errata it is only necessary to
   apply a workaround for Stage-1 invalidation.

   Architecturally, TLBI operations which invalidate only Stage-2
   information (e.g. IPAS2E1IS) are not required to invalidate TLB
   entries which combine information from Stage-1 and Stage-2
   translation table entries, and consequently may not complete memory
   accesses translated by those combined entries. In these cases,
   completion of memory accesses is only guaranteed after subsequent
   invalidation of Stage-1 information (e.g. VMALLE1IS).

Taking the above points into account, this patch reworks the workaround
logic to reduce overhead:

* New __tlbi_sync_s1ish() and __tlbi_sync_s1ish_hyp() functions are
  added and used in place of any dsb(ish) which is used to complete
  broadcast Stage-1 TLB maintenance. When the
  ARM64_WORKAROUND_REPEAT_TLBI workaround is enabled, these helpers will
  execute an additional TLBI;DSB sequence.

  For consistency, it might make sense to add __tlbi_sync_*() helpers
  for local and stage 2 maintenance. For now I've left those with
  open-coded dsb() to keep the diff small.

* The duplication of TLBIs in __TLBI_0() and __TLBI_1() is removed. This
  is no longer needed as the necessary synchronization will happen in
  __tlbi_sync_s1ish() or __tlbi_sync_s1ish_hyp().

* The additional TLBI operation is chosen to have minimal impact:

  - __tlbi_sync_s1ish() uses "TLBI VALE1IS, XZR". This is only used at
    EL1 or at EL2 with {E2H,TGE}=={1,1}, where it will target an unused
    entry for the reserved ASID in the kernel's own translation regime,
    and have no adverse affect.

  - __tlbi_sync_s1ish_hyp() uses "TLBI VALE2IS, XZR". This is only used
    in hyp code, where it will target an unused entry in the hyp code's
    TTBR0 mapping, and should have no adverse effect.

* As __TLBI_0() and __TLBI_1() no longer replace each TLBI with a
  TLBI;DSB;TLBI sequence, batching TLBIs is worthwhile, and there's no
  need for arch_tlbbatch_should_defer() to consider
  ARM64_WORKAROUND_REPEAT_TLBI.

When building defconfig with GCC 15.1.0, compared to v6.19-rc1, this
patch saves ~1KiB of text, makes the vmlinux ~42KiB smaller, and makes
the resulting Image 64KiB smaller:

| [mark@lakrids:~/src/linux]% size vmlinux-*
|    text    data     bss     dec     hex filename
| 21179831        19660919         708216 41548966        279fca6 vmlinux-after
| 21181075        19660903         708216 41550194        27a0172 vmlinux-before
| [mark@lakrids:~/src/linux]% ls -l vmlinux-*
| -rwxr-xr-x 1 mark mark 157771472 Feb  4 12:05 vmlinux-after
| -rwxr-xr-x 1 mark mark 157815432 Feb  4 12:05 vmlinux-before
| [mark@lakrids:~/src/linux]% ls -l Image-*
| -rw-r--r-- 1 mark mark 41007616 Feb  4 12:05 Image-after
| -rw-r--r-- 1 mark mark 41073152 Feb  4 12:05 Image-before

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Mark: Backport to v6.6.y]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/tlbflush.h | 60 ++++++++++++++++++-------------
 arch/arm64/kernel/sys_compat.c    |  2 +-
 arch/arm64/kvm/hyp/nvhe/mm.c      |  2 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c     |  8 ++---
 arch/arm64/kvm/hyp/pgtable.c      |  2 +-
 arch/arm64/kvm/hyp/vhe/tlb.c      |  8 ++---
 6 files changed, 46 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index c8d8b9622369f..d96342d455a68 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -31,18 +31,10 @@
  */
 #define __TLBI_0(op, arg) asm (ARM64_ASM_PREAMBLE			       \
 			       "tlbi " #op "\n"				       \
-		   ALTERNATIVE("nop\n			nop",		       \
-			       "dsb ish\n		tlbi " #op,	       \
-			       ARM64_WORKAROUND_REPEAT_TLBI,		       \
-			       CONFIG_ARM64_WORKAROUND_REPEAT_TLBI)	       \
 			    : : )
 
 #define __TLBI_1(op, arg) asm (ARM64_ASM_PREAMBLE			       \
 			       "tlbi " #op ", %x0\n"			       \
-		   ALTERNATIVE("nop\n			nop",		       \
-			       "dsb ish\n		tlbi " #op ", %x0",    \
-			       ARM64_WORKAROUND_REPEAT_TLBI,		       \
-			       CONFIG_ARM64_WORKAROUND_REPEAT_TLBI)	       \
 			    : : "rZ" (arg))
 
 #define __TLBI_N(op, arg, n, ...) __TLBI_##n(op, arg)
@@ -165,6 +157,34 @@ static inline unsigned long get_trans_granule(void)
 		(__pages >> (5 * (scale) + 1)) - 1;			\
 	})
 
+#define __repeat_tlbi_sync(op, arg...)						\
+do {										\
+	if (!alternative_has_cap_unlikely(ARM64_WORKAROUND_REPEAT_TLBI))	\
+		break;								\
+	__tlbi(op, ##arg);							\
+	dsb(ish);								\
+} while (0)
+
+/*
+ * Complete broadcast TLB maintenance issued by the host which invalidates
+ * stage 1 information in the host's own translation regime.
+ */
+static inline void __tlbi_sync_s1ish(void)
+{
+	dsb(ish);
+	__repeat_tlbi_sync(vale1is, 0);
+}
+
+/*
+ * Complete broadcast TLB maintenance issued by hyp code which invalidates
+ * stage 1 translation information in any translation regime.
+ */
+static inline void __tlbi_sync_s1ish_hyp(void)
+{
+	dsb(ish);
+	__repeat_tlbi_sync(vale2is, 0);
+}
+
 /*
  *	TLB Invalidation
  *	================
@@ -246,7 +266,7 @@ static inline void flush_tlb_all(void)
 {
 	dsb(ishst);
 	__tlbi(vmalle1is);
-	dsb(ish);
+	__tlbi_sync_s1ish();
 	isb();
 }
 
@@ -258,7 +278,7 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
 	asid = __TLBI_VADDR(0, ASID(mm));
 	__tlbi(aside1is, asid);
 	__tlbi_user(aside1is, asid);
-	dsb(ish);
+	__tlbi_sync_s1ish();
 	mmu_notifier_arch_invalidate_secondary_tlbs(mm, 0, -1UL);
 }
 
@@ -285,21 +305,11 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
 				  unsigned long uaddr)
 {
 	flush_tlb_page_nosync(vma, uaddr);
-	dsb(ish);
+	__tlbi_sync_s1ish();
 }
 
 static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
 {
-#ifdef CONFIG_ARM64_WORKAROUND_REPEAT_TLBI
-	/*
-	 * TLB flush deferral is not required on systems which are affected by
-	 * ARM64_WORKAROUND_REPEAT_TLBI, as __tlbi()/__tlbi_user() implementation
-	 * will have two consecutive TLBI instructions with a dsb(ish) in between
-	 * defeating the purpose (i.e save overall 'dsb ish' cost).
-	 */
-	if (unlikely(cpus_have_const_cap(ARM64_WORKAROUND_REPEAT_TLBI)))
-		return false;
-#endif
 	return true;
 }
 
@@ -333,7 +343,7 @@ static inline void arch_flush_tlb_batched_pending(struct mm_struct *mm)
  */
 static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 {
-	dsb(ish);
+	__tlbi_sync_s1ish();
 }
 
 /*
@@ -437,7 +447,7 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 	else
 		__flush_tlb_range_op(vae1is, start, pages, stride, asid, tlb_level, true);
 
-	dsb(ish);
+	__tlbi_sync_s1ish();
 	mmu_notifier_arch_invalidate_secondary_tlbs(vma->vm_mm, start, end);
 }
 
@@ -467,7 +477,7 @@ static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end
 	dsb(ishst);
 	for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12))
 		__tlbi(vaale1is, addr);
-	dsb(ish);
+	__tlbi_sync_s1ish();
 	isb();
 }
 
@@ -481,7 +491,7 @@ static inline void __flush_tlb_kernel_pgtable(unsigned long kaddr)
 
 	dsb(ishst);
 	__tlbi(vaae1is, addr);
-	dsb(ish);
+	__tlbi_sync_s1ish();
 	isb();
 }
 #endif
diff --git a/arch/arm64/kernel/sys_compat.c b/arch/arm64/kernel/sys_compat.c
index df14336c3a29c..2bc2ac91d79e3 100644
--- a/arch/arm64/kernel/sys_compat.c
+++ b/arch/arm64/kernel/sys_compat.c
@@ -37,7 +37,7 @@ __do_compat_cache_op(unsigned long start, unsigned long end)
 			 * We pick the reserved-ASID to minimise the impact.
 			 */
 			__tlbi(aside1is, __TLBI_VADDR(0, 0));
-			dsb(ish);
+			__tlbi_sync_s1ish();
 		}
 
 		ret = caches_clean_inval_user_pou(start, start + chunk);
diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index 65a7a186d7b21..4bb9da3381eaf 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -261,7 +261,7 @@ static void fixmap_clear_slot(struct hyp_fixmap_slot *slot)
 	 */
 	dsb(ishst);
 	__tlbi_level(vale2is, __TLBI_VADDR(addr, 0), (KVM_PGTABLE_MAX_LEVELS - 1));
-	dsb(ish);
+	__tlbi_sync_s1ish_hyp();
 	isb();
 }
 
diff --git a/arch/arm64/kvm/hyp/nvhe/tlb.c b/arch/arm64/kvm/hyp/nvhe/tlb.c
index a60fb13e21924..f03d4f7dbf443 100644
--- a/arch/arm64/kvm/hyp/nvhe/tlb.c
+++ b/arch/arm64/kvm/hyp/nvhe/tlb.c
@@ -102,7 +102,7 @@ void __kvm_tlb_flush_vmid_ipa(struct kvm_s2_mmu *mmu,
 	 */
 	dsb(ish);
 	__tlbi(vmalle1is);
-	dsb(ish);
+	__tlbi_sync_s1ish_hyp();
 	isb();
 
 	__tlb_switch_to_host(&cxt);
@@ -158,7 +158,7 @@ void __kvm_tlb_flush_vmid_range(struct kvm_s2_mmu *mmu,
 
 	dsb(ish);
 	__tlbi(vmalle1is);
-	dsb(ish);
+	__tlbi_sync_s1ish_hyp();
 	isb();
 
 	__tlb_switch_to_host(&cxt);
@@ -172,7 +172,7 @@ void __kvm_tlb_flush_vmid(struct kvm_s2_mmu *mmu)
 	__tlb_switch_to_guest(mmu, &cxt, false);
 
 	__tlbi(vmalls12e1is);
-	dsb(ish);
+	__tlbi_sync_s1ish_hyp();
 	isb();
 
 	__tlb_switch_to_host(&cxt);
@@ -198,5 +198,5 @@ void __kvm_flush_vm_context(void)
 	/* Same remark as in __tlb_switch_to_guest() */
 	dsb(ish);
 	__tlbi(alle1is);
-	dsb(ish);
+	__tlbi_sync_s1ish_hyp();
 }
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index ca0bf0b92ca09..4ec07236a68d2 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -534,7 +534,7 @@ static int hyp_unmap_walker(const struct kvm_pgtable_visit_ctx *ctx,
 		*unmapped += granule;
 	}
 
-	dsb(ish);
+	__tlbi_sync_s1ish_hyp();
 	isb();
 	mm_ops->put_page(ctx->ptep);
 
diff --git a/arch/arm64/kvm/hyp/vhe/tlb.c b/arch/arm64/kvm/hyp/vhe/tlb.c
index 23325e9f3cc38..af3a02b6b48b3 100644
--- a/arch/arm64/kvm/hyp/vhe/tlb.c
+++ b/arch/arm64/kvm/hyp/vhe/tlb.c
@@ -105,7 +105,7 @@ void __kvm_tlb_flush_vmid_ipa(struct kvm_s2_mmu *mmu,
 	 */
 	dsb(ish);
 	__tlbi(vmalle1is);
-	dsb(ish);
+	__tlbi_sync_s1ish_hyp();
 	isb();
 
 	__tlb_switch_to_host(&cxt);
@@ -165,7 +165,7 @@ void __kvm_tlb_flush_vmid_range(struct kvm_s2_mmu *mmu,
 
 	dsb(ish);
 	__tlbi(vmalle1is);
-	dsb(ish);
+	__tlbi_sync_s1ish_hyp();
 	isb();
 
 	__tlb_switch_to_host(&cxt);
@@ -181,7 +181,7 @@ void __kvm_tlb_flush_vmid(struct kvm_s2_mmu *mmu)
 	__tlb_switch_to_guest(mmu, &cxt);
 
 	__tlbi(vmalls12e1is);
-	dsb(ish);
+	__tlbi_sync_s1ish_hyp();
 	isb();
 
 	__tlb_switch_to_host(&cxt);
@@ -206,5 +206,5 @@ void __kvm_flush_vm_context(void)
 {
 	dsb(ishst);
 	__tlbi(alle1is);
-	dsb(ish);
+	__tlbi_sync_s1ish_hyp();
 }
-- 
2.30.2

