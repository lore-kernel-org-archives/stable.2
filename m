Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB9C35201E
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 02:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490349; cv=none; b=XZILLGW3oU7ZZArDIiGFCgrF40/OEo8vvdaNWLlZirjlHk2kBRLtj4Yi8ctOcpj7lDyMzWpM/VJIF9liSiQuod0+jyqNfq1Q+pY8E196iWTECBbgT0ylUM82WfIXMt2l6Uyq6rIySfBQOioRVP8HiQF8CdcmIk52ii76bZ9tW0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490349; c=relaxed/simple;
	bh=FuVZvws43a4cy01UxTnCt77NsQWaPKNFdR4IXDoXZC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6602TfRPr0e8keeiPOu2eSNOZT9W0F5eOYEm8DHUTY+7TuiW9XE/sJ7xB3XaosGgoeszM0M7GipcRm43iF/5gh2fx0reGopjm4irrZMZj1CpMTD59Ft1AHkIMfWjXUTv4RPt/KDTGkSwALPe9We0ZXO56/KERWOOgSEZnSj4XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDStRxXZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDStRxXZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEA21F00A3D;
	Fri,  4 Sep 2026 02:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490347;
	bh=X4bZgcJxFACafE1zLjwMjSu5qqCHIfioJpvDfh8r3o0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DDStRxXZ8NlQAs6BD4l6gfF9gl6+0dVLabGYFFPpPB/Vmlx9YWaUhYr2FlB8LWEU+
	 bwWzyQajnV2eH/0bp8T7qiVXwOYu89/2CTp1riHxbCLwi6aMtXEmbxZqY011nTSjsD
	 CYOVg5eMn3HpuTWMT5ijyWKKdVLdKfSKi0J6Qb3HIPmY95Z5X2SFGsFJeyxRWKYZBI
	 T7/yGYw8Twtg3MSViLwhDz+bE2Ncw4Z+gQT/6siCkdLlCvxoPZAQ+iICxOnkDjPWuC
	 qxojRIjsnDD8T5nADUGDPdpIa1wyX78lD/6Gns5WFgwvmLfNFlAcAwczaNKl85IEHT
	 o4PVbjTiYowyA==
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
Subject: [PATCH 6.12.y 2/2] mm/rmap: use huge_ptep_get() in try_to_unmap_one()
Date: Thu,  3 Sep 2026 22:52:16 -0400
Message-ID: <20260904025216.2265672-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904025216.2265672-1-sashal@kernel.org>
References: <2026090345-number-strenuous-f36b@gregkh>
 <20260904025216.2265672-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/hugetlb.h |  2 ++
 mm/rmap.c               | 16 ++++++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 739bc71c33fd1..dfea039a1dc89 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1235,6 +1235,8 @@ static inline void hugetlb_count_sub(long l, struct mm_struct *mm)
 {
 }
 
+pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
+
 static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long addr, pte_t *ptep)
 {
diff --git a/mm/rmap.c b/mm/rmap.c
index b7907fa14dc98..c051651de6f9a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1711,14 +1711,19 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		/* Unexpected PMD-mapped THP? */
 		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
 
-		/*
-		 * Handle PFN swap PTEs, such as device-exclusive ones, that
-		 * actually map pages.
-		 */
-		pteval = ptep_get(pvmw.pte);
+		address = pvmw.address;
+		if (folio_test_hugetlb(folio)) {
+			pteval = huge_ptep_get(mm, address, pvmw.pte);
+		} else {
+			pteval = ptep_get(pvmw.pte);
+		}
 		if (likely(pte_present(pteval))) {
 			pfn = pte_pfn(pteval);
 		} else {
+			/*
+			 * Handle PFN swap PTEs, such as device-exclusive ones,
+			 * that actually map pages.
+			 */
 			const softleaf_t entry = softleaf_from_pte(pteval);
 
 			pfn = softleaf_to_pfn(entry);
@@ -1726,7 +1731,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		}
 
 		subpage = folio_page(folio, pfn - folio_pfn(folio));
-		address = pvmw.address;
 		anon_exclusive = folio_test_anon(folio) &&
 				 PageAnonExclusive(subpage);
 
-- 
2.53.0

