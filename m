Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9E45B1EB
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726643; cv=none; b=Ol0IzJngUxy8mEKJ324vabuZ76wedUIAfrJNY6F+xUEMIbigAH29zJYTzTXCZmN9vWlnel78320hLbOZotvS8rAlUzsaKyAOhyrCPX5NG+J1YJvjLC4eKeGAwATyAm0vy6tXOc8dhakfXKi53s9AyPZ8xs3XBPtiSF272mHhU1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726643; c=relaxed/simple;
	bh=kzEubOw8Yue0CpYEIu8/MI6p+g0z53BdQlZHK3rjUqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPcTB0VFdv4OB/cRzMblQGpriSAcumRDZ/BH1R2NRqrgS2Nbe0r9/L0ys/WpKW8BbgMUwaV13ACScmci7da/11ULfee1e8KbV5Jn/EbVt4uvSissJtJx8Jpm8Els4U9gpsMD0yPtFOlrsBf+0Jo+N6usVlTNtiCsQDL6eCzKC1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SB/m+6xh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SB/m+6xh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03CE1F00898;
	Wed, 30 Sep 2026 00:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726642;
	bh=byHXUOAtMr4pe0LkgQBvT4z636PoEVB8DamUnNqt9sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SB/m+6xhL/7LtKjoxwx+8URpY3HxEf3Wjr+9J/kkN1BHUPDlj4cqSgm35PVRmr0dS
	 JNsJTaD6Ie8fT3tuF+Str+lqmXvBohtjLzmriz0TAlivFlq2+2Lz4etdf26PIDR5kv
	 r991XzIgUmAlr+sG6TAIb18kwx3BN9OJmeVLEpTc6CXL27QnaVi7/rMBprIjr7IuBo
	 cuj1QPJF6q/cXWa1hYgX3/yY7WoXwHFjW3mhgE/WOXo28z7D+FX0qmBZimIXgESJvS
	 +oiFsLEE7Q74Kjr0K7GLYZoQyx5tsRbDmhWWbJn1EIneOHFHHtM28/1nG3UyZwD5Ql
	 lFSnjCQvSHhUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Usama Arif <usamaarif642@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Muchun Song <muchun.song@linux.dev>,
	Rik van Riel <riel@surriel.com>,
	SeongJae Park <sj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] mm/hugetlb: create hstate_is_gigantic_no_runtime helper
Date: Tue, 29 Sep 2026 20:03:57 -0400
Message-ID: <20260930000358.2861523-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930000358.2861523-1-sashal@kernel.org>
References: <2026092904-singer-headphone-fefa@gregkh>
 <20260930000358.2861523-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Usama Arif <usamaarif642@gmail.com>

[ Upstream commit a743e0af503a633e4ca68a100d9b2a1a071fe8ae ]

This is a common condition used to skip operations that cannot be
performed on gigantic pages when runtime support is disabled.  This helper
is introduced as the condition will exist even more when allowing
"overcommit" of gigantic hugepages.  No functional change intended with
this patch.

Link: https://lkml.kernel.org/r/20251009172433.4158118-1-usamaarif642@gmail.com
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Rik van Riel <riel@surriel.com>
Cc: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

For the 6.6 dependency backport, implement the shared predicate as a
macro so no new functions are introduced.  Its argument is evaluated
once and the original short-circuit condition is preserved at all five
existing call sites.  Keep the 6.6 freeing and CMA paths: the upstream
hugetlb_free_folio() context and clear_flag local belong to later changes
and are not needed here.

This supplies hstate_is_gigantic_no_runtime() for a363c62a653c without
changing the existing hugepage behavior or importing unrelated refactors.

Stable-dep-of: a363c62a653c ("mm/hugetlb: do not dissolve gigantic pages without runtime support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2b12644e47848..f5b434f2ac474 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -102,6 +102,15 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, bool take_locks);
 static struct resv_map *vma_resv_map(struct vm_area_struct *vma);
 
+/*
+ * Check if the hstate represents gigantic pages but gigantic page
+ * runtime support is not available. This is a common condition used to
+ * skip operations that cannot be performed on gigantic pages when runtime
+ * support is disabled.
+ */
+#define hstate_is_gigantic_no_runtime(h) \
+	(hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
 	if (spool->count)
@@ -1656,7 +1665,7 @@ static void __remove_hugetlb_folio(struct hstate *h, struct folio *folio,
 	VM_BUG_ON_FOLIO(hugetlb_cgroup_from_folio_rsvd(folio), folio);
 
 	lockdep_assert_held(&hugetlb_lock);
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+	if (hstate_is_gigantic_no_runtime(h))
 		return;
 
 	list_del(&folio->lru);
@@ -1750,7 +1759,7 @@ static void add_hugetlb_folio(struct hstate *h, struct folio *folio,
 static void __update_and_free_hugetlb_folio(struct hstate *h,
 						struct folio *folio)
 {
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+	if (hstate_is_gigantic_no_runtime(h))
 		return;
 
 	/*
@@ -2659,7 +2668,7 @@ static void return_unused_surplus_pages(struct hstate *h,
 	/* Uncommit the reservation */
 	h->resv_huge_pages -= unused_resv_pages;
 
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+	if (hstate_is_gigantic_no_runtime(h))
 		goto out;
 
 	/*
@@ -3376,7 +3385,7 @@ static void __init hugetlb_init_hstates(void)
 		 * - If CMA allocation is possible, we can not demote
 		 *   HUGETLB_PAGE_ORDER or smaller size pages.
 		 */
-		if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+		if (hstate_is_gigantic_no_runtime(h))
 			continue;
 		if (hugetlb_cma_size && h->order <= HUGETLB_PAGE_ORDER)
 			continue;
@@ -3773,7 +3782,7 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
 	int err;
 	nodemask_t nodes_allowed, *n_mask;
 
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+	if (hstate_is_gigantic_no_runtime(h))
 		return -EINVAL;
 
 	if (nid == NUMA_NO_NODE) {
-- 
2.53.0

