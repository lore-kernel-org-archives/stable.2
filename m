Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389882;
	b=m+IpHbIQ0fpjmo99VH9mwZ/yoheQNsZICx8mLTbochR+5012WHV+Y1qtx2GYo51qrXpK
	 tS8ekhzHAhgGD87ffvDfcftiuHpxFrla5jzqHNwhQxgOuAZiAynKZjfhM5vxDjGTL+d25
	 qO9tcEmyNXYXtZnjFYVJzhk3gW4KskU6M10q0TYRh7+raIWNgV43QIplEbdqsHPIrZ7Ff
	 fvoOHBg1zcFW6cm2nywocY1x64mPSzGnSSak+0uisakGm+oytds7ERJ1tSJV6o5zN6M9j
	 NPgjAG4k2GhaC0emmQuBGEnQOVmqlsdQyOQdnHVMs4MDGbKxku5/wFDmpXYUwbzwKOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=J/lAuxNghYAit4d32b2tzmDG6oe5SfeXzLViO4wF0VE=;
	b=TO9+BaLHOuMgkun+Vd3Yv15BeSoCTXywHnlUfgMD5rIa/D6jV3cg+LbWJ48Zmmhvp/UW
	 nsiCO6OEgCgHEH1GdvyTwbu613J2ObveQ/kdWf/DArXzJQ35C5HnbqZF2jGG9LrOwWjHX
	 Mwu64+EVcMn2m7emuUdPrEbAzRrFJFLJeCI6ChN+mMOL982N/uFU2mudih/1R0D70H37S
	 tCycvr1fe6FlHHG/xA+wFhBD6NK4M3KXJVTBcNAJ9jsJlhdaVGWMjaADOGkOdlHgiwHuU
	 xMV/E363T/cZEAIJ9UM0i3+oGKu3tO3scDRO/FazfDri5EybZaX3r8fYs4hS+QfZQww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b="S79/0nLL";
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C685606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C685606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=S79/0nLL
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-37628596783so1940326eec.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794389880; x=1794994680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J/lAuxNghYAit4d32b2tzmDG6oe5SfeXzLViO4wF0VE=;
        b=S79/0nLLr8Y/haTXb45MLdlAHOd6mL8N7KA+6JaBFGEfJ4mJW54lMIw+985zMrpw15
         xho9tXRKqDH0xoJ07/wvi+1UOKBHJG4rvfXJEJtxCCNRcRn+QrlwMvNncHZDR7WXUURz
         pMOxdTIPkset8GgRI7l/+vCKpQBNHGqCJay96g+KtXfDztgyMZjnxEI9p6BEnjFZ0iNn
         FNwQTHQPzEGViDKdh9krSMfu8V+kH0sTMKgbuw/3H7URheiDpxgPW+GPrrwgC/KmHkuu
         BVKFUPWP321aWCDg/ilrBmebep9AXj/lratILzAgN8Xb00SAyOyUm4MNPtWa7RPROQyl
         7GrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794389880; x=1794994680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J/lAuxNghYAit4d32b2tzmDG6oe5SfeXzLViO4wF0VE=;
        b=lihkJTMKeMr04czMtGNuX82GbMDPJ1dqNOK8OhPu5xUBvzzXShAgerF+4XLP4FaXRw
         m9mqdPMc2HcCcPpman66h0I55/UxFrim2lKO0cgsOBr8gwEBmNqV1O2q2YQEqJ2tjAMB
         YRmbGcO7wIoGp/WFfDxBt1jQr1H4EYyO12hClT8l5D7JIWxXuxJj6yekQWSAFY/NM0C9
         F5sv4IWRV1xT6ZZc5PP+PgphuQ60ZzPC3E1SShczLGsVC40eGnnl+Hfpv+ZomyppgyNs
         FzzfzWbMKwN+sObSELSM3KK7a17nlhqyhNXn0Y+smTU1D4pWLHNONdH6T0CKD2YCinL0
         V+lA==
X-Forwarded-Encrypted: i=1; AL+hErGYqGHFMrzftv0qmDFkDFg9Ws+RzoK5U2LwBCq3UhLf24I9ByyvVruoGzXh6QaMNoqVp60s60M=@vger.kernel.org
X-Gm-Message-State: APuU4Z9OBhLJNORePOZxhWqSXCy5Scar3Fdykdoso2STytA1ROZMN/io
	DrnsdeSZ++xObv/Jq/rRAPMV6ofu7Bh/jGHUkNRVTH89Z6rK72sn14sNjIjlm0zBZVc=
