Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.34.181.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794002849;
	b=NBY+FrB+1G/GHRdC/5zktMBdrG86EX2B47gg9KWExnreTVCRVQY0ebHuIkyGw6Y3dSVL
	 kFB8kTpLAT9NgGK525hb7hu2tQPhYajsku1sWASNU9Y0SFtLj4vuxNWfjsh4yirpmL2Bw
	 MJW2ddt1JCEBYFe+654+XnRjIfodhS+QkqhLnab+D+OZ1bMw/wq2KiOJ9NgsJ9HqUn6+N
	 t9wi7/MSgd4i8QCCriV8sSvQkZ2sBUb3uShqyi1DgE+zFvpX2BM9XDrfU7aC7IJlRo61O
	 xGmnTd7P2T6BOcgXhI55whR5tcoiwDwJhH5qamlgPPqDIJxhOGOIJEHv5ayAVsl9e5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002849;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=OeQG5pSkuW0ZEeXokGWyNkXj2vkexyfhhiBRdLJ0eBw=;
	b=iJEsppwbs0saN841C5T5YIfiMd+oUQTh1AIJhZfqZKyasO+niGZLeaWhsfkobw2n/bNJ
	 KIm1r14nAVp9YcIfKgahQQgWgZTJbApcr9jMc+DmAQz+f2e1tjMk1ScX5blQlu84APt8Z
	 ge3r+SCb9pKxitfhBJIEiAD7jz/4NU1filgLQAJJ+s+M5ucBXg6w/gcrUk71hoblBhdvm
	 YRuYtceru82FKNPGfcTIUXEh1V6KAiZLTORFYbSfqp9XQZxm96KWnOlAfEh23saQgxaRR
	 EgNu3j4s1J77I2DG8L7hMZpQIJVomoP/oSRNQfliRCPKSgserAKZ3aTMiiGLMQgnncA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=J6SeVTeu;
	arc=none smtp.remote-ip=52.34.181.151
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC17D606A32C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 22:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC17D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=J6SeVTeu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794002848; x=1825538848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OeQG5pSkuW0ZEeXokGWyNkXj2vkexyfhhiBRdLJ0eBw=;
  b=J6SeVTeuHJmrW69FSU2bSL6RRZ71ln85Dy8LFFueudaEg5YBp0mNw6/S
   kBYG9qQtFX2NF/rojhUY3o7I/WWr1hvca50JilOWzpxFY0cxA3U+/gkL5
   sVsJ/x6kFCw+nUXoiLMh8P5HAjPjLTkhP5o4akQqoRcTm5KuubIx/QFeM
   3veYuSvhWv1NI6xzGf0qVyETiiUmcY9XbGyY2VT03QWOYvJEF5K3Q0Qnu
   rWcBamcm3b+p0W6BnEG2/WnK4nmtljozXfL47z/1sqkEHZn6XqH8iPezJ
   c5C3vcInRFAvEXWSyKBB3hhq7GKiRFylgmQCD5L8oyGXqjSVFaZYd/+Ae
   Q==;
X-CSE-ConnectionGUID: 4NdU7nahRPmqjrDDI8SGTw==
X-CSE-MsgGUID: V1gix10PRwmzqyO4vSz7rA==
X-IronPort-AV: E=Sophos;i="6.27,199,1787011200"; 
   d="scan'208";a="33352253"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 22:07:28 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:30760]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.238:2525] with esmtp (Farcaster)
 id fbdc7cc1-f9cc-4242-bdf2-a4ee55ba2275; Fri, 6 Nov 2026 22:07:28 +0000 (UTC)
X-Farcaster-Flow-ID: fbdc7cc1-f9cc-4242-bdf2-a4ee55ba2275
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 6 Nov 2026 22:07:27 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 6 Nov 2026 22:07:27 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: <sashal@kernel.org>, <linux-mm@kvack.org>, <david@kernel.org>, yangge
	<yangge1116@126.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song
	<21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>, SeongJae Park
	<sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mark Bundschuh
	<mkbund@amazon.com>
Subject: [PATCH v2 6.1 1/2] mm: replace free hugepage folios after migration
Date: Fri, 6 Nov 2026 22:07:14 +0000
Message-ID: <20261106220715.2869940-2-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261106220715.2869940-1-mkbund@amazon.com>
References: <20261105070346.3099207-1-mkbund@amazon.com>
 <20261106220715.2869940-1-mkbund@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
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
[ 6.1: dequeue_huge_page_node_exact() and alloc_and_dissolve_huge_page()
  take pages here. ]
Signed-off-by: Mark Bundschuh <mkbund@amazon.com>
---
 include/linux/hugetlb.h |  7 +++++++
 mm/hugetlb.c            | 42 +++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c         | 12 +++++++++++-
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 6b78a0f457d9..13606ab7d0ce 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -728,6 +728,7 @@ struct huge_bootmem_page {
 };
 
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
+int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
 struct page *alloc_huge_page(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
 struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
@@ -1044,6 +1045,12 @@ static inline int isolate_or_dissolve_huge_page(struct page *page,
 	return -ENOMEM;
 }
 
+static inline int replace_free_hugepage_folios(unsigned long start_pfn,
+		unsigned long end_pfn)
+{
+	return 0;
+}
+
 static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
 					   unsigned long addr,
 					   int avoid_reserve)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f549adc0b670..46031ca5a7fb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -46,6 +46,7 @@
 #include <linux/page_owner.h>
 #include "internal.h"
 #include "hugetlb_vmemmap.h"
+#include <linux/page-isolation.h>
 
 int hugetlb_max_hstate __read_mostly;
 unsigned int default_hstate_idx;
@@ -1343,6 +1344,9 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 		if (PageHWPoison(page))
 			continue;
 
+		if (is_migrate_isolate_page(page))
+			continue;
+
 		list_move(&page->lru, &h->hugepage_activelist);
 		set_page_refcounted(page);
 		ClearHPageFreed(page);
@@ -3073,6 +3077,44 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 	return ret;
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
+			ret = alloc_and_dissolve_huge_page(h, &folio->page,
+							   &isolate_list);
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
 struct page *alloc_huge_page(struct vm_area_struct *vma,
 				    unsigned long addr, int avoid_reserve)
 {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 85b189bcab7e..0004df47713d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9329,7 +9329,17 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	ret = __alloc_contig_migrate_range(&cc, start, end);
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

