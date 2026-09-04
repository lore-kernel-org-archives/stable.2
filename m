Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129B64F475C
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535669; cv=none; b=eIJyXKhRSa5mtlzWoogLMrXkGvh83jpyZs/kKJ8rtAM5vLj6oYMZ82R4TdRrq2voRvNqSs0LFYhJzf2urlbvblEufRO9q1re6e0a+D5xPTA3FVTvpQ6COIzcrXYKKwagIfN1xBOl6fWHHTfFMmX7WRAHS2VYALRkjfiHGvpYzsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535669; c=relaxed/simple;
	bh=9oJP72JNKZsmF6E12B0rtxAb9n31jIeJszAgRP6guZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuGdEgfRfZLyO1lf0u4rANPTUrda1vOVh5RBNn4K9llxkdMV+t6V3xVgoN/8QjYVUl2gyZ3aHCerYRGR1syEvREqTXKDVUde8fiyyh5Wipyn8tAtELRoPnvhTRu31t2m2aWyxEcGw6ybU6E0+9djTegpuWbIc7jfN9U9rV8Jtbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqXyDSsq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqXyDSsq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42FB1F00AC4;
	Fri,  4 Sep 2026 15:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788535666;
	bh=XOFYaOtUnTIm0B8e+4exGAIXTgVPB4uR5GC+/20OHSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OqXyDSsqRjwlsDrdrGKz4PWKykBd8t90mqlv9KVBibwSnHBy8w8SG0dVpXLBcToYN
	 k/sztTMLnV7qS4nKeiz3d9eGHkhdQiYNGKTPue15zIRzKDCtLCh+cDT0wtYi7Z/YJN
	 7y/RfGnc0ptnr7fpgarMOLl+85UCvRyMtPYa9Etcobbxz7HMHBvJErjbCKXXRli5OU
	 Uxiz6q9ZtKrkxPiRqWs4ro9H89ilEMxNuv3huwMgBn8kWJEIuUm0ueHI5iMuuHNZJE
	 1jyhmclNp3QW0AKV36Qg3iVqRfiqSFs1qmVDn3KJf6v/TQj7ustri21Ze4+wCYOgD9
	 Koy6As0/2hydw==
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
Subject: [PATCH 6.1.y 4/5] mm: provide mm_struct and address to huge_ptep_get()
Date: Fri,  4 Sep 2026 11:27:40 -0400
Message-ID: <20260904152741.898549-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904152741.898549-1-sashal@kernel.org>
References: <2026090326-freestyle-gratify-7686@gregkh>
 <20260904152741.898549-1-sashal@kernel.org>
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
  backport carries 19. Not backported here:
  arch/riscv/include/asm/hugetlb.h
  arch/riscv/mm/hugetlbpage.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: e87df0d5d696 ("mm/page_vma_mapped: use huge_ptep_get() for hugetlb")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/include/asm/hugetlb-3level.h |  4 +-
 arch/arm64/include/asm/hugetlb.h      |  2 +-
 arch/arm64/mm/hugetlbpage.c           |  2 +-
 arch/s390/include/asm/hugetlb.h       |  4 +-
 arch/s390/mm/hugetlbpage.c            |  4 +-
 fs/hugetlbfs/inode.c                  |  2 +-
 fs/proc/task_mmu.c                    |  6 +--
 fs/userfaultfd.c                      |  2 +-
 include/asm-generic/hugetlb.h         |  2 +-
 include/linux/swapops.h               | 12 +++--
 mm/damon/vaddr.c                      |  6 +--
 mm/gup.c                              |  2 +-
 mm/hmm.c                              |  2 +-
 mm/hugetlb.c                          | 75 ++++++++++++++++-----------
 mm/memory-failure.c                   |  2 +-
 mm/mempolicy.c                        |  2 +-
 mm/migrate.c                          | 10 ++--
 mm/mincore.c                          |  2 +-
 mm/userfaultfd.c                      |  3 +-
 19 files changed, 82 insertions(+), 62 deletions(-)

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
diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index d20f5da2d76fa..f61d45d3e6314 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -45,7 +45,7 @@ extern pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 			   pte_t *ptep, unsigned long sz);
 #define __HAVE_ARCH_HUGE_PTEP_GET
