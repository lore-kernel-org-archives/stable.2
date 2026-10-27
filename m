Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099809;
	b=QtSv2mCpks6VLffaOmWXBTpngR/He2tlxZMxPbtTNKUmiOT//+k4deRoyablvQoO/hq9
	 2G4OFMUizjnBqf0kUFTmJXPydQBW+UBPCbYTaEOziLjI85BEQ1VtGwsumK+rVirKfTWdD
	 nj3QsovoRNhwnNnV1vP43/2SeYUkxEidkOypo+bmVSooBi9kxWcfTDb9evaNsae//7SHe
	 a4c6Qs1WHSpk1nki9b/VGv/z/a9yp0IZGduGs5sYkGeYClFYwhS7HiXFDe9EcnQCINLUs
	 5ISOI68ReQCobBfQOyW0cyLdLjBr0COIVtQeH29ZMaK/ifJ0h9/dMAGeSpTv72b64Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099809;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 In-Reply-To:Organization:References:Date:Message-ID:MIME-Version:
	 Content-Type;
	bh=bEWKTusDyh1IbG4mBMX9eIv18yAmYuDI2D/Lf4UuZzo=;
	b=ZG/j30H5PpzyCzrlRdRDArig9fgm+B3rKRnFdoFVmLtDv5QWeAdLfyDDrXtKcQCSmdDf
	 r6TAHvd2x00f1UK/ViJo5rCo8Jl5WWADL4s9WGSzGgxIlmg3gFYB8XnuzQr82KSLewS8k
	 Mh3cb8GmS5Ne2KdwB5ThX5qSfTL7gwd88R4i/64RZz9zmnrJaHIpoAQIrJ5xOTg6aBbZO
	 xQxEJZCxUcOtWuAetTXJ1JxEWx7KBT+bCQHAT2IEDC9SZONcTVdcVkKsH8jrHLuvTwnCV
	 sOdJPaR8r1LTIXVgJLedcI0GQ7/MkpNtozFq2l5tlciUE+lEQjpF0tgFvAwbHi8Ng7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CZIJSMP+;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AB7606A320
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 11:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65AB7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CZIJSMP+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793099808; x=1824635808;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=L/1/KGyyj3SId0IkPfs37oAiXvoV0Xt7u9LLr+3T3B0=;
  b=CZIJSMP+2DuUbuuZnbsvxwbDw95xkOye3BMcbdmFnq32zNeHtQ0Zl4iI
   bCNoBc0qBTHmYnclpONYoREbP+E9hrI+FF8iHcxOoQf+LLZi1/8tHkjiR
   VCJe/Ka+y78N2NVz3sJHZTqVYBg6ymQLLqFmnVutl6rC8/g/WFekHndT2
   suZXsHK/ZGwakFWIe3cB3cFQiXbpjMf+BA5FQE/eCbwDbVC/sb1zfAJzu
   BSUoRZNEGjPOMWjyjTDjqVHiVVLHgIWuCA6dR88MDkdAFlDB9nIm6Wer2
   z35XfLs5OCwNbZf5Xr/pjPOYvQdIuBmO6Z07Ys3BoiVOrGKi+u1pRQvhM
   Q==;
X-CSE-ConnectionGUID: SNcsQhW1ThqW7IWTDhDgfg==
X-CSE-MsgGUID: 7QyY9peTSHeUV8pOjbY7hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1813763"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1813763"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 04:16:47 -0700
X-CSE-ConnectionGUID: mYlOohOaR/idmt8tbzS6Xg==
X-CSE-MsgGUID: 0gdNG6j1SGC2j3hJsfwm9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4520383"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.247])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 04:16:45 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Cc: suraj.kandpal@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/dp: Add quirk to allow eDP joiner on ASUS ROG
 Strix SCAR 18