X-Gm-Gg: AYBFou1IPe0OvsE/3EInXmxHMNqLWJFFqyD2CU28CG78s/LqKs3zDA/hb9py8ixX9Am
	57KPkhfh41xhfpQWIVqm32lnu+/dI3DwP6PS7AHWfmlPqzHFOltS3v0A5zW1x5BsF7g6aLyGlU5
	AP4xP+bJ2LkNrd47kDtnGFHkxlsNoJqzNO1oJPq5QGDv6lDK4Qyrx6bFXy52jrz9YeYOx00ufn+
	SiLQOkIqe9TXkwaGp3dF9U3CD+acG0VIlgQBBBROhBJ6BThp1VEsJm2IvmDw+IBZc7qzGM8CUpi
	bkja1kyrF5myEBEgyzPZsu9pV85toZY91JmuA4DyRL2o+UakBq6ZN9xJYLHuDO7TKvoVp2qd1sD
	6wDeNisz0UgHWZKwDxXYL/zdxOtMbNb1FcmDl9pT6tSv7I1zVesiq81zUjVRi2YSh9MTHyzbBM5
	FDAfK/PTmGst7roJwXtqB3AbKHp76G+591GSLjftBrdKxtCZUXmzIYLWOR5nyepKU3opeM3Sp4S
	iqBGRt2HojotFKU2Ol0tEqrh/Vfcr6zBPmGffP7JUh8Ni1IFB9JwUQrvlROetGDDW2WBnnE3D+e
	H3fTvZJr0S8TEYHZISyerrevgLbpmLU8PSX2qYI7iHokqJH4VJkUNTqmB6CIbQ==
X-Received: by 2002:a05:7301:2907:b0:369:fdae:c9fd with SMTP id 5a478bee46e88-376850ce224mr3460636eec.13.1794389880052;
        Wed, 11 Nov 2026 01:38:00 -0800 (PST)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e9e03sm29016749eec.23.2026.11.11.01.37.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 01:37:59 -0800 (PST)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Miaohe Lin <linmiaohe@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] mm/hugetlb_vmemmap: fix lost HWPoison state during optimization
Date: Wed, 11 Nov 2026 17:37:44 +0800
Message-ID: <20261111093747.50048-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111093747.50048-1-songmuchun@bytedance.com>
References: <20261111093747.50048-1-songmuchun@bytedance.com>
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

HVO copies the vmemmap head page before remapping it to a newly allocated
backing page. Memory failure can update the old head page after the copy
but before the remap's TLB invalidation completes:

CPU 0                            CPU 1
init_new_hugetlb_folio()
__hugetlb_vmemmap_optimize_folio()
  vmemmap_optimize_pte()
    copy_page(old_head, new_head)
                                 try_memory_failure_hugetlb()
                                   get_huge_page_for_hwpoison()
                                     hugetlb_update_hwpoison(old_head)
  set_pte_at(..., new_head)
  flush_tlb_all()
free_vmemmap_page_list(old_head)

The raw_hwp_page linked to the old head is then leaked and the folio's
HWPoison state is lost when the obsolete backing page is freed, allowing
the poisoned huge page to be allocated later.

Serialize HVO remapping against HWPoison updates. This ensures that an
update is either copied to the new vmemmap head page or applied after HVO
installs the new mapping and completes the TLB flush.

Fixes: 11aad2631bf7 ("mm/hugetlb_vmemmap: remap head page to newly allocated page")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-18e93f17-529b-4d84-ba44-a41829f4be64
---
 mm/hugetlb_vmemmap.c | 10 ++++++++++
 mm/hugetlb_vmemmap.h | 24 ++++++++++++++++++++++++
 mm/memory-failure.c  |  2 ++
 3 files changed, 36 insertions(+)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index ba8e11e399b2..79ca68dff635 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -15,6 +15,7 @@
 #include <linux/mmdebug.h>
 #include <linux/pagewalk.h>
 #include <linux/pgalloc.h>
