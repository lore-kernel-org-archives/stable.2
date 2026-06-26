Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EB93E1D05;
	Fri, 26 Jun 2026 13:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481903; cv=none; b=kDWfYMp/bkJpdAhAdMBGgLIYRZkHoYVgIJjsSOVPpU2wOBW/JjS/+Vf5Uab/eAD6Hxgvfd6KI1IDrK5PSLeOBZX2bE9/HZwxFCMy0XgQEDg42AAwS5+jVjTTsvyV/lYG78t6S7raGdRRqSV783wa6DLm4yR0RwYysTsZwj3gWVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481903; c=relaxed/simple;
	bh=0+hdvQLnAun10bg+4oAwwrNyo9ZCNRCyl1/B6sdkJeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmLIYlNpYF3PGJtA2Y9KpuYhoW6ksKpNpexxDBZPCMsWdNRocayAvnUchMnMdiBh5sVo35FrsuA2lvN93oQvVbtjQ1Fhu9l2MKl1GMiWdEMm7JX0D5RRHd6r/jsvKHKfA04/xbuR6aSGFT/9K4HTB1QTDzmjl8QDw/s7IBhsI0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HK/Zrlu0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HK/Zrlu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597461F00A3A;
	Fri, 26 Jun 2026 13:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782481902;
	bh=A4JY5U7hgmMwmoYLuJcVV6eGF+fJGev5ufEFJmKZ3vg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HK/Zrlu0y/MbzFC1mzYqzA8l0ppdQsn5y3xuhlmR48qIl47dGPgiXM21LroMDBlXU
	 EeoHu3qy7U2KKHnCmAvF0Cvg225munY7Z3aBSweQZCsu1q7cQfofJa2udVveiA4YRi
	 uDAMX6CBowecIbvyBe58c4uVh7HINM4IdhRZvt/tws5BnVHLIYdwryO71J2TYD08hQ
	 f5V+srAVFQI2gIclGKGritudWDZbcSbAuNXBDJANT+yur8OWEiUUzgaq9sUAm2vVEt
	 zY9na4k8Pt1xx/Yvw+QBWzG+8wXh4hcg+CxLu58N2Q02wRH3P2e+h+4u8pyHFrT1sm
	 6/C10xF457MUw==
Message-ID: <6feb9042-f9c0-4762-bd71-068d6ef5307c@kernel.org>
Date: Fri, 26 Jun 2026 15:51:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch mm-hotfixes v4] mm/page_vma_mapped: fix device-private PMD
 handling
