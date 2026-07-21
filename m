Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21FF1C68F;
	Tue, 21 Jul 2026 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784636118; cv=none; b=Qqoe6ul0GN3d3LXtWNGsTfmz/TeoibfKoqwzbi+o7z+XMSzbVdu0GmkT+GSjxAk79a7E3pIqvqGPvOQkKlIPGKDqGmU6Tdl8ZNxNJgRk3GqZpi5wSxm43z9N+Cx/6kxbTcsanBaOOp3Qnn6a0jhNv27BzfTts1JIDbW85iE7STk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784636118; c=relaxed/simple;
	bh=pCtXRjw6ZgMa3cHzlvS20X0DiuXByBGQ9I2rhzbSYX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b3E1rB07yjpKjRTNuX/RVkfp9JHRlb2H0aGCiTiRiLswzx2nQ1PzHvyZQxCNAO7Zu6/54QZvqzdK6oqTLozTI29Tz+2r07sDsWt/HbyFv4Ejv6yzNjqK/k9V8yNWGwctPsA9EVYS5vSRtyqs/AFPSNNv4oKdcGfcKXcNLJlAA5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3MlDfIO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3MlDfIO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5BB1F000E9;
	Tue, 21 Jul 2026 12:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784636116;
	bh=Rgk19z5wBcSkopJP5DQnZm6oUtjPmjQV+SnoXSevxp0=;
	h=From:Date:Subject:To:Cc;
	b=P3MlDfIOpiVgiX71b7+hBO/WkLafEp01fAHThAIGtbzT0Ytz2r/B+bNKAPr8pLYdK
	 sWELk56vfnbsnb1/TVf9VwMRF9TsU87/ebYfzCoIXynczqVibbThSvcIz8vViSzf1F
	 dkxbOA73VJGti3tcxh5AKr/Piq3ErsDXV3r/fTLslpJglzCOeDIJZhImVZNAjYfU5P
	 U25Y8V3rURaBnQz/pl3+UVeCwRDnC+lrUCGlg7K5T3Qo7kWTUiBSSN3oyV4bgTXC9S
	 2VhCwNuayesP2925rbuETzlnUH9ABQ80AJ8msQR4yK1ooz1p4gIBTlPJsp2U8G36k2
	 6JeygAUXzTOAA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 21 Jul 2026 13:14:52 +0100
Subject: [PATCH v2] x86/mm/pat: allocate split page tables as kernel page
 tables
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-fix-cpa-kernel-pagetables-v2-1-2b255deed710@kernel.org>
X-B4-Tracking: v=1; b=H4sIALtiX2oC/42NQQqDMBQFryJ/3V+SIFG66j2KixifmlZUklRax
 Ls36gW6HJg3b6UA7xDolq3ksbjgpjGBumRkezN2YNckJiWUFoUS3LoP29nwC37EwLPpEE09IDB
 0Lusml1aVktJ+9kjy0X5UJ4d3/YSNe3A3ehfi5L/H+SJ375+fRbJkUWiNolQWLe6nc518R9W2b
 T8rayna1QAAAA==
X-Change-ID: 20260720-fix-cpa-kernel-pagetables-e641bd41c281
To: ljs@kernel.org
Cc: stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, 
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Lu Baolu <baolu.lu@linux.intel.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Kiryl Shutsemau <kas@kernel.org>, iommu@lists.linux.dev, 
 Kevin Tian <kevin.tian@intel.com>, Vishal Moola <vishal.moola@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5554; i=ljs@kernel.org;
 h=from:subject:message-id; bh=pCtXRjw6ZgMa3cHzlvS20X0DiuXByBGQ9I2rhzbSYX4=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLikw6/nXTY3+f0Pz7tQB47DscqY9uIxZlc8a0b3jp/2
 MFaxGDcUcrCIMbFICumyPL8i/j+IJGweZ0X/N1g5rAygQxh4OIUgIm0TmdkaOz9+/+5zIxTAQmX
 7aoPd048nN56Ied+YdR6zsDjExbvd2NkeMG7TVrmUm18g94fAWn2sw5dr+bszDWKXzLBTrPZ7tV
 XfgA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

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
---
v2:
- Prefer PageTable(ptdesc_page()) over folio variants as per Vishal, Mike.
- Add comment to explain why we're conditionally calling dtor.

v1:
https://patch.msgid.link/20260720-fix-cpa-kernel-pagetables-v1-1-0766e782cefe@kernel.org

To: Dave Hansen <dave.hansen@linux.intel.com>
To: Andy Lutomirski <luto@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@kernel.org>
To: Ingo Molnar <mingo@redhat.com>
To: Borislav Petkov <bp@alien8.de>
To: x86@kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: ljs@kernel.org
Cc: Vishal Moola <vishal.moola@gmail.com>
---
 arch/x86/mm/pat/set_memory.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 301fb9e77d91..078689aa7206 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -439,7 +439,15 @@ static void __cpa_collapse_large_pages(struct cpa_data *cpa)
 
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
 
@@ -1138,11 +1146,10 @@ static void split_set_pte(struct cpa_data *cpa, pte_t *pte, unsigned long pfn,
 
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
@@ -1246,18 +1253,18 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
 			    unsigned long address)
 {
-	struct ptdesc *ptdesc;
+	pte_t *pte;
 
 	if (!debug_pagealloc_enabled())
 		spin_unlock(&cpa_lock);
-	ptdesc = pagetable_alloc(GFP_KERNEL, 0);
+	pte = pte_alloc_one_kernel(&init_mm);
 	if (!debug_pagealloc_enabled())
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

---
base-commit: 890f8c4e827c918dac668a12eaf63180ba8a9e6d
change-id: 20260720-fix-cpa-kernel-pagetables-e641bd41c281

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

