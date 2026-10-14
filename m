Received: from mta1.migadu.com (out-121.mta1.migadu.com [95.215.58.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D0655D872
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995454; cv=none; b=DWbBmzztD75Fkfh7gBw3NbNTY5zT5pw/0Qn6yngK4nVMKubyaOh6nVohE61CR+l41inF53A57PPZXuOWoGmgef//lIJ5JI1g5aGac42igVWHKOwzuBld/+HPKGHwC0s/n+zQGodgoF3BHNA3uf5b3ftsRkbx28D6p5w1QexBrLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995454; c=relaxed/simple;
	bh=dw453SjKRb4006gix6zhYjhyw8h2zLucTTilf+CwNnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcgzPOJtY1vfEN6KbLTT6U/mnDpH7mLTY60iHkdyjlsaYhVcjiXkuhWUsK1v90goifbE1bHBq+ysk+/NGQSmikMS7LUEUnLjU4rZ63+lTFbKTSIsE8QmhDCkQCphW4eTkLwYQT4vjZ3eKviAxD9AEZhd4d7663eUl91eNUDsG2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r3yIi4uE; arc=none smtp.client-ip=95.215.58.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r3yIi4uE"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dw453SjKRb4006gix6zhYjhyw8h2zLucTTilf+CwNnE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791995450; v=1; x=1792600250;
 b=r3yIi4uErvQk3aLwnT7PwDpTB4yWB+1CYIXSUqIJm9A3Jffi86vuBrOQcxcmPc7uLrs6eqXc
 vbcxYE6ma5IXv9mISCBjIvfJluES68Y+VI2tXLF0Or5x6DAz2SZGJzkWMIyGuSqqFe0UgSM4b/c
 r0IauxsTNyMo2Li7PxRJolCI=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b89656d6ed486c36;
	Wed, 14 Oct 2026 16:30:50 +0000
X-Mizu-Trace-ID: b89656d6ed486c36
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	huang.ying.caritas@gmail.com,
	baolin.wang@linux.alibaba.com,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	hanchuanhua@oppo.com,
	kas@kernel.org,
	kylebot@openai.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: fix address wraparound when scanning large folio PTEs
Date: Thu, 15 Oct 2026 00:30:43 +0800
Message-ID: <20261014163043.39233-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261013-folio_pte_scan_range-v1-1-c50dc30bf6ad@kernel.org>
References: <20261013-folio_pte_scan_range-v1-1-c50dc30bf6ad@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Tue, Oct 13, 2026 at 02:30:37PM +0200, David Hildenbrand (Arm) wrote:
>numa_rebuild_large_mapping() and do_swap_page() can be tricked into
>generating an address wraparound, crashing the kernel. All that's required
>is to map a tail page of a large folio close enough to the start/end of
>the address space to e.g., make
>
>	unsigned long addr_start = addr - (nr << PAGE_SHIFT);
>
>to wrap around.
>
>Let's fix it by providing a better helper, folio_pte_scan_range(), that
>takes care of staying within VMA and page table boundaries while
>handling possible wraparounds.
>
>Reported-by: Kyle Zeng <kylebot@openai.com>
>Fixes: d2136d749d76 ("mm: support multi-size THP numa balancing")
>Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swapcache")
>Cc: stable@vger.kernel.org
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> mm/memory.c | 43 +++++++++++++++++++++++++++++--------------
> 1 file changed, 29 insertions(+), 14 deletions(-)
>
>diff --git a/mm/memory.c b/mm/memory.c
>index 1f5d5f7d39cd2..a3823010aa981 100644
>--- a/mm/memory.c
>+++ b/mm/memory.c
>@@ -4933,6 +4933,27 @@ static void check_swap_exclusive(struct folio *folio, swp_entry_t entry,
> 	} while (--nr_pages);
> }
> 
>+/*
>+ * Get the address range in which a folio might be mapped, assuming its pages
>+ * are mapped consecutively and the folio page at the given idx is mapped at
>+ * the given address.
>+ */
>+static void folio_pte_scan_range(const struct folio *folio,
>+		const struct vm_area_struct *vma, unsigned long addr,
>+		unsigned long idx, unsigned long *start, unsigned long *end)
>+{
>+	/* Stay within the page table and VMA boundaries. */
>+	const unsigned long pmd_start = addr & PMD_MASK;
>+	const unsigned long pmd_end = pmd_start + PMD_SIZE;
>+	const unsigned long lower = max(pmd_start, vma->vm_start);
>+	const unsigned long upper = min(pmd_end - 1, vma->vm_end - 1) + 1;

That -1/+1 threw me for a sec ... Neat little trick!

>+	const unsigned long offset = idx << PAGE_SHIFT;
>+
>+	/* Avoid any address wraparounds. */
>+	*start = addr - min(addr - lower, offset);
>+	*end = addr + min(upper - addr, folio_size(folio) - offset);
>+}
>+
> /*
>  * We enter with either the VMA lock or the mmap_lock held (see
>  * FAULT_FLAG_VMA_LOCK), and pte mapped but not yet locked.
>@@ -5121,16 +5142,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> 	address = vmf->address;
> 	ptep = vmf->pte;
> 	if (folio_test_large(folio) && folio_test_swapcache(folio)) {
>-		int nr = folio_nr_pages(folio);
>-		unsigned long idx = folio_page_idx(folio, page);
>-		unsigned long folio_start = address - idx * PAGE_SIZE;
>-		unsigned long folio_end = folio_start + nr * PAGE_SIZE;
>+		const int nr = folio_nr_pages(folio);
>+		const unsigned long idx = folio_page_idx(folio, page);
>+		unsigned long folio_start, folio_end;
> 		pte_t *folio_ptep;
> 		pte_t folio_pte;
> 
>-		if (unlikely(folio_start < max(address & PMD_MASK, vma->vm_start)))
>-			goto check_folio;
>-		if (unlikely(folio_end > pmd_addr_end(address, vma->vm_end)))
>+		folio_pte_scan_range(folio, vma, address, idx, &folio_start,
>+				     &folio_end);
>+		if (unlikely((folio_end - folio_start) >> PAGE_SHIFT != nr))
> 			goto check_folio;
> 
> 		folio_ptep = vmf->pte - idx;
>@@ -6280,16 +6300,11 @@ static void numa_rebuild_large_mapping(struct vm_fault *vmf, struct vm_area_stru
> 				       struct folio *folio, pte_t fault_pte,
> 				       bool ignore_writable, bool pte_write_upgrade)
> {
>-	int nr = pte_pfn(fault_pte) - folio_pfn(folio);
>+	const unsigned long idx = pte_pfn(fault_pte) - folio_pfn(folio);
> 	unsigned long start, end, addr = vmf->address;
>-	unsigned long addr_start = addr - (nr << PAGE_SHIFT);
>-	unsigned long pt_start = ALIGN_DOWN(addr, PMD_SIZE);
> 	pte_t *start_ptep;
> 
>-	/* Stay within the VMA and within the page table. */
>-	start = max3(addr_start, pt_start, vma->vm_start);
>-	end = min3(addr_start + folio_size(folio), pt_start + PMD_SIZE,
>-		   vma->vm_end);
>+	folio_pte_scan_range(folio, vma, addr, idx, &start, &end);
> 	start_ptep = vmf->pte - ((addr - start) >> PAGE_SHIFT);
> 
> 	/* Restore all PTEs' mapping of the large folio */
>
>---

Nothing jumped out at me, feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>
