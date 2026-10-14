Received: from mta0.migadu.com (out-115.mta0.migadu.com [91.218.175.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A32475340
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 06:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960403; cv=none; b=gnxUCqZnH5XAhpEF/WMhwPJ4JV8s0visziysUtyG6lY+/nkJM8C5QfRiOODPkmP8STO0sk1DKc1jCQoRg3yod0eyqeBr8iwwe6nTehRcE06Ggn8yMMsQPJJVyo8ibzPA8i4ulm/bAwpU1Xa01R3fgsvjGDP3i5bxgsEv/goc6ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960403; c=relaxed/simple;
	bh=JLmTAoue8gGf1ERWgAb5UXzBAVBda1/ywkl4q8ms6rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWuUUFmnt31RZ5jmqGyMlLUsq4Jk6sUKOfHq4v6A/aBJTXDbho+7hygElzpT3rGtZKTYzluXyBDH73AZIW1YvU2vhFIlocrX5BW+0vl09dxmMlWBzxX51SOYXPk9Uqu6mT8Oz+wyLkoiJHoUecFDQk1J+GhIdqclMOQx6OGb2Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XduXr+NW; arc=none smtp.client-ip=91.218.175.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XduXr+NW"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JLmTAoue8gGf1ERWgAb5UXzBAVBda1/ywkl4q8ms6rw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791960394; v=1; x=1792565194;
 b=XduXr+NWEQc2k1ced2e4wi+9s8WN76WAicldStKItAcufoJI3wVXZKFuaTRVUBF7ND96HqvN
 R0eN5dIVH8BZYV8hJprCPN82Jcgo77XC6FmBjysbkspL0JlH5jDAJN1pNq1vsLzkIQt/NFOchYo
 W3JiTblzWUaZR9iCpLyqRV+0=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b9d4fb5be1186799;
	Wed, 14 Oct 2026 06:46:34 +0000
X-Mizu-Trace-ID: b9d4fb5be1186799
X-Migadu-Flow: FLOW_OUT
Message-ID: <f111bec5-6148-4649-8805-79a250f6e736@linux.dev>
Date: Wed, 14 Oct 2026 14:46:21 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: restrict transparent contpte mappings to valid
 PTEs
Content-Language: en-US
To: Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: catalin.marinas@arm.com, will@kernel.org, ryan.roberts@arm.com,
 dev.jain@arm.com, baolin.wang@linux.alibaba.com, mark.rutland@arm.com,
 akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
 liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261013093600.54995-1-zhaogongyi@bytedance.com>
 <20261013153953.77575-1-lance.yang@linux.dev>
 <516828fb-558d-4a20-9532-51f50d6ba042@bytedance.com>
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <516828fb-558d-4a20-9532-51f50d6ba042@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/10/14 14:31, Zhao Gongyi wrote:
> On 10/13/26 11:39 PM, Lance Yang wrote:
>>>
>>> +	/*
>>> +	 * Keep the producer-side invariant documented in pgtable.h true even
>>> +	 * if a direct caller passes an invalid descriptor with PTE_CONT set.
>>> +	 */
>>> +	if (!pte_valid(pte))
>>> +		return __set_ptes(mm, addr, ptep, pte_mknoncont(pte), nr);
>>
>> set_ptes() is the only in-tree caller, and it already clears PTE_CONT
>> before we get here ... no? Why not fold !pte_valid(pte) into the
>> !mm_is_user(mm) check below and return __set_ptes() directly?
>>
>> 	if (!mm_is_user(mm) || !pte_valid(pte))
>> 		return __set_ptes(mm, addr, ptep, pte, nr);
>>
>> If a direct caller does pass a !pte_valid PTE with PTE_CONT set, I'd
>> rather add a VM_WARN_ON() to catch that. Silently clearing the bit would
>> hide a caller bug :)
>>
> 
> Hi Lance,
> 
> Thanks for taking a look.

Cheers!

> Yes, you are right. The public set_ptes() wrapper already strips PTE_CONT
> before calling contpte_set_ptes(), so the pte_mknoncont() in the invalid
> path is unnecessary for the current in-tree path.
> 
> The issue I was trying to avoid is not that the incoming pte already has
> PTE_CONT set, but that contpte_set_ptes() rebuilds the pte from pfn/prot
> and then adds PTE_CONT again based on alignment. For an invalid descriptor,
> that transparent contiguous encoding should be skipped entirely.
> 
> So your suggested shape makes sense to me. I will change this to return
> through __set_ptes() directly for invalid descriptors, and add a warning
> for any unexpected direct caller that passes an invalid PTE with PTE_CONT
> set, e.g.:
> 
> 	if (!mm_is_user(mm) || !pte_valid(pte)) {
> 		VM_WARN_ON_ONCE(!pte_valid(pte) && pte_cont(pte));
> 		return __set_ptes(mm, addr, ptep, pte, nr);
> 	}
> 
> That keeps the fix focused on not creating new invalid contpte entries,
> while still catching a bad direct caller instead of silently sanitizing it.

Thanks for the quick fix! Nothing jumped out at me :)

With that:

Tested-by: Lance Yang <lance.yang@linux.dev>
