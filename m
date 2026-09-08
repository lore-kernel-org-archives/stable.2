Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8E3483814;
	Tue,  8 Sep 2026 22:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907919; cv=none; b=I1W4CZk7UJKOK2EtV+HFUsN6XRSedr124Z4DNlWQbqLSIMnbm5KyrysCyKb+fYhAaiRVZb+lAYzb37oPxbv/xmg3LiM9QFYGItp47llMoA9jaPjCUU//28d1mnsj2GPCy+NjWsak1JwlnIDaTYkFF5RVvgtWsF1wQI4U+jTMmrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907919; c=relaxed/simple;
	bh=THVJZ1G3xIE2bjbjeSF816JaqRoBwl80ZAdjPxEEIlo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XevEWI9Tu4FO7SjH2Mq7yb+2AzOjHl6xrH4PHnkJO1GoY5dD+iN9ib3+37uTzJmGSHWKd/kqCU/d2zB59z67bypiybDD29HQN2jYdWWaW9j0Yx8n6f8nMS7HG9jGBL+XVtA2l1u3pNKlFQoap9Myu+90RrJIYfZzxjSpgBbKYjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b/aOoFCz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bF086CHc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b/aOoFCz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bF086CHc"
Date: Tue, 08 Sep 2026 22:51:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788907915;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ral7bu6k93GxtLW+V97pRlYMQe7Iols7ySfAp1woDuA=;
	b=b/aOoFCzxBZmTj2jG1dYyA6Yshf68uT7X/zUI/Jpec77fUByciQDeXjFnIdyMmzkUIponH
	286OG2yJnozW+D1oKrEle0jGgayKadcDP0ipInH2+zludd42Gps1Pzn+kXXtWU7YvrkUQx
	eClXhAbCX3RWQqSaZPQCwWgnRLb6RSFGdER3Hq4PzAL+P8Vx9HzLC0BqgjOaHXB++O7meE
	A6+zlYjnMTOORR2KBSQHdBsFwWnaCGUtOAoBJbUSoqaH5nNo65+VGAAzRq/1S0mKmnEWaJ
	/L7O0OxPrV4xJa+jay4pRDAZ7jUF2rzLkq2UV5wbeDbx5Y5KTbfg+Jf9cp4EaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788907915;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ral7bu6k93GxtLW+V97pRlYMQe7Iols7ySfAp1woDuA=;
	b=bF086CHcqcy94yyYpd+8YwxXZ7QIBwQfybClSOPcdMYf69Kd0zPYI2z41cKHPPYnpi3bKi
	3DGGkrmxdKbm0oBA==
From: "tip-bot2 for Lorenzo Stoakes (ARM)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm/pat: Allocate split page tables as kernel
 page tables
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 Vishal Moola <vishal.moola@gmail.com>, Atish Patra <atishp@meta.com>,
 Nikunj A Dadhania <nikunj@amd.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260813-cpa-fixes-v2-4-39b4ff90f91d@kernel.org>
References: <20260813-cpa-fixes-v2-4-39b4ff90f91d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178890791396.623050.5111923910852372050.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     fa138406b1cb4e72170a5dfc011cbc76bf4795f7
Gitweb:        https://git.kernel.org/tip/fa138406b1cb4e72170a5dfc011cbc76bf4=
795f7
Author:        Lorenzo Stoakes (ARM) <ljs@kernel.org>
AuthorDate:    Thu, 13 Aug 2026 12:01:27 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 08 Sep 2026 15:43:07 -07:00

x86/mm/pat: Allocate split page tables as kernel page tables

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

  e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries for kernel address=
 space")

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
---
 arch/x86/mm/pat/set_memory.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index cb5d6d6..4652487 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -441,7 +441,15 @@ static void __cpa_collapse_large_pages(struct cpa_data *=
cpa)
=20
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
=20
@@ -1134,11 +1142,10 @@ set:
=20
 static int
 __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
-		   struct ptdesc *ptdesc)
+		   pte_t *pbase)
 {
 	unsigned long lpaddr, lpinc, ref_pfn, pfn, pfninc =3D 1;
-	struct page *base =3D ptdesc_page(ptdesc);
-	pte_t *pbase =3D (pte_t *)page_address(base);
+	struct page *base =3D virt_to_page(pbase);
 	unsigned int i, level;
 	pgprot_t ref_prot;
 	bool nx, rw;
@@ -1238,20 +1245,20 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte,=
 unsigned long address,
 static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
 			    unsigned long address)
 {
-	struct ptdesc *ptdesc;
+	pte_t *pte;
=20
 	spin_unlock(&cpa_lock);
 	if (cpa->init_mm_read_locked)
 		mmap_read_unlock(&init_mm);
-	ptdesc =3D pagetable_alloc(GFP_KERNEL, 0);
+	pte =3D pte_alloc_one_kernel(&init_mm);
 	if (cpa->init_mm_read_locked)
 		mmap_read_lock(&init_mm);
 	spin_lock(&cpa_lock);
-	if (!ptdesc)
+	if (!pte)
 		return -ENOMEM;
=20
-	if (__split_large_page(cpa, kpte, address, ptdesc))
-		pagetable_free(ptdesc);
+	if (__split_large_page(cpa, kpte, address, pte))
+		pte_free_kernel(&init_mm, pte);
=20
 	return 0;
 }
