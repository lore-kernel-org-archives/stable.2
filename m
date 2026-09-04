Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97744339847
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527897; cv=none; b=deGHniWGOak3jHFNVcik3foxXp3C4bQcYFNprvpSHTKqEqAlsoh2NtI6mBrNsIwBYwke/YLKmsL2xNBcSgJAKTCDuKPyg+mfnp9C5rj5KG0ikJcLtH4fD5857txna4JUsWtTvnozAik6vExQuNcPXkQdu7uKGy6BKFyPqe9+4WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527897; c=relaxed/simple;
	bh=sp3TOtke7pJMl6ITM7klg7kyrqfvcR7mo/eadc//J+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNHgphnWuAUTTGBzv4w71uckNRkV9LkPAh60JzZkwguiHgbu57XQtLba3oqnR+6JGl9c8qxNF0oBI0GH/eePDb1TclF8vnm6StyFlgDdrOkIedM2wdm9j9n+HDiPv8kvv82k1ZqCqVaQJGYIawzNDi/OcfKko2nb7OsHGGbQAl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gavQ+IPR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gavQ+IPR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE761F00AC4;
	Fri,  4 Sep 2026 13:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788527893;
	bh=Krt8CCHQDC0TOKbqr4LIO2/XoXZS0fvVFE0spBnmTQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gavQ+IPRO4ycYQ4sAAroscGj+e7uW9+uEFTZjQwxGeEUOa4EwvP3K9JxamB9Ki0DZ
	 d8zZjKfm5NDKa9sZsVWbcDRdCEtLNOHLwUJDTU90I9Oyo+8S5+N/Dpi2derUefyXss
	 4VVuh1l5N7S9iOJgcGWSRpXLFGdU0ackgEYeSVU0gEHj9HYrAPpKN6Wh8Dgm5ftuTN
	 oiB9nmf+cdqxRjhbNQEamKER07Z3U3xo94tv0Ui1ac2Fn7/cGCUSXMcxVjd0ufdY7k
	 oVaH22m6bBh1QeIrTrZLXj8fCditH3zWmPR0TCRyYGqXXL5NVaZWIZLOnXYtsaH1sB
	 GqI0vXH6RD+tw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/6] hugetlb: convert hugetlb_no_page() to use struct vm_fault
Date: Fri,  4 Sep 2026 09:18:05 -0400
Message-ID: <20260904131809.503371-2-sashal@kernel.org>
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

From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>

[ Upstream commit 7b6ec181de372a243e3ef285ae1a48f32d5c71ba ]

hugetlb_no_page() can use the struct vm_fault passed in from
hugetlb_fault(). This alleviates the stack by consolidating 7
variables into a single struct.

[vishal.moola@gmail.com:  simplify hugetlb_no_page() arguments]
  Link: https://lkml.kernel.org/r/ZhQtN8y5zud8iI1u@fedora
Link: https://lkml.kernel.org/r/20240401202651.31440-3-vishal.moola@gmail.com
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: e87df0d5d696 ("mm/page_vma_mapped: use huge_ptep_get() for hugetlb")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 74 +++++++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 27322ffd140c3..a9757b11b7c49 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5848,22 +5848,19 @@ static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm,
 	return same;
 }
 
