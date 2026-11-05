Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.68.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793862283;
	b=YcAIM5ReTcNUU5QIAMIfWZ0fRyfOBzTrp3KBSAvoXqD8Mm0oEeuYTWdbiEPqlGg3Pw7j
	 mYtOIjiEwalhTl96+dWE9eG/Sz+TZ/g6hRQtpU6wbuCV2qwxQXXv6HUqe496d2TQeJhji
	 2ZkahYhjLtRm6xP6IQv2kinhOoBsHsmXhmiZQwCl1uZXBJmr/AVCVmp8Gb4WZ1rWxc9Vo
	 pGmdI8m2NjuulI736K7/+Ah2gkrVWUEPl3SKfz7lV5zySZKPzvgdP+Bzrbzx6TNPBCthU
	 /Im6Rth1GX99kYqWFhzyiszaANKnymN9zAolGw1u/rpa5WGoNfrKY+A85WbIi6lUq6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862283;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=0LYlvKnBuyOgTFhE6ZXvSHnkMEzStXd16IsR93SDLcc=;
	b=2kZbPKHhU0x4MNGDSw2KkBWm0fht+OkKmvM5B9XE4niFs6HZdOkaXzsU19GbDFlawjex
	 hauF38DRB3VxsMoAHi/DTKvfD37rI580yY8NDPTr6CmnOfXQjc/oDrpcvcHvEIiaNGEdC
	 MJx3oCfllsAxfAY/feg+yw/5cy6a5hEF1Lu7D8yWiaVfNOs9IVj01x9or1Q6KN+XAlQKd
	 ZrIHI3u5C7uWtJbf1DwxL1iKCyXkau4iyxglzCQ8dtbIJpdWjggIv1wE9DBuSoDRUWBuV
	 hDwPRpxBNP+r9dBgs9pzqj5hDwE9fbB0PJ0RkqRkk3IqgnavCmX7GkiUShVqE6sEy6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=HmmHm7Js;
	arc=none smtp.remote-ip=44.246.68.102
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAB1606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 07:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EAB1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=HmmHm7Js
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793862283; x=1825398283;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0LYlvKnBuyOgTFhE6ZXvSHnkMEzStXd16IsR93SDLcc=;
  b=HmmHm7Jsxfm151C6pvP7HY7twZtLTmD3foJcMbrr/3LVH152MbYalNCn
   1qusji0mk5GUmu4v2A202pSf/n7lNSlso3gKk6MP1fmaQpvPNXsByt7SL
   sv/SZlVr0A0z3Tz7HXjKi3mLYNnCGhHrwd8JorAqZIr8oJxvdzDV6NqId
   O2PNSHdHzrY3yqAkw1m5WbgE01gRXoboZjK4voiFhgfLXd1tm60UZM83l
   OidiUGGvdWBXQBEwtspkYaCMwG/jqenIovX0kI37UIr+Ec1fxoU+fcUce
   tLtxkBJNo8ANEiy0HaScXehv4SAi04YsuuAivhLFDJHNvMd5aYPC59Hnq
   g==;
X-CSE-ConnectionGUID: LpbQ2qwrT/6iqIU4KMf9vw==
X-CSE-MsgGUID: E0dwvs0oQwitmljC1IpvKA==
X-IronPort-AV: E=Sophos;i="6.27,196,1787011200"; 
   d="scan'208";a="33083042"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 07:04:42 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:12999]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.80:2525] with esmtp (Farcaster)
 id 8a7e2f0f-1081-470b-bd38-44d3ccc99dc6; Thu, 5 Nov 2026 07:04:42 +0000 (UTC)
X-Farcaster-Flow-ID: 8a7e2f0f-1081-470b-bd38-44d3ccc99dc6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 5 Nov 2026 07:04:42 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 5 Nov 2026 07:04:42 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: <linux-mm@kvack.org>, <david@kernel.org>, yangge <yangge1116@126.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <21cnbao@gmail.com>,
	David Hildenbrand <david@redhat.com>, SeongJae Park <sj@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Mark Bundschuh <mkbund@amazon.com>
Subject: [PATCH 6.6] mm: replace free hugepage folios after migration
Date: Thu, 5 Nov 2026 07:04:31 +0000
Message-ID: <20261105070431.3100950-1-mkbund@amazon.com>
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
[ 6.6: Take only the dequeue_hugetlb_folio_node_exact() hunk, so memory
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
index 8bfaaa84bb3f..8c1a032a6f53 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -47,6 +47,7 @@
 #include <linux/page_owner.h>
 #include "internal.h"
 #include "hugetlb_vmemmap.h"
+#include <linux/page-isolation.h>
 
 int hugetlb_max_hstate __read_mostly;
 unsigned int default_hstate_idx;
@@ -1344,6 +1345,9 @@ static struct folio *dequeue_hugetlb_folio_node_exact(struct hstate *h,
 		if (folio_test_hwpoison(folio))
 			continue;
 
+		if (is_migrate_isolate_page(&folio->page))
+			continue;
+
 		list_move(&folio->lru, &h->hugepage_activelist);
 		folio_ref_unfreeze(folio, 1);
 		folio_clear_hugetlb_freed(folio);
-- 
2.50.1

