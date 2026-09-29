Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDE83ACEFF
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670463; cv=none; b=iSQ1UBF47nuvDyGBS9/Tp+xqsMm44zjSV1IdOPUpqNwhn3jX1ZpyWvyDuBBHB28H0B5g3j/yKzD14c2YO+Iz2IbrB9E/+msQ7lTurMD/Y4lgrQ+yXg63lvJLF/jIM9XQkPiCRfFuY6AWPJURzrt2SBLmwcqTyy0vhvUaxPkaYgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670463; c=relaxed/simple;
	bh=/mIAZqGjRqvtV2Ts5QgBIwE55nwuJXYqkyfyunsEQIw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KZvvJoWbBeSjrbqKCfYa0+4q+1xJM3Esw6X1w5cHoBM5Owhp055IbxTAGDP86E25RUYYKvEr6+y/3XTDa+8QRNc4KUWlzCEb2qo+z6D8+42qoO6m9LoovlU1HmRh9CEK603/pYbsACoRw7/eFWPZcVKl8mjaMNSAntbvkQGdb04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ytO81b/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ytO81b/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229C51F000FF;
	Tue, 29 Sep 2026 08:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790670461;
	bh=UhHKNO4QasqsriwYANe6haiWi3oC1dbcKTnhxxaghM8=;
	h=Subject:To:Cc:From:Date;
	b=ytO81b/bts/WnfY1XwWFcFTRppyBtfNmUsNDsDA9e+GoDJn9DLXoC9Nc3OkukkuzF
	 Tq+IRpa2rpCAIV6XW7X5+fUQHPOAa/Qrnx2jRQJs6IOc7GNeYKIOvL4zguzjJfx2Rs
	 OgbOF1feoCmFtWbfF5rcB7jh+BAL6Y3V7gISIlFU=
Subject: FAILED: patch "[PATCH] mm/damon/vaddr: avoid hw-driven pte updates during" failed to apply to 6.1-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,baolin.wang@linux.alibaba.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:27:31 +0200
Message-ID: <2026092931-carat-unheard-5a1d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 39c0ceedd54557bdc1542de08d22b2ed33e534e4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092931-carat-unheard-5a1d@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 39c0ceedd54557bdc1542de08d22b2ed33e534e4 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Mon, 7 Sep 2026 10:03:56 -0700
Subject: [PATCH] mm/damon/vaddr: avoid hw-driven pte updates during
 damon_hugetlb_mkold()

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

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 0648400b2d65..04ee2a2c6a4d 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -293,22 +293,29 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
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

