Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7150830D3E0;
	Tue, 18 Aug 2026 07:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787039942; cv=none; b=uOQxIQKNiWwkHI5d0ckv0GXxFtHql4cZLGb564ygulu1wiryI/uZsAGqUU68yHIwyO47hZ1Txs3wBIlaDiunSAC1eFfyjl4Y4BYzNy++ECT2hNsBKd2Kz1vh9TbiNAVST5MZC8VVZPePi2qp03yqy4dYWc6gCkKSlgfE23TxCQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787039942; c=relaxed/simple;
	bh=Hk0Zd1czJaTWm/hYSOrn7Jwx7VLlY4PtOOt4okU9jYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GEfFwCznHHAYEHUHRPYZpMXIqPLW/K1n+0KNKVTyuGZNCg9WUGeVbRPONdfm0LhByZg++7qkzGMrYmiUuOBEkLtCKofCKWqmve1BDs84d3ISeU5+7aMekO4vqxv95Xn1QMjXeisLdvPdewBHNYy0/uwyAN4G593012DuafZhpyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cN7I70f0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cN7I70f0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787039941; x=1818575941;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Hk0Zd1czJaTWm/hYSOrn7Jwx7VLlY4PtOOt4okU9jYc=;
  b=cN7I70f0l96Gw0e0Oa6QrltquKnb7Jav8vR3CIqVpLFl8ngAMK4OzwFu
   sztRIEDDgWnLMb+/7G1SvIuWy5IxoXOxREx7XJ1Q5J8OEMrqixyxTsgH4
   vXXA6PrhBELWRzuS7lMQ52gXzG3yU0woyhKvEjm0aLwgklLC7EWGnK18Y
   nJHO5KYEknZV/uI32ioQxxWkT+vLgcT71pjicqo6O21TS//z0H774Ztr3
   cWudSnPKsRsHfcgDX+4yVnIOzc8yUSmGQCYCpV4m7nCPI3B2iFHwwr1SE
   LgjplUhqAHKl0SFMsLjKSMeO80VbMYBz968lfZOE+nhAwXUTni6A0ZVfh
   w==;
X-CSE-ConnectionGUID: frUihPdVRY2nylt3wjv1lA==
X-CSE-MsgGUID: LD7we0QEQrO7lwLQJMSX6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="110310190"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="110310190"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 00:59:00 -0700
X-CSE-ConnectionGUID: 4bs/UuoqQbqEthPMS8Aq4A==
X-CSE-MsgGUID: ZCIanelLQdmz/7rRwltwiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="263426881"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.243])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 00:58:57 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: =?utf-8?Q?Chang_Jiong=28=E5=B8=B8=E7=82=AF=29?= <xspeed1989@gmail.com>,
 intel-gfx@lists.freedesktop.org
Cc: =?utf-8?Q?Chang_Jiong=28=E5=B8=B8=E7=82=AF=29?= <xspeed1989@gmail.com>,
 stable@vger.kernel.org,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Ville
 =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, =?utf-8?Q?Micha?=
 =?utf-8?Q?=C5=82?= Grzelak
 <michal.grzelak@intel.com>, "open list:INTEL DRM DISPLAY FOR XE AND I915
 DRIVERS" <intel-xe@lists.freedesktop.org>, "open list:DRM DRIVERS"
 <dri-devel@lists.freedesktop.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/i915/cdclk: Don't force cd2x pipe select on Xe3
 in bxt_sanitize_cdclk()
In-Reply-To: <20260816062344.796615-1-xspeed1989@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <tencent_6CC00E822A788776C8F6E2D6B24C5FE4A909@qq.com>
 <20260816062344.796615-1-xspeed1989@gmail.com>
Date: Tue, 18 Aug 2026 10:58:54 +0300
Message-ID: <c4dead5d0527e305f44ddb943f95e9967ec1911f@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, 16 Aug 2026, Chang Jiong(=E5=B8=B8=E7=82=AF) <xspeed1989@gmail.com>=
 wrote:
> Since commit 2ee8dbd880b1 ("drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL
> without a full PLL re-enable") bxt_sanitize_cdclk() normalizes the
> CD2X pipe select field of the CDCLK_CTL readback to PIPE_NONE before
> comparing against the expected value.
>
> However bxt_cdclk_ctl() does not include the CD2X pipe select field
> at all on DISPLAY_VER() >=3D 30, so on Xe3 (PTL) the normalized
> readback (pipe field forced to the PIPE_NONE encoding, 0b111) can
> never match the expected value (pipe field 0). The comparison now
> fails on every boot and we always take the full CDCLK PLL
> disable+re-enable path with the BIOS framebuffer actively scanning
> out - exactly what this code was trying to avoid. On a Panther Lake
> laptop (Arc B390, 8086:b080, eDP 3120x2080@120) this causes
> "CPU pipe A FIFO underrun" during probe and persistent full-screen
> scanout corruption for the first KMS client (the SDDM greeter);
> the corruption lasts until the next full modeset.
>
> Only normalize the CD2X pipe select field on platforms where
> bxt_cdclk_ctl() actually programs it, mirroring its DISPLAY_VER()
> check.
>
> Fixes: 2ee8dbd880b1 ("drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL without a=
 full PLL re-enable")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chang Jiong(=E5=B8=B8=E7=82=AF) <xspeed1989@gmail.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8550
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8569
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8901

The first one has a patch from Ville that is identical to this one.

I'll try to kick CI to get this tested before merging.

> ---
> v2: No code changes. Resent with From matching Signed-off-by
>     (v1 was sent from 304750714@qq.com, which is not on the
>     Intel CI allowlist).
>
>  drivers/gpu/drm/i915/display/intel_cdclk.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c b/drivers/gpu/drm=
/i915/display/intel_cdclk.c
> index 7bc9b956554b..0438f5ac78c0 100644
> --- a/drivers/gpu/drm/i915/display/intel_cdclk.c
> +++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
> @@ -2366,8 +2366,10 @@ static void bxt_sanitize_cdclk(struct intel_displa=
y *display)
>  	 * dividers both syncing to an active pipe, or asynchronously
>  	 * (PIPE_NONE).
>  	 */
> -	cdctl &=3D ~bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
> -	cdctl |=3D bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
> +	if (DISPLAY_VER(display) < 30) {
> +		cdctl &=3D ~bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
> +		cdctl |=3D bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
> +	}
>=20=20
>  	if (cdctl !=3D expected) {
>  		if (DISPLAY_VER(display) < 20) {

--=20
Jani Nikula, Intel
