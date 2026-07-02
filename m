Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2CF2D7814
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 01:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956882; cv=none; b=tccjQmaqaG4fRVkmBOblrej8uod4DOAUvOof/WWRdiKeMW/onzJV3oihAWspk91PO4xvF7XQ9Di2e/5otCsXhyhwEJKyW2viLur0VGr0sVVApzSUzHuXBTmd8zncjgZV0dsXko80C25htcrEmqmOvS8LwM2I/8k72dCyJyIwOSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956882; c=relaxed/simple;
	bh=vL19Y66aq34h6lqefzTPMlw6YHkIm12+EbTAWK8cCro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlPXOeNRb/s3ENNrCX4at2dQIEBzaYu2cIYkImVqCmissXaiA6HfZ2TjnyP5kbZK7takkCTRVIPaemd+iFlee0IDP38nij6Xlui1zoThj4yEmxc9gHaK5dKuxNcL5Dj0lWK5kiTBQ4LQMtsB5DT/jNgmP3HDDftYLSDYlRXoKOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZFj8EC9C; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZFj8EC9C"
Message-ID: <5af860ed-e468-495b-905e-5571bf7344af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782956867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JADcuSn/VPIsOHwuCi62daxla5bBVdR5HLrgcBe0R44=;
	b=ZFj8EC9C00SOAkiPd9aM7NmWzeXHYvQayP7DAeln2p7O6oY0pn46TFCduoAzBHEbZwdunE
	d6YaQcpaVWFusEmmmz55uoGwcr0BNfZFcL6jWmXkx3vyMsFm+hgvh6kWEBL83KUzjyTeKF
	j3I0zb2aV3VH+Bg+ZkWgp5I75KWH2es=
Date: Thu, 2 Jul 2026 09:47:25 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Patch mm-hotfixes v5] mm/page_vma_mapped: fix device-private PMD
 handling
To: Klara Modin <klarasmodin@gmail.com>
Cc: david@kernel.org, richard.weiyang@gmail.com, akpm@linux-foundation.org,
 ljs@kernel.org, riel@surriel.com, liam@infradead.org, vbabka@kernel.org,
 harry@kernel.org, jannh@google.com, balbirs@nvidia.com, sj@kernel.org,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <d4e4180e-dcdf-40e6-b5a2-2ac55f4aecc4@kernel.org>
 <20260701163356.22936-1-lance.yang@linux.dev>
 <akVDNLGaCfr-PF8K@soda.int.kasm.eu>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <akVDNLGaCfr-PF8K@soda.int.kasm.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/7/2 00:46, Klara Modin wrote:
[...]
>>>>
>>>> My only guess here would be that the compiler evaluates
>>>> !softleaf_is_migration(entry) to always be true and optimises away the
>>>> !check_pmd(softleaf_to_pfn(entry), pvmw) which is why this worked
>>>> before?
>>>
>>> Weird, we enter this path only with
>>>
>>> pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
>>> pmd_is_device_private_entry(pmde)
>>>
>>> If any one of these would compile for !CONFIG_TRANSPARENT_HUGEPAGE that would be
>>> odd.
>>>
>>> pmd_is_device_private_entry() is hard-coded to false unless
>>> CONFIG_ARCH_ENABLE_THP_MIGRATION. Which is only selected with
>>> ARCH_ENABLE_THP_MIGRATION.
>>>
>>> pmd_trans_huge() as well.
>>>
>>> Maybe it's struggling with pmd_is_migration_entry() on some (older) compilers?
>>> (not innlining stuff and not properly optimizing it out).
> 
> It's a GCC 16 cross-compiler for armv6 so I wouldn't call it old :)
> 
>>>
>>> The whole conditional must be optimized out.
>>
>> Right. Kinda weird if compiler didn't fold
>>
>> pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
>> pmd_is_device_private_entry(pmde)
>>
>> away here ...
>>
>>> We could check for IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) right at the start
>>> to make it easier for the compiler:
>>
>> +1, explicit THP guard should do the trick :)
>>
>>> if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) &&
>>>     (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
>>>      pmd_is_device_private_entry(pmde))) {
>>>
>>>
>>
>> Klara, could you try with this change and see if it fixes the build?
>>
>> Thanks, Lance
> 
> This does indeed make it build.

Good to know, thanks for testing!
