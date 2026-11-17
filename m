Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920287;
	b=p9SDIBykItWe5HH04/J3euKJtot+1H9PRvAcKVGCmRmhJ7ezVP4kSVscqitq2aQ5momC
	 ko7LKL9+MU7ADiAEk0P22nCbVJ5zvEtxAf2mfkn+bXG6P6LIVo3RUnHiXjtwDewMbhOyq
	 Zbiug7OVYp+bEMbwHmoKuR5WY2iw7nIJhSs303uwR3A55bwxwjPQQV2fJVCySTWlQSuUi
	 DaibadI9bLkDgkiKpwZDs6rIjusZc3q1CTtuwAjXASZOwzaEjjCa0K/H2dgPh9mjyrVLE
	 SskKgCRsEWfXqj68nv7nsuvOEycCjs1tmFXzNLJd41EAQmsW9FyHMLgto/6FFItDs1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920287;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=sfv/f/vchDZjJlFU/9RbAGG/Cj5/tePf3TPbDwMuMhU=;
	b=baBHsAsy//yOe4JG6jZZOpaDENAVOAZxfvI2P6rOoMMDFntek/LLP9+tVSBTUc66XYzL
	 1YmFNliSgu6B0PVbINtiz2OOW651oGHms/+CSiRh5MO+CQT9nruUlY+hnAYoihck72mFd
	 B+GOxB+DDj7OPimHqOxNupcTd7XzrzeDIpXAzUf3YYN5aFIUpgQVUQypgzidQeoxcZ20q
	 mO/GCIgDkTrhvlYyme5jx/LmklMFWbM85k5em0z/yi3Pb8vokzKS1PDPAzUoAEOpA9Kzo
	 W6sbgI21pPCTHyu6pMS/l4f9s29hbggocGm1MwUVQlCvL4UTQ4p5ctj2MFD4AUYt6eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=hXnyKZ14;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75196606A88F;
	Tue, 17 Nov 2026 12:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75196606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=hXnyKZ14
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 42ACD10F66A;
	Tue, 17 Nov 2026 13:57:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794920274;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=sfv/f/vchDZjJlFU/9RbAGG/Cj5/tePf3TPbDwMuMhU=;
	b=hXnyKZ14J+nWW0YrbDpIWs9jqXVTavLp1/qK2ylamt/dv7WMrB1ssnEBxTsjCdRu7guSR5
	jUbygR+P9J8dhDVV+vuFXGv7g+goRBxe57omA7T88FLkAJ4pu/br/iglvuR6yTgosnVJfU
	Dt8+NtxYPWL0HlKWljl64ewtV1Kd2A0Tbbtu2XVB2lBz3jvX2BAXfCIZuodu2OXWcSx0xK
	nDjoWZVhs0JLaL01YDuYFJBnsaf3aBEDlO8jbLEwPO4t8IJxr1FdUih6aN0CqUWbTnILaz
	/atKxrJVQ1nvovHN2wV6c8RGwhMwSBjGlNPphlCMLrjFiiQJAdEf5fSi9ScPsQ==
Message-ID: <2814f5f9-8f66-4fe3-9e31-a397bc39b004@nabladev.com>
Date: Tue, 17 Nov 2026 13:57:49 +0100
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
Subject: Re: [PATCH] drm/mxsfb: Complete page flips only once the new buffer
 is latched
To: Christian Gmeiner <christian.gmeiner@gmail.com>,
 Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Christian Gmeiner <cgmeiner@igalia.com>, stable@vger.kernel.org,
 Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Emil Velikov <emil.l.velikov@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20261108-mxsfb-flip-latch-v1-1-ad816b23b646@igalia.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20261108-mxsfb-flip-latch-v1-1-ad816b23b646@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 11/8/26 1:12 PM, Christian Gmeiner wrote:
