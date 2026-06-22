Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7583A5445
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124036; cv=none; b=D6k/zsTQg6aHAwSE3Cmk59h0spYDck3H0vNz3RpQy+kMpFBcbLgatYi74ISwzqLAJ7LXGVRyeTEibDWNb1lJbC+REhOpm8UYdgIp0usgRLaIsc6BU7GmB0+OcSDyFcF/v+GpLsWkkRwvP9CfT+iXL+S0UL+7IbrDsxfiI3XJGuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124036; c=relaxed/simple;
	bh=LtzCTOmX4DCnQlX89OeOELB6xkmNGyqXTx1x82/OPkQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mq73xVYs8XWZo2mlEwfH9Hh9WBzXQRoGUe9ypY/h2Fknoy/+u7UL7x08gg7SsQTGq5fnmjYMNggOv+H3Hc38d97VMj4fMDrNgWeRnDLw9iODLaV1gyYWwCFhqlFFjY2S0NfuPSSZqVXA8zapMU9v4HIiMQJ+VJ26V8EOS4Tk0mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VXDV3Oc/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VXDV3Oc/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782124035; x=1813660035;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=LtzCTOmX4DCnQlX89OeOELB6xkmNGyqXTx1x82/OPkQ=;
  b=VXDV3Oc/W8K2egbeMLFRIaULdXH0a/fLJxOmflUcqAy/Tjx6VDpazEFn
   rMX1Nhqod2tFnp/vod+ax0lVAKsz2WEmGzjjbFu1MMhQqQSpIcCIhiDaU
   mwBoszwZZ8ez5bDZ3tSNkxbjez7nme7lF+cRHgtisb0UG8VERxTwOqpQb
   Q+Xtt5Re/rM8xqTon6K2Iy2YdY13bPgSmDQFoQpfrO6m2uwygxN2VMuz3
   3JsWtY3ZgJW5c0xgosZuYOBiAe6o6fVdcLZyWYUmaBoTSVMMhvdPcaY+K
   ACQ+x2Jy9oEfN9H4iA5cmoHj5NxNHt20Fg7s77Ean01pR7c7HLgXEP7qL
   w==;
X-CSE-ConnectionGUID: nHfySHRpQ7ipzzXYMzDH3g==
X-CSE-MsgGUID: wOdE3x10Sv2b9gpWdLL/zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="108394121"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="108394121"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 03:27:14 -0700
X-CSE-ConnectionGUID: dGZBqa/oTPi3lUJ5WEUExg==
X-CSE-MsgGUID: +WS9q3cpTYa592nP7IbrYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="253525561"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.82])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 03:27:11 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost
 <matthew.brost@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Uma
 Shankar <uma.shankar@intel.com>, Nikolay Mikhaylov <sonny@milton.pro>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/xe/display: consider DPT when WA 22019338487 is active
In-Reply-To: <20260609171002.380499-2-matthew.auld@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260609171002.380499-2-matthew.auld@intel.com>
Date: Mon, 22 Jun 2026 13:27:07 +0300
Message-ID: <f1e52cc936d880cff3041be6902b046bc74e9487@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 09 Jun 2026, Matthew Auld <matthew.auld@intel.com> wrote:
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
> Cc: "Thomas Hellstr=C3=B6m" <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Uma Shankar <uma.shankar@intel.com>
> Cc: Nikolay Mikhaylov <sonny@milton.pro>
> Cc: <stable@vger.kernel.org> # v6.12+
> ---
>  drivers/gpu/drm/xe/display/xe_fb_pin.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/=
display/xe_fb_pin.c
> index f93c98bec5b5..46b1fd620527 100644
> --- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
> +++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
> @@ -20,6 +20,9 @@
>  #include "xe_pat.h"
>  #include "xe_pm.h"
>  #include "xe_vram_types.h"
> +#include "xe_wa.h"
> +
> +#include <generated/xe_device_wa_oob.h>
>=20=20
>  static void
>  write_dpt_rotated(struct xe_bo *bo, struct iosys_map *map, u32 *dpt_ofs,=
 u32 bo_ofs,
> @@ -172,7 +175,7 @@ static int __xe_pin_fb_vma_dpt(struct drm_gem_object =
*obj,
>  						   XE_BO_FLAG_GGTT |
>  						   XE_BO_FLAG_PAGETABLE,
>  						   pin_params->alignment, false);
> -	else
> +	else if (!XE_DEVICE_WA(xe, 22019338487_display))

Nitpick, please don't make if not-some-obscure-workaround the happy day
scenario path.

I'd rather see

	else if (XE_DEVICE_WA(xe, 22019338487_display))
		dpt =3D ERR_PTR(-ENODEV);


BR,
Jani.

>  		dpt =3D xe_bo_create_pin_map_at_novm(xe, tile0,
>  						   dpt_size,  ~0ull,
>  						   ttm_bo_type_kernel,
> @@ -180,6 +183,9 @@ static int __xe_pin_fb_vma_dpt(struct drm_gem_object =
*obj,
>  						   XE_BO_FLAG_GGTT |
>  						   XE_BO_FLAG_PAGETABLE,
>  						   pin_params->alignment, false);
> +	else
> +		dpt =3D ERR_PTR(-ENODEV);
> +
>  	if (IS_ERR(dpt))
>  		dpt =3D xe_bo_create_pin_map_at_novm(xe, tile0,
>  						   dpt_size,  ~0ull,

--=20
Jani Nikula, Intel
