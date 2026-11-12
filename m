Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450893;
	b=PwP3MjA7j7cadHKope0LmahQ4rgJSwn0brYnFadx1X/24wVxh8l/zZRQgldihK6O9uJa
	 hJ6tbyw7eSDn9HehWhCDf7TsYEDXMFOSnk7tJbsotGMDyIs4rNixfN8xN6jGcLZIORiBJ
	 7qgboXpeINnJ+DQR2xnOGAtBrPLYpSJzi7V7OKfSgfMsIrYC0oOs+K1ArXvj92Qvge1up
	 FeyAQ4+5vUDbFPRSuObT71bSFGlRHJpQm6LjPm0kNIfw1OHAEzIMg/VaY2KhqItnhrd3L
	 R6/fiBSuwOfePcrVNvYV6zIwls1wXY9ul6AhJIhMMw/De3ZWRBw0Xuwh58Yp8cceurg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450893;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6YYgDgPxCzso7Pp3rjIppXKuF8Hs/oWWkoVlmPelJjs=;
	b=R564t5kvJ9ydfWllOc7LTs20aP2p0JGEXyn9fVUaQf1yxBOd0pmItoXviA/LNFX0k81r
	 15cT6fZNw6siNX9xtAqcpvLgKLoY8MY6LCcT5zUlUm8tpS1rMzKJejhwm/sh2hEwnWXHG
	 orFih+dNJgFTzBPsmz9PqNS3hm0ih8BZmMn+8fyIx0r9t1DKfHl7xk+g3/k1BHNFVrkob
	 tquYE28HtqssnFChjvWwXKsB/DW8Fm9tMnQgMd2J6/oUB3z9tBpgzYfYLnw8ug6QKQq/6
	 yrYp3aAvdU/oYDXRqrsi/91mWnJCm+uXFO0RIyCXMdil5Ugle1vEsr6aD7CZ4u+6IpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ohkh+BnD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F35606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ohkh+BnD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8011F00A08;
	Thu, 12 Nov 2026 02:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450893;
	bh=6YYgDgPxCzso7Pp3rjIppXKuF8Hs/oWWkoVlmPelJjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ohkh+BnD7Mi5uoalWfrG5R8fSRsWExPyWq0o45FkmXaNA0nvBmauAXeTDd/Vr75b0
	 XrY2x1GOhVvBNduaOnGuZkBkPcpFufqhEHII4fftPPuSZOom2bsldS/U55HGEVyHxV
	 zm8qaMlz3X5Yk3KQYLFEHPAGMolSRIfAdVnk2/IZXprRuNDuOibTPP9BZsDd2Zdf1L
	 8y6Vx0/DwUH5lUVQjHmyWvdHAqhZqzX/dmdnO2Y8J29bisRc9OxINog8qXdUxY+nKs
	 SdoiyFn8RGutOHcKlBy0B4PTXBmUkGm3d5Psj4DsmWwnJk1nYRSH7z2Qant40N44ZX
	 o/iDDDSEI0Tfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] mm/gup: recheck the PUD under PTL in follow_pud_mask()
Date: Wed, 11 Nov 2026 21:34:44 -0500
Message-ID: <20261112023429.1348841-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112023429.1348841-1-sashal@kernel.org>
References: <20261109200900-failed-6.12-79cb51d538ab@kernel.org>
 <20261112023429.1348841-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit 79cb51d538abc459f74e046d27797d36b133ce0e ]

follow_pud_mask() reads the PUD without a lock. If it is a leaf, it takes
the lock and calls follow_huge_pud(), which reads the entry again, but
only tests whether it is present.

A leaf can be zapped concurrently and a page fault can fill the empty
entry with a page table.

This currently only applies when device-dax makes use of PUD entries,
and the fault after e.g., MADV_DONTNEED would find THPs to be disabled.

That requires a sequence like

1) Fault in the PUD
2) Disable THP
3) Have GUP race against concurrent MADV_DONTNEED + refault

Which is rather unlikely to happen in practice, which is why we never
received a report about such a problem.

Before commit 1b1676180246 ("mm/gup: handle huge pud for
follow_pud_mask()"), we performed that check in follow_devmap_pud() by
testing for pud_devmap().

Let's fix it by just structuring follow_pud_mask() similar to
follow_pmd_mask(), minus protnone stuff that does not apply and minus
FOLL_SPLIT_PMD handling. That makes it much easier to spot any such
inconsistencies.

Perform the pud_bad() check early in follow_pmd_mask() and just forward
the PUD value. We can drop the pud_present() check in follow_huge_pud(),
just like we have in follow_huge_pmd().

Even though we are performing more changes than strictly necessary, the
fix should be easy to backport.

Fixes: 1b1676180246 ("mm/gup: handle huge pud for follow_pud_mask()")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-19-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: adjusted hunk context for the older pud_write() permission check in place of can_follow_write_pud() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/gup.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index b8367869f7928..5c7ebf897476a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -632,9 +632,6 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
 	if ((flags & FOLL_WRITE) && !pud_write(pud))
 		return NULL;
 
-	if (!pud_present(pud))
-		return NULL;
-
 	pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
 	page = pfn_to_page(pfn);
 
@@ -911,15 +908,17 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 }
 
 static struct page *follow_pmd_mask(struct vm_area_struct *vma,
-				    unsigned long address, pud_t *pudp,
-				    unsigned int flags,
-				    unsigned long *page_mask)
+		unsigned long address, pud_t *pudp, pud_t pud,
+		unsigned int flags, unsigned long *page_mask)
 {
 	pmd_t *pmd, pmdval;
 	spinlock_t *ptl;
 	struct page *page;
 	struct mm_struct *mm = vma->vm_mm;
 
+	if (unlikely(pud_bad(pud)))
+		return no_page_table(vma, flags, address);
+
 	pmd = pmd_offset(pudp, address);
 	pmdval = pmdp_get_lockless(pmd);
 	if (pmd_none(pmdval))
@@ -968,18 +967,23 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 	pud = pudp_get(pudp);
 	if (!pud_present(pud))
 		return no_page_table(vma, flags, address);
-	if (pud_leaf(pud)) {
-		ptl = pud_lock(mm, pudp);
-		page = follow_huge_pud(vma, address, pudp, flags, page_mask);
+	if (!pud_leaf(pud))
+		return follow_pmd_mask(vma, address, pudp, pud, flags, page_mask);
+
+	ptl = pud_lock(mm, pudp);
+	pud = *pudp;
+	if (unlikely(!pud_present(pud))) {
 		spin_unlock(ptl);
-		if (page)
-			return page;
 		return no_page_table(vma, flags, address);
 	}
-	if (unlikely(pud_bad(pud)))
-		return no_page_table(vma, flags, address);
+	if (unlikely(!pud_leaf(pud))) {
+		spin_unlock(ptl);
+		return follow_pmd_mask(vma, address, pudp, pud, flags, page_mask);
+	}
 
-	return follow_pmd_mask(vma, address, pudp, flags, page_mask);
+	page = follow_huge_pud(vma, address, pudp, flags, page_mask);
+	spin_unlock(ptl);
+	return page;
 }
 
 static struct page *follow_p4d_mask(struct vm_area_struct *vma,
-- 
2.53.0

