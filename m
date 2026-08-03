Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D537D2848AA
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753243; cv=none; b=T/HNk7Ud8VtYg690HbR7W3NBioc396de3rLqUYFjj6O+iuREWOOGRg/sIdNqYy7nRSGrpkcEHnmXUMQ+FAMDSO01DrhM71vuZfv8BdnlrVyzbsRkb9r0MZ1ipC8eS+OF6su88/083MYHI7Jz8zryxJ7Rv6o8KD3NoPOJ16ST6Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753243; c=relaxed/simple;
	bh=uykY8r9B54oJs3WhicX8D2dSjTZf8770X/PAW2GBqRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kV+xWF0m5s8FFnFg1AGvQFwEUnGrV5MilarGb92+EongR0xRnKC5nnsJC/uDThx6OeBMVVOgaeM7ThaQdtSQKvcOa3v4Es3a7L+EeRmL7x2DTv11v32txgis8ZP8zEaN5SR/o9ivcaF9wFMUjQDX0CL7YxcQ1a0m1JCXUDnOn1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iPyWl/jm; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iPyWl/jm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785753241; x=1817289241;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uykY8r9B54oJs3WhicX8D2dSjTZf8770X/PAW2GBqRo=;
  b=iPyWl/jmwJ6dZPs1cnZi4HLdiz6Mc6LhG6nD8aPGpqO5OQd91L+a9XN8
   ssbOMXXT705kOq3GDSkuv+dHxYwB5zbgMKqcdgZZ1JdmFK4Yut6w7XXJm
   cGogXC9SuNlBDVq9mk/xyFC085CIg9cGfPW9FZs2e07fUwZblCZwUFRrl
   FZY7QEk7vQPmBQD4g2N3qYmIl6FvXI0jA74WlVsYaByekTcGnNNcxcpof
   bkKF23a7g73B792+WxlP9YZ8EgxCfhxwOCY9vnbvFwRPZRp31jHvJD1gz
   WAeU9OBNn1iEJIxJNiVE+NhoUWqN2vFW00VuS001vkwJT+SzDUjzzrQDO
   g==;
X-CSE-ConnectionGUID: cbvV7PT6R5mdNd/ygzF/HA==
X-CSE-MsgGUID: RtNd7Y1mS1C31mmOqZZxvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="96646554"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="96646554"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 03:34:00 -0700
X-CSE-ConnectionGUID: 8/70OJjVR/Og5XXSjCUceA==
X-CSE-MsgGUID: hlSC6oXVRoa3bHwbn10uRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="254907638"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO [10.245.245.45]) ([10.245.245.45])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 03:30:22 -0700
Message-ID: <b0765ccb-0460-4561-9fde-b9ad2de299f3@intel.com>
Date: Mon, 3 Aug 2026 11:30:20 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] drm/xe/guc_ads: allocate UM queues in a separate
 BO
To: Jia Yao <jia.yao@intel.com>, intel-xe@lists.freedesktop.org
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>, stable@vger.kernel.org
References: <20260731232232.548015-1-jia.yao@intel.com>
 <20260731232232.548015-2-jia.yao@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260731232232.548015-2-jia.yao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/08/2026 00:22, Jia Yao wrote:
