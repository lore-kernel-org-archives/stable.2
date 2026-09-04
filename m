Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA38D51E43A
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 18:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546918; cv=none; b=XCPvfcE/dalOzCMDIvPkPByr2fdUVCp2mguXVSVc5J6jHbnDyPdD2uXShflEa9QqmWXWqvzBVHLi2aeV9Ax6fCvp6eklBTp+Mqs0klG6Cig3/r27AQ4wZHXlbIgaVxVbfXmb4BsfHJzvShkslwSAcHgFX7fDh2BaIeHeDuZ1E3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546918; c=relaxed/simple;
	bh=dIZTZ3/4m2tuKEifGIzXFVkHW8L60yWUFR42k59UDks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0HVqDwrOhOHzXzUTL35Oqa3W6zq2RD051YS8Kv5vEuMni2IWPyPJy372bjwzVBy9DwrzcBgdoo0zKZrF1v4nkQcrmlGmLHWBkAFkNxvyfOvet30vsJz5PzoUdgvcaaK5Wgss7BTt/3Fpi0WHL3FzArpjg12UwqgOrK4RRQk7UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9nJrEep; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9nJrEep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDF41F00A3D;
	Fri,  4 Sep 2026 18:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788546905;
	bh=2v1BGIsN7dWpZBx1jnQXnAXQpkrZYyGDDT6jJ3TcsLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N9nJrEepKEYX2jbIrRKvc3dUlafXZzWY+WtPodo1nZLkrQ/jrmy3Md9T7vQvsawwl
	 7/C9E5gXGkBBhF7QmuFb8b1Lw9fBpVu7uAkDOO78VhFWgQQgDN9CBm+fh4YsnPrqZ8
	 w+783t3geuqbWq9Lu6C5eTxO340JyF5IyyY4Ry5fWizVI/sT70c4Qp5ebMv4NWis5N
	 cilJjMlm03zg3urIbRXVJcV0WIzAWfCdZ+IFWJNuitZnaI1xaeM03zD3a6HXsiY3PM
	 vSM6TYPCcsAHuxcbVnnrSuuMhtw+K5kZEWFB1Rnb2FUR4lP/NGqmjeQyfYLHUDzYKA
	 2NQcoC0JIV/6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Oscar Salvador <osalvador@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peter Xu <peterx@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] mm: provide mm_struct and address to huge_ptep_get()
Date: Fri,  4 Sep 2026 14:35:01 -0400
Message-ID: <20260904183502.1323253-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090326-clutch-freeness-d94a@gregkh>
References: <2026090326-clutch-freeness-d94a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit e6c0c03245b14d6c205814aee67128257d0bea84 ]

On powerpc 8xx huge_ptep_get() will need to know whether the given ptep is
a PTE entry or a PMD entry.  This cannot be known with the PMD entry
itself because there is no easy way to know it from the content of the
entry.

So huge_ptep_get() will need to know either the size of the page or get
the pmd.

In order to be consistent with huge_ptep_get_and_clear(), give mm and
address to huge_ptep_get().

Link: https://lkml.kernel.org/r/cc00c70dd384298796a4e1b25d6c4eb306d3af85.1719928057.git.christophe.leroy@csgroup.eu
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

