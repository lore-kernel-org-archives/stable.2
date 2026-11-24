Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795550940;
	b=J5raEGJp0Xge+Rud9n71a0Ndjw+9a18ykgYxuAryGXXnlN1gd1Gd4hWgtdrXotAD1Ydb
	 VbtnpAz8qBF4PJt6o/vTfWv1NJw9Y7oiPsZZFQ5LSgznfiDiCJgLwhc4xjNkeLsO+otUM
	 /BtiqNW42yg/mnXH2NrJIVm3TTn1u1dtq+1CngoHdGOatoymuRM05xFHfoFNuY8Idsmfk
	 WjfxE4I+fK2Vhf6h8M4N1DXLy44BreLg/K7WxoBknK6UWZcxOhIc+rHUZByT0W9NjArNF
	 3KXrzoEr1nkNROp1/Hv/0DuNR//A+dt0BTrdVTnqrEhrY+8ok6irxh5bcSNi6+dSorg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795550940;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=T3H6lL3t8m2Rn5JjTwQtdvkOPNL5fEm6i95W6wU+afE=;
	b=LBsM9y7yobD4ipkPRh4thfWPf7bbGt8tLLRc24t7M6FQlpfLlMKQfNuT3vGL7pr5xdyW
	 6Jhmy2IzLzOq7xsVqivB9id1zDSFQQiwRGggs4VZE4OvtqNQ0EUgahWOXemjv2VACeUY1
	 DVT0aQlWxLBiqxo+U+/GNfwJkRoDBZPNlYaPNDqf86naJHxU8TdeEY0uQUPEpwBbQe2qq
	 75qCTTWWF8rPposKZ9x1RwttJBjZPl51g7GsuYn1Zp4VJX2T2CFUzQTc6KYZo3TPTKg2F
	 b51MlkiYsADeSTaXp4MYUrKwQ9gzgV1U5kratWW2/R8RUHwwPZ12Nw0q/sjVJHxoPcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NTNKEMFs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555FF606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NTNKEMFs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F271F000C4;
	Tue, 24 Nov 2026 20:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795550939;
	bh=T3H6lL3t8m2Rn5JjTwQtdvkOPNL5fEm6i95W6wU+afE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NTNKEMFsHPSVTkKS1D5huMIAIsK6Yf+IvDB6kIw/65stCFZG1anb9+xvkOawSBzKA
	 fmISJaEUEvpVDIY4WHEbTWIQsSoP+cSNunB0/OPdjIgmYG/XfsStcB8hpmisJ7WESU
	 zv5IuiWPA47VdximLUE9DcoEE/m0tnJx2bc13oTcJWyp/vze67+JfJyFYc6XTg9scQ
	 jcCb57Tq11effDMPAocPAARj8FmLwiL6LAVqIqUMnUmz+NI66t+qtAouQikz5+jqJ5
	 Z4On2FCwuH+F5lOJijr1EFP1aaho/RogtyKs5EWLgKbehXOYJBjxMLLl8OTTEVjhxM
	 sFgDbEhkNu6HQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Brendan Jackman <jackmanb@google.com>,
	David Hildenbrand <david@kernel.org>,
	Jane Chu <jane.chu@oracle.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] mm: page_isolation: introduce page_is_unmovable()
Date: Tue, 24 Nov 2026 15:08:53 -0500
Message-ID: <20261124200755.2539343-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112414-subtract-calculus-aa18@gregkh>
References: <2026112414-subtract-calculus-aa18@gregkh>
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

From: Kefeng Wang <wangkefeng.wang@huawei.com>

[ Upstream commit c83109e95c9d78e41b39e65b6490e511f4b8fba2 ]

Patch series "mm: accelerate gigantic folio allocation".

Optimize pfn_range_valid_contig() and replace_free_hugepage_folios() in
alloc_contig_frozen_pages() to speed up gigantic folio allocation.  The
allocation time for 120*1G folios drops from 3.605s to 0.431s.

This patch (of 5):

Factor out the check if a page is unmovable into a new helper, and will be
reused in the following patch.

