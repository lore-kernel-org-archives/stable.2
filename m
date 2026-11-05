Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793852953;
	b=DFl0K1Sl55fPJSbk8uR/xjH+yVUFF2E/OJPL4FwEH4I5QChomtT1n+OuRn9Keex+7Rwe
	 XMlHw1w9pIlAob2nEL3Gbgb7LR8IzkSnEuLWUXss5vssJ9bIu9qsRdT70Sdw7NQXxvW3C
	 Jitn1rNRZtuQvh3iVB+i5uylK+Hw1B8dEi1qXcCPf0rJ2jTP1Bu0Pvu5StudoKG9ALSJM
	 XEKJ8btLg31TQ4KJg+VyzeendcId3QY1zHBQ8h7VTmMpWMg0GeHZBtIHCe7vXh2SOcBuk
	 +nET3aC9+lF/IDdXJKLUZMo+y/QHwtmjoQ7BFBDv9IibA5FiDZ2JU9JhEehJkGWp53Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793852953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=JMo4bIblf20Ox/wHcnXswTyrH1vkkJSSvlX7wiz1Kyg=;
	b=yXeh/OnCRvqirBhYfTLsTQbLKsFaMXVP1kSnANiIhOH2jVlYKPtSaRhocpuEQxQEYeEM
	 Oov9PC0dCkJhdhJYE7oyzospb+ZAwz681LWbwq8i3LK1ZexTDNRpL0gSm8zISXczlpt2O
	 hkyFFICYDojw6DZVOoTgEbu5oQcKQOkOWvMYK8a1+TTJAT7hLA0SaI0zOtMvyGBKToYL+
	 ve7VPTr3/tgWKZDQ5HRQclqUz9bxTnbgUoLQPI+c+mcyM2dzm/glquz2MtDRlfc/Esdhu
	 EGiaoMt50W9RgwLp9XeT9hUKTfmsn1VGekswYKgFP+o0X/nPb7M9dJI5tGdB8SgyIFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tof0ZRuF;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE5D606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 04:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CE5D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tof0ZRuF
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b0a519049aso742533a91.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 20:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793852952; x=1794457752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JMo4bIblf20Ox/wHcnXswTyrH1vkkJSSvlX7wiz1Kyg=;
        b=tof0ZRuFm308akvK86pHS8lOvkDLODF7X76iDUMsZeoOAL5PeMPvKicgb+VR7eA8CE
         CDZC4KeK2881mFNc4MHX8cmbbUI2qbshedQ/ofBO8Mq5HF4rC2Z+moQTT0ckFab2R5JR
         fAPGQIoEe7N94vCvCdMy3q7kKIbMV3/p0/vvankyrxL6JVdvhKLjZ8BJCqAe8sDx5zDF
         xsjq+wFej52YMT6lCH6GXSplD8aF8FkG7ure/XRkcPVwjxaXKUKuPuiSFPTLRnW4M5b/
         gQ/Q8blQ6krBTOD7JQYVAhoGoHVRLdaU+XTeTnuOJrm0uaKCo/o0A3l5PAkQofZGm437
         8nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793852952; x=1794457752;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JMo4bIblf20Ox/wHcnXswTyrH1vkkJSSvlX7wiz1Kyg=;
        b=Rgl00cLsOEnG2rj7Mc1jXEr2LTnjlDu0hYqpw7b31KSec9UFC9nzhsawqe1EZ8NThe
         UzHUCcST92CE+s9QUuv2rpjy7nUmVwJVrh4JwHeBjBAIFGQ56I3B204r0D2NlZa9Ac+/
         9QgsRE6O/5kFYUiArTLTG94HaNcbVJYWeINNManq8d3k/t96UrRiiy08/KqWvbhZJw5m
         HNaA/HROux+rW6j0u1KwN5ektS7VXnFV/qOwcoaOfXrOduujAjx5gq6znkjb5tAE2yGC
         /1tx2A6l2HktmB4+ny92mBB6yC8o+1XzPiyXPi4L2mtUrEP6IkF5lB39dI2JEroPtZ4h
         yHkw==
X-Forwarded-Encrypted: i=1; AKwUvBzZOXOIUYNsbW7aWr0U5hFQAmVm2CJV2WWQi/FRqfV7q0RdfFJxrMADw20yHyEiaGM7nOaCqWo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Q9cW5jpIg7RoZoWNi/csqPQCufqeH4C4j95XW+NKazWwc3GYh
	xmcZkO26G9epNnMv2xSxZvRMZE5/9tm7T7ql+sPYdCR4Zz0oPcEiqmQL
X-Gm-Gg: AYBFou0+c4cnxcriuzoY6QY/p7D06ENxqgWbY2O8bFGmf1gy7v9+ZPMJJJybpRxmWUc
	WLj7DVi/JXpCIkeNG9Kh4hM+8v6cVOqWXZlgBXzU2vMYZZifyKphzLe2z7rHfKke2EJbkxU5TGs
	UuHJYdMGwCqN4TcpS85EfXUOWH268tQZuBNQX9Zf3JOBmSAB6iZpVg6RaRTU7cQeeCN4PCd9rlV
	qNQVM2BnNz79ApBBpvVabgV2TkMK42zRpBa7Rp3CvMkNRjHt0XoExw3AXI4J5768g3oj/hnhrcB
	/TIgaD5pzmuWoJOTSwugFU/fbjuMPHxLxJnrLfDPE0McS7xvUfQGkrzkspUWWOOFOJTqDGp2D2v
	z1lU/13WVTsE/dC/yj+yucKlpXKYfbsGXFd7twXuomxC5b3t09yz+yx5RJnMc60IQvzI44zNYWh
	BsSvC85ybAYI26DNe1LNqpRTwYpER4Y1hLGHl3CXz9OyD9/fG+Nwh1N8+4S5H5L1AORdZRZArMa
	SjKKICzEFGqiPW7SS1fbfFIzUVgw11fVcamLCHD1LTWspjgCO2jxYOmBRWNLdgmIx99ns9qPSb2
	uuF/A2Rvx/KZXGCWrSK5PTOa1eNBTmCnZEJusQRjjiNPBDeQ
