Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAAB53A896;
	Thu, 15 Oct 2026 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080514; cv=none; b=INwDISzZC0o+1KxuhABzAWu/lUaF7PavK2okvobUOTh/V3LJv463MO6PEvPfSrj3AvbI/0R8OqMpNDZJzo8hfvY0nLVRdCiSuRx/bIa6iwFedpLCvFUs9wbmYGScwwdVFTSH1qSBY7E2zLDFelHwLdCALB2TiTGAN3uQIRjYGl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080514; c=relaxed/simple;
	bh=H0mRtHiREZR/wJfbvEOj3l9Hd/kFzFDOFJn7HQzzBYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gAfi3wCwBkDfHL7QEZShSy8E9A37hvbsjsVdhitp0gxAOJNp+l0eQeZE1cy5Q6mzhXx2sDFOK/J5/cVx0ka79p+P6YRq7PEK3UzAeRqUV5nJ2ZBe8dqnqKhaoIj6ATQSRii2zbgmDjx7ycAGhkXZ6/7JdmLTo4b9sEmxNnZ/6e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpWmW2p0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpWmW2p0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020211F000C5;
	Thu, 15 Oct 2026 16:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792080500;
	bh=luu9zceebiAM3DcgabjNhnEA73HFyTTMwHsaVP8GP7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IpWmW2p0cOKas78pJQq1fPzYf4OjZG1D5/E4uGVb/sSKqnGO8zzcFpOAMCj8r8Y/j
	 0fwISAtT3NHdyUMidHHvUFlN1Ohz3zEfITaeqcVWXSZ9700SpEyGIoPz4xLl9I0pHu
	 VZBaNezmk6pDEjLmgMsWOoTiGpsG8WEdR5ClhfEbOexU1Ev8s3wlE3q9Tkl81ZXpoG
	 0YtuMfNIq2fs5QkozUjwOKDOzPEL6e/QBoeaBm+P4umBvL3e//p62h/ezUx6VvuyNp
	 8LnNu/FcW0+Joug79ZWYKFiCnW7+t/ZW068LrHoTdTP/sWaR//pp2AGA7dByV03Atv
	 4GfSjSlq9VMRg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 15 Oct 2026 18:07:15 +0200
Subject: [PATCH 09/10] mm/hugetlb: don't leave a uffd-wp marker when
 zapping an RWP entry
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-urgent_fixes-v1-9-42796911043b@kernel.org>
References: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
In-Reply-To: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Adam Litke <agl@us.ibm.com>, 
 Mel Gorman <mel@csn.ul.ie>, Rik van Riel <riel@surriel.com>, 
 Peter Xu <peterx@redhat.com>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2705; i=david@kernel.org;
 h=from:subject:message-id; bh=jDtJa/vbrcghzS+kebnll5J1z6JL9nvmr5+IgGhx8P8=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIu/DI5dFov+la3mt9qM5ODbX/Yn6erNG2ukU4xN+8vP
 uv78NunjlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACZycwkjw6O/8w7p9l0VffTL
 brFP0ttta0IMbO++/Gm6LHSF1dSsoisM/93Ut/a3rmRmX2n/dGrndpWZgcG1Tx9VnVFPu6yx3Ke
 ekx8A
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Josef Bacik <josef@toxicpanda.com>

An entry that is protected with UFFDIO_RWPROTECT is PAGE_NONE with the
uffd bit set, the bit that userfaultfd write protection uses too.  When
__unmap_hugepage_range() zaps an entry with that bit it leaves a
PTE_MARKER_UFFD_WP behind, whatever the VMA is registered for.

In a VMA registered with UFFDIO_REGISTER_MODE_RWP that marker means
nothing.  The next fault has hugetlb_no_page() turn it into a present,
read-only entry with the uffd bit.  That is not an RWP entry, since it is
not PAGE_NONE, and the VMA has no VM_UFFD_WP (the two modes can not be
registered together).  An earlier fix solved some side effects, now just
stop the zap from wrongly installing a marker.

Leave a marker only if the VMA is registered for write protection, both
for present and for non-present entries.  The zap of ordinary page
tables has the same test, in cond_install_uffd_wp_ptes(), and
hugetlb_change_protection() says that "uffd_rwp does not install markers".

After a zap the range of an RWP VMA is simply empty, as it is for
anonymous memory and shmem.  Nothing changes for VMAs with VM_UFFD_WP.  In
a VMA that is not registered at all a leftover uffd bit or marker is now
dropped by the zap and no longer kept alive.

Original fix generated by an LLM and sent in private by Josef.

Fixes: 2d427bb01639 ("mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP")
Cc: stable@vger.kernel.org
Reported-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ david: a bit of description overhaul+simplification ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1548a6156206b..fb51f7d02cebf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5267,7 +5267,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			 * drop the uffd-wp bit in this zap, then replace the
 			 * pte with a marker.
 			 */
-			if (pte_swp_uffd_any(pte) &&
+			if (userfaultfd_wp(vma) && pte_swp_uffd_any(pte) &&
 			    !(zap_flags & ZAP_FLAG_DROP_MARKER))
 				set_huge_pte_at(mm, address, ptep,
 						make_pte_marker(PTE_MARKER_UFFD_WP),
@@ -5303,7 +5303,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		if (huge_pte_dirty(pte))
 			folio_mark_dirty(folio);
 		/* Leave a uffd-wp pte marker if needed */
-		if (huge_pte_uffd(pte) &&
+		if (userfaultfd_wp(vma) && huge_pte_uffd(pte) &&
 		    !(zap_flags & ZAP_FLAG_DROP_MARKER))
 			set_huge_pte_at(mm, address, ptep,
 					make_pte_marker(PTE_MARKER_UFFD_WP),

-- 
2.43.0

