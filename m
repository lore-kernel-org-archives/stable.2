Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430636;
	b=kfIbZ4brEqop6Cd5YbXrOuGcVzpMhsQ5vQV2Csy6ghCnx5urcjjMkomb1PCfZbAq/gER
	 QvS8ihNFXhTZlRqhUqCzI0RZFzle1HgNMyDOKQJ/mLyUga5PThAsLdg+uk2qdnYutceCU
	 fJ8AMk5HBf/gmyagbbcjRXcKja5wJE2xKatOgVkJ9B29TZ3R7DeSMJTRJ2ZhM8kzhQqZA
	 HD5AgYTEe0aegV3NlwDxa3C9QOMHbirUdd3coGGAXdKTCr6xYOih6Ed8Ff8Nx8wB8yjic
	 x0b4E+MTlbv/wRoQ019uiifvWTq/2Fm8jfVwYGLBfa8THidUAg0/C4DFJFWHtGF9qZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430636;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=f1NZpg4bEcv0tM4rCujJL7YKJxmpUNmsXISBuFDoLRI=;
	b=XVN0V0mX5BHXwO/+xkD3W266w2bj3FIA1ZJBagN6Kj0pmCLgOc8zja8hzy2QZziCdGuP
	 96BjN/oC7rceDhYdptFTXoY31uPddp43xRs6Dx1dLYQUt6LUxuXVI6KlH1JEqddmjGe9T
	 7b7N5JHI0VtFKTDwpC6kbXGXiTxifE7LoB9RWJ9/8M/gfJDP/6Z+BIHPrhlzQGNs7XVvb
	 8o/Jd8qgc+cMabR1Ao+SU8eqZFs27Z3tt+QLNUh+8pfp9stB9BxMfIjISKpqfNygsy3X+
	 1IsL6QoKi8W3EDwXYKgOOchGs/TYiE4m4Q7xMvd5oWQFuVn0f2AWsqiy/xvpUFB4dCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Uu8sLPAG;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C3260A260B
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 17:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2C3260A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Uu8sLPAG
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93f2b8cf037so184380585a.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 10:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792430634; x=1793035434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f1NZpg4bEcv0tM4rCujJL7YKJxmpUNmsXISBuFDoLRI=;
        b=Uu8sLPAGqDZN+suqxT8ZQWRMn/htuaE0tJ2cUywE8fjiHhARlGw1GGcitiWPj1+5GO
         990U77/tks3Xb+ctWFXCSuXFW2Ej7ibzH0gprDmh8rErsgLfBXoBMJr64s+OCLjY3fTC
         +BRH1/SU79wWrJCIZA+Hyc33DVhhpXrAPcxg+CF4z4nexGYbHUjW0ydOBcoVTH8TrW01
         fhT0Fhc7MCasG4vnK0G8eg5EP1EZlGCrb5Yx53K+USOuIylWOa6edYQtTFqMLrtLj5L2
         oazmoA/6Fyeqt+CoWRwaQ7rcM/4qQrR28moWZQZbQutPfMS4tafHQxFJC07uzVR5q7n0
         2JPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792430634; x=1793035434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f1NZpg4bEcv0tM4rCujJL7YKJxmpUNmsXISBuFDoLRI=;
        b=cQWHiX0vnK2KAKs060aZapXQ9R5b7rWhg53+KM0C6iWR0z8z02CPVfGz8mQ8MpaC1G
         mHRyKQKuIA/bmRvxKZa9d6CwN36SbemeUmQ/erWQTP9P5rx+tYjK3jwaek4aU1hi822Y
         xjPu6uOVjZ+OMPNLIVPtehwQOUyxf7X0/RoWIaku2vRL/Bcn6/ls+bUaeoipgwdGRAcv
         9HuJoOO7zN6plQHZIgoOlMgqQTrIWaZs2arQ6aq0iGB/fegklPLpKpEsO3ZVxymd3XVu
         QQ9wPIW0O28afxEkXxH2905xGVgHfJo3HJMilI9PsNysSiFs4VSEhAxTuQvmNMgPEzso
         5cFA==
X-Forwarded-Encrypted: i=1; AKwUvBxMoZCuW0TSKgB66kDo9a08baePXswrxXVDeGd4D8Yn5WFPpboEe/bavGQmHMbwb9wQu8/G0lg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjF5FtLNYMCCt2lcTPFQkFKixcUl2Ycqy8A/3exu7YH2WoPlP0
	qGvFag3taljvTKqIRQcmscnXhqeaP39NasYOWapinsMuwqEI9GNbbvvcjVM+ShIgGwo=
