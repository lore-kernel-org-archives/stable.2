Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B485349AD
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790173898; cv=none; b=pHNPO6MXk3nNkv5QyzUSBhJXf0WlkhXBRproyfjJhKwRZDriS02IGAyhtK8p+g58GtHrKseUkqiJGKb/vwt8Nd29WbQLKrIWc0sztT74hyI/wyabdXXEvd49N+EA2eNNXCjHQksWnjY4yEhMoTs0eeTezzTrNj+8EVh6/uaSvKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790173898; c=relaxed/simple;
	bh=LDJEYtV0SngvYz/ZC1T+PrxPc5QT1XPUcczHifZP2as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzLSPFprZ5RJK2KMjmnVH1KN7N2o4qz+vQtgKNh7ARD6HNh1djirC2haGgdXYvX8+gHj6zapIRXfacMYwxiG2q8ZqkQ7vsD2StJwB0TdcM8tm8YafXUc7/VSEJhHBwpYN2d5QoeLI+fbOkox+t2iTvbqUuaPDZZgNbdkYLepl9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iKIrWRb6; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iKIrWRb6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790173896; x=1821709896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LDJEYtV0SngvYz/ZC1T+PrxPc5QT1XPUcczHifZP2as=;
  b=iKIrWRb6u3GYxMqRlZPi1H03x4O4EdeNXGk/yAp4eMURwZLPiO+OvwQx
   RIMerJhaKOX2oTiEPuUL7KbGDJqGaZJBTFs+QA15xdp7BoYxDHG5xqgUb
   xwlCrBj9rXuIBBGRYa/D5D2bX7S97EpEshmwu5+JczLsipf6SOTaOBB20
   TMNEfsnYntWuY+lsSlqX/FZR4zq/HPYdN18RCzHw8sq/YhNAYhKfxuHrz
   yCKSLcm++za1KjROM1R69nnvlvMWRnRXzcGGQ/yTA5PSBzDBrV/4a7PZ5
   nDVUnlvgnY7tCeBrVYbiNRnNNwva4H5ekKwIRyRoEyVX+pZnC4HSV4AgY
   Q==;
X-CSE-ConnectionGUID: Xcbs9zWHTA2O2eETaxQhJg==
X-CSE-MsgGUID: lAtqAihVTgyL0y1LayqVMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="1381955"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="1381955"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 07:31:35 -0700
X-CSE-ConnectionGUID: 6NYeMNvxQJ2ptNfChDK8DQ==
X-CSE-MsgGUID: znp6td/0SzWR+yY7Of8ZFA==
X-ExtLoop1: 1
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.46])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 07:31:33 -0700
Date: Wed, 23 Sep 2026 17:31:30 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Xizhe Tang <xizheTang2005@163.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/i915/dp: Only send AS SDP when VRR/CMRR is
 enabled or PR !async
Message-ID: <arPiwvEgpLC5efE0@intel.com>
References: <20260923195200.21362-1-xizheTang2005@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260923195200.21362-1-xizheTang2005@163.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland

On Thu, Sep 24, 2026 at 03:51:59AM +0800, Xizhe Tang wrote:
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

The real problem is that intel_vrr_possible() no longer does what
it says on the tin. I think we have three different things
intel_vrr_possible() gets used for currently:

- intel_dp_needs_as_sdp() actually wants to know whether variable VRR
  timings are possible or not, and it wants to know that without
  actually looking at uapi.vrr_enabled in order to avoid changes to
  the guardband when uapi.vrr_enabled changes
- _intel_psr_min_set_context_latency() might want to know whether we
  could end up using the VRR timing generator or not. Not 100% sure
  about this one though
- everything in intel_vrr.c just wants to know whether we should program
  the VRR timing generator registers or not. These are the only places
  where the current intel_vrr_possible() actually looks correct, albeit
  with a bad function name

>  }
>  
>  static void intel_dp_compute_as_sdp(struct intel_dp *intel_dp,
> --
> 2.47.0

-- 
Ville Syrjälä
Intel
