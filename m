Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794396967;
	b=GaLr8eQ8LPwTIulC5LLsJio3A921/Mzb5PCgLGaVqEF9LOnngbbrz1sn9C7GFWEh5akE
	 nGdqcSL3/lVtKcFinNM/30A2IUr/T5rh5gvuny69PI0+lRWoBzAWLqb5w3VJbiMLp/Iz/
	 zUnmuxoIittxYiDHbUtSajMPGUykEzRorMMQ9uKaE/m7naaMoj/IuKzSnNr3AYV+ucgzn
	 sdfO487EeaQknIFNYM2riLktt96LvLvxL0qvSfJ72hME+8d1xvolUXMKGFlCpGsa5flh8
	 Pgx03S8Uiwkna5APpHfl+VD/ZgYG+6uP/qrvV4t2Q+27fF53Ivc6KMYKvMY/u7elEbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794396967;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Patchwork-Hint:Organization;
	bh=pnx+p3Y9Shn7ZHsPG+IsaJx7bL8tR8Q1UtvkOV4XwKc=;
	b=sbY4ohf/r9apFR6ti1LCJBt6aQw+py93eb20EI8s4R6CQJesYwoL91CCl/aB1RHrOpSS
	 e/S2c8XivKa1r1C5ilzFfiosCdxrtYSGS7naij6ktRw0cuSUV6FJitJPWxS7K/0W9yZ+Z
	 8+9VMI4pfjk+M9bGfchJZNOe6Yyod1BAZrqZX8ynhpkarG0+W9N4MZINhAEaXCHNsvn50
	 gTkXoKhMfgmHbvUlYrKbrWgc6yJ4svdpSOB4X6oXIAAnCpc+BqUZBfPygh8U7kO0rDCVG
	 1RbOQOtma0QkK/ZykU4RLGExzwXZtH/s//Vqt4IxKPobM56Q6QUL1zCLziK6A1nNRUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=crLYjJvg;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C4D606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 11:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21C4D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=crLYjJvg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794396966; x=1825932966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VR/ULc1l89b0Tm5UZIMhrFP8YU8fjtZ2wGba6ZkP2pg=;
  b=crLYjJvgsseoq3kfP5tO1BvIXUI50vX2pMKcQD188jwu7YEFyDYx8GTJ
   o2SGMv8mZTtsxiP2FO8ab8a/ERG51oSVjP4O/Gr0U/RiTF8DcJZXmLAeb
   m+BwmCx36j2+rR3vxkM5Qy+sxmi6/Oe632mCLkw7Atzcz6uhYeNFPtvaP
   GqyfhJKFYLV5/WxTNvKyV0NvlTPzJw+jaIqfCXqNrhSA3Brgmmcx/zwfS
   zfhOaeoe4SXSilITSCGrBIhA1XbaddipWRntadQYygksbfsYjxMQfQ8Xg
   0tHz03RLt5LrfdAs7XD5WFTRygSxUfbpEwt4cJst/Z8FBUXzVx7czk5de
   A==;
X-CSE-ConnectionGUID: IB5Q3kNcRd+iBgkbJy9fkw==
X-CSE-MsgGUID: +dx5p4wjQlyWxwYGa0qyvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3059529"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3059529"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 03:36:05 -0800
X-CSE-ConnectionGUID: SemcX0+rT2qqB/WsrzV6gw==
X-CSE-MsgGUID: a03hI+ZJTyGaUcmhpWXN6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8290207"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 03:36:04 -0800
Date: Wed, 11 Nov 2026 13:36:00 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	stable@vger.kernel.org, Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>
Subject: Re: [PATCH] drm/i915/dip: Write the DIP header last with SDP
 transmission lines
Message-ID: <avRTIDPwI3uOHQyo@intel.com>
References: <20261111103542.4093652-1-chaitanya.kumar.borah@intel.com>
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
In-Reply-To: <20261111103542.4093652-1-chaitanya.kumar.borah@intel.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland

