Received: from mta0.migadu.com (out-245.mta0.migadu.com [91.218.175.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F330B3C8C60
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 06:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541107; cv=none; b=AiEG4EUIXVn91mf/ry67Sy2yK6i35iRU5hh6g7fZxwSJGVHdOUrRC8nbcUQq25IT2FiKIJHod8I8bOr+ZhBj+2xvO2Ke/QWrTASb+941EkXJBaYkK515VEx6mSpl2V26aF4/4K3BgAvDM/XdvyavMv589kK9uYHVxknHCY7P7kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541107; c=relaxed/simple;
	bh=CemCmch04q5mUKawMy0vidBfLn08c8QpxpUgzyNdQbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwtKDpe2yy4xy2LoPKHMBjjqb8qIzvnwveeZI7R6hpYQCHmIZsQRYGMT/iwjXpd1NHp5obTU/99JnCVm7B/e0KxyjIrxXh15WUIPiamCCdK3gMC28UVaMelNVqV+VP5uCgdzz71flexLMP2B4l8lpDovT4dlf2z84aBKHKc9SsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mXtBqUic; arc=none smtp.client-ip=91.218.175.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mXtBqUic"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CemCmch04q5mUKawMy0vidBfLn08c8QpxpUgzyNdQbo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789541101; v=1; x=1790145901;
 b=mXtBqUicZVuyi6kRAjPefsuJTqASG+Jfri2piloLrH/3hj9T6NVpUR3Dnh46JJTSnCZ898y9
 k3thCelzmNSsoxhG8dBjrc0j25MlHAaBH2CYyzB6A0QPqwa/D3aRWZp1dPJeeeZiRl6pE40sr8k
 B+XWHubvH1r+fr4GIda6ux60=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0ef214d3c88bf2cc;
	Wed, 16 Sep 2026 06:45:01 +0000
X-Mizu-Trace-ID: 0ef214d3c88bf2cc
X-Migadu-Flow: FLOW_OUT
Message-ID: <0efbf471-b74e-4dfa-9335-f1720854d880@linux.dev>
Date: Wed, 16 Sep 2026 14:44:52 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/huge_memory: fix pgtable withdrawal for huge zero
 PMDs
Content-Language: en-US
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 liam@infradead.org, nico.pache@linux.dev, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, usama.arif@linux.dev, kas@kernel.org,
 ljs@kernel.org, surenb@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <83a1287b-8589-4408-96f4-4f78dfca1bc9@kernel.org>
 <20260916044142.95044-1-lance.yang@linux.dev>
 <f784fec5-7261-4ebe-803e-eb26141a0fdc@kernel.org>
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <f784fec5-7261-4ebe-803e-eb26141a0fdc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/9/16 14:11, David Hildenbrand (Arm) wrote:
> On 9/16/26 06:41, Lance Yang wrote:
>>
>> On Tue, Sep 15, 2026 at 05:13:17PM +0200, David Hildenbrand (Arm) wrote:
>> [...]
>>>
>>> Ok, it's really only DAX and anonymous VMAs that use the huge zero folio. Other
>>> (module) code would have a hard time using it, as mm_get_huge_zero_folio() is
>>> not exported to modules.
>>>
>>> DAX uses dax_pmd_load_hole()->vmf_insert_folio_pmd()->insert_pmd() where we
>>> deposit a page table only if arch_needs_pgtable_deposit().
>>>
>>>
>>> So I think the rule is simply:
>>>
>>> arch_needs_pgtable_deposit() -> always deposited
>>> vma_is_anonymous() -> always deposited
>>>
>>> ?
>>
>> YES!
>>
>>>
>>> The trick is that we don't have anon THPs in non-anon VMAs.
>>>
>>> So could this be simplified further or am I missing something?
>>
>> Ah, cool! I hadn't thought of that :) You're right, anon THPs cannot live
>> in non-anon VMAs, so pmdval and folio aren't needed here. Will simplify
>> it as suggested :) and add a comment explaining the rule.
>>
>> static bool has_deposited_pgtable(struct vm_area_struct *vma)
>> {
>> 	return arch_needs_pgtable_deposit() || vma_is_anonymous(vma);
>> }
> 
> Yes, that's what I had in mind. (while at it, maybe call it "vma_has_*)

Good point, will do. Thanks!