To: Lance Yang <lance.yang@linux.dev>
Cc: richard.weiyang@gmail.com, akpm@linux-foundation.org, ljs@kernel.org,
 riel@surriel.com, liam@infradead.org, vbabka@kernel.org, harry@kernel.org,
 jannh@google.com, ziy@nvidia.com, sj@kernel.org, balbirs@nvidia.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <d060cadd-34f8-42da-b7f7-c8d295050436@kernel.org>
 <20260626132728.77436-1-lance.yang@linux.dev>
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
In-Reply-To: <20260626132728.77436-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/26 15:27, Lance Yang wrote:
> 
> On Fri, Jun 26, 2026 at 12:07:56PM +0200, David Hildenbrand (Arm) wrote:
>> On 6/24/26 08:53, Wei Yang wrote:
>>> Commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration support
>>> device-private entries") introduced the concept of device-private
>>> PMD entries, but did not correctly update the rmap walk code to
>>> account for them.
>>>
>>> As a result, when page_vma_mapped_walk() encounters device-private
>>> PMD entries, it takes no action other than to acquire the PMD lock
>>> and exit.
>>>
>>> However this is highly problematic for two reasons - firstly,
>>> device private entries possess a PFN so check_pmd() needs to be
>>> called to ensure an overlapping PFN range.
>>>
>>> Secondly, and more importantly, if PVMW_MIGRATION is set the
>>> caller assumes the returned entry is a migration entry, resulting
>>> in memory corruption when the caller tries to interpret the device
>>> private entry as such.
>>>
>>> In addition, commit 146287290023 ("mm/huge_memory: implement
>>> device-private THP splitting") allowed device private PMDs to be
>>> split like THP mappings, but again did not update this code path.
>>>
>>> As a result, we might race a PMD split prior to acquiring the PMD
>>> lock.
>>>
>>> This patch addresses all of these issues by invoking check_pmd(),
>>> ensuring PMVW_MIGRATION is not set and checks whether a split raced
>>> us we do for PMD THP and migration entries.
>>>
>>> Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>> Suggested-by: David Hildenbrand <david@kernel.org>
>>> Cc: David Hildenbrand <david@kernel.org>
>>> Cc: Balbir Singh <balbirs@nvidia.com>
>>> Cc: SeongJae Park <sj@kernel.org>
>>> Cc: Zi Yan <ziy@nvidia.com>
>>> Cc: Lorenzo Stoakes <ljs@kernel.org>
>>> Cc: Lance Yang <lance.yang@linux.dev>
>>>
>>> ---
>>> v4:
>>>   * refine subject and commit log based on Lorenzo's suggestion
>>>   * put pmd device-private entry handling in its own if branch,
>>>     suggested by Lorenzo
>>>
>>> v3:
>>>   * remove cleanup part, only fix the issue for device-private entry
>>>   * refine user effect description based on Lorenzo's suggestion
>>>
>>> v2: https://lore.kernel.org/all/20260616063436.20455-1-richard.weiyang@gmail.com/T/#u
>>>   * specify the possible error case of current code and user visible effect
>>>   * besides fix, cleanup the pmd entry handling based on David's suggestion
>>>
>>> v1: https://lore.kernel.org/linux-mm/20260508013728.21285-1-richard.weiyang@gmail.com/
>>> ---
>>>  mm/page_vma_mapped.c | 20 +++++++++++++++-----
>>>  1 file changed, 15 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>>> index 2ccbabfb2cc1..17dff8aab9f9 100644
>>> --- a/mm/page_vma_mapped.c
>>> +++ b/mm/page_vma_mapped.c
>>> @@ -269,14 +269,24 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>>  			/* THP pmd was split under us: handle on pte level */
>>>  			spin_unlock(pvmw->ptl);
>>>  			pvmw->ptl = NULL;
>>> -		} else if (!pmd_present(pmde)) {
>>> -			const softleaf_t entry = softleaf_from_pmd(pmde);
>>> +		} else if (pmd_is_device_private_entry(pmde)) {
>>> +			softleaf_t entry;
>>> +
>>> +			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>> +			pmde = *pvmw->pmd;
>>> +			entry = softleaf_from_pmd(pmde);
>>>  
>>> -			if (softleaf_is_device_private(entry)) {
>>> -				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>> +			if (likely(softleaf_is_device_private(entry))) {
>>> +				if (pvmw->flags & PVMW_MIGRATION)
>>> +					return not_found(pvmw);
>>> +				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>>> +					return not_found(pvmw);
>>>  				return true;
>>>  			}
>>> -
>>> +			/* device-private pmd was split under us: handle on pte level */
>>> +			spin_unlock(pvmw->ptl);
>>> +			pvmw->ptl = NULL;
>>> +		} else if (!pmd_present(pmde)) {
>>>  			if ((pvmw->flags & PVMW_SYNC) &&
>>>  			    thp_vma_suitable_order(vma, pvmw->address,
>>>  						   PMD_ORDER) &&
>>
>> This is extremely hard to review given the existing crap handling here. I'm
>> really sorry, but it makes my head hurt (I'm not kidding :) ).
>>
>> It's completely unclear why we only have to check for a subset of the cases
>> after taking the lock.
>>
>> Could we simply extend the existing migration pmd handling and leave the
>> !pmd_present() case for pmd_none()?
>>
>> That leaves no question to "which transitions are actually allowed", including
>> "could we accidentally assume something is a page table when really it isn't".
>>
>>
>> So what about something like the following?
>>
>> The "thp_migration_supported()" is not required when checking for
>> pmd_is_migration_entry(), as that defaults to "false" when not compiled in.
>>
>> Untested:
>>
>>
>> >From 048ecd33673ec649e168fbbb97749a7c0e344fcd Mon Sep 17 00:00:00 2001
>> From: "David Hildenbrand (Arm)" <david@kernel.org>
>> Date: Fri, 26 Jun 2026 12:03:40 +0200
>> Subject: [PATCH] tmp
>>
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>> mm/page_vma_mapped.c | 29 +++++++++++++++++------------
>> 1 file changed, 17 insertions(+), 12 deletions(-)
>>
>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> index 2ccbabfb2cc17..ed2a23a90e8dd 100644
>> --- a/mm/page_vma_mapped.c
>> +++ b/mm/page_vma_mapped.c
>> @@ -243,21 +243,31 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>> 		 */
>> 		pmde = pmdp_get_lockless(pvmw->pmd);
>>
>> -		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
>> +		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
>> +		    pmd_is_device_private_entry(pmde)) {
>> 			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>> 			pmde = *pvmw->pmd;
>> -			if (!pmd_present(pmde)) {
>> +			if (pmd_is_migration_entry(pmde)) {
>> 				softleaf_t entry;
>>
>> -				if (!thp_migration_supported() ||
>> -				    !(pvmw->flags & PVMW_MIGRATION))
>> +				if (!(pvmw->flags & PVMW_MIGRATION))
>> 					return not_found(pvmw);
>> 				entry = softleaf_from_pmd(pmde);
>> +				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>> +					return not_found(pvmw);
>> +				return true;
>> +			} else if (pmd_is_device_private_entry(pmde)) {
>> +				softleaf_t entry;
>>
>> -				if (!softleaf_is_migration(entry) ||
>> -				    !check_pmd(softleaf_to_pfn(entry), pvmw))
>> +				if (pvmw->flags & PVMW_MIGRATION)
>> +					return not_found(pvmw);
>> +				entry = softleaf_from_pmd(pmde);
>> +				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>> 					return not_found(pvmw);
>> 				return true;
>> +			} else if (!pmd_present(pmde) ){
>> +				return not_found(pvmw);
>> 			}
>> 			if (likely(pmd_trans_huge(pmde))) {
>> 				if (pvmw->flags & PVMW_MIGRATION)
>> @@ -270,12 +280,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>> 			spin_unlock(pvmw->ptl);
>> 			pvmw->ptl = NULL;
>> 		} else if (!pmd_present(pmde)) {
>> -			const softleaf_t entry = softleaf_from_pmd(pmde);
>> -
>> -			if (softleaf_is_device_private(entry)) {
>> -				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>> -				return true;
>> -			}
>>
>> 			if ((pvmw->flags & PVMW_SYNC) &&
>> 			    thp_vma_suitable_order(vma, pvmw->address,
>> -- 
> 
> Might be good with this on top:
> 
> ---8<---
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index cfa1230c87bb..8b7c062bd81d 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -281,7 +281,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  					return not_found(pvmw);
>  				return true;
>  			}
> -			/* THP pmd was split under us: handle on pte level */
> +			/* THP/device-private pmd was split under us: handle on pte level */
>  			spin_unlock(pvmw->ptl);
>  			pvmw->ptl = NULL;
>  		} else if (!pmd_present(pmde)) {
> --
> 
> Looks good to me as well, thanks!

Makes sense, thanks!


-- 
Cheers,

David
