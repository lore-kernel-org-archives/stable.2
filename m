Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.35.192.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568002;
	b=v+lD99eWC7T4tgKC3gzoWj8QCL+VZCB378sa+i7pvzatWpSOI0yQFkfGkvvLOYLTSyzW
	 4Un0ZDNDFsmMMjS93uYUaAEVYoNO2+zISFb2oxeaAX2uWh2wvLdx4TZcfEKP5NSztHzC9
	 HObOpUL7FYZQS8N38L19wUFzZdXlM4GpezWahPL7AA6EdNW+NI/GLcqmhNJgX7qlIc8UE
	 TLuIDnzFVrvr8UwSp1CpSQy3bebS3Zx7VLS8ZiLxapz96FuWWE+2B1ZogKmQw3gU4ofPn
	 h20YG+DhrOCdP7xcYq1OpmdMLdWGGC0pSf5aY1TXHGbB1v+wVrW8pZ4wdnvlxkqdPMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568002;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:X-Originating-IP:X-ClientProxiedBy:Content-Type:
	 Content-Transfer-Encoding;
	bh=UmyuIbr3/EmKz19/YPopb6J3Aa3Wu6FFj+RTt7N8bE4=;
	b=uMuepR9ote7GVXJbCc+P3boJ1LoR+o6EpBDJwOPm7MTMe2Lo38MsE812CtYQrT8jp1y7
	 B7fCRBTxXUEpU0npb05xu7FXmqLSnNJgV2vonqtDgOa7d7xY6qm5ciQfzvvounxZSGag4
	 VOlkcyDQJxlNXhVSl++R7B4HypEqr+aDDEo3YeRaJcGBYAN2hqzjNKG0GFa45A8y7TzSn
	 aeY/z0gziRkqzbrzo92zZLklwAPGGVfD87TMN4kWnRs2gOBjF3JjGfNnv1RKffbFNX7cn
	 844G8W+Ez+u8DCgDZnJfylQSVWyANL/z5eaOV4+v7IMNnnU9qncVFhAhKOOmjuUnRWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.it;
	spf=pass smtp.mailfrom=amazon.it;
	dkim=pass header.d=amazon.it header.i=@amazon.it header.a=rsa-sha256 header.s=amazoncorp2 header.b=aiVef7hK;
	arc=none smtp.remote-ip=52.35.192.45
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523B8606A881
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 11:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 523B8606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.it header.i=@amazon.it header.a=rsa-sha256 header.s=amazoncorp2 header.b=aiVef7hK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.it; i=@amazon.it; q=dns/txt; s=amazoncorp2;
  t=1794568002; x=1826104002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UmyuIbr3/EmKz19/YPopb6J3Aa3Wu6FFj+RTt7N8bE4=;
  b=aiVef7hKXSiuOwF/ZZJYUOTDsNc2MSayMmMXlZ19fe3A1sHnQIY/hBhp
   vkgeclZYoqPC0HK4wn0v043rAeXGEsjgES5JxF9LG4EqKoxmNj7dvS6WQ
   N33Ef+AokQZ0e5IxZSUqKozk4ycmysjVfObHpjVD37KgPESKZ36wqM6vt
   +OY6kXb0Xve/5QN2dBV+6hEE45uudrWBiicwjLFjU2dOpF529T++YzYk2
   ZFpKAey0thULFdei/mmps2wR8suZTn3yopEbMXDOxef4hSbHFe5FMdaSk
   lje/3iaJsRfm2z+gFCdT3qutR9pkoNZr+0YsRToQBg4kxP3wt+c8/TnXz
   Q==;
X-CSE-ConnectionGUID: WS5SkEv+Sxyf/QNZNJDOtw==
X-CSE-MsgGUID: T51kXTZtRoGcqT4gRP70eg==
X-IronPort-AV: E=Sophos;i="6.27,211,1787011200"; 
   d="scan'208";a="33649448"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 11:06:39 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:5971]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.231:2525] with esmtp (Farcaster)
 id 9b67f0a9-eb39-4379-9acb-898a6c75b4a2; Fri, 13 Nov 2026 11:06:39 +0000 (UTC)
X-Farcaster-Flow-ID: 9b67f0a9-eb39-4379-9acb-898a6c75b4a2
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 13 Nov 2026 11:06:39 +0000
Received: from dev-dsk-dipiets-1b-77b833da.eu-west-1.amazon.com
 (10.253.66.177) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Fri, 13 Nov 2026
 11:06:37 +0000
From: Salvatore Dipietro <dipiets@amazon.it>
To: <stable@vger.kernel.org>
CC: <dipietro.salvatore@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka
	<vbabka@kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH 6.12.y 1/3] mm: page_alloc: do not give all non-blocking requests reserve access
Date: Fri, 13 Nov 2026 11:06:09 +0000
Message-ID: <20261113110611.2915381-2-dipiets@amazon.it>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261113110611.2915381-1-dipiets@amazon.it>
References: <20261113110611.2915381-1-dipiets@amazon.it>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Johannes Weiner <hannes@cmpxchg.org>

[ Upstream commit 6ee3d87b940848aaed5d4e8d005c5f674bf2637a ]

Patch series "mm: page_alloc: fix reserve access for non-blocking
requests", v2.

