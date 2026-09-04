Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC2343FD0B
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517800; cv=none; b=PCMsB75Cqj6s2Z1+UMh7IMn6aTUOT5VqCOxIgQDyhHqNGHcBEetl6UEiCcuZmjMBLTzwSUYYLkMs8FvI6sX9bahEPALSKnLnfshR9U9lInBGUXdBL1djpF3AbLtRbL180+oBGk8x/0x6QX5FZhFQUa85UKfB8xyMGjrE8Kg9bSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517800; c=relaxed/simple;
	bh=Mu14IA6fj3LsrdkYFosLo4sj3twDRfqqUU4OdW+rx94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fu3B1NYtmFVmtgmxILja1RfLDAZqtfy1UKjsPNx4/Md7AcRv/bS0jcT1987Xs4sYcFM8HdnAyBJd7YcUWPcoK5qyMUGIi0JYz1zWPAk/v8HIaAiW8uOKFOhMWh5qkgq1BUnEMZGKqbYXVZwaBPGTsZatvv7B5DLmB/dGawFVAAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyKP1B5i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyKP1B5i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8431C1F00A3D;
	Fri,  4 Sep 2026 10:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788517797;
	bh=TLONh+2qaaieJIqcw2c+qE2v/vWuxzIk8cycmZO/xHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JyKP1B5i+Va6PLeDG5MA+QxmB7BKcPSNMnf1zad7SoZCmFmhpKgNqzi+Wuqos7BE7
	 50lHTAl0sFptLwjpE7rmx7HiU5im8nWmeNUODToze+YYGi6pKCHWcmeco8QTAsSCEs
	 QwSlJxhMEZbBzx/gaSGverRTQIGYpWQVClaIX5M4azcaZzvLx9Uex+iiLyhxxLsm+3
	 KjuIXPwFgn0fkUyIHfRwstqO08z8LQSkY6KV7qnVnoZt212TDxzWAelQgLhvo4VNZy
	 xFfD+J9FOOaOd9v8Mh7rMDHbiZUeaDTxq3Gyhy2NXZWoFNyu9f82jeUHfBnYCyIXW3
	 8oG88OcziBPng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
	Vlastimil Babka <vbabka@suse.cz>,
	Wei Xu <weixugc@google.com>,
	xu xin <xu.xin16@zte.com.cn>,
	Yuanchu Xie <yuanchu@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] mm: remove is_hugetlb_entry_[migration, hwpoisoned]()
Date: Fri,  4 Sep 2026 06:29:49 -0400
Message-ID: <20260904102950.2499325-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090346-wildfire-tapered-9281@gregkh>
References: <2026090346-wildfire-tapered-9281@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

[ Upstream commit 03bfbc3ad6e496fb576ca9ace08211943232fdf9 ]

We do not need to have explicit helper functions for these, it adds a
level of confusion and indirection when we can simply use software leaf
entry logic here instead and spell out the special huge_pte_none() case we
must consider.

No functional change intended.

Link: https://lkml.kernel.org/r/0e92d6924d3de88cd014ce1c53e20edc08fc152e.1762812360.git.lorenzo.stoakes@oracle.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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
 arch/arm/include/asm/hugetlb-3level.h |   4 +-
 arch/arm64/include/asm/hugetlb.h      |   2 +-
 arch/arm64/mm/hugetlbpage.c           |   2 +-
 arch/riscv/include/asm/hugetlb.h      |   2 +-
 arch/riscv/mm/hugetlbpage.c           |   2 +-
 arch/s390/include/asm/hugetlb.h       |   4 +-
 arch/s390/mm/hugetlbpage.c            |   4 +-
 fs/hugetlbfs/inode.c                  |   2 +-
 fs/proc/task_mmu.c                    |   4 +-
 fs/userfaultfd.c                      |   2 +-
 include/asm-generic/hugetlb.h         |   2 +-
 include/linux/hugetlb.h               |   1 -
 include/linux/swapops.h               |   4 +-
 mm/damon/vaddr.c                      |   6 +-
 mm/gup.c                              |   2 +-
 mm/hmm.c                              |   2 +-
 mm/hugetlb.c                          | 100 +++++++++++---------------
 mm/memory-failure.c                   |   2 +-
 mm/mempolicy.c                        |   5 +-
 mm/migrate.c                          |   7 +-
 mm/mincore.c                          |   2 +-
 mm/rmap.c                             |  62 ++++++++++++----
 mm/userfaultfd.c                      |   2 +-
 23 files changed, 122 insertions(+), 103 deletions(-)

