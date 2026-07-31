Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9520437E2E5
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785496380; cv=none; b=Ut52z0loVjFftTNS7wc3XhIGySjSS1erPap2aTJfysnS/h4BU7wAWn1GJldNg3FWwmMGqkTiuqwOTaYFCqb5+kaEVsq1diye3MhVlmegPkPD+uO2g65whK4E+YPVFB0aeOLrj4DDXNtUtN41cH+VX0vCKd3lxbkJkkxD8BnRQEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785496380; c=relaxed/simple;
	bh=j7koQZVneRlmLAeGh4b4WYfNlN+1V137UDd96bI4Rmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tSJR9Z1rEgW5jRdPXI5kuRpWWznLz+hhOtkZGS2/LOAL2e8jbEmlNBWnc+xbiqH6XozvAoDk1xIeOdTKX+ugcd/BczHpKDcftahHqPC1YV19wRPA0Em3YNwVV+QK4MxUkt9qfBJdcb9y2ogcuZO5szW3YTJYrYrp7yhURci6hyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gYW+mJmZ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gYW+mJmZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785496379; x=1817032379;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j7koQZVneRlmLAeGh4b4WYfNlN+1V137UDd96bI4Rmk=;
  b=gYW+mJmZ+9aj1/NOEkFQhdf6taLCPGgn30EoJTSdP1eDHm049kbLxdix
   ZaviVtfg0rMc1viIxgUZZsIc/ruZ3LFWCN/pMrofg4MprNHxjoEjeEyCu
   cmeti56vcgSeyVORzaky7Nvtyij2lLzh1uoNxzUWOm4WC3czgmqpsxDxj
   5zh8ZQpBF0gFOMyf3tdoZzNljKqh3L9tiRIVyLQdbNNKriVhJ83A/rC6T
   whDGggAp1c00vZzW9dGupg0uBgn0rO3mfE1Cz2GHETVmg2ucngHsU8g4N
   ZAvOZbbZhKr1ilR1+75Wu1ok/E9dPuwB0bmzFARrnVEXqHFa5wOnyHgKg
   w==;
X-CSE-ConnectionGUID: YHZBXxOtR2er9nrx4YRWyw==
X-CSE-MsgGUID: J/0M8xibRHWY8n3ZlO+aRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="85098100"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="85098100"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 04:12:58 -0700
X-CSE-ConnectionGUID: rv3y0GOjShKEJoYAw+PlSA==
X-CSE-MsgGUID: x7QbJCfPS5SE2XeBSa9w5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="257195083"
Received: from slindbla-desk.ger.corp.intel.com (HELO [10.245.244.78]) ([10.245.244.78])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 04:12:56 -0700
Message-ID: <01d6dac9-a2f9-4551-aaa4-60828d31ae46@intel.com>
Date: Fri, 31 Jul 2026 12:12:54 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] drm/xe/guc_ads: allocate UM queues in a separate
 BO
To: Jia Yao <jia.yao@intel.com>, intel-xe@lists.freedesktop.org
Cc: gwan-gyeong.mun@intel.com, stable@vger.kernel.org
References: <20260722053410.2767369-1-jia.yao@intel.com>
 <20260730232712.517989-1-jia.yao@intel.com>
 <20260730232712.517989-2-jia.yao@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260730232712.517989-2-jia.yao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/07/2026 00:27, Jia Yao wrote:
> xe_guc_ads_populate() calls xe_map_memset() on the ADS BO on every GT
> reset.  The UM queue ring buffers were embedded in that same BO, so the
> memset discards fault descriptors already written by the GPU, causing
> GuC to forward an all-zero descriptor (Faulted Address = 0, ASID = 0).
> 
> Move the UM queue ring buffers into a dedicated BO so they are not
> affected by the ADS memset.
> 
> On pre-Xe3p platforms GAM accesses the UM queue ring via base_dpa, which
> must be a contiguous DMA address range.  Round the allocation size up to
> the next power of two so that the TTM pool issues a single order-N
> alloc_pages() call, maximising the chance of physical contiguity.  Verify
> the result with drm_prime_get_contiguous_size() and fail gracefully if
> the pages are non-contiguous.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")

As per the last revision, I think we can just do:

Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
Cc: <stable@vger.kernel.org> # v6.12+

LNL was the first production part we supported. Also since the last 
patch will need a recent-ish tag for the UC feature, and I think best 
have all three commits with the same tag.

> Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jia Yao <jia.yao@intel.com>

For next time, it's best to also put the changelog accross revisions in 
each commit, which makes things a bit easier for reviewers.

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   drivers/gpu/drm/xe/xe_guc.c           |  6 ++
>   drivers/gpu/drm/xe/xe_guc_ads.c       | 96 ++++++++++++++++++---------
>   drivers/gpu/drm/xe/xe_guc_ads_types.h |  5 ++
>   3 files changed, 75 insertions(+), 32 deletions(-)
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
> index f0ac00586d3a..3b6e1c45a0e9 100644
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
> @@ -461,6 +442,51 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
>   
>   	ads->bo = bo;
>   
> +	if (xe->info.has_usm) {
> +		/*
> +		 * Allocate a separate BO for the HW fault ring (UM queues).
> +		 *
> +		 * xe_guc_ads_populate() clears the entire ADS BO via
> +		 * xe_map_memset() on every GT reset.  Keeping the UM queues
> +		 * in a dedicated BO prevents that memset from discarding fault
> +		 * descriptors the GPU has already written into the ring,
> +		 * which would cause GuC to forward an all-zero descriptor to
> +		 * the driver (Faulted Address = 0, ASID = 0).
> +		 *
> +		 * Round the size up to the next power of two so that on iGPU
> +		 * (system memory, no IOMMU) the TTM pool issues a single
> +		 * alloc_pages(order=N) call, maximising the chance of getting
> +		 * a physically contiguous block.  GuC requires contiguous DPA.
> +		 */
> +		size_t um_size = roundup_pow_of_two(GUC_UM_QUEUE_SIZE *
> +						    GUC_UM_HW_QUEUE_MAX);
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
> @@ -893,7 +919,7 @@ static void guc_mmio_reg_state_init(struct xe_guc_ads *ads)
>   
>   static void guc_um_init_params(struct xe_guc_ads *ads)
>   {
> -	u32 um_queue_offset = guc_ads_um_queues_offset(ads);
> +	struct xe_bo *um_bo = ads->um_queue_bo;
>   	struct xe_guc *guc = ads_to_guc(ads);
>   	struct xe_device *xe = ads_to_xe(ads);
>   	u64 base_dpa;
> @@ -903,8 +929,14 @@ static void guc_um_init_params(struct xe_guc_ads *ads)
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

