Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.12.53.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348083;
	b=lBKrD4z2OLEFr9bPzh9gPvyKvcWwBfTVqViUuNxORIKY00k7e7JQKd1NerCAcrXh5M7N
	 FDckESXYqsBFrcoUp19tzaT/C6DXxEk8oOr1MAsl/31OiXBKCwq/ytZC9lhXtxI+gimkC
	 L98yClpDQc6F/9iCI1tsfLbp4kNvLXYoBE1na4iBIQefGg88LML1f6VdTj6f6OnhOaKYD
	 u0dZ+641lC0ELK3vKV1z7gyBpbagOaz/I18lqJ/dwl1segdgC8vfOYNrO62x7g2MJYF4Y
	 FHPUAlzxqZgKLzCZznAoPE9+cH72/U+nVPZP1RiRvHOeXpP/Q+1RyrHJKuPw8fMx4+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348083;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=fsSeCyyxxTUbCaalKAGDKE0ZpmnzMT58aaVvQO6FbxE=;
	b=O3b0M40xlQ5uG++TU2d9hq/pw/4vou1e4geXM8fCl033eptQsD4E6g9Mj7ZQKQrbS35j
	 GkYDy34uLD1bY0xbqKNmn5xGvTwvJpCjq8ir32VQiBt74S0elzBuvI89zDTe/PdtJ4sLo
	 1yaf79dsS2dWzB1SdmgJ9S9BjTSARXSAIyhuXPgRjsAbFgbzK9jqeWI7gKCNhc5AFo6L0
	 0Ohbgc6ySz+f6jy0N7n2yvwuSqxZXXLAEnZ5aEIpTNyvQaPFq6mPcrJJv0DZshOwjQNau
	 fKrJhOQwJo2isSPl598ymER/2eJUTAQTopVVt5PNU+advCWHQb1LK+L6l5kiCW+c/+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=NlZXNGJF;
	arc=none smtp.remote-ip=52.12.53.23
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46350606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46350606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=NlZXNGJF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794348083; x=1825884083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fsSeCyyxxTUbCaalKAGDKE0ZpmnzMT58aaVvQO6FbxE=;
  b=NlZXNGJF4NIeb8TXciReoy/xzvn+UWT8w4WAw9KnwZB88FWPsx9TD32z
   JLjGs+ajnsjT8lewXPsVFNyaJkvgGXXFCkFh0Le7MrPxoiU2w6+v8rymm
   n3X2fuJ+n+UhlrP3BtAROdxB5KlOj+kSysdhTV1qdJcXaab3dofrObEt6
   2L83DxZtdijYETtLqcyu8BYkqEX4GLrsj8a4HJJwXJxb2QwcYoDvCfCcG
   FjxsNRtJIbbCLNrwJ1GwBbW+amVc34lWg8sEtCLYNNSyxsY+BqP5ksslK
   Buqir/FpZFkg/fIinNCd68jLYMSkD3jvXpbT/JViCwC8t6NKjSxPjx/xj
   A==;
X-CSE-ConnectionGUID: qI3YSMVbTvC5qJu2zmJaEw==
X-CSE-MsgGUID: hh/LpjLXTpq9xE5Z8g9DKA==
X-IronPort-AV: E=Sophos;i="6.27,206,1787011200"; 
   d="scan'208";a="33528165"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 22:01:22 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:7503]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.231:2525] with esmtp (Farcaster)
 id 88fd72c9-b740-4869-b582-78f97e99861d; Tue, 10 Nov 2026 22:01:22 +0000 (UTC)
X-Farcaster-Flow-ID: 88fd72c9-b740-4869-b582-78f97e99861d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 10 Nov 2026 22:01:22 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 10 Nov 2026 22:01:22 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: <sashal@kernel.org>, <linux-mm@kvack.org>, <david@kernel.org>, yangge
	<yangge1116@126.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song
	<21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>, SeongJae Park
	<sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mark Bundschuh
	<mkbund@amazon.com>
Subject: [PATCH v3 6.12 1/2] mm: replace free hugepage folios after migration
Date: Tue, 10 Nov 2026 22:00:05 +0000
Message-ID: <20261110220006.3259056-2-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261110220006.3259056-1-mkbund@amazon.com>
References: <2026-11-08-1-daily-reply-0005-hugetlb-6-12-v3@kernel.org>
 <20261110220006.3259056-1-mkbund@amazon.com>
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
index 69bc41be9be9..96a201151a80 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -687,6 +687,7 @@ struct huge_bootmem_page {
 
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
 void wait_for_freed_hugetlb_folios(void);
+int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				unsigned long addr, bool cow_from_owner);
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
@@ -1078,6 +1079,12 @@ static inline void wait_for_freed_hugetlb_folios(void)
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
 					   bool cow_from_owner)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d9443bdebc06..929ea7dbd900 100644
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
 /*
  * NOTE! "cow_from_owner" represents a very hacky usage only used in CoW
  * faults of hugetlb private mappings on top of a non-page-cache folio (in
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 480579d7d59e..063c2a359a1e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6743,7 +6743,17 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
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

