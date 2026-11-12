Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794454078;
	b=ctudySPIo2kmpmSfsv73dRqiwN421SPxWnwx5By9j0tlpBsf7eYlmGWhK2RErwMvEzSZ
	 YRBKCzx1s0OrrQT5wPCV+35Jd1pfhwcH2d0Cdz4Nt6X8+QG7QNsREu7n+1hHlmvgBgfSF
	 eEwLusemK+f0cDnX1MiVNQSlGiAYAfrp1yWu4QLUd2HAn8OD+UK4sqcLtO59KirzAJrsM
	 DkrsKXSFHwyvXBAx1s0pH3wEtejDR12UB083dI61yyyqctCxjclwABVXV/ZZmIXSGe8ji
	 IsoBxeShYzHK6jlN14xpRGHykdSN907FMQn5xrttgKwHC+cEREbD9/6VcsO+PCdbFEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794454078;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=FJxtok8nywZ/TQgGJyWa/+E2CH+0K50OeaFCvC/H71M=;
	b=RdB/tY8rDbozUkrkpk318fA0aFdv5RZFqdP48RiguczZiPEHktcGiFCpU849iLrJhuMT
	 YzNxlm/1sELbOHhXUmB8wdwZb+jSXGKZJWvoh5tlVTjWoGAnnyOtYildd87+/x7kMDb7N
	 IOb1j2FUYFh8abqEZlaZsBJ7vQDGF1RQ33FVc9sDdsYLB1Vg/yO9SDPGvz7p+amqcVOmr
	 JDsl6I2BEEcZXQ0sAgQCCkQM+XLLVLp3rZx7M1cWu4hFfawMGE8WvUTYln1QoxzcaPc5k
	 xgj3kFD8O26+nnXOUWfm4I+LgNZ2Qt2pmUJS3cX9+wL5pBdQ1NYzMo59O3wcWZvkiXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LFZVCmgP;
	arc=none smtp.remote-ip=95.215.58.165
Received: from mta1.migadu.com (out-165.mta1.migadu.com [95.215.58.165])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDC8606A324
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FDC8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LFZVCmgP
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mcfYyT8ssdEa144YgXQss8K/JkNJiAW/50JOamvyaFE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794454076; v=1; x=1795058876;
 b=LFZVCmgPiTIEZJ1A5tKZkTFVNGFy6F8sQZ2z7v+0VqqrwOkK5MOLVGteCp7csaavOOeLXOx5
 K6UfAumPyZ11XL6I5aYTeBGMC71C1H4tuBPor6bSUp22nfLMw3qyguuCO94Wo7BFwnxfmZ8bw2t
 CXeuegxbcWb8tSb2xRQ7B7Tw=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d517d826f1cb946c;
	Thu, 12 Nov 2026 03:27:56 +0000
X-Mizu-Trace-ID: d517d826f1cb946c
X-Migadu-Flow: FLOW_OUT
Message-ID: <64a49d81-c836-49b2-890a-096f5ce5e318@linux.dev>
Date: Thu, 12 Nov 2026 11:27:42 +0800
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
Subject: Re: [PATCH v3 2/3] mm: gup: allow long-term pins of CMA-allocated
 HugeTLB folios
To: Frank van der Linden <fvdl@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, muchun.song@linux.dev,
 osalvador@suse.de, akpm@linux-foundation.org, azpijr@gmail.com,
 lance.yang@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 stable@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1794046188.git.zhengqi.arch@bytedance.com>
 <586d6c53ab7e4c64d6e89ad3cf0cf7e07dabbfaf.1794046188.git.zhengqi.arch@bytedance.com>
 <7abb3aa1-385a-422f-86bd-7aac9661c4d8@kernel.org>
 <423c9b28-ecf2-4fab-817d-2fb326690c73@linux.dev>
 <3a1a3bb5-0b01-4f20-aa0e-74a952544b8c@kernel.org>
 <5f68ffba-9f56-4e31-9e7c-9d110f552efc@bytedance.com>
 <CAPTztWb0XbjCxtihyp=Tx16Z_kjF+M8sa7YcUjvFv0WcS83MAg@mail.gmail.com>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <CAPTztWb0XbjCxtihyp=Tx16Z_kjF+M8sa7YcUjvFv0WcS83MAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/12/26 6:26 AM, Frank van der Linden wrote:
