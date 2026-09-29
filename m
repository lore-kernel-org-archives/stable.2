Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8751A568FB3
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 19:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710213; cv=none; b=NNFMuB6bW9ReECBfxiMI6QhPdzKm2OOluUhaEm3E1488DiMuZYAFOUaBX123FYHgqEAhiqUznfbRkJifAHfmwyaCMDDKOHnNBniOsjKCn2hWATZt5eE7mxKmaiBAQX0VJ1/twttXmeRxLTeTX4A0eKpLaqNvOvm/vrQBUyX76VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710213; c=relaxed/simple;
	bh=HnVAjK5T4XUxVuL5UTpqADAnYUn7XPFSfbM1VOnLFoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGh07k+KjG4APxJ83LEnLiYP995FXtRs+OkrCIDMyOdnBq2I5C95yzUDax7X+twSFZxVCS4xTkw78SeisjvvBs65MF1vdyAWjkZHHLQK/L8tgm26k+XcjVcnBomfhWXhuICX/jDR8Of/wqykf4/cnetWrmIXAUCUb8GqRDrlS6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4l2tC+N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4l2tC+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C311F000FF;
	Tue, 29 Sep 2026 19:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710211;
	bh=12aetVXEfQKgDX0eezBFxa0lc5FluRZndLpB/eveF+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f4l2tC+NTjUmpdzB9Vbq/2xeqVb1dWaE81oNZspoLPI4VxJJ6VTKCgXdadThJPcFx
	 F1XzauTEOEtdy1rAaNTsetZ1xEQSZxo+3gz30Zc0Gad2F3ByzpRyJb7aT0501iKlRE
	 rzCztZm9mtwjH1wi8hJjFMViy5Z2ZdO8ntG7yhCRm0hnl+1s/l7LJM2cN9yXbO8dFt
	 6K9UE1fm/YbgGNLaYRptFneCFfqMM9zBnzxPKq8rWgASjTsVqNN3aTXAPtpIU06O1c
	 yLPR1Fv/taq0ICBJwukjs6O8lrFQ/1p5IygVEElmEIkPsf0GFKS8eXM2Q/l1Mh4xjH
	 FIglKAhMAj/0w==
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
Subject: [PATCH 6.12.y 1/2] mm/hugetlb: create hstate_is_gigantic_no_runtime helper
Date: Tue, 29 Sep 2026 15:30:07 -0400
Message-ID: <20260929193008.822363-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092904-charbroil-reroute-765c@gregkh>
References: <2026092904-charbroil-reroute-765c@gregkh>
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
Stable-dep-of: a363c62a653c ("mm/hugetlb: do not dissolve gigantic pages without runtime support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0d98b591bcd1f..763044653ff66 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -104,6 +104,17 @@ static void hugetlb_free_folio(struct folio *folio)
 	folio_put(folio);
 }
 
+/*
+ * Check if the hstate represents gigantic pages but gigantic page
+ * runtime support is not available. This is a common condition used to
+ * skip operations that cannot be performed on gigantic pages when runtime
+ * support is disabled.
+ */
+static inline bool hstate_is_gigantic_no_runtime(struct hstate *h)
+{
+	return hstate_is_gigantic(h) && !gigantic_page_runtime_supported();
+}
+
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
 	if (spool->count)
@@ -1594,7 +1605,7 @@ static void remove_hugetlb_folio(struct hstate *h, struct folio *folio,
 	VM_BUG_ON_FOLIO(hugetlb_cgroup_from_folio_rsvd(folio), folio);
 
 	lockdep_assert_held(&hugetlb_lock);
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+	if (hstate_is_gigantic_no_runtime(h))
 		return;
 
 	list_del(&folio->lru);
@@ -1656,7 +1667,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 {
 	bool clear_flag = folio_test_hugetlb_vmemmap_optimized(folio);
 
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+	if (hstate_is_gigantic_no_runtime(h))
 		return;
 
 	/*
@@ -2560,7 +2571,7 @@ static void return_unused_surplus_pages(struct hstate *h,
 	/* Uncommit the reservation */
 	h->resv_huge_pages -= unused_resv_pages;
 
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+	if (hstate_is_gigantic_no_runtime(h))
 		goto out;
 
 	/*
@@ -3489,7 +3500,7 @@ static void __init hugetlb_init_hstates(void)
 		 * - If CMA allocation is possible, we can not demote
 		 *   HUGETLB_PAGE_ORDER or smaller size pages.
 		 */
-		if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+		if (hstate_is_gigantic_no_runtime(h))
 			continue;
 		if (hugetlb_cma_size && h->order <= HUGETLB_PAGE_ORDER)
 			continue;
@@ -3934,7 +3945,7 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
 	int err;
 	nodemask_t nodes_allowed, *n_mask;
 
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+	if (hstate_is_gigantic_no_runtime(h))
 		return -EINVAL;
 
 	if (nid == NUMA_NO_NODE) {
-- 
2.53.0

