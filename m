Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502995;
	b=ceHD+waGn2uQkQjOQEZpzaBeolpkA8wccOrgr2jaaeg6x/yUvCxPphO9SJmMoBwTeBy4
	 w988NlR6+1/DK58oEfC7OxMj6tsN8IXFekBJAzYlpsK1wGywErO5d73IMpsBdhXcrFT/3
	 5Va+Q35rrRZksqT9Ac8/fWhmb7U2vVZwoN1CVW0HTU6ZUWP3niA4wMEusMt3R1nmvYHKy
	 pj7zEq1/b/zt5NEKDtr7sB+LH4zWBkhHVOdmlisR5FynsLhbcEcufW5F9XleoTD/InmOh
	 vMVK+vJ2IIqYp6itVcc7JmLIpm1wBHGzeqkU1YRNSq391AT6Zto2FRJqTvYnBVnCukw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502995;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=CYMqg4ekhN+H2mR8y56+Gn4spdCq36SruBSB9+jht0c=;
	b=NkwdjsHEQIWHC2jB58Ed17hv+UR2qKshYsM9JJY8WO68NXUWrc8vA9TP+k8HOJPz7AWl
	 rnrk7+qHHnLbUMUIXHXsEbxRq3Dw9xtXJkkMfzf2cStKvkctZEqXllzaYqjoGtbSGN7Sj
	 MmduCFPolt7pp7QUwyBCWmIrUsuPUyK5uceIqF0RSh4cxkY+OQI9re0AE94SJ34DuEzko
	 xZbZT4xru6iIQ46NJuOWzV58n/aiXWj0nyCHniatVYSd2YdEJfEwllkRh5VJxOLEC3LL3
	 UcfMjSrvk76ioQO79YkZmp5l8qsch75nvOOaKtHo0yV5zsKXw4hV24n6gr1OCpomlPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=foZdgH0v;
	arc=none smtp.remote-ip=91.218.175.178
Received: from mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0235F60A2609
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0235F60A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=foZdgH0v
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=IKmZlEGfS2yeIgifNi1WabbugRXmrQXpvhboXkIucAc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792502993; v=1; x=1793107793;
 b=foZdgH0vzJ1Ry6v+DDc52BOnhdPefzLWppgUV2qWM0BlMmNHPu4cjGGzHWW1fKkpK+sybq19
 KZ+QEzvQHp4KqjdWw0mz6IqMXKH6QYK+jd0bm6LtODNziAxzL8Dx+xHiehSwOPlU6JoYE/cCF+K
 bt2me+wteS6F8MU/rxKMWQI0=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7f2e75a512db9909;
	Tue, 20 Oct 2026 13:29:53 +0000
