Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193821;
	b=Nup/xgnAU2MUuLoZILYsv7AGIB4GBCyROypkskVfnqHfmbEfbQuFanbZnb2jzjr7DiXt
	 JQGkObt1kzXe92aWare32FcskRrr0ULBtbps+jj6IGTReOfhDdPYHTchfsXD+m2uBlod+
	 WYjy7mB13GgftZqmfVi2FqaOvYSWpK1L8vPLpTyNQpJz4ELVPDWebbVWCVpJDVq2Q6SMD
	 4SoVXvC4uIvZ92AqcMvTSh41WP+OgjsRxnppdOGXAVcT2xc5qiiWu15QFUM7EVuJ/m5pj
	 l6xrlTiozMWEIxcRiwDjYda8RsuObh1uMgDNbzaEv4EU9QnLwcHnCF4ZCRz0eHuqYYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193821;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=R7YFoYH+pqizVWJtbykpYVkcry3ho5h+U0NhjdmQOV4=;
	b=1bbKhmfPfON6tFuKwxm4Ann9YXNiyV/DZAAEmd0+zAKBEwA+1LZeJb9RKAHcGm7Vmham
	 xepB+11UldIOawOhLBPPVyVaS/DQI9L2BB/u9mgQ/2NF2ZTQXMYshfhpyq3HG/FMmgigs
	 bpLmfAiw1arlYGuEi2v6UtSR7JpCCAeP/0t+uYjlIidood2aY4tz+/3KSM1/u2u30QWPi
	 74qol5u/LH06VhphN448AI0iRzhSCjCjXePPLzNVo1SHcVX+ActTffku0+6lyIRPt2njh
	 VyejkbclRKJ3o7x4UoFxfCyDmceHa5JBluwqMLNdUw3PVwQEX4vWOEZbrsiLVB40G9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gtbDVREB;
	arc=none smtp.remote-ip=91.218.175.153
Received: from mta0.migadu.com (out-153.mta0.migadu.com [91.218.175.153])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B458606A320
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 03:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B458606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gtbDVREB
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7Na7xjzcQd16juEXNoMu7pYk4KLFnTP5KHehCh6IFWE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794193813; v=1; x=1794798613;
 b=gtbDVREBKlXmZiiQn37nboEHI2/a0a20du9yKFge83pgGuSGnnJnWOdvyIUGVWhK9MPfmf8b
 RX9ADc8PDttBKuZ8wChz8b+rwNyNdarOiNrWfZR3x4yHDAAzQhnU5Xp0wtDMKweiSWKCeHnDzs5
 W45HOEGmg5bHLrY9e6j8bN9s=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1ae66134428fd04f;
	Mon, 09 Nov 2026 03:10:10 +0000
X-Mizu-Trace-ID: 1ae66134428fd04f
X-Migadu-Flow: FLOW_OUT
Message-ID: <423c9b28-ecf2-4fab-817d-2fb326690c73@linux.dev>
Date: Mon, 9 Nov 2026 11:10:02 +0800
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
To: "David Hildenbrand (Arm)" <david@kernel.org>, muchun.song@linux.dev,
 osalvador@suse.de, akpm@linux-foundation.org, azpijr@gmail.com,
 lance.yang@linux.dev, Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
References: <cover.1794046188.git.zhengqi.arch@bytedance.com>
 <586d6c53ab7e4c64d6e89ad3cf0cf7e07dabbfaf.1794046188.git.zhengqi.arch@bytedance.com>
 <7abb3aa1-385a-422f-86bd-7aac9661c4d8@kernel.org>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <7abb3aa1-385a-422f-86bd-7aac9661c4d8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/8/26 1:58 AM, David Hildenbrand (Arm) wrote:
> On 11/7/26 11:30, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> Long-term pinning treats explicitly CMA-allocated HugeTLB folios as
>> unpinnable, causing unnecessary migration or pinning failures.
>>
>> These folios already own their CMA bitmap ranges, and memory blocks
>> overlapping CMA areas cannot be offlined. Allow HugeTLB folios with
>> HPG_cma to be pinned directly, including in ZONE_MOVABLE.
>>
>> Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
>> Cc: stable@vger.kernel.org
>> Suggested-by: Muchun Song <muchun.song@linux.dev>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Acked-by: Muchun Song <muchun.song@linux.dev>
>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
>> ---
>>   include/linux/mm.h | 29 +----------------------------
>>   mm/gup.c           | 31 +++++++++++++++++++++++++++++++
>>   2 files changed, 32 insertions(+), 28 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 2d0b8a4c9974f..75dd40265d3f4 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -2975,35 +2975,8 @@ static inline bool is_zero_folio(const struct folio *folio)
>>   	return is_zero_page(&folio->page);
>>   }
>>   
>> -/* MIGRATE_CMA and ZONE_MOVABLE do not allow pin folios */
>>   #ifdef CONFIG_MIGRATION
>> -static inline bool folio_is_longterm_pinnable(struct folio *folio)
>> -{
>> -#ifdef CONFIG_CMA
>> -	int mt = folio_migratetype(folio);
>> -
>> -	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
>> -		return false;
>> -#endif
>> -	/* The zero page can be "pinned" but gets special handling. */
>> -	if (is_zero_folio(folio))
>> -		return true;
>> -
>> -	/* Coherent device memory must always allow eviction. */
>> -	if (folio_is_device_coherent(folio))
>> -		return false;
>> -
>> -	/*
>> -	 * Filesystems can only tolerate transient delays to truncate and
>> -	 * hole-punch operations
>> -	 */
>> -	if (folio_is_fsdax(folio))
>> -		return false;
>> -
>> -	/* Otherwise, non-movable zone folios can be pinned. */
>> -	return !folio_is_zone_movable(folio);
>> -
>> -}
> 
> Moving code while adding new stuff to it, please don't.
> 
> Move code first, then modify it.
> 
> I don't want to play "find the difference between two pictures" on a Saturday
> evening.

;), got it.

I moved the code to resolve a build dependency.

> 
>> +bool folio_is_longterm_pinnable(struct folio *folio);
>>   #else
>>   static inline bool folio_is_longterm_pinnable(struct folio *folio)
>>   {
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 2b405cce2ca5c..f41701c603500 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -2216,6 +2216,37 @@ struct page *get_dump_page(unsigned long addr, int *locked)
>>   
>>   #ifdef CONFIG_MIGRATION
>>   
>> +bool folio_is_longterm_pinnable(struct folio *folio)
>> +{
>> +#ifdef CONFIG_CMA
>> +	int mt = folio_migratetype(folio);
>> +
>> +	/* These HugeTLB folios own the CMA memory, so they can be long-term pinned. */
>> +	if (folio_test_hugetlb(folio) && folio_test_hugetlb_cma(folio))
>> +		return true;
> More hugetlb hackery ... don't like that, sorry.

Agree.

> 
> I think this just goes down to a problem we discussed a while ago that is
> independent of hugetlb: we'd need some way to identify that the the page was
> actually allocated by the CMA owner, and it's not just some other movable
> allcoation that ended up there.
> 
> For something generic non-hugetlb thing, can't we call into CMA to ask whether
> the current chunk is marked allocated?

The existing bitmap is set before allocation completes, so the range
may still contain borrowed movable pages. A set bit alone cannot
establish ownership.

A generic query may need separate ownership tracking, such as an
owned_bitmap recording successfully allocated pages. Its updates and
lookups would also need to handle concurrency with fast GUP.

> 
> If that's too hard, we could add a temporary hugetlb hack.

For this fix, I'd prefer to keep the current check.

> 
> But we all hate hugetlb hacks. :)

+1.

> 