[ sashal: Reduced backport -- upstream e6c0c03245b14 touches 21 file(s), this
  backport carries 15. Not backported here:
  arch/arm64/include/asm/hugetlb.h
  arch/riscv/include/asm/hugetlb.h
  arch/riscv/mm/hugetlbpage.c
  fs/hugetlbfs/inode.c
  include/linux/swapops.h
  mm/damon/vaddr.c
  mm/migrate.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: e87df0d5d696 ("mm/page_vma_mapped: use huge_ptep_get() for hugetlb")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/include/asm/hugetlb-3level.h |  4 +--
 arch/arm64/mm/hugetlbpage.c           | 14 +++++----
 arch/s390/include/asm/hugetlb.h       |  4 +--
 arch/s390/mm/hugetlbpage.c            |  4 +--
 fs/proc/task_mmu.c                    |  4 +--
 fs/userfaultfd.c                      |  2 +-
 include/asm-generic/hugetlb.h         |  2 +-
 mm/gup.c                              |  2 +-
 mm/hmm.c                              |  2 +-
 mm/hugetlb.c                          | 43 ++++++++++++++-------------
 mm/memory-failure.c                   |  2 +-
 mm/mempolicy.c                        |  2 +-
 mm/mincore.c                          |  3 +-
 mm/page_vma_mapped.c                  | 13 ++++----
 mm/userfaultfd.c                      |  2 +-
 15 files changed, 55 insertions(+), 48 deletions(-)

diff --git a/arch/arm/include/asm/hugetlb-3level.h b/arch/arm/include/asm/hugetlb-3level.h
index a30be55057939..87d48e2d90ad9 100644
--- a/arch/arm/include/asm/hugetlb-3level.h
+++ b/arch/arm/include/asm/hugetlb-3level.h
@@ -13,12 +13,12 @@
 
 /*
  * If our huge pte is non-zero then mark the valid bit.
- * This allows pte_present(huge_ptep_get(ptep)) to return true for non-zero
+ * This allows pte_present(huge_ptep_get(mm,addr,ptep)) to return true for non-zero
  * ptes.
  * (The valid bit is automatically cleared by set_pte_at for PROT_NONE ptes).
  */
 #define __HAVE_ARCH_HUGE_PTEP_GET
-static inline pte_t huge_ptep_get(pte_t *ptep)
+static inline pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	pte_t retval = *ptep;
 	if (pte_val(retval))
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index a8158c9489666..c468b7d29b0e2 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -159,7 +159,7 @@ static pte_t get_clear_flush(struct mm_struct *mm,
 			     unsigned long pgsize,
 			     unsigned long ncontig)
 {
-	pte_t orig_pte = huge_ptep_get(ptep);
+	pte_t orig_pte = huge_ptep_get(mm, addr, ptep);
 	bool valid = pte_valid(orig_pte);
 	unsigned long i, saddr = addr;
 
@@ -371,7 +371,7 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 {
 	int ncontig;
 	size_t pgsize;
-	pte_t orig_pte = huge_ptep_get(ptep);
+	pte_t orig_pte = huge_ptep_get(mm, addr, ptep);
 
 	if (!pte_cont(orig_pte))
 		return ptep_get_and_clear(mm, addr, ptep);
@@ -390,15 +390,16 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
  * all the contiguous ptes we need to check whether or not there is a
  * discrepancy between dirty or young.
  */
-static int __cont_access_flags_changed(pte_t *ptep, pte_t pte, int ncontig)
+static int __cont_access_flags_changed(struct mm_struct *mm,
+		unsigned long addr, pte_t *ptep, pte_t pte, int ncontig)
 {
 	int i;
 
-	if (pte_write(pte) != pte_write(huge_ptep_get(ptep)))
+	if (pte_write(pte) != pte_write(huge_ptep_get(mm, addr, ptep)))
 		return 1;
 
 	for (i = 0; i < ncontig; i++) {
-		pte_t orig_pte = huge_ptep_get(ptep + i);
+		pte_t orig_pte = huge_ptep_get(mm, addr, ptep + i);
 
 		if (pte_dirty(pte) != pte_dirty(orig_pte))
 			return 1;
@@ -426,7 +427,8 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	ncontig = find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
 	dpfn = pgsize >> PAGE_SHIFT;
 
-	if (!__cont_access_flags_changed(ptep, pte, ncontig))
+	if (!__cont_access_flags_changed(vma->vm_mm, addr, ptep, pte,
+					 ncontig))
 		return 0;
 
 	orig_pte = get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index d3642fb634bd9..ff0c51a633ef1 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -17,7 +17,7 @@
 
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t pte);
-pte_t huge_ptep_get(pte_t *ptep);
+pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 			      unsigned long addr, pte_t *ptep);
 
@@ -62,7 +62,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 					     unsigned long addr, pte_t *ptep,
 					     pte_t pte, int dirty)
 {
-	int changed = !pte_same(huge_ptep_get(ptep), pte);
+	int changed = !pte_same(huge_ptep_get(vma->vm_mm, addr, ptep), pte);
 	if (changed) {
 		huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
 		set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index 8631307d3defc..386e50952f5e9 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -170,7 +170,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	pte_val(*ptep) = rste;
 }
 
-pte_t huge_ptep_get(pte_t *ptep)
+pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	return __rste_to_pte(pte_val(*ptep));
 }
@@ -178,7 +178,7 @@ pte_t huge_ptep_get(pte_t *ptep)
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 			      unsigned long addr, pte_t *ptep)
 {
-	pte_t pte = huge_ptep_get(ptep);
+	pte_t pte = huge_ptep_get(mm, addr, ptep);
 	pmd_t *pmdp = (pmd_t *) ptep;
 	pud_t *pudp = (pud_t *) ptep;
 
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index b255e3dfded14..e9c2cf0094aeb 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1532,7 +1532,7 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 	if (vma->vm_flags & VM_SOFTDIRTY)
 		flags |= PM_SOFT_DIRTY;
 
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(walk->mm, addr, ptep);
 	if (pte_present(pte)) {
 		struct page *page = pte_page(pte);
 
@@ -1851,7 +1851,7 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 static int gather_hugetlb_stats(pte_t *pte, unsigned long hmask,
 		unsigned long addr, unsigned long end, struct mm_walk *walk)
 {
-	pte_t huge_pte = huge_ptep_get(pte);
+	pte_t huge_pte = huge_ptep_get(walk->mm, addr, pte);
 	struct numa_maps *md;
 	struct page *page;
 
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 271ce399f6b6f..9df8808cdc004 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -241,7 +241,7 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 		goto out;
 
 	ret = false;
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(vma->vm_mm, address, ptep);
 
 	/*
 	 * Lockless access: we're in a wait_event so it's ok if it
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 8e1e6244a89da..158c03631a9a1 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -120,7 +120,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 #endif
 
 #ifndef __HAVE_ARCH_HUGE_PTEP_GET
-static inline pte_t huge_ptep_get(pte_t *ptep)
+static inline pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	return ptep_get(ptep);
 }
diff --git a/mm/gup.c b/mm/gup.c
index 118c474471850..362c9e1c26c6e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2516,7 +2516,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 	if (pte_end < end)
 		end = pte_end;
 
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(current->mm, addr, ptep);
 
 	if (!pte_access_permitted(pte, flags & FOLL_WRITE))
 		return 0;
diff --git a/mm/hmm.c b/mm/hmm.c
index 2a44bab2c9d17..e033c2bc850f2 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -485,7 +485,7 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	pte_t entry;
 
 	ptl = huge_pte_lock(hstate_vma(vma), walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	entry = huge_ptep_get(walk->mm, addr, pte);
 
 	i = (start - range->start) >> PAGE_SHIFT;
 	pfn_req_flags = range->hmm_pfns[i];
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e0908e491065d..13a7ca474b20c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4258,7 +4258,8 @@ static void set_huge_ptep_writable(struct vm_area_struct *vma,
 {
 	pte_t entry;
 
-	entry = huge_pte_mkwrite(huge_pte_mkdirty(huge_ptep_get(ptep)));
+	entry = huge_pte_mkwrite(huge_pte_mkdirty(
+				huge_ptep_get(vma->vm_mm, address, ptep)));
 	if (huge_ptep_set_access_flags(vma, address, ptep, entry, 1))
 		update_mmu_cache(vma, address, ptep);
 }
@@ -4350,7 +4351,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		dst_ptl = huge_pte_lock(h, dst, dst_pte);
 		src_ptl = huge_pte_lockptr(h, src, src_pte);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
-		entry = huge_ptep_get(src_pte);
+		entry = huge_ptep_get(src, addr, src_pte);
 again:
 		if (huge_pte_none(entry)) {
 			/*
@@ -4374,7 +4375,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			}
 			set_huge_swap_pte_at(dst, addr, dst_pte, entry, sz);
 		} else {
-			entry = huge_ptep_get(src_pte);
+			entry = huge_ptep_get(src, addr, src_pte);
 			ptepage = pte_page(entry);
 			get_page(ptepage);
 
@@ -4408,7 +4409,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				dst_ptl = huge_pte_lock(h, dst, dst_pte);
 				src_ptl = huge_pte_lockptr(h, src, src_pte);
 				spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
-				entry = huge_ptep_get(src_pte);
+				entry = huge_ptep_get(src, addr, src_pte);
 				if (!pte_same(src_pte_old, entry)) {
 					restore_reserve_on_error(h, vma, addr,
 								new);
@@ -4494,7 +4495,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			continue;
 		}
 
-		pte = huge_ptep_get(ptep);
+		pte = huge_ptep_get(mm, address, ptep);
 		if (huge_pte_none(pte)) {
 			spin_unlock(ptl);
 			continue;
@@ -4654,7 +4655,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 	unsigned long haddr = address & huge_page_mask(h);
 	struct mmu_notifier_range range;
 
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(mm, haddr, ptep);
 	old_page = pte_page(pte);
 
 retry_avoidcopy:
@@ -4724,7 +4725,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 			spin_lock(ptl);
 			ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 			if (likely(ptep &&
-				   pte_same(huge_ptep_get(ptep), pte)))
+				   pte_same(huge_ptep_get(mm, haddr, ptep), pte)))
 				goto retry_avoidcopy;
 			/*
 			 * race occurs while re-acquiring page table
@@ -4760,7 +4761,8 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 	 */
 	spin_lock(ptl);
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
-	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
+	if (likely(ptep &&
+		   pte_same(huge_ptep_get(mm, haddr, ptep), pte))) {
 		ClearHPageRestoreReserve(new_page);
 
 		/* Break COW */
@@ -4939,7 +4941,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 */
 			ptl = huge_pte_lock(h, mm, ptep);
 			ret = 0;
-			if (huge_pte_none(huge_ptep_get(ptep)))
+			if (huge_pte_none(huge_ptep_get(mm, haddr, ptep)))
 				ret = vmf_error(PTR_ERR(page));
 			spin_unlock(ptl);
 			goto out;
@@ -5004,7 +5006,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 
 	ptl = huge_pte_lock(h, mm, ptep);
 	ret = 0;
-	if (!huge_pte_none(huge_ptep_get(ptep)))
+	if (!huge_pte_none(huge_ptep_get(mm, haddr, ptep)))
 		goto backout;
 
 	if (anon_rmap) {
@@ -5095,7 +5097,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * OK as we are only making decisions based on content and
 		 * not actually modifying content here.
 		 */
-		entry = huge_ptep_get(ptep);
+		entry = huge_ptep_get(mm, haddr, ptep);
 		if (unlikely(is_hugetlb_entry_migration(entry))) {
 			migration_entry_wait_huge(vma, mm, ptep);
 			return 0;
@@ -5132,7 +5134,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	hash = hugetlb_fault_mutex_hash(mapping, idx);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
-	entry = huge_ptep_get(ptep);
+	entry = huge_ptep_get(mm, haddr, ptep);
 	if (huge_pte_none(entry))
 		/*
 		 * hugetlb_no_page will drop vma lock and hugetlb fault
@@ -5176,7 +5178,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	ptl = huge_pte_lock(h, mm, ptep);
 
 	/* Check for a racing update before calling hugetlb_cow */
-	if (unlikely(!pte_same(entry, huge_ptep_get(ptep))))
+	if (unlikely(!pte_same(entry, huge_ptep_get(mm, haddr, ptep))))
 		goto out_ptl;
 
 	/*
@@ -5376,7 +5378,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release_unlock;
 
 	ret = -EEXIST;
-	if (!huge_pte_none(huge_ptep_get(dst_pte)))
+	if (!huge_pte_none(huge_ptep_get(dst_mm, dst_addr, dst_pte)))
 		goto out_release_unlock;
 
 	if (page_in_pagecache) {
@@ -5477,7 +5479,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 				      huge_page_size(h));
 		if (pte)
 			ptl = huge_pte_lock(h, mm, pte);
-		absent = !pte || huge_pte_none(huge_ptep_get(pte));
+		absent = !pte ||
+			huge_pte_none(huge_ptep_get(mm, vaddr, pte));
 
 		/*
 		 * When coredumping, it suits get_dump_page if we just return
@@ -5504,9 +5507,9 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * both cases, and because we can't follow correct pages
 		 * directly from any kind of swap entries.
 		 */
-		if (absent || is_swap_pte(huge_ptep_get(pte)) ||
+		if (absent || is_swap_pte(huge_ptep_get(mm, vaddr, pte)) ||
 		    ((flags & FOLL_WRITE) &&
-		      !huge_pte_write(huge_ptep_get(pte)))) {
+		      !huge_pte_write(huge_ptep_get(mm, vaddr, pte)))) {
 			vm_fault_t ret;
 			unsigned int fault_flags = 0;
 
@@ -5553,7 +5556,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		}
 
 		pfn_offset = (vaddr & ~huge_page_mask(h)) >> PAGE_SHIFT;
-		page = pte_page(huge_ptep_get(pte));
+		page = pte_page(huge_ptep_get(mm, vaddr, pte));
 
 		/*
 		 * If subpage information not requested, update counters
@@ -5655,7 +5658,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 			spin_unlock(ptl);
 			continue;
 		}
-		pte = huge_ptep_get(ptep);
+		pte = huge_ptep_get(mm, address, ptep);
 		if (unlikely(is_hugetlb_entry_hwpoisoned(pte))) {
 			spin_unlock(ptl);
 			continue;
@@ -6243,7 +6246,7 @@ follow_huge_pmd_pte(struct vm_area_struct *vma, unsigned long address, int flags
 		return NULL;
 
 	ptl = huge_pte_lock(h, mm, ptep);
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(mm, address, ptep);
 	if (pte_present(pte)) {
 		page = pte_page(pte) +
 			((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 66390688a62c0..17362b5db7d94 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -664,7 +664,7 @@ static int hwpoison_hugetlb_range(pte_t *ptep, unsigned long hmask,
 			    struct mm_walk *walk)
 {
 	struct hwp_walk *hwp = (struct hwp_walk *)walk->private;
-	pte_t pte = huge_ptep_get(ptep);
+	pte_t pte = huge_ptep_get(walk->mm, addr, ptep);
 	struct hstate *h = hstate_vma(walk->vma);
 
 	return check_hwpoisoned_entry(pte, addr, huge_page_shift(h),
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f089de8564cad..fd75021cc1943 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -574,7 +574,7 @@ static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
 	pte_t entry;
 
 	ptl = huge_pte_lock(hstate_vma(walk->vma), walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	entry = huge_ptep_get(walk->mm, addr, pte);
 	if (!pte_present(entry))
 		goto unlock;
 	page = pte_page(entry);
diff --git a/mm/mincore.c b/mm/mincore.c
index 889d84477a770..00d29997f0e16 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -32,7 +32,8 @@ static int mincore_hugetlb(pte_t *pte, unsigned long hmask, unsigned long addr,
 	 * Hugepages under user process are always in RAM and never
 	 * swapped out, but theoretically it needs to be checked.
 	 */
-	present = pte && !huge_pte_none(huge_ptep_get(pte));
+	present = pte &&
+		!huge_pte_none(huge_ptep_get(walk->mm, addr, pte));
 	for (; addr != end; vec++, addr += PAGE_SIZE)
 		*vec = present;
 	walk->private = vec;
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index f7b3310817910..3f003623eef45 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -87,33 +87,34 @@ static inline bool pfn_is_match(struct page *page, unsigned long pfn)
 static bool check_pte(struct page_vma_mapped_walk *pvmw)
 {
 	unsigned long pfn;
+	pte_t ptent = ptep_get(pvmw->pte);
 
 	if (pvmw->flags & PVMW_MIGRATION) {
 		swp_entry_t entry;
-		if (!is_swap_pte(*pvmw->pte))
+		if (!is_swap_pte(ptent))
 			return false;
-		entry = pte_to_swp_entry(*pvmw->pte);
+		entry = pte_to_swp_entry(ptent);
 
 		if (!is_migration_entry(entry) &&
 		    !is_device_exclusive_entry(entry))
 			return false;
 
 		pfn = swp_offset(entry);
-	} else if (is_swap_pte(*pvmw->pte)) {
+	} else if (is_swap_pte(ptent)) {
 		swp_entry_t entry;
 
 		/* Handle un-addressable ZONE_DEVICE memory */
-		entry = pte_to_swp_entry(*pvmw->pte);
+		entry = pte_to_swp_entry(ptent);
 		if (!is_device_private_entry(entry) &&
 		    !is_device_exclusive_entry(entry))
 			return false;
 
 		pfn = swp_offset(entry);
 	} else {
-		if (!pte_present(*pvmw->pte))
+		if (!pte_present(ptent))
 			return false;
 
-		pfn = pte_pfn(*pvmw->pte);
+		pfn = pte_pfn(ptent);
 	}
 
 	return pfn_is_match(pvmw->page, pfn);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 98a9d0ef2d917..812d6f50350ea 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -378,7 +378,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		}
 
 		if (mode != MCOPY_ATOMIC_CONTINUE &&
-		    !huge_pte_none(huge_ptep_get(dst_pte))) {
+		    !huge_pte_none(huge_ptep_get(dst_mm, dst_addr, dst_pte))) {
 			err = -EEXIST;
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			i_mmap_unlock_read(mapping);
-- 
2.53.0

