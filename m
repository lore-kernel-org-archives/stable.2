Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3313E274FD1
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 02:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788489387; cv=none; b=lSK730uRATCpmR9Mu7lt1ebKNyITCWeDf49K9VeY7+2FyKfGBp0lXkzk+ojvjr4pFF+IypiyDmycXOHGkRsjXiKz1p2nm0BwJNZxKZyEWBmyb1D2oCAQGKFQ33z/eIDUkDvzwsgnWfrL329OEKy7FqdkJMkmWY2tE9q6ichwvKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788489387; c=relaxed/simple;
	bh=ZQ71UZchkm+5sNnd6iK+uYsAPtqvLcDpKgoMi4/wPDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIArecp8E+x8vhJjPSYhHpwXx3/svHAT/cKoJr9voerx1XcHefLGuQhCK/ObRxtfpn5WCRuviQwDaWa2sjLd1tc6WkXX3h1h7B3c5jk9g0+4k+1wUUUO7xu1iAYCSYVwEiCmnnnW2BaUB47xvl+wFTMOlL34fYP5JfOQF7NIDK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pv9nOr+E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pv9nOr+E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E94B1F000E9;
	Fri,  4 Sep 2026 02:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788489385;
	bh=48H+JzQhwLNZeSqTG3FjRi79DNXw2bGAYfRInPbUSJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pv9nOr+ExP2Plbo78BzVHV/ZFSEDeE32qdLgp7O7DNRcYkf5b61vNjANw3GaNTSOl
	 49+2bt3S25a3Bh/hogXZ5wqdwnOgSTMxVG7BmrVp8MZ5NbRK1shvZENagLk7OyP1R1
	 4vPucBH+ioTRE5qxHN30z7lI/Zcmy8qPSn1WgISCrv99BKmlgtp5CCOZlmX3iaZ9kL
	 9KSTRQoNKOxAI3wgkn09v0ybFJMXnyHETl90kD+BPnmF/a5A//i9R63YMmg/sBciWM
	 RlRAUtjM8FPbd2dvjyVaiFxt/H6hoIEl6YUhbyg8+y8Vt9rXS++V0FTjoCd/2jaWcZ
	 jKzv8z9d/WVWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	William Kucharski <william.kucharski@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/huge_memory: use folio's memcg inside __folio_split()
Date: Thu,  3 Sep 2026 22:36:22 -0400
Message-ID: <20260904023622.2232975-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090357-daybed-breach-27b2@gregkh>
References: <2026090357-daybed-breach-27b2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zi Yan <ziy@nvidia.com>

[ Upstream commit c299a2285d9d8bda4da024455de65e3d00de6f17 ]

Patch series "Honor XA_FLAGS_ACCOUNT in xas_split_alloc() and charge to
folio's memcg", v3.

__GFP_ACCOUNT is needed for xarray node allocation accounting when
XA_FLAGS_ACCOUNT is set. Commit 7b785645e8f13 ("mm: fix page cache
convergence regression") fixed a workingset regression with it.
xas_split_alloc() does not have it and needs to be fixed.

In addition, based on Sashiko's review[1] and Johannes' confirmation[2], to
charge the right memcg, folio's memcg needs to be active during folio
split. Add that before adding __GFP_ACCOUNT.

There is no workingset convergence regression related to missing
__GFP_ACCOUNT in xas_split_alloc() and the impact to userspace should be
minor.

This patch (of 2):

During a pagecache folio split, an xarray node allocation can happen and
needs to charge at folio's memcg instead of folio split invoker's memcg,
because for example folio split can happen during reclaim and reclaim's
active memcg might not be folio's memcg.  Switch to folio's memcg at the
beginning and switch back afterwards.

Link: https://lore.kernel.org/20260804-add-gfp_account-to-xas_split_alloc-v3-0-38cb3ff325c5@nvidia.com
Link: https://lore.kernel.org/20260804-add-gfp_account-to-xas_split_alloc-v3-1-38cb3ff325c5@nvidia.com
Link: https://sashiko.dev/#/patchset/20260727-add-gfp_account-to-xas_split_alloc-v1-1-9fae6bf64838%40nvidia.com?part=1 [1]
Link: https://lore.kernel.org/all/amtcBZ-_QVRgCd6b@cmpxchg.org/ [2]
Fixes: 6b24ca4a1a8d ("mm: Use multi-index entries in the page cache")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Barry Song <baohua@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ adapted get_mem_cgroup_from_folio() to the older folio_memcg()/css_tryget() sequence in split_huge_page_to_list() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/huge_memory.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7ab6779849243..8c626f7c1aedc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2646,6 +2646,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	struct folio *folio = page_folio(page);
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
 	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
+	struct mem_cgroup *memcg, *old_memcg;
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
 	int extra_pins, ret;
@@ -2664,6 +2665,19 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	if (folio_test_writeback(folio))
 		return -EBUSY;
 
+	/*
+	 * switch to folio's memcg as xarray node allocation can happen and
+	 * needs to charge to it.
+	 */
+#ifdef CONFIG_MEMCG
+	memcg = folio_memcg(folio);
+	if (!memcg || WARN_ON_ONCE(!css_tryget(&memcg->css)))
+		memcg = root_mem_cgroup;
+#else
+	memcg = NULL;
+#endif
+	old_memcg = set_active_memcg(memcg);
+
 	if (folio_test_anon(folio)) {
 		/*
 		 * The caller does not necessarily hold an mmap_lock that would
@@ -2792,6 +2806,9 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	if (mapping)
 		i_mmap_unlock_read(mapping);
 out:
+	/* restore to caller's old_memcg */
+	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
 	xas_destroy(&xas);
 	count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
 	return ret;
-- 
2.53.0

