Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D26392C2C;
	Fri, 26 Jun 2026 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782470541; cv=none; b=pM0Yu2UIiKatjrBcDeqZ1IsBJzRPYXvvpLdqDdn8DEQ7432Rx4CgK4CHYDs6g+fA6qRfu1pIQ2OVZ9jbYRT6AScGGCmIOyS55kpUuqEgYRSW4ikkTknlVKyn8mT0ZXVBERdycTXtCpM1+ez6QaPulPgdZy3HiHZlJ/zorSdyq8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782470541; c=relaxed/simple;
	bh=ifmE2fTTYxC5X2K9/+qgYtK9IlDAJFEqdYMOf7u7BPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lra9spIlYvSoeK6SzXykRooP1ggb7KDICmVmcfpvuWK0fTm9jE1JIa4pN+y3dg9WKtIFP/10qlj25BJTvd7e77TLfyBIcqEfG/7IgzRO5fjHYIwIDrxjuqcuiOIqEk/SjDNtGDAVMBzM/CASLTEUJTVIQLMACJUr5du1FDon6+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lugqbHiO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lugqbHiO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA221F000E9;
	Fri, 26 Jun 2026 10:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782470539;
	bh=Z7InqrhYDZxSMwx3T3i/srdxrW6Z6e1Zj0iTt0IoNFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lugqbHiOMkQrqlrzp0U15pRPuhDteUk5H7BEdJONshnVNA0CXIbHdRc2edNnUu1E2
	 7Bi1hgNrF0B2RyqdJ2o81qk8D59rNSdiLSfOwGASJ+k6dO6ysZICDG4octJwRi1nFd
	 OCEO+fXQ0H5psDRdzNu/4ocXbTBEmFo0pd3a2mqUUxKjrbPMyNeW5GMb7X8X3C4+BI
	 K666MVGJ99s4fTHO8Cn8/YcNYRWR/6t5sdBx+6ZYFznId8LQntosa/9e+gdDpOHGfe
	 +23hHPYqeGQeYP76l30eT4T93pbk30s2YwQWI7q/ZuP1QRWmO/QcENqGsH1CiAdeA9
	 nGiR+WLH7lBmg==
Date: Fri, 26 Jun 2026 11:42:10 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org, 
	riel@surriel.com, liam@infradead.org, vbabka@kernel.org, harry@kernel.org, 
	jannh@google.com, ziy@nvidia.com, sj@kernel.org, balbirs@nvidia.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [Patch mm-hotfixes v4] mm/page_vma_mapped: fix device-private
 PMD handling
Message-ID: <aj5XVwsQ4rOLTzr5@lucifer>
References: <20260624065353.1622-1-richard.weiyang@gmail.com>
 <d060cadd-34f8-42da-b7f7-c8d295050436@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d060cadd-34f8-42da-b7f7-c8d295050436@kernel.org>

