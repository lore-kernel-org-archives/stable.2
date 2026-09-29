Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A69225392A
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707621; cv=none; b=A8BOz8xkLMWKhNILclyzf8PaUTlC+NoaLEeqHLD0QWxM2rVF8hpkjRDsKM5gVsnZtxii9TaSKeeT/CRpeu0YATvps3RnHgrNlCHw30wNTUlLyJEZpIT06rCcDhZn+q03/I2Ml3Z1tDB4isJVGIy3QxCtFg5rVug3z8yRN8h8fAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707621; c=relaxed/simple;
	bh=lLiYi4aGD2Dh63Cv1tzO89eqegfXFZesYuh9BrC18eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2VH5X+Id5Uxv0Gg91DQJ4oJXHdXRAZpxBfY31ZeR+0sT6UeuLgyK6CYg4DBwtsFd29Bd944Gma6j5Td/ttFNh5UNE19Ogd5gJUW1QiIV+m8pDSQeojp1sdp/RTEirjsBte+nZJ2pT8LkcK/Rn9Byg9F7no2Vh6ZC5juLbfhavE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cu7oT973; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cu7oT973"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079071F00899;
	Tue, 29 Sep 2026 18:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707620;
	bh=P4wxmpayZStywiysFjhPJO7ijJM/GspudJRKfv+BkdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cu7oT973vTwMmmjd9NWblljM+0v0kPeyp74qGHhHB+cjTjj9nmU/9bfiJh5ZlaUTz
	 vjhHpTvxXMdp3ic8aPwUQ067LuRIAraQQjyYAhPnA6NKA73IJWn1EcyQPXSCl1mBJC
	 JfAqZ5cP9fX/Ud0UkWPDaTeJ8uvzycldV+tfLp3buKfGM9H2DqAwCp6ej5XY46p0HA
	 VVtBmrJJ1BJGmGpfPFwt5oyRik6AZ5yoFiifmpqDf0YU1caDvDYgY2AMbMWsJABRAy
	 GcSUUjrUmR3SWHOqosWYcwaWVqzR0vvMsYYRoNxg2c00T5qZbZCNbH5yXNJEwFXDhK
	 Z8nyKSOX1UpxQ==
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
Subject: [PATCH 6.18.y 1/2] mm/hugetlb: create hstate_is_gigantic_no_runtime helper
Date: Tue, 29 Sep 2026 14:46:56 -0400
Message-ID: <20260929184657.522286-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092902-struck-raving-0494@gregkh>
References: <2026092902-struck-raving-0494@gregkh>
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
index d969c9ed91b16..e1ac2f5dab8f8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -138,6 +138,17 @@ static void hugetlb_free_folio(struct folio *folio)
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
@@ -1538,7 +1549,7 @@ static void remove_hugetlb_folio(struct hstate *h, struct folio *folio,
 	VM_BUG_ON_FOLIO(hugetlb_cgroup_from_folio_rsvd(folio), folio);
 
 	lockdep_assert_held(&hugetlb_lock);
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+	if (hstate_is_gigantic_no_runtime(h))
 		return;
 
 	list_del(&folio->lru);
@@ -1600,7 +1611,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 {
 	bool clear_flag = folio_test_hugetlb_vmemmap_optimized(folio);
 
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+	if (hstate_is_gigantic_no_runtime(h))
 		return;
 
 	/*
@@ -2496,7 +2507,7 @@ static void return_unused_surplus_pages(struct hstate *h,
 	/* Uncommit the reservation */
 	h->resv_huge_pages -= unused_resv_pages;
 
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+	if (hstate_is_gigantic_no_runtime(h))
 		goto out;
 
 	/*
@@ -3711,7 +3722,7 @@ static void __init hugetlb_init_hstates(void)
 		 * - If CMA allocation is possible, we can not demote
 		 *   HUGETLB_PAGE_ORDER or smaller size pages.
 		 */
-		if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+		if (hstate_is_gigantic_no_runtime(h))
 			continue;
 		if (hugetlb_cma_total_size() && h->order <= HUGETLB_PAGE_ORDER)
 			continue;
@@ -4188,7 +4199,7 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
 	int err;
 	nodemask_t nodes_allowed, *n_mask;
 
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+	if (hstate_is_gigantic_no_runtime(h))
 		return -EINVAL;
 
 	if (nid == NUMA_NO_NODE) {
-- 
2.53.0

