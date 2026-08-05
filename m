Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857AC35F170
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946898; cv=none; b=nHo7H9LjS44kdQpXiWTAWDndz0zO5EfQuH+xk+ABbAJH8WEEvmFBVvraeJ1t0/PJqoDJJZFFOL0K1b9fVHOI32NzcZ4o0qDApB6J1OCm3Jlp5Gi2ACanzrtVzcksRA7WQYVh0HGqUoZtWfse4wgCPUwtddwDO6ruCiKWN7ef0eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946898; c=relaxed/simple;
	bh=7AzRge3MAx/ljNGPFxwmXz6jrJwbMYw0OdT9ysR7NAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WcNeztBZjyAE5YBEhLen19vnJUKCfQhKLK3Eh/JR5fjU3k3uA3aAAYfM2a8xhL49h1Hw4GivgREXWT3c9qSZ/KuV9pIJ1imcI7zRYlNA40Jhr87UMnPWoB3r/AALxMlvp+lMIHpO+T2Ka1YiTL7YL1PsKbK/7JZnxwSNZ5NP7fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hfIc9tnE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LE4RiWKF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hfIc9tnE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LE4RiWKF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785946895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tizkSZxM4VvXKVuN9JfoqQPAahmETDYIePK/2g8gg9U=;
	b=hfIc9tnE51FNL6WChRV+CofyU3u6Ho2y0ZqVoYDu6pU9dIdnQOEMzv30hGTvKy5ISgbAqJ
	gWgP2kE9TQhiakorV4rboX4Shb83IMGdyb8Pt8lLlxkqx5cX/8ZKROLj9ZDgYnsFV5L3RI
	4t8jeQKzii5Qt1B4dnYLUby2G6MHcW8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-XQJREXY4PCmA2VYAPDhFWQ-1; Wed, 05 Aug 2026 12:21:34 -0400
X-MC-Unique: XQJREXY4PCmA2VYAPDhFWQ-1
X-Mimecast-MFC-AGG-ID: XQJREXY4PCmA2VYAPDhFWQ_1785946893
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f83416551so1044768f8f.3
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 09:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785946893; x=1786551693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tizkSZxM4VvXKVuN9JfoqQPAahmETDYIePK/2g8gg9U=;
        b=LE4RiWKFrax73NOg8TKqoqyEQLFb7i/9YH5UvdusIGCoGNvOBpNJSuOXQmOHa3VeJs
         lRZF6DvM82cH88nLq4z64EbeFW1gcTjwBd6tWiE5oYAAOh6zBMetYgvQJp7SbKYsu5np
         /JcPSs9FN5Jv6lk93dupILu/DdzjUAm+j9dfMhDU50x4pCjSTACHtTPKusz5kzFc4txl
         jD9yKVh3+ZjGoiZvQKFQEJtpVPqPlgGgO2NoXoLP5A1418T/Zne5qOcqNxbh2NW/7klF
         ifbSl9GZ/mEslilC3iSrFCXxxJ/Fxj/sv6Xeyaj0ROsqGkoTYIRDX4rpFyImPErEjfan
         je+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946893; x=1786551693;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tizkSZxM4VvXKVuN9JfoqQPAahmETDYIePK/2g8gg9U=;
        b=RVqMCyGhHYvSKKQFIYsiMOrpcwoT0n9nkymwdvAYjkK1x/Tf4BjDOhPPDZ6h03OQax
         eo/ofkNOnFEZasd1aIclwELLOeakgNmRxaQLIsmuBA8uAO/tsKoXSjIWyF8Qo6Ppvqo2
         GSBbT3vKEVNxxyndTpN/JQ+f9MCkIWlMG7YVC6d92vv48VXpmiqiRX39E+pMZGDyk0eU
         KEPNgjmidZuSmCqKgnf316trY5589rSPS612w1+GV155AehqwclR8IFNjoUA6hHPEmof
         AG9lIXf72xW3y9KL3Nv39ab9jPivZDjM7NsDwARfzKnK95+eWyHN0XmBKYAGYFz/7v9I
         /N+g==
X-Forwarded-Encrypted: i=1; AHgh+RpSm6smTNYzNDyW0NyQ2048fvmeFARdhnuQcqB6xiqpFGoPbO/pzND7/Q4i6PfJdCWWOK7tx2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3kYK3ko71gHWGusLmRDETMGy0MscNPdsg3gPMhRyfdUVpwI7z
	9/BP5ixbr5KZd8AlNwXAJ4Jvha4M0F05MCIIwGCdirrdjn/9bwkNJfZBmPQfH/w4//mxDopDDUj
	jn/IUng/D7sMhZ66Rd6oT73CEcGdrqYrFmPgXXwerbf+7y2X5+7Tam+/gNw==
