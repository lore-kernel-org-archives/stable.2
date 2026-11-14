Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794631838;
	b=NYMEhmgvEER2JCHUFYMdKFSSGub5TEelA4gehcldlu2qDDCHDioJ2QUyuKuxV82e5BKF
	 kYNvgKMuWKc7yADNWkA113KY0pGoD4WzNaj2l+YeCoXsHf0HA2eVT7ADSeGzoiKYV3Mz3
	 N1dPET13Pc4GpKpnFXotx2FqCsLvyp+ZbqkmYufjo8XxPuxXL0B1U+rge7CAhmrTZbzF2
	 tW0jxNZBfYCXcN0FtD2AXBlSLl7SY5g5sQR8QujV5BO7GsBddL+QS6Xcrx0+oPnDLhiUH
	 z+zYKOWUdcUx6B5JhNED9PrrK4STYGEGFy0A8rRUoI9f2O3ElnfdtA/LOS7+bjR47Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794631838;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RIGFDPbgU8//fNrKyktYS9U6y4B65PmoybGZaV2eHuk=;
	b=1aVTgajwvtR5lmtUEL1uBngVu1LPnOMoW0z5uwp4pqLLof5RjsWwsxZdFKbvvvuXsU3o
	 EGCAb4UEtl1rWqcNVPTNT/EuV6X0gZtO3BvViRIiqmOn0a6ohB1EsjVC0V9Bvyu3jLYgF
	 Q9X1cOIXUMxZPNkbdO3Bp+rwdsO5H2aYgjVJUwkdkSgu0k/dKhGeCfX3JMcWcdM7ATxp1
	 ez55pMCBqZHc1XrhPDuRehppm+DUwMSCWl95SAUA3DDit1PdMikkLhlr6M9mWW1ZOA5fP
	 nlyOoNr8oFSEBBpgqEPYCFE+IuhyP9HfL8o1Wg2w29Q1b4Ag6dmvjmyjt677HAQcwKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PN4GJWfv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C33606A32D
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PN4GJWfv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A551F000C4;
	Sat, 14 Nov 2026 04:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794631837;
	bh=RIGFDPbgU8//fNrKyktYS9U6y4B65PmoybGZaV2eHuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PN4GJWfvIBGA8ix4YoIJtB3CGl1idsaIDFaJmlHB6VmOshw1Ee1mfrp6rrm5X7VhG
	 EJmTd1M+jnvvx9VqKZjr87yZs+chfzFcm3v2LggEYKnKAuHafVSIP3ATsmxWHqPjHO
	 aOzFQwrj7DT+m1CaIkPLomJzYNdA10QoqBTZOIw184u9/Ms8pHzL+8FZVjh2myQdJo
	 w9FbcPcBBFRNYmzhAjRrbnt1PFq32FVNfo6VhWPquhF0VcpXVX8H8rhVECjx8YZOj+
	 Nqe3p8XxKwekRmOIAWDCeVMWiyBWMSTQWrRVcTPuRRL8KRWl+oJcKd03j3oWNNR20a
	 BlULjX5y6j/oA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Zhe <lizhe.67@bytedance.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/hugetlb: fix mremap deadlock when PMD sharing is possible
Date: Fri, 13 Nov 2026 23:50:35 -0500
Message-ID: <20261114045016.2948921-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201655-failed-6.1-92daa8652f88@kernel.org>
References: <20261109201655-failed-6.1-92daa8652f88@kernel.org>
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

From: Li Zhe <lizhe.67@bytedance.com>

[ Upstream commit 92daa8652f88c8cfc05f4899a8408a04b02f211e ]

move_hugetlb_page_tables() holds the mapping's i_mmap_rwsem for
write while moving hugetlb PTEs. This prevents races with truncation
and protects huge_pmd_unshare(), but the move loop must not call
helpers that can acquire the same rwsem for read.

huge_pte_alloc() can do that when the destination can use PMD
sharing: it may call huge_pmd_share(), which takes i_mmap_rwsem for
read while searching for a shareable PMD table. Calling it while the
move path already holds i_mmap_rwsem for write can deadlock.

Avoid that path for PMD-sized hugetlb mappings that can use PMD
sharing. Instead of allocating or sharing the destination page table
while moving, zap the source range and let the destination fault path
populate or share the PMD lazily.

Reuse the hugetlb unmap logic for the source-side zap by splitting
the core loop out of __unmap_hugepage_range(). The wrapper keeps the
existing tlb_start_vma(), tlb_end_vma() and huge_pmd_unshare_flush()
behavior, while move_hugetlb_page_tables() can reuse the unmap loop
with its existing mmu_gather.

