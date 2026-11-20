Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186783;
	b=JtHP5oeEZqvRARzAvng/UhQ7bu0pJgNwBFdOSYSw28o+176lv8jfa4+XhONm13+0I07Z
	 IXCmZh7tqr3+YpYUpzqIdGtCoJRDXC6cmqHLulH3x1d+zavqqIUV5RF6wizP47LdolNvs
	 jHxmMxKH4kOQEGgug1kpkPQfoz3BTKgcm8200fsA+PKANgQ20dlnX3u+LUc8ApAo7gk20
	 Apg8Yc0zTzRCol/2AtzoJw7YgdlPczYTJBsvrjNwC2pFID9oXSOHY0HOzcZJE6lkh5IVt
	 oq3r3/sm8uMEWkt1RpNWWRZo9hapJ+EHi+uMSo7ZqPyEoq8l1hkVSsR2cNbn4C2Apcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186783;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 In-Reply-To:Organization:References:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=hbMppDtKlF5sRBKrK6ST7ODTxHzVwJIFDjSQ5L9P1Ww=;
	b=NsSn5j1q4UfasLdSE9MNbIwMMNEiMZXp/ZGulFK8K8a9zonjStcnq4l1vLg5wUvcXZEk
	 hxVIix7RMo/3xJFvMzVQp9j3yJmW7wQaNkZzB2aA3Q+FziSXT1F9b/6U6yctNAE6Jq0dj
	 SiDV7Lw+nLq9GyNWjwOTT77phceXTlpvGvOQqlsqdzYSm0dle3li7xNVtiUQ3VC94Ly77
	 94tNK+eUwyqCjQPWuufTe0OOtRLA0wILYFqMHayCNbsgbASFsHhT1SSWAk2h40zLQx69b
	 Ii6ftPjWyBQv1dpylahYzrVdu6847i52yDA3kPfPfmeo6AuzK31pIddibdff51B3vcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ey9pIuUu;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8B76074D25
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 14:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F8B76074D25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ey9pIuUu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795186784; x=1826722784;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Mc3TQKAkEPj8M41125eC6jV4jm6ka5QqlciR82U0d0A=;
  b=ey9pIuUucVkgPOU0wNjSWvAEDnE0/fGDcjfxHB/oBeZppXn5mRpTIKMg
   U2/xAFrm/giqvQvWIGwuM+quDxkmRIVBSz5D93qx/t0rXhYuIyS2hLGrA
   l7UVsc/o197Gt7Y0RffZDs1y5HeMBwo5n5HT12XFCVhUqrREcTR3r40NM
   jgQbVoxF8kQI88p0k8MRqnKPD4sAYjBkKBfAZ+LeBBOHta1J6TFj3gWY1
   0D/Gxs4dMPOG+lum6liDMtXWtgqHly98NO7fpF8MS1csKlk8JqarYeABz
   PmaPnd36pTv1ZirUohOi8/YCgkMx42Pr1/lx04LMecL1vAOkj6cTHe+Qr
   A==;
X-CSE-ConnectionGUID: IxJUdGy3TPylu7Z2gCDZMQ==
X-CSE-MsgGUID: 5jTdnhAAQsu6gOJUJ7cPEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3957345"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="3957345"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 06:59:43 -0800
X-CSE-ConnectionGUID: CePIaZ/8QtGCDW4RJeYaGQ==
X-CSE-MsgGUID: 2EjZiOmxRKavxvyIeF5VfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10611337"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.250])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 06:59:41 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jouni =?utf-8?Q?H=C3=B6gander?= <jouni.hogander@intel.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Cc: Jouni =?utf-8?Q?H=C3=B6gander?= <jouni.hogander@intel.com>, Animesh
 Manna
 <animesh.manna@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/alpm: Track the configured transcoder lifetime
