Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A04751CF63;
	Wed, 14 Oct 2026 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984437; cv=none; b=bUgjF4pxNE0DAGgYOLBT+XyM4ZMRVTYC+Wfq1jKiqZAcTUxRcYmqKP8HJBzffUpkDzi9yYBq+Kc3SH/6zfoYf0CQVj5mFPfLdDzM4wx7ThBo3If1Yc0Ukpgy+GhmSmy31mfwja9SG2JaKl179MjZaM5ZnnB/1WEgFbma4L5/r0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984437; c=relaxed/simple;
	bh=6F6Ius2aNg4Vvs330MQliwP9/lyOPwNdFvrCpnO2PKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6Uxli0wRQFrfOQD+UbGXs+PLjsfZnWcR+EI41vmlKHjmHkepL+Cy2h3UuszwVT8uJDgCC1SDOH9GDscKZLnl5JvmSxL3vBsCtbwC59RZpPMyqstvGDKGqbBW3usJRLixzNmR7k1JZAUcAyyYXEpgFxKbfnBHAyWCXe/0fRta4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIe8xfLj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIe8xfLj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2F31F00898;
	Wed, 14 Oct 2026 13:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791984433;
	bh=7Tm/Yqwl2DB6mmlaFYO9FOD6DsPXL83E73jBmWe1les=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nIe8xfLjl1ADs8izT2EKBFqEJME8efDayDsg2tzwTBhwni8S4gwcjoNNavyi2ZgcN
	 lbVBB5Fy0kBQhCofz4oyTOOXj666OcqIU0vXayDeVxQ6XozZpVMApVvOOeLo91jvqR
	 kNBgpUl86oMAsFtOBswIqgPY5odKHHau8FUcMY3dN3pUrs3SiRBp5Jq2vEOKlLHqn+
	 Ud7PmAtIg9cas41d9WmHfE06a0sxn4NsmNynYgvdlL7zqMCJRVQ/E6L9l/neLLtNlF
	 6H3KbySuPjdK8eAkLw+sRE0tOnEU6xPd1blT1PYPwEwSdU7a+4dkYtOH8gRjr9cPk7
	 GqsJS/WDFCFug==
Date: Wed, 14 Oct 2026 14:27:06 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Ying Huang <huang.ying.caritas@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Chuanhua Han <hanchuanhua@oppo.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Kyle Zeng <kylebot@openai.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: fix address wraparound when scanning large folio PTEs
Message-ID: <as-BZibPscw4cxsD@gremlin>
References: <20261013-folio_pte_scan_range-v1-1-c50dc30bf6ad@kernel.org>
 <as4kvHe9IFZH5qrC@gremlin>
 <9add8400-66c1-47e9-b5af-7a4081ebf3c4@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9add8400-66c1-47e9-b5af-7a4081ebf3c4@kernel.org>

On Wed, Oct 14, 2026 at 10:12:06AM +0200, David Hildenbrand (Arm) wrote:
> >> Reported-by: Kyle Zeng <kylebot@openai.com>
> >> Fixes: d2136d749d76 ("mm: support multi-size THP numa balancing")
> >> Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swapcache")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Since I'm convinced the logic itself is correct:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

This cycle is brutal enough not to hold up fixes :>)

> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index 1f5d5f7d39cd2..a3823010aa981 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c

> >> +/*
> >> + * Get the address range in which a folio might be mapped, assuming its pages
> >> + * are mapped consecutively and the folio page at the given idx is mapped at
> >> + * the given address.
> >> + */
> >
> > I know it's a static function but kdoc here might be nice given the number of
> > params, including 2 output parameters.
>
> I had that, but decided "not worth it for an internal helper".
>
> Is anything here really that confusing to understand in mm/memory.c context? I
> highly doubt it.

I mean I found it pretty confusing :)

But this is a nice to have it's not a big deal.

> >> +static void folio_pte_scan_range(const struct folio *folio,
> >> +		const struct vm_area_struct *vma, unsigned long addr,
> >> +		unsigned long idx, unsigned long *start, unsigned long *end)
> >
> > I don't love the name - to me it implies to me that you're scanning the range.
> >
> > Maybe clamp_folio_pte_range()? I guess though clamp implies it limits an input
> > range.
>
> Ugly.

Yup, fair enough.

>
> >
> > Maybe get_folio_pte_range()?
>
> I can just call it "folio_pte_range()". Slightly similar (but different) to
> "folio_pte_batch()"

OK that works.

> > OTOH, that's pretty ugly... :))
>
>
> Not a fan of these semantics.

Yeah on reflection not so great, I sort of talked myself out of it a bit as I
typed...

>
> >
> >> +{
> >> +	/* Stay within the page table and VMA boundaries. */
> >> +	const unsigned long pmd_start = addr & PMD_MASK;
> >> +	const unsigned long pmd_end = pmd_start + PMD_SIZE;
> >> +	const unsigned long lower = max(pmd_start, vma->vm_start);
> >> +	const unsigned long upper = min(pmd_end - 1, vma->vm_end - 1) + 1;
> >
> > This is trickier :)
> >
> > I guess you're doing this in case either bound is right at wraparound
> > somehow?
> >
> > But then couldn't the +1 push you over the edge?
> >
> > Oh wait no, because then vma->vm_end would have to equal 0, which would
> > fail the other-place enforced invariant that vma->vm_start < vma->vm_end.
> >
> > So it's pmd_end that could overflow, hence the -1, +1 dance.
> >
>
> Yes. It's fairly common, though, to handle clamping of exclusive ends that way.

Right, it took me a while to figure this out though.

It involves an implicit assumption in there too, that _one_ of these values is
known not to overflow.

> > #define pmd_addr_end(addr, end)                                         \
> > ({      unsigned long __boundary = ((addr) + PMD_SIZE) & PMD_MASK;      \
> >         (__boundary - 1 < (end) - 1)? __boundary: (end);                \
> > })
>
> As replied elsewhere, I had that, but decided to open-code as pmd_addr_end() has
> very weird semantics with folded page tables, where we just don't clamp at all.

Hmm how so?

The logic seems, at a glance, equivalent?

>
> I'll sleep over it, but to me using pmd_addr_end() is not particularly better.

I'm not going to block things on that basis as we have a bug to fix here, but I
really had to sit down and take time to understand any of this.

> > 	*end = addr + min(max_remaining_bytes, folio_size(folio) - offset);
> >
>
> Sorry, to push back, but are we overthinking this helper here?
>
> I much rather get this fixed quickly then fine tuning some details in a helper
> with clear semantics that anybody can understand when looking at it for 1 minute?

As above, I tagged it, for the purposes of a fix let's just get this in.

But no, there's not overthinking IMO, it took me a long time to understand what
you were doing here, and there's a lot of implicit understanding in there.

And while I don't claim to be a great genius, I am fairly familiar with mm code,
so that's always to me a gauge on complexity.

Anyway, let's get this in, and we can debate the details upstream at our leisure
:)

--
Cheers, Lorenzo