> On Wed, Nov 11, 2026 at 2:27 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>
>> Hi David,
>>
>> On 11/11/26 3:43 PM, David Hildenbrand (Arm) wrote:
>>> On 11/9/26 04:10, Qi Zheng wrote:
>>>>
>>>>
>>>> On 11/8/26 1:58 AM, David Hildenbrand (Arm) wrote:
>>>>> On 11/7/26 11:30, Qi Zheng wrote:
>>>>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>>>
>>>>>> Long-term pinning treats explicitly CMA-allocated HugeTLB folios as
>>>>>> unpinnable, causing unnecessary migration or pinning failures.
>>>>>>
>>>>>> These folios already own their CMA bitmap ranges, and memory blocks
>>>>>> overlapping CMA areas cannot be offlined. Allow HugeTLB folios with
>>>>>> HPG_cma to be pinned directly, including in ZONE_MOVABLE.
>>>>>>
>>>>>> Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Suggested-by: Muchun Song <muchun.song@linux.dev>
>>>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>>> Acked-by: Muchun Song <muchun.song@linux.dev>
>>>>>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>>>>>> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
>>>>>> ---
>>>>>>     include/linux/mm.h | 29 +----------------------------
>>>>>>     mm/gup.c           | 31 +++++++++++++++++++++++++++++++
>>>>>>     2 files changed, 32 insertions(+), 28 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>>> index 2d0b8a4c9974f..75dd40265d3f4 100644
>>>>>> --- a/include/linux/mm.h
>>>>>> +++ b/include/linux/mm.h
>>>>>> @@ -2975,35 +2975,8 @@ static inline bool is_zero_folio(const struct folio *folio)
>>>>>>             return is_zero_page(&folio->page);
>>>>>>     }
>>>>>>
>>>>>> -/* MIGRATE_CMA and ZONE_MOVABLE do not allow pin folios */
>>>>>>     #ifdef CONFIG_MIGRATION
>>>>>> -static inline bool folio_is_longterm_pinnable(struct folio *folio)
>>>>>> -{
>>>>>> -#ifdef CONFIG_CMA
>>>>>> -  int mt = folio_migratetype(folio);
>>>>>> -
>>>>>> -  if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
>>>>>> -          return false;
>>>>>> -#endif
>>>>>> -  /* The zero page can be "pinned" but gets special handling. */
>>>>>> -  if (is_zero_folio(folio))
>>>>>> -          return true;
>>>>>> -
>>>>>> -  /* Coherent device memory must always allow eviction. */
>>>>>> -  if (folio_is_device_coherent(folio))
>>>>>> -          return false;
>>>>>> -
>>>>>> -  /*
>>>>>> -   * Filesystems can only tolerate transient delays to truncate and
>>>>>> -   * hole-punch operations
>>>>>> -   */
>>>>>> -  if (folio_is_fsdax(folio))
>>>>>> -          return false;
>>>>>> -
>>>>>> -  /* Otherwise, non-movable zone folios can be pinned. */
>>>>>> -  return !folio_is_zone_movable(folio);
>>>>>> -
>>>>>> -}
>>>>>
>>>>> Moving code while adding new stuff to it, please don't.
>>>>>
>>>>> Move code first, then modify it.
>>>>>
>>>>> I don't want to play "find the difference between two pictures" on a Saturday
>>>>> evening.
>>>>
>>>
>>> You resent your series way too fast.
>>
>> Got it.
>>
>>>
>>> Now we have discussions in to threads, congratulations ;)
>>>
>>>> ;), got it.
>>>>
>>>> I moved the code to resolve a build dependency.
>>>>
>>>
>>> Why can't that be resolved differently? What is the dependency?
>>
>> The dependency is that the new check wants to use
>> `folio_test_hugetlb_cma()`, which is a HugeTLB-specific inline helper
>> from `include/linux/hugetlb.h`.
>>
>> `folio_is_longterm_pinnable()` currently lives in `include/linux/mm.h`,
>> while `include/linux/hugetlb.h` already includes `linux/mm.h`. So I
>> can't simply use `folio_test_hugetlb_cma()` from `mm.h`
>>
>>>
>>>>>
>>>>>> +bool folio_is_longterm_pinnable(struct folio *folio);
>>>>>>     #else
>>>>>>     static inline bool folio_is_longterm_pinnable(struct folio *folio)
>>>>>>     {
>>>>>> diff --git a/mm/gup.c b/mm/gup.c
>>>>>> index 2b405cce2ca5c..f41701c603500 100644
>>>>>> --- a/mm/gup.c
>>>>>> +++ b/mm/gup.c
>>>>>> @@ -2216,6 +2216,37 @@ struct page *get_dump_page(unsigned long addr, int *locked)
>>>>>>
>>>>>>     #ifdef CONFIG_MIGRATION
>>>>>>
>>>>>> +bool folio_is_longterm_pinnable(struct folio *folio)
>>>>>> +{
>>>>>> +#ifdef CONFIG_CMA
>>>>>> +  int mt = folio_migratetype(folio);
>>>>>> +
>>>>>> +  /* These HugeTLB folios own the CMA memory, so they can be long-term pinned. */
>>>>>> +  if (folio_test_hugetlb(folio) && folio_test_hugetlb_cma(folio))
>>>>>> +          return true;
>>>>> More hugetlb hackery ... don't like that, sorry.
>>>>
>>>> Agree.
>>>>
>>>>>
>>>>> I think this just goes down to a problem we discussed a while ago that is
>>>>> independent of hugetlb: we'd need some way to identify that the the page was
>>>>> actually allocated by the CMA owner, and it's not just some other movable
>>>>> allcoation that ended up there.
>>>>>
>>>>> For something generic non-hugetlb thing, can't we call into CMA to ask whether
>>>>> the current chunk is marked allocated?
>>>>
>>>> The existing bitmap is set before allocation completes, so the range
>>>> may still contain borrowed movable pages. A set bit alone cannot
>>>> establish ownership.
>>
>> The more accurate code path is as follows.
>>
>> Assuming the 2M buddy allocation is successful, page P is borrowed from
>> the 1G CMA area.
>>
>> Now, proceed to request a new 1G huge page:
>>
>> only_alloc_fresh_hugetlb_folio
>> --> alloc_gigantic_frozen_folio
>>       --> hugetlb_cma_alloc_frozen_folio
>>           --> cma_range_alloc
>>                   /* set bitmap!! */
>>               --> bitmap_set(cmr->bitmap, bitmap_no, bitmap_count);
>>
>>                   <time A>
>>
>>                   /* may fail */
>>                   alloc_contig_frozen_range
>>
>>           /* set HPG_cma!! */
>>           folio_set_hugetlb_cma(folio);
>>
>> At time A, for page P, a bitmap was set, but HPG_cma was not set.
>>
>> If a concurrent FOLL_LONGTERM pin uses the bitmap alone to determine
>> ownership, it could incorrectly allow P to remain pinned. If
>> alloc_contig_frozen_range() fails, cma_range_alloc() clears the bitmap
>> bits, while the long-term pin on P remains.
>>
>> HPG_cma is set only after explicit CMA allocation succeeds. It records
>> the folio's own CMA ownership, whereas a set bitmap bit can represent
>> another allocation's in-flight reservation. Therefore, the bitmap
>> alone cannot replace HPG_cma in this check.
>>
>>>>
>>>> A generic query may need separate ownership tracking, such as an
>>>> owned_bitmap recording successfully allocated pages. Its updates and
>>>> lookups would also need to handle concurrency with fast GUP.
>>>
>>> Or simply two bitmaps? "trying allocation - allocated"
>>
>> As a fix, perhaps this is a bit too complex? :(
>>
>> Alternatively, we could adjust the timing for setting the bitmap, though
>> this might introduce new concurrency issues.
>>
>> Thanks,
>> Qi
> 
> Yeah, ideally there would be a way to identify folios allocated
> through cma_alloc. But that would probably require.. dare I say.. a
> page flag. Trying to check bitmaps does seem too complex.

Agree.

> 
> And, since we've had a local change that does exactly the same thing
> for a few years (which I apparently forgot to send along with other
> hugetlb_cma changes), I can confirm that this looks good to me and
> works. So,
> 
> Reviewed-by: Frank van der Linden <fvdl@google.com>

Thanks for your review and confirmation!




