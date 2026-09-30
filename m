Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2164F55B5
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776501; cv=none; b=EPvdLQYapfr+ggYQvnB7OlsxUiJypnxk5Ef3o5eCzRZvTTsThORAHJzZGl0fU3LM5j9P9OZhhyWObOqixkKfExMVE7qrv5I5TGVESGIlOt4XnVgDq1VNUfA/lZUXp8D1VSiO4yQ1q51xjLVSbwO/4qte1I2U1U69Yyi+PHFIJR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776501; c=relaxed/simple;
	bh=dzXnPVKKsfDXpEP6gWDmoVQdChtocWqreUrxOZB1ZO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bC1/0wKxFyK/5yC1zvJVjdSVv9X76voNFdV7PqGk8UcaD6dAqfdqvnjhhkWB1mOXEJ61JbtClL4bd2ILyqM/2f4FqIHaiET3Am2FwphFNJN863cmqrqHUGGD/vBHOtMIl+H321b2fHVcZKYgK8VeEOk4MkpDI0mYi4cowq6CZbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=FgInYH5H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CLordJIe; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="FgInYH5H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CLordJIe"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BFDE67A079A;
	Wed, 30 Sep 2026 09:54:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 30 Sep 2026 09:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790776482; x=1790862882; bh=f3025BozWU
	HE/l6kWWrP74Alx766xgYNMySd5+pCSmc=; b=FgInYH5Ht0EA2+zo7rwZ+mFHYd
	sZWWhTTenQKicL5MecisZYLph20awJFMrz7FvoTAltTUVV8hzSpQz28iH6mst4ed
	cp1bptE0THSuDgghJMvhPK4ppZX+s/VikQG6Hf825OAUPLqTABGqP3OGWNBb4C2D
	hOZgCq9eqFGqcPrCpYLnKBFA+KkcM10b9mEJvSK/AOY1Gdu6RqMvhDkpvvpkz/p9
	Jd6TbURU8ITnHjTpJw3qB56UucfxNqxh/NQRG6gZ4mPzHnvvewffH+l8MLw64yjh
	79elHSm2kXK51j9BE9sRCZAZNR2CRvul9fOsPSevsukD3JWi8W9dmAmrypnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790776482; x=1790862882; bh=f3025BozWUHE/l6kWWrP74Alx766xgYNMyS
	d5+pCSmc=; b=CLordJIebMB2LEYbZZYqPcD2F0GEJ7TOvmipTrXyYIayZkaZoYL
	6ubSV+hX/JZz8htFWg6HanbdYCG5WQIgyUwJ40kwrG/vToX7eklJxF4pQcsBJ48P
	oH9XElSka7blN1FvCiMZic7MLHklkSF2K3NVeXtiAZx+MvD+hoI3D3FbO4YOEidt
	w9fuMcUBh+l44vMl1xtt7mRtHwF9rrD47TgySCaRc5+CybPAJayw4cQZPo6LK2Ks
	WYm1OeD5PrwM5CE/zH8tuAofplE8aWi5GyykS4MJrgr09PrI+NckZtkxlHwmqmZv
	EaKPEk1vqNzD5Rnfwa2RZ+5q3BfN+vMM92g==
X-ME-Sender: <xms:ohS9ak33_eJ7iGIcS1TclwbSo1SGKwbQi3PcopRxFweo6gt4nBw-7g>
    <xme:ohS9asdRa--lZwTBZSuR0FFdomS4l_vBYdHjhXt5BeSNYL0PNqk6FG9csbr3BuRfu
    TaaH7rrV0Jq7lMN8UNFEWI34n5e0387Vin8rQ1tafr4goT5hQ>
X-ME-Received: <xmr:ohS9akMToSrgFY3aIsdMo6QrCytjM7VBaC4EgZQy-jfGB8b_XSBOs_5tax2VkSmWLaCEL6VZl56z3HlUEwFVy7yPipfnbgges_0JHWviB38>
X-ME-Proxy-Cause: dmFkZTGW3U9+lkwS0eF9Swmd9uNpOXYPUWMDeHtYWZ56OPeiRABqCpl8zTAFxdkKN6UWEE
    3aNLcgOdFDtlFBcpfxCpo9vWR7UFcyYMp+qNXWcOz9DO40yCREFf24XvjvN+12vBvSxHcJ
    8eNbo8trfVeteH8feoeq4IBaoPUmbAVPuARIFNmQ+1LuANUqCXa3jP3kvC7IlsvzC3LrfS
    5xZa8UUaHg2G4Wp3Oh56THEWmDMfdbz6w5g3kjEhbYegr1wUA49tlyQzohZzUXQ+eZmjxQ
    ZKE/Tgjf90/LAPWsT1XixroikLJUbN5PQYSIERaTVIbURjd6HB5SraQD9GlXBf2dbyZRae
    kQb+Owqq3QnfVm1gTQTESUI6oa1CXupSwx6dGGGpQnvzZzFows4wR6TUy3jpgFH3CBE6JU
    3h9soE7tPYr5gHJnkSp4nftQfmeWvlVJKobOiQ25ED2BNd5w9vynJCeTOxw4+Za0SJnfc7
    cDw/L32nQ0/XiVNc1kIzggyz96P5d6sAtU1faE3ZCuFOxWi3TQbBm3E7WzW3O4krCBbzAI
    RG2HqdFu/wfvJCJN3X41yDrfambY+AiWl8MStEVA5fwOukUbc24NEQOuhccTA8rhTeDM/W
    VPc+v3dl1LWVzfp8kjq5QL5Kg9Ulm2jKVB6AcMa3ifZJwpdXTJyZQvWgKatA
