Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795236434;
	b=Cs4+Dsu+qgy4DUCYUSe4hTkXWaUIG77tZpCq1H7fB5sjidFRnjzPYcEmtBzR7JxeYf48
	 F4RbFJY3sIOiirber86H03et2eLGBYhH5InJQtmViCpolB0ckM2gFZA04dgISyxAKAGqk
	 PC3w7M1yxNqB018trLc2B+1zF2xUtPVIsFZ9Izsc0UbFkvE/aeP9BywI+uVrti9EpodlB
	 uijqt/tJnOyy/IQEd18Im+GcSWgqMRd6hC34iUIJFDslYsQfvY0jQiZTfFcaWtWd08Bqe
	 YpKkzGAa2Mnit24fRHxNBcc6SNa5HgMyjS2ZG6VFyMVfsjLsj6/m43jLYTSy815/b6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795236434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=TKS3/Pf4zfqMdy6L2c4CbTel3Q9nSiZwM2cv9aIwwZQ=;
	b=ZqQkpm131yRV3rQY6p6uw+9tClNhory0F+QSJoSWvMnTT1YDP9Ic723q5ttD0CMKrSCH
	 YNQGHyqfavnZpVqaRpnEtiWonHMX2g6oRUDxKfbgg2jGoDhJyWT9I+FZ5jUzMRo4yo8du
	 N10BBfTxbfbz3PqknSQ/4sYaVghfx7DSepR4Qu3ldAXToHDpPFCtjbEFR9ANl3RSCi/xH
	 RytVI8Fnu/TdJQTWMDdzI079aQAu8EQSUtkv5xlUof0TKejjQGS2t48OvekC7ZPLryUh+
	 XWRbdrcdaBaUEqR1cEKgSJd03Z3g06g/c3MM/J9Rw/arKYfEX1WqJf8jS3gagLrZ7Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q86qFYKx;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB9C606A690
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 04:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAB9C606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q86qFYKx
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b43d30822fso533716a91.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 20:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795236429; x=1795841229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TKS3/Pf4zfqMdy6L2c4CbTel3Q9nSiZwM2cv9aIwwZQ=;
        b=q86qFYKxONhQ1/NZxv2vQ6vlQ+KQUtpuKzFqAjG+3Vrr/H/1sWHMm5YelBh9Nupnjt
         nVnbmzLeiEekkl9Wn5Sao2wAESMvGwnONAEky6RxNaol/cdKUd7aoRpXkPQ9v6r+2uDC
         y+Q37nTsMWjQNvtW3zDi/yNGwJ4/FNi92y/btYc7Yt7K/xYAGiYonefnzYv2k/iV2pE6
         cE7NwC7MJpv8MMqxtmI4K/sNgWMKg2H7KDztYQtHhzS2tKss3sWeljvoGfdcaBStue0o
         vpI8Ls6AW1+sx2WohEBZPFAadFhv23f9n3ztZ1lFqiCPDJBUkQcPYq6xLeU5kBTiEKUj
         Qn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795236429; x=1795841229;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TKS3/Pf4zfqMdy6L2c4CbTel3Q9nSiZwM2cv9aIwwZQ=;
        b=wtAJBk57+Gyx1A+JXP4N4JQLyNudtwZyIwVv0yjHL3w9Ft/+JhQVNGLGvkR5VrhPGX
         7FDR7FtihwzckiOGZ8Xyw5++yi+TJMhq5ICEVxWsQm/t4ojvJJsw669nJgFZIY/wCvHe
         HaH3zpGsI920vLK1lmgZmTaRWZKm6T2mvdJAx3cBk4BUwRnSNlxIbweMpNPnsvKoJ+JT
         0jD5j5o0Z2mQT7v1Cjab2uaImQerz7PPOyODYxnlCpt6RZbxLkw7J8vlZKdy4GqX6KaV
         dun9HbR4sUsOzGc4wzWV3lCPkTgs+63sIfOJSwvX9KV3ulQHBWeZ5ZdkKOFVlsBCR+jh
         7czw==
