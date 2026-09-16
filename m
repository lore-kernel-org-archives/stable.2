Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91404509F02
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567805; cv=none; b=el86LFil/qc4pM2juCcXRHyHIU98MXdfAT3+mb+kqd7nQklXGv+Mo8yqbIiyBtrZ7P3JJiNZVUtdLVg7qcy4pRYcYPZqiCj6YcyYeaBR0VFyV3LmYqaNF8lgB6nLKRaiuCeXtw/eMN5u5zcpOIiOicT2jiFjRmczFZUGVuzFy50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567805; c=relaxed/simple;
	bh=0t3b0Ja3rumJVPEXwuIU3yfwAfHLdGVN+MyI4ke0aCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXP/xgVNe+QhijTDv/p1ui5zxvSdN0RfWCRTjDrr6cLzaiKny+hRkUumze8csoEiQkVLNv8HVxWRPrEIE/Yn9R2TYPPf3BY/sUU8aBNZpYgkt/55OXjWPh6YuCAihaGrM+ABC4sRvjXuePKMkQzvy1gE8dea31Ja9WVPxE10XKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Smj6tBew; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Smj6tBew"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A1D1F00898;
	Wed, 16 Sep 2026 14:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789567796;
	bh=tZd9pKKVDoZNYAWONWb9jIgHwDFHXqeItWn03G6pnvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Smj6tBewyjAxWnY6xIxYXFsJFAJrTQyEj2OxMxM04ByMWy41dbRGaijbjPeNHxyaI
	 c5hlh/Q64vcn91KtWmwckIMFumFZi3O0cT5yNmlFakRjgvTWBYaWCD01aKxV/DPxk5
	 8hmGsBj4yfxGold5LgRG6GeIUm4XCuQKFZGRQbNNIh7qXx6b2KqTPAH2S2M2TOmUgL
	 cxh3ROuybLRmrkl/+Nx5nTj3ZT87g6I9xGTu1Hlhnf4L4E1P8BzmrqeKjHW5yrVa8p
	 RZNPJckfjCunsQMb4WlmhZUNjfWT/rYIsJXrIDOth5FK08LzM4pCtUnwT9PmLlrOO6
	 oMFHSeahRpuSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Vishal Moola <vishal.moola@gmail.com>,
	Atish Patra <atishp@meta.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 3/3] x86/mm/pat: Allocate split page tables as kernel page tables
Date: Wed, 16 Sep 2026 10:09:51 -0400
Message-ID: <20260916140951.2926572-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916140951.2926572-1-sashal@kernel.org>
References: <2026091603-illusion-provolone-913f@gregkh>
 <20260916140951.2926572-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>

[ Upstream commit 9e4a3ec3411bb6bb59e3c1f29b75609f1e87aac4 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 18f88e578be35..136ce0b8b256c 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -442,7 +442,15 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
 
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
 
 	spin_unlock(&cpa_lock);
@@ -1131,11 +1139,10 @@ static void split_set_pte(struct cpa_data *cpa, pte_t *pte, unsigned long pfn,
 
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
@@ -1239,20 +1246,20 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
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
-- 
2.53.0

