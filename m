Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07108411A17;
	Mon, 24 Aug 2026 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787572801; cv=none; b=RnTjqv0m7RFGEb1d/kxBP9qv+Vy4S+sQ2nzZ4K3TzmkbpsCcCKfYJgIWXRnZZ+Tu1avk5NROWsNft0SxsDt+zwITVomkJepJXfvDyc5CiTzlG1MGJQTIPKbEtrd7Q3NkgvJY8+A4/O1jxq2E/4lZcvYoZKDGIEgLvHnpuzlzIvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787572801; c=relaxed/simple;
	bh=2usbdkss54KNYExpP+scOyPTXsgm7rxDjwMzP29O+S8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fG+YofFMDClskqtHfc5X6S1YZ+XyOBpwAXDcgsxyREjBHGBXQRC5FQ2Q+TCPucrJnze7eu0xbmydWt1C+MYEwwMglt404InazD6C+Ic9Zj1wUhWYN6IoaSt3wBEaOFThcLq82eX0MfDeeYMBV/HsEPpLOYW3eGf0ebP/9I4H1Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DV8XUbma; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DV8XUbma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3691D1F000E9;
	Mon, 24 Aug 2026 11:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787572799;
	bh=rTuYvF3Mu7p31xlyX3il8puWDUAl1lur7TZTZMOinSw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DV8XUbmaKUGJZhyQ1aHYwN/aGyQChNpP/e/L2YUvyE4Qt2E6lWjS7DsjwkPQCtXPu
	 11Dgzi+rcPEI2V8DfmdRO+2hM6TZmmOOOCZW+MtGDSp/Iw5jx/tyEPab/lS3768PXt
	 +coJPLqdOA25xoeeLV6zmReX18s1vkXtEyAPQLCTUCl82xr1GdOrVHx073h1aGx3rH
	 IyBrhiIRf77corKNQlykvoVSUJd8TtjLwOLjVZxf4TKijbBl/XOCDUPTu1okWd+VlW
	 NhdOqmSULDHu45jlzUp2eCPONjeTRfoA19bjWYycWlWQp21DAEhUrl4VDPmqbmBmXe
	 zT8NEIkG46Rqg==
Message-ID: <8001afe8-84e4-43d4-971b-b23f72070339@kernel.org>
Date: Mon, 24 Aug 2026 13:59:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] mm: khugepaged: fix folio is used after
 folio_put/unlock()
To: Vernon Yang <vernon2gm@gmail.com>, akpm@linux-foundation.org,
 ljs@kernel.org
Cc: nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, lance.yang@linux.dev, usama.arif@linux.dev,
 zokeefe@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 stable@vger.kernel.org, Vernon Yang <yanglincheng@kylinos.cn>
References: <20260824092935.73892-1-vernon2gm@gmail.com>
 <20260824092935.73892-4-vernon2gm@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20260824092935.73892-4-vernon2gm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 11:29, Vernon Yang wrote:
> From: Vernon Yang <yanglincheng@kylinos.cn>
> 
> On the rollback path, folio_put() has already dropped the last reference
> of new_folio. On the success path, new_folio is already unlocked and can
> be freed concurrently. The trace_mm_khugepaged_collapse_file() is left
> with a dangling folio pointer.
> 
> So using the folio_pfn() before dropping the reference, closing
> use-after-free window.
> 
> Fixes: 4c9473e87e75 ("mm/khugepaged: add tracepoint to collapse_file()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
> ---
>  include/trace/events/huge_memory.h | 6 +++---
>  mm/khugepaged.c                    | 5 ++++-
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index fa828967e1fb..5fb4d92cfd84 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -211,10 +211,10 @@ TRACE_EVENT(mm_khugepaged_scan_file,
>  );
>  
>  TRACE_EVENT(mm_khugepaged_collapse_file,
> -	TP_PROTO(struct mm_struct *mm, struct folio *new_folio, pgoff_t index,
> +	TP_PROTO(struct mm_struct *mm, unsigned long new_pfn, pgoff_t index,
>  			unsigned long addr, bool is_shmem, struct file *file,
>  			int nr, int result),
> -	TP_ARGS(mm, new_folio, index, addr, is_shmem, file, nr, result),
> +	TP_ARGS(mm, new_pfn, index, addr, is_shmem, file, nr, result),
>  	TP_STRUCT__entry(
>  		__field(struct mm_struct *, mm)
>  		__field(unsigned long, hpfn)
> @@ -228,7 +228,7 @@ TRACE_EVENT(mm_khugepaged_collapse_file,
>  
>  	TP_fast_assign(
>  		__entry->mm = mm;
> -		__entry->hpfn = new_folio ? folio_pfn(new_folio) : -1;
> +		__entry->hpfn = new_pfn;
>  		__entry->index = index;
>  		__entry->addr = addr;
>  		__entry->is_shmem = is_shmem;
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 4e0fca5942dd..24347f1a94ae 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2254,6 +2254,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>  	struct address_space *mapping = file->f_mapping;
>  	struct page *dst;
>  	struct folio *folio, *tmp, *new_folio;
> +	unsigned long new_pfn = -1;
>  	pgoff_t index = 0, end = start + HPAGE_PMD_NR;
>  	LIST_HEAD(pagelist);
>  	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
> @@ -2633,6 +2634,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>  	retract_page_tables(mapping, start);
>  	if (cc && !cc->is_khugepaged)
>  		result = SCAN_PTE_MAPPED_HUGEPAGE;
> +	new_pfn = folio_pfn(new_folio);

Why not set new_pfn once after successful alloc_charge_folio()?




-- 
Cheers,

David
