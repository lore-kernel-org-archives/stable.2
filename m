Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9028F3E51F5
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166922; cv=none; b=dUF60zTHpuU30JHIZWdDTaAw9T9r9ge50AUTG+SpdWkdbZIVXyh8/cTu6DPIvgGUEJxyh0KsAaIhNAeazGnLtZG0m3y8EI88vkmZywJGx2UiI3fYeonWi9nP2zRIvJXxODraV71wFnjzDPLoUyQP7vBw6H+abtfD0lZ6jIUoFwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166922; c=relaxed/simple;
	bh=NUst59Nj86ONo8O+t+3UCjdvz8gS3JO/OxFem3r1dlM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HA7w39mscmxXPjj3X9PdQ9cl7fBhn9+B11Fb8m9zTw6hHZdxytLGK0JiPI5h5teKlyYswXFKyttPyUwQq74unfTjYnXzWrB2JTL2GiphoXoQmzLmzkC33URPZ0XzBr3c5Eg6wtB4O/RcAU0wJcvtP1k+04ShY9SWjXmiyys8OZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fkjzzac9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fkjzzac9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790166920; x=1821702920;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=NUst59Nj86ONo8O+t+3UCjdvz8gS3JO/OxFem3r1dlM=;
  b=fkjzzac9OFCkv9Gn6un84J7accr/AdjbGJ+KQjujllHPZc0fOltqEMvL
   PxntBVy6xznu2NwgUxs63EL6eQKsNiKNERytp0JKBJiSDDWKHMwumAv2l
   ZIn5V0awpuqHjZRR2TfsMKYPvBOqUTZ7EyZM9B9Rfnki3zucvNgL9UU8/
   Pe4JJxjOq6AbpaUK1Mj28fToLSnKYCFa5ckt+/XipnIlM4WymUY7p1KC7
   JTpGGebHPgVUenJ/rW3X8iD7mmHZg9qTpuleO3rbT2gA3zXtC5z7xHu6W
   GQU1jrVxfnRXAMkzrqb7EtHNfJ4/tMp3AdF3+iveH0tjkra3dZjPt6k+1
   w==;
X-CSE-ConnectionGUID: utWj7qZXTbuSbgK6zOFnpw==
X-CSE-MsgGUID: hTuHADiTRn+d60/7s9QKLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="101444992"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="101444992"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 05:35:05 -0700
X-CSE-ConnectionGUID: mUSEFwBUQyGvdI447caV8A==
X-CSE-MsgGUID: QaEsu21YSmSrACMamdgJEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4855983"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.253])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 05:35:02 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Xizhe Tang <xizheTang2005@163.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: Xizhe Tang <xizheTang2005@163.com>, Ville =?utf-8?B?U3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/i915/dp: Only send AS SDP when VRR/CMRR is
 enabled or PR !async
