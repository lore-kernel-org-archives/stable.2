Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C9844E673
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546277; cv=none; b=UWSY9Xqx1t//I9N8a9pcTPrn+b0pWFgk2woRNX5UJG34BCNwKXXTUrovL9oZCDUDPQxeUcT3AsEjmQNakBVMZfE6xtQlGWlw/C8xb9yxoL+dPi3rgHpn9hliAXn384/Ja01tFwtKoWnyylKz7S0WWmpZqQU6WSaD991G//t1iAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546277; c=relaxed/simple;
	bh=pDhsU75hhRzVPiaUjapE7C1HLkGJfTwgI+AMKFaUmSI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GH03P6qsg0z7Mhf3ZiSuDgjPkuIVZgWSJim7THe4REiQ0v1W0oM8uBVPZUo68KGueBKE3nQjojlB7RFDIcCwk+WK/WO7p1ol54621RKvRoAzU7v+iZtmhNUTAmsecCROpexnCC8z4QS5mltIP4HlSStB/MvbgyZWue2S5Fe+6lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W2zOicL9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W2zOicL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BE41F00893;
	Wed, 16 Sep 2026 08:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789546266;
	bh=7z2jQf4izFOfFuVRydMv8dS0Al/Rf6OshasVgFsf1B8=;
	h=Subject:To:Cc:From:Date;
	b=W2zOicL9kJOJN8Lg79dgUFIlpOKubQw3TKW8F8FfmPwk7ythKmTmIoh1DfMrt2pLV
	 nj09WyJvyEZ+uoPMnEHx8nYekkNOv8p6TJh4aFCklsq6QaoLYZBDH2JbmlcxJDHwvY
	 UK4Wchov9C9OoGrKdsQMRXhyzeupWGqBASv+jnaE=
Subject: FAILED: patch "[PATCH] x86/mm/pat: Allocate split page tables as kernel page tables" failed to apply to 6.18-stable tree
To: ljs@kernel.org,atishp@meta.com,dave.hansen@linux.intel.com,mingo@kernel.org,nikunj@amd.com,rppt@kernel.org,vishal.moola@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 09:09:05 +0100
Message-ID: <2026091605-rehire-self-1650@gregkh>
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
git cherry-pick -x 9e4a3ec3411bb6bb59e3c1f29b75609f1e87aac4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091605-rehire-self-1650@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9e4a3ec3411bb6bb59e3c1f29b75609f1e87aac4 Mon Sep 17 00:00:00 2001
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 13 Aug 2026 12:01:27 +0300
Subject: [PATCH] x86/mm/pat: Allocate split page tables as kernel page tables

A PTE is allocated directly without going through the standard page table
allocation routines (such as pte_alloc_one_kernel()) when the CPA code
splits a large page (__split_large_page()).

This means the page table constructor is never called nor is the page table
marked as a kernel page table.

The former results in the folio associated with the page table not being
marked as a page table (__pagetable_ctor() is never called thus neither is
__folio_set_pgtable()) nor are statistics updated to reflect
it (lruvec_stat_add_folio() is never called).

The latter issue of failing to mark the page table as a kernel page
table (ptdesc_set_kernel() is never called) is far more problematic.

Since commit:

  5ba2f0a15564 ("mm: introduce deferred freeing for kernel page tables")

kernel page table freeing has been batched and since the
subsequent commit:

  e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries for kernel address space")

IOTLB cache entries for kernel page tables have been invalidated upon
being freed.

Since split page tables are freed without this invalidation, the IOTLB
can contain stale entries for them.

Resolve the issue by using the ordinary PTE allocation API at split time.

This results in these kernel page tables invoking a page table constructor,
and thus requires a page table destructor.

Destructors are not always present, like for early allocated direct map
page tables). Conditionally call pagetable_dtor_free() if the PG_table
folio flag for the ptdesc is set, otherwise we free the page table via
pagetable_free().

Regardless of which path is taken page tables marked as kernel page tables,
which now includes split page tables, take the correct route through
pagetable_free_kernel().

There is a user-visible side effect in that split page tables will appear
in nr_page_table_pages in /proc/vmstat (as do other kernel page tables
allocated after early boot), however this is a positive change.

This issue started being markedly problematic after commit:

  5ba2f0a15564 ("mm: introduce deferred freeing for kernel page tables")

so choose this as the Fixes target.

[ dhansen: rephrase in imperative mood ]

Fixes: 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page tables")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Vishal Moola <vishal.moola@gmail.com>
Tested-by: Atish Patra <atishp@meta.com>
Tested-by: Nikunj A Dadhania <nikunj@amd.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260813-cpa-fixes-v2-4-39b4ff90f91d@kernel.org

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index cb5d6d6f71a4..4652487b5572 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -441,7 +441,15 @@ static void __cpa_collapse_large_pages(struct cpa_data *cpa)
 
 	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
 		list_del(&ptdesc->pt_list);
-		pagetable_free(ptdesc);
+		/*
+		 * Only early alloc'd direct map should not be flagged PG_table
+		 * here and those shouldn't be collapsed. However be abundantly
+		 * cautious and handle the !PG_table case too.
+		 */
+		if (PageTable((ptdesc_page(ptdesc))))
+			pagetable_dtor_free(ptdesc);
+		else
+			pagetable_free(ptdesc);
 	}
 }
 
@@ -1134,11 +1142,10 @@ static void split_set_pte(struct cpa_data *cpa, pte_t *pte, unsigned long pfn,
 
 static int
 __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
-		   struct ptdesc *ptdesc)
+		   pte_t *pbase)
 {
 	unsigned long lpaddr, lpinc, ref_pfn, pfn, pfninc = 1;
-	struct page *base = ptdesc_page(ptdesc);
-	pte_t *pbase = (pte_t *)page_address(base);
+	struct page *base = virt_to_page(pbase);
 	unsigned int i, level;
 	pgprot_t ref_prot;
 	bool nx, rw;
@@ -1238,20 +1245,20 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
 			    unsigned long address)
 {
-	struct ptdesc *ptdesc;
+	pte_t *pte;
 
 	spin_unlock(&cpa_lock);
 	if (cpa->init_mm_read_locked)
 		mmap_read_unlock(&init_mm);
-	ptdesc = pagetable_alloc(GFP_KERNEL, 0);
+	pte = pte_alloc_one_kernel(&init_mm);
 	if (cpa->init_mm_read_locked)
 		mmap_read_lock(&init_mm);
 	spin_lock(&cpa_lock);
-	if (!ptdesc)
+	if (!pte)
 		return -ENOMEM;
 
-	if (__split_large_page(cpa, kpte, address, ptdesc))
-		pagetable_free(ptdesc);
+	if (__split_large_page(cpa, kpte, address, pte))
+		pte_free_kernel(&init_mm, pte);
 
 	return 0;
 }

