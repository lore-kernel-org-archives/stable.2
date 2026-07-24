Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C94447808
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911493; cv=none; b=gLG1GzNAuJMucFivaWXMcVqccuKkV5RLemwPhSRQZ5NeLdgCx+RFV+aDw7O9wWzPCO5pB//DGp7zOq7G7+DN9mAvzgFNM8EZavmmCpz+ch1IKo/kKyqUc2SKoElyhCm+FRcGZNhMJl/8915vNap7rzvBFc9Yu12bElXKWSDN8E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911493; c=relaxed/simple;
	bh=gZuzOG2QbhJq0sK0oEQEJ1v5lESfJErdJlloF/b+dkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SeDpWmF0I33uTEsVihJCCcKagQtF/f81St1/I+1RLVJqSTYH/svmEPXqRG8QVkyTo5hohChoktijMMm5Kvwn6CWZZy1sYVNnjC5gVJ3FqLueBjp1oKCzAiaC+Fkr/DJjWtl3cKYeTohImLGHYB8cIgsSNkWVi6IXEln9eljwJIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMcEABXj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMcEABXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BF51F00A3A;
	Fri, 24 Jul 2026 16:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784911489;
	bh=wy5QET89/ac48xyNNLMlM7xEVpNfcasJiUOdUBwjxkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hMcEABXjJxawv4xNCGvnoGJGqWEnIL3M103xTNGV81xH7MhyRmMtZiCfvRBsku7FD
	 hySujmPHrjCdwbhmN1tcX38CjAqh7RCuC3s2EqrvE1CQ9iFkvuPzfWbPFlBoVHwBds
	 ek83RG5TO3umRgYMN5PQVFE6onJFbSjhr9QH/UdflNCCgtTDJy5Ez98oeP094VIMIO
	 bv82NPiHyY0akQy1Yjs7Ax8RF8TdjWyC+WzWNxcJrEXFodOQlJw0NRvDfvabrlvJIZ
	 Ox/RJbjIeowrkjsp3hm2QA6Vfb75UvROr0FqqILGmRuB4OJyeJaYo7ckRrqyBQgpgR
	 5FlaW/6g1DfNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Muchun Song <songmuchun@bytedance.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] mm/mm_init: fix uninitialized struct pages for ZONE_DEVICE
Date: Fri, 24 Jul 2026 12:44:43 -0400
Message-ID: <20260724164443.469191-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724164443.469191-1-sashal@kernel.org>
References: <2026072046-viewable-richness-35ef@gregkh>
 <20260724164443.469191-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muchun Song <songmuchun@bytedance.com>

[ Upstream commit cd681403a87085562499d60325b7b45d3be11217 ]

If DAX memory is hotplugged into an unoccupied subsection of an early
section, section_activate() reuses the unoptimized boot memmap.  However,
compound_nr_pages() still assumes that vmemmap optimization is in effect
and initializes only the reduced number of struct pages.  As a result, the
remaining tail struct pages are left uninitialized, which can later lead
to unexpected behavior or crashes.

Fix this by treating early sections as unoptimized when calculating how
many struct pages to initialize.

Link: https://lore.kernel.org/20260428081855.1249045-7-songmuchun@bytedance.com
Fixes: 6fd3620b3428 ("mm/page_alloc: reuse tail struct pages for compound devmaps")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Liam R. Howlett <liam@infradead.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mm_init.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 5aab6903bddcbe..a3acd113e7d0a4 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -262,10 +262,17 @@ do {									\
  * of how the sparse_vmemmap internals handle compound pages in the lack
  * of an altmap. See vmemmap_populate_compound_pages().
  */
-static inline unsigned long compound_nr_pages(struct vmem_altmap *altmap,
+static inline unsigned long compound_nr_pages(unsigned long pfn,
+					      struct vmem_altmap *altmap,
 					      struct dev_pagemap *pgmap)
 {
-	if (!vmemmap_can_optimize(altmap, pgmap))
+	/*
+	 * If DAX memory is hot-plugged into an unoccupied subsection
+	 * of an early section, the unoptimized boot memmap is reused.
+	 * See section_activate().
+	 */
+	if (early_section(__pfn_to_section(pfn)) ||
+	    !vmemmap_can_optimize(altmap, pgmap))
 		return pgmap_vmemmap_nr(pgmap);
 
 	return VMEMMAP_RESERVE_NR * (PAGE_SIZE / sizeof(struct page));
@@ -338,7 +345,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 			continue;
 
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(altmap, pgmap));
+				     compound_nr_pages(pfn, altmap, pgmap));
 	}
 
 	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
-- 
2.53.0

