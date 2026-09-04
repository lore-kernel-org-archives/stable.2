Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5481235200F
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527898; cv=none; b=uuJ/O9iCNREs0Gzwd23g5pr7fqeY4x4aU9PNpXZBU//lEG/W1BYRxD0EMibx+T50F+OuRalNzSz1Hi8P4l5rtTkHRKZdU4ZbOwz98XENH+IZaAgppevpu7RKALF8/nUSOhmiqVkkOHCwa08T8UTA0ZEKosJbJBvNJOFOWdRpzN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527898; c=relaxed/simple;
	bh=BrzrKBonsSlpSC7jKFOgDoULb2fqECDwBP0HkshJ51k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXx3BG5mUAYFmAw8u8FEcSeCD4EZSgn5IP1AB9kmp6pzt21JfXX8OruHQsZPZyoT731/nxSdY0pntIud10AzMu1R2j+938uRMiq8/vp5ygxOfKcivkqTDm039TRnBRYIX7KPObMNsebRTRBgUw0XWCECQl8oSHOGWdKPD/zfTgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwmhGcbq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwmhGcbq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C2D1F00A3D;
	Fri,  4 Sep 2026 13:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788527892;
	bh=QG79VwbXwSxObxJmrSOSlnB4yprIEH1UmHzCpv5v4g8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VwmhGcbqiTR9lGroBmnXIZuUTDniyuOfURyPiT544XC86VkYVU/jxhGaR5GWWNqCi
	 831FnLF4n1dxxySWbTBxEfwvjtk9n8+cy6Amfz5HM9AI1tgWB4upe2/jT1Y7J4TBRZ
	 aLVap4qiU7bs8AbVPeWmVA5p/PBPRLFIhkYrG0CrYMJ9KmPs4YraWfJt7M4OJvHNrt
	 fX5s6KP8RPI/PisySX/IJe2v5gQmOUCKhfYiVbPdmbe2btnN/JwlOcop0/gS26t5Sn
	 ItCS2ZN1GA4rzFZUPL5gDkdbAqJUEftOcUsBzkqQMwCXwHpsLVYP0019ILQTqpDGev
	 RJkZAunq7jJKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Muchun Song <muchun.song@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/6] hugetlb: convert hugetlb_fault() to use struct vm_fault
Date: Fri,  4 Sep 2026 09:18:04 -0400
Message-ID: <20260904131809.503371-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090314-mumps-septum-7049@gregkh>
References: <2026090314-mumps-septum-7049@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>

[ Upstream commit 9b42fa16195fb471bf3b7849803c0a7d3e7620f2 ]

Patch series "Hugetlb fault path to use struct vm_fault", v2.

This patchset converts the hugetlb fault path to use struct vm_fault.
This helps make the code more readable, and alleviates the stack by
allowing us to consolidate many fault-related variables into an individual
pointer.

This patch (of 3):

Now that hugetlb_fault() has a vm_fault available for fault tracking, use
it throughout.  This cleans up the code by removing 2 variables, and
prepares hugetlb_fault() to take in a struct vm_fault argument.

