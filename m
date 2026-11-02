Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793639762;
	b=V7Hb6gSeGRI4nLenWXSvYwrXinqua+7TVMJ3D2q8QuULBQn1N7dH9amQuQat90lw4m19
	 iONP352PS9Iv12B4WvUkqEybgbtEx9olT5fE26jiJB3Whu46uGCZjsUfPhWVFP/vuf2kv
	 2hCamR9aZHsyzHXyAWJuZzrAZ0wF8oR4/Y0Im8UTFgv9Z81iDjPtDjPgpZwyAJMXHBRSb
	 koZILB9YWZy95oD/cMmd3TlFnQMDs40F8gB4Z6SoxcSteaDJ03/QP4EipnXJXdViCr29v
	 Ax3eWLIwqFwSfxrTbyNxc8iEIqmLWOtIgZxi9pygv62HCPJ8MLiUcu5UAsJyzEWv3Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793639762;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Patchwork-Hint:Organization;
	bh=VvFiRX+UDiCb7EXBJoqD5jplvWH2r5HJgDKRSxF05uY=;
	b=eE7w25QROBwQ2t3sRpw87HPXpYFMyOu9h0ewwtTIV0PwWEjh1upAHXFE0v3Qvo89fY6X
	 yLnrTggOMgJkad11eiV5uLTaOO6ZJrr3fS79ca8sa+4C4mjXtSWhRu0FxZ1KNpFAq+9Cy
	 NC4I0XtW3I/qKY/HdZ9ObtxL0xw63h0+3sqdioeDZ0s4nCHe6LVaWWplcNaXA3KAzMC3O
	 EE0OD1PB8Sa/xFzR7wt2RlPXMJGXPvf7Q2VDSM6PV/APo82ZjO42Ab7Pqt4kzl/WuscFi
	 k6UpkUJIy5vs3tHyFIvGmwR4rnBIJKyAT6PNx8Vq5QKhT7LYGKAxHI+ONt1w5gLqnKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nWP8U6ir;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C93606A923
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 17:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13C93606A923
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nWP8U6ir
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793639763; x=1825175763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PindnjL+kM3irIKVMGKsxYjY2neN6CeuZV4NVO8juo4=;
  b=nWP8U6irobtJO3PXQMjxZuzh9lDHG8aB+Y18WoCS96qmwQm6UtLIbW8S
   8nHccg+1IgtwJvrfeCF/7uK04PcVBUIBcNHNKz6syx76tTBphf4buHw0B
   SOE44zc65TNfZOPK7eqC7+uL/VX6S4ZfVGBARVxhRKKGWptsBOI6oVKMF
   NU0l59bUUyzeZ3uobF/SPySnAEz+7FT3KUxdpLzcMVdoA13XhEa7p3WmH
   VimDI76tq9sTKxIJ02nVGVdLp7Be5qX2msBmMYicENl8TKx6LzrazhnpI
   tMI8sbprq3J4aUXruF0+Mf7i7vx8QbUQEhz4OaacWJNzzyUZCP+IftBsw
   A==;
X-CSE-ConnectionGUID: KE43CaSwQl2wJyZA96JRuA==
X-CSE-MsgGUID: s+b24zcMSOKERbCGqgc0TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2241214"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2241214"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 09:16:02 -0800
X-CSE-ConnectionGUID: eQhzoVBTRD6rD70CohQ4zg==
X-CSE-MsgGUID: WnKe0SRiT7yZHenZKyWDTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6038636"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 09:15:59 -0800
Date: Mon, 2 Nov 2026 19:15:55 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	airlied@gmail.com, simona@ffwll.ch, javierm@redhat.com,
	louis.chauvet@bootlin.com, dri-devel@lists.freedesktop.org,
	sashiko-reviews@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] drm/vblank: Restart enabling vblank timer on possible
 deadlock
Message-ID: <aujFSzHEv5pAfHPf@intel.com>
References: <20261102143919.1672293-1-tzimmermann@suse.de>
 <auioL8zR9O5u4TCF@intel.com>
 <4212140f-fa07-4f0c-bd3a-0ae3d88b250c@suse.de>
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
In-Reply-To: <4212140f-fa07-4f0c-bd3a-0ae3d88b250c@suse.de>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland

On Mon, Nov 02, 2026 at 05:48:23PM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 02.11.26 um 16:11 schrieb Ville Syrjälä:
> > On Mon, Nov 02, 2026 at 03:38:52PM +0100, Thomas Zimmermann wrote:
> >> Return -EDEADLK when trying to cancel a running hrtimer as part of
> >> enable_vblank(). Reacquire vblank_time_lock and try again.
> >>
> >> The vblank helper drm_vblank_disable_and_save() and the vblank IRQ
> >> handler hold the spin lock vblank_time_lock at some point. This
> >> can result in a deadlock if vblank timer's disable code in
> >> drm_crtc_vblank_cancel_timer() calls hrtimer_cancel() directly: the
> >> helper wais for the timer function to complete and the timer function
> >> waits for the helper to release vblank.time_lock.
> >>
> >> drm_crtc_vblank_cancel_timer() works around this problem by calling
> >> hrtimer_try_to_cancel() instead. For re-enabling the vblank timer,
> >> drm_crtc_vblank_start_timer() must wait for the vblank timer to stop.
> >> It runs into the same deadlock problem while waiting for the timer
> >> function to complete.
> >>
> >> The solution to this problem is to release and reacquire the spin
> >> lock vblank_time_lock if hrtimer_try_to_cancel() signals a running
> >> timer function. Releasing the lock allows for the timer function to
> >> make progress.
> >>
> >> Signal the possible deadlock with -EDEADLK and perform the necessary
> >> steps. No other driver uses -EDEADLK in their enable_vblank, so the
> >> change should not interfere.
> >>
> >> Tested with bochs on qemu.
> >>
> >> Closes: https://lore.kernel.org/dri-devel/20260914111129.300691F00898@smtp.kernel.org/
> >> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> >> Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
> >> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> >> Cc: Louis Chauvet <louis.chauvet@bootlin.com>
> >> Cc: Javier Martinez Canillas <javierm@redhat.com>
> >> Cc: David Airlie <airlied@gmail.com>
> >> Cc: Simona Vetter <simona@ffwll.ch>
> >> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> >> Cc: Maxime Ripard <mripard@kernel.org>
> >> Cc: dri-devel@lists.freedesktop.org
> >> Cc: <stable@vger.kernel.org> # v6.19+
> >> ---
> >> I also tried to move hrtimer_cancel() out of the critical section. The
> >> result was fairly fragile. So returning an error and re-acquiring the
> >> lock was the easier solution.
> >> ---
> >>   drivers/gpu/drm/drm_vblank.c | 21 +++++++++++++++------
> >>   1 file changed, 15 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> >> index 5162250e8813..135efde86298 100644
> >> --- a/drivers/gpu/drm/drm_vblank.c
> >> +++ b/drivers/gpu/drm/drm_vblank.c
> >> @@ -1182,10 +1182,12 @@ static int __enable_vblank(struct drm_device *dev, unsigned int pipe)
> >>   static int drm_vblank_enable(struct drm_device *dev, unsigned int pipe)
> >>   {
> >>   	struct drm_vblank_crtc *vblank = drm_vblank_crtc(dev, pipe);
> >> -	int ret = 0;
> >> +	int ret;
> >>   
> >>   	assert_spin_locked(&dev->vbl_lock);
> >>   
> >> +retry:
> >> +	ret = 0;
> >>   	spin_lock(&dev->vblank_time_lock);
> >>   
> >>   	if (!vblank->enabled) {
> >> @@ -1199,7 +1201,11 @@ static int drm_vblank_enable(struct drm_device *dev, unsigned int pipe)
> >>   		ret = __enable_vblank(dev, pipe);
> >>   		drm_dbg_core(dev, "enabling vblank on crtc %u, ret: %d\n",
> >>   			     pipe, ret);
> >> -		if (ret) {
> >> +		if (ret == -EDEADLK) {
> >> +			spin_unlock(&dev->vblank_time_lock);
> >> +			cpu_relax();
> >> +			goto retry;
> >> +		} else if (ret) {
> >>   			atomic_dec(&vblank->refcount);
> >>   		} else {
> >>   			drm_update_vblank_count(dev, pipe, 0);
> >> @@ -2232,11 +2238,14 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
> >>   			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> >>   	} else {
> >>   		/*
> >> -		 * Timer should not be active. If it is, wait for the
> >> -		 * previous cancel operations to finish.
> >> +		 * Timer should not be running. If it is, signal cancellation
> >> +		 * again and restart to release locks.
> >>   		 */
> >> -		while (hrtimer_active(&vtimer->timer))
> >> -			hrtimer_try_to_cancel(&vtimer->timer);
> > Why do you even have to cancel the timer here? Just let it run?
> 
> We ran hrtimer_try_to_cancel() in drm_crtc_vblank_cancel_timer() to 
> remove the vblank timer. When we later come here, we need to know if the 
> timer has meanwhile been fully canceled. Hence we need at least one call 
> to hrtimer_try_to_cancel() even if the timer is in some bogus state 
> where it should not be active. The loop here was nonsense and could 
> deadlock. In the new code, we still need that call to 
> hrtimer_try_to_cancel() to detect the possible deadlock.
> 
> I'm not confident that we can set up the hrtimer with new values while 
> it is in this half-canceled state, can we?

Shrug.

But what I'm thinking is:
- stop with the explicit cancel entirely and just rely on the
  timer cancelling itself
- try to start the timer in vblank_enable(), and if that can somehow
  fail because the timer is still running it should be fine because
  the self cancellation should anyway have been aborted
- explicitly wait for the timer to have stoppped in drm_vblank_off()
  to make sure the wrong interval can't leak from one mode to
  another

-- 
Ville Syrjälä
Intel
