Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE47444BC9F;
	Tue, 28 Jul 2026 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253338; cv=none; b=U3vjsQn9v8zomyl/qN3R3zAiRXA1yVQRUBzciF3gLs7PVqnB9KPiPrHkAIOhZfSH0u+zo5i5xtgjJBxAaUEXZpwGPiN933CZ77DrF5h4x0I8V/RNSN2qlKMP35dCUHU1Vsfe1wFgdUy3EY7br8Xw+XeBMAMTDWnww363lYteQi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253338; c=relaxed/simple;
	bh=6vPcZr9I7m6gNyk4lLtqUkd5H3hqbP2knjxQNzuzqN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDZxreowbce4TxnlS/n401Xg2dMF/Xq89C5JOl4QgY7+7uvk34KQPDgofmdqUDGTaPDBmMpxG9I7lXGUPTBoMCjj7vVs56HYFYEAmQTDkn3lRE9cmCKDB3XvvNhH+SpVN9ga6C1EsmQA0BfFX1IQaZDHXOpNuOlSplA1GpRzZf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hkk5d7pN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hkk5d7pN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EB01F000E9;
	Tue, 28 Jul 2026 15:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785253335;
	bh=Cn9uuCu4petLDLZf1KwAZ2CPZvy55bypKnCMo9F9MKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hkk5d7pN/gnfZxZufQsrgEvXOwGoimyv1SzUPkDfmdUX26sYH6/DQ/mN+5P0HlkeX
	 tOIOPRy3Do+8x+vQm8v1HMz10TAXOPdbzB6NpS8GmnvmJqGWzBpBtZ2DZefeQGt9ge
	 +XBuURtLarQzfpzvFMjq5ELicbcvIMIwByC9yifSTw0EYPR6Jh68eQEEJjWX6pMpsl
	 MaqObdhhyXkv8zZoFr2B9l9ZAVpCZje0DQjVor7vkp+DLCKDP8fOv4IoBSzOIYbXAQ
	 XXC10noKxpZyWEoHhoeflHrnDCRW0hm3YgmivKj/BOG9kfQl7kG1HAPnWO3SviqvIj
	 HDUHaryZm53Bw==
Date: Tue, 28 Jul 2026 16:41:56 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Pankaj Raghav <p.raghav@samsung.com>, 
	Hannes Reinecke <hare@suse.de>, Hugh Dickins <hughd@google.com>, Yang Shi <shy828301@gmail.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Hengbin Zhang <uqbarz@gmail.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH mm-hotfixes 1/2] mm/huge_memory: separate out
 CONFIG_PERSISTENT_HUGE_ZERO_FOLIO logic
Message-ID: <amjJM1Flp7bDN0NO@lucifer>
References: <20260728-fix-refcounted-huge-zero-v1-0-3f261f5447b4@kernel.org>
 <20260728-fix-refcounted-huge-zero-v1-1-3f261f5447b4@kernel.org>
 <amjD1MtOiXBRDxVi@thinkstation>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amjD1MtOiXBRDxVi@thinkstation>

