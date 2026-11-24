Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795545685;
	b=3Xz2onqwkpHRTllnQ0VSe4H8Y3ZkgKsSGIQFn6ZOyScdN60E8k4upwT0TYqAdy6bV4TZ
	 6GyIaY0JnJ1nE8hk9Xe41KdiH2Gr21y7d+RYFK8Wz9eZc3KUkdJ0ySCZpHORPOxxTcdQ9
	 R+6/pNo0Cd8vKj8NuG8LKksaTEnkjbDqIo170Sdl6Fzi6wmRF3M0Kr80QKnbIRfdOidua
	 jf+Nt353W/fgVNJOKmqcxI/sot/0luaewIorJd3V5aTXRj2hYqzlpIQFrjfN87oO5uXBc
	 ch3lIMHtjDFumcrNQ22F8b7MCJd+lWk6kIIowdzpNTlvGvZuC74jbDimKVB3NH+Ansg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545685;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=m+2Qxb4KEwgXHMupJHko5OK7Cy+4Jk91JdwfZsJm5Ks=;
	b=wvWlQoesowc2QaUusqoDEe+2Pa1AnLLEAgSISB+/cb+X40t1YhWmoQbmoYmLCdTeETwd
	 JwHhd2lGGxYLy6UzUvOvT5VD7C0Oytxr7TZ81/l/idxpGAiPzsPDXGciq+etuCwoT8gnz
	 pMrQWHzQEGRdqBR963/TXLqAJIyAsBS8HxXSNs5r2k5xZlsdJs9ygD8c2vQE8c1FhNeHu
	 oKni55BJzlsXZsDC/WEZpRxDC7PTxVgCxF7/1kDBQmEDcNqLc4Ucm5oPkanwY0ACpucM6
	 QvVn6XT1sPKdSyTTboeOMwBbA/dCbt12iG/rNcoIz9foX4kc3SEfEKlpN3F5RjXkeWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ijKevbUk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B7D606A326
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ijKevbUk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8331F000D2;
	Tue, 24 Nov 2026 18:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795545685;
	bh=m+2Qxb4KEwgXHMupJHko5OK7Cy+4Jk91JdwfZsJm5Ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ijKevbUk/MgHCXCeHJLjh4nfk7/BwOUHZxwIgQakQUDU7BYv7BRH+BblHhwPajgCB
	 s2bboNTGvlg9BFsW+83QgMDnX6AmOFpIbxoWdRmJYycER8Y4ClcWsz+7n3C5DHz64y
	 jKo95+vIl/bJqZAIF7AZSqlqsXk2OSzGitRQcwiUA07RdhVAwP7fdMBnPTWQU03QkA
	 PbKzdtBybfoFJ7tVpjbKtO098mtS9aykaxPy1MpAuGbQm1KGfF3suWi4DbDhNpM3D0
	 i2lwPqEkxyFiwmftRwSQOEirU1FzvPSNbAUWjWwtyIsVjW3eD611x2i3GswjRa7grK
	 rwWMkx313LU4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Shivank Garg <shivankg@amd.com>,
	David Hildenbrand <david@redhat.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] mm: improve code consistency with zonelist_* helper functions
Date: Tue, 24 Nov 2026 13:41:21 -0500
Message-ID: <20261124184032.2321147-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112421-retrace-illusion-ba9a@gregkh>
References: <2026112421-retrace-illusion-ba9a@gregkh>
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

From: Wei Yang <richard.weiyang@gmail.com>

[ Upstream commit 29943248af0a8ac3edb808564baa417b40e35521 ]

Replace direct access to zoneref->zone, zoneref->zone_idx, or
zone_to_nid(zoneref->zone) with the corresponding zonelist_* helper
functions for consistency.

No functional change.

Link: https://lkml.kernel.org/r/20240729091717.464-1-shivankg@amd.com
Co-developed-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 6c48b3ab4ee4 ("mm, page_alloc: pass zone pointer to trace_reclaim_retry_zone")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mmzone.h     |  4 ++--
 include/trace/events/oom.h |  4 ++--
 mm/mempolicy.c             |  4 ++--
 mm/mmzone.c                |  2 +-
 mm/page_alloc.c            | 22 +++++++++++-----------
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 7951de0ca970e..f0a0288bafc7b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1524,7 +1524,7 @@ static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
 			zone = zonelist_zone(z))
 
 #define for_next_zone_zonelist_nodemask(zone, z, highidx, nodemask) \
-	for (zone = z->zone;	\
+	for (zone = zonelist_zone(z);	\
 		zone;							\
 		z = next_zones_zonelist(++z, highidx, nodemask),	\
 			zone = zonelist_zone(z))
@@ -1560,7 +1560,7 @@ static inline bool movable_only_nodes(nodemask_t *nodes)
 	nid = first_node(*nodes);
 	zonelist = &NODE_DATA(nid)->node_zonelists[ZONELIST_FALLBACK];
 	z = first_zones_zonelist(zonelist, ZONE_NORMAL,	nodes);
-	return (!z->zone) ? true : false;
+	return (!zonelist_zone(z)) ? true : false;
 }
 
 
