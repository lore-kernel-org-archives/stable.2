Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B0F3B71B6;
	Thu, 13 Aug 2026 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611738; cv=none; b=KO8GQRp41hTGEdHebb9tEPp4KzsJauIO2TBJqHBg8YFOXNuIei5Gbmp9on+UTgL/MhuyXJpYU9ojyojgeqh3j3Gozfx7aq+bg2IybIki3JWGixkl+wZo3MdmoYCEHN8U0ivjLCZ0VyKhhxuoyO9351oDFKP943Dfm2RAUvFxiC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611738; c=relaxed/simple;
	bh=eR90IvSUViA5rAhz+GIOPWKSgTreSS8lW89G4Kl2ZFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bsh53+hlPCtAV66HhHvcc8wypNIZpbOyHIXp8iUdgbrks0vKzCxkge94CkMCTEus05uDdlEsp2MkPliOutK4MgozSHYi/sgP0iooeiN4CIPKX255Tow6S7jStuLCsVC01KmRcnEdU9brNtqStWHu3z/RenMN5LYBle2yuN1NY04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTHjlUqt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTHjlUqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450831F00A3D;
	Thu, 13 Aug 2026 09:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786611732;
	bh=X5zSwpgxBZvb+myrFl6S3DxQdJeWuTT7rdxmIVQZYGg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cTHjlUqtkSdbH+1I9do/NPyiH+MMWzDRET3NOH61eOVwd1VJxTrpsVOqpwVdcd3o3
	 1a+P8AZvdG4dTwAhdsVlXsHIPTE4Wk30hWvVnuTVs0j7UE9FzV4XjCqDWN6Dq1M2W4
	 YdIw8U7uzuXowdqqbZpsvhuOLRLJcugSJ8Xvi8+QDSzeE4i89uXTdfi8i5gcV3z+SE
	 mkyJvWT6Uvehy3Nzzc4qwCLqdFIT3iHGNXe/SlE/07853x12BnoUN1Tmnss5+9MbS+
	 BmiNToCMRCiMdxRSmec7BspR3mYd1XzZelKof57VO9NVgp2H32tQfDvp7tfgGDMpvJ
	 3XNuJzUVXQKyQ==
From: Mike Rapoport <rppt@kernel.org>
Date: Thu, 13 Aug 2026 12:01:27 +0300
Subject: [PATCH v2 4/5] x86/mm/pat: allocate split page tables as kernel
 page tables
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-cpa-fixes-v2-4-39b4ff90f91d@kernel.org>
References: <20260813-cpa-fixes-v2-0-39b4ff90f91d@kernel.org>
In-Reply-To: <20260813-cpa-fixes-v2-0-39b4ff90f91d@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 David CARLIER <devnexen@gmail.com>, David Hildenbrand <david@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Jiri Slaby <jirislaby@kernel.org>, Juergen Gross <jgross@suse.com>, 
 Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Mike Rapoport <rppt@kernel.org>, 
 Nikunj A Dadhania <nikunj@amd.com>, Pedro Falcato <pfalcato@suse.de>, 
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Steffen Dirkwinkel <lists@steffen.cc>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Toshi Kani <toshi.kani@hpe.com>, Vishal Moola <vishal.moola@gmail.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 stable@vger.kernel.org, syzbot@syzkaller.appspotmail.com, x86@kernel.org
X-Mailer: b4 0.17-dev

From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>

When splitting a large page in CPA in __split_large_page() we allocate a
PTE directly without going through the standard page table allocation
routines such as pte_alloc_one_kernel().

This means the page table constructor is never called nor is the page table
marked as a kernel page table.

The former results in the folio associated with the page table not being
marked as a page table (__pagetable_ctor() is never called thus neither is
__folio_set_pgtable()) nor are statistics updated to reflect
it (lruvec_stat_add_folio() is never called).

The latter issue of failing to mark the page table as a kernel page
table (ptdesc_set_kernel() is never called) is far more problematic.

Since commit 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page
tables") kernel page table freeing has been batched and since the
subsequent commit e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries
for kernel address space") IOTLB cache entries for kernel page tables have
been invalidated upon being freed.

Since split page tables are freed without this invalidation, the IOTLB can
contain stale entries for them.

Resolve the issue by using the ordinary PTE allocation API at split time.

This results in these kernel page tables invoking a page table constructor,
and thus requires a page table destructor.

Since we cannot assume one is always present (early allocated direct map
page tables are not marked as such), we conditionally call
pagetable_dtor_free() if the PG_table folio flag for the ptdesc is set,
otherwise we free the page table via pagetable_free().

Regardless of which path is taken page tables marked as kernel page tables,
which now includes split page tables, take the correct route through
pagetable_free_kernel().

There is a user-visible side effect in that split page tables will appear
in nr_page_table_pages in /proc/vmstat (as do other kernel page tables
allocated after early boot), however this is a positive change.

This issue started being markedly problematic after commit
5ba2f0a15564 ("mm: introduce deferred freeing for kernel page tables") so
choose this as the Fixes target.

Fixes: 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page tables")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Vishal Moola <vishal.moola@gmail.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 2d04a4bf34aa..fbc418dfc597 100644
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

-- 
2.53.0

