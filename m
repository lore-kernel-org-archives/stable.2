Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D383F1AD7
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484374; cv=none; b=OryT8AgP3ub1zbm9BueW0i+fSHsUb65fHvUw6PiHRPOf1FhVzoI3q+BUCiOOaHR+3KLI6G8EkY5OTBo31oXapYuQMYhI7p6B+ORytGPjTDxhV4zKa4gxzruTC33nXVbOhRNc8biArW7OGV2jK1sgVuE7TMoHotNecVr24cAaIV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484374; c=relaxed/simple;
	bh=1CYpYf+FwNEzDZ7W7ESjZCMN6SwZ0Qp80wMrfd5Bqew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tbz8CmkSGhHT/DUCyAzIVLXjm3nCucGCmIJfEfsyogf4NYwwweU5g4RH2A8M/yQaAIGbm6lIdtlEk3N05Lso7in+NPKj25SZpoP+ZXzfOVI+vheFYcUJSJuMHVT8O4oTVthPn+f1J/F1ChWnPc6fZoWc/KCynzs1JV2fng72pX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N64Gan4r; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N64Gan4r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782484372; x=1814020372;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1CYpYf+FwNEzDZ7W7ESjZCMN6SwZ0Qp80wMrfd5Bqew=;
  b=N64Gan4ra2Vi29sEnFc1vjyGIjfe8uemoinHrHwNt56o22HCpDyElFf2
   Xo2s2qUL7jqfTImt2czWVOrpxyomc94/XylAoKRdiombowOrtj1KTNHG0
   Hncr4tCgnScYp+A1l8kMJOLq8ZP8kwX5ZHv5izM1DK8oSIHv3dpA2i7zZ
   2bQf3g1n/cgHdLfh1ToZGDhDJfBQUBGMUG7CgJbQtMzVcc1dAdqwdtPQI
   CvOTCL4P/jw2J5XU6L1Rq+spv9fMvLFG1hYOjQKRnP9IvfFG8WH+Oy2uV
   +5chA9k2Lfi4hz9JMJtk89ri/hYmRtGOJyuPkybmH/H24uVZ4jmH2sei8
   w==;
X-CSE-ConnectionGUID: 5vWRdBIuRFCouAQpeiT0hw==
X-CSE-MsgGUID: xFFse0d/SySbict4nSeaiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="93630771"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="93630771"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 07:32:51 -0700
X-CSE-ConnectionGUID: 8UIJEyHsTF+d2kVDlO7Hjw==
X-CSE-MsgGUID: 6vuHH5reTdCo1ijrmNP6hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="251988518"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.244.49]) ([10.245.244.49])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 07:32:50 -0700
Message-ID: <dd6a1825-9c22-4c94-9ab5-7ccd24f96990@intel.com>
Date: Fri, 26 Jun 2026 15:32:46 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe/display: consider DPT when WA 22019338487 is
 active
To: Maarten Lankhorst <dev@lankhorst.se>, intel-xe@lists.freedesktop.org
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Nikolay Mikhaylov <sonny@milton.pro>,
 Uma Shankar <uma.shankar@intel.com>, Jani Nikula <jani.nikula@intel.com>,
 stable@vger.kernel.org
References: <20260623090155.268763-2-matthew.auld@intel.com>
 <9e04ec82-712d-41b6-9fe8-78aeb015d67c@intel.com>
 <9924291e-5108-41b3-9131-12b292e8bcd2@lankhorst.se>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <9924291e-5108-41b3-9131-12b292e8bcd2@lankhorst.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/06/2026 14:37, Maarten Lankhorst wrote:
