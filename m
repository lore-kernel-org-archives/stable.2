Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222378;
	b=Bi/vIm6xtodWcenR4/kxXKHmxyUTFlTk2Rgi3MKaa6RCuPNjeAzUxrIy1w+52F5/xkrC
	 svkFzkSH5RfqmEDH9LyJiZ+b7PKWL3Ov3OLkw0YmukYP6uM0l5lHhSKa8NW7Y9v8sK5Ed
	 Z/5LtIBTFedyNfmbNTvE1Kg41SI08DhE1QdtC3ymRCwH2ykpCRgMxj5CCtqSJggDfETZF
	 MvxncCg5k8l6ozucjhardfBlw8AcNLl7Yj87ARWlPIhdHEPgr78Jw4w4NDTdiLszH/Ruz
	 yDSASBGzIM6035hD3bCJTiWmihldJfl3NI/+T9mk0LvYrLuXGk8mzwS3emiay1qdnQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1qDLFGzOABB53SqGvA4E/3rKuoqOq+XmM1bYUdpKmDY=;
	b=R2GhQrm226HfwoiJ7oRnGh6eP4Ktd7TRtcAd/84eIUjQ1pZQGphyhYLAF1EcIHWcULm+
	 2kg9jVJ8Fm7ud9aObmItKPq4T4E2Kx5BvMKw3rFYWCvo4ZAgbFWgZfT2JtcxsYPNTAKLu
	 lf9buK9AREqQFh/W/P4yIMgxmr3YGOxkNLCmeJMWxaS2MDlR04exkq8juDGT+McQfvtH0
	 zU3lJzBvQeFLVBciDpHxkOU0YXsyuxcuYticZDXLvTCHXgRLfaemeaQpaij0+6OHob21P
	 4azbMeMOLFOOqb3bVlHkcgXTBkTAGWV6AOnYBcXDw6R2+1VyjIP1s6OtXUZy9FABhUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=kTMhMZiQ;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7F460A260C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F7F460A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=kTMhMZiQ
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91c73c63116so14961016d6.2
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793222377; x=1793827177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1qDLFGzOABB53SqGvA4E/3rKuoqOq+XmM1bYUdpKmDY=;
        b=kTMhMZiQUOk6JHIFen4OY/F4++2LudKwXi4T5jGyrRqh8tEt7rzRNZ0l58e8RJVpdA
         uqMuSl+12qqva1eFLvNBNGxkJaA1fBFfKFxUYyZiqr9TH8EBZrWstCPQrHihExLfM7KD
         qjen8SgtSAeGu5iGQPOj5X6bZf1XS66N5uk/2/++zZ0kfrZBy0b2UKIidiOVPp3ssduk
         Eigt+jNLkcJRVgW05U+Bp3uWKkNNJyQgNxoCbYDDqB4IfBzttpvOGIiu348xLdCsXbIW
         A7e8zQOVQeDUE16NsyoW7T2nHo8Bf8B/rzEDSFLDjr4zI21tBIJud0p/VGds+Kv/jj1b
         QAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793222377; x=1793827177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1qDLFGzOABB53SqGvA4E/3rKuoqOq+XmM1bYUdpKmDY=;
        b=eqTf+htyS615CNcZZRWm2PpniMYaGycHTmp2Qdy+9VGH7TvcGVt8xpCJ+mZ+0qj0GB
         XYO6vM/VqOgdGT87/h2XytVYvYJm/LJOuEnQgOUrOf1jI776Z6cZjHUGwofah6Ei5gw8
         mTkbybsriEYVU84AryXY/+5WqqtePpug3ux7KRTalKm+s+w+O8XEyv8cN7RuPq6ZaKuh
         jooxQHzZfXYh03wio5Vdlh2yi25QdaFol3pRhywOaC+DWe8NGyAMHtENsB9ddZlMYz6m
         /3F0IAe/KpprTLBWhjLb2ev1PQJWIcWlCKDlVmxj0xqG7cYPeeiQosypQr5VB0Y0f9qJ
         cE3A==
X-Forwarded-Encrypted: i=1; AKwUvBwx8AAz4vay7r3U06BxJ56a8j6d3no5EknNqiRSTdhuENH9BVtcdjwZLr1RBT8m0XrhS+AiljU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAeLKz6nab0keK08Tt9w1Q4h/0hevfgLhaffzUZdu/qe25wxJF
	jyUzpleym67GNVALb1ez028gMDqKw1AyAffEq1K076ISAXnZbpoX2cMiXyDLBJGML4E=
X-Gm-Gg: AYBFou2paaK9X2GIQFi1DYsIwBhLQgYNcTOor4o8B8I/hJvuAaE8hLYfgPJ8Z6WDX46
	boWJb9Fg3vdRKOPNhznZ3TTc2Wpxl9Mc186OOYWNm1LYSt3sePVcyJH4JodOwx9aFNDVJv8xj7D
	h1xAdgjt7CrA+1H9RS0pLX6CA0GlMZBFh0IE+i+gMV/L0EbOaKEHjlDGwBS4z1QZhlh5VgqYidg
	xITfe+yH0HYLq40mKzbllY2Y31XhWze/jeXGJh36/lJ5eWF2WoOsieHoUeTW+nAsbuxkwqRvR79
	7DsDbyt3j7yoOLAveqfao86rRl1Ei16ZV8jfDVEL+2O+UMZC6X5P9/8V6pNV+yVNEoaAziYfkaz
	UPeihSWF05VbSMZNCryAyVDHhFshsZsfPOPR9nawla+zvEDo5VU89LQ5JhfIOfxtfdSoWxuNH10
	goG2mae3JAPoILTf6Y6Im2RppaJWgxi0h3bs9ztaZ70DYTi2I1jODe6Au9b9+adk6WogoaJyoVS
	fHp7BzqJ4yl/W607Jziiv5WH3EWDIzOeymT0A4XTENlH8j70R8XSh2jD7GXlfV8hkGUxWGP+8yf
	Pht7gQWUvT4HoPmYACytzV4X3nLm6s5wxDwuwDsy6LfrliCA6EJk5k07AOxiIOXp4MVJ520jaNp
	EzkOudjP/aOaQ2p8=