No functional change intended, the minor changes are as follows,
1) Avoid unnecessary calls by checking CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
2) Directly call PageCompound since PageTransCompound may be dropped
3) Using folio_test_hugetlb()

Link: https://lkml.kernel.org/r/20260112150954.1802953-1-wangkefeng.wang@huawei.com
Link: https://lkml.kernel.org/r/20260112150954.1802953-2-wangkefeng.wang@huawei.com
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 213268869301 ("mm: page_isolation: do not take slab pages for free")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/page-isolation.h |   2 +
 mm/page_isolation.c            | 187 +++++++++++++++++----------------
 2 files changed, 101 insertions(+), 88 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 3e2f960e166ca..6f8638c9904ff 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -67,4 +67,6 @@ void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn);
 
 int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 			enum pb_isolate_mode mode);
+bool page_is_unmovable(struct zone *zone, struct page *page,
+			enum pb_isolate_mode mode, unsigned long *step);
 #endif
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 2e366e7bd5e93..7a32350eb8c2d 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -15,6 +15,100 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/page_isolation.h>
 
+bool page_is_unmovable(struct zone *zone, struct page *page,
+		enum pb_isolate_mode mode, unsigned long *step)
+{
+	/*
+	 * Both, bootmem allocations and memory holes are marked
+	 * PG_reserved and are unmovable. We can even have unmovable
+	 * allocations inside ZONE_MOVABLE, for example when
+	 * specifying "movablecore".
+	 */
+	if (PageReserved(page))
+		return true;
+
+	/*
+	 * If the zone is movable and we have ruled out all reserved
+	 * pages then it should be reasonably safe to assume the rest
+	 * is movable.
+	 */
+	if (zone_idx(zone) == ZONE_MOVABLE)
+		return false;
+
+	/*
+	 * Hugepages are not in LRU lists, but they're movable.
+	 * THPs are on the LRU, but need to be counted as #small pages.
+	 * We need not scan over tail pages because we don't
+	 * handle each tail page individually in migration.
+	 */
+	if (PageHuge(page) || PageCompound(page)) {
+		struct folio *folio = page_folio(page);
+
+		if (folio_test_hugetlb(folio)) {
+			struct hstate *h;
+
+			if (!IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION))
+				return true;
+
+			/*
+			 * The huge page may be freed so can not
+			 * use folio_hstate() directly.
+			 */
+			h = size_to_hstate(folio_size(folio));
+			if (h && !hugepage_migration_supported(h))
+				return true;
+
+		} else if (!folio_test_lru(folio)) {
+			return true;
+		}
+
+		*step = folio_nr_pages(folio) - folio_page_idx(folio, page);
+		return false;
+	}
+
+	/*
+	 * We can't use page_count without pin a page
+	 * because another CPU can free compound page.
+	 * This check already skips compound tails of THP
+	 * because their page->_refcount is zero at all time.
+	 */
+	if (!page_ref_count(page)) {
+		if (PageBuddy(page))
+			*step = (1 << buddy_order(page));
+		return false;
+	}
+
+	/*
+	 * The HWPoisoned page may be not in buddy system, and
+	 * page_count() is not 0.
+	 */
+	if ((mode == PB_ISOLATE_MODE_MEM_OFFLINE) && PageHWPoison(page))
+		return false;
+
+	/*
+	 * We treat all PageOffline() pages as movable when offlining
+	 * to give drivers a chance to decrement their reference count
+	 * in MEM_GOING_OFFLINE in order to indicate that these pages
+	 * can be offlined as there are no direct references anymore.
+	 * For actually unmovable PageOffline() where the driver does
+	 * not support this, we will fail later when trying to actually
+	 * move these pages that still have a reference count > 0.
+	 * (false negatives in this function only)
+	 */
+	if ((mode == PB_ISOLATE_MODE_MEM_OFFLINE) && PageOffline(page))
+		return false;
+
+	if (PageLRU(page) || page_has_movable_ops(page))
+		return false;
+
+	/*
+	 * If there are RECLAIMABLE pages, we need to check
+	 * it.  But now, memory offline itself doesn't call
+	 * shrink_node_slabs() and it still to be fixed.
+	 */
+	return true;
+}
+
 /*
  * This function checks whether the range [start_pfn, end_pfn) includes
  * unmovable pages or not. The range must fall into a single pageblock and
@@ -35,7 +129,6 @@ static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long e
 {
 	struct page *page = pfn_to_page(start_pfn);
 	struct zone *zone = page_zone(page);
-	unsigned long pfn;
 
 	VM_BUG_ON(pageblock_start_pfn(start_pfn) !=
 		  pageblock_start_pfn(end_pfn - 1));
@@ -52,96 +145,14 @@ static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long e
 		return page;
 	}
 
-	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
-		page = pfn_to_page(pfn);
+	while (start_pfn < end_pfn) {
+		unsigned long step = 1;
 
-		/*
-		 * Both, bootmem allocations and memory holes are marked
-		 * PG_reserved and are unmovable. We can even have unmovable
-		 * allocations inside ZONE_MOVABLE, for example when
-		 * specifying "movablecore".
-		 */
-		if (PageReserved(page))
+		page = pfn_to_page(start_pfn);
+		if (page_is_unmovable(zone, page, mode, &step))
 			return page;
 