X-Gm-Gg: AYBFou2A/XCYFL5vLaSPtjkZyr/UZKJ46Wx3Cc/VPT18cDdVLn7/VULLuqM7vQdS6mX
	W80pDy4YHKsCudA+J3Q+6h7thiikQxInA0ywcubnj9lnxqQAjOYyHiTxHpuRqT94adUx5VC5NeN
	NBVqnPCnZmKL20mOtN+v19S/+V7M6PGMYdCnQlzaN7wKaEHP7YgVZ+jxqFOU+3wBnVlQk8YLLKT
	AhZPkLYpP4TVCUpP+kSNJofc+CQhmOPTilr8QruoBzAWcTQcbffuaiHXKBjnupCO3aYo93u3D40
	SnmNpq89S/b+pThMTMx19edTqcVr/cs3j1u4xHw2YZfQTwz4e4yAtajCWsS2zeQHiSiIDfYDeEQ
	9/UFIT8neRUaVZ0rO0kE7gc5lNMOA9Ia7uB38R8neOA/zBhSZRd1IADwjRL84eLQLpPeNlOHlRc
	cgHEQHzOzVwsWIrrjVgbzYuUL2Zz8aOlH2YuGIB+4JPXr6Veufor5uu3O0fv+iy51sH4HUrbtbF
	3CeZ1l6+FSQUkChE2Fo/TZSFbGfr2sThbPl6/eJ0XvuLX5R8zhfB2v8RUzh
X-Received: by 2002:a05:620a:3711:b0:939:733d:cbe0 with SMTP id af79cd13be357-93f29b48f16mr1396488385a.3.1792430634536;
        Mon, 19 Oct 2026 10:23:54 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f4adb28c2sm14615385a.0.2026.10.19.10.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:23:53 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	mgorman@techsingularity.net,
	jiang.liu@huawei.com,
	Bessel.Wang@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH v2 3/5] mm/page_alloc: snapshot the preferred zone against shrink rebuilds
Date: Mon, 19 Oct 2026 13:23:43 -0400
Message-ID: <20261019172346.3344005-4-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019172346.3344005-1-gourry@gourry.net>
References: <20261019172346.3344005-1-gourry@gourry.net>
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

Fixes: c33d6c06f60f7 ("mm, page_alloc: avoid looking up the first zone in a zonelist twice")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index aa3cd44fdaa5b..75a440ebcead6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3807,12 +3807,21 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
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
@@ -3862,7 +3871,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		}
 
 		if (no_fallback && !defrag_mode && nr_online_nodes > 1 &&
-		    zone != zonelist_zone(ac->preferred_zoneref)) {
+		    zone != preferred_zone) {
 			int local_nid;
 
 			/*
@@ -3870,7 +3879,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * fragmenting fallbacks. Locality is more important
 			 * than fragmentation avoidance.
 			 */
-			local_nid = zonelist_node_idx(ac->preferred_zoneref);
+			local_nid = zone_to_nid(preferred_zone);
 			if (zone_to_nid(zone) != local_nid) {
 				alloc_flags &= ~ALLOC_NOFRAGMENT;
 				goto retry;
@@ -3932,7 +3941,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 				goto try_this_zone;
 
 			if (!node_reclaim_enabled() ||
-			    !zone_allows_reclaim(zonelist_zone(ac->preferred_zoneref), zone))
+			    !zone_allows_reclaim(preferred_zone, zone))
 				continue;
 
 			if (!node_reclaim(zone->zone_pgdat, gfp_mask, order))
@@ -3945,7 +3954,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		}
 
 try_this_zone:
-		page = rmqueue(zonelist_zone(ac->preferred_zoneref), zone, order,
+		page = rmqueue(preferred_zone, zone, order,
 				gfp_mask, alloc_flags, ac->migratetype);
 		if (page) {
 			prep_new_page(page, order, gfp_mask, alloc_flags);
@@ -5199,6 +5208,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 {
 	struct page *page;
 	struct zone *zone;
+	struct zone *preferred_zone;
 	struct zoneref *z;
 	struct per_cpu_pages *pcp;
 	struct list_head *pcp_list;
@@ -5247,6 +5257,11 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
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
@@ -5260,8 +5275,8 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 			continue;
 		}
 
-		if (nr_online_nodes > 1 && zone != zonelist_zone(ac.preferred_zoneref) &&
-		    zone_to_nid(zone) != zonelist_node_idx(ac.preferred_zoneref)) {
+		if (nr_online_nodes > 1 && zone != preferred_zone &&
+		    zone_to_nid(zone) != zone_to_nid(preferred_zone)) {
 			goto failed;
 		}
 
@@ -5269,7 +5284,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 retry_this_zone:
 		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK) + nr_pages - nr_populated;
 		if (zone_watermark_fast(zone, 0,  mark,
-				zonelist_zone_idx(ac.preferred_zoneref),
+				zone_idx(preferred_zone),
 				alloc_flags, gfp)) {
 			break;
 		}
@@ -5328,7 +5343,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	pcp_spin_unlock(pcp);
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
-	zone_statistics(zonelist_zone(ac.preferred_zoneref), zone, nr_account);
+	zone_statistics(preferred_zone, zone, nr_account);
 
 out:
 	return nr_populated;
-- 
2.53.0-Meta