On Wed, Nov 11, 2026 at 04:05:42PM +0530, Chaitanya Kumar Borah wrote:
> On platforms with SDP transmission line registers, the packets anchored
> to them are double buffered in the transcoder (TC) clock domain. The packet
> registers are in the core display (CD) clock domain and the whole packet is
> clock crossed on the write of the header (dword 0), so Bspec requires the
> data to be programmed first and the header last.
> 
> hsw_write_infoframe() writes the header first, so the packet is crossed
> before its payload is in place and the previous payload keeps being sent.
> This hits the AS SDP, and the VSC SDP whenever an AS SDP is enabled, which
> is whenever VRR is possible since commit 6a1712052859 ("drm/i915/dp: Enable
> AS SDP whenever VRR is possible or PR !async"). With CMN_SDP_TL, enabled by
> commit bfa597238073 ("drm/i915/dip: Enable Common SDP Transmission line"),
> it also hits the GMP and VSC SDPs: on NVL, entering HDR on an eDP panel
> leaves the image discoloured and scaled until the headers are rewritten.
> 
> Write the payload, including the ECC zero fill, first and the header last
> on platforms with EMP_AS_SDP_TL. CD domain packets have no ordering
> requirement and Bspec recommends the same order for all packets, so use it
> for all of them. Older platforms keep the current order.
> 
> Bspec: 75640, 71197, 74384
> Fixes: e1123e617e51 ("drm/i915/vrr: Program EMP_AS_SDP_TL for DP AS SDP")
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17732
> Cc: <stable@vger.kernel.org> # v6.17+
> Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> Cc: Suraj Kandpal <suraj.kandpal@intel.com>
> Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> ---
> 
> Notes:
>     Fixes tag rationale
>     
>     The Fixes tag points at commit e1123e617e51 ("drm/i915/vrr: Program
>     EMP_AS_SDP_TL for DP AS SDP"). The AS SDP has been written header first
>     since it was added by commit 8845021b7331 ("drm/i915/display: Read/Write
>     Adaptive Sync SDP"), but EMP_AS_SDP_TL, which holds the double buffer
>     point and the transmission line of the AS SDP on BMG and LNL+, was only
>     programmed from that commit on. From then on the driver relies on that
>     register to anchor the AS SDP, and the VSC SDP whenever an AS SDP is
>     enabled, and the programming note of the register asks for the packet
>     data first and the header last. The two later commits cited in the commit
>     message only widened the exposure: the first enabled the AS SDP whenever
>     VRR is possible and the second added CMN_SDP_TL for the GMP and VSC SDPs.
>     
>     Alternatives considered:
>      - 6a1712052859 (v7.2): AS SDP on whenever VRR is possible. The PTL
>        report is fixed by reverting it. Narrower than the spec argument, as
>        it only covers v7.2 and later.
>      - bfa597238073 (7.4): CMN_SDP_TL. The NVL regression, verified on
>        hardware, but covered by the older tag as every kernel with it also
>        has e1123e617e51.
>      - 8845021b7331 (v6.10): first header first AS SDP write, but
>        EMP_AS_SDP_TL was not programmed until e1123e617e51, so exposure
>        before it could not be shown.
>     
>     Not verified:
>      - The failure was observed on NVL with CMN_SDP_TL (rewriting the GMP and
>        VSC headers makes the panel recover). The AS SDP and the VSC SDP with
>        an AS SDP on BMG, LNL and PTL follow from the Bspec requirement and
>        were not reproduced here.
>      - No reproduction on kernels older than v7.2.
>      - Stable backports need the HAS_EMP_AS_SDP_TL gate adapted, as it is
>        defined in intel_dip.h, which is new in 7.4.
> 
>  drivers/gpu/drm/i915/display/intel_hdmi.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
> index 4ec0db8d93fb..3ecf017b3176 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
> @@ -51,6 +51,7 @@
>  #include "intel_cx0_phy.h"
>  #include "intel_ddi.h"
>  #include "intel_de.h"
> +#include "intel_dip.h"
>  #include "intel_display_driver.h"
>  #include "intel_display_regs.h"
>  #include "intel_display_types.h"
> @@ -524,6 +525,15 @@ void hsw_write_infoframe(struct intel_encoder *encoder,
>  	const u32 *data = frame;
>  	enum transcoder cpu_transcoder = crtc_state->cpu_transcoder;
>  	intel_reg_t ctl_reg = HSW_TVIDEO_DIP_CTL(display, cpu_transcoder);
> +	/*
> +	 * On platforms with the SDP transmission line registers some of the
> +	 * packets are double buffered in the transcoder clock domain, and the
> +	 * packet is clock crossed on the write of the header (dword 0). Program
> +	 * the payload first and the header last, so that the whole packet gets
> +	 * crossed. Packets double buffered in the core display clock domain
> +	 * have no ordering requirement, so use the same order for all of them.
> +	 */
> +	bool header_last = HAS_EMP_AS_SDP_TL(display);
>  	int data_size;
>  	int i;
>  	u32 val = intel_de_read(display, ctl_reg);
> @@ -535,18 +545,21 @@ void hsw_write_infoframe(struct intel_encoder *encoder,
>  	val &= ~hsw_infoframe_enable(type);
>  	intel_de_write(display, ctl_reg, val);
>  
> -	for (i = 0; i < len; i += 4) {
> +	for (i = header_last ? 4 : 0; i < len; i += 4)

IMO just always use the "write header last" approach. 

>  		intel_de_write(display,
>  			       hsw_dip_data_reg(display, cpu_transcoder, type, i >> 2),
> -			       *data);
> -		data++;
> -	}
> +			       data[i >> 2]);

Making 'i' the dword index rather than the byte index might make this
code a bit nicer. The only slight concern is whether len%4!=0 might
be true. Maybe just have the caller always align it for good measure.
But let's stick to the byte based thing for now to avoid adding more
noise to this patch, and clean it up later.

>  	/* Write every possible data byte to force correct ECC calculation. */
>  	for (; i < data_size; i += 4)
>  		intel_de_write(display,
>  			       hsw_dip_data_reg(display, cpu_transcoder, type, i >> 2),
>  			       0);
>  
> +	if (header_last)
> +		intel_de_write(display,
> +			       hsw_dip_data_reg(display, cpu_transcoder, type, 0),
> +			       data[0]);
> +
>  	/* Wa_14013475917 */
>  	if (!(IS_DISPLAY_VER(display, 13, 14) && crtc_state->has_psr &&
>  	      !crtc_state->has_panel_replay && type == DP_SDP_VSC))
> -- 
> 2.50.1

-- 
Ville Syrjälä
Intel
