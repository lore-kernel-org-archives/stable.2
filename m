Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5704334B2
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785834974; cv=none; b=aTKySz4LNt/aylNTYVxI8eV2a/eC40FJFpswuojdVh/YGC5QDcEUKXVErD+WNZX5qnsPCkM9+zd2wS71ykwFZld+cnCi0SqHOZDsRqApgL70bHiYpzawAid8vKuTbHWvVvr5xSebBYZi94Uo82WJrf1nNcHz3MGS9xdt20oxrCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785834974; c=relaxed/simple;
	bh=5QlIOjC6Jpbo66snd/FfKofyDqbOGgkcgpZFX8XSXUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I6Z/vP8EPmB/G/3LsEsuxJxvXGcoB/WCVFdGwwS8gKRkSTaXFGx7U6d3MOb9Lwyy4x6sskwKQ0t2z1jlOjqOIALZZ/9tPQdSEAAQffVv8dDddDT3LsCCOIdL1eTgjeIMvYgU1SD7+4w8geGe9S+mOmGRw6/IDYn7GTqqoCGm3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kj+EQeHb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kj+EQeHb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785834971; x=1817370971;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5QlIOjC6Jpbo66snd/FfKofyDqbOGgkcgpZFX8XSXUg=;
  b=kj+EQeHbrulDz3cNjJeD5fQTbIoawyv6lJDdwEW3ZuPjsNVgM2P2MXkH
   Uam3IQmWwBgHpcRaQF9GaUsYLTtPsxPIHQ3xb4liuKKg43RSSA/z2SIyp
   rlCNpLio93mPIxnstkXP8rdThqD+AHUcRButpxhT5aCWrTG8mExTTT3OF
   WsDjcRP1l/uhywbFrNShf+sO2FSsid3BMZLJsCTvGCiYDxaZhwRoS4Jty
   CFt+GhU4deI3tT2V3+9JCgh07oSNEKo8vztjbVE+QjU8JzrSgKMtMOK23
   LHT0xWE9Uz5jegBrdkr7RRydrREQsujS87YiqGJro8gTorV3G53LpCFaZ
   A==;
X-CSE-ConnectionGUID: bclInkMBQdWC/tzTAXSmqg==
X-CSE-MsgGUID: GE874pgbQrqRERLVV8Xb8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86391847"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86391847"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 02:16:10 -0700
X-CSE-ConnectionGUID: UyAyMfkgQfW0GCjtyswHQA==
X-CSE-MsgGUID: xx6z0YvnTVSRHq+4pFSVoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="257126725"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.172]) ([10.245.245.172])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 02:16:09 -0700
Message-ID: <23d6d8e8-a885-4bed-8384-d2b0b8dc5e11@intel.com>
Date: Tue, 4 Aug 2026 10:16:07 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] drm/xe/guc_ads: allocate UM queues in a separate
 BO
To: Matthew Brost <matthew.brost@intel.com>
Cc: Jia Yao <jia.yao@intel.com>, intel-xe@lists.freedesktop.org,
 Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>, stable@vger.kernel.org
References: <20260803200838.98826-1-jia.yao@intel.com>
 <20260803200838.98826-2-jia.yao@intel.com>
 <fff60c87-460c-4713-a65a-e9c3841bbf2b@intel.com>
 <anGo2nE/j1QUKE0J@gsse-cloud1.jf.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <anGo2nE/j1QUKE0J@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/08/2026 09:54, Matthew Brost wrote:
