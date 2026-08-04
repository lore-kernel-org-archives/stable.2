Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AEA420476
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 07:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785829506; cv=none; b=E1NYrfspLVpqQtjmS1EKgNABV9oQi70q6zTp3Qwc6bJ03WY7eEZvvvU/ifZtmIlHMkd3ELeY05ZQxl0EapeytV1MgiGL4W5BMYbEFoqMgaRy4KjzoM55Q5aVxKNETzeJ8z97DYG1KkSbeMiN/h0D/DcaAc07Y/tIEkHhLFXovvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785829506; c=relaxed/simple;
	bh=nvZE4Mbhz8nTAbWQzdY2uVuWIS51H8tSEWLAueBhUWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQV1Aml2opPXmMl8rQi6sMtHPjE+MZp+C5o9afIY2zjI1g0cJm1ruSjzt3u3o+qhfVFjEFrFzduU5ikSqeoZnG0VvMr3l8lXjQcYe7z4jqWa+TO272ouw4qT0ZT3LXXRkGOQFEtWtxeW4gBIXVee28d3OnL70NgVLkZHXnuF//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bOJ3/Nsb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bOJ3/Nsb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785829505; x=1817365505;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nvZE4Mbhz8nTAbWQzdY2uVuWIS51H8tSEWLAueBhUWs=;
  b=bOJ3/NsbTl5yTdaGVYY/ctyGswmQg6gf3qqueWFobeJN/j7iqamh6lTl
   Nm2QCCaMbzG8jYRqHV70RuxvZSZyAMVqP6d8cy5d6eb/g/kNofqMozwrv
   wFKUEY+szbvz6XOh6ylrSYxMtlH0bJDJZveq5k6rguc2U3riJlBwc7eRf
   pQatCgj5pZ+tbdW/1CzowBUdeZUYQ2P6oamW/bpBFgYn3Rkp9ID+Nb+hy
   UetnyoDsAiC6fepDkDZ1qxRVk1svfmZWEOmk0C/QdPfw/MBiBI2nTPjpu
   ArdbMB7DKMwC+WZlJhc5Sw5fiHybDaWdB7WUqL50MnHXIwZD3BWZAgqgm
   w==;
X-CSE-ConnectionGUID: YFzWwx+YS9iHjAs++6oSyw==
X-CSE-MsgGUID: +NwgY/tMRR6BXv/Q+z4DGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86384843"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86384843"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 00:45:04 -0700
X-CSE-ConnectionGUID: zjQ6RqPOQye59oiSRhXFGQ==
X-CSE-MsgGUID: bVFhWKaNR96qWHtvDXAe6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="264933909"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.172]) ([10.245.245.172])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 00:45:03 -0700
Message-ID: <0a0db7a1-a3ad-45a3-9b59-723d539fbe88@intel.com>
Date: Tue, 4 Aug 2026 08:45:00 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] drm/xe/guc_ads: allocate UM queues in VRAM on dGFX
To: Jia Yao <jia.yao@intel.com>, intel-xe@lists.freedesktop.org
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>, stable@vger.kernel.org
References: <20260803200838.98826-1-jia.yao@intel.com>
 <20260803200838.98826-3-jia.yao@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260803200838.98826-3-jia.yao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/08/2026 21:08, Jia Yao wrote:
> On iGPU, the UM queue BO is allocated in system memory. On dGFX, the BO
> was previously created in system memory and later reallocated in
> xe_guc_realloc_post_hwconfig().  Allocate the UM queue BO directly in
> VRAM on dGFX, where it is ultimately required.
> 
> Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
> Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: <stable@vger.kernel.org> # v6.12+
> Signed-off-by: Jia Yao <jia.yao@intel.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>


> ---
>   drivers/gpu/drm/xe/xe_guc.c     |  6 ------
>   drivers/gpu/drm/xe/xe_guc_ads.c | 17 ++++++++++-------
>   2 files changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
> index 4f132bf8539d..4286bd05c686 100644
> --- a/drivers/gpu/drm/xe/xe_guc.c
> +++ b/drivers/gpu/drm/xe/xe_guc.c
> @@ -732,12 +732,6 @@ static int xe_guc_realloc_post_hwconfig(struct xe_guc *guc)
>   	if (ret)
>   		return ret;
>   
> -	if (guc->ads.um_queue_bo) {
> -		ret = xe_managed_bo_reinit_in_vram(xe, tile, &guc->ads.um_queue_bo);
> -		if (ret)
> -			return ret;
> -	}
> -
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
> index ef8e9cc35c8c..a69ec584cc0f 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ads.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
> @@ -446,19 +446,22 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
>   		/*
>   		 * Allocate a separate BO for the HW fault ring (UM queues).
>   		 *
> -		 * Round the size up to the next power of two so that
> +		 * Round the size up to the next power of two so that on iGPU
>   		 * (system memory, no IOMMU) the TTM pool issues a single
>   		 * alloc_pages(order=N) call, maximising the chance of getting
>   		 * a physically contiguous block.  GuC requires contiguous DPA.
>   		 */
> -		size_t um_size = roundup_pow_of_two(GUC_UM_QUEUE_SIZE *
> +		size_t um_size = IS_DGFX(xe) ?
> +				 GUC_UM_QUEUE_SIZE * GUC_UM_HW_QUEUE_MAX :
> +				 roundup_pow_of_two(GUC_UM_QUEUE_SIZE *
>   						    GUC_UM_HW_QUEUE_MAX);
>   
> -		bo = xe_managed_bo_create_pin_map(xe, tile, um_size,
> -						  XE_BO_FLAG_SYSTEM |
> -						  XE_BO_FLAG_GGTT |
> -						  XE_BO_FLAG_GGTT_INVALIDATE |
> -						  XE_BO_FLAG_PINNED_NORESTORE);
> +		u32 um_flags = XE_BO_FLAG_VRAM_IF_DGFX(tile) |
> +			       XE_BO_FLAG_GGTT |
> +			       XE_BO_FLAG_GGTT_INVALIDATE |
> +			       XE_BO_FLAG_PINNED_NORESTORE;
> +
> +		bo = xe_managed_bo_create_pin_map(xe, tile, um_size, um_flags);
>   		if (IS_ERR(bo))
>   			return PTR_ERR(bo);
>   

