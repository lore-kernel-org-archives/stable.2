Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795016382;
	b=Kvqj1E0oc8NPRh1UKUv0GgDcSiqxV0U+j6P6llwp7TE50Cu0kgNdrGZH6Yve9UD7G1Tx
	 x0nNTuz0IjEHS5ajaDETuHmgRmUWXciFhjzTkTrptP+QFE1Ee0DsWN4H8PRZdlewsldMG
	 wp9WHzAr54bq3PpIUjjL192TY1MW4x/A2o50Y1tu9+Dqnwd5D8DM1DYe/BJVJV2c+ATkZ
	 LxtOseekSyeASIB4HI1AJq9Ii4vTKpA69bxdboGR/JeeIVWIqr0Zd0GS6u8mek8WOgSQF
	 rpn5JJ0ztzPmAVJZUwB1BcEHAkR9fYDf4V8zaY8blt03c40NjFhhDo82z9d8f8qtXFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016382;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5ax3Lipd+AcivWLlLBqoyKXnHoFVYuzVHK/u3oZQ3q8=;
	b=TYWxoXfeP/M7Iu3nOLIIaSZnTpd17PWU8KlpjRJat8HCIyyUkkJ8IsVK4IjG7kftun+Z
	 cFT0akFam2LU/yY0j+LNgSPS4j79QbSw0zGBJWHlovYYI4BZbrcBcLE47bInsE6hArlK0
	 faZZTCEK54YVT13AS9WLhFsSuYsppFziHVUaxXkzceTrOOzPqFU76Chp3TN0w0/js9raH
	 iDJ1gwsbXTc3lgQ+VBOu8Tsk2MrOQbpv8r+xk1sSa3JOuUt00r47yiw/O7Mb+/sFzeGmK
	 +u3XvotdYMdmjO6Dc3XPLMtiH8JsU4H9uZZfRuH1yUo4WYiZzlIKUWFxU6w6CQgkdJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ChN4RtDN;
	arc=none smtp.remote-ip=209.85.167.182
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA42F60A260B
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 15:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA42F60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ChN4RtDN
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-55e02e89f78so378020b6e.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 07:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795016381; x=1795621181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5ax3Lipd+AcivWLlLBqoyKXnHoFVYuzVHK/u3oZQ3q8=;
        b=ChN4RtDNL4FAZnfKWrkcqtZR9IwHiD412LxnId3JvdDhc10w9CNmIAgsuSll3tHp2S
         w3KfmBSLf8edMN/+2ABaalGwez79ruoZ/SLHAW5f8PboytQDbTeWW3KMmtPzNVcAS1XL
         LacFnrw01OSIW6IiBARxJfk2riKOsOXA2hPsu+tHeK7H8HqUZwqtrRDkUEh4+I3EVtAm
         KlaNLYjxxtrM5ZeDXLOKDL37vL6bOMnswIdnJehE7PBi4+/Tg7d7t/Imgru0kNALnnUR
         +pnmMFx/6a5ctuXYw9NsymB5Ipe0OBvr0807ptcZxoYCgpG623H5kq+8yLlmuu05TsF4
         /j6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795016381; x=1795621181;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ax3Lipd+AcivWLlLBqoyKXnHoFVYuzVHK/u3oZQ3q8=;
        b=twlOY/LngUyEwy//jXzluR5qDM8xmJHjtpeoPe45+uKFdx1gjtHWEGpuhj89wl3vrM
         dOrICDtHNrmbadkbEkX3101t4xXTJFwu2IwOPPBEKeoYLb0hi5qwid8yImP7ORbxR6LQ
         7naEC/WIUcNPBrmea3XonPbud3HVkTphrcyPfnWiSDxyk0Lr1xpKfQpunMRZ4svOkYwL
         Ub4cPLAbodNvrWo3JFDDn7jFKn7JxWwseBxR3mFQqwM/HTzpBs7Ignj/pjXPXultlH0X
         m62hj7nTT7LMOcI5DR+G3jpwSwbPP/llNABF53B1Tjf98o6UMEI9nB5kvUjW0b0H0vFQ
         juEA==
