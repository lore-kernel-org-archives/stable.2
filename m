Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A228CF5D;
	Wed, 14 Oct 2026 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791967097; cv=none; b=uepjPTEatJ+Br9Ghkh53HkjCqf69H5JuXjPdaA+WOFiw89BdngV78HemqOxPqvYdUlBoB4z8TBaqsL2NfJWHQ56hbNNI5k8CQwBDgaIIRtpIeEVMZ9Uf9ZewhZL8qiMXVZQayQRjJd0o79yG0xtfSblUIB8ZjJq/WknDufMDSLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791967097; c=relaxed/simple;
	bh=fyE6NuYU7YKQBcZXvmXWcdQEQhxvWJMMQXZzrHih7Xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8laUCoUDbhMphQkHk0qoMzuUqXSSucv/5VrfZSksj+NWrFRLi0WB+7X7dM0ZzisY8YNbaDleHEmAxNLm/geF1xI73zzKml3yWPkTmESINjqOdi++63+hHL0BOUVnTE8Au5Iv8OAJbKzBS98t4xL2xc5PR19UGFXodjonnM3Ns4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LtGynmg+; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LtGynmg+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791967091; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HfozdcxqBChVvaf7D3SigXB2jJovmVY483zJua6pyIA=;
	b=LtGynmg+3pa4Wz2+8nF1hhlUIVm2sdc/yanpkbURnvYZcmWW1Szk3v+IuDcPLBZ1RnaLCJ/epBWVn3zEI1CV1K/SButAawjb1sUGxSZjRa7z4S41KlbXuolcCDiJPZ3SOSnGOvUQMLZEpNtXby2pWLvGTpYkAkLC3JHrIFieSjg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0XCoZJ.D_1791967088;
Received: from 30.74.144.153(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XCoZJ.D_1791967088 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Oct 2026 16:38:09 +0800
Message-ID: <a6feb3f1-c08d-4d54-a38b-55fafcfec7b8@linux.alibaba.com>
Date: Wed, 14 Oct 2026 16:38:08 +0800
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
 dev.jain@arm.com, mark.rutland@arm.com, akpm@linux-foundation.org,
 david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261013093600.54995-1-zhaogongyi@bytedance.com>
 <20261013153953.77575-1-lance.yang@linux.dev>
 <516828fb-558d-4a20-9532-51f50d6ba042@bytedance.com>
 <f111bec5-6148-4649-8805-79a250f6e736@linux.dev>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <f111bec5-6148-4649-8805-79a250f6e736@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/14/26 2:46 PM, Lance Yang wrote:
> 
> 
> On 2026/10/14 14:31, Zhao Gongyi wrote:
>> On 10/13/26 11:39 PM, Lance Yang wrote:
>>>>
>>>> +    /*
>>>> +     * Keep the producer-side invariant documented in pgtable.h 
>>>> true even
>>>> +     * if a direct caller passes an invalid descriptor with 
>>>> PTE_CONT set.
>>>> +     */
>>>> +    if (!pte_valid(pte))
>>>> +        return __set_ptes(mm, addr, ptep, pte_mknoncont(pte), nr);
>>>
>>> set_ptes() is the only in-tree caller, and it already clears PTE_CONT
>>> before we get here ... no? Why not fold !pte_valid(pte) into the
>>> !mm_is_user(mm) check below and return __set_ptes() directly?
>>>
>>>     if (!mm_is_user(mm) || !pte_valid(pte))
>>>         return __set_ptes(mm, addr, ptep, pte, nr);
>>>
>>> If a direct caller does pass a !pte_valid PTE with PTE_CONT set, I'd
>>> rather add a VM_WARN_ON() to catch that. Silently clearing the bit would
>>> hide a caller bug :)
>>>
>>
>> Hi Lance,
>>
>> Thanks for taking a look.
> 
> Cheers!
> 
>> Yes, you are right. The public set_ptes() wrapper already strips PTE_CONT
>> before calling contpte_set_ptes(), so the pte_mknoncont() in the invalid
>> path is unnecessary for the current in-tree path.
>>
>> The issue I was trying to avoid is not that the incoming pte already has
>> PTE_CONT set, but that contpte_set_ptes() rebuilds the pte from pfn/prot
>> and then adds PTE_CONT again based on alignment. For an invalid 
>> descriptor,
>> that transparent contiguous encoding should be skipped entirely.
>>
>> So your suggested shape makes sense to me. I will change this to return
>> through __set_ptes() directly for invalid descriptors, and add a warning
>> for any unexpected direct caller that passes an invalid PTE with PTE_CONT
>> set, e.g.:
>>
>>     if (!mm_is_user(mm) || !pte_valid(pte)) {
>>         VM_WARN_ON_ONCE(!pte_valid(pte) && pte_cont(pte));

mprotect() can trigger the warning here when setting PAGE_NONE for a 
batch of PTEs?

>>         return __set_ptes(mm, addr, ptep, pte, nr);

I am trying to convince myself that the 'nr' passed in is always 
CONT_PTE_SIZE aligned, but it seems OK.
