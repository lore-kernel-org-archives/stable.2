Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B81581ACD
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 02:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782529167; cv=none; b=pupwHKbhJefBTmCEsJfDLpqet72O+xNaVudHP35cno6PI992EA6iVLjZytqJZF/NMOna/pUWU3JJSVvclHRH4P9FV+touesVmRYic6FPetIzjj9u7yGLWUu6Y8PNQze9DQRCUe54PcLK7SgvQXYw5YELQVAEU+txI9nGyOqq7Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782529167; c=relaxed/simple;
	bh=r9Q75OphY5MVzASjBnbo0wibhw8YfM7UaaE8mUUkTxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfgsj1BwOvL3tMceHsrdomCEMBKqtjcFKItCyjm8VUV225d8X2B1pQ9FbUqSAQexvczZLCFibO3/hPnYHbR39OQ/N2lw6W+Vj+gUwyOq5wUM/YYcaOXyq6fANLLx5mNwSleLTus3D1U7nnZs0JtJkdeRR63wz02beABi4196xsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HUNDZz1I; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HUNDZz1I"
Message-ID: <b7cfc04e-7a57-489e-9459-82d7eb818675@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782529163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xIG1WH1JHTR3E2pytb6E4uisyr919RG1wajEmDiA1og=;
	b=HUNDZz1I1zmsm2yvEdpByTZMAD4cmxX9cV8oH6VsWDhD/ii4iFw87sOrhG8+S4Hq2H68JI
	t1A+5d3yUd77doQ7ZKSVyjdJa6K1QL2hZMEPMQzgZiN0YN7NYIZdWsOzw3KTWHJvIIk3qy
	xzFNuuzfeEJ43OS7b/YmR+vy3EmV3+I=
Date: Sat, 27 Jun 2026 10:59:16 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Patch mm-hotfixes v4] mm/page_vma_mapped: fix device-private PMD
 handling
Content-Language: en-US
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, ljs@kernel.org, riel@surriel.com,
 liam@infradead.org, vbabka@kernel.org, harry@kernel.org, jannh@google.com,
 ziy@nvidia.com, sj@kernel.org, balbirs@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 "David Hildenbrand (Arm)" <david@kernel.org>
References: <20260624065353.1622-1-richard.weiyang@gmail.com>
 <d060cadd-34f8-42da-b7f7-c8d295050436@kernel.org>
 <20260627020719.ipzfrlhfbvr6ac35@master>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260627020719.ipzfrlhfbvr6ac35@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/6/27 10:07, Wei Yang wrote:
[...]
> 
> Hi David
> 
> I did a little adjustment like below. Want to check with you at first.
> 
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
> 
> How about:
> 				const softleaf_t entry = softleaf_from_pmd(pmde);
> 
>> -				if (!thp_migration_supported() ||
>> -				    !(pvmw->flags & PVMW_MIGRATION))
>> +				if (!(pvmw->flags & PVMW_MIGRATION))
>> 					return not_found(pvmw);
>> 				entry = softleaf_from_pmd(pmde);
> 
> could be removed.
> 
>> +				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>> +					return not_found(pvmw);
>> +				return true;
>> +			} else if (pmd_is_device_private_entry(pmde)) {
>> +				softleaf_t entry;
> 
> The same.
> 
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
> 
> How about merge this with above? And put at the first case?
> 
> Below is what it looks like:

Why add more churn to a fix with a stable tag? Cleanup can come later no?

[...]