Two fixes for how non-blocking allocations interact with the highatomic
reserve.  There are prerequisites for Salvatore's "mm/page_alloc: avoid
direct reclaim and compaction for costly __GFP_NORETRY allocations" [0].

Patch 1 narrows which requests may physically take highatomic pages,
patch 2 narrows which requests may count them in their watermark check.

Both are prerequisites for Salvatore's patch: it clears
__GFP_DIRECT_RECLAIM for costly __GFP_NORETRY requests, which turns every
large page cache folio allocation that reaches the slowpath into a
non-blocking one.  Without patch 1, those requests may fall back to the
highatomic freelists reserved for atomic requests.  Without patch 2, they
count the free highatomic pages in their watermark check while being
served from regular memory, so they can consume regular high-order blocks
below the min watermark by the size of the reserve.  GFP_NOWAIT requests
hit both paths today, so these are existing problems worthy of their own
stable backports; but Salvatore's patch would widen them significantly.

Patch 2 reproduction: a GFP_NOWAIT burst under memory pressure can drain
regular free memory to zero while the highatomic reserve sits idle.
Measured on a 32G box with an anonymous working set, swap, and a full 290M
reserve, three synthetic bursts drove the 28G Normal zone's regular free
memory to 28M, 0.8M and 0.6M against a 60M min watermark.  Swapout failed
its swap table allocation inside reclaim, reclaim scanned 13M pages to
free 200k, and page faults stalled for tens to hundreds of milliseconds.
With the fix the burst stops at the min watermark and nothing else
happens.  This was found in review and reproduced synthetically; it has
not been observed in production.

GFP_ATOMIC order-0 requests have a milder version of the same problem:
They are entitled to the reserve but are served regular memory first, so
the fix there has to change the watermark check and the freelist order
together.  Salvatore's change doesn't interact with this, though; fixing
that is left for a separate patch.

This patch (of 2):

281dd25c1a01 ("mm/page_alloc: let GFP_ATOMIC order-0 allocs access
highatomic reserves") accidentally gave all non-blocking allocation
requests access to highatomic reserves, which includes GFP_NOWAIT and
other sites clearing __GFP_DIRECT_RECLAIM.

While this improved atomic request success rate, it's unintentionally
broad and can actually worsen highatomic requests by squandering the
reserves on requests that don't need it.

There are concurrent efforts to clear __GFP_DIRECT_RECLAIM altogether
for costly order __GFP_NORETRY requests, which would then also fall
into this exemption and deplete reserves even faster.

What GFP_ATOMIC has over the others is __GFP_HIGH, which
alloc_flags_slowpath() translates to ALLOC_MIN_RESERVE.

Narrow the exemption to contexts that have both ALLOC_NON_BLOCK |
ALLOC_MIN_RESERVE.

Link: https://lore.kernel.org/20261001082152.2879289-1-dipiets@amazon.it [0]
Link: https://lore.kernel.org/linux-mm/arFBWvzXPYrKuIYi@cmpxchg.org/ [1]
Link: https://lore.kernel.org/linux-mm/20261001082152.2879289-1-dipiets@amazon.it/ [2]
Link: https://lore.kernel.org/20261028171719.2043421-1-hannes@cmpxchg.org
Link: https://lore.kernel.org/20261028171719.2043421-2-hannes@cmpxchg.org
Fixes: 281dd25c1a01 ("mm/page_alloc: let GFP_ATOMIC order-0 allocs access highatomic reserves")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260904115629.3993331-1-dipiets@amazon.it
Acked-by: Balbir Singh <balbirs@nvidia.com>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Salvatore Dipietro <dipiets@amazon.it>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <dgc@kernel.org>
Cc: Matt Fleming <matt@readmodwrite.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Brendan Jackman <brendan.jackman@linux.dev>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
[ Salvatore: backport to 6.12.y: mm/page_alloc.h does not exist in this
  tree, the ALLOC_* flags live in mm/internal.h. No code changes. ]
---
 mm/internal.h   | 3 +++
 mm/page_alloc.c | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/internal.h b/mm/internal.h
index 7aca909c5405..9fbed032a9c1 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1230,6 +1230,9 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 /* Flags that allow allocations below the min watermark. */
 #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
 
+/* Flags that mean GFP_ATOMIC */
+#define ALLOC_MASK_ATOMIC (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE)
+
 enum ttu_flags;
 struct tlbflush_unmap_batch;
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d8209a512019..3ecd3fd76cf9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2988,7 +2988,9 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 			 * reserves as failing now is worse than failing a
 			 * high-order atomic allocation in the future.
 			 */
-			if (!page && (alloc_flags & (ALLOC_OOM|ALLOC_NON_BLOCK)))
+			if (!page &&
+			    ((alloc_flags & ALLOC_OOM) ||
+			     (alloc_flags & ALLOC_MASK_ATOMIC) == ALLOC_MASK_ATOMIC))
 				page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
 
 			if (!page) {
-- 
2.50.1




AMAZON DEVELOPMENT CENTER ITALY SRL, viale Monte Grappa 3/5, 20124 Milano, Italia, Registro delle Imprese di Milano Monza Brianza Lodi REA n. 2504859, Capitale Sociale: 10.000 EUR i.v., Cod. Fisc. e P.IVA 10100050961, Societa con Socio Unico



