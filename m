Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000E14B0C9A
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439504; cv=none; b=DleC/dm60vWQW96Fd3O60vKHTt7MfGK5i2MSGyvAHCGZNA1Ww8JA0ITSSoaPlnvSiR292QMiWxcjxbDFwfRorf7qSrsxFOX3H/axi7LmzCs+XIazWwB5dgdNeScwLopRYOFOnq/3bEqdgU70I1VXqF+N20KMEGPzFmoso4AZD/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439504; c=relaxed/simple;
	bh=+w672uJkba/6wg3SNPslBtwodouCi9ylmlriSCmlRCI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OL6u0k6vf2QgJLFNFUafqPvNuiuFm/+vwNEGKKZt5cUIA2SBINsVAjKPujPE+Q+h6wlsl8veONS/q+jv2XahYh73HWLLzWOLKSoXapkxwhvJUcuwDqwXCRhtk7NHB+oec4wl1eJ10Zy1ZpjfOjsHFWov/Xo9PSLYcJkz7IeTYYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mxrwQg14; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mxrwQg14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D781F000E9;
	Thu,  3 Sep 2026 12:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439502;
	bh=cEHuLUi1MBdXTPMFwCdGKd0uDJNBkHav+Gc0Lg/N3Ok=;
	h=Subject:To:Cc:From:Date;
	b=mxrwQg14itkK6XCITNmqy0nGBCn6Iqf09SpTmG/ivtq/KDvs8DS1/5PDxkujvahaX
	 UJOCCfiefJaSsA80hya45B1wFFaNFrpvOdRsIO1jRhtdyhqUGoA+/dMdvvhGAUrVND
	 daFO5LvNGJ8+8OibARTgjG4gqvVk8BxnPuju3dQk=
Subject: FAILED: patch "[PATCH] mm/hugetlb: initialize gigantic bootmem hugepage struct pages" failed to apply to 6.12-stable tree
To: muchun.song@linux.dev,akpm@linux-foundation.org,aneesh.kumar@linux.ibm.com,david@kernel.org,fvdl@google.com,liam@infradead.org,ljs@kernel.org,maddy@linux.ibm.com,mpe@ellerman.id.au,npiggin@gmail.com,osalvador@kernel.org,osalvador@suse.de,ritesh.list@gmail.com,rppt@kernel.org,songmuchun@bytedance.com,stable@vger.kernel.org,usama.arif@linux.dev,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:47:13 +0200
Message-ID: <2026090313-preschool-santa-9fe8@gregkh>
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
git cherry-pick -x b1b7c045e808c761b1cc8c19b3040fadedda3fef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090313-preschool-santa-9fe8@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b1b7c045e808c761b1cc8c19b3040fadedda3fef Mon Sep 17 00:00:00 2001
From: Muchun Song <muchun.song@linux.dev>
Date: Fri, 12 Jun 2026 11:58:48 +0800
Subject: [PATCH] mm/hugetlb: initialize gigantic bootmem hugepage struct pages
 earlier

Gigantic bootmem HugeTLB pages are currently initialized from
hugetlb_init(), but page_alloc_init_late() runs earlier and walks
pageblocks to determine zone contiguity.

If a bootmem HugeTLB region is marked noinit, set_zone_contiguous() can
observe still-uninitialized struct pages through
__pageblock_pfn_to_page().  This may not trigger an immediate failure, but
it can make set_zone_contiguous() compute the wrong zone contiguity state.
If extra poisoned-page checks are added in this path, such as
PF_POISONED_CHECK() in page_zone_id(), it can also trigger an early boot
panic.

Initialize gigantic bootmem HugeTLB struct pages from
page_alloc_init_late(), before zone contiguity is evaluated, so later page
allocator setup only sees valid struct page state.  This also makes the
initialization order more natural, as struct pages should be initialized
before later code inspects them.

Link: https://lore.kernel.org/20260612035903.2468601-5-songmuchun@bytedance.com
Fixes: fde1c4ecf916 ("mm: hugetlb: skip initialization of gigantic tail struct pages if freed by HVO")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Oscar Salvador <osalvador@suse.de>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Frank van der Linden <fvdl@google.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Oscar Salvador (SUSE) <osalvador@kernel.org>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Usama Arif <usama.arif@linux.dev>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d6967fc94a49..431848873370 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -172,6 +172,7 @@ extern int movable_gigantic_pages __read_mostly;
 extern int sysctl_hugetlb_shm_group __read_mostly;
 extern struct list_head huge_boot_pages[MAX_NUMNODES];
 
+void hugetlb_bootmem_struct_page_init(void);
 void hugetlb_bootmem_alloc(void);
 extern nodemask_t hugetlb_bootmem_nodes;
 void hugetlb_bootmem_set_nodes(void);
@@ -1294,6 +1295,10 @@ static inline bool hugetlbfs_pagecache_present(
 static inline void hugetlb_bootmem_alloc(void)
 {
 }
+
+static inline void hugetlb_bootmem_struct_page_init(void)
+{
+}
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4c234611e7a0..78fe77a690ad 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3353,7 +3353,7 @@ static void __init gather_bootmem_prealloc_parallel(unsigned long start,
 		gather_bootmem_prealloc_node(nid);
 }
 
-static void __init gather_bootmem_prealloc(void)
+void __init hugetlb_bootmem_struct_page_init(void)
 {
 	struct padata_mt_job job = {
 		.thread_fn	= gather_bootmem_prealloc_parallel,
@@ -3582,7 +3582,7 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
  * - For gigantic pages, this is called early in the boot process and
  *   pages are allocated from memblock allocated or something similar.
  *   Gigantic pages are actually added to pools later with the routine
- *   gather_bootmem_prealloc.
+ *   hugetlb_bootmem_struct_page_init.
  * - For non-gigantic pages, this is called later in the boot process after
  *   all of mm is up and functional.  Pages are allocated from buddy and
  *   then added to hugetlb pools.
@@ -4152,7 +4152,6 @@ static int __init hugetlb_init(void)
 	}
 
 	hugetlb_init_hstates();
-	gather_bootmem_prealloc();
 	report_hugepages();
 
 	hugetlb_sysfs_init();
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 498d62c4ece3..eb7222f133e6 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2330,6 +2330,7 @@ void __init page_alloc_init_late(void)
 	/* Reinit limits that are based on free pages after the kernel is up */
 	files_maxfiles_init();
 #endif
+	hugetlb_bootmem_struct_page_init();
 
 	/* Accounting of total+free memory is stable at this point. */
 	mem_init_print_info();
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index dff8da23eabb..50df73b8f747 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -342,8 +342,8 @@ static __meminit struct page *vmemmap_get_tail(unsigned int order, struct zone *
 	 *
 	 * Any initialization done here will be overwritten by memmap_init().
 	 *
-	 * gather_bootmem_prealloc() will take care of initialization after
-	 * memmap_init().
+	 * hugetlb_bootmem_struct_page_init() will take care of initialization
+	 * after memmap_init().
 	 */
 
 	p = vmemmap_alloc_block_zero(PAGE_SIZE, node);

