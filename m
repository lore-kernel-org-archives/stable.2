Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B214C4E80DA;
	Wed, 16 Sep 2026 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789556060; cv=none; b=qO/WS70+zdFtCSg1Ybhgu9CM5MAltIppVZC0p+ilvPbFD8gyCAsSnO22ptV0dgBZgvcIjEX+0w6vRG/Sq/45HSuUrPnK/lkHdcYi/BVstrltOxVfgKZHf2tbWbZGa95Eqo0oJDhT1LIibXEn1v94p/G59OSjWrljAE8Oy8ccy/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789556060; c=relaxed/simple;
	bh=pWq26uk36Fa3vaxgg5PlpdHHNdiXgXw4Jez39b9S7yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8yRnjhYCLEfiXK6HFlK9RoLvxXjCASNZfDfWcsaCRXmwm0Yf7TRHTR6chzcROb5trFoQtrBOFc81xAI+LKYbXIiZ7fUotwVjJd1r6PuLuz+q7nVB9PW0tgX6QVOm4z1Hbc4NOvQ2QNIGjatO5vXvZFhdcUMGvw3CohV8kKOcnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmVxjWAI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmVxjWAI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CB51F00898;
	Wed, 16 Sep 2026 10:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789556046;
	bh=Lk85xeNcSE092LkOlJCMQ/OGCYgiaRkt+beVhCe3upM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HmVxjWAI/6i5FoXl7rUite4rysWcEEQDdkTWX9veRxbkCPUBQRW4yRQPavj6GyaiC
	 qnTvgs5NZhGjxQppVb8aqE4tAutWQoMp+9vYiQuCgqIpTp2SI0HQ1+Djv8ai3/QQih
	 6HcOCKtn1YR3ZOtKQYjcpltUEWEEqi+8g2PmODGmZ89S2lpW4LEMtciuNosj1bm7c+
	 oL7AYPKNo9yWbdDQ6mG40BdlSXVUg2VPj21bZ9O2X5GEFJYqAngksppgV2WhE3hEu3
	 vXwFUmQGi3Qs/RIkbKCZD9YDnoGFrqUaSsuSqCYWWg2XiLRT0+qCb1moi4oHGMuOc/
	 nkKuYhImINXxA==
Date: Wed, 16 Sep 2026 11:53:58 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, liam@infradead.org, david@kernel.org, vbabka@kernel.org, 
	jannh@google.com, ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, peterx@redhat.com, jgg@ziepe.ca, 
	sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/mempolicy: use vm_normal_folio_pmd() in
 queue_folios_pmd()
Message-ID: <aqpyp7ouLyxGhJDK@gremlin>
References: <20260912034833.2952750-1-gourry@gourry.net>
 <20260912034833.2952750-2-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912034833.2952750-2-gourry@gourry.net>

On Fri, Sep 11, 2026 at 11:48:32PM -0400, Gregory Price wrote:
> mmap a VM_PFNMAP region whose ->huge_fault installs a PMD through
> vmf_insert_pfn_pmd() - a vfio-pci MMIO BAR does this - then
>
> 	mbind(p, len, MPOL_BIND, &mask, maxnode, MPOL_MF_STRICT);
>
> With a stand-in module for the driver:
>
>   BUG: unable to handle page fault for address: fffff96dc0000008
>   RIP: 0010:queue_folios_pte_range+0xaf/0x440
>    walk_pgd_range+0x52b/0xaf0
>    __walk_page_range+0x6a/0x1d0
>    walk_page_range_mm_unsafe+0x193/0x230
>    queue_pages_range+0x64/0xa0
>    do_mbind+0x25e/0x640
>
> queue_folios_pmd(), inlined above, calls pmd_folio() on that PMD.  The pfn

This makes me wonder if pmd_folio() is just generally defunct in favour of
vm_normal_folio_pmd()?