+#include <linux/rwsem.h>
 #include <linux/vmemmap-optimization.h>
 
 #include <asm/tlbflush.h>
@@ -41,6 +42,8 @@ struct vmemmap_remap_walk {
 	unsigned long		flags;
 };
 
+DECLARE_RWSEM(vmemmap_remap_rwsem);
+
 static int vmemmap_split_pmd(pmd_t *pmd, struct page *head, unsigned long start,
 			     struct vmemmap_remap_walk *walk)
 {
@@ -333,6 +336,9 @@ static int vmemmap_pteify_folio(const struct folio *folio, unsigned long flags)
  * responsible for freeing the pages left on the @vmemmap_pages list, even on
  * failure.
  *
+ * Note: The caller must hold vmemmap_remap_rwsem. If TLB flushing is deferred,
+ * the lock must remain held until the final TLB flush.
+ *
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_optimize_folio(const struct folio *folio,
@@ -348,6 +354,8 @@ static int vmemmap_optimize_folio(const struct folio *folio,
 		.flags		= flags,
 	};
 
+	rwsem_assert_held(&vmemmap_remap_rwsem);
+
 	VM_WARN_ON_ONCE_FOLIO(folio_ref_count(folio), folio);
 
 	if (!vmemmap_optimizable_order(folio_order(folio)))
@@ -536,6 +544,7 @@ void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio)
 {
 	LIST_HEAD(vmemmap_pages);
 
+	guard(rwsem_read)(&vmemmap_remap_rwsem);
 	__hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages, 0);
 	free_vmemmap_page_list(&vmemmap_pages);
 }
@@ -588,6 +597,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 
 	flush_tlb_all();
 
+	guard(rwsem_read)(&vmemmap_remap_rwsem);
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret;
 
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index d057e8b12bf1..8b28063d78cc 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -9,9 +9,12 @@
 #ifndef _LINUX_HUGETLB_VMEMMAP_H
 #define _LINUX_HUGETLB_VMEMMAP_H
 #include <linux/hugetlb.h>
+#include <linux/rwsem.h>
 #include <linux/vmemmap-optimization.h>
 
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+extern struct rw_semaphore vmemmap_remap_rwsem;
+
 int hugetlb_vmemmap_restore_folio(const struct hstate *h, struct folio *folio);
 long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 					struct list_head *folio_list,
@@ -20,6 +23,16 @@ void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio)
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
 void hugetlb_vmemmap_optimize_bootmem_page(unsigned long pfn, unsigned int order);
 
+static inline void hugetlb_vmemmap_write_lock(void)
+{
+	down_write(&vmemmap_remap_rwsem);
+}
+
+static inline void hugetlb_vmemmap_write_unlock(void)
+{
+	up_write(&vmemmap_remap_rwsem);
+}
+
 static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
 {
 	return pages_per_huge_page(h) * sizeof(struct page);
@@ -59,6 +72,14 @@ static inline void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list
 {
 }
 
+static inline void hugetlb_vmemmap_write_lock(void)
+{
+}
+
+static inline void hugetlb_vmemmap_write_unlock(void)
+{
+}
+
 static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
 {
 	return 0;
@@ -69,6 +90,9 @@ static inline void hugetlb_vmemmap_optimize_bootmem_page(unsigned long pfn, unsi
 }
 #endif /* CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP */
 
+DEFINE_LOCK_GUARD_0(vmemmap_remap,
+		    hugetlb_vmemmap_write_lock(), hugetlb_vmemmap_write_unlock())
+
 static inline bool hugetlb_vmemmap_optimizable(const struct hstate *h)
 {
 	return hugetlb_vmemmap_optimizable_size(h) != 0;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 78f0a13349cb..164a02866fd5 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -69,6 +69,7 @@
 #include "page_alloc.h"
 #include "internal.h"
 #include "memory-failure.h"
+#include "hugetlb_vmemmap.h"
 
 static int sysctl_memory_failure_early_kill __read_mostly;
 
@@ -2038,6 +2039,7 @@ static int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 	bool count_increased = false;
 	int ret, rc;
 
+	guard(vmemmap_remap)();
 	spin_lock_irq(&hugetlb_lock);
 	folio = page_folio(page);
 	if (!folio_test_hugetlb(folio)) {
-- 
2.54.0

