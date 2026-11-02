Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632313;
	b=IOtitm18USAU1O3KxjyNGk3cVAaKF0AgaQasphxDO3+ZWuYFWCSQ/Nh7zYEH/wwEjOR/
	 hqW+fvGFgFIgLRB3D5+Vw699nkF7aF6WcoRO2PYhC/iq6NhPs8Geh4mcAgQRDVf73tGtM
	 Tg5CEsBAFkmXC1oWYBywOy8ZpjN/JRMOD6yef6rHaL9wG6C2cZWBM7ETbUk+AQ+doswbu
	 j4PlQPqeXOG3ZNMXFBfBxDAKYgbZROiEogbd7egYkq4a0DYLNgdRuh6gOuFM1zL19B/Ou
	 ZKPRrY/DmOaCNMMqsf2EiwsQNMPSm6BxAAm9wLauKWNJ+tZKAdsc1IAZVN46JlIJpTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632313;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Patchwork-Hint:Organization;
	bh=2/uq2w5qsdU3XkiAfIjdGg0EWb0SbhEqc6DCVolqH0U=;
	b=To+HH81fUACJbeDUdM8zW/rbkKLKngvFmWjRIbDvLZ3MYr54It/9YO0w36VKUnwTwPuv
	 Or8PLYzW+CBW/nq5263WzSJ/ouroDhX9YmAL20BICeOkmgPP3RGoHZ2bVoUtIOaxZIEd8
	 k7xOGl4luIpn4eCGhYB9Uvu/ajFHahD0ixJQAdX4e14sr65gXRe1p9ivONd2JB7FHMUAg
	 k1pkw1rqaDhc+c8yafsf76e9p7dQ0eVNkpwlUUoWa+tQm9UwgRnrhNtoMmEUM0H7XB3yH
	 asqP4DqQhl/TxHyEflVkfzm43IsxOfoVGUw1J+bsAMXCzDMIk9paQ1A+3OefNl2Gu7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f2oaTzZa;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0222060AB1B7
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0222060AB1B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f2oaTzZa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793632311; x=1825168311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=A1Z8YVADStasxeVGsvKlCx9NW4+VyRaCaoIqgq9WuaI=;
  b=f2oaTzZaWQqmk9rkZSoItVo7cUqrW8SFgTljfYBp18JZY3qyi790Ifg9
   BeuGr99V9EVbDP0KBixdtm7MRg/Fuc+VXPzOXRa7HH3CmIVDTJpCx7TSi
   Pug2jM5ZVgayce20DLYtBTRrDZEDzzg1s/VUuQnzuUFW5XL5hrM81x/bv
   lps6F8WJEJHj5vWrCXp+9aBNwbGerpaRXWnKgO1GxmIa+Egc+rKyBAl3A
   HTub9YwLFPu8jGa9I9Tab6VMWWXJsomyhePaeI1RLYi7cMH8s5gsPPvgg
   osBNTd4a5L9CvH/F+CEztIGNVhFMtIL+ItVsuvNG9MINHjhOoJlydycdD
   w==;
X-CSE-ConnectionGUID: s6xZ5tfgQVCdNbBlyy++/Q==
X-CSE-MsgGUID: 7wMYKVhjQrGxCTF5bkmIkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2338030"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2338030"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 07:11:51 -0800
X-CSE-ConnectionGUID: 14KMMsgeT4qr9BW02qAynQ==
X-CSE-MsgGUID: 0sF9zJAHQhaktVbw3e4vzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6315995"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 07:11:48 -0800
Date: Mon, 2 Nov 2026 17:11:43 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	airlied@gmail.com, simona@ffwll.ch, javierm@redhat.com,
	louis.chauvet@bootlin.com, dri-devel@lists.freedesktop.org,
	sashiko-reviews@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] drm/vblank: Restart enabling vblank timer on possible
 deadlock
Message-ID: <auioL8zR9O5u4TCF@intel.com>
References: <20261102143919.1672293-1-tzimmermann@suse.de>
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
In-Reply-To: <20261102143919.1672293-1-tzimmermann@suse.de>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland

On Mon, Nov 02, 2026 at 03:38:52PM +0100, Thomas Zimmermann wrote:
> Return -EDEADLK when trying to cancel a running hrtimer as part of
> enable_vblank(). Reacquire vblank_time_lock and try again.
> 
> The vblank helper drm_vblank_disable_and_save() and the vblank IRQ
> handler hold the spin lock vblank_time_lock at some point. This
> can result in a deadlock if vblank timer's disable code in
> drm_crtc_vblank_cancel_timer() calls hrtimer_cancel() directly: the
> helper wais for the timer function to complete and the timer function
> waits for the helper to release vblank.time_lock.
> 
> drm_crtc_vblank_cancel_timer() works around this problem by calling
> hrtimer_try_to_cancel() instead. For re-enabling the vblank timer,
> drm_crtc_vblank_start_timer() must wait for the vblank timer to stop.
> It runs into the same deadlock problem while waiting for the timer
> function to complete.
> 
> The solution to this problem is to release and reacquire the spin
> lock vblank_time_lock if hrtimer_try_to_cancel() signals a running
> timer function. Releasing the lock allows for the timer function to
> make progress.
> 
> Signal the possible deadlock with -EDEADLK and perform the necessary
> steps. No other driver uses -EDEADLK in their enable_vblank, so the
> change should not interfere.
> 
> Tested with bochs on qemu.
> 
> Closes: https://lore.kernel.org/dri-devel/20260914111129.300691F00898@smtp.kernel.org/
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Louis Chauvet <louis.chauvet@bootlin.com>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.19+
> ---
> I also tried to move hrtimer_cancel() out of the critical section. The
> result was fairly fragile. So returning an error and re-acquiring the
> lock was the easier solution.
> ---
>  drivers/gpu/drm/drm_vblank.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 5162250e8813..135efde86298 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -1182,10 +1182,12 @@ static int __enable_vblank(struct drm_device *dev, unsigned int pipe)
>  static int drm_vblank_enable(struct drm_device *dev, unsigned int pipe)
>  {
>  	struct drm_vblank_crtc *vblank = drm_vblank_crtc(dev, pipe);
> -	int ret = 0;
> +	int ret;
>  
>  	assert_spin_locked(&dev->vbl_lock);
>  
> +retry:
> +	ret = 0;
>  	spin_lock(&dev->vblank_time_lock);
>  
>  	if (!vblank->enabled) {
> @@ -1199,7 +1201,11 @@ static int drm_vblank_enable(struct drm_device *dev, unsigned int pipe)
>  		ret = __enable_vblank(dev, pipe);
>  		drm_dbg_core(dev, "enabling vblank on crtc %u, ret: %d\n",
>  			     pipe, ret);
> -		if (ret) {
> +		if (ret == -EDEADLK) {
> +			spin_unlock(&dev->vblank_time_lock);
> +			cpu_relax();
> +			goto retry;
> +		} else if (ret) {
>  			atomic_dec(&vblank->refcount);
>  		} else {
>  			drm_update_vblank_count(dev, pipe, 0);
> @@ -2232,11 +2238,14 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
>  			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>  	} else {
>  		/*
> -		 * Timer should not be active. If it is, wait for the
> -		 * previous cancel operations to finish.
> +		 * Timer should not be running. If it is, signal cancellation
> +		 * again and restart to release locks.
>  		 */
> -		while (hrtimer_active(&vtimer->timer))
> -			hrtimer_try_to_cancel(&vtimer->timer);

Why do you even have to cancel the timer here? Just let it run?

> +		if (hrtimer_try_to_cancel(&vtimer->timer) == -1) {
> +			scoped_guard(spinlock_irqsave, &vtimer->interval_lock)
> +				vtimer->interval = 0;

Does this interval_lock serve some actual purpose? Looks like it's just
protecting a single variable, and there are no read-modify-writes
happening to it that I can see.

> +			return -EDEADLK;
> +		}
>  	}
>  
>  	drm_calc_timestamping_constants(crtc, &crtc->mode);
> -- 
> 2.56.0

-- 
Ville Syrjälä
Intel
