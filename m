Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546425;
	b=f7MVC3yF6Ka2lZlAxihq4GHBe1pEIijqMTElYaqR4Sc747Qy1q8GbwBY5dewdKiO+ebz
	 vnNNRM58x8SYO+feQE8pREw60kiBCL6j90h2RtnCFXBkPM1Q6VUC+ymV2cKKFVef2fTUX
	 EYY3KsKnsm2b2n1TFF6ZWppPC+i1yQifhT2WoUchipwGyP2vEZZ/xoouV0m5IgLMQzXiX
	 3Lws1MeLQroOyyglExn4vRyG/idWu2A1yI96oXmR0YOEViYGcKqbPe+84WjhIu1ZGrnMQ
	 YhIwwfO77gJzzGUa2/JkVAvigNcG33N7YSWCA4PNj5wf9j1/yu6LZf8bzWor8Uy3CSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546425;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BiS4m4PXKgEGL9gNkNNsaqod9+1Qf8ydz71uXOyylVc=;
	b=wn4K26vaHsewboLuYDzoviYwrJxebdT3a2XcsVhEr+nnfLsm9fQMrVLcNdKsvN5yx/nB
	 KA58Q7QRLoyhHBEuHAuu2soBeOUd/sD4/zZKmvBEo8sNc47un7N0Z8u/ARkk3JlDwPFLy
	 Uc81yrs7hzm4W4IlOgNRZSXH69jzvxyy3A/6Iy/rzBzubcQwddFwDEIdauSDpzjzRV5ZM
	 TrCy5MHU9gr6coBh4xunUNeI8XZROfFA9BOzY9p+sZ82dbvlPKxRoPe4UgRlOc2J+W13y
	 C7jPUsR1TkRiX626/WhP4MXWa06qoFfsHD8Jq1vSCyhyuepKbPU3C58WAlEsmsf5atA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KaLRad0f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EF2606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KaLRad0f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F9F1F000C6;
	Tue, 24 Nov 2026 18:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795546425;
	bh=BiS4m4PXKgEGL9gNkNNsaqod9+1Qf8ydz71uXOyylVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KaLRad0fW9Yh+3rZ+1pm+kvoEE2qBmJ278U6TEIizILKVaZo+b6VxG41mmeqKD9BZ
	 T9k5m+ezdN8D2lGc6B6JYR2XzikE97hoLrDWKe9PRBcOkYsqZatxMmFuZUsutxwOGS
	 pTFOb9tk9fkA+hsPvohsC8XEolQAlAB8xystmi8wSvbi6MEojrrIX5RI+120AteaCG
	 kXzaJVwR5rbHE8zYWcEvkhN41DF3zRik9ZGw9op6ajScCxO19cGM/AxSCLBApiFwm4
	 WxJ96mi0XDnAWQxaFdZK7lpeim2m3FW5sVnMTH+HiUnTBflkmyst9n269xBra4NCak
	 Yihjmk1ehQ4RQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gregory Price <gourry@gourry.net>,
	David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] page_alloc: allow migration of smaller hugepages during contig_alloc
Date: Tue, 24 Nov 2026 13:53:41 -0500
Message-ID: <20261124184358.2182291-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112435-unnoticed-capsule-b761@gregkh>
References: <2026112435-unnoticed-capsule-b761@gregkh>
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

From: Gregory Price <gourry@gourry.net>

[ Upstream commit 3bb64898f00368cd110d4b31334f93251d56b404 ]

We presently skip regions with hugepages entirely when trying to do
contiguous page allocation.  This will cause otherwise-movable 2MB HugeTLB
pages to be considered unmovable, and makes 1GB gigantic page allocation
less reliable on systems utilizing both.

