Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60D43F4827
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535665; cv=none; b=pX6bgJzjihi0dJtoymHUevH0APJm7eBbhAhQLuZb4BOWWXVzVICVvz08wO7vp5g5AYXB3Xj9ZIclWe3jD3zxOH1epfmKfF1I4czk7HloYj6eO+xUaoiK4PNmlA6v3dhSzbitxFgg9r9pSJRZLBtl6yDNtob3NgedYZUxzo5/B4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535665; c=relaxed/simple;
	bh=ZVJ1j17AJLXL8OwQvhzLHLDiwDFJKIqnXVZJsa8kQjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHMaoqqfFwZXJNRBtajVeYuEa1g6NUMB+4RP+LiC5RBlJagc7k4wD/gRkqHyb9LFlUuLJGTayjz3XsLjfHSeY4LDvZitXpMPw/GBGfObtEhxqXMVG0tjC7AtZeW055z/dFtxVNyVro7RfsdDD7Lut069Dy460dh7J9qc4e53D/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUQrBsBg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUQrBsBg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07B01F00A3D;
	Fri,  4 Sep 2026 15:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788535663;
	bh=0Xzb+kQDilKO8oq7jiaH6n2A0W9V8Ofwhji+CklPMaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aUQrBsBgLMklWDbCyR2x0ZnpZ9beHQ28OeqgWjpkI4V9QLm9dy0g6fieL2QYF/TXV
	 oe58XC/h1M3rti0AG4KZBKoqQcqjFA6IgG1I8UcbWtRw/kirnEoxgMRnlMHmhaqN3j
	 CbJyie00/mOpdJjoe9JGi4POI+zRxBWV+1U+H35J8MtdU4DgDt/2UsmMX32uRrN+Qs
	 5eeNCbhoFdPBtn1j5uDWS1ixhOyTrZrO2df6va8y6q3NsQY+B23lchADtjoz9Im3TQ
	 FWnRElFa+Hp2DK8bYfI0jddmaajOBVXnrkJkAMmTLt/4+xw5M+UWV39343nMyWVU7m
	 Gc+8xQmcUFGyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] hugetlb: convert hugetlb_no_page() to use struct vm_fault
Date: Fri,  4 Sep 2026 11:27:37 -0400
Message-ID: <20260904152741.898549-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090326-freestyle-gratify-7686@gregkh>
References: <2026090326-freestyle-gratify-7686@gregkh>
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
 mm/hugetlb.c         | 176 +++++++++++++++++++++----------------------
 mm/page_vma_mapped.c |  13 ++--
 2 files changed, 94 insertions(+), 95 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ffe5196b4afa6..92c16b4af612d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5829,22 +5829,19 @@ static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm,
 	return same;
 }
 
