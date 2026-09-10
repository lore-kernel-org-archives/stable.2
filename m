Received: from coelho.fi (coelho.fi [88.99.146.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3133C404BE3
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.146.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033825; cv=none; b=QTTq26RYIOzVe4eM624H+QacdxyPIURva1NBKp6/BtRvIVqduLdXdZ01Ytf6wcQVajjd56aSZ98rNCtdMvYX8NzFM6ietWd/CzKrTLrfECEhAIqA8SY6rkwq8q3o3SRJ9htWlG+jg3d23Wh+A06ZZZPm9p9fG+S8fv8s/M1CqD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033825; c=relaxed/simple;
	bh=pAw5/B9uoYhXqHg6L0GJgCZ+iyJOEyco+Hx4bNZgEWQ=;
	h=Message-ID:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Subject; b=qkVtnTVYUqyo55+e3JLL02Vl/Wm5wVOs1PFpnfF1LpSmn+ucb4KbIDzVddAA8KNygplWaV/0zkTSLEGSoFvyMcwMnTNlgNe8Ntv00lck5mIJrBZyLvXnNkJcwQTQNXPVXXXTy9VkLOSm8P0zzY7Hl5q0XuynoKKoPbWnae3hO4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coelho.fi; spf=pass smtp.mailfrom=coelho.fi; arc=none smtp.client-ip=88.99.146.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coelho.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelho.fi
Received: from 91-158-54-113.elisa-laajakaista.fi ([91.158.54.113] helo=[192.168.100.133])
	by coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <luca@coelho.fi>)
	id 1x4bQA-00000003Pd0-2MzU;
	Thu, 10 Sep 2026 12:50:19 +0300
Message-ID: <676822730026eb7eed7513dbc8f1461f24c6a1a7.camel@coelho.fi>
From: Luca Coelho <luca@coelho.fi>
To: Imre Deak <imre.deak@intel.com>, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org
Date: Thu, 10 Sep 2026 12:50:16 +0300
In-Reply-To: <20260907174413.741851-2-imre.deak@intel.com>
References: <20260907174413.741851-1-imre.deak@intel.com>
	 <20260907174413.741851-2-imre.deak@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Level: 
Subject: Re: [PATCH 2/2] drm/i915/dp_mst: Fix configuring TUs for a
 disconnected stream

On Mon, 2026-09-07 at 20:44 +0300, Imre Deak wrote:
> During an atomic commit after all the MST stream CRTC state is computed
> the driver ensures that the sum of TUs of all the streams on a given MST
> topology link is within limits (63 for 8b10 and 64 for 128b132b). For a
> disconnected stream the DRM MST core's BW verification doesn't ensure
> this, because the topology state it uses for this is destroyed as soon
> as the stream (i.e. MST connector/port) is disconnected. The driver
> should keep the link state valid even for such disconnected streams, as
> userspace may disable them one-by-one only in a deferred way. Ensure the
> link's sum of TUs stays within limits in this case by simply reusing the
> maximum link BPP limit from the stream's (i.e. CRTC's) old state.
>=20
> The disconnection can happen either via the whole topology getting
> disconnected or via only the given stream's port getting disconnected.
> Check for both of these conditions separately, as a connector gets
> unregistered after a link disconnect event only in a deferred way.
>=20
> Cc: stable@vger.kernel.org # v6.10+
> Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16073
> Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16384
> Signed-off-by: Imre Deak <imre.deak@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp_mst.c  | 21 ++++++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_dp_mst.h  |  2 ++
>  drivers/gpu/drm/i915/display/intel_link_bw.c |  3 ++-
>  3 files changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/dr=
m/i915/display/intel_dp_mst.c
> index 20766b6c0bcfa..0c362784afe4a 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> @@ -2172,6 +2172,27 @@ bool intel_dp_mst_crtc_needs_modeset(struct intel_=
atomic_state *state,
>  	return false;
>  }
> =20
> +bool intel_dp_mst_stream_disconnected(struct intel_atomic_state *state,
> +				      const struct intel_crtc *crtc)
> +{
> +	struct intel_connector *connector;
> +
> +	connector =3D get_connector_in_state_for_crtc(state, crtc);
> +	if (!connector)
> +		return false;
> +
> +	if (!connector->mst.dp)
> +		return false;
> +
> +	if (!connector->mst.dp->mst.mgr.mst_state)
> +		return true;
> +
> +	if (drm_connector_is_unregistered(&connector->base))
> +		return true;
> +
> +	return false;
> +}
> +
>  /**
>   * intel_dp_mst_prepare_probe - Prepare an MST link for topology probing
>   * @intel_dp: DP port object
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.h b/drivers/gpu/dr=
m/i915/display/intel_dp_mst.h
> index ab09b487c6bb5..8ce89242c05c9 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.h
> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.h
> @@ -28,6 +28,8 @@ int intel_dp_mst_atomic_check_link(struct intel_atomic_=
state *state,
>  				   struct intel_link_bw_limits *limits);
>  bool intel_dp_mst_crtc_needs_modeset(struct intel_atomic_state *state,
>  				     struct intel_crtc *crtc);
> +bool intel_dp_mst_stream_disconnected(struct intel_atomic_state *state,
> +				      const struct intel_crtc *crtc);
>  void intel_dp_mst_prepare_probe(struct intel_dp *intel_dp);
>  bool intel_dp_mst_verify_dpcd_state(struct intel_dp *intel_dp);
> =20
> diff --git a/drivers/gpu/drm/i915/display/intel_link_bw.c b/drivers/gpu/d=
rm/i915/display/intel_link_bw.c
> index b47474a3e9fec..e71e76d6fd3e0 100644
> --- a/drivers/gpu/drm/i915/display/intel_link_bw.c
> +++ b/drivers/gpu/drm/i915/display/intel_link_bw.c
> @@ -64,7 +64,8 @@ void intel_link_bw_init_limits(struct intel_atomic_stat=
e *state,
>  			intel_atomic_get_new_crtc_state(state, crtc);
>  		int forced_bpp_x16 =3D get_forced_link_bpp_x16(state, crtc);
> =20
> -		if (state->base.duplicated && crtc_state) {
> +		if ((state->base.duplicated && crtc_state) ||
> +		    intel_dp_mst_stream_disconnected(state, crtc)) {
>  			limits->max_bpp_x16[pipe] =3D crtc_state->max_link_bpp_x16;
>  			if (intel_dsc_enabled_on_link(crtc_state))
>  				limits->link_dsc_pipes |=3D BIT(pipe);

I think Sashiko's NULL-dereference commment is valid.  Can you check
it?

--
Cheers,
Luca.