> is raw MMIO with no memmap entry, so the folio lands in unpopulated
> vmemmap.  Neither guard stops the walk:
>
>   walk_page_test()         skips VM_PFNMAP, but queue_pages_walk_ops
>                            supplies ->test_walk, so it never runs
>   queue_pages_test_walk()  honours vma_migratable(), but only while
>                            MPOL_MF_STRICT is clear
>
> A VM_MIXEDMAP vma needs neither flag, being vma_migratable(), so plain
> mbind(MPOL_MF_MOVE) reaches this too - and there the bad folio carries on
> into migrate_folio_add() and folio_isolate_lru().  mshv_vtl_low is such a
> mapping.
>
> Use vm_normal_folio_pmd() and skip on NULL, as the PTE loop in
> queue_folios_pte_range() already does with vm_normal_folio().  On the NULL
> path, retain ACTION_CONTINUE handling for the huge zero PMD.
>
> mbind(MPOL_MF_STRICT) over a PMD mapped VM_PFNMAP region now returns 0
> rather than -EIO.  The PTE loop already returned 0 there.
>
> Fixes: 3c8e44c9b369 ("mm: mark special bits for huge pfn mappings when inject")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260817220810.1175596-1-gourry%40gourry.net
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/mempolicy.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 2ad0a5f18280..8fc8a975657e 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -667,7 +667,8 @@ static inline bool queue_folio_required(struct folio *folio,
>  	return node_isset(nid, *qp->nmask) == !(flags & MPOL_MF_INVERT);
>  }
>
> -static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
> +static void queue_folios_pmd(pmd_t *pmd, unsigned long addr,
> +			     struct mm_walk *walk)
>  {
>  	struct folio *folio;
>  	struct queue_pages *qp = walk->private;
> @@ -678,13 +679,14 @@ static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
>  			qp->nr_failed++;
>  		return;
>  	}
> -	folio = pmd_folio(pmdval);
> -	if (folio_is_zone_device(folio))
> -		return;
> -	if (is_huge_zero_folio(folio)) {
> -		walk->action = ACTION_CONTINUE;
> +	folio = vm_normal_folio_pmd(walk->vma, addr, pmdval);
> +	if (!folio) {
> +		if (is_huge_zero_pmd(pmdval))
> +			walk->action = ACTION_CONTINUE;

Since you've already identified that this is a leaf PMD, is there really any
difference between setting walk->action to ACTION_CONTINUE or not?

There's nothing to descend to in the subtree here so either way you continue to
the next PMD entry don't you?

So there's a pmd_entry specified for both set of walk ops:

static const struct mm_walk_ops queue_pages_walk_ops = {
	.hugetlb_entry		= queue_folios_hugetlb,
	.pmd_entry		= queue_folios_pte_range,
	.test_walk		= queue_pages_test_walk,
	.walk_lock		= PGWALK_RDLOCK,
};

static const struct mm_walk_ops queue_pages_lock_vma_walk_ops = {
	.hugetlb_entry		= queue_folios_hugetlb,
	.pmd_entry		= queue_folios_pte_range,
	.test_walk		= queue_pages_test_walk,
	.walk_lock		= PGWALK_WRLOCK,
};

But no pte_entry or install_pte handlers.

Reading walk_pmd_range() in mm/pagewalk.c:

static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
			  struct mm_walk *walk)
{
	bool has_handler = ops->pte_entry;
	...
	bool has_install = ops->install_pte;
	...

	do {
again:
		walk->action = ACTION_SUBTREE;
		...
		if (ops->pmd_entry)
			err = ops->pmd_entry(pmd, addr, next, walk);
		if (err)
			break;

		if (walk->action == ACTION_AGAIN)
			goto again;
		if (walk->action == ACTION_CONTINUE)
			continue;

		if (!has_handler) { /* No handlers for lower page tables. */
			if (!has_install)
				continue; /* Nothing to do. */
			...
		}
	...
	} while (pmd++, addr = next, addr != end);
	...
}

It seems that setting ACTION_CONTINUE or not makes no difference.

This is really just a long way of saying maybe you could just do:

	folio = vm_normal_folio_pmd(walk->vma, addr, pmdval);
	if (!folio)
		return;

? :)

>  		return;
>  	}
> +	if (folio_is_zone_device(folio))
> +		return;
>  	if (!queue_folio_required(folio, qp))
>  		return;
>  	if (!(qp->flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
> @@ -717,7 +719,7 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
>
>  	ptl = pmd_trans_huge_lock(pmd, vma);
>  	if (ptl) {
> -		queue_folios_pmd(pmd, walk);
> +		queue_folios_pmd(pmd, addr, walk);
>  		spin_unlock(ptl);
>  		goto out;
>  	}
> --
> 2.55.0
>

--
Cheers, Lorenzo
