Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1569449B2D;
	Mon, 17 Aug 2026 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786983137; cv=none; b=sx3pGc4mXQCcK4dyeqyoYU5UUv75ZhA05nFy2NCNurWHQWLFNSnFGEmE173aJD6fBOpIM2dGHwHtQ+8G+frdrIF2eHdoZTBNsScEkak1MzVDenvhzQZKMs+F8frOc828QMIYBlt+vqeU2i+HqTbMLepGhF/cBJUKPlOyv66lxBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786983137; c=relaxed/simple;
	bh=QoSuaU8OFRJme2lV0npACZeRyv+Id01q+oSFvvjDlVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnJhCRELlWjHhW8Pw9AxfzIzX9b+p8VVMkDPH+twXuoB8W709w8O+DKkvV2V+/WWBc3eXfpiLT09wk0DBT9w9PzRgT7AEh8rgcxDjDeQaSoSAJR0pezb4VmS+FtgL+JhCVcfeZAMLeChcsHsbOCQbraHD3x5dwhyFxRFZINsMMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMzJBZll; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMzJBZll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07ABF1F000E9;
	Mon, 17 Aug 2026 16:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786983135;
	bh=FQUvrkehKpwo8jNXcs2xc61eh0IJJnnFxqJq+fJqvow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CMzJBZllxMo1S2XbnPp2+ODTD9IPmNxlpBKWEemO/6ae+sZK+yiC8J1YN2t5oLDQI
	 zykM+NdAwk/Gm2M1oBQqTlZDJMXMHTRDHj8Eix49bl/yj9DHUNwS3f7wNDtKiacYNz
	 lfbYgrzB4XALIVHOZs2SSzfwSvmKM1ZgLGzaa5BbjmON4PrTADLdblHH1KacPLVnpU
	 5Pq/alv6hVTGv6eIQdLLz4bJ/wDVsNvLNmXbOY4w6JP1V4f1zli5fkXFI3p1Vndej4
	 494gx6ntrO8yURjrgPHQsPXVJBl7IVRIcWUlYL40rjIDDc3YMkmAWuCCV7Zxn6K9qn
	 Icya7Qcq03yvw==
Date: Mon, 17 Aug 2026 17:11:56 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Vernon Yang <vernon2gm@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, nico.pache@linux.dev, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
	usama.arif@linux.dev, zokeefe@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Vernon Yang <yanglincheng@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mm: khugepaged: fix folio is used after
 pte_unmap_unlock()
Message-ID: <aoMynfFI2XK2UXXN@lucifer>
References: <20260815051924.194810-1-vernon2gm@gmail.com>
 <20260815051924.194810-3-vernon2gm@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815051924.194810-3-vernon2gm@gmail.com>

On Sat, Aug 15, 2026 at 01:19:23PM +0800, Vernon Yang wrote:
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
>  mm/khugepaged.c                    | 4 +++-
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index d3572d4ef453..5dc71d292f47 100644
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
> index e7830761d3a2..7c8c48577408 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1603,6 +1603,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>  	enum scan_result result = SCAN_FAIL;
>  	struct page *page = NULL;
>  	struct folio *folio = NULL;
> +	unsigned long pfn = -1;
>  	unsigned long addr;
>  	unsigned long enabled_orders;
>  	spinlock_t *ptl;
> @@ -1778,6 +1779,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>  		result = SCAN_SUCCEED;
>  	}
>  out_unmap:
> +	pfn = folio ? folio_pfn(folio) : -1;
>  	pte_unmap_unlock(pte, ptl);
>  	if (result == SCAN_SUCCEED) {
>  		/* collapse_huge_page expects the lock to be dropped before calling */
> @@ -1788,7 +1790,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>  		*lock_dropped = true;
>  	}
>  out:
> -	trace_mm_khugepaged_scan_pmd(mm, folio, referenced,
> +	trace_mm_khugepaged_scan_pmd(mm, pfn, referenced,

Same comment as 1/3 I don't see why we should be storing a pfn value used
nowhere else just for tracing.

>  				     none_or_zero, result, unmapped);
>  	return result;
>  }
> --
> 2.53.0
>

--
Cheers, Lorenzo
