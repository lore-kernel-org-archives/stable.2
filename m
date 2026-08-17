Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3291E3A9851
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971106; cv=none; b=a16vWsIe3qHSUwFH00OjjN/wXsVjRtiFqi5ZijLlYDMx6kGultzIIL7ChG4rmfhR3l5Jciyj0OtSIv3ZrE6xPqBfpDKqCS4us/sUZH2FzyjmMiu2Vyq9jXY9I7bmrHb3Jk759Ie0eSCANOscQwdh+7rr6KI8qikC+nCO0UBtRl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971106; c=relaxed/simple;
	bh=Kd/usPAbPN9vQI9WICdB3x0pXTZrJv282juSD+NAz5g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ghiey853Ao27VGBJUhhidfkIs3txkCUGdzIasYc3tB4iIoN/EpddJk54JnAGjRZWvUPMExXqKw55TaJY4kBgfIiTKzQa/T3J8/2IA9WlSQeUtGd0/BeBFIn7Ota3Ik+ySYF5lL4kz13dEZouUC3qPkPOE7BFgJGtMqsGgyld9Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=alAvVtvb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="alAvVtvb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5A21F000E9;
	Mon, 17 Aug 2026 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786971104;
	bh=458t7RvDUNAmuNfBDJh3RgvpXhtN44deTnEDaNOlKrI=;
	h=Subject:To:Cc:From:Date;
	b=alAvVtvbgOHdi3Ffv2k+Eb29Lv0oh5GDm/e5xiuv5MyzZ+E6YDN1QmPJDqeABOdwg
	 5ZpnGT6ysGNtXkpNpl5W0kIH1b0k0Udkr0I90FSvUw//NCv901SFgdr7M7RGILJR0D
	 gaIwXiUIJ7huvrzmSSbUWrRLXMzTgfSTZbOyyEpY=
Subject: FAILED: patch "[PATCH] mm/page_table_check: skip special zero mappings" failed to apply to 6.18-stable tree
To: zhilinz@nebusec.ai,akpm@linux-foundation.org,enjou1224z@gmail.com,pasha.tatashin@soleen.com,stable@vger.kernel.org,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:51:41 +0200
Message-ID: <2026081741-service-sandbank-1034@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 8db4bab826ccc9ec10fa41736a48031cd338d392
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081741-service-sandbank-1034@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8db4bab826ccc9ec10fa41736a48031cd338d392 Mon Sep 17 00:00:00 2001
From: Zhiling Zou <zhilinz@nebusec.ai>
Date: Thu, 23 Jul 2026 00:48:13 +0800
Subject: [PATCH] mm/page_table_check: skip special zero mappings

page_table_check_set() and page_table_check_clear() account mappings based
on PageAnon().  Shared zero-page PTEs and huge zero PMDs are special
mappings, but page_table_check can still account them as file-backed
pages.

An unprivileged process can populate enough zero mappings to overflow
file_map_count and hit the existing BUG_ON().  The PTE path can do this
with the shared zero page, and the PMD path can do the same with huge zero
mappings.

Skip special zero mappings in the user page-table accounting paths.  Keep
the PTE-side pte_special() check, and identify huge zero PMDs from the
mapped folio instead of pmd_special().  That covers architectures where
pmd_special() is a no-op without adding huge_zero_pfn checks to the
generic counter helpers.

Link: https://lore.kernel.org/cover.1784717203.git.zhilinz@nebusec.ai
Link: https://lore.kernel.org/e94478e4fb7912fb7e8ebebed5ce85d00dc9a69d.1784717203.git.zhilinz@nebusec.ai
Fixes: df4e817b7108 ("mm: page table check")
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
Reported-by: Vega <vega@nebusec.ai>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Assisted-by: Codex:gpt-5.4
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 53a8997ec043..2403f5a11410 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -151,18 +151,29 @@ void __page_table_check_pte_clear(struct mm_struct *mm, unsigned long addr,
 	if (&init_mm == mm)
 		return;
 
-	if (pte_user_accessible_page(mm, addr, pte))
+	if (pte_user_accessible_page(mm, addr, pte) && !pte_special(pte))
 		page_table_check_clear(pte_pfn(pte), PAGE_SIZE >> PAGE_SHIFT);
 }
 EXPORT_SYMBOL(__page_table_check_pte_clear);
 
+static inline bool page_table_check_huge_zero_pmd(pmd_t pmd)
+{
+	unsigned long pfn = pmd_pfn(pmd);
+
+	if (!pfn_valid(pfn))
+		return false;
+
+	return is_huge_zero_folio(page_folio(pfn_to_page(pfn)));
+}
+
 void __page_table_check_pmd_clear(struct mm_struct *mm, unsigned long addr,
 				  pmd_t pmd)
 {
 	if (&init_mm == mm)
 		return;
 
-	if (pmd_user_accessible_page(mm, addr, pmd))
+	if (pmd_user_accessible_page(mm, addr, pmd) &&
+	    !page_table_check_huge_zero_pmd(pmd))
 		page_table_check_clear(pmd_pfn(pmd), PMD_SIZE >> PAGE_SHIFT);
 }
 EXPORT_SYMBOL(__page_table_check_pmd_clear);
@@ -208,7 +219,7 @@ void __page_table_check_ptes_set(struct mm_struct *mm, unsigned long addr,
 
 	for (i = 0; i < nr; i++)
 		__page_table_check_pte_clear(mm, addr + PAGE_SIZE * i, ptep_get(ptep + i));
-	if (pte_user_accessible_page(mm, addr, pte))
+	if (pte_user_accessible_page(mm, addr, pte) && !pte_special(pte))
 		page_table_check_set(pte_pfn(pte), nr, pte_write(pte));
 }
 EXPORT_SYMBOL(__page_table_check_ptes_set);
@@ -238,7 +249,8 @@ void __page_table_check_pmds_set(struct mm_struct *mm, unsigned long addr,
 
 	for (i = 0; i < nr; i++)
 		__page_table_check_pmd_clear(mm, addr + PMD_SIZE * i, *(pmdp + i));
-	if (pmd_user_accessible_page(mm, addr, pmd))
+	if (pmd_user_accessible_page(mm, addr, pmd) &&
+	    !page_table_check_huge_zero_pmd(pmd))
 		page_table_check_set(pmd_pfn(pmd), stride * nr, pmd_write(pmd));
 }
 EXPORT_SYMBOL(__page_table_check_pmds_set);

