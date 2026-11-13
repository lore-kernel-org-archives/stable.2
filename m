Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.68.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568059;
	b=kVO61dmTCnkK3qZWiv6xxDv61xsisPW2X27qKUsswmOWfO40mp4Uu6NYOMDZZtVMXi+w
	 YzAhEAwi8QUKidJXutH9uaciKnvmeQ+7zKEFxTYCKdJEF7eC9fP11JQuhWbnUIlJ7fto+
	 F66eJkIOMzGfrcqr/sylbHpLyCoKrLLziD5+eH95eKROxJ1ymgpW83eXO6OC4BHurI6fN
	 o6nCNgw7qPH0vJ+NxxWP3NRUwcrGr5cqUkeuG5ayEWBwKmYtriWe8ui8fOTL4BW9uDoZR
	 YVB1asF6aOeTaG8GSSCJBASuBhwMH1mFnI6rdLb8n2pWMB7B75fDSXLevBTQ3DTJcHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568059;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:X-Originating-IP:X-ClientProxiedBy:Content-Type:
	 Content-Transfer-Encoding;
	bh=9qmgvs+MrefA7FJ6nAwlPPgi92BHFCm4YxrzJnGirF4=;
	b=jMGJCFrVYRnBuRzAXt31HbzmoTomUc8vwjdzY8cks25Rjed5owHH6WDCGYqGJVsuFBtN
	 WEZtKFTa7uoZdRP/UsCkOVMm+/+wJGoBNk3PKbsC8E2AMAms7OKV9IZxH0XLdSWpevz17
	 GIt30hc/k04tRooWqGsLieKHqKOMbnN5FBwkXuzaqCUKQO8Z1gRE49f3K8VVNGiAcFQoR
	 0CWPWwmGYYUVVVKBMQ/aJgi1ZVzjYd1ShvWUWaAdWf2ikdI6KwHG0d+6rjdfgY2A6GiIL
	 dABqxH3R2nlBFRVwykhMLD/Zlej8rMVY/dethiOIU8PSGXZFvfZQqVcLXt20r4+d6MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.it;
	spf=pass smtp.mailfrom=amazon.it;
	dkim=pass header.d=amazon.it header.i=@amazon.it header.a=rsa-sha256 header.s=amazoncorp2 header.b=MjaaW+49;
	arc=none smtp.remote-ip=44.246.68.102
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70895606A8B1
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 11:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70895606A8B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.it header.i=@amazon.it header.a=rsa-sha256 header.s=amazoncorp2 header.b=MjaaW+49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.it; i=@amazon.it; q=dns/txt; s=amazoncorp2;
  t=1794568059; x=1826104059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9qmgvs+MrefA7FJ6nAwlPPgi92BHFCm4YxrzJnGirF4=;
  b=MjaaW+49B6U9pV3NQuLUiauXI31MNRqYHO3dIg5BB3knQC6hHvWtfBHi
   30oLuS8eM1iIIV4eQMkXdwwxCu6VUyTVs8/aFOVvwSG0jVAljQLraoGh5
   PC/PIWUp4GRgUBf5jJxQrGna7/nN5/wG7RKwSu4QTyr7YJmrF8lqbjmFY
   m+qMrjkEAABcbZ8g7Miq3V0+edMKrSsSNkvuLB26SLRLJ1FTrHLPMQJCF
   8dO83uDnLBRJgnsX5FQ2Tae1x/UT2JkRt16OkA+LhfpL3X8DK6nEVvqiU
   AACYsw6NdlzNWCmYZlMuYtz8MwVC04VLftYNsqM3szwAx1izt6RioYo9v
   A==;
X-CSE-ConnectionGUID: bsaUzmBBRvCdEbmsTWTSIw==
X-CSE-MsgGUID: UDnJV56+T16eVdik2CMQ8A==
X-IronPort-AV: E=Sophos;i="6.27,211,1787011200"; 
   d="scan'208";a="33792833"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 11:07:37 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:31823]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.142:2525] with esmtp (Farcaster)
 id 9802ae81-8efc-477d-b9ac-0159f9be57f4; Fri, 13 Nov 2026 11:07:37 +0000 (UTC)
X-Farcaster-Flow-ID: 9802ae81-8efc-477d-b9ac-0159f9be57f4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 13 Nov 2026 11:07:37 +0000
Received: from dev-dsk-dipiets-1b-77b833da.eu-west-1.amazon.com
 (10.253.66.177) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Fri, 13 Nov 2026
 11:07:36 +0000
From: Salvatore Dipietro <dipiets@amazon.it>
To: <stable@vger.kernel.org>
CC: <dipietro.salvatore@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka
	<vbabka@kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH 6.6.y 1/3] mm: page_alloc: do not give all non-blocking requests reserve access
Date: Fri, 13 Nov 2026 11:07:22 +0000
Message-ID: <20261113110724.2920455-2-dipiets@amazon.it>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261113110724.2920455-1-dipiets@amazon.it>
References: <20261113110724.2920455-1-dipiets@amazon.it>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
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
[ Salvatore: backport to 6.6.y: mm/page_alloc.h does not exist in this
  tree, the ALLOC_* flags live in mm/internal.h. No code changes. ]
---
 mm/internal.h   | 3 +++
 mm/page_alloc.c | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/internal.h b/mm/internal.h
index 03cfd9f73659..ec8868828989 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -917,6 +917,9 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 /* Flags that allow allocations below the min watermark. */
 #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
 
+/* Flags that mean GFP_ATOMIC */
+#define ALLOC_MASK_ATOMIC (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE)
+
 enum ttu_flags;
 struct tlbflush_unmap_batch;
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 06c493b908ed..8ac6556d19c1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2706,7 +2706,9 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
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



