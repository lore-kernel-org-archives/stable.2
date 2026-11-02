Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793653608;
	b=3Ip8jJguXv/Xe0+OHGOIfk6vWKUIYNImumIaUfya6n5/JvF5Ukf5jJfU7Syf9420vaBW
	 Rtuw5kirrBqLe10n4zwajbsnvqQKm88Ejo0ImeM2Y1FioYK2YS1GBsFx21iSVj20JnKGK
	 OVbaOWuQQd4sAycCutf2tN8g+o5ZpR3uZpHAK6xBC9p13XJfwxZP0PzXWVDhgwlueawaK
	 DfbqknmWeBaCd+hg8vx9tINyo1yzpgvKji1wcNQWrQQD5l+9NjtBNwt7+MQxUtgXzv9e0
	 uxKd/6E62nwYhRJk3JGeuxFH0H+M8e6pImTum28F+FPZbEPTaXRC0jCYH3UHG0K7Odw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793653608;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=dUjQaUJN+hKn7gRiFVtfqB1QPp5lNz7tAcdpNDm6UXY=;
	b=diAzbT14KZpjt3SSvLuyAMHwo+Bx20qxc2gi9HLGWSis4kpqLFgu1jx3hnNMSqaoJ1AB
	 1qniGAVMWrr2vXqIUlTAhSffL6cg6616KTtLbClQUGjvrfRNnRlTHQYkKn+Of7Eeubvw0
	 SkCo7fCv7mXraYrPathOYzFn4ztBMgvIeWyCuZ41ZnE6s4A3xltp92GiwFR7CU3gQAz5U
	 cTGUlO6U1fD96OMTO/8l49wl53skgNCl3uAId2exJyVVoCXvLDOYpL+WLJv7UHu0GfBD6
	 ZPyF6n4enV8+oe7PSD5PJvTNWw1zL1P22YcuuWH3A1P/ZP9Z5Dc+tTsX3BAztzPq71g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pgzLKZkG;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85000606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 21:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85000606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pgzLKZkG
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5365d725440so35360641cf.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 13:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793653606; x=1794258406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dUjQaUJN+hKn7gRiFVtfqB1QPp5lNz7tAcdpNDm6UXY=;
        b=pgzLKZkGkS8Fra0gwul7iNVuPcLf2broF+6uXTiaF8Dd9QtL+H6V/Zy/Mj9YCPcMJT
         b+YfWyorbpO5zUaygX//RioVlaSUnmaLYKnKHPJIQwJZWu/VLjJRvM5KBgRN9OuVhN1b
         7nPI9uQeG8oEEIS0obXoKGt1ltbmZY6n2USVReV19l6IRPEES8QWvMhoFtKySgVSjr44
         5t8d8keVhl+P3pvs3sfaPv5swmOsnlNxjuyuVqfBhGlH64ueqe9AO4u8MA2yO5YVj9vy
         wQAyvAVJ/s4UvrU4Wk05qlIwNfYBg9nVtF9RyeHcs8N0k1oyRaxRNXaDsTzyew0+npOt
         sYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793653606; x=1794258406;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dUjQaUJN+hKn7gRiFVtfqB1QPp5lNz7tAcdpNDm6UXY=;
        b=OMF3+iV7Ca/qDor0VW4ITVXAhT5BeVf8XYpDGbqQxs5vyOCfY0NK04pZRqNKpAylnM
         2YAIvFLHWpfniJkJS15vrnxmDRjNwGf9k5u2xaSRDLoEbls3YQzbwU6kjQC+b4PKMEG1
         s+tlogXIuz1DJ70Pnfu5iBztoE2t8bCSsU45LcFRVwLd/u8hFZrRjIVZN4USkO5WWOUG
         DYGYyRWlUhvLTZ4hjd6ZYnAxKuFpAWZk51dLp8TW92k2izieERVuGfxTNlcZR46OQc1n
         pUlhbHdAbB0PnCmJlkcBOx0f0GWFluvFI7WQYesj/pIdo8UYrRzjqos9huu6t/PuwrO9
         Q9Qg==
