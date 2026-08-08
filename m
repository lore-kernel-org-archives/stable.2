Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E13D30C159
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 02:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786157554; cv=none; b=hv3zdOsFh3QrkTcooNzpQCMy8jjb/4MOLkxo45qPiDmkSH9afEM370sq3XhrOUDpDGACducQQYxxwtYSM7u5u0VkfoZu8vSl+5SS/bBJXdV1Z8ZH+V4TJigr37zCA8kXSDKpEIet/genNSJUaTOuEcJGyhiAG0CHMLl/5W3986Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786157554; c=relaxed/simple;
	bh=A9/5tXbh616nGIZuaxlY4eHF6mxPI/9wBDVM+fbRJr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEYYUaFqAbIagQ5R4mRE9SuWMGsaphrJfItzEHheto3WdLs9e44gwaIOq5+zmhvWyJbKE0YMUbMVeH/6JWaw7mhUq4+LcLd68QbW+E06Huh60dDoC66MZOuwF27NbWHgu3B6ON6PF9lJOWnoaq2IdLC4g/XV2v99snLZ0r6dHw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeqx+RZH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeqx+RZH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B8E1F000E9;
	Sat,  8 Aug 2026 02:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786157552;
	bh=XuIDCWRnkVPlZaadUjVCr9ZUnXCs015l0TufqDUi6ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oeqx+RZHiWAkBh0EkXhgRqv6aNfBpRHjThBf28HjnVYL1+jYpPHJbsyR09Aan1ZjX
	 TFkr7PgQ9s+2AIVV7UUuhdwN4tuciTP2tW/wazWUIEdeAVWhG2WupLE+IBsHMIKv7k
	 OCObShUBHozcpXiok4KypnQy3RlkwN+tErMjiE5zGFuQtUuy7fnCETlpD3fwCWyuUY
	 KeudLp67FUIGIOdILZrsE5PSFaWK3LOY1fRmjWovNLjjbulJvtqvauhEILQ4R2QEkc
	 t4XygIAsWqbPaZGlFXYzWMguHeadFsZi4AlOt+z5djUZLD4/IRn5b40EyvQiMIJKfL
	 IranND19r5tvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lance Yang <lance.yang@linux.dev>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Dev Jain <dev.jain@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] mm/khugepaged: guard is_zero_pfn() calls with pte_present()
Date: Fri,  7 Aug 2026 22:52:29 -0400
Message-ID: <20260808025230.4028587-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072906-scheming-vocation-25cd@gregkh>
References: <2026072906-scheming-vocation-25cd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

[ Upstream commit 074f027d15c10cb376b3ad88405b8e512fa5b3a8 ]

A non-present entry, like a swap PTE, contains completely different data
(swap type and offset).  pte_pfn() doesn't know this, so if we feed it a
non-present entry, it will spit out a junk PFN.

What if that junk PFN happens to match the zeropage's PFN by sheer chance?
While really unlikely, this would be really bad if it did.

So, let's fix this potential bug by ensuring all calls to is_zero_pfn() in
khugepaged.c are properly guarded by a pte_present() check.

Link: https://lkml.kernel.org/r/20251020151111.53561-1-lance.yang@linux.dev
Signed-off-by: Lance Yang <lance.yang@linux.dev>
Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Nico Pache <npache@redhat.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 3c58f641e813 ("userfaultfd: prevent registration of special VMAs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/khugepaged.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 95b49ca6b196c..a6b2c7d7d73b6 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -346,6 +346,13 @@ struct attribute_group khugepaged_attr_group = {
 };
 #endif /* CONFIG_SYSFS */
 
+static bool pte_none_or_zero(pte_t pte)
+{
+	if (pte_none(pte))
+		return true;
+	return pte_present(pte) && is_zero_pfn(pte_pfn(pte));
+}
+
 int hugepage_madvise(struct vm_area_struct *vma,
 		     unsigned long *vm_flags, int advice)
 {
@@ -529,6 +536,7 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
 
 		if (pte_none(pteval))
 			continue;
+		VM_WARN_ON_ONCE(!pte_present(pteval));
 		pfn = pte_pfn(pteval);
 		if (is_zero_pfn(pfn))
 			continue;
@@ -572,8 +580,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
 	     _pte++, address += PAGE_SIZE) {
 		pte_t pteval = ptep_get(_pte);
-		if (pte_none(pteval) || (pte_present(pteval) &&
-				is_zero_pfn(pte_pfn(pteval)))) {
+		if (pte_none_or_zero(pteval)) {
 			++none_or_zero;
 			if (!userfaultfd_armed(vma) &&
 			    (!cc->is_khugepaged ||
@@ -716,17 +723,17 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
 	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
 	     _pte++, address += PAGE_SIZE) {
 		pteval = ptep_get(_pte);
-		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
+		if (pte_none_or_zero(pteval)) {
 			add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
-			if (is_zero_pfn(pte_pfn(pteval))) {
-				/*
-				 * ptl mostly unnecessary.
-				 */
-				spin_lock(ptl);
-				ptep_clear(vma->vm_mm, address, _pte);
-				spin_unlock(ptl);
-				ksm_might_unmap_zero_page(vma->vm_mm, pteval);
-			}
+			if (pte_none(pteval))
+				continue;
+			/*
+			 * ptl mostly unnecessary.
+			 */
+			spin_lock(ptl);
+			ptep_clear(vma->vm_mm, address, _pte);
+			spin_unlock(ptl);
+			ksm_might_unmap_zero_page(vma->vm_mm, pteval);
 		} else {
 			struct page *src_page = pte_page(pteval);
 
@@ -812,7 +819,7 @@ static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
 		unsigned long src_addr = address + i * PAGE_SIZE;
 		struct page *src_page;
 
-		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
+		if (pte_none_or_zero(pteval)) {
 			clear_user_highpage(page, src_addr);
 			continue;
 		}
@@ -1305,7 +1312,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 				goto out_unmap;
 			}
 		}
-		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
+		if (pte_none_or_zero(pteval)) {
 			++none_or_zero;
 			if (!userfaultfd_armed(vma) &&
 			    (!cc->is_khugepaged ||
-- 
2.53.0