diff --git a/arch/arm/include/asm/hugetlb-3level.h b/arch/arm/include/asm/hugetlb-3level.h
index a30be55057939..87d48e2d90ad9 100644
--- a/arch/arm/include/asm/hugetlb-3level.h
+++ b/arch/arm/include/asm/hugetlb-3level.h
@@ -13,12 +13,12 @@
 
 /*
  * If our huge pte is non-zero then mark the valid bit.
- * This allows pte_present(huge_ptep_get(ptep)) to return true for non-zero
+ * This allows pte_present(huge_ptep_get(mm,addr,ptep)) to return true for non-zero
  * ptes.
  * (The valid bit is automatically cleared by set_pte_at for PROT_NONE ptes).
  */
 #define __HAVE_ARCH_HUGE_PTEP_GET
-static inline pte_t huge_ptep_get(pte_t *ptep)
+static inline pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	pte_t retval = *ptep;
 	if (pte_val(retval))
diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 92a5e0879b111..5d278bf511fa4 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -46,7 +46,7 @@ extern pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 			   pte_t *ptep, unsigned long sz);
 #define __HAVE_ARCH_HUGE_PTEP_GET
-extern pte_t huge_ptep_get(pte_t *ptep);
+extern pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 
 void __init arm64_hugetlb_cma_reserve(void);
 
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 688d11b1cabdb..b2ca8fa5af44c 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -141,7 +141,7 @@ static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
 	return contig_ptes;
 }
 
-pte_t huge_ptep_get(pte_t *ptep)
+pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	int ncontig, i;
 	size_t pgsize;
diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
index 0e809026b6e39..7107d1eaeb24b 100644
--- a/arch/riscv/include/asm/hugetlb.h
+++ b/arch/riscv/include/asm/hugetlb.h
@@ -45,7 +45,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 			       pte_t pte, int dirty);
 
 #define __HAVE_ARCH_HUGE_PTEP_GET
-pte_t huge_ptep_get(pte_t *ptep);
+pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 
 pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags);
 #define arch_make_huge_pte arch_make_huge_pte
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 57afbc3270a3c..8a059b15d760a 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -3,7 +3,7 @@
 #include <linux/err.h>
 
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
-pte_t huge_ptep_get(pte_t *ptep)
+pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	unsigned long pte_num;
 	int i;
diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index 097b388d4e690..87ead138973d8 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -19,7 +19,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t pte, unsigned long sz);
 void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t pte);
-pte_t huge_ptep_get(pte_t *ptep);
+pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 pte_t __huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep);
 
@@ -71,7 +71,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 					     unsigned long addr, pte_t *ptep,
 					     pte_t pte, int dirty)
 {
-	int changed = !pte_same(huge_ptep_get(ptep), pte);
+	int changed = !pte_same(huge_ptep_get(vma->vm_mm, addr, ptep), pte);
 	if (changed) {
 		__huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
 		__set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index 5ebd730f1ffbb..eef46fd9eaaff 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -169,7 +169,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	__set_huge_pte_at(mm, addr, ptep, pte);
 }
 
-pte_t huge_ptep_get(pte_t *ptep)
+pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	return __rste_to_pte(pte_val(*ptep));
 }