X-Gm-Message-State: APuU4Z+IIr/YUKo2RCV2V1ITtSDJyZfQQ0ZFKTgKgA4a4w+XD0O3R1+k
	uMsj+IbSiCmuXsy4nWi380b0Ye5zR0wvEfuDxi0s3XBmmnmJTwWvDNjNr+YD02xf5WM=
X-Gm-Gg: AYBFou3XbPU4wCsIaUwDpqY4OxYSwh6zzd0Iyd6HpKNlMJ73pu2mWf9S+UDHJ1dqJYp
	dI3tC7ZZsMAXuDjvNQpiL1YRGn6O0DG0/SrMYoh0L68AbSSCyfRd8NcQaONPFKkYXP8RftTevBm
	uHf1plAeP90/15EKSgRQfSgow1649FZINlri7RZWa+JK3XxiKb6N0vG7qHxKVmeNShu2FnvleZk
	HmhtxbsBoodoEvVICHNbYsaO/dmK1pePtfW0jc3L+NVcmWbA6yiM0GP7uINpHyqHRz2mRhZTgRf
	0bdd1zhKSQ39ji/KdZygX4buIEQ4rf1yIn1byU2AAIYDzWB6bhXaAkwVnYeqm2JFc4h556HLfDz
	tX7MgRGwvIsuinf3jS5cQd2nyWYGK73QTbHkamvg4VYsEQwZ375Whj93OGC3WKTWiSvQ+icqP6R
	YRbPq3YS8Zse3sDQJSnBdQCPNZkjxBJtRf8MsurZu6Slyo0vbs6rMuhkWSU///qBh4u7RHMUMHr
	XXZAg4uBMZdZ1dAm02kZQTGbvaUcmE4j5pJATDgc0ra9dUFspSOgbIcQ30A1xGiLN5Zt+Wfv87y
	JWSDXykSm9sJu+aACzZ/iyjY49/wZMDyrnN8d6tL3AdRxTGbGy2dRPnHBKijGlj90kdb0vaUZRP
	ky9pHBF6svA==
X-Received: by 2002:ac8:5d46:0:b0:536:2936:6ca3 with SMTP id d75a77b69052e-542b6a72b22mr192751401cf.14.1793653606308;
        Mon, 02 Nov 2026 13:06:46 -0800 (PST)
