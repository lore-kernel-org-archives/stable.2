Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD483C3F40;
	Tue, 13 Oct 2026 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900682; cv=none; b=nGCh4r4QsI/lOEKe4FckTUtbzcTQbscrXaaSurSXoJRWq1z2bLmysPA+0GOBYBVHrUrjchehRDKyOdPHTW/7lLAk5InKlLurrseYX9HAzCGj9hgof8wzRdhJ3QuQ/npjY2YSzsSloUCV7dHnn8EaHN/cxjF/L9ppzCK12IpIIUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900682; c=relaxed/simple;
	bh=HYAGIj77WyC/Jcq+g6tnLubWVbk/cd83F1lLqIPCKhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBOU6ZS95FT0xEmTZp1b2brDaFBXc0CJgd2RnqjTbgXSIq/Y8iv0rLa16WHxN/d6pJqN85ecm4aKNjOse5UwhK+E1z+mlJynaVTTaOjSDw/VgFzI3mejRhbz/+84eK/ggCSGoC1j9pT2A21VpOYKYeWUQGkETCtwxORMgI4fISI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTTmcHwc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTTmcHwc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667CB1F000FF;
	Tue, 13 Oct 2026 14:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791900681;
	bh=PafVWtiiBVG/CnUNItxta5c64k8qSC/5mZ/lxcbSfuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WTTmcHwcZrWC6wIHZ4MKlhp2UbxVVfnyQhygIA7pwCuO27EWQQwjjy5Pr/G5PjLRS
	 kgu/qr2UpU9jczKBTuspnklruSAY//9u1nNJhv6wDTzTLlaQiSxAxN4l/7OUtXVSsS
	 utiaQToztMh3L+geyoayp0jZRBM8D+SMSgRuNA6V/DiZj52mLpNYo+qqKM+1qOhCJr
	 ZsJYlUB39tnfy1QnhHMpH8iylJjTqh254YQk5QEC7K3wgtChYqUtFbdGRoChr4Qb4I
	 Fq1tIiyCQ2UCxNRQSqHQ8V423ClS3wK9y4vLE2uPuMGFVKEsPPtakP49z36XcjbkOy
	 ngOWAENHP5YmQ==
Date: Tue, 13 Oct 2026 15:11:13 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Ying Huang <huang.ying.caritas@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Chuanhua Han <hanchuanhua@oppo.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Kyle Zeng <kylebot@openai.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: fix address wraparound when scanning large folio PTEs
Message-ID: <as4kvHe9IFZH5qrC@gremlin>
References: <20261013-folio_pte_scan_range-v1-1-c50dc30bf6ad@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013-folio_pte_scan_range-v1-1-c50dc30bf6ad@kernel.org>

On Tue, Oct 13, 2026 at 02:30:37PM +0200, David Hildenbrand (Arm) wrote:
> numa_rebuild_large_mapping() and do_swap_page() can be tricked into
> generating an address wraparound, crashing the kernel. All that's required
> is to map a tail page of a large folio close enough to the start/end of
> the address space to e.g., make
>
> 	unsigned long addr_start = addr - (nr << PAGE_SHIFT);
>
> to wrap around.

Yeah damn.

I feel like we need to generalise the underflow/overflow checks we have
arbitrarily around the place into helper functions.

I know somebody schlopped something like that for one function in particular
recently, but a non-schlopped, generalised version of that would be nice.

>
> Let's fix it by providing a better helper, folio_pte_scan_range(), that
> takes care of staying within VMA and page table boundaries while
> handling possible wraparounds.

OK so this is effectively abstracting this very thing :) though I guess
perhaps not quite a match for the general 'did we over/underflow stuff with
the addr, size pair we just got'.

Anyway that's something to think about separately I guess.

>
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Fixes: d2136d749d76 ("mm: support multi-size THP numa balancing")
> Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swapcache")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/memory.c | 43 +++++++++++++++++++++++++++++--------------
>  1 file changed, 29 insertions(+), 14 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 1f5d5f7d39cd2..a3823010aa981 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4933,6 +4933,27 @@ static void check_swap_exclusive(struct folio *folio, swp_entry_t entry,
>  	} while (--nr_pages);
>  }
>
> +/*
> + * Get the address range in which a folio might be mapped, assuming its pages
> + * are mapped consecutively and the folio page at the given idx is mapped at
> + * the given address.
> + */

I know it's a static function but kdoc here might be nice given the number of
params, including 2 output parameters.

Also then can specify exclusive end, etc.

> +static void folio_pte_scan_range(const struct folio *folio,
> +		const struct vm_area_struct *vma, unsigned long addr,
> +		unsigned long idx, unsigned long *start, unsigned long *end)

I don't love the name - to me it implies to me that you're scanning the range.

Maybe clamp_folio_pte_range()? I guess though clamp implies it limits an input
range.

Maybe get_folio_pte_range()?

Also I think it might be useful to have it return the number of pages contained
within the range?

Then this below:

+		folio_pte_scan_range(folio, vma, address, idx, &folio_start,
+				     &folio_end);
+		if (unlikely((folio_end - folio_start) >> PAGE_SHIFT != nr))

Could be:

+		if (unlikely(get_folio_pte_range(folio, vma, address, idx,
+						 &folio_start, &folio_end)) != nr)