X-Forwarded-Encrypted: i=1; AL+hErFlFanN7nC6ljKUtMYwgxRrO9HEgut+M3arqhwXmgZ/r641iPtaiMZKkgpIaZHblEe1rPTbOeo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/F0bs0H+4Khe9/RgMrm+jCHCClaVMYu7p1jac0J3oYxU71FG4A
	SFet47TFia+jsS/eMKgEr3NxebGRXXQGMEf7X8ITkxsPBf8nK1MzpmK/
X-Gm-Gg: AZFdTZfbXmmeLOWvJdbpZXYfg4tqwwCHJChRx3Lm/hn1Eyei/p2eOewA/Q3vcsry397
	a9tGpegt+zSOwDryQPd5Zc+3XmMLy9lU2b4SPntLZMuKhLp9FVqjlAaTbYe9+5VIwDE3oexFrtK
	Owbswxsy7a/3et8tXcniMmtiqKOOfUbqQ0ddQUUgjoKiUukGNw/KOOiab4M2HBVDyA+yJJll5uU
	8U0UKuhDsz7NlWETbrN8Jdyk0gvBW9kkIdKkxcOQ2DMau/e3VMqMmzSpU2F2bfbRGHUdRqR8Yif
	G2Cjx2pRlMij1LtwZ22MHvRVZo7NwqcwHNOkBbKCpYPWTzRxy73pBnZxkZTCF/3SozlmbUdCvwT
	UljnS0AUnmh+tTCyAcjs/5GZhLJwCtLbCwT2NTd4u1CRgH0QYQC2PoewlYCs2sSb4cjiBxxVtBA
	EHYmirR6wnVChLrw1vw+VeUdNCKyYcbVmfSi0lHkHw0w3HHr7XAHlBQylQixUIVErCjWCpZyAIw
	MpSaqu5Z/FeciVP/6cRWmyi6TGlvKfttBW+Nd1OBGdY7Bmgfa4HPn9y7MLeml878xOMBGpGnuz7
	sNP2d99UrI44TNkqyXYVd53DDmyeXFb/gIUSgOS+QUw2xRc87Q==
X-Received: by 2002:a17:90b:3fc5:b0:3b4:166a:27cf with SMTP id 98e67ed59e1d1-3b41c902ba8mr5025493a91.21.1795236429159;
        Fri, 20 Nov 2026 20:47:09 -0800 (PST)
Received: from rigel (106-68-220-184.tpgi.com.au. [106.68.220.184])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad46ef5sm6815488a91.8.2026.11.20.20.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 20:47:08 -0800 (PST)
Date: Sat, 21 Nov 2026 12:46:57 +0800
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
Subject: Re: [PATCH v7 7/8] gpiolib: let the character device free its IRQs
 first on chip removal
Message-ID: <20261121044657.GA17013@rigel>
References: <20261120-gpiolib-chip-removal-v7-0-aambrozewicz@nvidia.com>
 <20261120-gpiolib-chip-removal-v7-7-aambrozewicz@nvidia.com>
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
In-Reply-To: <20261120-gpiolib-chip-removal-v7-7-aambrozewicz@nvidia.com>

