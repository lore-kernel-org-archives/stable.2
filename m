Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794383044;
	b=sAvE1mxMJ0Kfjz12xE4A0iLg37SRTaGAeKBWTF3ZTGs/oeV93nEZvEeKs7lW0iJlBaS1
	 DEwwcuGc3aviBDGzbeRhBNyzyf9NpemsuS6rRmxfhiTlSK0LaTeJy7WsH6YgLdAXQi2fO
	 bRDrk9mSFNTB/OrvDsotb4gaCf7ykB1RTuu68MCe+LgKDMmcDfZAYgU2pKY5XreZDcuiy
	 CYopSonbglAch9KMADGGg15ieWZCtsfC1OSo2Y27NEYbI/O/QOJWQu+1VnKUsqLbx8mW+
	 No35IjdrDfpySKlzD1BPc2hlzBTSdR7rTrwfWjklFuK5exy6+d8jIt/5NnduosPGtUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794383044;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Z9RWwu7ZrdbjA/+NxwvyjbBT9j/m8TzxPE3PcvKEAL8=;
	b=vNeq62KC03DWgS6W94xF4tcGr9A5lRdWgKLNo/2+YLpEY0h7z0iLawUG4yVKx3Ff+atR
	 U9EiTrX/JGIV/S4Lhu2j85npAfs5rd9u+1wqGIVs9+UoHoG89AQNOFTXCZV+HCWfweaE0
	 OuL3WubQrwjV7yNVU14jxnf6JM5/hrgcwFZLCFTlCb7E02jHCPMZTbr4dP7h91IaMex9H
	 4+yfHtKcldnvSZtJFuHs4vJzyYDcQ+IPHQW9pkm25YmpbR12sHGQmRptdqqrs/EICwTm8
	 EjXvD6RQ/BG5f1g3/fE33xRO5BzStr49AtPZ4ZCYsYKUHRryygL7nv8Ycz3WNPx6NCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FIS3zgbw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6EF606A321;
	Wed, 11 Nov 2026 07:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FIS3zgbw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0311F00A06;
	Wed, 11 Nov 2026 07:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794383044;
	bh=Z9RWwu7ZrdbjA/+NxwvyjbBT9j/m8TzxPE3PcvKEAL8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FIS3zgbwrSyy0PKttgXR+kQJschgcbgwzK3PbLmjMG9H8zSaGctP/fvk43C6fFom6
	 i1LDLytYQIwfO2numnAedMu3hQxhleqtydsLVrDs5b0+jSFAcPn75n9YTxy2BIvXEC
	 mhuVFfzzqc5L4uXTtu9q9ybdqkR+4OeS5JMAmGdJ+brJmc756UdZyYhDhTKGrw6zBw
	 nubQLpn0zrlU12xsPNmddER70eW7j+XNiOfxz3BTt8Sw2fu5zW9nfJnPRw0mr0TMea
	 MrLnadxeUwsQ6T5Q3nzapZtRQiuJpAD0AWKSun0wdTkePVx9nRq0cEk4vfql+LBtzH
	 J2V1nfhYgnfiQ==
Message-ID: <3a1a3bb5-0b01-4f20-aa0e-74a952544b8c@kernel.org>
Date: Wed, 11 Nov 2026 08:43:58 +0100
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
To: Qi Zheng <qi.zheng@linux.dev>, muchun.song@linux.dev, osalvador@suse.de,
 akpm@linux-foundation.org, azpijr@gmail.com, lance.yang@linux.dev,
 Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
References: <cover.1794046188.git.zhengqi.arch@bytedance.com>
 <586d6c53ab7e4c64d6e89ad3cf0cf7e07dabbfaf.1794046188.git.zhengqi.arch@bytedance.com>
 <7abb3aa1-385a-422f-86bd-7aac9661c4d8@kernel.org>
 <423c9b28-ecf2-4fab-817d-2fb326690c73@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <423c9b28-ecf2-4fab-817d-2fb326690c73@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/9/26 04:10, Qi Zheng wrote:
