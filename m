Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795559928;
	b=43XP7FwrU3GOvgF2BInJA2Te1NAU7rK5Bq2aJq1IOLqKWSG8zv8IITGxu4lqU+UYJjAH
	 bSXBQM8MuB76xH9K007uVU8kinoXFsSx5CV+D9ACxM9v1ZGKXlMbFIdwoQeUOTf+z5PTG
	 PxkuJzoCnV9nEb4dpL/G3s93GEANnPtzXORg9yKb/X5lUWVBTS+x5/rrhuCAUuedmi243
	 oEWkokHX7Yw8IdnieOWBHKUcE4vv9r59SbdVuNUe5sL282Haz8lZOd/lk43THYDREWm+4
	 sxg48PnYJwlX+rrJANUSTRcO4eGZxo5lu2oyNfbB9NT8I0Nd+IgXCtzmIfembcj4pVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795559928;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=714nQXjUbjTwtLfwwBNIjaQ0ndWzHjEb/zYwWfHTKPo=;
	b=x0AlEa6TUuOyZ/zymU4B9Nt8CTNVL4e7/XFCGT7qupNammgg9/1xZOuj6wBu3XCqUzxN
	 MunbM59e2fcet83HrWCG4u9Rw/6SGo2FBbRE922OIuf5ENsNVRPBkVMS/oX+9OUsr++Yy
	 /teuX5rTdC/o+SgmVUvB7M9e3cnUWf1njefSK8jGbCmabahuTYy40YGHQ/t0aa5E3aO5B
	 VN0pt3+FSdn+bYKXXHWxvGUc8NHKXRu3w197c0CIdynlhYmxL8ZXlqnx2GAKGx8VroXyn
	 T02WQ/TYiobbJGHOZavtQZA45taTY9bej9BA0kSpm/iKGmaFud/nu3z7Lye1qq+cStw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kYDOB5QD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14697606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kYDOB5QD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0909C1F000C0;
	Tue, 24 Nov 2026 22:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795559927;
	bh=714nQXjUbjTwtLfwwBNIjaQ0ndWzHjEb/zYwWfHTKPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kYDOB5QDHwOm3Bs+baKTJw5LHyUKXTmO+j8cGBxJHxUvCJ87Lh+NIztrWwksmYej/
	 afGOiP2c16CQxP1QZ1pF2nf6irp31lZyprsCIm1HNhiiQdll4W+1d7sSnlDi3SrYl1
	 VM4Jh/8PqwN5pJn/kEfoD4R+3pdGE3/hycq5zVf1fCYGpK6oyJ+UI4fgcO89ardrlp
	 K93LNNOdHLmwDa6BasZc9+/kIhaYvJRy0IvieycFX3PQ4L+ijn6jcFDJ87Y+3tW4gL
	 s62uSEajj5TjYeUCmcRvLnzR7TLMeAQMx0XSVUzHfJXXCVk6r9MrMRfsXHceAFxUhS
	 /H7GTIKWhTT7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/page_alloc: snapshot the preferred zone against shrink rebuilds
Date: Tue, 24 Nov 2026 17:38:45 -0500
Message-ID: <20261124222706.2765691-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112441-mumps-legend-37a2@gregkh>
References: <2026112441-mumps-legend-37a2@gregkh>
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

[ Upstream commit b3e3a760eb68449e2794ef68ab212173d9c3e8c7 ]

get_page_from_freelist() and alloc_pages_bulk_noprof() reread
ac->preferred_zoneref->zone at every use. Offlining a zone's last block
rebuilds the zonelists in place, and the shrunk list's NULL terminator
can land on the preferred slot mid-walk:

  CPU 0                             CPU 1
  get_page_from_freelist(GFP_KERNEL | __GFP_THISNODE)
    zone = NORMAL (slot 1)
                                    offline_pages()
                                      build_all_zonelists()
                                        [MOVABLE, NORMAL, NULL]
                                        -> [NORMAL, NULL]
    rmqueue(zonelist_zone(slot 1), zone)
      zone_statistics(NULL, zone)

  BUG: kernel NULL pointer dereference, address: 0000000000000060
  RIP: 0010:get_page_from_freelist+0x6a5/0x15f0
  Call Trace:
   __alloc_frozen_pages_noprof+0x125/0x330