On Fri, Nov 20, 2026 at 10:13:59AM +0200, Adrian Ambrozewicz wrote:
> gpiochip_remove() force-frees the remaining IRQs, removes the irqchip,
> and only then calls the device notifier on which the character device
> frees its own IRQs. The character device can then free an IRQ it no
> longer owns: after its mapping was disposed of and the number reused, or
> from a release that races gpiod_free_irqs() and
> gpiochip_irqchip_remove(). free_irq() then warns "Trying to free
> already-free IRQ" or uses a disposed descriptor.
> 
> Call the notifier once the chip pointer is cleared and the SRCU grace
> period has elapsed, when no ioctl can request IRQs any more, and free
> the remaining IRQs after it. Have the release paths free their IRQs
> before unregistering from the notifier, under the lock its callback
> takes (config_mutex, or a new mutex for v1 line events). Herve Codina
> first proposed calling the notifier earlier [1].
> 
> IRQs that in-kernel users leave requested are now freed after the chip
> pointer is cleared, when gpiod_*() calls on the chip fail.
> 
> Reproduced with a test-only chip on the hierarchical irqchip: both races
> warn in all 30 cycles; with this change, none does.
> 
> Link: https://lore.kernel.org/all/20240227113426.253232-1-herve.codina@bootlin.com/ [1]
> Fixes: ec8b6f55b981 ("gpio: free irqs that are still requested when the chip is being removed")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 37 ++++++++++++++++++++++++++-----------
>  drivers/gpio/gpiolib.c      | 28 +++++++++++++++++++++++-----
>  2 files changed, 49 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index d829f7d00b5e..ceecce572a52 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -1590,19 +1590,25 @@ static void linereq_free(struct linereq *lr)
>  {
>  	unsigned int i;
>  
> +	/*
> +	 * Stop edge detection while still registered for the notification, so
> +	 * that gpiochip_remove() does not get past it until the IRQs are freed.
> +	 */
> +	scoped_guard(mutex, &lr->config_mutex) {
> +		for (i = 0; i < lr->num_lines; i++)
> +			edge_detector_stop(&lr->lines[i]);
> +	}
> +
>  	if (lr->device_unregistered_nb.notifier_call)
>  		blocking_notifier_chain_unregister(&lr->gdev->device_notifier,
>  						   &lr->device_unregistered_nb);
>  
> -	for (i = 0; i < lr->num_lines; i++) {
> -		if (lr->lines[i].desc) {
> -			edge_detector_stop(&lr->lines[i]);
> -			gpiod_free(lr->lines[i].desc);
> -		}
> -	}
> +	for (i = 0; i < lr->num_lines; i++)
> +		gpiod_free(lr->lines[i].desc);
>  	kfifo_free(&lr->events);
>  	kfree(lr->label);
>  	gpio_device_put(lr->gdev);
> +	mutex_destroy(&lr->config_mutex);
>  	kvfree(lr);
>  }
>  
> @@ -1673,6 +1679,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
>  	if (!lr)
>  		return -ENOMEM;
>  	lr->num_lines = ulr.num_lines;
> +	mutex_init(&lr->config_mutex);
>  
>  	lr->gdev = gpio_device_get(gdev);
>  
> @@ -1690,7 +1697,6 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
>  			return -ENOMEM;
>  	}
>  
> -	mutex_init(&lr->config_mutex);

What is the rationale for relocating the mutex_init()?
Looks like a gratuitous change, and if this patch is going to be
backported then it should be kept minimal.

