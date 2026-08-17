Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029803A9851
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971120; cv=none; b=uTZMCtYGdt9n2+EnAMIs4nRMuFwTbuw8OTbyOw0NbUlVoc6szGtUl7VZJK7qFawrxeRO9FA4IXeGgQ0FDEFf4u3x8AdCarlHBJvKuDwY4Hz9HfDlpzICbJe0UmY/dkBVeMR/2YgTB8YJs8kPRtmboZ3djJPMKAwyZPwMW3Taxe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971120; c=relaxed/simple;
	bh=TNvInGjJUo2xXo9CqLLugzTCO27tJO5xWy7qu0WtA4c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=k3I/AIhL3/9BaiFa9sRZWEF4vupy5ch74EDIIoVjqjmjwn2m/FK/f0iZh3Kg/6QLtcgGS68JDTSMX6VkCpCperJxaK8HNJb+WxS/7J5ElQ2nKbHDUizXQgAEJULUXvG5GBQzaC4MNPNM+msmvcFm7seZmkDAGjJHjxxUdh0Llt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uc086Wlw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uc086Wlw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA7C1F000E9;
	Mon, 17 Aug 2026 12:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786971118;
	bh=Z6qJjfzZma1kNGuQ7YcOx//1fs3TKlY4i5c9k1wXOqU=;
	h=Subject:To:Cc:From:Date;
	b=Uc086WlwnjdF2BHGGkf3h6W3Ml3KeSk2vRGRaHAdjEPcgicO45q4OnN3+4V/m0kga
	 sC910zkEzDhxHEsonZYzpXQEldqaTJ41p6Dykiw9HBReuAeneScUKZVuvQHzeMhkej
	 BYillXSQdQglfxA1KGYYukJEUanPVEjUt8BRcz0g=
Subject: FAILED: patch "[PATCH] mm/page_table_check: skip special zero mappings" failed to apply to 6.12-stable tree
To: zhilinz@nebusec.ai,akpm@linux-foundation.org,enjou1224z@gmail.com,pasha.tatashin@soleen.com,stable@vger.kernel.org,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:51:42 +0200
Message-ID: <2026081742-asleep-antsy-cddd@gregkh>
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
git cherry-pick -x 8db4bab826ccc9ec10fa41736a48031cd338d392
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081742-asleep-antsy-cddd@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