> Hey,
> 
> On 6/26/26 12:27, Matthew Auld wrote:
>> On 23/06/2026 10:01, Matthew Auld wrote:
>>> WA 22019338487 (22019338487_display) indicates that stolen memory should
>>> not be used for display allocations on affected platforms (like Lunar
>>> Lake). In particular we need to be mindful of not hammering stolen over
>>> the BAR from the host side, like with issuing many writes.
>>>
>>> While the fbdev allocation in xe_display_bo.c properly respected this
>>> workaround, the Display Page Table (DPT) allocation in xe_fb_pin.c
>>> continued to unconditionally attempt to allocate from stolen memory on
>>> all integrated GPUs.
>>>
>>> Check XE_DEVICE_WA(xe, 22019338487_display) before attempting to
>>> allocate the DPT from stolen memory. If the workaround applies, skip the
>>> stolen allocation attempt and let the driver naturally fall back to
>>> allocating from system memory.
>>>
>>> Without this we will end up hammering stolen when programming the DPT on
>>> the host side during the normal operation, which seems to be exactly
>>> what the WA wants us to avoid.
>>>
>>> There are a bunch of users all getting some kind of hard hang in the fb
>>> pin programming sequence on LNL, so wondering if this could help there.
>>>
>>> v2 (Jani):
>>>     - Invert the WA check. No functional change.
>>>
>>> Assisted-by: Gemini:gemini-3.1-pro-preview
>>> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513
>>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>>> Fixes: 775d0adc01a5 ("drm/xe/fbdev: Limit the usage of stolen for LNL+")
>>> Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>>> Cc: Nikolay Mikhaylov <sonny@milton.pro>
>>> Cc: Uma Shankar <uma.shankar@intel.com>
>>> Cc: Jani Nikula <jani.nikula@intel.com>
>>> Cc: <stable@vger.kernel.org> # v6.12+
>>
>> Ping on this? So far two separate users report this fixes the hard machine hang for them, after several days of testing.
> 
> Can we instead disable stolen entirely so we no longer need this workaround?

I'm not sure. You mean disable it except for fbc etc ? We just need some 
patch to disable at least this dpt path on LNL, which is also easy to 
backport. We can take your patch to disable this completely instead and 
I guess remove the WA, so long as we can easily backport it. Either way 
we just need to land a fix for this ASAP.

> 
> https://patchwork.freedesktop.org/patch/735208/?series=159035&rev=19
> https://patchwork.freedesktop.org/patch/735215/?series=159035&rev=19
> https://patchwork.freedesktop.org/patch/735223/?series=159035&rev=19
> 
> Sending a new version soon, I can split out those patches if needed.
> Ideally we find a way to preserve the initial framebuffer by blitting
> from the DSB FB to a system memory FB, but this may affect module load time.
> 
> Kind regards,
> ~Maarten Lankhorst
> 
>> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513#note_3537314
>>
>> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513#note_3531435
>>
>> Looking through the HSD I think it is clear we need something like this for the WA.
>>
>>> ---
>>>    drivers/gpu/drm/xe/display/xe_fb_pin.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
>>> index f93c98bec5b5..8ebb52741ea6 100644
>>> --- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
>>> +++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
>>> @@ -20,6 +20,9 @@
>>>    #include "xe_pat.h"
>>>    #include "xe_pm.h"
>>>    #include "xe_vram_types.h"
>>> +#include "xe_wa.h"
>>> +
>>> +#include <generated/xe_device_wa_oob.h>
>>>      static void
>>>    write_dpt_rotated(struct xe_bo *bo, struct iosys_map *map, u32 *dpt_ofs, u32 bo_ofs,
>>> @@ -172,6 +175,8 @@ static int __xe_pin_fb_vma_dpt(struct drm_gem_object *obj,
>>>                               XE_BO_FLAG_GGTT |
>>>                               XE_BO_FLAG_PAGETABLE,
>>>                               pin_params->alignment, false);
>>> +    else if (XE_DEVICE_WA(xe, 22019338487_display))
>>> +        dpt = ERR_PTR(-ENODEV);
>>>        else
>>>            dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
>>>                               dpt_size,  ~0ull,
>>
> 

