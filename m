Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830FE466B1D
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 18:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785263997; cv=none; b=kIJNSc0BcvlQIXpn+XL/09B6oP67xlqEp/7Cmy6eYnJ/E7nYJHcgWTi0hmkKdtHtyZHnbCsgfA7fNt+cNQ/DRWpzqnXWI7N/CVIqAWQ3Uyh4Ee7hcMFWhBiX4rBQrnHhmvazoJ3JGVdzuKGfeSdWNqr6NOwSDGAOvsfC8koC1is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785263997; c=relaxed/simple;
	bh=QlkmroNtp4km6BTSrzmgQasv2sXnFhjjQfDE5NuMwWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uHCVCj6rKZoo1BsID0YliBMJsS9DQHc7xlelsCzUWik0aSMe0nvgw9n5UgwRhlu0DK0auOKVtAHSTNEWf/Uv7eTl9+x4fgakU81RxGCG8I4iwZ5QiICZFBSTTnhSoCxuITSQ3UeLGQoZaL/JYQ1lPh5e4qct0QXqzDj7j9YnxGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAT5X/Xr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAT5X/Xr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C59C1F000E9;
	Tue, 28 Jul 2026 18:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785263996;
	bh=oHsUxFoiyHVcRJtbSPescE2hFg4RdUF+1muhOwuzSDM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BAT5X/XrQ3zdVQxjRgZj5fZH6tLLc2uAS2xS/u3LyBAInOb5ftFHQJgWf9HMNiy9n
	 obRlNajmspIciaqEOAPUCIqz0sxXbPUQX/XvyO7D/Zp1Hvwjg4pHGA6OinmfpKfjwR
	 X77v+fPjgnKazTfieVzcYU5EkeVYd/ARBL29W0SyX5qlS5P/te+s0cMElQuBpV7fmI
	 AZngnFrQD8mN7lqFcgScMN6jy/mAOpGBmfyR9t2Ri6vs4DZ00/SHtVkwtMYatpXrhh
	 yPWaF9Kup5uoqilv0IjrctURYPBK993dIO4ChHikrvSwQZ+jnyEFursWaLlfYTPRUx
	 lWQDMGFwCkfMw==
Message-ID: <c446e576-6fa6-4546-aa53-04b07c746f5e@kernel.org>
Date: Tue, 28 Jul 2026 13:39:55 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Exit idle optimizations before
 programming
