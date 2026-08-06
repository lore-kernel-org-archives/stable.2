Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42913624CF
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786034048; cv=none; b=WxMLK8N5A6UrzkBeqW4GtVL/Cn5DEmy1yWuNK/gg2J0VXNNQzuHOJDJJbWMphNMFJ4K5tXTvRXEerIoj8Gs0QDJ4W2C+v5xMihpUFBSTCJwlydHrYik8+uZwVI0MIr88wdWHbRBhO5I/w36qpgEsUwiWWGef5ukLifoKUGIR8sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786034048; c=relaxed/simple;
	bh=4Ne+jJmBgdlIOpnC36PxFcQXxx3PRA1g/ge80WWktb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uHIh63lpdNhdFkOkwPnXX8es2Hss00soquX8wLEeaKjjlpWFbauyI6JXzSL5uNsZ8EzuPxKzyna+44f6ABkirwP+dZmTP9iKWkKkmWVIwCWntgmhXVfO3mF+77++zCj4aQcU9lecOV5W/ttG5VMm7m/PV9h5csn/d77B4+TmNXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFprzlFx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nHR2yiSk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFprzlFx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nHR2yiSk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786034045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JQp5RwExOV2Y6Ewnz0reZlcW0GsOQG1VQZgGAw/gAgM=;
	b=VFprzlFxWtNUKyK32CWo9pf/168pMx6JvvLbD2YRpXKq2z4HvcDdCdXcDnWkgOVbtBQkWz
	EDLui6LEZocfI/zNvQqoFW9gqNC65YUEc17cZW1UPq2Y1NAWhTyREQXQh4oG/5+Jw8a8rt
	/hV+vW4fFAMu1OjG6k+pbwIdllQWOJE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-jQdBZeAdNNKM6p7jQpIrxQ-1; Thu, 06 Aug 2026 12:34:04 -0400
X-MC-Unique: jQdBZeAdNNKM6p7jQpIrxQ-1
X-Mimecast-MFC-AGG-ID: jQdBZeAdNNKM6p7jQpIrxQ_1786034043
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f83999cceso1926486f8f.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 09:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786034043; x=1786638843; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JQp5RwExOV2Y6Ewnz0reZlcW0GsOQG1VQZgGAw/gAgM=;
        b=nHR2yiSkR+OjxndueLV+JvDRf7CE3UEd0L0gLaqTnoNKMTtIHO2cLKrGxLoXYxxRwD
         mwM9AzkuefZ/ZeomtcZ/j/di7wa3F2wBVboT0InZf2TQV5avBIK/tcSJS8miuv78qY9E
         Sgce6INps8X+etL9iX8JGdpG9oLHIHHSaosQmo/cnjmh9XFIjo1PLosthRUkHCz46n2x
         nADZJK3JO2Swdyz0NlsDcmXnjmCGnvUHXWCirfBbZ0VPV9LxeyMQ2wGt87IUu14mPwk9
         k0ivKdaa/Ju9lsu4tODHPylu+Q8zO27c9qVt6au39R4fXBH5AOuz0k5kA9qmIe0Qo4DR
         g9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786034043; x=1786638843;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JQp5RwExOV2Y6Ewnz0reZlcW0GsOQG1VQZgGAw/gAgM=;
        b=j11xAwIk1h6KWEk/MTOdEN82JgJhuXHNPNgFS626ZGxVMS22ASPx8ocxtvxPLDyy/R
         p/jC1kZLRUDy876SlLTHobMdQommJv0Oy+pQ98XxpZvMevsIpJiy8kkvEGVLxSp2pGnq
         9tnkVoZ5KCRfWZpWsmUNp2H7NrMq+ohxwW6CUFO9XAI5lpJ+iXzan9awiaeL+r3IDuXO
         YaE2Giw70fkKl+5R24rmtIz/rPariN9e923bnt5XM/g6XkbzgLTYzJsWhSFG2mKdYiPq
         ZBTopLstMCk9AOCrZ31MhXDFW3rAdvCISeG+yMMGOxjYfhxbdwN9/AaTC+A1UkXkOGBr
         KUXw==
X-Forwarded-Encrypted: i=1; AHgh+RqekNTrc8y3YYDuwRj2Xlb3aaNHF11PmhsJZMVBNvBoUgGMEaZ4fFu3kXZiBCxzuvpwie7mlLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj4u5fR/nHe8NDwtf0M6BTB88LZfgAVY86X74ul87ays8ezJpM
	vtmyecSahf9HNeFfVQTa4I8lBRO+7BMob9FzvIHgNc1F9HGcge2modisM/AFN81Az75CGfrVNP9
	VremAC8odJrVv9IHCYjA096yJxifZURhD822ZW6NHCPLqOCZOPLEI5pcajA==
