Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552312;
	b=DLGyaLH73DCpCevudgTDXV3r4/IxT3SnVwhfnc8B4clQe77OdBDuCLq+Qr+5FWna2uVI
	 j3ICpKbC7mFj2uB6lK7a9kg702amFezzS3O5AhuUihb8qUWquLIksv472gXYFCaXJ8Y8o
	 NDQgecUka3MzbbTPPMF2yuplVASNAh4hYGUIp/dLe5Oc7zQeiVaXcUZwWbgeBwWlsPD44
	 T1S0GS5zQyrAIGE9wp6jRFSmxtl6qMa0rEjipqnoQ59Csk+EcnPtDfSOn+RCUayJiHbY9
	 ch+MrQG8EN5D5cJxGFkV1OhuN1k9jaiywYgFku3tQGzCxHe4tAB7vg/TyklBtPWiLpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552312;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uQ6RrklJ6jKDVUFkkRnQGifu9+x8wHnhGsApVvnRhvo=;
	b=cMQ6JyL0k3gOp4GG0tzJjFhnQGn7gEK2s5IV4VetbH1WfPa+Y2YbaHWZFTJC/RfzIuxU
	 frTt3yNwftf66y/lGhkJyZcFpS5OfqM71kHBaJ1xBa/lry8CM78fgbMqCl8qjv3d/FI1X
	 pVmIVGza9N2KgzbDFMAuzDxuHDGk56NbC14aRh9TpFI6clnZL3UddCXhnWtnNnkm5IKEB
	 6GfA9f7ONSX71xEcQq8a42hBFIWwk5xSDZS2PEJJB4EAJFIDwynJizAj7lOrDuPo0kOZJ
	 DVvfWcr+5CTsIljCQfPOrk969frjS5rsjkQZrC1ByPNWhpnRKZR0jY7nxIJBd5HPMUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mLlq01eB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947F5606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mLlq01eB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685C21F000C6;
	Tue, 24 Nov 2026 20:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795552312;
	bh=uQ6RrklJ6jKDVUFkkRnQGifu9+x8wHnhGsApVvnRhvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mLlq01eBn3iRNRkutxSshaT8hv9RaxCtLq3vgdvxHYviVcGAnmr5+l6LnSWVGC2An
	 BItEBwVWsiGdCJ1NZE/m89XA9+Z798mBFVIDpkVbmLTZ035zfT6ipH9KJNy622JRMC
	 8D33wBkQCSrRj4FG2HFfLK2BTM9n8VERCpTuAI2a91imFTacxH8RahQ/t8syXneTf4
	 ehO3ztsmtA+kiwfHeKnE/mqEh4qMybz5m9ubKVySgi6F3o+6TErNUd5AaGnWdh5DEt
	 xOtkHrh5uP5Z5ShfS7SqMBOdKYL9/S/uzZv6PIH5bnmZ3mmXLRPTjRe0pKCw36gVzR
	 y2xKzRvcdo0NQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/page_alloc: snapshot the preferred zone against shrink rebuilds
Date: Tue, 24 Nov 2026 15:31:49 -0500
Message-ID: <20261124203119.2608398-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112437-awaken-barbed-a88e@gregkh>
References: <2026112437-awaken-barbed-a88e@gregkh>
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
[ sashal: adapted to the older code: renamed alloc_pages_bulk_noprof to __alloc_pages_bulk, and adjusted context for missing defrag_mode, kswapd-skip logic, and the older pcp trylock and node_reclaim code. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Depends on <20261124175924.2153167-1-sashal@kernel.org>

 mm/page_alloc.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f9321e1197f9d..3174a98b407bf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3111,10 +3111,19 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
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
@@ -3161,7 +3170,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		}
 
 		if (no_fallback && nr_online_nodes > 1 &&
-		    zone != zonelist_zone(ac->preferred_zoneref)) {
+		    zone != preferred_zone) {
 			int local_nid;
 
 			/*
@@ -3169,7 +3178,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * fragmenting fallbacks. Locality is more important
 			 * than fragmentation avoidance.
 			 */
-			local_nid = zonelist_node_idx(ac->preferred_zoneref);
+			local_nid = zone_to_nid(preferred_zone);
 			if (zone_to_nid(zone) != local_nid) {
 				alloc_flags &= ~ALLOC_NOFRAGMENT;
 				goto retry;
@@ -3203,7 +3212,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 				goto try_this_zone;
 
 			if (!node_reclaim_enabled() ||
-			    !zone_allows_reclaim(zonelist_zone(ac->preferred_zoneref), zone))
+			    !zone_allows_reclaim(preferred_zone, zone))
 				continue;
 
 			ret = node_reclaim(zone->zone_pgdat, gfp_mask, order);
@@ -3225,7 +3234,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		}
 
 try_this_zone:
-		page = rmqueue(zonelist_zone(ac->preferred_zoneref), zone, order,
+		page = rmqueue(preferred_zone, zone, order,
 				gfp_mask, alloc_flags, ac->migratetype);
 		if (page) {
 			prep_new_page(page, order, gfp_mask, alloc_flags);
@@ -4338,6 +4347,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	struct page *page;
 	unsigned long __maybe_unused UP_flags;
 	struct zone *zone;
+	struct zone *preferred_zone;
 	struct zoneref *z;
 	struct per_cpu_pages *pcp;
 	struct list_head *pcp_list;
@@ -4388,6 +4398,11 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
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
@@ -4398,14 +4413,14 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 			continue;
 		}
 
-		if (nr_online_nodes > 1 && zone != zonelist_zone(ac.preferred_zoneref) &&
-		    zone_to_nid(zone) != zonelist_node_idx(ac.preferred_zoneref)) {
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
@@ -4458,7 +4473,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	pcp_trylock_finish(UP_flags);
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
-	zone_statistics(zonelist_zone(ac.preferred_zoneref), zone, nr_account);
+	zone_statistics(preferred_zone, zone, nr_account);
 
 out:
 	return nr_populated;
-- 
2.53.0

