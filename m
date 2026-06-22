Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73447270EC3
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139472; cv=none; b=TGwH06cC1gfYb0ZpaHVG7/EcidRUeqDXkVRvcCTSYw060h9sxXnPdYMYtcDvsePvPK8dCEs7jHwDDNBMqQKsKQ1ywOQPkOrku71Zggm9fdeupS10GiMi/xfZTUvkWeuVGYpj0bNwjgjwhIXCIMZ8j3TB0R9CBopjVeRNjEXMNn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139472; c=relaxed/simple;
	bh=SXAT9iR8fgMl4hnb97zZeOWs16cDRbwBUGNnqc6ffWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hH/HN+0sD8sIGGJTwdg9DUjnGyDVrkHoUDAXqXVwrnr+RlVJMPVPpvFbvXGuOPM/hQf1nUEYu4INEdGpFVY1104QsrSyfYLy0S6UmvPb8CyMUZgy1JJqyd3oawE85nL4aP5iOjwjqY9Mqw5+kgPguYKaW4hQ3u2EjcEzzDUrd3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VOl8Ph1D; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VOl8Ph1D"
Message-ID: <bae77c2d-117e-4344-91cd-ab9d5293c605@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782139469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5GpC/58OIjPW5VUdg3/lmsNA+ApTm9doUWXBLX0N1fY=;
	b=VOl8Ph1DZdilhTcZXNLqhnjlYI0B8CCAfUVYmd3MpweWipJrtmwv69CSLaXG8x4/kLUavF
	H6C+4GX180ccjbkalabMfKh56X8K0O8Hw583aKpWsxh6SBM5pNzVuGB3dPWEiw7+x+y5GI
	xHaSBW/3/LoztTgGrTbJDIPbRRav/HE=
Date: Mon, 22 Jun 2026 22:44:17 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/page_vma_mapped: revalidate and do proper check before
 return device-private pmd
To: Lorenzo Stoakes <ljs@kernel.org>, Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, riel@surriel.com,
 liam@infradead.org, vbabka@kernel.org, harry@kernel.org, jannh@google.com,
 sj@kernel.org, ziy@nvidia.com, balbirs@nvidia.com, linux-mm@kvack.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260622130651.23359-1-richard.weiyang@gmail.com>
 <ajk0N3Aekapljaoh@lucifer>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <ajk0N3Aekapljaoh@lucifer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/6/22 21:46, Lorenzo Stoakes wrote:
> +cc Lance, linux-kernel

Thanks for the cc.

[...]

> 
> ----8<----
>  From e6a3c1c782714ed831c4d46a14bb99226423bf59 Mon Sep 17 00:00:00 2001
> From: Wei Yang <richard.weiyang@gmail.com>
> Date: Mon, 22 Jun 2026 13:06:51 +0000
> Subject: [PATCH] refactored
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> ---
>   mm/page_vma_mapped.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 2ccbabfb2cc1..17dff8aab9f9 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -269,14 +269,24 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>   			/* THP pmd was split under us: handle on pte level */
>   			spin_unlock(pvmw->ptl);
>   			pvmw->ptl = NULL;
> -		} else if (!pmd_present(pmde)) {
> -			const softleaf_t entry = softleaf_from_pmd(pmde);
> +		} else if (pmd_is_device_private_entry(pmde)) {
> +			softleaf_t entry;
> +
> +			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
> +			pmde = *pvmw->pmd;
> +			entry = softleaf_from_pmd(pmde);
> 
> -			if (softleaf_is_device_private(entry)) {
> -				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
> +			if (likely(softleaf_is_device_private(entry))) {
> +				if (pvmw->flags & PVMW_MIGRATION)
> +					return not_found(pvmw);
> +				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
> +					return not_found(pvmw);
>   				return true;
>   			}
> -
> +			/* device-private pmd was split under us: handle on pte level */
> +			spin_unlock(pvmw->ptl);
> +			pvmw->ptl = NULL;
> +		} else if (!pmd_present(pmde)) {
>   			if ((pvmw->flags & PVMW_SYNC) &&
>   			    thp_vma_suitable_order(vma, pvmw->address,
>   						   PMD_ORDER) &&
> --
> 2.54.0

Cool, looks way cleaner :) Nothing jumped out at me :)

Cheers, Lance
