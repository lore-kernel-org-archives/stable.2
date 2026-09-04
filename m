Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D4A32F75B
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527921; cv=none; b=ELREwt1+P8teOWZjmgh21iJKyO3zuAoZACWexISA+KIrZ9DdeACMeHGp+rQrphyCrrur62u2jMwuAPySxZ1O1wYc/GusLy8bbNqcZqQOAGqJXh6v17gLkZw3NmaMtZjYKBqACYWPA5xoHIVoJqpUlE1UOUrqtkCrEU+AfUhV/Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527921; c=relaxed/simple;
	bh=E+xM0KaxILa0drbBPJjrN7ZhUX5gYyKN0nDdvbjoR2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHdGl6brBdEm3oIi9etIyeFP7RUhMF50/pCtCf+NBPqnnenLjafXxuRx+o+ehzCaNxvHmNf0kHOfuZGrS2gEcDXmzTe/AHleVltdwfromMsiEpb8LRiduRdNZ3ozPq7ccDA3tYYVijHNrvIpdp+Z9yNMpRBEiy9gdPmUm7tCodo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPjAIryi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPjAIryi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8D91F00A3D;
	Fri,  4 Sep 2026 13:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788527915;
	bh=6xs4alKN25r7IKcBT4PGNZXlPKvtpUtZYJhZeOhFOTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MPjAIryiw6TbHhw4rT3Lg4IqdNTOkzCDQZirhzbDjyyZuiO2lfM11W9SBZRV88HTN
	 lSNsodA5ix4SwAghV+PMOvAdF29l8vaeO9GqRCAaMw4Y+v6SziEJAz93VFe5DkIsw2
	 /L34lItv3p2QMhYw2LGzYCsys9dvzRXerDNfTck53UXvekGeQFnjVlzGf2OBQcFBHn
	 HSBz+wUcojt3HSeEblY1koT6C+2mDqVBUyLDRZ5lEcHeDI0a7MUUTRv9VRlMG6uge8
	 +97blBot9XP8CxvbClg9zNdtRr+NF77bdPRwBxo2ZMyUDExsK57DogWIT6d7R4oBI9
	 KMHsNwMu3gEmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	SeongJae Park <sj@kernel.org>,
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
	Suren Baghdasaryan <surenb@google.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Wei Xu <weixugc@google.com>,
	xu xin <xu.xin16@zte.com.cn>,
	Yuanchu Xie <yuanchu@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] mm: replace pmd_to_swp_entry() with softleaf_from_pmd()
Date: Fri,  4 Sep 2026 09:18:27 -0400
Message-ID: <20260904131828.504592-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090359-rejoicing-splatter-c71f@gregkh>
References: <2026090359-rejoicing-splatter-c71f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

[ Upstream commit 0ac881efe16468503e8c1e7d8a7210b75f027ce3 ]

Introduce softleaf_from_pmd() to do the equivalent operation for PMDs that
softleaf_from_pte() fulfils, and cascade changes through code base
accordingly, introducing helpers as necessary.

We are then able to eliminate pmd_to_swp_entry(),
is_pmd_migration_entry(), is_pmd_device_private_entry() and
is_pmd_non_present_folio_entry().

This further establishes the use of leaf operations throughout the code
base and further establishes the foundations for eliminating
is_swap_pmd().

No functional change intended.

[lorenzo.stoakes@oracle.com: check writable, not readable/writable, per Vlastimil]
  Link: https://lkml.kernel.org/r/cd97b6ec-00f9-45a4-9ae0-8f009c212a94@lucifer.local
Link: https://lkml.kernel.org/r/3fb431699639ded8fdc63d2210aa77a38c8891f1.1762812360.git.lorenzo.stoakes@oracle.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: SeongJae Park <sj@kernel.org>\
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
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Wei Xu <weixugc@google.com>
Cc: xu xin <xu.xin16@zte.com.cn>
Cc: Yuanchu Xie <yuanchu@google.com>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

