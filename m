Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE72C3CD8BB;
	Fri, 28 Aug 2026 07:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787901102; cv=none; b=KE/PG0VpfSwREFu0O/ZMAh3LsBsuOftt+IbUBjwjK5C0MhHesmmVEtQPT89WYkNvTsQGGT5SbWRvZ3gc52Ajs+bMM2cqHCUph2feCjn6MjYfIy9VfSle6VtACPJZVfkWuhg6B/oPf6JC470c1HoqavpYST88GtpibogEj3Bfefw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787901102; c=relaxed/simple;
	bh=74uRMhY+OtOFVMcK+Dbj4/ITYszwPXslA4rUWfFmKTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmlOzNAPUguAlTNphXt5KSAHUDndNKgWXjw0uzbe5gyvx2fRjP7kyMlPb8qIjYEJsw+gdPY/MRscLh9xMAHu3m893Gn26N1PxmJuB84lojhpqBTaj/40bZ2H9xvDVa1giQhGUeSiacIuVkm1Ko1wle2m0AeEijvg6iNvf7EThaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQO7tg5L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQO7tg5L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3981F000E9;
	Fri, 28 Aug 2026 07:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787901098;
	bh=Nlvtq8RrY4Qv1BwWlfkIuckX4fyEMKpcHNCZEpNZD1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LQO7tg5LJMeiaUlf4a5H7/JysPrXdJg6wWW6gAPJHdrP//LipPDnv3j2P+z5oJifu
	 ttdApyw0xT3NW4RHj9q26RZUz/UY38/m1vrm3PQ369Ezl/ttVkOK/4rKaNz2cb7DNA
	 ORPvN9x+XNb4nzBNb6MKiwqb7laHIaP+jTiLbOnePwZjZSL056DXh8Xfi/kKU7eG57
	 lPkXI6PjMfTVH8laDKmUwoRCM/hnw6jjRHTRiOitxxUN5ysdv7HeEnUa479ld34MbZ
	 ons+fV7jS1m7b9RDaYPkBMqqyMkJEqOUKDuI5NPgIHP0iKT4O6WtjPHivhePxqiadR
	 rNbRhQ9ePvwag==
Date: Fri, 28 Aug 2026 08:11:32 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, Peter Xu <peterx@redhat.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Cedric Le Goater <clg@redhat.com>, Saravanan D <saravanand@crusoe.ai>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: bypass THP tuneables for huge pfnmap
 mappings
Message-ID: <apEzvfGgsvbc3vBI@gremlin>
References: <20260827-hugepfn-allowable-orders-v1-1-94819c8807c8@kernel.org>
 <DL08J4JGJ4UK.2G92WO0NK8XU3@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DL08J4JGJ4UK.2G92WO0NK8XU3@nvidia.com>

On Thu, Aug 27, 2026 at 10:52:24PM -0400, Zi Yan wrote:
> On Thu Aug 27, 2026 at 3:55 PM EDT, Lorenzo Stoakes (ARM) wrote:
> > The sysfs THP tuneables at /sys/kernel/mm/transparent_huge_pages/ rather
> > confusingly only control the behaviour of THP in some instances.
> >
> > They are not applicable to MADV_COLLAPSE operations, nor to DAX mappings.
> >
> > Long-term, THP is predicated upon compaction being able to obtain large
> > folios to populate THP ranges.
> >
> > However, vm_normal_folio() returns NULL for PFN map mappings, thus their
> > reference count is maintained by the driver, not core mm.
> >
> > As a consequence, the folios are not subject to reclaim nor compaction, so
> > are not truly part of the THP mechanism at all.
> >
> > However, since commit 5dd40721f147 ("mm: allow THP orders for PFNMAPs")
> > introduced the ability to establish huge PFN maps, they have been subject
> > to THP tuneables.
> >
> > This is incorrect - if a huge PFN map is available (defined by
> > vma->vm_ops->huge_fault being non-NULL for a VMA_PFNMAP_BIT VMA), then it
> > should be mapped huge upon fault-in.
> >
> > Correct this by explicitly checking for this while ensuring that smaps
> > continues to accurately report THPeligible statistics.
> >
> > While here, abstract the entire file-backed THP check in
> > vma_can_map_huge_file(), with sensible separation of logic into helper
> > functions.
> >
> > Note that drm_gem_shmem_mmap() and panthor_gem_mmap() establish huge PFN
> > maps of shmem folios, however they are marked unevictable in
> > drm_gem_get_pages(), and in any case would fail the reference check in
> > __remove_mapping() even if they weren't.
> >
> > Failing to map huge PFN maps has resulted in significant real-world
> > performance degradation, see links for details.
> >
> > Reported-by: Cedric Le Goater <clg@redhat.com>
> > Closes: https://lore.kernel.org/linux-mm/20260805055544.1568534-1-clg@redhat.com/
> > Reported-by: Saravanan D <saravanand@crusoe.ai>
> > Closes: https://lore.kernel.org/linux-mm/20260821070520.25759-1-saravanand@crusoe.ai/
> > Fixes: 5dd40721f147 ("mm: allow THP orders for PFNMAPs")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  mm/huge_memory.c | 86 +++++++++++++++++++++++++++++++++++++++++---------------
> >  1 file changed, 64 insertions(+), 22 deletions(-)
>
> I checked the code logic and find everything matches except the intended
> pfnmap check for the fix.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Thanks! :)

