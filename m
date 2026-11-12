Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450892;
	b=W2zc5DGyo46WF2xb8eQxb8QhASfwL+4gTZYERNGLzH6nZcMsulloWNQSsrPo0g5OeVBH
	 knXG9uSKXzgoxtvHuQhRdMnW4VAdMmPW+m12/FNpFv+r9NW9SevLy1UsRr+yNMeMemtSB
	 35ZDlKw3iSdKT1Mqo8ei/aTmtKErvdAZVUUDGVnEBc3XIxkUFEdAzVVVoIUDSROt9/iMt
	 3+69dq8JCLXr+eGI+WHn3bVXKV/K3x7Zwv+qIQgOE3jcVr3OyHdsSaWgONLXVy3jGQ1PO
	 ptiFiXkMUOl54j1Xn8OKyI5znc6QGPEzbBvHI+Qm6ZfpwCBCiI6SCT10WBediovsEZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450892;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OrHFq+vpUFZgOzQwSFfGF33qyM25Z/c5KwjiuMBu+2g=;
	b=R7KqbbnQOC50uCRDmezC8u4sH/QQjsYARFZrUwZ0RJrjCP8qlWJgrrPR0Tm4BRqoK9VY
	 SoVN7re2yBGgjMnFGn4cpllRPqd0u1zQ6n9i4i54Rtb76QbzieFQ6QYuZ5rbFWonkrrAt
	 clTJK6zfsZ6RmHux9hO8mPC2oQWAHg07m/tyYYMG7yFH2TYfBZ87hhgGG43p/m+iBTj6l
	 S+TMMVyB2WCnJuxF3GGhyiXB9tXHG77QZn8mLTUuSTHTET27oLb5bkIpI3+QmLtdOs1SX
	 edanJUW1W9SF+1lNW3W0KbkSKCSxR41mb5dZs+0NXMB1OUHAtKX+p/q1XNmSuIPO1Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PTnIsKxT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1061606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PTnIsKxT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DDC1F00A06;
	Thu, 12 Nov 2026 02:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450892;
	bh=OrHFq+vpUFZgOzQwSFfGF33qyM25Z/c5KwjiuMBu+2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PTnIsKxTZysvoolXoXoi54ElknvR94J2G/prC9L3MIDjGR47pXoaTkKvqup/VBrkS
	 m6NQ34mP4EU1c5DTH/UVBm14H/eoUIPu6moG1JfQUQLA89I8moK0uepLXwQKaSNxWy
	 jbQSf2nGMW3cvhz8HN/i7IEn730hbZsKpHXSSte8mdSDDihK7dZuXrWj4rdOO0Wp4X
	 KSyFmC0NSWIOzUxeBst+vAyMwZfyG7fOQNW/f39ltyN3lANErEltzRkeKFqxiaEQVI
	 pGA9ytFUUIe8jyF3WAEHT+kQCSQZ/FYi6jzUG/oI5MfuItcpr7x/s74wzy+kqcJgNX
	 I7St1XMOzSLSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alistair Popple <apopple@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] mm/gup: remove dead pgmap refcounting code
Date: Wed, 11 Nov 2026 21:34:43 -0500
Message-ID: <20261112023429.1348841-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112023429.1348841-1-sashal@kernel.org>
References: <20261109200900-failed-6.12-79cb51d538ab@kernel.org>
 <20261112023429.1348841-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Popple <apopple@nvidia.com>

[ Upstream commit d3f7922b929a92873e14f7c61a026a6b576e8773 ]

