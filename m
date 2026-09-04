Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1F43ED3CF
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535038; cv=none; b=EGbMpjP0ZIVjpGo/A2ELutobTSuYnn8kX5dchZhqeEG3RcPTAvLziTejvwDbMqozu/xQ7tUQsFIZV6uRa6/pz2Mcvcs3P6kOzx9EYjPcfpJNmTxVsh96PDfmAKw3eGWEV0+smXn3yGLoH5Wj3KdDETdakg56fOPCtw5sDgwZ0YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535038; c=relaxed/simple;
	bh=xIDFQFQPESkS2JSUJnNkUfUYa1G4N4vLG1j8c2qfsLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfknChrqkJLDQSeMa11mYAby+zxRDLzAmBDmW70s46/94kKnUxkWwr/cBmURdXx6SWpVzxKlpYtkw7/tJ7D57LO9FqwFL1LT1UBETwEBsjVxUzRaFhhB28nXi4KOUEUNardCjd0N9bre3F49GqXWM83+9uNUhq8w+yWb+Ip9aMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAdyj18R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAdyj18R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5613B1F00A3D;
	Fri,  4 Sep 2026 15:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788535035;
	bh=PTn/svM33MY8VWq1h3gKGOEuJl+5I3d0voc1gqBMWmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LAdyj18R/oaJ8PstjyJRtZTH3QzxfAe7wLkmruADywq1SkrPD6IstFqt4aGHxoilw
	 Kws+9fH0nwSQ+JxPDg3dQrBcxCCip0vQxqHdBtN7w/qoBrEbCLX+PiMq+TCSeEcmAe
	 MhMzC3K4meaEXP41sygrKeBJjFpWB13odhaX+jAlEWTwtWE7P56grldXOUUUBshNdb
	 9yj7bfCpUGxsNiTYABM0sd3PY7i52BQU1inPxpXqXVuBudIsUWRWMq3HwOtVULxlq9
	 zEJNFTjLHVd2tFWfDNPylcqJPuEfvKpx09oxa4JotPuwdLFk5DmtFmkrQ/2qAEirpu
	 KnMD4iuLqp0cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dev Jain <dev.jain@arm.com>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Alistair Popple <apopple@nvidia.com>,
	Andi Kleen <ak@linux.intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Byungchul Park <byungchul@sk.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Gregory Price <gourry@gourry.net>,
	Harry Yoo <harry@kernel.org>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Jann Horn <jannh@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Mel Gorman <mel@csn.ul.ie>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Pedro Falcato <pfalcato@suse.de>,
	Rakie Kim <rakie.kim@sk.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Rik van Riel <riel@surriel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Will Deacon <will@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/rmap: use huge_ptep_get() in try_to_unmap_one()
Date: Fri,  4 Sep 2026 11:17:10 -0400
Message-ID: <20260904151710.890678-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090347-esquire-pox-67eb@gregkh>
References: <2026090347-esquire-pox-67eb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dev Jain <dev.jain@arm.com>

[ Upstream commit f5407e9b697c940e78b27ff63c6e14d8d171adc3 ]

Patch series "Fix incorrect access of hugetlb pte entries", v3.

There are various places which use ptep_get() to get the pte entry
corresponding to a hugetlb folio.  Some arches (like s390) have special
handling to compute the pteval, so they provide huge_ptep_get().  Use this
helper consistently.

Additionally, some code paths may provide huge_ptep_get with an unaligned
address.  This is a problem on arm64 (I checked other arches and it looks
fine for them), which is fixed in patch 1.  The fix is made to be
backport-friendly: the cleaner fix would be to perhaps pass the hstate to
huge_ptep_get() - that is wider churn and we can do that later.

This patch (of 5):

try_to_unmap_one() handles hugetlb folios when memory failure needs to
replace a poisoned hugetlb mapping with a hwpoison entry.  In that case
page_vma_mapped_walk() returns the pte pointer to the hugetlb folio in
pvmw.pte, but the code reads it with ptep_get().

On arches which provide their own huge_ptep_get() to dereference a huge
pte pointer, accessing via ptep_get() would cause pte_pfn(), pte_present()
etc to misbehave.

It is not clear whether this has a trivially visible effect to userspace.

Just use huge_ptep_get() for dereferencing a huge pte pointer.

Link: https://lore.kernel.org/20260703114202.365553-1-dev.jain@arm.com
Link: https://lore.kernel.org/20260703114202.365553-3-dev.jain@arm.com
Fixes: c7ab0d2fdc84 ("mm: convert try_to_unmap_one() to use page_vma_mapped_walk()")
Signed-off-by: Dev Jain <dev.jain@arm.com>
Reported-by: David Hildenbrand <david@kernel.org>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Harry Yoo <harry@kernel.org>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Jann Horn <jannh@google.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Jun'ichi "Nick" Nomura <j-nomura@ce.jp.nec.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Mel Gorman <mel@csn.ul.ie>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ adapted folio and modern PTE accessors to page-based logic and the older huge_ptep_get() signature ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/hugetlb.h | 2 ++
 mm/rmap.c               | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 254fcd6f9604f..64a2c9e84bc12 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1078,6 +1078,8 @@ static inline void hugetlb_count_sub(long l, struct mm_struct *mm)
 {
 }
 
+pte_t huge_ptep_get(pte_t *ptep);
+
 static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
 					pte_t *ptep, pte_t pte, unsigned long sz)
 {
diff --git a/mm/rmap.c b/mm/rmap.c
index c103e01d22327..202c13b8aa3e5 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1465,8 +1465,12 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		/* Unexpected PMD-mapped THP? */
 		VM_BUG_ON_PAGE(!pvmw.pte, page);
 
-		subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
 		address = pvmw.address;
+		if (PageHuge(page))
+			pteval = huge_ptep_get(pvmw.pte);
+		else
+			pteval = *pvmw.pte;
+		subpage = page - page_to_pfn(page) + pte_pfn(pteval);
 
 		if (PageHuge(page) && !PageAnon(page)) {
 			struct mmu_gather tlb;
@@ -1503,7 +1507,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		}
 
 		/* Nuke the page table entry. */
-		flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
+		flush_cache_page(vma, address, pte_pfn(pteval));
 		if (should_defer_flush(mm, flags)) {
 			/*
 			 * We clear the PTE but do not flush so potentially
-- 
2.53.0

