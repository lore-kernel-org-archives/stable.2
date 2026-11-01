Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499237;
	b=GL9P0kGLGn6k6adYC4U/clwbtgVU3dw0aOt3if5cN0kK6NLebfZgR9kvuCORnWRABmWf
	 fkr2YO1rlR/hLl16iv4pLf6nBHpb6Ntt51BpMc3L+Bn6qhkb67jpU0QnYHKLW2hJ2uZcg
	 BEgfc/jtXZE62hoR2Vryr/XIM1HTNRYGO+Ox76XzmNla56ltqCq6oalptxV6MIQ/QHF8B
	 VOKS573tVd40LUxmd0ZVnn7Nmkz+4XOnky70RsKsXlN3PL8HNrczIL57ZtEj9oqu6qMMZ
	 n2/+S5LdtDjbK7JgvMOtLEnB9C+hrpI1ymu4R7GONN0E9ZYfTmSRCNq0CCHO166XbUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bfcQbHHTje9Qk+CY4i9Q1tMr84K/2Do4+uTd71vDbHQ=;
	b=bZbzsLKdnR6mL/IKXExd3F7l5EVdAqEdm0CrfiCTx4S75DYUj8GIxQA6sqao4NSu4NTI
	 S+ZK34FzU/gMFd++cn/dquhODBUHGRTLHBqxyeUk85WWlHFgiyC5fQ73mcTwJAiI3Ecmd
	 DEB/I0WcQKIlqd8cN/2afkHsZRROteecBcNnTACC0fLNXw9nGAIjwreVfTmpmZPFUkMA5
	 cEmLsUDlFStiB4RiIBwrzruwRgzFz+Cea99rY+nZErNMiAPLXqKQ1i8l0PCjHBXQP6yNX
	 GvquR0XzIcACBZykW7e+Z2/q7HDaHWY3L53WwpbmZvd2gF5FEEYa2rdb78nFClCcEEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Zw76JQjb;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8624160A260D
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 02:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8624160A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Zw76JQjb
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f3c616c84so171412985a.1
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 19:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793499236; x=1794104036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bfcQbHHTje9Qk+CY4i9Q1tMr84K/2Do4+uTd71vDbHQ=;
        b=Zw76JQjb64/g/oHgoR4RwK+I3+edEcQMK/mldUIlOwSuJ5ixWvJsSEcCOlw3knbcML
         mW8SxKo8YPkDFeGbe5gyLDBf/pkvGEn7bTPswbaHVfPG1YQBL0dn2Nxev7fsG/MjosXR
         MefnbhdYbo+xygEwZwECaAeEFR4+uAdfALCYyU22IrLBIHgN1zUj68Pi2+H4hYLNuPbw
         2ELbuf5G1vedunp/DHwQ8ENG62NAyDiwE0eRt2LY2g13DReG2B1nKPQooTG8rzDnXHMo
         Rlncjx3f+l7N2mXL6FIPxNIpAg0y4mobCccVLa+AnutKbnq3OpRXiESOqDdYaDs7z58M
         SZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793499236; x=1794104036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bfcQbHHTje9Qk+CY4i9Q1tMr84K/2Do4+uTd71vDbHQ=;
        b=rWBQPm1SIjqvlRyYHenAnQi+BDbVURWV2x9fn2qeRzKmrf/vAvNMPm4R7Uv335tl4z
         hmcQaaKR361wAR5rdKFRn7I+lMw5DmZNWawRHlBfoRab9j5B4opBPeKo/k4QpInmV8ZH
         F7H9grRluIgQ/RCx4A+MUoG02ZHQbGjHyvpqAKCvW+pX4rOFBrsId02U5WZU44feMbVR
         RO4WzTAcd6JuH0Rdp4WBnCsz9zbd9k1MGe3uj7I10FVeXoDNLxNDt61r7s3mjGvje3mE
         PoO1onj/IBlqd4DiPyopDT58SAJkJXLdZTrxAB5RfyHALSNGcl6rmn2/oP96pUCiFyrl
         /BXQ==
X-Forwarded-Encrypted: i=1; AKwUvBxp5k3+0wVpbHPB76bRDdnAp9+46/HnJ25uWVIASF9Gc1vDuqTrGqACRVMkd0W+jJ/7f4pNchI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJgGAyZsWeyhSBkLpdE0ag0RskiJT4gs7bcnOOWM+qS/GaQdBZa
	9W835FMN/eob4tnuxomyi6W/lfx2NHRGkTePGEcT5BEVlgcRgzDd/LbUrcCoSZi2+Ic=
