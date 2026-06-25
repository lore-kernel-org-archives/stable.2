Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E593DA7F2;
	Thu, 25 Jun 2026 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782387031; cv=none; b=tycARA2G13XfnP109i7HqHDZ5G3eOfcbNDtQdRSK8wwvwwcyWjl9DQgtRzBsMY/RDPQXzCUjVH537Ouam6Nwo78oW6Pnjfr12r3PjGcpHjADXNTd2biMbpizIy/CgkuQmIZaECwwtseFJuB9z0d8Fvml8v6SCNmKCRRSBYWjCWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782387031; c=relaxed/simple;
	bh=Ib8HLtVOx0bEstNiQgQ183JVLf7OFocK8ZFR9pqwh+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7LqmA+JShl1l44LdSql+SyvNBv8xPE4CYHqlHbTwhr5cmDFnWOCqytpyy0eaOJIafOjKpz4A8M/dJQe1H0ghhGfvRoCmubnmzWjeuDm+jimfmfaaN5NjMHlnQmlzRijukZMemgj15jeL/U2a/eLgb3RTQaDOgO/f6KN58umHWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=D00yAIF3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="D00yAIF3"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3321328E;
	Thu, 25 Jun 2026 04:30:24 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 72CE23F62B;
	Thu, 25 Jun 2026 04:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782387029; bh=Ib8HLtVOx0bEstNiQgQ183JVLf7OFocK8ZFR9pqwh+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D00yAIF3PxWlFQ7TUPdyDv/Bkj2YGFHDJzLdp6WtkJ3941gqW0Tlc5PQ77i3EdsD0
	 wW2iicZugLsxvqgCZ0MbrOxkaRuVF7sbD2nf3gU665s+IsSrXI2sKFC4bK0LQgm5rT
	 TAdYoJBI2FPE0WKowUceZqoHbAKlu0CKJgr37Kho=
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
	rcampbell@nvidia.com,
	apopple@nvidia.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	mel@csn.ul.ie,
	nao.horiguchi@gmail.com,
	ak@linux.intel.com,
	j-nomura@ce.jp.nec.com,
	pfalcato@suse.de,
	dave.hansen@intel.com,
	tglx@kernel.org,
	jpoimboe@kernel.org,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH 2/5] mm/rmap: use huge_ptep_get() in try_to_migrate_one()
Date: Thu, 25 Jun 2026 11:29:51 +0000
Message-ID: <20260625112955.3254283-3-dev.jain@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625112955.3254283-1-dev.jain@arm.com>
References: <20260625112955.3254283-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

try_to_migrate_one() is used by folio migration to replace a present
mapping with a migration entry. For hugetlb folios, page_vma_mapped_walk()
returns the pte pointer to the hugetlb folio in pvmw.pte, but the code
reads the huge pte entry with ptep_get().

On arches which provide their own huge_ptep_get() to dereference a huge
pte pointer, accessing via ptep_get() would cause pte_pfn(), pte_present()
etc to misbehave.

It is not clear whether this has a trivially visible effect to userspace.

Use huge_ptep_get() to dereference a huge pte pointer.

Commit a98a2f0c8ce1 copied the bug from try_to_unmap_one into
try_to_migrate_one.

Fixes: a98a2f0c8ce1 ("mm/rmap: split migration into its own function")
Cc: stable@vger.kernel.org
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/rmap.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index aa8a254efaecc..abc3a44baaa3d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2505,11 +2505,16 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
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
@@ -2520,7 +2525,6 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		}
 
 		subpage = folio_page(folio, pfn - folio_pfn(folio));
-		address = pvmw.address;
 		anon_exclusive = folio_test_anon(folio) &&
 				 PageAnonExclusive(subpage);
 
-- 
2.43.0