OTOH, that's pretty ugly... :))

> +{
> +	/* Stay within the page table and VMA boundaries. */
> +	const unsigned long pmd_start = addr & PMD_MASK;
> +	const unsigned long pmd_end = pmd_start + PMD_SIZE;

OK so get the range of the PTE page table.

> +	const unsigned long lower = max(pmd_start, vma->vm_start);

Then clamp to VMA start...

> +	const unsigned long upper = min(pmd_end - 1, vma->vm_end - 1) + 1;

This is trickier :)

I guess you're doing this in case either bound is right at wraparound
somehow?

But then couldn't the +1 push you over the edge?

Oh wait no, because then vma->vm_end would have to equal 0, which would
fail the other-place enforced invariant that vma->vm_start < vma->vm_end.

So it's pmd_end that could overflow, hence the -1, +1 dance.

Yeah I kind of hate that, that's a lot of 'just have to know' right there.

Actually we have pmd_addr_end() already, could we use that?

#define pmd_addr_end(addr, end)                                         \
({      unsigned long __boundary = ((addr) + PMD_SIZE) & PMD_MASK;      \
        (__boundary - 1 < (end) - 1)? __boundary: (end);                \
})

That embeds the trick in the helper and it expresses what you're getting.

Then it could be:

	const unsigned long pmd_start = addr & PMD_MASK;
	const unsigned long lower = max(pmd_start, vma->vm_start);
	const unsigned long upper = pmd_addr_end(addr, vma->vm_end);

> +	const unsigned long offset = idx << PAGE_SHIFT;
> +
> +	/* Avoid any address wraparounds. */
> +	*start = addr - min(addr - lower, offset);

This is also tricky. This is clamping to max(lower, addr - offset) right,
but being very careful about underflow?

I don't love the addr - (addr - lower) = lower here, and it feels like it
embeds a comparison there too. It's all very implicit.

Actually maybe just naming addr - lower gets us there:

	const unsigned long max_offset = addr - lower;
	...
	*start = addr - min(max_offset, offset);

There's check_sub_overflow() or you could use a ternary also but both feel
like they add more complexity than is useful.

> +	*end = addr + min(upper - addr, folio_size(folio) - offset);

Same deal here.

Maybe something like:

	const unsigned long max_remaining_bytes = upper - addr;
	...
	*end = addr + min(max_remaining_bytes, folio_size(folio) - offset);

> +}
> +
>  /*
>   * We enter with either the VMA lock or the mmap_lock held (see
>   * FAULT_FLAG_VMA_LOCK), and pte mapped but not yet locked.
> @@ -5121,16 +5142,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	address = vmf->address;
>  	ptep = vmf->pte;
>  	if (folio_test_large(folio) && folio_test_swapcache(folio)) {
> -		int nr = folio_nr_pages(folio);
> -		unsigned long idx = folio_page_idx(folio, page);
> -		unsigned long folio_start = address - idx * PAGE_SIZE;
> -		unsigned long folio_end = folio_start + nr * PAGE_SIZE;
> +		const int nr = folio_nr_pages(folio);
> +		const unsigned long idx = folio_page_idx(folio, page);
> +		unsigned long folio_start, folio_end;
>  		pte_t *folio_ptep;
>  		pte_t folio_pte;
>
> -		if (unlikely(folio_start < max(address & PMD_MASK, vma->vm_start)))
> -			goto check_folio;
> -		if (unlikely(folio_end > pmd_addr_end(address, vma->vm_end)))
> +		folio_pte_scan_range(folio, vma, address, idx, &folio_start,
> +				     &folio_end);
> +		if (unlikely((folio_end - folio_start) >> PAGE_SHIFT != nr))
>  			goto check_folio;
>
>  		folio_ptep = vmf->pte - idx;
> @@ -6280,16 +6300,11 @@ static void numa_rebuild_large_mapping(struct vm_fault *vmf, struct vm_area_stru
>  				       struct folio *folio, pte_t fault_pte,
>  				       bool ignore_writable, bool pte_write_upgrade)
>  {
> -	int nr = pte_pfn(fault_pte) - folio_pfn(folio);
> +	const unsigned long idx = pte_pfn(fault_pte) - folio_pfn(folio);
>  	unsigned long start, end, addr = vmf->address;
> -	unsigned long addr_start = addr - (nr << PAGE_SHIFT);
> -	unsigned long pt_start = ALIGN_DOWN(addr, PMD_SIZE);
>  	pte_t *start_ptep;
>
> -	/* Stay within the VMA and within the page table. */
> -	start = max3(addr_start, pt_start, vma->vm_start);
> -	end = min3(addr_start + folio_size(folio), pt_start + PMD_SIZE,
> -		   vma->vm_end);
> +	folio_pte_scan_range(folio, vma, addr, idx, &start, &end);
>  	start_ptep = vmf->pte - ((addr - start) >> PAGE_SHIFT);
>
>  	/* Restore all PTEs' mapping of the large folio */
>
> ---
>
> base-commit: 634cbf5b794b734c78631b92e381cfc85f357bbe
>
> change-id: 20261013-folio_pte_scan_range-c6ca19cc8e9d
>
> --
>
> Cheers,
>
> David
>

In general though the logic as a whole looks correct to me, AFAICT.

--
Cheers, Lorenzo