X-Gm-Gg: AR+sD103B1Qy9ICjDzxZJkQ8JphmN3nSB/+a3mgDi6B1RHaiqvSvQX6POfhbHknzY90
	bbENwiaUUMT0CX8klx6wZplM2+5AmLyQGBQaf4qSa4SrkuShpSD3Lp1g6K06Hf0tTOh7FY+XfKl
	4HoQuP/nMG/qfVAJulRLAFAf7kOaBuZ/pa5otyf4U3DvhMyvRAs60kfvtU7GDf/uCVPrVLuzaaI
	IEoLbwdqTjZCozqFvbKo1lO1ayO7FSms03Q33+M+xXazM8klxRxFnX6eV0KF96zMbIBYfivsyRE
	vQc2R6HODTuKVplsHIXnzjj7aiBCmLdXOufm4DgwhtLgb1Ea4J0N+LM+hAKQeJ2X+C3e3dYk+Zf
	9PCLRAjP7t7P8YzZoSF/he2ZlAjcJFmLC4Ul4rio=
X-Received: by 2002:a05:6000:2486:b0:47f:80df:3ba4 with SMTP id ffacd0b85a97d-47fec62aec8mr13193502f8f.28.1785946892815;
        Wed, 05 Aug 2026 09:21:32 -0700 (PDT)
X-Received: by 2002:a05:6000:2486:b0:47f:80df:3ba4 with SMTP id ffacd0b85a97d-47fec62aec8mr13193399f8f.28.1785946892352;
        Wed, 05 Aug 2026 09:21:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a? ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec231f5csm10142282f8f.23.2026.08.05.09.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 09:21:31 -0700 (PDT)
Message-ID: <4ddc95f2-8868-4be3-9839-e2d14cf35fef@redhat.com>
Date: Wed, 5 Aug 2026 18:21:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: let special huge VMAs bypass the THP
 policy check
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260805055544.1568534-1-clg@redhat.com>
 <anL-NZkNMSSxN0YN@lucifer>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <anL-NZkNMSSxN0YN@lucifer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the quick feedback Lorenzo !
> So I think it should be something more like the attached.
> 
> That way all the handling remains the same and the override is applied in
> the right place plus smaps keeps working.

LGTM, do you want me to respin a v2 with what's below ? or you'd rather
send it yourself.

C.



> ----8<----
>  From d6537260722c8741586e6295c8eea68d06087efa Mon Sep 17 00:00:00 2001
> From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
> Date: Wed, 5 Aug 2026 11:35:13 +0100
> Subject: [PATCH] ideas
> 
> ---
>   mm/huge_memory.c | 32 +++++++++++++++++++++++++++++---
>   1 file changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index abc65d608c23..5fa01364f089 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -111,6 +111,34 @@ static bool vma_is_special_huge(const struct vm_area_struct *vma)
>   	return vma_test_any(vma, VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT);
>   }
> 
> +static bool should_obey_thp_file_tunables(const struct vm_area_struct *vma,
> +					  bool forced_collapse)
> +{
> +	if (forced_collapse)
> +		return false;
> +	VM_WARN_ON_ONCE(vma_is_anonymous(vma));
> +	/* Huge PFN mappings allocate no folios so the policy doesn't apply. */
> +	if (vma_test(vma, VMA_PFNMAP_BIT) && vma->vm_ops->huge_fault)
> +		return false;
> +	return true;
> +}
> +
> +static bool can_thp_collapse_file(const struct vm_area_struct *vma,
> +		vm_flags_t vm_flags, bool forced_collapse)
> +{
> +	/* Override THP tunables? */
> +	if (!should_obey_thp_file_tunables(vma, forced_collapse))
> +		return true;
> +	/* THP=always? */
> +	if (hugepage_global_always())
> +		return true;
> +	/* THP=madvise? */
> +	if (!hugepage_global_enabled())
> +		return false;
> +	/* Has VMA had madvise(..., MADV_HUGEPAGE) applied to it? */
> +	return vm_flags & VM_HUGEPAGE;
> +}
> +
>   unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>   					 vm_flags_t vm_flags,
>   					 enum tva_type type,
> @@ -188,9 +216,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>   		 * Enforce THP collapse requirements as necessary. Anonymous vmas
>   		 * were already handled in thp_vma_allowable_orders().
>   		 */
> -		if (!forced_collapse &&
> -		    (!hugepage_global_enabled() || (!(vm_flags & VM_HUGEPAGE) &&
> -						    !hugepage_global_always())))
> +		if (!can_thp_collapse_file(vma, vm_flags, forced_collapse))
>   			return 0;
> 
>   		/*
> --
> 2.55.0
> 

