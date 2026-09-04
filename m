Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEAC3537FB
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527899; cv=none; b=qdp/3DaroEl0OBN0panRiQSZDzipo9zmhVaFHCu3ZLYmkvF/6/k13ixXyNONVUNo4lc4MZeG4jnaZnrU1g4VpicDApjd553EjmvFA2WBgVP5yrfWOhByw0bSSkkABdkOwupYYp1tgizUjYke2HyFufmYy6AK7SfszTE7/IML4W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527899; c=relaxed/simple;
	bh=YbUMkZUBwGeCT1r3KFxf3rMkd8Zto7/aTC3CD1SFDQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/uTbWD8RnKOMcQqLPFbeHW1Atnqoo78eyVc9bIcz8YEbbemMBL8R27Hpa7serDzEQTWhSMCwp3EponsdFO5hwRGk5d7Ed8L/9nqtLLZJJPe9kY2SHp/dp3ubbtJpn5mvzwnVDxyt0ec+Xw6pKvP+Cdp8+pg24byqKtxfD64UQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRVpG+7m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRVpG+7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1231F00A3F;
	Fri,  4 Sep 2026 13:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788527894;
	bh=bxuM8/MHbuTZO1Qu0wEHqkb39aVANKDgTYnt52w4BbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YRVpG+7mvNQwQVDMn7Cm7uSFjUuydj0QTwph7BRjWfga7olugGe+CFPjFmlLNCxdD
	 GwDtcG/jgyw2Qth0TXZ9U7wbAX02Jagw8eSi57wET5Y3Aw2lPp32BvRISXNxPPgm3x
	 SPNsjqBtImvCRML7f/19YU6mo7An53i4C2znx1lkv/zwDFcIV4G5deMG5fIzBkYWYx
	 eTCKfW/VVNrkk4Gdt4M+mf5l6RRcrBx+jv12kE2Rd890aHALYHxPRgOQ7BiIxNjLGs
	 WIXcrXHWh0GrRL8Wlg12Dbidpw33ZNKZF5vYbsYVgWaxiR/g0+MvW4Y4nu9A9XzlN9
	 30847PWqszG8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/6] hugetlb: convert hugetlb_wp() to use struct vm_fault
Date: Fri,  4 Sep 2026 09:18:06 -0400
Message-ID: <20260904131809.503371-3-sashal@kernel.org>
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
 mm/hugetlb.c | 65 ++++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a9757b11b7c49..271f42eb53ac9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5563,18 +5563,18 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
  * cannot race with other handlers or page migration.
  * Keep the pte_same checks anyway to make transition from the mutex easier.
  */
