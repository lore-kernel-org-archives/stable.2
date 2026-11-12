Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474280;
	b=m7Sj3uaC+Ki5yrODU92OYH7Qs9v/YE2qh/twGzdO4mBRjFgZCuhT00EEf8g5iN7bFijS
	 gZ68Y+Bg3MkRnyNr8snk8efx0WOJElPnPYO2N86nDN57jOlR+u3keC7iq3aoBdnssbO9y
	 SJ5277jMc/Uf29UOjLCXAuR25AdxqxNKyxRnh0+zAayh9Cmed/+feTdIcWNMRyZhSLGBP
	 V2Zis/Rt+daeVUnHKQhynqcdPzw3pNDBlJNkwYavbAQq3tyT2EFmXRoK1upJ98C0MWhtz
	 AJLjGC7TIZSlCLej6s3Zyxw82VRUSBjdlrYi9Qac5xzeoyaXjJ6+cY/9sMV28B/4EWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474280;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=3QXd43+9YkcDdqXRXfijDPFLngipxJU07bnf2rvgj7k=;
	b=v/OF9k0KhNqgG3QqALDPQBkmuA4O4GesM6foi8VVFcPNGQvKW4KKFASIo/19VP2LORrF
	 3MJEZUHSNl8XwhWfT2UOEDcWQlmRHfi8njFMQNGuXHUYH+sOYpkybtPoels+vAbb44zH+
	 SdaQz8yFkUX8K0uAYt+yGkJu2d6EzfFOly+xA6AFIVuwxYxYCsnqaoRDw64ktHR/nZYcZ
	 cmW5kM85qNdnEQoJR7HDEIZm/J6DJJq2eRc8jiyxfnoAMILdNZ/TimkWn+/PX6u1AwIk1
	 yTCdwARRjBtvJ6W9aWNKpVc34aGOxWtPZjKmElW7lznxuXsRDCxW1NOMUkfFDGOZkBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jQBBi8sk;
	arc=none smtp.remote-ip=91.218.175.18
Received: from mta0.migadu.com (out-18.mta0.migadu.com [91.218.175.18])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B97C606A32E
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 09:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B97C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jQBBi8sk
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8Qf+LHzFQU7sWVDR2P/LLaDSEFd56f41ktqAEc9o61g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794474277; v=1; x=1795079077;
 b=jQBBi8skxsUmEGg7hgwl5JSxXg48EUwvnKFRaYkIg+/x+bn6PT2Qf94ueriElqvJRdjbGXL+
 wAX1gW4SAtXCwlINFhQQPaa269TqOTKCTLqthogsTDg00QhNrVzKBeJpwWIfrwVQksUNfQGsuSt
 AHo7FxKOYP5lSWWFzv9ZK1Xw=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8b0e325b35ab9706;
	Thu, 12 Nov 2026 09:04:37 +0000
X-Mizu-Trace-ID: 8b0e325b35ab9706
X-Migadu-Flow: FLOW_OUT
Message-ID: <cc8c4c79-e7b4-46f7-b8a2-b5564b3cc85a@linux.dev>
Date: Thu, 12 Nov 2026 17:04:28 +0800
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
Subject: Re: [PATCH v4 2/3] mm: gup: allow long-term pins of CMA-allocated
 HugeTLB folios
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Muchun Song <muchun.song@linux.dev>
Cc: osalvador@suse.de, akpm@linux-foundation.org, azpijr@gmail.com,
 Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1794379433.git.zhengqi.arch@bytedance.com>
 <503c9f6d869e3206c6fd591de962c3d619b73825.1794379433.git.zhengqi.arch@bytedance.com>
 <80FED512-77D2-4D49-BAE5-745CE1F711CA@linux.dev>
 <1116fd15-a927-4f6e-a0ab-084bc36a90aa@linux.dev>
 <ceb2ef49-69e8-425c-9582-ba6fb872e0cf@kernel.org>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <ceb2ef49-69e8-425c-9582-ba6fb872e0cf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/12/26 4:49 PM, David Hildenbrand (Arm) wrote:
