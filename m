Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560943537C8
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527907; cv=none; b=i7WqtKR4N3NaQaFUf+gSImXd9d/44KaYsoJlLjUPeLGOwS2bH/w95gFo0p1qrKDyGwYFcnd4Y/38ftQ6hCF8atYWnn60mPr7Fikdf/QERWpegUFtGIjapicjkM6d9TPjXMtPYfvBd9erw3e+ShTIBP3FqFOVU8ihwVzi8nXhMr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527907; c=relaxed/simple;
	bh=+iff5HH1Xyg0S6LAiwJF3tPZ9vMQufy+AdX8m85G6cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSZC+D3CLWRDy5UIz31G3Etc2e01Z6CeJGiKmXQD3ReTxsUsIOfd6F0tZ3+J7Jndph61H5lHpoMN3iXoGbtvIRb1KIUfj89oQawkUkPgVA1Qs1gI4rxCcwliK/08jLPQJa7YJHBaxwyKBecGKoqG8f1MjgVQ97LwCuESXjP6wLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDqpY9uF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDqpY9uF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477351F00ADB;
	Fri,  4 Sep 2026 13:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788527896;
	bh=Nq0p1pBgH935O6y+MsMIIENOvudRJ9B5vmZqPTHwlII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GDqpY9uF5uTkOQoYSN7dkZ6BC7pzjvB62+E5soKH+g8vqG50I7Ys0MeLhTSk2ar4K
	 Ca6XG6sAb76JgoCqahyPGbUFxJj32mLY6zPGnlpr0NUVmDuJI+gkXKxvMueirVUeEp
	 1Ads1KkYD5IUXedanvuTHS5eZyqbUWxrkQ052W5V8dpc00mkLBZiDK9JmZCIqd2vnM
	 QeNPeM//Si2N+a+ulUaf5dwOJsriNTpl215F26nTwWUFH/ul3klaW867ZjfhHM9llW
	 AUEr1Foxhjl0Ca99TlLKroBaIrllXcpXsB7U90gh+0VShimO7O5fUtg97UAataUEas
	 tVLpGuy8DYzNw==
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
Subject: [PATCH 6.6.y 5/6] mm: provide mm_struct and address to huge_ptep_get()
Date: Fri,  4 Sep 2026 09:18:08 -0400
Message-ID: <20260904131809.503371-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904131809.503371-1-sashal@kernel.org>
References: <2026090314-mumps-septum-7049@gregkh>
 <20260904131809.503371-1-sashal@kernel.org>
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
Stable-dep-of: e87df0d5d696 ("mm/page_vma_mapped: use huge_ptep_get() for hugetlb")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/include/asm/hugetlb-3level.h |  4 +--
 arch/arm64/include/asm/hugetlb.h      |  2 +-
 arch/arm64/mm/hugetlbpage.c           |  2 +-
 arch/riscv/include/asm/hugetlb.h      |  2 +-
 arch/riscv/mm/hugetlbpage.c           |  2 +-
 arch/s390/include/asm/hugetlb.h       |  4 +--
 arch/s390/mm/hugetlbpage.c            |  4 +--
 fs/hugetlbfs/inode.c                  |  2 +-
 fs/proc/task_mmu.c                    | 10 +++---
 fs/userfaultfd.c                      |  2 +-
 include/asm-generic/hugetlb.h         |  2 +-
 include/linux/swapops.h               |  4 +--
 mm/damon/vaddr.c                      |  6 ++--
 mm/gup.c                              |  2 +-
 mm/hmm.c                              |  2 +-
 mm/hugetlb.c                          | 46 +++++++++++++--------------
 mm/memory-failure.c                   |  2 +-
 mm/mempolicy.c                        |  2 +-
 mm/migrate.c                          |  4 +--
 mm/mincore.c                          |  2 +-
 mm/userfaultfd.c                      |  2 +-
 21 files changed, 54 insertions(+), 54 deletions(-)

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
index 92a5e0879b111..5d278bf511fa4 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -46,7 +46,7 @@ extern pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 			   pte_t *ptep, unsigned long sz);
 #define __HAVE_ARCH_HUGE_PTEP_GET
-extern pte_t huge_ptep_get(pte_t *ptep);
+extern pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 
 void __init arm64_hugetlb_cma_reserve(void);
 
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 688d11b1cabdb..b2ca8fa5af44c 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -141,7 +141,7 @@ static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
 	return contig_ptes;
 }
 
-pte_t huge_ptep_get(pte_t *ptep)
+pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	int ncontig, i;
 	size_t pgsize;
diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
index 0e809026b6e39..7107d1eaeb24b 100644
--- a/arch/riscv/include/asm/hugetlb.h
+++ b/arch/riscv/include/asm/hugetlb.h
@@ -45,7 +45,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 			       pte_t pte, int dirty);
 
 #define __HAVE_ARCH_HUGE_PTEP_GET
-pte_t huge_ptep_get(pte_t *ptep);
+pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 
 pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags);
 #define arch_make_huge_pte arch_make_huge_pte
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 57afbc3270a3c..8a059b15d760a 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -3,7 +3,7 @@
 #include <linux/err.h>
 
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
-pte_t huge_ptep_get(pte_t *ptep)
+pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	unsigned long pte_num;
 	int i;
diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index 097b388d4e690..87ead138973d8 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -19,7 +19,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t pte, unsigned long sz);
 void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t pte);
-pte_t huge_ptep_get(pte_t *ptep);
+pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 pte_t __huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep);
 
@@ -71,7 +71,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 					     unsigned long addr, pte_t *ptep,
 					     pte_t pte, int dirty)
 {
-	int changed = !pte_same(huge_ptep_get(ptep), pte);
+	int changed = !pte_same(huge_ptep_get(vma->vm_mm, addr, ptep), pte);
 	if (changed) {
 		__huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
 		__set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index 5ebd730f1ffbb..eef46fd9eaaff 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -169,7 +169,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	__set_huge_pte_at(mm, addr, ptep, pte);
 }
 
-pte_t huge_ptep_get(pte_t *ptep)
+pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	return __rste_to_pte(pte_val(*ptep));
 }
