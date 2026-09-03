Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEB64EE859
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453238; cv=none; b=UvI9+x0T7rCI03IZ9Au4ZeMj8VXGKzjYvv6Felj3yaYTe+KBmW4y2DRV4Y2JrfhcfJi2KvXzTbVxXzUsV6tHVkiFUyml9GfjgZGcapo6S4fUYrScSsyRAvfjJ6U8/I8CQvMmrUWW2MFds8HwCDcf3MfjJmSZuf9kcvpxBlmPwig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453238; c=relaxed/simple;
	bh=aNB6iHbNdDaxM3Ne6JQ1xM8htycdsMii4YvSQCMvOXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgXDa9Fz+pdfn5sNwiCTjKQQfb+yBZ/h/WU0o+6FRih+LBqABCXxLPYqOI8ZYjqD5CjCvaIv1agiug2HZaQSMwE9bpgpLase7gCPGRHJ6xOvDEzkNEjvodCfaIDVef7Hi8Tf+rq7ygQ9PHccckMRbYoMN3MY3fwQC0mV6/WzRk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoJkaqM/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoJkaqM/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E82D1F00AC4;
	Thu,  3 Sep 2026 16:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788453236;
	bh=BNpZKHyEyRYxi7tEmLXkRb3F/UXJSw+YwiNcq+lSC1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LoJkaqM/Az8iNnSTA4DwArMLMnL7/EBIQ/gvK3K1p6JVRpo+OCTg0aSV1DycReJoD
	 I0jXQyRXacaKtKPQY3fVXqmnV8pJD6jRwJJKUTVX3sFe3gpAg1OZiOJ7tFnzkE3mtP
	 TuiTSgYTHj+BXTiT2vD55Y1ajqFFc4+BVF9kNqDP/gEw3YjBthcIJCfhxhs9gNfFi7
	 0Aa6jzJJzlb8BhrZeZOzMzw63ne9WQVRAJbMv6SCCksfNWyaeVa9UX/K68JICPrlTy
	 rDba5xgrpssl/1mFD4BB5C3N19NjM+COvzRUrzu7HuRHv516O/ku6R6CjSA+mBt9VT
	 AQ+rfe90Ok8Wg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Muchun Song <songmuchun@bytedance.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Frank van der Linden <fvdl@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Oscar Salvador (SUSE)" <osalvador@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Usama Arif <usama.arif@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] mm/hugetlb: initialize gigantic bootmem hugepage struct pages earlier
Date: Thu,  3 Sep 2026 12:33:47 -0400
Message-ID: <20260903163347.987961-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903163347.987961-1-sashal@kernel.org>
References: <2026090313-purgatory-bondless-206f@gregkh>
 <20260903163347.987961-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muchun Song <songmuchun@bytedance.com>

[ Upstream commit b1b7c045e808c761b1cc8c19b3040fadedda3fef ]

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
[ adapted the header context and omitted a comment update for an absent HVO helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/hugetlb.h | 5 +++++
 mm/hugetlb.c            | 5 ++---
 mm/mm_init.c            | 1 +
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index a3f6cdf8a2b6d..bf666f9ece1eb 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -173,6 +173,7 @@ struct address_space *hugetlb_folio_mapping_lock_write(struct folio *folio);
 extern int sysctl_hugetlb_shm_group;
 extern struct list_head huge_boot_pages[MAX_NUMNODES];
 
+void hugetlb_bootmem_struct_page_init(void);
 void hugetlb_bootmem_alloc(void);
 bool hugetlb_bootmem_allocated(void);
 extern nodemask_t hugetlb_bootmem_nodes;
@@ -1314,6 +1315,10 @@ static inline bool hugetlb_bootmem_allocated(void)
 {
 	return false;
 }
+
+static inline void hugetlb_bootmem_struct_page_init(void)
+{
+}
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5515870b5b155..1d40bb65421c5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3451,7 +3451,7 @@ static void __init gather_bootmem_prealloc_parallel(unsigned long start,
 		gather_bootmem_prealloc_node(nid);
 }
 
-static void __init gather_bootmem_prealloc(void)
+void __init hugetlb_bootmem_struct_page_init(void)
 {
 	struct padata_mt_job job = {
 		.thread_fn	= gather_bootmem_prealloc_parallel,
@@ -3648,7 +3648,7 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
  * - For gigantic pages, this is called early in the boot process and
  *   pages are allocated from memblock allocated or something similar.
  *   Gigantic pages are actually added to pools later with the routine
- *   gather_bootmem_prealloc.
+ *   hugetlb_bootmem_struct_page_init.
  * - For non-gigantic pages, this is called later in the boot process after
  *   all of mm is up and functional.  Pages are allocated from buddy and
  *   then added to hugetlb pools.
@@ -4715,7 +4715,6 @@ static int __init hugetlb_init(void)
 
 	hugetlb_cma_check();
 	hugetlb_init_hstates();
-	gather_bootmem_prealloc();
 	report_hugepages();
 
 	hugetlb_sysfs_init();
diff --git a/mm/mm_init.c b/mm/mm_init.c
index d2d915984611a..d11eb841b45ca 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2354,6 +2354,7 @@ void __init page_alloc_init_late(void)
 	/* Reinit limits that are based on free pages after the kernel is up */
 	files_maxfiles_init();
 #endif
+	hugetlb_bootmem_struct_page_init();
 
 	/* Accounting of total+free memory is stable at this point. */
 	mem_init_print_info();
-- 
2.53.0

