Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D41399D0D;
	Tue,  8 Sep 2026 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852104; cv=none; b=tcjLnx8QHDeL69ogCfBAeyAd3ankrNKtCu/+buwwEnjolC/vMy16PfLuirDJihvu9ZwHfC/dXSHI2Uc/fBPW8LapehOwLIp4UARIlshi4dEM9rXnwqPjDnDnBFB62Pr8OElNSLi0UbiRNWYuj3NRMYnGu9GCEfAgSC3cMmHvqEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852104; c=relaxed/simple;
	bh=XNpqscKm4aVAIr5oIWssDqDND6Kn1e3Mat8tZqIY5C0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=glaxOX+aP91DlLSp/Vx1rdnlACCnwofsCM6nbqcoz9yx3WT9b9lB77h2u6jdudFt/ifqR1MYar9ju0PeZomvsG7wR0CUtvTYCyARVqvQgHF/lNqqyBLw7rN7u7vsznD8TiX32qIVeAieS6L3hN2CesVK+2Q2Xy+NaLnzrkk/6FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YB6XISvN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=58Ehw2/j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YB6XISvN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="58Ehw2/j"
Date: Tue, 08 Sep 2026 07:21:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788852100;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJCUvxg4QFGESMfYDFCHHEtoyd8ZJ2vJUNa8o3Zfr0U=;
	b=YB6XISvN7NpbCB+otZH09W2X+LDcZqtW8S79AFVqTgWcx/VQR9hQlM3Wj3zKUoOAWYs7uY
	vIecTwlSMr+2PMmbuVrEmCTYEwwZKNIgK4Yc2qDGuaWa8G3fHdIQfsVe0bqv2mNbjXaVyX
	YH5PV+9SKPV9sEYO8CmlwCLy137OXwNkIWtJEfIpH+ID6tLPcfz1nj2NtHFsi86T7Y55pL
	Z8EneVDE0sgrCujBOUL9ah+PcT1ayssT0/s0x0VxU74E1GsbZfRCRW+1W4MD0sdmhu0vGC
	UOZLJsDVLO/swSJPLyhY8vTjK1x2XtHZKx9s/E0o12nOM89K57lJ4On8JERDMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788852100;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJCUvxg4QFGESMfYDFCHHEtoyd8ZJ2vJUNa8o3Zfr0U=;
	b=58Ehw2/jjXchtVG6a5G5fogez7pVSjFO6ebub65a5VmjA9dFcSYxKbe2YygqOigwxNH0e2
	T4nCIqa1nFS7MNAA==
From: "tip-bot2 for Lorenzo Stoakes (ARM)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/mm] x86/mm/pat: Allocate split page tables as kernel page tables
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
Message-ID: <178885209922.623050.14096720380707882252.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     394562a5546aaaeabef6baef5715adf59b71a7c4
Gitweb:        https://git.kernel.org/tip/394562a5546aaaeabef6baef5715adf59b7=
1a7c4
Author:        Lorenzo Stoakes (ARM) <ljs@kernel.org>
AuthorDate:    Thu, 13 Aug 2026 12:01:27 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 08 Sep 2026 09:12:55 +02:00

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
