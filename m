Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551611;
	b=WBbcCTbCzH1oxuge0xSPfWIvL9E0ffaz778c0PVTTcKtY6wnGaHoaAOZeOu76bR0DvT/
	 4StM0cgeVB/BBSCN19Clb8QulaJdtgPpU+eA05HqeavH6imd57R9zzA2kUXG2CyMpwZtJ
	 UVm9Jog+60g6/LmCiRzALkjpR0stPonHmrCnmINYwn7nf7327kbIqTI/BUecxX6hA/iqC
	 qobAgvfwthcKhGq+GV7AeIq4apnQBKeGwcIdRxRtohPsmde9ANLtvFeGSGr9c2yocUXGM
	 QV4iVTQXelmcHc7lrYHU5fIQ8L+MqSc3+ldYyhSGNAoPmOm4IGJIbD5ncojrPKKABEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551611;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EhuMLGWO6ZCZM0+mIrcho8XnGB/eBtbLUdTmg3mSHh4=;
	b=TZvtjcI0wvrVjFgApB2smTwWqis/8qNhEza/MBbAdBs+cWr7eRoYCptXGjItszyICWov
	 JBbMDLuRs31PlmD1wYvtOX1621I0MdY1gnhSH6RqcnF7sxPMPjiN/7sNX8PcmlsEFd3OP
	 //vJItA/D0zFlvnJVebjAfEgKxAy2kLePO+o/hJE7epstaOlqAIhQeiZegP/bwNIg45Gr
	 1zjObAxcV5gR4KeKG1IMMWf3hnN2sv6rET/U20fW2gApSw65ZZacfsTM0KR8gh14Nx3gb
	 DBvTC3Ycd/IUTPsEq4pPBDfUtitLdsd2r2aVlQp+YvBWE71K0seEtybmRgM4ulM9pCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cdk9P/6V";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43269606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cdk9P/6V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224031F000C6;
	Tue, 24 Nov 2026 20:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795551610;
	bh=EhuMLGWO6ZCZM0+mIrcho8XnGB/eBtbLUdTmg3mSHh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cdk9P/6VVgoUAZXgKdynXoRV4k/sux/G3gNEJsqvckaEMngL0hg0TS0vOwGPwxRlD
	 0XGmMjC14aR6qQomCIKsXurpTiWa7fc48/LyPArfRaT97XRfgQnroVsIcz/Nz3ITGa
	 V7vjIAAdVm14fLilE+OVSDam8nc4N1cA8fqny8lcUhHX4qOIORzELGq+nB1nXKBfW3
	 LUvsFfm/6b85A8B/GXlXUhCbNivo+fUCen4gzi67obozBBJvKC53MTy9rhkz4Ig+hz
	 bEMeb/p7x4LEXwC0uJFwtPp6mL62ggVP4p29nE6k8SH/rbRzi1rRziN6yydVFIw4y3
	 tydfyPtuvqPbA==
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
Subject: [PATCH 6.12.y 1/2] page_alloc: allow migration of smaller hugepages during contig_alloc
Date: Tue, 24 Nov 2026 15:20:06 -0500
Message-ID: <20261124200953.2516046-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112436-division-scalding-7339@gregkh>
References: <2026112436-division-scalding-7339@gregkh>
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
index e9aadaf6e91b6..af979e29c7996 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6851,7 +6851,8 @@ static int __alloc_contig_pages(unsigned long start_pfn,
 }
 
 static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
-				   unsigned long nr_pages)
+				   unsigned long nr_pages, bool skip_hugetlb,
+				   bool *skipped_hugetlb)
 {
 	unsigned long i, end_pfn = start_pfn + nr_pages;
 	struct page *page;
@@ -6867,8 +6868,42 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
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
@@ -6911,7 +6946,10 @@ struct page *alloc_contig_pages_noprof(unsigned long nr_pages, gfp_t gfp_mask,
 	struct zonelist *zonelist;
 	struct zone *zone;
 	struct zoneref *z;
+	bool skip_hugetlb = true;
+	bool skipped_hugetlb = false;
 
+retry:
 	zonelist = node_zonelist(nid, gfp_mask);
 	for_each_zone_zonelist_nodemask(zone, z, zonelist,
 					gfp_zone(gfp_mask), nodemask) {
@@ -6919,7 +6957,9 @@ struct page *alloc_contig_pages_noprof(unsigned long nr_pages, gfp_t gfp_mask,
 
 		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
 		while (zone_spans_last_pfn(zone, pfn, nr_pages)) {
-			if (pfn_range_valid_contig(zone, pfn, nr_pages)) {
+			if (pfn_range_valid_contig(zone, pfn, nr_pages,
+						   skip_hugetlb,
+						   &skipped_hugetlb)) {
 				/*
 				 * We release the zone lock here because
 				 * alloc_contig_range() will also lock the zone
@@ -6938,6 +6978,17 @@ struct page *alloc_contig_pages_noprof(unsigned long nr_pages, gfp_t gfp_mask,
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