Prior to commit aed877c2b425 ("device/dax: properly refcount device dax
pages when mapping") ZONE_DEVICE pages were not fully reference counted
when mapped into user page tables.  Instead GUP would take a reference on
the associated pgmap to ensure the results of pfn_to_page() remained
valid.

This is no longer required and most of the code was removed by commit
fd2825b0760a ("mm/gup: remove pXX_devmap usage from get_user_pages()").
Finish cleaning this up by removing the dead calls to put_dev_pagemap()
and the temporary context struct.

Link: https://lkml.kernel.org/r/20250903225926.34702-1-apopple@nvidia.com
Signed-off-by: Alistair Popple <apopple@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 79cb51d538ab ("mm/gup: recheck the PUD under PTL in follow_pud_mask()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/gup.c | 67 ++++++++++++++++++++++----------------------------------
 1 file changed, 26 insertions(+), 41 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 914e586137a2f..b8367869f7928 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -27,11 +27,6 @@
 
 #include "internal.h"
 
-struct follow_page_context {
-	struct dev_pagemap *pgmap;
-	unsigned int page_mask;
-};
-
 static inline void sanity_check_pinned_pages(struct page **pages,
 					     unsigned long npages)
 {
@@ -624,7 +619,7 @@ static struct page *no_page_table(struct vm_area_struct *vma,
 #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
 static struct page *follow_huge_pud(struct vm_area_struct *vma,
 				    unsigned long addr, pud_t *pudp,
-				    int flags, struct follow_page_context *ctx)
+				    int flags, unsigned long *page_mask)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct page *page;
@@ -650,7 +645,7 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
 	if (ret)
 		page = ERR_PTR(ret);
 	else
-		ctx->page_mask = HPAGE_PUD_NR - 1;
+		*page_mask = HPAGE_PUD_NR - 1;
 
 	return page;
 }
@@ -696,7 +691,7 @@ static inline bool can_follow_write_pmd(pmd_t pmd, struct page *page,
 static struct page *follow_huge_pmd(struct vm_area_struct *vma,
 				    unsigned long addr, pmd_t *pmd,
 				    unsigned int flags,
-				    struct follow_page_context *ctx)
+				    unsigned long *page_mask)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pmd_t pmdval = *pmd;
@@ -733,7 +728,7 @@ static struct page *follow_huge_pmd(struct vm_area_struct *vma,
 #endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
 
 	page += (addr & ~HPAGE_PMD_MASK) >> PAGE_SHIFT;
-	ctx->page_mask = HPAGE_PMD_NR - 1;
+	*page_mask = HPAGE_PMD_NR - 1;
 
 	return page;
 }
@@ -741,7 +736,7 @@ static struct page *follow_huge_pmd(struct vm_area_struct *vma,
 #else  /* CONFIG_PGTABLE_HAS_HUGE_LEAVES */
 static struct page *follow_huge_pud(struct vm_area_struct *vma,
 				    unsigned long addr, pud_t *pudp,
-				    int flags, struct follow_page_context *ctx)
+				    int flags, unsigned long *page_mask)
 {
 	return NULL;
 }
@@ -749,7 +744,7 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
 static struct page *follow_huge_pmd(struct vm_area_struct *vma,
 				    unsigned long addr, pmd_t *pmd,
 				    unsigned int flags,
-				    struct follow_page_context *ctx)
+				    unsigned long *page_mask)
 {
 	return NULL;
 }
@@ -815,8 +810,7 @@ static inline bool can_follow_write_pte(pte_t pte, struct page *page,
 }
 
 static struct page *follow_page_pte(struct vm_area_struct *vma,
-		unsigned long address, pmd_t *pmd, unsigned int flags,
-		struct dev_pagemap **pgmap)
+		unsigned long address, pmd_t *pmd, unsigned int flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct folio *folio;
@@ -919,7 +913,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 				    unsigned long address, pud_t *pudp,
 				    unsigned int flags,
-				    struct follow_page_context *ctx)
+				    unsigned long *page_mask)
 {
 	pmd_t *pmd, pmdval;
 	spinlock_t *ptl;
@@ -933,7 +927,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 	if (!pmd_present(pmdval))
 		return no_page_table(vma, flags, address);
 	if (likely(!pmd_leaf(pmdval)))
-		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
+		return follow_page_pte(vma, address, pmd, flags);
 
 	if (pmd_protnone(pmdval) && !gup_can_follow_protnone(vma, flags))
 		return no_page_table(vma, flags, address);
@@ -946,16 +940,16 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 	}
 	if (unlikely(!pmd_leaf(pmdval))) {
 		spin_unlock(ptl);
-		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
+		return follow_page_pte(vma, address, pmd, flags);
 	}
 	if (pmd_trans_huge(pmdval) && (flags & FOLL_SPLIT_PMD)) {
 		spin_unlock(ptl);
 		split_huge_pmd(vma, pmd, address);
 		/* If pmd was left empty, stuff a page table in there quickly */
 		return pte_alloc(mm, pmd) ? ERR_PTR(-ENOMEM) :
-			follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
+			follow_page_pte(vma, address, pmd, flags);
 	}
-	page = follow_huge_pmd(vma, address, pmd, flags, ctx);
+	page = follow_huge_pmd(vma, address, pmd, flags, page_mask);
 	spin_unlock(ptl);
 	return page;
 }
