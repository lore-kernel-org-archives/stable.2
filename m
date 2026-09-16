Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309DD4F6468;
	Wed, 16 Sep 2026 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789564727; cv=none; b=iWZMyrLTeWPIHp8ZWSzbamlB8oAdQtVX9sWqZ9nPyBoIev76ZYaAHoN8U6QLuepas4H5dqDLBh9qJ0fvxBbhfB+fESLvcLNHJguGgW/h7eSmRQV/DUZ21jCznG7Dn/4jIRs2wR8eKi0c+k7Y0T0Mq99YkzGOdte2H3cvCDg0SV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789564727; c=relaxed/simple;
	bh=oP0Rox2ckShYxxmd6vBE3szxUuxB0giBdWHfz7+QWzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmxjBpOtpnYsEocOFnNmoJFkJDVNovdUvslMjhj/J9XRZl5qedA5xP2k+ECgrcx3vyzBBumA/Q05xEMK54mjCG9dsfAtwlYFv2TC0RKONz0Ncm5DNXJ+fLgLJGca661BKCzPHSJhYPJwxBjArCG2o9xNGqbHuXfXX0CelRJcy2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJaqVsvr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJaqVsvr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1CD1F000FF;
	Wed, 16 Sep 2026 13:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789564722;
	bh=DEhcki1FWir9Oh5eBIg+At1+YvFsWkSvwkm/yPub4nY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VJaqVsvrsk5KkE/cdHDLawuZ/0bUQ892OUWjj3oraqjRyD+GzzDAZGAS25s0UI/00
	 IQyw7b+SX/pSwjiG46K193E40Mo3RlNFqM+4ZsRrDW/2bspstiP7cDVTg7L3z5iu/t
	 GTvfL8Bcl/cBCmOshtjmSgJwY/bSV0d6jd+MCiXK21guK72klUVTr/uiuM4MOidf2c
	 ThGTZl55eN3W7yl5jNq1HyklXXe0OpgE6tOuIbKn4ald8+9gR0NxzDP8JT2ANpxRA/
	 IW0Og3+QGPbV+qHSl94PwJTe/Cgu5M26QdA2zoSRG2+nCk/aNxpkxt/dcUQ6vXmFRr
	 rjuvCWet4NYZA==
Date: Wed, 16 Sep 2026 14:18:36 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, liam@infradead.org, david@kernel.org, vbabka@kernel.org, 
	jannh@google.com, wangjiexun@tinylab.org, sashiko-bot <sashiko-bot@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: reclaim isolated folios if PTE restart fails
Message-ID: <aqqTtW3vjfzH8bcY@gremlin>
References: <20260912110832.3203902-1-gourry@gourry.net>
 <aqloB0zm3RjJ47m1@gremlin>
 <aqlzzwLOVT79Ti_7@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqlzzwLOVT79Ti_7@gourry-fedora-PF4VCD3F>

On Tue, Sep 15, 2026 at 01:00:31PM -0400, Gregory Price wrote:
> On Tue, Sep 15, 2026 at 04:55:47PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > index 574aa2bb7c7e..ba5a3d77241a 100644
> > > --- a/mm/madvise.c
> > > +++ b/mm/madvise.c
> > > @@ -464,7 +464,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> >
> > This function is truly some of the absolute worst code I've read in
> > mm. Shocking.
> >
>
> relevant meme: https://i.imgur.com/W0N40BK.png

Content not viewable in my region :'( seems I do not have a loicense for
that!

>
> No argument here. This function in particular is really horrendous.
>
> I think i'm now 4 or 5 stacks deep on the "Thanks for fixing a bug, but
> while reviewing your fix sashiko found yet another CVE-worthy bug".

Yeah, I WISH it wouldn't do that.

I mean it's helpful to some degree and it finds real stuff.

But it's _where_ it does that and the workload++ aspect of it.

>
> I'm convinced (like you below) madvise needs some attention.
>
> > >  restart:
> > >  	start_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> > >  	if (!start_pte)
> > > -		return 0;
> > > +		goto out;
> > >  	flush_tlb_batched_pending(mm);
> > >  	lazy_mmu_mode_enable();
> > >  	for (; addr < end; pte += nr, addr += nr * PAGE_SIZE) {
> > > @@ -568,6 +568,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> > >  			folio_deactivate(folio);
> > >  	}
> > >
> > > +out:
> >
> > Seems odd to put this here for a condition that explicitly guarantees
> > !start_pte? It should be before the if (pageout) reclaim_pages(...);
> > surely?
> >
>
> I wanted to prevent any future use of the label from skipping the
> start_pte check.  The function is so bad I was err'ing on the side
> of being a bit defensive without making it worse.
>
> I suppose reasonable to say the goto is worse.

Yeah I know it's all a bit much of a muchness, and obviously my suggestion
_duplicates code_ which is also not wonderful.

But the control flow in the function I think is a bigger issue.

>
> > I honestly wonder whether, rather than adding yet another label/goto into this
> > absolute bloody mess, whether we should just live with a bit of duplication and do:
> >
> > 	if (!start_pte) {
> > 		if (pageout)
> > 			reclaim_pages(&folio_list);
> > 		return 0;
> > 	}
> >
> > I actually think that'd be clearer at this point than throwing in some more
> > indirection.
> >
>
> I'll spin a v2.

Thanks!

>
> > That's for the backport but somebody needs to rework this entire bloody
> > function going forwards...
>
> The longer I look at madvise, the more I think it is a wart on mm/
> as-written.  A userland-driven page table walker that requires all
> the special-casing of Yooj Pages, zone device, swap, soft leafs, a
> bunch of tlb flushing 5-tabs deep...
>
> Scary surface.
>
> I've been trying to think about how we might make this more reasonable,
> but generalizing the different walkers across mm is pretty hard.

I mean it's a vital interface, but it often feels the wrong one (it's meant
to be advice but several cases cannot actually be 'advisory'), and it's all
a bit of a mess.

I wouldn't be against a new interface (new system calls aren't a big deal)
but it'd have to be carefully thought through.

Like say, the complete diametric opposite of e.g. prctl :)

Anyway we have to keep supporting what's there indefinitely because users
and such and in any case we can certainly improve hellish code in
madvise.c.

>
> ~Gregory

--
Cheers, Lorenzo