In-Reply-To: <20261120112446.1562267-1-jouni.hogander@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261120112446.1562267-1-jouni.hogander@intel.com>
Date: Fri, 20 Nov 2026 16:59:38 +0200
Message-ID: <df6089c2500a2f5d3b79bcaa2ac6a440222f7f4e@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Nov 2026, Jouni H=C3=B6gander <jouni.hogander@intel.com> wrote:
> ALPM disable can access a stale transcoder when ALPM was not configured
> for the current modeset, causing unclaimed register accesses during
> pipe teardown.
>
> Record the transcoder only when programming ALPM and invalidate it
> after disable. Check it under the ALPM lock to avoid register accesses
> on repeated or unconfigured disables.
>
> Fixes: 504766382edb ("drm/i915/lobf: Disintegrate alpm_disable from psr_d=
isable")
> Cc: Animesh Manna <animesh.manna@intel.com>
> Cc: <stable@vger.kernel.org> # v6.16+
> Signed-off-by: Jouni H=C3=B6gander <jouni.hogander@intel.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/i915/display/intel_alpm.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/=
i915/display/intel_alpm.c
> index f54b29e193ee9..105006ca6be7f 100644
> --- a/drivers/gpu/drm/i915/display/intel_alpm.c
> +++ b/drivers/gpu/drm/i915/display/intel_alpm.c
> @@ -46,6 +46,7 @@ bool intel_alpm_is_alpm_aux_less(struct intel_dp *intel=
_dp,
>  void intel_alpm_init(struct intel_dp *intel_dp)
>  {
>  	mutex_init(&intel_dp->alpm.lock);
> +	intel_dp->alpm.transcoder =3D INVALID_TRANSCODER;
>  }
>=20=20
>  static int get_silence_period_symbols(const struct intel_crtc_state *crt=
c_state)
> @@ -549,6 +550,7 @@ static void lnl_alpm_configure(struct intel_dp *intel=
_dp,
>  	alpm_ctl |=3D ALPM_CTL_ALPM_ENTRY_CHECK(crtc_state->alpm_state.check_en=
try_lines);
>=20=20
>  	intel_de_write(display, ALPM_CTL(display, cpu_transcoder), alpm_ctl);
> +	intel_dp->alpm.transcoder =3D cpu_transcoder;
>  	mutex_unlock(&intel_dp->alpm.lock);
>  }
>=20=20
> @@ -556,7 +558,6 @@ void intel_alpm_configure(struct intel_dp *intel_dp,
>  			  const struct intel_crtc_state *crtc_state)
>  {
>  	lnl_alpm_configure(intel_dp, crtc_state);
> -	intel_dp->alpm.transcoder =3D crtc_state->cpu_transcoder;
>  }
>=20=20
>  void intel_alpm_port_configure(struct intel_dp *intel_dp,
> @@ -733,17 +734,23 @@ void intel_alpm_lobf_debugfs_add(struct intel_conne=
ctor *connector)
>  void intel_alpm_disable(struct intel_dp *intel_dp)
>  {
>  	struct intel_display *display =3D to_intel_display(intel_dp);
> -	enum transcoder cpu_transcoder =3D intel_dp->alpm.transcoder;
> +	enum transcoder cpu_transcoder;
>=20=20
>  	if (DISPLAY_VER(display) < 20 || !intel_dp->alpm_dpcd)
>  		return;
>=20=20
>  	mutex_lock(&intel_dp->alpm.lock);
>=20=20
> +	cpu_transcoder =3D intel_dp->alpm.transcoder;
> +	if (cpu_transcoder =3D=3D INVALID_TRANSCODER)
> +		goto unlock;
> +
>  	intel_de_rmw(display, ALPM_CTL(display, cpu_transcoder),
>  		     ALPM_CTL_ALPM_ENABLE | ALPM_CTL_LOBF_ENABLE, 0);
> +	intel_dp->alpm.transcoder =3D INVALID_TRANSCODER;
>=20=20
>  	drm_dbg_kms(display->drm, "Disabling ALPM\n");
> +unlock:
>  	mutex_unlock(&intel_dp->alpm.lock);
>  }

--=20
Jani Nikula, Intel
