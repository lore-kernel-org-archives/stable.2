Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C894630D410;
	Wed, 16 Sep 2026 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570472; cv=none; b=oadlEboruGBYb8SpvAwiJblPejZvHwBpml7xQBKVoar/22tuPkKTz/bK0ZpC/cPRBMmCgkjyFtLuQ10Vk1Rxl/48DaJRPEvhF46qBxC4ZbW6j8bbNhMzh0I/6C4M/hjmLHzhSXBTv6UtXOQJKeHN6dbb6TFzpEQVu82hwYsZ+Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570472; c=relaxed/simple;
	bh=hGC+EVI4Y0/YtilopqcCFxb7GcD2lK3DAQ+eE7bTOd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqEIAOAN8gyJkYGyldsfNomX4KwB1gmiRLcD4O/wb3xt/SCoBjw+nn1AHBFT9HQ8ahDQtTeOwZ17iNtnUXNBJZu8sg4UwkDZTaFzKfjCm1tv/RBArL65q6ePHb5ZIZzin8fwfuo9+jAXNppEyjYc1GB8sIpvcHI8TVsZ6WoZf3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=imxkUhaY; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="imxkUhaY"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3E52A558;
	Wed, 16 Sep 2026 16:52:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789570367;
	bh=hGC+EVI4Y0/YtilopqcCFxb7GcD2lK3DAQ+eE7bTOd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=imxkUhaYqBRwTsCLCU/fusfDyOLm0nkX1ecwfWqRGYk7yTmtrEiLFx5eYXQLurwKq
	 r3b1Irx2RFqxAMPzlXgeTp9mHD22fwp+pk4qUYSoVKLDqaCQkhKM3bZDGVeUVjUMTU
	 XHdjLRA5lbdXGn8Lr13Jmgczs3HOL3wPWzw835rU=
Date: Wed, 16 Sep 2026 17:54:27 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: airlied@gmail.com, andrzej.hajda@intel.com, architt@codeaurora.org,
	bbrezillon@kernel.org, dri-devel@lists.freedesktop.org,
	eric@anholt.net, jernej.skrabec@gmail.com, jonas@kwiboo.se,
	linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, neil.armstrong@linaro.org, rfoss@kernel.org,
	simona@ffwll.ch, tzimmermann@suse.de, stable@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: cdns-dsi: Fix runtime PM leak in
 cdns_dsi_bridge_atomic_pre_enable()
Message-ID: <20260916145427.GA40507@killaraus.ideasonboard.com>
References: <20260916100405.2012604-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916100405.2012604-1-vulab@iscas.ac.cn>

On Wed, Sep 16, 2026 at 10:04:05AM +0000, Wentao Liang wrote:
> cdns_dsi_bridge_atomic_pre_enable() resumes the DSI controller with
> pm_runtime_get_sync() and returns early with a WARN_ON() when the
> resume fails.  pm_runtime_get_sync() increments the runtime PM usage
> count even when it fails, so returning without dropping the reference
> leaks it and prevents the device from ever suspending again once the
> error has been hit.
> 
> Drop the runtime PM reference with pm_runtime_put_noidle() on the
> resume failure path before returning.
> 
> Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> index 0dd85e26248c..fca4528edfa6 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> @@ -733,8 +733,10 @@ static void cdns_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>  	 * enable their streams.
>  	 */
>  
> -	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0))
> +	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0)) {
> +		pm_runtime_put_noidle(dsi->base.dev);
>  		return;
> +	}

Anything wrong with pm_runtime_resume_and_get() ?

>  
>  	new_bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
>  	if (WARN_ON(!new_bridge_state))

-- 
Regards,

Laurent Pinchart
