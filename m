Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E69379C32;
	Wed, 26 Aug 2026 08:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731683; cv=none; b=q0APnUTqO7zomb9ialz3bc3t1HyneqwguI18ZSRIBra+NjWuBX4LD0WnF76oFwdyw0hiI9xhkHl/5mwMkN5ySwMOHDj9NugYqPoPTE9queldECfAk7FYmUUFIOwVz96F9ZTHwR8XIg0Xf7VkaKvbpx+NS+f17tLn8uTHmt417mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731683; c=relaxed/simple;
	bh=3u2+7y/v6V2bidIkbguCHiMTsXDy++wrF+IRQwwUvCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YB6RpjUuUotGKEoeRO8Hpe0l+Ftz/IoF79eqVmGUQ7kkPc4UqTA+sHCe+NMMaiiSWrdXOhYrGHc6wTFNK20Aj+Muk28nuILLdsmPFq2GWwdHb+v0vSz/p3YVJLVeInKaLA2f6/mqpHBm2MKPFW2lt3xl/DZgBArodq635Acv0uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DR7QvqSz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DR7QvqSz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41001F000E9;
	Wed, 26 Aug 2026 08:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787731681;
	bh=QQdtBssAwwKPp/yVBHLqOxmBB73GFT/M0a43+g7tuu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DR7QvqSz+6My6tCuflSAf6AqnatJqWsaMh3RP7hk4YEA4FzjSmojxxWBLFeiV+Ejn
	 1oaldsgxytC3EixN725F6VQ0bRO2T/ae9L7KeLoHPgxBsazha8g3jpsvK1/finMsDr
	 1E8Mi0TiEz2A/eAFphoVdL/ckxOzkFx5oggf04eTTxoUHHC2g7YtUGSOCSNWryjHtS
	 u34f5qoKsO1xjoVhMW1hf8ZtVzB/lWD0dRFYL7eeTUDyXAFjS2k3qG9dUgfvi/IAoj
	 zUelNYzlCy5nEbnBjqJCi45iejK6Co5uMPjg/ukLc2Kjf4reLkiPYfbvXnEhQuHrlS
	 kxHGnJWI4wJ7Q==
Date: Wed, 26 Aug 2026 09:07:55 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Vernon Yang <vernon2gm@gmail.com>, akpm@linux-foundation.org, 
	nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, usama.arif@linux.dev, zokeefe@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, 
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: Re: [PATCH v3 1/3] mm: khugepaged: fix swap entry value to
 folio_pfn()
Message-ID: <ao6c6Oe_KV0O1LJn@gremlin>
References: <20260824092935.73892-1-vernon2gm@gmail.com>
 <20260824092935.73892-2-vernon2gm@gmail.com>
 <edd7ed8d-0f2c-4de3-89e5-f2b23c2dd1e5@kernel.org>
 <6a9c2369-5589-4f2a-bcfe-c6e3b46a1ccd@gmail.com>
 <c8e3bb54-e4f1-45d3-8059-3ee1910a920a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8e3bb54-e4f1-45d3-8059-3ee1910a920a@kernel.org>

