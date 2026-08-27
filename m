Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3158455163;
	Thu, 27 Aug 2026 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787835450; cv=none; b=m7GfWwXxhk3QsooLotcV9gfaOliL5OBBFHPoRwWgyGp9GjZfgsav/Jur+BXsRRUfmXHI80LyxCoXsgYd8gPGKbrk7Pd+H+utG2rH9jNgW1i+XRfghnvZLhT1jjTwbNYVhZCY5BrL4RKNdd1wGQt78t7ltPKHo3o8pquOU3hWwJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787835450; c=relaxed/simple;
	bh=e6/QBSyP47fTzS40B/76H5JQRDopX/QXY9E74a2icgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHnntMRs5fe5ZXk91BkFgFru4GDOrFm2u9hIwNLgitE65dvTYUSmIfIQtsNdLhKJ8ePHawb/d5FByLuSazsT0Jspo2CaluIK9609Wr4vaqraZKlAMYA2Zs+tPU2XbGWvSgRv3h6tFQNPrFKdhHNU0kDaIfQHx2l4t2hOVgVT4TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sbu9a26q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sbu9a26q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD251F00A3E;
	Thu, 27 Aug 2026 12:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787835414;
	bh=4Kb9B1KFBjdS/mwKMqS12FE3cDcHMbGbcgzZVwPuFk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sbu9a26qSJwZ2Qy+2iwhtN/QJ4dx6yIVTEVXiD0yZE7DWeS+5zIzcVTKkQMZ8AKlE
	 TBFyP0fJVxorDV/nntaxCxb1CDJoDQdcR0myw64/EU025zl5FhEgfSVWy5YLywgtR7
	 /dPFpcBsqnCGWB/sn/P2Q75l/j6ZEtz0SwvoKdZw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.218