> Move the UM queues into a dedicated UC BO (ads->um_queue_bo) and avoid
> CPU memset operations on it, which eliminates the CPU as a potential
> cacheline-polluting agent and helps maintain consistency between GAM
> writes and GuC reads.
> 
> Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
> Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: <stable@vger.kernel.org> # v6.12+
> Signed-off-by: Jia Yao <jia.yao@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_guc.c           |  6 ++
>   drivers/gpu/drm/xe/xe_guc_ads.c       | 91 +++++++++++++++++----------
>   drivers/gpu/drm/xe/xe_guc_ads_types.h |  5 ++
>   3 files changed, 70 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
> index 4286bd05c686..4f132bf8539d 100644
> --- a/drivers/gpu/drm/xe/xe_guc.c
> +++ b/drivers/gpu/drm/xe/xe_guc.c
> @@ -732,6 +732,12 @@ static int xe_guc_realloc_post_hwconfig(struct xe_guc *guc)
>   	if (ret)
>   		return ret;
>   
> +	if (guc->ads.um_queue_bo) {
> +		ret = xe_managed_bo_reinit_in_vram(xe, tile, &guc->ads.um_queue_bo);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
> index f0ac00586d3a..46c4d702d1f3 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ads.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
> @@ -8,6 +8,7 @@
>   #include <linux/fault-inject.h>
>   
>   #include <drm/drm_managed.h>
> +#include <drm/drm_prime.h>
>   
>   #include <generated/xe_wa_oob.h>
>   
> @@ -64,10 +65,14 @@ ads_to_map(struct xe_guc_ads *ads)
>   
>   /*
>    * The Additional Data Struct (ADS) has pointers for different buffers used by
> - * the GuC. One single gem object contains the ADS struct itself (guc_ads) and
> - * all the extra buffers indirectly linked via the ADS struct's entries.
> + * the GuC. One gem object (ads->bo) contains the ADS struct itself (guc_ads)
> + * and most of the extra buffers linked via the ADS struct's entries.  The UM
> + * fault queues (PAGE_FAULT, PAGE_FAULT_RESPONSE, ACCESS_COUNTER rings) are
> + * kept in a separate BO (ads->um_queue_bo) so that the full memset of ads->bo
> + * performed on every GT reset does not discard fault descriptors already
> + * written into the rings by the GPU.
>    *
> - * Layout of the ADS blob allocated for the GuC:
> + * Layout of the ADS blob (ads->bo):
>    *
>    *      +---------------------------------------+ <== base
>    *      | guc_ads                               |
> @@ -99,10 +104,6 @@ ads_to_map(struct xe_guc_ads *ads)
>    *      +---------------------------------------+
>    *      | padding                               |
>    *      +---------------------------------------+ <== 4K aligned
> - *      | UM queues                             |
> - *      +---------------------------------------+
> - *      | padding                               |
> - *      +---------------------------------------+ <== 4K aligned
>    *      | private data                          |
>    *      +---------------------------------------+
>    *      | padding                               |
> @@ -156,16 +157,6 @@ static size_t guc_ads_capture_size(struct xe_guc_ads *ads)
>   	return PAGE_ALIGN(ads->capture_size);
>   }
>   
> -static size_t guc_ads_um_queues_size(struct xe_guc_ads *ads)
> -{
> -	struct xe_device *xe = ads_to_xe(ads);
> -
> -	if (!xe->info.has_usm)
> -		return 0;
> -
> -	return GUC_UM_QUEUE_SIZE * GUC_UM_HW_QUEUE_MAX;
> -}
> -
>   static size_t guc_ads_private_data_size(struct xe_guc_ads *ads)
>   {
>   	return PAGE_ALIGN(ads_to_guc(ads)->fw.private_data_size);
> @@ -206,22 +197,12 @@ static size_t guc_ads_capture_offset(struct xe_guc_ads *ads)
>   	return PAGE_ALIGN(offset);
>   }
>   
> -static size_t guc_ads_um_queues_offset(struct xe_guc_ads *ads)
> -{
> -	u32 offset;
> -
> -	offset = guc_ads_capture_offset(ads) +
> -		 guc_ads_capture_size(ads);
> -
> -	return PAGE_ALIGN(offset);
> -}
> -
>   static size_t guc_ads_private_data_offset(struct xe_guc_ads *ads)
>   {
>   	size_t offset;
>   
> -	offset = guc_ads_um_queues_offset(ads) +
> -		guc_ads_um_queues_size(ads);
> +	offset = guc_ads_capture_offset(ads) +
> +		guc_ads_capture_size(ads);
>   
>   	return PAGE_ALIGN(offset);
>   }
> @@ -461,6 +442,46 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
>   
>   	ads->bo = bo;
>   
> +	if (xe->info.has_usm) {
> +		/*
> +		 * Allocate a separate BO for the HW fault ring (UM queues).
> +		 *
> +		 * Round the size up to the next power of two so that on iGPU
> +		 * (system memory, no IOMMU) the TTM pool issues a single
> +		 * alloc_pages(order=N) call, maximising the chance of getting
> +		 * a physically contiguous block.  GuC requires contiguous DPA.
> +		 */
> +		size_t um_size = IS_DGFX(xe) ?
> +				 GUC_UM_QUEUE_SIZE * GUC_UM_HW_QUEUE_MAX :
> +				 roundup_pow_of_two(GUC_UM_QUEUE_SIZE *
> +						    GUC_UM_HW_QUEUE_MAX);

I think the suggestion was to put this into patch 2, otherwise at this 
point it is still in system memory so would still need the roundup even 
on dgpu.

> +
> +		bo = xe_managed_bo_create_pin_map(xe, tile, um_size,
> +						  XE_BO_FLAG_SYSTEM |
> +						  XE_BO_FLAG_GGTT |
> +						  XE_BO_FLAG_GGTT_INVALIDATE |
> +						  XE_BO_FLAG_PINNED_NORESTORE);
> +		if (IS_ERR(bo))
> +			return PTR_ERR(bo);
> +
> +		/*
> +		 * On pre-Xe3p platforms, GAM (not GuC) accesses the UM queue
> +		 * ring via base_dpa, which must be a contiguous DMA address
> +		 * range.  Verify that the allocated pages are contiguous in
> +		 * DMA address space.
> +		 */
> +		if (xe_bo_sg(bo) &&
> +		    !xe_guc_using_main_gamctrl_queues(ads_to_guc(ads)) &&
> +		    unlikely(drm_prime_get_contiguous_size(xe_bo_sg(bo)) <
> +			     GUC_UM_QUEUE_SIZE * GUC_UM_HW_QUEUE_MAX)) {
> +			drm_err(&xe->drm,
> +				"UM fault queue memory is not contiguous in DMA address space; GAM requires contiguous DPA\n");
> +			return -ENOMEM;
> +		}
> +
> +		ads->um_queue_bo = bo;
> +	}
> +
>   	return 0;
>   }
>   ALLOW_ERROR_INJECTION(xe_guc_ads_init, ERRNO); /* See xe_pci_probe() */
> @@ -893,7 +914,7 @@ static void guc_mmio_reg_state_init(struct xe_guc_ads *ads)
>   
>   static void guc_um_init_params(struct xe_guc_ads *ads)
>   {
> -	u32 um_queue_offset = guc_ads_um_queues_offset(ads);
> +	struct xe_bo *um_bo = ads->um_queue_bo;
>   	struct xe_guc *guc = ads_to_guc(ads);
>   	struct xe_device *xe = ads_to_xe(ads);
>   	u64 base_dpa;
> @@ -903,8 +924,14 @@ static void guc_um_init_params(struct xe_guc_ads *ads)
>   
>   	with_dpa = !xe_guc_using_main_gamctrl_queues(guc);
>   
> -	base_ggtt = xe_bo_ggtt_addr(ads->bo) + um_queue_offset;
> -	base_dpa = xe_bo_main_addr(ads->bo, PAGE_SIZE) + um_queue_offset;
> +	if (um_bo) {
> +		/* All USM platforms: UM queues in dedicated um_queue_bo */
> +		base_ggtt = xe_bo_ggtt_addr(um_bo);
> +		base_dpa = xe_bo_main_addr(um_bo, PAGE_SIZE);
> +	} else {
> +		/* Platform does not support USM: no UM queues, nothing to do */
> +		return;
> +	}
>   
>   	for (i = 0; i < GUC_UM_HW_QUEUE_MAX; ++i) {
>   		/*
> diff --git a/drivers/gpu/drm/xe/xe_guc_ads_types.h b/drivers/gpu/drm/xe/xe_guc_ads_types.h
> index 48a8e092023f..845c1fbd93a4 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ads_types.h
> +++ b/drivers/gpu/drm/xe/xe_guc_ads_types.h
> @@ -16,6 +16,11 @@ struct xe_bo;
>   struct xe_guc_ads {
>   	/** @bo: Xe BO for GuC ads blob */
>   	struct xe_bo *bo;
> +	/**
> +	 * @um_queue_bo: Dedicated BO for the HW fault ring (UM queues).
> +	 * NULL if the platform does not support USM.
> +	 */
> +	struct xe_bo *um_queue_bo;
>   	/** @golden_lrc_size: golden LRC size */
>   	size_t golden_lrc_size;
>   	/** @regset_size: size of register set passed to GuC for save/restore */

