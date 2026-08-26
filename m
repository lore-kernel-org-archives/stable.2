Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665DB37F72F
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735334; cv=none; b=Vw0ZpJFct5n/t3YXjHn+6yKHAQ1HJPhDeEJoByrIvGX5K8uCz2Nrd7soEER02D9nQ5PFJX0UwKT/89DpC2toDqhFXVXl0FDaKIIufFVW58SwU+8MRlm7WNQQqTwVi+8HCbgOerQci734uUSgLJwfrgcQuOFTvnYt+P+KrQYnkr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735334; c=relaxed/simple;
	bh=J71Rw8rp/R1CpQuUZqlGL/KNAehRlY+Qa59LopVqz94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueGc3ApMb979FcYgteE7USpcHNladyUG0xG3JwjhidC1+KZQWn7IR7KegfZsp/4riLpUyj9x6Go05gomO6NDlWgEbxePopxs+LHB/mH6YcWw5XO+ZXKAb2P55LKFw4ASMj3s/9ZJsvfcIARZgPL8z9jakC50ZOERd6Cz0TUfgZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dio0J7Vi; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dio0J7Vi"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-853f8c34ba4so470449b3a.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 02:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787735333; x=1788340133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wsy4CZwXyrUEQvKaVnRxCtC5ibMuY6bQzne6mmJqiFY=;
        b=dio0J7ViK8n3SN0lOlUaRIuP8Qtl304JCnNSEymB1mWS/yUQaeG+Yl5ZVG3OTllGja
         Ze/8I0+0XBlcXDxCY6lxfi+4QkVzwdtmEcmirrU+sWvtok9n1EqtTmdvAz0xmdg67HJ1
         DGwilYdae1mNYp5gO3yYF6JfJBf104WR7LRAN74s0bsG3Rr9ZaaCX7+jB9MP3k9ojnVO
         mBTHPyOi4AUOR+lRkEgk3CcqySIGDWJbRN6T3h0zKEZALp61yYCuEvSU6fkehhf/+hoN
         I5JAuk/CsX2eMMcw6Gv8bxleS+RTBmi2EUyCl+605qOcDWjtQIbgtgr5fye3AymvWl2w
         kWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735333; x=1788340133;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wsy4CZwXyrUEQvKaVnRxCtC5ibMuY6bQzne6mmJqiFY=;
        b=XhlyLhKt4Neq5maS4rzHt9ovdL9SM7d4RYNLDWk0dD1LqU7GpG/QFKuAfkSebeiDeL
         YqW/ee97oFIpO+P3c5hG/lWEuFFKnNs8ynmzXzJ4HOsPmBVdxKvCalhdIc8Fr1tDXK0+
         f3SuY9Q4Gt69S6XaZzki0IAlnuLsJOI94X4p1kxhLnXkjQV0CVqBUTZPIG8hdo3+1Y1q
         iu+TW7pCTPZ/lB7hvGKQL+IkmlS2u+BFps8tsP8rAWXQXnpwzDS8mqINirEVubNAIROA
         9WiIxySxv+71oicCkFnxUsa0BteA0acx/mbxmW0Nixw2Rtr3o1/1tEPosuryEtI4MA0K
         tGgQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrt+DXUSUq7UlyWArR1ciVcUYIIQAZBfzKjzXk2hSW4xJ7FqvMn0IL0SU2NZlUdC6aVe1xJpmA=@vger.kernel.org
X-Gm-Message-State: AFuF++mM0WYcJaAlzGiIVpJ/9Bdis0Rxup5GSnoeI+U5QnIi3G+ENDS1
	6OVOtF7PnKnDmTNvnE5PnOw7TsLD/WcpZgqkJV7VRMYKouWasBW0+HOk
X-Gm-Gg: AR+sD13n5XR5YMjsPUBpPqBWyfdQG270uaNDTXryjSHDIqhRwaDoR9maAhE1rvuEzyb
	t77fHiZ+R0v7rpBaD7WtZYFls6KhEpFlmHipvQMgvLAp2s/NIt2fJRwYlKkLAB5WBCJBXAt41gB
	5Mod7CJlJ+cvh7/n1kKd5jEgKONw4C5y6frWudfHc3GaJCZWhp1oZYenwC2QiksR6jvvvpuZPGi
	Jw9vYuV3rxnEVyhk62fqeJv5znrASt+Nr3i0G6WEmqMLxyqZvvMHs3x62DYsLFU8OOWGU8C/5aR
	dmkMmMaYpMkyz/BATIXjEbSmjWIh/7T6ypA9U5Dz8ef62oWs7liDEJsUltV4x2OzKWeW2gtlcQH
	C6PxsLMBc/LGkFCuKwPNGmKR8jTaIN8wMTTENlTGj+EVpfvtiEefNyh+0b4E2HI+/yk0BKmxqEV
	RRS6RN38CFVT8Ujf5g+wU12mGYlhxsvkKz4HSXCAOfzzATj9jlh2NUep4yVOTX6wev/tpp2sAmN
	hM=
X-Received: by 2002:a05:6a00:4149:b0:852:5f99:1866 with SMTP id d2e1a72fcca58-8536e922f5fmr10466435b3a.0.1787735332560;
        Wed, 26 Aug 2026 02:08:52 -0700 (PDT)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535cd809bdsm669384b3a.28.2026.08.26.02.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 02:08:52 -0700 (PDT)
Date: Wed, 26 Aug 2026 17:08:44 +0800
From: Vernon Yang <vernon2gm@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, ljs@kernel.org, nico.pache@linux.dev, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
	usama.arif@linux.dev, zokeefe@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org, Vernon Yang <yanglincheng@kylinos.cn>
Subject: Re: [PATCH v3 1/3] mm: khugepaged: fix swap entry value to
 folio_pfn()
Message-ID: <50c73754-5e6e-48af-9d8e-148f4596387b@gmail.com>
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

Yes, this is clearer. I considered this approach before, but it would be
quite verbose.

LGTM, I will use this in the next version. Thanks!

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
>