-static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
-			struct vm_area_struct *vma,
-			struct address_space *mapping, pgoff_t idx,
-			unsigned long address, pte_t *ptep,
-			pte_t old_pte, unsigned int flags)
+static vm_fault_t hugetlb_no_page(struct address_space *mapping,
+			struct vm_fault *vmf)
 {
+	struct vm_area_struct *vma = vmf->vma;
+	struct mm_struct *mm = vma->vm_mm;
 	struct hstate *h = hstate_vma(vma);
 	vm_fault_t ret = VM_FAULT_SIGBUS;
 	int anon_rmap = 0;
 	unsigned long size;
 	struct folio *folio;
 	pte_t new_pte;
-	spinlock_t *ptl;
-	unsigned long haddr = address & huge_page_mask(h);
 	bool new_folio, new_pagecache_folio = false;
-	u32 hash = hugetlb_fault_mutex_hash(mapping, idx);
+	u32 hash = hugetlb_fault_mutex_hash(mapping, vmf->pgoff);
 
 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -5882,10 +5879,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * before we get page_table_lock.
 	 */
 	new_folio = false;
-	folio = filemap_lock_folio(mapping, idx);
+	folio = filemap_lock_folio(mapping, vmf->pgoff);
 	if (IS_ERR(folio)) {
 		size = i_size_read(mapping->host) >> huge_page_shift(h);
-		if (idx >= size)
+		if (vmf->pgoff >= size)
 			goto out;
 		/* Check for page in userfault range */
 		if (userfaultfd_missing(vma)) {
@@ -5906,17 +5903,18 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 * never happen on the page after UFFDIO_COPY has
 			 * correctly installed the page and returned.
 			 */
-			if (!hugetlb_pte_stable(h, mm, ptep, old_pte)) {
+			if (!hugetlb_pte_stable(h, mm, vmf->pte, vmf->orig_pte)) {
 				ret = 0;
 				goto out;
 			}
 
-			return hugetlb_handle_userfault(vma, mapping, idx, flags,
-							haddr, address,
+			return hugetlb_handle_userfault(vma, mapping, vmf->pgoff,
+							vmf->flags, vmf->address,
+							vmf->real_address,
 							VM_UFFD_MISSING);
 		}
 
-		folio = alloc_hugetlb_folio(vma, haddr, 0);
+		folio = alloc_hugetlb_folio(vma, vmf->address, 0);
 		if (IS_ERR(folio)) {
 			/*
 			 * Returning error will result in faulting task being
@@ -5930,18 +5928,20 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 * here.  Before returning error, get ptl and make
 			 * sure there really is no pte entry.
 			 */
-			if (hugetlb_pte_stable(h, mm, ptep, old_pte))
+			if (hugetlb_pte_stable(h, mm, vmf->pte, vmf->orig_pte))
 				ret = vmf_error(PTR_ERR(folio));
 			else
 				ret = 0;
 			goto out;
 		}
-		clear_huge_page(&folio->page, address, pages_per_huge_page(h));
+		clear_huge_page(&folio->page, vmf->real_address,
+				pages_per_huge_page(h));
 		__folio_mark_uptodate(folio);
 		new_folio = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
-			int err = hugetlb_add_to_page_cache(folio, mapping, idx);
+			int err = hugetlb_add_to_page_cache(folio, mapping,
+							vmf->pgoff);
 			if (err) {
 				/*
 				 * err can't be -EEXIST which implies someone
@@ -5950,7 +5950,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 				 * to the page cache. So it's safe to call
 				 * restore_reserve_on_error() here.
 				 */
-				restore_reserve_on_error(h, vma, haddr, folio);
+				restore_reserve_on_error(h, vma, vmf->address,
+							folio);
 				folio_put(folio);
 				goto out;
 			}
@@ -5980,12 +5981,13 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			folio_unlock(folio);
 			folio_put(folio);
 			/* See comment in userfaultfd_missing() block above */
-			if (!hugetlb_pte_stable(h, mm, ptep, old_pte)) {
+			if (!hugetlb_pte_stable(h, mm, vmf->pte, vmf->orig_pte)) {
 				ret = 0;
 				goto out;
 			}
-			return hugetlb_handle_userfault(vma, mapping, idx, flags,
-							haddr, address,
+			return hugetlb_handle_userfault(vma, mapping, vmf->pgoff,
+							vmf->flags, vmf->address,
+							vmf->real_address,
 							VM_UFFD_MINOR);
 		}
 	}
@@ -5996,23 +5998,23 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * any allocations necessary to record that reservation occur outside
 	 * the spinlock.
 	 */
-	if ((flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
-		if (vma_needs_reservation(h, vma, haddr) < 0) {
+	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
+		if (vma_needs_reservation(h, vma, vmf->address) < 0) {
 			ret = VM_FAULT_OOM;
 			goto backout_unlocked;
 		}
 		/* Just decrements count, does not deallocate */
-		vma_end_reservation(h, vma, haddr);
+		vma_end_reservation(h, vma, vmf->address);
 	}
 
-	ptl = huge_pte_lock(h, mm, ptep);
+	vmf->ptl = huge_pte_lock(h, mm, vmf->pte);
 	ret = 0;
 	/* If pte changed from under us, retry */
-	if (!pte_same(huge_ptep_get(ptep), old_pte))
+	if (!pte_same(huge_ptep_get(vmf->pte), vmf->orig_pte))
 		goto backout;
 
 	if (anon_rmap)
-		hugepage_add_new_anon_rmap(folio, vma, haddr);
+		hugepage_add_new_anon_rmap(folio, vma, vmf->address);
 	else
 		page_dup_file_rmap(&folio->page, true);
 	new_pte = make_huge_pte(vma, &folio->page, ((vma->vm_flags & VM_WRITE)
@@ -6021,17 +6023,18 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * If this pte was previously wr-protected, keep it wr-protected even
 	 * if populated.
 	 */
-	if (unlikely(pte_marker_uffd_wp(old_pte)))
+	if (unlikely(pte_marker_uffd_wp(vmf->orig_pte)))
 		new_pte = huge_pte_mkuffd_wp(new_pte);
-	set_huge_pte_at(mm, haddr, ptep, new_pte, huge_page_size(h));
+	set_huge_pte_at(mm, vmf->address, vmf->pte, new_pte, huge_page_size(h));
 
 	hugetlb_count_add(pages_per_huge_page(h), mm);
-	if ((flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
+	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
 		/* Optimization, do the COW without a second fault */
-		ret = hugetlb_wp(mm, vma, address, ptep, flags, folio, ptl);
+		ret = hugetlb_wp(mm, vma, vmf->real_address, vmf->pte,
+				vmf->flags, folio, vmf->ptl);
 	}
 
-	spin_unlock(ptl);
+	spin_unlock(vmf->ptl);
 
 	/*
 	 * Only set hugetlb_migratable in newly allocated pages.  Existing pages
@@ -6048,10 +6051,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	return ret;
 
 backout:
-	spin_unlock(ptl);
+	spin_unlock(vmf->ptl);
 backout_unlocked:
 	if (new_folio && !new_pagecache_folio)
-		restore_reserve_on_error(h, vma, haddr, folio);
+		restore_reserve_on_error(h, vma, vmf->address, folio);
 
 	folio_unlock(folio);
 	folio_put(folio);
@@ -6153,8 +6156,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * hugetlb_no_page will drop vma lock and hugetlb fault
 		 * mutex internally, which make us return immediately.
 		 */
-		return hugetlb_no_page(mm, vma, mapping, vmf.pgoff, address,
-				       vmf.pte, vmf.orig_pte, flags);
+		return hugetlb_no_page(mapping, &vmf);
 	}
 
 	ret = 0;
-- 
2.53.0

