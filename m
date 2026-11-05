Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.12.53.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793862227;
	b=UklFUC0OneaQQbuMH2P6k2QpYLP96mRZugGDos4MHnZNf/kxBac9ciZ1r3xU6sviYtnL
	 xacyr8eJOXdlC6msBeh7FcFPxp6BopYfPDf9W/iVBn0SjaWhFRJfQE4J3fHRapciwex09
	 ezC6zXprjmP2OL8bGycZTjwf/oBJSqFqYkRKhEe2X5zMlT+mEvo6ylNgtLD/f+DudDQIo
	 ZSzVEEtDo7nphZU+LhrmvRa3pNvJwRHPiRAeXaebWO2x/OO0o1Zm8PvG8m959nkRN3Hbd
	 QuZQt9aA+5+3y31qmPtm2iA+gr80tucIDTMcfPy1otKqwYdNv1P5wMH8Ei/T8j7ZsgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862227;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=fvQJZD3XLmj+V8GZDkyRwcnTerFRSlnUb09suoHH/o4=;
	b=Ibd/d1EJ8Zvp5byM80Y8lDmBORgyX1Pn+SSvvDH7lic8zf4v7hZwvzo1JjIh5sZ9BFPR
	 3vjMqoA6FiS2EuppfktX/o9rfdfDXLtoKsC/pLITk2EGaVADG21SZZekS1Eysro7sMiyQ
	 hO9KTgPHUSHTPw8xQXw1zZ7fF3g6qe6UqoZxWA4aLo/gqGJsEqVtiSDNNizcBWqA+rjme
	 OklPb8AJcoRvdxz2DprOIj6ez32403sEzA9fWRpj1wrXNdnSnNgL3+Abv4oVc0PkPUs+H
	 rduTaDYBbtAXT4il0qIvu7KLXo9+2Eus8sTe2lr4CqYnnj6jJHMwjoZ1RdmpOUwOQHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=NPmqUjvK;
	arc=none smtp.remote-ip=52.12.53.23
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75633606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 07:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75633606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=NPmqUjvK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793862227; x=1825398227;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fvQJZD3XLmj+V8GZDkyRwcnTerFRSlnUb09suoHH/o4=;
  b=NPmqUjvKQ4qDwQfbSBX1tBhFGCrDyVwVYDBUvqi4h9GCn+kA26/1k+Bx
   iDTBJ0ZGdGpXPuieVpEpfXdgzyj7T5BuwIjWkRBL3TMpu+aZ9Jj4Q9z1p
   Tc8fMA/lwQZr7LFzEoZAmYAvjCbVwu+4ppvO/mVhxCsVvIDdI0494eb4y
   g8F4ZQRXVMkgBc4hSgvcEkBjSatiyZ507t2AaPzA2pGsptTUWXtxu8TE3
   FlO/Si/iobjU0NucjswWn+Ro4fMJHDKPOD5EQIUIBqvP6nLDwD8S90Oyr
   au9AVhpz+UFr11TekP2wsjb/vSs1aRC7sFIib2Ty8HYnNdcTk+3ofGAYz
   w==;
X-CSE-ConnectionGUID: g+K16sRRR0W1NVflLnpqRQ==
X-CSE-MsgGUID: cNLdWNkkSTO0CWOPDLBthg==
X-IronPort-AV: E=Sophos;i="6.27,196,1787011200"; 
   d="scan'208";a="33031176"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 07:03:46 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:2395]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.21:2525] with esmtp (Farcaster)
 id 36cb82fb-703e-4a8b-9c69-0f3d4ec523ab; Thu, 5 Nov 2026 07:03:46 +0000 (UTC)
X-Farcaster-Flow-ID: 36cb82fb-703e-4a8b-9c69-0f3d4ec523ab
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 5 Nov 2026 07:03:46 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 5 Nov 2026 07:03:46 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: <linux-mm@kvack.org>, <david@kernel.org>, yangge <yangge1116@126.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <21cnbao@gmail.com>,
	David Hildenbrand <david@redhat.com>, SeongJae Park <sj@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Mark Bundschuh <mkbund@amazon.com>
Subject: [PATCH 5.15] mm: replace free hugepage folios after migration
Date: Thu, 5 Nov 2026 07:02:06 +0000
Message-ID: <20261105070206.3094675-1-mkbund@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
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
[ 5.15: Take only the dequeue_huge_page_node_exact() hunk, so memory
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
index 947610e37a33..6df31569ce36 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -43,6 +43,7 @@
 #include <linux/page_owner.h>
 #include "internal.h"
 #include "hugetlb_vmemmap.h"
+#include <linux/page-isolation.h>
 
 int hugetlb_max_hstate __read_mostly;
 unsigned int default_hstate_idx;
@@ -1095,6 +1096,9 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 		if (PageHWPoison(page))
 			continue;
 
+		if (is_migrate_isolate_page(page))
+			continue;
+
 		list_move(&page->lru, &h->hugepage_activelist);
 		set_page_refcounted(page);
 		ClearHPageFreed(page);
-- 
2.50.1

