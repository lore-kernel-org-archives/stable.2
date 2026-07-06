Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750AA3914F8;
	Mon,  6 Jul 2026 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783335309; cv=none; b=eGw+pa9rd98hv1aRLr1IpVqMEImHOnishTGMAtC22Mm6FIMPgdBUlB5ZLHC679BmgM7eMOQ3FnUv2HrrWNPRgnHU5Km+iPdDIhZgtN00/ZXnPizhnuWpBnIKLvV8Sv/t6XSq2sQcc5BcYg8BH/LZIb7B9VF7ZBuI51jnnmdu2+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783335309; c=relaxed/simple;
	bh=kUg3SSlZYOMQVG94aHXp/3YGAOJyzCEBoYwrgN+THCA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eWXoZ7RlE/QOuAz0Qz8K3X01IWjNfStwqLjtWMs55wDW/p8Ssn/+nO0Hsxy0JLo1ZA7BC9et8VNjDnOVirWIBf1xXBex3EJXfXapCBL7HgRs+DgfudOY4x1WqeAst+f5ZuWJVy2eJjzS1RfnebV/NzLZAHkbl5dc24ceXG8lHI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=shX+3OKH; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="shX+3OKH"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4572C3297;
	Mon,  6 Jul 2026 03:55:02 -0700 (PDT)
Received: from [10.164.148.41] (MacBook-Pro.blr.arm.com [10.164.148.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 302593F85F;
	Mon,  6 Jul 2026 03:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783335306; bh=kUg3SSlZYOMQVG94aHXp/3YGAOJyzCEBoYwrgN+THCA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=shX+3OKH0GDEBl7HPAkKvHndWQPXZWFDYKZCnRDHc9zSOZOlyrOtxtPdT7WkUnZn6
	 drCorekkLPZ520O6dDK+omcH6IgAdV1z6HYRZqrAw98nqbl8DNSHUS0Yu7Cfzw9nSQ
	 K3tyrSAYUqGV2vp3jALusUBwt8fqAi6J+2p6EhJA=
Message-ID: <7ac558fd-1081-456b-b997-c7321241cf8c@arm.com>
Date: Mon, 6 Jul 2026 16:24:53 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] arm64: make huge_ptep_get handled unaligned
 addresses
From: Dev Jain <dev.jain@arm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: muchun.song@linux.dev, osalvador@suse.de, ljs@kernel.org,
 liam@infradead.org, riel@surriel.com, vbabka@kernel.org, harry@kernel.org,
 jannh@google.com, lance.yang@linux.dev, kas@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, apopple@nvidia.com, rcampbell@nvidia.com,
 ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, ak@linux.intel.com, nao.horiguchi@gmail.com,
 mel@csn.ul.ie, j-nomura@ce.jp.nec.com, pfalcato@suse.de, tglx@kernel.org,
 dave.hansen@intel.com, jpoimboe@kernel.org, catalin.marinas@arm.com,
 will@kernel.org, linux-arm-kernel@lists.infradead.org, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, stable@vger.kernel.org
References: <20260703114202.365553-1-dev.jain@arm.com>
 <20260703114202.365553-2-dev.jain@arm.com>
 <20260705003559.8b124d2b94b685cc2e4e77ae@linux-foundation.org>
 <8fdbe0d6-87fd-441c-b6d2-baac380f6fb3@arm.com>
 <4b4e8007-3747-457a-85cc-d1003e1c8fe2@kernel.org>
 <39a13445-dc6f-4a75-92b8-f4a122c63b89@arm.com>
Content-Language: en-US
In-Reply-To: <39a13445-dc6f-4a75-92b8-f4a122c63b89@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06/07/26 4:22 pm, Dev Jain wrote:
> 
> 
> On 06/07/26 2:15 pm, David Hildenbrand (Arm) wrote:
>> On 7/5/26 10:08, Dev Jain wrote:
>>>
>>>
>>> On 05/07/26 1:05 pm, Andrew Morton wrote:
>>>> On Fri,  3 Jul 2026 11:41:54 +0000 Dev Jain <dev.jain@arm.com> wrote:
>>>>
>>>>> huge_ptep_get() can be handed a virtual address pointing to the middle of
>>>>> a contpmd/contpte mapped hugetlb folio (examples of callers are
>>>>> pagemap_hugetlb_range, page_mapped_in_vma).
>>>>>
>>>>> The arm64 helper rewalks the pgtables in find_num_contig to answer whether
>>>>> the huge pte we have maps a contpmd or a contpte hugetlb folio, and
>>>>> returns CONT_PMDS or CONT_PTES, so that it can collect a/d bits over the
>>>>> contiguous ptes. We can falsely return CONT_PTES instead of CONT_PMDS
>>>>> if the addr is not aligned.
>>>>>
>>>>> Fix this by aligning the pmdp pointer down to a contpmd base before
>>>>> checking equality with the passed huge pte pointer, to correctly answer
>>>>> whether the huge pte is the base of a contpmd block.
>>>>>
>>>>> Fixes: 29cb80519689 ("arm64: hugetlb: Cleanup huge_pte size discovery mechanisms")
>>>>> Cc: stable@vger.kernel.org
>>>>
>>>> Please describe the userspace-visible effects of bugs when fixing them.
>>>> Particularly when cc:stable is proposed.  Thanks.
>>>
>>> Forgot for this one. It should be, on systems where CONT_PTES != CONT_PMDS
>>> (meaning page size is 16K) we could collect excess a/d bit state, meaning
>>> extra work for the kernel.
>>
>> Even worse, right? We could walk 128 entries, when we really should just walk 16
>> (IIRC) entries, possibly reading garbage or even worse, into a memory hole at
>> the end of memory?
> 
> Hmm I was thinking that the checks pte_dirty() and pte_young() wouldn't care whether
> the pte is garbage. But, we could actually dereference a ptep pointer not having
> backing memory at all.
> 
> Does the following sound good?
> 
> "On systems where CONT_PTES != CONT_PMDS (meaning page size is 16K), we could collect
> excess a/d bit state, meaning extra work for the kernel. Even worse, we may iterate
> beyond the PTE table and dereference a garbage ptep pointer to access physical
> memory we don't own. Since the ptep pointer is a linear map address, we may run off
> the end of the linear map, dereference a VA not mapped into the kernel pgtables and
> cause kernel panic."
> 
> Although I checked on arm64, there is no case in which there is a hole after the
> linear map, but still that assumption shouldn't be made.

Oh but we could access a linear map address which corresponds to a DRAM hole, meaning
there is no entry in the kernel pgtable.


> 
> 
>>
> 
> 