Date: Thu, 27 Aug 2026 14:56:43 +0200
Message-ID: <2026082743-cable-affair-0560@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026082743-unhappily-famine-cfe4@gregkh>
References: <2026082743-unhappily-famine-cfe4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 4a3360de8431..9d11ba195a16 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 217
+SUBLEVEL = 218
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index db667b4ad103..7d04f9670644 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -881,7 +881,7 @@ transparent_hugepage_adjust(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		 * THP doesn't start to split while we are adjusting the
 		 * refcounts.
 		 *
-		 * We are sure this doesn't happen, because mmu_notifier_retry
+		 * We are sure this doesn't happen, because mmu_invalidate_retry
 		 * was successful and we are holding the mmu_lock, so if this
 		 * THP is trying to split, it will be blocked in the mmu
 		 * notifier before touching any of the pages, specifically
@@ -1074,14 +1074,14 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	gfn = fault_ipa >> PAGE_SHIFT;
 
 	/*
-	 * Read mmu_notifier_seq so that KVM can detect if the results of
+	 * Read mmu_invalidate_seq so that KVM can detect if the results of
 	 * vma_lookup() or __gfn_to_pfn_memslot() become stale prior to
 	 * acquiring kvm->mmu_lock.
 	 *
 	 * Rely on mmap_read_unlock() for an implicit smp_rmb(), which pairs
-	 * with the smp_wmb() in kvm_dec_notifier_count().
+	 * with the smp_wmb() in kvm_mmu_invalidate_end().
 	 */
-	mmu_seq = vcpu->kvm->mmu_notifier_seq;
+	mmu_seq = vcpu->kvm->mmu_invalidate_seq;
 	mmap_read_unlock(current->mm);
 
 	pfn = __gfn_to_pfn_memslot(memslot, gfn, false, NULL,
@@ -1118,7 +1118,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 
 	spin_lock(&kvm->mmu_lock);
 	pgt = vcpu->arch.hw_mmu->pgt;
-	if (mmu_notifier_retry(kvm, mmu_seq))
+	if (mmu_invalidate_retry(kvm, mmu_seq))
 		goto out_unlock;
 
 	/*
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 72b524945227..755b7a0a5595 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -615,17 +615,17 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
 	 * Used to check for invalidations in progress, of the pfn that is
 	 * returned by pfn_to_pfn_prot below.
 	 */
-	mmu_seq = kvm->mmu_notifier_seq;
+	mmu_seq = kvm->mmu_invalidate_seq;
 	/*
-	 * Ensure the read of mmu_notifier_seq isn't reordered with PTE reads in
-	 * gfn_to_pfn_prot() (which calls get_user_pages()), so that we don't
+	 * Ensure the read of mmu_invalidate_seq isn't reordered with PTE reads
+	 * in gfn_to_pfn_prot() (which calls get_user_pages()), so that we don't
 	 * risk the page we get a reference to getting unmapped before we have a
-	 * chance to grab the mmu_lock without mmu_notifier_retry() noticing.
+	 * chance to grab the mmu_lock without mmu_invalidate_retry() noticing.
 	 *
 	 * This smp_rmb() pairs with the effective smp_wmb() of the combination
 	 * of the pte_unmap_unlock() after the PTE is zapped, and the
 	 * spin_lock() in kvm_mmu_notifier_invalidate_<page|range_end>() before
-	 * mmu_notifier_seq is incremented.
+	 * mmu_invalidate_seq is incremented.
 	 */
 	smp_rmb();
 
@@ -638,7 +638,7 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
 
 	spin_lock(&kvm->mmu_lock);
 	/* Check if an invalidation has taken place since we got pfn */
-	if (mmu_notifier_retry(kvm, mmu_seq)) {
+	if (mmu_invalidate_retry(kvm, mmu_seq)) {
 		/*
 		 * This can happen when mappings are changed asynchronously, but
 		 * also synchronously if a COW is triggered by
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index eaf3a562bf1e..0b418df7e3f8 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -673,7 +673,7 @@ static inline pte_t *find_kvm_host_pte(struct kvm *kvm, unsigned long mmu_seq,
 	VM_WARN(!spin_is_locked(&kvm->mmu_lock),
 		"%s called with kvm mmu_lock not held \n", __func__);
 
-	if (mmu_notifier_retry(kvm, mmu_seq))
+	if (mmu_invalidate_retry(kvm, mmu_seq))
 		return NULL;
 
 	pte = __find_linux_pte(kvm->mm->pgd, ea, NULL, hshift);
diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index c3e31fef0be1..1d0f3f9d8508 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -90,7 +90,7 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte,
 	unsigned long pfn;
 
 	/* used to check for invalidations in progress */
-	mmu_seq = kvm->mmu_notifier_seq;
+	mmu_seq = kvm->mmu_invalidate_seq;
 	smp_rmb();
 
 	/* Get host physical address for gpa */
@@ -151,7 +151,7 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte,
 	cpte = kvmppc_mmu_hpte_cache_next(vcpu);
 
 	spin_lock(&kvm->mmu_lock);
-	if (!cpte || mmu_notifier_retry(kvm, mmu_seq)) {
+	if (!cpte || mmu_invalidate_retry(kvm, mmu_seq)) {
 		r = -EAGAIN;
 		goto out_unlock;
 	}
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index c63e263312a4..42cc2de2e3b5 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -570,7 +570,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_vcpu *vcpu,
 		return -EFAULT;
 
 	/* used to check for invalidations in progress */
-	mmu_seq = kvm->mmu_notifier_seq;
+	mmu_seq = kvm->mmu_invalidate_seq;
 	smp_rmb();
 
 	ret = -EFAULT;
@@ -685,7 +685,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_vcpu *vcpu,
 
 	/* Check if we might have been invalidated; let the guest retry if so */
 	ret = RESUME_GUEST;
-	if (mmu_notifier_retry(vcpu->kvm, mmu_seq)) {
+	if (mmu_invalidate_retry(vcpu->kvm, mmu_seq)) {
 		unlock_rmap(rmap);
 		goto out_unlock;
 	}
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 16359525a40f..6dc8dad1be99 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -634,7 +634,7 @@ int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
 	/* Check if we might have been invalidated; let the guest retry if so */
 	spin_lock(&kvm->mmu_lock);
 	ret = -EAGAIN;
-	if (mmu_notifier_retry(kvm, mmu_seq))
+	if (mmu_invalidate_retry(kvm, mmu_seq))
 		goto out_unlock;
 
 	/* Now traverse again under the lock and change the tree */
@@ -824,7 +824,7 @@ int kvmppc_book3s_instantiate_page(struct kvm_vcpu *vcpu,
 	bool large_enable;
 
 	/* used to check for invalidations in progress */
-	mmu_seq = kvm->mmu_notifier_seq;
+	mmu_seq = kvm->mmu_invalidate_seq;
 	smp_rmb();
 
 	/*
@@ -1185,7 +1185,7 @@ void kvmppc_radix_flush_memslot(struct kvm *kvm,
 	 * Increase the mmu notifier sequence number to prevent any page
 	 * fault that read the memslot earlier from writing a PTE.
 	 */
-	kvm->mmu_notifier_seq++;
+	kvm->mmu_invalidate_seq++;
 	spin_unlock(&kvm->mmu_lock);
 }
 
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index fdeda6a9cff4..26ee88843f76 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -499,7 +499,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	/*
 	 * used to check for invalidations in progress
 	 */
-	mmu_seq = kvm->mmu_notifier_seq;
+	mmu_seq = kvm->mmu_invalidate_seq;
 	smp_rmb();
 
 	stt = kvmppc_find_table(vcpu->kvm, liobn);
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index ddea14e5cb5e..e31b3c20a9d4 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -1574,7 +1574,7 @@ static long int __kvmhv_nested_page_fault(struct kvm_vcpu *vcpu,
 	/* 2. Find the host pte for this L1 guest real address */
 
 	/* Used to check for invalidations in progress */
-	mmu_seq = kvm->mmu_notifier_seq;
+	mmu_seq = kvm->mmu_invalidate_seq;
 	smp_rmb();
 
 	/* See if can find translation in our partition scoped tables for L1 */
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 632b2545072b..95fb2965945f 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -216,7 +216,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 	g_ptel = ptel;
 
 	/* used later to detect if we might have been invalidated */
-	mmu_seq = kvm->mmu_notifier_seq;
+	mmu_seq = kvm->mmu_invalidate_seq;
 	smp_rmb();
 
 	/* Find the memslot (if any) for this address */
@@ -363,7 +363,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 			rmap = real_vmalloc_addr(rmap);
 		lock_rmap(rmap);
 		/* Check for pending invalidations under the rmap chain lock */
-		if (mmu_notifier_retry(kvm, mmu_seq)) {
+		if (mmu_invalidate_retry(kvm, mmu_seq)) {
 			/* inval in progress, write a non-present HPTE */
 			pteh |= HPTE_V_ABSENT;
 			pteh &= ~HPTE_V_VALID;
@@ -929,7 +929,7 @@ static long kvmppc_do_h_page_init_zero(struct kvm_vcpu *vcpu,
 	int i;
 
 	/* Used later to detect if we might have been invalidated */
-	mmu_seq = kvm->mmu_notifier_seq;
+	mmu_seq = kvm->mmu_invalidate_seq;
 	smp_rmb();
 
 	arch_spin_lock(&kvm->mmu_lock.rlock.raw_lock);
@@ -957,7 +957,7 @@ static long kvmppc_do_h_page_init_copy(struct kvm_vcpu *vcpu,
 	long ret = H_SUCCESS;
 
 	/* Used later to detect if we might have been invalidated */
-	mmu_seq = kvm->mmu_notifier_seq;
+	mmu_seq = kvm->mmu_invalidate_seq;
 	smp_rmb();
 
 	arch_spin_lock(&kvm->mmu_lock.rlock.raw_lock);
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index 7f16afc331ef..05668e964140 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -339,7 +339,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 	unsigned long flags;
 
 	/* used to check for invalidations in progress */
-	mmu_seq = kvm->mmu_notifier_seq;
+	mmu_seq = kvm->mmu_invalidate_seq;
 	smp_rmb();
 
 	/*
@@ -460,7 +460,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 	}
 
 	spin_lock(&kvm->mmu_lock);
-	if (mmu_notifier_retry(kvm, mmu_seq)) {
+	if (mmu_invalidate_retry(kvm, mmu_seq)) {
 		ret = -EAGAIN;
 		goto out;
 	}
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 84eeed9a9615..c0257bbb25c3 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -999,15 +999,16 @@ static void __pte_list_remove(u64 *spte, struct kvm_rmap_head *rmap_head)
 	}
 }
 
-static void pte_list_remove(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
-			    u64 *sptep)
+static void kvm_zap_one_rmap_spte(struct kvm *kvm,
+				  struct kvm_rmap_head *rmap_head, u64 *sptep)
 {
 	mmu_spte_clear_track_bits(kvm, sptep);
 	__pte_list_remove(sptep, rmap_head);
 }
 
-/* Return true if rmap existed, false otherwise */
-static bool pte_list_destroy(struct kvm *kvm, struct kvm_rmap_head *rmap_head)
+/* Return true if at least one SPTE was zapped, false otherwise */
+static bool kvm_zap_all_rmap_sptes(struct kvm *kvm,
+				   struct kvm_rmap_head *rmap_head)
 {
 	struct pte_list_desc *desc, *next;
 	int i;
@@ -1434,7 +1435,7 @@ static bool rmap_write_protect(struct kvm_vcpu *vcpu, u64 gfn)
 static bool kvm_zap_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 			  const struct kvm_memory_slot *slot)
 {
-	return pte_list_destroy(kvm, rmap_head);
+	return kvm_zap_all_rmap_sptes(kvm, rmap_head);
 }
 
 static bool kvm_unmap_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
@@ -1465,7 +1466,7 @@ static bool kvm_set_pte_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 		need_flush = 1;
 
 		if (pte_write(pte)) {
-			pte_list_remove(kvm, rmap_head, sptep);
+			kvm_zap_one_rmap_spte(kvm, rmap_head, sptep);
 			goto restart;
 		} else {
 			new_spte = kvm_mmu_changed_pte_notifier_make_spte(
@@ -1639,7 +1640,7 @@ static void rmap_add(struct kvm_vcpu *vcpu, u64 *spte, gfn_t gfn)
 	rmap_count = pte_list_add(vcpu, spte, rmap_head);
 
 	if (rmap_count > RMAP_RECYCLE_THRESHOLD) {
-		kvm_unmap_rmapp(vcpu->kvm, rmap_head, NULL, gfn, sp->role.level, __pte(0));
+		kvm_zap_all_rmap_sptes(vcpu->kvm, rmap_head);
 		kvm_flush_remote_tlbs_with_address(
 				vcpu->kvm, sp->gfn, KVM_PAGES_PER_HPAGE(sp->role.level));
 	}
@@ -1942,7 +1943,11 @@ static void mmu_audit_disable(void) { }
 
 static bool is_obsolete_sp(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
-	return sp->role.invalid ||
+	if (sp->role.invalid)
+		return true;
+
+	/* TDP MMU pages due not use the MMU generation. */
+	return !sp->tdp_mmu_page &&
 	       unlikely(sp->mmu_valid_gen != kvm->arch.mmu_valid_gen);
 }
 
@@ -2862,12 +2867,37 @@ static void direct_pte_prefetch(struct kvm_vcpu *vcpu, u64 *sptep)
 	 * If addresses are being invalidated, skip prefetching to avoid
 	 * accidentally prefetching those addresses.
 	 */
-	if (unlikely(vcpu->kvm->mmu_notifier_count))
+	if (unlikely(vcpu->kvm->mmu_invalidate_in_progress))
 		return;
 
 	__direct_pte_prefetch(vcpu, sp, sptep);
 }
 
+/*
+ * Lookup the mapping level for @gfn in the current mm.
+ *
+ * WARNING!  Use of host_pfn_mapping_level() requires the caller and the end
+ * consumer to be tied into KVM's handlers for MMU notifier events!
+ *
+ * There are several ways to safely use this helper:
+ *
+ * - Check mmu_invalidate_retry_hva() after grabbing the mapping level, before
+ *   consuming it.  In this case, mmu_lock doesn't need to be held during the
+ *   lookup, but it does need to be held while checking the MMU notifier.
+ *
+ * - Hold mmu_lock AND ensure there is no in-progress MMU notifier invalidation
+ *   event for the hva.  This can be done by explicit checking the MMU notifier
+ *   or by ensuring that KVM already has a valid mapping that covers the hva.
+ *
+ * - Do not use the result to install new mappings, e.g. use the host mapping
+ *   level only to decide whether or not to zap an entry.  In this case, it's
+ *   not required to hold mmu_lock (though it's highly likely the caller will
+ *   want to hold mmu_lock anyways, e.g. to modify SPTEs).
+ *
+ * Note!  The lookup can still race with modifications to host page tables, but
+ * the above "rules" ensure KVM will not _consume_ the result of the walk if a
+ * race with the primary MMU occurs.
+ */
 static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 				  const struct kvm_memory_slot *slot)
 {
@@ -2946,7 +2976,7 @@ int kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, gfn_t gfn,
 		return PG_LEVEL_4K;
 
 	/*
-	 * mmu_notifier_retry() was successful and mmu_lock is held, so
+	 * mmu_invalidate_retry() was successful and mmu_lock is held, so
 	 * the pmd can't be split from under us.
 	 */
 	mask = KVM_PAGES_PER_HPAGE(level) - 1;
@@ -2965,11 +2995,11 @@ void disallowed_hugepage_adjust(u64 spte, gfn_t gfn, int cur_level,
 	    is_shadow_present_pte(spte) &&
 	    !is_large_pte(spte)) {
 		/*
-		 * A small SPTE exists for this pfn, but FNAME(fetch)
-		 * and __direct_map would like to create a large PTE
-		 * instead: just force them to go down another level,
-		 * patching back for them into pfn the next 9 bits of
-		 * the address.
+		 * A small SPTE exists for this pfn, but FNAME(fetch),
+		 * direct_map(), or kvm_tdp_mmu_map() would like to create a
+		 * large PTE instead: just force them to go down another level,
+		 * patching back for them into pfn the next 9 bits of the
+		 * address.
 		 */
 		u64 page_mask = KVM_PAGES_PER_HPAGE(level) -
 				KVM_PAGES_PER_HPAGE(level - 1);
@@ -2978,9 +3008,9 @@ void disallowed_hugepage_adjust(u64 spte, gfn_t gfn, int cur_level,
 	}
 }
 
-static int __direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
-			int map_writable, int max_level, kvm_pfn_t pfn,
-			bool prefault, bool is_tdp)
+static int direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
+		      int map_writable, int max_level, kvm_pfn_t pfn,
+		      bool prefault, bool is_tdp)
 {
 	bool nx_huge_page_workaround_enabled = is_nx_huge_page_enabled();
 	bool write = error_code & PFERR_WRITE_MASK;
@@ -3968,10 +3998,37 @@ static bool kvm_faultin_pfn(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
 	return true;
 }
 
+/*
+ * Returns true if the page fault is stale and needs to be retried, i.e. if the
+ * root was invalidated by a memslot update or a relevant mmu_notifier fired.
+ */
+static bool is_page_fault_stale(struct kvm_vcpu *vcpu,
+				kvm_pfn_t pfn, unsigned long mmu_seq, hva_t hva)
+{
+	struct kvm_mmu_page *sp = to_shadow_page(vcpu->arch.mmu->root_hpa);
+
+	/* Special roots, e.g. pae_root, are not backed by shadow pages. */
+	if (sp && is_obsolete_sp(vcpu->kvm, sp))
+		return true;
+
+	/*
+	 * Roots without an associated shadow page are considered invalid if
+	 * there is a pending request to free obsolete roots.  The request is
+	 * only a hint that the current root _may_ be obsolete and needs to be
+	 * reloaded, e.g. if the guest frees a PGD that KVM is tracking as a
+	 * previous root, then __kvm_mmu_prepare_zap_page() signals all vCPUs
+	 * to reload even if no vCPU is actively using the root.
+	 */
+	if (!sp && kvm_test_request(KVM_REQ_MMU_RELOAD, vcpu))
+		return true;
+
+	return !is_noslot_pfn(pfn) &&
+	       mmu_invalidate_retry_hva(vcpu->kvm, mmu_seq, hva);
+}
+
 static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 			     bool prefault, int max_level, bool is_tdp)
 {
-	bool is_tdp_mmu_fault = is_tdp_mmu(vcpu->arch.mmu);
 	bool write = error_code & PFERR_WRITE_MASK;
 	bool map_writable;
 
@@ -3992,7 +4049,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 	if (r)
 		return r;
 
-	mmu_seq = vcpu->kvm->mmu_notifier_seq;
+	mmu_seq = vcpu->kvm->mmu_invalidate_seq;
 	smp_rmb();
 
 	if (kvm_faultin_pfn(vcpu, prefault, gfn, gpa, &pfn, &hva,
@@ -4002,32 +4059,22 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 	if (handle_abnormal_pfn(vcpu, is_tdp ? 0 : gpa, gfn, pfn, ACC_ALL, &r))
 		return r;
 
-	r = RET_PF_RETRY;
-
-	if (is_tdp_mmu_fault)
-		read_lock(&vcpu->kvm->mmu_lock);
-	else
-		write_lock(&vcpu->kvm->mmu_lock);
+	write_lock(&vcpu->kvm->mmu_lock);
 
-	if (!is_noslot_pfn(pfn) && mmu_notifier_retry_hva(vcpu->kvm, mmu_seq, hva))
+	r = make_mmu_pages_available(vcpu);
+	if (r)
 		goto out_unlock;
 
-	if (is_tdp_mmu_fault) {
-		r = kvm_tdp_mmu_map(vcpu, gpa, error_code, map_writable, max_level,
-				    pfn, prefault);
-	} else {
-		r = make_mmu_pages_available(vcpu);
-		if (r)
-			goto out_unlock;
-		r = __direct_map(vcpu, gpa, error_code, map_writable, max_level, pfn,
-				 prefault, is_tdp);
+	if (is_page_fault_stale(vcpu, pfn, mmu_seq, hva)) {
+		r = RET_PF_RETRY;
+		goto out_unlock;
 	}
 
+	r = direct_map(vcpu, gpa, error_code, map_writable, max_level, pfn,
+		       prefault, is_tdp);
+
 out_unlock:
-	if (is_tdp_mmu_fault)
-		read_unlock(&vcpu->kvm->mmu_lock);
-	else
-		write_unlock(&vcpu->kvm->mmu_lock);
+	write_unlock(&vcpu->kvm->mmu_lock);
 	kvm_release_pfn_clean(pfn);
 	return r;
 }
@@ -4075,6 +4122,56 @@ int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
 }
 EXPORT_SYMBOL_GPL(kvm_handle_page_fault);
 
+#ifdef CONFIG_X86_64
+static int kvm_tdp_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa,
+				  u32 error_code, bool prefault, int max_level)
+{
+	bool write = error_code & PFERR_WRITE_MASK;
+	bool map_writable;
+
+	gfn_t gfn = gpa >> PAGE_SHIFT;
+	unsigned long mmu_seq;
+	kvm_pfn_t pfn;
+	hva_t hva;
+	int r;
+
+	if (page_fault_handle_page_track(vcpu, error_code, gfn))
+		return RET_PF_EMULATE;
+
+	r = fast_page_fault(vcpu, gpa, error_code);
+	if (r != RET_PF_INVALID)
+		return r;
+
+	r = mmu_topup_memory_caches(vcpu, false);
+	if (r)
+		return r;
+
+	mmu_seq = vcpu->kvm->mmu_invalidate_seq;
+	smp_rmb();
+
+	if (kvm_faultin_pfn(vcpu, prefault, gfn, gpa, &pfn, &hva,
+			 write, &map_writable, &r))
+		return r;
+
+	if (handle_abnormal_pfn(vcpu, 0, gfn, pfn, ACC_ALL, &r))
+		return r;
+
+	r = RET_PF_RETRY;
+	read_lock(&vcpu->kvm->mmu_lock);
+
+	if (is_page_fault_stale(vcpu, pfn, mmu_seq, hva))
+		goto out_unlock;
+
+	r = kvm_tdp_mmu_map(vcpu, gpa, error_code, map_writable, max_level,
+			    pfn, prefault);
+
+out_unlock:
+	read_unlock(&vcpu->kvm->mmu_lock);
+	kvm_release_pfn_clean(pfn);
+	return r;
+}
+#endif
+
 int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 		       bool prefault)
 {
@@ -4090,6 +4187,12 @@ int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 			break;
 	}
 
+#ifdef CONFIG_X86_64
+	if (is_tdp_mmu(vcpu->arch.mmu))
+		return kvm_tdp_mmu_page_fault(vcpu, gpa, error_code, prefault,
+					      max_level);
+#endif
+
 	return direct_page_fault(vcpu, gpa, error_code, prefault,
 				 max_level, true);
 }
@@ -5741,7 +5844,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 
 	write_lock(&kvm->mmu_lock);
 
-	kvm_inc_notifier_count(kvm, gfn_start, gfn_end);
+	kvm_mmu_invalidate_begin(kvm, gfn_start, gfn_end);
 
 	if (kvm_memslots_have_rmaps(kvm)) {
 		for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
@@ -5776,7 +5879,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 		kvm_flush_remote_tlbs_with_address(kvm, gfn_start,
 						   gfn_end - gfn_start);
 
-	kvm_dec_notifier_count(kvm, gfn_start, gfn_end);
+	kvm_mmu_invalidate_end(kvm, gfn_start, gfn_end);
 
 	write_unlock(&kvm->mmu_lock);
 }
@@ -5855,7 +5958,7 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
 		    !kvm_is_reserved_pfn(pfn) &&
 		    sp->role.level < kvm_mmu_max_mapping_level(kvm, slot, sp->gfn,
 							       pfn, PG_LEVEL_NUM)) {
-			pte_list_remove(kvm, rmap_head, sptep);
+			kvm_zap_one_rmap_spte(kvm, rmap_head, sptep);
 
 			if (kvm_available_flush_tlb_with_range())
 				kvm_flush_remote_tlbs_with_address(kvm, sp->gfn,
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index a1811f51eda9..fd3f2c5bb7ed 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -634,7 +634,7 @@ static void FNAME(pte_prefetch)(struct kvm_vcpu *vcpu, struct guest_walker *gw,
 	 * If addresses are being invalidated, skip prefetching to avoid
 	 * accidentally prefetching those addresses.
 	 */
-	if (unlikely(vcpu->kvm->mmu_notifier_count))
+	if (unlikely(vcpu->kvm->mmu_invalidate_in_progress))
 		return;
 
 	if (sp->role.direct)
@@ -894,7 +894,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
 	else
 		max_level = walker.level;
 
-	mmu_seq = vcpu->kvm->mmu_notifier_seq;
+	mmu_seq = vcpu->kvm->mmu_invalidate_seq;
 	smp_rmb();
 
 	if (kvm_faultin_pfn(vcpu, prefault, walker.gfn, addr, &pfn, &hva,
@@ -923,15 +923,18 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
 			walker.pte_access &= ~ACC_EXEC_MASK;
 	}
 
-	r = RET_PF_RETRY;
 	write_lock(&vcpu->kvm->mmu_lock);
-	if (!is_noslot_pfn(pfn) && mmu_notifier_retry_hva(vcpu->kvm, mmu_seq, hva))
-		goto out_unlock;
 
 	kvm_mmu_audit(vcpu, AUDIT_PRE_PAGE_FAULT);
 	r = make_mmu_pages_available(vcpu);
 	if (r)
 		goto out_unlock;
+
+	if (is_page_fault_stale(vcpu, pfn, mmu_seq, hva)) {
+		r = RET_PF_RETRY;
+		goto out_unlock;
+	}
+
 	r = FNAME(fetch)(vcpu, addr, &walker, error_code, max_level, pfn,
 			 map_writable, prefault);
 	kvm_mmu_audit(vcpu, AUDIT_POST_PAGE_FAULT);
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 174d93a84137..e41ec5096a63 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -13,6 +13,8 @@ static inline sector_t mb_to_sects(unsigned long mb)
 
 static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
 {
+	if (WARN_ON_ONCE(!dev->zone_size_sects))
+		return 0;
 	return sect >> ilog2(dev->zone_size_sects);
 }
 
@@ -62,8 +64,8 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	sector_t sector = 0;
 	unsigned int i;
 
-	if (!is_power_of_2(dev->zone_size)) {
-		pr_err("zone_size must be power-of-two\n");
+	if (!dev->zone_size || !is_power_of_2(dev->zone_size)) {
+		pr_err("zone_size must be non-zero power-of-two\n");
 		return -EINVAL;
 	}
 	if (dev->zone_size > dev->size) {
@@ -94,6 +96,10 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	zone_capacity_sects = mb_to_sects(dev->zone_capacity);
 	dev_capacity_sects = mb_to_sects(dev->size);
 	dev->zone_size_sects = mb_to_sects(dev->zone_size);
+	if (!dev->zone_size_sects) {
+		pr_err("zone_size too large or too small, leads to zero sectors\n");
+		return -EINVAL;
+	}
 	dev->nr_zones = round_up(dev_capacity_sects, dev->zone_size_sects)
 		>> ilog2(dev->zone_size_sects);
 
diff --git a/drivers/gpio/gpio-ml-ioh.c b/drivers/gpio/gpio-ml-ioh.c
index efa9acdc320a..83c2fd4f21e5 100644
--- a/drivers/gpio/gpio-ml-ioh.c
+++ b/drivers/gpio/gpio-ml-ioh.c
@@ -84,7 +84,7 @@ struct ioh_gpio {
 	u32 gpio_use_sel;
 	int ch;
 	int irq_base;
-	spinlock_t spinlock;
+	raw_spinlock_t spinlock;
 };
 
 static const int num_ports[] = {6, 12, 16, 16, 15, 16, 16, 12};
@@ -95,7 +95,7 @@ static void ioh_gpio_set(struct gpio_chip *gpio, unsigned nr, int val)
 	struct ioh_gpio *chip =	gpiochip_get_data(gpio);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	reg_val = ioread32(&chip->reg->regs[chip->ch].po);
 	if (val)
 		reg_val |= (1 << nr);
@@ -103,7 +103,7 @@ static void ioh_gpio_set(struct gpio_chip *gpio, unsigned nr, int val)
 		reg_val &= ~(1 << nr);
 
 	iowrite32(reg_val, &chip->reg->regs[chip->ch].po);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 }
 
 static int ioh_gpio_get(struct gpio_chip *gpio, unsigned nr)
@@ -121,7 +121,7 @@ static int ioh_gpio_direction_output(struct gpio_chip *gpio, unsigned nr,
 	u32 reg_val;
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	pm = ioread32(&chip->reg->regs[chip->ch].pm) &
 					((1 << num_ports[chip->ch]) - 1);
 	pm |= (1 << nr);
@@ -134,7 +134,7 @@ static int ioh_gpio_direction_output(struct gpio_chip *gpio, unsigned nr,
 		reg_val &= ~(1 << nr);
 	iowrite32(reg_val, &chip->reg->regs[chip->ch].po);
 
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
@@ -145,12 +145,12 @@ static int ioh_gpio_direction_input(struct gpio_chip *gpio, unsigned nr)
 	u32 pm;
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	pm = ioread32(&chip->reg->regs[chip->ch].pm) &
 				((1 << num_ports[chip->ch]) - 1);
 	pm &= ~(1 << nr);
 	iowrite32(pm, &chip->reg->regs[chip->ch].pm);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
@@ -254,7 +254,7 @@ static int ioh_irq_type(struct irq_data *d, unsigned int type)
 	dev_dbg(chip->dev, "%s:irq=%d type=%d ch=%d pos=%d type=%d\n",
 		__func__, irq, type, ch, im_pos, type);
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -294,7 +294,7 @@ static int ioh_irq_type(struct irq_data *d, unsigned int type)
 	ien = ioread32(&chip->reg->regs[chip->ch].ien);
 	iowrite32(ien | BIT(ch), &chip->reg->regs[chip->ch].ien);
 end:
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
@@ -324,11 +324,11 @@ static void ioh_irq_disable(struct irq_data *d)
 	unsigned long flags;
 	u32 ien;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	ien = ioread32(&chip->reg->regs[chip->ch].ien);
 	ien &= ~(1 << (d->irq - chip->irq_base));
 	iowrite32(ien, &chip->reg->regs[chip->ch].ien);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 }
 
 static void ioh_irq_enable(struct irq_data *d)
@@ -338,11 +338,11 @@ static void ioh_irq_enable(struct irq_data *d)
 	unsigned long flags;
 	u32 ien;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	ien = ioread32(&chip->reg->regs[chip->ch].ien);
 	ien |= 1 << (d->irq - chip->irq_base);
 	iowrite32(ien, &chip->reg->regs[chip->ch].ien);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 }
 
 static irqreturn_t ioh_gpio_handler(int irq, void *dev_id)
@@ -439,7 +439,7 @@ static int ioh_gpio_probe(struct pci_dev *pdev,
 		chip->base = base;
 		chip->reg = chip->base;
 		chip->ch = i;
-		spin_lock_init(&chip->spinlock);
+		raw_spin_lock_init(&chip->spinlock);
 		ioh_gpio_setup(chip, num_ports[i]);
 		ret = gpiochip_add_data(&chip->gpio, chip);
 		if (ret) {
@@ -525,9 +525,9 @@ static int __maybe_unused ioh_gpio_suspend(struct device *dev)
 	struct ioh_gpio *chip = dev_get_drvdata(dev);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	ioh_gpio_save_reg_conf(chip);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
@@ -537,11 +537,11 @@ static int __maybe_unused ioh_gpio_resume(struct device *dev)
 	struct ioh_gpio *chip = dev_get_drvdata(dev);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	iowrite32(0x01, &chip->reg->srst);
 	iowrite32(0x00, &chip->reg->srst);
 	ioh_gpio_restore_reg_conf(chip);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7f5083814749..d94d02844c64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1352,6 +1352,31 @@ bool amdgpu_device_pcie_dynamic_switching_supported(void)
 	return true;
 }
 
+/*
+ * Some dGPUs expose their display endpoint below an internal PCIe switch.
+ * Use the switch upstream port to query the host-facing link.
+ */
+static struct pci_dev *amdgpu_device_get_aspm_pdev(struct amdgpu_device *adev)
+{
+	struct pci_dev *swds, *swus;
+
+	swds = pci_upstream_bridge(adev->pdev);
+	if (!swds ||
+	    (swds->vendor != PCI_VENDOR_ID_ATI &&
+	     swds->vendor != PCI_VENDOR_ID_AMD) ||
+	    pci_pcie_type(swds) != PCI_EXP_TYPE_DOWNSTREAM)
+		return adev->pdev;
+
+	swus = pci_upstream_bridge(swds);
+	if (!swus ||
+	    (swus->vendor != PCI_VENDOR_ID_ATI &&
+	     swus->vendor != PCI_VENDOR_ID_AMD) ||
+	    pci_pcie_type(swus) != PCI_EXP_TYPE_UPSTREAM)
+		return adev->pdev;
+
+	return swus;
+}
+
 /**
  * amdgpu_device_should_use_aspm - check if the device should program ASPM
  *
@@ -1364,6 +1389,9 @@ bool amdgpu_device_pcie_dynamic_switching_supported(void)
  */
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 {
+	struct pci_dev *aspm_pdev, *parent;
+	bool enabled;
+
 	switch (amdgpu_aspm) {
 	case -1:
 		break;
@@ -1374,7 +1402,27 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 	default:
 		return false;
 	}
-	return pcie_aspm_enabled(adev->pdev);
+
+	/*
+	 * pcie_aspm_enabled() checks the link between its argument and
+	 * the immediate upstream bridge. Use SWUS for dGPUs with an
+	 * internal switch so that this is the host-facing link.
+	 */
+	aspm_pdev = amdgpu_device_get_aspm_pdev(adev);
+	parent = pci_upstream_bridge(aspm_pdev);
+	if (!parent) {
+		dev_dbg(adev->dev, "ASPM: no upstream PCIe link for %s\n",
+			pci_name(aspm_pdev));
+		return false;
+	}
+
+	enabled = pcie_aspm_enabled(aspm_pdev);
+	/* Report the exact link used for the automatic ASPM decision. */
+	dev_dbg(adev->dev, "ASPM: link %s <-> %s is %s\n",
+		pci_name(parent), pci_name(aspm_pdev),
+		enabled ? "enabled" : "disabled");
+
+	return enabled;
 }
 
 bool amdgpu_device_aspm_support_quirk(void)
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index c201055f9332..7144bd2c1153 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -346,6 +346,9 @@ static int hid_add_field(struct hid_parser *parser, unsigned report_type, unsign
 
 static u32 item_udata(struct hid_item *item)
 {
+	if (item->format != HID_ITEM_FORMAT_SHORT)
+		return 0;
+
 	switch (item->size) {
 	case 1: return item->data.u8;
 	case 2: return item->data.u16;
@@ -356,6 +359,9 @@ static u32 item_udata(struct hid_item *item)
 
 static s32 item_sdata(struct hid_item *item)
 {
+	if (item->format != HID_ITEM_FORMAT_SHORT)
+		return 0;
+
 	switch (item->size) {
 	case 1: return item->data.s8;
 	case 2: return item->data.s16;
@@ -1696,13 +1702,14 @@ int hid_set_field(struct hid_field *field, unsigned offset, __s32 value)
 
 	size = field->report_size;
 
-	hid_dump_input(field->report->device, field->usage + offset, value);
-
 	if (offset >= field->report_count) {
 		hid_err(field->report->device, "offset (%d) exceeds report_count (%d)\n",
 				offset, field->report_count);
 		return -1;
 	}
+
+	hid_dump_input(field->report->device, field->usage + offset, value);
+
 	if (field->logical_minimum < 0) {
 		if (value != snto32(s32ton(value, size), size)) {
 			hid_err(field->report->device, "value %d is out of range\n", value);
diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index bf77cfb723d5..b9f64e374488 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -179,18 +179,32 @@ static void mousevsc_free_device(struct mousevsc_dev *device)
 }
 
 static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
-				struct synthhid_device_info *device_info)
+					    struct synthhid_device_info *device_info,
+					    u32 device_info_size)
 {
 	int ret = 0;
 	struct hid_descriptor *desc;
 	struct mousevsc_prt_msg ack;
+	size_t desc_offset;
+	size_t desc_size;
 
 	input_device->dev_info_status = -ENOMEM;
 
+	if (device_info_size < sizeof(*device_info)) {
+		input_device->dev_info_status = -EINVAL;
+		goto cleanup;
+	}
+
 	input_device->hid_dev_info = device_info->hid_dev_info;
 	desc = &device_info->hid_descriptor;
+	desc_offset = offsetof(struct synthhid_device_info, hid_descriptor);
+	desc_size = device_info_size - desc_offset;
 	if (desc->bLength == 0)
 		goto cleanup;
+	if (desc->bLength < sizeof(*desc) || desc->bLength > desc_size) {
+		input_device->dev_info_status = -EINVAL;
+		goto cleanup;
+	}
 
 	/* The pointer is not NULL when we resume from hibernation */
 	kfree(input_device->hid_desc);
@@ -205,6 +219,10 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 		input_device->dev_info_status = -EINVAL;
 		goto cleanup;
 	}
+	if (input_device->report_desc_size > desc_size - desc->bLength) {
+		input_device->dev_info_status = -EINVAL;
+		goto cleanup;
+	}
 
 	/* The pointer is not NULL when we resume from hibernation */
 	kfree(input_device->report_desc);
@@ -285,14 +303,17 @@ static void mousevsc_on_receive(struct hv_device *device,
 		break;
 
 	case SYNTH_HID_INITIAL_DEVICE_INFO:
-		WARN_ON(pipe_msg->size < sizeof(struct hv_input_dev_info));
+		if (WARN_ON_ONCE(pipe_msg->size <
+				 sizeof(struct synthhid_device_info)))
+			break;
 
 		/*
 		 * Parse out the device info into device attr,
 		 * hid desc and report desc
 		 */
 		mousevsc_on_receive_device_info(input_dev,
-			(struct synthhid_device_info *)pipe_msg->data);
+						(struct synthhid_device_info *)pipe_msg->data,
+						pipe_msg->size);
 		break;
 	case SYNTH_HID_INPUT_REPORT:
 		input_report =
diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 2eda56779b4c..52ae2102d4ec 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -375,6 +375,10 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 	struct input_dev *input = msc->input;
 	int x = 0, y = 0, ii, clicks = 0, npoints;
 
+	/* Protect against zero sized recursive calls from DOUBLE_REPORT_ID */
+	if (size < 1)
+		return 0;
+
 	switch (data[0]) {
 	case TRACKPAD_REPORT_ID:
 	case TRACKPAD2_BT_REPORT_ID:
@@ -475,6 +479,18 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 		/* Sometimes the trackpad sends two touch reports in one
 		 * packet.
 		 */
+
+		/* Ensure that we have at least 2 elements (report type and size) */
+		if (size < 2)
+			return 0;
+
+		if (size < data[1] + 2) {
+			hid_warn(hdev,
+				 "received report length (%d) was smaller than specified (%d)",
+				 size, data[1] + 2);
+			return 0;
+		}
+
 		magicmouse_raw_event(hdev, report, data + 2, data[1]);
 		magicmouse_raw_event(hdev, report, data + 2 + data[1],
 			size - 2 - data[1]);
@@ -830,6 +846,16 @@ static int magicmouse_probe(struct hid_device *hdev,
 		return ret;
 	}
 
+	/*
+	 * When hidinput_connect() fails it frees every input device it
+	 * created, but that does not fail hid_hw_start(): the core simply
+	 * does not claim an input. msc->input, cached in ->input_mapping
+	 * while the report descriptor was parsed, would then be a dangling
+	 * pointer that passes every NULL check. Trust the core's claim.
+	 */
+	if (!(hdev->claimed & HID_CLAIMED_INPUT))
+		msc->input = NULL;
+
 	if (is_usb_magicmouse2(id->vendor, id->product) ||
 	    is_usb_magictrackpad2(id->vendor, id->product)) {
 		timer_setup(&msc->battery_timer, magicmouse_battery_timer_tick, 0);
diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 602465ad2745..77cc778aef41 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -910,26 +910,26 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = sysfs_create_group(&sensor_inst->pdev->dev.kobj,
-				 &enable_sensor_attr_group);
+	ret = hid_sensor_custom_add_attributes(sensor_inst);
 	if (ret)
 		goto err_remove_callback;
 
-	ret = hid_sensor_custom_add_attributes(sensor_inst);
+	ret = sysfs_create_group(&sensor_inst->pdev->dev.kobj,
+				 &enable_sensor_attr_group);
 	if (ret)
-		goto err_remove_group;
+		goto err_remove_attributes;
 
 	ret = hid_sensor_custom_dev_if_add(sensor_inst);
 	if (ret)
-		goto err_remove_attributes;
+		goto err_remove_group;
 
 	return 0;
 
-err_remove_attributes:
-	hid_sensor_custom_remove_attributes(sensor_inst);
 err_remove_group:
 	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
 			   &enable_sensor_attr_group);
+err_remove_attributes:
+	hid_sensor_custom_remove_attributes(sensor_inst);
 err_remove_callback:
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 
@@ -947,9 +947,10 @@ static int hid_sensor_custom_remove(struct platform_device *pdev)
 	}
 
 	hid_sensor_custom_dev_if_remove(sensor_inst);
-	hid_sensor_custom_remove_attributes(sensor_inst);
+	/* Remove enable_sensor first as it uses fields via power_state/report_state. */
 	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
 			   &enable_sensor_attr_group);
+	hid_sensor_custom_remove_attributes(sensor_inst);
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 
 	return 0;
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index d8b7645e8d4e..c639e7a2d7da 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1940,17 +1940,32 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		.callback = atkbd_deactivate_fixup,
 	},
 	{
-		/* Lenovo Yoga Air 14 (83QK) */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "83QK"),
+			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "BCC-N"),
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "BCC-N"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "FMB-P"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
+	{
+		/* HONOR MagicBook Pro 14 2026 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZQC-P"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
+	{
+		/* Lenovo Yoga Air 14 (83QK) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83QK"),
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 3c461e3fc8b8..6df7f3ee7a74 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -78,7 +78,7 @@
 #define USER_PD		(1)
 #define SENSORS_PD	(2)
 
-#define miscdev_to_cctx(d) container_of(d, struct fastrpc_channel_ctx, miscdev)
+#define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
 
 static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
 						"sdsp", "cdsp"};
@@ -212,9 +212,14 @@ struct fastrpc_channel_ctx {
 	spinlock_t lock;
 	struct idr ctx_idr;
 	struct list_head users;
-	struct miscdevice miscdev;
 	struct kref refcount;
 	u64 dma_mask;
+	struct fastrpc_device *fdevice;
+};
+
+struct fastrpc_device {
+	struct fastrpc_channel_ctx *cctx;
+	struct miscdevice miscdev;
 };
 
 struct fastrpc_user {
@@ -1250,10 +1255,14 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 
 static int fastrpc_device_open(struct inode *inode, struct file *filp)
 {
-	struct fastrpc_channel_ctx *cctx = miscdev_to_cctx(filp->private_data);
+	struct fastrpc_channel_ctx *cctx;
+	struct fastrpc_device *fdevice;
 	struct fastrpc_user *fl = NULL;
 	unsigned long flags;
 
+	fdevice = miscdev_to_fdevice(filp->private_data);
+	cctx = fdevice->cctx;
+
 	fl = kzalloc(sizeof(*fl), GFP_KERNEL);
 	if (!fl)
 		return -ENOMEM;
@@ -1380,30 +1389,14 @@ static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
 	return err;
 }
 
-static int fastrpc_req_munmap_impl(struct fastrpc_user *fl,
-				   struct fastrpc_req_munmap *req)
+static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *buf)
 {
 	struct fastrpc_invoke_args args[1] = { [0] = { 0 } };
-	struct fastrpc_buf *buf = NULL, *iter, *b;
 	struct fastrpc_munmap_req_msg req_msg;
 	struct device *dev = fl->sctx->dev;
 	int err;
 	u32 sc;
 
-	spin_lock(&fl->lock);
-	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
-		if ((iter->raddr == req->vaddrout) && (iter->size == req->size)) {
-			buf = iter;
-			break;
-		}
-	}
-	spin_unlock(&fl->lock);
-
-	if (!buf) {
-		dev_err(dev, "mmap not in list\n");
-		return -EINVAL;
-	}
-
 	req_msg.pgid = fl->tgid;
 	req_msg.size = buf->size;
 	req_msg.vaddr = buf->raddr;
@@ -1416,9 +1409,6 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl,
 				      &args[0]);
 	if (!err) {
 		dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
-		spin_lock(&fl->lock);
-		list_del(&buf->node);
-		spin_unlock(&fl->lock);
 		fastrpc_buf_free(buf);
 	} else {
 		dev_err(dev, "unmmap\tpt 0x%09lx ERROR\n", buf->raddr);
@@ -1429,12 +1419,38 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl,
 
 static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 {
+	struct fastrpc_buf *buf = NULL, *iter, *b;
 	struct fastrpc_req_munmap req;
+	struct device *dev = fl->sctx->dev;
+	int err;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
 
-	return fastrpc_req_munmap_impl(fl, &req);
+	spin_lock(&fl->lock);
+	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
+		if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
+			list_del(&iter->node);
+			buf = iter;
+			break;
+		}
+	}
+	spin_unlock(&fl->lock);
+
+	if (!buf) {
+		dev_err(dev, "mmap\t\tpt 0x%09llx [len 0x%08llx] not in list\n",
+			req.vaddrout, req.size);
+		return -EINVAL;
+	}
+
+	err = fastrpc_req_munmap_impl(fl, buf);
+	if (err) {
+		spin_lock(&fl->lock);
+		list_add_tail(&buf->node, &fl->mmaps);
+		spin_unlock(&fl->lock);
+	}
+
+	return err;
 }
 
 static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
@@ -1443,7 +1459,6 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_buf *buf = NULL;
 	struct fastrpc_mmap_req_msg req_msg;
 	struct fastrpc_mmap_rsp_msg rsp_msg;
-	struct fastrpc_req_munmap req_unmap;
 	struct fastrpc_phy_page pages;
 	struct fastrpc_req_mmap req;
 	struct device *dev = fl->sctx->dev;
@@ -1491,7 +1506,8 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 				      &args[0]);
 	if (err) {
 		dev_err(dev, "mmap error (len 0x%08llx)\n", buf->size);
-		goto err_invoke;
+		fastrpc_buf_free(buf);
+		return err;
 	}
 
 	/* update the buffer to be able to deallocate the memory on the DSP */
@@ -1505,11 +1521,8 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	spin_unlock(&fl->lock);
 
 	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
-		/* unmap the memory and release the buffer */
-		req_unmap.vaddrout = buf->raddr;
-		req_unmap.size = buf->size;
-		fastrpc_req_munmap_impl(fl, &req_unmap);
-		return -EFAULT;
+		err = -EFAULT;
+		goto err_assign;
 	}
 
 	dev_dbg(dev, "mmap\t\tpt 0x%09lx OK [len 0x%08llx]\n",
@@ -1517,8 +1530,8 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 
 	return 0;
 
-err_invoke:
-	fastrpc_buf_free(buf);
+err_assign:
+	fastrpc_req_munmap_impl(fl, buf);
 
 	return err;
 }
@@ -1651,6 +1664,27 @@ static struct platform_driver fastrpc_cb_driver = {
 	},
 };
 
+static int fastrpc_device_register(struct device *dev, struct fastrpc_channel_ctx *cctx,
+				   const char *domain)
+{
+	struct fastrpc_device *fdev;
+	int err;
+
+	fdev = devm_kzalloc(dev, sizeof(*fdev), GFP_KERNEL);
+	if (!fdev)
+		return -ENOMEM;
+
+	fdev->cctx = cctx;
+	fdev->miscdev.minor = MISC_DYNAMIC_MINOR;
+	fdev->miscdev.fops = &fastrpc_fops;
+	fdev->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "fastrpc-%s", domain);
+	err = misc_register(&fdev->miscdev);
+	if (!err)
+		cctx->fdevice = fdev;
+
+	return err;
+}
+
 static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 {
 	struct device *rdev = &rpdev->dev;
@@ -1680,11 +1714,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	if (!data)
 		return -ENOMEM;
 
-	data->miscdev.minor = MISC_DYNAMIC_MINOR;
-	data->miscdev.name = devm_kasprintf(rdev, GFP_KERNEL, "fastrpc-%s",
-					    domains[domain_id]);
-	data->miscdev.fops = &fastrpc_fops;
-	err = misc_register(&data->miscdev);
+	err = fastrpc_device_register(rdev, data, domains[domain_id]);
 	if (err) {
 		kfree(data);
 		return err;
@@ -1729,7 +1759,9 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 		fastrpc_notify_users(user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
-	misc_deregister(&cctx->miscdev);
+	if (cctx->fdevice)
+		misc_deregister(&cctx->fdevice->miscdev);
+
 	of_platform_depopulate(&rpdev->dev);
 
 	fastrpc_channel_ctx_put(cctx);
diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index e59d5cbb644a..ec624cfc1b07 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -203,7 +203,6 @@ struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	*cf = skb_put_zero(skb, sizeof(struct can_frame));
 
@@ -234,7 +233,6 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	*cfd = skb_put_zero(skb, sizeof(struct canfd_frame));
 
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index d42ec7d1bc14..2ace2b735c20 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -213,7 +213,6 @@ static void slc_bump(struct slcan *sl)
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = sl->dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	skb_put_data(skb, &cf, sizeof(struct can_frame));
 
diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index b701ee83e64a..7e562751d6dd 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -100,7 +100,7 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 				  void *data, int len)
 {
 	struct net_device *ndev = qp_data;
-	struct sk_buff *skb;
+	struct sk_buff *skb, *new_skb;
 	int rc;
 
 	skb = data;
@@ -115,6 +115,12 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 		goto enqueue_again;
 	}
 
+	new_skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
+	if (!new_skb) {
+		ndev->stats.rx_dropped++;
+		goto enqueue_again;
+	}
+
 	skb_put(skb, len);
 	skb->protocol = eth_type_trans(skb, ndev);
 	skb->ip_summed = CHECKSUM_NONE;
@@ -127,12 +133,7 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 		ndev->stats.rx_bytes += len;
 	}
 
-	skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
-	if (!skb) {
-		ndev->stats.rx_errors++;
-		ndev->stats.rx_frame_errors++;
-		return;
-	}
+	skb = new_skb;
 
 enqueue_again:
 	rc = ntb_transport_rx_enqueue(qp, skb, skb->data, ndev->mtu + ETH_HLEN);
diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
index f3e4a68b6c94..608bfac443f0 100644
--- a/drivers/net/usb/rndis_host.c
+++ b/drivers/net/usb/rndis_host.c
@@ -14,6 +14,7 @@
 #include <linux/usb/cdc.h>
 #include <linux/usb/usbnet.h>
 #include <linux/usb/rndis_host.h>
+#include <linux/overflow.h>
 
 
 /*
@@ -495,6 +496,7 @@ int rndis_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 		struct rndis_data_hdr	*hdr = (void *)skb->data;
 		struct sk_buff		*skb2;
 		u32			msg_type, msg_len, data_offset, data_len;
+		u32			overflow_check;
 
 		msg_type = le32_to_cpu(hdr->msg_type);
 		msg_len = le32_to_cpu(hdr->msg_len);
@@ -503,7 +505,9 @@ int rndis_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 
 		/* don't choke if we see oob, per-packet data, etc */
 		if (unlikely(msg_type != RNDIS_MSG_PACKET || skb->len < msg_len
-				|| (data_offset + data_len + 8) > msg_len)) {
+				|| (data_offset + data_len + 8) > msg_len
+				|| check_add_overflow(data_offset, data_len, &overflow_check)
+				|| check_add_overflow(overflow_check, 8, &overflow_check))) {
 			dev->net->stats.rx_frame_errors++;
 			netdev_dbg(dev->net, "bad rndis message %d/%d/%d/%d, len %d\n",
 				   le32_to_cpu(hdr->msg_type),
diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
index 5f97dcf08dd0..3e10518d6c96 100644
--- a/drivers/nfc/fdp/i2c.c
+++ b/drivers/nfc/fdp/i2c.c
@@ -166,9 +166,36 @@ static int fdp_nci_i2c_read(struct fdp_i2c_phy *phy, struct sk_buff **skb)
 		/* Packet that contains a length */
 		if (tmp[0] == 0 && tmp[1] == 0) {
 			phy->next_read_size = (tmp[2] << 8) + tmp[3] + 3;
+
+			/*
+			 * next_read_size is taken from the device and is used
+			 * as the i2c_master_recv() count for the next packet
+			 * and as the data skb size. A value above the receive
+			 * buffer overflows tmp[]; one below the minimum frame
+			 * size runs the header/LRC strip and the length-field
+			 * read past a short receive. Either way the packet is
+			 * corrupt: drop it and force resynchronization.
+			 */
+			if (phy->next_read_size < FDP_NCI_I2C_MIN_PAYLOAD ||
+			    phy->next_read_size > FDP_NCI_I2C_MAX_PAYLOAD) {
+				dev_dbg(&client->dev, "%s: corrupted packet\n",
+					__func__);
+				phy->next_read_size = FDP_NCI_I2C_MIN_PAYLOAD;
+				goto flush;
+			}
 		} else {
 			phy->next_read_size = FDP_NCI_I2C_MIN_PAYLOAD;
 
+			/*
+			 * Only one data packet is delivered per call; if the
+			 * device sends another, do not overwrite and leak the
+			 * skb allocated for the previous one.
+			 */
+			if (*skb) {
+				kfree_skb(*skb);
+				*skb = NULL;
+			}
+
 			*skb = alloc_skb(len, GFP_KERNEL);
 			if (*skb == NULL) {
 				r = -ENOMEM;
diff --git a/drivers/nfc/microread/microread.c b/drivers/nfc/microread/microread.c
index bb4d029bb888..b0e483ee7eec 100644
--- a/drivers/nfc/microread/microread.c
+++ b/drivers/nfc/microread/microread.c
@@ -483,13 +483,19 @@ static void microread_target_discovered(struct nfc_hci_dev *hdev, u8 gate,
 
 	switch (gate) {
 	case MICROREAD_GATE_ID_MREAD_ISO_A:
+		if (skb->len <= MICROREAD_EMCF_A_LEN) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols =
 		      nfc_hci_sak_to_protocol(skb->data[MICROREAD_EMCF_A_SAK]);
 		targets->sens_res =
 			 be16_to_cpu(*(u16 *)&skb->data[MICROREAD_EMCF_A_ATQA]);
 		targets->sel_res = skb->data[MICROREAD_EMCF_A_SAK];
 		targets->nfcid1_len = skb->data[MICROREAD_EMCF_A_LEN];
-		if (targets->nfcid1_len > sizeof(targets->nfcid1)) {
+		if (targets->nfcid1_len > sizeof(targets->nfcid1) ||
+		    targets->nfcid1_len > skb->len - MICROREAD_EMCF_A_UID) {
 			r = -EINVAL;
 			goto exit_free;
 		}
@@ -497,13 +503,19 @@ static void microread_target_discovered(struct nfc_hci_dev *hdev, u8 gate,
 		       targets->nfcid1_len);
 		break;
 	case MICROREAD_GATE_ID_MREAD_ISO_A_3:
+		if (skb->len <= MICROREAD_EMCF_A3_LEN) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols =
 		      nfc_hci_sak_to_protocol(skb->data[MICROREAD_EMCF_A3_SAK]);
 		targets->sens_res =
 			 be16_to_cpu(*(u16 *)&skb->data[MICROREAD_EMCF_A3_ATQA]);
 		targets->sel_res = skb->data[MICROREAD_EMCF_A3_SAK];
 		targets->nfcid1_len = skb->data[MICROREAD_EMCF_A3_LEN];
-		if (targets->nfcid1_len > sizeof(targets->nfcid1)) {
+		if (targets->nfcid1_len > sizeof(targets->nfcid1) ||
+		    targets->nfcid1_len > skb->len - MICROREAD_EMCF_A3_UID) {
 			r = -EINVAL;
 			goto exit_free;
 		}
@@ -511,11 +523,21 @@ static void microread_target_discovered(struct nfc_hci_dev *hdev, u8 gate,
 		       targets->nfcid1_len);
 		break;
 	case MICROREAD_GATE_ID_MREAD_ISO_B:
+		if (skb->len < MICROREAD_EMCF_B_UID + 4) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols = NFC_PROTO_ISO14443_B_MASK;
 		memcpy(targets->nfcid1, &skb->data[MICROREAD_EMCF_B_UID], 4);
 		targets->nfcid1_len = 4;
 		break;
 	case MICROREAD_GATE_ID_MREAD_NFC_T1:
+		if (skb->len < MICROREAD_EMCF_T1_UID + 4) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols = NFC_PROTO_JEWEL_MASK;
 		targets->sens_res =
 			le16_to_cpu(*(u16 *)&skb->data[MICROREAD_EMCF_T1_ATQA]);
@@ -523,6 +545,11 @@ static void microread_target_discovered(struct nfc_hci_dev *hdev, u8 gate,
 		targets->nfcid1_len = 4;
 		break;
 	case MICROREAD_GATE_ID_MREAD_NFC_T3:
+		if (skb->len < MICROREAD_EMCF_T3_UID + 8) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols = NFC_PROTO_FELICA_MASK;
 		memcpy(targets->nfcid1, &skb->data[MICROREAD_EMCF_T3_UID], 8);
 		targets->nfcid1_len = 8;
diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index fceae9c12760..a042fba8f69d 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -2805,6 +2805,7 @@ void pn53x_common_clean(struct pn533 *priv)
 	destroy_workqueue(priv->wq);
 
 	skb_queue_purge(&priv->resp_q);
+	skb_queue_purge(&priv->fragment_skb);
 
 	list_for_each_entry_safe(cmd, n, &priv->cmd_queue, queue) {
 		list_del(&cmd->queue);
diff --git a/drivers/nfc/st21nfca/dep.c b/drivers/nfc/st21nfca/dep.c
index 1ec651e31064..e56a01178583 100644
--- a/drivers/nfc/st21nfca/dep.c
+++ b/drivers/nfc/st21nfca/dep.c
@@ -207,6 +207,9 @@ static int st21nfca_tm_recv_atr_req(struct nfc_hci_dev *hdev,
 	if (atr_req->length < sizeof(struct st21nfca_atr_req))
 		return -EPROTO;
 
+	if (atr_req->length > skb->len)
+		return -EPROTO;
+
 	r = st21nfca_tm_send_atr_res(hdev, atr_req);
 	if (r)
 		return r;
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 80e0dc60a920..3be722a7f3c7 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -571,7 +571,7 @@ nvmet_fc_alloc_ls_iodlist(struct nvmet_fc_tgtport *tgtport)
 		list_del(&iod->ls_rcv_list);
 	}
 
-	kfree(iod);
+	kfree(tgtport->iod);
 
 	return -EFAULT;
 }
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 8fe51218441e..904bbb10f5d0 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -405,14 +405,15 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 	}
 	cmd->req.transfer_len += len;
 
-	cmd->req.sg = sgl_alloc(len, GFP_KERNEL, &cmd->req.sg_cnt);
+	cmd->req.sg = sgl_alloc(len, GFP_KERNEL | __GFP_NOWARN,
+				&cmd->req.sg_cnt);
 	if (!cmd->req.sg)
 		return NVME_SC_INTERNAL;
 	cmd->cur_sg = cmd->req.sg;
 
 	if (nvmet_tcp_has_data_in(cmd)) {
 		cmd->iov = kmalloc_array(cmd->req.sg_cnt,
-				sizeof(*cmd->iov), GFP_KERNEL);
+				sizeof(*cmd->iov), GFP_KERNEL | __GFP_NOWARN);
 		if (!cmd->iov)
 			goto err;
 	}
diff --git a/drivers/pci/controller/pci-host-generic.c b/drivers/pci/controller/pci-host-generic.c
index 63865aeb636b..70e9f4cab9be 100644
--- a/drivers/pci/controller/pci-host-generic.c
+++ b/drivers/pci/controller/pci-host-generic.c
@@ -14,15 +14,6 @@
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
 
-static const struct pci_ecam_ops gen_pci_cfg_cam_bus_ops = {
-	.bus_shift	= 16,
-	.pci_ops	= {
-		.map_bus	= pci_ecam_map_bus,
-		.read		= pci_generic_config_read,
-		.write		= pci_generic_config_write,
-	}
-};
-
 static bool pci_dw_valid_device(struct pci_bus *bus, unsigned int devfn)
 {
 	struct pci_config_window *cfg = bus->sysdata;
@@ -58,7 +49,7 @@ static const struct pci_ecam_ops pci_dw_ecam_bus_ops = {
 
 static const struct of_device_id gen_pci_of_match[] = {
 	{ .compatible = "pci-host-cam-generic",
-	  .data = &gen_pci_cfg_cam_bus_ops },
+	  .data = &pci_generic_cam_ops },
 
 	{ .compatible = "pci-host-ecam-generic",
 	  .data = &pci_generic_ecam_ops },
diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index 1c40d2506aef..97430664db3a 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -208,6 +208,19 @@ const struct pci_ecam_ops pci_generic_ecam_ops = {
 };
 EXPORT_SYMBOL_GPL(pci_generic_ecam_ops);
 
+/* CAM ops */
+const struct pci_ecam_ops pci_generic_cam_ops = {
+	.bus_shift	= 16,
+	.pci_ops	= {
+		.add_bus	= pci_ecam_add_bus,
+		.remove_bus	= pci_ecam_remove_bus,
+		.map_bus	= pci_ecam_map_bus,
+		.read		= pci_generic_config_read,
+		.write		= pci_generic_config_write,
+	}
+};
+EXPORT_SYMBOL_GPL(pci_generic_cam_ops);
+
 #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
 /* ECAM ops for 32-bit access only (non-compliant) */
 const struct pci_ecam_ops pci_32b_ops = {
diff --git a/drivers/s390/cio/vfio_ccw_async.c b/drivers/s390/cio/vfio_ccw_async.c
index 7a838e3d7c0f..01f8cedc46e2 100644
--- a/drivers/s390/cio/vfio_ccw_async.c
+++ b/drivers/s390/cio/vfio_ccw_async.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/vfio.h>
+#include <linux/nospec.h>
 #include <linux/mdev.h>
 
 #include "vfio_ccw_private.h"
@@ -25,11 +26,20 @@ static ssize_t vfio_ccw_async_region_read(struct vfio_ccw_private *private,
 		return -EINVAL;
 
 	mutex_lock(&private->io_mutex);
+
+	if (i >= private->num_regions) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	i = array_index_nospec(i, private->num_regions);
 	region = private->region[i].data;
 	if (copy_to_user(buf, (void *)region + pos, count))
 		ret = -EFAULT;
 	else
 		ret = count;
+
+out_unlock:
 	mutex_unlock(&private->io_mutex);
 	return ret;
 }
@@ -49,6 +59,12 @@ static ssize_t vfio_ccw_async_region_write(struct vfio_ccw_private *private,
 	if (!mutex_trylock(&private->io_mutex))
 		return -EAGAIN;
 
+	if (i >= private->num_regions) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	i = array_index_nospec(i, private->num_regions);
 	region = private->region[i].data;
 	if (copy_from_user((void *)region + pos, buf, count)) {
 		ret = -EFAULT;
diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
index 13b26a1c7988..3ee2444f3d90 100644
--- a/drivers/s390/cio/vfio_ccw_chp.c
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/nospec.h>
 #include <linux/vfio.h>
 #include "vfio_ccw_private.h"
 
@@ -25,6 +26,13 @@ static ssize_t vfio_ccw_schib_region_read(struct vfio_ccw_private *private,
 		return -EINVAL;
 
 	mutex_lock(&private->io_mutex);
+
+	if (i >= private->num_regions) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	i = array_index_nospec(i, private->num_regions);
 	region = private->region[i].data;
 
 	if (cio_update_schib(private->sch)) {
@@ -84,19 +92,30 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
 	loff_t pos = *ppos & VFIO_CCW_OFFSET_MASK;
 	struct ccw_crw_region *region;
 	struct vfio_ccw_crw *crw;
+	unsigned long flags;
 	int ret;
 
 	if (pos + count > sizeof(*region))
 		return -EINVAL;
 
+	mutex_lock(&private->io_mutex);
+	if (i >= private->num_regions) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	i = array_index_nospec(i, private->num_regions);
+	region = private->region[i].data;
+
+	spin_lock_irqsave(&private->crw_lock, flags);
 	crw = list_first_entry_or_null(&private->crw,
 				       struct vfio_ccw_crw, next);
 
 	if (crw)
 		list_del(&crw->next);
 
-	mutex_lock(&private->io_mutex);
-	region = private->region[i].data;
+	/* Drop CRW lock while copying to userspace */
+	spin_unlock_irqrestore(&private->crw_lock, flags);
 
 	if (crw)
 		memcpy(&region->crw, &crw->crw, sizeof(region->crw));
@@ -107,14 +126,16 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
 		ret = count;
 
 	region->crw = 0;
-
-	mutex_unlock(&private->io_mutex);
-
 	kfree(crw);
 
 	/* Notify the guest if more CRWs are on our queue */
+	spin_lock_irqsave(&private->crw_lock, flags);
 	if (!list_empty(&private->crw) && private->crw_trigger)
 		eventfd_signal(private->crw_trigger, 1);
+	spin_unlock_irqrestore(&private->crw_lock, flags);
+
+out:
+	mutex_unlock(&private->io_mutex);
 
 	return ret;
 }
diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 4da85df9f781..38beb20e7517 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -16,6 +16,7 @@
 #include <asm/idals.h>
 
 #include "vfio_ccw_cp.h"
+#include "vfio_ccw_private.h"
 
 struct pfn_array {
 	/* Starting guest physical I/O address. */
@@ -446,9 +447,6 @@ static int ccwchain_handle_ccw(u32 cda, struct channel_program *cp)
 	/* Loop for tics on this new chain. */
 	ret = ccwchain_loop_tic(chain, cp);
 
-	if (ret)
-		ccwchain_free(chain);
-
 	return ret;
 }
 
@@ -477,6 +475,23 @@ static int ccwchain_loop_tic(struct ccwchain *chain, struct channel_program *cp)
 	return 0;
 }
 
+static int ccwchain_build_ccws(u32 cda, struct channel_program *cp)
+{
+	struct ccwchain *chain, *temp;
+	int ret;
+
+	ret = ccwchain_handle_ccw(cda, cp);
+
+	if (ret) {
+		/* Cleanup if an error occurred */
+		list_for_each_entry_safe(chain, temp, &cp->ccwchain_list, next) {
+			ccwchain_free(chain);
+		}
+	}
+
+	return ret;
+}
+
 static int ccwchain_fetch_tic(struct ccwchain *chain,
 			      int idx,
 			      struct channel_program *cp)
@@ -650,7 +665,7 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
 	cp->mdev = mdev;
 
 	/* Build a ccwchain for the first CCW segment */
-	ret = ccwchain_handle_ccw(orb->cmd.cpa, cp);
+	ret = ccwchain_build_ccws(orb->cmd.cpa, cp);
 
 	if (!ret) {
 		cp->initialized = true;
@@ -852,17 +867,23 @@ void cp_update_scsw(struct channel_program *cp, union scsw *scsw)
  */
 bool cp_iova_pinned(struct channel_program *cp, u64 iova)
 {
+	struct vfio_ccw_private *private =
+		container_of(cp, struct vfio_ccw_private, cp);
 	struct ccwchain *chain;
 	int i;
 
 	if (!cp->initialized)
 		return false;
 
+	mutex_lock(&private->io_mutex);
 	list_for_each_entry(chain, &cp->ccwchain_list, next) {
 		for (i = 0; i < chain->ch_len; i++)
-			if (pfn_array_iova_pinned(chain->ch_pa + i, iova))
+			if (pfn_array_iova_pinned(chain->ch_pa + i, iova)) {
+				mutex_unlock(&private->io_mutex);
 				return true;
+			}
 	}
+	mutex_unlock(&private->io_mutex);
 
 	return false;
 }
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index b9091e22ca57..735d9493b687 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -93,6 +93,7 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 
 	is_final = !(scsw_actl(&irb->scsw) &
 		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
+	mutex_lock(&private->io_mutex);
 	if (scsw_is_solicited(&irb->scsw)) {
 		cp_update_scsw(&private->cp, &irb->scsw);
 		if (is_final && private->state == VFIO_CCW_STATE_CP_PENDING) {
@@ -100,9 +101,7 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 			cp_is_finished = true;
 		}
 	}
-	mutex_lock(&private->io_mutex);
 	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
-	mutex_unlock(&private->io_mutex);
 
 	/*
 	 * Reset to IDLE only if processing of a channel program
@@ -111,6 +110,7 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 	 */
 	if (private->mdev && cp_is_finished)
 		private->state = VFIO_CCW_STATE_IDLE;
+	mutex_unlock(&private->io_mutex);
 
 	if (private->io_trigger)
 		eventfd_signal(private->io_trigger, 1);
@@ -119,11 +119,14 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 static void vfio_ccw_crw_todo(struct work_struct *work)
 {
 	struct vfio_ccw_private *private;
+	unsigned long flags;
 
 	private = container_of(work, struct vfio_ccw_private, crw_work);
 
+	spin_lock_irqsave(&private->crw_lock, flags);
 	if (!list_empty(&private->crw) && private->crw_trigger)
 		eventfd_signal(private->crw_trigger, 1);
+	spin_unlock_irqrestore(&private->crw_lock, flags);
 }
 
 /*
@@ -207,6 +210,7 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	INIT_LIST_HEAD(&private->crw);
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
 	INIT_WORK(&private->crw_work, vfio_ccw_crw_todo);
+	spin_lock_init(&private->crw_lock);
 	atomic_set(&private->avail, 1);
 	private->state = VFIO_CCW_STATE_STANDBY;
 
@@ -238,13 +242,16 @@ static void vfio_ccw_sch_remove(struct subchannel *sch)
 {
 	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
 	struct vfio_ccw_crw *crw, *temp;
+	unsigned long flags;
 
 	vfio_ccw_sch_quiesce(sch);
 
+	spin_lock_irqsave(&private->crw_lock, flags);
 	list_for_each_entry_safe(crw, temp, &private->crw, next) {
 		list_del(&crw->next);
 		kfree(crw);
 	}
+	spin_unlock_irqrestore(&private->crw_lock, flags);
 
 	vfio_ccw_mdev_unreg(sch);
 
@@ -304,6 +311,7 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_private *private,
 			       unsigned int rsid)
 {
 	struct vfio_ccw_crw *crw;
+	unsigned long flags;
 
 	/*
 	 * If unable to allocate a CRW, just drop the event and
@@ -321,7 +329,9 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_private *private,
 	crw->crw.erc = erc;
 	crw->crw.rsid = rsid;
 
+	spin_lock_irqsave(&private->crw_lock, flags);
 	list_add_tail(&crw->next, &private->crw);
+	spin_unlock_irqrestore(&private->crw_lock, flags);
 	queue_work(vfio_ccw_work_q, &private->crw_work);
 }
 
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 7f540ad0b568..4c035a8f9691 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -207,6 +207,14 @@ static void vfio_ccw_mdev_close_device(struct mdev_device *mdev)
 	}
 
 	cp_free(&private->cp);
+
+	/*
+	 * Ensure these work items are drained, in the event the
+	 * device is re-opened instead of released.
+	 */
+	cancel_work_sync(&private->io_work);
+	cancel_work_sync(&private->crw_work);
+
 	vfio_ccw_unregister_dev_regions(private);
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
 				 &private->nb);
@@ -251,6 +259,7 @@ static ssize_t vfio_ccw_mdev_read(struct mdev_device *mdev,
 		return vfio_ccw_mdev_read_io_region(private, buf, count, ppos);
 	default:
 		index -= VFIO_CCW_NUM_REGIONS;
+		index = array_index_nospec(index, private->num_regions);
 		return private->region[index].ops->read(private, buf, count,
 							ppos);
 	}
@@ -304,6 +313,7 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 		return vfio_ccw_mdev_write_io_region(private, buf, count, ppos);
 	default:
 		index -= VFIO_CCW_NUM_REGIONS;
+		index = array_index_nospec(index, private->num_regions);
 		return private->region[index].ops->write(private, buf, count,
 							 ppos);
 	}
@@ -351,11 +361,8 @@ static int vfio_ccw_mdev_get_region_info(struct vfio_region_info *info,
 		    VFIO_CCW_NUM_REGIONS + private->num_regions)
 			return -EINVAL;
 
-		info->index = array_index_nospec(info->index,
-						 VFIO_CCW_NUM_REGIONS +
-						 private->num_regions);
-
 		i = info->index - VFIO_CCW_NUM_REGIONS;
+		i = array_index_nospec(i, private->num_regions);
 
 		info->offset = VFIO_CCW_INDEX_TO_OFFSET(info->index);
 		info->size = private->region[i].size;
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index b2c762eb42b9..67bc16f8c11c 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -74,7 +74,8 @@ struct vfio_ccw_crw {
  * @mdev: pointer to the mediated device
  * @nb: notifier for vfio events
  * @io_region: MMIO region to input/output I/O arguments/results
- * @io_mutex: protect against concurrent update of I/O regions
+ * @io_mutex: protect against concurrent update of I/O resources
+ *            and @cp lifecycle
  * @region: additional regions for other subchannel operations
  * @cmd_region: MMIO region for asynchronous I/O commands other than START
  * @schib_region: MMIO region for SCHIB information
@@ -83,6 +84,8 @@ struct vfio_ccw_crw {
  * @cp: channel program for the current I/O operation
  * @irb: irb info received from interrupt
  * @scsw: scsw info
+ * @crw_lock: serialization of CRW list information
+ * @crw: list of Channel Report Word elements
  * @io_trigger: eventfd ctx for signaling userspace I/O results
  * @crw_trigger: eventfd ctx for signaling userspace CRW information
  * @req_trigger: eventfd ctx for signaling userspace to return device
@@ -107,6 +110,8 @@ struct vfio_ccw_private {
 	struct channel_program	cp;
 	struct irb		irb;
 	union scsw		scsw;
+
+	spinlock_t		crw_lock;
 	struct list_head	crw;
 
 	struct eventfd_ctx	*io_trigger;
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index c881d4413b89..82d5b4919409 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1198,7 +1198,7 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 
 	if (uap->using_tx_dma) {
 		/* In theory, this should already be done by pl011_dma_flush_buffer */
-		dmaengine_terminate_all(uap->dmatx.chan);
+		dmaengine_terminate_sync(uap->dmatx.chan);
 		if (uap->dmatx.queued) {
 			dma_unmap_single(uap->dmatx.chan->device->dev,
 					 uap->dmatx.dma, uap->dmatx.len,
@@ -1211,12 +1211,12 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 	}
 
 	if (uap->using_rx_dma) {
-		dmaengine_terminate_all(uap->dmarx.chan);
+		if (uap->dmarx.poll_rate)
+			timer_delete_sync(&uap->dmarx.timer);
+		dmaengine_terminate_sync(uap->dmarx.chan);
 		/* Clean up the RX DMA */
 		pl011_dmabuf_free(uap->dmarx.chan, &uap->dmarx.dbuf_a, DMA_FROM_DEVICE);
 		pl011_dmabuf_free(uap->dmarx.chan, &uap->dmarx.dbuf_b, DMA_FROM_DEVICE);
-		if (uap->dmarx.poll_rate)
-			del_timer_sync(&uap->dmarx.timer);
 		uap->using_rx_dma = false;
 	}
 }
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index d6ccd3801eb4..44a2df42167e 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2049,12 +2049,13 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 				 * stable so we can check the additional
 				 * reference fits.
 				 */
-				ref = le32_to_cpu(BHDR(new_bh)->h_refcount) + 1;
-				if (ref > EXT4_XATTR_REFCOUNT_MAX) {
+				ref = le32_to_cpu(BHDR(new_bh)->h_refcount);
+				if (ref >= EXT4_XATTR_REFCOUNT_MAX) {
 					/*
 					 * Undo everything and check mbcache
 					 * again.
 					 */
+					clear_bit(MBE_REUSABLE_B, &ce->e_flags);
 					unlock_buffer(new_bh);
 					dquot_free_block(inode,
 							 EXT4_C2B(EXT4_SB(sb),
@@ -2065,6 +2066,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 					new_bh = NULL;
 					goto inserted;
 				}
+				ref++;
 				BHDR(new_bh)->h_refcount = cpu_to_le32(ref);
 				if (ref == EXT4_XATTR_REFCOUNT_MAX)
 					clear_bit(MBE_REUSABLE_B, &ce->e_flags);
@@ -2788,6 +2790,7 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 		    s_min_extra_isize) {
 			tried_min_extra_isize++;
 			new_extra_isize = s_min_extra_isize;
+			error = 0;
 			goto retry;
 		}
 		goto cleanup;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 87a4f5a2ded0..6c76dba0a61c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -103,17 +103,24 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 	 * to avoid reading in already uptodate ranges.
 	 */
 	if (iop) {
-		unsigned int i;
+		unsigned int i, blocks_skipped;
 
 		/* move forward for each leading block marked uptodate */
-		for (i = first; i <= last; i++) {
+		for (i = first; i <= last; i++)
 			if (!test_bit(i, iop->uptodate))
 				break;
-			*pos += block_size;
-			poff += block_size;
-			plen -= block_size;
-			first++;
+
+		blocks_skipped = i - first;
+		if (blocks_skipped) {
+			unsigned long block_offset = *pos & (block_size - 1);
+			unsigned bytes_skipped =
+				(blocks_skipped << block_bits) - block_offset;
+
+			*pos += bytes_skipped;
+			poff += bytes_skipped;
+			plen -= bytes_skipped;
 		}
+		first = i;
 
 		/* truncate len if we find any trailing uptodate block(s) */
 		for ( ; i <= last; i++) {
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 1f22ad21ae60..473a90848cb9 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -740,12 +740,10 @@ static int ocfs2_xattr_extend_allocation(struct inode *inode,
 					 prev_clusters;
 
 		if (why != RESTART_NONE && clusters_to_add) {
-			/*
-			 * We can only fail in case the alloc file doesn't give
-			 * up enough clusters.
-			 */
-			BUG_ON(why == RESTART_META);
-
+			if (why == RESTART_META) {
+				status = -ENOSPC;
+				break;
+			}
 			credits = ocfs2_calc_extend_credits(inode->i_sb,
 							    &vb->vb_xv->xr_list);
 			status = ocfs2_extend_trans(handle, credits);
@@ -3214,6 +3212,14 @@ static int ocfs2_calc_xattr_set_need(struct inode *inode,
 		} else
 			credits += OCFS2_SUBALLOC_ALLOC + 1;
 
+		/*
+		 * Reserve metadata for the new xattr's value extent tree.
+		 * The not_found path above adds credits for this tree but
+		 * omits meta_add, leaving meta_ac NULL for large values.
+		 */
+		if (xi->xi_value_len > OCFS2_XATTR_INLINE_SIZE)
+			meta_add += ocfs2_extend_meta_needed(&def_xv.xv.xr_list);
+
 		/*
 		 * This cluster will be used either for new bucket or for
 		 * new xattr block.
diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index 06421a9062a0..2f495cd4748b 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -266,6 +266,13 @@ xfs_attr3_leaf_verify_entry(
 	 */
 	if (ent->flags & XFS_ATTR_LOCAL) {
 		lentry = xfs_attr3_leaf_name_local(leaf, idx);
+
+		/* Validate lentry pointer is within bounds before field access */
+		if ((char *)lentry >= buf_end)
+			return __this_address;
+		if ((char *)lentry + offsetof(struct xfs_attr_leaf_name_local, nameval) > buf_end)
+			return __this_address;
+
 		namesize = xfs_attr_leaf_entsize_local(lentry->namelen,
 				be16_to_cpu(lentry->valuelen));
 		name_end = (char *)lentry + namesize;
@@ -273,6 +280,13 @@ xfs_attr3_leaf_verify_entry(
 			return __this_address;
 	} else {
 		rentry = xfs_attr3_leaf_name_remote(leaf, idx);
+
+		/* Validate rentry pointer is within bounds before field access */
+		if ((char *)rentry >= buf_end)
+			return __this_address;
+		if ((char *)rentry + offsetof(struct xfs_attr_leaf_name_remote, name) > buf_end)
+			return __this_address;
+
 		namesize = xfs_attr_leaf_entsize_remote(rentry->namelen);
 		name_end = (char *)rentry + namesize;
 		if (rentry->namelen == 0)
diff --git a/fs/xfs/xfs_buf_item_recover.c b/fs/xfs/xfs_buf_item_recover.c
index 31cbe7deebfa..63cb5b60b624 100644
--- a/fs/xfs/xfs_buf_item_recover.c
+++ b/fs/xfs/xfs_buf_item_recover.c
@@ -441,7 +441,7 @@ xlog_recover_validate_buf_type(
  * given buffer.  The bitmap in the buf log format structure indicates
  * where to place the logged data.
  */
-STATIC void
+STATIC int
 xlog_recover_do_reg_buffer(
 	struct xfs_mount		*mp,
 	struct xlog_recover_item	*item,
@@ -469,8 +469,24 @@ xlog_recover_do_reg_buffer(
 		ASSERT(nbits > 0);
 		ASSERT(item->ri_buf[i].i_addr != NULL);
 		ASSERT(item->ri_buf[i].i_len % XFS_BLF_CHUNK == 0);
-		ASSERT(BBTOB(bp->b_length) >=
-		       ((uint)bit << XFS_BLF_SHIFT) + (nbits << XFS_BLF_SHIFT));
+		/*
+		 * The bitmap is only trustworthy to the extent that it
+		 * describes a region that actually fits inside the buffer we
+		 * read in based on the (attacker-controlled) blf_len.  Do not
+		 * rely on an ASSERT() for this -- it compiles away entirely on
+		 * non-DEBUG kernels, which is exactly where this matters, so
+		 * validate it for real and abort recovery of this buffer rather
+		 * than copying past the end of it.
+		 */
+		if (XFS_IS_CORRUPT(mp, BBTOB(bp->b_length) <
+				((uint)bit << XFS_BLF_SHIFT) +
+				(nbits << XFS_BLF_SHIFT))) {
+			xfs_alert(mp,
+	"Bad buffer log item dirty bitmap (bit %d, nbits %d) for %d-byte buffer at daddr 0x%llx.",
+				bit, nbits, BBTOB(bp->b_length),
+				xfs_buf_daddr(bp));
+			return -EFSCORRUPTED;
+		}
 
 		/*
 		 * The dirty regions logged in the buffer, even though
@@ -524,6 +540,7 @@ xlog_recover_do_reg_buffer(
 	ASSERT(i == item->ri_total);
 
 	xlog_recover_validate_buf_type(mp, bp, buf_f, current_lsn);
+	return 0;
 }
 
 /*
@@ -532,10 +549,10 @@ xlog_recover_do_reg_buffer(
  * (ie. USR or GRP), then just toss this buffer away; don't recover it.
  * Else, treat it as a regular buffer and do recovery.
  *
- * Return false if the buffer was tossed and true if we recovered the buffer to
- * indicate to the caller if the buffer needs writing.
+ * Return 0 if the buffer was not recovered (tossed), 1 if it was recovered and
+ * needs writing, or a negative errno if recovery of the buffer failed.
  */
-STATIC bool
+STATIC int
 xlog_recover_do_dquot_buffer(
 	struct xfs_mount		*mp,
 	struct xlog			*log,
@@ -544,6 +561,7 @@ xlog_recover_do_dquot_buffer(
 	struct xfs_buf_log_format	*buf_f)
 {
 	uint			type;
+	int			error;
 
 	trace_xfs_log_recover_buf_dquot_buf(log, buf_f);
 
@@ -551,7 +569,7 @@ xlog_recover_do_dquot_buffer(
 	 * Filesystems are required to send in quota flags at mount time.
 	 */
 	if (!mp->m_qflags)
-		return false;
+		return 0;
 
 	type = 0;
 	if (buf_f->blf_flags & XFS_BLF_UDQUOT_BUF)
@@ -564,10 +582,12 @@ xlog_recover_do_dquot_buffer(
 	 * This type of quotas was turned off, so ignore this buffer
 	 */
 	if (log->l_quotaoffs_flag & type)
-		return false;
+		return 0;
 
-	xlog_recover_do_reg_buffer(mp, item, bp, buf_f, NULLCOMMITLSN);
-	return true;
+	error = xlog_recover_do_reg_buffer(mp, item, bp, buf_f, NULLCOMMITLSN);
+	if (error)
+		return error;
+	return 1;
 }
 
 /*
@@ -962,13 +982,16 @@ xlog_recover_buf_commit_pass2(
 			goto out_release;
 	} else if (buf_f->blf_flags &
 		  (XFS_BLF_UDQUOT_BUF|XFS_BLF_PDQUOT_BUF|XFS_BLF_GDQUOT_BUF)) {
-		bool	dirty;
-
-		dirty = xlog_recover_do_dquot_buffer(mp, log, item, bp, buf_f);
-		if (!dirty)
+		error = xlog_recover_do_dquot_buffer(mp, log, item, bp, buf_f);
+		if (error <= 0)
 			goto out_release;
+		/* write dirty buffer */
+		error = 0;
 	} else {
-		xlog_recover_do_reg_buffer(mp, item, bp, buf_f, current_lsn);
+		error = xlog_recover_do_reg_buffer(mp, item, bp, buf_f,
+						   current_lsn);
+		if (error)
+			goto out_release;
 	}
 
 	/*
diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index 5fb8d0e3f9c1..3287232e3cad 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -58,6 +58,7 @@ extern void can_rx_unregister(struct net *net, struct net_device *dev,
 			      void *data);
 
 extern int can_send(struct sk_buff *skb, int loop);
+void can_set_skb_uid(struct sk_buff *skb);
 void can_sock_destruct(struct sock *sk);
 
 #endif /* !_CAN_CORE_H */
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index d311bc369a39..f887eb21e178 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -43,13 +43,11 @@ struct sk_buff *alloc_can_err_skb(struct net_device *dev,
 /**
  * struct can_skb_priv - private additional data inside CAN sk_buffs
  * @ifindex:	ifindex of the first interface the CAN frame appeared on
- * @skbcnt:	atomic counter to have an unique id together with skb pointer
  * @frame_len:	length of CAN frame in data link layer
  * @cf:		align to the following CAN frame at skb->data
  */
 struct can_skb_priv {
 	int ifindex;
-	int skbcnt;
 	unsigned int frame_len;
 	struct can_frame cf[];
 };
@@ -107,7 +105,6 @@ static inline bool can_skb_headroom_valid(struct net_device *dev,
 	if (skb->ip_summed == CHECKSUM_NONE) {
 		/* init headroom */
 		can_skb_prv(skb)->ifindex = dev->ifindex;
-		can_skb_prv(skb)->skbcnt = 0;
 
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 118a3905afb0..24ce84739f03 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -710,10 +710,10 @@ struct kvm {
 
 #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
 	struct mmu_notifier mmu_notifier;
-	unsigned long mmu_notifier_seq;
-	long mmu_notifier_count;
-	unsigned long mmu_notifier_range_start;
-	unsigned long mmu_notifier_range_end;
+	unsigned long mmu_invalidate_seq;
+	long mmu_invalidate_in_progress;
+	unsigned long mmu_invalidate_range_start;
+	unsigned long mmu_invalidate_range_end;
 #endif
 	struct list_head devices;
 	u64 manual_dirty_log_protect;
@@ -1100,10 +1100,10 @@ void kvm_mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc);
 void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
 #endif
 
-void kvm_inc_notifier_count(struct kvm *kvm, unsigned long start,
-				   unsigned long end);
-void kvm_dec_notifier_count(struct kvm *kvm, unsigned long start,
-				   unsigned long end);
+void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
+			      unsigned long end);
+void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned long start,
+			    unsigned long end);
 
 long kvm_arch_dev_ioctl(struct file *filp,
 			unsigned int ioctl, unsigned long arg);
@@ -1631,42 +1631,44 @@ extern const struct kvm_stats_header kvm_vcpu_stats_header;
 extern const struct _kvm_stats_desc kvm_vcpu_stats_desc[];
 
 #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
-static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
+static inline int mmu_invalidate_retry(struct kvm *kvm, unsigned long mmu_seq)
 {
-	if (unlikely(kvm->mmu_notifier_count))
+	if (unlikely(kvm->mmu_invalidate_in_progress))
 		return 1;
 	/*
-	 * Ensure the read of mmu_notifier_count happens before the read
-	 * of mmu_notifier_seq.  This interacts with the smp_wmb() in
-	 * mmu_notifier_invalidate_range_end to make sure that the caller
-	 * either sees the old (non-zero) value of mmu_notifier_count or
-	 * the new (incremented) value of mmu_notifier_seq.
-	 * PowerPC Book3s HV KVM calls this under a per-page lock
-	 * rather than under kvm->mmu_lock, for scalability, so
-	 * can't rely on kvm->mmu_lock to keep things ordered.
+	 * Ensure the read of mmu_invalidate_in_progress happens before
+	 * the read of mmu_invalidate_seq.  This interacts with the
+	 * smp_wmb() in mmu_notifier_invalidate_range_end to make sure
+	 * that the caller either sees the old (non-zero) value of
+	 * mmu_invalidate_in_progress or the new (incremented) value of
+	 * mmu_invalidate_seq.
+	 *
+	 * PowerPC Book3s HV KVM calls this under a per-page lock rather
+	 * than under kvm->mmu_lock, for scalability, so can't rely on
+	 * kvm->mmu_lock to keep things ordered.
 	 */
 	smp_rmb();
-	if (kvm->mmu_notifier_seq != mmu_seq)
+	if (kvm->mmu_invalidate_seq != mmu_seq)
 		return 1;
 	return 0;
 }
 
-static inline int mmu_notifier_retry_hva(struct kvm *kvm,
-					 unsigned long mmu_seq,
-					 unsigned long hva)
+static inline int mmu_invalidate_retry_hva(struct kvm *kvm,
+					   unsigned long mmu_seq,
+					   unsigned long hva)
 {
 	lockdep_assert_held(&kvm->mmu_lock);
 	/*
-	 * If mmu_notifier_count is non-zero, then the range maintained by
-	 * kvm_mmu_notifier_invalidate_range_start contains all addresses that
-	 * might be being invalidated. Note that it may include some false
+	 * If mmu_invalidate_in_progress is non-zero, then the range maintained
+	 * by kvm_mmu_notifier_invalidate_range_start contains all addresses
+	 * that might be being invalidated. Note that it may include some false
 	 * positives, due to shortcuts when handing concurrent invalidations.
 	 */
-	if (unlikely(kvm->mmu_notifier_count) &&
-	    hva >= kvm->mmu_notifier_range_start &&
-	    hva < kvm->mmu_notifier_range_end)
+	if (unlikely(kvm->mmu_invalidate_in_progress) &&
+	    hva >= kvm->mmu_invalidate_range_start &&
+	    hva < kvm->mmu_invalidate_range_end)
 		return 1;
-	if (kvm->mmu_notifier_seq != mmu_seq)
+	if (kvm->mmu_invalidate_seq != mmu_seq)
 		return 1;
 	return 0;
 }
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ae79df28174e..a08e187e056a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -274,9 +274,11 @@ struct hh_cache {
  * We could use other alignment values, but we must maintain the
  * relationship HH alignment <= LL alignment.
  */
-#define LL_RESERVED_SPACE(dev) \
-	((((dev)->hard_header_len + READ_ONCE((dev)->needed_headroom)) \
+#define LL_RESERVED_SPACE_EX(dev, hlen) \
+	((((hlen) + READ_ONCE((dev)->needed_headroom)) \
 	  & ~(HH_DATA_MOD - 1)) + HH_DATA_MOD)
+#define LL_RESERVED_SPACE(dev) \
+	LL_RESERVED_SPACE_EX(dev, (dev)->hard_header_len)
 #define LL_RESERVED_SPACE_EXTRA(dev,extra) \
 	((((dev)->hard_header_len + READ_ONCE((dev)->needed_headroom) + (extra)) \
 	  & ~(HH_DATA_MOD - 1)) + HH_DATA_MOD)
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index adea5a4771cf..c94d2856edc2 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -77,6 +77,9 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
 /* default ECAM ops */
 extern const struct pci_ecam_ops pci_generic_ecam_ops;
 
+/* default CAM ops */
+extern const struct pci_ecam_ops pci_generic_cam_ops;
+
 #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
 extern const struct pci_ecam_ops pci_32b_ops;	/* 32-bit accesses only */
 extern const struct pci_ecam_ops pci_32b_read_ops; /* 32-bit read only */
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index dd6203f3f0a5..42238e7accb3 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -93,6 +93,7 @@ struct Qdisc {
 	struct hlist_node       hash;
 	u32			handle;
 	u32			parent;
+	int			depth;
 
 	struct netdev_queue	*dev_queue;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 156221bd5661..dc59568a538f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2110,18 +2110,6 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 	if (event->group_leader == event)
 		del_event_from_groups(event, ctx);
 
-	/*
-	 * If event was in error state, then keep it
-	 * that way, otherwise bogus counts will be
-	 * returned on read(). The only way to get out
-	 * of error state is by explicit re-enabling
-	 * of the event
-	 */
-	if (event->state > PERF_EVENT_STATE_OFF) {
-		perf_cgroup_event_disable(event, ctx);
-		perf_event_set_state(event, PERF_EVENT_STATE_OFF);
-	}
-
 	ctx->generation++;
 }
 
@@ -2138,14 +2126,13 @@ perf_aux_output_match(struct perf_event *event, struct perf_event *aux_event)
 }
 
 static void put_event(struct perf_event *event);
-static void event_sched_out(struct perf_event *event,
-			    struct perf_cpu_context *cpuctx,
-			    struct perf_event_context *ctx);
+static void __event_disable(struct perf_event *event,
+			    struct perf_event_context *ctx,
+			    enum perf_event_state state);
 
 static void perf_put_aux_event(struct perf_event *event)
 {
 	struct perf_event_context *ctx = event->ctx;
-	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
 	struct perf_event *iter;
 
 	/*
@@ -2174,8 +2161,7 @@ static void perf_put_aux_event(struct perf_event *event)
 		 * state so that we don't try to schedule it again. Note
 		 * that perf_event_enable() will clear the ERROR status.
 		 */
-		event_sched_out(iter, cpuctx, ctx);
-		perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
+		__event_disable(iter, ctx, PERF_EVENT_STATE_ERROR);
 	}
 }
 
@@ -2229,19 +2215,32 @@ static inline struct list_head *get_event_list(struct perf_event *event)
 	return event->attr.pinned ? &ctx->pinned_active : &ctx->flexible_active;
 }
 
-/*
- * Events that have PERF_EV_CAP_SIBLING require being part of a group and
- * cannot exist on their own, schedule them out and move them into the ERROR
- * state. Also see _perf_event_enable(), it will not be able to recover
- * this ERROR state.
- */
-static inline void perf_remove_sibling_event(struct perf_event *event)
+/* @sibling must already be unlinked from its old leader's sibling_list. */
+static void perf_promote_sibling_to_leader(struct perf_event *sibling,
+					   struct perf_event_context *ctx,
+					   int group_caps)
 {
-	struct perf_event_context *ctx = event->ctx;
-	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
+	/*
+	 * Events that have PERF_EV_CAP_SIBLING require being part of
+	 * a group and cannot exist on their own, schedule them out
+	 * and move them into the ERROR state. Also see
+	 * _perf_event_enable(), it will not be able to recover this
+	 * ERROR state.
+	 */
+	if (sibling->event_caps & PERF_EV_CAP_SIBLING)
+		__event_disable(sibling, ctx, PERF_EVENT_STATE_ERROR);
+
+	sibling->group_leader = sibling;
+	sibling->group_caps = group_caps;
+
+	if (sibling->attach_state & PERF_ATTACH_CONTEXT) {
+		add_event_to_groups(sibling, ctx);
+
+		if (sibling->state == PERF_EVENT_STATE_ACTIVE)
+			list_add_tail(&sibling->active_list, get_event_list(sibling));
+	}
 
-	event_sched_out(event, cpuctx, ctx);
-	perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
+	perf_event__header_size(sibling);
 }
 
 static void perf_group_detach(struct perf_event *event)
@@ -2267,8 +2266,9 @@ static void perf_group_detach(struct perf_event *event)
 	 */
 	if (leader != event) {
 		list_del_init(&event->sibling_list);
-		event->group_leader->nr_siblings--;
-		event->group_leader->group_generation++;
+		leader->nr_siblings--;
+		leader->group_generation++;
+		perf_promote_sibling_to_leader(event, ctx, event->event_caps);
 		goto out;
 	}
 
@@ -2278,25 +2278,14 @@ static void perf_group_detach(struct perf_event *event)
 	 * to whatever list we are on.
 	 */
 	list_for_each_entry_safe(sibling, tmp, &event->sibling_list, sibling_list) {
-
-		if (sibling->event_caps & PERF_EV_CAP_SIBLING)
-			perf_remove_sibling_event(sibling);
-
-		sibling->group_leader = sibling;
 		list_del_init(&sibling->sibling_list);
 
 		/* Inherit group flags from the previous leader */
-		sibling->group_caps = event->group_caps;
-
-		if (sibling->attach_state & PERF_ATTACH_CONTEXT) {
-			add_event_to_groups(sibling, event->ctx);
-
-			if (sibling->state == PERF_EVENT_STATE_ACTIVE)
-				list_add_tail(&sibling->active_list, get_event_list(sibling));
-		}
+		perf_promote_sibling_to_leader(sibling, ctx, event->group_caps);
 
 		WARN_ON_ONCE(sibling->ctx != event->ctx);
 	}
+	event->nr_siblings = 0;
 
 out:
 	for_each_sibling_event(tmp, leader)
@@ -2446,6 +2435,7 @@ group_sched_out(struct perf_event *group_event,
 #define DETACH_GROUP	0x01UL
 #define DETACH_CHILD	0x02UL
 #define DETACH_DEAD	0x04UL
+#define DETACH_EXIT	0x08UL
 
 /*
  * Cross CPU call to remove a performance event
@@ -2459,6 +2449,7 @@ __perf_remove_from_context(struct perf_event *event,
 			   struct perf_event_context *ctx,
 			   void *info)
 {
+	enum perf_event_state state = PERF_EVENT_STATE_OFF;
 	unsigned long flags = (unsigned long)info;
 
 	if (ctx->is_active & EVENT_TIME) {
@@ -2470,16 +2461,20 @@ __perf_remove_from_context(struct perf_event *event,
 	 * Ensure event_sched_out() switches to OFF, at the very least
 	 * this avoids raising perf_pending_task() at this time.
 	 */
-	if (flags & DETACH_DEAD)
+	if (flags & DETACH_EXIT)
+		state = PERF_EVENT_STATE_EXIT;
+	if (flags & DETACH_DEAD) {
 		event->pending_disable = 1;
-	event_sched_out(event, cpuctx, ctx);
+		state = PERF_EVENT_STATE_DEAD;
+	}
+
+	__event_disable(event, ctx, state);
+
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	if (flags & DETACH_CHILD)
 		perf_child_detach(event);
 	list_del_event(event, ctx);
-	if (flags & DETACH_DEAD)
-		event->state = PERF_EVENT_STATE_DEAD;
 
 	if (!ctx->nr_events && ctx->is_active) {
 		if (ctx == &cpuctx->ctx)
@@ -2531,6 +2526,16 @@ static void perf_remove_from_context(struct perf_event *event, unsigned long fla
 	event_function_call(event, __perf_remove_from_context, (void *)flags);
 }
 
+static void __event_disable(struct perf_event *event,
+			    struct perf_event_context *ctx,
+			    enum perf_event_state state)
+{
+	event_sched_out(event, __get_cpu_context(ctx), ctx);
+	if (event->state > PERF_EVENT_STATE_OFF)
+		perf_cgroup_event_disable(event, ctx);
+	perf_event_set_state(event, min(event->state, state));
+}
+
 /*
  * Cross CPU call to disable a performance event
  */
@@ -2547,13 +2552,18 @@ static void __perf_event_disable(struct perf_event *event,
 		update_cgrp_time_from_event(event);
 	}
 
+	/*
+	 * When disabling a group leader, the whole group becomes ineligible
+	 * to run, so schedule out the full group.
+	 */
 	if (event == event->group_leader)
 		group_sched_out(event, cpuctx, ctx);
-	else
-		event_sched_out(event, cpuctx, ctx);
 
-	perf_event_set_state(event, PERF_EVENT_STATE_OFF);
-	perf_cgroup_event_disable(event, ctx);
+	/*
+	 * But only mark the leader OFF; the siblings will remain
+	 * INACTIVE.
+	 */
+	__event_disable(event, ctx, PERF_EVENT_STATE_OFF);
 }
 
 /*
@@ -13046,12 +13056,7 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
 		mutex_lock(&parent_event->child_mutex);
 	}
 
-	perf_remove_from_context(event, detach_flags);
-
-	raw_spin_lock_irq(&ctx->lock);
-	if (event->state > PERF_EVENT_STATE_EXIT)
-		perf_event_set_state(event, PERF_EVENT_STATE_EXIT);
-	raw_spin_unlock_irq(&ctx->lock);
+	perf_remove_from_context(event, detach_flags | DETACH_EXIT);
 
 	/*
 	 * Child events can be freed.
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 94398e024d3a..5dad4b6ec6d6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -61,6 +61,7 @@ unsigned long transparent_hugepage_flags __read_mostly =
 static struct shrinker deferred_split_shrinker;
 
 static atomic_t huge_zero_refcount;
+static DEFINE_SPINLOCK(huge_zero_lock);
 struct page *huge_zero_page __read_mostly;
 unsigned long huge_zero_pfn __read_mostly = ~0UL;
 
@@ -91,7 +92,8 @@ bool transparent_hugepage_active(struct vm_area_struct *vma)
 static bool get_huge_zero_page(void)
 {
 	struct page *zero_page;
-retry:
+
+	/* Paired with atomic_set_release(). */
 	if (likely(atomic_inc_not_zero(&huge_zero_refcount)))
 		return true;
 
@@ -102,17 +104,22 @@ static bool get_huge_zero_page(void)
 		return false;
 	}
 	count_vm_event(THP_ZERO_PAGE_ALLOC);
-	preempt_disable();
-	if (cmpxchg(&huge_zero_page, NULL, zero_page)) {
-		preempt_enable();
+
+	/* Paired with critical section in shrink_huge_zero_page_scan(). */
+	spin_lock(&huge_zero_lock);
+	if (huge_zero_page) {
+		/* Somebody else already installed it. */
+		atomic_inc(&huge_zero_refcount);
+		spin_unlock(&huge_zero_lock);
 		__free_pages(zero_page, compound_order(zero_page));
-		goto retry;
+		return true;
 	}
+	WRITE_ONCE(huge_zero_page, zero_page);
 	WRITE_ONCE(huge_zero_pfn, page_to_pfn(zero_page));
+	/* Paired with atomic_inc_not_zero(). +1 for shrinker pin. */
+	atomic_set_release(&huge_zero_refcount, 2);
+	spin_unlock(&huge_zero_lock);
 
-	/* We take additional reference here. It will be put back by shrinker */
-	atomic_set(&huge_zero_refcount, 2);
-	preempt_enable();
 	return true;
 }
 
@@ -155,15 +162,24 @@ static unsigned long shrink_huge_zero_page_count(struct shrinker *shrink,
 static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
 				       struct shrink_control *sc)
 {
-	if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) == 1) {
-		struct page *zero_page = xchg(&huge_zero_page, NULL);
-		BUG_ON(zero_page == NULL);
-		WRITE_ONCE(huge_zero_pfn, ~0UL);
-		__free_pages(zero_page, compound_order(zero_page));
-		return HPAGE_PMD_NR;
+	struct page *zero_page;
+
+	/* Paired with critical section in get_huge_zero_page(). */
+	spin_lock(&huge_zero_lock);
+	/* Paired with atomic_inc_not_zero() in get_huge_zero_page(). */
+	if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) != 1) {
+		spin_unlock(&huge_zero_lock);
+		return 0;
 	}
 
-	return 0;
+	zero_page = huge_zero_page;
+	VM_WARN_ON_ONCE(!zero_page);
+	WRITE_ONCE(huge_zero_page, NULL);
+	WRITE_ONCE(huge_zero_pfn, ~0UL);
+	spin_unlock(&huge_zero_lock);
+
+	__free_pages(zero_page, compound_order(zero_page));
+	return HPAGE_PMD_NR;
 }
 
 static struct shrinker huge_zero_page_shrinker = {
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 8a8afcd075eb..835993181dd0 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1330,7 +1330,10 @@ static struct rfcomm_session *rfcomm_recv_disc(struct rfcomm_session *s,
 	return s;
 }
 
-void rfcomm_dlc_accept(struct rfcomm_dlc *d)
+/* Must be called with rfcomm_mutex held, so that the session cannot be
+ * unlinked from under us.
+ */
+static void __rfcomm_dlc_accept(struct rfcomm_dlc *d)
 {
 	struct sock *sk = d->session->sock->sk;
 	struct l2cap_conn *conn = l2cap_pi(sk)->chan->conn;
@@ -1352,6 +1355,21 @@ void rfcomm_dlc_accept(struct rfcomm_dlc *d)
 	rfcomm_send_msc(d->session, 1, d->dlci, d->v24_sig);
 }
 
+void rfcomm_dlc_accept(struct rfcomm_dlc *d)
+{
+	rfcomm_lock();
+
+	/* rfcomm_recv_disc() sets the dlc state to BT_CLOSED before calling
+	 * __rfcomm_dlc_close(), so the RFCOMM_DEFER_SETUP handshake there is
+	 * skipped and the session can already be unlinked by the time the
+	 * deferred accept runs from rfcomm_sock_recvmsg().
+	 */
+	if (d->session)
+		__rfcomm_dlc_accept(d);
+
+	rfcomm_unlock();
+}
+
 static void rfcomm_check_accept(struct rfcomm_dlc *d)
 {
 	if (rfcomm_check_security(d)) {
@@ -1364,7 +1382,7 @@ static void rfcomm_check_accept(struct rfcomm_dlc *d)
 			d->state_change(d, 0);
 			rfcomm_dlc_unlock(d);
 		} else
-			rfcomm_dlc_accept(d);
+			__rfcomm_dlc_accept(d);
 	} else {
 		set_bit(RFCOMM_AUTH_PENDING, &d->flags);
 		rfcomm_dlc_set_timer(d, RFCOMM_AUTH_TIMEOUT);
@@ -1949,7 +1967,7 @@ static void rfcomm_process_dlcs(struct rfcomm_session *s)
 					d->state_change(d, 0);
 					rfcomm_dlc_unlock(d);
 				} else
-					rfcomm_dlc_accept(d);
+					__rfcomm_dlc_accept(d);
 			}
 			continue;
 		} else if (test_and_clear_bit(RFCOMM_AUTH_REJECT, &d->flags)) {
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 85b01dea76df..95b7cc548675 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -641,6 +641,16 @@ static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buf
 	return matches;
 }
 
+void can_set_skb_uid(struct sk_buff *skb)
+{
+	/* create non-zero unique skb identifier together with *skb */
+	while (!(skb->hash))
+		skb->hash = atomic_inc_return(&skbcounter);
+
+	skb->sw_hash = 1;
+}
+EXPORT_SYMBOL(can_set_skb_uid);
+
 static void can_receive(struct sk_buff *skb, struct net_device *dev)
 {
 	struct can_dev_rcv_lists *dev_rcv_lists;
@@ -652,9 +662,7 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 	atomic_long_inc(&pkg_stats->rx_frames);
 	atomic_long_inc(&pkg_stats->rx_frames_delta);
 
-	/* create non-zero unique skb identifier together with *skb */
-	while (!(can_skb_prv(skb)->skbcnt))
-		can_skb_prv(skb)->skbcnt = atomic_inc_return(&skbcounter);
+	can_set_skb_uid(skb);
 
 	rcu_read_lock();
 
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 2cf63940f6a9..235156223394 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -338,7 +338,6 @@ static void bcm_can_tx(struct bcm_op *op, struct canfd_frame *cf)
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	skb_put_data(skb, cf, op->cfsiz);
 
@@ -1577,7 +1576,6 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
 	}
 
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 	skb->dev = dev;
 	can_skb_set_owner(skb, sk);
 	err = can_send(skb, 1); /* send with loopback */
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 34939744dd41..1037d2c2e61a 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -114,6 +114,15 @@ MODULE_ALIAS("can-proto-6");
 #define ISOTP_FC_TIMEOUT 1	/* 1 sec */
 #define ISOTP_ECHO_TIMEOUT 2	/* 2 secs */
 
+/* so->tx_result[so->tx_gen % ISOTP_TX_RESULT_SLOTS] holds the packed value
+ * (err << ISOTP_TX_RESULT_GEN_BITS | gen) for each tx generation slot, so it
+ * can be handled with a single READ_ONCE()/WRITE_ONCE() access.
+ */
+#define ISOTP_TX_RESULT_SLOTS 4
+#define ISOTP_TX_RESULT_GEN_BITS 24
+#define ISOTP_TX_RESULT_GEN_MASK ((1U << ISOTP_TX_RESULT_GEN_BITS) - 1)
+#define ISOTP_TX_RESULT_ERR_MASK 0xFF
+
 enum {
 	ISOTP_IDLE = 0,
 	ISOTP_WAIT_FIRST_FC,
@@ -150,7 +159,8 @@ struct isotp_sock {
 	u32 force_tx_stmin;
 	u32 force_rx_stmin;
 	u32 cfecho; /* consecutive frame echo tag */
-	u32 tx_gen; /* generation, bumped per new tx transfer */
+	u32 tx_gen; /* transfer generation, increased per new tx transfer */
+	u32 tx_result[ISOTP_TX_RESULT_SLOTS]; /* per-generation result slots */
 	struct tpcon rx, tx;
 	struct list_head notifier;
 	wait_queue_head_t wait;
@@ -161,6 +171,65 @@ static LIST_HEAD(isotp_notifier_list);
 static DEFINE_SPINLOCK(isotp_notifier_lock);
 static struct isotp_sock *isotp_busy_notifier;
 
+/* increase (24 bit) tx generation value */
+static u32 isotp_inc_tx_gen(u32 gen)
+{
+	return (gen + 1) & ISOTP_TX_RESULT_GEN_MASK;
+}
+
+/* store 8 bit error and 24 bit tx generation values in packed u32 element */
+static u32 isotp_pack_tx_result(u32 gen, int err)
+{
+	return gen | ((u32)err << ISOTP_TX_RESULT_GEN_BITS);
+}
+
+/* get the 24 bit tx generation value from the tx result */
+static u32 isotp_get_tx_gen(u32 gen_err)
+{
+	return gen_err & ISOTP_TX_RESULT_GEN_MASK;
+}
+
+/* get the 8 bit error value from the tx result */
+static u32 isotp_get_tx_err(u32 gen_err)
+{
+	return (gen_err >> ISOTP_TX_RESULT_GEN_BITS) & ISOTP_TX_RESULT_ERR_MASK;
+}
+
+/* store transfer result in per-generation%4 so->tx_result[] slot */
+static void isotp_set_tx_result(struct isotp_sock *so, u32 gen, int err)
+{
+	WRITE_ONCE(so->tx_result[gen % ISOTP_TX_RESULT_SLOTS],
+		   isotp_pack_tx_result(gen, err));
+}
+
+/* fetch the result recorded for 'gen', as a (negative) errno (0 for success) */
+static int isotp_get_tx_result(struct isotp_sock *so, u32 gen)
+{
+	u32 result = READ_ONCE(so->tx_result[gen % ISOTP_TX_RESULT_SLOTS]);
+
+	if (isotp_get_tx_gen(result) != gen) {
+		pr_notice_once("can-isotp: tx_result[] slot reused before read\n");
+
+		/* report failure rather than risk a false success */
+		return -ECOMM;
+	}
+
+	return -(isotp_get_tx_err(result));
+}
+
+/* true if done, shut down or superseded ('gen' is no longer the active
+ * transfer). Reads tx.state first (acquire) so tx_gen/tx_result reads
+ * below see at least what that state write published (common sequence).
+ */
+static bool isotp_tx_gen_done(struct isotp_sock *so, u32 gen)
+{
+	/* read tx.state first for the common sequence */
+	u32 state = smp_load_acquire(&so->tx.state);
+
+	return state == ISOTP_IDLE || state == ISOTP_SHUTDOWN ||
+	       READ_ONCE(so->tx_gen) != gen;
+}
+
 static inline struct isotp_sock *isotp_sk(const struct sock *sk)
 {
 	return (struct isotp_sock *)sk;
@@ -183,7 +252,7 @@ static enum hrtimer_restart isotp_rx_timer_handler(struct hrtimer *hrtimer)
 					     rxtimer);
 	struct sock *sk = &so->sk;
 
-	if (so->rx.state == ISOTP_WAIT_DATA) {
+	if (READ_ONCE(so->rx.state) == ISOTP_WAIT_DATA) {
 		/* we did not get new data frames in time */
 
 		/* report 'connection timed out' */
@@ -192,7 +261,7 @@ static enum hrtimer_restart isotp_rx_timer_handler(struct hrtimer *hrtimer)
 			sk_error_report(sk);
 
 		/* reset rx state */
-		so->rx.state = ISOTP_IDLE;
+		WRITE_ONCE(so->rx.state, ISOTP_IDLE);
 	}
 
 	return HRTIMER_NORESTART;
@@ -218,7 +287,6 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 
 	can_skb_reserve(nskb);
 	can_skb_prv(nskb)->ifindex = dev->ifindex;
-	can_skb_prv(nskb)->skbcnt = 0;
 
 	nskb->dev = dev;
 	can_skb_set_owner(nskb, sk);
@@ -350,20 +418,19 @@ static void isotp_send_cframe(struct isotp_sock *so);
 static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 {
 	struct sock *sk = &so->sk;
+	int tx_err = EBADMSG; /* default for unknown FC status */
 
-	if (so->tx.state != ISOTP_WAIT_FC &&
-	    so->tx.state != ISOTP_WAIT_FIRST_FC)
+	if (READ_ONCE(so->tx.state) != ISOTP_WAIT_FC &&
+	    READ_ONCE(so->tx.state) != ISOTP_WAIT_FIRST_FC)
 		return 0;
 
 	hrtimer_cancel(&so->txtimer);
 
 	/* isotp_tx_timeout() may have given up on this job while
-	 * hrtimer_cancel() above waited for it to finish; so->rx_lock
-	 * (held by our caller isotp_rcv()) rules out a concurrent claim,
-	 * so a plain recheck is enough here.
+	 * hrtimer_cancel() above waited for it to finish => recheck
 	 */
-	if (so->tx.state != ISOTP_WAIT_FC &&
-	    so->tx.state != ISOTP_WAIT_FIRST_FC)
+	if (READ_ONCE(so->tx.state) != ISOTP_WAIT_FC &&
+	    READ_ONCE(so->tx.state) != ISOTP_WAIT_FIRST_FC)
 		return 1;
 
 	if ((cf->len < ae + FC_CONTENT_SZ) ||
@@ -374,13 +441,15 @@ static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
 
-		so->tx.state = ISOTP_IDLE;
+		isotp_set_tx_result(so, so->tx_gen, EBADMSG);
+		/* set to IDLE after publishing tx_result */
+		smp_store_release(&so->tx.state, ISOTP_IDLE);
 		wake_up_interruptible(&so->wait);
 		return 1;
 	}
 
 	/* get communication parameters only from the first FC frame */
-	if (so->tx.state == ISOTP_WAIT_FIRST_FC) {
+	if (READ_ONCE(so->tx.state) == ISOTP_WAIT_FIRST_FC) {
 		so->txfc.bs = cf->data[ae + 1];
 		so->txfc.stmin = cf->data[ae + 2];
 
@@ -403,13 +472,13 @@ static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 			so->tx_gap = ktime_add_ns(so->tx_gap,
 						  (so->txfc.stmin - 0xF0)
 						  * 100000);
-		so->tx.state = ISOTP_WAIT_FC;
+		WRITE_ONCE(so->tx.state, ISOTP_WAIT_FC);
 	}
 
 	switch (cf->data[ae] & 0x0F) {
 	case ISOTP_FC_CTS:
 		so->tx.bs = 0;
-		so->tx.state = ISOTP_SENDING;
+		WRITE_ONCE(so->tx.state, ISOTP_SENDING);
 		/* send CF frame and enable echo timeout handling */
 		hrtimer_start(&so->echotimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
@@ -424,14 +493,19 @@ static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 
 	case ISOTP_FC_OVFLW:
 		/* overflow on receiver side - report 'message too long' */
-		sk->sk_err = EMSGSIZE;
-		if (!sock_flag(sk, SOCK_DEAD))
-			sk_error_report(sk);
+		tx_err = EMSGSIZE;
 		fallthrough;
 
 	default:
-		/* stop this tx job */
-		so->tx.state = ISOTP_IDLE;
+		/* reserved/unknown flow status (tx_err defaults to EBADMSG) */
+
+		sk->sk_err = tx_err;
+		if (!sock_flag(sk, SOCK_DEAD))
+			sk_error_report(sk);
+
+		isotp_set_tx_result(so, so->tx_gen, tx_err);
+		/* set to IDLE after publishing tx_result */
+		smp_store_release(&so->tx.state, ISOTP_IDLE);
 		wake_up_interruptible(&so->wait);
 	}
 	return 0;
@@ -444,7 +518,7 @@ static int isotp_rcv_sf(struct sock *sk, struct canfd_frame *cf, int pcilen,
 	struct sk_buff *nskb;
 
 	hrtimer_cancel(&so->rxtimer);
-	so->rx.state = ISOTP_IDLE;
+	WRITE_ONCE(so->rx.state, ISOTP_IDLE);
 
 	if (!len || len > cf->len - pcilen)
 		return 1;
@@ -478,7 +552,7 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
 	int ff_pci_sz;
 
 	hrtimer_cancel(&so->rxtimer);
-	so->rx.state = ISOTP_IDLE;
+	WRITE_ONCE(so->rx.state, ISOTP_IDLE);
 
 	/* get the used sender LL_DL from the (first) CAN frame data length */
 	so->rx.ll_dl = padlen(cf->len);
@@ -522,7 +596,7 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
 
 	/* initial setup for this pdu reception */
 	so->rx.sn = 1;
-	so->rx.state = ISOTP_WAIT_DATA;
+	WRITE_ONCE(so->rx.state, ISOTP_WAIT_DATA);
 
 	/* no creation of flow control frames */
 	if (so->opt.flags & CAN_ISOTP_LISTEN_MODE)
@@ -540,7 +614,7 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 	struct sk_buff *nskb;
 	int i;
 
-	if (so->rx.state != ISOTP_WAIT_DATA)
+	if (READ_ONCE(so->rx.state) != ISOTP_WAIT_DATA)
 		return 0;
 
 	/* drop if timestamp gap is less than force_rx_stmin nano secs */
@@ -555,11 +629,9 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 	hrtimer_cancel(&so->rxtimer);
 
 	/* isotp_rx_timer_handler() may have raced us for so->rx.state
-	 * while hrtimer_cancel() above waited for it to finish, already
-	 * reporting ETIMEDOUT and resetting the reception; don't process
-	 * this CF into a reassembly that has already been given up on.
+	 * while hrtimer_cancel() above waited for it to finish => recheck
 	 */
-	if (so->rx.state != ISOTP_WAIT_DATA)
+	if (READ_ONCE(so->rx.state) != ISOTP_WAIT_DATA)
 		return 1;
 
 	/* CFs are never longer than the FF */
@@ -580,7 +652,7 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 			sk_error_report(sk);
 
 		/* reset rx state */
-		so->rx.state = ISOTP_IDLE;
+		WRITE_ONCE(so->rx.state, ISOTP_IDLE);
 		return 1;
 	}
 	so->rx.sn++;
@@ -594,7 +666,7 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 
 	if (so->rx.idx >= so->rx.len) {
 		/* we are done */
-		so->rx.state = ISOTP_IDLE;
+		WRITE_ONCE(so->rx.state, ISOTP_IDLE);
 
 		if ((so->opt.flags & ISOTP_CHECK_PADDING) &&
 		    check_pad(so, cf, i + 1, so->opt.rxpad_content)) {
@@ -665,8 +737,10 @@ static void isotp_rcv(struct sk_buff *skb, void *data)
 
 	if (so->opt.flags & CAN_ISOTP_HALF_DUPLEX) {
 		/* check rx/tx path half duplex expectations */
-		if ((so->tx.state != ISOTP_IDLE && n_pci_type != N_PCI_FC) ||
-		    (so->rx.state != ISOTP_IDLE && n_pci_type == N_PCI_FC))
+		if ((READ_ONCE(so->tx.state) != ISOTP_IDLE &&
+		     n_pci_type != N_PCI_FC) ||
+		    (READ_ONCE(so->rx.state) != ISOTP_IDLE &&
+		     n_pci_type == N_PCI_FC))
 			goto out_unlock;
 	}
 
@@ -760,6 +834,7 @@ static void isotp_send_cframe(struct isotp_sock *so)
 	struct canfd_frame *cf;
 	int can_send_ret;
 	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
+	u32 old_cfecho;
 
 	dev = dev_get_by_index(sock_net(sk), so->ifindex);
 	if (!dev)
@@ -773,7 +848,9 @@ static void isotp_send_cframe(struct isotp_sock *so)
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
+
+	/* set uid in tx skb to identify CF echo frames */
+	can_set_skb_uid(skb);
 
 	cf = (struct canfd_frame *)skb->data;
 	skb_put_zero(skb, so->ll.mtu);
@@ -791,12 +868,15 @@ static void isotp_send_cframe(struct isotp_sock *so)
 	skb->dev = dev;
 	can_skb_set_owner(skb, sk);
 
-	/* cfecho should have been zero'ed by init/isotp_rcv_echo() */
-	if (so->cfecho)
-		pr_notice_once("can-isotp: cfecho is %08X != 0\n", so->cfecho);
+	/* zero'ed by init/isotp_rcv_echo(); reached lock-free via
+	 * isotp_txfr_timer_handler() too, so use READ_ONCE()/WRITE_ONCE()
+	 */
+	old_cfecho = READ_ONCE(so->cfecho);
+	if (old_cfecho)
+		pr_notice_once("can-isotp: cfecho is %08X != 0\n", old_cfecho);
 
 	/* set consecutive frame echo tag */
-	so->cfecho = *(u32 *)cf->data;
+	WRITE_ONCE(so->cfecho, skb->hash);
 
 	/* send frame with local echo enabled */
 	can_send_ret = can_send(skb, 1);
@@ -848,7 +928,6 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 {
 	struct sock *sk = (struct sock *)data;
 	struct isotp_sock *so = isotp_sk(sk);
-	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 
 	/* only handle my own local echo CF/SF skb's (no FF!) */
 	if (skb->sk != sk)
@@ -860,32 +939,35 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 	spin_lock(&so->rx_lock);
 
 	/* so->cfecho may since belong to a new transfer; recheck under lock */
-	if (so->cfecho != *(u32 *)cf->data)
+	if (READ_ONCE(so->cfecho) != skb->hash)
 		goto out_unlock;
 
 	/* cancel local echo timeout */
 	hrtimer_cancel(&so->echotimer);
 
 	/* local echo skb with consecutive frame has been consumed */
-	so->cfecho = 0;
+	WRITE_ONCE(so->cfecho, 0);
 
 	/* claiming a transfer also takes so->rx_lock, so a plain recheck
 	 * is enough: so->tx.state can't have flipped to ISOTP_SENDING for
 	 * a new claim while we're still in here
 	 */
-	if (so->tx.state != ISOTP_SENDING)
+	if (READ_ONCE(so->tx.state) != ISOTP_SENDING)
 		goto out_unlock;
 
 	if (so->tx.idx >= so->tx.len) {
 		/* we are done */
-		so->tx.state = ISOTP_IDLE;
+
+		isotp_set_tx_result(so, so->tx_gen, 0);
+		/* set to IDLE after publishing tx_result */
+		smp_store_release(&so->tx.state, ISOTP_IDLE);
 		wake_up_interruptible(&so->wait);
 		goto out_unlock;
 	}
 
 	if (so->txfc.bs && so->tx.bs >= so->txfc.bs) {
 		/* stop and wait for FC with timeout */
-		so->tx.state = ISOTP_WAIT_FC;
+		WRITE_ONCE(so->tx.state, ISOTP_WAIT_FC);
 		hrtimer_start(&so->txtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
 		goto out_unlock;
@@ -907,16 +989,20 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 	spin_unlock(&so->rx_lock);
 }
 
-/* shared by so->txtimer's and so->echotimer's callbacks. Both timers get
- * cancelled under so->rx_lock elsewhere, so this must stay lock-free to
- * avoid deadlocking with that; uses so->tx_gen instead to avoid tainting
- * a new transfer with an error from the one that just timed out.
+/* isotp_tx_timeout: we did not get any flow control or echo frame in time
+ *
+ * Shared by so->txtimer's and so->echotimer's callbacks. Both timers get
+ * cancelled under so->rx_lock elsewhere, so this must stay lock-free.
+ *
+ * tx.state is acquired before tx_gen. Common sequence in isotp_tx_gen_done().
+ * cmpxchg() only orders itself, not the two preceding loads.
  */
 static enum hrtimer_restart isotp_tx_timeout(struct isotp_sock *so)
 {
 	struct sock *sk = &so->sk;
+	/* read tx.state first for the common sequence */
+	u32 old_state = smp_load_acquire(&so->tx.state);
 	u32 gen = READ_ONCE(so->tx_gen);
-	u32 old_state = READ_ONCE(so->tx.state);
 
 	/* don't handle timeouts in IDLE or SHUTDOWN state */
 	if (old_state == ISOTP_IDLE || old_state == ISOTP_SHUTDOWN)
@@ -926,14 +1012,14 @@ static enum hrtimer_restart isotp_tx_timeout(struct isotp_sock *so)
 	if (cmpxchg(&so->tx.state, old_state, ISOTP_IDLE) != old_state)
 		return HRTIMER_NORESTART;
 
-	/* we did not get any flow control or echo frame in time */
+	/* detected timeout: report 'communication error on send' */
 
-	if (READ_ONCE(so->tx_gen) == gen) {
-		/* report 'communication error on send' */
-		sk->sk_err = ECOMM;
-		if (!sock_flag(sk, SOCK_DEAD))
-			sk_error_report(sk);
-	}
+	/* a stale read of this slot by a waiter still falls back to ECOMM */
+	isotp_set_tx_result(so, gen, ECOMM);
+
+	sk->sk_err = ECOMM;
+	if (!sock_flag(sk, SOCK_DEAD))
+		sk_error_report(sk);
 
 	wake_up_interruptible(&so->wait);
 
@@ -968,7 +1054,7 @@ static enum hrtimer_restart isotp_txfr_timer_handler(struct hrtimer *hrtimer)
 		      HRTIMER_MODE_REL_SOFT);
 
 	/* cfecho should be consumed by isotp_rcv_echo() here */
-	if (so->tx.state == ISOTP_SENDING && !so->cfecho)
+	if (READ_ONCE(so->tx.state) == ISOTP_SENDING && !READ_ONCE(so->cfecho))
 		isotp_send_cframe(so);
 
 	return HRTIMER_NORESTART;
@@ -986,10 +1072,12 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	s64 hrtimer_sec = ISOTP_ECHO_TIMEOUT;
 	struct hrtimer *tx_hrt = &so->echotimer;
 	u32 new_state = ISOTP_SENDING;
+	u32 my_gen;
+	u32 old_cfecho;
 	int off;
 	int err;
 
-	if (!so->bound || so->tx.state == ISOTP_SHUTDOWN)
+	if (!so->bound || READ_ONCE(so->tx.state) == ISOTP_SHUTDOWN)
 		return -EADDRNOTAVAIL;
 
 	/* claim the socket under so->rx_lock: this serializes the claim
@@ -1006,29 +1094,33 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		if (msg->msg_flags & MSG_DONTWAIT)
 			return -EAGAIN;
 
-		if (so->tx.state == ISOTP_SHUTDOWN)
+		if (READ_ONCE(so->tx.state) == ISOTP_SHUTDOWN)
 			return -EADDRNOTAVAIL;
 
 		/* wait for complete transmission of current pdu */
 		err = wait_event_interruptible(so->wait,
-					       so->tx.state == ISOTP_IDLE);
+					       READ_ONCE(so->tx.state) == ISOTP_IDLE ||
+					       READ_ONCE(so->tx.state) == ISOTP_SHUTDOWN);
 		if (err)
 			return err;
 	}
 
-	/* new transfer: bump so->tx_gen and drain the old one's timers,
-	 * still under the so->rx_lock we just claimed the socket with
-	 */
-	WRITE_ONCE(so->tx.state, ISOTP_SENDING);
-	WRITE_ONCE(so->tx_gen, READ_ONCE(so->tx_gen) + 1);
+	/* txfrtimer's callback re-arms echotimer lock-free: drain it first */
+	hrtimer_cancel(&so->txfrtimer);
 	hrtimer_cancel(&so->txtimer);
 	hrtimer_cancel(&so->echotimer);
-	hrtimer_cancel(&so->txfrtimer);
-	so->cfecho = 0;
+
+	/* new transfer: increment so->tx_gen and set tx.state after barrier */
+	my_gen = isotp_inc_tx_gen(READ_ONCE(so->tx_gen));
+	isotp_set_tx_result(so, my_gen, ECOMM); /* prevent stale slot matching */
+	WRITE_ONCE(so->tx_gen, my_gen);
+	smp_wmb(); /* see smp_load_acquire() in isotp_tx_[timeout|gen_done] */
+	WRITE_ONCE(so->tx.state, ISOTP_SENDING);
+	WRITE_ONCE(so->cfecho, 0);
 	spin_unlock_bh(&so->rx_lock);
 
 	/* so->bound is only checked once above - a wakeup may have
-	 * unbound/rebound the socket meanwhile, so re-validate it
+	 * unbound/rebound the socket meanwhile => recheck
 	 */
 	if (!so->bound) {
 		err = -EADDRNOTAVAIL;
@@ -1069,7 +1161,9 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
+
+	/* set uid in tx skb to identify CF echo frames */
+	can_set_skb_uid(skb);
 
 	so->tx.len = size;
 	so->tx.idx = 0;
@@ -1078,8 +1172,9 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	skb_put_zero(skb, so->ll.mtu);
 
 	/* cfecho should have been zero'ed by init / former isotp_rcv_echo() */
-	if (so->cfecho)
-		pr_notice_once("can-isotp: uninit cfecho %08X\n", so->cfecho);
+	old_cfecho = READ_ONCE(so->cfecho);
+	if (old_cfecho)
+		pr_notice_once("can-isotp: uninit cfecho %08X\n", old_cfecho);
 
 	/* check for single frame transmission depending on TX_DL */
 	if (size <= so->tx.ll_dl - SF_PCI_SZ4 - ae - off) {
@@ -1107,7 +1202,7 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			cf->data[ae] |= size;
 
 		/* set CF echo tag for isotp_rcv_echo() (SF-mode) */
-		so->cfecho = *(u32 *)cf->data;
+		WRITE_ONCE(so->cfecho, skb->hash);
 	} else {
 		/* send first frame */
 
@@ -1124,7 +1219,7 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			so->txfc.bs = 0;
 
 			/* set CF echo tag for isotp_rcv_echo() (CF-mode) */
-			so->cfecho = *(u32 *)cf->data;
+			WRITE_ONCE(so->cfecho, skb->hash);
 		} else {
 			/* standard flow control check */
 			new_state = ISOTP_WAIT_FIRST_FC;
@@ -1134,12 +1229,12 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			tx_hrt = &so->txtimer;
 
 			/* no CF echo tag for isotp_rcv_echo() (FF-mode) */
-			so->cfecho = 0;
+			WRITE_ONCE(so->cfecho, 0);
 		}
 	}
 
 	spin_lock_bh(&so->rx_lock);
-	if (so->tx.state == ISOTP_SHUTDOWN) {
+	if (READ_ONCE(so->tx.state) == ISOTP_SHUTDOWN) {
 		/* isotp_release() has since taken over and already drained
 		 * our timers - don't send into a socket that's going away
 		 */
@@ -1150,7 +1245,7 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		return -EADDRNOTAVAIL;
 	}
 	/* WAIT_FIRST_FC for standard FF, else stays ISOTP_SENDING */
-	so->tx.state = new_state;
+	WRITE_ONCE(so->tx.state, new_state);
 	hrtimer_start(tx_hrt, ktime_set(hrtimer_sec, 0),
 		      HRTIMER_MODE_REL_SOFT);
 	spin_unlock_bh(&so->rx_lock);
@@ -1167,20 +1262,49 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			       __func__, ERR_PTR(err));
 
 		spin_lock_bh(&so->rx_lock);
+
+		/* new transfer already claimed by a concurrent completion,
+		 * timeout or sendmsg() while we were stuck in can_send()?
+		 */
+		if (READ_ONCE(so->tx_gen) != my_gen) {
+			/* don't touch timers and state of the new transfer */
+			spin_unlock_bh(&so->rx_lock);
+			return err;
+		}
+
 		/* no transmission -> no timeout monitoring */
 		hrtimer_cancel(tx_hrt);
 		goto err_out_drop_locked;
 	}
 
 	if (wait_tx_done) {
-		/* wait for complete transmission of current pdu */
-		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+		/* wake up for:
+		 * - concurrent sendmsg() claiming a new transfer
+		 * - complete transmission of current PDU
+		 * - shutdown state change in isotp_release()
+		 * isotp_tx_gen_done() uses common tx.state/tx_gen read sequence
+		 */
+		err = wait_event_interruptible(so->wait,
+					       isotp_tx_gen_done(so, my_gen));
 		if (err)
 			goto err_event_drop;
 
-		err = sock_error(sk);
-		if (err)
-			return err;
+		/* still our claim, but isotp_release() force-shut it down */
+		if (smp_load_acquire(&so->tx.state) == ISOTP_SHUTDOWN &&
+		    READ_ONCE(so->tx_gen) == my_gen) {
+			err = -EADDRNOTAVAIL;
+			goto err_event_drop;
+		}
+
+		/* own completion, or tx_gen moved on - either way this is
+		 * what isotp_get_tx_result() recorded for my_gen
+		 */
+		err = isotp_get_tx_result(so, my_gen);
+
+		/* drain to avoid stale error for a later poll()/SO_ERROR */
+		sock_error(sk);
+
+		return err ? err : size;
 	}
 
 	return size;
@@ -1190,15 +1314,26 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	spin_lock_bh(&so->rx_lock);
 	goto err_out_drop_locked;
 err_event_drop:
-	/* interrupted waiting on our own transfer - drain its timers */
+	/* interrupted or shut down while waiting on our own transfer */
 	spin_lock_bh(&so->rx_lock);
+
+	/* new transfer already started by concurrent sendmsg()? */
+	if (READ_ONCE(so->tx_gen) != my_gen) {
+		/* don't touch timers and states of the new transfer */
+		spin_unlock_bh(&so->rx_lock);
+		return err;
+	}
+
 	hrtimer_cancel(&so->txfrtimer);
 	hrtimer_cancel(&so->txtimer);
 	hrtimer_cancel(&so->echotimer);
 err_out_drop_locked:
 	/* release the claim; so->rx_lock still held from above */
-	so->cfecho = 0;
-	so->tx.state = ISOTP_IDLE;
+	WRITE_ONCE(so->cfecho, 0);
+
+	/* only claim to IDLE if isotp_release() has not taken over */
+	if (READ_ONCE(so->tx.state) != ISOTP_SHUTDOWN)
+		WRITE_ONCE(so->tx.state, ISOTP_IDLE);
 	spin_unlock_bh(&so->rx_lock);
 	wake_up_interruptible(&so->wait);
 
@@ -1266,8 +1401,9 @@ static int isotp_release(struct socket *sock)
 	/* best-effort: wait for a running pdu to finish, but don't block on
 	 * it forever - give up after the first signal
 	 */
-	while (so->tx.state != ISOTP_IDLE &&
-	       wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE) == 0)
+	while (READ_ONCE(so->tx.state) != ISOTP_IDLE &&
+	       wait_event_interruptible(so->wait,
+					READ_ONCE(so->tx.state) == ISOTP_IDLE) == 0)
 		;
 
 	/* claim the socket under so->rx_lock like sendmsg() does, so its
@@ -1275,9 +1411,12 @@ static int isotp_release(struct socket *sock)
 	 * unconditionally, even when a signal cut the wait above short
 	 */
 	spin_lock_bh(&so->rx_lock);
-	so->tx.state = ISOTP_SHUTDOWN;
+	WRITE_ONCE(so->tx.state, ISOTP_SHUTDOWN);
 	spin_unlock_bh(&so->rx_lock);
-	so->rx.state = ISOTP_IDLE;
+	WRITE_ONCE(so->rx.state, ISOTP_IDLE);
+
+	/* forced SHUTDOWN may have skipped IDLE (gave up on a signal) */
+	wake_up_interruptible(&so->wait);
 
 	spin_lock(&isotp_notifier_lock);
 	while (isotp_busy_notifier == so) {
@@ -1392,7 +1531,8 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	 * with so->bound in the same lock_sock() section above, so there is
 	 * no window in which a concurrent isotp_notify() could be missed.
 	 */
-	if (so->tx.state != ISOTP_IDLE || so->rx.state != ISOTP_IDLE) {
+	if (READ_ONCE(so->tx.state) != ISOTP_IDLE ||
+	    READ_ONCE(so->rx.state) != ISOTP_IDLE) {
 		err = -EAGAIN;
 		goto out;
 	}
@@ -1426,7 +1566,7 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 				isotp_rcv, sk, "isotp", sk);
 
 	/* no consecutive frame echo skb in flight */
-	so->cfecho = 0;
+	WRITE_ONCE(so->cfecho, 0);
 
 	/* register for echo skb's */
 	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
@@ -1769,7 +1909,7 @@ static __poll_t isotp_poll(struct file *file, struct socket *sock, poll_table *w
 	poll_wait(file, &so->wait, wait);
 
 	/* Check for false positives due to TX state */
-	if ((mask & EPOLLWRNORM) && (so->tx.state != ISOTP_IDLE))
+	if ((mask & EPOLLWRNORM) && (READ_ONCE(so->tx.state) != ISOTP_IDLE))
 		mask &= ~(EPOLLOUT | EPOLLWRNORM);
 
 	return mask;
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index ec2927566cf3..540836c4964d 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -889,7 +889,6 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = ndev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
 	ret = memcpy_from_msg(skb_put(skb, size), msg, size);
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 55bbcf73c873..74638cf04172 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -612,7 +612,6 @@ sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
 	skb->dev = priv->ndev;
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = priv->ndev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 	/* reserve CAN header */
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
@@ -1551,7 +1550,6 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 	skb->dev = priv->ndev;
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = priv->ndev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(skcb, rel_skcb, sizeof(*skcb));
 
diff --git a/net/can/raw.c b/net/can/raw.c
index b489689ada33..ffbb622f8842 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -74,8 +74,8 @@ MODULE_ALIAS("can-proto-1");
  */
 
 struct uniqframe {
-	int skbcnt;
 	const struct sk_buff *skb;
+	u32 hash;
 	unsigned int join_rx_count;
 };
 
@@ -136,7 +136,7 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 
 	/* eliminate multiple filter matches for the same skb */
 	if (this_cpu_ptr(ro->uniq)->skb == oskb &&
-	    this_cpu_ptr(ro->uniq)->skbcnt == can_skb_prv(oskb)->skbcnt) {
+	    this_cpu_ptr(ro->uniq)->hash == oskb->hash) {
 		if (ro->join_filters) {
 			this_cpu_inc(ro->uniq->join_rx_count);
 			/* drop frame until all enabled filters matched */
@@ -147,7 +147,7 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 		}
 	} else {
 		this_cpu_ptr(ro->uniq)->skb = oskb;
-		this_cpu_ptr(ro->uniq)->skbcnt = can_skb_prv(oskb)->skbcnt;
+		this_cpu_ptr(ro->uniq)->hash = oskb->hash;
 		this_cpu_ptr(ro->uniq)->join_rx_count = 1;
 		/* drop first frame to check all enabled filters? */
 		if (ro->join_filters && ro->count > 1)
@@ -829,7 +829,6 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	err = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (err < 0)
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 94edea03b0cb..25f25e026d8b 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -4995,7 +4995,7 @@ static int decode_watchers(void **p, void *end,
 	if (ret)
 		return ret;
 
-	*num_watchers = ceph_decode_32(p);
+	ceph_decode_32_safe(p, end, *num_watchers, bad);
 	*watchers = kcalloc(*num_watchers, sizeof(**watchers), GFP_NOIO);
 	if (!*watchers)
 		return -ENOMEM;
@@ -5009,6 +5009,9 @@ static int decode_watchers(void **p, void *end,
 	}
 
 	return 0;
+
+bad:
+	return -EINVAL;
 }
 
 /*
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 7e3817011199..7922b10f360e 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -339,16 +339,18 @@ static struct inet_frag_queue *inet_frag_create(struct fqdir *fqdir,
 		*prev = ERR_PTR(-ENOMEM);
 		return NULL;
 	}
-	mod_timer(&q->timer, jiffies + fqdir->timeout);
 
+	spin_lock_bh(&q->lock);
 	*prev = rhashtable_lookup_get_insert_key(&fqdir->rhashtable, &q->key,
 						 &q->node, f->rhash_params);
 	if (*prev) {
 		q->flags |= INET_FRAG_COMPLETE;
-		inet_frag_kill(q);
+		spin_unlock_bh(&q->lock);
 		inet_frag_destroy(q);
 		return NULL;
 	}
+	mod_timer(&q->timer, jiffies + fqdir->timeout);
+	spin_unlock_bh(&q->lock);
 	return q;
 }
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 1d353f3c4403..fb64f5fcc422 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -795,6 +795,10 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	 */
 
 	hlen = iph->ihl * 4;
+	if (mtu < hlen + 8) {
+		err = -EMSGSIZE;
+		goto fail;
+	}
 	mtu = mtu - hlen;	/* Size of data space */
 	IPCB(skb)->flags |= IPSKB_FRAG_COMPLETE;
 	ll_rs = LL_RESERVED_SPACE(rt->dst.dev);
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 65b3168bce31..ab745cda1179 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -118,6 +118,8 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 
 		if (res != LWTUNNEL_XMIT_CONTINUE)
 			return res;
+		hdr = ipv6_hdr(skb);
+		daddr = &hdr->daddr;
 	}
 
 	rcu_read_lock_bh();
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 78e83ce15cc1..c913f1903380 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -45,6 +45,14 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 				expected_opsize = TCPOLEN_MPTCP_MPC_SYN;
 		}
 
+		/* Only the MPC + ACK can be used with a RM_ADDR */
+		if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)) {
+			if ((mp_opt->suboptions & ~OPTION_MPTCP_RM_ADDR) != 0)
+				break;
+		} else if (mp_opt->suboptions != 0) {
+			break;
+		}
+
 		/* Cfr RFC 8684 Section 3.3.0:
 		 * If a checksum is present but its use had
 		 * not been negotiated in the MP_CAPABLE handshake, the receiver MUST
@@ -117,6 +125,11 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_MP_JOIN:
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTION_MPTCP_RM_ADDR |
+					    OPTION_MPTCP_PRIO)) != 0)
+			break;
+
 		if (opsize == TCPOLEN_MPTCP_MPJ_SYN) {
 			mp_opt->suboptions |= OPTION_MPTCP_MPJ_SYN;
 			mp_opt->backup = *ptr++ & MPTCPOPT_BACKUP;
@@ -148,6 +161,14 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_DSS:
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTION_MPTCP_ADD_ADDR |
+					    OPTION_MPTCP_RM_ADDR |
+					    OPTION_MPTCP_PRIO |
+					    OPTION_MPTCP_FASTCLOSE |
+					    OPTION_MPTCP_FAIL)) != 0)
+			break;
+
 		pr_debug("DSS\n");
 		ptr++;
 
@@ -235,6 +256,12 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_ADD_ADDR:
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_DSS |
+					    OPTION_MPTCP_RM_ADDR |
+					    OPTION_MPTCP_PRIO)) != 0)
+			break;
+
 		mp_opt->echo = (*ptr++) & MPTCP_ADDR_ECHO;
 		if (!mp_opt->echo) {
 			if (opsize == TCPOLEN_MPTCP_ADD_ADDR ||
@@ -294,6 +321,14 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_RM_ADDR:
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_MPC |
+					    OPTIONS_MPTCP_MPJ |
+					    OPTIONS_MPTCP_DSS |
+					    OPTION_MPTCP_ADD_ADDR |
+					    OPTION_MPTCP_PRIO)) != 0)
+			break;
+
 		if (opsize < TCPOLEN_MPTCP_RM_ADDR_BASE + 1 ||
 		    opsize > TCPOLEN_MPTCP_RM_ADDR_BASE + MPTCP_RM_IDS_MAX)
 			break;
@@ -308,6 +343,13 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_MP_PRIO:
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_MPJ |
+					    OPTIONS_MPTCP_DSS |
+					    OPTION_MPTCP_ADD_ADDR |
+					    OPTION_MPTCP_RM_ADDR)) != 0)
+			break;
+
 		if (opsize != TCPOLEN_MPTCP_PRIO)
 			break;
 
@@ -317,6 +359,11 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_MP_FASTCLOSE:
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_DSS |
+					    OPTION_MPTCP_RST)) != 0)
+			break;
+
 		if (opsize != TCPOLEN_MPTCP_FASTCLOSE)
 			break;
 
@@ -327,6 +374,11 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_RST:
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTION_MPTCP_FAIL |
+					    OPTION_MPTCP_FASTCLOSE)) != 0)
+			break;
+
 		if (opsize != TCPOLEN_MPTCP_RST)
 			break;
 
@@ -340,6 +392,11 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_MP_FAIL:
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_DSS |
+					    OPTION_MPTCP_RST)) != 0)
+			break;
+
 		if (opsize != TCPOLEN_MPTCP_FAIL)
 			break;
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 87321d545564..e912615e008f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -36,6 +36,7 @@ struct mptcp_pm_add_entry {
 	struct timer_list	add_timer;
 	struct mptcp_sock	*sock;
 	u8			retrans_times;
+	bool			timer_done;
 	struct rcu_head		rcu;
 };
 
@@ -316,28 +317,23 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	struct mptcp_pm_add_entry *entry = from_timer(entry, timer, add_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
-	unsigned int timeout;
+	unsigned int timeout = 0;
+	bool retransmit;
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!msk)
-		return;
-
-	if (inet_sk_state_load(sk) == TCP_CLOSE)
-		return;
-
-	if (!entry->addr.id)
-		return;
-
 	bh_lock_sock(sk);
+	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
+		goto out;
+
 	if (sock_owned_by_user(sk)) {
 		/* Try again later. */
-		sk_reset_timer(sk, timer, jiffies + HZ / 20);
+		timeout = HZ / 20;
 		goto out;
 	}
 
 	if (mptcp_pm_should_add_signal_addr(msk)) {
-		sk_reset_timer(sk, timer, jiffies + HZ);
+		timeout = HZ;
 		goto out;
 	}
 
@@ -360,18 +356,23 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		entry->retrans_times++;
 	}
 
-	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
-		sk_reset_timer(sk, timer,
-			       jiffies + timeout);
+	retransmit = entry->retrans_times < ADD_ADDR_RETRANS_MAX;
+	if (!retransmit)
+		timeout = 0;
 
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry->retrans_times == ADD_ADDR_RETRANS_MAX)
+	if (!retransmit)
 		mptcp_pm_subflow_established(msk);
 
 out:
+	if (timeout)
+		sk_reset_timer(sk, timer, jiffies + timeout);
+	else
+		/* if sock_put calls sk_free: avoid waiting for this timer */
+		entry->timer_done = true;
 	bh_unlock_sock(sk);
-	__sock_put(sk);
+	sock_put(sk);
 }
 
 struct mptcp_pm_add_entry *
@@ -432,6 +433,7 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry->retrans_times = 0;
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
+	add_entry->timer_done = false;
 	timeout = mptcp_get_add_addr_timeout(net);
 	if (timeout)
 		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
@@ -452,7 +454,8 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
-		sk_stop_timer_sync(sk, &entry->add_timer);
+		if (!entry->timer_done)
+			sk_stop_timer_sync(sk, &entry->add_timer);
 		kfree_rcu(entry, rcu);
 	}
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4767b5ea29df..609e7768fab3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -35,6 +35,7 @@
 				 OPTION_MPTCP_MPC_ACK)
 #define OPTIONS_MPTCP_MPJ	(OPTION_MPTCP_MPJ_SYN | OPTION_MPTCP_MPJ_SYNACK | \
 				 OPTION_MPTCP_MPJ_ACK)
+#define OPTIONS_MPTCP_DSS	(OPTION_MPTCP_DSS | OPTION_MPTCP_CSUMREQD)
 
 /* MPTCP option subtypes */
 #define MPTCPOPT_MP_CAPABLE	0
diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
index e29dd10f280e..3c2d225d694a 100644
--- a/net/nfc/digital_technology.c
+++ b/net/nfc/digital_technology.c
@@ -778,6 +778,8 @@ static void digital_in_recv_sensf_res(struct nfc_digital_dev *ddev, void *arg,
 
 	sensf_res = (struct digital_sensf_res *)resp->data;
 
+	resp->len = min_t(unsigned int, resp->len, NFC_SENSF_RES_MAXSIZE);
+
 	memcpy(target.sensf_res, sensf_res, resp->len);
 	target.sensf_res_len = resp->len;
 
diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index 706da71c5f29..48d02c968601 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -193,7 +193,8 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
 			  const u8 *tlv_array, u16 tlv_array_len)
 {
 	const u8 *tlv = tlv_array;
-	u8 type, length, offset = 0;
+	u8 type, length;
+	u16 offset = 0;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
@@ -201,9 +202,15 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
 		return -ENODEV;
 
 	while (offset < tlv_array_len) {
+		if (offset + 2 > tlv_array_len)
+			return -EINVAL;
+
 		type = tlv[0];
 		length = tlv[1];
 
+		if (offset + 2 + length > tlv_array_len)
+			return -EINVAL;
+
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		switch (type) {
@@ -243,7 +250,8 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
 				  const u8 *tlv_array, u16 tlv_array_len)
 {
 	const u8 *tlv = tlv_array;
-	u8 type, length, offset = 0;
+	u8 type, length;
+	u16 offset = 0;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
@@ -251,9 +259,15 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
 		return -ENOTCONN;
 
 	while (offset < tlv_array_len) {
+		if (offset + 2 > tlv_array_len)
+			return -EINVAL;
+
 		type = tlv[0];
 		length = tlv[1];
 
+		if (offset + 2 + length > tlv_array_len)
+			return -EINVAL;
+
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		switch (type) {
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index c7de44637e01..c5971ccd33ea 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -856,13 +856,16 @@ static struct nfc_llcp_sock *nfc_llcp_sock_get_sn(struct nfc_llcp_local *local,
 static const u8 *nfc_llcp_connect_sn(const struct sk_buff *skb, size_t *sn_len)
 {
 	u8 type, length;
-	const u8 *tlv = &skb->data[2];
-	size_t tlv_array_len = skb->len - LLCP_HEADER_SIZE, offset = 0;
+	const u8 *tlv = &skb->data[LLCP_HEADER_SIZE];
+	const u8 *tlv_end = skb_tail_pointer(skb);
 
-	while (offset < tlv_array_len) {
+	while (tlv + 2 < tlv_end) {
 		type = tlv[0];
 		length = tlv[1];
 
+		if (tlv + 2 + length > tlv_end)
+			break;
+
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		if (type == LLCP_TLV_SN) {
@@ -870,7 +873,6 @@ static const u8 *nfc_llcp_connect_sn(const struct sk_buff *skb, size_t *sn_len)
 			return &tlv[2];
 		}
 
-		offset += length + 2;
 		tlv += length + 2;
 	}
 
@@ -1559,6 +1561,11 @@ static void nfc_llcp_rx_work(struct work_struct *work)
 
 static void __nfc_llcp_recv(struct nfc_llcp_local *local, struct sk_buff *skb)
 {
+	if (!pskb_may_pull(skb, LLCP_HEADER_SIZE)) {
+		kfree_skb(skb);
+		return;
+	}
+
 	local->rx_pending = skb;
 	del_timer(&local->link_timer);
 	schedule_work(&local->rx_work);
diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index a63b935872ca..59e349957e7a 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -440,7 +440,7 @@ void nci_clear_target_list(struct nci_dev *ndev)
 static int nci_rf_discover_ntf_packet(struct nci_dev *ndev,
 				      const struct sk_buff *skb)
 {
-	struct nci_rf_discover_ntf ntf;
+	struct nci_rf_discover_ntf ntf = {};
 	const __u8 *data;
 	bool add_target = true;
 
@@ -603,6 +603,12 @@ static void nci_target_auto_activated(struct nci_dev *ndev,
 	struct nfc_target *target;
 	int rc;
 
+	/* This is a new target, check if we've enough room */
+	if (ndev->n_targets == NCI_MAX_DISCOVERED_TARGETS) {
+		pr_debug("not enough room, ignoring new target...\n");
+		return;
+	}
+
 	target = &ndev->targets[ndev->n_targets];
 
 	rc = nci_add_new_protocol(ndev, target, ntf->rf_protocol,
@@ -666,7 +672,7 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 					    const struct sk_buff *skb)
 {
 	struct nci_conn_info *conn_info;
-	struct nci_rf_intf_activated_ntf ntf;
+	struct nci_rf_intf_activated_ntf ntf = {};
 	const __u8 *data;
 	int err = NCI_STATUS_OK;
 
diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index b911ab78bed9..fccd7ce69bb7 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -336,6 +336,7 @@ static void nci_core_conn_close_rsp_packet(struct nci_dev *ndev,
 			list_del(&conn_info->list);
 			if (conn_info == ndev->rf_conn_info)
 				ndev->rf_conn_info = NULL;
+			devm_kfree(&ndev->nfc_dev->dev, conn_info->dest_params);
 			devm_kfree(&ndev->nfc_dev->dev, conn_info);
 		}
 	}
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 963be5198c63..447c29d942e9 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1333,13 +1333,25 @@ static int packet_rcv_has_room(struct packet_sock *po, struct sk_buff *skb)
 	return ret;
 }
 
-static void packet_rcv_try_clear_pressure(struct packet_sock *po)
+static void __packet_rcv_try_clear_pressure(struct packet_sock *po)
 {
 	if (READ_ONCE(po->pressure) &&
 	    __packet_rcv_has_room(po, NULL) == ROOM_NORMAL)
 		WRITE_ONCE(po->pressure,  0);
 }
 
+static void packet_rcv_try_clear_pressure(struct packet_sock *po)
+{
+	struct sock *sk = &po->sk;
+
+	if (!READ_ONCE(po->pressure))
+		return;
+
+	spin_lock_bh(&sk->sk_receive_queue.lock);
+	__packet_rcv_try_clear_pressure(po);
+	spin_unlock_bh(&sk->sk_receive_queue.lock);
+}
+
 static void packet_sock_destruct(struct sock *sk)
 {
 	skb_queue_purge(&sk->sk_error_queue);
@@ -1972,8 +1984,9 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 	struct net_device *dev;
 	struct sockcm_cookie sockc;
 	__be16 proto = 0;
-	int err;
+	int hard_header_len;
 	int extra_len = 0;
+	int err;
 
 	/*
 	 *	Get and verify the address.
@@ -2016,14 +2029,18 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 		extra_len = 4; /* We're doing our own CRC */
 	}
 
+	/* Keep the allocation-time header length across retry. */
+	if (!skb)
+		hard_header_len = READ_ONCE(dev->hard_header_len);
+
 	err = -EMSGSIZE;
-	if (len > dev->mtu + dev->hard_header_len + VLAN_HLEN + extra_len)
+	if (len > dev->mtu + hard_header_len + VLAN_HLEN + extra_len)
 		goto out_unlock;
 
 	if (!skb) {
-		size_t reserved = LL_RESERVED_SPACE(dev);
+		size_t reserved = LL_RESERVED_SPACE_EX(dev, hard_header_len);
 		int tlen = dev->needed_tailroom;
-		unsigned int hhlen = dev->header_ops ? dev->hard_header_len : 0;
+		unsigned int hhlen = dev->header_ops ? hard_header_len : 0;
 
 		rcu_read_unlock();
 		skb = sock_wmalloc(sk, len + reserved + tlen, 0, GFP_KERNEL);
@@ -2053,7 +2070,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 		err = -EINVAL;
 		goto out_unlock;
 	}
-	if (len > (dev->mtu + dev->hard_header_len + extra_len) &&
+	if (len > (dev->mtu + hard_header_len + extra_len) &&
 	    !packet_extra_vlan_len_allowed(dev, skb)) {
 		err = -EMSGSIZE;
 		goto out_unlock;
@@ -2581,6 +2598,7 @@ static int packet_snd_vnet_parse(struct msghdr *msg, size_t *len,
 static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 		void *frame, struct net_device *dev, void *data, int tp_len,
 		__be16 proto, unsigned char *addr, int hlen, int copylen,
+		int hard_header_len,
 		const struct sockcm_cookie *sockc)
 {
 	union tpacket_uhdr ph;
@@ -2612,8 +2630,8 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	} else if (copylen) {
 		int hdrlen = min_t(int, copylen, tp_len);
 
-		skb_push(skb, dev->hard_header_len);
-		skb_put(skb, copylen - dev->hard_header_len);
+		skb_push(skb, hard_header_len);
+		skb_put(skb, copylen - hard_header_len);
 		err = skb_store_bits(skb, 0, data, hdrlen);
 		if (unlikely(err))
 			return err;
@@ -2746,7 +2764,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 	void *data;
 	int len_sum = 0;
 	int status = TP_STATUS_AVAILABLE;
-	int hlen, tlen, copylen = 0;
+	int hard_header_len, hlen, tlen, copylen = 0;
 	long timeo;
 
 	mutex_lock(&po->pg_vec_lock);
@@ -2793,8 +2811,9 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto out_put;
 	}
 
+	hard_header_len = READ_ONCE(dev->hard_header_len);
 	if (po->sk.sk_socket->type == SOCK_RAW)
-		reserve = dev->hard_header_len;
+		reserve = hard_header_len;
 	size_max = po->tx_ring.frame_size
 		- (po->tp_hdrlen - sizeof(struct sockaddr_ll));
 
@@ -2831,7 +2850,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto tpacket_error;
 
 		status = TP_STATUS_SEND_REQUEST;
-		hlen = LL_RESERVED_SPACE(dev);
+		hlen = LL_RESERVED_SPACE_EX(dev, hard_header_len);
 		tlen = dev->needed_tailroom;
 		if (po->has_vnet_hdr) {
 			data += sizeof(vnet_hdr);
@@ -2849,10 +2868,10 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 						    vnet_hdr.hdr_len);
 			has_vnet_hdr = true;
 		}
-		copylen = max_t(int, copylen, dev->hard_header_len);
+		copylen = max_t(int, copylen, hard_header_len);
 		skb = sock_alloc_send_skb(&po->sk,
 				hlen + tlen + sizeof(struct sockaddr_ll) +
-				(copylen - dev->hard_header_len),
+				(copylen - hard_header_len),
 				!need_wait, &err);
 
 		if (unlikely(skb == NULL)) {
@@ -2862,7 +2881,8 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto out_status;
 		}
 		tp_len = tpacket_fill_skb(po, skb, ph, dev, data, tp_len, proto,
-					  addr, hlen, copylen, &sockc);
+					  addr, hlen, copylen, hard_header_len,
+					  &sockc);
 		if (likely(tp_len >= 0) &&
 		    tp_len > dev->mtu + reserve &&
 		    !po->has_vnet_hdr &&
@@ -2969,7 +2989,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	int offset = 0;
 	struct packet_sock *po = pkt_sk(sk);
 	bool has_vnet_hdr = false;
-	int hlen, tlen, linear;
+	int hard_header_len, hlen, tlen, linear;
 	int extra_len = 0;
 
 	/*
@@ -3010,8 +3030,9 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 			goto out_unlock;
 	}
 
+	hard_header_len = READ_ONCE(dev->hard_header_len);
 	if (sock->type == SOCK_RAW)
-		reserve = dev->hard_header_len;
+		reserve = hard_header_len;
 	if (po->has_vnet_hdr) {
 		err = packet_snd_vnet_parse(msg, &len, &vnet_hdr);
 		if (err)
@@ -3033,10 +3054,10 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 		goto out_unlock;
 
 	err = -ENOBUFS;
-	hlen = LL_RESERVED_SPACE(dev);
+	hlen = LL_RESERVED_SPACE_EX(dev, hard_header_len);
 	tlen = dev->needed_tailroom;
 	linear = __virtio16_to_cpu(vio_le(), vnet_hdr.hdr_len);
-	linear = max(linear, min_t(int, len, dev->hard_header_len));
+	linear = max(linear, min_t(int, len, hard_header_len));
 	skb = packet_alloc_skb(sk, hlen + tlen, hlen, len, linear,
 			       msg->msg_flags & MSG_DONTWAIT, &err);
 	if (skb == NULL)
@@ -3052,7 +3073,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	} else if (reserve) {
 		skb_reserve(skb, -reserve);
 		if (len < reserve + sizeof(struct ipv6hdr) &&
-		    dev->min_header_len != dev->hard_header_len)
+		    dev->min_header_len != hard_header_len)
 			skb_reset_network_header(skb);
 	}
 
@@ -4295,7 +4316,7 @@ static __poll_t packet_poll(struct file *file, struct socket *sock,
 			TP_STATUS_KERNEL))
 			mask |= EPOLLIN | EPOLLRDNORM;
 	}
-	packet_rcv_try_clear_pressure(po);
+	__packet_rcv_try_clear_pressure(po);
 	spin_unlock_bh(&sk->sk_receive_queue.lock);
 	spin_lock_bh(&sk->sk_write_queue.lock);
 	if (po->tx_ring.pg_vec) {
@@ -4535,14 +4556,14 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 		rb->frame_max = (req->tp_frame_nr - 1);
 		rb->head = 0;
 		rb->frame_size = req->tp_frame_size;
+		po->prot_hook.func = (po->rx_ring.pg_vec) ?
+						tpacket_rcv : packet_rcv;
 		spin_unlock_bh(&rb_queue->lock);
 
 		swap(rb->pg_vec_order, order);
 		swap(rb->pg_vec_len, req->tp_block_nr);
 
 		rb->pg_vec_pages = req->tp_block_size/PAGE_SIZE;
-		po->prot_hook.func = (po->rx_ring.pg_vec) ?
-						tpacket_rcv : packet_rcv;
 		skb_queue_purge(rb_queue);
 		if (atomic_long_read(&po->mapped))
 			pr_err("packet_mmap: vma is busy: %ld\n",
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index c67d95a078f7..cbb6c2e0dbff 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1045,6 +1045,9 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 		unsigned int i, num_q, ingress;
 		struct netdev_queue *dev_queue;
 
+		if (new)
+			new->depth = 0;
+
 		ingress = 0;
 		num_q = dev->num_tx_queues;
 		if ((q && q->flags & TCQ_F_INGRESS) ||
@@ -1124,9 +1127,15 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 			NL_SET_ERR_MSG(extack, "STAB not supported on a non root");
 			return -EINVAL;
 		}
+		if (new && parent->depth >= 7) {
+			NL_SET_ERR_MSG(extack, "Qdisc hierarchy is too deep");
+			return -E2BIG;
+		}
 		err = cops->graft(parent, cl, new, &old, extack);
 		if (err)
 			return err;
+		if (new)
+			new->depth = parent->depth + 1;
 		notify_and_destroy(net, skb, n, classid, old, new);
 	}
 	return 0;
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 8a75c91a02b4..7180d4810d33 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2430,7 +2430,7 @@ int xfrm_user_policy(struct sock *sk, int optname, sockptr_t optval, int optlen)
 	if (sockptr_is_null(optval) && !optlen) {
 		xfrm_sk_policy_insert(sk, XFRM_POLICY_IN, NULL);
 		xfrm_sk_policy_insert(sk, XFRM_POLICY_OUT, NULL);
-		__sk_dst_reset(sk);
+		sk_dst_reset(sk);
 		return 0;
 	}
 
@@ -2470,7 +2470,7 @@ int xfrm_user_policy(struct sock *sk, int optname, sockptr_t optval, int optlen)
 	if (err >= 0) {
 		xfrm_sk_policy_insert(sk, err, pol);
 		xfrm_pol_put(pol);
-		__sk_dst_reset(sk);
+		sk_dst_reset(sk);
 		err = 0;
 	}
 
diff --git a/sound/aoa/codecs/onyx.c b/sound/aoa/codecs/onyx.c
index 293ea2d2600e..1abee841cc45 100644
--- a/sound/aoa/codecs/onyx.c
+++ b/sound/aoa/codecs/onyx.c
@@ -121,9 +121,10 @@ static int onyx_snd_vol_get(struct snd_kcontrol *kcontrol,
 	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
 	s8 l, r;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_DAC_ATTEN_LEFT, &l);
 	onyx_read_register(onyx, ONYX_REG_DAC_ATTEN_RIGHT, &r);
+	mutex_unlock(&onyx->mutex);
 
 	ucontrol->value.integer.value[0] = l + VOLUME_RANGE_SHIFT;
 	ucontrol->value.integer.value[1] = r + VOLUME_RANGE_SHIFT;
@@ -144,13 +145,15 @@ static int onyx_snd_vol_put(struct snd_kcontrol *kcontrol,
 	    ucontrol->value.integer.value[1] > -1 + VOLUME_RANGE_SHIFT)
 		return -EINVAL;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_DAC_ATTEN_LEFT, &l);
 	onyx_read_register(onyx, ONYX_REG_DAC_ATTEN_RIGHT, &r);
 
 	if (l + VOLUME_RANGE_SHIFT == ucontrol->value.integer.value[0] &&
-	    r + VOLUME_RANGE_SHIFT == ucontrol->value.integer.value[1])
+	    r + VOLUME_RANGE_SHIFT == ucontrol->value.integer.value[1]) {
+		mutex_unlock(&onyx->mutex);
 		return 0;
+	}
 
 	onyx_write_register(onyx, ONYX_REG_DAC_ATTEN_LEFT,
 			    ucontrol->value.integer.value[0]
@@ -158,6 +161,7 @@ static int onyx_snd_vol_put(struct snd_kcontrol *kcontrol,
 	onyx_write_register(onyx, ONYX_REG_DAC_ATTEN_RIGHT,
 			    ucontrol->value.integer.value[1]
 			     - VOLUME_RANGE_SHIFT);
+	mutex_unlock(&onyx->mutex);
 
 	return 1;
 }
@@ -193,8 +197,9 @@ static int onyx_snd_inputgain_get(struct snd_kcontrol *kcontrol,
 	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
 	u8 ig;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_ADC_CONTROL, &ig);
+	mutex_unlock(&onyx->mutex);
 
 	ucontrol->value.integer.value[0] =
 		(ig & ONYX_ADC_PGA_GAIN_MASK) + INPUTGAIN_RANGE_SHIFT;
@@ -211,13 +216,14 @@ static int onyx_snd_inputgain_put(struct snd_kcontrol *kcontrol,
 	if (ucontrol->value.integer.value[0] < 3 + INPUTGAIN_RANGE_SHIFT ||
 	    ucontrol->value.integer.value[0] > 28 + INPUTGAIN_RANGE_SHIFT)
 		return -EINVAL;
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_ADC_CONTROL, &v);
 	n = v;
 	n &= ~ONYX_ADC_PGA_GAIN_MASK;
 	n |= (ucontrol->value.integer.value[0] - INPUTGAIN_RANGE_SHIFT)
 		& ONYX_ADC_PGA_GAIN_MASK;
 	onyx_write_register(onyx, ONYX_REG_ADC_CONTROL, n);
+	mutex_unlock(&onyx->mutex);
 
 	return n != v;
 }
@@ -245,8 +251,9 @@ static int onyx_snd_capture_source_get(struct snd_kcontrol *kcontrol,
 	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
 	s8 v;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_ADC_CONTROL, &v);
+	mutex_unlock(&onyx->mutex);
 
 	ucontrol->value.enumerated.item[0] = !!(v&ONYX_ADC_INPUT_MIC);
 
@@ -257,12 +264,13 @@ static void onyx_set_capture_source(struct onyx *onyx, int mic)
 {
 	s8 v;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_ADC_CONTROL, &v);
 	v &= ~ONYX_ADC_INPUT_MIC;
 	if (mic)
 		v |= ONYX_ADC_INPUT_MIC;
 	onyx_write_register(onyx, ONYX_REG_ADC_CONTROL, v);
+	mutex_unlock(&onyx->mutex);
 }
 
 static int onyx_snd_capture_source_put(struct snd_kcontrol *kcontrol,
@@ -303,8 +311,9 @@ static int onyx_snd_mute_get(struct snd_kcontrol *kcontrol,
 	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
 	u8 c;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_DAC_CONTROL, &c);
+	mutex_unlock(&onyx->mutex);
 
 	ucontrol->value.integer.value[0] = !(c & ONYX_MUTE_LEFT);
 	ucontrol->value.integer.value[1] = !(c & ONYX_MUTE_RIGHT);
@@ -319,9 +328,9 @@ static int onyx_snd_mute_put(struct snd_kcontrol *kcontrol,
 	u8 v = 0, c = 0;
 	int err = -EBUSY;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	if (onyx->analog_locked)
-		return -EBUSY;
+		goto out_unlock;
 
 	onyx_read_register(onyx, ONYX_REG_DAC_CONTROL, &v);
 	c = v;
@@ -332,6 +341,9 @@ static int onyx_snd_mute_put(struct snd_kcontrol *kcontrol,
 		c |= ONYX_MUTE_RIGHT;
 	err = onyx_write_register(onyx, ONYX_REG_DAC_CONTROL, c);
 
+ out_unlock:
+	mutex_unlock(&onyx->mutex);
+
 	return !err ? (v != c) : err;
 }
 
@@ -360,8 +372,9 @@ static int onyx_snd_single_bit_get(struct snd_kcontrol *kcontrol,
 	u8 address = (pv >> 8) & 0xff;
 	u8 mask = pv & 0xff;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx_read_register(onyx, address, &c);
+	mutex_unlock(&onyx->mutex);
 
 	ucontrol->value.integer.value[0] = !!(c & mask) ^ polarity;
 
@@ -380,10 +393,11 @@ static int onyx_snd_single_bit_put(struct snd_kcontrol *kcontrol,
 	u8 address = (pv >> 8) & 0xff;
 	u8 mask = pv & 0xff;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	if (spdiflock && onyx->spdif_locked) {
 		/* even if alsamixer doesn't care.. */
-		return -EBUSY;
+		err = -EBUSY;
+		goto out_unlock;
 	}
 	onyx_read_register(onyx, address, &v);
 	c = v;
@@ -392,6 +406,9 @@ static int onyx_snd_single_bit_put(struct snd_kcontrol *kcontrol,
 		c |= mask;
 	err = onyx_write_register(onyx, address, c);
 
+ out_unlock:
+	mutex_unlock(&onyx->mutex);
+
 	return !err ? (v != c) : err;
 }
 
@@ -472,7 +489,7 @@ static int onyx_spdif_get(struct snd_kcontrol *kcontrol,
 	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
 	u8 v;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_DIG_INFO1, &v);
 	ucontrol->value.iec958.status[0] = v & 0x3e;
 
@@ -484,6 +501,7 @@ static int onyx_spdif_get(struct snd_kcontrol *kcontrol,
 
 	onyx_read_register(onyx, ONYX_REG_DIG_INFO4, &v);
 	ucontrol->value.iec958.status[4] = v & 0x0f;
+	mutex_unlock(&onyx->mutex);
 
 	return 0;
 }
@@ -494,7 +512,7 @@ static int onyx_spdif_put(struct snd_kcontrol *kcontrol,
 	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
 	u8 v;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_DIG_INFO1, &v);
 	v = (v & ~0x3e) | (ucontrol->value.iec958.status[0] & 0x3e);
 	onyx_write_register(onyx, ONYX_REG_DIG_INFO1, v);
@@ -509,6 +527,7 @@ static int onyx_spdif_put(struct snd_kcontrol *kcontrol,
 	onyx_read_register(onyx, ONYX_REG_DIG_INFO4, &v);
 	v = (v & ~0x0f) | (ucontrol->value.iec958.status[4] & 0x0f);
 	onyx_write_register(onyx, ONYX_REG_DIG_INFO4, v);
+	mutex_unlock(&onyx->mutex);
 
 	return 1;
 }
@@ -653,13 +672,14 @@ static int onyx_usable(struct codec_info_item *cii,
 	struct onyx *onyx = cii->codec_data;
 	int spdif_enabled, analog_enabled;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_DIG_INFO4, &v);
 	spdif_enabled = !!(v & ONYX_SPDIF_ENABLE);
 	onyx_read_register(onyx, ONYX_REG_DAC_CONTROL, &v);
 	analog_enabled =
 		(v & (ONYX_MUTE_RIGHT|ONYX_MUTE_LEFT))
 		 != (ONYX_MUTE_RIGHT|ONYX_MUTE_LEFT);
+	mutex_unlock(&onyx->mutex);
 
 	switch (ti->tag) {
 	case 0: return 1;
@@ -675,8 +695,9 @@ static int onyx_prepare(struct codec_info_item *cii,
 {
 	u8 v;
 	struct onyx *onyx = cii->codec_data;
+	int err = -EBUSY;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 
 #ifdef SNDRV_PCM_FMTBIT_COMPRESSED_16BE
 	if (substream->runtime->format == SNDRV_PCM_FMTBIT_COMPRESSED_16BE) {
@@ -685,9 +706,10 @@ static int onyx_prepare(struct codec_info_item *cii,
 		if (onyx_write_register(onyx,
 					ONYX_REG_DAC_CONTROL,
 					v | ONYX_MUTE_RIGHT | ONYX_MUTE_LEFT))
-			return -EBUSY;
+			goto out_unlock;
 		onyx->analog_locked = 1;
-		return 0;
+		err = 0;
+		goto out_unlock;
 	}
 #endif
 	switch (substream->runtime->rate) {
@@ -697,7 +719,8 @@ static int onyx_prepare(struct codec_info_item *cii,
 		/* these rates are ok for all outputs */
 		/* FIXME: program spdif channel control bits here so that
 		 *	  userspace doesn't have to if it only plays pcm! */
-		return 0;
+		err = 0;
+		goto out_unlock;
 	default:
 		/* got some rate that the digital output can't do,
 		 * so disable and lock it */
@@ -705,12 +728,16 @@ static int onyx_prepare(struct codec_info_item *cii,
 		if (onyx_write_register(onyx,
 					ONYX_REG_DIG_INFO4,
 					v & ~ONYX_SPDIF_ENABLE))
-			return -EBUSY;
+			goto out_unlock;
 		onyx->spdif_locked = 1;
-		return 0;
+		err = 0;
+		goto out_unlock;
 	}
 
-	return -EBUSY;
+ out_unlock:
+	mutex_unlock(&onyx->mutex);
+
+	return err;
 }
 
 static int onyx_open(struct codec_info_item *cii,
@@ -718,8 +745,9 @@ static int onyx_open(struct codec_info_item *cii,
 {
 	struct onyx *onyx = cii->codec_data;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx->open_count++;
+	mutex_unlock(&onyx->mutex);
 
 	return 0;
 }
@@ -729,10 +757,11 @@ static int onyx_close(struct codec_info_item *cii,
 {
 	struct onyx *onyx = cii->codec_data;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx->open_count--;
 	if (!onyx->open_count)
 		onyx->spdif_locked = onyx->analog_locked = 0;
+	mutex_unlock(&onyx->mutex);
 
 	return 0;
 }
@@ -742,7 +771,7 @@ static int onyx_switch_clock(struct codec_info_item *cii,
 {
 	struct onyx *onyx = cii->codec_data;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	/* this *MUST* be more elaborate later... */
 	switch (what) {
 	case CLOCK_SWITCH_PREPARE_SLAVE:
@@ -754,6 +783,7 @@ static int onyx_switch_clock(struct codec_info_item *cii,
 	default: /* silence warning */
 		break;
 	}
+	mutex_unlock(&onyx->mutex);
 
 	return 0;
 }
@@ -764,21 +794,27 @@ static int onyx_suspend(struct codec_info_item *cii, pm_message_t state)
 {
 	struct onyx *onyx = cii->codec_data;
 	u8 v;
+	int err = -ENXIO;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	if (onyx_read_register(onyx, ONYX_REG_CONTROL, &v))
-		return -ENXIO;
+		goto out_unlock;
 	onyx_write_register(onyx, ONYX_REG_CONTROL, v | ONYX_ADPSV | ONYX_DAPSV);
 	/* Apple does a sleep here but the datasheet says to do it on resume */
-	return 0;
+	err = 0;
+ out_unlock:
+	mutex_unlock(&onyx->mutex);
+
+	return err;
 }
 
 static int onyx_resume(struct codec_info_item *cii)
 {
 	struct onyx *onyx = cii->codec_data;
 	u8 v;
+	int err = -ENXIO;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 
 	/* reset codec */
 	onyx->codec.gpio->methods->set_hw_reset(onyx->codec.gpio, 0);
@@ -790,13 +826,17 @@ static int onyx_resume(struct codec_info_item *cii)
 
 	/* take codec out of suspend (if it still is after reset) */
 	if (onyx_read_register(onyx, ONYX_REG_CONTROL, &v))
-		return -ENXIO;
+		goto out_unlock;
 	onyx_write_register(onyx, ONYX_REG_CONTROL, v & ~(ONYX_ADPSV | ONYX_DAPSV));
 	/* FIXME: should divide by sample rate, but 8k is the lowest we go */
 	msleep(2205000/8000);
 	/* reset all values */
 	onyx_register_init(onyx);
-	return 0;
+	err = 0;
+ out_unlock:
+	mutex_unlock(&onyx->mutex);
+
+	return err;
 }
 
 #endif /* CONFIG_PM */
diff --git a/sound/aoa/codecs/tas.c b/sound/aoa/codecs/tas.c
index 734b629495a1..ab19a37e2a68 100644
--- a/sound/aoa/codecs/tas.c
+++ b/sound/aoa/codecs/tas.c
@@ -235,9 +235,10 @@ static int tas_snd_vol_get(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	ucontrol->value.integer.value[0] = tas->cached_volume_l;
 	ucontrol->value.integer.value[1] = tas->cached_volume_r;
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -253,15 +254,18 @@ static int tas_snd_vol_put(struct snd_kcontrol *kcontrol,
 	    ucontrol->value.integer.value[1] > 177)
 		return -EINVAL;
 
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	if (tas->cached_volume_l == ucontrol->value.integer.value[0]
-	 && tas->cached_volume_r == ucontrol->value.integer.value[1])
+	 && tas->cached_volume_r == ucontrol->value.integer.value[1]) {
+		mutex_unlock(&tas->mtx);
 		return 0;
+	}
 
 	tas->cached_volume_l = ucontrol->value.integer.value[0];
 	tas->cached_volume_r = ucontrol->value.integer.value[1];
 	if (tas->hw_enabled)
 		tas_set_volume(tas);
+	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -281,9 +285,10 @@ static int tas_snd_mute_get(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	ucontrol->value.integer.value[0] = !tas->mute_l;
 	ucontrol->value.integer.value[1] = !tas->mute_r;
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -292,15 +297,18 @@ static int tas_snd_mute_put(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	if (tas->mute_l == !ucontrol->value.integer.value[0]
-	 && tas->mute_r == !ucontrol->value.integer.value[1])
+	 && tas->mute_r == !ucontrol->value.integer.value[1]) {
+		mutex_unlock(&tas->mtx);
 		return 0;
+	}
 
 	tas->mute_l = !ucontrol->value.integer.value[0];
 	tas->mute_r = !ucontrol->value.integer.value[1];
 	if (tas->hw_enabled)
 		tas_set_volume(tas);
+	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -329,9 +337,10 @@ static int tas_snd_mixer_get(struct snd_kcontrol *kcontrol,
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 	int idx = kcontrol->private_value;
 
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	ucontrol->value.integer.value[0] = tas->mixer_l[idx];
 	ucontrol->value.integer.value[1] = tas->mixer_r[idx];
+	mutex_unlock(&tas->mtx);
 
 	return 0;
 }
@@ -342,16 +351,19 @@ static int tas_snd_mixer_put(struct snd_kcontrol *kcontrol,
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 	int idx = kcontrol->private_value;
 
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	if (tas->mixer_l[idx] == ucontrol->value.integer.value[0]
-	 && tas->mixer_r[idx] == ucontrol->value.integer.value[1])
+	 && tas->mixer_r[idx] == ucontrol->value.integer.value[1]) {
+		mutex_unlock(&tas->mtx);
 		return 0;
+	}
 
 	tas->mixer_l[idx] = ucontrol->value.integer.value[0];
 	tas->mixer_r[idx] = ucontrol->value.integer.value[1];
 
 	if (tas->hw_enabled)
 		tas_set_mixer(tas);
+	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -384,8 +396,9 @@ static int tas_snd_drc_range_get(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	ucontrol->value.integer.value[0] = tas->drc_range;
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -398,13 +411,16 @@ static int tas_snd_drc_range_put(struct snd_kcontrol *kcontrol,
 	    ucontrol->value.integer.value[0] > TAS3004_DRC_MAX)
 		return -EINVAL;
 
-	guard(mutex)(&tas->mtx);
-	if (tas->drc_range == ucontrol->value.integer.value[0])
+	mutex_lock(&tas->mtx);
+	if (tas->drc_range == ucontrol->value.integer.value[0]) {
+		mutex_unlock(&tas->mtx);
 		return 0;
+	}
 
 	tas->drc_range = ucontrol->value.integer.value[0];
 	if (tas->hw_enabled)
 		tas3004_set_drc(tas);
+	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -424,8 +440,9 @@ static int tas_snd_drc_switch_get(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	ucontrol->value.integer.value[0] = tas->drc_enabled;
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -434,13 +451,16 @@ static int tas_snd_drc_switch_put(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	guard(mutex)(&tas->mtx);
-	if (tas->drc_enabled == ucontrol->value.integer.value[0])
+	mutex_lock(&tas->mtx);
+	if (tas->drc_enabled == ucontrol->value.integer.value[0]) {
+		mutex_unlock(&tas->mtx);
 		return 0;
+	}
 
 	tas->drc_enabled = !!ucontrol->value.integer.value[0];
 	if (tas->hw_enabled)
 		tas3004_set_drc(tas);
+	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -466,8 +486,9 @@ static int tas_snd_capture_source_get(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	ucontrol->value.enumerated.item[0] = !!(tas->acr & TAS_ACR_INPUT_B);
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -479,7 +500,7 @@ static int tas_snd_capture_source_put(struct snd_kcontrol *kcontrol,
 
 	if (ucontrol->value.enumerated.item[0] > 1)
 		return -EINVAL;
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	oldacr = tas->acr;
 
 	/*
@@ -491,10 +512,13 @@ static int tas_snd_capture_source_put(struct snd_kcontrol *kcontrol,
 	if (ucontrol->value.enumerated.item[0])
 		tas->acr |= TAS_ACR_INPUT_B | TAS_ACR_B_MONAUREAL |
 		      TAS_ACR_B_MON_SEL_RIGHT;
-	if (oldacr == tas->acr)
+	if (oldacr == tas->acr) {
+		mutex_unlock(&tas->mtx);
 		return 0;
+	}
 	if (tas->hw_enabled)
 		tas_write_reg(tas, TAS_REG_ACR, 1, &tas->acr);
+	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -533,8 +557,9 @@ static int tas_snd_treble_get(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	ucontrol->value.integer.value[0] = tas->treble;
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -546,13 +571,16 @@ static int tas_snd_treble_put(struct snd_kcontrol *kcontrol,
 	if (ucontrol->value.integer.value[0] < TAS3004_TREBLE_MIN ||
 	    ucontrol->value.integer.value[0] > TAS3004_TREBLE_MAX)
 		return -EINVAL;
-	guard(mutex)(&tas->mtx);
-	if (tas->treble == ucontrol->value.integer.value[0])
+	mutex_lock(&tas->mtx);
+	if (tas->treble == ucontrol->value.integer.value[0]) {
+		mutex_unlock(&tas->mtx);
 		return 0;
+	}
 
 	tas->treble = ucontrol->value.integer.value[0];
 	if (tas->hw_enabled)
 		tas_set_treble(tas);
+	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -580,8 +608,9 @@ static int tas_snd_bass_get(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	ucontrol->value.integer.value[0] = tas->bass;
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -593,13 +622,16 @@ static int tas_snd_bass_put(struct snd_kcontrol *kcontrol,
 	if (ucontrol->value.integer.value[0] < TAS3004_BASS_MIN ||
 	    ucontrol->value.integer.value[0] > TAS3004_BASS_MAX)
 		return -EINVAL;
-	guard(mutex)(&tas->mtx);
-	if (tas->bass == ucontrol->value.integer.value[0])
+	mutex_lock(&tas->mtx);
+	if (tas->bass == ucontrol->value.integer.value[0]) {
+		mutex_unlock(&tas->mtx);
 		return 0;
+	}
 
 	tas->bass = ucontrol->value.integer.value[0];
 	if (tas->hw_enabled)
 		tas_set_bass(tas);
+	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -690,13 +722,13 @@ static int tas_switch_clock(struct codec_info_item *cii, enum clock_switch clock
 		break;
 	case CLOCK_SWITCH_SLAVE:
 		/* Clocks are back, re-init the codec */
-		scoped_guard(mutex, &tas->mtx) {
-			tas_reset_init(tas);
-			tas_set_volume(tas);
-			tas_set_mixer(tas);
-			tas->hw_enabled = 1;
-			tas->codec.gpio->methods->all_amps_restore(tas->codec.gpio);
-		}
+		mutex_lock(&tas->mtx);
+		tas_reset_init(tas);
+		tas_set_volume(tas);
+		tas_set_mixer(tas);
+		tas->hw_enabled = 1;
+		tas->codec.gpio->methods->all_amps_restore(tas->codec.gpio);
+		mutex_unlock(&tas->mtx);
 		break;
 	default:
 		/* doesn't happen as of now */
@@ -711,21 +743,23 @@ static int tas_switch_clock(struct codec_info_item *cii, enum clock_switch clock
  * our i2c device is suspended, and then take note of that! */
 static int tas_suspend(struct tas *tas)
 {
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	tas->hw_enabled = 0;
 	tas->acr |= TAS_ACR_ANALOG_PDOWN;
 	tas_write_reg(tas, TAS_REG_ACR, 1, &tas->acr);
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
 static int tas_resume(struct tas *tas)
 {
 	/* reset codec */
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	tas_reset_init(tas);
 	tas_set_volume(tas);
 	tas_set_mixer(tas);
 	tas->hw_enabled = 1;
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -768,13 +802,14 @@ static int tas_init_codec(struct aoa_codec *codec)
 		return -EINVAL;
 	}
 
-	scoped_guard(mutex, &tas->mtx) {
-		if (tas_reset_init(tas)) {
-			printk(KERN_ERR PFX "tas failed to initialise\n");
-			return -ENXIO;
-		}
-		tas->hw_enabled = 1;
+	mutex_lock(&tas->mtx);
+	if (tas_reset_init(tas)) {
+		printk(KERN_ERR PFX "tas failed to initialise\n");
+		mutex_unlock(&tas->mtx);
+		return -ENXIO;
 	}
+	tas->hw_enabled = 1;
+	mutex_unlock(&tas->mtx);
 
 	if (tas->codec.soundbus_dev->attach_codec(tas->codec.soundbus_dev,
 						   aoa_get_card(),
diff --git a/sound/aoa/core/gpio-feature.c b/sound/aoa/core/gpio-feature.c
index 19ed0e6907da..39bb409b27f6 100644
--- a/sound/aoa/core/gpio-feature.c
+++ b/sound/aoa/core/gpio-feature.c
@@ -212,9 +212,10 @@ static void ftr_handle_notify(struct work_struct *work)
 	struct gpio_notification *notif =
 		container_of(work, struct gpio_notification, work.work);
 
-	guard(mutex)(&notif->mutex);
+	mutex_lock(&notif->mutex);
 	if (notif->notify)
 		notif->notify(notif->data);
+	mutex_unlock(&notif->mutex);
 }
 
 static void gpio_enable_dual_edge(int gpio)
@@ -340,17 +341,19 @@ static int ftr_set_notify(struct gpio_runtime *rt,
 	if (!irq)
 		return -ENODEV;
 
-	guard(mutex)(&notif->mutex);
+	mutex_lock(&notif->mutex);
 
 	old = notif->notify;
 
-	if (!old && !notify)
-		return 0;
+	if (!old && !notify) {
+		err = 0;
+		goto out_unlock;
+	}
 
 	if (old && notify) {
 		if (old == notify && notif->data == data)
 			err = 0;
-		return err;
+		goto out_unlock;
 	}
 
 	if (old && !notify)
@@ -359,13 +362,16 @@ static int ftr_set_notify(struct gpio_runtime *rt,
 	if (!old && notify) {
 		err = request_irq(irq, ftr_handle_notify_irq, 0, name, notif);
 		if (err)
-			return err;
+			goto out_unlock;
 	}
 
 	notif->notify = notify;
 	notif->data = data;
 
-	return 0;
+	err = 0;
+ out_unlock:
+	mutex_unlock(&notif->mutex);
+	return err;
 }
 
 static int ftr_get_detect(struct gpio_runtime *rt,
diff --git a/sound/aoa/core/gpio-pmf.c b/sound/aoa/core/gpio-pmf.c
index e76bde25e41a..37866039d1ea 100644
--- a/sound/aoa/core/gpio-pmf.c
+++ b/sound/aoa/core/gpio-pmf.c
@@ -74,9 +74,10 @@ static void pmf_handle_notify(struct work_struct *work)
 	struct gpio_notification *notif =
 		container_of(work, struct gpio_notification, work.work);
 
-	guard(mutex)(&notif->mutex);
+	mutex_lock(&notif->mutex);
 	if (notif->notify)
 		notif->notify(notif->data);
+	mutex_unlock(&notif->mutex);
 }
 
 static void pmf_gpio_init(struct gpio_runtime *rt)
@@ -153,17 +154,19 @@ static int pmf_set_notify(struct gpio_runtime *rt,
 		return -EINVAL;
 	}
 
-	guard(mutex)(&notif->mutex);
+	mutex_lock(&notif->mutex);
 
 	old = notif->notify;
 
-	if (!old && !notify)
-		return 0;
+	if (!old && !notify) {
+		err = 0;
+		goto out_unlock;
+	}
 
 	if (old && notify) {
 		if (old == notify && notif->data == data)
 			err = 0;
-		return err;
+		goto out_unlock;
 	}
 
 	if (old && !notify) {
@@ -175,8 +178,10 @@ static int pmf_set_notify(struct gpio_runtime *rt,
 	if (!old && notify) {
 		irq_client = kzalloc(sizeof(struct pmf_irq_client),
 				     GFP_KERNEL);
-		if (!irq_client)
-			return -ENOMEM;
+		if (!irq_client) {
+			err = -ENOMEM;
+			goto out_unlock;
+		}
 		irq_client->data = notif;
 		irq_client->handler = pmf_handle_notify_irq;
 		irq_client->owner = THIS_MODULE;
@@ -187,14 +192,17 @@ static int pmf_set_notify(struct gpio_runtime *rt,
 			printk(KERN_ERR "snd-aoa: gpio layer failed to"
 					" register %s irq (%d)\n", name, err);
 			kfree(irq_client);
-			return err;
+			goto out_unlock;
 		}
 		notif->gpio_private = irq_client;
 	}
 	notif->notify = notify;
 	notif->data = data;
 
-	return 0;
+	err = 0;
+ out_unlock:
+	mutex_unlock(&notif->mutex);
+	return err;
 }
 
 static int pmf_get_detect(struct gpio_runtime *rt,
diff --git a/sound/aoa/soundbus/i2sbus/pcm.c b/sound/aoa/soundbus/i2sbus/pcm.c
index 2637507b9f66..ae047c11283f 100644
--- a/sound/aoa/soundbus/i2sbus/pcm.c
+++ b/sound/aoa/soundbus/i2sbus/pcm.c
@@ -79,10 +79,11 @@ static int i2sbus_pcm_open(struct i2sbus_dev *i2sdev, int in)
 	u64 formats = 0;
 	unsigned int rates = 0;
 	struct transfer_info v;
+	int result = 0;
 	int bus_factor = 0, sysclock_factor = 0;
 	int found_this;
 
-	guard(mutex)(&i2sdev->lock);
+	mutex_lock(&i2sdev->lock);
 
 	get_pcm_info(i2sdev, in, &pi, &other);
 
@@ -91,7 +92,8 @@ static int i2sbus_pcm_open(struct i2sbus_dev *i2sdev, int in)
 
 	if (pi->active) {
 		/* alsa messed up */
-		return -EBUSY;
+		result = -EBUSY;
+		goto out_unlock;
 	}
 
 	/* we now need to assign the hw */
@@ -115,8 +117,10 @@ static int i2sbus_pcm_open(struct i2sbus_dev *i2sdev, int in)
 			ti++;
 		}
 	}
-	if (!masks_inited || !bus_factor || !sysclock_factor)
-		return -ENODEV;
+	if (!masks_inited || !bus_factor || !sysclock_factor) {
+		result = -ENODEV;
+		goto out_unlock;
+	}
 	/* bus dependent stuff */
 	hw->info = SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
 		   SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_RESUME |
@@ -189,12 +193,15 @@ static int i2sbus_pcm_open(struct i2sbus_dev *i2sdev, int in)
 	hw->periods_max = MAX_DBDMA_COMMANDS;
 	err = snd_pcm_hw_constraint_integer(pi->substream->runtime,
 					    SNDRV_PCM_HW_PARAM_PERIODS);
-	if (err < 0)
-		return err;
+	if (err < 0) {
+		result = err;
+		goto out_unlock;
+	}
 	list_for_each_entry(cii, &sdev->codec_list, list) {
 		if (cii->codec->open) {
 			err = cii->codec->open(cii, pi->substream);
 			if (err) {
+				result = err;
 				/* unwind */
 				found_this = 0;
 				list_for_each_entry_reverse(rev,
@@ -206,12 +213,14 @@ static int i2sbus_pcm_open(struct i2sbus_dev *i2sdev, int in)
 					if (rev == cii)
 						found_this = 1;
 				}
-				return err;
+				goto out_unlock;
 			}
 		}
 	}
 
-	return 0;
+ out_unlock:
+	mutex_unlock(&i2sdev->lock);
+	return result;
 }
 
 #undef CHECK_RATE
@@ -222,7 +231,7 @@ static int i2sbus_pcm_close(struct i2sbus_dev *i2sdev, int in)
 	struct pcm_info *pi;
 	int err = 0, tmp;
 
-	guard(mutex)(&i2sdev->lock);
+	mutex_lock(&i2sdev->lock);
 
 	get_pcm_info(i2sdev, in, &pi, NULL);
 
@@ -236,6 +245,7 @@ static int i2sbus_pcm_close(struct i2sbus_dev *i2sdev, int in)
 
 	pi->substream = NULL;
 	pi->active = 0;
+	mutex_unlock(&i2sdev->lock);
 	return err;
 }
 
@@ -286,10 +296,10 @@ static void i2sbus_pcm_clear_active(struct i2sbus_dev *i2sdev, int in)
 {
 	struct pcm_info *pi;
 
-	guard(mutex)(&i2sdev->lock);
-
+	mutex_lock(&i2sdev->lock);
 	get_pcm_info(i2sdev, in, &pi, NULL);
 	pi->active = 0;
+	mutex_unlock(&i2sdev->lock);
 }
 
 static inline int i2sbus_hw_params(struct snd_pcm_substream *substream,
@@ -349,25 +359,32 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 	int input_16bit;
 	struct pcm_info *pi, *other;
 	int cnt;
+	int result = 0;
 	unsigned int cmd, stopaddr;
 
-	guard(mutex)(&i2sdev->lock);
+	mutex_lock(&i2sdev->lock);
 
 	get_pcm_info(i2sdev, in, &pi, &other);
 
-	if (pi->dbdma_ring.running)
-		return -EBUSY;
+	if (pi->dbdma_ring.running) {
+		result = -EBUSY;
+		goto out_unlock;
+	}
 	if (pi->dbdma_ring.stopping)
 		i2sbus_wait_for_stop(i2sdev, pi);
 
-	if (!pi->substream || !pi->substream->runtime)
-		return -EINVAL;
+	if (!pi->substream || !pi->substream->runtime) {
+		result = -EINVAL;
+		goto out_unlock;
+	}
 
 	runtime = pi->substream->runtime;
 	if (other->active &&
 	    ((i2sdev->format != runtime->format)
-	     || (i2sdev->rate != runtime->rate)))
-		return -EINVAL;
+	     || (i2sdev->rate != runtime->rate))) {
+		result = -EINVAL;
+		goto out_unlock;
+	}
 
 	i2sdev->format = runtime->format;
 	i2sdev->rate = runtime->rate;
@@ -432,7 +449,8 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 		input_16bit = 0;
 		break;
 	default:
-		return -EINVAL;
+		result = -EINVAL;
+		goto out_unlock;
 	}
 	/* we assume all sysclocks are the same! */
 	bi.sysclock_factor = cii->codec->sysclock_factor;
@@ -440,8 +458,10 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 	if (clock_and_divisors(bi.sysclock_factor,
 			       bi.bus_factor,
 			       runtime->rate,
-			       &sfr) < 0)
-		return -EINVAL;
+			       &sfr) < 0) {
+		result = -EINVAL;
+		goto out_unlock;
+	}
 	switch (bi.bus_factor) {
 	case 32:
 		sfr |= I2S_SF_SERIAL_FORMAT_I2S_32X;
@@ -457,8 +477,10 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 		int err = 0;
 		if (cii->codec->prepare)
 			err = cii->codec->prepare(cii, &bi, pi->substream);
-		if (err)
-			return err;
+		if (err) {
+			result = err;
+			goto out_unlock;
+		}
 	}
 	/* codecs are fine with it, so set our clocks */
 	if (input_16bit)
@@ -475,7 +497,7 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 	if (in_le32(&i2sdev->intfregs->serial_format) == sfr &&
 	    in_le32(&i2sdev->intfregs->data_word_sizes) == dws) {
 		pi->active = 1;
-		return 0;
+		goto out_unlock;
 	}
 
 	/* let's notify the codecs about clocks going away.
@@ -515,7 +537,10 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 			cii->codec->switch_clock(cii, CLOCK_SWITCH_SLAVE);
 
 	pi->active = 1;
-	return 0;
+
+ out_unlock:
+	mutex_unlock(&i2sdev->lock);
+	return result;
 }
 
 #ifdef CONFIG_PM
diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 2a7fc49c1a7c..fc8818699d81 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -1025,6 +1025,12 @@ static int snd_dummy_probe(struct platform_device *devptr)
 	int idx, err;
 	int dev = devptr->id;
 
+	if (dev < 0 || dev >= SNDRV_CARDS) {
+		dev_warn(&devptr->dev,
+			 "Invalid card index %d, using default 0\n", dev);
+		dev = 0;
+	}
+
 	err = snd_devm_card_new(&devptr->dev, index[dev], id[dev], THIS_MODULE,
 				sizeof(struct snd_dummy), &card);
 	if (err < 0)
diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 095c6dc56446..f32db1eda631 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -1013,7 +1013,7 @@ static int tx_macro_dec_mode_get(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	int path = e->shift_l;
 
-	ucontrol->value.integer.value[0] = tx->dec_mode[path];
+	ucontrol->value.enumerated.item[0] = tx->dec_mode[path];
 
 	return 0;
 }
@@ -1022,7 +1022,7 @@ static int tx_macro_dec_mode_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
-	int value = ucontrol->value.integer.value[0];
+	int value = ucontrol->value.enumerated.item[0];
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	int path = e->shift_l;
 	struct tx_macro *tx = snd_soc_component_get_drvdata(component);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 79422642ae00..1482aeebe745 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -665,30 +665,31 @@ static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
 
 	/*
 	 * .change_pte() must be surrounded by .invalidate_range_{start,end}().
-	 * If mmu_notifier_count is zero, then no in-progress invalidations,
-	 * including this one, found a relevant memslot at start(); rechecking
-	 * memslots here is unnecessary.  Note, a false positive (count elevated
-	 * by a different invalidation) is sub-optimal but functionally ok.
+	 * If mmu_invalidate_in_progress is zero, then no in-progress
+	 * invalidations, including this one, found a relevant memslot at
+	 * start(); rechecking memslots here is unnecessary.  Note, a false
+	 * positive (count elevated by a different invalidation) is sub-optimal
+	 * but functionally ok.
 	 */
 	WARN_ON_ONCE(!READ_ONCE(kvm->mn_active_invalidate_count));
-	if (!READ_ONCE(kvm->mmu_notifier_count))
+	if (!READ_ONCE(kvm->mmu_invalidate_in_progress))
 		return;
 
 	kvm_handle_hva_range(mn, address, address + 1, pte, kvm_change_spte_gfn);
 }
 
-void kvm_inc_notifier_count(struct kvm *kvm, unsigned long start,
-				   unsigned long end)
+void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
+			      unsigned long end)
 {
 	/*
 	 * The count increase must become visible at unlock time as no
 	 * spte can be established without taking the mmu_lock and
 	 * count is also read inside the mmu_lock critical section.
 	 */
-	kvm->mmu_notifier_count++;
-	if (likely(kvm->mmu_notifier_count == 1)) {
-		kvm->mmu_notifier_range_start = start;
-		kvm->mmu_notifier_range_end = end;
+	kvm->mmu_invalidate_in_progress++;
+	if (likely(kvm->mmu_invalidate_in_progress == 1)) {
+		kvm->mmu_invalidate_range_start = start;
+		kvm->mmu_invalidate_range_end = end;
 	} else {
 		/*
 		 * Fully tracking multiple concurrent ranges has dimishing
@@ -699,10 +700,10 @@ void kvm_inc_notifier_count(struct kvm *kvm, unsigned long start,
 		 * accumulate and persist until all outstanding invalidates
 		 * complete.
 		 */
-		kvm->mmu_notifier_range_start =
-			min(kvm->mmu_notifier_range_start, start);
-		kvm->mmu_notifier_range_end =
-			max(kvm->mmu_notifier_range_end, end);
+		kvm->mmu_invalidate_range_start =
+			min(kvm->mmu_invalidate_range_start, start);
+		kvm->mmu_invalidate_range_end =
+			max(kvm->mmu_invalidate_range_end, end);
 	}
 }
 
@@ -715,7 +716,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 		.end		= range->end,
 		.pte		= __pte(0),
 		.handler	= kvm_unmap_gfn_range,
-		.on_lock	= kvm_inc_notifier_count,
+		.on_lock	= kvm_mmu_invalidate_begin,
 		.on_unlock	= kvm_arch_guest_memory_reclaimed,
 		.flush_on_ret	= true,
 		.may_block	= mmu_notifier_range_blockable(range),
@@ -726,7 +727,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 	/*
 	 * Prevent memslot modification between range_start() and range_end()
 	 * so that conditionally locking provides the same result in both
-	 * functions.  Without that guarantee, the mmu_notifier_count
+	 * functions.  Without that guarantee, the mmu_invalidate_in_progress
 	 * adjustments will be imbalanced.
 	 *
 	 * Pairs with the decrement in range_end().
@@ -740,22 +741,22 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 	return 0;
 }
 
-void kvm_dec_notifier_count(struct kvm *kvm, unsigned long start,
-				   unsigned long end)
+void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned long start,
+			    unsigned long end)
 {
 	/*
 	 * This sequence increase will notify the kvm page fault that
 	 * the page that is going to be mapped in the spte could have
 	 * been freed.
 	 */
-	kvm->mmu_notifier_seq++;
+	kvm->mmu_invalidate_seq++;
 	smp_wmb();
 	/*
 	 * The above sequence increase must be visible before the
 	 * below count decrease, which is ensured by the smp_wmb above
-	 * in conjunction with the smp_rmb in mmu_notifier_retry().
+	 * in conjunction with the smp_rmb in mmu_invalidate_retry().
 	 */
-	kvm->mmu_notifier_count--;
+	kvm->mmu_invalidate_in_progress--;
 }
 
 static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
@@ -767,7 +768,7 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 		.end		= range->end,
 		.pte		= __pte(0),
 		.handler	= (void *)kvm_null_fn,
-		.on_lock	= kvm_dec_notifier_count,
+		.on_lock	= kvm_mmu_invalidate_end,
 		.on_unlock	= (void *)kvm_null_fn,
 		.flush_on_ret	= false,
 		.may_block	= mmu_notifier_range_blockable(range),
@@ -788,7 +789,7 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 	if (wake)
 		rcuwait_wake_up(&kvm->mn_memslots_update_rcuwait);
 
-	BUG_ON(kvm->mmu_notifier_count < 0);
+	BUG_ON(kvm->mmu_invalidate_in_progress < 0);
 }
 
 static int kvm_mmu_notifier_clear_flush_young(struct mmu_notifier *mn,
