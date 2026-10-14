Received: from mta0.migadu.com (out-105.mta0.migadu.com [91.218.175.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B9323D7E3
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969870; cv=none; b=YWpg/W4We6RY0g3gmxUxbwjDZxfGPobCC97xHN+nL8WASyut7ys6DCl4o+kb59nSBsxZiKX3dPytHqeYlCbAbltxUz1OmdZo60ewjbs/rhJ6tP26as/zar9EDfnu0Ajgi2zRSTR0FqijLFjc8d9s6FXUiHw2aQ0R/XGX0UckN4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969870; c=relaxed/simple;
	bh=9Rp6gok1+Kio/TSq1E9OFvpUWzUtlcEW1k6DFeMPFSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4Ah/r93MWUaylQeCFQ1SchbJ5nnvPLj0kxlKmd2WnLGUCJF2tmXq8Z5CzU3JuLIHhDoFd/v9+MQi9y0q7UwQczMMDliRDnhq7/w/qV9gt8XLDEeIFAXku/TGlK5Bi3ztXmQeEMYDag+ehN7lDuRRLWeN1fCfzOr4xtW+swTH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JAVBCnpl; arc=none smtp.client-ip=91.218.175.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JAVBCnpl"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9Rp6gok1+Kio/TSq1E9OFvpUWzUtlcEW1k6DFeMPFSc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791969865; v=1; x=1792574665;
 b=JAVBCnplvCbeKZl/JMDYbx2XfdKASjfrgzyZcBQgCeAwhRclpCVnMlD5EI5AfTK0D+TU4Ege
 oPnzfO5/QqZcOrOhaDCXAsNCAKisNa83gtXcpc4jdRIyhZKN8RLpQ0JY+mXMRxtBeNbd4q5bvJa
 MoCNL1khmzGusLotplHPv1RE=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f4836833ee7be581;
	Wed, 14 Oct 2026 09:24:25 +0000
X-Mizu-Trace-ID: f4836833ee7be581
X-Migadu-Flow: FLOW_OUT
Message-ID: <cb63eec0-4c39-49cb-89c7-15639f51a710@linux.dev>
Date: Wed, 14 Oct 2026 17:24:15 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: restrict transparent contpte mappings to valid
 PTEs
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: catalin.marinas@arm.com, will@kernel.org, ryan.roberts@arm.com,
 dev.jain@arm.com, mark.rutland@arm.com, akpm@linux-foundation.org,
 david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261013093600.54995-1-zhaogongyi@bytedance.com>
 <20261013153953.77575-1-lance.yang@linux.dev>
 <516828fb-558d-4a20-9532-51f50d6ba042@bytedance.com>
 <f111bec5-6148-4649-8805-79a250f6e736@linux.dev>
 <a6feb3f1-c08d-4d54-a38b-55fafcfec7b8@linux.alibaba.com>
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <a6feb3f1-c08d-4d54-a38b-55fafcfec7b8@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/10/14 16:38, Baolin Wang wrote:
> 
> 
> On 10/14/26 2:46 PM, Lance Yang wrote:
>>
>>
>> On 2026/10/14 14:31, Zhao Gongyi wrote:
>>> On 10/13/26 11:39 PM, Lance Yang wrote:
>>>>>
>>>>> +    /*
>>>>> +     * Keep the producer-side invariant documented in pgtable.h 
>>>>> true even
>>>>> +     * if a direct caller passes an invalid descriptor with 
>>>>> PTE_CONT set.
>>>>> +     */
>>>>> +    if (!pte_valid(pte))
>>>>> +        return __set_ptes(mm, addr, ptep, pte_mknoncont(pte), nr);
>>>>
>>>> set_ptes() is the only in-tree caller, and it already clears PTE_CONT
>>>> before we get here ... no? Why not fold !pte_valid(pte) into the
>>>> !mm_is_user(mm) check below and return __set_ptes() directly?
>>>>
>>>>     if (!mm_is_user(mm) || !pte_valid(pte))
>>>>         return __set_ptes(mm, addr, ptep, pte, nr);
>>>>
>>>> If a direct caller does pass a !pte_valid PTE with PTE_CONT set, I'd
>>>> rather add a VM_WARN_ON() to catch that. Silently clearing the bit 
>>>> would
>>>> hide a caller bug :)
>>>>
>>>
>>> Hi Lance,
>>>
>>> Thanks for taking a look.
>>
>> Cheers!
>>
>>> Yes, you are right. The public set_ptes() wrapper already strips 
>>> PTE_CONT
>>> before calling contpte_set_ptes(), so the pte_mknoncont() in the invalid
>>> path is unnecessary for the current in-tree path.
>>>
>>> The issue I was trying to avoid is not that the incoming pte already has
>>> PTE_CONT set, but that contpte_set_ptes() rebuilds the pte from pfn/prot
>>> and then adds PTE_CONT again based on alignment. For an invalid 
>>> descriptor,
>>> that transparent contiguous encoding should be skipped entirely.
>>>
>>> So your suggested shape makes sense to me. I will change this to return
>>> through __set_ptes() directly for invalid descriptors, and add a warning
>>> for any unexpected direct caller that passes an invalid PTE with 
>>> PTE_CONT
>>> set, e.g.:
>>>
>>>     if (!mm_is_user(mm) || !pte_valid(pte)) {
>>>         VM_WARN_ON_ONCE(!pte_valid(pte) && pte_cont(pte));
> 
> mprotect() can trigger the warning here when setting PAGE_NONE for a 
> batch of PTEs?

Nope. set_ptes() clears PTE_CONT before calling contpte_set_ptes().
PAGE_NONE makes !pte_valid(pte) true, but pte_cont(pte) is false,
so the warning won't fire :)

>>>         return __set_ptes(mm, addr, ptep, pte, nr);
> 
> I am trying to convince myself that the 'nr' passed in is always 
> CONT_PTE_SIZE aligned, but it seems OK.

Still nope :)

IIRC, any partially covered contpte block should already be unfolded
by the time we get here ...

We're just installing PTEs without PTE_CONT into cleared entries,
so nr doesn't need to be aligned to CONT_PTES.

Cheers, Lance