Commit 4d73ba5fa710 ("mm: page_alloc: skip regions with hugetlbfs pages
when allocating 1G pages") skipped all HugePage containing regions because
it can cause significant delays in 1G allocation (as HugeTLB migrations
may fail for a number of reasons).

Instead, if hugepage migration is enabled, consider regions with hugepages
smaller than the target contiguous allocation request as valid targets for
allocation.

We optimize for the existing behavior by searching for non-hugetlb regions
in a first pass, then retrying the search to include hugetlb only on
failure.  This allows the existing fast-path to remain the default case
with a slow-path fallback to increase reliability.

We only fallback to the slow path if a hugetlb region was detected, and we
do a full re-scan because the zones/blocks may have changed during the
first pass (and it's not worth further complexity).

isolate_migrate_pages_block() has similar hugetlb filter logic, and the
hugetlb code does a migratable check in folio_isolate_hugetlb() during
isolation.  The code servicing the allocation and migration already
supports this exact use case.

To test, allocate a bunch of 2MB HugeTLB pages (in this case 48GB) and
then attempt to allocate some 1G HugeTLB pages (in this case 4GB) (Scale
to your machine's memory capacity).

echo 24576 > .../hugepages-2048kB/nr_hugepages
echo 4 > .../hugepages-1048576kB/nr_hugepages

Prior to this patch, the 1GB page reservation can fail if no contiguous
1GB pages remain.  After this patch, the kernel will try to move 2MB pages
and successfully allocate the 1GB pages (assuming overall sufficient
memory is available).  Also tested this while a program had the 2MB
reservations mapped, and the 1GB reservation still succeeds.

folio_alloc_gigantic() is the primary user of alloc_contig_pages(),
other users are debug or init-time allocations and largely unaffected.
- ppc/memtrace is a debugfs interface
- x86/tdx memory allocation occurs once on module-init
- kfence/core happens once on module (late) init
- THP uses it in debug_vm_pgtable_alloc_huge_page at __init time

Link: https://lkml.kernel.org/r/20251221124656.2362540-1-gourry@gourry.net
Signed-off-by: Gregory Price <gourry@gourry.net>
Suggested-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/linux-mm/6fe3562d-49b2-4975-aa86-e139c535ad00@redhat.com/
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: da0d7a895e90 ("mm/page_alloc: retry alloc_contig_pages() when the zonelist is rebuilt")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 59 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 074178f4d7a07..18c0e6d2ba298 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7230,7 +7230,8 @@ static int __alloc_contig_pages(unsigned long start_pfn,
 }
 
 static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
-				   unsigned long nr_pages)
+				   unsigned long nr_pages, bool skip_hugetlb,
+				   bool *skipped_hugetlb)
 {
 	unsigned long i, end_pfn = start_pfn + nr_pages;
 	struct page *page;
@@ -7246,8 +7247,42 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
 		if (PageReserved(page))
 			return false;
 
-		if (PageHuge(page))
-			return false;
+		/*
+		 * Only consider ranges containing hugepages if those pages are
+		 * smaller than the requested contiguous region.  e.g.:
+		 *     Move 2MB pages to free up a 1GB range.
+		 *     Don't move 1GB pages to free up a 2MB range.
+		 *
+		 * This makes contiguous allocation more reliable if multiple
+		 * hugepage sizes are used without causing needless movement.
+		 */
+		if (PageHuge(page)) {
+			unsigned int order;
+
+			if (!IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION))
+				return false;
+
+			if (skip_hugetlb) {
+				*skipped_hugetlb = true;
+				return false;
+			}
+
+			page = compound_head(page);
+			order = compound_order(page);
+			if ((order >= MAX_FOLIO_ORDER) ||
+			    (nr_pages <= (1 << order)))
+				return false;
+
+			/*
+			 * Reaching this point means we've encounted a huge page
+			 * smaller than nr_pages, skip all pfn's for that page.
+			 *
+			 * We can't get here from a tail-PageHuge, as it implies
+			 * we started a scan in the middle of a hugepage larger
+			 * than nr_pages - which the prior check filters for.
+			 */
+			i += (1 << order) - 1;
+		}
 	}
 	return true;
 }
@@ -7290,7 +7325,10 @@ struct page *alloc_contig_pages_noprof(unsigned long nr_pages, gfp_t gfp_mask,
 	struct zonelist *zonelist;
 	struct zone *zone;
 	struct zoneref *z;
+	bool skip_hugetlb = true;
+	bool skipped_hugetlb = false;
 
+retry:
 	zonelist = node_zonelist(nid, gfp_mask);
 	for_each_zone_zonelist_nodemask(zone, z, zonelist,
 					gfp_zone(gfp_mask), nodemask) {
@@ -7298,7 +7336,9 @@ struct page *alloc_contig_pages_noprof(unsigned long nr_pages, gfp_t gfp_mask,
 
 		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
 		while (zone_spans_last_pfn(zone, pfn, nr_pages)) {
-			if (pfn_range_valid_contig(zone, pfn, nr_pages)) {
+			if (pfn_range_valid_contig(zone, pfn, nr_pages,
+						   skip_hugetlb,
+						   &skipped_hugetlb)) {
 				/*
 				 * We release the zone lock here because
 				 * alloc_contig_range() will also lock the zone
@@ -7317,6 +7357,17 @@ struct page *alloc_contig_pages_noprof(unsigned long nr_pages, gfp_t gfp_mask,
 		}
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}
+	/*
+	 * If we failed, retry the search, but treat regions with HugeTLB pages
+	 * as valid targets.  This retains fast-allocations on first pass
+	 * without trying to migrate HugeTLB pages (which may fail). On the
+	 * second pass, we will try moving HugeTLB pages when those pages are
+	 * smaller than the requested contiguous region size.
+	 */
+	if (skip_hugetlb && skipped_hugetlb) {
+		skip_hugetlb = false;
+		goto retry;
+	}
 	return NULL;
 }
 #endif /* CONFIG_CONTIG_ALLOC */
-- 
2.53.0

