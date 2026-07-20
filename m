Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7EB42A7AC
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558121; cv=none; b=KfZjxAiPvm3Bhii3gxLPzrcuhXeeZk51lg5TxDy35538L7yXHL/nVCDhPuOODcTwKlgLQBdPvJ4tYgjmXaiyrCwAj+oHtrOcqxVwLTuElFr4VtoyTWYTFezfsHq1emBt8vOsqh0oV/f3e0A0C4ONA80oB23n4D8Dl15jSj85Ngo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558121; c=relaxed/simple;
	bh=z0QY0RjxpF8N9JSEwOmiKwXoPXC6e/UNbpPwGFZOZEI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aQxNk3cpbvh3fbSNa/0bfDR5S04kt743fdXodFrYGuIqNm2kmNROO/C66eMqUSZowrkBaVI5AfTJDswfWOayCjpPuS8GV0d30zJr6qoYLuZyKRST1kmxaF/vIbvVs23loSyWW2ocCTb6BU8fjdc9wIa5R0TKN54I/wbKvdEaOec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MZY7r7rj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MZY7r7rj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373691F000E9;
	Mon, 20 Jul 2026 14:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784558119;
	bh=AmHq98doTMYFirRcKoR1HZ3cTZ6PqUNP42QKWPopKPc=;
	h=Subject:To:Cc:From:Date;
	b=MZY7r7rjSUYdTKzA0v/+YA1Yn6ZVcSDADslnA0WBwnA+AntbDAqyp8Z47+WCf+ceq
	 llJTYkHBSDvEdkKk4LXRfHdLegi1zg3T72PA/YHdTqhif/NHuJaJIMsk6qbHwKUlbg
	 +Y0MCSAnaavCiC7pVzpj/BSgw7GEV65WYriRWnfc=
Subject: FAILED: patch "[PATCH] mm/sparse-vmemmap: fix DAX vmemmap accounting with" failed to apply to 7.1-stable tree
To: muchun.song@linux.dev,akpm@linux-foundation.org,aneesh.kumar@linux.ibm.com,david@kernel.org,joao.m.martins@oracle.com,liam@infradead.org,ljs@kernel.org,maddy@linux.ibm.com,mhocko@suse.com,mpe@ellerman.id.au,npiggin@gmail.com,osalvador@suse.de,rppt@kernel.org,songmuchun@bytedance.com,stable@vger.kernel.org,surenb@google.com,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 16:35:10 +0200
Message-ID: <2026072010-unadorned-lubricate-bf28@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 721a73e30c9e3e8fcffe1725bcede1bbd20b4918
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072010-unadorned-lubricate-bf28@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 721a73e30c9e3e8fcffe1725bcede1bbd20b4918 Mon Sep 17 00:00:00 2001
From: Muchun Song <muchun.song@linux.dev>
Date: Tue, 28 Apr 2026 16:18:53 +0800
Subject: [PATCH] mm/sparse-vmemmap: fix DAX vmemmap accounting with
 optimization

When vmemmap optimization is enabled for DAX, the nr_memmap_pages counter
in /proc/vmstat is incorrect.  The current code always accounts for the
full, non-optimized vmemmap size, but vmemmap optimization reduces the
actual number of vmemmap pages by reusing tail pages.  This causes the
system to overcount vmemmap usage, leading to inaccurate page statistics
in /proc/vmstat.

Fix this by introducing section_nr_vmemmap_pages(), which returns the
exact vmemmap page count for a given pfn range based on whether
optimization is in effect.

Link: https://lore.kernel.org/20260428081855.1249045-5-songmuchun@bytedance.com
Fixes: 15995a352474 ("mm: report per-page metadata information")
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
index eafb7c6eb71e..112ccf9c71ca 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -647,6 +647,31 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 	}
 }
 
+static int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
+		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
+{
+	const unsigned int order = pgmap ? pgmap->vmemmap_shift : 0;
+	const unsigned long pages_per_compound = 1UL << order;
+
+	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTION));
+	VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION);
+
+	if (!vmemmap_can_optimize(altmap, pgmap))
+		return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
+
+	if (order < PFN_SECTION_SHIFT) {
+		VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, pages_per_compound));
+		return VMEMMAP_RESERVE_NR * nr_pages / pages_per_compound;
+	}
+
+	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));
+
+	if (IS_ALIGNED(pfn, pages_per_compound))
+		return VMEMMAP_RESERVE_NR;
+
+	return 0;
+}
+
 static struct page * __meminit populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap)
@@ -654,7 +679,7 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
 	struct page *page = __populate_section_memmap(pfn, nr_pages, nid, altmap,
 						      pgmap);
 
-	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
+	memmap_pages_add(section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
 
 	return page;
 }
@@ -665,7 +690,7 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
-	memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
+	memmap_pages_add(-section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
 	vmemmap_free(start, end, altmap);
 }
 
@@ -673,9 +698,10 @@ static void free_map_bootmem(struct page *memmap)
 {
 	unsigned long start = (unsigned long)memmap;
 	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
+	unsigned long pfn = page_to_pfn(memmap);
 
-	memmap_boot_pages_add(-1L * (DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
-						  PAGE_SIZE)));
+	memmap_boot_pages_add(-section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
+							NULL, NULL));
 	vmemmap_free(start, end, NULL);
 }
 