In-Reply-To: <20260923195200.21362-1-xizheTang2005@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260923195200.21362-1-xizheTang2005@163.com>
Date: Wed, 23 Sep 2026 15:34:59 +0300
Message-ID: <45cd4f2b396b208b976bd946ae0efe45a1c0c09c@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 24 Sep 2026, Xizhe Tang <xizheTang2005@163.com> wrote:
> A Panther Lake eDP panel that advertises VRR in EDID but runs at a fixed
> refresh rate has received an Adaptive-Sync SDP since commit 6a1712052859
> ("drm/i915/dp: Enable AS SDP whenever VRR is possible or PR !async").
> On this panel the first modeset at boot is vertically streaked.
>
> intel_vrr_possible() is only crtc_state->vrr.flipline != 0. Fixed-refresh
> timings program flipline too:
>
> 	intel_vrr_compute_fixed_rr_timings():
> 		/* For fixed rr,  vmin = vmax = flipline */
> 		crtc_state->vrr.flipline = crtc_state->vrr.vmin;
>
> intel_vrr_compute_config() takes that path when VRR is not actually
> enabled (uapi.vrr_enabled is false, or vmin == vmax). Then
> intel_dp_needs_as_sdp() is true with `vrr: no, fixed rr: yes`, and
> intel_dp_compute_as_sdp() programs DP_AS_SDP_AVT_FIXED_VTOTAL.
>
> Gate the terminal condition on the states that consume the SDP:
> crtc_state->vrr.enable (VRR) or crtc_state->cmrr.enable (CMRR / FAVT).
> Leave the Panel Replay aux-less-ALPM early-return from the same commit
> unchanged.
>
> CMRR is still hard-disabled (is_cmrr_frac_required() has "|| true"), so
> cmrr.enable stays false today and the OR is a no-op versus v1 at fixed
> refresh. intel_vrr_compute_cmrr_timings() sets cmrr.enable without
> vrr.enable; the OR keeps the FAVT branch reachable when CMRR is re-enabled.
>
> This is a no-op while VRR is actually active. It does not fix Adaptive
> Sync = Always corruption, nor the non-atomic SDP update named by the
> #FIXME above intel_dp_compute_as_sdp(). Trailer is Link:, not Closes:.
>
> Tested on LENOVO 21VG (PTL eDP, 8086:b080), v7.2.6-200.fc44.x86_64,
> rebuilding only xe.ko with this hunk:
>
>   Adaptive Sync = Never (Tested-by): vrr: no, fixed rr: yes,
>   infoframes enabled: 0x6 (no BIT(3)), zero Adaptive-Sync SDP, panel
>   clean. This boot: six s2idle suspend/resume cycles, all clean.
>
>   Adaptive Sync = Always (not Tested-by): vrr: yes, vmin 2016 / vmax 8064,
>   infoframes enabled: 0xe, Adaptive-Sync SDP still sent. Panel
>   appearance on Always is not claimed.
>
>   CMRR / FAVT: not tested.
>
> On the same panel, Adaptive Sync = Never, first modeset, drm.debug=0xe:
>
>   7.1.13 (clean):     infoframes enabled: 0x4  (VSC only)
>   7.2.4  (streaked):  infoframes enabled: 0xc  (VSC + AS SDP,
>                       operation mode 1 = DP_AS_SDP_AVT_FIXED_VTOTAL)
>
>   Later dumps of those boots are 0x6 vs 0xe; each non-zero bad mask is
>   good | BIT(3).
>
> Changes in v2:
> - OR crtc_state->cmrr.enable so CMRR still gets AS SDP (v1 review).
>   At fixed refresh v2 matches v1.
>   v1: https://lore.kernel.org/r/20260923052937.22817-1-xizheTang2005@163.com

I've received a bug report, patch v1, and four (!) copies of patch v2
within just hours.

Please have more patience.

The commit message appears to be a long-winded description of *what* the
code does, which is mostly uninteresting and frankly difficult to
understand, and lacks proper rationale of *why* the change is being made
and why it might help with the issue.


BR,
Jani.



>
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9252
> Fixes: 6a1712052859 ("drm/i915/dp: Enable AS SDP whenever VRR is possible or PR !async")
> Cc: stable@vger.kernel.org # 7.2.x
> Signed-off-by: Xizhe Tang <xizheTang2005@163.com>
> Tested-by: Xizhe Tang <xizheTang2005@163.com> # v7.2.6, PTL eDP, Adaptive Sync=Never
> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -3115,8 +3115,9 @@ static bool intel_dp_needs_as_sdp(struct intel_dp *intel_dp,
>  	if (intel_psr_needs_alpm_aux_less(intel_dp, crtc_state) &&
>  	    !intel_psr_pr_async_video_timing_supported(intel_dp))
>  		return true;
>  
> -	return intel_vrr_possible(crtc_state);
> +	return crtc_state->vrr.enable ||
> +	       crtc_state->cmrr.enable;
>  }
>  
>  static void intel_dp_compute_as_sdp(struct intel_dp *intel_dp,
> --
> 2.47.0
>

-- 
Jani Nikula, Intel
