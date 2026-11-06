Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.35.192.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794002928;
	b=11sozgxNkxAt+sn/BlyDuy2gFz3XGfcEBtcUBjtWGvv+LoBcuhC0g/OgwFNbGEvLvnTP
	 yDpJEAvtbwNC+MjkEqf3a73MnzxRVYszPxDhy+cYWqwePGjr+eGnRC055bt4kwSmoepST
	 djpCHir0H07cPVAvKL/Vtz+q+CO7ZvZPCZADbGaUrJP6z/dS2gj5PQKNJLtlWi7J6Sy0w
	 0q81MxFWIjDdPHgs7Ovk64d+DWyjAB+Sen1PNi2t2nfQiel6et0mFAoiFAF9Pj5YEIJwM
	 KdpATyFjYzYbswSOYvMpV+ZvoWGOZcy7Cs00Y5RhzUXb8UckabRmUi1jMXJH3dvT60Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002928;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=7V2F+zDGhfbCGkDv7uMmAHQm9x2OVvO4ypTRhhXUa9c=;
	b=BTcfNYP9mVWeYSHhW2G1y8X5idGtQogPl/FxIE9KrOopQh/vsHz/1j+LK8uH7s0oz4c7
	 i4qSU4TBucuDlO8gfw9lKBFiXC/P2WQ9rj+P3X9yMkV+6pLRGLLhjtjAf4IX+jkSBYP/l
	 XjtTwXna+PbEbSxH9i3uXe/i4iOEgrHhmDNpkGwLkS9/NhX95czyYehadzVxMO1bhBVwV
	 Hgj9qM9ev5EmVrr608yiQexfJguBamcTt1hJWjGWJnyMS9r1+tk32ohKe4ET2jgEbXziQ
	 1ndeNUMxP+1qx+CnDv6Df7d9qnm34A/dZkZ4iQRH7nVMNkr9rTDamc9BicsKlZZYK4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=qpPii9Jw;
	arc=none smtp.remote-ip=52.35.192.45
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27C5606A32C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 22:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D27C5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=qpPii9Jw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794002927; x=1825538927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7V2F+zDGhfbCGkDv7uMmAHQm9x2OVvO4ypTRhhXUa9c=;
  b=qpPii9JwgqMCY00MQNto2grwpswwk2keYqghnt+YBNpBu9b+XwKmSM2d
   Jo/o3tQdJFKRyeyDdGcWbR3yX85L6ojnETvIbWjrdO9Z8e8jOJCS2IfyT
   9oJXDFe019xYVlu0A6OddFUkJqfRHPxRDzJwWGhYGfieJka09Ly+4iyJi
   nVSGg6v0cMg87Twb3sF7zOJvVndj73rSskOimfsjv1N3ycM7mroCVyv/Z
   RyULvdQiTMH9eRwztfQwLBmckyoDC2BkS+ywUVk/ocMZ39m56ESGlCVbE
   GplWsKyEYRFmOy5J+ljQM2f7myYZh+DWmCI/mRCtbCGDvJtY3wsoMXiEc
   A==;
X-CSE-ConnectionGUID: qZleS3m3TZOM1UN4jSXFrQ==
X-CSE-MsgGUID: cLK0wNGgQzKEGWpG7b/HLw==
X-IronPort-AV: E=Sophos;i="6.27,199,1787011200"; 
   d="scan'208";a="33124031"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 22:08:47 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:23643]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.238:2525] with esmtp (Farcaster)
 id eaedad91-858b-4098-95c4-88367f80b45f; Fri, 6 Nov 2026 22:08:47 +0000 (UTC)
X-Farcaster-Flow-ID: eaedad91-858b-4098-95c4-88367f80b45f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 6 Nov 2026 22:08:46 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 6 Nov 2026 22:08:46 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: <sashal@kernel.org>, <linux-mm@kvack.org>, <david@kernel.org>, yangge
	<yangge1116@126.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song
	<21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>, SeongJae Park
	<sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mark Bundschuh
	<mkbund@amazon.com>
Subject: [PATCH v2 6.12 1/2] mm: replace free hugepage folios after migration
Date: Fri, 6 Nov 2026 22:08:34 +0000
Message-ID: <20261106220835.2878368-2-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261106220835.2878368-1-mkbund@amazon.com>
References: <20261105070442.3101877-1-mkbund@amazon.com>
 <20261106220835.2878368-1-mkbund@amazon.com>
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: yangge <yangge1116@126.com>

[ Upstream commit 04f13d241b8b146b23038bffd907cb8278391d07 ]

My machine has 4 NUMA nodes, each equipped with 32GB of memory.  I have
configured each NUMA node with 16GB of CMA and 16GB of in-use hugetlb
pages.  The allocation of contiguous memory via cma_alloc() can fail
probabilistically.

When there are free hugetlb folios in the hugetlb pool, during the
migration of in-use hugetlb folios, new folios are allocated from the free
hugetlb pool.  After the migration is completed, the old folios are
released back to the free hugetlb pool instead of being returned to the
buddy system.  This can cause test_pages_isolated() check to fail,
ultimately leading to the failure of cma_alloc().

