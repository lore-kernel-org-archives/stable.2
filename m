Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AD4552955
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992286; cv=none; b=TiuS4GrEwS9v84cIQak6BjvmNT0rtLeqzlKrwr2ct01L+Gkkk/pznVm3o7lF2G9vOCxDohr8tAtSf6axMXgcKKhtKP5jJX222s6vgFxCgR9dUpXus/lV5G5rm/8kfxITLp8F6A+wnMxtCkSQk3+X7S6ZfE16LUmX59xsHPN4UQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992286; c=relaxed/simple;
	bh=lz8D8RC8N3bVt0E+KvIJN169I0g9bBLpdu3waw6TBSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cv17Zt647pQ0b5g2PbJvAYuSDqE1hqsCcv76X8v9JEVId0SqbNl9PSZrX2s/dc+7waCNTX0iEwkZs2gcyX+5Agw7Txnabph5XkGyBvHVBpBaBP557791iSv1wnKec2foARFE5ymZlyfSid4otQ5JJUu7RIzwF+DNBtu1pVST8Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIwfbI0t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIwfbI0t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1E61F000C4;
	Wed, 14 Oct 2026 15:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791992285;
	bh=ovHBYbcBVfimIe8eIAVC5wulfBTP62i70vORa5b5ogA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XIwfbI0tm0ACdckGwvsEBkJRpeZAVoo0Z32DQrUoOFZcHwSY8TWZaYye3wWEgpO5B
	 OU7t2Uy6e3aD3Xh6jukKRqrVockHpcBY269mio57JdUrm5mBevYtlvollmaNu7RbK5
	 IGZ7ejU75rAcRvm1p6BAZ12Lv+wE9v26HpP24KDEkvUvCMy08CojuMyogVxNb6ey5r
	 hr9L3b14eST3c1C4g+DXO1WjIiFbZJlZP+ZTVaarlkLJRB2WFqLd9l89qVud7yj2vz
	 lEt6OuXSM4M8jaNP7lAh9kbZGObS8nI4P1InddjPqH/HmJioyXFSQWUzz2pD2oqjW5
	 PWz/Y7F/CPPNg==
Date: Wed, 14 Oct 2026 16:37:59 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Minchan Kim <minchan@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
	stable@vger.kernel.org, Samarth Narang <samarth.colleges@gmail.com>, 
	Gregory Price <gourry@gourry.net>
Subject: Re: [PATCH] mm/madvise: atomically clear the young bit on THP
 MADV_COLD
Message-ID: <as-dr-S6c3FALwQb@gremlin>
References: <20261013191719.95502-1-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013191719.95502-1-pfalcato@suse.de>

+cc Gregory

On Tue, Oct 13, 2026 at 08:17:19PM +0100, Pedro Falcato wrote:
> As-is, madvise_cold_or_pageout_pte_range() discards the hardware young

The function from hell... Gregory - PLEASE FIX THIS SOON :))

> bit by invalidating the PMD, doing pmd_mkold() and subsequently writing
> to the pmd again. However, it does so in a racy manner, looking at a
> possibly-stale snapshot. It's entirely possible that a write elsewhere
> set the hardware D bit, which this logic now loses.
>
> Fix it by using pmdp_test_and_clear_young(). This is an atomic
> modification of the PMD entry, and thus safe against any possible racing
> writes. As a (nice) side-effect, this elides one non-required TLB flush
> in pmdp_invalidate().

Nice, I'm guessing the tlb_remove_pmd_tlb_entry() does what we need already? (as
discussed off-list :)

>
> This bug can interact with the swapping system in complicated ways, leading
> to data loss. For instance, if a folio is marked lazyfree, but was later
> read from, and then MADV_COLD'd while racing a write to that same THP,
> dropping the dirty bit may lead to data loss as reclaim/MADV_PAGEOUT drops
> the "clean" anon folio:
>
> T0                                T1
> ================================================================
> MADV_FREE(thp)                  |
>   folio marked lazyfree         |
> read(thp)                       |
>   PMD marked young by hardware  |
>                                 | MADV_COLD(thp)
> write(thp)                      |   if (pmd_young(pmd)) {
>   PMD marked dirty by hardware  |     set(pmdp, pmd_mkold(pmd));
> MADV_PAGEOUT/reclaim            |
>   dirty bit may or may not be   |
>   set                           |
>     reclaim/pageout may drop    |
>     the folio                   |
>

Thanks, nice explanation (even if the >quoting ruins the indentation on my editor
:P) [untabbed for my benefit]

>
> Fixes: 9c276cc65a58 ("mm: introduce MADV_COLD")
> Cc: stable@vger.kernel.org
> Reported-by: Samarth Narang <samarth.colleges@gmail.com>
> Closes: https://lore.kernel.org/linux-mm/20261011132227.413217-1-samarth.colleges@gmail.com/
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/madvise.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 85ab9bc76e06..19cd3bb4d1b9 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -431,10 +431,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  		}
>
>  		if (!pageout && pmd_young(orig_pmd)) {
> -			pmdp_invalidate(vma, addr, pmd);
> -			orig_pmd = pmd_mkold(orig_pmd);
> -
> -			set_pmd_at(mm, addr, pmd, orig_pmd);
> +			pmdp_test_and_clear_young(vma, addr, pmd);

Lovely diffstat :)

>  			tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
>  		}
>
> --
> 2.55.0
>

--
Cheers, Lorenzo
