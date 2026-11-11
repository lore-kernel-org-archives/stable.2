Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416218;
	b=ftXkciKdIad80nzFJQujxcCIMDyUR8G1AHjFsYUMBa82tvoeqA84olk4J3qncshovyYS
	 tuplecFWMOASgNmNACYFvnpwlfXAM6xiJGTXbXsrAeFO6jcwF9f+RYwdGgrDtNzKPmvkY
	 ShxuO1opXpLdUZ3jEwU6mRmpzf75YH8wKIPDJDdIELHb8U153EOh6u8GrWLQBwvtb96QK
	 STZdij9biXINtHTBBIKTazrofFJWvY0y+tL2mHb2jSsZpq431LV21luC9/HPAPYVc/uJL
	 vvZ/Th6CBWrt3B9XCEtojhaFmp1OXqFL+zqjt5KP4DzZV6Dt7QbtrTstYSVDItW5AJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416218;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OHydv+J9bn+PJETtK0VtdeUsE2qb91ZNog9LD/G43n4=;
	b=xM2LCj6j+CNYM7v8VDGwzncvzS5KIx7rzPrd076kLBe6S9bZfzHQWS24jCBx4kM8WKTI
	 VZ9FoVaBrrCqzMNBauqq77An1tMa9TvLgswFRaA7hwtc6miaQsUbRwxts9m1kvYLn9Rjz
	 wTVwco2QYDXseuj6QqFf2FxzgOY/5bOdoyfc8zbEcPcMypI2niWjmEifmZj452eieHdYf
	 i+xB3tqqeHsrF6aSwxQBI+Egp5ins7r2ZS8QVWO9zz8z8pD0Y89ofR2NlKn6Iwj3zygdi
	 D1SHUwE6vOJzdXlm2eOR7pHScFMVKPjJk3qsuUFnftZcFHaK+0QOyqHwFBJAxyrvXxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0azdaTr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B2A606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0azdaTr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED5F1F00A05;
	Wed, 11 Nov 2026 16:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416217;
	bh=OHydv+J9bn+PJETtK0VtdeUsE2qb91ZNog9LD/G43n4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e0azdaTrajT6NjVQYB8+46/zNXENUp6ekG3c0VazE7pif5BwoyAsdfzrBkgTjr4es
	 KrZ9KIkxmPL0DsrXFeGGO4OJTbIyjtPF+5iHUEsH5XDnnptX3VxXRCc8I63SE5UYZv
	 8yrUSqXsffu/8SODmvFtCjI7qomSiBXz5+pvH85/TC2zELNRNsZw0OGbsmaae3wrkz
	 UDl1bPnqSXkwnn6bvEMk8HHM72CYGjfNYj0Wj6+lU5xC5XMuhkhPCU5N37+u7n10Gh
	 3bemn1aqnE2YOism4yfUSg0M7yvkI/EjxAnBJtzALW89gHOM9Pb2SCH0lARBTyGCWq
	 kVYHAoOnmHIWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/huge_memory: split huge PUDs when adjusting VMA boundaries
Date: Wed, 11 Nov 2026 11:56:56 -0500
Message-ID: <20261111165619.3336362-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200513-failed-6.18-23e570927421@kernel.org>
References: <20261109200513-failed-6.18-23e570927421@kernel.org>
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

[ Upstream commit 23e570927421d569fdc510d5f3f29542a43eeda5 ]

PFN mappings such as VFIO PCI BAR mappings can use PUD leaves while
allowing VMA splits at page granularity. However, vma_adjust_trans_huge()
only handles PMDs.

After faulting a writable PUD-sized VFIO BAR mapping, changing its first
page to read-only with mprotect() makes the PMD walk treat the PUD leaf
as a PMD table. Applying MADV_DONTFORK to the first PMD-sized chunk leaves
the PUD spanning two VMAs: the PMD-aligned boundary skips splitting.