Link: https://lkml.kernel.org/r/20240401202651.31440-1-vishal.moola@gmail.com
Link: https://lkml.kernel.org/r/20240401202651.31440-2-vishal.moola@gmail.com
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: e87df0d5d696 ("mm/page_vma_mapped: use huge_ptep_get() for hugetlb")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 104 ++++++++++++++++++++++++++-------------------------
 1 file changed, 53 insertions(+), 51 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index edae641407b96..27322ffd140c3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6085,17 +6085,27 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx)
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags)
 {
-	pte_t *ptep, entry;
-	spinlock_t *ptl;
 	vm_fault_t ret;
 	u32 hash;
-	pgoff_t idx;
 	struct folio *folio = NULL;
 	struct folio *pagecache_folio = NULL;
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
+		/* TODO: Track hugetlb faults using vm_fault */
+
+		/*
+		 * Some fields may not be initialized, be careful as it may
+		 * be hard to debug if called functions make assumptions
+		 */
+	};
 
 	/* TODO: Handle faults under the VMA lock */
 	if (flags & FAULT_FLAG_VMA_LOCK) {
@@ -6109,28 +6119,27 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
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
-	if (huge_pte_none_mostly(entry)) {
-		if (is_pte_marker(entry)) {
+	vmf.orig_pte = huge_ptep_get(vmf.pte);
+	if (huge_pte_none_mostly(vmf.orig_pte)) {
+		if (is_pte_marker(vmf.orig_pte)) {
 			pte_marker marker =
-				pte_marker_get(pte_to_swp_entry(entry));
+				pte_marker_get(pte_to_swp_entry(vmf.orig_pte));
 
 			if (marker & PTE_MARKER_POISONED) {
 				ret = VM_FAULT_HWPOISON_LARGE;
@@ -6144,21 +6153,21 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * hugetlb_no_page will drop vma lock and hugetlb fault
 		 * mutex internally, which make us return immediately.
 		 */
-		return hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
-				      entry, flags);
+		return hugetlb_no_page(mm, vma, mapping, vmf.pgoff, address,
+				       vmf.pte, vmf.orig_pte, flags);
 	}
 
 	ret = 0;
 
 	/*
-	 * entry could be a migration/hwpoison entry at this point, so this
-	 * check prevents the kernel from going below assuming that we have
-	 * an active hugepage in pagecache. This goto expects the 2nd page
-	 * fault, and is_hugetlb_entry_(migration|hwpoisoned) check will
-	 * properly handle it.
+	 * vmf.orig_pte could be a migration/hwpoison vmf.orig_pte at this
+	 * point, so this check prevents the kernel from going below assuming
+	 * that we have an active hugepage in pagecache. This goto expects
+	 * the 2nd page fault, and is_hugetlb_entry_(migration|hwpoisoned)
+	 * check will properly handle it.
 	 */
-	if (!pte_present(entry)) {
-		if (unlikely(is_hugetlb_entry_migration(entry))) {
+	if (!pte_present(vmf.orig_pte)) {
+		if (unlikely(is_hugetlb_entry_migration(vmf.orig_pte))) {
 			/*
 			 * Release the hugetlb fault lock now, but retain
 			 * the vma lock, because it is needed to guard the
@@ -6167,9 +6176,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			 * be released there.
 			 */
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			migration_entry_wait_huge(vma, ptep);
+			migration_entry_wait_huge(vma, vmf.pte);
 			return 0;
-		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
+		} else if (unlikely(is_hugetlb_entry_hwpoisoned(vmf.orig_pte)))
 			ret = VM_FAULT_HWPOISON_LARGE |
 			    VM_FAULT_SET_HINDEX(hstate_index(h));
 		goto out_mutex;
@@ -6183,36 +6192,29 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * determine if a reservation has been consumed.
 	 */
 	if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
-	    !(vma->vm_flags & VM_MAYSHARE) && !huge_pte_write(entry)) {
-		if (vma_needs_reservation(h, vma, haddr) < 0) {
+	    !(vma->vm_flags & VM_MAYSHARE) && !huge_pte_write(vmf.orig_pte)) {
+		if (vma_needs_reservation(h, vma, vmf.address) < 0) {
 			ret = VM_FAULT_OOM;
 			goto out_mutex;
 		}
 		/* Just decrements count, does not deallocate */
-		vma_end_reservation(h, vma, haddr);
+		vma_end_reservation(h, vma, vmf.address);
 
-		pagecache_folio = filemap_lock_folio(mapping, idx);
+		pagecache_folio = filemap_lock_folio(mapping, vmf.pgoff);
 		if (IS_ERR(pagecache_folio))
 			pagecache_folio = NULL;
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
 		if (pagecache_folio) {
 			folio_unlock(pagecache_folio);
 			folio_put(pagecache_folio);
@@ -6223,11 +6225,11 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 
 	/*
-	 * hugetlb_wp() requires page locks of pte_page(entry) and
+	 * hugetlb_wp() requires page locks of pte_page(vmf.orig_pte) and
 	 * pagecache_folio, so here we need take the former one
 	 * when folio != pagecache_folio or !pagecache_folio.
 	 */
-	folio = page_folio(pte_page(entry));
+	folio = page_folio(pte_page(vmf.orig_pte));
 	if (folio != pagecache_folio)
 		if (!folio_trylock(folio)) {
 			need_wait_lock = 1;
@@ -6237,24 +6239,24 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	folio_get(folio);
 
 	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
-		if (!huge_pte_write(entry)) {
-			ret = hugetlb_wp(mm, vma, address, ptep, flags,
-					 pagecache_folio, ptl);
+		if (!huge_pte_write(vmf.orig_pte)) {
+			ret = hugetlb_wp(mm, vma, address, vmf.pte, flags,
+					 pagecache_folio, vmf.ptl);
 			goto out_put_page;
 		} else if (likely(flags & FAULT_FLAG_WRITE)) {
-			entry = huge_pte_mkdirty(entry);
+			vmf.orig_pte = huge_pte_mkdirty(vmf.orig_pte);
 		}
 	}
-	entry = pte_mkyoung(entry);
-	if (huge_ptep_set_access_flags(vma, haddr, ptep, entry,
+	vmf.orig_pte = pte_mkyoung(vmf.orig_pte);
+	if (huge_ptep_set_access_flags(vma, vmf.address, vmf.pte, vmf.orig_pte,
 						flags & FAULT_FLAG_WRITE))
-		update_mmu_cache(vma, haddr, ptep);
+		update_mmu_cache(vma, vmf.address, vmf.pte);
 out_put_page:
 	if (folio != pagecache_folio)
 		folio_unlock(folio);
 	folio_put(folio);
 out_ptl:
-	spin_unlock(ptl);
+	spin_unlock(vmf.ptl);
 
 	if (pagecache_folio) {
 		folio_unlock(pagecache_folio);
-- 
2.53.0

