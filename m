Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232164F55D7;
	Wed, 14 Oct 2026 11:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975743; cv=none; b=kU9m0SvzgDTlGkuyrunE5x6Nq5kMdAo7bKVK9L11gu/FfMKJZkefPEY6f5NTeJIOW+7f6Wivu1FW4VAp0LpKsiTbnaCYpYUsECpCM2ZWo696bDMMajEnQPPxSR9EcGBVBe+SQpQBh+n6I4cJfuWCOvgRlUWVHlliI6eeSNvuSJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975743; c=relaxed/simple;
	bh=oVNV5iMCm9Xg6NFTetIT77HNSLPF87+/20UvMr4ytKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZ/eTS0cJQri1h1DcjPD+9rIPUjmwDSUFudYv3HkSdqYH8RIuESCTmrqxXGKv7F1oGBlSgDebbTAH5CR+Nw79WlDvFtMYTzzIY76qTwvhKkOVDKW/2v1M+ilSIM12jR9GL3+du/ICFrqBHh/nzo21DeWG22uuMKcLKwYzsbdHOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vvDFoElS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vvDFoElS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFC671595;
	Wed, 14 Oct 2026 04:02:14 -0700 (PDT)
Received: from [10.164.19.62] (unknown [10.164.19.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 414993F673;
	Wed, 14 Oct 2026 04:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791975738; bh=oVNV5iMCm9Xg6NFTetIT77HNSLPF87+/20UvMr4ytKk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vvDFoElSzHAL7njvysTrWnNvK1GtCywEfeK9mwdUkPdlWjR25Zq/BQyZmqDvwvbw0
	 oeBbCutseoX+rcvFkBPEzdhk+v6NZrmCyMCI0/P+IW3Q2JPebR+H9x8kouSJavsQt2
	 hjGpBZtDcC3NjE+ByOKTUqA0EcsIv1XDwSL+o5lw=
Message-ID: <dd2cc3df-f8be-4263-9c33-cbf0f3343dbf@arm.com>
Date: Wed, 14 Oct 2026 16:32:10 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: restrict transparent contpte mappings to valid
 PTEs
To: Lance Yang <lance.yang@linux.dev>, Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: catalin.marinas@arm.com, will@kernel.org, ryan.roberts@arm.com,
 baolin.wang@linux.alibaba.com, mark.rutland@arm.com,
 akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
 liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261013093600.54995-1-zhaogongyi@bytedance.com>
 <20261013153953.77575-1-lance.yang@linux.dev>
 <516828fb-558d-4a20-9532-51f50d6ba042@bytedance.com>
 <0bbbe312-47a4-4eeb-8299-1f20daf4e949@arm.com>
 <44aba42f-0355-4643-826f-0c7abec4499c@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <44aba42f-0355-4643-826f-0c7abec4499c@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 14/10/26 4:15 pm, Lance Yang wrote:
> 
> 
> On 2026/10/14 18:03, Dev Jain wrote:
>>
>>
>> On 14/10/26 12:01 pm, Zhao Gongyi wrote:
>>> On 10/13/26 11:39 PM, Lance Yang wrote:
>>>>>
>>>>> +    /*
>>>>> +     * Keep the producer-side invariant documented in pgtable.h true even
>>>>> +     * if a direct caller passes an invalid descriptor with PTE_CONT set.
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
>>>> rather add a VM_WARN_ON() to catch that. Silently clearing the bit would
>>>> hide a caller bug :)
>>>>
>>>
>>> Hi Lance,
>>>
>>> Thanks for taking a look.
>>>
>>> Yes, you are right. The public set_ptes() wrapper already strips PTE_CONT
>>> before calling contpte_set_ptes(), so the pte_mknoncont() in the invalid
>>> path is unnecessary for the current in-tree path.
>>>
>>> The issue I was trying to avoid is not that the incoming pte already has
>>> PTE_CONT set, but that contpte_set_ptes() rebuilds the pte from pfn/prot
>>> and then adds PTE_CONT again based on alignment. For an invalid descriptor,
>>> that transparent contiguous encoding should be skipped entirely.
>>>
>>> So your suggested shape makes sense to me. I will change this to return
>>> through __set_ptes() directly for invalid descriptors, and add a warning
>>> for any unexpected direct caller that passes an invalid PTE with PTE_CONT
>>> set, e.g.:
>>>
>>>     if (!mm_is_user(mm) || !pte_valid(pte)) {
>>>         VM_WARN_ON_ONCE(!pte_valid(pte) && pte_cont(pte));
>>
>> set_ptes does pte_mknoncont(), so the warning will *never* fire I think?
> 
> YES. Just a sanity check to catch a future direct caller passing
> a !pte_valid PTE with PTE_CONT set, rather than silently clearing
> the bit :)

Ah okay you said "future direct caller". I got confused since if the only
caller is set_ptes() then the warning is useless by construction.


> 
> Cheers, Lance
> 
>>
>>>         return __set_ptes(mm, addr, ptep, pte, nr);
>>>     }
>>>
>>> That keeps the fix focused on not creating new invalid contpte entries,
>>> while still catching a bad direct caller instead of silently sanitizing it.
>>>
>>> Thanks,
>>> Zhao
>>
> 

