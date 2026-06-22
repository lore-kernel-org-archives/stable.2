Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000D2395ACA;
	Mon, 22 Jun 2026 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782135265; cv=none; b=naJYblXFPN3JaNVi3OaChgP6bXlVbFaD6gOfLxAKRA/hrIPXtuaombZ7kdwFWYSCIvyedNe6UABMUnaCTSjbraeLHKqyFzFElV96jSSiEpiaRjonHh+tXBhuheMsjCATOTmDHB8u+Q6UHpnSrzs8UTXD/VdvfVp53Qi8AvcdeMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782135265; c=relaxed/simple;
	bh=JJ3rlqN0C0VeC+P3O2EW2SHdp+5nesw2FXlEGZcZraw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bSFIFfn7e1rHKGXUt9C4O+LV6OYka+oKCxxSNVrQOsjzUTSQ1cK8a2WRSdq69jeN5Qg0P1BZQYrUwEbZ8H3imnAfur4fXhEsnoZnnI/tapjPtt8NY6FCJnvxKtTntRVlXp+DKD00MBf7Pfs7fNKjhvCqKBR9bnAyFu5LKxLa4tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gE+tlzKn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gE+tlzKn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782135262; x=1813671262;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=JJ3rlqN0C0VeC+P3O2EW2SHdp+5nesw2FXlEGZcZraw=;
  b=gE+tlzKnJvZkkMii0TvDfTsxLtlky9+gN5fSTI9XDlAcJ5eYWg+ocs1g
   2smGVbOds2cFGqpQ6OcAvc48h6XltCbW9rm8Lzi8+2rBV7/a5UANCO8E1
   ggNn+nHUw2p0nMRhIw2/FEtiQzmz/UuZjeBqI0Hf0ue3qgzSoh0DZ9Wo1
   fon036mpwWy38vNwkhSRk4zH3nH85Xo/SR2ngu8doINasrgBVFSuS3SqI
   bDdEpA+Z3FMYJPObgxXLdf52iKfROh3y8LiQXvVNeXwMeWFdMrFno6aYl
   OLQ4y0CDzWPxSmZlI/nTnldmxKmjQLowIXd9fY+F4QSYFpyWFJ0NMVGKK
   A==;
X-CSE-ConnectionGUID: i4onayWXSIa519OeRi/M1w==
X-CSE-MsgGUID: fhm+wKSJS3Sc9BeHD5R2BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="82867926"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="82867926"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 06:34:21 -0700
X-CSE-ConnectionGUID: zNPS5jY9T8u6Nm5O7dn+Kw==
X-CSE-MsgGUID: aEMdhIINQTq/L8a4sqj4KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="246299546"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.82])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 06:34:16 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, hns@goldelico.com,
 zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 akemnade@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/fb-helper: Only consider active CRTCs for vblank
 sync