On Wed, Aug 26, 2026 at 09:57:05AM +0200, David Hildenbrand (Arm) wrote:
> On 8/26/26 04:44, Vernon Yang wrote:
> > On Mon, Aug 24, 2026 at 01:54:18PM +0200, David Hildenbrand (Arm) wrote:
> >> On 8/24/26 11:29, Vernon Yang wrote:
> >>> From: Vernon Yang <yanglincheng@kylinos.cn>
> >>>
> >>> When the swap entries found exceed max_ptes_swap, the loop is left via
> >>> break with folio still holding the xarray value that encodes the swap
> >>> entry, not valid folio pointer.
> >>>
> >>> That value is passed to trace_mm_khugepaged_scan_file(), which feeds it
> >>> to folio_pfn(). On FLATMEM and SPARSEMEM_VMEMMAP, the page_to_pfn() is
> >>> plain pointer arithmetic, so the trace event merely prints bogus
> >>> scan_pfn. On classic SPARSEMEM, the page_to_pfn() reads page->flags,
> >>> dereferencing the tiny encoded integer and oopsing khugepaged whenever
> >>> the trace event is enabled.
> >>>
> >>> So when folio is the swap entry value, simply set pfn to -1, just like
> >>> exhausted scan naturally.
> >>>
> >>> And the folio_put() has maybe dropped the last reference of folio. The
> >>> trace_mm_khugepaged_scan_file() is left with a dangling folio pointer.
> >>> so using the folio_pfn() before dropping the reference, closing
> >>> use-after-free window.
> >>>
> >>> Fixes: d41fd2016ed0 ("mm/khugepaged: add tracepoint to hpage_collapse_scan_file()")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
> >>> ---
> >>>  include/trace/events/huge_memory.h | 6 +++---
> >>>  mm/khugepaged.c                    | 5 ++++-
> >>>  2 files changed, 7 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> >>> index 5a48c5406cce..7b526528f85b 100644
> >>> --- a/include/trace/events/huge_memory.h
> >>> +++ b/include/trace/events/huge_memory.h
> >>> @@ -178,10 +178,10 @@ TRACE_EVENT(mm_collapse_huge_page_swapin,
> >>>
> >>>  TRACE_EVENT(mm_khugepaged_scan_file,
> >>>
> >>> -	TP_PROTO(struct mm_struct *mm, struct folio *folio, struct file *file,
> >>> +	TP_PROTO(struct mm_struct *mm, unsigned long pfn, struct file *file,
> >>>  		 int present, int swap, int result),
> >>>
> >>> -	TP_ARGS(mm, folio, file, present, swap, result),
> >>> +	TP_ARGS(mm, pfn, file, present, swap, result),
> >>>
> >>>  	TP_STRUCT__entry(
> >>>  		__field(struct mm_struct *, mm)
> >>> @@ -194,7 +194,7 @@ TRACE_EVENT(mm_khugepaged_scan_file,
> >>>
> >>>  	TP_fast_assign(
> >>>  		__entry->mm = mm;
> >>> -		__entry->pfn = folio ? folio_pfn(folio) : -1;
> >>> +		__entry->pfn = pfn;
> >>>  		__assign_str(filename);
> >>>  		__entry->present = present;
> >>>  		__entry->swap = swap;
> >>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >>> index 79effd3f3da4..00337405c0e0 100644
> >>> --- a/mm/khugepaged.c
> >>> +++ b/mm/khugepaged.c
> >>> @@ -2689,6 +2689,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
> >>>  	int present, swap;
> >>>  	int node = NUMA_NO_NODE;
> >>>  	enum scan_result result = SCAN_SUCCEED;
> >>> +	unsigned long pfn;
> >>>
> >>>  	present = 0;
> >>>  	swap = 0;
> >>> @@ -2719,6 +2720,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
> >>>  			continue;
> >>>  		}
> >>>
> >>> +		pfn = folio_pfn(folio);
> >>>  		if (is_pmd_order(folio_order(folio))) {
> >>>  			result = SCAN_PTE_MAPPED_HUGEPAGE;
> >>>  			/*
> >>> @@ -2779,7 +2781,8 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
> >>>  		}
> >>>  	}
> >>>
> >>> -	trace_mm_khugepaged_scan_file(mm, folio, file, present, swap, result);
> >>> +	trace_mm_khugepaged_scan_file(mm, (!folio || xa_is_value(folio)) ? -1 : pfn,
> >>> +				      file, present, swap, result);
> >>>  	return result;
> >>>  }
> >>>
> >>
> >> Shouldn't we just reset PFN to -1 at the beginning of the loop (and set it
> >> initially)?
> >
> > When the `xas_for_each()` iteration to terminate and the folio operation
> > preceding is normal, but pfn will be incorrect.
>
> The PFN is only relevant when a folio participated in the failure. Maybe the
> following would be cleanest?
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 75639298efc27..371ee0b16d10c 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2683,6 +2683,7 @@ static enum scan_result collapse_scan_file(struct
> mm_struct *mm,
>         int present, swap;
>         int node = NUMA_NO_NODE;
>         enum scan_result result = SCAN_SUCCEED;
> +       unsigned long problematic_pfn = -1;

I find this name... problematic :)

What about:

	pfn_t pfn = -1; /* Assign on failure before dropping ref */

Then:

	if (result == SCAN_SUCCEED) {
		...
		trace_mm_khugepaged_scan_file(mm, -1, file, present, swap, result);
	} else {
		trace_mm_khugepaged_scan_file(mm, pfn, file, present, swap, result);
	}

?

Other than that I do think your approach of assigning it on failure is the
right one.

>
>         present = 0;
>         swap = 0;
> @@ -2714,6 +2715,7 @@ static enum scan_result collapse_scan_file(struct
> mm_struct *mm,
>                 }
>
>                 if (is_pmd_order(folio_order(folio))) {
> +                       problematic_pfn = folio_pfn(folio);
>                         result = SCAN_PTE_MAPPED_HUGEPAGE;
>                         /*
>                          * PMD-sized THP implies that we can only try
> @@ -2725,6 +2727,7 @@ static enum scan_result collapse_scan_file(struct
> mm_struct *mm,
>
>                 node = folio_nid(folio);
>                 if (collapse_scan_abort(node, cc)) {
> +                       problematic_pfn = folio_pfn(folio);
>                         result = SCAN_SCAN_ABORT;
>                         folio_put(folio);
>                         break;
> @@ -2732,12 +2735,14 @@ static enum scan_result collapse_scan_file(struct
> mm_struct *mm,
>                 cc->node_load[node]++;
>
>                 if (!folio_test_lru(folio)) {
> +                       problematic_pfn = folio_pfn(folio);
>                         result = SCAN_PAGE_LRU;
>                         folio_put(folio);
>                         break;
>                 }
>
>                 if (folio_expected_ref_count(folio) + 1 != folio_ref_count(folio)) {
> +                       problematic_pfn = folio_pfn(folio);
>                         result = SCAN_PAGE_COUNT;
>                         folio_put(folio);
>                         break;
> @@ -2773,7 +2778,7 @@ static enum scan_result collapse_scan_file(struct
> mm_struct *mm,
>                 }
>         }
>
> -       trace_mm_khugepaged_scan_file(mm, folio, file, present, swap, result);
> +       trace_mm_khugepaged_scan_file(mm, problematic_pfn, file, present, swap,
> result);
>         return result;
>  }
>
>
>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
