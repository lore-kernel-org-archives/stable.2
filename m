Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807915;
	b=04wtUdyXg4Zj789KjeHgijd0vLBNQsNJkLS3idp9KNMCHzZa8VEU6PlbSHNZ/Vguizx8
	 VVD85q77Sm48YINpZRkt5tzFAXZshcF5mt7eEo6+84jjwmUy0pLydayvd5g+Xd98QJPSV
	 uPj7NH8IYdEX+a1bkfs0sVwRQMLKRC3Wfu0UF6u1enpx07ic3ihVFOy6u+Z/dv71xXvI/
	 hpQIJMGDAnYKQleWg62eXxcCWfpubAidZUMDiLJ6TPvcFqqHUyuGSSdRNe2TOz/87y7QB
	 q1csYu3xKujnaGoiMZYzyhYril1b6B5r80nRJHhhAlZ8D8SNFQsmzvmZMGSaua12qpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807915;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=P30DDjg7bH526+hJDmjJPo/XeXkLPxWiQeBty+u3At0=;
	b=RYm+E0uuna1/NLSbJb0iTRM5s616ybpwg35eLyYtOyL+xjVNCozMbO0IgILKrui+R1CI
	 oasPvG/PoqpAeYrPY2crBaed2JycIegE8Vhr/7cjWL5S+3tL8Hfk1vGOVmLkd46JJmlpi
	 cw08nuFdu/Eja0ACT5wnFsg0FBjx0Q7gIiNvuXeVo+iNZ/0qwfx1aqsg6Ke8LuQ+D4SGZ
	 cAXiw26VFWeDS9hMikLej5Vh9dOGKDaSFejC13D2rRq9h1Ewf/sooKfLuvGJoYdUgH/BP
	 NAc3/V36CMstr7MoPPL/025GgcriHfDcKRnm0FpTbGTpjovuC7Kq8wu4Spk/1CeeRwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d+X3dh1C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956BE606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d+X3dh1C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599961F0093A;
	Wed,  4 Nov 2026 15:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807915;
	bh=P30DDjg7bH526+hJDmjJPo/XeXkLPxWiQeBty+u3At0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d+X3dh1Cqx90UME92BZDx056wBAuHvsh2UXof3GHOz3gteKBkzlEe3fv+CtGMnojP
	 vtlqOD88B29ehQbm4csMedvwxTpPlr879WfZZ0y0fP9Oc0vJ1UU6qLJzAKJlsxntkg
	 fCDm2owvdscsEj/viSm8HgdDmfNgTLNZt1xw6Q5odFYkOLBxSCSvcI8hTIT0mcZcDN
	 sqPx1+n6z2XshbadLDMatXvVL3xPHZ+AySNbGYF7MCI8mE7DzhEMZ2eObTAGIoB777
	 rcd0z6ptT2Fbj/1fA9IF4IthPWEEFqJqg4x6xFcMMtGImyiz4XBqf7MwD2IPBtvXGX
	 4UrVRLUwoPS3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Xu <peterx@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Ackerley Tng <ackerleytng@google.com>,
	Breno Leitao <leitao@debian.org>,
	Muchun Song <muchun.song@linux.dev>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Rik van Riel <riel@surriel.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/5] mm/hugetlb: rename avoid_reserve to cow_from_owner
Date: Wed,  4 Nov 2026 10:58:28 -0500
Message-ID: <20261104155731.3920547-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104155731.3920547-1-sashal@kernel.org>
References: <2026110456-remix-oversold-9ee1@gregkh>
 <20261104155731.3920547-1-sashal@kernel.org>
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

From: Peter Xu <peterx@redhat.com>

[ Upstream commit 30cef82bc6e8975a360ec05b707f7fb194c875ed ]

The old name "avoid_reserve" can be too generic and can be used wrongly in
the new call sites that want to allocate a hugetlb folio.

It's confusing on two things: (1) whether one can opt-in to avoid global
reservation, and (2) whether it should take more than one count.

In reality, this flag is only used in an extremely hacky path, in an
extremely hacky way in hugetlb CoW path only, and always use with 1 saying
"skip global reservation".  Rename the flag to avoid future abuse of this
flag, making it a boolean so as to reflect its true representation that
it's not a counter.  To make it even harder to abuse, add a comment above
the function to explain it.

Link: https://lkml.kernel.org/r/20250107204002.2683356-4-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Ackerley Tng <ackerleytng@google.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 824cc56bf43c ("mm/hugetlb: fix use-after-free of a new anon folio")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hugetlbfs/inode.c    |  2 +-
 include/linux/hugetlb.h |  4 ++--
 mm/hugetlb.c            | 33 ++++++++++++++++++++-------------
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 734eb08bafc92..1a12932b58806 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -884,7 +884,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		 * folios in these areas, we need to consume the reserves
 		 * to keep reservation accounting consistent.
 		 */
-		folio = alloc_hugetlb_folio(&pseudo_vma, addr, 0);
+		folio = alloc_hugetlb_folio(&pseudo_vma, addr, false);
 		if (IS_ERR(folio)) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			error = PTR_ERR(folio);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 7eaabacdf1105..32cbaaaccfe54 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -691,7 +691,7 @@ struct huge_bootmem_page {
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
 void wait_for_freed_hugetlb_folios(void);
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
-				unsigned long addr, int avoid_reserve);
+				unsigned long addr, bool cow_from_owner);
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask,
 				bool allow_alloc_fallback);
