Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473AE3D9689;
	Thu,  6 Aug 2026 06:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785997774; cv=none; b=IhucM5fRweC0ihFNNPn4p+YI/7YOG6+cF7jPjw0XzxuLJVORBjN1QOiwxQDctREmYIywGX7+xWeuAH+JDiVw8WUN2UV2fcGKTnqozGFr6pFry0U3LaBZkFGCpFvqh6r2fuTc+oTKKjTj7o4gQm5lMoekcg++t1AkPqBlhWJwSG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785997774; c=relaxed/simple;
	bh=ZjlVGfjNm9UzrIGKVKZMV0JjWrsbuAZwXlbz5xNJvdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLe0o/4TzLQX1kar4Q0KdOP9YqHqGXKx/oK2159HA01QM0t0JcYLSgMpHIkeExoeAuMEcAom/M9VuOZiJmvAg94LR9PYQJMzEVK8jg4kxvFk5O8Pj4axGNQQbt8NEuKhjuZTWIUSlYNDGif+U90FSH/VT3112MfbMqLjtrBImZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0TdJHLp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0TdJHLp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B571F000E9;
	Thu,  6 Aug 2026 06:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785997772;
	bh=uTUsBX7WtmPH4wCrVl7CPUs1HMuRqiZHQH/yykCv0ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i0TdJHLpfRIyVrazRatHbTvOQTLs2FrDrmZdevwhXrlB70kdbMutIMO4Q5tF3VWRj
	 mveH6kM7aX//q/uH/xGjp4JakUszPnnIo/x9yqTOXr4nLFyAZTr2QIrdbp8PPrAaS7
	 FSt0pfJJn6Gua8r5CHpaoeK9bVAmFVgjs//34NwJp02r1rt3DpHVAxhT7QL3BQMiP6
	 Alzo7gSekvASdiGktAbF2Ryg9I10oCS8N5oOjFYE2H1tMM1bNXE7yxXNRLDDRcaPuB
	 PTO9jX9BPQgavUJl98HIXkYtvOfOI00bMn5RvpJsvVqqa4mg6LLo+fzBxhW6cYrL65
	 dls2OcjdeF3tQ==
Date: Thu, 6 Aug 2026 07:29:15 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Peter Xu <peterx@redhat.com>, 
	David Hildenbrand <david@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Zi Yan <ziy@nvidia.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: let special huge VMAs bypass the THP
 policy check
Message-ID: <anQpWs6fapNVZSdt@lucifer>
References: <20260805055544.1568534-1-clg@redhat.com>
 <anL-NZkNMSSxN0YN@lucifer>
 <anPm6vGNeDxLFIkJ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anPm6vGNeDxLFIkJ@casper.infradead.org>

On Thu, Aug 06, 2026 at 02:44:10AM +0100, Matthew Wilcox wrote:
> On Wed, Aug 05, 2026 at 11:41:46AM +0100, Lorenzo Stoakes (ARM) wrote:
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index abc65d608c23..5fa01364f089 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -111,6 +111,34 @@ static bool vma_is_special_huge(const struct vm_area_struct *vma)
> >  	return vma_test_any(vma, VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT);
> >  }
> >
> > +static bool should_obey_thp_file_tunables(const struct vm_area_struct *vma,
> > +					  bool forced_collapse)
> > +{
> > +	if (forced_collapse)
> > +		return false;
> > +	VM_WARN_ON_ONCE(vma_is_anonymous(vma));
> > +	/* Huge PFN mappings allocate no folios so the policy doesn't apply. */
> > +	if (vma_test(vma, VMA_PFNMAP_BIT) && vma->vm_ops->huge_fault)
> > +		return false;
> > +	return true;
> > +}
> > +
> > +static bool can_thp_collapse_file(const struct vm_area_struct *vma,
> > +		vm_flags_t vm_flags, bool forced_collapse)
> > +{
> > +	/* Override THP tunables? */
> > +	if (!should_obey_thp_file_tunables(vma, forced_collapse))
> > +		return true;
> > +	/* THP=always? */
> > +	if (hugepage_global_always())
> > +		return true;
> > +	/* THP=madvise? */
> > +	if (!hugepage_global_enabled())
> > +		return false;
> > +	/* Has VMA had madvise(..., MADV_HUGEPAGE) applied to it? */
> > +	return vm_flags & VM_HUGEPAGE;
> > +}
> > +
> >  unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
> >  					 vm_flags_t vm_flags,
> >  					 enum tva_type type,
> > @@ -188,9 +216,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
> >  		 * Enforce THP collapse requirements as necessary. Anonymous vmas
> >  		 * were already handled in thp_vma_allowable_orders().
> >  		 */
> > -		if (!forced_collapse &&
> > -		    (!hugepage_global_enabled() || (!(vm_flags & VM_HUGEPAGE) &&
> > -						    !hugepage_global_always())))
> > +		if (!can_thp_collapse_file(vma, vm_flags, forced_collapse))
> >  			return 0;
> >
> >  		/*
>
> I think 'thp_' in all of this is confusing.  DAX isn't THPs.  PFNMAPs
> aren't THPa.  There's other reasons to implement huge_fault that aren't
> THPs.  Can we rename all of this to drop the 'thp_' string, starting
> with thp_vma_allowable_order()?

Matthew, are you baiting the churnmeister 3000 into a refactor here? :)

I despise this function and agree with you entirely.

So maybe I could add a few other patches first before the change to improve
the horror show that is this function and its auxiliaries also :)

--
Cheers, Lorenzo
