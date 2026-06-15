Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D893D413221
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544018; cv=none; b=ipqYOpD7MhcbStlXM+NMwSjTTLX/MiN00DPc30qm/bT4K7Iy+8NSelr9VPVkcdKY/7css5Cqslt3Ntg4tm98/0xlOrScNTprTqvohZdkP/8io00H0WZW2NbodE1C+TL3QObDLoHwq89X8yTTGasdOQnYbEZCxA8JmD3Fnaew4Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544018; c=relaxed/simple;
	bh=nQMx2xjGZaZEzcyc9EI+7IwbIbnUSvIu+pCMMd6vvZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XHXCPvNAYDWZFfWUJeY1HqPnWdAKNz6qncUGuu89cUtSv0BuzZwnHMuH0ydanVdh5+w5ewO1QiicL4ScyBpWKj+Av/XNihoJ6vJxrEd/4hRuKHVsgb8egWnDYhPbVIwWR0t1bLffUWX/C9ZgeyxPwDCOaN4Tfjz9hjqpNo9JI60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hKUeDI5I; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hKUeDI5I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781544016; x=1813080016;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=nQMx2xjGZaZEzcyc9EI+7IwbIbnUSvIu+pCMMd6vvZo=;
  b=hKUeDI5IFXSylJCQRQgp+nUAoSPTdpNvKn6SYjWppIgWVH49Z58B0MxL
   +c7wQuJGuyu4xLhKiIrfT6rWUa/9+kmLxnTurmUwq5PPINN9UrHkamDY9
   0R3d/yvM/SmxDWG77esUbSjSzIBinQ92VJFAjGl8cQmfJNArptYqok77y
   L2k73Xb3dfj29Eejfmku9q7/wdCEST5opsxW5AnAB35LkyxYwEml4QxHv
   MHIWrsf9W5E+uhr01zHIkdHlB5wrkvdtGUckbspEGj607nx0CK0m8JWQF
   EydENjxv3UrE8lx0Qs+tAGsIw/9esAaMK0keDFBepFt7pYY/ygtiHGtkC
   g==;
X-CSE-ConnectionGUID: VajzAFaXR+mCR943o2fuDA==
X-CSE-MsgGUID: ZlutY/rWTaS4EihfmSDhsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82190227"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="82190227"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 10:20:15 -0700
X-CSE-ConnectionGUID: 4SJVtSTeTWymtaGZDr0jrQ==
X-CSE-MsgGUID: ZflAhESTQC6HTBWUV7/b5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="285647746"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 10:20:14 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: chafi <chafiprc@foxmail.com>, intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org, Yu Zhang
 <chafiprc@foxmail.com>
Subject: Re: [PATCH 1/3] drm/i915/dsi: Program TRANS_HSYNC register for
 dual-link command mode
In-Reply-To: <tencent_41186F27AF2C13B660C14ED5E6E14759800A@qq.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <tencent_41186F27AF2C13B660C14ED5E6E14759800A@qq.com>
Date: Mon, 15 Jun 2026 20:20:10 +0300
Message-ID: <ed14be7c1d21587af9731726ae1c311c4ad6602c@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 08 Jun 2026, chafi <chafiprc@foxmail.com> wrote:
> From: Yu Zhang <chafiprc@foxmail.com>
>
> The TRANS_HSYNC register programming and dual-link hsync halving is
> placed inside the is_vid_mode() guard, so it only runs for video mode.
> Command mode dual-link DSI also needs this:
>
> 1. Without TRANS_HSYNC written, the hardware retains an inconsistent
>    state, leading to errors on modeset:
>
>    [drm] *ERROR* mismatch in hw.pipe_mode.crtc_hsync_start
>    (expected 2762, found 1380)
>
> 2. The hsync_start/end are not halved for each link, so the hardware
>    stores per-link values while the software expects full values.
>
> Fix this by moving the dual-link hsync halving and TRANS_HSYNC write
> outside the is_vid_mode() guard, making them unconditional for all
> DSI modes.
>
> Fixes: d1aeb5f399d9 ("drm/i915/icl: Configure DSI transcoder timings")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yu Zhang <chafiprc@foxmail.com>

Hey, I see you've sent a few paches for DSI. Nice! Do you actually have
the hardware? Would be great to have a bug report over at [1] with the
dmesg (with drm debugs enabled) so we can see the failure mode and exact
hardware details.


BR,
Jani.


[1] https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html


> ---
>  drivers/gpu/drm/i915/display/icl_dsi.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
> index 951f30a64..c667d5941 100644
> --- a/drivers/gpu/drm/i915/display/icl_dsi.c
> +++ b/drivers/gpu/drm/i915/display/icl_dsi.c
> @@ -950,7 +950,6 @@ gen11_dsi_set_transcoder_timings(struct intel_encoder *encoder,
>  			       HACTIVE(hactive - 1) | HTOTAL(htotal - 1));
>  	}
>  
> -	/* TRANS_HSYNC register to be programmed only for video mode */
>  	if (is_vid_mode(intel_dsi)) {
>  		if (intel_dsi->video_mode == NON_BURST_SYNC_PULSE) {
>  			/* BSPEC: hsync size should be atleast 16 pixels */
> @@ -961,18 +960,18 @@ gen11_dsi_set_transcoder_timings(struct intel_encoder *encoder,
>  
>  		if (hback_porch < 16)
>  			drm_err(display->drm, "hback porch < 16 pixels\n");
> +	}
>  
> -		if (intel_dsi->dual_link) {
> -			hsync_start /= 2;
> -			hsync_end /= 2;
> -		}
> +	if (intel_dsi->dual_link) {
> +		hsync_start /= 2;
> +		hsync_end /= 2;
> +	}
>  
> -		for_each_dsi_port(port, intel_dsi->ports) {
> -			dsi_trans = dsi_port_to_transcoder(port);
> -			intel_de_write(display,
> -				       TRANS_HSYNC(display, dsi_trans),
> -				       HSYNC_START(hsync_start - 1) | HSYNC_END(hsync_end - 1));
> -		}
> +	for_each_dsi_port(port, intel_dsi->ports) {
> +		dsi_trans = dsi_port_to_transcoder(port);
> +		intel_de_write(display,
> +			       TRANS_HSYNC(display, dsi_trans),
> +			       HSYNC_START(hsync_start - 1) | HSYNC_END(hsync_end - 1));
>  	}
>  
>  	/* program TRANS_VTOTAL register */

-- 
Jani Nikula, Intel
