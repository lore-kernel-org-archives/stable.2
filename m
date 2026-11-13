Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604255;
	b=yjEz7eqO7bm2Kung8vBIWjM24z6UZYhUIve6m+MA8iDLItH5mix9sWbQ2CDtkIy+qTTt
	 p8i+Aao7WMFol26AYQFKjWw8xrWHazQ1boCtERpW32OLjqbcYUKdvjaVulhhmSz8JBl3a
	 9Na1sLYYGq8BsYObv6zg/pMdQvlK3HTrv8YqJcDUAhva2DI7GzlTTmgwDmjREFNEsE5W+
	 3M46gowNqz36oLJHcNiEV/GLly7bxMIN7g4eyx0xWDdhY7eNaN1QOjAvQv26tN7pPUCK3
	 /8mnGr9uiqbAd7Yt34wegAVVHtBINnrWiAzIm/4axbPHTQpF2mMXEgzAxEHd9zyab/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604255;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=eNX9PRs12wEvtOpFuHeZVZADVMT79l+m7/X1dUvnqbE=;
	b=LnYnxRXZajNnqZgTjvkSrckjMcfmlmsAfyDiNphPeDHbT87hPaPDf8yPtYV40DmOnXk0
	 9fAPAvcQ1FFAGumjQVo/BshgKBMAU/1IatD58IhD0Vq6kH/cLSlhq45JxUBK+50brJMiv
	 k0Iqo9mBkNA/sCAjLN1zE7I08On6qFMTthtudGVvFJHcsrFvv/1NwBrQhXNpCg9ve1Mud
	 UqFGAB6to7VQZ3HYqjp9QoMc4w0vJXo+/nFCcRXATrcdzwiS1YoIYLnaqA1JXdprMAvTs
	 XRYoKorzjNwnVa29STWbWHVXvH88MYMpqbFD0yhIYpWUlwgqk3eP0W15RCRyOxOQi0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Prn6xmv6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7349F606A335;
	Fri, 13 Nov 2026 21:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Prn6xmv6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111751F000C4;
	Fri, 13 Nov 2026 21:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794604255;
	bh=eNX9PRs12wEvtOpFuHeZVZADVMT79l+m7/X1dUvnqbE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Prn6xmv6HHRpPSZb/fj0yneI6YgxjAwhILamg/+ltT2OJwC8UbiGZaRh9nKjTLGQJ
	 QtHQhX6ESp8/rdGqEEy3T3FHZVSLoybbdg1ippq3W3HgHkeT1JEYPd6ZFcV67SGJdn
	 nw7Q1yunbvMaWmWg0jANOqY6KHd9NV0juzHX5SvOvmVOwaCdC7EuqhpXP61aYQ2bOA
	 ySgLa93b9SFql0F7Chzpu6O+Kq0583qoCcNQteGyeRp/4zGDnFV899PE9aSI5IZpsZ
	 Z/rqEaOnn3sTr6p61mH7QHtQrHU7mUBTEiyZrcm42BIHJykEtxxzTk8wCxvUGFRw/I
	 /d89nvFfiJJpg==
Message-ID: <f8b0f20d-90dd-496d-97e9-9a232124e3e0@kernel.org>
Date: Fri, 13 Nov 2026 22:10:49 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/madvise: zap markers from guard regions
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>,
 stable@vger.kernel.org