Content-Language: en-US
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, alexander.deucher@amd.com, stable@vger.kernel.org
References: <20260728170550.40908-1-sunpeng.li@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260728170550.40908-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/28/26 12:02, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> [Why]
> 
> We need to exit PSR/IPS before programming. Before calling DC for
> programming in amdgpu_dm_commit_planes(), there's a
> vblank_control_workqueue flush. This waits for IPS and PSR exit. (See
> drm_vblank_on/off() > amdgpu_dm_crtc_set_vblank() --queue_work()->
> amdgpu_dm_crtc_vblank_control_worker())
> 
> Prior to the tagged "Fixes:" change, drm_vblank_get() was called before
> the workqueue flush. This ordering ensures that PSR exit occurred before
> programming. After the "Fixes:" change, drm_vblank_get() is called after
> the workqueue flush, leading to programming while idle optimizations are
> still active. This can lead to incorrect flip_pending detection used by
> vblank event delivery.
> 
> [How]
> 
> Split the vblank_get() component of `dm_arm_vblank_event()` into
> `dm_arm_vblank_event_pre_programming()`, which is called before
> programming. Call it before the vblank_control_workqueue flush.
> 
> Includes a drive-by cleanup of prepare_flip_isr(): the only caller is
> dm_arm_vblank_event() and it's simple enough to roll-in.
> 
> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> Fixes: 48ab86360af1 ("drm/amd/display: check GRPH_FLIP status before sending event")
> Cc: stable@vger.kernel.org
> Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/4141#note_3583205
> Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5527
> Assisted-by: Codex:gpt-5.6-sol
> Assisted-by: Claude:opus-5
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> Rebased patch for applying on 7.2-rc5:
> https://gitlab.freedesktop.org/leoli/linux-asdn/-/commit/f05db644126540f1d237f846cc0512088551eb73
> 
> Thanks,
> Leo
> 
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 79 +++++++++++--------
>   1 file changed, 47 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index df6b59fb8d0d4..784587697bac8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3576,25 +3576,6 @@ static void remove_stream(struct amdgpu_device *adev,
>   	acrtc->enabled = false;
>   }
>   
> -static void prepare_flip_isr(struct amdgpu_crtc *acrtc)
> -{
> -
> -	assert_spin_locked(&acrtc->base.dev->event_lock);
> -	WARN_ON(acrtc->event);
> -
> -	acrtc->event = acrtc->base.state->event;
> -
> -	/* Set the flip status */
> -	acrtc->pflip_status = AMDGPU_FLIP_SUBMITTED;
> -
> -	/* Mark this event as consumed */
> -	acrtc->base.state->event = NULL;
> -
> -	drm_dbg_state(acrtc->base.dev,
> -		      "crtc:%d, pflip_stat:AMDGPU_FLIP_SUBMITTED\n",
> -		      acrtc->crtc_id);
> -}
> -
>   static void amdgpu_dm_commit_cursors(struct drm_atomic_commit *state)
>   {
>   	struct drm_plane *plane;
> @@ -3740,17 +3721,48 @@ static void dm_arm_vblank_event(struct amdgpu_crtc *acrtc,
>   		return;
>   
>   	if (pflip_update) {
> -		drm_crtc_vblank_get(&acrtc->base);
>   		WARN_ON(acrtc->pflip_status != AMDGPU_FLIP_NONE);
> -		/* Arm flip completion handling and event delivery after programming. */
> -		prepare_flip_isr(acrtc);
> +		WARN_ON(acrtc->event);
> +
> +		acrtc->pflip_status = AMDGPU_FLIP_SUBMITTED;
> +		acrtc->event = acrtc->base.state->event;
> +		acrtc->base.state->event = NULL;
> +
> +		drm_dbg_state(acrtc->base.dev,
> +			      "crtc:%d, pflip_stat:AMDGPU_FLIP_SUBMITTED\n",
> +			      acrtc->crtc_id);
>   	} else if (cursor_update) {
> -		drm_crtc_vblank_get(&acrtc->base);
>   		acrtc->event = acrtc->base.state->event;
>   		acrtc->base.state->event = NULL;
>   	}
>   }
>   
> +/**
> + * dm_arm_vblank_event_pre_programming - Prepare for programming
> + * @acrtc: The amdgpu CRTC to prepare
> + * @acrtc_state: The new CRTC state
> + * @pflip_update: Whether a page flip is being programmed
> + * @cursor_update: Whether a cursor update is being programmed
> + *
> + * Grab a reference on the vblank counter if a page flip or cursor update is to
> + * be programmed. Do this before programming so the HW is not in any
> + * idle-optimized state (such as PSR).
> + */
> +static void dm_arm_vblank_event_pre_programming(
> +	struct amdgpu_crtc *acrtc,
> +	struct dm_crtc_state *acrtc_state,
> +	bool pflip_update,
> +	bool cursor_update)
> +{
> +	assert_spin_locked(&acrtc->base.dev->event_lock);
> +
> +	if (!acrtc->base.state->event || acrtc_state->active_planes == 0)
> +		return;
> +
> +	if (pflip_update || cursor_update)
> +		drm_crtc_vblank_get(&acrtc->base);
> +}
> +
>   static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
>   				    struct drm_device *dev,
>   				    struct amdgpu_display_manager *dm,
> @@ -4013,16 +4025,19 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
>   		}
>   	}
>   
> -	/*
> -	 * DCE depends on a combination of GRPH_FLIP, VLINE0, and VUPDATE for
> -	 * event delivery. Only GRPH_FLIP handler can send pflip events, and it
> -	 * only fires if HW latched to the flip. Maintain legacy behavior by
> -	 * arming event before programming.
> -	 */
> -	if (amdgpu_ip_version(dm->adev, DCE_HWIP, 0) == 0) {
> -		scoped_guard(spinlock_irqsave, &pcrtc->dev->event_lock) {
> +	scoped_guard(spinlock_irqsave, &pcrtc->dev->event_lock) {
> +		dm_arm_vblank_event_pre_programming(acrtc_attach, acrtc_state,
> +						    pflip_present,
> +						    cursor_update);
> +		/*
> +		 * DCE depends on a combination of GRPH_FLIP, VLINE0, and
> +		 * VUPDATE for event delivery. Only GRPH_FLIP handler can send
> +		 * pflip events, and it only fires if HW latched to the flip.
> +		 * Maintain legacy behavior by arming event before programming.
> +		 */
> +		if (amdgpu_ip_version(dm->adev, DCE_HWIP, 0) == 0) {
>   			dm_arm_vblank_event(acrtc_attach, acrtc_state,
> -					pflip_present, cursor_update);
> +					    pflip_present, cursor_update);
>   		}
>   	}
>   

