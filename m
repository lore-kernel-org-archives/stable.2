Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E836342D760
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557857; cv=none; b=RWjO8zn6BEMPq8/6zmdle0cE9aCuIR3ej0a3078J68a/VrSJL7zcoGW3RWjFoH7UppcsBFnQbJRajJF5V3PldjG1rlOAnMRzb47tZVZrzxgftbrogZk4HYwHnRJXEyYedZFwdq99aI46C4H8F6AC/jtqgSpmVBt0OHT+aqF89eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557857; c=relaxed/simple;
	bh=H+zGFL/CzdH5PyG9ipBXLgFVTHP8tq3Gc6HnaSYlOeU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N/gHw5mAvxs2HlMkYnYqmgolXwIfVdLRaa0XdY6AwDBD/JpTJTp7MM1qCigxt7rlolmSHRhzG8485x4VprnRmTLkXk/0PSfNpLBORbS3NsC7NUrk5k9x208usPxYdzIirYFH/wgkEiiOb3CAvldHvlMG2gWcFd/VjEwhhlE1I0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f3xH5D44; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f3xH5D44"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0081F000E9;
	Mon, 20 Jul 2026 14:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784557855;
	bh=jcnN98hPCgPh7z9cLrhdfHIFHKSVCgL390uRpMsUxLw=;
	h=Subject:To:Cc:From:Date;
	b=f3xH5D442/hq4++7Rv8VhhslP/AtzJeZZJwgzlmpJ3THbESuUGIdPlk566BEDIJce
	 fe7LKQwoUIWj5++1+cpICtlVJcFNXQ1CCGQS1GgxPMRTARc10TfSy7KGYOwZ5il05h
	 SRRYenpebczDiTsqJCNPHsofpyNnT1h5p9NsLmwM=
Subject: FAILED: patch "[PATCH] mm/mm_init: fix uninitialized struct pages for ZONE_DEVICE" failed to apply to 6.1-stable tree
To: muchun.song@linux.dev,akpm@linux-foundation.org,aneesh.kumar@linux.ibm.com,david@kernel.org,joao.m.martins@oracle.com,liam@infradead.org,ljs@kernel.org,maddy@linux.ibm.com,mhocko@suse.com,mpe@ellerman.id.au,npiggin@gmail.com,osalvador@suse.de,rppt@kernel.org,songmuchun@bytedance.com,stable@vger.kernel.org,surenb@google.com,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 16:30:46 +0200
Message-ID: <2026072046-viewable-richness-35ef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x cd681403a87085562499d60325b7b45d3be11217
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072046-viewable-richness-35ef@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cd681403a87085562499d60325b7b45d3be11217 Mon Sep 17 00:00:00 2001
From: Muchun Song <muchun.song@linux.dev>
Date: Tue, 28 Apr 2026 16:18:55 +0800
Subject: [PATCH] mm/mm_init: fix uninitialized struct pages for ZONE_DEVICE

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

diff --git a/mm/mm_init.c b/mm/mm_init.c
index cfc76953e249..bd466a3c10c8 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1055,10 +1055,17 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
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
@@ -1128,7 +1135,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 			continue;
 
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(altmap, pgmap));
+				     compound_nr_pages(pfn, altmap, pgmap));
 	}
 
 	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);