@@ -963,7 +957,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 static struct page *follow_pud_mask(struct vm_area_struct *vma,
 				    unsigned long address, p4d_t *p4dp,
 				    unsigned int flags,
-				    struct follow_page_context *ctx)
+				    unsigned long *page_mask)
 {
 	pud_t *pudp, pud;
 	spinlock_t *ptl;
@@ -976,7 +970,7 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 		return no_page_table(vma, flags, address);
 	if (pud_leaf(pud)) {
 		ptl = pud_lock(mm, pudp);
-		page = follow_huge_pud(vma, address, pudp, flags, ctx);
+		page = follow_huge_pud(vma, address, pudp, flags, page_mask);
 		spin_unlock(ptl);
 		if (page)
 			return page;
@@ -985,13 +979,13 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 	if (unlikely(pud_bad(pud)))
 		return no_page_table(vma, flags, address);
 
-	return follow_pmd_mask(vma, address, pudp, flags, ctx);
+	return follow_pmd_mask(vma, address, pudp, flags, page_mask);
 }
 
 static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 				    unsigned long address, pgd_t *pgdp,
 				    unsigned int flags,
-				    struct follow_page_context *ctx)
+				    unsigned long *page_mask)
 {
 	p4d_t *p4dp, p4d;
 
@@ -1002,7 +996,7 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 	if (!p4d_present(p4d) || p4d_bad(p4d))
 		return no_page_table(vma, flags, address);
 
-	return follow_pud_mask(vma, address, p4dp, flags, ctx);
+	return follow_pud_mask(vma, address, p4dp, flags, page_mask);
 }
 
 /**
@@ -1010,20 +1004,16 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
  * @vma: vm_area_struct mapping @address
  * @address: virtual address to look up
  * @flags: flags modifying lookup behaviour
- * @ctx: contains dev_pagemap for %ZONE_DEVICE memory pinning and a
- *       pointer to output page_mask
+ * @page_mask: a pointer to output page_mask
  *
  * @flags can have FOLL_ flags set, defined in <linux/mm.h>
  *
- * When getting pages from ZONE_DEVICE memory, the @ctx->pgmap caches
- * the device's dev_pagemap metadata to avoid repeating expensive lookups.
- *
  * When getting an anonymous page and the caller has to trigger unsharing
  * of a shared anonymous page first, -EMLINK is returned. The caller should
  * trigger a fault with FAULT_FLAG_UNSHARE set. Note that unsharing is only
  * relevant with FOLL_PIN and !FOLL_WRITE.
  *
- * On output, the @ctx->page_mask is set according to the size of the page.
+ * On output, @page_mask is set according to the size of the page.
  *
  * Return: the mapped (struct page *), %NULL if no mapping exists, or
  * an error pointer if there is a mapping to something not represented
@@ -1031,7 +1021,7 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
  */
 static struct page *follow_page_mask(struct vm_area_struct *vma,
 			      unsigned long address, unsigned int flags,
-			      struct follow_page_context *ctx)
+			      unsigned long *page_mask)
 {
 	pgd_t *pgd;
 	struct mm_struct *mm = vma->vm_mm;
@@ -1039,13 +1029,13 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 
 	vma_pgtable_walk_begin(vma);
 
-	ctx->page_mask = 0;
+	*page_mask = 0;
 	pgd = pgd_offset(mm, address);
 
 	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
 		page = no_page_table(vma, flags, address);
 	else
-		page = follow_p4d_mask(vma, address, pgd, flags, ctx);
+		page = follow_p4d_mask(vma, address, pgd, flags, page_mask);
 
 	vma_pgtable_walk_end(vma);
 
@@ -1389,7 +1379,7 @@ static long __get_user_pages(struct mm_struct *mm,
 {
 	long ret = 0, i = 0;
 	struct vm_area_struct *vma = NULL;
-	struct follow_page_context ctx = { NULL };
+	unsigned long page_mask = 0;
 
 	if (!nr_pages)
 		return 0;
@@ -1427,7 +1417,7 @@ static long __get_user_pages(struct mm_struct *mm,
 						pages ? &page : NULL);
 				if (ret)
 					goto out;
-				ctx.page_mask = 0;
+				page_mask = 0;
 				goto next_page;
 			}
 
@@ -1450,7 +1440,7 @@ static long __get_user_pages(struct mm_struct *mm,
 		}
 		cond_resched();
 
-		page = follow_page_mask(vma, start, gup_flags, &ctx);
+		page = follow_page_mask(vma, start, gup_flags, &page_mask);
 		if (!page || PTR_ERR(page) == -EMLINK) {
 			ret = faultin_page(vma, start, gup_flags,
 					   PTR_ERR(page) == -EMLINK, locked);
@@ -1483,7 +1473,7 @@ static long __get_user_pages(struct mm_struct *mm,
 			goto out;
 		}
 next_page:
-		page_increm = 1 + (~(start >> PAGE_SHIFT) & ctx.page_mask);
+		page_increm = 1 + (~(start >> PAGE_SHIFT) & page_mask);
 		if (page_increm > nr_pages)
 			page_increm = nr_pages;
 
@@ -1533,8 +1523,6 @@ static long __get_user_pages(struct mm_struct *mm,
 		nr_pages -= page_increm;
 	} while (nr_pages);
 out:
-	if (ctx.pgmap)
-		put_dev_pagemap(ctx.pgmap);
 	return i ? i : ret;
 }
 
@@ -2894,7 +2882,6 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		unsigned long end, unsigned int flags, struct page **pages,
 		int *nr)
 {
-	struct dev_pagemap *pgmap = NULL;
 	int ret = 0;
 	pte_t *ptep, *ptem;
 
@@ -2966,8 +2953,6 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 	ret = 1;
 
 pte_unmap:
-	if (pgmap)
-		put_dev_pagemap(pgmap);
 	pte_unmap(ptem);
 	return ret;
 }
-- 
2.53.0

