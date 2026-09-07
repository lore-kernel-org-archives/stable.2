Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5C051990F;
	Mon,  7 Sep 2026 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788797865; cv=none; b=RLJModKLA4b5Y41w9dlZ15ocjq/FEDLsHuZCVwNMEtBKXCIE0Jof2DflVSHJmOY9EqgNIkr2w4n/xf1mkG8GsHz6jTYK2of2AP9hpL8TBVIZSedWXVT2ze5I0uHgGVaB87+UF1yD1jnQ2M/PfZIgdW1soSykU53jDmw7gS+n94A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788797865; c=relaxed/simple;
	bh=IBUKXyVBs3ELYeNrmV5yec13Og1+lO7CD5WRBnH53nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnA3RRhXZuYM4Cu+5tMwoT53eqKqG9kNAWDflNk6NjScIgt2IlVAt/bntFT/chrXjXFVrrVKm8HgTs7hnBY/T+5dsCShoSp0VQ1PHKMKy27XNbjSRxJ3E17bruwTFyYi/4OLlrU9uGFN4xawZHzOP8nhs8lx4X/O+/g1lQzmyiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chjSiu0k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chjSiu0k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D921F00A3A;
	Mon,  7 Sep 2026 16:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788797860;
	bh=wOnQahPO1TmCL6FmC3Riu7SZQYrSuY8UOh5mIJltyRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=chjSiu0kxNy55FySd80YLuWpGKduvYPpWOIeXBDAEDtKqnVBNh9d2zpIacBhCSdaA
	 /hPjIqOuSUHj8c/P9fQmZl5QsN4WOnfiIOfKBSlpTDf98LalsExTWUCBri/U/G11Qu
	 463UFNmJOoS1/LOyoX+MydBYhJ4deFChj18UBUl7lXOC4G9EfqkcCO0FWNUFnMgVSu
	 ZJ0dq8yg+/MGoN7WleKNCrwoFHxPeyLQn9DKBpOtPSgfQA6XKTE7mNpQtFaKmgn8pj
	 cXgDuC+tRseK5NaxjJcE836EtT/y3wIWapSvHcDps3dvye1fYFKYf3q119INcb4rPb
	 /Z9QHNIdzdHYA==
Date: Mon, 7 Sep 2026 17:17:33 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Cedric Le Goater <clg@redhat.com>, 
	Saravanan D <saravanand@crusoe.ai>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: bypass THP tuneables for huge pfnmap
 mappings
Message-ID: <ap7jVxFLczCCsJp_@gremlin>
References: <20260827-hugepfn-allowable-orders-v1-1-94819c8807c8@kernel.org>
 <034a2687-3551-485a-a382-e7e77aa3919b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <034a2687-3551-485a-a382-e7e77aa3919b@kernel.org>

On Mon, Sep 07, 2026 at 06:14:14PM +0200, David Hildenbrand (Arm) wrote:
> On 8/27/26 21:55, Lorenzo Stoakes (ARM) wrote:
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
>
> I don't have the time to find out how these functions ended up being named, I'll
> have to trust that it will be alright.

:-O

>
> Adding to what Zi say, vma_can_map_huge_file is also confusing, no?

Yeah I agree, I had a model in my head as to why it was an OK name then when Zi
raised it I realised that my naming scheme was, in fact, terrible :)

>
> are we mapping a huge file? :)

Lol... hugetlb maybe? HW poision too? Perhaps? OK you've only been back for a
day I should stop using these swear words :P

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
