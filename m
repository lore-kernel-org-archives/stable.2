Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE4143B6C5;
	Thu, 24 Sep 2026 07:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236603; cv=none; b=SOsKPXVijYHwjiwC6fFhZbbBcu4Se2jukn6Vc7X3Sm2SK/BYJmYqw3Hi0wCUpni/M+WMJ/KtM0vd+PmivHLsexI80OX8q4FEZ2r5nCfa/779xM7D41fVP4wZ12kroIcMTOSLeUFxneHBLwV1Cb1VojEtwgDBppwcS99ii6jOxt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236603; c=relaxed/simple;
	bh=lifQK7NL3lhWVqZyGTggeDsd/4jk+HTMdgMvpeHqFkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPP87iKJdxL1jJ4jzK6ZMzvwtayu2R6ObrMS9E5cF7WvyvkEdSzqT4euy8CBIOtUc6jgVDmwz2mciRz7HcNS+1RlMZw/jbNbFbUSxQKMNozsJEYGOr1ZdHhZgp5ieTLZ4Jk1Qhl4a1tlQ0gJVrmfRCXuOjSEnIX722uc7OaQz9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odmVQ7Dt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odmVQ7Dt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14CE1F00893;
	Thu, 24 Sep 2026 07:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790236598;
	bh=AMvc3Z//XYqelk8JnFtLHUgeDJdTu8PnHAzgmjTWd/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=odmVQ7DtmdRtAwA/YGAps0oiLrwR0LA/kI1F1X+zml5UI3/3DHB+da17YrzTVC0qV
	 yH+LFPuJtIOZ1e3d0k0n/QxBncDgj2d5slyT9T8+axmeNtQu9cm4aJ3VOXKKfbIJN/
	 Jxxs/Utmeh371xIq0ZBHMAJSqKNfjoBC6GKLYGpuvhME/fL4bP8NC7+9X8KLskQu7z
	 EWUlYS/Dq1VaR0i9DlgE1AorfAS4rbTCvdUFUbG49vzFiClOLSO8fcSbWDxusmNaek
	 YQg3ejgRGzP+Vhtl/h12snOugfWYh9d8Z25MU6NXX8mHKc6NtiDSOvf+QiZcdyN/Um
	 zLnGpAu0IZzGQ==
Date: Thu, 24 Sep 2026 08:56:33 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/vma: predicate setting mmap_prepare VMA fields on new
 vma alloc
Message-ID: <arTT5RfK4gjW_f0d@gremlin>
References: <20260923-fix-mmap-prepare-overwrite-v1-1-3b3f1bfcdf5e@kernel.org>
 <a4bf1f96-787d-4c1e-9bef-52ab2be570ae@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4bf1f96-787d-4c1e-9bef-52ab2be570ae@kernel.org>

On Thu, Sep 24, 2026 at 09:19:26AM +0200, Vlastimil Babka (SUSE) wrote:
> On 9/23/26 19:45, Lorenzo Stoakes (ARM) wrote:
> > It only makes sense to manipulate VMA fields if a new VMA was allocated,
> > rather than merged.
> >
> > VMA merging does not compare vm_ops or vm_private_data, so a merged VMA
> > keeps its own, which is also what the legacy f_op->mmap path does since it
> > never touches an existing VMA.
> >
> > Currently, these fields will get overwritten by whatever state is
> > established in the mmap_prepare hook, and if the VMA was merged,
> > vm_ops->mapped will not have been called, so this could destructively clear
> > existing state without replacing it with anything valid.
> >
> > There is an implicit requirement that vm_private_data and vm_ops are
> > fungible across VMAs which means that losing the 'new' state is
> > fine.
> >
> > However in this case the 'old' state is being overwritten by potentially
> > invalid 'new' state, so this must be rectified.
> >
> > Additionally constify have_mmap_prepare while here.
> >
> > All existing in-tree users either derive state for the tree or are
> > unmergeable due to VMA flags, so this has no direct impact.
> >
> > Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> > Note that this is cc: stable to account for any possible back-ports that could
> > break it (unlikely)
>
> Does it mean that patches are on the way to mainline that will break it, but
> it's unlikely they will be backported? Or there are no such patches yet?

Nope it's highly unlikely. You'd have to introduce a brand new mmap_prepare
etc. etc.

> Just curious... if it's the first case then with the amount of random stuff
> that goes to stable these days, I'd rather assume they could be backported
> at some point :)

Suren insisted on it being a fix and I didn't really want to argue.

I thought perhaps it hit something real but when writing the patch I asked
the LLM to actually check and it seems not, which is exactly what I thought
initially and why this wasn't a fix.

Anyway it's a small change so I think it's fine for stable.

>
> or out-of-tree modules which might be affected.
>
> That is never a concern, and even suggesting it can bring hch's wrath ;)

Yeah that's what I assumed.

>
> Anyway,
>
> Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Thanks

>
>
> > ---
> >  mm/vma.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 9f0a0acf694a..6cde67883fb0 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -2849,7 +2849,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
> >  {
> >  	struct mm_struct *mm = current->mm;
> >  	struct vm_area_struct *vma = NULL;
> > -	bool have_mmap_prepare = file && file->f_op->mmap_prepare;
> > +	const bool have_mmap_prepare = file && file->f_op->mmap_prepare;
> >  	VMA_ITERATOR(vmi, mm, addr);
> >  	const pgoff_t anon_pgoff = addr >> PAGE_SHIFT;
> >  	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, anon_pgoff, vma_flags, file);
> > @@ -2892,7 +2892,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
> >  		allocated_new = true;
> >  	}
> >
> > -	if (have_mmap_prepare)
> > +	if (have_mmap_prepare && allocated_new)
> >  		set_vma_user_defined_fields(vma, &map);
> >
> >  	__mmap_complete(&map, vma);
> >
> > ---
> > base-commit: fe2ec83746e501645709761605c2464a44fd2929
> > change-id: 20260923-fix-mmap-prepare-overwrite-6304d112a4c7
> >
> > Best regards,
>

--
Cheers, Lorenzo
