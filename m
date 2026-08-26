Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1403B841D;
	Wed, 26 Aug 2026 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731980; cv=none; b=mM/7AMpNvZ0g80up0AamaPi2BKF1FEU6tPMlfdInYw8ORg+0IqFiuSwnBzyTpaeoyVwY4wwXCj5ZnKZEIwF9/69X9S3qxXLjZawH7o4EXYFMMRzXpNKAOqpkVoSg2wXUaOITdIRNkrLD6ShmYJP75TuFEPWom0/2rG9elP4eVTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731980; c=relaxed/simple;
	bh=DAZVO8sv+wbwKAq8r3UxKs7CZsVOtvU3+AbbjStKYX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhTwtjoBlFRh/HDHz5IGoorIxpo5BkLwwcoVQBlN068OK4Hn6ltsZFX9Hq6mV3atOUJUXdBLaISbeHDXN5ACQhyIZs018LofJnazfiv77QlgVVBGoSELDqrqreDZ8L8PP7PRFmVhsUa7FdRr4JeRWKgld5zCh0iRu9JpO2mPvzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWUHJOgz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWUHJOgz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98141F000E9;
	Wed, 26 Aug 2026 08:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787731978;
	bh=mHM+KLGJhKONQ8oZCL9USP5IfUiOqstnnbJ6mUwf/Kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PWUHJOgzhS85nKK26GiYPIQe1YdM9KPHP1BRkbXQ2o/tdh3h4hIqfKbYMR9IKXrmt
	 8lrSbafX0pmxFrgpA9jz6ujqod5rhnUBj9ZpnRNz4YBZvvyMh1E8b5EwLfS5Dy0jyc
	 ckfHPIGBZ5af14FWF1sDnBJHKUnyZW6V7dXI3zQaZBjQiAVyWt6r1Q5vtA9pTsC0j1
	 98p7/RD/+eD5Cv74Y5f02K6pr97YCSlJcxyVwq6PyP5gekKI4yjwWKNg3r2IKM7ZFi
	 cLuDKNNVcJtehBhf/GMuNKjY6YvDeM25NlfpaW2j+HGCwDAehn3Qu8iJfYvSrJt0r9
	 Qa6RlyaKWzqtw==
Date: Wed, 26 Aug 2026 09:12:52 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Vernon Yang <vernon2gm@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, nico.pache@linux.dev, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
	usama.arif@linux.dev, zokeefe@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org, Vernon Yang <yanglincheng@kylinos.cn>
Subject: Re: [PATCH v3 2/3] mm: khugepaged: fix folio is used after
 pte_unmap_unlock()
Message-ID: <ao6f4773bhQb-CtQ@gremlin>
References: <20260824092935.73892-1-vernon2gm@gmail.com>
 <20260824092935.73892-3-vernon2gm@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824092935.73892-3-vernon2gm@gmail.com>

On Mon, Aug 24, 2026 at 05:29:34PM +0800, Vernon Yang wrote:
> From: Vernon Yang <yanglincheng@kylinos.cn>
>
> After the page table lock has dropped, the folio can be freed
> concurrently. The trace_mm_khugepaged_scan_pmd() is left with
> a dangling folio pointer.
>
> So using the folio_pfn() before dropping the page table lock,
> closing use-after-free window.
>
> Fixes: 7d2eba0557c1 ("mm: add tracepoint for scanning pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
> ---
>  include/trace/events/huge_memory.h | 6 +++---
>  mm/khugepaged.c                    | 5 ++++-
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index 7b526528f85b..fa828967e1fb 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -55,10 +55,10 @@ SCAN_STATUS
>
>  TRACE_EVENT(mm_khugepaged_scan_pmd,
>
> -	TP_PROTO(struct mm_struct *mm, struct folio *folio,
> +	TP_PROTO(struct mm_struct *mm, unsigned long pfn,
>  		 int referenced, int none_or_zero, int status, int unmapped),
>
> -	TP_ARGS(mm, folio, referenced, none_or_zero, status, unmapped),
> +	TP_ARGS(mm, pfn, referenced, none_or_zero, status, unmapped),
>
>  	TP_STRUCT__entry(
>  		__field(struct mm_struct *, mm)
> @@ -71,7 +71,7 @@ TRACE_EVENT(mm_khugepaged_scan_pmd,
>
>  	TP_fast_assign(
>  		__entry->mm = mm;
> -		__entry->pfn = folio ? folio_pfn(folio) : -1;
> +		__entry->pfn = pfn;
>  		__entry->referenced = referenced;
>  		__entry->none_or_zero = none_or_zero;
>  		__entry->status = status;
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 00337405c0e0..4e0fca5942dd 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1618,6 +1618,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>  	enum scan_result result = SCAN_FAIL;
>  	struct page *page = NULL;
>  	struct folio *folio = NULL;
> +	unsigned long pfn = -1;

pfn_t please.

>  	unsigned long addr;
>  	unsigned long enabled_orders;
>  	spinlock_t *ptl;
> @@ -1780,6 +1781,8 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>  		result = SCAN_SUCCEED;
>  	}
>  out_unmap:
> +	if (folio)
> +		pfn = folio_pfn(folio);

And +1 to David on ensuring this is reset to NULL appropriately.

>  	pte_unmap_unlock(pte, ptl);
>  	if (result == SCAN_SUCCEED) {
>  		/* collapse_huge_page() expects the lock to be dropped before calling */
> @@ -1790,7 +1793,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>  		*lock_dropped = true;
>  	}
>  out:
> -	trace_mm_khugepaged_scan_pmd(mm, folio, referenced,
> +	trace_mm_khugepaged_scan_pmd(mm, pfn, referenced,
>  				     none_or_zero, result, unmapped);
>  	return result;
>  }
> --
> 2.53.0
>

--
Cheers, Lorenzo
