Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546426;
	b=0T+/hlT11ItKHi1XdIiIpcT0bPlAvogd9d0ZypY/iqvefuUG/dig7/7IIi9nJC5CY7Tr
	 icT/klGZf3n1O+mwSztMw/qIkoLXh+fUftDQPCHforvdc2uLd1foysriB0e30qeuiRNiU
	 uyKVglpFKYijqsk5/9iF4u3DXPFE7fed2WagVNbkEMEx7Rmy2aM9U0UemV/vJ/HJ6dhUs
	 R1EVtBmKEvKIxLEwSPvpV5goy8TzpBojomukkcUZEmERLxb4OGX3R+L7yYeG4o1Q16Q87
	 uezVQvFpBpgBT0GUAyVluTMCM6XLGhErk2zDYgOv8KQKTj9YnPg0Qk6gdyUrmcQ4nWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546426;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eOqJH/E3G0LjMOjD5N2wNzcmizmY4M0edAxM6+coObc=;
	b=M2rCHJe2VNB/m5uYJpX0bfbdQOt/g+KCDxNSDsH2vwrkMiOhLjyzbEko6XSH7nfVOcrM
	 W0ungV5xgkEjk8csNiSneT1XUZWcF3l5v5lHAdTXkhoYVLdFqfBxPpfSuRx3yKr8XUPnG
	 o1CEtICkhMfehAx0J2jqaQ4eCo6eH2ZUQt+qLjQ1fcMMty4yqH95SDUHVMR/z/yI5x0DA
	 s6HznAx6kxRotTTyLOmFM0etVA2MKcsxT1YpEz5LReWtfEXFoE/zD7hHsla48O+Xf6Epp
	 cLlMDS+klEdH5rl+KTJHcsbJ9QEeqUqP5kEV05N1rR58tYkyZLxF7V2lUtWuCa4c1Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D+T7y8xe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D11606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D+T7y8xe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D801F000C0;
	Tue, 24 Nov 2026 18:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795546426;
	bh=eOqJH/E3G0LjMOjD5N2wNzcmizmY4M0edAxM6+coObc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D+T7y8xeSIp0uaRMK+eWLUleHlA8N5qgR+EwympUY8kWENyWYdH27aBROpZjelg77
	 NwCQ2s0gifYhaJQvt+hKL9xh5wX6FVxrlmfS/y2yQhjUvixP1iUP/lYi5/dO01prm5
	 VonyzQktk1LVJR9qrAu8Rl92P5jFVdWRIsiCEW2gPjyiZny7HmB+19RP6+UZ7A9DO4
	 HT8dktuo9lyvhswGIR0oMZq/diPenzeUueLp6N1cpq/zo4dFg4AjXCqoWJplOpYhai
	 QC+07DxlUK2hUPP8oZZ98EsKsRVZPN3I87avDtE+pHbG/jgZwzSVX2RtGt0YDx9ltO
	 F8ZnKkYesJy5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] mm/page_alloc: retry alloc_contig_pages() when the zonelist is rebuilt
Date: Tue, 24 Nov 2026 13:53:42 -0500
Message-ID: <20261124184358.2182291-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124184358.2182291-1-sashal@kernel.org>
References: <2026112435-unnoticed-capsule-b761@gregkh>
 <20261124184358.2182291-1-sashal@kernel.org>
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
index 18c0e6d2ba298..d44cf80dd75fb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7322,6 +7322,7 @@ struct page *alloc_contig_pages_noprof(unsigned long nr_pages, gfp_t gfp_mask,
 				 int nid, nodemask_t *nodemask)
 {
 	unsigned long ret, pfn, flags;
+	unsigned int zonelist_cookie;
 	struct zonelist *zonelist;
 	struct zone *zone;
 	struct zoneref *z;
@@ -7330,8 +7331,13 @@ struct page *alloc_contig_pages_noprof(unsigned long nr_pages, gfp_t gfp_mask,
 
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
@@ -7364,6 +7370,9 @@ struct page *alloc_contig_pages_noprof(unsigned long nr_pages, gfp_t gfp_mask,
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

