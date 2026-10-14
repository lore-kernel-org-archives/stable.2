Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B974E73BE;
	Wed, 14 Oct 2026 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791976758; cv=none; b=EMXdOJdpTxtwiPzQvOw6p6R1DMlwv5gq35pdfpyi0dQ8w0lBdVlMjLCilMj/lL6uIVsPDW9W2HXRJMVvn8NT1F6epshbD9hBGgQ+9ZG2lzOvJzMDsv4Lvcy245SOsli3oT2NFA91S5mU5rC/AZruJ9KTNPGgCLeLzbu2OfaWlNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791976758; c=relaxed/simple;
	bh=mILDQ0beEHugYrDGAp7RHecafUChyKoMmsDB5orFUMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVkYrnmNKqFK09514KCpI3g3kKPZuRp1Z9uR0k7mNo1/IF4zzjR+g013JyHuPh3rqfydAd8z9tP+naT8x8wCGA2xmmCcxZka0wFh8yXCpE7cQ/Mr890UbZAYugyhKHlJqIo6xElH8C9cfvMx5mx2bOSamsfa8GQZW6uuXfnqqy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DwSntr5L; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DwSntr5L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791976757; x=1823512757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mILDQ0beEHugYrDGAp7RHecafUChyKoMmsDB5orFUMU=;
  b=DwSntr5LpLTsTFOCVWxoa3MtwIB51N0QQdqer4CzkmI8X/e9qdlTShv1
   yKXGdT7rWIXFDcITPK/WKu3M+YtZfK9uDAoZNw42BE5BkijEPpoW2yU0y
   XPX9rl3umSHfEKo7NX2djpP1pmSwpv/HXCAxMc46K3co6BckFWV7GlIxu
   8lJoFYwamXHSF7lAdr/gT8o/RM/ZeyETYi35ERwRe++EgVr1ygcxi0Q9n
   GNgrT3wqsSrbPUrqQXF2m/7f9M+JRsbbruE0IF5Mr+gYZZHzqbFy006LY
   JoRj7PyOwHjJQPyJopOXkkC2+gXLvFgVMehnhe+YMGfZh+ZLpuLzQyUBn
   A==;
X-CSE-ConnectionGUID: Nw3I40fjT6yHL0AqWhm9eA==
X-CSE-MsgGUID: IpOJOs9zSMCzwB2epY/VoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="622478"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="622478"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 04:19:16 -0700
X-CSE-ConnectionGUID: zXUXL0ZSTwu5nDmhUHEoog==
X-CSE-MsgGUID: AfkKKCLKQMqOSDGxji1TyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1372069"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.13])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 04:19:11 -0700
Date: Wed, 14 Oct 2026 14:19:09 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: hex@aleph0.ai
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	intel-gfx@lists.freedesktop.org,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jouni =?iso-8859-1?Q?H=F6gander?= <jouni.hogander@intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/psr: Send a frame change notification for async
 flips
Message-ID: <as9lLU0VnFW6JLKf@intel.com>
References: <20261013-fix-psr-async-trans-push-v1-1-ee79bf31b66f@aleph0.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261013-fix-psr-async-trans-push-v1-1-ee79bf31b66f@aleph0.ai>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland

On Tue, Oct 13, 2026 at 05:16:07PM +0200, Vladyslav Yamkovyi via B4 Relay wrote:
> From: Vladyslav Yamkovyi <hex@aleph0.ai>
> 
> On platforms using TRANS_PUSH for PSR frame-change notifications,
> intel_pipe_update_end() exits early for asynchronous flips, before sending
> the push. The register-based notification is disabled on these platforms,
> and an ORIGIN_FLIP frontbuffer flush does not force PSR to exit.
> 
> This can leave an accepted async flip without a completion event after
> PSR2 enters DEEP_SLEEP. On Panther Lake, scanout freezes and the kernel
> reports "[CRTC:152:pipe A] flip_done timed out". Intel IGT kms_async_flips
> reproduces the failure with the compositor inactive when a 200 ms idle
> interval is inserted before an asynchronous atomic flip.
> 
> Send the PSR frame-change notification after plane programming and before
> releasing the existing PSR lock. Restrict the push to CRTC states that use
> TRANS_PUSH for PSR, leaving other async flips and the synchronous and DSB
> paths unchanged.
> 
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9582
> Fixes: 129a4da11707 ("drm/i915/psr: Use TRANS_PUSH to trigger frame change event")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM sparse smatch
> Signed-off-by: Vladyslav Yamkovyi <hex@aleph0.ai>
> ---
> Based on drm-tip (2026-10-13); also applies to v7.3-rc7.
> 
> Runtime-tested on Panther Lake (xe, eDP-1, 2880x1800) with Ubuntu-based
> 7.3.0-rc6 kernels, before and after this fix. IGT kms_async_flips,
> async-flip-with-page-flip-events-tiled-atomic, dynamic subtest
> pipe-A-eDP-1-4-rc-ccs, fails with Flip Timeout before the fix and passes
> afterwards. An LD_PRELOAD interposer inserts one 200 ms idle interval
> before the eighth async atomic commit without changing its request or
> flags. Both runs enter PSR2 Early Transport DEEP_SLEEP with selective
> fetch enabled before that commit.
> 
> Clang 23.1.2, W=1 builds and Sparse/Smatch checks of the CRTC, PSR and VRR
> translation units for i915 and Xe produced no new diagnostics.
> 
> OpenAI Codex (GPT-6-Astra) assisted diagnosis, reproducer and fix
> development, validation and patch preparation, following requests to
> reproduce the freeze independently, trace its driver cause and prepare a
> tested upstream fix. I take direct responsibility for this contribution,
> have carefully reviewed the change and ensured rigorous local testing.
> ---
>  drivers/gpu/drm/i915/display/intel_crtc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_crtc.c b/drivers/gpu/drm/i915/display/intel_crtc.c
> index 10ed9bdfee76..8ef24cddbaa6 100644
> --- a/drivers/gpu/drm/i915/display/intel_crtc.c
> +++ b/drivers/gpu/drm/i915/display/intel_crtc.c
> @@ -736,8 +736,16 @@ void intel_pipe_update_end(struct intel_atomic_state *state,
>  
>  	drm_WARN_ON(display->drm, new_crtc_state->use_dsb);
>  
> -	if (new_crtc_state->do_async_flip)
> +	if (new_crtc_state->do_async_flip) {
> +		/*
> +		 * LNL+ uses TRANS_PUSH for PSR frame-change notifications.
> +		 * Async flips skip the vblank path below, but still need to
> +		 * notify PSR after programming the new surface address.
> +		 */
> +		if (intel_psr_use_trans_push(new_crtc_state))
> +			intel_vrr_send_push(NULL, new_crtc_state);

This will make the behaviour of async flips + VRR inconsistent
between platforms where trans push is used for PSR vs. platforms
where it's not used. We don't want that.

So either we want to start doing trans pushes for all async
flips+VRR cases, or we want to disable the PSR trans push usage
when async flips are happening. The latter would be the safer
option since the mailboxy trans push usage this would cause
hasn't been done before. The vblank evasion code does try to
handle it, but it's not actually tested.

>  		goto out;
> +	}
>  
>  	trace_intel_pipe_update_end(crtc, end_vbl_count, scanline_end);
>  
> 
> ---
> base-commit: eb1bf4700d3b25a1a1e670ef31cc06969fa08019
> change-id: 20261013-fix-psr-async-trans-push-bfa6550270c7
> 

-- 
Ville Syrjälä
Intel