@@ -177,7 +177,7 @@ pte_t huge_ptep_get(pte_t *ptep)
 pte_t __huge_ptep_get_and_clear(struct mm_struct *mm,
 				unsigned long addr, pte_t *ptep)
 {
-	pte_t pte = huge_ptep_get(ptep);
+	pte_t pte = huge_ptep_get(mm, addr, ptep);
 	pmd_t *pmdp = (pmd_t *) ptep;
 	pud_t *pudp = (pud_t *) ptep;
 
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 914e850b9cbb7..7fd8dccca8189 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -448,7 +448,7 @@ static bool hugetlb_vma_maps_page(struct vm_area_struct *vma,
 	if (!ptep)
 		return false;
 
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(vma->vm_mm, addr, ptep);
 	if (huge_pte_none(pte) || !pte_present(pte))
 		return false;
 
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index d0896bf8e12f0..8dca336818db0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1578,7 +1578,7 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 	if (vma->vm_flags & VM_SOFTDIRTY)
 		flags |= PM_SOFT_DIRTY;
 
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(walk->mm, addr, ptep);
 	if (pte_present(pte)) {
 		struct page *page = pte_page(pte);
 
@@ -1910,7 +1910,7 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 static int gather_hugetlb_stats(pte_t *pte, unsigned long hmask,
 		unsigned long addr, unsigned long end, struct mm_walk *walk)
 {
-	pte_t huge_pte = huge_ptep_get(pte);
+	pte_t huge_pte = huge_ptep_get(walk->mm, addr, pte);
 	struct numa_maps *md;
 	struct page *page;
 
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0ebdf3c2c9ee6..4349afd3c742c 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -291,7 +291,7 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 		goto out;
 
 	ret = false;
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(vma->vm_mm, vmf->address, ptep);
 
 	/*
 	 * Lockless access: we're in a wait_event so it's ok if it
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 2d7ae9b51d1e3..215bf9f317cbf 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -144,7 +144,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 #endif
 
 #ifndef __HAVE_ARCH_HUGE_PTEP_GET
-static inline pte_t huge_ptep_get(pte_t *ptep)
+static inline pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	return ptep_get(ptep);
 }
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 6ecf2907172b7..94c189cc78526 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -278,7 +278,6 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot,
 		unsigned long cp_flags);
 
-bool is_hugetlb_entry_migration(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
 void hugetlb_split(struct vm_area_struct *vma, unsigned long addr);
 
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 7555a4a3d3d49..229e409ac2f69 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -334,7 +334,7 @@ static inline bool is_migration_entry_dirty(swp_entry_t entry)
 
 extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					unsigned long address);
-extern void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte);
+extern void migration_entry_wait_huge(struct vm_area_struct *vma, unsigned long addr, pte_t *pte);
 #else  /* CONFIG_MIGRATION */
 static inline swp_entry_t make_readable_migration_entry(pgoff_t offset)
 {
@@ -359,7 +359,7 @@ static inline int is_migration_entry(swp_entry_t swp)
 static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					unsigned long address) { }
 static inline void migration_entry_wait_huge(struct vm_area_struct *vma,
-					pte_t *pte) { }
+					     unsigned long addr, pte_t *pte) { }
 static inline int is_writable_migration_entry(swp_entry_t entry)
 {
 	return 0;
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 4d7dc9f65f682..01319e28f2054 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -339,7 +339,7 @@ static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
 				struct vm_area_struct *vma, unsigned long addr)
 {
 	bool referenced = false;
-	pte_t entry = huge_ptep_get(pte);
+	pte_t entry = huge_ptep_get(mm, addr, pte);
 	struct folio *folio = pfn_folio(pte_pfn(entry));
 	unsigned long psize = huge_page_size(hstate_vma(vma));
 
@@ -373,7 +373,7 @@ static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	pte_t entry;
 
 	ptl = huge_pte_lock(h, walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	entry = huge_ptep_get(walk->mm, addr, pte);
 	if (!pte_present(entry))
 		goto out;
 
@@ -507,7 +507,7 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	pte_t entry;
 
 	ptl = huge_pte_lock(h, walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	entry = huge_ptep_get(walk->mm, addr, pte);
 	if (!pte_present(entry))
 		goto out;
 
diff --git a/mm/gup.c b/mm/gup.c
index 60006de1219ee..c5275acb686f4 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2812,7 +2812,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 	if (pte_end < end)
 		end = pte_end;
 
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(vma->vm_mm, addr, ptep);
 
 	if (!pte_access_permitted(pte, flags & FOLL_WRITE))
 		return 0;
diff --git a/mm/hmm.c b/mm/hmm.c
index a36e1b4046dbd..575fb7b6db7f0 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -485,7 +485,7 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	pte_t entry;
 
 	ptl = huge_pte_lock(hstate_vma(vma), walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	entry = huge_ptep_get(walk->mm, addr, pte);
 
 	i = (start - range->start) >> PAGE_SHIFT;
 	pfn_req_flags = range->hmm_pfns[i];
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index edae641407b96..b0107867e0ab1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5001,37 +5001,12 @@ static void set_huge_ptep_writable(struct vm_area_struct *vma,
 {
 	pte_t entry;
 
-	entry = huge_pte_mkwrite(huge_pte_mkdirty(huge_ptep_get(ptep)));
+	entry = huge_pte_mkwrite(huge_pte_mkdirty(
+			huge_ptep_get(vma->vm_mm, address, ptep)));
 	if (huge_ptep_set_access_flags(vma, address, ptep, entry, 1))
 		update_mmu_cache(vma, address, ptep);
 }
 
-bool is_hugetlb_entry_migration(pte_t pte)
-{
-	swp_entry_t swp;
-
-	if (huge_pte_none(pte) || pte_present(pte))
-		return false;
-	swp = pte_to_swp_entry(pte);
-	if (is_migration_entry(swp))
-		return true;
-	else
-		return false;
-}
-
-static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
-{
-	swp_entry_t swp;
-
-	if (huge_pte_none(pte) || pte_present(pte))
-		return false;
-	swp = pte_to_swp_entry(pte);
-	if (is_hwpoison_entry(swp))
-		return true;
-	else
-		return false;
-}
-
 static void
 hugetlb_install_folio(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr,
 		      struct folio *new_folio, pte_t old, unsigned long sz)
@@ -5104,14 +5079,15 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		dst_ptl = huge_pte_lock(h, dst, dst_pte);
 		src_ptl = huge_pte_lockptr(h, src, src_pte);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
-		entry = huge_ptep_get(src_pte);
+		entry = huge_ptep_get(src_vma->vm_mm, addr, src_pte);
 again:
 		if (huge_pte_none(entry)) {
 			/*
 			 * Skip if src entry none.
 			 */
 			;
-		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry))) {
+		} else if (unlikely(!pte_present(entry) &&
+				    is_hwpoison_entry(pte_to_swp_entry(entry)))) {
 			/*
 			 * A hwpoison entry never carries the uffd-wp bit: it is
 			 * installed fresh by make_hwpoison_entry() and
@@ -5119,7 +5095,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			 * there is nothing to clear for the child.
 			 */
 			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
-		} else if (unlikely(is_hugetlb_entry_migration(entry))) {
+		} else if (unlikely(!pte_present(entry) &&
+				    is_migration_entry(pte_to_swp_entry(entry)))) {
 			swp_entry_t swp_entry = pte_to_swp_entry(entry);
 			bool uffd_wp = pte_swp_uffd_wp(entry);
 
@@ -5146,7 +5123,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				set_huge_pte_at(dst, addr, dst_pte,
 						make_pte_marker(marker), sz);
 		} else {
-			entry = huge_ptep_get(src_pte);
+			entry = huge_ptep_get(src_vma->vm_mm, addr, src_pte);
 			pte_folio = page_folio(pte_page(entry));
 			folio_get(pte_folio);
 
@@ -5190,7 +5167,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				dst_ptl = huge_pte_lock(h, dst, dst_pte);
 				src_ptl = huge_pte_lockptr(h, src, src_pte);
 				spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
-				entry = huge_ptep_get(src_pte);
+				entry = huge_ptep_get(src_vma->vm_mm, addr, src_pte);
 				if (!pte_same(src_pte_old, entry)) {
 					restore_reserve_on_error(h, dst_vma, addr,
 								new_folio);
@@ -5301,7 +5278,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 			new_addr |= last_addr_mask;
 			continue;
 		}
-		if (huge_pte_none(huge_ptep_get(src_pte)))
+		if (huge_pte_none(huge_ptep_get(mm, old_addr, src_pte)))
 			continue;
 
 		if (huge_pmd_unshare(&tlb, vma, old_addr, src_pte)) {
@@ -5370,7 +5347,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			continue;
 		}
 
-		pte = huge_ptep_get(ptep);
+		pte = huge_ptep_get(mm, address, ptep);
 		if (huge_pte_none(pte)) {
 			spin_unlock(ptl);
 			continue;
@@ -5568,13 +5545,13 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		       struct folio *pagecache_folio, spinlock_t *ptl)
 {
 	const bool unshare = flags & FAULT_FLAG_UNSHARE;
-	pte_t pte = huge_ptep_get(ptep);
 	struct hstate *h = hstate_vma(vma);
 	struct folio *old_folio;
 	struct folio *new_folio;
 	int outside_reserve = 0;
 	vm_fault_t ret = 0;
 	unsigned long haddr = address & huge_page_mask(h);
+	pte_t pte = huge_ptep_get(mm, haddr, ptep);
 	struct mmu_notifier_range range;
 
 	/*
@@ -5679,7 +5656,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 			spin_lock(ptl);
 			ptep = hugetlb_walk(vma, haddr, huge_page_size(h));
 			if (likely(ptep &&
-				   pte_same(huge_ptep_get(ptep), pte)))
+				   pte_same(huge_ptep_get(mm, haddr, ptep),
+					    pte)))
 				goto retry_avoidcopy;
 			/*
 			 * race occurs while re-acquiring page table
@@ -5718,7 +5696,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 */
 	spin_lock(ptl);
 	ptep = hugetlb_walk(vma, haddr, huge_page_size(h));
-	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
+	if (likely(ptep &&
+		   pte_same(huge_ptep_get(mm, haddr, ptep), pte))) {
 		pte_t newpte = make_huge_pte(vma, &new_folio->page, !unshare);
 
 		/* Break COW or unshare */
@@ -5836,13 +5815,13 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
  * false if pte changed or is changing.
  */
 static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm,
-			       pte_t *ptep, pte_t old_pte)
+			       unsigned long addr, pte_t *ptep, pte_t old_pte)
 {
 	spinlock_t *ptl;
 	bool same;
 
 	ptl = huge_pte_lock(h, mm, ptep);
-	same = pte_same(huge_ptep_get(ptep), old_pte);
+	same = pte_same(huge_ptep_get(mm, addr, ptep), old_pte);
 	spin_unlock(ptl);
 
 	return same;
@@ -5906,7 +5885,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 * never happen on the page after UFFDIO_COPY has
 			 * correctly installed the page and returned.
 			 */
-			if (!hugetlb_pte_stable(h, mm, ptep, old_pte)) {
+			if (!hugetlb_pte_stable(h, mm, haddr, ptep, old_pte)) {
 				ret = 0;
 				goto out;
 			}
@@ -5930,7 +5909,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 * here.  Before returning error, get ptl and make
 			 * sure there really is no pte entry.
 			 */
-			if (hugetlb_pte_stable(h, mm, ptep, old_pte))
+			if (hugetlb_pte_stable(h, mm, haddr, ptep, old_pte))
 				ret = vmf_error(PTR_ERR(folio));
 			else
 				ret = 0;
@@ -5980,7 +5959,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			folio_unlock(folio);
 			folio_put(folio);
 			/* See comment in userfaultfd_missing() block above */
-			if (!hugetlb_pte_stable(h, mm, ptep, old_pte)) {
+			if (!hugetlb_pte_stable(h, mm, haddr, ptep, old_pte)) {
 				ret = 0;
 				goto out;
 			}
@@ -6008,7 +5987,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	ptl = huge_pte_lock(h, mm, ptep);
 	ret = 0;
 	/* If pte changed from under us, retry */
-	if (!pte_same(huge_ptep_get(ptep), old_pte))
+	if (!pte_same(huge_ptep_get(mm, haddr, ptep), old_pte))
 		goto backout;
 
 	if (anon_rmap)
@@ -6126,7 +6105,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		return VM_FAULT_OOM;
 	}
 
-	entry = huge_ptep_get(ptep);
+	entry = huge_ptep_get(mm, haddr, ptep);
 	if (huge_pte_none_mostly(entry)) {
 		if (is_pte_marker(entry)) {
 			pte_marker marker =
@@ -6154,11 +6133,12 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * entry could be a migration/hwpoison entry at this point, so this
 	 * check prevents the kernel from going below assuming that we have
 	 * an active hugepage in pagecache. This goto expects the 2nd page
-	 * fault, and is_hugetlb_entry_(migration|hwpoisoned) check will
-	 * properly handle it.
+	 * fault, and the migration/hwpoison checks will properly handle it.
 	 */
-	if (!pte_present(entry)) {
-		if (unlikely(is_hugetlb_entry_migration(entry))) {
+	if (!pte_present(entry) && !huge_pte_none(entry)) {
+		swp_entry_t swp = pte_to_swp_entry(entry);
+
+		if (unlikely(is_migration_entry(swp))) {
 			/*
 			 * Release the hugetlb fault lock now, but retain
 			 * the vma lock, because it is needed to guard the
@@ -6167,9 +6147,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			 * be released there.
 			 */
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			migration_entry_wait_huge(vma, ptep);
+			migration_entry_wait_huge(vma, haddr, ptep);
 			return 0;
-		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
+		} else if (unlikely(is_hwpoison_entry(swp)))
 			ret = VM_FAULT_HWPOISON_LARGE |
 			    VM_FAULT_SET_HINDEX(hstate_index(h));
 		goto out_mutex;
@@ -6199,11 +6179,12 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	ptl = huge_pte_lock(h, mm, ptep);
 
 	/* Check for a racing update before calling hugetlb_wp() */
-	if (unlikely(!pte_same(entry, huge_ptep_get(ptep))))
+	if (unlikely(!pte_same(entry, huge_ptep_get(mm, haddr, ptep))))
 		goto out_ptl;
 
 	/* Handle userfault-wp first, before trying to lock more pages */
-	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(ptep)) &&
+	if (userfaultfd_wp(vma) &&
+	    huge_pte_uffd_wp(huge_ptep_get(mm, haddr, ptep)) &&
 	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
 		struct vm_fault vmf = {
 			.vma = vma,
@@ -6306,7 +6287,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 		ptl = huge_pte_lock(h, dst_mm, dst_pte);
 
 		/* Don't overwrite any existing PTEs (even markers) */
-		if (!huge_pte_none(huge_ptep_get(dst_pte))) {
+		if (!huge_pte_none(huge_ptep_get(dst_mm, dst_addr, dst_pte))) {
 			spin_unlock(ptl);
 			return -EEXIST;
 		}
@@ -6435,7 +6416,8 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	 * page backing it, then access the page.
 	 */
 	ret = -EEXIST;
-	if (!huge_pte_none_mostly(huge_ptep_get(dst_pte)))
+	if (!huge_pte_none_mostly(
+			huge_ptep_get(dst_mm, dst_addr, dst_pte)))
 		goto out_release_unlock;
 
 	if (folio_in_pagecache)
@@ -6510,7 +6492,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 		goto out_unlock;
 
 	ptl = huge_pte_lock(h, mm, pte);
-	entry = huge_ptep_get(pte);
+	entry = huge_ptep_get(mm, haddr, pte);
 	if (pte_present(entry)) {
 		page = pte_page(entry);
 
@@ -6627,10 +6609,12 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 			address |= last_addr_mask;
 			continue;
 		}
-		pte = huge_ptep_get(ptep);
-		if (unlikely(is_hugetlb_entry_hwpoisoned(pte))) {
+		pte = huge_ptep_get(mm, address, ptep);
+		if (unlikely(!huge_pte_none(pte) && !pte_present(pte) &&
+			     is_hwpoison_entry(pte_to_swp_entry(pte)))) {
 			/* Nothing to do. */
-		} else if (unlikely(is_hugetlb_entry_migration(pte))) {
+		} else if (unlikely(!huge_pte_none(pte) && !pte_present(pte) &&
+				    is_migration_entry(pte_to_swp_entry(pte)))) {
 			swp_entry_t entry = pte_to_swp_entry(pte);
 			struct page *page = pfn_swap_entry_to_page(entry);
 			pte_t newpte = pte;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 86cdf36ee3bb9..2dca9b862ca39 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -825,7 +825,7 @@ static int hwpoison_hugetlb_range(pte_t *ptep, unsigned long hmask,
 			    struct mm_walk *walk)
 {
 	struct hwpoison_walk *hwp = walk->private;
-	pte_t pte = huge_ptep_get(ptep);
+	pte_t pte = huge_ptep_get(walk->mm, addr, ptep);
 	struct hstate *h = hstate_vma(walk->vma);
 
 	return check_hwpoisoned_entry(pte, addr, huge_page_shift(h),
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 5bbeb6df9c007..05573a08795dd 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -584,9 +584,10 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
 	pte_t entry;
 
 	ptl = huge_pte_lock(hstate_vma(walk->vma), walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	entry = huge_ptep_get(walk->mm, addr, pte);
 	if (!pte_present(entry)) {
-		if (unlikely(is_hugetlb_entry_migration(entry)))
+		if (!huge_pte_none(entry) &&
+		    unlikely(is_migration_entry(pte_to_swp_entry(entry))))
 			qp->nr_failed++;
 		goto unlock;
 	}
diff --git a/mm/migrate.c b/mm/migrate.c
index 620871d193c7c..3a43abfc0e537 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -335,16 +335,17 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
  *
  * This function will release the vma lock before returning.
  */
-void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *ptep)
+void migration_entry_wait_huge(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
 	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), vma->vm_mm, ptep);
 	pte_t pte;
 
 	hugetlb_vma_assert_locked(vma);
 	spin_lock(ptl);
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(vma->vm_mm, addr, ptep);
 
-	if (unlikely(!is_hugetlb_entry_migration(pte))) {
+	if (unlikely(huge_pte_none(pte) || pte_present(pte) ||
+		     !is_migration_entry(pte_to_swp_entry(pte)))) {
 		spin_unlock(ptl);
 		hugetlb_vma_unlock_read(vma);
 	} else {
diff --git a/mm/mincore.c b/mm/mincore.c
index 2a55eed792b64..03b42e8dfd642 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -33,7 +33,7 @@ static int mincore_hugetlb(pte_t *pte, unsigned long hmask, unsigned long addr,
 	 * Hugepages under user process are always in RAM and never
 	 * swapped out, but theoretically it needs to be checked.
 	 */
-	present = pte && !huge_pte_none_mostly(huge_ptep_get(pte));
+	present = pte && !huge_pte_none_mostly(huge_ptep_get(walk->mm, addr, pte));
 	for (; addr != end; vec++, addr += PAGE_SIZE)
 		*vec = present;
 	walk->private = vec;
diff --git a/mm/rmap.c b/mm/rmap.c
index 0a88928c410a0..a337263497c77 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -84,6 +84,11 @@
 
 #include "internal.h"
 
+/* Compatibility names used by the target commit's pre-softleaf backport. */
+typedef swp_entry_t softleaf_t;
+#define softleaf_from_pte(pte) pte_to_swp_entry(pte)
+#define softleaf_to_pfn(entry) swp_offset_pfn(entry)
+
 static struct kmem_cache *anon_vma_cachep;
 static struct kmem_cache *anon_vma_chain_cachep;
 
@@ -1519,9 +1524,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	mmu_notifier_invalidate_range_start(&range);
 
 	while (page_vma_mapped_walk(&pvmw)) {
-		/* Unexpected PMD-mapped THP? */
-		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
-
 		/*
 		 * If the folio is in an mlock()d vma, we must not swap it out.
 		 */
@@ -1534,7 +1536,23 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			break;
 		}
 
-		pfn = pte_pfn(ptep_get(pvmw.pte));
+		/* Unexpected PMD-mapped THP? */
+		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
+
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
@@ -1593,7 +1611,9 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
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
@@ -1611,6 +1631,10 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			} else {
 				pteval = ptep_clear_flush(vma, address, pvmw.pte);
 			}
+			if (pte_dirty(pteval))
+				folio_mark_dirty(folio);
+		} else {
+			pte_clear(mm, address, pvmw.pte);
 		}
 
 		/*
@@ -1620,10 +1644,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		 */
 		pte_install_uffd_wp_if_needed(vma, address, pvmw.pte, pteval);
 
-		/* Set the dirty flag on the folio now the pte is gone. */
-		if (pte_dirty(pteval))
-			folio_mark_dirty(folio);
-
 		/* Update high watermark before we lower rss */
 		update_hiwater_rss(mm);
 
@@ -1638,7 +1658,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				set_pte_at(mm, address, pvmw.pte, pteval);
 			}
 
-		} else if (pte_unused(pteval) && !userfaultfd_armed(vma)) {
+		} else if (likely(pte_present(pteval)) && pte_unused(pteval) &&
+			   !userfaultfd_armed(vma)) {
 			/*
 			 * The guest indicated that the page content is of no
 			 * interest anymore. Simply discard the pte, vmscan
@@ -1712,6 +1733,12 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				page_vma_mapped_walk_done(&pvmw);
 				break;
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
@@ -1740,10 +1767,17 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
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
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 99438f0950e3c..ed76ad3ab4fd0 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -482,7 +482,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 		}
 
 		if (!uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE) &&
-		    !huge_pte_none_mostly(huge_ptep_get(dst_pte))) {
+		    !huge_pte_none_mostly(huge_ptep_get(dst_mm, dst_addr, dst_pte))) {
 			err = -EEXIST;
 			hugetlb_vma_unlock_read(dst_vma);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-- 
2.53.0