On Fri, Jun 26, 2026 at 12:07:56PM +0200, David Hildenbrand (Arm) wrote:
> On 6/24/26 08:53, Wei Yang wrote:
> > Commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration support
> > device-private entries") introduced the concept of device-private
> > PMD entries, but did not correctly update the rmap walk code to
> > account for them.
> >
> > As a result, when page_vma_mapped_walk() encounters device-private
> > PMD entries, it takes no action other than to acquire the PMD lock
> > and exit.
> >
> > However this is highly problematic for two reasons - firstly,
> > device private entries possess a PFN so check_pmd() needs to be
> > called to ensure an overlapping PFN range.
> >
> > Secondly, and more importantly, if PVMW_MIGRATION is set the
> > caller assumes the returned entry is a migration entry, resulting
> > in memory corruption when the caller tries to interpret the device
> > private entry as such.
> >
> > In addition, commit 146287290023 ("mm/huge_memory: implement
> > device-private THP splitting") allowed device private PMDs to be
> > split like THP mappings, but again did not update this code path.
> >
> > As a result, we might race a PMD split prior to acquiring the PMD
> > lock.
> >
> > This patch addresses all of these issues by invoking check_pmd(),
> > ensuring PMVW_MIGRATION is not set and checks whether a split raced
> > us we do for PMD THP and migration entries.
> >
> > Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> > Suggested-by: David Hildenbrand <david@kernel.org>
> > Cc: David Hildenbrand <david@kernel.org>
> > Cc: Balbir Singh <balbirs@nvidia.com>
> > Cc: SeongJae Park <sj@kernel.org>
> > Cc: Zi Yan <ziy@nvidia.com>
> > Cc: Lorenzo Stoakes <ljs@kernel.org>
> > Cc: Lance Yang <lance.yang@linux.dev>
> >
> > ---
> > v4:
> >   * refine subject and commit log based on Lorenzo's suggestion
> >   * put pmd device-private entry handling in its own if branch,
> >     suggested by Lorenzo
> >
> > v3:
> >   * remove cleanup part, only fix the issue for device-private entry
> >   * refine user effect description based on Lorenzo's suggestion
> >
> > v2: https://lore.kernel.org/all/20260616063436.20455-1-richard.weiyang@gmail.com/T/#u
> >   * specify the possible error case of current code and user visible effect
> >   * besides fix, cleanup the pmd entry handling based on David's suggestion
> >
> > v1: https://lore.kernel.org/linux-mm/20260508013728.21285-1-richard.weiyang@gmail.com/
> > ---
> >  mm/page_vma_mapped.c | 20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > index 2ccbabfb2cc1..17dff8aab9f9 100644
> > --- a/mm/page_vma_mapped.c
> > +++ b/mm/page_vma_mapped.c
> > @@ -269,14 +269,24 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> >  			/* THP pmd was split under us: handle on pte level */
> >  			spin_unlock(pvmw->ptl);
> >  			pvmw->ptl = NULL;
> > -		} else if (!pmd_present(pmde)) {
> > -			const softleaf_t entry = softleaf_from_pmd(pmde);
> > +		} else if (pmd_is_device_private_entry(pmde)) {
> > +			softleaf_t entry;
> > +
> > +			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
> > +			pmde = *pvmw->pmd;
> > +			entry = softleaf_from_pmd(pmde);
> >
> > -			if (softleaf_is_device_private(entry)) {
> > -				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
> > +			if (likely(softleaf_is_device_private(entry))) {
> > +				if (pvmw->flags & PVMW_MIGRATION)
> > +					return not_found(pvmw);
> > +				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
> > +					return not_found(pvmw);
> >  				return true;
> >  			}
> > -
> > +			/* device-private pmd was split under us: handle on pte level */
> > +			spin_unlock(pvmw->ptl);
> > +			pvmw->ptl = NULL;
> > +		} else if (!pmd_present(pmde)) {
> >  			if ((pvmw->flags & PVMW_SYNC) &&
> >  			    thp_vma_suitable_order(vma, pvmw->address,
> >  						   PMD_ORDER) &&
>
> This is extremely hard to review given the existing crap handling here. I'm
> really sorry, but it makes my head hurt (I'm not kidding :) ).
>
> It's completely unclear why we only have to check for a subset of the cases
> after taking the lock.
>
> Could we simply extend the existing migration pmd handling and leave the
> !pmd_present() case for pmd_none()?
>
> That leaves no question to "which transitions are actually allowed", including
> "could we accidentally assume something is a page table when really it isn't".
>
>
> So what about something like the following?
>
> The "thp_migration_supported()" is not required when checking for
> pmd_is_migration_entry(), as that defaults to "false" when not compiled in.
>
> Untested:
>
>
> From 048ecd33673ec649e168fbbb97749a7c0e344fcd Mon Sep 17 00:00:00 2001
> From: "David Hildenbrand (Arm)" <david@kernel.org>
> Date: Fri, 26 Jun 2026 12:03:40 +0200
> Subject: [PATCH] tmp
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/page_vma_mapped.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 2ccbabfb2cc17..ed2a23a90e8dd 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -243,21 +243,31 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  		 */
>  		pmde = pmdp_get_lockless(pvmw->pmd);
>
> -		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
> +		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
> +		    pmd_is_device_private_entry(pmde)) {
>  			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>  			pmde = *pvmw->pmd;
> -			if (!pmd_present(pmde)) {
> +			if (pmd_is_migration_entry(pmde)) {
>  				softleaf_t entry;
>
> -				if (!thp_migration_supported() ||

Do we care about this? Or is !tmp_migration_supported() -> implies you
wouldn't see a migration entry here anyway?

Maybe worth a VM_WARN_ON_ONCE()?

> -				    !(pvmw->flags & PVMW_MIGRATION))
> +				if (!(pvmw->flags & PVMW_MIGRATION))
>  					return not_found(pvmw);
>  				entry = softleaf_from_pmd(pmde);
> +				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
> +					return not_found(pvmw);
> +				return true;
> +			} else if (pmd_is_device_private_entry(pmde)) {
> +				softleaf_t entry;
>
> -				if (!softleaf_is_migration(entry) ||
> -				    !check_pmd(softleaf_to_pfn(entry), pvmw))
> +				if (pvmw->flags & PVMW_MIGRATION)
> +					return not_found(pvmw);
> +				entry = softleaf_from_pmd(pmde);
> +				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>  					return not_found(pvmw);
>  				return true;
> +			} else if (!pmd_present(pmde) ){
> +				return not_found(pvmw);
>  			}
>  			if (likely(pmd_trans_huge(pmde))) {
>  				if (pvmw->flags & PVMW_MIGRATION)
> @@ -270,12 +280,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  			spin_unlock(pvmw->ptl);
>  			pvmw->ptl = NULL;
>  		} else if (!pmd_present(pmde)) {
> -			const softleaf_t entry = softleaf_from_pmd(pmde);
> -
> -			if (softleaf_is_device_private(entry)) {
> -				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
> -				return true;
> -			}
>
>  			if ((pvmw->flags & PVMW_SYNC) &&
>  			    thp_vma_suitable_order(vma, pvmw->address,

Overall though this seems fine to me.

> --
> 2.43.0
>
>
> --
> Cheers,
>
> David

Thanks, Lorenzo
