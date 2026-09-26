Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23EA37DAA9;
	Sat, 26 Sep 2026 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790418483; cv=none; b=JIOn2i7vsOo+bqIOwUYJkPJuVkd2jIdBy5op31BZViaT+0MB7sHS/0WOrKzGqT+eC3ViKc59LuiL/uDxV72WJ610hZ77t2j6xg+7/zcpHhUQcJkJy5+8J2QcY54R0TvhYW+IipUIox5ZuSs+tsyxvkM2Uns/rniCKT8aSZU58Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790418483; c=relaxed/simple;
	bh=zn3gB2iKw0TjEM28CjHqS24OFhOrsj4e3ejvq0z/5mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pP20X6yk24EwfcQrb4/TzhEiWpMx6MhvUmJGU4bw7Mw6S23LJ3MHV++940vBDyutxdxM0Pt33tDUPXX6mP/VmPOf5DmT8KYsKLb9zE07xbPAPW2hPovcgoXAwfBf3B6N+1kqsagd1hIDeFDAF2a7k6ambJy0ApneM/T2ola+KNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1xAP4O-0007LN-00; Sat, 26 Sep 2026 11:51:48 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id D0EB9C0C84; Sat, 26 Sep 2026 11:37:12 +0200 (CEST)
Date: Sat, 26 Sep 2026 11:37:12 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Orgad Shaneh <orgads@gmail.com>
Cc: linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, osalvador@suse.de,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] MIPS: mm: do not write a huge TLB entry when the
 probe misses
Message-ID: <areSSGHptMhgnXQ3@alpha.franken.de>
References: <20260915071329.15125-1-orgads@gmail.com>
 <20260915071329.15125-2-orgads@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915071329.15125-2-orgads@gmail.com>

On Tue, Sep 15, 2026 at 07:13:25AM +0000, Orgad Shaneh wrote:
> __update_tlb() probes for the 8K pair at the address it is given and,
> for a huge pmd, writes the huge entry with tlbwi at the probed index or
> with tlbwr when the probe misses. That works only if the caller passes
> the faulting address, so that the probe finds the 4K entry the refill
> handler loaded for the faulting page and the huge entry replaces it.
> 
> update_mmu_cache_pmd() is not called that way. do_set_pmd() has always
> passed the huge-aligned address, and since commit ebcfc63d6bca ("mm:
> abstract THP allocation") the anonymous THP fault path does too
> (map_anon_folio_pmd()). The probe then misses the stale 4K entry, which
> sits at the faulting page somewhere else in the 2 MB range, tlbwr adds
> a huge entry next to it, and the TLB holds two entries matching the
> faulting address. Octeon raises "Machine Check exception - caused by
> multiple matching entries in the TLB" on the next refill of that page;
> a process on a CN63XX board died this way within a second of start, on
> the first anonymous THP of its bss.
> 
> Skip the write when the probe misses. The refill and TLBL/TLBS handlers
> probe the faulting address themselves and rewrite the stale entry with
> the huge one (they also set the software young bit), so the entry is
> installed on the next access at the cost of one exception.
> 
> Fixes: fd062c847a8c ("MIPS: TLB support for hugetlbfs.")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---
> diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
> --- a/arch/mips/mm/tlb-r4k.c
> +++ b/arch/mips/mm/tlb-r4k.c
> @@ -332,6 +332,19 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
>  	/* this could be a huge page  */
>  	if (pmd_leaf(*pmdp)) {
>  		unsigned long lo;
> +
> +		/*
> +		 * The probe above only covers the 8K pair at @address, and
> +		 * a huge mapping is installed with the huge-aligned address
> +		 * while the refill that started the fault left a 4K entry
> +		 * for the faulting page elsewhere in the range. Writing the
> +		 * huge entry to a random index would leave two entries
> +		 * matching the faulting address; leave it to the refill and
> +		 * TLBL/TLBS handlers, which probe the faulting address.
> +		 */
> +		if (idx < 0)
> +			goto out;
> +
>  		write_c0_pagemask(PM_HUGE_MASK);
>  		ptep = (pte_t *)pmdp;
>  		lo = pte_to_entrylo(pte_val(*ptep));
> @@ -339,10 +352,7 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
>  		write_c0_entrylo1(lo + (HPAGE_SIZE >> 7));
>  
>  		mtc0_tlbw_hazard();
> -		if (idx < 0)
> -			tlb_write_random();
> -		else
> -			tlb_write_indexed();
> +		tlb_write_indexed();
>  		tlbw_use_hazard();
>  		write_c0_pagemask(PM_DEFAULT_MASK);
>  	} else
> @@ -380,6 +390,7 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
>  			tlb_write_indexed();
>  	}
>  	tlbw_use_hazard();
> +out:

If CONFIG_MIPS_HUGE_TLB_SUPPORT is unset, the not needed out: gives
a warning. I've fixed that while applying.

>  	htw_start();
>  	flush_micro_tlb_vm(vma);
>  
> -- 
> 2.47.0

applied to mips-next

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
