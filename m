Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125E052D2CC;
	Tue, 13 Oct 2026 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906378; cv=none; b=KZEYVExpFj8NfDrBpeuZp/UlZ0vSS+CpySyPpuHqEGkOh6iQWYK7Ikuj8kZrBxpet9xS6+28xGTMVjPZu6YsSolVlCzltenp4BxBWYIqzYpHU7suMePbLnlhAqgHkK2SyZq6X4akAi5rYrwkX89+SasJgu1nlR/lMeRwPi9w+TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906378; c=relaxed/simple;
	bh=XuWA6CDAD0oKpnT54prmMz8xHDjG+uiR1e6XzEDjg3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjzquDYtCT4DN0XUifQqzE/lUQgFMbensb3xRm2xRdfyNBb0suDQsSJgiZqo7WJ+TFC/j3yYCQur5wDoAxOrW4huCVLp/exoEx3nuXnINrNyGQ3Lxu+rO4QhcvHzLGrLqf8zv2ocSrJ8bAgMhr8OXw8EAa55c5vupIgEy4ksEbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZjFOOBmK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZjFOOBmK"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3BEF1650;
	Tue, 13 Oct 2026 08:46:11 -0700 (PDT)
Received: from [10.57.13.106] (unknown [10.57.13.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B34B3F673;
	Tue, 13 Oct 2026 08:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791906375; bh=XuWA6CDAD0oKpnT54prmMz8xHDjG+uiR1e6XzEDjg3k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZjFOOBmKsahlAoLaaCP80butvn34rJwBxI/KlXTDwEbOHXbvc9w6p2iFn5xnwkUbY
	 8pX/C4RRzfAkFQXwAN03mQEp1RDWDe34NtNMndsb900iRhte6mST01qKnGH7YZpnF8
	 66UGXrxvp+Iivp9v6L5hUgLq6glrE6G5Ev0gmlEU=
Message-ID: <2552e0bd-0e50-4dd5-a3d9-00e9204eb2c2@arm.com>
Date: Tue, 13 Oct 2026 17:46:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mm: fix missing page-table destructor in
 pagetable_free()
To: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>,
 Dave Hansen <dave.hansen@intel.com>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Muchun Song <muchun.song@linux.dev>
References: <20261010112457.49485-1-songmuchun@bytedance.com>
 <20261010112457.49485-2-songmuchun@bytedance.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20261010112457.49485-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/10/2026 13:24, Muchun Song wrote:
> Since commit 49f599666420 ("mm: call ctor/dtor for kernel PTEs"),
> pte_alloc_one_kernel() runs the page-table constructor for kernel PTE
> tables.
>
> HVO (HugeTLB Vmemmap Optimization) uses pte_alloc_one_kernel() when
> splitting a PMD. Restoring the vmemmap backing pages does not collapse
> the PTE table, so a later memory hot-remove eventually frees it through
> pagetable_free() on x86-64. That releases the page without running the
> matching destructor and leaves NR_PAGETABLE elevated.
>
> Make pagetable_free() detect constructor-backed pages and run the
> destructor before releasing their memory to fix the problem.
>
> Fixes: 49f599666420 ("mm: call ctor/dtor for kernel PTEs")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
> v2:
> - Move destructor handling from x86 into pagetable_free() (suggested by
>   David Hildenbrand)
> - Trim and update the commit message (requested by Dave Hansen)
> ---
>  include/linux/mm.h | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5cca90fc1df6..771a7d60b0a5 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3969,23 +3969,6 @@ static inline void pagetable_free_kernel(struct ptdesc *pt)
>  	__pagetable_free(pt);
>  }
>  #endif
> -/**
> - * pagetable_free - Free pagetables
> - * @pt:	The page table descriptor
> - *
> - * pagetable_free frees the memory of all page tables described by a page
> - * table descriptor and the memory for the descriptor itself.
> - */
> -static inline void pagetable_free(struct ptdesc *pt)
> -{
> -	if (ptdesc_test_kernel(pt)) {
> -		ptdesc_clear_kernel(pt);
> -		pagetable_free_kernel(pt);
> -	} else {
> -		__pagetable_free(pt);
> -	}
> -}
> -
>  #if defined(CONFIG_SPLIT_PTE_PTLOCKS)
>  #if ALLOC_SPLIT_PTLOCKS
>  void __init ptlock_cache_init(void);
> @@ -4078,6 +4061,26 @@ static inline void pagetable_dtor(struct ptdesc *ptdesc)
>  	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
>  }
>  
> +/**
> + * pagetable_free - Free pagetables
> + * @pt:	The page table descriptor
> + *
> + * pagetable_free frees the memory of all page tables described by a page
> + * table descriptor and the memory for the descriptor itself.
> + */
> +static inline void pagetable_free(struct ptdesc *pt)
> +{
> +	if (PageTable(ptdesc_page(pt)))
> +		pagetable_dtor(pt);

Took me a while to understand why this is fine. Currently we have:

    ptdesc = pagetable_alloc();
    pagetable_*_ctor(mm, ptdesc);
    [...]
    pagetable_dtor(ptdesc);
    pagetable_free(ptdesc);

All good, nice and balanced.

Now we're saying that pagetable_free() should call the dtor. But of
course, in most cases, the dtor has already been called. Yes, this is
fine because in that case PageTable(page) returns false. Still, the
casual reader is likely to be confused (like I was).

The commit message should really explain this. I'm not a big fan of the
asymmetry we're creating between explicit alloc+ctor and free implicitly
calling dtor, but I suppose it's safer this way. (And looking at the
rest of the series, it does bring some nice cleanups.)

I understand this is a bugfix series so its scope is limited, but if
time allows please post a follow-up series removing all those explicit
dtor calls that are no longer required.

Now don't get me wrong, I am absolutely in favour of moving as much
handling as possible out of the ctor/dtor and into
pagetable_{alloc,free}; a series I posted earlier [1] was a step in that
direction. It unfortunately had many issues, including the unmatched
alloc/free calls [2]. The work you're doing in this series, and your
plan to use pagetable_alloc() for vmemmap, are exactly what I was
planning to do next, so thank you for taking care of that :)

With the commit message improved:

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

- Kevin

[1]
https://lore.kernel.org/linux-mm/20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com/
[2]
https://lore.kernel.org/linux-mm/6d167aaa-e9b0-4687-970c-1c67d0df6344@arm.com/

> +
> +	if (ptdesc_test_kernel(pt)) {
> +		ptdesc_clear_kernel(pt);
> +		pagetable_free_kernel(pt);
> +	} else {
> +		__pagetable_free(pt);
> +	}
> +}
> +
>  static inline void pagetable_dtor_free(struct ptdesc *ptdesc)
>  {
>  	pagetable_dtor(ptdesc);
