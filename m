Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BEC430CC8
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417171; cv=none; b=OVL+m9OeiILal7lvSUDqVKxE66fBSWZoXFgkf5/MTTLFl4LdYcO/1MilQ0/Ku3C69TKyugaRcxijar2ytlVfzvmzSOmguRnlI2XdI/fEszer8ChXgjg2uyp06L33KsTQoxZ+wpHR6uPlRCIwX1FFeZZp7GNEpSB8V49vGIE+NJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417171; c=relaxed/simple;
	bh=zyTFT5PUTIzO6aWPAmeFZLa5yPKvMYo7+eyon/uh6fk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Zs1Xo2w7h/+zW3mj715WAjKZp6MH6LGDobqHHAVsnuu25bzxXA6IUfdb0mDMsvMVFl+Q4ECCJC9cBaiXarNinI7Bugyalabr70JdT0pO3TJ8y2QpgM1sgWbCWZR7Zr9YjyRxCRGZCvLjBRU3k3yUCs5odjBPsGBGYbZTAdT8diM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZRKvp4F; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZRKvp4F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785417167; x=1816953167;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=zyTFT5PUTIzO6aWPAmeFZLa5yPKvMYo7+eyon/uh6fk=;
  b=ZZRKvp4FVg17W8yT0LMb+yY+0Ho/JozyqbQExXuFIHxmB5sYHxymQmXO
   EJyc/6Oww13QGSyIsWW0bhC97BjxxRNWnd4IvtG50UmkBGb+Oxo/1X5PR
   BAZuzrDgeJrc5sJiDK5N3ar9c3uJTQNKPY8ewN30AdUkVQAsbw6w8vL7F
   6dx8kqf9PBvbs5y9uCWwD2W+dMRqtOuloWJIfxBFns795VOQPOvr8QIQq
   sIkttJ47dTWnB2PYostRZ/Pif8vPyCxDJPY71lBy/OCofDgYspQj2OPfD
   Q2EkLMvYWfqMwumMF12hSx/cLYjOaBtcRjGhbFH88yx5sMHzCkO/CWb6R
   Q==;
X-CSE-ConnectionGUID: wrIHdRFVRDOTFRoH6SL4gw==
X-CSE-MsgGUID: 00FqrIazQRaqwnej/tzvOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85798815"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="85798815"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 06:12:46 -0700
X-CSE-ConnectionGUID: ARd7VzA8TwSGDtDQjzmTxQ==
X-CSE-MsgGUID: n7vPDf9UTGee4IANC7Oy1g==
X-ExtLoop1: 1
Received: from rvuia-mobl.ger.corp.intel.com (HELO [10.245.245.197]) ([10.245.245.197])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 06:12:44 -0700
Message-ID: <789a05bc-f33f-41ed-869d-0fbe45ebef09@intel.com>
Date: Thu, 30 Jul 2026 14:12:42 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] drm/xe/guc_ads: allocate UM queues in VRAM on dGFX
From: Matthew Auld <matthew.auld@intel.com>
To: Jia Yao <jia.yao@intel.com>, intel-xe@lists.freedesktop.org
Cc: gwan-gyeong.mun@intel.com, stable@vger.kernel.org
References: <20260722053410.2767369-1-jia.yao@intel.com>
 <20260730004735.344627-1-jia.yao@intel.com>
 <20260730004735.344627-3-jia.yao@intel.com>
 <148b38ae-eae7-40d5-837c-fddda1299d9f@intel.com>
Content-Language: en-GB
In-Reply-To: <148b38ae-eae7-40d5-837c-fddda1299d9f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/07/2026 11:51, Matthew Auld wrote:
> On 30/07/2026 01:47, Jia Yao wrote:
>> On dGFX the original ADS BO is explicitly migrated to VRAM by
>> xe_guc_realloc_post_hwconfig() so that xe_bo_main_addr() returns a
>> real device-physical address (DPA) rather than an IOMMU IOVA.  A
>> separate SYSTEM BO for the UM queues would not go through that migration
>> path, so its IOVA would differ from the physical address on systems
>> where pages are allocated above 4 GB.  GuC/GAM accesses the UM queue
>> ring via base_dpa (with_dpa=true on pre-Xe3p), so an incorrect DPA
>> causes all-zero fault descriptors to be forwarded to the driver.
> 
> I feel like I don't fully understand the explanation here. Is the issue 
> not just the contig requirement for base_dpa? We now use attempt a best 
> effort approach for system memory, however for dgpu we can go further 
> and use VRAM to guarantee that requirement. If that is all this is doing 
> then commit message can be simplified with something like:
> 
> "To fully guarantee the contig requirement for base_dpa, we can instead 
> just use VRAM for the um queue, on dgpu..."

Or is the issue that this has to always be in VRAM, since there is no 
bit to say whether the DPA is system vs VRAM, like we do for the GGTT 
pte? On dgpu, assumption is that this is then always VRAM, if using DPA? 
If so, please make that clearer in the commit message.

> 
>>
>> Use XE_BO_FLAG_VRAM_IF_DGFX() for the UM queue BO so that on dGFX the
>> BO is allocated directly in VRAM and xe_bo_main_addr() returns the
>> correct DPA without needing a post-hwconfig migration step.
>>
>> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
>> Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jia Yao <jia.yao@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_guc.c     |  6 ------
>>   drivers/gpu/drm/xe/xe_guc_ads.c | 11 ++++++-----
>>   2 files changed, 6 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
>> index 21cf3edef922..4023700ff2a9 100644
>> --- a/drivers/gpu/drm/xe/xe_guc.c
>> +++ b/drivers/gpu/drm/xe/xe_guc.c
>> @@ -714,12 +714,6 @@ static int xe_guc_realloc_post_hwconfig(struct 
>> xe_guc *guc)
>>       if (ret)
>>           return ret;
>> -    if (guc->ads.um_queue_bo) {
>> -        ret = xe_managed_bo_reinit_in_vram(xe, tile, &guc- 
>> >ads.um_queue_bo);
>> -        if (ret)
>> -            return ret;
>> -    }
>> -
>>       return 0;
>>   }
>> diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/ 
>> xe_guc_ads.c
>> index 7f371f9c7268..53636333fb45 100644
>> --- a/drivers/gpu/drm/xe/xe_guc_ads.c
>> +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
>> @@ -409,11 +409,12 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
>>           size_t um_size = roundup_pow_of_two(GUC_UM_QUEUE_SIZE *
>>                               GUC_UM_HW_QUEUE_MAX);
>> -        bo = xe_managed_bo_create_pin_map(xe, tile, um_size,
>> -                          XE_BO_FLAG_SYSTEM |
>> -                          XE_BO_FLAG_GGTT |
>> -                          XE_BO_FLAG_GGTT_INVALIDATE |
>> -                          XE_BO_FLAG_PINNED_NORESTORE);
>> +        u32 um_flags = XE_BO_FLAG_VRAM_IF_DGFX(tile) |
>> +                   XE_BO_FLAG_GGTT |
>> +                   XE_BO_FLAG_GGTT_INVALIDATE |
>> +                   XE_BO_FLAG_PINNED_NORESTORE;
>> +
>> +        bo = xe_managed_bo_create_pin_map(xe, tile, um_size, um_flags);
>>           if (IS_ERR(bo))
>>               return PTR_ERR(bo);
> 

