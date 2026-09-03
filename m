Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CE14B1B22
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444344; cv=none; b=SDe0d7HwybPT3AwOGy3oyjKiiaYWiOw1DmRz1OZHzA2GudMAtQZetFpksiXKWc5dsdhb/XWd6rwjJF5TXrJ2ouUx5ejhyo239hrSGs+/2pCjwbSK9ptVUYRmSdZMN+KBJfPwj3VqquTp3JI4OJXRzvnJqredpvzBSFZsG+kbsC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444344; c=relaxed/simple;
	bh=QAqloB9wo8HVh+RhZ39my1ZzQ34rmt8f8EJrLKkpS20=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lRLQp55AJOWobJZPeJ4/GXHRXhzxUWZq55FWrIIhPDjVqwObG9zHZRGp4EZjS3ip6ksvB0cwy2tS0LQjfEkmqZGaAXVwmHkZKPGJI1kqy9ev0i3VVkv4p4vP64+vU5/OEFGZV1GFIRTjiuFR/14+IVonDmYMOLCxe/DWxvw1sno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x3dTqO58; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x3dTqO58"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613C71F00ACF;
	Thu,  3 Sep 2026 14:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444334;
	bh=hc9SJsxcl1jJvncSYIusk/AYk5KCgS9WwqRayDlczrI=;
	h=Subject:To:Cc:From:Date;
	b=x3dTqO58jts1UZq1+1xfG/+7kB6xBRjtWi8AJzYi+4vYbO0BrLh8tgXxt5auEphlz
	 gCRmICup5Zpns5vISiTGkgibiYq2cykBybF6fQJ4U/36/iqHMMDZfYzC5c9W8cLJWt
	 n81j1e7M5k2wZfT7bq+i6dMNTkyDKDZ+yyDfNZ5w=
Subject: FAILED: patch "[PATCH] hugetlb: only adjust reservation during unmapping if mapcount" failed to apply to 6.12-stable tree
To: guillaume@morinfr.org,akpm@linux-foundation.org,david@kernel.org,leitao@debian.org,muchun.song@linux.dev,osalvador@suse.de,riel@surriel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:42:56 +0200
Message-ID: <2026090356-destiny-subject-4d56@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 5120b1e048d48596ffaec1a8412012a91adba73b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090356-destiny-subject-4d56@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5120b1e048d48596ffaec1a8412012a91adba73b Mon Sep 17 00:00:00 2001
From: Guillaume Morin <guillaume@morinfr.org>
Date: Tue, 28 Jul 2026 21:29:03 +0200
Subject: [PATCH] hugetlb: only adjust reservation during unmapping if mapcount
 is 0

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

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 49bf325325c0..7d14511c20ad 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5218,6 +5218,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	bool adjust_reservation;
 	unsigned long last_addr_mask;
 
+	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
 	WARN_ON(!is_vm_hugetlb_page(vma));
 	BUG_ON(start & ~huge_page_mask(h));
 	BUG_ON(end & ~huge_page_mask(h));
@@ -5309,7 +5310,10 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
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
@@ -5317,7 +5321,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 		spin_lock_irq(&hugetlb_lock);
 		if (!h->surplus_huge_pages && __vma_private_lock(vma) &&
-		    folio_test_anon(folio)) {
+		    !folio_mapped(folio) && folio_test_anon(folio)) {
 			folio_set_hugetlb_restore_reserve(folio);
 			/* Reservation to be adjusted after the spin lock */
 			adjust_reservation = true;

