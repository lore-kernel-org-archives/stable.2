Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778477;
	b=S3OwncgF/8iRZE7Ziq3A+598V/23ssUt+rqPtZeewNPmNAcEUlp47zLELzD5WpxXCMhM
	 mv+fFXTWrOVLWzMH0QD0uy7dwmUor3i1i8OLyzp58inPgVHwdLW7TMnAlIjqzTvEE3u0a
	 LE35xg9PbWwopEqXT0FbpM3vaShGMfvWKcHMRMZlpBEUUCN0wiqB+ofZ1eL96Zo17VCKw
	 xuILhRz1NnndntTrJVnWACGnLi46qCEkqIaqtnm6RSb+vARRE4mWAiFxU6RXeSD76h10B
	 lYyQT9kE1cbLZYchTtWbHBMEhxLtT14sNwTXTRGwTdPZspyPxo/aBs0VQnVyyA+LLPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778477;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=sDlodseTHUYdBDE8U9EBMQzIvxI2E8etBmPnHlBGbe4=;
	b=El/7Vc1vl7aSTL1hmyHm4+Yf0tTZTYz6Y3ORPB45n7mg8/Z8Gcy5N8UK79bvjeCjchM9
	 JYtFcn4XPQfzWYcopLfNxmUoeBe3u/vziQmJ35ccQEbOhTF/twYNoBPDjdYBdDJde061j
	 YaUJ+77rROvep4AdEnfaZFHJu47gV9rToeLOd1tXiHZqGi1mEHvjqDnExfZ0tYsxIFsB0
	 +TZxQ9a7zb8a4HVkNnW/8LeWh2rDDh9/wR5ckhCp9pgznvwjFfrXvvTbawWnfB430neOj
	 CVJmz0A+kG3LI7QHMvVat4nNNBDwAUtXTvKsuOCP+yWl2JlRyfhnwdZXFaBBcFrvrwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=D+NDpLB8;
	arc=none smtp.remote-ip=91.218.175.231
Received: from mta0.migadu.com (out-231.mta0.migadu.com [91.218.175.231])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAD2606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 07:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAAD2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=D+NDpLB8
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0JyHOnRJ/tnwgb0cYunQfYkiNN1NIfUkDxCymd783Zw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793778474; v=1; x=1794383274;
 b=D+NDpLB8FgH/m2MD1a+Myx9jAgt9m0ChiQdW7eJlYcQ4IwUpIljY6vXpgPyKQSA3F0IWpOQI
 Q9KAxj3nxiUDPKIMa1eY6Yug1gUnZpd1eW3cs++y52JjozTVwkk80l359pxwDfpn+egfSupVSmx
 v3vZ4fB3n2PYVA3SBUvaY/0A=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6abba58bc298b535;
	Wed, 04 Nov 2026 07:47:54 +0000
X-Mizu-Trace-ID: 6abba58bc298b535
X-Migadu-Flow: FLOW_OUT
Message-ID: <ae47e4d2-e847-4ee5-901f-56536527eadd@linux.dev>
Date: Wed, 4 Nov 2026 15:47:47 +0800
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
Subject: Re: [PATCH 2/4] mm: hugetlb: skip CMA allocations under
 PF_MEMALLOC_PIN
To: Muchun Song <muchun.song@linux.dev>
Cc: osalvador@suse.de, David Hildenbrand <david@kernel.org>,
 akpm@linux-foundation.org, azpijr@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1793692578.git.zhengqi.arch@bytedance.com>
 <5bc00742fe249cf09a3095abccf8889d5fa71116.1793692578.git.zhengqi.arch@bytedance.com>
 <4EC5E593-7537-4659-879C-95ECC2224D2F@linux.dev>
 <8b7f6573-ed12-494f-9210-d6f6dbf01567@linux.dev>
 <2DE679F1-C87F-4222-A710-C87CDE86D333@linux.dev>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <2DE679F1-C87F-4222-A710-C87CDE86D333@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Muchun,

