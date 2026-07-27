Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89A742B314;
	Mon, 27 Jul 2026 18:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785175764; cv=none; b=cJbYH+0aaZjlK6HsRsqbwQiAeqyNq6EJo/21J9lk6HXiuqJR15cV1rhlfPLsIXXurAf4RICIUJHGFxTfntQFBcyLdR82ieBPN0t64GhFHycaPquRkmOQqKAHy7WGjKKHnBFQjg2b6NK+/cQUAcVCDYnX/DKe9oJe5n7304Y59lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785175764; c=relaxed/simple;
	bh=7CHmC2resTHfIW+i5+pyTizaOx1+9D0Z88t1xEm75UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIPRbfBiOcdtOjlUcBMZURY73saS69A5Lf0q3FdacKhTFviPIWyZnTEFx0WLkBW3pDOCAqulOU++FXSqRJ2ypTJYQh7QZplEMSzl4u05i8z1gUt7E/wU32L/Vc5VJ0vNrxFvionmnteL6Rr9vZcHhauHQhYvxCbRhl06QYbca+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUyBVRvT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUyBVRvT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056B21F000E9;
	Mon, 27 Jul 2026 18:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785175762;
	bh=RcjbXP8Y17nr6eEz7yURI6DNo/+/Q534212DGqxsB6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nUyBVRvTt12wzr30EzC1dj3+o2IHuFUkcbhMVzmIbjhqYCFAJ1y2Wic3eoU2A4prF
	 OcCVzOpvEWKsSj2N2BdMUFDDTWva8VwCVgYKP0k16+jR3GNUAYB6r2jV9qKkUpWZHQ
	 XJwNIvqfXpQEpxaEo6cYd1S5dNPYBWB3jaj1Ux5G4+GWTVrZfvHco7h1/AdZI60yRi
	 BuUEBX1IeQ84jTUsy1WCKkDm0EwGH8kVYbCrK1pBVfjNyOrRgIK9Qre9BPbMq2WBMJ
	 I3Jpvg1/Y4DEYR3LK08zl660CTNugggLYMmCmOhsdgFTGFTS/Gnk+5hfeoUoJQ+7TI
	 fnOywseuI+QTw==
Date: Mon, 27 Jul 2026 19:09:05 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Hengbin Zhang <uqbarz@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>
Subject: Re: [RFC PATCH v3] mm/thp: serialize huge-zero folio state
 transitions
Message-ID: <ameC4IWCOVBGlXZu@lucifer>
References: <4146d4f5-c8fb-42cf-9dc8-a9d4c26055da@kernel.org>
 <20260727154001.4102341-1-uqbarz@gmail.com>
 <b915b058-f5b1-423a-a835-5891e7997080@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b915b058-f5b1-423a-a835-5891e7997080@kernel.org>

TL;DR - after spending far too long on this - this is very subtle and I am
not confident you understand the patch, I wonder if the fix is possibly
AI-generated also?

This is really subtle stuff and requires backports, so I think it's better
if I send a patch myself.

(I think this is less egregious than it might seem in that the lock
suggestion is ultimately David's in any case.)

I will acknowledge this submission in the commit message, however.

It seems the race is:

static unsigned long shrink_huge_zero_folio_scan(struct shrinker *shrink,
						 struct shrink_control *sc)
{
	if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) == 1) {   <-------------------------- 1. sets to 0
		struct folio *zero_folio = xchg(&huge_zero_folio, NULL); < preempted for a very very long time>
		BUG_ON(zero_folio == NULL);
		WRITE_ONCE(huge_zero_pfn, ~0UL);                <------------------------- 6. Overwrites the valid PFN
		folio_put(zero_folio);
		return HPAGE_PMD_NR;
	}

	return 0;
}

