Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.155.198.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793862128;
	b=cjjKQpVSLYYr3f9Q5E73IdFMBVnpgtNuEXrMxb+CinlSN2TlB4Ot7Glq0Kw42oup7XJl
	 i5d+VZ3+VAOLg2ypFpSjGAyvkReyykyi4L7OXAkwVIyV72CSlhQYOJSjH37kokkJz2TO7
	 4ztlSeXqvXT0kE4ByhMTF8gIHrclYOsWvWOHfF4BDezplgNUTQQhLNbAacRsBh6L9RSBP
	 7ul5ra6kDluKK9BaFK07tV687rqii/xfE/37MD5rHxJEegnSPLow2Cxkzztcwq/ERM2s3
	 Vw8J8k1WAVIpuSa9OayYBhdVGxyTm26iXNHTa31Q4KcyzT1oGwVJM4AffFGv+4nYkcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862128;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=YIY8kqUIU6/z94NGPeDu4JQpZ6OW4PmQsBTRnwMMORE=;
	b=vRudegecRX5SdTIgZCCpM2POfNDuzIS83TYVx3wpffjjwPzel9A2yZrNxtbOIIyObhn8
	 vE7lDjijAJdGj1DrjY5VLaG8O0YXkknTEw7FrgUvBlZJCS0iBo8e77qJUyRWIEhmR0+Pc
	 J/AY1iIt0P1WVAvVxz60M9w3l2x7Hl05BqtOODHE6jYLkGFsgUbcxeRBMH/OrZFnH40YS
	 yfJ0Pzno51/ZAiDJhPptCPJdM1Q8KRx2PWxKs6k3hwl3TU+hR7G8bKvnm6eWY1nXvxkED
	 bUHvVCGUe0wT4rqbVllhvuIhN24r5pwmbKAer5pnzrp9FXzIjHaGMEaTfgwSf1ZS9Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b="V+0b/M+H";
	arc=none smtp.remote-ip=35.155.198.111
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F87606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 07:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2F87606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=V+0b/M+H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793862127; x=1825398127;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YIY8kqUIU6/z94NGPeDu4JQpZ6OW4PmQsBTRnwMMORE=;
  b=V+0b/M+HwaC3ME+B79y0cj55CWBfMhsSlV2q+pedAKjylOO6eQljkA35
   c689QSBzFl6BCdF8BscEzn7pKPkOgf/u0MueJPOySt6YiKFRteKfE5ktA
   MD5GhamymyINmMQUqLEoJdBe4zTXg9Hg4JkVEWqdzbpqLTX3SAiNCJKjS
   k8DTV8wwh707Fjv7/BSJYn+ZjGd6tHT4STlwTcHEKkys5IAvpVeZ6lQ9b
   CxE5G/SNXUNsGXDSfsZph/pSfX3nBk9atxhe21itaz+FYCpyqLFIMBQJp
   OoczoiAHujp0mh0c9NvlzMotLH4kScSNQA/svRUimfF0NpBr9sWeEk8qt
   w==;
X-CSE-ConnectionGUID: s26Q9zbLQAqL8oxZ3zTAJg==
X-CSE-MsgGUID: AHxq8QwUQ/6TSK0SjDwUPQ==
X-IronPort-AV: E=Sophos;i="6.27,196,1787011200"; 
   d="scan'208";a="33069119"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 07:02:07 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:21704]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.80:2525] with esmtp (Farcaster)
 id 8ac5ada2-292c-4d17-9bcd-c9860d19a1d4; Thu, 5 Nov 2026 07:02:07 +0000 (UTC)
X-Farcaster-Flow-ID: 8ac5ada2-292c-4d17-9bcd-c9860d19a1d4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 5 Nov 2026 07:02:06 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 5 Nov 2026 07:02:06 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: <linux-mm@kvack.org>, <david@kernel.org>, yangge <yangge1116@126.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <21cnbao@gmail.com>,
	David Hildenbrand <david@redhat.com>, SeongJae Park <sj@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Mark Bundschuh <mkbund@amazon.com>
Subject: [PATCH 5.10] mm: replace free hugepage folios after migration
Date: Thu, 5 Nov 2026 07:01:50 +0000
Message-ID: <20261105070150.3093908-1-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
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
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
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
[ 5.10: Take only the dequeue_huge_page_node_exact() hunk, so memory
  offline stops migrating huge pages back into the isolated range. ]
Signed-off-by: Mark Bundschuh <mkbund@amazon.com>
---
Without this, offlining a memory block holding mapped huge pages keeps
migrating them back into the block until the offline is interrupted.
Reproduced on arm64 on 5.10 and 6.12 (stock AL2023 6.12.113): the offline
was still migrating after 60 s. With this patch on 5.10 it completes in
0.15 s with the data intact. Also sent for 5.10, 5.15, 6.1, 6.6 and 6.12.

 mm/hugetlb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b23c8b2699b5..4383de6fe621 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -41,6 +41,7 @@
 #include <linux/node.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/page_owner.h>
+#include <linux/page-isolation.h>
 #include "internal.h"
 
 int hugetlb_max_hstate __read_mostly;
@@ -1088,6 +1089,9 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 		if (PageHWPoison(page))
 			continue;
 
+		if (is_migrate_isolate_page(page))
+			continue;
+
 		list_move(&page->lru, &h->hugepage_activelist);
 		set_page_refcounted(page);
 		ClearPageHugeFreed(page);
-- 
2.50.1