X-Gm-Gg: AR+sD10CXPw+tUa9fo93vdTwzFJ4iYGnt0uG+N674dx4t5CxmJaY/qgW30PPIdBEbTQ
	yrLgcgEGGrAfHzTtHLy+80aq0/HMAXxDfzcaswfDF2ZRmXciIt8HTpnIZgHMIio994b/d6kjU09
	EoWfXS8wU973YQJ2XB1qW0sRDAoCMmc7mq2doKBEUg1X6poOfF0HD7nrtRp8VceOSmrhq4HtZzp
	6tuQwNEjl7tafoFnYTdiiYUw/u4KdDiBoctESz5UliZCsi6dmuk5j5woNawo+ho038enwbL5Jcn
	Fr3dbqAgoqETITZoZFs6z7zWVPhWeOdEoeoj+mxUT3DsqmpVSLGYbiHNShO8dPX8DB2UF8z+rjg
	9SPJ7xrcQ1mypWw5QBREu9HQ79Eww0gE6Q6Eeios=
X-Received: by 2002:a05:6000:29cc:b0:47f:e748:3ae3 with SMTP id ffacd0b85a97d-47fec4e7431mr21184625f8f.3.1786034042808;
        Thu, 06 Aug 2026 09:34:02 -0700 (PDT)
X-Received: by 2002:a05:6000:29cc:b0:47f:e748:3ae3 with SMTP id ffacd0b85a97d-47fec4e7431mr21184557f8f.3.1786034042349;
        Thu, 06 Aug 2026 09:34:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a? ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b31975sm6656072f8f.33.2026.08.06.09.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 09:34:01 -0700 (PDT)
Message-ID: <2a7686ee-56ab-439a-90fd-ad3c10e4c336@redhat.com>
Date: Thu, 6 Aug 2026 18:34:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: let special huge VMAs bypass the THP
 policy check
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260805055544.1568534-1-clg@redhat.com>
 <anL-NZkNMSSxN0YN@lucifer> <0bd6d355-e6d9-4f5a-b101-9a041c2a2436@kernel.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <0bd6d355-e6d9-4f5a-b101-9a041c2a2436@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/26 18:19, David Hildenbrand (Arm) wrote:
