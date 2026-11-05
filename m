Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793852638;
	b=E4Lmm9Yvxr3qUqDra6BENdtKbHhSmZjFbo2KEZS6Ga7pE7/dW3b+svaU8zoeSSz+XYCl
	 /Wc5Dxd9+FP38H45Z6eQ1fq3905poBm6xOu87x6Egf2m5cH/HuEc2b3aMH5dP84yVW5JF
	 sBunkhfLQafm1+7X35Svwxr7hNx8pzjlGmASrRGrldvgkVI7kfkAAo6an7eKBRuqUq1YW
	 g9ZuOpZuLwL+4Fk2al5kdCzdNiiITAkXFlqkzlrtomuZvDWhx5VO/dxOCaxRDg44BeT/V
	 GRAYKEVU/RUy4b7b4bWMItmffdG5ZgetiAF4sQ6Whma/D/LmidE1uTo8EOTJstKzw7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793852638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=0Ic22w/EG1/wGaj0qAXu35aYDokPrgCRY3cSmP40FPc=;
	b=rEYuNJmhHo+v+GnmqYYDG9AY5Z5ecFot2s9NP8pJl6UtZqSr1cVOk3czMDPmtmr42i9B
	 Eba+Q5QnbDcZQiP4mk7eWYYU+NuvOtFbSuB7O4aCTEi3Z2yGMlyseZMJ7wDjz+Xi4CWIu
	 3lwqf/lpGDz/WXWR5bafWVG9IIFG244tf2HJoWiJtJrPALg+pVvntXe/t3ZlSaeU/Fsg9
	 2VeaVRCF/TIEnrariXfiQGnFVMJU29MiAjS4UrCX1XZJnaIWKB3vh+XSpcC99+XIqU0XB
	 iHb2h2HYn0IJpCw22bKxQ/cChCIHzFNxngmVwJT9bTUucy95IFLLhuSozNmKTP5xM6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="K/LUUDcc";
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E544B606A32D
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 04:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E544B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K/LUUDcc
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso3762709eec.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 20:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793852637; x=1794457437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0Ic22w/EG1/wGaj0qAXu35aYDokPrgCRY3cSmP40FPc=;
        b=K/LUUDccLX+qTBm7UcPTDL27HGE++ItvMbbx2fYN0zjTjbKhr5OruZA/U7XyohQJ+F
         3az/M6N7+cDpLM3MORa9LKSuduqeXftKxiYYvJpaavCkveXYccJgOZK+HVrVT6kJRVCG
         gE0XHgswm0RJA2PGbm2XTWut+QNKK4gjk3+u1jsBemZT/Iwj3O+UM5zA+KOFO3Sz/gML
         u/WOXZJ4CJI10W36On7HS+7xMUQd6lYimmjCw7NFwn6E9KMXGPGxupMk6e6BSzO4bNQb
         018CovunjInZ0AQROTlN4Sp1zp8UWZmPfS3memHNUNS80h9Cm/hk/AfScfGAzmwaaRL3
         rtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793852637; x=1794457437;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Ic22w/EG1/wGaj0qAXu35aYDokPrgCRY3cSmP40FPc=;
        b=tjNcq8CVXwNjeU+ANCHBO4ANWxsQMG1pHzc7IAF6dJmqT5VguUfJvPEh7o0dpYutS8
         ggJKn3ITsftGgJdWyCiKem8ZQUet+pxy35TFcZFogkXZ8NW1Fqf4P+SBdhrqmG+AAVwk
         lJ2Vg9qlk9VzZhctCe7WEG0EMPDQPf5YK5kZmyVODVWdJYj4ihhHZ4h7XYmucu1sNCRw
         yWOZKsdK5oV7a0tcWfidWLrldBsqVeFIpx8ZazkuKv2NIj1rSHH8t8z/PJfs5GWypJSn
         YFagiRYelkTThHd5XUeHnKzJ5kD5iV9RYbigbQbdLcULubKn82ITXE8MOdRu7+uIUIPN
         S65Q==
