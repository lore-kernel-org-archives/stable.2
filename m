Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032A568FC7
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790711267; cv=none; b=IokK43xj0feL6jzPMMcatJRV7hCu8HN1V1J61j2hA+1C1WEor+lkyB51x/F46uz+z3x4BGjKgOsxN4N25DyQg8T/pQrfkvC9T27BZlFx5bgAx+cKE4717Stca+VdUsd2IVk6ItENMz+3LqCOu0gEoQOdoezBXjSBUCZ/pIF6TNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790711267; c=relaxed/simple;
	bh=1rCT3f64h3ePQ13TLHc+ciqo6ZLfaDRQF95bDkJ1UJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFAXZivUovV0ksJT246579SEjiAY1F9WCMBZsxevDUVIYSrcGmw9+dP5c/Vp4A7stKkuh4CcJrV1jeCVX7tLCEWZm6UNQ4kC7h9y55H/gEh33vf0OPez6Ev7vCxOQTsbsslDEbI7nvIzpVhVD1DpnUKLXeHPC2woi0iPncjMQMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRkKGsCY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRkKGsCY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C7D1F00893;
	Tue, 29 Sep 2026 19:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790711266;
	bh=tO4jP0sLJJHPHrBABAHG5A90U9Kwqwy+lADBdqLlvKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JRkKGsCYZ1fA1S4EOLluiYwNB8V6KFK1OzYXiS7BqQotWiV3pteaw8scP5YdX3jpy
	 fOVgbUJZ6TW1Wnur7jx1ywYkXmqLFKxMsa0/CGy6zMOgoPjAtAx2FpPihB6uuz5kRZ
	 AgC7JwNHq4p5VEcfTl6trms6ssZx3U5E1wZRtETm22Wu9G96CAVuzeEy5Hct+J6TcB
	 XeyRRhNcZ9lGIXCzBoxhP7zk8sbjOkCk6yqBg0JpTA5Lq/bfOV0kwojDfwb8CbNLUV
	 KNA5krPDfbg8MIGp9fzKItq22W9I4aoqTv8vbm2KQWi7iJDsj9krMBV3f0ZYHJAiCo
	 aOvLuDqivghyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] mm/damon/vaddr: avoid hw-driven pte updates during damon_hugetlb_mkold()
Date: Tue, 29 Sep 2026 15:47:42 -0400
Message-ID: <20260929194742.835805-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929194742.835805-1-sashal@kernel.org>
References: <2026092931-carat-unheard-5a1d@gregkh>
 <20260929194742.835805-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SJ Park <sj@kernel.org>

[ Upstream commit 39c0ceedd54557bdc1542de08d22b2ed33e534e4 ]

damon_hugetlb_mkold() reads the page table entry into a local variable,
unsets the accessed bit in the variable, and updates the page table entry
with the updated variable value.  If hardware updates the same page table
entry in parallel, the hw updates could be lost.  For example,
hardware-updated dirty bits might be lost.

Avoid the parallel updates by clearing the page table entry when reading
it together, using huge_ptep_get_and_clear().  If a parallel write to the
memory is made after the clearing, the hw will see the page table entry is
cleared, trigger page fault and wait until it is handled.  The page fault
handling will wait for damon_hugetlb_mkold() due to the page table lock.

Because hugetlbfs is an in-memory file system and hugetlb pages cannot be
reclaimed, no critical issue is expected to my best knowledge.  But
definitely this is a nasty bug that should be fixed sooner rather than
later.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260907170358.100168-1-sj@kernel.org
Link: https://lore.kernel.org/20260830160545.98969-1-sj@kernel.org [1]
Fixes: 49f4203aae06 ("mm/damon: add access checking for hugetlb pages")
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: <stable@vger.kernel.org> # 5.17.x
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/vaddr.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 59d3a634aa412..ca4fc845c9fb7 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -332,22 +332,29 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
+static bool damon_hugetlb_ptep_mkold(pte_t *pte, struct mm_struct *mm,
+		struct vm_area_struct *vma, unsigned long addr, pte_t *entry)
+{
+	unsigned long psize = huge_page_size(hstate_vma(vma));
+
+	if (!pte_young(*entry))
+		return false;
+	*entry = huge_ptep_get_and_clear(mm, addr, pte, psize);
+	*entry = pte_mkold(*entry);
+	set_huge_pte_at(mm, addr, pte, *entry, psize);
+	return true;
+}
+
 static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
 				struct vm_area_struct *vma, unsigned long addr)
 {
 	bool referenced = false;
 	pte_t entry = huge_ptep_get(mm, addr, pte);
 	struct folio *folio = pfn_folio(pte_pfn(entry));
-	unsigned long psize = huge_page_size(hstate_vma(vma));
 
 	folio_get(folio);
 
-	if (pte_young(entry)) {
-		referenced = true;
-		entry = pte_mkold(entry);
-		set_huge_pte_at(mm, addr, pte, entry, psize);
-	}
-
+	referenced = damon_hugetlb_ptep_mkold(pte, mm, vma, addr, &entry);
 	if (mmu_notifier_clear_young(mm, addr,
 				     addr + huge_page_size(hstate_vma(vma))))
 		referenced = true;
-- 
2.53.0