static bool get_huge_zero_folio(void)
{
	struct folio *zero_folio;
retry:
	if (likely(atomic_inc_not_zero(&huge_zero_refcount))) <--------------------  2. sees the zero
		return true;

	zero_folio = folio_alloc((GFP_TRANSHUGE | __GFP_ZERO | __GFP_ZEROTAGS) & <--- 3. allocates (magically, very very quickly)
				 ~__GFP_MOVABLE,
			HPAGE_PMD_ORDER);
	if (!zero_folio) {
		count_vm_event(THP_ZERO_PAGE_ALLOC_FAILED);
		return false;
	}
	/* Ensure zero folio won't have large_rmappable flag set. */
	folio_clear_large_rmappable(zero_folio);
	preempt_disable();
	if (cmpxchg(&huge_zero_folio, NULL, zero_folio)) { <---------------- 4. no concurrent setter so branch not taken
		preempt_enable();
		folio_put(zero_folio);
		goto retry;
	}
	WRITE_ONCE(huge_zero_pfn, folio_pfn(zero_folio)); <----------------- 5. Writes the PFN first despite not being able to be reordered

	/* We take additional reference here. It will be put back by shrinker */
	atomic_set(&huge_zero_refcount, 2);
	preempt_enable();
	count_vm_event(THP_ZERO_PAGE_ALLOC);
	return true;
}

?

In general I don't know why we're not just making
CONFIG_PERSISTENT_HUGE_ZERO_FOLIO mandatory for CONFIG_TRANSPARENT_HUGEPAGE.

If you're embedded, don't enabled THP (which will up your reserves a bunch for
khugepaged anyway).

On Mon, Jul 27, 2026 at 06:08:53PM +0200, David Hildenbrand (Arm) wrote:
> On 7/27/26 17:40, Hengbin Zhang wrote:
> > The nonpersistent huge-zero shrinker clears huge_zero_folio and then

NIT: insert a hyphen: non-persistent.

> > invalidates huge_zero_pfn. A concurrent fault can publish a replacement

'Invalidates'? How do you mean?

You mean setting it to NULL? Clearer to say that.

> > folio and PFN between those updates, after which the old shrinker
> > invalidates the replacement generation's PFN identity.

I don't understand what you mean generation or PFN identity?


> >
> > A later partial mprotect() can then misidentify the live special PMD and
> > enter the ordinary anonymous THP split path.

What is a live special PMD?

Please don't say special :) that term is so overloaded in mm.

'...can then fail to identify the huge zero folio which then incorrectly enters
the anonymous THP split path'.

But I'd even not mention mprotect() specifically, if the huge zero folio can be
misidentified that's already a problem.

> >
> > A writer-side spinlock keeps huge_zero_folio and huge_zero_pfn updates
> > from different generations together. Lockless getters still use the

I'm very confused by what you mean.

> > refcount fast path. atomic_set_release() publishes an initialized new
> > generation before a successful atomic_inc_not_zero() can admit a getter
> > on weakly ordered architectures.

Overall I am not confident you understand this so as per above I think

> >
> > Suggested-by: David Hildenbrand <david@kernel.org>

Should be a S-o-b and David should handle this.

> > Link: https://lore.kernel.org/r/20260724100509.2300200-1-uqbarz@gmail.com
>
> We want a Fixes: tag + Cc: stable.

Yup.

>
> Can you dig up the proper Fixes commit? Thanks
>
> > Signed-off-by: Hengbin Zhang <uqbarz@gmail.com>
> > ---
> >  mm/huge_memory.c | 22 +++++++++++++++-------
> >  1 file changed, 15 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index b5d1e9d4463d..79bec4495540 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -78,6 +78,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
> >  static bool split_underused_thp = true;
> >
> >  static atomic_t huge_zero_refcount;
> > +static DEFINE_SPINLOCK(huge_zero_lock);
> >  struct folio *huge_zero_folio __read_mostly;
> >  unsigned long huge_zero_pfn __read_mostly = ~0UL;
> >  unsigned long huge_anon_orders_always __read_mostly;
> > @@ -237,17 +238,18 @@ static bool get_huge_zero_folio(void)
> >  	}
> >  	/* Ensure zero folio won't have large_rmappable flag set. */
> >  	folio_clear_large_rmappable(zero_folio);
> > -	preempt_disable();
> > -	if (cmpxchg(&huge_zero_folio, NULL, zero_folio)) {
> > -		preempt_enable();
> > +	spin_lock(&huge_zero_lock);
> > +	if (READ_ONCE(huge_zero_folio)) {
>
> Same comment as below: who could possibly modify this value concurrently? I
> don't think we need the READ_ONCE.

Yeah I don't think so either.

>
> > +		spin_unlock(&huge_zero_lock);
> >  		folio_put(zero_folio);
> >  		goto retry;
> >  	}
> >  	WRITE_ONCE(huge_zero_pfn, folio_pfn(zero_folio));
> > +	WRITE_ONCE(huge_zero_folio, zero_folio);

This is still necessary however for concurrent lockless readers.

> > +	spin_unlock(&huge_zero_lock);
> >
> > -	/* We take additional reference here. It will be put back by shrinker */
> > -	atomic_set(&huge_zero_refcount, 2);
> > -	preempt_enable();
> > +	/* Publish the identity before admitting lockless getters. */

You're deleting the comment about an additional reference...

And this comment doesn't make any sense really.

> > +	atomic_set_release(&huge_zero_refcount, 2);
>
> Why do we need the _release semantics here when we just did a spin_unlock()?

This is really suspect, as I had AI look at this and it also suggested
exactly what you did here, and I'm not confident you understand it.

Are you generating this code using AI without disclosing it against the
kernel policy on this?

See https://kernel.org/doc/html/latest/process/coding-assistants.html

Can you give a detailed, coherent response as to why you chose this, if it
was not AI-generated? A human-sounding one? :)