>
> Some nits on the function names below, but feel free to ignore.
>
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index afbb5974bd22..4bf7b670586d 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -92,7 +92,7 @@ unsigned long huge_anon_orders_madvise __read_mostly;
> >  unsigned long huge_anon_orders_inherit __read_mostly;
> >  static bool anon_orders_configured __initdata;
> >
> > -static inline bool file_thp_enabled(struct vm_area_struct *vma)
> > +static inline bool file_thp_enabled(const struct vm_area_struct *vma)
> >  {
> >  	struct inode *inode;
> >
> > @@ -118,6 +118,67 @@ static bool vma_is_special_huge(const struct vm_area_struct *vma)
> >  	return vma_test_any(vma, VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT);
> >  }
> >
> > +static bool vma_bypass_thp_tuneables_file(const struct vm_area_struct *vma,
> > +		enum tva_type type)
> > +{
> > +	const bool has_huge_fault = vma->vm_ops->huge_fault;
> > +
> > +	/* MADV_COLLAPSE ignores tuneables. */
> > +	if (type == TVA_FORCED_COLLAPSE)
> > +		return true;
> > +	/* Huge PFN mappings are uncompactable so the policy doesn't apply. */
> > +	if (vma_test(vma, VMA_PFNMAP_BIT) && has_huge_fault)
> > +		return true;
> > +	return false;
> > +}
> > +
> > +static bool vma_thp_tuneables_allow_file(vm_flags_t vm_flags)
> > +{
> > +	/* THP=always? */
> > +	if (hugepage_global_always())
> > +		return true;
> > +	/* THP=madvise and marked MADV_HUGEPAGE? */
> > +	if (hugepage_global_enabled() && (vm_flags & VM_HUGEPAGE))
> > +		return true;
> > +	return false;
> > +}
> > +
> > +static bool vma_check_thp_tuneables_file(const struct vm_area_struct *vma,
> > +		vm_flags_t vm_flags, enum tva_type type)
> > +{
> > +	return vma_bypass_thp_tuneables_file(vma, type) ||
> > +		vma_thp_tuneables_allow_file(vm_flags);
>
> Naming is hard, but

Yes :)

> 1. is vma_allow_thp_tuneables_file() better? Then all three helpers are
> vma + a verb + thp_tuneables_file().

That's a good idea! Much better thanks.

>
> 2. is vma_file_ a better prefix than putting file at the end?

Yeah, it's an annoying one as kinda want to say 'file-backed VMA' but I think
you're right vma_xxx_file() -> vma_file_xxx() is better.

Andrew - could you fix that up in place?

Obviously if there's further feedback I can respin as well.

>
>
> Another idea is to put all checks in one function and just add some comments
> on bypassing ones and allowed ones.
>
> > +}
> > +
> > +static bool vma_can_map_huge_file(const struct vm_area_struct *vma,
> > +		vm_flags_t vm_flags, enum tva_type type)
> > +{
> > +	const bool has_huge_fault = vma->vm_ops->huge_fault;
> > +
> > +	/*
> > +	 * Enforce THP collapse requirements as necessary. Anonymous vmas
> > +	 * were already handled in thp_vma_allowable_orders().
> > +	 */
> > +	if (!vma_check_thp_tuneables_file(vma, vm_flags, type))
> > +		return false;
> > +
> > +	switch (type) {
> > +	case TVA_PAGEFAULT:
> > +		/*
> > +		 * Trust that ->huge_fault() handlers know what they are doing
> > +		 * in fault path.
> > +		 */
> > +		return has_huge_fault;
> > +	case TVA_SMAPS:
> > +		if (has_huge_fault)
> > +			return true;
> > +		fallthrough;
> > +	default:
> > +		/* Only regular file is valid in collapse path. */
> > +		return file_thp_enabled(vma);
> > +	}
> > +}
> > +
> >  unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
> >  					 vm_flags_t vm_flags,
> >  					 enum tva_type type,
> > @@ -190,27 +251,8 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
> >  						   vma, vma_start_pgoff(vma), 0,
> >  						   forced_collapse);
> >
> > -	if (!vma_is_anonymous(vma)) {
> > -		/*
> > -		 * Enforce THP collapse requirements as necessary. Anonymous vmas
> > -		 * were already handled in thp_vma_allowable_orders().
> > -		 */
> > -		if (!forced_collapse &&
> > -		    (!hugepage_global_enabled() || (!(vm_flags & VM_HUGEPAGE) &&
> > -						    !hugepage_global_always())))
> > -			return 0;
> > -
> > -		/*
> > -		 * Trust that ->huge_fault() handlers know what they are doing
> > -		 * in fault path.
> > -		 */
> > -		if (((in_pf || smaps)) && vma->vm_ops->huge_fault)
> > -			return orders;
> > -		/* Only regular file is valid in collapse path */
> > -		if (((!in_pf || smaps)) && file_thp_enabled(vma))
> > -			return orders;
> > -		return 0;
> > -	}
> > +	if (!vma_is_anonymous(vma))
> > +		return vma_can_map_huge_file(vma, vm_flags, type) ? orders : 0;
> >
> >  	if (vma_is_temporary_stack(vma))
> >  		return 0;
> >
>
> The rest looks great to me. Thanks.

Thanks!

>
>
> --
> Best Regards,
> Yan, Zi
>

--
Cheers, Lorenzo
