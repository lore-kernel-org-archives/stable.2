Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED77CA6F;
	Fri, 21 Aug 2026 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787332178; cv=none; b=HYxEXq2mMx0Nnp4nl+dSyBr/VZx1qMsrOUEub/1BBeqsIXV6l1J5Yux62oISzEiNmM/Orpd0Na2Ooe9Z5/Juo2m+m7octRd8UFOnfUWtCq0a4KXw/wBVIvJdiLZOvlDPAcIA78k0lSqFbWEYe9QDcZstuQKbH0dllr01PW/MMCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787332178; c=relaxed/simple;
	bh=7GXr0u+OQ0oLrxHT8t+RWzO5wtKMLnVNPS3p8JwoadQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OujXsCm8dvSBqS8VIhzNVfn2GPtR7CuvlJEYA1+LDVCOSXp7jD1LpOwHicK6X4a9hiNna9Y1JpDeIYeXhtETZOZN/dUZ8cgkA2UeF3chs36DPAAdg4va+1LdPJLXPr76W310y2qBiw+Fqp0vAV5188aaTYp76bwfAYYZhW8M8uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBDi66cJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBDi66cJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388E11F000E9;
	Fri, 21 Aug 2026 17:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787332177;
	bh=SXhsSgD+So1KYv0opzbteQ7Y/GTNQS0Ot83166ZvllE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DBDi66cJgAuWcv90XqfOjUMXdJYHjk6ICIrClqQjw3fx0PiQ+i6Q1mAYoFtRdzpiP
	 IpgWFLgdtU/zNuaznv4wKX+6cujfcChcyjf3Fxwly2ZqSwCHpO4FHasgjSCEtuXIJI
	 Vcc+9Fes6TFXSxN1oFkXQ86OwFZ/OUubeu9T/WTu9Km13yuzFBkW3sdAKBIuBYZOi8
	 V3gAIIKftBQ10fLj/1kIYtQoTE+cHU95+VP9lCt/6tV0k0r0Ujr55eTko9Kr5y5n9+
	 0btgFaMOEAOIjSmyTCc16eWkpEkBF2yUpl1OJrpasgS1hq6sAoQB8QWQYiJFtxWoKJ
	 Uksb5L6i67JFA==
Date: Fri, 21 Aug 2026 18:09:30 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Vernon Yang <vernon2gm@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, nico.pache@linux.dev, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
	usama.arif@linux.dev, zokeefe@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Vernon Yang <yanglincheng@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm: khugepaged: fix swap entry value to
 folio_pfn()
Message-ID: <aoiDTwCf6320fedN@gremlin>
References: <20260815051924.194810-1-vernon2gm@gmail.com>
 <20260815051924.194810-2-vernon2gm@gmail.com>
 <aoMs79VDCnYvA9S7@lucifer>
 <aoMzkN8EfFllT5zH@lucifer>
 <aedcacce-4880-41b0-a4a6-d892465fff57@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aedcacce-4880-41b0-a4a6-d892465fff57@gmail.com>

