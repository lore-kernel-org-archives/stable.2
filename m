Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EA73C76A0;
	Sun, 13 Sep 2026 06:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789281998; cv=none; b=PaxZlwowrBVo5hE7suxR9/tpJQsuR8r84KH5fJja0+1RaHTWv8L57xvVOyFZxxT0j/eaDPH9q7JpwYpuOvKAbAU8Op/M7ZoXHvh65JI2zaKimfjJGigburExSWxTrZiXhDQYXCqxdQ+39/OEGjQRRr9ujNlzdZflsmTcr6TIpB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789281998; c=relaxed/simple;
	bh=7eJhp5fg3ifvTFQXzhHVslkmtPAfvcRpoNkduDSINWk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OsIplz7C3o3dyVlavkdiWoHkmE/4k93vuQ3ucnBb8IetZjqg99rby4kh6O4jsrNvuSNmJeetVta7DlwXhdw954ov+hquLSi1dfCucB7r+E3LvPVHq+61pWUgFrkUCiGok+CvZP7a7OY6BzxNBPaWWO3pGXitiC4xz7Iql9CfZ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XAnBHG8a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XAnBHG8a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72A81F000FF;
	Sun, 13 Sep 2026 06:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789281996;
	bh=xQwdvU95FrXRFZwRBjEBFe2/Hx2FqUUlTLasQMUqqps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XAnBHG8aaIJf3Qg7JPHialtHJS0edKVR9YxPGIF64eWU5k+ntxHydQKfUl+NAY0Nd
	 9o9UYmJ8HPCNiCz6K64j9IsAo7b8DqvCGwAt17PZsa82RYoIXM9oOW4ik23SPITNqm
	 jv/7UJh2FCC4QPLUCjPrEFiyUV5vMhR2lGYhmqns=
Date: Sat, 12 Sep 2026 23:46:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: david@kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 liam@infradead.org, nico.pache@linux.dev, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, usama.arif@linux.dev, kas@kernel.org,
 ljs@kernel.org, surenb@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/huge_memory: fix pgtable withdrawal for huge
 zero PMDs
Message-Id: <20260912234635.db50397364858aa15f58f4d7@linux-foundation.org>
In-Reply-To: <20260913051942.40889-1-lance.yang@linux.dev>
References: <20260913051942.40889-1-lance.yang@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Sep 2026 13:19:42 +0800 Lance Yang <lance.yang@linux.dev> wrote:

> From: Lance Yang <lance.yang@linux.dev>
> 
> has_deposited_pgtable() uses !vma_is_dax() to decide whether a huge zero
> PMD has a deposited PTE page table. That also accepts raw PFN mappings
> of huge_zero_pfn, although vmf_insert_pfn_pmd() does not deposit a page
> table on x86.
> 
> Zapping such a mapping would call pgtable_trans_huge_withdraw() without
> a corresponding deposit. With pmd_huge_pte(mm, pmd) == NULL, that causes
> a NULL pointer dereference.

That's the sort of thing we'd prefer to avoid.

> Use vma_is_anonymous() for the huge zero PMD check. This matches how PTE
> page tables are allocated, deposited and moved.
> 
> - For anonymous page faults that install a huge zero PMD,
>   do_huge_pmd_anonymous_page() allocates a PTE page table and
>   set_huge_zero_folio() deposits it before installing the PMD.
> 
> - On fork, copy_huge_pmd() allocates and deposits a PTE page table when
>   copying a huge zero PMD into an anonymous VMA.
> 
> - Raw PFN mappings use vmf_insert_pfn_pmd(), and DAX file holes use
>   vmf_insert_folio_pmd() to map the huge zero folio. Both use insert_pmd(),
>   which deposits a PTE page table only when arch_needs_pgtable_deposit()
>   requires it.
> 
> - Moving an anonymous huge PMD preserves its deposited PTE page table.
>   move_huge_pmd() transfers the deposit when necessary. For UFFD MOVE,
>   both VMAs must be anonymous, and move_pages_huge_pmd() transfers the
>   deposit as well.
> 
> Keep arch_needs_pgtable_deposit() first so architectures that require a
> deposited PTE page table still return true regardless of the VMA type.
> 
> Commit d80a9cb1a64a ("mm/huge_memory: add and use
> normal_or_softleaf_folio_pmd()") removed the vma_is_special_huge() check
> in zap_huge_pmd(). That check skipped the huge zero PMD deposit test for
> non-DAX VM_PFNMAP and VM_MIXEDMAP mappings. Removing it exposed these
> mappings to the incorrect !vma_is_dax() test.
> 
> Fixes: d80a9cb1a64a ("mm/huge_memory: add and use normal_or_softleaf_folio_pmd()")
> Cc: stable@vger.kernel.org

How real is this?  Is there a reported-by:?  Do you have a reproducer? 
Is it a theoretical, LLM-found-this thing which can't really happen?

> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2529,11 +2529,11 @@ static bool has_deposited_pgtable(struct vm_area_struct *vma, pmd_t pmdval,
>  		return true;
>  
>  	/*
> -	 * Huge zero always deposited except for DAX which handles itself, see
> -	 * set_huge_zero_folio().
> +	 * Huge zero PMDs have a deposited page table only for anonymous VMAs,
> +	 * see set_huge_zero_folio().
>  	 */
>  	if (is_huge_zero_pmd(pmdval))
> -		return !vma_is_dax(vma);
> +		return vma_is_anonymous(vma);
>  
>  	/*
>  	 * Otherwise, only anonymous folios are deposited, see

Thanks, I'll add it for test-n-review.
