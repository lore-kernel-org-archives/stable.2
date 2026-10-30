Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358894;
	b=B8giWU207niluuuCbOSkIklwzZpCUf1HQwcFK1E4IyZKJfTtWWPm3eDjyDrYrekhzaPO
	 7BxZWxMPDoRv2/Ls11P5POCpjgN9EDvMj4yuzrte/H/zLyJt8WTu03qjQ0DfBhrT6V2K8
	 AXG7qveOcGIApSWl+Ls8h/SGbbg69ixIliZsHAbvvu7v9JORXBZ+8x8YSJPPU4E872g9F
	 askOG4gqcyIPoLSVXJFzcF3bKah+kuKSZO0qTNMAzy/VsFSr9fYBIS63RRjcYEJr1n5sP
	 vhuvQUwYXQKrStcLwSLKrviGv0cJYwicrSggcTypwJfoPloPLXbg4AxEQ4JKDk37wNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Mr1+XuTgSkjae7K1Qb91H4lBdSosGmI/b2MCp8eMYDU=;
	b=G7Qj48PtLaUy690Hwt4LC7qSF5u76vPFIP69fxOWApUWVS72GxhP8GUcNtk9anuRmigR
	 Pql8eC26ZuLTlj3LNTOfSvjw0PpO90idRNAc/K8+/y9M4o4aGnuByLFXHixUL9RfPifb9
	 Q+QUmgY5pPfPLkOyrqxhTdZ7HIYZKaX35p57Mx/JguHqok8s6GuHfrD6Y2NMwGZt7+CkT
	 P+2iJekWz7GfHbhTrfmI874vpU0ErnkdZnpzjWMHvdIc0bQfWozuPie+0dKMNq5oH3P87
	 a7+CtEATYWx4rUeOfsG4gVDsO0HP8gVMu46VqWxQUEFYlq74mSKuVLMcnoHkUP+om+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="cKbDNQ/W";
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67785606A31F
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 11:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67785606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cKbDNQ/W
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso371701a91.2
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 04:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793358889; x=1793963689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mr1+XuTgSkjae7K1Qb91H4lBdSosGmI/b2MCp8eMYDU=;
        b=cKbDNQ/WlZdgYHgXvsoeLIfDefTUui4goSPq94ObGf8vvLgtnUW+WPGBaZQ5llYMq7
         2PpkB8KatXY5F6q9N1rQNUeARnAR4wqsBmlE8eme18Cmwrtl2RbOqztYdsflN8Dj31XS
         B+qmtU5mr8amQDdncuO14gvxnAnioSO2TmFOFXBsa3XkDJjiqkeeLuAB86aNi9ZCfQqA
         HgrX7+Nitfbmk998l4iVm749LxVyb8zlkyd1/UBOxIdqUKi3nVivUXru/ieJTjFPyZU+
         i7CeZCnEEDfHx2OuTaouP3xCxyp9lVi6U+mrqkp356TUT2eSaeYZiO0ADDxTEj2L1oA4
         F18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793358889; x=1793963689;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mr1+XuTgSkjae7K1Qb91H4lBdSosGmI/b2MCp8eMYDU=;
        b=FGD9nuETPMPW/ZTRp6o3Itcddg6oBvqdfyW3xnTWV694Jybl/XunIerNBGxhEflQ24
         UOncrwF/esA+wN/wTwz2WRGE/KW4gDEa/Y/7n/tc8NKsxeFVBci462SGZq72UEtWZcQP
         T6JENvTs2bkM95f3hrBJdZ154FrYgDvgjNRCrZYqJnHlq0j+wx9czQiGutdVCAh0gsDo
         U7ND8HPvGC4x5HiLxUyhn3BM7VR86qlWE5g6J5WyUtCZTKUdZocc2p08WPBk7Unrv9h3
         4juqC8jFEV0Gi/K4pW7slt4OkAfVpic6qWx4Hgy/upM7WH24wKkE0evIesL5yuIwurRO
         Ml8g==
X-Forwarded-Encrypted: i=1; AKwUvBytUcB2HSNsTEEoyOkiq1cJDbAfCBe+9ih2nEcZ6sbeRPDql5sCwD50k/cPvK1Y7VpY/sGI+k0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJK2H5ZiR7P7IRelVF4HWMWxd0qLasU1pbGP1PExS3bi55yDJgH
	g15QDOckSf8kPwm5pg+9mRLCGlnZmRI9u/lCWYozOg67ArUMmNCOFECo
X-Gm-Gg: AYBFou2uFW7xlwgTLhRGcAjLT/hk7yxdl6SMZKnnGENxPSEsFF6TyNySHe+l5tAlK7l
	gX9EZ42APBdYTsUvB1c3hKpBGQ/LPK9AjhZCt12WMqdPTPtXncTR1FSE2iyJ3wrJ5+9tY2Eg9ct
	pgGCkZ8XqTLCkObneZcTGr5xV6kZdfdjLvnJfe0KJxElntRyV2EepJqVNt3jckkZIY6HUcTdKXi
	ICQJdIVDPhrk1uIfCjHwAzlPgpnuoCRcrgY3bVDAuJdObK8psN/hyM34Dt8OgMKBd0oTSj3pFiX
	zq6XC8yUZDIkE0oCgxuXxYI7DqLlzzRx8sJAV6UrCt1t0iOGVS7lQVEFn6vrVYL56CN4ZWwnAXV
	jDkAqsC3Hbax/HOO1obVvYIu96HUZLp4WkuPlDKPR1juoXHPEDPjlnvHkISE3Qr4aWzLjEoT4ib
	bKnYrgPkKPLuHYbuKTimG/2n6NUt5NlX/vHVt+0+x5TiVYfGmK7eDhsdvrD3Azp8h135bqrCnLl
	vI7GU5fMQ92a7HBgSRrmrUUIM2e8YNUlhbXneLXUFruCZeP7rlAsQeeeOPIpNNhgVVm7xTypape
	AIFai/+2PkHITCsgE7VaXkRb5LJog6Tawf5BjiSqJWhRJ3E/
