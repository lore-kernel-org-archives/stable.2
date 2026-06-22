Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF35C3264D7
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140429; cv=none; b=sK8nEWa8jREWBKZqo8ndlkjMrfl1GurDbJeRNccay9dc6wpZpfUp0QrZeaQ5mWMzLZ70ksKtQu0LCWx2a9ZSZ8uNm9HnF4uZLsXQz3dufhKeW/4a0q5U2+cQCwac2NKqDwWif9MVqMVg5BPMqCW40CoCBCxoRg3BlpjA3Bx0E8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140429; c=relaxed/simple;
	bh=PlnXP82l5c9DBIRhnBwz60gBUOqylW2SmOkpkj4/boc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBsiN0ri2atC1bICkQVFCCxFm4lA61kwfiC1VywFeZfto+VsDmAU/0ZkFJwFZZPBNDD8tArjHuhAB1VhPxffG/pRnVyJtkoaKt17H3fID5WkPopm4JCpc618E9yVvGPM/Hj9iDz2l/qqO8/1qmLZtTremLXmR+z15+z4eZM4Er8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lm7QAjZj; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lm7QAjZj"
Message-ID: <fbad4ccd-33dd-4d5f-be34-254095e714b0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782140415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NOJ7I8F4EO4YGKqeUHW4KddOImg3/9NrBeT3tUiiggU=;
	b=lm7QAjZjJbNEjzhuKwp0t1Wo0hoKuz96n30Jj0Jga70Q2X+pdZe1co7PxyVG3oEUiCtdfb
	i/Jiv9p5E5Vq/0nSMaQDAQQ5WRo7gwjfD7sEQCSDBp2IL2ZVc5Mn8J4Fh4i+3LSrjIt692
	XXYWmHgWKSGT/dpiCjUyhvOmhiC/wkY=
Date: Mon, 22 Jun 2026 22:59:39 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/page_vma_mapped: revalidate and do proper check before
 return device-private pmd
Content-Language: en-US
To: Wei Yang <richard.weiyang@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>
Cc: akpm@linux-foundation.org, david@kernel.org, riel@surriel.com,
 liam@infradead.org, vbabka@kernel.org, harry@kernel.org, jannh@google.com,
 sj@kernel.org, ziy@nvidia.com, balbirs@nvidia.com, linux-mm@kvack.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260622130651.23359-1-richard.weiyang@gmail.com>
 <ajk0N3Aekapljaoh@lucifer> <20260622142102.pcmr5pftshj5lvju@master>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260622142102.pcmr5pftshj5lvju@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/6/22 22:21, Wei Yang wrote:
> On Mon, Jun 22, 2026 at 02:46:40PM +0100, Lorenzo Stoakes wrote:
>> +cc Lance, linux-kernel
>>
>> Your subject line is 83 characters long and is way too detailed how about 'fix
>> device-private PMD handling'?
>>
> 
> Got it.
> 
>> You forgot to include linux-kernel@vger.kernel.org on the mail, lore seems to be
>> a bit broken atm but in general it's helpful to include that.
> 
> Got it.
> 
> So usually we send a patch to both linux-mm and linux-kernel? If so, I
> remember is later actions.

Yeah, please keep linux-kernel copied too. For MM patches, linux-mm +
linux-kernel is the right default, IMHO :)

>>
>> Also is useful to make this [PATCH mm-hotfixes] to make it really clear it's
>> intended as a hotfix.
>>
> 
> Got it.
> 
[...]
>> ----8<----
>> >From e6a3c1c782714ed831c4d46a14bb99226423bf59 Mon Sep 17 00:00:00 2001
>> From: Wei Yang <richard.weiyang@gmail.com>
>> Date: Mon, 22 Jun 2026 13:06:51 +0000
>> Subject: [PATCH] refactored
>>
>> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
>> ---
>> mm/page_vma_mapped.c | 20 +++++++++++++++-----
>> 1 file changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> index 2ccbabfb2cc1..17dff8aab9f9 100644
>> --- a/mm/page_vma_mapped.c
>> +++ b/mm/page_vma_mapped.c
>> @@ -269,14 +269,24 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>> 			/* THP pmd was split under us: handle on pte level */
>> 			spin_unlock(pvmw->ptl);
>> 			pvmw->ptl = NULL;
>> -		} else if (!pmd_present(pmde)) {
>> -			const softleaf_t entry = softleaf_from_pmd(pmde);
>> +		} else if (pmd_is_device_private_entry(pmde)) {
>> +			softleaf_t entry;
>> +
>> +			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>> +			pmde = *pvmw->pmd;
>> +			entry = softleaf_from_pmd(pmde);
>>
>> -			if (softleaf_is_device_private(entry)) {
>> -				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>> +			if (likely(softleaf_is_device_private(entry))) {
>> +				if (pvmw->flags & PVMW_MIGRATION)
>> +					return not_found(pvmw);
>> +				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>> +					return not_found(pvmw);
>> 				return true;
>> 			}
>> -
>> +			/* device-private pmd was split under us: handle on pte level */
>> +			spin_unlock(pvmw->ptl);
>> +			pvmw->ptl = NULL;
>> +		} else if (!pmd_present(pmde)) {
>> 			if ((pvmw->flags & PVMW_SYNC) &&
>> 			    thp_vma_suitable_order(vma, pvmw->address,
>> 						   PMD_ORDER) &&
>> --
>> 2.54.0
> 
> If we prefer this way, I will check and take it.

And +1 on Lorenzo's diff. Much cleaner.

Cheers, Lance