[ sashal: Reduced backport -- upstream 0ac881efe1646 touches 18 file(s), this
  backport carries 2. Not backported here:
  fs/proc/task_mmu.c
  include/linux/migrate.h
  include/linux/swapops.h
  mm/damon/ops-common.c
  mm/filemap.c
  mm/hmm.c
  mm/huge_memory.c
  mm/khugepaged.c
  ... and 8 more
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 9be12ffa78cd ("mm/rmap: use huge_ptep_get() in try_to_migrate_one()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/leafops.h | 18 ++++++++++++++++
 mm/rmap.c               | 48 +++++++++++++++++++++++++----------------
 2 files changed, 48 insertions(+), 18 deletions(-)
 create mode 100644 include/linux/leafops.h

diff --git a/include/linux/leafops.h b/include/linux/leafops.h
new file mode 100644
index 0000000000000..7c441356f52a8
--- /dev/null
+++ b/include/linux/leafops.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_LEAFOPS_H
+#define _LINUX_LEAFOPS_H
+
+/*
+ * The stable tree still represents non-present page-table leaves with
+ * swp_entry_t.  Keep the leafops names used by the dependent fix as aliases
+ * until the wider leafops conversion reaches this tree.
+ */
+#include <linux/swapops.h>
+
+typedef swp_entry_t softleaf_t;
+
+#define softleaf_from_pte	pte_to_swp_entry
+#define softleaf_from_pmd	pmd_to_swp_entry
+#define softleaf_to_pfn		swp_offset_pfn
+
+#endif /* _LINUX_LEAFOPS_H */
diff --git a/mm/rmap.c b/mm/rmap.c
index 886000da89a6f..ff1d0a18f1fca 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -57,7 +57,7 @@
 #include <linux/sched/task.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/ksm.h>
@@ -83,6 +83,13 @@
 
 #include "internal.h"
 
+/*
+ * The mm and address arguments were added to huge_ptep_get() after this
+ * stable series.  Accept the newer call shape used by the dependent fix while
+ * retaining the architecture-specific one-argument implementation in 6.1.
+ */
+#define huge_ptep_get(mm, address, ptep) huge_ptep_get(ptep)
+
 static struct kmem_cache *anon_vma_cachep;
 static struct kmem_cache *anon_vma_chain_cachep;
 
@@ -1847,6 +1854,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 	bool anon_exclusive, ret = true;
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
+	unsigned long pfn;
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
@@ -1889,8 +1897,14 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 		/* PMD-mapped THP migration entry */
 		if (!pvmw.pte) {
-			subpage = folio_page(folio,
-				pmd_pfn(*pvmw.pmd) - folio_pfn(folio));
+			pmd_t pmdval = *pvmw.pmd;
+
+			if (likely(pmd_present(pmdval)))
+				pfn = pmd_pfn(pmdval);
+			else
+				pfn = softleaf_to_pfn(softleaf_from_pmd(pmdval));
+
+			subpage = folio_page(folio, pfn - folio_pfn(folio));
 			VM_BUG_ON_FOLIO(folio_test_hugetlb(folio) ||
 					!folio_test_pmd_mappable(folio), folio);
 
@@ -1906,23 +1920,21 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		/* Unexpected PMD-mapped THP? */
 		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
 
-		if (folio_is_zone_device(folio)) {
-			/*
-			 * Our PTE is a non-present device exclusive entry and
-			 * calculating the subpage as for the common case would
-			 * result in an invalid pointer.
-			 *
-			 * Since only PAGE_SIZE pages can currently be
-			 * migrated, just set it to page. This will need to be
-			 * changed when hugepage migrations to device private
-			 * memory are supported.
-			 */
-			VM_BUG_ON_FOLIO(folio_nr_pages(folio) > 1, folio);
-			subpage = &folio->page;
+		/*
+		 * Handle PFN swap PTEs, such as device-exclusive ones, that
+		 * actually map pages.
+		 */
+		pteval = ptep_get(pvmw.pte);
+		if (likely(pte_present(pteval))) {
+			pfn = pte_pfn(pteval);
 		} else {
-			subpage = folio_page(folio,
-					pte_pfn(*pvmw.pte) - folio_pfn(folio));
+			const softleaf_t entry = softleaf_from_pte(pteval);
+
+			pfn = softleaf_to_pfn(entry);
+			VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 		}
+
+		subpage = folio_page(folio, pfn - folio_pfn(folio));
 		address = pvmw.address;
 		anon_exclusive = folio_test_anon(folio) &&
 				 PageAnonExclusive(subpage);
-- 
2.53.0