On Fri, Aug 21, 2026 at 04:17:55PM +0800, Vernon Yang wrote:
> On Mon, Aug 17, 2026 at 05:23:30PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Mon, Aug 17, 2026 at 05:10:39PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > On Sat, Aug 15, 2026 at 01:19:22PM +0800, Vernon Yang wrote:
> > > > From: Vernon Yang <yanglincheng@kylinos.cn>
> > > >
> > > > When the swap entries found exceed max_ptes_swap, the loop is left via
> > > > break with folio still holding the xarray value that encodes the swap
> > > > entry, not valid folio pointer.
> > > >
> > > > That value is passed to trace_mm_khugepaged_scan_file(), which feeds it
> > > > to folio_pfn(). On FLATMEM and SPARSEMEM_VMEMMAP, the page_to_pfn() is
> > > > plain pointer arithmetic, so the trace event merely prints bogus
> > > > scan_pfn. On classic SPARSEMEM, the page_to_pfn() reads page->flags,
> > > > dereferencing the tiny encoded integer and oopsing khugepaged whenever
> > > > the trace event is enabled.
> > >
> > > Hmm I seem to recall that we were no longer spporting !VMEMMAP SPARSEMEM, but
> > > maybe I was imagining that :)
> >
> > OK seems some museum piece architectures are causing us issues again, fun times
> > (parisc and some mips).
> >
> > >
> > > But this needs fixing in general anyway.
> > >
> > > >
> > > > So when folio is the swap entry value, simply set pfn to -1, just like
> > > > exhausted scan naturally.
> > > >
> > > > And the folio_put() has maybe dropped the last reference of folio. The
> > > > trace_mm_khugepaged_scan_file() is left with a dangling folio pointer.
> > > > so using the folio_pfn() before dropping the reference, closing
> > > > use-after-free window.
> > > >
> > > > Fixes: d41fd2016ed0 ("mm/khugepaged: add tracepoint to hpage_collapse_scan_file()")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
> > > > ---
> > > >  include/trace/events/huge_memory.h |  6 +++---
> > > >  mm/khugepaged.c                    | 14 +++++++++-----
> > > >  2 files changed, 12 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> > > > index 291fae364c62..d3572d4ef453 100644
> > > > --- a/include/trace/events/huge_memory.h
> > > > +++ b/include/trace/events/huge_memory.h
> > > > @@ -178,10 +178,10 @@ TRACE_EVENT(mm_collapse_huge_page_swapin,
> > > >
> > > >  TRACE_EVENT(mm_khugepaged_scan_file,
> > > >
> > > > -	TP_PROTO(struct mm_struct *mm, struct folio *folio, struct file *file,
> > > > +	TP_PROTO(struct mm_struct *mm, unsigned long pfn, struct file *file,
> > > >  		 int present, int swap, int result),
> > > >
> > > > -	TP_ARGS(mm, folio, file, present, swap, result),
> > > > +	TP_ARGS(mm, pfn, file, present, swap, result),
> > > >
> > > >  	TP_STRUCT__entry(
> > > >  		__field(struct mm_struct *, mm)
> > > > @@ -194,7 +194,7 @@ TRACE_EVENT(mm_khugepaged_scan_file,
> > > >
> > > >  	TP_fast_assign(
> > > >  		__entry->mm = mm;
> > > > -		__entry->pfn = folio ? folio_pfn(folio) : -1;
> > > > +		__entry->pfn = pfn;
> > >
> > > I wonder how easy it is for people to interpret that this is a PFN of something
> > > only in the case of an early exit.
> > >
> > > It's a bit of a mess that we're exposing internal implementation details like
> > > this, quite honestly.
> > >
> > > I hope there is no expectation of this being there indefinitely.
> > >
> > > >  		__assign_str(filename);
> > > >  		__entry->present = present;
> > > >  		__entry->swap = swap;
> > > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > > index 617bca76db49..e7830761d3a2 100644
> > > > --- a/mm/khugepaged.c
> > > > +++ b/mm/khugepaged.c
> > > > @@ -2683,6 +2683,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
> > > >  	int present, swap;
> > > >  	int node = NUMA_NO_NODE;
> > > >  	enum scan_result result = SCAN_SUCCEED;
> > > > +	unsigned long pfn;
> > >
> > > See below I think we should drop it.
> >
> > OK we can't because of museum piece architectures that will actually deref the
> > folio to get the PFN...
> >
> > I'd startr by initialising this to -1 then since I guess in theory it's possible
> > xas_for_each() could just not do anything is it? (folio is being set to NULL so
> > that suggests so).
> >
> > >
> > > >
> > > >  	present = 0;
> > > >  	swap = 0;
> > > > @@ -2720,27 +2721,23 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
> > > >  			 * PMD-sized THP implies that we can only try
> > > >  			 * retracting the PTE table.
> > > >  			 */
> > > > -			folio_put(folio);
> >
> > I still hate the idea of moving these outside of the loop, it's just asking for trouble.
> >
> > So I guess instead:
> >
> > 	xas_for_each(&xas, folio, start + HPAGE_PMD_NR - 1) {
> > 		pfn = -1;
> > 		...
> > 		if (xa_is_value(folio)) {
> > 			...
> > 		}
> > 		pfn = folio_pfn(folio);
> > 		...
> > 	}
> > 	...
> > 	trace_mm_khugepaged_scan_file(mm, pfn, file, present, swap, result);
> >
> > That way you avoid the horror or moving the folio put somewhere deeply
> > unintuitive and inconsistent, and maintain pfn lifetime for some arches nobody
> > uses.
>
> Thank you for the reference solution. After studying the overall
> process, I found that the above solution still has two issues:
>
> - When `!folio_try_get(folio)` or `folio != xas_reload(&xas)`, if the
>   next `xas_for_each()` iteration happens to terminate, pfn will be
>   incorrect, which is inconsistent with previous versions.

Ah you're right of course!

> - when the `xas_for_each()` iteration to terminate and the folio
>   operation preceding is normal. but pfn will be incorrect, also same
>   issue.

Yeah... :)

>
> To keep it simple, I modified it as follows. Is this OK?
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 79effd3f3da4..00337405c0e0 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2689,6 +2689,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
>  	int present, swap;
>  	int node = NUMA_NO_NODE;
>  	enum scan_result result = SCAN_SUCCEED;
> +	unsigned long pfn;
>
>  	present = 0;
>  	swap = 0;
> @@ -2719,6 +2720,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
>  			continue;
>  		}
>
> +		pfn = folio_pfn(folio);
>  		if (is_pmd_order(folio_order(folio))) {
>  			result = SCAN_PTE_MAPPED_HUGEPAGE;
>  			/*
> @@ -2779,7 +2781,8 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
>  		}
>  	}
>
> -	trace_mm_khugepaged_scan_file(mm, folio, file, present, swap, result);
> +	trace_mm_khugepaged_scan_file(mm, (!folio || xa_is_value(folio)) ? -1 : pfn,
> +				      file, present, swap, result);
>  	return result;
>  }

OK looks reasonable, thanks! :)

>
> --
> Cheers,
> Vernon
>
