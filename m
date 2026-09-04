Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E08D4EC661
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535666; cv=none; b=YqC/8B3FExWmWlGKmkECqEIeO0SKph0Yk03xzDZTgNlLA2CsqzrjpIFn1M6OZqHuWGbr/sv8f1MtXlQAebl4nhoJiNXmg3f0cd6XF7P7mHkzM1EeKDHefaTJX664fBQygGT6wBK30Tx2nyB/Q87vEWw4Fo4YC8OothLoHv8tg8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535666; c=relaxed/simple;
	bh=r63x9uwcuxKv6DuL83TJou9eLdpPEJUc+JB6yfN94Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHIWeG2pbAKVyehKCfsbIfFCepn5HTgOOgTNxeeHy2e0mLLd2GEz4fuX2qh/3L3MFun3TDU8LPUEElUW1Jd00VtPlUW5KvH+EYaRL6aEdozJk47RmDOjRMGxqwUTwCG7HXX9CmhyPccbxeSO3QZkkgYLBgcB2iyhjCNkdoD8x5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uvpe+G6g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uvpe+G6g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04921F00A3E;
	Fri,  4 Sep 2026 15:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788535665;
	bh=t5BNBaJkuitOwp3rCYvbe0HqCD0vr+b5MYbnn/IsArc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uvpe+G6gYFuNb9ZQ8TAgHf0ERVHvV723jDMlZ0KkW355S9UECJ+4LxmxMBlZeSE3q
	 gh0HF+OFnEYe7kdc2m+dUjlTak2hParfWWPMrsvZtSFY6hmdQvYSXinHawqAgdSJlj
	 LA9jznKYWhL/2s16CcikbyLL3zmLnGNeCxSHCZzRMl0VcFLDJFzCMHYaLvEOnlLUAa
	 N+B0Z8sCxdTQbZ0+bsr9AFtujeJ/O7BUcGFvXrsp4oEUTjRuNA5QtAFTm3Uof4Ivgt
	 2SEvTzXHbAnDPIqYCKKNOBgoJStK4hI0dwjSJXA/zVyjFE14tqShiQuw0UAreXLUmx
	 Euf6r/vDWYJlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/5] fs/proc/task_mmu: convert smaps_hugetlb_range() to work on folios
Date: Fri,  4 Sep 2026 11:27:39 -0400
Message-ID: <20260904152741.898549-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904152741.898549-1-sashal@kernel.org>
References: <2026090326-freestyle-gratify-7686@gregkh>
 <20260904152741.898549-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 6401a2e6900843a77a27873c0529dea68f61193d ]

Let's get rid of another page_mapcount() check and simply use
folio_likely_mapped_shared(), which is precise for hugetlb folios.

While at it, use huge_ptep_get() + pte_page() instead of ptep_get() +
vm_normal_page(), just like we do in pagemap_hugetlb_range().

No functional change intended.

Link: https://lkml.kernel.org/r/20240417092313.753919-3-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

On this stable tree, use folio_estimated_sharers() and wrap
pfn_swap_entry_to_page() with page_folio().  These are the equivalent APIs
available before folio_likely_mapped_shared() and pfn_swap_entry_folio() were
introduced.

Stable-dep-of: e87df0d5d696 ("mm/page_vma_mapped: use huge_ptep_get() for hugetlb")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/task_mmu.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 484886cdd272c..39ce3cf7d5add 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -726,18 +726,20 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 {
 	struct mem_size_stats *mss = walk->private;
 	struct vm_area_struct *vma = walk->vma;
-	struct page *page = NULL;
+	pte_t ptent = huge_ptep_get(pte);
+	struct folio *folio = NULL;
 
-	if (pte_present(*pte)) {
-		page = vm_normal_page(vma, addr, *pte);
-	} else if (is_swap_pte(*pte)) {
-		swp_entry_t swpent = pte_to_swp_entry(*pte);
+	if (pte_present(ptent)) {
+		folio = page_folio(pte_page(ptent));
+	} else if (is_swap_pte(ptent)) {
+		swp_entry_t swpent = pte_to_swp_entry(ptent);
 
 		if (is_pfn_swap_entry(swpent))
-			page = pfn_swap_entry_to_page(swpent);
+			folio = page_folio(pfn_swap_entry_to_page(swpent));
 	}
-	if (page) {
-		if (page_mapcount(page) >= 2 || hugetlb_pmd_shared(pte))
+	if (folio) {
+		if (folio_estimated_sharers(folio) >= 2 ||
+		    hugetlb_pmd_shared(pte))
 			mss->shared_hugetlb += huge_page_size(hstate_vma(vma));
 		else
 			mss->private_hugetlb += huge_page_size(hstate_vma(vma));
-- 
2.53.0

