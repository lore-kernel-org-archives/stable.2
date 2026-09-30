Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F34EED8
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726650; cv=none; b=dy9GI/ypQ5ifPONneyruKHPMStSlNIJqzEVg/bsQsRwVzyew33KlS8amLI3/JY0OSQmx8883fAj7fmZbS1dSZQHnyOQMGrU3L5phjXnf3MVpkp5dDyebIiHsXewQTVIJsjC9afGKD1NBGM4cC9Ciz+KBYqKBYmlhUjr73nO0e74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726650; c=relaxed/simple;
	bh=xvKCybjTdre6oXjOuQ5ojcyqY4tzU7Mxta8YJ9P31P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyumObiKNxVbKFPzZy4W6JgFJhDL2Dpuz5766WiTHMT6S50baG3LTj2IXhWLIwiJCPfcNgnkDjMW4ZDbIGB0h0LfPO/YyFjuqmVmYWwHqeEnGH3l94PydbQhJjnnfV/VNwKbXfrgtMh0mVfCPlhu7OHlJnfZKqxO4fyE1mNvtPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxFcUJ/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxFcUJ/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A471F00898;
	Wed, 30 Sep 2026 00:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726648;
	bh=QEhqIBWND07TRTW7yD7Z8CgEtVqfK8/Ejz+MDnRpcfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gxFcUJ/bI01B5+x1WDLh9WYpT4kVMqCQYqYHEC87ycEShbuW4xmCKz05bpPQXZZ79
	 5HhFvXGjGmp3m/Gq+gUUZdhoLoSW5wPpLL4ZHO8Y2a4z6zoUG02mx0h3k6Jcu0KMo8
	 Js8YqtApJFEApUd7MHHpe6IKGRV5mx+SWK3CtDeMtNA4Xm2CpHKmC/Aac0uFAhl3r1
	 6yWz+I0kl1yTS9sVPuuKWciOs1t3HRlWbVPsHg9e1HJDJZu88p24ph+s0rIy3Q/yCo
	 HkysBt6WaljgGdOpJaIVxCtjnPTKa128ndU1Gy9+0Ev5xN/m2areYEAhSDepf4lkzY
	 Oa3BULlw1kiyw==
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
Subject: [PATCH 6.1.y 2/3] mm/hugetlb: create hstate_is_gigantic_no_runtime helper
Date: Tue, 29 Sep 2026 20:04:03 -0400
Message-ID: <20260930000404.2861901-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930000404.2861901-1-sashal@kernel.org>
References: <2026092905-greeter-coke-d3db@gregkh>
 <20260930000404.2861901-1-sashal@kernel.org>
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

Backport adaptation for Linux 6.1:

The preceding surplus-accounting backport already provides
hstate_is_gigantic_no_runtime() as a local macro with the identical
predicate. Reuse it and omit the upstream inline function definition,
whose surrounding hugetlb_free_folio() context is absent in this tree.
This avoids importing newer folio/CMA APIs or adding functions.

Retain all five condition replacements in the existing page-based
removal, freeing, surplus-return, demotion-setup, and pool-resizing paths.
The predicate and short-circuit evaluation remain unchanged, so this is
still a non-functional refactoring. The dissolution context prepared by
the preceding backport is preserved, allowing a363c62a653c to apply
unchanged.

Stable-dep-of: a363c62a653c ("mm/hugetlb: do not dissolve gigantic pages without runtime support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 497e975b28254..7c7a1faebd047 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1673,7 +1673,7 @@ static void __remove_hugetlb_page(struct hstate *h, struct page *page,
 	VM_BUG_ON_FOLIO(hugetlb_cgroup_from_folio_rsvd(folio), folio);
 
 	lockdep_assert_held(&hugetlb_lock);
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+	if (hstate_is_gigantic_no_runtime(h))
 		return;
 
 	list_del(&page->lru);
@@ -1769,7 +1769,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	int i;
 	struct page *subpage;
 
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+	if (hstate_is_gigantic_no_runtime(h))
 		return;
 
 	/*
@@ -2691,7 +2691,7 @@ static void return_unused_surplus_pages(struct hstate *h,
 	/* Uncommit the reservation */
 	h->resv_huge_pages -= unused_resv_pages;
 
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+	if (hstate_is_gigantic_no_runtime(h))
 		goto out;
 
 	/*
@@ -3406,7 +3406,7 @@ static void __init hugetlb_init_hstates(void)
 		 * - If CMA allocation is possible, we can not demote
 		 *   HUGETLB_PAGE_ORDER or smaller size pages.
 		 */
-		if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+		if (hstate_is_gigantic_no_runtime(h))
 			continue;
 		if (hugetlb_cma_size && h->order <= HUGETLB_PAGE_ORDER)
 			continue;
@@ -3802,7 +3802,7 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
 	int err;
 	nodemask_t nodes_allowed, *n_mask;
 
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+	if (hstate_is_gigantic_no_runtime(h))
 		return -EINVAL;
 
 	if (nid == NUMA_NO_NODE) {
-- 
2.53.0

