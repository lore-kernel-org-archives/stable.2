Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4D23290BD
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 03:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781236773; cv=none; b=JgBRhBJLOZmvxZ/G85YMLOPk0gAg8F6Dy3GWyHiaIJWtYLnHCe8QfGP6bVT6jYfJkQ/xCtZ+iPBY43Qgu/FVWCyZDYNzC6aJ+BRBY+gMb6nwS5p/cDThB3Y3aocl5DA6WSgGqSM8qaEA8Xbn0Ij0xDv+Ra9dDl0l3UzW+H5iDog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781236773; c=relaxed/simple;
	bh=x9z/vRDeyr9Fu3596Te+LWfQJ5AgaVC79DfGI8JIx6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uP6FtjDrNmCbR88TXcoHIKs8tWb8xuxxTISvag6JTUCPG3NO0HRQqkhlabhtbrEDwIFLXSGQCLnpbvoLJXqfwAoPFwpmLsqSskVGRPYN/m8YKLqZ/R9UZACQvGdJuHeEqLStIdnr2R3cVzfXf9p4YbOtZrReTY21WP+wZyFNiS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kmwW1qEf; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kmwW1qEf"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-842307472d4so251565b3a.0
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 20:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781236772; x=1781841572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bw/+TUFGRb1cb6WBPutvKTpZXTM41uBrQaMLYOSWWQg=;
        b=kmwW1qEf4ygSo/Dk1/wfbv7+s6AQOGo8HVpFwtOgKs1jx1hdAWIg9tUaGPTa8rYY4/
         6tpRTtwsh1Al+VSrm8aOzRoumuSpH726blbJxVcKcQCbHbl1wZKCyydcyg/5SKA+aiZC
         sqjKnKDx2fhKE7tl4H09HmjQauaDR5x5yeiemxDwll7jU8bXqMS4enGbJYRHmeDNKk6f
         UE6nLNQWWKyB+f5rC9Tp+MxoDGpCSJtj2vy+yIn0F6a8slvj+rrNS4I+eLDe3oikVWxz
         G+WN+0hJN7YYhistgtuTLaK4y9Hd3I4WagA55SpnAjHY5lBVoq5pINo/inGtVu2P0S3w
         vEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236772; x=1781841572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bw/+TUFGRb1cb6WBPutvKTpZXTM41uBrQaMLYOSWWQg=;
        b=n+whGO3xn0hfBFgmcudaqdb1pjsQZKwIpxa14+HpDkueTNvdrOOnvld1+3QztB9ohe
         kRFaoFqlv58Df4P6fvjrAAoVevKuwhaECChP5xRSLnbIpJV0oH0358JDeIQc4Lkb6+ew
         hFRHuiJm689UQKrsQkp8AYEHPEh74HQQFlIyCghdGXhx8J42CFiAcJ4POnrj+Dfw18Xb
         /9RSmQY4zr59SStKDJuLXCH3jDrmOxr5BxT6A2e8G07XZEslcOSIGgE2jXDY9mPj4RAI
         SCdFq7NW3hdF8zY76iAWrblRjEOxaWFfUyK7Vp9aDvX545mVWMgdsJ9BNE1iyljGR/cy
         jKmQ==
X-Forwarded-Encrypted: i=1; AFNElJ/4FmiUhbagUp7enBilLzQOF76TWnmqOrQGcd26qkdxtlj3/yjGUtRc/Ny6/4kgyFTUsV2J7b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVaY0PigTHei48qrlFMulEVBefLydGg+26tQ25F3UHWOS7fW2/
	6ICQClqthfBs5kfyPPzzYG5Eg2tBmrds/WCYiWzFr0lnaYdYfQlzp+2gucM32pp8wvQ=