In-Reply-To: <20260622113434.682292-1-tzimmermann@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260622113434.682292-1-tzimmermann@suse.de>
Date: Mon, 22 Jun 2026 16:34:12 +0300
Message-ID: <395f15bb770b4be0ffeeb09e7cdeef49340f910c@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 22 Jun 2026, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Only synchronize fbdev output to the vblank of an active CRTC. Go over
> the list of CRTCs and pick the first that matches. Fixes warnings as
> the one shown below
>
> [   77.201354] WARNING: drivers/gpu/drm/drm_vblank.c:1320 at drm_crtc_wait_one_vblank+0x194/0x1cc [drm], CPU#1: kworker/1:7/1867
> [   77.201354] omapdrm omapdrm.0: [drm] vblank wait timed out on crtc 0
>
> This currently happens if the fbdev output is not on CRTC 0.
>
> Atomic and non-atomic drivers require distinct code paths. As for other
> fbdev operations, implement both and select the correct one at runtime.
>
> Not finding an active CRTC is not a bug. Do not wait in this case, but
> flush the display update as before.
>
> v2:
> - move look-up code into separate helper
> - support drivers with legacy modesetting
> v1:
> - see https://lore.kernel.org/dri-devel/1c9e0e24-9c4a-4259-8700-cf9e5fd60ca3@suse.de/
>
> Co-authored-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: d8c4bddcd8bcb ("drm/fb-helper: Synchronize dirty worker with vblank")
> Tested-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> Closes: https://bugs.debian.org/1138033
> Cc: <stable@vger.kernel.org> # v6.19+
> ---
>  drivers/gpu/drm/drm_fb_helper.c | 71 ++++++++++++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index 7b11a582f8ec..cbf0a9a7b8e5 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -225,16 +225,85 @@ static void drm_fb_helper_resume_worker(struct work_struct *work)
>  	console_unlock();
>  }
>  
> +static int find_crtc_index_atomic(struct drm_fb_helper *helper)
> +{
> +	struct drm_device *dev = helper->dev;
> +	struct drm_plane *plane;
> +
> +	drm_for_each_plane(plane, dev) {
> +		const struct drm_plane_state *plane_state;
> +		const struct drm_crtc *crtc;
> +
> +		if (plane->type != DRM_PLANE_TYPE_PRIMARY)
> +			continue;
> +
> +		plane_state = plane->state;
> +		if (plane_state->fb != helper->fb || !plane_state->crtc)
> +			continue; /* plane doesn't display fbdev emulation */
> +
> +		crtc = plane_state->crtc;
> +		if (!crtc->state->active)
> +			continue;
> +		if (drm_WARN_ON_ONCE(dev, crtc->index > INT_MAX))
> +			continue; /* driver bug */

I take it this is here because crtc->index is unsigned, and this
function returns int so you can have negative error codes. Ditto the
other function below.

I feel like this is something that should be checked once somewhere, if
that. I think adding arbitrary checks like this invites more arbitrary
checks everywhere. crtc->index is supposed to be invariant over the
lifetime of the CRTC.

BR,
Jani.

> +
> +		return crtc->index;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int find_crtc_index_legacy(struct drm_fb_helper *helper)
> +{
> +	struct drm_device *dev = helper->dev;
> +	struct drm_crtc *crtc;
> +
> +	drm_for_each_crtc(crtc, dev) {
> +		struct drm_plane *plane = crtc->primary;
> +
> +		if (!crtc->enabled)
> +			continue;
> +		if (!plane || plane->fb != helper->fb)
> +			continue; /* CRTC doesn't display fbdev emulation */
> +		if (drm_WARN_ON_ONCE(dev, crtc->index > INT_MAX))
> +			continue; /* driver bug */
> +
> +		return crtc->index;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int drm_fb_helper_find_crtc_index(struct drm_fb_helper *helper)
> +{
> +	struct drm_device *dev = helper->dev;
> +	int crtc_index;
> +
> +	mutex_lock(&dev->mode_config.mutex);
> +
> +	if (drm_drv_uses_atomic_modeset(dev))
> +		crtc_index = find_crtc_index_atomic(helper);
> +	else
> +		crtc_index = find_crtc_index_legacy(helper);
> +
> +	mutex_unlock(&dev->mode_config.mutex);
> +
> +	return crtc_index;
> +}
> +
>  static void drm_fb_helper_fb_dirty(struct drm_fb_helper *helper)
>  {
>  	struct drm_device *dev = helper->dev;
>  	struct drm_clip_rect *clip = &helper->damage_clip;
>  	struct drm_clip_rect clip_copy;
> +	int crtc_index;
>  	unsigned long flags;
>  	int ret;
>  
>  	mutex_lock(&helper->lock);
> -	drm_client_modeset_wait_for_vblank(&helper->client, 0);
> +	crtc_index = drm_fb_helper_find_crtc_index(helper);
> +	if (crtc_index >= 0)
> +		drm_client_modeset_wait_for_vblank(&helper->client, crtc_index);
>  	mutex_unlock(&helper->lock);
>  
>  	if (drm_WARN_ON_ONCE(dev, !helper->funcs->fb_dirty))

-- 
Jani Nikula, Intel