X-Gm-Gg: AYBFou35lSOVtvYPU0glYFafU7PMAbe4KmEEOznbAl7CU0OVvV3nykSFoPx59tbHkJL
	mQi9s2yxTm4h8Z9ANaifJqxMYh0dK5e07ZcF5uKpwXBLv45f0n97fYuWgeCLPBtvxPeGkwSBWpr
	hk7o3bmm6GFdbw6ZeVj3jKG5bV/6nplN5WSXh6GhVNuspUm+Od1BDjYAF8hDZ4quBldMR1yOoK5
	3wO8hGH4nVi3JZm5faYrSksspvf6Ibb20WWegmGPn2gi+D1c4tmnVIaaqfS2wEDuLz2NyADydsG
	iKpGLEDmHr/qa1sCjzW3f2oofG1ghejyK0yO56C185mwyAwyvWJpgf1H+UC+ylufn68E4m+HL6x
	If5/6uKz2nzPftZO+/GJqGyX+CFVVsmah1jisUb3G8WDyOL4iia7COt/pJixl4h6nXMNMYdh72R
	pgiKHvB16Qcz146zsywA2WfDoaq9DShZMaivwVkz4OLsen7wWxZIPH/sOJBPiWlbQBlU+tKWWSI
	XKNT4RsRE/R/wb+KpSm+SR0JM1uYo/bgOHCGp7KgaKV3PgrJKQvwQou/MWaikUlDR1xyn/VBSkq
	s8eXxpwllX0Fvz0y5ax2JimoWEbpb09QKWKTfA6aSFnrLTqIDvVc951V3gXH+VLwWAYzDVmTll8
	r6HCmcwjM0A==
X-Received: by 2002:a05:620a:4555:b0:93e:942f:b8b1 with SMTP id af79cd13be357-9442173ddb2mr1115363085a.64.1793499236470;
        Sat, 31 Oct 2026 19:13:56 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425858552sm498131985a.18.2026.10.31.19.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 19:13:56 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	gourry@gourry.net,
	ziy@nvidia.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	Bessel.Wang@huawei.com,
	jiang.liu@huawei.com,
	mgorman@techsingularity.net,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH v5 06/12] mm/page_alloc: snapshot the preferred zone against shrink rebuilds
Date: Sat, 31 Oct 2026 22:13:34 -0400
Message-ID: <20261101021340.2251928-7-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101021340.2251928-1-gourry@gourry.net>
References: <20261101021340.2251928-1-gourry@gourry.net>
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
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/page_alloc.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 11be12b443ad..28d46f987685 100644
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
+	preferred_zone = zonelist_zone(ac->preferred_zoneref);
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
@@ -5169,6 +5178,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 {
 	struct page *page;
 	struct zone *zone;
+	struct zone *preferred_zone;
 	struct zoneref *z;
 	struct per_cpu_pages *pcp;
 	struct list_head *pcp_list;
@@ -5217,6 +5227,11 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &gfp, &alloc_flags))
 		goto out;
 
+	/* Read once; see get_page_from_freelist(). */
+	preferred_zone = zonelist_zone(ac.preferred_zoneref);
+	if (!preferred_zone)
+		goto failed;
+
 	/* Find an allowed local zone that meets the low watermark. */
 	z = ac.preferred_zoneref;
 	for_next_zone_zonelist_nodemask(zone, z, ac.highest_zoneidx, ac.nodemask) {
@@ -5227,8 +5242,8 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 			continue;
 		}
 
-		if (nr_online_nodes > 1 && zone != zonelist_zone(ac.preferred_zoneref) &&
-		    zone_to_nid(zone) != zonelist_node_idx(ac.preferred_zoneref)) {
+		if (nr_online_nodes > 1 && zone != preferred_zone &&
+		    zone_to_nid(zone) != zone_to_nid(preferred_zone)) {
 			goto failed;
 		}
 
@@ -5236,7 +5251,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 retry_this_zone:
 		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK) + nr_pages - nr_populated;
 		if (zone_watermark_fast(zone, 0,  mark,
-				zonelist_zone_idx(ac.preferred_zoneref),
+				zone_idx(preferred_zone),
 				alloc_flags, gfp)) {
 			break;
 		}
@@ -5295,7 +5310,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	pcp_spin_unlock(pcp);
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
-	zone_statistics(zonelist_zone(ac.preferred_zoneref), zone, nr_account);
+	zone_statistics(preferred_zone, zone, nr_account);
 
 out:
 	return nr_populated;
-- 
2.56.0