X-Gm-Gg: Acq92OEasEGsmMDFMbtw864z83IxNaQK/MINs8gWFBG0z0miuLqXDUZLq0fJQSSeofY
	SdtPXg+4s80TwoAKYK4kqvE9TrQ4dKNKYpzKZAoHwdjaCRkv/SqoXC3/7zdW+oDAKQgxOaOLW+t
	Sq7VR999NjcnV+zwV969Ceolq6w5tQGwe2V4460BcesK2KMchIw+CkRtcxHSfEx7ce9pmw3jVoP
	R3JcyMU468ADy3HZZa5BPZWldpG/r0O4XsTWnEHm9dpAi0fMNY4HpvxL21vc16k6RrbWUX0vIJL
	UYNXLF6Fq2EZSuvDrQOEPfOnifsndPrmIrc8KltjGmqZpeHpzTEqiq3JelUq21u0VEzRtmikraj
	Nd1pcnztsWGI5KUXtGtBSEYu0qb9LHG0uZG2MyRpfDCj+vE0ZRURWjO3CYPK3VBYfcfWqTFnUgk
	Sff1ND+NGPNnu15N1ir338s29fSl8EyHUKMr/TfhFgQYM=
X-Received: by 2002:a05:6a00:3395:b0:842:5b1e:5908 with SMTP id d2e1a72fcca58-8434d0795a6mr1106623b3a.25.1781236771699;
        Thu, 11 Jun 2026 20:59:31 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm643352b3a.24.2026.06.11.20.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 20:59:31 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 04/19] mm/hugetlb: Initialize gigantic bootmem hugepage struct pages earlier
Date: Fri, 12 Jun 2026 11:58:48 +0800
Message-ID: <20260612035903.2468601-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612035903.2468601-1-songmuchun@bytedance.com>
References: <20260612035903.2468601-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gigantic bootmem HugeTLB pages are currently initialized from hugetlb_init(),
but page_alloc_init_late() runs earlier and walks pageblocks to determine
zone contiguity.

If a bootmem HugeTLB region is marked noinit, set_zone_contiguous() can
observe still-uninitialized struct pages through __pageblock_pfn_to_page().
This may not trigger an immediate failure, but it can make
set_zone_contiguous() compute the wrong zone contiguity state. If extra
poisoned-page checks are added in this path, such as PF_POISONED_CHECK()
in page_zone_id(), it can also trigger an early boot panic.

Initialize gigantic bootmem HugeTLB struct pages from page_alloc_init_late(),
before zone contiguity is evaluated, so later page allocator setup only
sees valid struct page state. This also makes the initialization order
more natural, as struct pages should be initialized before later code
inspects them.

Fixes: fde1c4ecf916 ("mm: hugetlb: skip initialization of gigantic tail struct pages if freed by HVO")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/hugetlb.h | 5 +++++
 mm/hugetlb.c            | 5 ++---
 mm/mm_init.c            | 1 +
 mm/sparse-vmemmap.c     | 4 ++--
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 2abaf99321e9..3700c0a1f6ff 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -171,6 +171,7 @@ extern int movable_gigantic_pages __read_mostly;
 extern int sysctl_hugetlb_shm_group __read_mostly;
 extern struct list_head huge_boot_pages[MAX_NUMNODES];
 
+void hugetlb_bootmem_struct_page_init(void);
 void hugetlb_bootmem_alloc(void);
 extern nodemask_t hugetlb_bootmem_nodes;
 void hugetlb_bootmem_set_nodes(void);
@@ -1293,6 +1294,10 @@ static inline bool hugetlbfs_pagecache_present(
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
index cd55524c7e30..2bf9fe16abb9 100644
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
index 0f64909e8d20..92e88fca717f 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2323,6 +2323,7 @@ void __init page_alloc_init_late(void)
 	/* Reinit limits that are based on free pages after the kernel is up */
 	files_maxfiles_init();
 #endif
+	hugetlb_bootmem_struct_page_init();
 
 	/* Accounting of total+free memory is stable at this point. */
 	mem_init_print_info();
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index bb23fb3077a3..6e09000ed3e1 100644
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
-- 
2.54.0

