Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F1849C4CD
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052958; cv=none; b=aiaBwmDZF1bGgArTeIIn2VbPihAkNxXbJUZiwVhwT1injZt83LGlLhJcEIV5Lq8cVkV6hGghMnrcmMMRbR9f7q/qZ+UOHypQ34h8vYUqGxKyg4w6F8upuwgnGkKp+5FSddbrCSaRdYfdHzX9U1FG9Zl9J/DnnTJz62FlCsg32cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052958; c=relaxed/simple;
	bh=4yHo0jxkxzwvqa4dyNy+s98uCpIdE0kge3qev5EKwt4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pA/Lwg3liYVBsMtfnEg1nkx606vXZY6VelQjN/m2P19HbpziGV0WSf1zjlSbUF/6adb4l8hsrjn3RZKY+uU0jDu/+vlYDBgF7v38C/t9/ClgVhUsyv2XlrNV02x5S8cibO1JdRQIfQ7LwTOF2SaEbptxtFbfouDPoXwTDI2jzZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AtSS4y/S; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jnqHHhpp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtSS4y/S";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jnqHHhpp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792052956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6fmAA4pRjLkz/PBqarAT5jgfTfqNf/gcx018ODCtjo4=;
	b=AtSS4y/SgMTHKA/tWwdagOPDmdI4Ppm5MGLKu6vW+pusQ4OHW6WskhjLgytRiDgsv9QpfN
	pliQTZw+ESOKPNvsnkRJr3TMkswcAXTHm7aRibGAZHwHHssv0Ard5W068LZL7PoU4iJQqL
	NbQpIkS0G/SWElZ/yFCjUfjIlygZOcU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-VTit_RCqMDGmI73pVDOrBw-1; Thu, 15 Oct 2026 08:29:13 +0000
X-MC-Unique: VTit_RCqMDGmI73pVDOrBw-1
X-Mimecast-MFC-AGG-ID: VTit_RCqMDGmI73pVDOrBw_1792052952
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48b09f01f56so3203394f8f.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 01:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792052952; x=1792657752; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6fmAA4pRjLkz/PBqarAT5jgfTfqNf/gcx018ODCtjo4=;
        b=jnqHHhpp0kWEtfvsStNIYVWwd8sH9gG8SNMrYDKPNG0rXsvK0ejsdszDE6u0J3NX1a
         w8TRaYKCTDhOfCmg7f+bYNX2GunXe1uaVKSi+8ATkmo5wo/d86mfWY7uqQQhygV+QZvE
         DBYDft/DKoiMvfAEwNdl/3z120iWYXmOktA+bwccGhNj4qvCnQ0x+2kUJIqZg+/LGMn2
         9q2G9FpsCr7ikxXG4BxG2zkHP6NmDWGVLe4+22ynoikRLGeQaUlp7XVOEePI6cXuSiuT
         i21UzCUES1q0Y0k7awGnIavtJN4pSi1MTXCs5WHNiUpTg9cSk6VSdeG/GvCPzMpq8b7l
         cwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792052952; x=1792657752;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6fmAA4pRjLkz/PBqarAT5jgfTfqNf/gcx018ODCtjo4=;
        b=itbHvYgmWkIHzKmEkqrRXff6hDilygwDRQYEqAnY2+1SqlwSZOb2x58SDZ2xhmQHUH
         +L6E+4Otuyyg2MS0unCVRP375NO554Apc9LL9/f13d8+vBq1QQE+qxFV/BgYfNQik0hc
         17/p+llQ9qJzTjp3nbPdt+WfTHJ5/sSO6UejXSr/O62qvAtw27EjsOWP6038z2K4TFlC
         OqB67cyVOt5rcFeJXZKq11cJL38ytYUBWdnS2Cqk6SFNxSbTI0czn2TBONEYx/Hq4p+5
         vetaJw0A9y6B2mJxALPNkRAdhwRgM+2A8Tm82Z9DxnNmHxQx0PiejgzOh1pQFcCYR2aF
         R6jg==
X-Forwarded-Encrypted: i=1; AKwUvBw5XzWWMlHAqe+Gc58iMYsjGcgfGiJbxuU8SYRRh7oMKQ3pvdmWoqqigKWy3bCBwsw2Hqa87RU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZQVESc+HbLGS0rux2M2nSPY6sSK25ArQS6N4ZqbMtMqFbUt6M
	1Q2BC8Z4pipKuJZqdyfC2fN+jGamTUdHZFiO9ASHtwwBwpvIM2Ew8ZV0sBAnZ3y6giLKwxvgjF1
	8+4MGNRbBTbI91MD7NNA8N7EPIMudSuN8bAkQT/9EU8dJA8Ye/xsXW4h+rw==