Read the slot once. Zones are never freed, so a stale zone is safe, and
a NULL slot fails the same way as walking off the end.

Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Link: https://patch.msgid.link/20261101021340.2251928-7-gourry@gourry.net
Acked-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
[ sashal: Adapted to the older tree by using its open-coded zone accessors in the removed lines and adjusting context (older reclaim/unlock calls, no defrag_mode), with the preferred-zone snapshot read via zonelist_zone(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e58f3f514e640..31deab00cf793 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4088,9 +4088,18 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 {
 	struct zoneref *z;
 	struct zone *zone;
+	struct zone *preferred_zone;
 	struct pglist_data *last_pgdat_dirty_limit = NULL;
 	bool no_fallback;
 
+	/*
+	 * A concurrent zonelist rebuild can NULL or replace this slot. Zones
+	 * are never freed, so reading it once keeps a usable zone.
+	 */
+	preferred_zone = zonelist_zone(ac->preferred_zoneref);
+	if (!preferred_zone)
+		return NULL;
+
 retry:
 	/*
 	 * Scan zonelist, looking for a zone with enough free.
@@ -4137,7 +4146,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		}
 
 		if (no_fallback && nr_online_nodes > 1 &&
-		    zone != ac->preferred_zoneref->zone) {
+		    zone != preferred_zone) {
 			int local_nid;
 
 			/*
@@ -4145,7 +4154,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * fragmenting fallbacks. Locality is more important
 			 * than fragmentation avoidance.
 			 */
-			local_nid = zone_to_nid(ac->preferred_zoneref->zone);
+			local_nid = zone_to_nid(preferred_zone);
 			if (zone_to_nid(zone) != local_nid) {
 				alloc_flags &= ~ALLOC_NOFRAGMENT;
 				goto retry;
@@ -4174,7 +4183,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 				goto try_this_zone;
 
 			if (!node_reclaim_enabled() ||
-			    !zone_allows_reclaim(ac->preferred_zoneref->zone, zone))
+			    !zone_allows_reclaim(preferred_zone, zone))
 				continue;
 
 			ret = node_reclaim(zone->zone_pgdat, gfp_mask, order);
@@ -4196,7 +4205,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		}
 
 try_this_zone:
-		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
+		page = rmqueue(preferred_zone, zone, order,
 				gfp_mask, alloc_flags, ac->migratetype);
 		if (page) {
 			prep_new_page(page, order, gfp_mask, alloc_flags);
@@ -5331,6 +5340,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	struct page *page;
 	unsigned long flags;
 	struct zone *zone;
+	struct zone *preferred_zone;
 	struct zoneref *z;
 	struct per_cpu_pages *pcp;
 	struct list_head *pcp_list;
@@ -5381,6 +5391,11 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		goto out;
 	gfp = alloc_gfp;
 
+	/* Read once; see get_page_from_freelist(). */
+	preferred_zone = zonelist_zone(ac.preferred_zoneref);
+	if (!preferred_zone)
+		goto failed;
+
 	/* Find an allowed local zone that meets the low watermark. */
 	z = ac.preferred_zoneref;
 	for_next_zone_zonelist_nodemask(zone, z, ac.highest_zoneidx, ac.nodemask) {
@@ -5391,14 +5406,14 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 			continue;
 		}
 
-		if (nr_online_nodes > 1 && zone != ac.preferred_zoneref->zone &&
-		    zone_to_nid(zone) != zone_to_nid(ac.preferred_zoneref->zone)) {
+		if (nr_online_nodes > 1 && zone != preferred_zone &&
+		    zone_to_nid(zone) != zone_to_nid(preferred_zone)) {
 			goto failed;
 		}
 
 		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK) + nr_pages;
 		if (zone_watermark_fast(zone, 0,  mark,
-				zonelist_zone_idx(ac.preferred_zoneref),
+				zone_idx(preferred_zone),
 				alloc_flags, gfp)) {
 			break;
 		}
@@ -5445,7 +5460,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	local_unlock_irqrestore(&pagesets.lock, flags);
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
-	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
+	zone_statistics(preferred_zone, zone, nr_account);
 
 out:
 	return nr_populated;
-- 
2.53.0

