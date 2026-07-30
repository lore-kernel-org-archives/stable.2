Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD35040B364
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410605; cv=none; b=XjuyiPlQ6Ac83Ih6ylnlyEzBvLaVU3lfQpoXthd6W+jeNyspXRe5ZSKTpRxZAd4NV0yfBWJk6Vz3qzeyUZ3sgX5p9fQdr/pEGevLT3R+PHDuu2MeIZ7m2io41kNcng3EDJS+pUJHxijdrQSzV8gUANW+JtGm/sifc4/PdwA95ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410605; c=relaxed/simple;
	bh=oZnVuwsdYI44LQGjRuL65ZXWD+wuxjwxtVXK2xAd3R0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sHGc/RvlQUhm3/xB0AkgKyY0fbywdgTksiDwBTZg81FI9hUyvigl4mE1ySqCBBKtxYHzk3v7ugCPtvFlZ+G593JDEr9IjpSFBI5EKxIdi6iEKUlS4r2/fQ8ENOX3aYsbpnMVXWmUl7RcJyVeLtxMiBYc1JVBsydqkml6UtHzE0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KJxnZs2C; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KJxnZs2C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785410602; x=1816946602;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oZnVuwsdYI44LQGjRuL65ZXWD+wuxjwxtVXK2xAd3R0=;
  b=KJxnZs2CahhT97e2Zqt5GI1sIpOSZqQHDfZifM9i25/6zrun24BWABFi
   N8rV8BMha0mdktg1enyPP2F3NjUGi4zo0R5q3h+mnt+2KOhg07qxyPZLT
   LywJv0VQ9NpNIESa4rq/8wsUk+eY0dqJotyCOoTyy6keoFC4NfbjbIJcM
   IM5gusY80qOqdqIHznNchV47qrqqykiNKD3Pg8CyY33Brb5vIEdpsW9hE
   SyhMGdYi9B0kYVbW/xzaEtW0ClOjdQ6eaBdNJItaxz7EWmYLamHgL5Fjy
   o0Tln4EilIlGlkjnP7EZuVKbUQJBoe/fBez+WvgqqfnqCSS7pDse7Oj/i
   A==;
X-CSE-ConnectionGUID: 2bhim98fR1uBgnwsQ6N/6g==
X-CSE-MsgGUID: YR2gFwHcQT+5Sd20vvGGVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="96689699"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="96689699"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 04:23:22 -0700
X-CSE-ConnectionGUID: BAirZQ0tTRKAGBXghH0qwA==
X-CSE-MsgGUID: YXtwwKcTTVCEdCZ+ZG0P2A==
X-ExtLoop1: 1
Received: from rvuia-mobl.ger.corp.intel.com (HELO [10.245.245.197]) ([10.245.245.197])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 04:23:20 -0700
Message-ID: <d44bbc54-ea0f-471c-bebe-19499fa47b93@intel.com>
Date: Thu, 30 Jul 2026 12:23:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] drm/xe/guc_ads: use uncached mapping for UM queue
 BO
To: Jia Yao <jia.yao@intel.com>, intel-xe@lists.freedesktop.org
Cc: gwan-gyeong.mun@intel.com, stable@vger.kernel.org
References: <20260722053410.2767369-1-jia.yao@intel.com>
 <20260730004735.344627-1-jia.yao@intel.com>
 <20260730004735.344627-4-jia.yao@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260730004735.344627-4-jia.yao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/07/2026 01:47, Jia Yao wrote:
> The HW unit that writes fault descriptors into the UM queue ring buffer
> may not be coherent with the CPU cache.  If a descriptor write is still
> sitting in a GPU L3 cache line when GuC reads the slot, GuC sees the
> stale (all-zero) content from DRAM and forwards an invalid descriptor to
> the driver (Faulted Address = 0, ASID = 0).
> 
> Mark the UM queue BO as uncached (XE_BO_FLAG_NEEDS_UC) so that writes
> bypass the cache and are immediately visible to GuC.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")

As per Michal this is too old. I think we can instead do:

Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
Cc: <stable@vger.kernel.org> # v6.12+

> Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jia Yao <jia.yao@intel.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   drivers/gpu/drm/xe/xe_guc_ads.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
> index 53636333fb45..76029575aa45 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ads.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
> @@ -412,7 +412,8 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
>   		u32 um_flags = XE_BO_FLAG_VRAM_IF_DGFX(tile) |
>   			       XE_BO_FLAG_GGTT |
>   			       XE_BO_FLAG_GGTT_INVALIDATE |
> -			       XE_BO_FLAG_PINNED_NORESTORE;
> +			       XE_BO_FLAG_PINNED_NORESTORE |
> +			       XE_BO_FLAG_NEEDS_UC;
>   
>   		bo = xe_managed_bo_create_pin_map(xe, tile, um_size, um_flags);
>   		if (IS_ERR(bo))

