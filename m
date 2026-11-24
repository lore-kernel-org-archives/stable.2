Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795525625;
	b=IoXADVirOZt5iPYhkuom4lio1v/0ojSDnbjAHUqFP7HmvdZNcHu3eQ3FLuyEHXIhC1J2
	 Q8nn3kkNGNVJz1pVACNxOc10t7zthmmk2DHVr9iKJeWkUZaIFoEOrWtem0yYXPaDJYac4
	 dKQM2vUY1oyzvhdGMB3OdBf7YXPqOz8u2LD9tF1bGs0ZyEmMjP6Z/s9DQP8D8z9wE8wnA
	 v83kNUMkkDCniAonh+rLpQW4F2QuBAwxRFAVOd1C/MgRQARjd6oL9BEVeRPp/9xyXOBB9
	 MydoI1MAhM8BJ7qKABoJCLeatknkKgst0f0bh15/SPF+o+T4BpbgLkwvg1bHRyPaH5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795525625;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Patchwork-Hint:Organization;
	bh=9cDEhUhpswSYbiu47LsHUEy/96Fzpq2WscTeT3sqrt4=;
	b=2rS6Re9gNhiXDoHQPRKklyF0MaDtc+LGLI4qE6y59M9pGxyz5o4c4cA3O5TSyWt8bjTk
	 spDrlnHucts2Ueetbh9RqU0YDz//rLwH1ZCu3O/B38alANOmY0NMWzkNVejU/gU/XyXYy
	 70JL2sOu5qKK6702e2P6VNnNaewuItsryW3AIvIG/DCZNteIVwqRhSUI8kz2HELgIQBiI
	 lbwJYtloo8/64DpGOAtMhYgXYziwSLRjWSVPEoPowBhBwervmL6Q3kWSiqHThnVPI5TMx
	 uqculBc08Zzrt9GtAB5CaulZNg4H7hKO5snbl5/bPAlbjtGe2qxEZ89bO50Yd4JKwLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VCVjLQ+D;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA9E606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 13:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DA9E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VCVjLQ+D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795525624; x=1827061624;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Te4AmTY9SNn131H6ENr5PVBO/axCNZkwfoJKkzYGjTs=;
  b=VCVjLQ+DHJEdP67oMTODJLn3/3/vesfNkVsGzTwBRKdtFR2qAoIJgcQ+
   7cEYipajidf9f8HGPgnA0QmnA3jknxDUonG2NB+8UOAfOM70sYFA2jIpd
   kbhtQhTypEP1Lo4VQ54yF8u9evmhvyAKQawT6N+gCwYW+UNTekMHa9T+I
   1FAOGGeV5gPbYW4wi/97HDP/JY503Hu4rOvAVN9sfUM1/TLLV+DC32eKT
   oqVd9sxJuV0sp6+oQpI39Mj2F8v5zigIKidUGK+mJLSyObHIjuEAQS12Z
   v6AdeeuJrLxh68tW/X19ou1O/AMJPFg6D6J6NoVute1mFQ6GJG57W9e/2
   g==;
X-CSE-ConnectionGUID: NIegLZztTau+fj0lkkoW5Q==
X-CSE-MsgGUID: P+9Y0TpcQkakvf+bqY2Cbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4413902"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4413902"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 05:07:04 -0800
X-CSE-ConnectionGUID: 4YtgsVJdS8qiO91lLP01TA==
X-CSE-MsgGUID: iMP6K+SgSly5DqkK2je4rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="12002056"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 05:07:01 -0800
Date: Tue, 24 Nov 2026 15:06:58 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	imre.deak@intel.com, mika.kahola@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/pps: Don't steal VDD from another eDP port
 sharing the PPS
Message-ID: <awWL8jQGrCxadBMt@intel.com>
References: <20261123050422.3130438-1-suraj.kandpal@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261123050422.3130438-1-suraj.kandpal@intel.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland

On Mon, Nov 23, 2026 at 10:34:23AM +0530, Suraj Kandpal wrote:
> Some VBTs declare an unpopulated eDP port next to the real panel and
> assign both the same PPS. The ghost port adopts the VDD bit the real
> port turned on, and when its DPCD read fails it clears EDP_FORCE_VDD
> underneath the real port. The real port's VDD reference is then never
> released, leaking an AUX power domain reference and a runtime PM
> wakelock:
> 
>   drm_WARN_ON(intel_dp->pps.vdd_wakeref)
>   i915 raw-wakerefs=1 wakelocks=1 on cleanup
> 
> Don't adopt or turn off VDD owned by another eDP port on the same PPS.
> 
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17232
> Cc: stable@vger.kernel.org # v6.15+
> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_pps.c | 35 ++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_pps.c b/drivers/gpu/drm/i915/display/intel_pps.c
> index 442b00491a88..653b8bf7ec6d 100644
> --- a/drivers/gpu/drm/i915/display/intel_pps.c
> +++ b/drivers/gpu/drm/i915/display/intel_pps.c
> @@ -570,6 +570,30 @@ static bool edp_have_panel_vdd(struct intel_dp *intel_dp)
>  	return intel_de_read(display, _pp_ctrl_reg(intel_dp)) & EDP_FORCE_VDD;
>  }
>  
> +static bool pps_vdd_owned_by_other_port(struct intel_dp *intel_dp)
> +{
> +	struct intel_display *display = to_intel_display(intel_dp);
> +	struct intel_encoder *encoder;
> +
> +	lockdep_assert_held(&display->pps.mutex);
> +
> +	if (display->platform.valleyview || display->platform.cherryview)
> +		return false;
> +
> +	for_each_intel_dp(display->drm, encoder) {
> +		struct intel_dp *dp = enc_to_intel_dp(encoder);
> +
> +		if (dp == intel_dp || encoder->type != INTEL_OUTPUT_EDP)
> +			continue;
> +
> +		if (dp->pps.pps_idx == intel_dp->pps.pps_idx &&
> +		    dp->pps.vdd_wakeref)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  void intel_pps_check_power_unlocked(struct intel_dp *intel_dp)
>  {
>  	struct intel_display *display = to_intel_display(intel_dp);
> @@ -839,6 +863,9 @@ static void intel_pps_vdd_off_sync_unlocked(struct intel_dp *intel_dp)
>  	if (!edp_have_panel_vdd(intel_dp))
>  		return;
>  
> +	if (!intel_dp->pps.vdd_wakeref && pps_vdd_owned_by_other_port(intel_dp))
> +		return;
> +
>  	drm_dbg_kms(display->drm, "[ENCODER:%d:%s] %s turning VDD off\n",
>  		    dig_port->base.base.base.id, dig_port->base.base.name,
>  		    pps_name(intel_dp));
> @@ -1334,6 +1361,14 @@ static void pps_vdd_init(struct intel_dp *intel_dp)
>  	if (!edp_have_panel_vdd(intel_dp))
>  		return;
>  
> +	if (pps_vdd_owned_by_other_port(intel_dp)) {
> +		drm_dbg_kms(display->drm,
> +			    "[ENCODER:%d:%s] %s VDD owned by another eDP port, not adopting it\n",
> +			    dig_port->base.base.base.id, dig_port->base.base.name,
> +			    pps_name(intel_dp));
> +		return;
> +	}

If someone else already owns the PPS then we should stop the probe
of the current port right here. So I think this belongs in
pps_initial_setup(). And it should not look at the wakeref,
pps_idx alone should be sufficient to figure out who owns what.
That will also avoid racing with the delayed VDD off from a
previously probed port.

I think the proper solution for this PPS init mess should be
something along the lines of:
- extract the PPS tracking out from intel_dp into its' own per PPS
  object, and have each intel_dp just point to the right one.
  VLV/CHV with their screwed up PPS hardware would probably be the
  hardest thing to handle here.
- never turn VDD off during until connector probing is fully done
- if multiple encoders are trying to use the same PPS let the first
  one to successfully probe own it, don't even probe the remaining ones
- after all connectors are probed turn off all PPSs that aren't in
  use, and schedule the delayed off for the ones that are in use

but that's a lot of work, so we do probably want a less refined
stopgap first.

> +
>  	/*
>  	 * The VDD bit needs a power domain reference, so if the bit is
>  	 * already enabled when we boot or resume, grab this reference and
> -- 
> 2.34.1

-- 
Ville Syrjälä
Intel
