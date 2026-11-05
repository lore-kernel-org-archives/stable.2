Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.34.181.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793862272;
	b=a7rbKYhXyKArnaslqNUm5Uy54VYLSL//D//HPqAuIld0BMqUrmuceTht3zm8egXXD1Fk
	 2q/png5qco5t3nIfNmAk7r1Q8P37JXz2L0Cf227r8D5ZDeE2jtbgSaJ846vi7z41KyZR0
	 7/4Dcq3OX8uHL0KxB/e56ixEiuHf+9/MhrzfbUFRB9madWVEvlL7Pa1vopT+oh3TFwyha
	 XS7+UGHaIUrpmxcWCSml3LGpc5KBdthIRpvpiZWWuEQQTr7Q2GhVqG5/Lsfw6xZQMka61
	 JARcekU4KnDO8XgakN3K3IRSvEBqRSG9q81ZAjIaq64YDluT84oYyDjTpp6lnh2DYcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862272;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=LUkLYCAQG8uZ5fDEy/ZrjWX6jHEgJ9R2DqBFxbgN3OM=;
	b=zLKWMRw5i//YK2nDHsofd6QoGfYPEIv079Alqvnos3DJU4jNOrD7T5YNBFDx4aYb0S6d
	 5ATV7YeerwYO837fpKrXcfNMku4kzax3GXtBkREMyLBJwjEMPQ4JHpyr9mX0dlXJMX9q+
	 j5E02ry1hCF9La2acsMzDOLaHOOedEQ9F31+WREBjZyzbRRhm0Wmn/v50MQGAEsZ2Z3xE
	 fhZjyELWkcsiVY627JCci+xlAX9ea0yRJYz96FP/Ura97xoY7mJsDveMcZsxSoFMnqLj2
	 sSUMdu7NzdekjNZmivVByDDrNVqfGjQOYoe+6iYQRgk0YsI0k4dHEocaSItcRGnq0XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=NmQGSaCC;
	arc=none smtp.remote-ip=52.34.181.151
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CDB606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 07:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43CDB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=NmQGSaCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793862272; x=1825398272;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LUkLYCAQG8uZ5fDEy/ZrjWX6jHEgJ9R2DqBFxbgN3OM=;
  b=NmQGSaCCskyDyxE92OdaZEOV/ZlvV991n447Fi/L2t0mqectykLG7oYz
   fScSwx1W4lplG/Yi3eMNfRKI5iY6M/I8Y1M/RRMvnaVN4VG/rwPNwzaWy
   dr4L9ZKuMUXyWTNSBMm1wJlNYM2Xx7110f1uUAqI/dg3J67p67r6/TasV
   fWiGnypd92QZB7CwDvCyGX2ftkBkX+AD9zsspAtT/3u5p6Gco8UDKb5O6
   2Y+oJFpQhMeR4sJky2IcMeQ7mgv1Z/Iw9wauuaqr67UZWYVeOXEJDzDXv
   /bE4tAsBCu30VAaW+FnvyIwOMnTvlo5s8h1qHRsA5KqvTBBmKvVltpopO
   g==;
X-CSE-ConnectionGUID: vrDY9AL7QE6n6IHFzeQHIA==
X-CSE-MsgGUID: ow7+GQKLSr667QbihRJPMA==
X-IronPort-AV: E=Sophos;i="6.27,196,1787011200"; 
   d="scan'208";a="33157905"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 07:04:31 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:23713]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.208:2525] with esmtp (Farcaster)
 id 97f8a510-eb14-487f-a6b5-da15ebf78121; Thu, 5 Nov 2026 07:04:31 +0000 (UTC)
X-Farcaster-Flow-ID: 97f8a510-eb14-487f-a6b5-da15ebf78121
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 5 Nov 2026 07:04:31 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 5 Nov 2026 07:04:30 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: <linux-mm@kvack.org>, <david@kernel.org>, yangge <yangge1116@126.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <21cnbao@gmail.com>,
	David Hildenbrand <david@redhat.com>, SeongJae Park <sj@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Mark Bundschuh <mkbund@amazon.com>
Subject: [PATCH 6.1] mm: replace free hugepage folios after migration
Date: Thu, 5 Nov 2026 07:03:46 +0000
Message-ID: <20261105070346.3099207-1-mkbund@amazon.com>
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
[ 6.1: Take only the dequeue_huge_page_node_exact() hunk, so memory
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
index f549adc0b670..d39cd5c582c8 100644
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
-- 
2.50.1

