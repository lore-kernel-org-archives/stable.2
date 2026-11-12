Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484377;
	b=hC2HqRFaNhEfyUJjhjH5wPEw7Zojp67w3+Oo70tVRGoBt8G8dnoWFarTvTUwUErFzqLz
	 dRyelriGhiKUzN0MgmK3/4wZwCvwJIiCcH+dFGTPca8WUALJtuIKmLJ8z3Bsy0hbv3v+J
	 TWvBwoMLZ1uaqTz01vQcGQGQoYJzoZMPcAKkK0meloNRyoCifcILww/OBDi4dP/7sAIur
	 e+hj7OdGNZjtU6lOV50rst6/cSmNC46qai4sus0kJKqgj2XMAu3RrN8t7ZbNWZ0AaAfMp
	 d/ZUZXcIxMwRJI64l6j56t1IwNfs8H7PexXuowvUj1oRLNnvYPtR0TdlNUzs6uqJpqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484377;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mwn/H1ULONfD3r8MGUfyFZepAjOONqSHtVOfwqC7R44=;
	b=Oxq346R2fRCx+nru7mpRbeyhEfaSr0DobM06AY0j7kaIV9En/zmyEcyOcf0zEqoBNyXl
	 ts36a1kqSLe5vaua1BPf4IUy/1XcyES8vxa7M6IlkG+dYZHgU8WEdz8Ds9HITK1IO+Pjb
	 NmGozWIK2sAbVQobrag0S10/GwuO4jfAu1pUBcHiSRQsp25gwV0TR7rGho0TfZkabPPki
	 xUANJEYIVtxMgyimPySWgnCCPFR5X+6IXo4glzsuhX1O+qWfjrRjETJ+vSj/GF2VT4Oup
	 ex+cfTmLmf51pFZjqhohynTV5MUapnj/TmV6KjQdISHznLuDgZR4I8GC/kYu1N5V3Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n73BoZfW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A55606A33B;
	Thu, 12 Nov 2026 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n73BoZfW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AFC1F00A06;
	Thu, 12 Nov 2026 11:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794484376;
	bh=mwn/H1ULONfD3r8MGUfyFZepAjOONqSHtVOfwqC7R44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n73BoZfWq97QkN/EzmbuARqlOgkw571PAQbg9exHKtPkxPfLWofEF3xx49ExQI0+5
	 NP7AVrlK+9cNoWfkzTQe8yBsYysMxwPj7QUvfullML+BTgnwt+niwBFJ4djUkPZJhj
	 u6DmKuJ63HSV8sLPOkQLGdgtwRQ6RQpEjkwL8WSFEcC5i1lk/REmtDn0ONN8B0fZFp
	 KWkLDbCPyrj8njpmsNXUwgIiAnGNXbD/W3krNa+IIu6u5Jasv+5pY51IpfMF9/2E1L
	 EJxh+zfJfG5qrKbAwulb0FfxElREfauArGku1EH6kDQbGoA0jT0iwqZaeqUalrXJE5
	 nEFAmwZULpIuQ==
Date: Thu, 12 Nov 2026 11:52:46 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com, 
	byungchul@sk.com, david@kernel.org, gourry@gourry.net, jannh@google.com, 
	joshua.hahnjy@gmail.com, liam@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com, mhocko@suse.com, 
	pfalcato@suse.de, rppt@kernel.org, surenb@google.com, vbabka@kernel.org, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com, kas@kernel.org, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, kernel-team@meta.com, 
	baolin.wang@linux.alibaba.com, Nico Pache <nico.pache@linux.dev>, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: don't PTE-batch a swap-in over a
 hardware-poisoned subpage
Message-ID: <avWn47ADwJwP3DWz@gremlin>
References: <avRqaatdOUunxrcZ@gremlin>
 <20261111183917.1093166-1-usama.arif@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111183917.1093166-1-usama.arif@linux.dev>