-static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
-		       unsigned long address, pte_t *ptep, unsigned int flags,
-		       struct folio *pagecache_folio, spinlock_t *ptl)
+static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
+		       struct vm_fault *vmf)
 {
-	const bool unshare = flags & FAULT_FLAG_UNSHARE;
-	pte_t pte = huge_ptep_get(ptep);
+	struct vm_area_struct *vma = vmf->vma;
+	struct mm_struct *mm = vma->vm_mm;
+	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
+	pte_t pte = huge_ptep_get(vmf->pte);
 	struct hstate *h = hstate_vma(vma);
 	struct folio *old_folio;
 	struct folio *new_folio;
 	int outside_reserve = 0;
 	vm_fault_t ret = 0;
-	unsigned long haddr = address & huge_page_mask(h);
 	struct mmu_notifier_range range;
 
 	/*
@@ -5597,7 +5597,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	/* Let's take out MAP_SHARED mappings first. */
 	if (vma->vm_flags & VM_MAYSHARE) {
-		set_huge_ptep_writable(vma, haddr, ptep);
+		set_huge_ptep_writable(vma, vmf->address, vmf->pte);
 		return 0;
 	}
 
@@ -5614,7 +5614,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		if (!PageAnonExclusive(&old_folio->page))
 			page_move_anon_rmap(&old_folio->page, vma);
 		if (likely(!unshare))
-			set_huge_ptep_writable(vma, haddr, ptep);
+			set_huge_ptep_writable(vma, vmf->address, vmf->pte);
 
 		delayacct_wpcopy_end();
 		return 0;
@@ -5641,8 +5641,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * Drop page table lock as buddy allocator may be called. It will
 	 * be acquired again before returning to the caller, as expected.
 	 */
-	spin_unlock(ptl);
-	new_folio = alloc_hugetlb_folio(vma, haddr, outside_reserve);
+	spin_unlock(vmf->ptl);
+	new_folio = alloc_hugetlb_folio(vma, vmf->address, outside_reserve);
 
 	if (IS_ERR(new_folio)) {
 		/*
@@ -5667,19 +5667,21 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 			 *
 			 * Reacquire both after unmap operation.
 			 */
-			idx = vma_hugecache_offset(h, vma, haddr);
+			idx = vma_hugecache_offset(h, vma, vmf->address);
 			hash = hugetlb_fault_mutex_hash(mapping, idx);
 			hugetlb_vma_unlock_read(vma);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 
-			unmap_ref_private(mm, vma, &old_folio->page, haddr);
+			unmap_ref_private(mm, vma, &old_folio->page,
+					vmf->address);
 
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 			hugetlb_vma_lock_read(vma);
-			spin_lock(ptl);
-			ptep = hugetlb_walk(vma, haddr, huge_page_size(h));
-			if (likely(ptep &&
-				   pte_same(huge_ptep_get(ptep), pte)))
+			spin_lock(vmf->ptl);
+			vmf->pte = hugetlb_walk(vma, vmf->address,
+					huge_page_size(h));
+			if (likely(vmf->pte &&
+				   pte_same(huge_ptep_get(vmf->pte), pte)))
 				goto retry_avoidcopy;
 			/*
 			 * race occurs while re-acquiring page table
@@ -5702,37 +5704,38 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		goto out_release_all;
 	}
 
-	if (copy_user_large_folio(new_folio, old_folio, address, vma)) {
+	if (copy_user_large_folio(new_folio, old_folio, vmf->real_address, vma)) {
 		ret = VM_FAULT_HWPOISON_LARGE;
 		goto out_release_all;
 	}
 	__folio_mark_uptodate(new_folio);
 
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, haddr,
-				haddr + huge_page_size(h));
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, vmf->address,
+				vmf->address + huge_page_size(h));
 	mmu_notifier_invalidate_range_start(&range);
 
 	/*
 	 * Retake the page table lock to check for racing updates
 	 * before the page tables are altered
 	 */
-	spin_lock(ptl);
-	ptep = hugetlb_walk(vma, haddr, huge_page_size(h));
-	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
+	spin_lock(vmf->ptl);
+	vmf->pte = hugetlb_walk(vma, vmf->address, huge_page_size(h));
+	if (likely(vmf->pte && pte_same(huge_ptep_get(vmf->pte), pte))) {
 		pte_t newpte = make_huge_pte(vma, &new_folio->page, !unshare);
 
 		/* Break COW or unshare */
-		huge_ptep_clear_flush(vma, haddr, ptep);
+		huge_ptep_clear_flush(vma, vmf->address, vmf->pte);
 		page_remove_rmap(&old_folio->page, vma, true);
-		hugepage_add_new_anon_rmap(new_folio, vma, haddr);
+		hugepage_add_new_anon_rmap(new_folio, vma, vmf->address);
 		if (huge_pte_uffd_wp(pte))
 			newpte = huge_pte_mkuffd_wp(newpte);
-		set_huge_pte_at(mm, haddr, ptep, newpte, huge_page_size(h));
+		set_huge_pte_at(mm, vmf->address, vmf->pte, newpte,
+				huge_page_size(h));
 		folio_set_hugetlb_migratable(new_folio);
 		/* Make the old page be freed below */
 		new_folio = old_folio;
 	}
-	spin_unlock(ptl);
+	spin_unlock(vmf->ptl);
 	mmu_notifier_invalidate_range_end(&range);
 out_release_all:
 	/*
@@ -5740,12 +5743,12 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * unshare)
 	 */
 	if (new_folio != old_folio)
-		restore_reserve_on_error(h, vma, haddr, new_folio);
+		restore_reserve_on_error(h, vma, vmf->address, new_folio);
 	folio_put(new_folio);
 out_release_old:
 	folio_put(old_folio);
 
-	spin_lock(ptl); /* Caller expects lock to be held */
+	spin_lock(vmf->ptl); /* Caller expects lock to be held */
 
 	delayacct_wpcopy_end();
 	return ret;
@@ -6030,8 +6033,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	hugetlb_count_add(pages_per_huge_page(h), mm);
 	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
 		/* Optimization, do the COW without a second fault */
-		ret = hugetlb_wp(mm, vma, vmf->real_address, vmf->pte,
-				vmf->flags, folio, vmf->ptl);
+		ret = hugetlb_wp(folio, vmf);
 	}
 
 	spin_unlock(vmf->ptl);
@@ -6242,8 +6244,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
 		if (!huge_pte_write(vmf.orig_pte)) {
-			ret = hugetlb_wp(mm, vma, address, vmf.pte, flags,
-					 pagecache_folio, vmf.ptl);
+			ret = hugetlb_wp(pagecache_folio, &vmf);
 			goto out_put_page;
 		} else if (likely(flags & FAULT_FLAG_WRITE)) {
 			vmf.orig_pte = huge_pte_mkdirty(vmf.orig_pte);
-- 
2.53.0