In-Reply-To: <20261027024334.1140596-1-ankit.k.nautiyal@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261027024334.1140596-1-ankit.k.nautiyal@intel.com>
Date: Tue, 27 Oct 2026 13:16:42 +0200
Message-ID: <fc612de514d2382b5c783854aeb98963d0bc0fb9@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 27 Oct 2026, Ankit Nautiyal <ankit.k.nautiyal@intel.com> wrote:
> On Arrow Lake, VBT defaults the eDP pipe joiner enable bit to
> disabled, and commit 650471948e49 ("drm/i915/dp: Avoid joiner for
> eDP if not enabled in VBT") made the driver honor that default.
>
> On the ASUS ROG Strix SCAR 18 (G835LXG), the bit in VBT is left to
> the platform default instead of enabling it, even though the
> 3840x2400@240Hz panel requires the joiner to reach its native
> mode. As a result the mode is pruned and the panel is limited to
> 120Hz.
>
> Since the VBT bit cannot be relied upon globally for ARL (it is
> needed to block the joiner on at least one other machine), add a
> machine-specific quirk, to bypass the VBT restriction and allow the
> joiner on this machine.
>
> Fixes: 650471948e49 ("drm/i915/dp: Avoid joiner for eDP if not enabled in VBT")
> Cc: Suraj Kandpal <suraj.kandpal@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v7.1+
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16854
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp.c     |  3 ++-
>  drivers/gpu/drm/i915/display/intel_quirks.c | 13 +++++++++++++
>  drivers/gpu/drm/i915/display/intel_quirks.h |  1 +
>  3 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 00e02e019d25..7b83cc83eede 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -476,7 +476,8 @@ bool intel_dp_has_joiner(struct intel_dp *intel_dp)
>  		return false;
>  
>  	if (intel_dp_is_edp(intel_dp)) {
> -		bool pipe_joiner_enable = connector->panel.vbt.edp.pipe_joiner_enable;
> +		bool pipe_joiner_enable = connector->panel.vbt.edp.pipe_joiner_enable ||
> +					  intel_has_quirk(display, QUIRK_ALLOW_EDP_JOINER);

Could we hide the quirk in intel_bios.c to set
connector->panel.vbt.edp.pipe_joiner_enable?

BR,
Jani.

>  
>  		if (connector->force_joined_pipes > 1)
>  			pipe_joiner_enable = true;
> diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
> index 7d7db774d8c7..ba7bce7f2827 100644
> --- a/drivers/gpu/drm/i915/display/intel_quirks.c
> +++ b/drivers/gpu/drm/i915/display/intel_quirks.c
> @@ -100,6 +100,16 @@ static void quirk_disable_psr2(struct intel_display *display)
>  	drm_info(display->drm, "PSR2 support not currently available for this setup, applying disable PSR2 quirk\n");
>  }
>  
> +/*
> + * VBT on some machines defaults the eDP pipe joiner to disabled even though
> + * the panel requires it to achieve its native mode, so allow it regardless.
> + */
> +static void quirk_allow_edp_joiner(struct intel_display *display)
> +{
> +	intel_set_quirk(display, QUIRK_ALLOW_EDP_JOINER);
> +	drm_info(display->drm, "Applying allow eDP joiner quirk\n");
> +}
> +
>  struct intel_quirk {
>  	int device;
>  	int subsystem_vendor;
> @@ -262,6 +272,9 @@ static struct intel_quirk intel_quirks[] = {
>  
>  	/* Xiaomi Book Pro 14 2026 */
>  	{ 0xb081, 0x1d72, 0x2424, quirk_disable_psr2 },
> +
> +	/* ASUS ROG Strix SCAR 18 G835LXG */
> +	{ 0x7d67, 0x1043, 0x3b29, quirk_allow_edp_joiner },
>  };
>  
>  static const struct intel_dpcd_quirk intel_dpcd_quirks[] = {
> diff --git a/drivers/gpu/drm/i915/display/intel_quirks.h b/drivers/gpu/drm/i915/display/intel_quirks.h
> index 970a4fe52faf..84f31809011c 100644
> --- a/drivers/gpu/drm/i915/display/intel_quirks.h
> +++ b/drivers/gpu/drm/i915/display/intel_quirks.h
> @@ -23,6 +23,7 @@ enum intel_quirk_id {
>  	QUIRK_EDP_LIMIT_RATE_HBR2,
>  	QUIRK_DISABLE_EDP_PANEL_REPLAY,
>  	QUIRK_DISABLE_PSR2,
> +	QUIRK_ALLOW_EDP_JOINER,
>  };
>  
>  void intel_init_quirks(struct intel_display *display);

-- 
Jani Nikula, Intel