> On Tue, Aug 04, 2026 at 09:00:19AM +0100, Matthew Auld wrote:
>> On 03/08/2026 21:08, Jia Yao wrote:
>>> Move the UM queues into a dedicated UC BO (ads->um_queue_bo) and avoid
>>> CPU memset operations on it, which eliminates the CPU as a potential
>>> cacheline-polluting agent and helps maintain consistency between GAM
>>> writes and GuC reads.
>>>
>>> Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
>>> Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>> Cc: <stable@vger.kernel.org> # v6.12+
>>> Signed-off-by: Jia Yao <jia.yao@intel.com>
>>> ---
>>>    drivers/gpu/drm/xe/xe_guc.c           |  6 ++
>>>    drivers/gpu/drm/xe/xe_guc_ads.c       | 89 +++++++++++++++++----------
>>>    drivers/gpu/drm/xe/xe_guc_ads_types.h |  5 ++
>>>    3 files changed, 68 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
>>> index 4286bd05c686..4f132bf8539d 100644
>>> --- a/drivers/gpu/drm/xe/xe_guc.c
>>> +++ b/drivers/gpu/drm/xe/xe_guc.c
>>> @@ -732,6 +732,12 @@ static int xe_guc_realloc_post_hwconfig(struct xe_guc *guc)
>>>    	if (ret)
>>>    		return ret;
> 
> Add a newline here.
> 
>>> +	if (guc->ads.um_queue_bo) {
>>> +		ret = xe_managed_bo_reinit_in_vram(xe, tile, &guc->ads.um_queue_bo);
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>> +
>>>    	return 0;
>>>    }
>>> diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
>>> index f0ac00586d3a..ef8e9cc35c8c 100644
>>> --- a/drivers/gpu/drm/xe/xe_guc_ads.c
>>> +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
>>> @@ -8,6 +8,7 @@
>>>    #include <linux/fault-inject.h>
>>>    #include <drm/drm_managed.h>
>>> +#include <drm/drm_prime.h>
>>>    #include <generated/xe_wa_oob.h>
>>> @@ -64,10 +65,14 @@ ads_to_map(struct xe_guc_ads *ads)
>>>    /*
>>>     * The Additional Data Struct (ADS) has pointers for different buffers used by
>>> - * the GuC. One single gem object contains the ADS struct itself (guc_ads) and
>>> - * all the extra buffers indirectly linked via the ADS struct's entries.
>>> + * the GuC. One gem object (ads->bo) contains the ADS struct itself (guc_ads)
>>> + * and most of the extra buffers linked via the ADS struct's entries.  The UM
>>> + * fault queues (PAGE_FAULT, PAGE_FAULT_RESPONSE, ACCESS_COUNTER rings) are
>>> + * kept in a separate BO (ads->um_queue_bo) so that the full memset of ads->bo
>>> + * performed on every GT reset does not discard fault descriptors already
>>> + * written into the rings by the GPU.
>>>     *
>>> - * Layout of the ADS blob allocated for the GuC:
>>> + * Layout of the ADS blob (ads->bo):
>>>     *
>>>     *      +---------------------------------------+ <== base
>>>     *      | guc_ads                               |
>>> @@ -99,10 +104,6 @@ ads_to_map(struct xe_guc_ads *ads)
>>>     *      +---------------------------------------+
>>>     *      | padding                               |
>>>     *      +---------------------------------------+ <== 4K aligned
>>> - *      | UM queues                             |
>>> - *      +---------------------------------------+
>>> - *      | padding                               |
>>> - *      +---------------------------------------+ <== 4K aligned
>>>     *      | private data                          |
>>>     *      +---------------------------------------+
>>>     *      | padding                               |
>>> @@ -156,16 +157,6 @@ static size_t guc_ads_capture_size(struct xe_guc_ads *ads)
>>>    	return PAGE_ALIGN(ads->capture_size);
>>>    }
>>> -static size_t guc_ads_um_queues_size(struct xe_guc_ads *ads)
>>> -{
>>> -	struct xe_device *xe = ads_to_xe(ads);
>>> -
>>> -	if (!xe->info.has_usm)
>>> -		return 0;
>>> -
>>> -	return GUC_UM_QUEUE_SIZE * GUC_UM_HW_QUEUE_MAX;
>>> -}
>>> -
>>>    static size_t guc_ads_private_data_size(struct xe_guc_ads *ads)
>>>    {
>>>    	return PAGE_ALIGN(ads_to_guc(ads)->fw.private_data_size);
>>> @@ -206,22 +197,12 @@ static size_t guc_ads_capture_offset(struct xe_guc_ads *ads)
>>>    	return PAGE_ALIGN(offset);
>>>    }
>>> -static size_t guc_ads_um_queues_offset(struct xe_guc_ads *ads)
>>> -{
>>> -	u32 offset;
>>> -
>>> -	offset = guc_ads_capture_offset(ads) +
>>> -		 guc_ads_capture_size(ads);
>>> -
>>> -	return PAGE_ALIGN(offset);
>>> -}
>>> -
>>>    static size_t guc_ads_private_data_offset(struct xe_guc_ads *ads)
>>>    {
>>>    	size_t offset;
>>> -	offset = guc_ads_um_queues_offset(ads) +
>>> -		guc_ads_um_queues_size(ads);
>>> +	offset = guc_ads_capture_offset(ads) +
>>> +		guc_ads_capture_size(ads);
>>>    	return PAGE_ALIGN(offset);
>>>    }
>>> @@ -461,6 +442,44 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
>>>    	ads->bo = bo;
>>> +	if (xe->info.has_usm) {
>>> +		/*
>>> +		 * Allocate a separate BO for the HW fault ring (UM queues).
>>> +		 *
>>> +		 * Round the size up to the next power of two so that
>>> +		 * (system memory, no IOMMU) the TTM pool issues a single
>>> +		 * alloc_pages(order=N) call, maximising the chance of getting
>>> +		 * a physically contiguous block.  GuC requires contiguous DPA.
>>> +		 */
>>> +		size_t um_size = roundup_pow_of_two(GUC_UM_QUEUE_SIZE *
>>> +						    GUC_UM_HW_QUEUE_MAX);
>>> +
>>> +		bo = xe_managed_bo_create_pin_map(xe, tile, um_size,
>>> +						  XE_BO_FLAG_SYSTEM |
>>> +						  XE_BO_FLAG_GGTT |
>>> +						  XE_BO_FLAG_GGTT_INVALIDATE |
>>> +						  XE_BO_FLAG_PINNED_NORESTORE);
>>> +		if (IS_ERR(bo))
>>> +			return PTR_ERR(bo);
>>> +
>>> +		/*
>>> +		 * On pre-Xe3p platforms, GAM (not GuC) accesses the UM queue
>>> +		 * ring via base_dpa, which must be a contiguous DMA address
>>> +		 * range.  Verify that the allocated pages are contiguous in
>>> +		 * DMA address space.
>>> +		 */
>>> +		if (xe_bo_sg(bo) &&
>>
>>
>> There is a comment from Sashiko that there might not be a valid tt for vram
>> buffers, so perhaps just make this check !xe_bo_is_vram() instead?
>>
>>> +		    !xe_guc_using_main_gamctrl_queues(ads_to_guc(ads)) &&
>>> +		    unlikely(drm_prime_get_contiguous_size(xe_bo_sg(bo)) <
> 
> Using drm_prime_* really is the wrong layering. Either this helper
> should be some drm or sg generic or IMO we implement this helper
> ourselves until we have a proper one in drm or sg generic.
> 
> e.g., for SG specific BOs, something like this should work.
> 
> xe_bo_sg_is_contigous(struct xe_bo *bo)
> {
> 	struct xe_res_cursor cur;
> 
> 	xe_assert(xe_bo_device(bo), xe_bo_sg(bo));
> 	xe_res_first_sg(xe_bo_sg(bo), 0, xe_bo_size(bo), &cur);
> 
> 	return cur.size == xe_bo_size(bo);
> }

AFAICT I don't think it's the same since you could potentially get 
multiple sg entries underneath, where they still occupy something contig 
as a whole, and xe_res_first_sg() doesn't try to coalesce. Maybe it 
should? The !xe_bo_sg_is_contigous() will be fatal, so I think we should 
try as hard as possible for the check.

Agreed drm_prime_get_contiguous_size() is a bit odd, but essentially we 
were previously implementing the same thing.

> 
> Matt
> 
>>> +			     GUC_UM_QUEUE_SIZE * GUC_UM_HW_QUEUE_MAX)) {
>>> +			drm_err(&xe->drm,
>>> +				"UM fault queue memory is not contiguous in DMA address space; GAM requires contiguous DPA\n");
>>> +			return -ENOMEM;
>>> +		}
>>> +
>>> +		ads->um_queue_bo = bo;
>>> +	}
>>> +
>>>    	return 0;
>>>    }
>>>    ALLOW_ERROR_INJECTION(xe_guc_ads_init, ERRNO); /* See xe_pci_probe() */
>>> @@ -893,7 +912,7 @@ static void guc_mmio_reg_state_init(struct xe_guc_ads *ads)
>>>    static void guc_um_init_params(struct xe_guc_ads *ads)
>>>    {
>>> -	u32 um_queue_offset = guc_ads_um_queues_offset(ads);
>>> +	struct xe_bo *um_bo = ads->um_queue_bo;
>>>    	struct xe_guc *guc = ads_to_guc(ads);
>>>    	struct xe_device *xe = ads_to_xe(ads);
>>>    	u64 base_dpa;
>>> @@ -903,8 +922,14 @@ static void guc_um_init_params(struct xe_guc_ads *ads)
>>>    	with_dpa = !xe_guc_using_main_gamctrl_queues(guc);
>>> -	base_ggtt = xe_bo_ggtt_addr(ads->bo) + um_queue_offset;
>>> -	base_dpa = xe_bo_main_addr(ads->bo, PAGE_SIZE) + um_queue_offset;
>>> +	if (um_bo) {
>>> +		/* All USM platforms: UM queues in dedicated um_queue_bo */
>>> +		base_ggtt = xe_bo_ggtt_addr(um_bo);
>>> +		base_dpa = xe_bo_main_addr(um_bo, PAGE_SIZE);
>>> +	} else {
>>> +		/* Platform does not support USM: no UM queues, nothing to do */
>>> +		return;
>>> +	}
>>>    	for (i = 0; i < GUC_UM_HW_QUEUE_MAX; ++i) {
>>>    		/*
>>> diff --git a/drivers/gpu/drm/xe/xe_guc_ads_types.h b/drivers/gpu/drm/xe/xe_guc_ads_types.h
>>> index 48a8e092023f..845c1fbd93a4 100644
>>> --- a/drivers/gpu/drm/xe/xe_guc_ads_types.h
>>> +++ b/drivers/gpu/drm/xe/xe_guc_ads_types.h
>>> @@ -16,6 +16,11 @@ struct xe_bo;
>>>    struct xe_guc_ads {
>>>    	/** @bo: Xe BO for GuC ads blob */
>>>    	struct xe_bo *bo;
>>> +	/**
>>> +	 * @um_queue_bo: Dedicated BO for the HW fault ring (UM queues).
>>> +	 * NULL if the platform does not support USM.
>>> +	 */
>>> +	struct xe_bo *um_queue_bo;
>>>    	/** @golden_lrc_size: golden LRC size */
>>>    	size_t golden_lrc_size;
>>>    	/** @regset_size: size of register set passed to GuC for save/restore */
>>

