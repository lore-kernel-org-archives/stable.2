Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFB033D6F8;
	Tue, 13 Oct 2026 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894658; cv=none; b=L8+jl1LDMjDPa0ncWpLAeq4bv6RhaD986V+wpCfVlvDHLYfoGucv/jzUW9RtSNWV1BrMdLCr4ihQTwcUn3yjQj3biAUFUxFdZyc4iZHVPF+PZD/PoWJP8NSlAH6OF5ibB++yfIEqp5IzE76jlO0tPmiLAuRg7MZcR8HgYPYhosI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894658; c=relaxed/simple;
	bh=q6nRAbWGhJmgn8/3tLbirUhaQCaDCSXwvO/2ykqrnTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gA1jsAiEr3TsdK6o57YmOa4Qv//lBkVuKuS05iBxKADgnP2A6hZPUQs5/bGPRkRN+ujqv0F4tfOA5SMlJFLhW3jxUGcCtSw//M8SVOn1WxRhol6qFvJct5hc6mzYBbvjkT/00rKDaHNDPOZd/9nzj+Xw9IWlwTF7T4LnHRCBm3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZTRINwc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZTRINwc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3101F00893;
	Tue, 13 Oct 2026 12:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791894657;
	bh=Xb1hOH7i9YqMB45ChD69mFDwlRw95h31SKU2E12G4YQ=;
	h=From:Date:Subject:To:Cc;
	b=gZTRINwczHe7ZL8f1PcBeMY2tu1LxVXEWFrHCNBd59lQhR9MedBrhgfDx9Et3dRi8
	 f6FoDnd2y7gIFlEctA7LwOEwX5rQdx3x3J5HQp5Yrklf4+XEdg0QPex25WzYeMC1OO
	 M1k18osGBO5pgsWsaWy4NevXyn6+d2hEBOteBitDaa/nZLl2phfi/bBmWuTJ9xy6gn
	 8oZhn69X+lszyFM30TxsixPD0ZbUkxKWJa6KfgCOO3OuLdLF4En+VtGFC1LKL7CWui
	 CcTg5oUhXYvFReIGCZCWo3RmgJmWLxphKvPMD81i0+t1zysS0NLtXYmLo7XJkmJu7s
	 HTkBgsINt+kzw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 13 Oct 2026 14:30:37 +0200
Subject: [PATCH] mm: fix address wraparound when scanning large folio PTEs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-folio_pte_scan_range-v1-1-c50dc30bf6ad@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGwkzmoC/yXM0QpAQBCF4VfRXFOWEl5F2tYYjLSrHaTk3S0uv
 zrnv0DIMwnU0QWeDhZ2NkDFEeBk7EgJ98GQpVmhUpUng1vY6XUjLWis9t8GCzSqQiyp6iFcV08
 Dn1+2aX/L3s2E29uC+34ANex0hHgAAAA=
X-Change-ID: 20261013-folio_pte_scan_range-c6ca19cc8e9d
To: Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Ying Huang <huang.ying.caritas@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
 Ryan Roberts <ryan.roberts@arm.com>, Chuanhua Han <hanchuanhua@oppo.com>, 
 Mike Rapoport <rppt@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, 
 Kyle Zeng <kylebot@openai.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4181; i=david@kernel.org;
 h=from:subject:message-id; bh=q6nRAbWGhJmgn8/3tLbirUhaQCaDCSXwvO/2ykqrnTY=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLOqRTY7REJCHv+Oc5wyrsQY85DXHtSTqgvU5xxJCtRs
 8/y8Yu5HaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEwkTJfhf2i1y5Xmsthvm1Jc
 JupN/tP07EzGhtsH+iZfDrue6vPVcSfDH+7NvOdtDjh5Ou/ozjkY8mGRWJ4+X4RO/55zV6dvqIn
 eyQAA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

numa_rebuild_large_mapping() and do_swap_page() can be tricked into
generating an address wraparound, crashing the kernel. All that's required
is to map a tail page of a large folio close enough to the start/end of
the address space to e.g., make

	unsigned long addr_start = addr - (nr << PAGE_SHIFT);

to wrap around.

