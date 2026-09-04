Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FEC35201E
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 02:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490345; cv=none; b=ilVOHuhL8O1vahclc4LwRkVlZBYs515hum7MwwSA1FQaUTJXXIOzR3Clc5MicE/jb6DIR+2HxOAKNBdByg/NJm06sk4BZadqN6sP3+qNaof6um1l4Cnwkhn3fUomVCKEjViQO3GqcERXY/thjwv26pvCtkQIEKLg3BJyhxIdrjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490345; c=relaxed/simple;
	bh=kbEL/gceOn6UmZ/I6MWAqnDcdnT0Lc94+sflILML6a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlqyVlMDs6oDvn413FMY8qatHAe4SW2GCz0fDXVZ71EB5Xu3FNipUaMSAyHWFaMtaJLFtmgdB1divCejfvt3CwcwuOtRy3tVYVgGKJtHpbpB/4ybI9lsK7FNf6oBYWeph6lv7SGmPRoRcYrlgM8SP5XHgVL29bEbBE/dbgk4UhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsXdHQfS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsXdHQfS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587751F000E9;
	Fri,  4 Sep 2026 02:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490343;
	bh=vZpwdYNmsUp+PUrYRgEyQz/fUy5ZNu6tfC9qu6+GjAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IsXdHQfSKxLvquhlkp2seOdI3iAImdDOEu2bZ57DyuP47WTQ7hM8GQqo6zHe9ObmH
	 Syk3irg35fkyNNVg1i3/YfJpvLYNcaGxRgnTVUQajgL++VkqWeo8xDqA0FOnbaXauZ
	 i/rGn+k+5pXpIlDKBqfv39Y8L+2GHSdnJz5Mq4XkSoOzJyALGLcnTP5Cl7dlBx680q
	 /cKGZK7VlMfI9Db1gUp6x4rnXWC0kQWDpAMJeDLWSLplVottG+q9WqsC9mdoN8Moc2
	 3ObFALanpQK3ARGYG+mhwayXV33f20xBSUTM9q8F1isYzUiy5yFJzVrfKMjpvTgRlA
	 GvidR/HFZ9nTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alistair Popple <apopple@nvidia.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Byungchul Park <byungchul@sk.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Dev Jain <dev.jain@arm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Gregory Price <gourry@gourry.net>,
	Heiko Carstens <hca@linux.ibm.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Hugh Dickins <hughd@google.com>,
	Jan Kara <jack@suse.cz>,
	Jann Horn <jannh@google.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Lance Yang <lance.yang@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Liam Howlett <liam.howlett@oracle.com>,
	Mathew Brost <matthew.brost@intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Nico Pache <npache@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Peter Xu <peterx@redhat.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Rik van Riel <riel@surriel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	SeongJae Park <sj@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Wei Xu <weixugc@google.com>,
	xu xin <xu.xin16@zte.com.cn>,
	Yuanchu Xie <yuanchu@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] mm: avoid unnecessary use of is_swap_pmd()
Date: Thu,  3 Sep 2026 22:52:15 -0400
Message-ID: <20260904025216.2265672-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090345-number-strenuous-f36b@gregkh>
References: <2026090345-number-strenuous-f36b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

[ Upstream commit aa62204cb680d8ff32497181fc9e0dac4956f7e5 ]

PMD 'non-swap' swap entries are currently used for PMD-level migration
entries and device private entries.

To add to the confusion in this terminology we use is_swap_pmd() in an
inconsistent way similar to how is_swap_pte() was being used - sometimes
adopting the convention that !pmd_none(), !pmd_present() implies PMD 'swap'
entry, sometimes not.

This patch handles the low-hanging fruit of cases where we can simply
substitute other predicates for is_swap_pmd().

No functional change intended.