Anyway.

AI says this actually _is_ necessary.

And using my human brain to think about it:

static bool get_huge_zero_folio(void)
{
	struct folio *zero_folio;
retry:
	if (likely(atomic_inc_not_zero(&huge_zero_refcount)))
		return true;

	zero_folio = folio_alloc((GFP_TRANSHUGE | __GFP_ZERO | __GFP_ZEROTAGS) &
				 ~__GFP_MOVABLE,
			HPAGE_PMD_ORDER);
	if (!zero_folio) {
		count_vm_event(THP_ZERO_PAGE_ALLOC_FAILED);
		return false;
       	}
	/* Ensure zero folio won't have large_rmappable flag set. */
	folio_clear_large_rmappable(zero_folio);
	spin_lock(&huge_zero_lock);                          <--- acquire semantics
	if (huge_zero_folio) {                                            |			   <|
		spin_unlock(&huge_zero_lock);                             v			   <|
		folio_put(zero_folio);			  All loads/stores AFTER appear AFTER	   <|
		goto retry;									   <|
	}                                                  All loads/stores BEFORE appear BEFORE   <|
	WRITE_ONCE(huge_zero_pfn, folio_pfn(zero_folio));                 ^			   <| Anywhere here.
	WRITE_ONCE(huge_zero_folio, zero_folio);                          |			   <|
	spin_unlock(&huge_zero_lock);                         <--- release semantics               <|
                                                                                                   <|
	/* We take additional reference here. It will be put back by shrinker */                   <|
	atomic_set(&huge_zero_refcount, 2); ---- relaxed ordering so could be moved ----------------|

	count_vm_event(THP_ZERO_PAGE_ALLOC);
	return true;
}

So yeah I think that should be atomic_set_release() in order to prevent
that occurring before the critical section.

The retry stuff is a bit suspect now, how could we be concurrently raced in
order to require a retry? I don't think so.

It's needed because it has to pair with atomic_inc_not_zero() to prevent a
concurrent get_huge_zero_folio() invocation from incorrectly returning
before the critical section is completely finished.

>
> >  	count_vm_event(THP_ZERO_PAGE_ALLOC);
> >  	return true;
> >  }
> > @@ -298,9 +300,15 @@ static unsigned long shrink_huge_zero_folio_scan(struct shrinker *shrink,
> >  						 struct shrink_control *sc)
> >  {
> >  	if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) == 1) {
> > -		struct folio *zero_folio = xchg(&huge_zero_folio, NULL);
> > +		struct folio *zero_folio;
> > +
> > +		spin_lock(&huge_zero_lock);
> > +		zero_folio = READ_ONCE(huge_zero_folio);
>
> Why do we need a READ_ONCE? Nobody should be legally be allowed to change this
> variable concurrently, no?

Yup.

>
> >  		BUG_ON(zero_folio == NULL);
> >  		WRITE_ONCE(huge_zero_pfn, ~0UL);
> > +		WRITE_ONCE(huge_zero_folio, NULL);
> > +		spin_unlock(&huge_zero_lock);
> > +
> >  		folio_put(zero_folio);
> >  		return HPAGE_PMD_NR;
> >  	}
>
>
> --
> Cheers,
>
> David

Thanks, Lorenzo
