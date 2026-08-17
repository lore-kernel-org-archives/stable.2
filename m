Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCF1449B26;
	Mon, 17 Aug 2026 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786983054; cv=none; b=hRJRwWp/rZSSR1ZrskMLu3PG7/5RhU5vOtfwv0BS9bRD5irR0VNJ6enuFOcJsR9qpcIj/qA8yfHCoWdZUgG7PZbdZEeTlgoZkh/u51mjulENWk705ZjZrwDDpiV2YFAx7ROItiuMH2OeIeJMGYgjDQ0DtKNbrMwuRlEp3QdEKI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786983054; c=relaxed/simple;
	bh=/JEAOX8UVXnoWgnkm4NmwTQxUagNOU75+5zuHjypmOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJAm1F9Y7x4YB7k76wNjYvraxc50+0xd0SoI/Wnvhca5CFUeeZqTTKb/3RewDGosWfVypYn2jI6GMg90bWgjJP7pciT9/g+9znvP8G0b1j/Awdr6jON2OGtfWEkFPsIzVMqpDnaUs3LYzngfkzuQgrIapatApK3Lq+WkJ5krccY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCBaa+j+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCBaa+j+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC7F1F000E9;
	Mon, 17 Aug 2026 16:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786983052;
	bh=ehil3JC0l4LDLYFfypizoKcVHzJxLCL/jYPuy7ixqt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SCBaa+j+AIpRYkJmJX3uDNdJm1MMZGwWIXmfqLt+TQDIgCGBTZ8Nd11gzvihP3AKi
	 buYunOdFO42MxMRjMdmB3HRkliFilbGMxVY1te3hdhc4BhkjjGUOdzF7RORsDgHB9s
	 hctOlspJASD07HP5J428S2a8JmThNHrBWT9q1uquWERcm4viZ4CWxSiPN9FGcHe0WB
	 jh2pkADjj1FqTELBdmntQikje+F+KnQT6iFuEHhK2SsoghF6V0YbF5qdqrQCy+xUq/
	 ViAnuu5SahbcAIqktb0rESgQwnWOlcwJD86ksHAYqxc90wlNVIefzRHdfO+5YdaYJi
	 5PfIAINR53hdQ==
Date: Mon, 17 Aug 2026 17:10:34 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Vernon Yang <vernon2gm@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, nico.pache@linux.dev, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
	usama.arif@linux.dev, zokeefe@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Vernon Yang <yanglincheng@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm: khugepaged: fix swap entry value to
 folio_pfn()
Message-ID: <aoMs79VDCnYvA9S7@lucifer>
References: <20260815051924.194810-1-vernon2gm@gmail.com>
 <20260815051924.194810-2-vernon2gm@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815051924.194810-2-vernon2gm@gmail.com>

On Sat, Aug 15, 2026 at 01:19:22PM +0800, Vernon Yang wrote:
> From: Vernon Yang <yanglincheng@kylinos.cn>
>
> When the swap entries found exceed max_ptes_swap, the loop is left via
> break with folio still holding the xarray value that encodes the swap
> entry, not valid folio pointer.
>
> That value is passed to trace_mm_khugepaged_scan_file(), which feeds it
> to folio_pfn(). On FLATMEM and SPARSEMEM_VMEMMAP, the page_to_pfn() is
> plain pointer arithmetic, so the trace event merely prints bogus
> scan_pfn. On classic SPARSEMEM, the page_to_pfn() reads page->flags,
> dereferencing the tiny encoded integer and oopsing khugepaged whenever
> the trace event is enabled.

Hmm I seem to recall that we were no longer spporting !VMEMMAP SPARSEMEM, but
maybe I was imagining that :)

But this needs fixing in general anyway.