-		/*
-		 * If the zone is movable and we have ruled out all reserved
-		 * pages then it should be reasonably safe to assume the rest
-		 * is movable.
-		 */
-		if (zone_idx(zone) == ZONE_MOVABLE)
-			continue;
-
-		/*
-		 * Hugepages are not in LRU lists, but they're movable.
-		 * THPs are on the LRU, but need to be counted as #small pages.
-		 * We need not scan over tail pages because we don't
-		 * handle each tail page individually in migration.
-		 */
-		if (PageHuge(page) || PageTransCompound(page)) {
-			struct folio *folio = page_folio(page);
-			unsigned int skip_pages;
-
-			if (PageHuge(page)) {
-				struct hstate *h;
-
-				/*
-				 * The huge page may be freed so can not
-				 * use folio_hstate() directly.
-				 */
-				h = size_to_hstate(folio_size(folio));
-				if (h && !hugepage_migration_supported(h))
-					return page;
-			} else if (!folio_test_lru(folio)) {
-				return page;
-			}
-
-			skip_pages = folio_nr_pages(folio) - folio_page_idx(folio, page);
-			pfn += skip_pages - 1;
-			continue;
-		}
-
-		/*
-		 * We can't use page_count without pin a page
-		 * because another CPU can free compound page.
-		 * This check already skips compound tails of THP
-		 * because their page->_refcount is zero at all time.
-		 */
-		if (!page_ref_count(page)) {
-			if (PageBuddy(page))
-				pfn += (1 << buddy_order(page)) - 1;
-			continue;
-		}
-
-		/*
-		 * The HWPoisoned page may be not in buddy system, and
-		 * page_count() is not 0.
-		 */
-		if ((mode == PB_ISOLATE_MODE_MEM_OFFLINE) && PageHWPoison(page))
-			continue;
-
-		/*
-		 * We treat all PageOffline() pages as movable when offlining
-		 * to give drivers a chance to decrement their reference count
-		 * in MEM_GOING_OFFLINE in order to indicate that these pages
-		 * can be offlined as there are no direct references anymore.
-		 * For actually unmovable PageOffline() where the driver does
-		 * not support this, we will fail later when trying to actually
-		 * move these pages that still have a reference count > 0.
-		 * (false negatives in this function only)
-		 */
-		if ((mode == PB_ISOLATE_MODE_MEM_OFFLINE) && PageOffline(page))
-			continue;
-
-		if (PageLRU(page) || page_has_movable_ops(page))
-			continue;
-
-		/*
-		 * If there are RECLAIMABLE pages, we need to check
-		 * it.  But now, memory offline itself doesn't call
-		 * shrink_node_slabs() and it still to be fixed.
-		 */
-		return page;
+		start_pfn += step;
 	}
 	return NULL;
 }
-- 
2.53.0