On Tue, Jul 28, 2026 at 04:08:35PM +0100, Kiryl Shutsemau wrote:
> On Tue, Jul 28, 2026 at 01:05:44PM +0100, Lorenzo Stoakes (ARM) wrote:
> > Rather than mixing the refcounted and non-refcounted
> > CONFIG_PERSISTENT_HUGE_ZERO_FOLIO logic, separate the two out cleanly
> > so it is clear what happens when this configuration option is set and what
> > happens when it is not.
> >
> > Introduce HUGE_ZERO_UNSET_PFN to abstract the ~0UL assignment, only
> > introduce the refcount and shrinker if !CONFIG_PERSISTENT_HUGE_ZERO_FOLIO,
> > abstract initialisation and teardown, abstract the huge zero folio
> > allocation from refcounting.
> >
> > Also change a BUG_ON() to WARN_ON_ONCE() while we're at it.
> >
> > Without this change, the subsequent fix for a subtle race is harder to
> > understand thus this is a dependency of it.
> >
> > Cc: stable@vger.kernel.org # 6.18.x: dependency of subsequent fix
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  mm/huge_memory.c | 159 ++++++++++++++++++++++++++++++++-----------------------
> >  1 file changed, 94 insertions(+), 65 deletions(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 032702a4637b..0f60bc82e87a 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -77,9 +77,14 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
> >  					 struct shrink_control *sc);
> >  static bool split_underused_thp = true;
> >
> > -static atomic_t huge_zero_refcount;
> > +#define HUGE_ZERO_UNSET_PFN (~0UL)
> >  struct folio *huge_zero_folio __read_mostly;
> > -unsigned long huge_zero_pfn __read_mostly = ~0UL;
> > +unsigned long huge_zero_pfn __read_mostly = HUGE_ZERO_UNSET_PFN;
> > +#ifndef CONFIG_PERSISTENT_HUGE_ZERO_FOLIO
> > +static atomic_t huge_zero_refcount;
> > +static struct shrinker *huge_zero_folio_shrinker;
> > +#endif
> > +
> >  unsigned long huge_anon_orders_always __read_mostly;
> >  unsigned long huge_anon_orders_madvise __read_mostly;
> >  unsigned long huge_anon_orders_inherit __read_mostly;
> > @@ -221,22 +226,58 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
> >  	return orders;
> >  }
> >
> > -static bool get_huge_zero_folio(void)
> > +static struct folio *alloc_huge_zero_folio(void)
> >  {
> >  	struct folio *zero_folio;
> > -retry:
> > -	if (likely(atomic_inc_not_zero(&huge_zero_refcount)))
> > -		return true;
> >
> >  	zero_folio = folio_alloc((GFP_TRANSHUGE | __GFP_ZERO | __GFP_ZEROTAGS) &
> >  				 ~__GFP_MOVABLE,
> >  			HPAGE_PMD_ORDER);
> >  	if (!zero_folio) {
> >  		count_vm_event(THP_ZERO_PAGE_ALLOC_FAILED);
> > -		return false;
> > +		return NULL;
> > +	}
> > +	folio_clear_large_rmappable(zero_folio); /* Explicitly not rmappable. */
> > +	return zero_folio;
> > +}
> > +
> > +#ifdef CONFIG_PERSISTENT_HUGE_ZERO_FOLIO
> > +static int __init huge_zero_init(void)
> > +{
> > +	huge_zero_folio = alloc_huge_zero_folio();
> > +	if (!huge_zero_folio) {
> > +		pr_warn("Allocating persistent huge zero folio failed\n");
>
> I am not sure the warn is enough. mm_get_huge_zero_folio() will produce
> NULL pointer now without any attempts to allocate again.

Well firstly this was existing behaviour :) and is to be backported also, so
anything changing that would need to be a separate change.

Secondly this failure really shouldn't happen in reality, it's very early in the
boot (see my RFC...) and the config has to set CONFIG_THP too.

And finally, more importantly perhaps, everywhere deals with it - anon read
fault in do_huge_pmd_anonymous_page() for e.g.

	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
			!mm_forbids_zeropage(vma->vm_mm) &&
			transparent_hugepage_use_zero_page()) {
		...
		zero_folio = mm_get_huge_zero_folio(vma->vm_mm); <- returns NULL
		if (unlikely(!zero_folio)) {
			pte_free(vma->vm_mm, pgtable);
			count_vm_event(THP_FAULT_FALLBACK);
			return VM_FAULT_FALLBACK;
		}
		...
	}

DAX:

static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
		const struct iomap_iter *iter, void **entry)
{
	...
	zero_folio = mm_get_huge_zero_folio(vmf->vma->vm_mm);

	if (unlikely(!zero_folio)) {
		trace_dax_pmd_load_hole_fallback(inode, vmf, zero_folio, *entry);
		return VM_FAULT_FALLBACK;
	}

	...
}

etc. etc.

Where:

struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
{
	if (IS_ENABLED(CONFIG_PERSISTENT_HUGE_ZERO_FOLIO))
		return huge_zero_folio; <-- returns NULL
}

So it's all fine.

>
> Have you considered moving huge_zero_folio to BSS for
> CONFIG_PERSISTENT_HUGE_ZERO_FOLIO=y?

Interesting :)

That'd be huge for larger page size and why would we expect a failure at init
like this I guess I'd say?

It'd be nice to guarantee it though.

IN general you have to have CONFIG_THP enabled to get this at all, and surely
the micro embedded systems will never set that... (see my RFC to just make the
persistent huge zero folio permanently how we do this and remove the damn
refcounted nonsense altogether).

But one for a follow up anyway!

>
> > @@ -308,7 +323,46 @@ static unsigned long shrink_huge_zero_folio_scan(struct shrinker *shrink,
> >  	return 0;
> >  }
> >
> > -static struct shrinker *huge_zero_folio_shrinker;
> > +static int __init huge_zero_init(void)
> > +{
> > +	huge_zero_folio_shrinker = shrinker_alloc(0, "thp-zero");
> > +	if (!huge_zero_folio_shrinker) {
> > +		shrinker_free(deferred_split_shrinker);
> > +		list_lru_destroy(&deferred_split_lru);
>
> Hm. What? Why does huge_zero_init() touches deferred_*?
> That's caller business.

Again existing code :)

But yeah that's really broken as subsys_initcall() apparently discards the
error...

I guess the thinking was because I think because it's doing stuff after the
deferred stuff is initialised and bailling.

In practice it's probably an impossibly small allocation to fail. But should do
something about this, if only oops-ing on failure.

But that's for a follow up :) existing code, backported fix etc. etc.

This patch is rearranging stuff so the code is much clearer for the race stuff
taking into account CONFIG_PERSISTENT_HUGE_ZERO_FOLIO.

>
> >  static void __init thp_shrinker_exit(void)
> >  {
> > -	shrinker_free(huge_zero_folio_shrinker);
> >  	shrinker_free(deferred_split_shrinker);
> >  	list_lru_destroy(&deferred_split_lru);
> > +	huge_zero_shrinker_exit();
>
> Any reason behind the reorder?

Well 'do everything else first then call the external function' but really no
solid reason. It makes no difference though.

Can re-reorder if a respin required :)

>
> >  }
>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

Cheers, Lorenzo