Let's fix it by providing a better helper, folio_pte_scan_range(), that
takes care of staying within VMA and page table boundaries while
handling possible wraparounds.

Reported-by: Kyle Zeng <kylebot@openai.com>
Fixes: d2136d749d76 ("mm: support multi-size THP numa balancing")
Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swapcache")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 1f5d5f7d39cd2..a3823010aa981 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4933,6 +4933,27 @@ static void check_swap_exclusive(struct folio *folio, swp_entry_t entry,
 	} while (--nr_pages);
 }
 
+/*
+ * Get the address range in which a folio might be mapped, assuming its pages
+ * are mapped consecutively and the folio page at the given idx is mapped at
+ * the given address.
+ */
+static void folio_pte_scan_range(const struct folio *folio,
+		const struct vm_area_struct *vma, unsigned long addr,
+		unsigned long idx, unsigned long *start, unsigned long *end)
+{
+	/* Stay within the page table and VMA boundaries. */
+	const unsigned long pmd_start = addr & PMD_MASK;
+	const unsigned long pmd_end = pmd_start + PMD_SIZE;
+	const unsigned long lower = max(pmd_start, vma->vm_start);
+	const unsigned long upper = min(pmd_end - 1, vma->vm_end - 1) + 1;
+	const unsigned long offset = idx << PAGE_SHIFT;
+
+	/* Avoid any address wraparounds. */
+	*start = addr - min(addr - lower, offset);
+	*end = addr + min(upper - addr, folio_size(folio) - offset);
+}
+
 /*
  * We enter with either the VMA lock or the mmap_lock held (see
  * FAULT_FLAG_VMA_LOCK), and pte mapped but not yet locked.
@@ -5121,16 +5142,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	address = vmf->address;
 	ptep = vmf->pte;
 	if (folio_test_large(folio) && folio_test_swapcache(folio)) {
-		int nr = folio_nr_pages(folio);
-		unsigned long idx = folio_page_idx(folio, page);
-		unsigned long folio_start = address - idx * PAGE_SIZE;
-		unsigned long folio_end = folio_start + nr * PAGE_SIZE;
+		const int nr = folio_nr_pages(folio);
+		const unsigned long idx = folio_page_idx(folio, page);
+		unsigned long folio_start, folio_end;
 		pte_t *folio_ptep;
 		pte_t folio_pte;
 
-		if (unlikely(folio_start < max(address & PMD_MASK, vma->vm_start)))
-			goto check_folio;
-		if (unlikely(folio_end > pmd_addr_end(address, vma->vm_end)))
+		folio_pte_scan_range(folio, vma, address, idx, &folio_start,
+				     &folio_end);
+		if (unlikely((folio_end - folio_start) >> PAGE_SHIFT != nr))
 			goto check_folio;
 
 		folio_ptep = vmf->pte - idx;
@@ -6280,16 +6300,11 @@ static void numa_rebuild_large_mapping(struct vm_fault *vmf, struct vm_area_stru
 				       struct folio *folio, pte_t fault_pte,
 				       bool ignore_writable, bool pte_write_upgrade)
 {
-	int nr = pte_pfn(fault_pte) - folio_pfn(folio);
+	const unsigned long idx = pte_pfn(fault_pte) - folio_pfn(folio);
 	unsigned long start, end, addr = vmf->address;
-	unsigned long addr_start = addr - (nr << PAGE_SHIFT);
-	unsigned long pt_start = ALIGN_DOWN(addr, PMD_SIZE);
 	pte_t *start_ptep;
 
-	/* Stay within the VMA and within the page table. */
-	start = max3(addr_start, pt_start, vma->vm_start);
-	end = min3(addr_start + folio_size(folio), pt_start + PMD_SIZE,
-		   vma->vm_end);
+	folio_pte_scan_range(folio, vma, addr, idx, &start, &end);
 	start_ptep = vmf->pte - ((addr - start) >> PAGE_SHIFT);
 
 	/* Restore all PTEs' mapping of the large folio */

---

base-commit: 634cbf5b794b734c78631b92e381cfc85f357bbe

change-id: 20261013-folio_pte_scan_range-c6ca19cc8e9d

--

Cheers,

David