> On 11/12/26 07:13, Qi Zheng wrote:
>>
>>
>> On 11/11/26 3:42 PM, Muchun Song wrote:
>>>
>>>
>>>>
>>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>
>>>> Long-term pinning treats explicitly CMA-allocated HugeTLB folios as
>>>> unpinnable, causing unnecessary migration or pinning failures.
>>>>
>>>> These folios already own their CMA bitmap ranges, and memory blocks
>>>
>>> Commit message needs updating to bitmap as well.
>>
>> Will do.
>>
>>>
>>>> overlapping CMA areas cannot be offlined. Allow HugeTLB folios with
>>>> HPG_cma to be pinned directly, including in ZONE_MOVABLE.
>>>>
>>>> Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages
>>>> using cma")
>>>> Cc: stable@vger.kernel.org
>>>> Suggested-by: Muchun Song <muchun.song@linux.dev>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> Acked-by: Muchun Song <muchun.song@linux.dev>
>>>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>>>> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
>>>> ---
>>>> include/linux/mm.h | 29 +----------------------------
>>>> mm/gup.c           | 31 +++++++++++++++++++++++++++++++
>>>> 2 files changed, 32 insertions(+), 28 deletions(-)
>>>>
>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>> index b0da9be413098..47d1d96bfc7fd 100644
>>>> --- a/include/linux/mm.h
>>>> +++ b/include/linux/mm.h
>>>> @@ -2954,35 +2954,8 @@ static inline bool is_zero_folio(const struct folio
>>>> *folio)
>>>>      return is_zero_page(&folio->page);
>>>> }
>>>>
>>>> -/* MIGRATE_CMA and ZONE_MOVABLE do not allow pin folios */
>>>> #ifdef CONFIG_MIGRATION
>>>> -static inline bool folio_is_longterm_pinnable(struct folio *folio)
>>>
>>> I think David prefer to move this function first, then fix it in a separate
>>> patch,
>>> right?
>>
>> Hi David, is this what you mean? If so, I will split it into two patches
>> for the v5.
> 
> Let's try something that is more future-directed: cma should deal with
> cma details. In the future we might implement something reasonable there.

Aha, that does make more sense. Will do.

Thanks,
Qi

> 
> diff --git a/include/linux/cma.h b/include/linux/cma.h
> index 8555d38a97b1a..d829fd0355bae 100644
> --- a/include/linux/cma.h
> +++ b/include/linux/cma.h
> @@ -21,6 +21,9 @@
>   #define CMA_MIN_ALIGNMENT_BYTES (PAGE_SIZE * CMA_MIN_ALIGNMENT_PAGES)
>   
>   struct cma;
> +struct folio;
> +
> +bool cma_folio_is_longterm_pinnable(struct folio *folio);
>   
>   extern unsigned long totalcma_pages;
>   extern phys_addr_t cma_get_base(const struct cma *cma);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6af3b7008f1ad..5392e225cab9b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3,6 +3,7 @@
>   #define _LINUX_MM_H
>   
>   #include <linux/args.h>
> +#include <linux/cma.h>
>   #include <linux/errno.h>
>   #include <linux/mmdebug.h>
>   #include <linux/gfp.h>
> @@ -2975,7 +2976,10 @@ static inline bool is_zero_folio(const struct folio *folio)
>   	return is_zero_page(&folio->page);
>   }
>   
> -/* MIGRATE_CMA and ZONE_MOVABLE do not allow pin folios */
> +/*
> + * MIGRATE_CMA and ZONE_MOVABLE folios cannot normally be long-term pinned.
> + * CMA may allow pinning folios explicitly allocated from its areas.
> + */
>   #ifdef CONFIG_MIGRATION
>   static inline bool folio_is_longterm_pinnable(struct folio *folio)
>   {
> @@ -2983,7 +2987,7 @@ static inline bool folio_is_longterm_pinnable(struct folio *folio)
>   	int mt = folio_migratetype(folio);
>   
>   	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
> -		return false;
> +		return cma_folio_is_longterm_pinnable(folio);
>   #endif
>   	/* The zero page can be "pinned" but gets special handling. */
>   	if (is_zero_folio(folio))
> diff --git a/mm/cma.c b/mm/cma.c
> index 9ec1d1fd5dff5..b3bf0014a90f5 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -27,6 +27,7 @@
>   #include <linux/log2.h>
>   #include <linux/cma.h>
>   #include <linux/highmem.h>
> +#include <linux/hugetlb.h>
>   #include <linux/io.h>
>   #include <linux/kmemleak.h>
>   #include <trace/events/cma.h>
> @@ -38,6 +39,16 @@
>   struct cma cma_areas[MAX_CMA_AREAS];
>   unsigned int cma_area_count;
>   
> +bool cma_folio_is_longterm_pinnable(struct folio *folio)
> +{
> +	/*
> +	 * Explicitly allocated CMA folios own their bitmap ranges and can be
> +	 * pinned even in ZONE_MOVABLE, as CMA memory cannot be offlined.
> +	 * For now, only HugeTLB tracks these allocations with a folio flag.
> +	 */
> +	return folio_test_hugetlb(folio) && folio_test_hugetlb_cma(folio);
> +}
> +
>   phys_addr_t cma_get_base(const struct cma *cma)
>   {
>   	WARN_ON_ONCE(cma->nranges != 1);

