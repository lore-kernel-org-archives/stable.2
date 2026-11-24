Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513017;
	b=Aq+NrleD5DBHzz044lwL+lexUELoLU7zE6H+E5Fcjsfo4pN7DbgPLMTwtFdwNUah1qX0
	 FLh7+j+JlH0whddkUC66WeuixEvMiUArfYubk3lg9Rps1Z68CKtDIxEJDpV2GXsiIggj8
	 F4gAm6Oyrc0aOpyrrawQ9C/i5aQkWvZFmba+AkB7Txp6QHrvLzA9g8I+tlx4Ht8tOIYrd
	 YutSvYud/cmJRCShpTYh4axaKAM65p50w1eQEqr7bznWqVMKGkX1ulr0VxEVZvicJmCnU
	 /68Ah+APzNDIbDeAqyKObWvCOD2YMMAg0BMKMFv9JWcz8s51fbAfzAWIq2KpniwZCeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513017;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Last-TLS-Session-Version;
	bh=mUK8JpDoInG3VuJFjVZB6WRxQ+kbA+qAqeBOuWnngnE=;
	b=HCkTrtnKVkGEGrb7RvtVQhDSXVcY/CMwV17+P3Ky43a8ooF79B2JT9QNDEr0ds5/yFqg
	 q0aZCPGND/MzQpzEdPXAAtR68re/d4NSbEfdDlf+Tdy2Avui6GsH+N/wXHn8s/KJTuJK+
	 ZypRasanJKfveP1pTFTL8BpCXBUNzR/2f4i+DxJVoLljLN++qbrFV/rUiRwI5e0LaOmRP
	 XIS0AZJaqf6DBo+xHUhj/sLnqQdDV7rlOahEL0w/JPqF+oft2jmg5Cg96dW0mGEckQG5w
	 BuDLsPZqqJ8zGe6unzUMqgTF0bO/SK7RRJXQmRSPasQwnU7XQ7x++jnGp0XkiFrGvQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=PwdrEfh0;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4454A606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4454A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=PwdrEfh0
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 886FC1A17A9;
	Tue, 24 Nov 2026 09:36:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 54B30601E1;
	Tue, 24 Nov 2026 09:36:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 84AAC11E68893;
	Tue, 24 Nov 2026 10:36:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795513014; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mUK8JpDoInG3VuJFjVZB6WRxQ+kbA+qAqeBOuWnngnE=;
	b=PwdrEfh0QbnmVJcCzNbLaRx8V2B2pMDk386ZarL645isDKiuEhDCb9F6q4knLVPMEGGJyf
	xpzfKEiZ5rSl7D7IUW/bZVZKnG2bH7TqaV3+w+khv3sSW32V5CHN4a40IUYrQsAKB5ZL3W
	TgpAQfDFkXlNqnGeFAGkv/UTPS861BnnqpJ0v1E4xzbGsRbaD9I4aALV4JiYIPe0ECPH6F
	jyHJ/KbrGuea0BALDkEJpQtdRddiWgrGcoPyO5mY1T8H+uqFVhW9T41pu0YBD90RHOETSq
	nBf6SK59sTmJZErei7/IEUQBgaoXUMPN9mXlvJfCMqVOqp9d9blY22i41jXQfA==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] drm/mxsfb: lcdif: Fix use-after-free on unbind
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: laurentiu.palcu@oss.nxp.com, dri-devel@lists.freedesktop.org, 
 imx@lists.linux.dev, marek.vasut@mailbox.org, mripard@kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261123223357.535424-1-festevam@gmail.com>
References: <20261123223357.535424-1-festevam@gmail.com>
Date: Tue, 24 Nov 2026 10:36:49 +0100
Message-Id: <179551300942.327856.7174455040291936744.b4-review@b4>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Hello Fabio,

> lcdif allocates its private data, which embeds the CRTC and primary
> plane, and its encoders using devres. These DRM objects are linked into
> the mode_config lists.
>
> Since mode_config cleanup is DRM-managed, it is deferred until the DRM
> device is released. An open DRM file can keep the DRM device alive after
> the platform device has been unbound and devres has freed those objects.
> The later mode_config cleanup then dereferences freed memory.
>
> Allocate the private data with drmm before initializing mode_config so
> that it remains alive until mode_config cleanup has completed. Allocate
> encoders with drmm_plain_encoder_alloc(), which cleans up each encoder
> and removes it from the mode_config list before freeing its memory.
>
> This can be reproduced on i.MX8MP by keeping the DRM card open across an
> LCDIF unbind and closing it afterwards.
>
> Cc: stable@vger.kernel.org
> Fixes: 1c71d925c03a ("drm: lcdif: Switch to drmm_mode_config_init")
> Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

I'm OK with the change (except a small nit, see below), but I have a
general question: is there any valid use case for removing the lcdif, other
than testing?

> diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
> index b7be7e17d1d0..bc1a9a2fc6bd 100644
> --- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
> @@ -24,6 +24,7 @@
>  #include <drm/drm_fbdev_dma.h>
>  #include <drm/drm_gem_dma_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_managed.h>
>  #include <drm/drm_mode_config.h>
>  #include <drm/drm_module.h>
>  #include <drm/drm_of.h>
> @@ -43,10 +44,6 @@ static const struct drm_mode_config_helper_funcs lcdif_mode_config_helpers = {
>  	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
>  };
>
> -static const struct drm_encoder_funcs lcdif_encoder_funcs = {
> -	.destroy = drm_encoder_cleanup,
> -};
> -
>  static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
>  {
>  	struct device *dev = lcdif->drm->dev;
> @@ -74,19 +71,16 @@ static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
>  					     "Failed to get bridge for endpoint%u\n",
>  					     of_ep.id);
>
> -		encoder = devm_kzalloc_obj(dev, *encoder);
> -		if (!encoder)
> -			return dev_err_probe(dev, -ENOMEM,
> -					     "Failed to allocate encoder for endpoint%u\n",
> -					     of_ep.id);
> -
> -		encoder->possible_crtcs = drm_crtc_mask(&lcdif->crtc);
> -		ret = drm_encoder_init(lcdif->drm, encoder, &lcdif_encoder_funcs,
> -				       DRM_MODE_ENCODER_NONE, NULL);
> -		if (ret)
> +		encoder = drmm_plain_encoder_alloc(lcdif->drm, NULL,
> +						   DRM_MODE_ENCODER_NONE, NULL);
> +		if (IS_ERR(encoder)) {
> +			ret = PTR_ERR(encoder);
>  			return dev_err_probe(dev, ret,
>  					     "Failed to initialize encoder for endpoint%u\n",
>  					     of_ep.id);
> +		}

No need to use the @ret temporary variable, just replace it with:

		if (IS_ERR(encoder))
 			return dev_err_probe(dev, PTR_ERR(encoder),
 					     "Failed to initialize encoder for endpoint%u\n",
 					     of_ep.id);

With that done you can send v3 and add:
+Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
+Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