-extern pte_t huge_ptep_get(pte_t *ptep);
+extern pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 
 void __init arm64_hugetlb_cma_reserve(void);
 
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 79f0d2a776885..b3871b1446d33 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -148,7 +148,7 @@ static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
 	return contig_ptes;
 }
 
-pte_t huge_ptep_get(pte_t *ptep)
+pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	int ncontig, i;
 	size_t pgsize;
diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index ccdbccfde148c..b8f5c42c8ed0e 100644
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
index 33ef6790114ab..1a46530d3bf0a 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -163,7 +163,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	set_pte(ptep, __pte(rste));
 }
 
-pte_t huge_ptep_get(pte_t *ptep)
+pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	return __rste_to_pte(pte_val(*ptep));
 }
@@ -171,7 +171,7 @@ pte_t huge_ptep_get(pte_t *ptep)
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 			      unsigned long addr, pte_t *ptep)
 {
-	pte_t pte = huge_ptep_get(ptep);
+	pte_t pte = huge_ptep_get(mm, addr, ptep);
 	pmd_t *pmdp = (pmd_t *) ptep;
 	pud_t *pudp = (pud_t *) ptep;
 
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 7f521311e3f09..9262cd2cc47ee 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -405,7 +405,7 @@ static bool hugetlb_vma_maps_page(struct vm_area_struct *vma,
 	if (!ptep)
 		return false;
 
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(vma->vm_mm, addr, ptep);
 	if (huge_pte_none(pte) || !pte_present(pte))
 		return false;
 
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 39ce3cf7d5add..72226fa3744f2 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -726,7 +726,7 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 {
 	struct mem_size_stats *mss = walk->private;
 	struct vm_area_struct *vma = walk->vma;
-	pte_t ptent = huge_ptep_get(pte);
+	pte_t ptent = huge_ptep_get(walk->mm, addr, pte);
 	struct folio *folio = NULL;
 
 	if (pte_present(ptent)) {
@@ -1576,7 +1576,7 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 	if (vma->vm_flags & VM_SOFTDIRTY)
 		flags |= PM_SOFT_DIRTY;
 
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(walk->mm, addr, ptep);
 	if (pte_present(pte)) {
 		struct page *page = pte_page(pte);
 
@@ -1900,7 +1900,7 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 static int gather_hugetlb_stats(pte_t *pte, unsigned long hmask,
 		unsigned long addr, unsigned long end, struct mm_walk *walk)
 {
-	pte_t huge_pte = huge_ptep_get(pte);
+	pte_t huge_pte = huge_ptep_get(walk->mm, addr, pte);
 	struct numa_maps *md;
 	struct page *page;
 
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 6ebee2b3a5a83..673d96c081c80 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -264,7 +264,7 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 		goto out;
 
 	ret = false;
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(vma->vm_mm, address, ptep);
 
 	/*
 	 * Lockless access: we're in a wait_event so it's ok if it
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index a57d667addd2e..8499b3732b7bc 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -144,7 +144,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 #endif
 
 #ifndef __HAVE_ARCH_HUGE_PTEP_GET
-static inline pte_t huge_ptep_get(pte_t *ptep)
+static inline pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	return ptep_get(ptep);
 }
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 7de89a03b72e7..68e47fa4e63c3 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -347,8 +347,10 @@ extern void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					unsigned long address);
 #ifdef CONFIG_HUGETLB_PAGE
-extern void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl);
-extern void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte);
+extern void __migration_entry_wait_huge(struct mm_struct *mm,
+		unsigned long address, pte_t *ptep, spinlock_t *ptl);
+extern void migration_entry_wait_huge(struct vm_area_struct *vma,
+		unsigned long address, pte_t *pte);
 #endif	/* CONFIG_HUGETLB_PAGE */
 #else  /* CONFIG_MIGRATION */
 static inline swp_entry_t make_readable_migration_entry(pgoff_t offset)
@@ -376,8 +378,10 @@ static inline void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					 unsigned long address) { }
 #ifdef CONFIG_HUGETLB_PAGE
-static inline void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl) { }
-static inline void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte) { }
+static inline void __migration_entry_wait_huge(struct mm_struct *mm,
+		unsigned long address, pte_t *ptep, spinlock_t *ptl) { }
+static inline void migration_entry_wait_huge(struct vm_area_struct *vma,
+		unsigned long address, pte_t *pte) { }
 #endif	/* CONFIG_HUGETLB_PAGE */
 static inline int is_writable_migration_entry(swp_entry_t entry)
 {
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 708f281c1b6b4..55dfddf1b01f5 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -336,7 +336,7 @@ static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
 				struct vm_area_struct *vma, unsigned long addr)
 {
 	bool referenced = false;
-	pte_t entry = huge_ptep_get(pte);
+	pte_t entry = huge_ptep_get(mm, addr, pte);
 	struct page *page = pte_page(entry);
 
 	get_page(page);
@@ -369,7 +369,7 @@ static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	pte_t entry;
 
 	ptl = huge_pte_lock(h, walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	entry = huge_ptep_get(walk->mm, addr, pte);
 	if (!pte_present(entry))
 		goto out;
 
@@ -497,7 +497,7 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	pte_t entry;
 
 	ptl = huge_pte_lock(h, walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	entry = huge_ptep_get(walk->mm, addr, pte);
 	if (!pte_present(entry))
 		goto out;
 
diff --git a/mm/gup.c b/mm/gup.c
index 72e01b8311d7c..7f74f1223e8b9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2662,7 +2662,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 	if (pte_end < end)
 		end = pte_end;
 
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(current->mm, addr, ptep);
 
 	if (!pte_access_permitted(pte, flags & FOLL_WRITE))
 		return 0;
diff --git a/mm/hmm.c b/mm/hmm.c
index 2cb3626fd1034..9737bd676179b 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -484,7 +484,7 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	pte_t entry;
 
 	ptl = huge_pte_lock(hstate_vma(vma), walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	entry = huge_ptep_get(walk->mm, addr, pte);
 
 	i = (start - range->start) >> PAGE_SHIFT;
 	pfn_req_flags = range->hmm_pfns[i];
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cd93d3b0a433d..586b8abdd90b6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4998,7 +4998,8 @@ static void set_huge_ptep_writable(struct vm_area_struct *vma,
 {
 	pte_t entry;
 
-	entry = huge_pte_mkwrite(huge_pte_mkdirty(huge_ptep_get(ptep)));
+	entry = huge_pte_mkwrite(huge_pte_mkdirty(
+				huge_ptep_get(vma->vm_mm, address, ptep)));
 	if (huge_ptep_set_access_flags(vma, address, ptep, entry, 1))
 		update_mmu_cache(vma, address, ptep);
 }
@@ -5098,7 +5099,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		dst_ptl = huge_pte_lock(h, dst, dst_pte);
 		src_ptl = huge_pte_lockptr(h, src, src_pte);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
-		entry = huge_ptep_get(src_pte);
+		entry = huge_ptep_get(src, addr, src_pte);
 again:
 		if (huge_pte_none(entry)) {
 			/*
@@ -5140,7 +5141,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			if (userfaultfd_wp(dst_vma))
 				set_huge_pte_at(dst, addr, dst_pte, entry);
 		} else {
-			entry = huge_ptep_get(src_pte);
+			entry = huge_ptep_get(src, addr, src_pte);
 			ptepage = pte_page(entry);
 			get_page(ptepage);
 
@@ -5178,7 +5179,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				dst_ptl = huge_pte_lock(h, dst, dst_pte);
 				src_ptl = huge_pte_lockptr(h, src, src_pte);
 				spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
-				entry = huge_ptep_get(src_pte);
+				entry = huge_ptep_get(src, addr, src_pte);
 				if (!pte_same(src_pte_old, entry)) {
 					restore_reserve_on_error(h, dst_vma, addr,
 								new);
@@ -5284,7 +5285,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 			new_addr |= last_addr_mask;
 			continue;
 		}
-		if (huge_pte_none(huge_ptep_get(src_pte)))
+		if (huge_pte_none(huge_ptep_get(mm, old_addr, src_pte)))
 			continue;
 
 		if (huge_pmd_unshare(&tlb, vma, old_addr, src_pte)) {
@@ -5361,7 +5362,7 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 			continue;
 		}
 
-		pte = huge_ptep_get(ptep);
+		pte = huge_ptep_get(mm, address, ptep);
 		if (huge_pte_none(pte)) {
 			spin_unlock(ptl);
 			continue;
@@ -5544,7 +5545,7 @@ static vm_fault_t hugetlb_wp(struct page *pagecache_page,
 	struct vm_area_struct *vma = vmf->vma;
 	struct mm_struct *mm = vma->vm_mm;
 	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
-	pte_t pte = huge_ptep_get(vmf->pte);
+	pte_t pte = huge_ptep_get(mm, vmf->address, vmf->pte);
 	struct hstate *h = hstate_vma(vma);
 	struct page *old_page, *new_page;
 	int outside_reserve = 0;
@@ -5659,7 +5660,8 @@ static vm_fault_t hugetlb_wp(struct page *pagecache_page,
 			vmf->pte = huge_pte_offset(mm, vmf->address,
 						    huge_page_size(h));
 			if (likely(vmf->pte &&
-				   pte_same(huge_ptep_get(vmf->pte), pte)))
+				   pte_same(huge_ptep_get(mm, vmf->address,
+						       vmf->pte), pte)))
 				goto retry_avoidcopy;
 			/*
 			 * race occurs while re-acquiring page table
@@ -5697,7 +5699,8 @@ static vm_fault_t hugetlb_wp(struct page *pagecache_page,
 	 */
 	spin_lock(vmf->ptl);
 	vmf->pte = huge_pte_offset(mm, vmf->address, huge_page_size(h));
-	if (likely(vmf->pte && pte_same(huge_ptep_get(vmf->pte), pte))) {
+	if (likely(vmf->pte &&
+		   pte_same(huge_ptep_get(mm, vmf->address, vmf->pte), pte))) {
 		ClearHPageRestoreReserve(new_page);
 
 		/* Break COW or unshare */
@@ -5819,13 +5822,14 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
  * false if pte changed or is changing.
  */
 static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm,
-			       pte_t *ptep, pte_t old_pte)
+			       unsigned long address, pte_t *ptep,
+			       pte_t old_pte)
 {
 	spinlock_t *ptl;
 	bool same;
 
 	ptl = huge_pte_lock(h, mm, ptep);
-	same = pte_same(huge_ptep_get(ptep), old_pte);
+	same = pte_same(huge_ptep_get(mm, address, ptep), old_pte);
 	spin_unlock(ptl);
 
 	return same;
@@ -5886,7 +5890,8 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 			 * never happen on the page after UFFDIO_COPY has
 			 * correctly installed the page and returned.
 			 */
-			if (!hugetlb_pte_stable(h, mm, vmf->pte, vmf->orig_pte)) {
+			if (!hugetlb_pte_stable(h, mm, vmf->address, vmf->pte,
+						vmf->orig_pte)) {
 				ret = 0;
 				goto out;
 			}
@@ -5911,7 +5916,8 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 			 * here.  Before returning error, get ptl and make
 			 * sure there really is no pte entry.
 			 */
-			if (hugetlb_pte_stable(h, mm, vmf->pte, vmf->orig_pte))
+			if (hugetlb_pte_stable(h, mm, vmf->address, vmf->pte,
+					       vmf->orig_pte))
 				ret = vmf_error(PTR_ERR(page));
 			else
 				ret = 0;
@@ -5963,7 +5969,8 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 			unlock_page(page);
 			put_page(page);
 			/* See comment in userfaultfd_missing() block above */
-			if (!hugetlb_pte_stable(h, mm, vmf->pte, vmf->orig_pte)) {
+			if (!hugetlb_pte_stable(h, mm, vmf->address, vmf->pte,
+						vmf->orig_pte)) {
 				ret = 0;
 				goto out;
 			}
@@ -5992,7 +5999,8 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	vmf->ptl = huge_pte_lock(h, mm, vmf->pte);
 	ret = 0;
 	/* If pte changed from under us, retry */
-	if (!pte_same(huge_ptep_get(vmf->pte), vmf->orig_pte))
+	if (!pte_same(huge_ptep_get(mm, vmf->address, vmf->pte),
+		      vmf->orig_pte))
 		goto backout;
 
 	if (anon_rmap) {
@@ -6093,9 +6101,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * OK as we are only making decisions based on content and
 		 * not actually modifying content here.
 		 */
-		vmf.orig_pte = huge_ptep_get(vmf.pte);
+		vmf.orig_pte = huge_ptep_get(mm, vmf.address, vmf.pte);
 		if (unlikely(is_hugetlb_entry_migration(vmf.orig_pte))) {
-			migration_entry_wait_huge(vma, vmf.pte);
+			migration_entry_wait_huge(vma, vmf.address, vmf.pte);
 			return 0;
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(vmf.orig_pte)))
 			return VM_FAULT_HWPOISON_LARGE |
@@ -6128,7 +6136,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		return VM_FAULT_OOM;
 	}
 
-	vmf.orig_pte = huge_ptep_get(vmf.pte);
+	vmf.orig_pte = huge_ptep_get(mm, vmf.address, vmf.pte);
 	/* PTE markers should be handled the same way as none pte */
 	if (huge_pte_none_mostly(vmf.orig_pte))
 		/*
@@ -6172,11 +6180,13 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	vmf.ptl = huge_pte_lock(h, mm, vmf.pte);
 
 	/* Check for a racing update before calling hugetlb_wp() */
-	if (unlikely(!pte_same(vmf.orig_pte, huge_ptep_get(vmf.pte))))
+	if (unlikely(!pte_same(vmf.orig_pte,
+			       huge_ptep_get(mm, vmf.address, vmf.pte))))
 		goto out_ptl;
 
 	/* Handle userfault-wp first, before trying to lock more pages */
-	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(vmf.pte)) &&
+	if (userfaultfd_wp(vma) &&
+	    huge_pte_uffd_wp(huge_ptep_get(mm, vmf.address, vmf.pte)) &&
 	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(vmf.orig_pte)) {
 		spin_unlock(vmf.ptl);
 		if (pagecache_page) {
@@ -6377,7 +6387,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	 * page backing it, then access the page.
 	 */
 	ret = -EEXIST;
-	if (!huge_pte_none_mostly(huge_ptep_get(dst_pte)))
+	if (!huge_pte_none_mostly(huge_ptep_get(dst_mm, dst_addr, dst_pte)))
 		goto out_release_unlock;
 
 	if (page_in_pagecache) {
@@ -6450,10 +6460,11 @@ static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
 	}
 }
 
-static inline bool __follow_hugetlb_must_fault(unsigned int flags, pte_t *pte,
-					       bool *unshare)
+static inline bool __follow_hugetlb_must_fault(struct mm_struct *mm,
+		unsigned long address, unsigned int flags, pte_t *pte,
+		bool *unshare)
 {
-	pte_t pteval = huge_ptep_get(pte);
+	pte_t pteval = huge_ptep_get(mm, address, pte);
 
 	*unshare = false;
 	if (is_swap_pte(pteval))
@@ -6507,7 +6518,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 				      huge_page_size(h));
 		if (pte)
 			ptl = huge_pte_lock(h, mm, pte);
-		absent = !pte || huge_pte_none(huge_ptep_get(pte));
+		absent = !pte ||
+			huge_pte_none(huge_ptep_get(mm, vaddr, pte));
 
 		/*
 		 * When coredumping, it suits get_dump_page if we just return
@@ -6535,7 +6547,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * directly from any kind of swap entries.
 		 */
 		if (absent ||
-		    __follow_hugetlb_must_fault(flags, pte, &unshare)) {
+		    __follow_hugetlb_must_fault(mm, vaddr, flags, pte,
+						&unshare)) {
 			vm_fault_t ret;
 			unsigned int fault_flags = 0;
 
@@ -6584,7 +6597,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		}
 
 		pfn_offset = (vaddr & ~huge_page_mask(h)) >> PAGE_SHIFT;
-		page = pte_page(huge_ptep_get(pte));
+		page = pte_page(huge_ptep_get(mm, vaddr, pte));
 
 		VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
 			       !PageAnonExclusive(page), page);
@@ -6712,7 +6725,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 			address |= last_addr_mask;
 			continue;
 		}
-		pte = huge_ptep_get(ptep);
+		pte = huge_ptep_get(mm, address, ptep);
 		if (unlikely(is_hugetlb_entry_hwpoisoned(pte))) {
 			/* Nothing to do. */
 		} else if (unlikely(is_hugetlb_entry_migration(pte))) {
@@ -7366,7 +7379,7 @@ follow_huge_pmd_pte(struct vm_area_struct *vma, unsigned long address, int flags
 		return NULL;
 
 	ptl = huge_pte_lock(h, mm, ptep);
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(mm, address, ptep);
 	if (pte_present(pte)) {
 		page = pte_page(pte) +
 			((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
@@ -7385,7 +7398,7 @@ follow_huge_pmd_pte(struct vm_area_struct *vma, unsigned long address, int flags
 	} else {
 		if (is_hugetlb_entry_migration(pte)) {
 			spin_unlock(ptl);
-			__migration_entry_wait_huge(ptep, ptl);
+			__migration_entry_wait_huge(mm, address, ptep, ptl);
 			goto retry;
 		}
 		/*
@@ -7413,7 +7426,7 @@ follow_huge_pud(struct mm_struct *mm, unsigned long address,
 	ptl = huge_pte_lock(hstate_sizelog(PUD_SHIFT), mm, (pte_t *)pud);
 	if (!pud_huge(*pud))
 		goto out;
-	pte = huge_ptep_get((pte_t *)pud);
+	pte = huge_ptep_get(mm, address, (pte_t *)pud);
 	if (pte_present(pte)) {
 		page = pud_page(*pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
 		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 776a37ae4eb69..5314c8e52f703 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -721,7 +721,7 @@ static int hwpoison_hugetlb_range(pte_t *ptep, unsigned long hmask,
 			    struct mm_walk *walk)
 {
 	struct hwp_walk *hwp = walk->private;
-	pte_t pte = huge_ptep_get(ptep);
+	pte_t pte = huge_ptep_get(walk->mm, addr, ptep);
 	struct hstate *h = hstate_vma(walk->vma);
 
 	return check_hwpoisoned_entry(pte, addr, huge_page_shift(h),
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 518adfe4ad85b..ec0c0667fa9b5 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -567,7 +567,7 @@ static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
 	pte_t entry;
 
 	ptl = huge_pte_lock(hstate_vma(walk->vma), walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	entry = huge_ptep_get(walk->mm, addr, pte);
 	if (!pte_present(entry))
 		goto unlock;
 	page = pte_page(entry);
diff --git a/mm/migrate.c b/mm/migrate.c
index b5311dcb8dbbb..1eca397c09631 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -322,12 +322,13 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
-void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl)
+void __migration_entry_wait_huge(struct mm_struct *mm,
+		unsigned long address, pte_t *ptep, spinlock_t *ptl)
 {
 	pte_t pte;
 
 	spin_lock(ptl);
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(mm, address, ptep);
 
 	if (unlikely(!is_hugetlb_entry_migration(pte)))
 		spin_unlock(ptl);
@@ -335,11 +336,12 @@ void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl)
 		migration_entry_wait_on_locked(pte_to_swp_entry(pte), NULL, ptl);
 }
 
-void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte)
+void migration_entry_wait_huge(struct vm_area_struct *vma,
+		unsigned long address, pte_t *pte)
 {
 	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), vma->vm_mm, pte);
 
-	__migration_entry_wait_huge(pte, ptl);
+	__migration_entry_wait_huge(vma->vm_mm, address, pte, ptl);
 }
 #endif
 
diff --git a/mm/mincore.c b/mm/mincore.c
index 47e89cf37062e..f726b01fbc9a0 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -33,7 +33,7 @@ static int mincore_hugetlb(pte_t *pte, unsigned long hmask, unsigned long addr,
 	 * Hugepages under user process are always in RAM and never
 	 * swapped out, but theoretically it needs to be checked.
 	 */
-	present = pte && !huge_pte_none_mostly(huge_ptep_get(pte));
+	present = pte && !huge_pte_none_mostly(huge_ptep_get(walk->mm, addr, pte));
 	for (; addr != end; vec++, addr += PAGE_SIZE)
 		*vec = present;
 	walk->private = vec;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 992a0a16846f7..dfe0fb032bfa6 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -417,7 +417,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		}
 
 		if (mode != MCOPY_ATOMIC_CONTINUE &&
-		    !huge_pte_none_mostly(huge_ptep_get(dst_pte))) {
+		    !huge_pte_none_mostly(huge_ptep_get(dst_mm, dst_addr,
+						      dst_pte))) {
 			err = -EEXIST;
 			hugetlb_vma_unlock_read(dst_vma);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-- 
2.53.0