Link: https://lkml.kernel.org/r/8a1704b36a009c18032d5bea4cb68e71448fbbe5.1762812360.git.lorenzo.stoakes@oracle.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Chris Li <chrisl@kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jann Horn <jannh@google.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Mathew Brost <matthew.brost@intel.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Wei Xu <weixugc@google.com>
Cc: xu xin <xu.xin16@zte.com.cn>
Cc: Yuanchu Xie <yuanchu@google.com>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: f5407e9b697c ("mm/rmap: use huge_ptep_get() in try_to_unmap_one()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/task_mmu.c       | 15 ++++++++---
 include/linux/mm_types.h |  3 +++
 include/linux/swapops.h  | 12 ++++++++-
 mm/huge_memory.c         |  4 ++-
 mm/memory.c              | 49 ++++++++++++++++++++----------------
 mm/page_table_check.c    | 12 ++++++---
 mm/rmap.c                | 54 ++++++++++++++++++++++++++++++----------
 7 files changed, 105 insertions(+), 44 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 44dc442b4f0e7..cfcf0daa1e626 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -860,10 +860,12 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	bool present = false;
 	struct folio *folio;
 
+	if (pmd_none(*pmd))
+		return;
 	if (pmd_present(*pmd)) {
 		page = vm_normal_page_pmd(vma, addr, *pmd);
 		present = true;
-	} else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
+	} else if (unlikely(thp_migration_supported())) {
 		swp_entry_t entry = pmd_to_swp_entry(*pmd);
 
 		if (is_pfn_swap_entry(entry))
@@ -1786,6 +1788,9 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		if (vma->vm_flags & VM_SOFTDIRTY)
 			flags |= PM_SOFT_DIRTY;
 
+		if (pmd_none(pmd))
+			goto populate_pagemap;
+
 		if (pmd_present(pmd)) {
 			page = pmd_page(pmd);
 
@@ -1798,7 +1803,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 				frame = pmd_pfn(pmd) + idx;
 		}
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
-		else if (is_swap_pmd(pmd)) {
+		else {
 			swp_entry_t entry = pmd_to_swp_entry(pmd);
 			unsigned long offset;
 
@@ -1826,6 +1831,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 				flags |= PM_FILE;
 		}
 
+populate_pagemap:
 		for (; addr != end; addr += PAGE_SIZE, idx++) {
 			u64 cur_flags = flags;
 			pagemap_entry_t pme;
@@ -2172,6 +2178,9 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
 {
 	unsigned long categories = PAGE_IS_HUGE;
 
+	if (pmd_none(pmd))
+		return categories;
+
 	if (pmd_present(pmd)) {
 		struct page *page;
 
@@ -2189,7 +2198,7 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
 			categories |= PAGE_IS_PFNZERO;
 		if (pmd_soft_dirty(pmd))
 			categories |= PAGE_IS_SOFT_DIRTY;
-	} else if (is_swap_pmd(pmd)) {
+	} else {
 		swp_entry_t swp;
 
 		categories |= PAGE_IS_SWAPPED;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 2113f7da182c6..ca4e4a1c2d0b9 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -283,6 +283,9 @@ typedef struct {
 	unsigned long val;
 } swp_entry_t;
 
+/* Transitional name used by newer MM fixes. */
+typedef swp_entry_t softleaf_t;
+
 /**
  * struct folio - Represents a contiguous set of bytes.
  * @flags: Identical to the page flags.
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index d988ce9516510..d06bda5be5768 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -139,6 +139,10 @@ static inline swp_entry_t pte_to_swp_entry(pte_t pte)
 	return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
 }
 
+/* Transitional softleaf spellings for the equivalent swap entry helpers. */
+#define softleaf_from_pte(pte) pte_to_swp_entry(pte)
+#define softleaf_to_pfn(entry) swp_offset_pfn(entry)
+
 /*
  * Convert the arch-independent representation of a swp_entry_t into the
  * arch-dependent pte representation.
@@ -569,7 +573,13 @@ static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
 
 static inline int is_pmd_migration_entry(pmd_t pmd)
 {
-	return is_swap_pmd(pmd) && is_migration_entry(pmd_to_swp_entry(pmd));
+	swp_entry_t entry;
+
+	if (pmd_present(pmd))
+		return 0;
+
+	entry = pmd_to_swp_entry(pmd);
+	return is_migration_entry(entry);
 }
 #else  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
 static inline int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 29cbe43b60a4f..6fc4e1fb88ae6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2149,9 +2149,11 @@ static pmd_t move_soft_dirty_pmd(pmd_t pmd)
 
 static pmd_t clear_uffd_wp_pmd(pmd_t pmd)
 {
+	if (pmd_none(pmd))
+		return pmd;
 	if (pmd_present(pmd))
 		pmd = pmd_clear_uffd_wp(pmd);
-	else if (is_swap_pmd(pmd))
+	else
 		pmd = pmd_swp_clear_uffd_wp(pmd);
 
 	return pmd;
diff --git a/mm/memory.c b/mm/memory.c
index 359de59c39b1a..c493f18cfb3ab 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5901,34 +5901,39 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	    thp_vma_allowable_order(vma, vm_flags,
 				TVA_IN_PF | TVA_ENFORCE_SYSFS, PMD_ORDER)) {
 		ret = create_huge_pmd(&vmf);
-		if (!(ret & VM_FAULT_FALLBACK))
+		if (ret & VM_FAULT_FALLBACK)
+			goto fallback;
+		else
 			return ret;
-	} else {
-		vmf.orig_pmd = pmdp_get_lockless(vmf.pmd);
+	}
 
-		if (unlikely(is_swap_pmd(vmf.orig_pmd))) {
-			VM_BUG_ON(thp_migration_supported() &&
-					  !is_pmd_migration_entry(vmf.orig_pmd));
-			if (is_pmd_migration_entry(vmf.orig_pmd))
-				pmd_migration_entry_wait(mm, vmf.pmd);
-			return 0;
-		}
-		if (pmd_trans_huge(vmf.orig_pmd) || pmd_devmap(vmf.orig_pmd)) {
-			if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
-				return do_huge_pmd_numa_page(&vmf);
+	vmf.orig_pmd = pmdp_get_lockless(vmf.pmd);
+	if (pmd_none(vmf.orig_pmd))
+		goto fallback;
 
-			if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
-			    !pmd_write(vmf.orig_pmd)) {
-				ret = wp_huge_pmd(&vmf);
-				if (!(ret & VM_FAULT_FALLBACK))
-					return ret;
-			} else {
-				huge_pmd_set_accessed(&vmf);
-				return 0;
-			}
+	if (unlikely(!pmd_present(vmf.orig_pmd))) {
+		VM_BUG_ON(thp_migration_supported() &&
+				  !is_pmd_migration_entry(vmf.orig_pmd));
+		if (is_pmd_migration_entry(vmf.orig_pmd))
+			pmd_migration_entry_wait(mm, vmf.pmd);
+		return 0;
+	}
+	if (pmd_trans_huge(vmf.orig_pmd) || pmd_devmap(vmf.orig_pmd)) {
+		if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
+			return do_huge_pmd_numa_page(&vmf);
+
+		if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
+		    !pmd_write(vmf.orig_pmd)) {
+			ret = wp_huge_pmd(&vmf);
+			if (!(ret & VM_FAULT_FALLBACK))
+				return ret;
+		} else {
+			huge_pmd_set_accessed(&vmf);
+			return 0;
 		}
 	}
 
+fallback:
 	return handle_pte_fault(&vmf);
 }
 
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 509c6ef8de400..ee52927e9e66b 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -228,10 +228,14 @@ EXPORT_SYMBOL(__page_table_check_ptes_set);
 
 static inline void page_table_check_pmd_flags(pmd_t pmd)
 {
-	if (pmd_present(pmd) && pmd_uffd_wp(pmd))
-		WARN_ON_ONCE(pmd_write(pmd));
-	else if (is_swap_pmd(pmd) && pmd_swp_uffd_wp(pmd))
-		WARN_ON_ONCE(swap_cached_writable(pmd_to_swp_entry(pmd)));
+	if (pmd_present(pmd)) {
+		if (pmd_uffd_wp(pmd))
+			WARN_ON_ONCE(pmd_write(pmd));
+	} else if (pmd_swp_uffd_wp(pmd)) {
+		swp_entry_t entry = pmd_to_swp_entry(pmd);
+
+		WARN_ON_ONCE(swap_cached_writable(entry));
+	}
 }
 
 void __page_table_check_pmd_set(struct mm_struct *mm, pmd_t *pmdp, pmd_t pmd)
diff --git a/mm/rmap.c b/mm/rmap.c
index ea9c6d540d498..b7907fa14dc98 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1637,9 +1637,9 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
+	bool anon_exclusive, ret = true;
 	pte_t pteval;
 	struct page *subpage;
-	bool anon_exclusive, ret = true;
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
 	unsigned long pfn;
@@ -1711,7 +1711,20 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		/* Unexpected PMD-mapped THP? */
 		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
 
-		pfn = pte_pfn(ptep_get(pvmw.pte));
+		/*
+		 * Handle PFN swap PTEs, such as device-exclusive ones, that
+		 * actually map pages.
+		 */
+		pteval = ptep_get(pvmw.pte);
+		if (likely(pte_present(pteval))) {
+			pfn = pte_pfn(pteval);
+		} else {
+			const softleaf_t entry = softleaf_from_pte(pteval);
+
+			pfn = softleaf_to_pfn(entry);
+			VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
+		}
+
 		subpage = folio_page(folio, pfn - folio_pfn(folio));
 		address = pvmw.address;
 		anon_exclusive = folio_test_anon(folio) &&
@@ -1766,7 +1779,9 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				tlb_finish_mmu(&tlb);
 			}
 			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
-		} else {
+			if (pte_dirty(pteval))
+				folio_mark_dirty(folio);
+		} else if (likely(pte_present(pteval))) {
 			flush_cache_page(vma, address, pfn);
 			/* Nuke the page table entry. */
 			if (should_defer_flush(mm, flags)) {
@@ -1784,6 +1799,10 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			} else {
 				pteval = ptep_clear_flush(vma, address, pvmw.pte);
 			}
+			if (pte_dirty(pteval))
+				folio_mark_dirty(folio);
+		} else {
+			pte_clear(mm, address, pvmw.pte);
 		}
 
 		/*
@@ -1793,10 +1812,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		 */
 		pte_install_uffd_wp_if_needed(vma, address, pvmw.pte, pteval);
 
-		/* Set the dirty flag on the folio now the pte is gone. */
-		if (pte_dirty(pteval))
-			folio_mark_dirty(folio);
-
 		/* Update high watermark before we lower rss */
 		update_hiwater_rss(mm);
 
@@ -1810,8 +1825,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				dec_mm_counter(mm, mm_counter(folio));
 				set_pte_at(mm, address, pvmw.pte, pteval);
 			}
-
-		} else if (pte_unused(pteval) && !userfaultfd_armed(vma)) {
+		} else if (likely(pte_present(pteval)) && pte_unused(pteval) &&
+			   !userfaultfd_armed(vma)) {
 			/*
 			 * The guest indicated that the page content is of no
 			 * interest anymore. Simply discard the pte, vmscan
@@ -1890,6 +1905,12 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				set_pte_at(mm, address, pvmw.pte, pteval);
 				goto walk_abort;
 			}
+
+			/*
+			 * arch_unmap_one() is expected to be a NOP on
+			 * architectures where we could have PFN swap PTEs,
+			 * so we'll not check/care.
+			 */
 			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
 				swap_free(entry);
 				set_pte_at(mm, address, pvmw.pte, pteval);
@@ -1914,10 +1935,17 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			swp_pte = swp_entry_to_pte(entry);
 			if (anon_exclusive)
 				swp_pte = pte_swp_mkexclusive(swp_pte);
-			if (pte_soft_dirty(pteval))
-				swp_pte = pte_swp_mksoft_dirty(swp_pte);
-			if (pte_uffd_wp(pteval))
-				swp_pte = pte_swp_mkuffd_wp(swp_pte);
+			if (likely(pte_present(pteval))) {
+				if (pte_soft_dirty(pteval))
+					swp_pte = pte_swp_mksoft_dirty(swp_pte);
+				if (pte_uffd_wp(pteval))
+					swp_pte = pte_swp_mkuffd_wp(swp_pte);
+			} else {
+				if (pte_swp_soft_dirty(pteval))
+					swp_pte = pte_swp_mksoft_dirty(swp_pte);
+				if (pte_swp_uffd_wp(pteval))
+					swp_pte = pte_swp_mkuffd_wp(swp_pte);
+			}
 			set_pte_at(mm, address, pvmw.pte, swp_pte);
 		} else {
 			/*
-- 
2.53.0