>>  From d6537260722c8741586e6295c8eea68d06087efa Mon Sep 17 00:00:00 2001
>> From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
>> Date: Wed, 5 Aug 2026 11:35:13 +0100
>> Subject: [PATCH] ideas
>>
>> ---
>>   mm/huge_memory.c | 32 +++++++++++++++++++++++++++++---
>>   1 file changed, 29 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index abc65d608c23..5fa01364f089 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -111,6 +111,34 @@ static bool vma_is_special_huge(const struct vm_area_struct *vma)
>>   	return vma_test_any(vma, VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT);
>>   }
>>
>> +static bool should_obey_thp_file_tunables(const struct vm_area_struct *vma,
>> +					  bool forced_collapse)
>> +{> +	if (forced_collapse)
>> +		return false;
>> +	VM_WARN_ON_ONCE(vma_is_anonymous(vma));
>> +	/* Huge PFN mappings allocate no folios so the policy doesn't apply. */
>> +	if (vma_test(vma, VMA_PFNMAP_BIT) && vma->vm_ops->huge_fault)
>> +		return false;
>> +	return true;
>> +}
> 
> If that's sufficient, then this is is the better direction.
> 
>> +> +static bool can_thp_collapse_file(const struct vm_area_struct *vma,
>> +		vm_flags_t vm_flags, bool forced_collapse)
>> +{
>> +	/* Override THP tunables? */
>> +	if (!should_obey_thp_file_tunables(vma, forced_collapse))
>> +		return true;
>> +	/* THP=always? */
>> +	if (hugepage_global_always())
>> +		return true;
>> +	/* THP=madvise? */
>> +	if (!hugepage_global_enabled())
>> +		return false;
>> +	/* Has VMA had madvise(..., MADV_HUGEPAGE) applied to it? */
>> +	return vm_flags & VM_HUGEPAGE;
>> +}
>> +
>>   unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>>   					 vm_flags_t vm_flags,
>>   					 enum tva_type type,
>> @@ -188,9 +216,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>>   		 * Enforce THP collapse requirements as necessary. Anonymous vmas
>>   		 * were already handled in thp_vma_allowable_orders().
>>   		 */
>> -		if (!forced_collapse &&
>> -		    (!hugepage_global_enabled() || (!(vm_flags & VM_HUGEPAGE) &&
>> -						    !hugepage_global_always())))
>> +		if (!can_thp_collapse_file(vma, vm_flags, forced_collapse))
>>   			return 0;
> 
> I played a bit with that and came up with the following. Not quite happy about
> it, just for your inspiration on naming and what to split out.
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index a00df56a68b57..8ba77608959d4 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -111,6 +111,54 @@ static bool vma_is_special_huge(const struct vm_area_struct
> *vma)
>   	return vma_test_any(vma, VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT);
>   }
> 
> +static bool file_vma_honors_thp_toggles(struct vm_area_struct *vma,> +		enum tva_type type)
> +{
> +	const bool forced_collapse = type == TVA_FORCED_COLLAPSE;
> +
> +	if (forced_collapse)
> +		return false;
> +	/* Huge PFN mappings allocate no folios so the policy doesn't apply. */

So, may be rename the routine to file_vma_thp_policy_applies() ?

> +	return !(vma_test(vma, VMA_PFNMAP_BIT) && vma->vm_ops->huge_fault);
> +}
> +
> +static bool vma_thp_toggles_enabled(struct vm_area_struct *vma,

This routine could use the same 'file_vma_' prefix.

> +		vm_flags_t vm_flags)
> +{
> +	/* THP=always? */
> +	if (hugepage_global_always())
> +		return true;
> +	/* THP=madvise and actually advised? */
> +	return hugepage_global_enabled() && vm_flags & VM_HUGEPAGE;

I would add extra parentheses around 'vm_flags & VM_HUGEPAGE'

> +}
> +
> +static bool file_vma_forces_order_0(struct vm_area_struct *vma,
> +		vm_flags_t vm_flags, enum tva_type type)
> +{
> +	const bool in_pf = type == TVA_PAGEFAULT;
> +	const bool smaps = type == TVA_SMAPS;
> +
> +	/*
> +	 * Enforce THP collapse requirements as necessary. Anonymous vmas
> +	 * were already handled in thp_vma_allowable_orders().
> +	 */
> +
> +	if (file_vma_honors_thp_toggles(vma, type) &&
> +	    !vma_thp_toggles_enabled(vma, vm_flags))
> +		return true;
> +
> +	/*
> +	 * Trust that ->huge_fault() handlers know what they are doing
> +	 * in fault path.
> +	 */
> +	if (((in_pf || smaps)) && vma->vm_ops->huge_fault)

and there remove the extra parentheses.

> +		return false;
> +	/* Only regular file is valid in collapse path */
> +	if (((!in_pf || smaps)) && file_thp_enabled(vma))

there too.

Thanks,

C.

> +		return false;
> +	return true;
> +}
> +
>   unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>   					 vm_flags_t vm_flags,
>   					 enum tva_type type,
> @@ -183,27 +231,8 @@ unsigned long __thp_vma_allowable_orders(struct
> vm_area_struct *vma,
>   						   vma, vma_start_pgoff(vma), 0,
>   						   forced_collapse);
> 
> -	if (!vma_is_anonymous(vma)) {
> -		/*
> -		 * Enforce THP collapse requirements as necessary. Anonymous vmas
> -		 * were already handled in thp_vma_allowable_orders().
> -		 */
> -		if (!forced_collapse &&
> -		    (!hugepage_global_enabled() || (!(vm_flags & VM_HUGEPAGE) &&
> -						    !hugepage_global_always())))
> -			return 0;
> -
> -		/*
> -		 * Trust that ->huge_fault() handlers know what they are doing
> -		 * in fault path.
> -		 */
> -		if (((in_pf || smaps)) && vma->vm_ops->huge_fault)
> -			return orders;
> -		/* Only regular file is valid in collapse path */
> -		if (((!in_pf || smaps)) && file_thp_enabled(vma))
> -			return orders;
> -		return 0;
> -	}
> +	if (!vma_is_anonymous(vma))
> +		return __file_vma_forces_order_0(vma, vm_flags, type) ? 0 : orders;
> 
>   	if (vma_is_temporary_stack(vma))
>   		return 0;
> 

