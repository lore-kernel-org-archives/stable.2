Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B8F3EDE42;
	Wed,  5 Aug 2026 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947214; cv=none; b=jbgMMwSC7OCwTgc+29Ulh/4f9XhTX/0ZPlRzf/nneSAcgE76i7UJMy4N6TZSmceYwFyeJGo6pp/ysvn0QmgpwhIsiuvucQadFas2UbhptsXuV7byGpkNe2EUtcW2pDqjKufpSGLtxdrEgsqS4eL1UCKHsHHJAdoQvEBYXh5h37A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947214; c=relaxed/simple;
	bh=VT0WkNlyaLD7bdOLFtnCMJlXDojq53wuFfizIehF1so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmVWaiLZyyy2W+gEZcbYhiF8f6t36hwF7rH5PvY+5o2Q/ktPyGCSZBlKC7kvOoOb//OoK5os0yaZL+1Z6RpmEI3OSE4Hv+naZDE6Gk8v6NYdBIe66UEC3di0PMSbNyJr8ChpzwgpaIvr7Wp7m/m+O73UrixLlwd47pTjIRK0i9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ii3HHFaP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ii3HHFaP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC2A1F000E9;
	Wed,  5 Aug 2026 16:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785947212;
	bh=fV8b/4Y/yqMyoR8AxAiGFbcq1oDUETRU4WY12VjWgDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ii3HHFaP+cLRY1G6nl+4ikP+j0AuPQEmO39D9OK2MX5r11FixTJJu4FZ3CBiNVeEZ
	 WVPF/ni06PFEfU+gLzl3vVmZ2j8E2/SncgOJ6iyKFabAVX+2L16QLJqsEw22X23u2f
	 2H6MDuPX3ALSchNr75SZhI7Zm82L+cTuuOb7wglYRCCi+FxQIG8Cw4GPEwIH9J5I9E
	 VIoxuWl5har0rDJMMs7FL+xXcNmxrP7B19vLmS0pOivktsBwidprZjqqDElhDxtaLC
	 AJBuEdqY7T+NjECJvRMG8eXMJqXPRd/K6RRUV3f/V9Ry0Pe1lS1d1FbZ+v8/61/CrA
	 vQvyiJrp7LRSg==
Date: Wed, 5 Aug 2026 17:26:35 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@kernel.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, Zi Yan <ziy@nvidia.com>, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: let special huge VMAs bypass the THP
 policy check
Message-ID: <anNjdDxP5-Oq5eXk@lucifer>
References: <20260805055544.1568534-1-clg@redhat.com>
 <anL-NZkNMSSxN0YN@lucifer>
 <4ddc95f2-8868-4be3-9839-e2d14cf35fef@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ddc95f2-8868-4be3-9839-e2d14cf35fef@redhat.com>

On Wed, Aug 05, 2026 at 06:21:30PM +0200, Cédric Le Goater wrote:
> Thanks for the quick feedback Lorenzo !
> > So I think it should be something more like the attached.
> >
> > That way all the handling remains the same and the override is applied in
> > the right place plus smaps keeps working.
>
> LGTM, do you want me to respin a v2 with what's below ? or you'd rather
> send it yourself.

Thanks, I think as it's somewhat divergent maybe better if I send it with
Reported-by/Closes if that makes sense to you?

I'd like to get David's input on it first however!

>
> C.
>
>
>
> > ----8<----
> >  From d6537260722c8741586e6295c8eea68d06087efa Mon Sep 17 00:00:00 2001
> > From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
> > Date: Wed, 5 Aug 2026 11:35:13 +0100
> > Subject: [PATCH] ideas
> >
> > ---
> >   mm/huge_memory.c | 32 +++++++++++++++++++++++++++++---
> >   1 file changed, 29 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index abc65d608c23..5fa01364f089 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -111,6 +111,34 @@ static bool vma_is_special_huge(const struct vm_area_struct *vma)
> >   	return vma_test_any(vma, VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT);
> >   }
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
> >   unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
> >   					 vm_flags_t vm_flags,
> >   					 enum tva_type type,
> > @@ -188,9 +216,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
> >   		 * Enforce THP collapse requirements as necessary. Anonymous vmas
> >   		 * were already handled in thp_vma_allowable_orders().
> >   		 */
> > -		if (!forced_collapse &&
> > -		    (!hugepage_global_enabled() || (!(vm_flags & VM_HUGEPAGE) &&
> > -						    !hugepage_global_always())))
> > +		if (!can_thp_collapse_file(vma, vm_flags, forced_collapse))
> >   			return 0;
> >
> >   		/*
> > --
> > 2.55.0
> >
>

--
Cheers, Lorenzo