X-ME-Proxy: <xmx:ohS9aoXOZ01Z3ZHkz2945iA4go7npf8PH5k_0GcM1IudT5I2b8Vpnw>
    <xmx:ohS9akx9zLNVRc9pPAxuYEXQkcoj5B9Xs-p4gdEeXmh0DZSWCx6ORA>
    <xmx:ohS9an9jLjoxxtz22BZUdVWs6MeY6ra2H107lrH24NOqit7SjURFBA>
    <xmx:ohS9ah_9sLBOw2HmWeJEhpvSCp9Hs3J0A0OjUQR0y9KOSO4Egj8cfg>
    <xmx:ohS9asuRzWI4_MaYSTj8OrFjWULfBiLASd08tCutOPNYDC84RxWr8WVj>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 09:54:42 -0400 (EDT)
Date: Wed, 30 Sep 2026 15:54:37 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Imre Deak <imre.deak@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH 6.12.y] drm/i915/dp_mst: Fix configuring TUs for a
 disconnected stream
Message-ID: <2026093033-ravioli-rectify-dc1e@gregkh>
References: <2026092957-hardening-slingshot-e073@gregkh>
 <20260929193021.823447-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929193021.823447-1-sashal@kernel.org>

On Tue, Sep 29, 2026 at 03:30:21PM -0400, Sasha Levin wrote:
> From: Imre Deak <imre.deak@intel.com>
> 
> [ Upstream commit a443e0b8d647c1401b110d9f919d8c6cb8607260 ]
> 
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
> 
> The disconnection can happen either via the whole topology getting
> disconnected or via only the given stream's port getting disconnected.
> Check for both of these conditions separately, as a connector gets
> unregistered after a link disconnect event only in a deferred way.
> 
> Cc: stable@vger.kernel.org # v6.10+
> Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16073
> Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16384
> Reviewed-by: Luca Coelho <luciano.coelho@intel.com>
> Signed-off-by: Imre Deak <imre.deak@intel.com>
> Link: https://patch.msgid.link/20260907174413.741851-2-imre.deak@intel.com
> (cherry picked from commit ee00f8fbb2b202002ab90834e02e9ba372773a36)
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> [ adapted MST field accesses to `mst_port` and `mst_mgr`, reusing a local `crtc` lookup. ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/gpu/drm/i915/display/intel_dp_mst.c  | 21 ++++++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_dp_mst.h  |  2 ++
>  drivers/gpu/drm/i915/display/intel_link_bw.c |  7 ++++---
>  3 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> index eeaedd979354b..eb0ee759569c3 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> @@ -2053,6 +2053,27 @@ bool intel_dp_mst_crtc_needs_modeset(struct intel_atomic_state *state,
>  	return false;
>  }
>  
> +bool intel_dp_mst_stream_disconnected(struct intel_atomic_state *state,
> +				      const struct intel_crtc *crtc)
> +{
> +	struct intel_connector *connector;
> +
> +	connector = get_connector_in_state_for_crtc(state, crtc);
> +	if (!connector)
> +		return false;
> +
> +	if (!connector->mst_port)
> +		return false;
> +
> +	if (!connector->mst_port->mst_mgr.mst_state)
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
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.h b/drivers/gpu/drm/i915/display/intel_dp_mst.h
> index 8343804ce3f8d..261a97e24d91e 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.h
> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.h
> @@ -27,6 +27,8 @@ int intel_dp_mst_atomic_check_link(struct intel_atomic_state *state,
>  				   struct intel_link_bw_limits *limits);
>  bool intel_dp_mst_crtc_needs_modeset(struct intel_atomic_state *state,
>  				     struct intel_crtc *crtc);
> +bool intel_dp_mst_stream_disconnected(struct intel_atomic_state *state,
> +				      const struct intel_crtc *crtc);
>  void intel_dp_mst_prepare_probe(struct intel_dp *intel_dp);
>  bool intel_dp_mst_verify_dpcd_state(struct intel_dp *intel_dp);
>  
> diff --git a/drivers/gpu/drm/i915/display/intel_link_bw.c b/drivers/gpu/drm/i915/display/intel_link_bw.c
> index e7a9b860fac6e..da4f0186311ba 100644
> --- a/drivers/gpu/drm/i915/display/intel_link_bw.c
> +++ b/drivers/gpu/drm/i915/display/intel_link_bw.c
> @@ -32,11 +32,12 @@ void intel_link_bw_init_limits(struct intel_atomic_state *state,
>  	limits->force_fec_pipes = 0;
>  	limits->bpp_limit_reached_pipes = 0;
>  	for_each_pipe(display, pipe) {
> +		struct intel_crtc *crtc = intel_crtc_for_pipe(i915, pipe);
>  		const struct intel_crtc_state *crtc_state =
> -			intel_atomic_get_new_crtc_state(state,
> -							intel_crtc_for_pipe(i915, pipe));
> +			intel_atomic_get_new_crtc_state(state, crtc);
>  
> -		if (state->base.duplicated && crtc_state) {
> +		if ((state->base.duplicated && crtc_state) ||
> +		    intel_dp_mst_stream_disconnected(state, crtc)) {
>  			limits->max_bpp_x16[pipe] = crtc_state->max_link_bpp_x16;
>  			if (crtc_state->fec_enable)
>  				limits->force_fec_pipes |= BIT(pipe);
> -- 
> 2.53.0
> 
> 

Breaks the build :(