@@ -1083,7 +1083,7 @@ static inline void wait_for_freed_hugetlb_folios(void)
 
 static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 					   unsigned long addr,
-					   int avoid_reserve)
+					   bool cow_from_owner)
 {
 	return NULL;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a1dc40a06eb0a..2805ddda5adeb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2991,8 +2991,15 @@ void wait_for_freed_hugetlb_folios(void)
 	flush_work(&free_hpage_work);
 }
 
+/*
+ * NOTE! "cow_from_owner" represents a very hacky usage only used in CoW
+ * faults of hugetlb private mappings on top of a non-page-cache folio (in
+ * which case even if there's a private vma resv map it won't cover such
+ * allocation).  New call sites should (probably) never set it to true!!
+ * When it's set, the allocation will bypass all vma level reservations.
+ */
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
-				    unsigned long addr, int avoid_reserve)
+				    unsigned long addr, bool cow_from_owner)
 {
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	struct hstate *h = hstate_vma(vma);
@@ -3034,7 +3041,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	 * Allocations for MAP_NORESERVE mappings also need to be
 	 * checked against any subpool limit.
 	 */
-	if (map_chg || avoid_reserve) {
+	if (map_chg || cow_from_owner) {
 		gbl_chg = hugepage_subpool_get_pages(spool, 1);
 		if (gbl_chg < 0)
 			goto out_end_reservation;
@@ -3042,7 +3049,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 	/* If this allocation is not consuming a reservation, charge it now.
 	 */
-	deferred_reserve = map_chg || avoid_reserve;
+	deferred_reserve = map_chg || cow_from_owner;
 	if (deferred_reserve) {
 		ret = hugetlb_cgroup_charge_cgroup_rsvd(
 			idx, pages_per_huge_page(h), &h_cg_rsvd);
@@ -3067,7 +3074,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		if (!folio)
 			goto out_uncharge_cgroup;
 		spin_lock_irq(&hugetlb_lock);
-		if (!avoid_reserve && vma_has_reserves(vma, gbl_chg)) {
+		if (!cow_from_owner && vma_has_reserves(vma, gbl_chg)) {
 			folio_set_hugetlb_restore_reserve(folio);
 			h->resv_huge_pages--;
 		}
@@ -3125,7 +3132,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		hugetlb_cgroup_uncharge_cgroup_rsvd(idx, pages_per_huge_page(h),
 						    h_cg_rsvd);
 out_subpool_put:
-	if (map_chg || avoid_reserve)
+	if (map_chg || cow_from_owner)
 		hugepage_subpool_put_pages(spool, 1);
 out_end_reservation:
 	vma_end_reservation(h, vma, addr);
@@ -5366,7 +5373,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				spin_unlock(src_ptl);
 				spin_unlock(dst_ptl);
 				/* Do not use reserve as it's private owned */
-				new_folio = alloc_hugetlb_folio(dst_vma, addr, 0);
+				new_folio = alloc_hugetlb_folio(dst_vma, addr, false);
 				if (IS_ERR(new_folio)) {
 					folio_put(pte_folio);
 					ret = PTR_ERR(new_folio);
@@ -5827,7 +5834,7 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 	struct hstate *h = hstate_vma(vma);
 	struct folio *old_folio;
 	struct folio *new_folio;
-	int outside_reserve = 0;
+	bool cow_from_owner = 0;
 	vm_fault_t ret = 0;
 	struct mmu_notifier_range range;
 
@@ -5896,7 +5903,7 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 	 */
 	if (is_vma_resv_set(vma, HPAGE_RESV_OWNER) &&
 			old_folio != pagecache_folio)
-		outside_reserve = 1;
+		cow_from_owner = true;
 
 	folio_get(old_folio);
 
@@ -5905,7 +5912,7 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 	 * be acquired again before returning to the caller, as expected.
 	 */
 	spin_unlock(vmf->ptl);
-	new_folio = alloc_hugetlb_folio(vma, vmf->address, outside_reserve);
+	new_folio = alloc_hugetlb_folio(vma, vmf->address, cow_from_owner);
 
 	if (IS_ERR(new_folio)) {
 		/*
@@ -5915,7 +5922,7 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 		 * reliability, unmap the page from child processes. The child
 		 * may get SIGKILLed if it later faults.
 		 */
-		if (outside_reserve) {
+		if (cow_from_owner) {
 			struct address_space *mapping = vma->vm_file->f_mapping;
 			pgoff_t idx;
 			u32 hash;
@@ -6166,7 +6173,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 				goto out;
 		}
 
-		folio = alloc_hugetlb_folio(vma, vmf->address, 0);
+		folio = alloc_hugetlb_folio(vma, vmf->address, false);
 		if (IS_ERR(folio)) {
 			/*
 			 * Returning error will result in faulting task being
@@ -6630,7 +6637,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			goto out;
 		}
 
-		folio = alloc_hugetlb_folio(dst_vma, dst_addr, 0);
+		folio = alloc_hugetlb_folio(dst_vma, dst_addr, false);
 		if (IS_ERR(folio)) {
 			ret = -ENOMEM;
 			goto out;
@@ -6672,7 +6679,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			goto out;
 		}
 
-		folio = alloc_hugetlb_folio(dst_vma, dst_addr, 0);
+		folio = alloc_hugetlb_folio(dst_vma, dst_addr, false);
 		if (IS_ERR(folio)) {
 			folio_put(*foliop);
 			ret = -ENOMEM;
-- 
2.53.0

