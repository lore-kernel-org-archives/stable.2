Received: from mta0.migadu.com (out-76.mta0.migadu.com [91.218.175.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636DD432E79
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791974739; cv=none; b=hMRhQei/rcgLf0rpLpZRWNuUCl521VpttIygMaP5b1cxQduI4gIp17c094/ZiuBKM4Ccl6UBeS8oT/Afgl2fBnef7gm2Yi3HBQrPCdFdjrZb7ljTRrEQJb1wt7Mlxrkg/9vF2LwCQUSSfX/gBcYiNVt1qrZxwvOjmNskwLs3aGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791974739; c=relaxed/simple;
	bh=4j71whs7pU+NnCMQt6l/U/Btk6pFemJHjPQ5tC3+JVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iEEuIR9uojzyEPweWfaagn8+X36ICTINSP/NT5gWBRIatjTzd5tGlBr0+el6KjSUY9vwnzGp8KCVf/bOVv6UCSeF7AU/eho3mCUovWaMKVobwe0SgK3I7hj9+l+XaAIiRpNoDvuqenTYNSII6Q5iY04G43o2273PHWP79stCOiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FYzHg0Xn; arc=none smtp.client-ip=91.218.175.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FYzHg0Xn"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4j71whs7pU+NnCMQt6l/U/Btk6pFemJHjPQ5tC3+JVI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791974733; v=1; x=1792579533;
 b=FYzHg0XnYGEUQq4gQZ5cIbHAgUUe4PpGS1L3xemdo1QSXQzcIC76202IsBVcUhpf6mVVskX/
 XK4ZbrCHKtKxf26lrd1wGSJh0rbd9KbjJDTAkElHSfV7oM+6YU8/nTeRR4QAv4kDQFKqJpC0wiE
 r0uD1vFxp4NgP+ne0cKlS/C8=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 767be9f59756f718;
	Wed, 14 Oct 2026 10:45:21 +0000
X-Mizu-Trace-ID: 767be9f59756f718
X-Migadu-Flow: FLOW_OUT
Message-ID: <44aba42f-0355-4643-826f-0c7abec4499c@linux.dev>
Date: Wed, 14 Oct 2026 18:45:11 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: restrict transparent contpte mappings to valid
 PTEs
To: Dev Jain <dev.jain@arm.com>, Zhao Gongyi <zhaogongyi@bytedance.com>
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
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <0bbbe312-47a4-4eeb-8299-1f20daf4e949@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/10/14 18:03, Dev Jain wrote:
> 
> 
> On 14/10/26 12:01 pm, Zhao Gongyi wrote:
>> On 10/13/26 11:39 PM, Lance Yang wrote:
>>>>
>>>> +	/*
>>>> +	 * Keep the producer-side invariant documented in pgtable.h true even
>>>> +	 * if a direct caller passes an invalid descriptor with PTE_CONT set.
>>>> +	 */
>>>> +	if (!pte_valid(pte))
>>>> +		return __set_ptes(mm, addr, ptep, pte_mknoncont(pte), nr);
>>>
>>> set_ptes() is the only in-tree caller, and it already clears PTE_CONT
>>> before we get here ... no? Why not fold !pte_valid(pte) into the
>>> !mm_is_user(mm) check below and return __set_ptes() directly?
>>>
>>> 	if (!mm_is_user(mm) || !pte_valid(pte))
>>> 		return __set_ptes(mm, addr, ptep, pte, nr);
>>>
>>> If a direct caller does pass a !pte_valid PTE with PTE_CONT set, I'd
>>> rather add a VM_WARN_ON() to catch that. Silently clearing the bit would
>>> hide a caller bug :)
>>>
>>
>> Hi Lance,
>>
>> Thanks for taking a look.
>>
>> Yes, you are right. The public set_ptes() wrapper already strips PTE_CONT
>> before calling contpte_set_ptes(), so the pte_mknoncont() in the invalid
>> path is unnecessary for the current in-tree path.
>>
>> The issue I was trying to avoid is not that the incoming pte already has
>> PTE_CONT set, but that contpte_set_ptes() rebuilds the pte from pfn/prot
>> and then adds PTE_CONT again based on alignment. For an invalid descriptor,
>> that transparent contiguous encoding should be skipped entirely.
>>
>> So your suggested shape makes sense to me. I will change this to return
>> through __set_ptes() directly for invalid descriptors, and add a warning
>> for any unexpected direct caller that passes an invalid PTE with PTE_CONT
>> set, e.g.:
>>
>> 	if (!mm_is_user(mm) || !pte_valid(pte)) {
>> 		VM_WARN_ON_ONCE(!pte_valid(pte) && pte_cont(pte));
> 
> set_ptes does pte_mknoncont(), so the warning will *never* fire I think?

YES. Just a sanity check to catch a future direct caller passing
a !pte_valid PTE with PTE_CONT set, rather than silently clearing
the bit :)

Cheers, Lance

> 
>> 		return __set_ptes(mm, addr, ptep, pte, nr);
>> 	}
>>
>> That keeps the fix focused on not creating new invalid contpte entries,
>> while still catching a bad direct caller instead of silently sanitizing it.
>>
>> Thanks,
>> Zhao
> 

