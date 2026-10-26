Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011315;
	b=R+kS4QWk6YoKqrtboMoj7TlFAWNbotg362+vKlz1gjQnHnCnaoE3jdRzlinjvcroTFfb
	 SFdFO8pkaDwfL/bcyW64fBAoQgYYzZDG/AQsD0LAfew4R2zsZX+h6C8BoKB8FJsfiBqoY
	 aVlp/9ERsq5Y2iG0MfjdL6uUy58Vj/UVmvdtKvmJZqQciZdJwDVrJqGdQXScgnTzn7MZH
	 HIs/nM2ixbGZyIlsEs+0F3VPPhCfleryKXf7Q7clxWqEKoYn8j5M6U9AWkDyAQl0/MTc5
	 ngPBOZUJTTU2WV9JPdyYoZlLo72k40fshhn1t72lssZA2TgxQ2y8JYCmxAvuFLXsMCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011315;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
	bh=kzgs3AQHLT3HSYh32Yj3thzN6uDPjTvFSOG8Xs2EFDM=;
	b=oBRgWtIIxEyGHCRtyzNikPAFVtmV5AQF3DdFp6wNB7XOEYG1adI0YOjrko9cTo1hKwuP
	 Kl+eQMMClVmp9E8hh72EOHvfpaZf4mnazgB0xdEKdgvLMRGhrj/v9myHw9cL2LFHOWcPM
	 uw0wXRTFpAHh8MrJdHW0KXocYeF9R5K/3oKtl4waeDby1IoOr9dEPZKImws/QM7jx+b7R
	 fVJE+8LGHT4EN4/vi6WRrrrDqXevlm77v+FMc50OxSeg7/0QQPejxV7xsg9roLZDqD7BP
	 rZqlJ2kB9BUi1JYeAV4ievAaPBysNhYJ0EJ9ByLBXO3ny2sbnqP/L4nyjxWJ5TRjKHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=DkWW4NNC;
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A89606A321
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 10:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4A89606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=DkWW4NNC
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jCqtd06QFz8t2h;
	Mon, 26 Oct 2026 11:41:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793011305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kzgs3AQHLT3HSYh32Yj3thzN6uDPjTvFSOG8Xs2EFDM=;
	b=DkWW4NNCtwDcquzGT2i1uQpzfJ7cq015afy2S8OH3g+Zc0Bt8hqPNFmS3Q1OAs5HdlBqYh
	gnoCfN/s/bYOPiBih4ExklS97zbMwa/cktIbUPMDBiR7sJaDtBX9SZvTuxjgf+Ve9PTBJH
	L/5gD1G5JprehXwvJ5p0qrkA6tO02N46OCRI2iV2ST0xuYmAXEwPY8KNXXQe5x6Jn8jsA/
	y8SaXcVmEroRqNwUbl1X2oWYjaV8Qg6Gp0D43jwNUlWd/ohlYSA29x3/VJQ1+FnVsEgdwz
	Mh0PmLqa5AqTkk+wDku6eGK9xt0mz1y/2XwmE6mDBECrt4G04rUfrBljA4SNiA==
Message-ID: <e307f665-3836-47ac-bca2-b9ed883fc995@mailbox.org>
Date: Mon, 26 Oct 2026 11:41:43 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix DC scanout position handling
To: Erhan Bilgili <erhan.bilgili@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Jack.Xiao@amd.com,
 stable@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <20261025084506.62881-1-erhan.bilgili@gmail.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20261025084506.62881-1-erhan.bilgili@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: zpz4e79r48wx4n4f8jybk3kjowe48amm
X-MBO-RS-ID: 3b6ae10290bdc8a2763

On 10/25/26 09:45, Erhan Bilgili wrote:
> dm_crtc_get_scanoutpos() packs decoded DC positions and blanking
> boundaries into u32 words, shifting the second value by 16 bits.
> 
> VRR extends vertical blanking without changing the line clock. For
> example, a 4K240 mode with vtotal=2250 spans about 9000 lines per
> refresh at 60 Hz, exceeding the 13 bit range within a 48-240 Hz VRR
> range.
> 
> The 13 bit mask truncates positions above 8191, causing early VRR
> timestamps and missed vblank count adjustments.
> 
> Fixes: e806208dc1da ("drm/amd/display: Fix slow FPS.")

I don't see how that commit caused the issue. Rather it fixed a bug which had masked the issue.


> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 0a8dd7241750..f78c82ba7f70 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -1767,6 +1767,8 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
>  	bool in_vbl = true;
>  
>  	struct amdgpu_device *adev = drm_to_adev(dev);
> +	/* DC packs decoded values into 16 bit fields. */
> +	const u32 scanout_mask = adev->dc_enabled ? 0xffff : 0x1fff;

The 0x1fff mask isn't correct for all non-DC cases either. drivers/gpu/drm/amd/include/asic_reg/dce/dce_10_0_sh_mask.h has

#define CRTC_STATUS_POSITION__CRTC_VERT_COUNT_MASK 0x3fff


> @@ -1784,15 +1786,15 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
>  	/* preempt_enable_rt() should go right here in PREEMPT_RT patchset. */
>  
>  	/* Decode into vertical and horizontal scanout position. */
> -	*vpos = position & 0x1fff;
> -	*hpos = (position >> 16) & 0x1fff;
> +	*vpos = position & scanout_mask;
> +	*hpos = (position >> 16) & scanout_mask;

Since no HW generation seems to have any other fields in the CRTC_STATUS_POSITION & CRTC_V_BLANK_START_END registers, maybe just use

	*vpos = lower_16_bits(position);
	*hpos = upper_16_bits(position);

and correspondingly for vbl_start/end.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