Link: https://lore.kernel.org/20261022034543.51226-4-lizhe.67@bytedance.com
Fixes: 550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage backed vma")
Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
Co-developed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Peter Xu <peterx@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Cc: <stable@vger.kernel.org>
[ sashal: moved existing MMU notifier calls into the unmap wrapper to preserve notification ordering ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 66 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 18 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9660566a1ba4b..a4b5243281af0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -99,6 +99,10 @@ static int __huge_pmd_unshare(struct mmu_gather *tlb,
 		bool check_locks);
 static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, bool take_locks);
+static void hugetlb_unmap_range(struct mmu_gather *tlb,
+				struct vm_area_struct *vma, unsigned long start,
+				unsigned long end, struct page *ref_page,
+				zap_flags_t zap_flags);
 static struct resv_map *vma_resv_map(struct vm_area_struct *vma);
 
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
@@ -5292,6 +5296,8 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
 		const unsigned long offset_to_last_entry =
 			(old_addr | last_addr_mask) - old_addr;
+		const unsigned long offset_to_last_dst_entry =
+			(new_addr | last_addr_mask) - new_addr;
 
 		src_pte = huge_pte_offset(mm, old_addr, sz);
 		if (!src_pte) {
@@ -5308,6 +5314,24 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 			continue;
 		}
 
+		/*
+		 * Avoid entering the destination PMD sharing path while holding
+		 * i_mmap_rwsem for write. Leave destination page table
+		 * population to the fault path, which can share the PMD lazily.
+		 */
+		if (sz == PMD_SIZE && want_pmd_share(new_vma, new_addr)) {
+			const unsigned long unmap_size =
+				min(old_end - old_addr,
+				    offset_to_last_dst_entry + sz);
+
+			hugetlb_unmap_range(&tlb, vma, old_addr,
+					    old_addr + unmap_size, NULL,
+					    ZAP_FLAG_DROP_MARKER);
+			old_addr += unmap_size - sz;
+			new_addr += unmap_size - sz;
+			continue;
+		}
+
 		dst_pte = huge_pte_alloc(mm, new_vma, new_addr, sz);
 		if (!dst_pte)
 			break;
@@ -5327,9 +5351,10 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	return len + old_addr - old_end;
 }
 
-static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
-				   unsigned long start, unsigned long end,
-				   struct page *ref_page, zap_flags_t zap_flags)
+static void hugetlb_unmap_range(struct mmu_gather *tlb,
+				struct vm_area_struct *vma, unsigned long start,
+				unsigned long end, struct page *ref_page,
+				zap_flags_t zap_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
@@ -5339,27 +5364,12 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 	struct page *page;
 	struct hstate *h = hstate_vma(vma);
 	unsigned long sz = huge_page_size(h);
-	struct mmu_notifier_range range;
 	unsigned long last_addr_mask;
 
 	WARN_ON(!is_vm_hugetlb_page(vma));
 	BUG_ON(start & ~huge_page_mask(h));
 	BUG_ON(end & ~huge_page_mask(h));
 
-	/*
-	 * This is a hugetlb vma, all the pte entries should point
-	 * to huge page.
-	 */
-	tlb_change_page_size(tlb, sz);
-	tlb_start_vma(tlb, vma);
-
-	/*
-	 * If sharing possible, alert mmu notifiers of worst case.
-	 */
-	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, mm, start,
-				end);
-	adjust_range_if_pmd_sharing_possible(vma, &range.start, &range.end);
-	mmu_notifier_invalidate_range_start(&range);
 	last_addr_mask = hugetlb_mask_last_page(h);
 	address = start;
 	for (; address < end; address += sz) {
@@ -5446,6 +5456,26 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 		if (ref_page)
 			break;
 	}
+}
+
+static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+				   unsigned long start, unsigned long end,
+				   struct page *ref_page, zap_flags_t zap_flags)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct mmu_notifier_range range;
+
+	tlb_change_page_size(tlb, huge_page_size(hstate_vma(vma)));
+	tlb_start_vma(tlb, vma);
+
+	/*
+	 * If sharing possible, alert mmu notifiers of worst case.
+	 */
+	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, mm, start,
+				end);
+	adjust_range_if_pmd_sharing_possible(vma, &range.start, &range.end);
+	mmu_notifier_invalidate_range_start(&range);
+	hugetlb_unmap_range(tlb, vma, start, end, ref_page, zap_flags);
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_end_vma(tlb, vma);
 
-- 
2.53.0

