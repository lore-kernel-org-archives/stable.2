Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7DB3DCDAB
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557304; cv=none; b=S1vTxW04alY8H97pd+DbNozjH9CIgnreDaVQO94LWedH1CrhD12Map5Q0aYdd35NZGFTwiRNp+50BNAPzNxKirqpRZ6n6wGqBXM/QAGM7ZqzMTs5ZF7X3iDKF8p8+07Z65nB3hnFo/DSXGA+HLqTf5qdVO67Bn9Q8jEFjm3k7+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557304; c=relaxed/simple;
	bh=xoZz7klmz3RiTNyc2mHJOGvtcg8Y9JgZ0Ivfqs4Y7cw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=A0e2ALj3uyUHZDhbg2Z0cb8I/s/eJxiOfvSd7zAaksSXD/PTRMsiMpmjWMfsEYQLL6f+VTPmImsgLUjbw9qPlfk+XMNt1eHKVM938OKo+3m1fUeq7ivqN9W9LpUMmXs7b4Bxi6h1Wy57+qpukENG31MXAAGfJG0+WWDX7iM0Jxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZU2gylfF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZU2gylfF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8021F000E9;
	Mon, 20 Jul 2026 14:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784557302;
	bh=qelQ39PZY9KYoarucKTpLBEMkjGGW82UsE/3JAnkOeA=;
	h=Subject:To:Cc:From:Date;
	b=ZU2gylfFRgFclArOKNDl9Tl7POqGnb7sB3jEfq9AlsYdRKeuuR+JWEI5Ul7kWEC8u
	 tdwPGx5t7AwGXDPIe11nHABhFpX+Esu68isHIK8+gxxoR6pmDACoLrZjJg+09xk8nD
	 9EAA2EEe+k41p8qjm+0ZLteJmwt0l82zYgL0ZPZ4=
Subject: FAILED: patch "[PATCH] mm/sparse-vmemmap: fix vmemmap accounting underflow" failed to apply to 6.12-stable tree
To: muchun.song@linux.dev,akpm@linux-foundation.org,aneesh.kumar@linux.ibm.com,david@kernel.org,joao.m.martins@oracle.com,liam@infradead.org,ljs@kernel.org,maddy@linux.ibm.com,mhocko@suse.com,mpe@ellerman.id.au,npiggin@gmail.com,osalvador@suse.de,rppt@kernel.org,songmuchun@bytedance.com,stable@vger.kernel.org,surenb@google.com,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 16:21:26 +0200
Message-ID: <2026072025-sponge-disaster-ef73@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c373f7f98e6ad591c85d40548cf8b6443be69311
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072025-sponge-disaster-ef73@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c373f7f98e6ad591c85d40548cf8b6443be69311 Mon Sep 17 00:00:00 2001
From: Muchun Song <muchun.song@linux.dev>
Date: Tue, 28 Apr 2026 16:18:50 +0800
Subject: [PATCH] mm/sparse-vmemmap: fix vmemmap accounting underflow

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

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 43f82621dd92..60e55e78d7ff 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -651,7 +651,12 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
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
@@ -660,13 +665,17 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
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
 
@@ -769,14 +778,10 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
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
@@ -821,7 +826,6 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 		section_deactivate(pfn, nr_pages, altmap);
 		return ERR_PTR(-ENOMEM);
 	}
-	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
 
 	return memmap;
 }