Walk the page tables once at each adjusted boundary and split a huge
PUD or PMD leaf as needed. Handle PUD leaves even when the boundary is
PMD-aligned.

Fixes: f9e54c3a2f5b7 ("vfio/pci: implement huge_fault support")
Cc: stable@vger.kernel.org
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Link: https://patch.msgid.link/20261031-fixes_core-v3-43-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: Replaced vma_test_any() with a direct vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP) test. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/huge_memory.c | 70 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 78fecc3ad5700..24f5887eb48ee 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3210,16 +3210,66 @@ void split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
 	__split_huge_pmd(vma, pmd, address, freeze);
 }
 
-static inline void split_huge_pmd_if_needed(struct vm_area_struct *vma, unsigned long address)
+static bool pud_split_required(const struct vm_area_struct *vma,
+		unsigned long address)
 {
+	if (!IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD))
+		return false;
+	if (IS_ALIGNED(address, HPAGE_PUD_SIZE))
+		return false;
 	/*
-	 * If the new address isn't hpage aligned and it could previously
-	 * contain an hugepage: check if we need to split an huge pmd.
+	 * Only selected VMAs support mapping PUDs for now. Lift the
+	 * restriction once this changes.
 	 */
-	if (!IS_ALIGNED(address, HPAGE_PMD_SIZE) &&
-	    range_in_vma(vma, ALIGN_DOWN(address, HPAGE_PMD_SIZE),
-			 ALIGN(address, HPAGE_PMD_SIZE)))
-		split_huge_pmd_address(vma, address, false);
+	if (!vma_is_dax(vma) && !(vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP)))
+		return false;
+	return range_in_vma(vma, ALIGN_DOWN(address, HPAGE_PUD_SIZE),
+			    ALIGN(address, HPAGE_PUD_SIZE));
+}
+
+static bool pmd_split_required(const struct vm_area_struct *vma,
+		unsigned long address)
+{
+	if (IS_ALIGNED(address, HPAGE_PMD_SIZE))
+		return false;
+
+	return range_in_vma(vma, ALIGN_DOWN(address, HPAGE_PMD_SIZE),
+			    ALIGN(address, HPAGE_PMD_SIZE));
+}
+
+static void split_huge_leaf(struct vm_area_struct *vma,
+		unsigned long address)
+{
+	const bool split_pud = pud_split_required(vma, address);
+	const bool split_pmd = pmd_split_required(vma, address);
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	/*
+	 * mmap, VMA and rmap write locks protect the walk; the split helpers
+	 * take the page table locks.
+	 */
+	if (!split_pud && !split_pmd)
+		return;
+
+	pgd = pgd_offset(vma->vm_mm, address);
+	if (!pgd_present(*pgd))
+		return;
+
+	p4d = p4d_offset(pgd, address);
+	if (!p4d_present(*p4d))
+		return;
+
+	pud = pud_offset(p4d, address);
+	if (pud_leaf(*pud))
+		__split_huge_pud(vma, pud, address);
+	if (!split_pmd || !pud_present(*pud))
+		return;
+
+	pmd = pmd_offset(pud, address);
+	__split_huge_pmd(vma, pmd, address, false);
 }
 
 void vma_adjust_trans_huge(struct vm_area_struct *vma,
@@ -3228,14 +3278,14 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
 			   struct vm_area_struct *next)
 {
 	/* Check if we need to split start first. */
-	split_huge_pmd_if_needed(vma, start);
+	split_huge_leaf(vma, start);
 
 	/* Check if we need to split end next. */
-	split_huge_pmd_if_needed(vma, end);
+	split_huge_leaf(vma, end);
 
 	/* If we're incrementing next->vm_start, we might need to split it. */
 	if (next)
-		split_huge_pmd_if_needed(next, end);
+		split_huge_leaf(next, end);
 }
 
 static void unmap_folio(struct folio *folio)
-- 
2.53.0