Call trace:

cma_alloc()
    __alloc_contig_migrate_range() // migrate in-use hugepage
    test_pages_isolated()
        __test_page_isolated_in_pageblock()
             PageBuddy(page) // check if the page is in buddy

To address this issue, we introduce a function named
replace_free_hugepage_folios().  This function will replace the hugepage
in the free hugepage pool with a new one and release the old one to the
buddy system.  After the migration of in-use hugetlb pages is completed,
we will invoke replace_free_hugepage_folios() to ensure that these
hugepages are properly released to the buddy system.  Following this step,
when test_pages_isolated() is executed for inspection, it will
successfully pass.

Additionally, when alloc_contig_range() is used to migrate multiple in-use
hugetlb pages, it can result in some in-use hugetlb pages being released
back to the free hugetlb pool and subsequently being reallocated and used
again.  For example:

[huge 0] [huge 1]

To migrate huge 0, we obtain huge x from the pool.  After the migration is
completed, we return the now-freed huge 0 back to the pool.  When it's
time to migrate huge 1, we can simply reuse the now-freed huge 0 from the
pool.  As a result, when replace_free_hugepage_folios() is executed, it
cannot release huge 0 back to the buddy system.  To address this issue, we
should prevent the reuse of isolated free hugepages during the migration
process.

Link: https://lkml.kernel.org/r/1734503588-16254-1-git-send-email-yangge1116@126.com
Link: https://lkml.kernel.org/r/1736582300-11364-1-git-send-email-yangge1116@126.com
Signed-off-by: yangge <yangge1116@126.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <21cnbao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Mark Bundschuh <mkbund@amazon.com>
---
 include/linux/hugetlb.h |  7 +++++++
 mm/hugetlb.c            | 42 +++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c         | 12 +++++++++++-
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 7eaabacdf110..7b5395e361d5 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -690,6 +690,7 @@ struct huge_bootmem_page {
 
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
 void wait_for_freed_hugetlb_folios(void);
+int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
@@ -1081,6 +1082,12 @@ static inline void wait_for_freed_hugetlb_folios(void)
 {
 }
 
+static inline int replace_free_hugepage_folios(unsigned long start_pfn,
+		unsigned long end_pfn)
+{
+	return 0;
+}
+
 static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 					   unsigned long addr,
 					   int avoid_reserve)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 68e0cc0748ca..a3d3fb1de3ec 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -48,6 +48,7 @@
 #include <linux/page_owner.h>
 #include "internal.h"
 #include "hugetlb_vmemmap.h"
+#include <linux/page-isolation.h>
 
 int hugetlb_max_hstate __read_mostly;
 unsigned int default_hstate_idx;
@@ -1350,6 +1351,9 @@ static struct folio *dequeue_hugetlb_folio_node_exact(struct hstate *h,
 		if (folio_test_hwpoison(folio))
 			continue;
 
+		if (is_migrate_isolate_page(&folio->page))
+			continue;
+
 		list_move(&folio->lru, &h->hugepage_activelist);
 		folio_ref_unfreeze(folio, 1);
 		folio_clear_hugetlb_freed(folio);
@@ -2991,6 +2995,44 @@ void wait_for_freed_hugetlb_folios(void)
 	flush_work(&free_hpage_work);
 }
 
+/*
+ *  replace_free_hugepage_folios - Replace free hugepage folios in a given pfn
+ *  range with new folios.
+ *  @start_pfn: start pfn of the given pfn range
+ *  @end_pfn: end pfn of the given pfn range
+ *  Returns 0 on success, otherwise negated error.
+ */
+int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn)
+{
+	struct hstate *h;
+	struct folio *folio;
+	int ret = 0;
+
+	LIST_HEAD(isolate_list);
+
+	while (start_pfn < end_pfn) {
+		folio = pfn_folio(start_pfn);
+		if (folio_test_hugetlb(folio)) {
+			h = folio_hstate(folio);
+		} else {
+			start_pfn++;
+			continue;
+		}
+
+		if (!folio_ref_count(folio)) {
+			ret = alloc_and_dissolve_hugetlb_folio(h, folio,
+							       &isolate_list);
+			if (ret)
+				break;
+
+			putback_movable_pages(&isolate_list);
+		}
+		start_pfn++;
+	}
+
+	return ret;
+}
+
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				    unsigned long addr, int avoid_reserve)
 {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d8209a512019..3686b787c14e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6730,7 +6730,17 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
 	ret = __alloc_contig_migrate_range(&cc, start, end, migratetype);
 	if (ret && ret != -EBUSY)
 		goto done;
-	ret = 0;
+
+	/*
+	 * When in-use hugetlb pages are migrated, they may simply be released
+	 * back into the free hugepage pool instead of being returned to the
+	 * buddy system.  After the migration of in-use huge pages is completed,
+	 * we will invoke replace_free_hugepage_folios() to ensure that these
+	 * hugepages are properly released to the buddy system.
+	 */
+	ret = replace_free_hugepage_folios(start, end);
+	if (ret)
+		goto done;
 
 	/*
 	 * Pages from [start, end) are within a pageblock_nr_pages
-- 
2.50.1