-static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
-			struct vm_area_struct *vma,
-			struct address_space *mapping, pgoff_t idx,
-			unsigned long address, pte_t *ptep,
-			pte_t old_pte, unsigned int flags)
+static vm_fault_t hugetlb_no_page(struct address_space *mapping,
+				  struct vm_fault *vmf)
 {
+	struct vm_area_struct *vma = vmf->vma;
+	struct mm_struct *mm = vma->vm_mm;
 	struct hstate *h = hstate_vma(vma);
 	vm_fault_t ret = VM_FAULT_SIGBUS;
 	int anon_rmap = 0;
 	unsigned long size;
 	struct page *page;
 	pte_t new_pte;
-	spinlock_t *ptl;
-	unsigned long haddr = address & huge_page_mask(h);
 	bool new_page, new_pagecache_page = false;
-	u32 hash = hugetlb_fault_mutex_hash(mapping, idx);
+	u32 hash = hugetlb_fault_mutex_hash(mapping, vmf->pgoff);
 
 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -5863,10 +5860,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * before we get page_table_lock.
 	 */
 	new_page = false;
-	page = find_lock_page(mapping, idx);
+	page = find_lock_page(mapping, vmf->pgoff);
 	if (!page) {
 		size = i_size_read(mapping->host) >> huge_page_shift(h);
-		if (idx >= size)
+		if (vmf->pgoff >= size)
 			goto out;
 		/* Check for page in userfault range */
 		if (userfaultfd_missing(vma)) {
@@ -5887,17 +5884,18 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
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
 
-		page = alloc_huge_page(vma, haddr, 0);
+		page = alloc_huge_page(vma, vmf->address, 0);
 		if (IS_ERR(page)) {
 			/*
 			 * Returning error will result in faulting task being
@@ -5911,18 +5909,19 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 * here.  Before returning error, get ptl and make
 			 * sure there really is no pte entry.
 			 */
-			if (hugetlb_pte_stable(h, mm, ptep, old_pte))
+			if (hugetlb_pte_stable(h, mm, vmf->pte, vmf->orig_pte))
 				ret = vmf_error(PTR_ERR(page));
 			else
 				ret = 0;
 			goto out;
 		}
-		clear_huge_page(page, address, pages_per_huge_page(h));
+		clear_huge_page(page, vmf->real_address, pages_per_huge_page(h));
 		__SetPageUptodate(page);
 		new_page = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
-			int err = hugetlb_add_to_page_cache(page, mapping, idx);
+			int err = hugetlb_add_to_page_cache(page, mapping,
+							vmf->pgoff);
 			if (err) {
 				/*
 				 * err can't be -EEXIST which implies someone
@@ -5931,7 +5930,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 				 * to the page cache. So it's safe to call
 				 * restore_reserve_on_error() here.
 				 */
-				restore_reserve_on_error(h, vma, haddr, page);
+				restore_reserve_on_error(h, vma, vmf->address,
+							 page);
 				put_page(page);
 				goto out;
 			}
@@ -5961,12 +5961,13 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			unlock_page(page);
 			put_page(page);
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
@@ -5977,24 +5978,24 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
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
 
 	if (anon_rmap) {
 		ClearHPageRestoreReserve(page);
-		hugepage_add_new_anon_rmap(page, vma, haddr);
+		hugepage_add_new_anon_rmap(page, vma, vmf->address);
 	} else
 		page_dup_file_rmap(page, true);
 	new_pte = make_huge_pte(vma, page, ((vma->vm_flags & VM_WRITE)
@@ -6003,17 +6004,18 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * If this pte was previously wr-protected, keep it wr-protected even
 	 * if populated.
 	 */
-	if (unlikely(pte_marker_uffd_wp(old_pte)))
+	if (unlikely(pte_marker_uffd_wp(vmf->orig_pte)))
 		new_pte = huge_pte_wrprotect(huge_pte_mkuffd_wp(new_pte));
-	set_huge_pte_at(mm, haddr, ptep, new_pte);
+	set_huge_pte_at(mm, vmf->address, vmf->pte, new_pte);
 
 	hugetlb_count_add(pages_per_huge_page(h), mm);
-	if ((flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
+	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
 		/* Optimization, do the COW without a second fault */
-		ret = hugetlb_wp(mm, vma, address, ptep, flags, page, ptl);
+		ret = hugetlb_wp(mm, vma, vmf->real_address, vmf->pte,
+				 vmf->flags, page, vmf->ptl);
 	}
 
-	spin_unlock(ptl);
+	spin_unlock(vmf->ptl);
 
 	/*
 	 * Only set HPageMigratable in newly allocated pages.  Existing pages
@@ -6030,10 +6032,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	return ret;
 
 backout:
-	spin_unlock(ptl);
+	spin_unlock(vmf->ptl);
 backout_unlocked:
 	if (new_page && !new_pagecache_page)
-		restore_reserve_on_error(h, vma, haddr, page);
+		restore_reserve_on_error(h, vma, vmf->address, page);
 
 	unlock_page(page);
 	put_page(page);
@@ -6067,30 +6069,34 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx)
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags)
 {
-	pte_t *ptep, entry;
-	spinlock_t *ptl;
 	vm_fault_t ret;
 	u32 hash;
-	pgoff_t idx;
 	struct page *page = NULL;
 	struct page *pagecache_page = NULL;
 	struct hstate *h = hstate_vma(vma);
 	struct address_space *mapping;
 	int need_wait_lock = 0;
-	unsigned long haddr = address & huge_page_mask(h);
+	struct vm_fault vmf = {
+		.vma = vma,
+		.address = address & huge_page_mask(h),
+		.real_address = address,
+		.flags = flags,
+		.pgoff = vma_hugecache_offset(h, vma,
+				address & huge_page_mask(h)),
+	};
 
-	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
-	if (ptep) {
+	vmf.pte = huge_pte_offset(mm, vmf.address, huge_page_size(h));
+	if (vmf.pte) {
 		/*
-		 * Since we hold no locks, ptep could be stale.  That is
+		 * Since we hold no locks, vmf.pte could be stale.  That is
 		 * OK as we are only making decisions based on content and
 		 * not actually modifying content here.
 		 */
-		entry = huge_ptep_get(ptep);
-		if (unlikely(is_hugetlb_entry_migration(entry))) {
-			migration_entry_wait_huge(vma, ptep);
+		vmf.orig_pte = huge_ptep_get(vmf.pte);
+		if (unlikely(is_hugetlb_entry_migration(vmf.orig_pte))) {
+			migration_entry_wait_huge(vma, vmf.pte);
 			return 0;
-		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
+		} else if (unlikely(is_hugetlb_entry_hwpoisoned(vmf.orig_pte)))
 			return VM_FAULT_HWPOISON_LARGE |
 				VM_FAULT_SET_HINDEX(hstate_index(h));
 	}
@@ -6101,47 +6107,45 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * the same page in the page cache.
 	 */
 	mapping = vma->vm_file->f_mapping;
-	idx = vma_hugecache_offset(h, vma, haddr);
-	hash = hugetlb_fault_mutex_hash(mapping, idx);
+	hash = hugetlb_fault_mutex_hash(mapping, vmf.pgoff);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 	/*
 	 * Acquire vma lock before calling huge_pte_alloc and hold
-	 * until finished with ptep.  This prevents huge_pmd_unshare from
-	 * being called elsewhere and making the ptep no longer valid.
+	 * until finished with vmf.pte.  This prevents huge_pmd_unshare from
+	 * being called elsewhere and making the vmf.pte no longer valid.
 	 *
-	 * ptep could have already be assigned via huge_pte_offset.  That
+	 * vmf.pte could have already be assigned via huge_pte_offset.  That
 	 * is OK, as huge_pte_alloc will return the same value unless
 	 * something has changed.
 	 */
 	hugetlb_vma_lock_read(vma);
-	ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
-	if (!ptep) {
+	vmf.pte = huge_pte_alloc(mm, vma, vmf.address, huge_page_size(h));
+	if (!vmf.pte) {
 		hugetlb_vma_unlock_read(vma);
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		return VM_FAULT_OOM;
 	}
 
-	entry = huge_ptep_get(ptep);
+	vmf.orig_pte = huge_ptep_get(vmf.pte);
 	/* PTE markers should be handled the same way as none pte */
-	if (huge_pte_none_mostly(entry))
+	if (huge_pte_none_mostly(vmf.orig_pte))
 		/*
 		 * hugetlb_no_page will drop vma lock and hugetlb fault
 		 * mutex internally, which make us return immediately.
 		 */
-		return hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
-				      entry, flags);
+		return hugetlb_no_page(mapping, &vmf);
 
 	ret = 0;
 
 	/*
-	 * entry could be a migration/hwpoison entry at this point, so this
-	 * check prevents the kernel from going below assuming that we have
-	 * an active hugepage in pagecache. This goto expects the 2nd page
-	 * fault, and is_hugetlb_entry_(migration|hwpoisoned) check will
-	 * properly handle it.
+	 * vmf.orig_pte could be a migration/hwpoison entry at this point, so
+	 * this check prevents the kernel from going below assuming that we
+	 * have an active hugepage in pagecache. This goto expects the 2nd page
+	 * fault, and is_hugetlb_entry_(migration|hwpoisoned) check will properly
+	 * handle it.
 	 */
-	if (!pte_present(entry))
+	if (!pte_present(vmf.orig_pte))
 		goto out_mutex;
 
 	/*
@@ -6152,34 +6156,28 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * determine if a reservation has been consumed.
 	 */
 	if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
-	    !(vma->vm_flags & VM_MAYSHARE) && !huge_pte_write(entry)) {
-		if (vma_needs_reservation(h, vma, haddr) < 0) {
+	    !(vma->vm_flags & VM_MAYSHARE) &&
+	    !huge_pte_write(vmf.orig_pte)) {
+		if (vma_needs_reservation(h, vma, vmf.address) < 0) {
 			ret = VM_FAULT_OOM;
 			goto out_mutex;
 		}
 		/* Just decrements count, does not deallocate */
-		vma_end_reservation(h, vma, haddr);
+		vma_end_reservation(h, vma, vmf.address);
 
-		pagecache_page = find_lock_page(mapping, idx);
+		pagecache_page = find_lock_page(mapping, vmf.pgoff);
 	}
 
-	ptl = huge_pte_lock(h, mm, ptep);
+	vmf.ptl = huge_pte_lock(h, mm, vmf.pte);
 
 	/* Check for a racing update before calling hugetlb_wp() */
-	if (unlikely(!pte_same(entry, huge_ptep_get(ptep))))
+	if (unlikely(!pte_same(vmf.orig_pte, huge_ptep_get(vmf.pte))))
 		goto out_ptl;
 
 	/* Handle userfault-wp first, before trying to lock more pages */
-	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(ptep)) &&
-	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
-		struct vm_fault vmf = {
-			.vma = vma,
-			.address = haddr,
-			.real_address = address,
-			.flags = flags,
-		};
-
-		spin_unlock(ptl);
+	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(vmf.pte)) &&
+	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(vmf.orig_pte)) {
+		spin_unlock(vmf.ptl);
 		if (pagecache_page) {
 			unlock_page(pagecache_page);
 			put_page(pagecache_page);
@@ -6190,11 +6188,11 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 
 	/*
-	 * hugetlb_wp() requires page locks of pte_page(entry) and
+	 * hugetlb_wp() requires page locks of pte_page(vmf.orig_pte) and
 	 * pagecache_page, so here we need take the former one
 	 * when page != pagecache_page or !pagecache_page.
 	 */
-	page = pte_page(entry);
+	page = pte_page(vmf.orig_pte);
 	if (page != pagecache_page)
 		if (!trylock_page(page)) {
 			need_wait_lock = 1;
@@ -6204,24 +6202,24 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	get_page(page);
 
 	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
-		if (!huge_pte_write(entry)) {
-			ret = hugetlb_wp(mm, vma, address, ptep, flags,
-					 pagecache_page, ptl);
+		if (!huge_pte_write(vmf.orig_pte)) {
+			ret = hugetlb_wp(mm, vma, address, vmf.pte, flags,
+					 pagecache_page, vmf.ptl);
 			goto out_put_page;
 		} else if (likely(flags & FAULT_FLAG_WRITE)) {
-			entry = huge_pte_mkdirty(entry);
+			vmf.orig_pte = huge_pte_mkdirty(vmf.orig_pte);
 		}
 	}
-	entry = pte_mkyoung(entry);
-	if (huge_ptep_set_access_flags(vma, haddr, ptep, entry,
-						flags & FAULT_FLAG_WRITE))
-		update_mmu_cache(vma, haddr, ptep);
+	vmf.orig_pte = pte_mkyoung(vmf.orig_pte);
+	if (huge_ptep_set_access_flags(vma, vmf.address, vmf.pte, vmf.orig_pte,
+				       flags & FAULT_FLAG_WRITE))
+		update_mmu_cache(vma, vmf.address, vmf.pte);
 out_put_page:
 	if (page != pagecache_page)
 		unlock_page(page);
 	put_page(page);
 out_ptl:
-	spin_unlock(ptl);
+	spin_unlock(vmf.ptl);
 
 	if (pagecache_page) {
 		unlock_page(pagecache_page);
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 93e13fc17d3cb..db442094ee8de 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -75,33 +75,34 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw)
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
 
 		pfn = swp_offset_pfn(entry);
-	} else if (is_swap_pte(*pvmw->pte)) {
+	} else if (is_swap_pte(ptent)) {
 		swp_entry_t entry;
 
 		/* Handle un-addressable ZONE_DEVICE memory */
-		entry = pte_to_swp_entry(*pvmw->pte);
+		entry = pte_to_swp_entry(ptent);
 		if (!is_device_private_entry(entry) &&
 		    !is_device_exclusive_entry(entry))
 			return false;
 
 		pfn = swp_offset_pfn(entry);
 	} else {
-		if (!pte_present(*pvmw->pte))
+		if (!pte_present(ptent))
 			return false;
 
-		pfn = pte_pfn(*pvmw->pte);
+		pfn = pte_pfn(ptent);
 	}
 
 	return (pfn - pvmw->pfn) < pvmw->nr_pages;
-- 
2.53.0

