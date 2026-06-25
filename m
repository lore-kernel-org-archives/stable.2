Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C775026158B;
	Thu, 25 Jun 2026 04:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782361780; cv=none; b=tIs7c34jj3PWLJhgreESdVpV4Cvbk4WhoLHnm8Kgnrmp4c133iVfOj46c6ChH5bA0eZUrg5CW02vkfqpH0BRcPVFsiQIJJ3rOFj0Wyb1L9HQ6mPr6wLL2T8xPs+y7phoyv/X5q7sfQEsJeqN4/qka0BiXwNf8xV/+M+XQtnUAaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782361780; c=relaxed/simple;
	bh=7mIUdhpxjfBGpDoIwyQsU3lKaGAeN4hJVoywz3Jt11U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TL1SQpjRFLj84Jm/Bybb5V3s+tSPbtGGOE3njM2CeZ6QFSDC+uUsKes6Uogp9sn0xaEyT/Sv8vadraP6qsEg2aAG/wT+aFDVeTpGivqD1ruOs0jAJBeLU/F9fXABCaK0+jVt4tbaFIjilnM3flNaiP9UnioyoDLfxi9Nv14IhXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=A65Fo0vA; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="A65Fo0vA"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71BCB2BCE;
	Wed, 24 Jun 2026 21:29:32 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E23993F836;
	Wed, 24 Jun 2026 21:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782361776; bh=7mIUdhpxjfBGpDoIwyQsU3lKaGAeN4hJVoywz3Jt11U=;
	h=From:To:Cc:Subject:Date:From;
	b=A65Fo0vA4tHeeQXXWFvROS/Qx4WjhFQyKCTP3R+9g1J/pHMVXTLveKpCjWEo0lrP0
	 LjuuNTfiardA87j/CArqMgKjjdiTuvEsqv9a36VCfwTQm1BjHEBg9Wk4yrRwthoiNE
	 fZ05es2tqrTsRMM8eQqARMz0RPfjPEivtCMlIYJE=
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org
Cc: Dev Jain <dev.jain@arm.com>,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	kas@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH] mm/rmap: use huge_ptep_get() in try_to_unmap_one()
Date: Thu, 25 Jun 2026 04:28:51 +0000
Message-ID: <20260625042853.2752898-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

try_to_unmap_one() handles hugetlb folios when memory failure needs
to replace a poisoned hugetlb mapping with a hwpoison entry. In that
case page_vma_mapped_walk() returns the hugetlb entry in pvmw.pte, but
the code reads it with ptep_get() before decoding the PFN.

That is wrong on architectures where hugetlb entries are not encoded as
regular PTEs. On s390, for example, a raw huge RSTE must be converted
by huge_ptep_get() before helpers such as pte_pfn() can inspect it. A
raw decode can select the wrong subpage, so try_to_unmap_one() can
install a hwpoison entry for the wrong PFN.

The userspace-visible result is that a later access to the poisoned
hugetlb subpage can miss the expected SIGBUS. With DEBUG_VM, the wrong
subpage can also trip the PageHWPoison check.

Use huge_ptep_get() for hugetlb mappings before decoding the PFN.

Before c7ab0d2fdc84, the bug existed in the form of a plain dereference:
we would check the head page pfn of the hugetlb with pte_pfn(*pte), and
bail out on mismatch. This would mean that the hwpoisoned entry will not
get installed.

I am not sure what is the procedure on such kinds of very old bugs - how
back should I really go?

Fixes: c7ab0d2fdc84 ("mm: convert try_to_unmap_one() to use page_vma_mapped_walk()")
Cc: stable@vger.kernel.org
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
Applies on mm-unstable (d17fe8a046a2).
There are similar old bugs present, in try_to_migrate_one(), check_pte(),
remove_migration_pte(), prot_none_hugetlb_entry().

 mm/rmap.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 1c77d5dc06e9f..aa8a254efaecc 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2095,11 +2095,16 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
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
+			/*
+			 * Handle PFN swap PTEs, such as device-exclusive ones,
+			 * that actually map pages.
+			 */
+			pteval = ptep_get(pvmw.pte);
+		}
 		if (likely(pte_present(pteval))) {
 			pfn = pte_pfn(pteval);
 		} else {
@@ -2110,7 +2115,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		}
 
 		subpage = folio_page(folio, pfn - folio_pfn(folio));
-		address = pvmw.address;
 		anon_exclusive = folio_test_anon(folio) &&
 				 PageAnonExclusive(subpage);
 
-- 
2.43.0