X-Received: by 2002:a17:90b:224f:b0:3ab:27f0:c90b with SMTP id 98e67ed59e1d1-3ae8983cf4emr16977504a91.53.1793852952411;
        Wed, 04 Nov 2026 20:29:12 -0800 (PST)
Received: from rigel (194-223-74-160.tpgi.com.au. [194.223.74.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b32812a6sm1611635a91.11.2026.11.04.20.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 20:29:11 -0800 (PST)
Date: Thu, 5 Nov 2026 12:29:05 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Adrian Ambrozewicz <aambrozewicz@nvidia.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/5] gpiolib: don't overwrite the entire flags field in
 gpiod_free_commit()
Message-ID: <20261105042905.GB8436@rigel>
References: <20261104-gpio-desc-flags-atomic-v1-0-e23cedf619ba@oss.qualcomm.com>
 <20261104-gpio-desc-flags-atomic-v1-4-e23cedf619ba@oss.qualcomm.com>
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
In-Reply-To: <20261104-gpio-desc-flags-atomic-v1-4-e23cedf619ba@oss.qualcomm.com>

On Wed, Nov 04, 2026 at 04:36:59PM +0100, Bartosz Golaszewski wrote:
> Use gpiod_update_flags() to clear all request-related flags in one go
> instead of risking racing with concurrent users and overwriting any
> changes they could have done between READ_ONCE() and WRITE_ONCE().
> 
> Cc: stable@vger.kernel.org
> Fixes: 35b545332b80 ("gpio: remove gpio_lock")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/gpio/gpiolib.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 63b65b646fbcfa9ea0f724d1d3e1ac22ba28f638..28d4cf0cef70f437dc4271f82975d09dc55125ea 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2693,23 +2693,23 @@ void gpiod_free_commit(struct gpio_desc *desc)
>  		if (guard.gc->free)
>  			guard.gc->free(guard.gc, gpiod_hwgpio(desc));
>  
> -		clear_bit(GPIOD_FLAG_ACTIVE_LOW, &flags);
> -		clear_bit(GPIOD_FLAG_REQUESTED, &flags);
> -		clear_bit(GPIOD_FLAG_OPEN_DRAIN, &flags);
> -		clear_bit(GPIOD_FLAG_OPEN_SOURCE, &flags);
> -		clear_bit(GPIOD_FLAG_PULL_UP, &flags);
> -		clear_bit(GPIOD_FLAG_PULL_DOWN, &flags);
> -		clear_bit(GPIOD_FLAG_BIAS_DISABLE, &flags);
> -		clear_bit(GPIOD_FLAG_EDGE_RISING, &flags);
> -		clear_bit(GPIOD_FLAG_EDGE_FALLING, &flags);
> -		clear_bit(GPIOD_FLAG_EVENT_CLOCK_REALTIME, &flags);
> -		clear_bit(GPIOD_FLAG_EVENT_CLOCK_HTE, &flags);
> -		clear_bit(GPIOD_FLAG_IS_HOGGED, &flags);
>  #ifdef CONFIG_OF_DYNAMIC
>  		WRITE_ONCE(desc->hog, NULL);
>  #endif
>  		desc_set_label(desc, NULL);
> -		WRITE_ONCE(desc->flags, flags);
> +		gpiod_update_flags(desc,
> +				   BIT(GPIOD_FLAG_ACTIVE_LOW) |
> +				   BIT(GPIOD_FLAG_REQUESTED) |
> +				   BIT(GPIOD_FLAG_OPEN_DRAIN) |
> +				   BIT(GPIOD_FLAG_OPEN_SOURCE) |
> +				   BIT(GPIOD_FLAG_PULL_UP) |
> +				   BIT(GPIOD_FLAG_PULL_DOWN) |
> +				   BIT(GPIOD_FLAG_BIAS_DISABLE) |
> +				   BIT(GPIOD_FLAG_EDGE_RISING) |
> +				   BIT(GPIOD_FLAG_EDGE_FALLING) |
> +				   BIT(GPIOD_FLAG_EVENT_CLOCK_REALTIME) |
> +				   BIT(GPIOD_FLAG_EVENT_CLOCK_HTE) |
> +				   BIT(GPIOD_FLAG_IS_HOGGED), 0);
>  #ifdef CONFIG_GPIO_CDEV
>  		WRITE_ONCE(desc->debounce_period_us, 0);
>  #endif
> 

Not directly related to your change, but the debounce_period_us is
protected by the GPIOD_FLAG_REQUESTED flag, so it should be cleared
before the flag, else it could potentially race with a new request.
Not sure if you want to fix it here or in a separate patch.

Cheers,
Kent.
