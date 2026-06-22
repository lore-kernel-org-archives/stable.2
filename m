Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D0E335066
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120781; cv=none; b=LBuMphxq57IDcyckKIE2uKrm233qASIjt7/Bh9GWBZuxkKSAU3e158ItLz97IIhqMcGgayWBp2uDuhXAvo1dhNH+H1FYZE/ohcJ45MjSPwibuBxX8jef3wONb3fn6LSJ6UKpWXhFFLPHELeopOhqXOM7citW6H3Nq/GPsYx5AKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120781; c=relaxed/simple;
	bh=0CvKUFjKoILmkCGQleW1GHUvPBmFheCJkQxaNG2gEsk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DplGJd3oHtevqaIGokGb5JW8r13dp8xMLExZgyHL14jcr+np2nwJo6GjkaoehroJP8HCvFA/fZekGAyI9ze8R/r3rB09jsRjAQmnmgAXGHpUwlnMp5G2cHkdVg+VphN7l2TuQ42W5mSZY91oUFvciD0qkj/nbGdpZu6aotcSPxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gipXYsTr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gipXYsTr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782120780; x=1813656780;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=0CvKUFjKoILmkCGQleW1GHUvPBmFheCJkQxaNG2gEsk=;
  b=gipXYsTr4QKUcS8eqPugRStGA2efaCpMBSZ4Rd0AVL19KgqYwPofLhmE
   ghQG+g78+u9Nswg8jPRjRVCgVpiNHVS0I1mbMxfTE9Q4sQqIuoFzxAQ6K
   J44bHfriSmfJlVvY/btf2tGKaDULdr4i0Jrn2QYza5NjNDebVqEIRgzgW
   kfHrh78nW06e0I2bRPuXdq67UccAaILqGw/ZDT7pnkdKy1cJewFBVWJoG
   e+QBWfEGa+gl6b6H6Q1ifQuc9+wKTqQ0f7YbjC9W4bliV87YyaqU44lEO
   3bT1G8hwkYfBDwl0BRmfgHKO3rD4cuJhQPNobegL2vvLKVjhzp3zEyOAS
   Q==;
X-CSE-ConnectionGUID: 6DobiWuBTuy24/jRKE5CHQ==
X-CSE-MsgGUID: iYhp/XsTTuaFA4boj3ooFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="81949200"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="81949200"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 02:32:59 -0700
X-CSE-ConnectionGUID: Rwe2EGAeRS2KbPP8uXzJTQ==
X-CSE-MsgGUID: 7KRajiXbQvGKtAKblHntMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="287299079"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO [10.245.245.133]) ([10.245.245.133])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 02:32:58 -0700
Message-ID: <51364474-5b32-4f7c-80e8-86c430fee7b7@intel.com>
Date: Mon, 22 Jun 2026 10:32:55 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/display: consider DPT when WA 22019338487 is
 active
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Uma Shankar <uma.shankar@intel.com>,
 Nikolay Mikhaylov <sonny@milton.pro>, stable@vger.kernel.org
References: <20260609171002.380499-2-matthew.auld@intel.com>
Content-Language: en-GB
In-Reply-To: <20260609171002.380499-2-matthew.auld@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/06/2026 18:10, Matthew Auld wrote:
> WA 22019338487 (22019338487_display) indicates that stolen memory should
> not be used for display allocations on affected platforms (like Lunar
> Lake).
> 
> While the fbdev allocation in xe_display_bo.c properly respected this
> workaround, the Display Page Table (DPT) allocation in xe_fb_pin.c
> continued to unconditionally attempt to allocate from stolen memory on
> all integrated GPUs.
> 
> Check XE_DEVICE_WA(xe, 22019338487_display) before attempting to
> allocate the DPT from stolen memory. If the workaround applies, skip the
> stolen allocation attempt and let the driver naturally fall back to
> allocating from system memory.
> 
> Without this we will end up hammering stolen when programming the DPT on
> the host side during the normal operation, which seems to be exactly
> what the WA wants us to avoid.
> 
> There are a bunch of users all getting some kind of hard hang in the fb
> pin programming sequence on LNL, so wondering if this could help there.
> 
> Assisted-by: Gemini:gemini-3.1-pro-preview
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Fixes: 775d0adc01a5 ("drm/xe/fbdev: Limit the usage of stolen for LNL+")
> Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Uma Shankar <uma.shankar@intel.com>
> Cc: Nikolay Mikhaylov <sonny@milton.pro>
> Cc: <stable@vger.kernel.org> # v6.12+

Any takers for this one?

> ---
>   drivers/gpu/drm/xe/display/xe_fb_pin.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
> index f93c98bec5b5..46b1fd620527 100644
> --- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
> +++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
> @@ -20,6 +20,9 @@
>   #include "xe_pat.h"
>   #include "xe_pm.h"
>   #include "xe_vram_types.h"
> +#include "xe_wa.h"
> +
> +#include <generated/xe_device_wa_oob.h>
>   
>   static void
>   write_dpt_rotated(struct xe_bo *bo, struct iosys_map *map, u32 *dpt_ofs, u32 bo_ofs,
> @@ -172,7 +175,7 @@ static int __xe_pin_fb_vma_dpt(struct drm_gem_object *obj,
>   						   XE_BO_FLAG_GGTT |
>   						   XE_BO_FLAG_PAGETABLE,
>   						   pin_params->alignment, false);
> -	else
> +	else if (!XE_DEVICE_WA(xe, 22019338487_display))
>   		dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
>   						   dpt_size,  ~0ull,
>   						   ttm_bo_type_kernel,
> @@ -180,6 +183,9 @@ static int __xe_pin_fb_vma_dpt(struct drm_gem_object *obj,
>   						   XE_BO_FLAG_GGTT |
>   						   XE_BO_FLAG_PAGETABLE,
>   						   pin_params->alignment, false);
> +	else
> +		dpt = ERR_PTR(-ENODEV);
> +
>   	if (IS_ERR(dpt))
>   		dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
>   						   dpt_size,  ~0ull,