X-Received: by 2002:a05:620a:3183:b0:93f:3646:7a57 with SMTP id af79cd13be357-94408cfbb47mr549993085a.57.1793222377269;
        Wed, 28 Oct 2026 14:19:37 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a6d598sm139778966d6.3.2026.10.28.14.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:19:36 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	akpm@linux-foundation.org,
	gourry@gourry.net,
	ziy@nvidia.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	mgorman@techsingularity.net,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH v4 3/8] mm/page_alloc: snapshot the preferred zone against shrink rebuilds
Date: Wed, 28 Oct 2026 17:19:25 -0400
Message-ID: <20261028211930.3504634-4-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028211930.3504634-1-gourry@gourry.net>
References: <20261028211930.3504634-1-gourry@gourry.net>
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
---
 mm/page_alloc.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 52533992ea16..24106c881ec2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3794,12 +3794,21 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 {
 	struct zoneref *z;
 	struct zone *zone;
+	struct zone *preferred_zone;
 	struct pglist_data *last_pgdat = NULL;
 	bool last_pgdat_dirty_ok = false;
 	bool no_fallback;
 	bool skip_kswapd_nodes = nr_online_nodes > 1;
 	bool skipped_kswapd_nodes = false;
 
+	/*
+	 * A concurrent zonelist rebuild can NULL or replace this slot. Zones
+	 * are never freed, so reading it once keeps a usable zone.
+	 */
+	preferred_zone = READ_ONCE(ac->preferred_zoneref->zone);
+	if (!preferred_zone)
+		return NULL;
+
 retry:
 	/*
 	 * Scan zonelist, looking for a zone with enough free.
@@ -3846,7 +3855,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		}
 
 		if (no_fallback && !defrag_mode && nr_online_nodes > 1 &&
-		    zone != zonelist_zone(ac->preferred_zoneref)) {
+		    zone != preferred_zone) {
 			int local_nid;
 
 			/*
@@ -3854,7 +3863,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * fragmenting fallbacks. Locality is more important
 			 * than fragmentation avoidance.
 			 */
-			local_nid = zonelist_node_idx(ac->preferred_zoneref);
+			local_nid = zone_to_nid(preferred_zone);
 			if (zone_to_nid(zone) != local_nid) {
 				alloc_flags &= ~ALLOC_NOFRAGMENT;
 				goto retry;
@@ -3916,7 +3925,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 				goto try_this_zone;
 
 			if (!node_reclaim_enabled() ||
-			    !zone_allows_reclaim(zonelist_zone(ac->preferred_zoneref), zone))
+			    !zone_allows_reclaim(preferred_zone, zone))
 				continue;
 
 			if (!node_reclaim(zone->zone_pgdat, gfp_mask, order))
@@ -3929,7 +3938,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		}
 
 try_this_zone:
-		page = rmqueue(zonelist_zone(ac->preferred_zoneref), zone, order,
+		page = rmqueue(preferred_zone, zone, order,
 				gfp_mask, alloc_flags, ac->migratetype);
 		if (page) {
 			prep_new_page(page, order, gfp_mask, alloc_flags);
@@ -5184,6 +5193,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 {
 	struct page *page;
 	struct zone *zone;
+	struct zone *preferred_zone;
 	struct zoneref *z;
 	struct per_cpu_pages *pcp;
 	struct list_head *pcp_list;
@@ -5232,6 +5242,11 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &gfp, &alloc_flags))
 		goto out;
 
+	/* Read once; see get_page_from_freelist(). */
+	preferred_zone = READ_ONCE(ac.preferred_zoneref->zone);
+	if (!preferred_zone)
+		goto failed;
+
 	/* Find an allowed local zone that meets the low watermark. */
 	z = ac.preferred_zoneref;
 	for_next_zone_zonelist_nodemask(zone, z, ac.highest_zoneidx, ac.nodemask) {
@@ -5242,8 +5257,8 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 			continue;
 		}
 
-		if (nr_online_nodes > 1 && zone != zonelist_zone(ac.preferred_zoneref) &&
-		    zone_to_nid(zone) != zonelist_node_idx(ac.preferred_zoneref)) {
+		if (nr_online_nodes > 1 && zone != preferred_zone &&
+		    zone_to_nid(zone) != zone_to_nid(preferred_zone)) {
 			goto failed;
 		}
 
@@ -5251,7 +5266,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 retry_this_zone:
 		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK) + nr_pages - nr_populated;
 		if (zone_watermark_fast(zone, 0,  mark,
-				zonelist_zone_idx(ac.preferred_zoneref),
+				zone_idx(preferred_zone),
 				alloc_flags, gfp)) {
 			break;
 		}
@@ -5310,7 +5325,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	pcp_spin_unlock(pcp);
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
-	zone_statistics(zonelist_zone(ac.preferred_zoneref), zone, nr_account);
+	zone_statistics(preferred_zone, zone, nr_account);
 
 out:
 	return nr_populated;
-- 
2.56.0