X-Received: by 2002:a17:90b:5827:b0:3ab:be66:ddb7 with SMTP id 98e67ed59e1d1-3ae897bae26mr1591051a91.47.1793358888671;
        Fri, 30 Oct 2026 04:14:48 -0700 (PDT)
Received: from rigel (194-223-74-160.tpgi.com.au. [194.223.74.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845432e4sm3771544a91.3.2026.10.30.04.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:14:47 -0700 (PDT)
Date: Fri, 30 Oct 2026 19:14:35 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v4 6/7] gpiolib: cdev: don't report a failed line read as
 an edge
Message-ID: <20261030111435.GA76958@rigel>
References: <20261029-gpiolib-chip-removal-v4-0-aambrozewicz@nvidia.com>
 <20261029-gpiolib-chip-removal-v4-6-aambrozewicz@nvidia.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-gpiolib-chip-removal-v4-6-aambrozewicz@nvidia.com>

On Thu, Oct 29, 2026 at 01:29:21PM +0200, Adrian Ambrozewicz wrote:
> With both edges requested, the IRQ threads read the line to tell a
> rising edge from a falling one, and report any non-zero result as
> rising, an error included. A read fails when a hot-pluggable chip is
> going away, or when gpiochip_remove() has cleared gdev->chip before the
> IRQ is freed.
> 
> Drop the event when the read fails, as debounce_work_func() does.
> 
> Reproduced with gpio-sim and a test delay in the IRQ threads: a falling
> edge during chip removal is read as rising; with this change, it is
> dropped and read() returns -ENODEV. The HTE path was compile-tested.
> 
> Fixes: 61f922db7221 ("gpio: userspace ABI for reading GPIO line events")
> Fixes: 73e0341992b6 ("gpiolib: cdev: support edge detection for uAPI v2")
> Fixes: 2068339a6c35 ("gpiolib: cdev: Add hardware timestamp clock type")

How did you determine that?  Those commits are where the associated blocks
of code were first added - not where the problem first exhibited.

The failure mode you are addressing was added by
commit d83cee3d ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU").
Prior to that gpiod_get_raw_value_commit(), and gpiod_get_value_cansleep()
and gpiod_get_raw_value_cansleep() that wrap it, wouldn't return the error
that you are handling.

Could you bisect to confirm?

The code change itself looks good.

Cheers,
Kent.

> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20261020-gpiolib-chip-removal-v3-0-aambrozewicz@nvidia.com?part=6
> Assisted-by: LLM
> Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index cf23b5296fd1..0d6853751e6e 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -643,6 +643,8 @@ static enum hte_return process_hw_ts_thread(void *p)
>  		level = (line->raw_level >= 0) ?
>  				line->raw_level :
>  				gpiod_get_raw_value_cansleep(line->desc);
> +		if (level < 0)
> +			return HTE_CB_HANDLED;
>  
>  		if (edflags & GPIO_V2_LINE_FLAG_ACTIVE_LOW)
>  			level = !level;
> @@ -743,6 +745,7 @@ static irqreturn_t edge_irq_thread(int irq, void *p)
>  	struct line *line = p;
>  	struct linereq *lr = line->req;
>  	struct gpio_v2_line_event le;
> +	int level;
>  
>  	/* Do not leak kernel stack to userspace */
>  	memset(&le, 0, sizeof(le));
> @@ -763,7 +766,10 @@ static irqreturn_t edge_irq_thread(int irq, void *p)
>  
>  	switch (READ_ONCE(line->edflags) & GPIO_V2_LINE_EDGE_FLAGS) {
>  	case GPIO_V2_LINE_FLAG_EDGE_BOTH:
> -		le.id = line_event_id(gpiod_get_value_cansleep(line->desc));
> +		level = gpiod_get_value_cansleep(line->desc);
> +		if (level < 0)
> +			return IRQ_HANDLED;
> +		le.id = line_event_id(level);
>  		break;
>  	case GPIO_V2_LINE_FLAG_EDGE_RISING:
>  		le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
> @@ -2006,6 +2012,8 @@ static irqreturn_t lineevent_irq_thread(int irq, void *p)
>  	    && le->eflags & GPIOEVENT_REQUEST_FALLING_EDGE) {
>  		int level = gpiod_get_value_cansleep(le->desc);
>  
> +		if (level < 0)
> +			return IRQ_HANDLED;
>  		if (level)
>  			/* Emit low-to-high event */
>  			ge.id = GPIOEVENT_EVENT_RISING_EDGE;
> -- 
> 2.43.0
> 