On 11/4/26 3:07 PM, Muchun Song wrote:
> 
> 
>> On Nov 4, 2026, at 11:27, Qi Zheng <qi.zheng@linux.dev> wrote:
>>
>> Hi Muchun,
> 
> Hi,
> 
>>
>> On 11/3/26 6:56 PM, Muchun Song wrote:
>>>> On Nov 3, 2026, at 16:01, Qi Zheng <qi.zheng@linux.dev> wrote:
>>>>
>>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>
>>>> With gigantic overcommit enabled, a fault during long-term pinning
>>>> can allocate a fresh HugeTLB folio from CMA despite PF_MEMALLOC_PIN.
>>>>
>>>> The folio must then be migrated before it can be pinned. However,
>>>> fresh gigantic migration targets are not supported, so pinning fails
>>>> when the HugeTLB pool has no suitable target, even if the original
>>>> fault could have allocated pinnable memory outside CMA.
>>>>
>>>> Honor PF_MEMALLOC_PIN in the HugeTLB CMA allocator so the fault can
>>>> try the non-CMA fallback, or fail when allocation is restricted to CMA.
>>> Wait... I think my Acked-by got ahead of me here. :)
>>> There seems to be a rather odd distinction that GUP is missing.
>>> The usual reason long-term GUP must migrate a page out of a
>>> MIGRATE_CMA pageblock is that the page was only borrowed from CMA by the
>>> normal page allocator.  The corresponding CMA bitmap range is still
>>> available, so a future CMA allocation relies on being able to migrate
>>> that page away.  A long-term pin would prevent that.
>>> However, a HugeTLB folio returned by
>>> hugetlb_cma_alloc_frozen_folio() is different.  It is the actual CMA
>>> allocation, not merely a movable page that happens to reside in a
>>> MIGRATE_CMA pageblock.  Its range has already been marked allocated in
>>> the hugetlb CMA bitmap.
>>> Therefore, CMA cannot allocate that range again until the HugeTLB folio
>>> is freed anyway.  Long-term pinning the folio does not seem to make the
>>> CMA area any less available than keeping the HugeTLB folio mapped for
>>> the same amount of time.
>>> folio_is_longterm_pinnable() currently only sees MIGRATE_CMA and does
>>> not distinguish these two cases.  In that light, rejecting
>>> PF_MEMALLOC_PIN in hugetlb_cma_alloc_frozen_folio() looks like working
>>> around an overly broad GUP classification.  It also means that
>>> hugetlb_cma_only users will fail the fault, while other users may consume
>>> a gigantic contiguous range outside the dedicated hugetlb CMA area even
>>> when that area has free space.
>>> Would it make more sense to fix the long-term GUP check instead, so that
>>> an explicitly CMA-allocated HugeTLB folio is considered pinnable, while
>>> ordinary pages merely borrowed from MIGRATE_CMA pageblocks remain unpinnable?
>>
>> Make sense!
>>
>> I'll replace this patch with an exception for HPG_cma folios in the
>> MIGRATE_CMA check. This also lets the HugeTLB allocator select preallocated
>> CMA folios during long-term pinning. MIGRATE_ISOLATE and ZONE_MOVABLE
>> remain restricted.
>>
>> Fresh CMA allocations under PF_MEMALLOC_PIN also need to skip ranges
>> in ZONE_MOVABLE. Returning -EBUSY here lets CMA try its remaining ranges.
>>
>> The incremental diff against this patch is below.
>>
>> diff --git a/include/linux/cma.h b/include/linux/cma.h
>> index 8555d38a97b1..7fd1b6e65b58 100644
>> --- a/include/linux/cma.h
>> +++ b/include/linux/cma.h
>> @@ -21,11 +21,13 @@
>> #define CMA_MIN_ALIGNMENT_BYTES (PAGE_SIZE * CMA_MIN_ALIGNMENT_PAGES)
>>
>> struct cma;
>> +struct folio;
>>
>> extern unsigned long totalcma_pages;
>> extern phys_addr_t cma_get_base(const struct cma *cma);
>> extern unsigned long cma_get_size(const struct cma *cma);
>> extern const char *cma_get_name(const struct cma *cma);
>> +bool cma_folio_is_pinnable(struct folio *folio);
>>
>> extern int __init cma_declare_contiguous_nid(phys_addr_t base,
>> 			phys_addr_t size, phys_addr_t limit,
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index cb993a1d0728..d15810be7d96 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -3,6 +3,7 @@
>> #define _LINUX_MM_H
>>
>> #include <linux/args.h>
>> +#include <linux/cma.h>
>> #include <linux/errno.h>
>> #include <linux/mmdebug.h>
>> #include <linux/gfp.h>
>> @@ -2975,14 +2976,16 @@ static inline bool is_zero_folio(const struct folio *folio)
>> 	return is_zero_page(&folio->page);
>> }
>>
>> -/* MIGRATE_CMA and ZONE_MOVABLE do not allow pin folios */
>> +/* Borrowed CMA pages and ZONE_MOVABLE folios cannot be pinned long term. */
>> #ifdef CONFIG_MIGRATION
>> static inline bool folio_is_longterm_pinnable(struct folio *folio)
>> {
>> #ifdef CONFIG_CMA
>> 	int mt = folio_migratetype(folio);
>>
>> -	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
>> +	if (mt == MIGRATE_ISOLATE)
>> +		return false;
>> +	if (mt == MIGRATE_CMA && !cma_folio_is_pinnable(folio))
>> 		return false;
> 
> Actually, we do not need cma_folio_is_pinnable(), does the following work for you?

OK, will do.

> 
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2982,6 +2982,9 @@ static inline bool folio_is_longterm_pinnable(struct folio *folio)
>   #ifdef CONFIG_CMA
>          int mt = folio_migratetype(folio);
> 
> +       if (folio_test_hugetlb(folio) && folio_test_hugetlb_cma(folio))
> +               return true;
> +
>          if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
>                  return false;
>   #endif

We should move the implementation of folio_is_longterm_pinnable() to
mm/gup.c to avoid the header dependency and build errors.

> 
>> #endif
>> /* The zero page can be "pinned" but gets special handling. */
>> diff --git a/mm/cma.c b/mm/cma.c
>> index a10ea37a261d..c2814f54f86a 100644
>> --- a/mm/cma.c
>> +++ b/mm/cma.c
>> @@ -27,6 +27,7 @@
>> #include <linux/log2.h>
>> #include <linux/cma.h>
>> #include <linux/highmem.h>
>> +#include <linux/hugetlb.h>
>> #include <linux/io.h>
>> #include <linux/kmemleak.h>
>> #include <trace/events/cma.h>
>> @@ -55,6 +56,12 @@ const char *cma_get_name(const struct cma *cma)
>> }
>> EXPORT_SYMBOL_GPL(cma_get_name);
>>
>> +bool cma_folio_is_pinnable(struct folio *folio)
>> +{
>> +	/* Explicit HugeTLB CMA allocations own their bitmap ranges. */
>> +	return folio_test_hugetlb(folio) && folio_test_hugetlb_cma(folio);
>> +}
>> +
>> static unsigned long cma_bitmap_aligned_mask(const struct cma *cma,
>> 					     unsigned int align_order)
>> {
>> @@ -792,6 +799,11 @@ static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
>> 	int ret = -EBUSY;
>> 	struct page *page = NULL;
>>
>> + 	/* Each range lies within one zone; try other ranges if needed. */
>> +	if ((current->flags & PF_MEMALLOC_PIN) &&
>> + 	    is_zone_movable_page(pfn_to_page(cmr->base_pfn)))
>> +		return -EBUSY;
> 
> I don't know why we need this.

I had assumed that ZONE_MOVABLE pages must always remain unpinnable.
But Documentation/admin-guide/mm/memory-hotplug.rst explicitly states:

   - Memory blocks overlapping with CMA areas cannot be offlined, this 
applies to
     memory blocks present during boot only.

So pinning explicitly CMA-allocated HugeTLB folios does not introduce
an additional offlining restriction. The ZONE_MOVABLE check I added
in cma_range_alloc() is unnecessary, and I'll drop it.

Thanks,
Qi

