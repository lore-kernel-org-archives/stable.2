Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813313644B3
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 10:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786359486; cv=none; b=bR8bFxb0ya83T1LGVQ6XU5l2xlTZ6ayVb3zPo3QdyWu2w3dApzx1225uu6cUzDetkTWt8o1NUivcfEQKzLP/Vo2PXqWEp1SNpaBA6NYL3tmapLOd3Tnq+x63OiASJJI4kYM6533W3ksp53ceMrTq3TkQ8I2vTV8P0WwYJTDvzjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786359486; c=relaxed/simple;
	bh=SDxQ4vtR6Xx17C4B2cAXWBgjWZmOXVjaMXQ0O4j3dDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llzJi/gOXYau6dyvH90auVwzQ2nh11gZPFlLaNZ6d9A+Mg+IbstLQiOW+ryWKNdqgYCnlKkkQY9fllGrXio0ej+auJajOEEYB9BKtCLBsXkFa1VMQjI0a8nkM/7dx+MhlIguy8RBSVbcawHMoBwy3J1Wwl61YULYzow4NtIaZMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcIiQvk8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcIiQvk8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CA61F000E9;
	Mon, 10 Aug 2026 10:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786359484;
	bh=j5TYHYZj1zjYXjxrfLF6cOjgJIgGdNa3E3KjoKVIIC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bcIiQvk8PmpmhoswlQ8KucVLw5dgq3RAAXDIup6sp1ZEgAMEPPpAFEYNPE1vj3dMx
	 H5+EIqAZGIw6zynTN3UrGxUVNUcEmrq1aE3el94pxQSIvYqblrUU01kgNFWpvDa/1O
	 iVUhdo7EnvAhm+6JLBQnzjZKsRoxvnrljJAEcdLE1mmYTv7EGEpWua09Zx5uScafD4
	 y7Xvd4qLGlnduP0MrccEqBgAiwgQoiCoYoSNWuw0Zlr0tV5ZL6e19NWvDaWQSjFiRt
	 +5GrubFkdwyYDzFbLd90oPdAB0ErLLcVv6dcBnBRr9BF8UyJD6DHTAuoI+W32KN3MA
	 g1Nca2l52eUPA==
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
Subject: [PATCH 6.18.y 1/3] fs/proc/task_mmu: refactor pagemap_pmd_range()
Date: Mon, 10 Aug 2026 06:57:53 -0400
Message-ID: <20260810105755.579268-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080544-exit-cesarean-7929@gregkh>
References: <2026080544-exit-cesarean-7929@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

[ Upstream commit de4d6c94914f3659f0b51725e23e637d4e9f78cc ]

Separate out THP logic so we can drop an indentation level and reduce the
amount of noise in this function.

We add pagemap_pmd_range_thp() for this purpose.

While we're here, convert the VM_BUG_ON() to a VM_WARN_ON_ONCE() at the
same time.

No functional change intended.

Link: https://lkml.kernel.org/r/f9ce7f3bb57e3627288225e23f2498cc5315f5ab.1762812360.git.lorenzo.stoakes@oracle.com
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
Cc: Wei Xu <weixugc@google.com>
Cc: xu xin <xu.xin16@zte.com.cn>
Cc: Yuanchu Xie <yuanchu@google.com>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 4165b7d1c45c ("userfaultfd: wait on source PMD during UFFDIO_MOVE")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/task_mmu.c | 146 ++++++++++++++++++++++++---------------------
 1 file changed, 77 insertions(+), 69 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 858b11009c269..a4f3158aeb39b 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1989,90 +1989,98 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 	return make_pme(frame, flags);
 }
 