X-Forwarded-Encrypted: i=1; AL+hErHRCdiqAAqmMaA0cfMlrvADDYbxoO8fYmsnbIqHOzjbx00HPe2dafKjA5+IIoyyAG1F6wJLKMc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SHuT6beSLUwBT0yDZJlNeIuu09JD4Hly5yMXzmKuedRNFXMg7
	q0pvqcGzyUUObhACceusYXY7BNeWXr07j7C4rJcEDxiuFYOLVg+dB7BNIMHToQ==
X-Gm-Gg: AYBFou0qMBJKSSGvGORUDPMk9mjG2jyX+E2y2FO9RRMB82G3ZkoTf8xlOcPp/TwH7SH
	H0wlN+CGsDSKkb6PEZqmcUzKBLPTernGNRokmVtLNgNbIrCKBuatwxIMA2RwhV7OKXy+QPBeZOK
	XPhlqbcy9p3m4Gw8rOK04yN9mc+Ysz9tPn9Fc5reBP0UL/Vp3R0IdmS4g18F9v2ZQQlL7peIWNR
	EsNDnHa0DmCbuc/MQ79H2GxhwjQmXu7bfx8ro7y2X1UBrkyrSDzpcvzoTow/61ppIFXEBmR2gBw
	XSMy7Rxh1OvO4fa107TtZHUNeVA3u8I4RRiiEOafEEntBI6+0APMgR4BG7gwgG8obkUzDznLA9g
	SWpEGhWxla2BIMYPGJ5jeDqIZWnmZG1XyRsZqIrmNGx+NCsWt4n4gRuKPZjor//AyXAAEBYJ4al
	OLWQAf4hQzu7Vtk4T9PFc2QIT6VdEx+bFj/jo7q3MH95oSNwMCG1POhMxhFmXsjjDj8itZ6X74s
	xv65TCmyLrVLiFryEGP170qunOvdKpfLbF+wSzVmjie//V9XKxYZT9Nsme1iF9tdKLnCibV2F8x
	AtMWUpjBYvNzT5XeLShEazMFun+wXds4ezELAfkA2Ng8W2R4
X-Received: by 2002:a05:6808:220e:b0:573:f2e:2bee with SMTP id 5614622812f47-57741723566mr3647243b6e.37.1795016380749;
        Wed, 18 Nov 2026 07:39:40 -0800 (PST)
Received: from rigel (106-68-220-184.tpgi.com.au. [106.68.220.184])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57775461e70sm1987291b6e.0.2026.11.18.07.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:39:39 -0800 (PST)
Date: Wed, 18 Nov 2026 23:39:31 +0800
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
	stable@vger.kernel.org
Subject: Re: [PATCH v6 3/8] gpiolib: cdev: do not free line IRQs again after
 the chip is removed
Message-ID: <20261118153931.GA46152@rigel>
References: <20261116-gpiolib-chip-removal-v6-0-aambrozewicz@nvidia.com>
 <20261116-gpiolib-chip-removal-v6-3-aambrozewicz@nvidia.com>
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
In-Reply-To: <20261116-gpiolib-chip-removal-v6-3-aambrozewicz@nvidia.com>

On Mon, Nov 16, 2026 at 03:47:06PM +0200, Adrian Ambrozewicz wrote:
> Since commit ec8b6f55b981 ("gpio: free irqs that are still requested
> when the chip is being removed"), gpiochip_remove() frees the IRQs
> still installed on the chip's lines. A line request or v1 line event
> kept open across the removal frees its IRQ again on release. If the
> mapping is gone, that can touch freed memory, as reported with
> virtio-gpio; if the number was reused, free_irq() warns:
> 
>   Trying to free already-free IRQ 28
>   WARNING: kernel/irq/manage.c:1881 at free_irq+0x193/0x2d0, CPU#2: gpio-hold/111
>   Call Trace:
>    linereq_free
>    linereq_release
>    __fput
> 
> Stop edge detection from the device notifier that gpiochip_remove()
> calls, under config_mutex so that it does not race a reconfiguration.
> Free the IRQ there only if it still has an action, as gpiochip_remove()
> frees only those on lines flagged as used for IRQs. The release path
> then finds nothing left to free.
> 
> Reproduced with gpio-sim: remove the chip under an open request with
> edge detection, set it up again and request the same line, then close
> the first request. Every cycle warns; with this change, 100 cycles pass.
> 

Reviewed-by: Kent Gibson <warthog618@gmail.com>

Cheers,
Kent.