Received: from localhost ([204.244.107.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca8071408sm99734356d6.40.2026.11.02.13.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:06:45 -0800 (PST)
Date: Mon, 2 Nov 2026 16:06:45 -0500
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Liang Hao <haohlliang@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 159/595] gpio: dwapb: Mask interrupts at hardware
 initialization
Message-ID: <auj7ZUcOlNC-rEnk@maple.netwinder.org>
References: <20260930152347.700140858@linuxfoundation.org>
 <20260930152351.156698628@linuxfoundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260930152351.156698628@linuxfoundation.org>

Hello Greg,

This caused a small regression on 5.10, details below.

On Wed, Sep 30, 2026 at 05:20:52PM +0200, Greg Kroah-Hartman wrote:
>5.10-stable review patch.  If anyone has any objections, please let me know.
>
>------------------
>
>From: Liang Hao <haohlliang@gmail.com>
>
>[ Upstream commit aaf7766ba3b99a3834319e7cf939838afc705574 ]
>
>GPIO interrupts may retain stale state across warm reboots when
>peripherals remain powered. If a GPIO line is not explicitly
>configured for interrupts, this can result in interrupt storms
>due to missing handlers.
>
>Fix this by ensuring all interrupts are masked and disabled at
>hardware initialization time via the init_hw() callback. Pending
>interrupts are also cleared to start from a known-safe state.
>
>Interrupts will be unmasked only when explicitly configured by
>userspace or kernel drivers.
>
>Signed-off-by: Liang Hao <haohlliang@gmail.com>
>Link: https://patch.msgid.link/20260705074759.47863-1-haohlliang@gmail.com
>Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>Signed-off-by: Sasha Levin <sashal@kernel.org>
>---
> drivers/gpio/gpio-dwapb.c | 17 +++++++++++++++++
> 1 file changed, 17 insertions(+)
>
>diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
>index ea2e2618b7945..d6240ae0f87ca 100644
>--- a/drivers/gpio/gpio-dwapb.c
>+++ b/drivers/gpio/gpio-dwapb.c
>@@ -189,6 +189,22 @@ static void dwapb_toggle_trigger(struct dwapb_gpio *gpio, unsigned int offs)
> 	dwapb_write(gpio, GPIO_INT_POLARITY, pol);
> }
>
>+static int dwapb_irq_init_hw(struct gpio_chip *gc)
>+{
>+	struct dwapb_gpio *gpio = to_dwapb_gpio(gc);
>+
>+	/*
>+	 * GPIO interrupts may retain stale state across warm reboots when
>+	 * peripherals stay powered. Force a known-safe state before the GPIO
>+	 * irqchip and irq domain are set up.
>+	 */
>+	dwapb_write(gpio, GPIO_INTEN, 0);
>+	dwapb_write(gpio, GPIO_INTMASK, 0xffffffff);
>+	dwapb_write(gpio, GPIO_PORTA_EOI, 0xffffffff);
>+
>+	return 0;
>+}
>+
> static u32 dwapb_do_irq(struct dwapb_gpio *gpio)
> {
> 	struct gpio_chip *gc = &gpio->ports[0].gc;
>@@ -428,6 +444,7 @@ static void dwapb_configure_irqs(struct dwapb_gpio *gpio,
> 	girq = &gc->irq;
> 	girq->handler = handle_bad_irq;
> 	girq->default_type = IRQ_TYPE_NONE;
>+	girq->init_hw = dwapb_irq_init_hw;
>
> 	port->pirq = pirq;
> 	pirq->irqchip.name = DWAPB_DRIVER_NAME;
>-- 

This causes a small regression in 5.10: the gpio-dwapb controller no 
longer produces interrupts, because nothing undoes the GPIO_INTMASK 
added in this commit.

Only 5.10 is affected, because the following commit was not backported:
1cc3542c76ac ("gpio: dwapb: mask/unmask IRQ when disable/enale it")

The earlier commit does not apply cleanly, due to changes in the 
context, but it is straightforward to apply by hand. For reference I 
tested with the following and it restored the interrupts.

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 265b7e14f346..eb4f2872cc60 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -283,13 +283,15 @@ static void dwapb_irq_enable(struct irq_data *d)
  {
  	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
  	struct dwapb_gpio *gpio = to_dwapb_gpio(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
  	unsigned long flags;
  	u32 val;
  
  	spin_lock_irqsave(&gc->bgpio_lock, flags);
-	val = dwapb_read(gpio, GPIO_INTEN);
-	val |= BIT(irqd_to_hwirq(d));
+	val = dwapb_read(gpio, GPIO_INTEN) | BIT(hwirq);
  	dwapb_write(gpio, GPIO_INTEN, val);
+	val = dwapb_read(gpio, GPIO_INTMASK) & ~BIT(hwirq);
+	dwapb_write(gpio, GPIO_INTMASK, val);
  	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
  }
  
@@ -297,12 +299,14 @@ static void dwapb_irq_disable(struct irq_data *d)
  {
  	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
  	struct dwapb_gpio *gpio = to_dwapb_gpio(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
  	unsigned long flags;
  	u32 val;
  
  	spin_lock_irqsave(&gc->bgpio_lock, flags);
-	val = dwapb_read(gpio, GPIO_INTEN);
-	val &= ~BIT(irqd_to_hwirq(d));
+	val = dwapb_read(gpio, GPIO_INTMASK) | BIT(hwirq);
+	dwapb_write(gpio, GPIO_INTMASK, val);
+	val = dwapb_read(gpio, GPIO_INTEN) & ~BIT(hwirq);
  	dwapb_write(gpio, GPIO_INTEN, val);
  	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
  }
-- 
2.55.0

Regards,
Ralph