On Wed, Nov 11, 2026 at 10:39:17AM -0800, Usama Arif wrote:
> On Wed, 11 Nov 2026 13:18:36 +0000 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
>
> > On Wed, Nov 11, 2026 at 03:38:29AM -0800, Usama Arif wrote:
> > > do_swap_page() checks PageHWPoison() on the faulting page, but the
> > > large-folio batching path then maps the rest of the folio without looking
> > > at the other subpages. A poisoned subpage that is not the one being
> > > faulted gets mapped anyway, and the fault that would have reported it
> > > never happens.
> > >
> > > Skip batching for such a folio and let each page take its own fault,
> > > where the existing check catches it.
> > >
> > > Scan the subpages rather than testing the folio-level PG_has_hwpoisoned:
> > > memory_failure() sets PageHWPoison() on the subpage first and only sets
> > > the folio flag much later, and the bail-outs in between - for example
> > > get_hwpoison_page() losing a page lifecycle race - return with the
> > > subpage marked and the folio flag never set.
> > >
> > > Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swapcache")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Usama Arif <usama.arif@linux.dev>
> > > ---
> > >  mm/internal.h | 15 +++++++++++++++
> > >  mm/memory.c   |  4 ++++
> > >  2 files changed, 19 insertions(+)
> > >
> > > diff --git a/mm/internal.h b/mm/internal.h
> > > index cd3675c044e0a..e61c02f4019b0 100644
> > > --- a/mm/internal.h
> > > +++ b/mm/internal.h
> > > @@ -28,6 +28,21 @@ struct folio_batch;
> > >  int __copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
> > >  		void *buf, int len, unsigned int gup_flags);
> > >
> > > +/*
> > > + * Check every page of the folio for HWPoison, rather than relying on the
> > > + * folio-level PG_has_hwpoisoned, which memory_failure() can leave clear.
> > > + */
> > > +static inline bool folio_has_any_hwpoisoned_page(const struct folio *folio)
> > > +{
> > > +	long nr = folio_nr_pages(folio);
> > > +	long i;
> > > +
> > > +	for (i = 0; i < nr; i++)
> > > +		if (PageHWPoison(folio_page(folio, i)))
> > > +			return true;
> > > +	return false;
> > > +}
> > > +
> > >  /* mm/workingset.c */
> > >  bool workingset_test_recent(void *shadow, bool file, bool *workingset,
> > >  			    bool flush);
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index d477a4f986bc8..4b7d456332200 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -5158,6 +5158,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >  		    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
> > >  			goto check_folio;
> > >
> > > +		/* Let a poisoned subpage take its own fault. */
> > > +		if (folio_has_any_hwpoisoned_page(folio))
> > > +			goto check_folio;
> > > +
>
> Hello Lorenzo,
>
> Thanks for the reviews!
>
> >
> > Hm, isn't scanning every single page in the folio potentially quite costly
> > here?  I thought the point of batching was to improve performance overall?
>
> Swapping in requires checking every subpage, so there would be a cost.
> I guess trading it off for correctness :(

(we don't say subpage apparently :)

Yeah but the cost is now paid by literally everybody...

And...

>
> >
> > It seems broken to have stuff potentially interact with hwpoison but then
> > to only set the folio-level flag much later?
> >
>
> PG_has_hwpoisoned lives in the second page, so memory_failure() only
> sets it once it holds a folio reference, otherwise it could race with a
> THP split. If get_hwpoison_page() can't get a reference,
> memory_failure() gives up with only the subpage marked. The comment
> above folio_set_has_hwpoisoned() in memory_failure() says that is fine:
>
>   Don't need care about the above error handling paths for
>   get_hwpoison_page() since they handle either free page
>   or unhandlable page.
>
> But a large folio that is briefly off the LRU, e.g. isolated by
> reclaim, takes those paths too and can still be mapped afterwards.

...now you're narrowing this cost to literally a vague edge case.

Can we not just do the scan _only in this case_?

>
> > Also why are we swapping out folios containing hwpoison pages? Shouldn't we
> > migrate away from the hwpoison? :) (I'm not really familiar with the hw
> > poison stuff)
> >
> >
>
> The error hits a folio that is already in the swap
> cache, e.g. while reclaim has it off the LRU to write it out, and
> get_hwpoison_page() fails for any folio that is off the LRU. Normally
> memory_failure() would split the folio and isolate the bad page (for
> an uncorrected error there is nothing to migrate; that is soft
> offline). Here it does neither, and the folio stays in the swap cache
> with only the subpage marked.

Yeah this just seems like the swapcache code being broken in general.

>
> While looking at this I also noticed that the fallback drops a freshly
> read (not yet anon) folio from the swap cache and frees it with the
> poisoned page in it. We should actually actually also check folio_test_anon()
> before checking folio_has_any_hwpoisoned_page().

Ugh lord, how much crap is handled improperly re: hw poisoning. Such a mess...

--
Cheers, Lorenzo