X-Gm-Gg: AYBFou3L1lxpHHv96gvvWL6uUDisi/JUTpW9ei8gLbXT1bzzvxJWjHj2n/2IEjLzLEo
	ibq+6AInVFYlkuQIAMWjhLaX6SbXgtNBH7HaDX1OoXNC7XSGsX+Pb0M3HliBhxc1eMDtuRy363U
	7ZWObIjaKwd5wRMGYAfRF1XaGB1iUY6bhpb+YCHCvCRsJxuB197/lpCNU/uiK5IaDA3VEavyOBv
	xptWG05FGWu1KxLP6urHKeNIORNGjzdBUvpNMGQqb/B3h6OhDRIGxvL0aWPm08t0cmhwrHouxXg
	p4fzuSEdSLOkcMVM09wXRFTIN6h0UiPKmGTizu+9iI7KtEVthM6S3BZ9N8Bw3oq8vQtcEsu7BRE
	l+BtobMH+02Z5MrAxklm5kI0snW7LTGUGy+I=
X-Received: by 2002:a05:6000:2085:b0:488:7496:15b5 with SMTP id ffacd0b85a97d-48dbacf126amr34728395f8f.47.1792052952396;
        Thu, 15 Oct 2026 01:29:12 -0700 (PDT)
X-Received: by 2002:a05:6000:2085:b0:488:7496:15b5 with SMTP id ffacd0b85a97d-48dbacf126amr34728336f8f.47.1792052951831;
        Thu, 15 Oct 2026 01:29:11 -0700 (PDT)
Received: from localhost ([62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48df758258fsm1459412f8f.17.2026.10.15.01.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 01:29:11 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Phong LE <ple@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Julien
 Chauveau <chauveau.julien@gmail.com>
Cc: Paul Cercueil <paul.cercueil@bootlin.com>, Nishanth Menon <nm@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] drm/bridge: ite-it66121: fix silent probe regression
 due to reset timing
In-Reply-To: <20261015-drm-ite-it66121-fix-reset-v1-1-473038e06abc@bootlin.com>
References: <20261015-drm-ite-it66121-fix-reset-v1-1-473038e06abc@bootlin.com>
Date: Thu, 15 Oct 2026 10:28:59 +0200
Message-ID: <xlv14iengyes.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Luca Ceresoli <luca.ceresoli@bootlin.com> writes:

Hello Luca,

> Commit e02b5262fd28 ("drm/bridge: it66121: acquire reset GPIO in probe")
> rightfully added code to make the reset pin really work instead of being a
> no-op, but that change introduced a regression making probe fail most of
> the times, at least on some hardware.
>
> On a BeagleBone Black rev.D the IT66122 silently fails probing >90% of the
> times. This is because:
>
>  1. the regmap_read() calls just after it66121_hw_reset() to read the ID
>     registers fail
>  2. there is no error checking for these regmap_read(), execution
>     continues silently
>  3. this results in not matching any of the IDs from it66xx_chip_info
>  4. and this results in silently returning -ENODEV
>
> Empirical tests showed a small delay after de-asserting reset fixes
> probing. Likely the device needs some ramp-up time after reset. No such
> requirement is mentioned in the docs I could find, so the amount of delay
> was chosen by testing: 10 ms worked in 100% of 25 test runs, so setting a
> 20 ms delay should provide a safe margin.
>
> Fixes: e02b5262fd28 ("drm/bridge: it66121: acquire reset GPIO in probe")
> Cc: stable@vger.kernel.org
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
> FYI For items 2 and 4 above, I'm sending separate patches to make those
> errors not silent. Those aren't fixes, so they would be for drm-misc-next,
> while this patch is for drm-misc-fixes.
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index 51fc68ffdf8f..692a85e1e2e8 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -356,6 +356,7 @@ static void it66121_hw_reset(struct it66121_ctx *ctx)
>  	gpiod_set_value(ctx->gpio_reset, 1);
>  	msleep(20);
>  	gpiod_set_value(ctx->gpio_reset, 0);
> +	msleep(20);

Maybe adding a comment here mentioning that this value was found by
testing and is not mentioned in the IT66122 documentation ?

In any case, the patch makes sense to me:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

