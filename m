Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F223C10AE
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890183; cv=none; b=idwTjE0fiHa7+QBFLkDWbgbBIfnnHsUsI1E07ryy0xEbg8v6TOUItAXL+vdUe7lgQNZgmT/VRm8Lws+ZTMsv3ChxGOVOVip99tJxGsQI3sjHj+6L3g+D0m46sGDH+znDRJpF/Gq3LlhAQsKau8l3v7kB3qu3bIB8SOSTFQVAmYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890183; c=relaxed/simple;
	bh=Fgn19GE/G3MQPgzYcDj7/aJi60z0Q9JRz5jHb0JQPD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lut+72iVWJeD218DmQVIRn8Ndx3VNoAvWT+sgaVzNR4OI50XIDV+snCEXklNO3ISf+fkQz+Q0UKnFQ9InyzNJF9kSVknkQegy70TyQt1aqnuh7WPBaA4kCpCOHso1RdRIm4Fc11yvA7BPC+Cj5DW0Ag/3ixpaHLbpGJUXaFk58k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVvNO1LG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVvNO1LG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609B01F000E9;
	Fri, 24 Jul 2026 10:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784890181;
	bh=Ri6i1kSwClyn9lDVM/seNHX7yENfWkco4CltfGY/img=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gVvNO1LGcpC5UhzPFi4n/BXynUABd+fUooev7u/3UQ5485ps9f0Vpili3+ylJMHrP
	 VT4MQORhH/Tp8/cW8nujnT+Md5dOp/8unFW2tyO9QmtbZDy6E36hdbIe7elzY5y87m
	 LGREtvRzGGaapgowApgl+tSFnrUI5EPRONJBzfXx9655DoBX6IGwNLtk5IqTxmuscm
	 1KlQ7K+IBp42/p43zfolw3nFpwfrlVI8w/m+7X+TSuc6Q58bdhOwwDS3CM6BOmXCj2
	 EJ/eqRnXskz16scqtaorhSFgIF7lxfykwEc0+fwtmQKpOC3yV8AAIzFR8+RXsOEos/
	 AElAAPo26w/BA==
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
Subject: [PATCH 6.18.y] mm/sparse-vmemmap: fix vmemmap accounting underflow
Date: Fri, 24 Jul 2026 06:49:37 -0400
Message-ID: <20260724104937.3975387-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072025-carving-copper-7ae4@gregkh>
References: <2026072025-carving-copper-7ae4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muchun Song <songmuchun@bytedance.com>

[ Upstream commit c373f7f98e6ad591c85d40548cf8b6443be69311 ]

Patch series "mm: Fix vmemmap optimization accounting and initialization",
v8.

The series fixes several bugs in vmemmap optimization, mainly around
incorrect page accounting and memmap initialization in DAX and memory
hotplug paths.  It also fixes pageblock migratetype initialization and
struct page initialization for ZONE_DEVICE compound pages.

Patches 1-4 fix vmemmap accounting issues.  Patch 1 fixes an accounting
underflow in the section activation failure path by moving vmemmap page
accounting into the lower-level allocation and freeing helpers.  Patch 2
fixes incorrect altmap passing in the memory hotplug error path.  Patch 3
passes pgmap through memory deactivation paths so the teardown side can
determine whether vmemmap optimization was in effect.  Patch 4 uses that
information to account the optimized DAX vmemmap size correctly.

Patches 5-6 fix initialization issues in mm/mm_init.  One makes sure all
pageblocks in ZONE_DEVICE compound pages get their migratetype
initialized.  The other fixes a case where DAX memory hotplug reuses an
unoptimized early-section memmap while compound_nr_pages() still assumes
vmemmap optimization, leaving tail struct pages uninitialized.

This patch (of 6):

In section_activate(), if populate_section_memmap() fails, the error
handling path calls section_deactivate() to roll back the state.  This
causes a vmemmap accounting imbalance.

Since commit c3576889d87b ("mm: fix accounting of memmap pages"), memmap
pages are accounted for only after populate_section_memmap() succeeds.
However, the failure path unconditionally calls section_deactivate(),
which decreases the vmemmap count.  Consequently, a failure in
populate_section_memmap() leads to an accounting underflow, incorrectly
reducing the system's tracked vmemmap usage.

Fix this more thoroughly by moving all accounting calls into the lower
level functions that actually perform the vmemmap allocation and freeing:

  - populate_section_memmap() accounts for newly allocated vmemmap pages -
depopulate_section_memmap() unaccounts when vmemmap is freed

This ensures proper accounting in all code paths, including error handling
and early section cases.

Link: https://lore.kernel.org/20260428081855.1249045-1-songmuchun@bytedance.com
Link: https://lore.kernel.org/20260428081855.1249045-2-songmuchun@bytedance.com
Fixes: c3576889d87b ("mm: fix accounting of memmap pages")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Oscar Salvador <osalvador@suse.de>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/sparse.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 17c50a6415c2db..bda92a084681a7 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -670,7 +670,12 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap)
 {
-	return __populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
+	struct page *page = __populate_section_memmap(pfn, nr_pages, nid, altmap,
+						      pgmap);
+
+	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
+
+	return page;
 }
 
 static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
@@ -679,13 +684,17 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
+	memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
 	vmemmap_free(start, end, altmap);
 }
+
 static void free_map_bootmem(struct page *memmap)
 {
 	unsigned long start = (unsigned long)memmap;
 	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
 
+	memmap_boot_pages_add(-1L * (DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
+						  PAGE_SIZE)));
 	vmemmap_free(start, end, NULL);
 }
 
@@ -742,13 +751,18 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap)
 {
-	return kvmalloc_node(array_size(sizeof(struct page),
-					PAGES_PER_SECTION), GFP_KERNEL, nid);
+	struct page *page = kvmalloc_node(array_size(sizeof(struct page),
+						PAGES_PER_SECTION), GFP_KERNEL, nid);
+
+	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
+
+	return page;
 }
 
 static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 		struct vmem_altmap *altmap)
 {
+	memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
 	kvfree(pfn_to_page(pfn));
 }
 
@@ -761,6 +775,9 @@ static void free_map_bootmem(struct page *memmap)
 	nr_pages = PAGE_ALIGN(PAGES_PER_SECTION * sizeof(struct page))
 		>> PAGE_SHIFT;
 
+	memmap_boot_pages_add(-1L * (DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
+						  PAGE_SIZE)));
+
 	for (i = 0; i < nr_pages; i++, page++) {
 		type = bootmem_type(page);
 
@@ -854,14 +871,10 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	 * The memmap of early sections is always fully populated. See
 	 * section_activate() and pfn_valid() .
 	 */
-	if (!section_is_early) {
-		memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
+	if (!section_is_early)
 		depopulate_section_memmap(pfn, nr_pages, altmap);
-	} else if (memmap) {
-		memmap_boot_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page),
-							  PAGE_SIZE)));
+	else if (memmap)
 		free_map_bootmem(memmap);
-	}
 
 	if (empty)
 		ms->section_mem_map = (unsigned long)NULL;
@@ -906,7 +919,6 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 		section_deactivate(pfn, nr_pages, altmap);
 		return ERR_PTR(-ENOMEM);
 	}
-	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
 
 	return memmap;
 }
-- 
2.53.0

