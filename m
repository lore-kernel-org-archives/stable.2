Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B84C29992B;
	Wed,  8 Jul 2026 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783499529; cv=none; b=A33ZsWS0GfFtF7wdRLUWFn3x0zT2K/2CWzOApY40GfEjZgIv/Q782Vma3JUHeeXRT3NzI4Sw4bNrixXjSRFlABt8FgT4LP1E18nXdyXgN3dat7oBU4P0omrHSivP4dYU1zvLHbVpQO5WVVapYWcOWI1+xQiL6FkkJy98n3ckfNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783499529; c=relaxed/simple;
	bh=Yo2zB0eULVVqb8jXoImLc72duqPtdPjbKTlsD6uwDqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEt9aIx/9GoM6JqAYGY10duXjLDRC1JDes1kDGQTPQaB8aofM8vn2H20h/7G7d3YSvMlWALDyPU9MVdLcfUhQh++/aw948BIoictYp7MI59yMdIlMob4AMb0a1zlsaU8UxJzccBf/dRfI2vHUnUAzIgxrAqhfRRFEGSxBASo5Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/F6NZyn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/F6NZyn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7831F000E9;
	Wed,  8 Jul 2026 08:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783499527;
	bh=c4ESd5w+M2nYuptCS0AZ2uFcE5EIsy34u8jWL9YQIJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g/F6NZynkHZZkdMtfyNvxGJ83yPjcmU31yD2r/fGncf00K1xWvN34mwxbRKQ4iSxC
	 G5hFe+apUbqNMCB9UyRUOxa6zNKzqCMz6tBRvAYoIrQSFIYfPdctennxQeO+G3Kk4k
	 irJDpo0mZ5/I8gFw6zSGfprFs6k+pbS0Dhj516GApTErgkop/C1Fm1yj+K6A8VBFN+
	 IhDLzOYO+ozJqAXJ245zl9cCajx8Lo17qbFs9AnGgOWIeKNmx/s04lzTTB7gxEcT8s
	 vPNDhuz8rbOZcR9IAXJp/Lm9zi4rXFb0MbiHaRfEcoKVB2Ua0+h2MFfwS9GTp9Cl8w
	 dsDJo4QXWiL6A==
Date: Wed, 8 Jul 2026 09:31:55 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Luiz Capitulino <luizcap@redhat.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/util: don't read __page_2 for order-1 folios in
 snapshot_page()
Message-ID: <ak4KweoRcwnxZC-5@lucifer>
References: <20260708015252.296103-1-aboorvad@linux.ibm.com>
 <6fec660b-7c6b-44b1-a7bc-f4687cda734a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fec660b-7c6b-44b1-a7bc-f4687cda734a@kernel.org>

On Wed, Jul 08, 2026 at 10:10:33AM +0200, David Hildenbrand (Arm) wrote:
> On 7/8/26 03:52, Aboorva Devarajan wrote:
> > snapshot_page() reconstructs a folio from a struct page.  After copying
> > the head and __page_1 it reads __page_2 whenever the folio has more than
> > one page:
> >
> > 	if (nr_pages > 1)
> > 		memcpy(&ps->folio_snapshot.__page_2, &foliop->__page_2,
> > 		       sizeof(struct page));
> >
> > __page_2 is the folio's third struct page, so it is part of the folio
> > only for order >= 2 (nr_pages > 2).  For an order-1 folio (exactly two
> > pages) __page_2 is not part of the folio at all, it is the struct page
> > of the following pfn.
> >
> > When such an order-1 head sits in the last struct page slots of a
> > populated section whose neighbouring section is absent (a memory hole),
> > __page_2 falls into the next section's unpopulated vmemmap and the
> > read oopses.
> >
> > Observed on a 22 TB ppc64le LPAR during DLPAR memory remove, on the page
> > isolation dump path:
> >
> > 	offline_pages -> start_isolate_page_range -> isolate_single_pageblock
> > 	  -> set_migratetype_isolate -> dump_page -> __dump_page -> snapshot_page
> >
> > 	NIP   = snapshot_page+264  (ld of __page_2)
> > 	r4    = foliop = head = 0xc00c0005a03fff80
> > 	DAR   = r4 + 0x88     = 0xc00c0005a0400008   (unmapped)
> > 	DSISR = 0x40000000                           (no translation)
> >
> > The faulting head was a free page that still carried PG_head with
> > _nr_pages == 2; its __page_2 is the first entry of the absent section.
> >
> > It is also reproducible deterministically in a VM by placing an order-1
> > folio in the last slots of a populated section adjacent to a hole
> > (memmap=nnM$ssM) and calling dump_page() on it.
> >
> > Only read __page_2 for order >= 2 folios (nr_pages > 2).
>
> Hi!
>
> Can you shorten that a bit? It's rather trivial, really.
>
> "snapshot_page() currently reads __page_2 after checking nr_pages > 1, whereby
> we really should only do so for nr_pages > 2. Let's fix that to avoid reading
> memmap that doesn't exist (e.g., vmemmap hole)
>
>
> Observed on a 22 TB ppc64le LPAR during DLPAR memory remove ...
> "
>
> >
> > Fixes: 31a31da8a618 ("mm: move _pincount in folio to page[2] on 32bit")
> > Cc: stable@vger.kernel.org # v6.15+
> > Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > ---
> >  mm/util.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/util.c b/mm/util.c
> > index af2c2103f0d95..b3d48a05e6d82 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -1353,7 +1353,13 @@ void snapshot_page(struct page_snapshot *ps, const struct page *page)
> >  	if (ps->idx < MAX_FOLIO_NR_PAGES) {
> >  		memcpy(&ps->folio_snapshot, foliop, 2 * sizeof(struct page));
> >  		nr_pages = folio_nr_pages(&ps->folio_snapshot);
> > -		if (nr_pages > 1)
> > +		/*
> > +		 * __page_2 is the folio's third struct page and is part of the
> > +		 * folio only for order >= 2 (nr_pages > 2).  For an order-1
> > +		 * folio it is not part of the folio and may fall into an
> > +		 * adjacent, possibly absent, section.
> > +		 */
>
> No need for the comment, really, this is rather trivial.
>
> > +		if (nr_pages > 2)
> >  			memcpy(&ps->folio_snapshot.__page_2, &foliop->__page_2,
> >  			       sizeof(struct page));
> >  		set_ps_flags(ps, foliop, page);
>
>
> With a condensed patch description and the comment dropped
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>
> Thanks!
>
> --
> Cheers,
>
> David

Agree with everything David said :)

Patch looks good with changes David suggested applied, so feel free to add my
tag to v2 alongside David's:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

Cheers, Lorenzo