diff --git a/include/trace/events/oom.h b/include/trace/events/oom.h
index b799f3bcba823..8c834a0d22817 100644
--- a/include/trace/events/oom.h
+++ b/include/trace/events/oom.h
@@ -55,8 +55,8 @@ TRACE_EVENT(reclaim_retry_zone,
 	),
 
 	TP_fast_assign(
-		__entry->node = zone_to_nid(zoneref->zone);
-		__entry->zone_idx = zoneref->zone_idx;
+		__entry->node = zonelist_node_idx(zoneref);
+		__entry->zone_idx = zonelist_zone_idx(zoneref);
 		__entry->order = order;
 		__entry->reclaimable = reclaimable;
 		__entry->available = available;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index a8e990a6aa0c0..bfc94fb823608 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1925,7 +1925,7 @@ unsigned int mempolicy_slab_node(void)
 		zonelist = &NODE_DATA(node)->node_zonelists[ZONELIST_FALLBACK];
 		z = first_zones_zonelist(zonelist, highest_zoneidx,
 							&policy->nodes);
-		return z->zone ? zone_to_nid(z->zone) : node;
+		return zonelist_zone(z) ? zonelist_node_idx(z) : node;
 	}
 	case MPOL_LOCAL:
 		return node;
@@ -2617,7 +2617,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 				node_zonelist(numa_node_id(), GFP_HIGHUSER),
 				gfp_zone(GFP_HIGHUSER),
 				&pol->nodes);
-		polnid = zone_to_nid(z->zone);
+		polnid = zonelist_node_idx(z);
 		break;
 
 	default:
diff --git a/mm/mmzone.c b/mm/mmzone.c
index 68e1511be12de..9e268ee0a34db 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -66,7 +66,7 @@ struct zoneref *__next_zones_zonelist(struct zoneref *z,
 			z++;
 	else
 		while (zonelist_zone_idx(z) > highest_zoneidx ||
-				(z->zone && !zref_in_nodemask(z, nodes)))
+				(zonelist_zone(z) && !zref_in_nodemask(z, nodes)))
 			z++;
 
 	return z;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ba7f386331a65..5b5a64db3f3be 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4303,7 +4303,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		}
 
 		if (no_fallback && nr_online_nodes > 1 &&
-		    zone != ac->preferred_zoneref->zone) {
+		    zone != zonelist_zone(ac->preferred_zoneref)) {
 			int local_nid;
 
 			/*
@@ -4311,7 +4311,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * fragmenting fallbacks. Locality is more important
 			 * than fragmentation avoidance.
 			 */
-			local_nid = zone_to_nid(ac->preferred_zoneref->zone);
+			local_nid = zonelist_node_idx(ac->preferred_zoneref);
 			if (zone_to_nid(zone) != local_nid) {
 				alloc_flags &= ~ALLOC_NOFRAGMENT;
 				goto retry;
@@ -4340,7 +4340,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 				goto try_this_zone;
 
 			if (!node_reclaim_enabled() ||
-			    !zone_allows_reclaim(ac->preferred_zoneref->zone, zone))
+			    !zone_allows_reclaim(zonelist_zone(ac->preferred_zoneref), zone))
 				continue;
 
 			ret = node_reclaim(zone->zone_pgdat, gfp_mask, order);
@@ -4362,7 +4362,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		}
 
 try_this_zone:
-		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
+		page = rmqueue(zonelist_zone(ac->preferred_zoneref), zone, order,
 				gfp_mask, alloc_flags, ac->migratetype);
 		if (page) {
 			prep_new_page(page, order, gfp_mask, alloc_flags);
@@ -5152,7 +5152,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 */
 	ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
 					ac->highest_zoneidx, ac->nodemask);
-	if (!ac->preferred_zoneref->zone)
+	if (!zonelist_zone(ac->preferred_zoneref))
 		goto nopage;
 
 	/*
@@ -5164,7 +5164,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		struct zoneref *z = first_zones_zonelist(ac->zonelist,
 					ac->highest_zoneidx,
 					&cpuset_current_mems_allowed);
-		if (!z->zone)
+		if (!zonelist_zone(z))
 			goto nopage;
 	}
 
@@ -5544,8 +5544,8 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 			continue;
 		}
 
-		if (nr_online_nodes > 1 && zone != ac.preferred_zoneref->zone &&
-		    zone_to_nid(zone) != zone_to_nid(ac.preferred_zoneref->zone)) {
+		if (nr_online_nodes > 1 && zone != zonelist_zone(ac.preferred_zoneref) &&
+		    zone_to_nid(zone) != zonelist_node_idx(ac.preferred_zoneref)) {
 			goto failed;
 		}
 
@@ -5604,7 +5604,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	pcp_trylock_finish(UP_flags);
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
-	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
+	zone_statistics(zonelist_zone(ac.preferred_zoneref), zone, nr_account);
 
 out:
 	return nr_populated;
@@ -5662,7 +5662,7 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 	 * Forbid the first pass from falling back to types that fragment
 	 * memory until all local zones are considered.
 	 */
-	alloc_flags |= alloc_flags_nofragment(ac.preferred_zoneref->zone, gfp);
+	alloc_flags |= alloc_flags_nofragment(zonelist_zone(ac.preferred_zoneref), gfp);
 
 	/* First allocation attempt */
 	page = get_page_from_freelist(alloc_gfp, order, alloc_flags, &ac);
@@ -6633,7 +6633,7 @@ int local_memory_node(int node)
 	z = first_zones_zonelist(node_zonelist(node, GFP_KERNEL),
 				   gfp_zone(GFP_KERNEL),
 				   NULL);
-	return zone_to_nid(z->zone);
+	return zonelist_node_idx(z);
 }
 #endif
 
-- 
2.53.0

