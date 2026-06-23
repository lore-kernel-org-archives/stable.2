Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6AF2E2286
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782203292; cv=none; b=qL/mldQtqpk9il3loxzsvH2G3UFBs8JkxJNuxjd4XBy109QCGbIzxxB128vAqTGK2NGsjm2QLOS+ynPgyCme5gM4FyMq2IhUnpWNvNb9O+0I1Ut4r9Qu/2SIztEqe43njnZBzITSF1QUFvNPMMFhMBAFs13gljmvscLlPjwk5q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782203292; c=relaxed/simple;
	bh=z0SXAia8ruPxK/zDm9KXDLErWTklT5oxtPUHHuhfMGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f08I8+Kh8K7MUFbXOTZeHdsIVw7nRKEqmhWYGRhvI8R1X1NrqTd08wvlONeQ3H6GR78u0+HQjKs82cwlYI7Y6pQFXLls8CvfE8tg0acumiiaVRzPiG5NmbvmnacQQktksAqNm3bREngZTzRBLOH8DGdQmC4/li/nBT7wYP0MP14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JPC8ilqp; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JPC8ilqp"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gkyr56Ljgz9tqv;
	Tue, 23 Jun 2026 10:28:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782203285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJimQdzybTxzTLGbKtZM1e8rYaAZQLBVJJujT6gBEis=;
	b=JPC8ilqp8nnQ4aN499Qi/XAZ92ws7JYpGM9wcnJvfQYq2+QgymDOolFOoI3jJ1yyXFc6c7
	5b1PPRW4aj5BbQYO2eOF7LI/lCw5Oh/CZfTFisW/PFI2Y5FWStfDqSTDtiGe1x31nB70ZS
	l/J+xIZ8Wp5SLgz4QbpXOuPk0nzfXDb6cmyJ6f5g7GXhAhspDh/b5k5+6b7Ndoi0EdDIsG
	J18HyzhAun1RI4XTVYVVj5sfCjd9XhVp+r+/Lj19BS9XqoA/9VOH2BLB+wp9Io1IWHA+Ie
	tbV0ywdxrapdd5WiDHTEZUN0Pyka3iBK5LbV009Mk1uM9n0oLbyKQvN1Y9jycA==
Message-ID: <f36d5096-b509-42b7-8a11-423c03c05919@mailbox.org>
Date: Tue, 23 Jun 2026 10:28:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/3] drm/amd/display: check GRPH_FLIP status before
 sending event
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, mario.limonciello@amd.com, wiagn233@outlook.com,
 sysdadmin@m1k.cloud, timur.kristof@gmail.com, xaver.hugl@kde.org,
 mario.kleiner.de@gmail.com, matthew.schwartz@linux.dev, chris@kode54.net,
 stable@vger.kernel.org
References: <20260622171752.73374-1-sunpeng.li@amd.com>
 <20260622171752.73374-3-sunpeng.li@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20260622171752.73374-3-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4p1kghpoqgpc6odtkt3cgxgochkn6agr
X-MBO-RS-ID: b2c8e0ce78beb67af8b

On 6/22/26 19:17, sunpeng.li@amd.com wrote:
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index da118377b73a8..732ddafb5cfea 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4135,6 +4135,28 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_display_manager *dm,
>  	}
>  }
>  
> +static void dm_arm_vblank_event(struct amdgpu_crtc *acrtc,
> +				struct dm_crtc_state *acrtc_state,
> +				bool pflip_update,
> +				bool cursor_update)
> +{
> +	assert_spin_locked(&acrtc->base.dev->event_lock);
> +
> +	if (pflip_update && acrtc->base.state->event &&
> +	acrtc_state->active_planes > 0) {
> +		drm_crtc_vblank_get(&acrtc->base);
> +		WARN_ON(acrtc->pflip_status != AMDGPU_FLIP_NONE);
> +		/* Arm flip completion handling and event delivery after programming. */
> +		prepare_flip_isr(acrtc);
> +	} else if (cursor_update && acrtc_state->active_planes > 0) {
> +		if (acrtc->base.state->event) {
> +			drm_crtc_vblank_get(&acrtc->base);
> +			acrtc->event = acrtc->base.state->event;
> +			acrtc->base.state->event = NULL;
> +		}
> +	}
> +}

This looks like it can be cleaned up a bit (feel free to ignore though):

{
	assert_spin_locked(&acrtc->base.dev->event_lock);

	if (acrtc->base.state->event && acrtc_state->active_planes > 0) {
		if (pflip_update) {
			drm_crtc_vblank_get(&acrtc->base);
			WARN_ON(acrtc->pflip_status != AMDGPU_FLIP_NONE);
			/* Arm flip completion handling and event delivery after programming. */
			prepare_flip_isr(acrtc);
		} else if (cursor_update) {
			drm_crtc_vblank_get(&acrtc->base);
			acrtc->event = acrtc->base.state->event;
			acrtc->base.state->event = NULL;
		}
	}
}


> +	/*
> +	 * DCE depends on a combination of GRPH_FLIP, VLINE0, and VUPDATE for
> +	 * event delivery. Only GRPH_FLIP handler can send pflip events, and it
> +	 * only fires if HW latched to the flip. Maintain legacy behavior by
> +	 * arming event before programming.
> +	 */
> +	if (amdgpu_ip_version(dm->adev, DCE_HWIP, 0) == 0) {
> +		scoped_guard(spinlock_irqsave, &pcrtc->dev->event_lock)
> +			dm_arm_vblank_event(acrtc_attach, acrtc_state,
> +					pflip_present, cursor_update);
>  	}

Coding style:

	if (amdgpu_ip_version(dm->adev, DCE_HWIP, 0) == 0) {
		scoped_guard(spinlock_irqsave, &pcrtc->dev->event_lock) {
			dm_arm_vblank_event(acrtc_attach, acrtc_state,
					    pflip_present, cursor_update);
		}
	}

Nested multi-line statements require curly braces.


> +		if (updated_planes_and_streams)
> +			flip_latched_during_prog =
> +				!dc_get_flip_pending_on_otg(dm->dc, acrtc_attach->otg_inst);

		if (updated_planes_and_streams) {
			flip_latched_during_prog =
				!dc_get_flip_pending_on_otg(dm->dc, acrtc_attach->otg_inst);
		}


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