X-Forwarded-Encrypted: i=1; AKwUvBxXGSt8+fIEkb7x9SYamQ9U0TukA/t93aw02b+lvYPkTm+YFonbKdkXCpf4AUDN5FOFOLT+D/4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8WYGmvKjfj4Y6YfUMT4ukfRJJ/8CAGlPbn09iMPJoJf730I1tT
	59/OORO4OGdPutRFB4aerBC6SxVur3rqERZOPFlY7nVzNee8KYRyvGQ5
X-Gm-Gg: AYBFou2gPSeDirtNqyshRyQf/7oOdftnqEKaL03SKcQuRGFFYFaNBtAISZhEKo+xnH9
	V+Y7ntQw+SsHED6Lp2Csv4QMCTnbD1CaH1wL3xJB0xPJ55bvGPzUSFXdB5i5JAD+tuOdUebibBu
	qoHQL5aKv/5Qxw+vLKC24OhR20RoSNhjdoMAY1dABSbNh8TEsJFoLYpAqI1Q0LR5dJvFqinl8Ir
	1jIWINz5Xfc5F49xZwwsr5KmqHVNamNQRlmEZJi2pOuyXYvm13nW7ZbsHCids0DtrGCell15HfY
	/i8zsB4sQqm3mTF4PGLIqF7O8jUOBIp6BbTKU8J29KRao98gGLVthxChXjUeHa8ba31JZ+9t+2u
	QKNOnuOQhGioW+ZY/Hr8pTI4vVfmqtWYTYBOBB9EsloIQFBpaf0GzWYvN23lMZvHTWzXrw9EjKO
	JBNSLYP/ZBXBPfQ8rJyY++dIVegne+1eNqlLfwkXy80BuYGOTAsqBHWAz3n2RG4rEboceDhAU+B
	n899Nzz/rze11JcLDwLBW3chTCqAb4HbvvW/ZEYdDAl8HE26zYsOLQatnVxI4Rh8qBfL9+Dwoo5
	AQ4T2QdviOFFqYpXKNduEFoQ50g6IzABJPvLIwcZDjtuE2un/Mbn/SCRuOSjjtkDjZlMcQ==
X-Received: by 2002:a05:7022:f903:b0:149:cfa4:9b3b with SMTP id a92af1059eb24-1ac55776fa1mr27637322c88.3.1793852636693;
        Wed, 04 Nov 2026 20:23:56 -0800 (PST)
Received: from rigel (194-223-74-160.tpgi.com.au. [194.223.74.160])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3788bffsm12394555eec.1.2026.11.04.20.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 20:23:56 -0800 (PST)
Date: Thu, 5 Nov 2026 12:23:45 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Adrian Ambrozewicz <aambrozewicz@nvidia.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/5] gpio: cdev: don't overwrite the whole flags field
 when configuring lines
Message-ID: <20261105042345.GA8436@rigel>
References: <20261104-gpio-desc-flags-atomic-v1-0-e23cedf619ba@oss.qualcomm.com>
 <20261104-gpio-desc-flags-atomic-v1-5-e23cedf619ba@oss.qualcomm.com>
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
In-Reply-To: <20261104-gpio-desc-flags-atomic-v1-5-e23cedf619ba@oss.qualcomm.com>