@@ -177,7 +177,7 @@ pte_t huge_ptep_get(pte_t *ptep)
 pte_t __huge_ptep_get_and_clear(struct mm_struct *mm,
 				unsigned long addr, pte_t *ptep)
 {
-	pte_t pte = huge_ptep_get(ptep);
+	pte_t pte = huge_ptep_get(mm, addr, ptep);
 	pmd_t *pmdp = (pmd_t *) ptep;
 	pud_t *pudp = (pud_t *) ptep;
 
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 914e850b9cbb7..7fd8dccca8189 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -448,7 +448,7 @@ static bool hugetlb_vma_maps_page(struct vm_area_struct *vma,
 	if (!ptep)
 		return false;
 
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(vma->vm_mm, addr, ptep);
 	if (huge_pte_none(pte) || !pte_present(pte))
 		return false;
 
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 1a9c1c9e53e4e..a245ee038ed55 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -723,7 +723,7 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 {
 	struct mem_size_stats *mss = walk->private;
 	struct vm_area_struct *vma = walk->vma;
-	pte_t ptent = huge_ptep_get(pte);
+	pte_t ptent = huge_ptep_get(walk->mm, addr, pte);
 	struct folio *folio = NULL;
 
 	if (pte_present(ptent)) {
@@ -732,10 +732,10 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 		swp_entry_t swpent = pte_to_swp_entry(ptent);
 
 		if (is_pfn_swap_entry(swpent))
-			folio = pfn_swap_entry_folio(swpent);
+			folio = page_folio(pfn_swap_entry_to_page(swpent));
 	}
 	if (folio) {
-		if (folio_likely_mapped_shared(folio) ||
+		if (folio_mapcount(folio) >= 2 ||
 		    hugetlb_pmd_shared(pte))
 			mss->shared_hugetlb += huge_page_size(hstate_vma(vma));
 		else
@@ -1579,7 +1579,7 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 	if (vma->vm_flags & VM_SOFTDIRTY)
 		flags |= PM_SOFT_DIRTY;
 
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(walk->mm, addr, ptep);
 	if (pte_present(pte)) {
 		struct page *page = pte_page(pte);
 
@@ -1911,7 +1911,7 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 static int gather_hugetlb_stats(pte_t *pte, unsigned long hmask,
 		unsigned long addr, unsigned long end, struct mm_walk *walk)
 {
-	pte_t huge_pte = huge_ptep_get(pte);
+	pte_t huge_pte = huge_ptep_get(walk->mm, addr, pte);
 	struct numa_maps *md;
 	struct page *page;
 
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0ebdf3c2c9ee6..4349afd3c742c 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -291,7 +291,7 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 		goto out;
 
 	ret = false;
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(vma->vm_mm, vmf->address, ptep);
 
 	/*
 	 * Lockless access: we're in a wait_event so it's ok if it
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 2d7ae9b51d1e3..215bf9f317cbf 100644
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
index 7555a4a3d3d49..229e409ac2f69 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -334,7 +334,7 @@ static inline bool is_migration_entry_dirty(swp_entry_t entry)
 
 extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					unsigned long address);
-extern void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte);
+extern void migration_entry_wait_huge(struct vm_area_struct *vma, unsigned long addr, pte_t *pte);
 #else  /* CONFIG_MIGRATION */
 static inline swp_entry_t make_readable_migration_entry(pgoff_t offset)
 {
@@ -359,7 +359,7 @@ static inline int is_migration_entry(swp_entry_t swp)
 static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					unsigned long address) { }
 static inline void migration_entry_wait_huge(struct vm_area_struct *vma,
-					pte_t *pte) { }
+					     unsigned long addr, pte_t *pte) { }
 static inline int is_writable_migration_entry(swp_entry_t entry)
 {
 	return 0;
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 4d7dc9f65f682..01319e28f2054 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -339,7 +339,7 @@ static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
 				struct vm_area_struct *vma, unsigned long addr)
 {
 	bool referenced = false;
-	pte_t entry = huge_ptep_get(pte);
+	pte_t entry = huge_ptep_get(mm, addr, pte);
 	struct folio *folio = pfn_folio(pte_pfn(entry));
 	unsigned long psize = huge_page_size(hstate_vma(vma));
 
@@ -373,7 +373,7 @@ static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	pte_t entry;
 
 	ptl = huge_pte_lock(h, walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	entry = huge_ptep_get(walk->mm, addr, pte);
 	if (!pte_present(entry))
 		goto out;
 
@@ -507,7 +507,7 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	pte_t entry;
 
 	ptl = huge_pte_lock(h, walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	entry = huge_ptep_get(walk->mm, addr, pte);
 	if (!pte_present(entry))
 		goto out;
 
diff --git a/mm/gup.c b/mm/gup.c
index 60006de1219ee..dbb051eac6021 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2812,7 +2812,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 	if (pte_end < end)
 		end = pte_end;
 
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(current->mm, addr, ptep);
 
 	if (!pte_access_permitted(pte, flags & FOLL_WRITE))
 		return 0;
diff --git a/mm/hmm.c b/mm/hmm.c
index a36e1b4046dbd..575fb7b6db7f0 100644
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
index 271f42eb53ac9..b83cfbb71b7f4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5001,7 +5001,7 @@ static void set_huge_ptep_writable(struct vm_area_struct *vma,
 {
 	pte_t entry;
 
-	entry = huge_pte_mkwrite(huge_pte_mkdirty(huge_ptep_get(ptep)));
+	entry = huge_pte_mkwrite(huge_pte_mkdirty(huge_ptep_get(vma->vm_mm, address, ptep)));
 	if (huge_ptep_set_access_flags(vma, address, ptep, entry, 1))
 		update_mmu_cache(vma, address, ptep);
 }
@@ -5104,7 +5104,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		dst_ptl = huge_pte_lock(h, dst, dst_pte);
 		src_ptl = huge_pte_lockptr(h, src, src_pte);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
-		entry = huge_ptep_get(src_pte);
+		entry = huge_ptep_get(src_vma->vm_mm, addr, src_pte);
 again:
 		if (huge_pte_none(entry)) {
 			/*
@@ -5146,7 +5146,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				set_huge_pte_at(dst, addr, dst_pte,
 						make_pte_marker(marker), sz);
 		} else {
-			entry = huge_ptep_get(src_pte);
+			entry = huge_ptep_get(src_vma->vm_mm, addr, src_pte);
 			pte_folio = page_folio(pte_page(entry));
 			folio_get(pte_folio);
 
@@ -5190,7 +5190,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				dst_ptl = huge_pte_lock(h, dst, dst_pte);
 				src_ptl = huge_pte_lockptr(h, src, src_pte);
 				spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
-				entry = huge_ptep_get(src_pte);
+				entry = huge_ptep_get(src_vma->vm_mm, addr, src_pte);
 				if (!pte_same(src_pte_old, entry)) {
 					restore_reserve_on_error(h, dst_vma, addr,
 								new_folio);
@@ -5301,7 +5301,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 			new_addr |= last_addr_mask;
 			continue;
 		}
-		if (huge_pte_none(huge_ptep_get(src_pte)))
+		if (huge_pte_none(huge_ptep_get(mm, old_addr, src_pte)))
 			continue;
 
 		if (huge_pmd_unshare(&tlb, vma, old_addr, src_pte)) {
@@ -5370,7 +5370,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			continue;
 		}
 
-		pte = huge_ptep_get(ptep);
+		pte = huge_ptep_get(mm, address, ptep);
 		if (huge_pte_none(pte)) {
 			spin_unlock(ptl);
 			continue;
@@ -5569,7 +5569,7 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 	struct vm_area_struct *vma = vmf->vma;
 	struct mm_struct *mm = vma->vm_mm;
 	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
-	pte_t pte = huge_ptep_get(vmf->pte);
+	pte_t pte = huge_ptep_get(mm, vmf->address, vmf->pte);
 	struct hstate *h = hstate_vma(vma);
 	struct folio *old_folio;
 	struct folio *new_folio;
@@ -5681,7 +5681,7 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 			vmf->pte = hugetlb_walk(vma, vmf->address,
 					huge_page_size(h));
 			if (likely(vmf->pte &&
-				   pte_same(huge_ptep_get(vmf->pte), pte)))
+				   pte_same(huge_ptep_get(mm, vmf->address, vmf->pte), pte)))
 				goto retry_avoidcopy;
 			/*
 			 * race occurs while re-acquiring page table
@@ -5720,7 +5720,7 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 	 */
 	spin_lock(vmf->ptl);
 	vmf->pte = hugetlb_walk(vma, vmf->address, huge_page_size(h));
-	if (likely(vmf->pte && pte_same(huge_ptep_get(vmf->pte), pte))) {
+	if (likely(vmf->pte && pte_same(huge_ptep_get(mm, vmf->address, vmf->pte), pte))) {
 		pte_t newpte = make_huge_pte(vma, &new_folio->page, !unshare);
 
 		/* Break COW or unshare */
@@ -5838,14 +5838,14 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
  * Recheck pte with pgtable lock.  Returns true if pte didn't change, or
  * false if pte changed or is changing.
  */
-static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm,
+static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm, unsigned long addr,
 			       pte_t *ptep, pte_t old_pte)
 {
 	spinlock_t *ptl;
 	bool same;
 
 	ptl = huge_pte_lock(h, mm, ptep);
-	same = pte_same(huge_ptep_get(ptep), old_pte);
+	same = pte_same(huge_ptep_get(mm, addr, ptep), old_pte);
 	spin_unlock(ptl);
 
 	return same;
@@ -5906,7 +5906,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 			 * never happen on the page after UFFDIO_COPY has
 			 * correctly installed the page and returned.
 			 */
-			if (!hugetlb_pte_stable(h, mm, vmf->pte, vmf->orig_pte)) {
+			if (!hugetlb_pte_stable(h, mm, vmf->address, vmf->pte, vmf->orig_pte)) {
 				ret = 0;
 				goto out;
 			}
@@ -5931,7 +5931,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 			 * here.  Before returning error, get ptl and make
 			 * sure there really is no pte entry.
 			 */
-			if (hugetlb_pte_stable(h, mm, vmf->pte, vmf->orig_pte))
+			if (hugetlb_pte_stable(h, mm, vmf->address, vmf->pte, vmf->orig_pte))
 				ret = vmf_error(PTR_ERR(folio));
 			else
 				ret = 0;
@@ -5984,7 +5984,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 			folio_unlock(folio);
 			folio_put(folio);
 			/* See comment in userfaultfd_missing() block above */
-			if (!hugetlb_pte_stable(h, mm, vmf->pte, vmf->orig_pte)) {
+			if (!hugetlb_pte_stable(h, mm, vmf->address, vmf->pte, vmf->orig_pte)) {
 				ret = 0;
 				goto out;
 			}
@@ -6013,7 +6013,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	vmf->ptl = huge_pte_lock(h, mm, vmf->pte);
 	ret = 0;
 	/* If pte changed from under us, retry */
-	if (!pte_same(huge_ptep_get(vmf->pte), vmf->orig_pte))
+	if (!pte_same(huge_ptep_get(mm, vmf->address, vmf->pte), vmf->orig_pte))
 		goto backout;
 
 	if (anon_rmap)
@@ -6140,7 +6140,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		return VM_FAULT_OOM;
 	}
 
-	vmf.orig_pte = huge_ptep_get(vmf.pte);
+	vmf.orig_pte = huge_ptep_get(mm, vmf.address, vmf.pte);
 	if (huge_pte_none_mostly(vmf.orig_pte)) {
 		if (is_pte_marker(vmf.orig_pte)) {
 			pte_marker marker =
@@ -6180,7 +6180,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			 * be released there.
 			 */
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			migration_entry_wait_huge(vma, vmf.pte);
+			migration_entry_wait_huge(vma, vmf.address, vmf.pte);
 			return 0;
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(vmf.orig_pte)))
 			ret = VM_FAULT_HWPOISON_LARGE |
@@ -6212,11 +6212,11 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	vmf.ptl = huge_pte_lock(h, mm, vmf.pte);
 
 	/* Check for a racing update before calling hugetlb_wp() */
-	if (unlikely(!pte_same(vmf.orig_pte, huge_ptep_get(vmf.pte))))
+	if (unlikely(!pte_same(vmf.orig_pte, huge_ptep_get(mm, vmf.address, vmf.pte))))
 		goto out_ptl;
 
 	/* Handle userfault-wp first, before trying to lock more pages */
-	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(vmf.pte)) &&
+	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(mm, vmf.address, vmf.pte)) &&
 	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(vmf.orig_pte)) {
 		spin_unlock(vmf.ptl);
 		if (pagecache_folio) {
@@ -6311,7 +6311,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 		ptl = huge_pte_lock(h, dst_mm, dst_pte);
 
 		/* Don't overwrite any existing PTEs (even markers) */
-		if (!huge_pte_none(huge_ptep_get(dst_pte))) {
+		if (!huge_pte_none(huge_ptep_get(dst_mm, dst_addr, dst_pte))) {
 			spin_unlock(ptl);
 			return -EEXIST;
 		}
@@ -6440,7 +6440,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	 * page backing it, then access the page.
 	 */
 	ret = -EEXIST;
-	if (!huge_pte_none_mostly(huge_ptep_get(dst_pte)))
+	if (!huge_pte_none_mostly(huge_ptep_get(dst_mm, dst_addr, dst_pte)))
 		goto out_release_unlock;
 
 	if (folio_in_pagecache)
@@ -6515,7 +6515,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 		goto out_unlock;
 
 	ptl = huge_pte_lock(h, mm, pte);
-	entry = huge_ptep_get(pte);
+	entry = huge_ptep_get(mm, haddr, pte);
 	if (pte_present(entry)) {
 		page = pte_page(entry);
 
@@ -6632,7 +6632,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 			address |= last_addr_mask;
 			continue;
 		}
-		pte = huge_ptep_get(ptep);
+		pte = huge_ptep_get(mm, address, ptep);
 		if (unlikely(is_hugetlb_entry_hwpoisoned(pte))) {
 			/* Nothing to do. */
 		} else if (unlikely(is_hugetlb_entry_migration(pte))) {
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 86cdf36ee3bb9..2dca9b862ca39 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -825,7 +825,7 @@ static int hwpoison_hugetlb_range(pte_t *ptep, unsigned long hmask,
 			    struct mm_walk *walk)
 {
 	struct hwpoison_walk *hwp = walk->private;
-	pte_t pte = huge_ptep_get(ptep);
+	pte_t pte = huge_ptep_get(walk->mm, addr, ptep);
 	struct hstate *h = hstate_vma(walk->vma);
 
 	return check_hwpoisoned_entry(pte, addr, huge_page_shift(h),
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 5bbeb6df9c007..1be46783d9d4b 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -584,7 +584,7 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
 	pte_t entry;
 
 	ptl = huge_pte_lock(hstate_vma(walk->vma), walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	entry = huge_ptep_get(walk->mm, addr, pte);
 	if (!pte_present(entry)) {
 		if (unlikely(is_hugetlb_entry_migration(entry)))
 			qp->nr_failed++;
diff --git a/mm/migrate.c b/mm/migrate.c
index 620871d193c7c..5fbec4834a138 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -335,14 +335,14 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
  *
  * This function will release the vma lock before returning.
  */
-void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *ptep)
+void migration_entry_wait_huge(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
 	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), vma->vm_mm, ptep);
 	pte_t pte;
 
 	hugetlb_vma_assert_locked(vma);
 	spin_lock(ptl);
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(vma->vm_mm, addr, ptep);
 
 	if (unlikely(!is_hugetlb_entry_migration(pte))) {
 		spin_unlock(ptl);
diff --git a/mm/mincore.c b/mm/mincore.c
index 2a55eed792b64..03b42e8dfd642 100644
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
index 99438f0950e3c..ed76ad3ab4fd0 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -482,7 +482,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 		}
 
 		if (!uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE) &&
-		    !huge_pte_none_mostly(huge_ptep_get(dst_pte))) {
+		    !huge_pte_none_mostly(huge_ptep_get(dst_mm, dst_addr, dst_pte))) {
 			err = -EEXIST;
 			hugetlb_vma_unlock_read(dst_vma);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-- 
2.53.0

