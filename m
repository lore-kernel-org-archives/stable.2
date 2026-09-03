Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA17D4AA1D2
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439595; cv=none; b=p7J2BF1mNNa6A1pX7HQPFdDk5KrIIf7kwqU7XBNYckOjVY5j3h/ldAN6DTXEC+pQ0sbl1n87oCJ6yktQ1NtRjGA5Dr0jVw8nImMqHmSiw/JLfu6qQMOg9CIlsHZoJpGxsjdLaGMBJL9YRm4AMyiCa25caSgZEhmpPPyiK9XO/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439595; c=relaxed/simple;
	bh=4E76wappxnMYZnAU4t7Uxe8WKv4Q43SiiIw2je8C01U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IxJVXxrZvJxdCIlyez0LAkZjhfELK9gsV5b3+pBjmfky9oVXsF9CteCwsjlelTqdRBHEvirv3fmbzUIDj28XhZoTxBT2LN2eKJ+mJ1AGM6poYo8PCcL5dV1LD/G9OfZdW3DTRh51LwU0yOJvhSqxdlYHL2DFbqropiGNeCLhZeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hLpmo66R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hLpmo66R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11FF1F00A3A;
	Thu,  3 Sep 2026 12:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439592;
	bh=gOnEpMBmWjSQPrIJSNn3+t66/NbxQdGj9Q9l9BIVMBg=;
	h=Subject:To:Cc:From:Date;
	b=hLpmo66Rr5y5tYo+rog9uR5UT8VbomCKJLU5C+UGR64QYOFQMdv5JOqX3pgKlgSdw
	 3pBnUtL0j9x14skZESzsmGnk4nZ+mDmvUeS8z3GiolwGo7NWP0vUE+SLUVliNWDvmD
	 DklKunS03y6UDaTS+wsM7bQNeHJBu6CUmHJWpj4g=
Subject: FAILED: patch "[PATCH] mm/rmap: use huge_ptep_get() in try_to_unmap_one()" failed to apply to 6.1-stable tree
To: dev.jain@arm.com,ak@linux.intel.com,akpm@linux-foundation.org,anshuman.khandual@arm.com,apopple@nvidia.com,byungchul@sk.com,catalin.marinas@arm.com,dave.hansen@intel.com,david@kernel.org,gourry@gourry.net,harry@kernel.org,j-nomura@ce.jp.nec.com,jannh@google.com,joshua.hahnjy@gmail.com,jpoimboe@kernel.org,kas@kernel.org,lance.yang@linux.dev,liam@infradead.org,ljs@kernel.org,matthew.brost@intel.com,mel@csn.ul.ie,muchun.song@linux.dev,nao.horiguchi@gmail.com,osalvador@suse.de,pfalcato@suse.de,rakie.kim@sk.com,rcampbell@nvidia.com,riel@surriel.com,ryan.roberts@arm.com,stable@vger.kernel.org,vbabka@kernel.org,will@kernel.org,ying.huang@linux.alibaba.com,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:49:46 +0200
Message-ID: <2026090346-evaluator-pointless-7f22@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f5407e9b697c940e78b27ff63c6e14d8d171adc3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090346-evaluator-pointless-7f22@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f5407e9b697c940e78b27ff63c6e14d8d171adc3 Mon Sep 17 00:00:00 2001
From: Dev Jain <dev.jain@arm.com>
Date: Fri, 3 Jul 2026 11:41:55 +0000
Subject: [PATCH] mm/rmap: use huge_ptep_get() in try_to_unmap_one()

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

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 817b8b4223fa..95b1b6ee1f96 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1270,6 +1270,8 @@ static inline void hugetlb_count_sub(long l, struct mm_struct *mm)
 {
 }
 
+pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
+
 static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long addr, pte_t *ptep)
 {
diff --git a/mm/rmap.c b/mm/rmap.c
index 408e542649b5..e0d7b33ceee4 100644
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
 