References: <20261113-disallow-uffd-guard-install-v2-1-9d0063c70542@kernel.org>
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
In-Reply-To: <20261113-disallow-uffd-guard-install-v2-1-9d0063c70542@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/26 22:04, Lorenzo Stoakes (ARM) wrote:
> In order to establish guard regions, guard markers are installed in the
> page tables of a mapped VMA.
> 
> However, problems arise when one tries to combine this with registering a
> VMA for userfaultfd, as such operations may themselves need to install page
> table markers such as uffd-wp.
> 
> When the installation is attempted the guard marker prevents these markers
> being applied, which can lead to unexpected results (especially if the
> guard regions are later removed.)
> 
> This is especially problematic because guard region installation causes the
> regions to be zapped first, meaning that the removal of userfaultfd-tracked
> ranges will not be logged in this case.
> 
> Additionally, the uffd-wp page table marker will be propagated regardless
> for file-backed mappings as the zap being performed does not clear these
> markers.
> 
> This is problematic, as it can cause repeated failure to install guard
> markers resulting in an infinite loop.
> 
> Therefore, update guard region installation to invoke the zap with the
> ZAP_FLAG_DROP_MARKER flag applied.
> 
> Both before and after this change, uffd remove events will not trigger on
> guard region installation, nor will write protect state be propagated after
> guard region removal.
> 
> This makes sense as conceptually, guard regions mark a part of a VMA as
> effectively unmapped at the page table level, and removing the markers is
> like mapping the VMA again, over which operation uffd markers would in any
> case be lost.
> 
> A survey of open source users indicates nobody is relying on installing
> guard regions in uffd-armed VMAs. Software including glibc, android,
> tcmalloc and CRIU were checked.
> 
> This change means that any already established guard regions are removed on
> zap. These will be overwritten with the newly installed guard markers on
> success.
> 
> However, if this fails for some reason (fatal signal likely the only
> reasonable cause), guard regions may remain removed, and concurrent faults
> may succeed in the interim in the range.
> 
> Since the installation failing guarantees nothing about the range being
> installed into, and since success overwrites with guard markers, this isn't
> an issue.
> 
> Since MADV_DONTNEED does something similar, abstract the zapping to
> zap_range() and call it from both places.
> 
> Fixes: f807123d578d ("mm: allow guard regions in file-backed and read-only mappings")
> Reported-by: Tal Zussman <tz2294@columbia.edu>
> Closes: https://lore.kernel.org/all/20261111-uffd-state-fixes-v1-9-00713d368976@columbia.edu/
> Closes: https://lore.kernel.org/all/20261111-uffd-state-fixes-v1-10-00713d368976@columbia.edu/
> Closes: https://lore.kernel.org/all/20261111-uffd-state-fixes-v1-11-00713d368976@columbia.edu/
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
> v2:
> * Updated to just zap everything as per David + Tal.
> 
> v1:
> https://lore.kernel.org/r/20261112-disallow-uffd-guard-install-v1-1-bcf8b1aaa72e@kernel.org
> ---
>  mm/madvise.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 0214efd2a014..4f7728583207 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -850,6 +850,19 @@ static int madvise_free_single_vma(struct madvise_behavior *madv_behavior)
>  	return 0;
>  }
>  
> +static void zap_range(struct madvise_behavior *madv_behavior,
> +		      zap_flags_t flags)

Two ... ;) But maybe it's consistent like that in the file, didn't check.

> +{
> +	const struct madvise_behavior_range *range = &madv_behavior->range;
> +	struct zap_details details = {
> +		.reclaim_pt = true,
> +		.zap_flags = flags,
> +	};
> +
> +	zap_vma_range_batched(madv_behavior->tlb, madv_behavior->vma,
> +			      range->start, range->end - range->start, &details);
> +}
> +
>  /*
>   * Application no longer needs these pages.  If the pages are dirty,
>   * it's OK to just throw them away.  The app will be more careful about
> @@ -872,13 +885,7 @@ static int madvise_free_single_vma(struct madvise_behavior *madv_behavior)
>  static long madvise_dontneed_single_vma(struct madvise_behavior *madv_behavior)
>  
>  {
> -	struct madvise_behavior_range *range = &madv_behavior->range;
> -	struct zap_details details = {
> -		.reclaim_pt = true,
> -	};
> -
> -	zap_vma_range_batched(madv_behavior->tlb, madv_behavior->vma,
> -			      range->start, range->end - range->start, &details);
> +	zap_range(madv_behavior, 0);
>  	return 0;
>  }
>  
> @@ -1217,9 +1224,11 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
>  
>  		/*
>  		 * OK some of the range have non-guard pages mapped, zap
> -		 * them. This leaves existing guard pages in place.
> +		 * them. This also drops any PTE markers in the range,
> +		 * including existing guard markers, which we reinstall on
> +		 * the next attempt.
>  		 */
> -		zap_vma_range(vma, range->start, range->end - range->start);
> +		zap_range(madv_behavior, ZAP_FLAG_DROP_MARKER);
>  	}
>  
>  	/*
> @@ -1845,6 +1854,7 @@ static bool madvise_batch_tlb_flush(int behavior)
>  	case MADV_DONTNEED:
>  	case MADV_DONTNEED_LOCKED:
>  	case MADV_FREE:
> +	case MADV_GUARD_INSTALL:

Huh why that change? Not spelled out above.

Apart from that LGTM.

-- 
Cheers,

David