On Wed, Nov 04, 2026 at 04:37:00PM +0100, Bartosz Golaszewski wrote:
> linehandle_flags_to_desc_flags() and
> gpio_v2_line_config_flags_to_desc_flags() read the flags word with
> READ_ONCE(), modify the local copy and write it back with WRITE_ONCE().
> 
> The per-request config_mutex does not exclude sysfs, the irq core or
> drivers touching the same descriptor, so bits they set or clear
> concurrently can be lost.
> 
> Build the mask of bits owned by the line configuration and their new
> values locally and apply them with gpiod_update_flags(). The whole
> group changes in a single atomic step.
> 
> Cc: stable@vger.kernel.org
> Fixes: b7adfb6076ff ("gpio: cdev: update flags at once when reconfiguring from user-space")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 118 ++++++++++++++++++++++++--------------------
>  1 file changed, 65 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index 3f1f8c9acfc3c10d5b3e86b70009f1226793cbc7..b7f0aec12c8551e39d042a1999fdfb5683ae97d7 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -140,24 +140,30 @@ static int linehandle_validate_flags(u32 flags)
>  	return 0;
>  }
>  
> -static void linehandle_flags_to_desc_flags(u32 lflags, unsigned long *flagsp)
> -{
> -	unsigned long flags = READ_ONCE(*flagsp);
> -
> -	assign_bit(GPIOD_FLAG_ACTIVE_LOW, &flags,
> -		   lflags & GPIOHANDLE_REQUEST_ACTIVE_LOW);
> -	assign_bit(GPIOD_FLAG_OPEN_DRAIN, &flags,
> -		   lflags & GPIOHANDLE_REQUEST_OPEN_DRAIN);
> -	assign_bit(GPIOD_FLAG_OPEN_SOURCE, &flags,
> -		   lflags & GPIOHANDLE_REQUEST_OPEN_SOURCE);
> -	assign_bit(GPIOD_FLAG_PULL_UP, &flags,
> -		   lflags & GPIOHANDLE_REQUEST_BIAS_PULL_UP);
> -	assign_bit(GPIOD_FLAG_PULL_DOWN, &flags,
> -		   lflags & GPIOHANDLE_REQUEST_BIAS_PULL_DOWN);
> -	assign_bit(GPIOD_FLAG_BIAS_DISABLE, &flags,
> -		   lflags & GPIOHANDLE_REQUEST_BIAS_DISABLE);
> -
> -	WRITE_ONCE(*flagsp, flags);
> +static void linehandle_flags_to_desc_flags(u32 lflags, struct gpio_desc *desc)

This used to be a conversion function, hence the a_to_b naming.
Now it is specifically updating the desc flags, so how about
linehandle_update_desc_flags()?

> +{
> +	const unsigned long mask = BIT(GPIOD_FLAG_ACTIVE_LOW) |
> +				   BIT(GPIOD_FLAG_OPEN_DRAIN) |
> +				   BIT(GPIOD_FLAG_OPEN_SOURCE) |
> +				   BIT(GPIOD_FLAG_PULL_UP) |
> +				   BIT(GPIOD_FLAG_PULL_DOWN) |
> +				   BIT(GPIOD_FLAG_BIAS_DISABLE);
> +	unsigned long val = 0;
> +

Agree with Andy - this should be flags, not val.

> +	__assign_bit(GPIOD_FLAG_ACTIVE_LOW, &val,
> +		     lflags & GPIOHANDLE_REQUEST_ACTIVE_LOW);
> +	__assign_bit(GPIOD_FLAG_OPEN_DRAIN, &val,
> +		     lflags & GPIOHANDLE_REQUEST_OPEN_DRAIN);
> +	__assign_bit(GPIOD_FLAG_OPEN_SOURCE, &val,
> +		     lflags & GPIOHANDLE_REQUEST_OPEN_SOURCE);
> +	__assign_bit(GPIOD_FLAG_PULL_UP, &val,
> +		     lflags & GPIOHANDLE_REQUEST_BIAS_PULL_UP);
> +	__assign_bit(GPIOD_FLAG_PULL_DOWN, &val,
> +		     lflags & GPIOHANDLE_REQUEST_BIAS_PULL_DOWN);
> +	__assign_bit(GPIOD_FLAG_BIAS_DISABLE, &val,
> +		     lflags & GPIOHANDLE_REQUEST_BIAS_DISABLE);
> +
> +	gpiod_update_flags(desc, mask, val);
>  }
>  
>  static long linehandle_set_config(struct linehandle_state *lh,
> @@ -182,7 +188,7 @@ static long linehandle_set_config(struct linehandle_state *lh,
>  
>  	for (i = 0; i < lh->num_descs; i++) {
>  		desc = lh->descs[i];
> -		linehandle_flags_to_desc_flags(lflags, &desc->flags);
> +		linehandle_flags_to_desc_flags(lflags, desc);
>  
>  		if (lflags & GPIOHANDLE_REQUEST_OUTPUT) {
>  			int val = !!gcnf.default_values[i];
> @@ -346,7 +352,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
>  		if (ret)
>  			return ret;
>  		lh->descs[i] = desc;
> -		linehandle_flags_to_desc_flags(handlereq.flags, &desc->flags);
> +		linehandle_flags_to_desc_flags(handlereq.flags, desc);
>  
>  		ret = gpiod_set_transitory(desc, false);
>  		if (ret < 0)
> @@ -1224,36 +1230,42 @@ static int gpio_v2_line_config_validate(struct gpio_v2_line_config *lc,
>  }
>  
>  static void gpio_v2_line_config_flags_to_desc_flags(u64 lflags,
> -						    unsigned long *flagsp)

How about linereq_update_desc_flags()?

> -{
> -	unsigned long flags = READ_ONCE(*flagsp);
> -
> -	assign_bit(GPIOD_FLAG_ACTIVE_LOW, &flags,
> -		   lflags & GPIO_V2_LINE_FLAG_ACTIVE_LOW);
> -
> -	assign_bit(GPIOD_FLAG_EDGE_RISING, &flags,
> -		   lflags & GPIO_V2_LINE_FLAG_EDGE_RISING);
> -	assign_bit(GPIOD_FLAG_EDGE_FALLING, &flags,
> -		   lflags & GPIO_V2_LINE_FLAG_EDGE_FALLING);
> -
> -	assign_bit(GPIOD_FLAG_OPEN_DRAIN, &flags,
> -		   lflags & GPIO_V2_LINE_FLAG_OPEN_DRAIN);
> -	assign_bit(GPIOD_FLAG_OPEN_SOURCE, &flags,
> -		   lflags & GPIO_V2_LINE_FLAG_OPEN_SOURCE);
> -
> -	assign_bit(GPIOD_FLAG_PULL_UP, &flags,
> -		   lflags & GPIO_V2_LINE_FLAG_BIAS_PULL_UP);
> -	assign_bit(GPIOD_FLAG_PULL_DOWN, &flags,
> -		   lflags & GPIO_V2_LINE_FLAG_BIAS_PULL_DOWN);
> -	assign_bit(GPIOD_FLAG_BIAS_DISABLE, &flags,
> -		   lflags & GPIO_V2_LINE_FLAG_BIAS_DISABLED);
> -
> -	assign_bit(GPIOD_FLAG_EVENT_CLOCK_REALTIME, &flags,
> -		   lflags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME);
> -	assign_bit(GPIOD_FLAG_EVENT_CLOCK_HTE, &flags,
> -		   lflags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE);
> -
> -	WRITE_ONCE(*flagsp, flags);
> +						    struct gpio_desc *desc)
> +{
> +	const unsigned long mask = BIT(GPIOD_FLAG_ACTIVE_LOW) |
> +				   BIT(GPIOD_FLAG_EDGE_RISING) |
> +				   BIT(GPIOD_FLAG_EDGE_FALLING) |
> +				   BIT(GPIOD_FLAG_OPEN_DRAIN) |
> +				   BIT(GPIOD_FLAG_OPEN_SOURCE) |
> +				   BIT(GPIOD_FLAG_PULL_UP) |
> +				   BIT(GPIOD_FLAG_PULL_DOWN) |
> +				   BIT(GPIOD_FLAG_BIAS_DISABLE) |
> +				   BIT(GPIOD_FLAG_EVENT_CLOCK_REALTIME) |
> +				   BIT(GPIOD_FLAG_EVENT_CLOCK_HTE);
> +	unsigned long val = 0;
> +

And again.

> +	__assign_bit(GPIOD_FLAG_ACTIVE_LOW, &val,
> +		     lflags & GPIO_V2_LINE_FLAG_ACTIVE_LOW);
> +	__assign_bit(GPIOD_FLAG_EDGE_RISING, &val,
> +		     lflags & GPIO_V2_LINE_FLAG_EDGE_RISING);
> +	__assign_bit(GPIOD_FLAG_EDGE_FALLING, &val,
> +		     lflags & GPIO_V2_LINE_FLAG_EDGE_FALLING);
> +	__assign_bit(GPIOD_FLAG_OPEN_DRAIN, &val,
> +		     lflags & GPIO_V2_LINE_FLAG_OPEN_DRAIN);
> +	__assign_bit(GPIOD_FLAG_OPEN_SOURCE, &val,
> +		     lflags & GPIO_V2_LINE_FLAG_OPEN_SOURCE);
> +	__assign_bit(GPIOD_FLAG_PULL_UP, &val,
> +		     lflags & GPIO_V2_LINE_FLAG_BIAS_PULL_UP);
> +	__assign_bit(GPIOD_FLAG_PULL_DOWN, &val,
> +		     lflags & GPIO_V2_LINE_FLAG_BIAS_PULL_DOWN);
> +	__assign_bit(GPIOD_FLAG_BIAS_DISABLE, &val,
> +		     lflags & GPIO_V2_LINE_FLAG_BIAS_DISABLED);
> +	__assign_bit(GPIOD_FLAG_EVENT_CLOCK_REALTIME, &val,
> +		     lflags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME);
> +	__assign_bit(GPIOD_FLAG_EVENT_CLOCK_HTE, &val,
> +		     lflags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE);
> +
> +	gpiod_update_flags(desc, mask, val);
>  }
>  
>  static long linereq_get_values(struct linereq *lr, void __user *ip)
> @@ -1411,7 +1423,7 @@ static long linereq_set_config(struct linereq *lr, void __user *ip)
>  		 */
>  		if (!(flags & GPIO_V2_LINE_DIRECTION_FLAGS))
>  			continue;
> -		gpio_v2_line_config_flags_to_desc_flags(flags, &desc->flags);
> +		gpio_v2_line_config_flags_to_desc_flags(flags, desc);
>  		edflags = flags & GPIO_V2_LINE_EDGE_DETECTOR_FLAGS;
>  		if (flags & GPIO_V2_LINE_FLAG_OUTPUT) {
>  			int val = gpio_v2_line_config_output_value(&lc, i);
> @@ -1667,7 +1679,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
>  
>  		lr->lines[i].desc = desc;
>  		flags = gpio_v2_line_config_flags(lc, i);
> -		gpio_v2_line_config_flags_to_desc_flags(flags, &desc->flags);
> +		gpio_v2_line_config_flags_to_desc_flags(flags, desc);
>  
>  		ret = gpiod_set_transitory(desc, false);
>  		if (ret < 0)
> @@ -2062,7 +2074,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
>  	le->desc = desc;
>  	le->eflags = eflags;
>  
> -	linehandle_flags_to_desc_flags(lflags, &desc->flags);
> +	linehandle_flags_to_desc_flags(lflags, desc);
>  
>  	ret = gpiod_direction_input(desc);
>  	if (ret)
> 

Overall I like the series.
Good to see there is a raw version of try_cmpxchg() that can be combined with
the existing atomic bitops without the questionable casting I was using
with the atomic_long_try_cmpxchg().  That makes a whole load of sense.

A couple of things not covered in these patches, but related to flag
consistency:

GPIOD_FLAG_USED_AS_IRQ is used as a lock over GPIOD_FLAG_IRQ_IS_ENABLED.
e.g. gpiochip_enable_irq() and gpiochip_disable_irq() both warn and drop
thru if it is not set.
Yet gpiochip_lock_as_irq() does not check if it is already set, even just to
raise a warning.  Why not?
Does the updating of those two flags by gpiochip_lock_as_irq() and 
gpiochip_unlock_as_irq() need to be atomic?  Not individually atomic but
as a pair, else they race with gpiochip_enable_irq() and
gpiochip_disable_irq()?
Similarly, don't gpiochip_enable_irq() and gpiochip_disable_irq() need
to perform an atomic test (of GPIOD_FLAG_USED_AS_IRQ) and set
(of GPIOD_FLAG_IRQ_IS_ENABLED) so as not to race with the lock/unlock?

Cheers,
Kent.
