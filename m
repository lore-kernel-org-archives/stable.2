Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B6F3ABDA5;
	Mon, 12 Oct 2026 10:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791801240; cv=none; b=GzvnhNbuUIl0tBFH1pp41Xxnn3KPNftDQT/VM0pnXMRt9rdSGE2ZJfPaJ7lX0iKoDDhUuPRwZetsuOfklvFpVEmTye4WT/MIpdMx2t//dAKsVFF11swtPO2ZavTR1ua3CwX9c4MihJU543M93AtCA7p8gL4O44OfMl7Zff/w0Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791801240; c=relaxed/simple;
	bh=OhMtNDrimXppjoitpJALUEqM8XzTYMltqE4WibgaUF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APV1zJdJ/Orge4B+gSUoBlOMiOx//reG/noYMHIJYYcEQlffW9rIWpoCZl2aFex9s3o3MFoIPATYId2ymGwctGibtXu4ebEPuFAMdDkvIrvO2t92xMAbQNjPHmNjlG0pHiKgNuFH5Hnl0bqtzyZD7Ze/tnVmoxrCDMbZHlAHcqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEKg6uip; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEKg6uip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6801F0089B;
	Mon, 12 Oct 2026 10:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791801234;
	bh=YNnBEk1ZblEqrRrnuFXhKbUtj1Kjb67w+8SQlGULyHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fEKg6uipIJDU9BC6xLEMgoLYR9QG7W0hFPrT8AQqy8X2IQaQv99e7Fq09HEvCH/7m
	 QeS0JYlgUSTRWU+B3s/P7udKfTuMZUdJC/3eZku2DYciVmbv5wXEzhgn1KnMpklBTJ
	 vn2c9N0de6SuluS/nhj/Q4f+YIWeQ06tzo6l90oRfJf72m4iWPmr+sVAy89lUnVgm3
	 kw3XKwdEGazJRTIyqblyFf3KzxNPxoYXt1dD+qWn5pClS0PO7kTIzPqLOg2Kbh0ZAg
	 aqW0ULSvcobAVRgeguqucH/6oNpiq6OgjyZdiV0qYhlDj4J9xTfN+KgA8HZ8IFXmPB
	 5DgvOhzM1Irmg==
Date: Mon, 12 Oct 2026 11:33:48 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	jannh@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: keep the hardware dirty bit in MADV_COLD's
 THP path
Message-ID: <asyy7Nwik5yMTNbo@gremlin>
References: <20261011132227.413217-1-samarth.colleges@gmail.com>
 <42087cd7-473e-40a7-ae63-3c841c615c8f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42087cd7-473e-40a7-ae63-3c841c615c8f@kernel.org>

-cc slopper.

On Mon, Oct 12, 2026 at 12:09:07PM +0200, David Hildenbrand (Arm) wrote:
> On 10/11/26 15:22, samarth.colleges@gmail.com wrote:

> > diff --git a/mm/madvise.c b/mm/madvise.c
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -426,8 +426,14 @@
> >  		}
> >
> >  		if (!pageout && pmd_young(orig_pmd)) {
> > -			pmdp_invalidate(vma, addr, pmd);
> > -			orig_pmd = pmd_mkold(orig_pmd);
> > +			/*
> > +			 * Rebuild from the entry pmdp_invalidate() exchanged
> > +			 * out, not from orig_pmd: hardware may have set the
> > +			 * dirty bit since orig_pmd was read, and a MADV_FREE'd
> > +			 * (lazyfree) THP whose dirty bit is lost is discarded
> > +			 * by reclaim, silently dropping the store.
> > +			 */
> > +			orig_pmd = pmd_mkold(pmdp_invalidate(vma, addr, pmd));
>
> Okay, you are saying we can lose the dirty bit that could get set concurrently.
> And if we did an MADV_FREE before, we might not detect that the content was changed.

Yeah, lazyfree -> write means you don't actually free it.

As per the manpage:

	For each of the pages that has been marked to be freed but has not yet
	been freed, the free operation will be canceled if the caller writes
	into the page.

This is anon memory only:

	The MADV_FREE operation can be applied only to private anonymous
	pages (see mmap(2)).

>
>
> I suspect this found through the help of an LLM and not an actual use case in
> practice?

Seems very likely.

>
> Using MADV_COLD following MADV_FREE sounds odd at thirst. In particular, when
> having MADV_COLD race with actual access.

It's odd to MADV_FREE (lazyfree) then MADV_COLD (deactivate) yes,
especially with racing accesses.

I wonder if there are other cases where you could get weird races like
this...

In any case it seems a really hard thing to hit in reality. But I think we
probably need to fix this because of the stated contract of MADV_FREE.

I think probably we shouldn't have added that contract...

>
> On the PTE path we use clear_young_dirty_ptes(CYDP_CLEAR_YOUNG) which achieves
> the same through ptep_test_and_clear_young().
>
>
> ... where we also just do a
>
> pte = ptep_get(ptep);
> set_pte_at(vma->vm_mm, address, ptep, pte_mkold(pte));
>
> in the generic variant and rely on the per-arch variant to do the right thing.
>
> Which makes me wonder whether we should actually have per-architecture PMD
> helpers for that purpose?

Is it achieving the same thing? There's an invalidation here also.

pmdp_establish() is used to install a pmd_mkinvalid() entry and there's a
flush_pmd_tlb_range().

--
Cheers, Lorenzo
