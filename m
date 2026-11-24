Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552933;
	b=KNrYd2eJxhk34w/e0cSM9nOWQh6xLmLcxF3lyq5IceczvQNPTb3Rml485gKEgF8BF6++
	 VW0S+uDPv9dDGX3NSSE1TJsrErfA2NyjZe36+1eZB8ThTUT+0uPSZ4KoFZxwQNNrqhJFb
	 VVkpBa8h5jsWXHzO5hGVDR/ianwcs3C6ysHoJS30d/+ANsWUFBtYfr7AIXAL3trTTa1uw
	 v34PXVwgHWFUo1RN3pypSsfHX/D2oSIlsdr43SCSNtY1JJB/q8q7ljijx99h+980XgpOw
	 vH1kWtvlQjWpK+tylPa9oKUftIG1XCrEg/HQKb9BaCJh5fZjhFTxX15bSE0TegQtsvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552933;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ff+Je+oSc9EzZktON8eWdlvd4LR5czhllib+HDWIy20=;
	b=Lu8Dr6RdvbAWxqiDkrjxU02JkhHwhO/WLJuFhTCsWtU6YvGxwSQIHOc2+tlm0Q/sxw/5
	 UG4MsZH3M50ASYRzl9YJEU3PhcUQz9YKYg3cy6j6I7VQvaNNDvH8d9bNAa6NiJa6zMrOr
	 7ktbXF9xbIIQSbW38ZpopezYTscFZQkGUxdeUnzrt+YydTn09iBQNwMC5PsZ57WR5541T
	 ajyUrBzF55MC97gz3MgHXf/EA4T0iKHdJEGML2AAeGe5LABhcZqNkyXypWHz+N7HE+4Ge
	 iFmhOjA7soIH/Oqxu9Fgu+4NHC0VFzmD2f2txvNbM93ulGi/naULem9fxAbuQDcJlOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fkkf8QMj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D59606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fkkf8QMj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B821F000C4;
	Tue, 24 Nov 2026 20:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795552933;
	bh=Ff+Je+oSc9EzZktON8eWdlvd4LR5czhllib+HDWIy20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fkkf8QMjE4yrmXpByx+rbxjRnCPf6kKqc4K4FSGhr8Jf46poXjni2iNhF2rDWrFWB
	 IhccsJqmTifUdFpFMr34WzWAOltMVUCw67F7xPCgR9RZweF9saSDQniA2ZJvUl6gQv
	 cCT7EG3w5bUtsATSqTP4LWIAkYzqC2/R/EHObTp+Sv538XrNGvEs8/+xN2nvuJSjmo
	 NjaqWKzva6L98biumO4zxL3nUstSb94PV2U7yf4BdUuw3uF/sA/Y/duUmaJ4Sh+r9B
	 cajS8JwLtXAGktUrGuMd9VakGd5VzjVwCrZeIux405SsUDrn0d+jy9CQVvsMEhNP9V
	 WpC14poK38t+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/page_alloc: snapshot the preferred zone against shrink rebuilds
Date: Tue, 24 Nov 2026 15:42:11 -0500
Message-ID: <20261124204039.2687257-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112438-universe-idealist-d7df@gregkh>
References: <2026112438-universe-idealist-d7df@gregkh>
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
[ sashal: Replaced direct preferred_zoneref->zone reads with zonelist_zone() and zone_to_nid(), and kept the existing no_fallback condition because defrag_mode is absent from this tree. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ba7f386331a65..53f0f05ca4903 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4253,10 +4253,19 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 {
 	struct zoneref *z;
 	struct zone *zone;
+	struct zone *preferred_zone;
 	struct pglist_data *last_pgdat = NULL;
 	bool last_pgdat_dirty_ok = false;
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
@@ -4303,7 +4312,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		}
 
 		if (no_fallback && nr_online_nodes > 1 &&
-		    zone != ac->preferred_zoneref->zone) {
+		    zone != preferred_zone) {
 			int local_nid;
 
 			/*
@@ -4311,7 +4320,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * fragmenting fallbacks. Locality is more important
 			 * than fragmentation avoidance.
 			 */
-			local_nid = zone_to_nid(ac->preferred_zoneref->zone);
+			local_nid = zone_to_nid(preferred_zone);
 			if (zone_to_nid(zone) != local_nid) {
 				alloc_flags &= ~ALLOC_NOFRAGMENT;
 				goto retry;
@@ -4340,7 +4349,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 				goto try_this_zone;
 
 			if (!node_reclaim_enabled() ||
-			    !zone_allows_reclaim(ac->preferred_zoneref->zone, zone))
+			    !zone_allows_reclaim(preferred_zone, zone))
 				continue;
 
 			ret = node_reclaim(zone->zone_pgdat, gfp_mask, order);
@@ -4362,7 +4371,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		}
 
 try_this_zone:
-		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
+		page = rmqueue(preferred_zone, zone, order,
 				gfp_mask, alloc_flags, ac->migratetype);
 		if (page) {
 			prep_new_page(page, order, gfp_mask, alloc_flags);
@@ -5484,6 +5493,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	struct page *page;
 	unsigned long __maybe_unused UP_flags;
 	struct zone *zone;
+	struct zone *preferred_zone;
 	struct zoneref *z;
 	struct per_cpu_pages *pcp;
 	struct list_head *pcp_list;
@@ -5534,6 +5544,11 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
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
@@ -5544,14 +5559,14 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
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
@@ -5604,7 +5619,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	pcp_trylock_finish(UP_flags);
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
-	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
+	zone_statistics(preferred_zone, zone, nr_account);
 
 out:
 	return nr_populated;
-- 
2.53.0

