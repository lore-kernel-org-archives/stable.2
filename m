Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F9C48BD5B;
	Mon,  7 Sep 2026 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788783820; cv=none; b=enjflhg1TVGRBk8Fj58gLEsCdu/Ps+yDJU6u3W/t6Gdt3/1FWnWmvNooYzdekiGOXJo83+MiXDpInbDI/F2NdbwStXxt6Q+WOY5e9/kVPzR/7U/gIFhni3E+rRaZz89Mq5MH8XXRm8sJ6zAW0EQBRDZZrHcQHdEq1NNRovchiDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788783820; c=relaxed/simple;
	bh=CN85r1Si1c2if0aRtnE6q+6I4jm+i11TMr6tC0E4jRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSSHtkwKL1XI4tyZbw9tERpttAN8ItvcPfZ7rbxSBA1nZVH0+5rz6BBg+POITmkEJxFBrfj1UJ2hEtkAQsnnfEgk18FGLayNsH+0Qh3jLPfkomwc5wM+THQ7Xyij10XMDfMvYyKkQBRGD1gX2rk0vxol0sPkfa8gnn14k0bfOAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTWtYKU2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTWtYKU2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D611F00A3A;
	Mon,  7 Sep 2026 12:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788783819;
	bh=DKWwKFC4qZfk9FuvRkvf9yrxae6yPLmuMCybVojYj7w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QTWtYKU2TyoxPXjcHz+SiSddeSqqdvSFOswAYcm578/7B/fTaz0fQyG5Icg3+VHLm
	 v6Dq4OMR7o5VtmB4eXuQDSNPvgtsNPC++8zGFQlNPs1rWtlwyJuFbPXYmdfDhq8DGt
	 8tU65ngkv7fDdyLxAha7PE8Okts73aKvC88MxdbnLJ/l1E1xohN6E3i8Dsy18loMEx
	 hNojwg8rtowHlQGSIrFMObNhvk7T7n43KE+4tcMLPRXKdv3iemHiUrwcUczRjQippe
	 L77nQ0Oovfubn2l3n1a2/Fb7FOwPkIV+0umIYUTyLvsVJjCqeF0MZIQiRuy7uCOY9l
	 0P4eTZM0rGbjg==
Message-ID: <5ae7a11c-1db4-44cd-bf67-a98cfd5ca08b@kernel.org>
Date: Mon, 7 Sep 2026 14:23:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/migrate_device: avoid out-of-bounds writes for
 compound folios
To: Matthew Brost <matthew.brost@intel.com>
Cc: Hui Su <sh_def@163.com>, akpm@linux-foundation.org, balbirs@nvidia.com,
 ziy@nvidia.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260817120758.669807-3-sh_def@163.com>
 <4ead5df7-f000-4087-83e4-13aae036e0b7@kernel.org>
 <apESOAPVzggWmbcJ@gsse-cloud1.jf.intel.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <apESOAPVzggWmbcJ@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/26 06:44, Matthew Brost wrote:
