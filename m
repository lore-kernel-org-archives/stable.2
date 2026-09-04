Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5B63BCD3D
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788549876; cv=none; b=TDAWDBTas0EIMcCBEPe9d67vLiyyOLqONa/vDFbEjZUDXUrH9PBmF7gEvxJzPaM0BLq/l0ow/VIMGaANbxl0sX5k7BbxCs4Vf3XGbjRpwtJ9emo7VmjCQFPzcN5CgR4/aiLFu7R24C9VaWZSeKhijbJHY84eHSO9NPrre2SUoFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788549876; c=relaxed/simple;
	bh=Gk5sG5NYiQgumRroRz89wCni4F97j60zgbfDFei7ahk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=d3Ysuz36w7c7pwx2d+PO9y3T8J4wNIeOa03+3hu4bnw195oQUruzKkksOMYXqtHAeArZeRTgnIiJigZAOj2gH1n0GpMoLb8yZ2jdec7Vi4ks+c1ne6Fn1jjwRmNrP0Q7T1HDlmxUgVvo2/FvtmXZuPGlZ+J0gaAG3z6oo4fyZXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=Zc+hbo17; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="Zc+hbo17"
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 96779428BE8
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 21:15:20 +0200 (CEST)
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp4-g21.free.fr (Postfix) with ESMTPS id C99FA19F593;
	Fri,  4 Sep 2026 21:15:04 +0200 (CEST)
Authentication-Results: smtp4-g21.free.fr;
	dkim=pass (1024-bit key; unprotected) header.d=morinfr.org header.i=@morinfr.org header.a=rsa-sha256 header.s=20170427 header.b=Zc+hbo17;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:
	To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Bet1ENQIidJOOmEUh1wloYG6lEbqDq/1uE9YGY3qGjk=; b=Zc+hbo173rbyUTcVzDil1jQwXc
	lU9iF5bo3+uiup93uybj8z0M2440ZJ6FQzpm9IBu2Afecn14ZAbD+YwohkJJ2KpUTb19VSYUqgIW3
	ChORtSDTieVKQSE3E+a1AakxIfsOR9bixf09V4mvoPhn2S9eAFhOzYEv06peeaN7u4cs=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.98.2)
	(envelope-from <guillaume@morinfr.org>)
	id 1x2ZNQ-00000002jby-14XJ;
	Fri, 04 Sep 2026 21:15:04 +0200
Date: Fri, 4 Sep 2026 21:15:04 +0200
From: Guillaume Morin <guillaume@morinfr.org>
To: stable@vger.kernel.org
Cc: akpm@linux-foundation.org, leitao@debian.org, muchun.song@linux.dev,
	osalvador@suse.de, gregkh@linuxfoundation.org, riel@surriel.com
Subject: [PATCH 6.12.y]  hugetlb: only adjust reservation during unmapping if
 mapcount
Message-ID: <apsYuFimfru7WaJn@bender.morinfr.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026090356-destiny-subject-4d56@gregkh>

This is a backport of 5120b1e048d48596ffaec1a8412012a91adba73b which
failed to apply to the 6.12 branch

Since df7a6d1f6405, __unmap_hugepage_range can adjust reservations.  In
the case of folio mapped in both a parent and a child, if the parent
unmaps the range first, the reservation adjustment will result in an
underflow of the reserved count.  Once the child unmaps the range, the
count is restored.  Change __unmap_hugepage_range() to check the mapcount
before adjusting the reservation.

Link: https://lore.kernel.org/all/alEJkwn5VlTTH_ZX@bender.morinfr.org/
Link: https://lore.kernel.org/amkC_1Ya6OiUoiLZ@bender.morinfr.org
Fixes: df7a6d1f6405 ("mm/hugetlb: restore the reservation if needed")
Signed-off-by: Guillaume Morin <guillaume@morinfr.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: David Hildenbrand <david@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 5120b1e048d48596ffaec1a8412012a91adba73b)
Signed-off-by: Guillaume Morin <guillaume@morinfr.org>
---
 mm/hugetlb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e910ed0c43d0..185faeaf5c08 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5523,6 +5523,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	bool adjust_reservation;
 	unsigned long last_addr_mask;
 
+	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
 	WARN_ON(!is_vm_hugetlb_page(vma));
 	BUG_ON(start & ~huge_page_mask(h));
 	BUG_ON(end & ~huge_page_mask(h));
@@ -5613,7 +5614,10 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 		/*
 		 * Restore the reservation for anonymous page, otherwise the
-		 * backing page could be stolen by someone.
+		 * backing page could be stolen by someone. Restore only on the
+		 * last unmap, otherwise the owner could empty its resv map
+		 * while the folio is still mapped by a child. Note that holding
+		 * i_mmap_lock_write is needed to check the number of mappings.
 		 * If there we are freeing a surplus, do not set the restore
 		 * reservation bit.
 		 */
@@ -5621,7 +5625,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 		spin_lock_irq(&hugetlb_lock);
 		if (!h->surplus_huge_pages && __vma_private_lock(vma) &&
-		    folio_test_anon(page_folio(page))) {
+		    !folio_mapped(page_folio(page)) && folio_test_anon(page_folio(page))) {
 			folio_set_hugetlb_restore_reserve(page_folio(page));
 			/* Reservation to be adjusted after the spin lock */
 			adjust_reservation = true;
-- 
2.39.1


-- 
Guillaume Morin <guillaume@morinfr.org>
