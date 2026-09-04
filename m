Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C51F399001
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535666; cv=none; b=PWinJ2yvCXzPMzyV31pZ41JUhSLY51dyOBm5N5hs3RMoDieo9Nw8OZufKxqlPBOL0DZip7Ql/AHZOA+dBOm9kwioVY+MJAEUUXF66YT1PqxPgRDUtf/fBDoWlDhXEG/eHD5n341U6bLuRKhnKEDV5dicZWhkodJTYkCm9aVPRZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535666; c=relaxed/simple;
	bh=AhR6EkPrNMFk8cKu/YtjpYkwxElNANVv9yJTf3WQ4wM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUoI72Hm2qb2kUIRUJeDAixVupou8c3PHng+P3jkQ0G3Kq/djhEeWX/UtD616Ypi0XsLjchaWapgzPvhMFDH/aT3vnOH6lvcbgIulwcxarwPTjWe4LWpmd3G57URzNJJNn3abo7QhePvWgeEsxpztlT/yjHxA7Xcy0FeNPGqznI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUOMO6Ok; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUOMO6Ok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4A41F00A3F;
	Fri,  4 Sep 2026 15:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788535664;
	bh=jKyVF4dGSjpu9G/+NKun8tIwsK57UZiN6s6wsjJiEgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LUOMO6OkUYDQmFtTwXj419lmTPS+C8IzCGFU0891Jg/Ih5h4g0Ru2WE+g9ko4kxpB
	 hhXXNCvWSNRIJcen16PSHeUYcoFMxqT8/9udS/UBXmA/fvuKKdndIFWn+uIXjEAxhB
	 WwurtkszwLhUYqef8k2uJvumCspVq7UTmTS+ZTuYb8VTraNlvUnRW0+msaB3vNAw42
	 rm15TRjjwX0zEWwqG7W+Bh4RwUtckvhiWPPgW0J0ehII6JpKHM3uTVFsCPZMpRX0hP
	 lVBwe/2yHGpKhyxU2khRt4jSgsWCXUBCwomMf0qQVHQpNemtwDGTA1kPYNZHJKVg7R
	 uGvkQQziGX9xg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] hugetlb: convert hugetlb_wp() to use struct vm_fault
Date: Fri,  4 Sep 2026 11:27:38 -0400
Message-ID: <20260904152741.898549-2-sashal@kernel.org>
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

From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>

[ Upstream commit bd722058e34de4857bc554e786b7f41c747ad894 ]

hugetlb_wp() can use the struct vm_fault passed in from hugetlb_fault().
This alleviates the stack by consolidating 5 variables into a single
struct.

[vishal.moola@gmail.com: simplify hugetlb_wp() arguments]
  Link: https://lkml.kernel.org/r/ZhQtoFNZBNwBCeXn@fedora
Link: https://lkml.kernel.org/r/20240401202651.31440-4-vishal.moola@gmail.com
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: e87df0d5d696 ("mm/page_vma_mapped: use huge_ptep_get() for hugetlb")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 68 ++++++++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 92c16b4af612d..cd93d3b0a433d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5538,21 +5538,21 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
  * cannot race with other handlers or page migration.
  * Keep the pte_same checks anyway to make transition from the mutex easier.
  */