-static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
-			     struct mm_walk *walk)
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
+		unsigned long end, struct vm_area_struct *vma,
+		struct pagemapread *pm)
 {
-	struct vm_area_struct *vma = walk->vma;
-	struct pagemapread *pm = walk->private;
-	spinlock_t *ptl;
-	pte_t *pte, *orig_pte;
+	unsigned int idx = (addr & ~PMD_MASK) >> PAGE_SHIFT;
+	u64 flags = 0, frame = 0;
+	pmd_t pmd = *pmdp;
+	struct page *page = NULL;
+	struct folio *folio = NULL;
 	int err = 0;
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
-	ptl = pmd_trans_huge_lock(pmdp, vma);
-	if (ptl) {
-		unsigned int idx = (addr & ~PMD_MASK) >> PAGE_SHIFT;
-		u64 flags = 0, frame = 0;
-		pmd_t pmd = *pmdp;
-		struct page *page = NULL;
-		struct folio *folio = NULL;
+	if (vma->vm_flags & VM_SOFTDIRTY)
+		flags |= PM_SOFT_DIRTY;
 
-		if (vma->vm_flags & VM_SOFTDIRTY)
-			flags |= PM_SOFT_DIRTY;
+	if (pmd_present(pmd)) {
+		page = pmd_page(pmd);
 
-		if (pmd_present(pmd)) {
-			page = pmd_page(pmd);
+		flags |= PM_PRESENT;
+		if (pmd_soft_dirty(pmd))
+			flags |= PM_SOFT_DIRTY;
+		if (pmd_uffd_wp(pmd))
+			flags |= PM_UFFD_WP;
+		if (pm->show_pfn)
+			frame = pmd_pfn(pmd) + idx;
+	} else if (thp_migration_supported() && is_swap_pmd(pmd)) {
+		swp_entry_t entry = pmd_to_swp_entry(pmd);
+		unsigned long offset;
 
-			flags |= PM_PRESENT;
-			if (pmd_soft_dirty(pmd))
-				flags |= PM_SOFT_DIRTY;
-			if (pmd_uffd_wp(pmd))
-				flags |= PM_UFFD_WP;
-			if (pm->show_pfn)
-				frame = pmd_pfn(pmd) + idx;
-		}
-#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
-		else if (is_swap_pmd(pmd)) {
-			swp_entry_t entry = pmd_to_swp_entry(pmd);
-			unsigned long offset;
-
-			if (pm->show_pfn) {
-				if (is_pfn_swap_entry(entry))
-					offset = swp_offset_pfn(entry) + idx;
-				else
-					offset = swp_offset(entry) + idx;
-				frame = swp_type(entry) |
-					(offset << MAX_SWAPFILES_SHIFT);
-			}
-			flags |= PM_SWAP;
-			if (pmd_swp_soft_dirty(pmd))
-				flags |= PM_SOFT_DIRTY;
-			if (pmd_swp_uffd_wp(pmd))
-				flags |= PM_UFFD_WP;
-			VM_BUG_ON(!is_pmd_migration_entry(pmd));
-			page = pfn_swap_entry_to_page(entry);
+		if (pm->show_pfn) {
+			if (is_pfn_swap_entry(entry))
+				offset = swp_offset_pfn(entry) + idx;
+			else
+				offset = swp_offset(entry) + idx;
+			frame = swp_type(entry) |
+				(offset << MAX_SWAPFILES_SHIFT);
 		}
-#endif
+		flags |= PM_SWAP;
+		if (pmd_swp_soft_dirty(pmd))
+			flags |= PM_SOFT_DIRTY;
+		if (pmd_swp_uffd_wp(pmd))
+			flags |= PM_UFFD_WP;
+		VM_WARN_ON_ONCE(!is_pmd_migration_entry(pmd));
+		page = pfn_swap_entry_to_page(entry);
+	}
 
-		if (page) {
-			folio = page_folio(page);
-			if (!folio_test_anon(folio))
-				flags |= PM_FILE;
-		}
+	if (page) {
+		folio = page_folio(page);
+		if (!folio_test_anon(folio))
+			flags |= PM_FILE;
+	}
 
-		for (; addr != end; addr += PAGE_SIZE, idx++) {
-			u64 cur_flags = flags;
-			pagemap_entry_t pme;
+	for (; addr != end; addr += PAGE_SIZE, idx++) {
+		u64 cur_flags = flags;
+		pagemap_entry_t pme;
 
-			if (folio && (flags & PM_PRESENT) &&
-			    __folio_page_mapped_exclusively(folio, page))
-				cur_flags |= PM_MMAP_EXCLUSIVE;
+		if (folio && (flags & PM_PRESENT) &&
+		    __folio_page_mapped_exclusively(folio, page))
+			cur_flags |= PM_MMAP_EXCLUSIVE;
 
-			pme = make_pme(frame, cur_flags);
-			err = add_to_pagemap(&pme, pm);
-			if (err)
-				break;
-			if (pm->show_pfn) {
-				if (flags & PM_PRESENT)
-					frame++;
-				else if (flags & PM_SWAP)
-					frame += (1 << MAX_SWAPFILES_SHIFT);
-			}
+		pme = make_pme(frame, cur_flags);
+		err = add_to_pagemap(&pme, pm);
+		if (err)
+			break;
+		if (pm->show_pfn) {
+			if (flags & PM_PRESENT)
+				frame++;
+			else if (flags & PM_SWAP)
+				frame += (1 << MAX_SWAPFILES_SHIFT);
 		}
+	}
+	return err;
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
+			     struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->vma;
+	struct pagemapread *pm = walk->private;
+	spinlock_t *ptl;
+	pte_t *pte, *orig_pte;
+	int err = 0;
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	ptl = pmd_trans_huge_lock(pmdp, vma);
+	if (ptl) {
+		err = pagemap_pmd_range_thp(pmdp, addr, end, vma, pm);
 		spin_unlock(ptl);
 		return err;
 	}
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+#endif
 
 	/*
 	 * We can assume that @vma always points to a valid one and @end never
-- 
2.53.0