>  	init_waitqueue_head(&lr->wait);
>  	INIT_KFIFO(lr->events);
>  	lr->event_buffer_size = ulr.event_buffer_size;
> @@ -1790,6 +1796,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
>   * @eflags: the event flags this line was requested with
>   * @irq: the interrupt that trigger in response to events on this GPIO
>   * @irq_label: the name @irq was requested with
> + * @irq_lock: serializes freeing @irq on release and on chip removal
>   * @wait: wait queue that handles blocking reads of events
>   * @device_unregistered_nb: notifier block for receiving gdev unregister events
>   * @events: KFIFO for the GPIO events
> @@ -1804,6 +1811,8 @@ struct lineevent_state {
>  	u32 eflags;
>  	int irq;
>  	char *irq_label;
> +	/* release vs. chip removal notifier */
> +	struct mutex irq_lock;
>  	wait_queue_head_t wait;
>  	struct notifier_block device_unregistered_nb;
>  	DECLARE_KFIFO(events, struct gpioevent_data, 16);
> @@ -1839,8 +1848,10 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
>  	struct lineevent_state *le = container_of(nb, struct lineevent_state,
>  						  device_unregistered_nb);
>  
> -	free_line_irq(le->irq, le, &le->irq_label);
> -	le->irq = 0;
> +	scoped_guard(mutex, &le->irq_lock) {
> +		free_line_irq(le->irq, le, &le->irq_label);
> +		le->irq = 0;
> +	}

The lines removed/guarded were added in patch 3, so note that this patch is
dependent on patch 3 in the description[1].

>  
>  	wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
>  
> @@ -1920,14 +1931,18 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
>  
>  static void lineevent_free(struct lineevent_state *le)
>  {
> +	scoped_guard(mutex, &le->irq_lock) {
> +		free_line_irq(le->irq, le, &le->irq_label);
> +		le->irq = 0;
> +	}
>  	if (le->device_unregistered_nb.notifier_call)
>  		blocking_notifier_chain_unregister(&le->gdev->device_notifier,
>  						   &le->device_unregistered_nb);
> -	free_line_irq(le->irq, le, &le->irq_label);

The line removed/guarded was added in patch 5, so note that this patch is
dependent on patch 5 in the description[1].

>  	if (le->desc)
>  		gpiod_free(le->desc);
>  	kfree(le->label);
>  	gpio_device_put(le->gdev);
> +	mutex_destroy(&le->irq_lock);
>  	kfree(le);
>  }
>  
> @@ -2101,6 +2116,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
>  	le = kzalloc_obj(*le);
>  	if (!le)
>  		return -ENOMEM;
> +	mutex_init(&le->irq_lock);
>  	le->gdev = gpio_device_get(gdev);
>  
>  	if (eventreq.consumer_label[0] != '\0') {
> @@ -2836,5 +2852,4 @@ int gpiolib_cdev_register(struct gpio_chip *gc, dev_t devt)
>  void gpiolib_cdev_unregister(struct gpio_device *gdev)
>  {
>  	cdev_device_del(&gdev->chrdev, &gdev->dev);
> -	blocking_notifier_call_chain(&gdev->device_notifier, 0, NULL);
>  }
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 9832f755312f..e0ba17a73c4b 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -854,11 +854,22 @@ bool gpiochip_line_is_valid(const struct gpio_chip *gc,
>  }
>  EXPORT_SYMBOL_GPL(gpiochip_line_is_valid);
>  
> -static void gpiod_free_irqs(struct gpio_desc *desc)
> +static void gpiod_free_irqs(struct gpio_chip *gc, struct gpio_desc *desc)
>  {
> -	int irq = gpiod_to_irq(desc);
> -	struct irq_desc *irqd = irq_to_desc(irq);
> +	struct irq_desc *irqd;
>  	void *cookie;
> +	int irq;
> +
> +	/* Called with gdev->chip already NULL, so gpiod_to_irq() can't be used. */
> +	if (!gc->to_irq)
> +		return;
> +	irq = gc->to_irq(gc, gpiod_hwgpio(desc));
> +	if (irq <= 0)
> +		return;
> +
> +	irqd = irq_to_desc(irq);
> +	if (!irqd)
> +		return;
>  
>  	for (;;) {
>  		/*
> @@ -890,7 +901,7 @@ static void gpiochip_free_remaining_irqs(struct gpio_chip *gc)
>  	struct gpio_desc *desc;
>  
>  	for_each_gpio_desc_with_flag(gc, desc, GPIOD_FLAG_USED_AS_IRQ)
> -		gpiod_free_irqs(desc);
> +		gpiod_free_irqs(gc, desc);
>  }
>  
>  static void gpiodev_release(struct device *dev)
> @@ -1439,7 +1450,6 @@ void gpiochip_remove(struct gpio_chip *gc)
>  	/* FIXME: should the legacy sysfs handling be moved to gpio_device? */
>  	gpiochip_sysfs_unregister(gc);
>  	gpiochip_free_hogs(gc);
> -	gpiochip_free_remaining_irqs(gc);
>  
>  	scoped_guard(mutex, &gpio_devices_lock)
>  		list_del_rcu(&gdev->list);
> @@ -1448,6 +1458,14 @@ void gpiochip_remove(struct gpio_chip *gc)
>  	/* Numb the device, cancelling all outstanding operations */
>  	rcu_assign_pointer(gdev->chip, NULL);
>  	synchronize_srcu(&gdev->srcu);
> +
> +	/*
> +	 * No new interrupts can be requested through the character device now.
> +	 * Have it free the ones it holds before forcibly freeing the rest, and
> +	 * both before the irqchip and its mappings go away.
> +	 */
> +	blocking_notifier_call_chain(&gdev->device_notifier, 0, NULL);
> +	gpiochip_free_remaining_irqs(gc);
>  	gpio_device_teardown_shared(gdev);
>  	gpiochip_irqchip_remove(gc);
>  	acpi_gpiochip_remove(gc);
> -- 
> 2.43.0

Cheers,
Kent.

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#separate-your-changes

