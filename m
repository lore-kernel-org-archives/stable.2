Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CC13B7759;
	Fri,  3 Jul 2026 11:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078967; cv=none; b=dYXGGlnP9X4EcH8cShfRhmSZIE+71ZcUoCScfN6TYl3Va6G0hd9bSiUrRixhb+E751pCmA1K6uFBPuZ7Y4tllRE5Nua4uMHFGi71lV/3Dl5tzOBfanZb58YWPHscLSOcGvaZqoHqKcWu4b6pyflMmttn9mGKvlrxTDu6JNRGUNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078967; c=relaxed/simple;
	bh=BRu+bhG7aKPiwT5vuH3zvlt7PlvdsDOhL/vNEPHmmuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ls0kPWrTYLl8Q3p/G4wsaOmE2Sv+Mr9ryblWuflMPBzS85r0FnjRxt7S31DPMZQsIaxtKL5IEYD/f3NwiTfFmxN4D8BHCrQstA38QWTv1pGQdyVLVCKPHBE6UZKKXKIUk8FJx4N8188XgWIOGXcvVgTQeK7oeVDomsc2zLUs6jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bZE5qae5; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bZE5qae5"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61F7D3587;
	Fri,  3 Jul 2026 04:42:40 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 85C5A3F673;
	Fri,  3 Jul 2026 04:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783078964; bh=BRu+bhG7aKPiwT5vuH3zvlt7PlvdsDOhL/vNEPHmmuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZE5qae5+56oO0S3uNA4ZnaxllNJL7xt1NU0E09fQ779TxsZvP3TNcLz3cnjE+9yK
	 aPal0ieAg0R7/f/NZT22vH0T1f8E7ieCwBTMhNTpGz/7JKySJSfrYj3blLLbOsbd5J
	 JP0rBHMBYdhLeAFN9ToEtIptslmqlwFr3u/d4WVI=
From: Dev Jain <dev.jain@arm.com>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	david@kernel.org,
	liam@infradead.org
Cc: Dev Jain <dev.jain@arm.com>,
	riel@surriel.com,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev,
	kas@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	apopple@nvidia.com,
	rcampbell@nvidia.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	ak@linux.intel.com,
	nao.horiguchi@gmail.com,
	mel@csn.ul.ie,
	j-nomura@ce.jp.nec.com,
	pfalcato@suse.de,
	tglx@kernel.org,
	dave.hansen@intel.com,
	jpoimboe@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH v3 2/6] mm/rmap: use huge_ptep_get() in try_to_unmap_one()
Date: Fri,  3 Jul 2026 11:41:55 +0000
Message-ID: <20260703114202.365553-3-dev.jain@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703114202.365553-1-dev.jain@arm.com>
References: <20260703114202.365553-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

try_to_unmap_one() handles hugetlb folios when memory failure needs
to replace a poisoned hugetlb mapping with a hwpoison entry. In that
case page_vma_mapped_walk() returns the pte pointer to the hugetlb folio
in pvmw.pte, but the code reads it with ptep_get().

On arches which provide their own huge_ptep_get() to dereference a huge
pte pointer, accessing via ptep_get() would cause pte_pfn(), pte_present()
etc to misbehave.

It is not clear whether this has a trivially visible effect to userspace.

Just use huge_ptep_get() for dereferencing a huge pte pointer.

Fixes: c7ab0d2fdc84 ("mm: convert try_to_unmap_one() to use page_vma_mapped_walk()")
Cc: stable@vger.kernel.org
Reported-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 include/linux/hugetlb.h |  2 ++
 mm/rmap.c               | 16 ++++++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 2abaf99321e90..6996d02acf171 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1261,6 +1261,8 @@ static inline void hugetlb_count_sub(long l, struct mm_struct *mm)
 {
 }
 
+pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
+
 static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long addr, pte_t *ptep)
 {
diff --git a/mm/rmap.c b/mm/rmap.c
index 1c77d5dc06e9f..03737daa348c0 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2095,14 +2095,19 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
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
@@ -2110,7 +2115,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		}
 
 		subpage = folio_page(folio, pfn - folio_pfn(folio));
-		address = pvmw.address;
 		anon_exclusive = folio_test_anon(folio) &&
 				 PageAnonExclusive(subpage);
 
-- 
2.43.0

