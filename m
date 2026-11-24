Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551612;
	b=lOsjTR/OpK5sJXl0UTAp2oXp8nN8duToL6Y1iR/uKEIYC477Xx88lnS+jzw8a8Bisofb
	 h66WDzh6IhO9cpd3uPkEP5L0BOWAH2zr1evBnr4hRhLlOjaqqSqVk9uAK/Jj2hJhVQMCZ
	 VnJT0JQKwPWREIymKOhWk6tkSFjhHRL8cLC0we56+MFh++1MPel/M3Lg/qSUPlqqwV0eu
	 D0UP8noDaqyujqarqhATr18KcLAju+oQZr3rS5iEz6apaCIB1xhH8WeIgiVLGlo8ERq8Q
	 DaLDguoxU7oOL39KTItbDO5ozfy9HjssHjVa8XA25meF4SThAu2DUZSjUtDspAxLenQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551612;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=io2+EozEZoOmCenpXxuco5qjPfgjxGwsFdsuLB2jE1U=;
	b=ih1Cros/Qy+rbarXuM6bI7J9gcvIQveDPWLljMVBOGp6m4SySFHSPQBrG87sRQ9RdQZy
	 BnFsRku+Ftp09iys+xR1D/j81EnlEXIPTLWTaY2i6sybyajhE2jb2cWDf5/fRgvJppPJN
	 rWn1/Gq7ofbldloQoNdUrMxtrSwgbj7Oep4ZhjDca7hy+NbPPvkaaR93vXFhBlwTjmuJa
	 3KBRYE5yHtJ4UGwnFiGByZ0QsHSmQImPTk65rRpuiqg2KueF08YAx5uqzbEVGlGC2Yfpu
	 1GpkopJ8396K7ymPUYYTAOQE/VV4PBQVzdqFXIY+EANjqd5tXYb0W9FPw9erpbV5Szg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="M8/jDMU7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F8A606A329
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M8/jDMU7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278B01F000D1;
	Tue, 24 Nov 2026 20:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795551611;
	bh=io2+EozEZoOmCenpXxuco5qjPfgjxGwsFdsuLB2jE1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M8/jDMU7Pfd/KAybbCFLURa/S8l0/bL7PGHixQsabCdGMecEEMmA8vDacYgN+m0A+
	 aGusdVvEIVLlhQUCOPk7YC+u+2hgHr4fEGqNLfLVEh8D0x5H/PA+fb362kh8t7ORUT
	 T8p1NeSj5wcINL7cWsJqbO2ngbGWribmq1GYHyM+lIFYsKDQ/q8Ztqs+tVZ1wcr11F
	 aYwU6YOVr9bQHhSYH5y5DlfXozuvL0qmh0MlJWomYVj8P7OIFF9Hq0n2F3C8INLpNH
	 FJSRwPipBd7vqv+D4HjSvcTPVpDqrrqF3LOE2X1lPoPX41daj54L3f4vHE2ZfPQ38v
	 x+N0EUnFToDRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] mm/page_alloc: retry alloc_contig_pages() when the zonelist is rebuilt
Date: Tue, 24 Nov 2026 15:20:07 -0500
Message-ID: <20261124200953.2516046-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124200953.2516046-1-sashal@kernel.org>
References: <2026112436-division-scalding-7339@gregkh>
 <20261124200953.2516046-1-sashal@kernel.org>
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

From: "Gregory Price (Meta)" <gourry@gourry.net>

[ Upstream commit da0d7a895e9021dc2cffa90fb6fafd8b9379e544 ]

Onlining the first block of a zone rebuilds every zonelist in place,
shifting the slots after the new zone.
alloc_contig_frozen_pages_noprof() approves a slot by the caller's gfp
and nodemask, then loads the zone from it:

  CPU 0                             CPU 1
  alloc_contig_frozen_pages_noprof(GFP_HIGHUSER | __GFP_THISNODE)
    slot 0 (NORMAL1) approved
                                    online_pages()
                                      build_all_zonelists()
                                        [NORMAL1]
                                        -> [MOVABLE1, NORMAL1]
    zone = zonelist_zone(slot 0)    /* MOVABLE1 */
    alloc_contig_frozen_range(MOVABLE1 pfns)

A gigantic hugetlb page can then land in ZONE_MOVABLE, and a nodemask
caller can get a range from another node.  Gigantic pages are kept out
of ZONE_MOVABLE since commit 79b63f12abcb ("mm, hugetlb: do not allocate
non-migrateable gigantic pages from movable zones").

Check zonelist_update_seq before using each zone, and restart the walk
if it changed, as the hugetlb pool walk does.  Check again before
escalating to the pass that may migrate hugetlb pages, so a pass a
rebuild cut short is redone rather than escalated.

With kprobes holding the walk across the online, the base kernel put the
1G page in ZONE_MOVABLE in 3 of 3 runs, and this change put it in
ZONE_NORMAL in 3 of 3.  Direct GFP_KERNEL calls with nodemask {1} and
{2} got a ZONE_MOVABLE range and a node 1 range on base, 3 of 3 each,
and neither with this change.

Fixes: 5e27a2df03b8 ("mm/page_alloc: add alloc_contig_pages()")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Link: https://patch.msgid.link/20261101021340.2251928-11-gourry@gourry.net
Acked-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index af979e29c7996..cabb7879012f2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6943,6 +6943,7 @@ struct page *alloc_contig_pages_noprof(unsigned long nr_pages, gfp_t gfp_mask,
 				 int nid, nodemask_t *nodemask)
 {
 	unsigned long ret, pfn, flags;
+	unsigned int zonelist_cookie;
 	struct zonelist *zonelist;
 	struct zone *zone;
 	struct zoneref *z;
@@ -6951,8 +6952,13 @@ struct page *alloc_contig_pages_noprof(unsigned long nr_pages, gfp_t gfp_mask,
 
 retry:
 	zonelist = node_zonelist(nid, gfp_mask);
+	zonelist_cookie = zonelist_iter_begin();
 	for_each_zone_zonelist_nodemask(zone, z, zonelist,
 					gfp_zone(gfp_mask), nodemask) {
+		/* A rebuild may have shifted an ineligible zone into this slot. */
+		if (unlikely(check_retry_zonelist(zonelist_cookie)))
+			goto retry;
+
 		spin_lock_irqsave(&zone->lock, flags);
 
 		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
@@ -6985,6 +6991,9 @@ struct page *alloc_contig_pages_noprof(unsigned long nr_pages, gfp_t gfp_mask,
 	 * second pass, we will try moving HugeTLB pages when those pages are
 	 * smaller than the requested contiguous region size.
 	 */
+	/* Redo a pass that a rebuild cut short before escalating. */
+	if (unlikely(check_retry_zonelist(zonelist_cookie)))
+		goto retry;
 	if (skip_hugetlb && skipped_hugetlb) {
 		skip_hugetlb = false;
 		goto retry;
-- 
2.53.0

