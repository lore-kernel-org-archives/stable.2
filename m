Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF5F37A85B
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785067259; cv=none; b=GWhQfpaj2NkuVBB1d6DzIqo5QFsNBkljzz7WMSDNHKCh2vNlXm0tdI15Iuv5354MbgLrvCZTRq0c7DBqoYO8IYf3/rj6v/Lx5d8E+iSu15PANwyyMNX87cdfhthbLTSY37u5+HdP84HAc5grcebPG8JCKHGj1L/CxRYjyMa5Rp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785067259; c=relaxed/simple;
	bh=s81wjJ9bTxaJsdEIplwufVkuVUpkfjj3VTV06oR3JB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6swuqA1XV4ikpeTJKnRbd9PIF1krMfqJ78ReaLDdmhTHTBkUUDO5g4EBymhhTb4UACGu8ZqpejlhGacbYYriHVy3Hd+eAOp5Tcw/XLSvLA8nFtJTD5MhC57kn/142jzPsRzK0O546gEO+4704cSzS1e6OKxDJe7YCIQpNsgbME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUwR1vwM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUwR1vwM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722C31F000E9;
	Sun, 26 Jul 2026 12:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785067258;
	bh=0ye8d8/vp3omJewmcD3gnqTA+cK4c6IFuaeMR/dGnHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PUwR1vwME5lm8goo1IDllJ+zzk8Y1boeyGL1RPX9mOwuuLb9aaUhma5jBQJOq8UDR
	 No8Qbg7wiOHZGT2sQKPitpqLJunooQLnqM16+/JVhXtVSzYiPBbP3adi8OWmPgydrv
	 0l3UOySVcbKzjh1WI/w5PmbQtlqr4BUhk7jNtJHNu8SCZof7jsw46j1oWGbqvPJxTo
	 42Ir6aqWxE1OnvjGHtLbh+S6oDlOtFKMH1IfwaeD9U+/pBgXEKuC2O1DuqgQI/D3Yq
	 2pRa8wxB5EIWpjT+eeiZt7EoWeUUOaDhmkGUsZsK2gKOMxNLcGryQEAjk7tKf2cNcg
	 kWm8Gfh6QihZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Muchun Song <songmuchun@bytedance.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/mm_init: fix pageblock migratetype for ZONE_DEVICE compound pages
Date: Sun, 26 Jul 2026 08:00:54 -0400
Message-ID: <20260726120054.4138350-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072015-charger-reveler-9c5e@gregkh>
References: <2026072015-charger-reveler-9c5e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muchun Song <songmuchun@bytedance.com>

[ Upstream commit 94405c6136839f7c462249c8b4b957bcb9527a9d ]

The memmap_init_zone_device() function only initializes the migratetype of
the first pageblock of a compound page.  If the compound page size exceeds
pageblock_nr_pages (e.g., 1GB hugepages with 2MB pageblocks), subsequent
pageblocks in the compound page remain uninitialized.

Move the migratetype initialization out of __init_zone_device_page() and
into a separate pageblock_migratetype_init_range() function.  This
iterates over the entire PFN range of the memory, ensuring that all
pageblocks are correctly initialized.

Also remove the stale confusing comment about MEMINIT_HOTPLUG above the
migratetype setting since it is an obsolete relic from commit 966cf44f637e
("mm: defer ZONE_DEVICE page initialization to the point where we init
pgmap") and no longer makes sense here.

Link: https://lore.kernel.org/20260428081855.1249045-6-songmuchun@bytedance.com
Fixes: c4386bd8ee3a ("mm/memremap: add ZONE_DEVICE support for compound pages")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Liam R. Howlett <liam@infradead.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ relocated the mm/mm_init.c changes to mm/page_alloc.c and replaced init_pageblock_migratetype() with set_pageblock_migratetype() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 93c63b5fad2889..35792ac5487112 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6912,6 +6912,18 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
 }
 
 #ifdef CONFIG_ZONE_DEVICE
+static __meminit void pageblock_migratetype_init_range(unsigned long pfn,
+		unsigned long nr_pages, int migratetype)
+{
+	const unsigned long end = pfn + nr_pages;
+
+	for (pfn = pageblock_align(pfn); pfn < end; pfn += pageblock_nr_pages) {
+		set_pageblock_migratetype(pfn_to_page(pfn), migratetype);
+		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
+			cond_resched();
+	}
+}
+
 static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 					  unsigned long zone_idx, int nid,
 					  struct dev_pagemap *pgmap)
@@ -6936,21 +6948,6 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	page->pgmap = pgmap;
 	page->zone_device_data = NULL;
 
-	/*
-	 * Mark the block movable so that blocks are reserved for
-	 * movable at startup. This will force kernel allocations
-	 * to reserve their blocks rather than leaking throughout
-	 * the address space during boot when many long-lived
-	 * kernel allocations are made.
-	 *
-	 * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
-	 * because this is done early in section_activate()
-	 */
-	if (pageblock_aligned(pfn)) {
-		set_pageblock_migratetype(page, MIGRATE_MOVABLE);
-		cond_resched();
-	}
-
 	/*
 	 * ZONE_DEVICE pages are released directly to the driver page allocator
 	 * which will set the page count to 1 when allocating the page.
@@ -7035,6 +7032,9 @@ void __ref memmap_init_zone_device(struct zone *zone,
 
 		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
 
+		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
+			cond_resched();
+
 		if (pfns_per_compound == 1)
 			continue;
 
@@ -7042,6 +7042,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
 				     compound_nr_pages(altmap, pfns_per_compound));
 	}
 
+	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
+
 	pr_info("%s initialised %lu pages in %ums\n", __func__,
 		nr_pages, jiffies_to_msecs(jiffies - start));
 }
-- 
2.53.0