>
> So when folio is the swap entry value, simply set pfn to -1, just like
> exhausted scan naturally.
>
> And the folio_put() has maybe dropped the last reference of folio. The
> trace_mm_khugepaged_scan_file() is left with a dangling folio pointer.
> so using the folio_pfn() before dropping the reference, closing
> use-after-free window.
>
> Fixes: d41fd2016ed0 ("mm/khugepaged: add tracepoint to hpage_collapse_scan_file()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
> ---
>  include/trace/events/huge_memory.h |  6 +++---
>  mm/khugepaged.c                    | 14 +++++++++-----
>  2 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index 291fae364c62..d3572d4ef453 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -178,10 +178,10 @@ TRACE_EVENT(mm_collapse_huge_page_swapin,
>
>  TRACE_EVENT(mm_khugepaged_scan_file,
>
> -	TP_PROTO(struct mm_struct *mm, struct folio *folio, struct file *file,
> +	TP_PROTO(struct mm_struct *mm, unsigned long pfn, struct file *file,
>  		 int present, int swap, int result),
>
> -	TP_ARGS(mm, folio, file, present, swap, result),
> +	TP_ARGS(mm, pfn, file, present, swap, result),
>
>  	TP_STRUCT__entry(
>  		__field(struct mm_struct *, mm)
> @@ -194,7 +194,7 @@ TRACE_EVENT(mm_khugepaged_scan_file,
>
>  	TP_fast_assign(
>  		__entry->mm = mm;
> -		__entry->pfn = folio ? folio_pfn(folio) : -1;
> +		__entry->pfn = pfn;

I wonder how easy it is for people to interpret that this is a PFN of something
only in the case of an early exit.

It's a bit of a mess that we're exposing internal implementation details like
this, quite honestly.

I hope there is no expectation of this being there indefinitely.

>  		__assign_str(filename);
>  		__entry->present = present;
>  		__entry->swap = swap;
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 617bca76db49..e7830761d3a2 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2683,6 +2683,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
>  	int present, swap;
>  	int node = NUMA_NO_NODE;
>  	enum scan_result result = SCAN_SUCCEED;
> +	unsigned long pfn;

See below I think we should drop it.

>
>  	present = 0;
>  	swap = 0;
> @@ -2720,27 +2721,23 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
>  			 * PMD-sized THP implies that we can only try
>  			 * retracting the PTE table.
>  			 */
> -			folio_put(folio);
>  			break;
>  		}
>
>  		node = folio_nid(folio);
>  		if (collapse_scan_abort(node, cc)) {
>  			result = SCAN_SCAN_ABORT;
> -			folio_put(folio);
>  			break;
>  		}
>  		cc->node_load[node]++;
>
>  		if (!folio_test_lru(folio)) {
>  			result = SCAN_PAGE_LRU;
> -			folio_put(folio);
>  			break;
>  		}
>
>  		if (folio_expected_ref_count(folio) + 1 != folio_ref_count(folio)) {
>  			result = SCAN_PAGE_COUNT;
> -			folio_put(folio);
>  			break;
>  		}
>
> @@ -2759,7 +2756,14 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
>  			cond_resched_rcu();
>  		}
>  	}
> +	if (!folio || xa_is_value(folio)) {
> +		pfn = -1;
> +	} else {
> +		pfn = folio_pfn(folio);
> +		folio_put(folio);
> +	}

Hmm kinda hate this you're now mixing clean up logic with some trace logic.

You have to go check out xas_for_each() and see that xas_next_entry() sets folio
to NULL at the end for the normal case to know this is OK and then figure out
that this is just for the break cases.

That's not intuitive in already not intuitive code.

And this is a patch you're wanting to backport to fix a bug too... :)

I think you should keep the folio_put()'s where they are for now and limit this
fix to the trace code please.

I think you should drop the pfn var altogether and do this far more simply, see
below.

>  	rcu_read_unlock();
> +

Stray newline added, let's not do that for a backported fix please :)

>  	if (result == SCAN_PTE_MAPPED_HUGEPAGE)
>  		cc->progress++;
>  	else
> @@ -2774,7 +2778,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
>  		}
>  	}
>
> -	trace_mm_khugepaged_scan_file(mm, folio, file, present, swap, result);
> +	trace_mm_khugepaged_scan_file(mm, pfn, file, present, swap, result);

I mean maybe better to just reduce this to something like:

	/* folio is NULL unless exited early. */
	trace_mm_khugepaged_scan_file(mm,
			(!folio || xa_is_value(folio)) ? -1 : folio_pfn(folio),
			file, present, swap, result);

As the least invasive way of fixing the trace + limiting the contageon?

>  	return result;
>  }
>
> --
> 2.53.0
>

--
Cheers, Lorenzo