> On Thu, Aug 27, 2026 at 05:14:40PM +0200, David Hildenbrand (Arm) wrote:
>> On 8/17/26 14:08, Hui Su wrote:
>>> migrate_device_range() and migrate_device_pfns() clear the entries
>>> following a compound folio so that the PFN arrays retain their
>>> page-granular representation.
>>>
>>> If a compound folio extends beyond the end of the caller-provided range,
>>> the loops clear all following folio entries without limiting them to the
>>> number of slots remaining in the npages-sized array, causing an
>>> out-of-bounds write.
>>>
>>> Do not proceed with a compound folio if its page-granular representation
>>> does not fit entirely in the remaining PFN array. If this happens, drop
>>> any reference and lock acquired for the folio, clear the remaining
>>> entries, and stop collecting.
>>>
>>> Observed with a KASAN x86 QEMU kernel using the HMM
>>> migrate_anon_huge_zero selftest. Closing /dev/hmm_dmirror0 after
>>> migrating an anonymous huge page to device memory exercises:
>>>
>>>   dmirror_fops_release()
>>>     -> dmirror_device_evict_chunk()
>>>       -> migrate_device_range()
>>>
>>> Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Hui Su <sh_def@163.com>
>>> ---
>>> Changes in v2:
>>> - Do not partially represent a compound folio when it does not fit in
>>>   the remaining PFN array.
>>> - Drop any reference and lock acquired for that folio, clear the
>>>   remaining entries, and stop collecting, as suggested by Balbir Singh.
>>>
>>> v1: https://lore.kernel.org/lkml/20260817074350.442493-2-sh_def@163.com/
>>>
>>>  mm/migrate_device.c | 18 ++++++++++++++++++
>>>  1 file changed, 18 insertions(+)
>>>
>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>> index 908d2d4ec43a..69b8d0660bab 100644
>>> --- a/mm/migrate_device.c
>>> +++ b/mm/migrate_device.c
>>> @@ -1400,6 +1400,15 @@ int migrate_device_range(unsigned long *src_pfns, unsigned long start,
>>>  
>>>  		src_pfns[i] = migrate_device_pfn_lock(pfn);
>>>  		nr = folio_nr_pages(folio);
>>> +		if (nr > npages - i) {
>>> +			if (src_pfns[i] & MIGRATE_PFN_MIGRATE) {
>>> +				folio_unlock(folio);
>>> +				folio_put(folio);
>>> +			}
>>> +			memset(&src_pfns[i], 0,
>>> +			       (npages - i) * sizeof(*src_pfns));
>>> +			break;
>>> +		}
>>>  		if (nr > 1) {
>>>  			src_pfns[i] |= MIGRATE_PFN_COMPOUND;
>>>  			for (j = 1; j < nr; j++)
>>> @@ -1434,6 +1443,15 @@ int migrate_device_pfns(unsigned long *src_pfns, unsigned long npages)
>>>  
>>>  		src_pfns[i] = migrate_device_pfn_lock(src_pfns[i]);
>>>  		nr = folio_nr_pages(folio);
>>> +		if (nr > npages - i) {
>>> +			if (src_pfns[i] & MIGRATE_PFN_MIGRATE) {
>>> +				folio_unlock(folio);
>>> +				folio_put(folio);
>>> +			}
>>> +			memset(&src_pfns[i], 0,
>>> +			       (npages - i) * sizeof(*src_pfns));
>>> +			break;
>>> +		}
>>>  		if (nr > 1) {
>>>  			src_pfns[i] |= MIGRATE_PFN_COMPOUND;
>>>  			for (j = 1; j < nr; j++)
>>
>> The code duplication here makes me angry. :) And using a memset on one branch but
>> not on the other is weird.
>>
>> But is this the right fix or rather what
>>
>> 	https://lore.kernel.org/r/20260805231041.3791771-3-matthew.brost@intel.com 
>>
> 
> I'm not sure my patch is right now that I think about, or if this patch
> is right, or your suggestion either :).
> 
>> tried? That fix would also need a cleanup but seems code-wise simpler. A cleanup could look like:
>>
>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>> index 762c5cee8fecc..480bf59bc2425 100644
>> --- a/mm/migrate_device.c
>> +++ b/mm/migrate_device.c
>> @@ -1419,10 +1419,9 @@ int migrate_device_range(unsigned long *src_pfns, unsigned long start,
>>         for (pfn = start, i = 0; i < npages; pfn++, i++) {
>>                 struct page *page = pfn_to_page(pfn);
>>                 struct folio *folio = page_folio(page);
>> -               unsigned int nr = 1;
>> +               unsigned int nr = min(folio_nr_pages(folio), npages - i);
>>  
>>                 src_pfns[i] = migrate_device_pfn_lock(pfn);
>> -               nr = folio_nr_pages(folio);
>>                 if (nr > 1) {
>>                         src_pfns[i] |= MIGRATE_PFN_COMPOUND;
>>                         for (j = 1; j < nr; j++)
>> @@ -1453,10 +1452,9 @@ int migrate_device_pfns(unsigned long *src_pfns, unsigned long npages)
>>         for (i = 0; i < npages; i++) {
>>                 struct page *page = pfn_to_page(src_pfns[i]);
>>                 struct folio *folio = page_folio(page);
>> -               unsigned int nr = 1;
>> +               unsigned int nr = min(folio_nr_pages(folio), npages - i);
> 
> I think the semantics of both these function should be that if a user
> passes in a PFN array and one of the PFNs exceeds the `npages` limit,
> that is a misuse of this function and we should unwind and return an
> error. The caller is providing the PFNs and should therefore know the
> backing page alignment, so `npages` should always end exactly on a page
> boundary. The sole caller of migrate_device_pfns function is
> `drm_gpusvm/pagemap`, which certainly adheres to this requirement.
> 
> The two callers of migrate_device_range, also seemly adheres to this
> requirement.

That's what I was thinking: because how should we partially migrate folios?
Doesn't make sense :)

If this cannot be triggered today, neither Fixes: nor CC: stable is appropriate.

Agreed that we should just warn.

-- 
Cheers,

David
