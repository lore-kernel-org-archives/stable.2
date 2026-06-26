Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3B23ED3CA
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782469667; cv=none; b=denvjyUsDgd5DuIE4qKKC9AmVfLaMnjuPIQ/+K4u7PzPXp2ixxAYVFyExi14C7KTqUioh909u2/kUvq0XjExmRd/gMc0opVtZHOVvmdlHgrtvCX6lFW0lmmoNbK2AUls+8GMVZhgvk+3ssSFf4ErbOuvmqom/239vCmZiLVfnTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782469667; c=relaxed/simple;
	bh=eHH924sR1+BCDOOcFegq9qEd4OO2yfx2DSQfnJoVrDg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=V+bw/mipTUWnwcHwpwIMvvT4YjTlzZhDKQx49qXBMFabO5vZnP0uVnrFHVaTmrUpYizkbo31oWTz+i9yDY/WdaApwcQBB0Om0EdDePrSVqFWkzcPAP1qNFs2EWXmeHVG6RGbXPs8gTB+zh0irhc7mJu95ZmxMkRszgdW7CNX8+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Geh3s2na; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Geh3s2na"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782469659; x=1814005659;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=eHH924sR1+BCDOOcFegq9qEd4OO2yfx2DSQfnJoVrDg=;
  b=Geh3s2natD3u4LbBoCnEp6D8LH3HBaVZBU/7Zk0xjhnoqIjXlhxS/eZU
   JfUsIdpXkMjJHVK83Og23oHNFGq8yn1WztTOPXhqQXOxu2ncl5qlYXXop
   YxtKLke3TfeRmX/TiWPXF3LREz1kU6DqdzXxX3X+lqczkuV3/ZwUjKURX
   QHMEnHHqc2acmANrIv6p1qAhLmwser1KEnBtmB/bsrR3KKs7ticYz9ded
   ENj1KHhQq3BNj93g/ypUtsPp7axsFa27NgPK3MrSjN7SPSJG3x5pz1oX8
   nO9jqzewL0KwZXTDtr0lqzBM/HPwRY6qCjY0oKPQuxpL4DxXcDH9VLeTC
   A==;
X-CSE-ConnectionGUID: ghwtlE/YQ6y1QyuR/KUcZg==
X-CSE-MsgGUID: 9FXOn0YkQ6m2eWEHde8LEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="106057111"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="106057111"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 03:27:39 -0700
X-CSE-ConnectionGUID: wJT9KauuRLeoPPlcUAseRA==
X-CSE-MsgGUID: BK4Ny/TdQAWWrh/B86PXKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="255280315"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.244.49]) ([10.245.244.49])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 03:27:37 -0700
Message-ID: <9e04ec82-712d-41b6-9fe8-78aeb015d67c@intel.com>
Date: Fri, 26 Jun 2026 11:27:34 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe/display: consider DPT when WA 22019338487 is
 active
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Nikolay Mikhaylov <sonny@milton.pro>,
 Uma Shankar <uma.shankar@intel.com>, Jani Nikula <jani.nikula@intel.com>,
 stable@vger.kernel.org, Maarten Lankhorst <dev@lankhorst.se>
References: <20260623090155.268763-2-matthew.auld@intel.com>
Content-Language: en-GB
In-Reply-To: <20260623090155.268763-2-matthew.auld@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/06/2026 10:01, Matthew Auld wrote:
> WA 22019338487 (22019338487_display) indicates that stolen memory should
> not be used for display allocations on affected platforms (like Lunar
> Lake). In particular we need to be mindful of not hammering stolen over
> the BAR from the host side, like with issuing many writes.
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
> v2 (Jani):
>    - Invert the WA check. No functional change.
> 
> Assisted-by: Gemini:gemini-3.1-pro-preview
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Fixes: 775d0adc01a5 ("drm/xe/fbdev: Limit the usage of stolen for LNL+")
> Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Nikolay Mikhaylov <sonny@milton.pro>
> Cc: Uma Shankar <uma.shankar@intel.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: <stable@vger.kernel.org> # v6.12+

Ping on this? So far two separate users report this fixes the hard 
machine hang for them, after several days of testing.

https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513#note_3537314

https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513#note_3531435

Looking through the HSD I think it is clear we need something like this 
for the WA.

> ---
>   drivers/gpu/drm/xe/display/xe_fb_pin.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
> index f93c98bec5b5..8ebb52741ea6 100644
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
> @@ -172,6 +175,8 @@ static int __xe_pin_fb_vma_dpt(struct drm_gem_object *obj,
>   						   XE_BO_FLAG_GGTT |
>   						   XE_BO_FLAG_PAGETABLE,
>   						   pin_params->alignment, false);
> +	else if (XE_DEVICE_WA(xe, 22019338487_display))
> +		dpt = ERR_PTR(-ENODEV);
>   	else
>   		dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
>   						   dpt_size,  ~0ull,

