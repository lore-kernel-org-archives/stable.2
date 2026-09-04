Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18034F4747
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535673; cv=none; b=F800cBgTJVn2eUtIuJ7sKrEaLaVu1iZOw+Idjd/08opwtjp2wiMa+7Oay7FVryty9EhJm9SpUioJPdhmttOKjNcLQyXlPdcX6vREMIn04NN2zXOgz/OsjxTmqiNvnyLu6S88zBUE6pEG6QJq5306xyzFQYoha1i9U4/0vFno0tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535673; c=relaxed/simple;
	bh=TXE2hhBoAvTwW9zkm3o2HlixZFnVpiLjMGRmmG8QV0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgjMq4qn0FxRoDnccfglP0tsC2glxEDjd9H/T50RCCWfz9UX8sAaF8rHOgsBrrhhbhg4VO3s/Rm/TNyACMrBgKVKdsht2YV0gGmqrOqeObMXGFNn9C83AtWNmmrR3FVvp1IYrT4kISOawDwcFrZ0zNDl7xuPRRNIuum/2482hPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVZc86jp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVZc86jp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC6D1F00A3D;
	Fri,  4 Sep 2026 15:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788535669;
	bh=e211aQeUTdigpOw3wbofPtpx8U+lxlajTdtYsLB8bkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SVZc86jp86mBov5/gkz7bpZYXZGNDS8YpFuik/7n9sLGOQTA9/pYbz/H1yt5Ueodc
	 psywgV3bmorHI4xvTSMk4PH2YE0hhrqgFQ9V1wWFqHl1wNZCEqzRFRxHuTNOjtRyfp
	 kOt0mq9wtN01DAsLTpsExzSGfnEGwHyY/ebQHd+5sYjjlDgT+TdxvpzqhTOiRn6YAJ
	 FDOY1SPYcR/E2qzCw48lGqlbpWtRTvAjszjaKnB63svOdITYCv8gpGM6Rn8iCW1n/d
	 vyNQlrJNA4ko9Ta7QdNFGZOfqCdWDbU1rqdTgutDE0/ZsaO/q/mSKmuDXV9SZf6Df2
	 uYhvvA18RACJg==
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
Subject: [PATCH 5.10.y] mm/rmap: use huge_ptep_get() in try_to_unmap_one()
Date: Fri,  4 Sep 2026 11:27:44 -0400
Message-ID: <20260904152744.898593-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090348-declared-riveting-c33a@gregkh>
References: <2026090348-declared-riveting-c33a@gregkh>
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
index dfb1afa3d2821..7dbe266621845 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -929,6 +929,8 @@ static inline void hugetlb_count_sub(long l, struct mm_struct *mm)
 {
 }
 
+pte_t huge_ptep_get(pte_t *ptep);
+
 static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
 					pte_t *ptep, pte_t pte, unsigned long sz)
 {
diff --git a/mm/rmap.c b/mm/rmap.c
index a5da7abd15d3d..0cab38f1907ba 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1466,8 +1466,12 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
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
@@ -1544,7 +1548,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		}
 
 		/* Nuke the page table entry. */
-		flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
+		flush_cache_page(vma, address, pte_pfn(pteval));
 		if (should_defer_flush(mm, flags)) {
 			/*
 			 * We clear the PTE but do not flush so potentially
-- 
2.53.0

