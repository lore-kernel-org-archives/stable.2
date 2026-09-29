Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD50B569F13
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710217; cv=none; b=UvCzzdTWFX/yTjutF6TxeJ4P5WruHFfqoASX5X3FeCWIgzZYtmDOp9RLUIKZP3OTZed0cwvFAD/IZxrPi/v/4jP8Uo/vB/UZcF41gWcZZrC/5+BU8bb9eeiRqk0qmCwAtBpVC8Rr0HNyOLqtJwjlMnsgm324hQOFP8RywgmpRD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710217; c=relaxed/simple;
	bh=rhbbeVzOfGJ55GpdkLsk8s8SngK0vLuIFhzBzWfowYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7t5cdiAk/9WQs+SmIzr210MxMcOYfPj7kw1a8CcEF+fQE2HiI8yIkSGHbErd+x1q6XM6n+OFbaTKqgfJUdrB/HHDRwRGBtcGsimD+BX0xutpz062CTLtgv6gOsHl+Ntg02mFELDOriLULhQ2GVMu8hYpPdzklT5QbbKNQ1t3LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaBJ1K9N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaBJ1K9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9AE1F00898;
	Tue, 29 Sep 2026 19:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710215;
	bh=0eBE2ZOwGsX8wQyYNyfFf/5HGV++W3BqRPaU/aZyRAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PaBJ1K9Nem7hwdKdyuKb3Aj5KGFZFJlnECDbyAbhldgBFrcOLVrNRDYoFOnM+5Bp+
	 tEPeLafUEZ8vGJcUE85IBY3+35cvAmzONTfCmZEYGCXwjTq38vval6SmzsnUNcX7na
	 rpf4pi76Yd/USWv6q9wNWZxgTjVrKCybvTjlakZl4y8IXqV77x88H1mHuGcrGmImMP
	 HFyGmSQgc/0eAHTP1g2njpZ+5tsZfHBB0Uu5eR3lviany7+ZLfIuXC677IOBwLF/qw
	 U8tXzN/UhP8g8dtus8dx3QOM+WgzDtAeYKHRuBOC18Ia+SufCp695m1nZSEMkT/mly
	 pfEAUqUCXqeFw==
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
Subject: [PATCH 6.12.y 2/3] mm/hugetlb: create hstate_is_gigantic_no_runtime helper
Date: Tue, 29 Sep 2026 15:30:10 -0400
Message-ID: <20260929193011.822493-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929193011.822493-1-sashal@kernel.org>
References: <2026092904-charbroil-reroute-765c@gregkh>
 <20260929193011.822493-1-sashal@kernel.org>
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
index 7ddf872081c41..738e1c9f7c588 100644
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
@@ -2564,7 +2575,7 @@ static void return_unused_surplus_pages(struct hstate *h,
 	/* Uncommit the reservation */
 	h->resv_huge_pages -= unused_resv_pages;
 
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+	if (hstate_is_gigantic_no_runtime(h))
 		goto out;
 
 	/*
@@ -3493,7 +3504,7 @@ static void __init hugetlb_init_hstates(void)
 		 * - If CMA allocation is possible, we can not demote
 		 *   HUGETLB_PAGE_ORDER or smaller size pages.
 		 */
-		if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+		if (hstate_is_gigantic_no_runtime(h))
 			continue;
 		if (hugetlb_cma_size && h->order <= HUGETLB_PAGE_ORDER)
 			continue;
@@ -3938,7 +3949,7 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
 	int err;
 	nodemask_t nodes_allowed, *n_mask;
 
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+	if (hstate_is_gigantic_no_runtime(h))
 		return -EINVAL;
 
 	if (nid == NUMA_NO_NODE) {
-- 
2.53.0