-static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
-		       unsigned long address, pte_t *ptep, unsigned int flags,
-		       struct page *pagecache_page, spinlock_t *ptl)
+static vm_fault_t hugetlb_wp(struct page *pagecache_page,
+		       struct vm_fault *vmf)
 {
-	const bool unshare = flags & FAULT_FLAG_UNSHARE;
-	pte_t pte = huge_ptep_get(ptep);
+	struct vm_area_struct *vma = vmf->vma;
+	struct mm_struct *mm = vma->vm_mm;
+	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
+	pte_t pte = huge_ptep_get(vmf->pte);
 	struct hstate *h = hstate_vma(vma);
 	struct page *old_page, *new_page;
 	int outside_reserve = 0;
 	vm_fault_t ret = 0;
-	unsigned long haddr = address & huge_page_mask(h);
 	struct mmu_notifier_range range;
 
-	VM_BUG_ON(unshare && (flags & FOLL_WRITE));
-	VM_BUG_ON(!unshare && !(flags & FOLL_WRITE));
+	VM_BUG_ON(unshare && (vmf->flags & FOLL_WRITE));
+	VM_BUG_ON(!unshare && !(vmf->flags & FOLL_WRITE));
 
 	/*
 	 * Never handle CoW for uffd-wp protected pages.  It should be only
@@ -5576,7 +5576,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (vma->vm_flags & VM_MAYSHARE) {
 		if (unlikely(unshare))
 			return 0;
-		set_huge_ptep_writable(vma, haddr, ptep);
+		set_huge_ptep_writable(vma, vmf->address, vmf->pte);
 		return 0;
 	}
 
@@ -5593,7 +5593,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		if (!PageAnonExclusive(old_page))
 			page_move_anon_rmap(old_page, vma);
 		if (likely(!unshare))
-			set_huge_ptep_writable(vma, haddr, ptep);
+			set_huge_ptep_writable(vma, vmf->address, vmf->pte);
 
 		delayacct_wpcopy_end();
 		return 0;
@@ -5620,8 +5620,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * Drop page table lock as buddy allocator may be called. It will
 	 * be acquired again before returning to the caller, as expected.
 	 */
-	spin_unlock(ptl);
-	new_page = alloc_huge_page(vma, haddr, outside_reserve);
+	spin_unlock(vmf->ptl);
+	new_page = alloc_huge_page(vma, vmf->address, outside_reserve);
 
 	if (IS_ERR(new_page)) {
 		/*
@@ -5646,19 +5646,20 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 			 *
 			 * Reacquire both after unmap operation.
 			 */
-			idx = vma_hugecache_offset(h, vma, haddr);
+			idx = vma_hugecache_offset(h, vma, vmf->address);
 			hash = hugetlb_fault_mutex_hash(mapping, idx);
 			hugetlb_vma_unlock_read(vma);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 
-			unmap_ref_private(mm, vma, old_page, haddr);
+			unmap_ref_private(mm, vma, old_page, vmf->address);
 
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 			hugetlb_vma_lock_read(vma);
-			spin_lock(ptl);
-			ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
-			if (likely(ptep &&
-				   pte_same(huge_ptep_get(ptep), pte)))
+			spin_lock(vmf->ptl);
+			vmf->pte = huge_pte_offset(mm, vmf->address,
+						    huge_page_size(h));
+			if (likely(vmf->pte &&
+				   pte_same(huge_ptep_get(vmf->pte), pte)))
 				goto retry_avoidcopy;
 			/*
 			 * race occurs while re-acquiring page table
@@ -5681,35 +5682,36 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		goto out_release_all;
 	}
 
-	copy_user_huge_page(new_page, old_page, address, vma,
+	copy_user_huge_page(new_page, old_page, vmf->real_address, vma,
 			    pages_per_huge_page(h));
 	__SetPageUptodate(new_page);
 
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, haddr,
-				haddr + huge_page_size(h));
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
+				vmf->address,
+				vmf->address + huge_page_size(h));
 	mmu_notifier_invalidate_range_start(&range);
 
 	/*
 	 * Retake the page table lock to check for racing updates
 	 * before the page tables are altered
 	 */
-	spin_lock(ptl);
-	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
-	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
+	spin_lock(vmf->ptl);
+	vmf->pte = huge_pte_offset(mm, vmf->address, huge_page_size(h));
+	if (likely(vmf->pte && pte_same(huge_ptep_get(vmf->pte), pte))) {
 		ClearHPageRestoreReserve(new_page);
 
 		/* Break COW or unshare */
-		huge_ptep_clear_flush(vma, haddr, ptep);
+		huge_ptep_clear_flush(vma, vmf->address, vmf->pte);
 		mmu_notifier_invalidate_range(mm, range.start, range.end);
 		page_remove_rmap(old_page, vma, true);
-		hugepage_add_new_anon_rmap(new_page, vma, haddr);
-		set_huge_pte_at(mm, haddr, ptep,
+		hugepage_add_new_anon_rmap(new_page, vma, vmf->address);
+		set_huge_pte_at(mm, vmf->address, vmf->pte,
 				make_huge_pte(vma, new_page, !unshare));
 		SetHPageMigratable(new_page);
 		/* Make the old page be freed below */
 		new_page = old_page;
 	}
-	spin_unlock(ptl);
+	spin_unlock(vmf->ptl);
 	mmu_notifier_invalidate_range_end(&range);
 out_release_all:
 	/*
@@ -5717,12 +5719,12 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * unshare)
 	 */
 	if (new_page != old_page)
-		restore_reserve_on_error(h, vma, haddr, new_page);
+		restore_reserve_on_error(h, vma, vmf->address, new_page);
 	put_page(new_page);
 out_release_old:
 	put_page(old_page);
 
-	spin_lock(ptl); /* Caller expects lock to be held */
+	spin_lock(vmf->ptl); /* Caller expects lock to be held */
 
 	delayacct_wpcopy_end();
 	return ret;
@@ -6011,8 +6013,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	hugetlb_count_add(pages_per_huge_page(h), mm);
 	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
 		/* Optimization, do the COW without a second fault */
-		ret = hugetlb_wp(mm, vma, vmf->real_address, vmf->pte,
-				 vmf->flags, page, vmf->ptl);
+		ret = hugetlb_wp(page, vmf);
 	}
 
 	spin_unlock(vmf->ptl);
@@ -6203,8 +6204,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
 		if (!huge_pte_write(vmf.orig_pte)) {
-			ret = hugetlb_wp(mm, vma, address, vmf.pte, flags,
-					 pagecache_page, vmf.ptl);
+			ret = hugetlb_wp(pagecache_page, &vmf);
 			goto out_put_page;
 		} else if (likely(flags & FAULT_FLAG_WRITE)) {
 			vmf.orig_pte = huge_pte_mkdirty(vmf.orig_pte);
-- 
2.53.0

