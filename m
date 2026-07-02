Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27483101C8;
	Thu,  2 Jul 2026 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010832; cv=none; b=S+DE/RHc2JTlYo+Q8Ulx27UWBBc/l+BL8DBjWCla0z3FQfzR+06V8sMbBEkzrSn4Ot0sy8tBKiN/pb2MACGRVO/s5vnm0Uq53rX2KHOZ7ANH7dvAjnr0AoTta7FHY5Hvqah50skRIlI8HTrXlPG26bbJyePoexh7h2cdLEWUEME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010832; c=relaxed/simple;
	bh=5XUkBQcAn9U6Y07aslj6I2AgcOM8TP0WDIngo4IAEtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idaGbN4gOEooYyxAywWl8L5yBS3gUIYIlraMnB8ZFC8wHrScrs0mbfMxNlLKlDTGIGPR0ljf7/9TSGYH7fN3wqfS68Oa1/hQY3/EE86Yk537dzzyFkeJOXvf8BN67SpwUbdpIn0oJtBCSSFt7uFj9hQsznxhRwBJnVZaemWX3Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ng793fMZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ng793fMZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3191F000E9;
	Thu,  2 Jul 2026 16:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783010831;
	bh=taOAjbXieJFMNm4bP1CgHm93WARmoJbQ3VZALpeoKYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ng793fMZgoIdBJrF15JJRcVZc4Bd+e1Y5NlbggtZpjY40sADDO0g7AShASlnCbxTn
	 DULmdgFBcsXTUAqkhid4+Ghqkgk76u9EKOUrjSby0N5E+UBRVtc8efeMDRD3IByK4f
	 KiK0PBm5LkZpiwQCqgpdkpanN8QQnkdwH6Yy/jqyHYSR7oNcnunqWf+cxZsucx4rfd
	 DNPxHWL14kPBV6UTC8s+SccwkwjybjXqiKcRUo11fZnfUEPoNKr9CarED87qEIw6Tp
	 9dfE1AfX5ojzy6hll3aFSdibY+wokynzZwX2I4vZ7dzJ6lULKP3dZf6svsaZcsH7dF
	 Vtch1kZDF/LtA==
Date: Thu, 2 Jul 2026 17:47:01 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, linux-mm@kvack.org, 
	akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	liam@infradead.org, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, yang@os.amperecomputing.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/huge_memory: set PG_has_hwpoisoned only after new
 folio head is established
Message-ID: <akaV3b1eziZ2bq21@lucifer>
References: <20260701174235.3173401-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701174235.3173401-1-riel@surriel.com>

On Wed, Jul 01, 2026 at 01:42:34PM -0400, Rik van Riel wrote:
> __split_folio_to_order() copies the hwpoison state onto each new
> sub-folio while splitting a folio to a non-zero order.  It does so via
>
> 	if (handle_hwpoison && page_range_has_hwpoisoned(new_head, new_nr_pages))
> 		folio_set_has_hwpoisoned(new_folio);
>
> *before* clear_compound_head(new_head)/prep_compound_page(new_head, ...)
> turns @new_head from a tail page into a proper folio head.
>
> PG_has_hwpoisoned is a FOLIO_SECOND_PAGE flag, so folio_set_has_hwpoisoned()
> resolves to folio_flags(folio, 1).  With the new compound_info-based
> page-flags layout, folio_flags() asserts the page is not a tail:
>
> 	VM_BUG_ON_PGFLAGS(page->compound_info & 1, page);
> 	VM_BUG_ON_PGFLAGS(n > 0 && !test_bit(PG_head, &page->flags.f), page);
>
> At the current call site @new_head still has the tail marker
> (compound_info bit 0 set, PG_head clear), so on CONFIG_DEBUG_VM kernels
> this hits:
>
>   kernel BUG at include/linux/page-flags.h:354
>   folio_flags+0x82
>   folio_set_has_hwpoisoned
>   __split_folio_to_order
>   __split_unmapped_folio
>   __folio_split
>   truncate_inode_partial_folio  (shmem hole-punch / MADV_REMOVE)
>
> Reproduced by syzkaller: hwpoison-inject a few subpages of a large shmem
> folio, then MADV_REMOVE (fallocate punch hole) on the same range, which
> splits the partial folio to a non-zero order.
>
> memory_failure() tries to split the poisoned folio to order 0 first, but
> that split is best-effort; when it fails the folio is left large with
> PG_has_hwpoisoned set, the case fa5a06170036 added this hwpoison copying
> for.
>
> Move the folio_set_has_hwpoisoned() call to after
> clear_compound_head()/prep_compound_page(), where @new_folio is a real
> order-new_order head folio (handle_hwpoison implies new_order != 0, so a
> second page always exists).  The flag still lands on the same struct page
> (page[1] of the new folio); only the ordering relative to compound-head
> setup changes, satisfying the FOLIO_SECOND_PAGE precondition.
>
> Fixes: fa5a06170036 ("mm/huge_memory: preserve PG_has_hwpoisoned if a folio is split to >0 order")
> Signed-off-by: Rik van Riel <riel@surriel.com>

The actual logic looks good, thanks for fixing this, and the comment is much
nicer now :) So:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

> Assisted-by: Claude:claude-opus-4-8
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Tested-by: Lance Yang <lance.yang@linux.dev>
> Cc: stable@vger.kernel.org
> ---
> v2:
>  - cleaned up comment (Lorenzo)
>  - consistent changelog grammar, plus rationale on why this path exists (David)
>  - Cc: stable (Zi)
>
>  mm/huge_memory.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2bccb0a53a0a..b5d1e9d4463d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3587,10 +3587,6 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>  				 (1L << PG_dropbehind) |
>  				 LRU_GEN_MASK | LRU_REFS_MASK));
>
> -		if (handle_hwpoison &&
> -		    page_range_has_hwpoisoned(new_head, new_nr_pages))
> -			folio_set_has_hwpoisoned(new_folio);
> -
>  		new_folio->mapping = folio->mapping;
>  		new_folio->index = folio->index + i;
>
> @@ -3612,6 +3608,14 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>  			folio_set_large_rmappable(new_folio);
>  		}
>
> +		/*
> +		 * PG_has_hwpoisoned is on the 2nd page, so set it after
> +		 * the compound head is prepped.
> +		 */

Great thanks!

> +		if (handle_hwpoison &&
> +		    page_range_has_hwpoisoned(new_head, new_nr_pages))
> +			folio_set_has_hwpoisoned(new_folio);
> +
>  		if (folio_test_young(folio))
>  			folio_set_young(new_folio);
>  		if (folio_test_idle(folio))
> --
> 2.53.0-Meta
>

Cheers, Lorenzo