> 
> 
> On 11/8/26 1:58 AM, David Hildenbrand (Arm) wrote:
>> On 11/7/26 11:30, Qi Zheng wrote:
>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>
>>> Long-term pinning treats explicitly CMA-allocated HugeTLB folios as
>>> unpinnable, causing unnecessary migration or pinning failures.
>>>
>>> These folios already own their CMA bitmap ranges, and memory blocks
>>> overlapping CMA areas cannot be offlined. Allow HugeTLB folios with
>>> HPG_cma to be pinned directly, including in ZONE_MOVABLE.
>>>
>>> Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
>>> Cc: stable@vger.kernel.org
>>> Suggested-by: Muchun Song <muchun.song@linux.dev>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> Acked-by: Muchun Song <muchun.song@linux.dev>
>>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>>> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
>>> ---
>>>   include/linux/mm.h | 29 +----------------------------
>>>   mm/gup.c           | 31 +++++++++++++++++++++++++++++++
>>>   2 files changed, 32 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index 2d0b8a4c9974f..75dd40265d3f4 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -2975,35 +2975,8 @@ static inline bool is_zero_folio(const struct folio *folio)
>>>   	return is_zero_page(&folio->page);
>>>   }
>>>   
>>> -/* MIGRATE_CMA and ZONE_MOVABLE do not allow pin folios */
>>>   #ifdef CONFIG_MIGRATION
>>> -static inline bool folio_is_longterm_pinnable(struct folio *folio)
>>> -{
>>> -#ifdef CONFIG_CMA
>>> -	int mt = folio_migratetype(folio);
>>> -
>>> -	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
>>> -		return false;
>>> -#endif
>>> -	/* The zero page can be "pinned" but gets special handling. */
>>> -	if (is_zero_folio(folio))
>>> -		return true;
>>> -
>>> -	/* Coherent device memory must always allow eviction. */
>>> -	if (folio_is_device_coherent(folio))
>>> -		return false;
>>> -
>>> -	/*
>>> -	 * Filesystems can only tolerate transient delays to truncate and
>>> -	 * hole-punch operations
>>> -	 */
>>> -	if (folio_is_fsdax(folio))
>>> -		return false;
>>> -
>>> -	/* Otherwise, non-movable zone folios can be pinned. */
>>> -	return !folio_is_zone_movable(folio);
>>> -
>>> -}
>>
>> Moving code while adding new stuff to it, please don't.
>>
>> Move code first, then modify it.
>>
>> I don't want to play "find the difference between two pictures" on a Saturday
>> evening.
> 

You resent your series way too fast.

Now we have discussions in to threads, congratulations ;)

> ;), got it.
> 
> I moved the code to resolve a build dependency.
> 

Why can't that be resolved differently? What is the dependency?

>>
>>> +bool folio_is_longterm_pinnable(struct folio *folio);
>>>   #else
>>>   static inline bool folio_is_longterm_pinnable(struct folio *folio)
>>>   {
>>> diff --git a/mm/gup.c b/mm/gup.c
>>> index 2b405cce2ca5c..f41701c603500 100644
>>> --- a/mm/gup.c
>>> +++ b/mm/gup.c
>>> @@ -2216,6 +2216,37 @@ struct page *get_dump_page(unsigned long addr, int *locked)
>>>   
>>>   #ifdef CONFIG_MIGRATION
>>>   
>>> +bool folio_is_longterm_pinnable(struct folio *folio)
>>> +{
>>> +#ifdef CONFIG_CMA
>>> +	int mt = folio_migratetype(folio);
>>> +
>>> +	/* These HugeTLB folios own the CMA memory, so they can be long-term pinned. */
>>> +	if (folio_test_hugetlb(folio) && folio_test_hugetlb_cma(folio))
>>> +		return true;
>> More hugetlb hackery ... don't like that, sorry.
> 
> Agree.
> 
>>
>> I think this just goes down to a problem we discussed a while ago that is
>> independent of hugetlb: we'd need some way to identify that the the page was
>> actually allocated by the CMA owner, and it's not just some other movable
>> allcoation that ended up there.
>>
>> For something generic non-hugetlb thing, can't we call into CMA to ask whether
>> the current chunk is marked allocated?
> 
> The existing bitmap is set before allocation completes, so the range
> may still contain borrowed movable pages. A set bit alone cannot
> establish ownership.
> 
> A generic query may need separate ownership tracking, such as an
> owned_bitmap recording successfully allocated pages. Its updates and
> lookups would also need to handle concurrency with fast GUP.

Or simply two bitmaps? "trying allocation - allocated"

-- 
Cheers,

David