X-Mizu-Trace-ID: 7f2e75a512db9909
X-Migadu-Flow: FLOW_OUT
Message-ID: <f6bdf823-be42-4184-87d2-fc7c128f4786@linux.dev>
Date: Tue, 20 Oct 2026 21:29:40 +0800
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
Subject: Re: [PATCH v2] mm/ksm: keep soft-dirty and uffd-wp when merging a
 page
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: samarth.colleges@gmail.com, akpm@linux-foundation.org, xu.xin@linux.dev,
 chengming.zhou@linux.dev, peterx@redhat.com, kas@kernel.org,
 rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <efa6a28c-f0f9-4d1e-9cce-fec2c08e7d9f@kernel.org>
 <20261020055518.36087-1-lance.yang@linux.dev>
 <3da45e6d-2b46-4fff-9ff3-241f70d68296@kernel.org>
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <3da45e6d-2b46-4fff-9ff3-241f70d68296@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/10/20 21:03, David Hildenbrand (Arm) wrote:
> On 10/20/26 07:55, Lance Yang wrote:
>>
>> On Mon, Oct 19, 2026 at 03:24:11PM +0200, David Hildenbrand (Arm) wrote:
>>> On 10/19/26 03:09, Samarth Narang wrote:
>>>> replace_page() maps the KSM page with a PTE built from scratch, so the
>>>> soft-dirty and uffd bits of the PTE it replaces are lost. Due to this, a
>>>> write before the merge no longer shows as soft-dirty, the next write to
>>>> a uffd-wp page raises no write-protect fault, and because the page is
>>>> mapped with the VMA's normal permissions, on a uffd-rwp VMA the next
>>>> access raises no RWP fault.
>>>>
>>>> Copy the soft-dirty and uffd bits from the original PTE to the new PTE,
>>>> and restore PAGE_NONE for RWP VMAs, as try_to_map_unused_to_zeropage()
>>>> does.
>>>>
>>>> Fixes: 0f8975ec4db2 ("mm: soft-dirty bits for user memory changes tracking")
>>>> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
>>>> Fixes: 2d427bb01639 ("mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP")
>>>
>>> I would actually split that up into separate patches.
>>>
>>> Over-indicating soft-dirty (as raised by Sashiko) is in general not a problem.
>>
>> Right.
>>
>>> Losing WP bits is.
>>>
>>> UFFD, the gift that keeps on giving.
>>
>> Haha, yeah, I stared at the code a bit. Say we arm RWP on an existing KSM
>> mapping, then do MADV_UNMERGEABLE. We're just replacing the shared page
>> with a private copy. That shouldn't count as an access to the mapping ...
>> no?
>>
>> But the protnone check sends us to do_uffd_rwp() before the
>> FAULT_FLAG_UNSHARE handling. No FAULT_FLAG_ALLOW_RETRY here, so sync RWP
>> gives us VM_FAULT_SIGBUS. Then break_ksm() does this:
>>
>> static int break_ksm(struct vm_area_struct *vma, unsigned long addr,
>> 		unsigned long end, bool lock_vma)
>> {
>> 	vm_fault_t ret = 0;
>> ...
>> 	do {
>> ...
>> 		ret = handle_mm_fault(vma, addr,
>> 				      FAULT_FLAG_UNSHARE | FAULT_FLAG_REMOTE,
>> 				      NULL);
>> 	} while (!(ret & (VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | VM_FAULT_OOM)));
>> ...
>> 	return (ret & VM_FAULT_OOM) ? -ENOMEM : 0;
>> }
>>
>> So we report success with the page still merged. Async RWP does unshare
>> it, but only after clearing the uffd bit.
>>
>> I'd let FAULT_FLAG_UNSHARE skip do_uffd_rwp(). We'd still need to carry
>> PAGE_NONE over in wp_page_copy(), though. That PTE is rebuilt from
>> vma->vm_page_prot, so the uffd bit alone won't stop reads.
>>
>>> How to deal RWP properly is a good question (see Sashiko review). I feel like
>>> some more stuff might be missing there to handle this correctly.
>>
>> Tested, this is what I had in mind:
>>
>> ---8<---
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 976cd03954e3..d99f5ef1dd8c 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4119,8 +4119,11 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>>   		if (unlikely(unshare)) {
>>   			if (pte_soft_dirty(vmf->orig_pte))
>>   				entry = pte_mksoft_dirty(entry);
>> -			if (pte_uffd(vmf->orig_pte))
>> +			if (pte_uffd(vmf->orig_pte)) {
>>   				entry = pte_mkuffd(entry);
>> +				if (userfaultfd_rwp(vma))
>> +					entry = pte_modify(entry, PAGE_NONE);
>> +			}
>>   		} else {
>>   			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
>>   		}
>> @@ -6656,9 +6659,12 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>>   		 * VM_UFFD_RWP VMA, a protnone PTE without the uffd bit is
>>   		 * NUMA hinting and must still fall through to do_numa_page().
>>   		 */
>> -		if (userfaultfd_pte_rwp(vmf->vma, vmf->orig_pte))
>> -			return do_uffd_rwp(vmf);
>> -		return do_numa_page(vmf);
>> +		if (userfaultfd_pte_rwp(vmf->vma, vmf->orig_pte)) {
>> +			if (!(vmf->flags & FAULT_FLAG_UNSHARE))
>> +				return do_uffd_rwp(vmf);
>> +		} else {
>> +			return do_numa_page(vmf);
>> +		}
>>   	}
> 
> Looks like a reasonable direction (without looking into all the details).
> 
> I've been also wondering whether KSM should simply skip these uffd regions, they
> it never worked properly ... but I'm sure we'd run into issue with leftover uffd

+1. Did it ever actually work there :) Why not just skip them and
call it a day :D

> pte bits :(
> 