> From: Christian Gmeiner <cgmeiner@igalia.com>
> 
> The controller copies NEXT_BUF to CUR_BUF at the end of each frame. When
> a commit writes NEXT_BUF just after that point, the new buffer is only
> scanned out one frame later, but the event armed in atomic_flush is
> still sent at the next frame done interrupt. Userspace then renders into
> a buffer that is still on screen, which shows up as half drawn frames
> when a compositor renders directly into its scanout buffers.
> 
> Keep the event in the driver and send it from the interrupt handler once
> CUR_BUF matches NEXT_BUF, and AS_BUF matches AS_NEXT_BUF for an enabled
> overlay. On i.MX8MQ about 2% of the flips completed one frame early
> before this change, for both planes.
> 
> Fixes: b9f5937680a8 ("drm: mxsfb: Enable vblank handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
> ---
>   drivers/gpu/drm/mxsfb/mxsfb_drv.c |  2 +-
>   drivers/gpu/drm/mxsfb/mxsfb_drv.h |  3 +++
>   drivers/gpu/drm/mxsfb/mxsfb_kms.c | 47 ++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 641691fc92c8..d21f12074a81 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -166,7 +166,7 @@ static irqreturn_t mxsfb_irq_handler(int irq, void *data)
>   	reg = readl(mxsfb->base + LCDC_CTRL1);
>   
>   	if (reg & CTRL1_CUR_FRAME_DONE_IRQ) {
> -		drm_crtc_handle_vblank(&mxsfb->crtc);
> +		mxsfb_crtc_handle_vblank(mxsfb);
>   		if (mxsfb->crc_active) {
>   			crc = readl(mxsfb->base + LCDC_V4_CRC_STAT);
>   			vbc = drm_crtc_accurate_vblank_count(&mxsfb->crtc);
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.h b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> index bdc47ce5be79..9264ca53999d 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> @@ -49,6 +49,8 @@ struct mxsfb_drm_private {
>   	u32				bus_format;
>   
>   	bool				crc_active;
> +
> +	struct drm_pending_vblank_event	*event;
>   };
>   
>   static inline struct mxsfb_drm_private *
> @@ -61,5 +63,6 @@ void mxsfb_enable_axi_clk(struct mxsfb_drm_private *mxsfb);
>   void mxsfb_disable_axi_clk(struct mxsfb_drm_private *mxsfb);
>   
>   int mxsfb_kms_init(struct mxsfb_drm_private *mxsfb);
> +void mxsfb_crtc_handle_vblank(struct mxsfb_drm_private *mxsfb);
>   
>   #endif /* __MXSFB_DRV_H__ */
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> index bbc2a2df9f16..c7e516758a1a 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> @@ -328,6 +328,7 @@ static int mxsfb_crtc_atomic_check(struct drm_crtc *crtc,
>   static void mxsfb_crtc_atomic_flush(struct drm_crtc *crtc,
>   				    struct drm_atomic_commit *state)
>   {
> +	struct mxsfb_drm_private *mxsfb = to_mxsfb_drm_private(crtc->dev);
>   	struct drm_pending_vblank_event *event;
>   
>   	event = crtc->state->event;
> @@ -338,12 +339,54 @@ static void mxsfb_crtc_atomic_flush(struct drm_crtc *crtc,
>   
>   	spin_lock_irq(&crtc->dev->event_lock);
>   	if (drm_crtc_vblank_get(crtc) == 0)
> -		drm_crtc_arm_vblank_event(crtc, event);
> +		mxsfb->event = event;
>   	else
>   		drm_crtc_send_vblank_event(crtc, event);
>   	spin_unlock_irq(&crtc->dev->event_lock);
>   }
>   
> +static bool mxsfb_crtc_buffers_latched(struct mxsfb_drm_private *mxsfb)
> +{
> +	if (readl(mxsfb->base + mxsfb->devdata->cur_buf) !=
> +	    readl(mxsfb->base + mxsfb->devdata->next_buf))
> +		return false;
> +
> +	if (mxsfb->devdata->has_overlay &&
> +	    (readl(mxsfb->base + LCDC_AS_CTRL) & AS_CTRL_AS_ENABLE) &&
> +	    readl(mxsfb->base + LCDC_AS_BUF) != readl(mxsfb->base + LCDC_AS_NEXT_BUF))
> +		return false;
> +
> +	return true;
> +}
> +
> +static void mxsfb_crtc_finish_page_flip(struct mxsfb_drm_private *mxsfb)
> +{
> +	struct drm_crtc *crtc = &mxsfb->crtc;
> +
> +	drm_crtc_send_vblank_event(crtc, mxsfb->event);
> +	drm_crtc_vblank_put(crtc);
> +	mxsfb->event = NULL;
> +}
> +
> +void mxsfb_crtc_handle_vblank(struct mxsfb_drm_private *mxsfb)
> +{
> +	struct drm_crtc *crtc = &mxsfb->crtc;
> +
> +	drm_crtc_handle_vblank(crtc);
> +
> +	/*
> +	 * The controller copies NEXT_BUF to CUR_BUF at the end of a frame. If
> +	 * the commit wrote NEXT_BUF after that point, the new buffer is only
> +	 * scanned out from the next frame on. Complete the flip only once the
> +	 * hardware has latched it, otherwise userspace gets back a buffer that
> +	 * is still being scanned out.
> +	 */
> +	spin_lock(&crtc->dev->event_lock);
> +	if (mxsfb->event && mxsfb_crtc_buffers_latched(mxsfb))
> +		mxsfb_crtc_finish_page_flip(mxsfb);
> +	spin_unlock(&crtc->dev->event_lock);
> +}
> +
>   static void mxsfb_crtc_atomic_enable(struct drm_crtc *crtc,
>   				     struct drm_atomic_commit *state)
>   {
> @@ -425,6 +468,8 @@ static void mxsfb_crtc_atomic_disable(struct drm_crtc *crtc,
>   		crtc->state->event = NULL;
>   		drm_crtc_send_vblank_event(crtc, event);
>   	}
> +	if (mxsfb->event)
> +		mxsfb_crtc_finish_page_flip(mxsfb);
>   	spin_unlock_irq(&drm->event_lock);
>   
>   	drm_crtc_vblank_off(crtc);
> 
> ---
> base-commit: 19e67d977d3d4d0c54f03906ef578578190db9e1
> change-id: 20261108-mxsfb-flip-latch-ef53c4526ba6
> 
> Best regards,

+CC Liu

It looks good to me, thanks !
