Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D298D37C929;
	Wed, 19 Aug 2026 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787132179; cv=none; b=r3LPP1k1QsLrcNbPw9lBBc7joTT043X7/eP9bhSbdvR+E4L72rGkFV8JkqGJ+1cncHip94u3lw4armb2dLlWeuy3FDvMSYh30A80dKVfaookr5mI1kSNBzVUx/fdcUE/LimXS+jZMoZqBSkBcE0NRFEGFYINWu7QwGFy5gBZcD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787132179; c=relaxed/simple;
	bh=mtYxa/cP+mVeQA1/tOeZeGzeookG16Dmsup9Q8azDr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ikd1VKVKVgHJNJFAatJkTPQKCsJUOofVidbXiDiPAnfz9Hky6EFwT+ABCTxdIwPMfyKcxju75EIERCP0frqg4Dh36FNpPAE131G0A0kGk4hJr7B3qkNbfpDUP/GQ9kBUMNfUn3vbSas/GZxVj1HVnSiWH/jTRbGa6zhSENxd27w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aBvpiCw1; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aBvpiCw1"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1A59A1A1733;
	Wed, 19 Aug 2026 09:36:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DA5775FF42;
	Wed, 19 Aug 2026 09:36:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6183711C75549;
	Wed, 19 Aug 2026 11:36:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787132174; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=A/xkCgha8hwURYD4JLDAys/B3Rx8Yg7BIQ8wcjbJ8pA=;
	b=aBvpiCw1ob+oCjwxCmm+OR1N8ofj/xI5b4XVzCKGGbngDdvamdczTbSMEu7X8ztCigmDhm
	s2UlWvtNO1vFr+OOmMPbZKlF0NkqeJYVo3/ggwcwkKlSJHVRL6V3bDt7Y8dzlrYqXDxo4r
	HbcOAZb4sDz90JiC2zetjIc/bWju9ub4afYRngYVK2np5gdh4vTqW3+Y4u4Q78Xq7/v6fd
	yov9yJOX4Hn9g4DbwDH8brDYaavwdpKlG6m0NyThj40/WfcPWbdz2O1tgwRM6VSFZAoFki
	MQ2BPR1ptAuZn6oxdmHyPupXkUgzFJS4czdUYKYi9/woDA4x8xFRo8VxLmrzMg==
Date: Wed, 19 Aug 2026 11:36:09 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Linus Walleij <linusw@kernel.org>, Frieder
 Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v4 2/3] drm/bridge: ti-sn65dsi83: Propagate error in
 sn65dsi83_reset_pipe()
Message-ID: <20260819113609.2a8bc92b@bootlin.com>
In-Reply-To: <20260810-ti-sn65dsi83-fixes-v4-2-ae9c95c8d162@geanix.com>
References: <20260810-ti-sn65dsi83-fixes-v4-0-ae9c95c8d162@geanix.com>
	<20260810-ti-sn65dsi83-fixes-v4-2-ae9c95c8d162@geanix.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Esben,

On Mon, 10 Aug 2026 09:19:41 +0200
Esben Haabendal <esben@geanix.com> wrote:

> Propagate the error code from drm_bridge_helper_reset_crtc(), so that
> callers has a chance to handle the failure.
> 
> Fixes: ad5c6ecef27e ("drm: bridge: ti-sn65dsi83: Add error recovery mechanism")
> Cc: stable@vger.kernel.org
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index 0ccfff401b2a..475224c5a5d8 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -403,7 +403,7 @@ static int sn65dsi83_reset_pipe(struct sn65dsi83 *sn65dsi83)
>  	drm_modeset_drop_locks(&ctx);
>  	drm_modeset_acquire_fini(&ctx);
>  
> -	return 0;
> +	return err;
>  }
>  
>  static void sn65dsi83_reset_work(struct work_struct *ws)
> 

I have sent my 'Reviewed-by' too late on the v3. Sorry about that.

Here it is for this v4.

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
