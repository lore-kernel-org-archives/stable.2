Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F72528D831
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785918947; cv=none; b=OB4MTkWk1HYMQ6rqkt2nCkhyTCrpgf3TuYSK528sWUdj4sjJDlf67ojgNRURhP8Rxb3ne1VA8o24ZgGo7ZzYm8qtnwx2785o341MHtN7CC9zzwsfKZDMwZ/0bDB3fueNbd9CxtaW3fgy/V3VOTKCMA5+zpWZPD8N2+7UgrFe+cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785918947; c=relaxed/simple;
	bh=2Del6jwUsEdQBvVBTZxzNq9P6q7Gq3sEfKbVpcXvdjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F2sJHmmkznEHn4mzH86jYC9fH0pWb/FOJRFd7RB3AjSTIfIXHwCeZIkaEbi3twY/HkicJ7ra88ns3fav2O6SRvyom1buX156OdCXdVZ6fM91kKgskAPk2AFHK7EWvDnMf/xTKyO80/htYFc64NvoaUHUDLSWsUVUL9/gsph6O0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S0l1oRAh; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S0l1oRAh"
Message-ID: <666e55c0-5d4b-4b3d-9523-8170a012b172@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785918943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u0AnJkrMx7QjOonbpzeN6LmXwjYrMRg/WF8FenCDs2U=;
	b=S0l1oRAhRXzEMa8alEZliRFQYihbm6sNGtqbMEZ6pcnYJR2Vf5+jhfQUQlswrmqcs2CyHV
	GVP4mwT0sVS9f3LdXIaPAEnYIHbR4KObDuAg3Ta+q4Zoe6AHxKSaJPN5ghrjHVQLsXyHLr
	sSD07L+JgfuBgkOV8+75sDO2DUHoiUI=
Date: Wed, 5 Aug 2026 16:35:21 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] alloc_tag: fix undetected compressed tag overflow when
 profiling is disabled
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Abhishek Bapat <abhishekbapat@google.com>,
 stable@vger.kernel.org
References: <20260804122038.190270-1-hao.ge@linux.dev>
 <20260804124346.15e4be960ca4ac739f740248@linux-foundation.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <20260804124346.15e4be960ca4ac739f740248@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/8/5 03:43, Andrew Morton wrote:
> On Tue,  4 Aug 2026 20:20:38 +0800 Hao Ge <hao.ge@linux.dev> wrote:
> 
>> In reserve_module_tags(), the tag overflow check is gated on
>> mem_alloc_profiling_enabled():
>>
>>      if (mem_alloc_profiling_enabled() && !tags_addressable())
>>
>> If profiling is toggled off at runtime and a module is loaded whose
>> tags exceed the compressed-mode limit, shutdown_mem_profiling() is
>> skipped. vm_module_tags_populate() still maps memory for the tags and
>> the module loads successfully, but the total tag count now exceeds what
>> NR_UNUSED_PAGEFLAG_BITS can address.
>>
>> Once profiling is re-enabled, ref_to_idx() computes each tag's index
>> as its position in the alloc_tag array. update_page_tag_ref() masks
>> it to alloc_tag_ref_mask before storing in page->flags. Indices
>> beyond the mask are truncated and idx_to_ref() resolves them to wrong
>> tags.
>>
>> mem_alloc_profiling_enabled() and mem_profiling_compressed are
>> independent. Once compressed mode is established at boot, it stays
>> active regardless of runtime toggles of mem_profiling.
>>
>> Remove the mem_alloc_profiling_enabled() guard. Also return an error
>> after shutdown_mem_profiling() to skip vm_module_tags_populate(), as
>> the mapped pages would never be reused - shutdown_mem_profiling() sets
>> mem_profiling_support to false, so no future module load enters the
>> codetag path.
> 
> Thanks.  Sashiko pointed at a few things, one pre-existing.
> 	https://sashiko.dev/#/patchset/20260804122038.190270-1-hao.ge@linux.dev
> 
> Is there any sanity in there?
Hi Andrew

Thanks for pointing these out.
I went through all the Sashiko feedback from v1 and v2.
Most of what it flagged is pre-existing and I'll fix it separately.
The only point that actually touches this patch is the -ENOMEM failing 
the first load. Between wasting a few KB of tag memory to let the load 
succeed and returning -ENOMEM so the user just reloads the module once,
I prefer the latter: a re-insmod works because the codetag section is 
skipped once profiling is off, whereas those mapped tag pages would 
never be used or reclaimed.

Thanks
Best Regards
Hao
