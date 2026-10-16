Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9D84D956B
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158019; cv=none; b=Flbb0WDcH5T9hEjixpDF6PV+iuPDiDybERTmFj8hPhljuUqDN76JDeDgPBgH2a8iYRAg6LwvteR5VE+oeUMALvP/Bt9kEr9XGbROEvw8Oi8zfUcsUE9J/Hwr+lFml0tZErtzx5AjFrViuD9U8QzXa4kF+8jE2ZFZ8v1YM4LnXUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158019; c=relaxed/simple;
	bh=8peD1OsoGMuXunVLES2cLCaTYTNG/Kc9MRmIC24PAL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRjo6vl9SVqHjbJUTPycPLwJLK0fgwlZmCoR11XslXPeTbZ1Fy9kd+XSbaRDVZj9OC+0mfuuzQA+P2crfgX+9A12gQI+Rg/SAy8tuQyIZrONq6hQJmFaccneVrF5oQWB2i/FgES8gBCZ/ToTpK4lOmhebkLGYPT5anRaKu1Zh14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7a6Aq+l; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7a6Aq+l"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ccca948203aso2708875a12.3
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 06:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792158018; x=1792762818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qW/8J21hrdlnc223vSj62Ky8ptl28R09HnYDC7Cieog=;
        b=b7a6Aq+laoLsPpBgktOVIRO33L+sNpMtTjKjJvLTodKOOTMi1b1198vyTK+BcPAcVG
         K5shFmzIOBaszn1gccz/kZbLLVaEgncBPMFbtOX+RxYvQM5ltK+x/Znha2n8XIedN/37
         NIsmJ7kksayfWIEw4OaOatNtBE9stoBP2Ex5Y6vd1Zw+aSAUhqs/OlEF3yoUZpZen/ET
         UYPOGzISzJNhlqdLmisv4lwRcv3k4ejGYJpkoxl6buRHkbYIeL5wyF783pYCj61O27HZ
         bsVXsHG1wEYev8bxLd6A5pGASAWOnRhZxEjs4Xdrrl6LNcCpU2IFLWSe9cq4pqWswzcW
         HR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792158018; x=1792762818;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qW/8J21hrdlnc223vSj62Ky8ptl28R09HnYDC7Cieog=;
        b=el0Nn5XPoM2M2JicfnHsn1Lp2YgP6Njt+AHzgCAwcczPCCJsDycoJO/ZLyIxjmCRrq
         P+q+XsOkETejgwGv5ENzJ5vl+TaY1x5jgujbDEoEofZcVrj2O+zSA1uNNZOgG1akQA+h
         UY5xjGLD41WD9TeHFesnZpId3HenB6ns3ZXwd0LcHaJA1BaxYHZ8ePSU0hx6cYuIiXAR
         N5XgoFOCkDXkTAkOSEa06lavoUSKbZHzAcnn9vanOX1SFSijMC0vFH5N9N/QP0pGSWLt
         LhaeutRB7bsYiUs2gtBvdCMswJJIbeoNkhPIW1OeWlNRhiNg/QLeC9Gbc3phB7WJon3A
         Kgxw==
X-Forwarded-Encrypted: i=1; AKwUvBwx0rrcbZEIU6ftlUyp596+A1j08s4eFX4+f6VCi8P8PuRwwOpMUAKizLYSKy+devx1tIdrjBM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJbtRxmULfKfZWJHerODqNPmDRG5NWeBLqQQyAAsrWUEr6Cgm4g
	oaI+WK6fRpV7G5sZ6KK7ZiBnjF1Lmb4u70bQImdegGg9papVc0A2tpWi
X-Gm-Gg: AYBFou24z4CKHQcH8kHEB9i6Z/noo2iGCeYjitz18nkWd/SBJ1pzsgEa71v/pT4s78g
	m6YBa0yXBX/s1OjbAZQx0muctQPIuhChwvqEEexZjYBwEaiBhvk30IRGFTCP0D2yuzx7MSdr8mg
	y8tNtbDJHnX7HNSNME9z8exT731NjYOrisGAlCAt7H8xqQjnWuNHrQQMAU94t7cyhz5gDQnozyT
	uDlpoHB+djQjdJCj7p1VhQ+x9isxSD7lJl7yMMoFoxC44En2ej/DrrreZE2ARWkGFBLgXb+9RIN
	eBgsqVlCGQBw9+4sAwl6UDsNh4t0weRfAgTuFtN90EBAOQ7j4wjQoNs4cP4lcoMJSmnG12bHNDd
	JbWMZ2dIxYZ72NDqjIcrYaFyFgKmoG8iYRa57WTu1wgrNA2IldxPwJU88BbMI0bCh8s7VR1TCzT
	j4DCaZYsI3iKeNaaw48g1rHOkYvxEI2qFSd+5lz/9pX1ppkud08boTQcCjzOE+YunYmCndvAVdb
	Sw2JmXNjmvvbTv5DU+1N6NXOzXs
X-Received: by 2002:a17:902:e80c:b0:2e9:4e83:1969 with SMTP id d9443c01a7336-2e94e836693mr59757755ad.34.1792158017475;
        Fri, 16 Oct 2026 06:40:17 -0700 (PDT)
Received: from rigel (194-223-74-160.tpgi.com.au. [194.223.74.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e83500bsm10514865ad.37.2026.10.16.06.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 06:40:16 -0700 (PDT)
Date: Fri, 16 Oct 2026 21:40:03 +0800
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
Subject: Re: [PATCH v2 6/6] gpiolib: let the character device free its IRQs
 first on chip removal
Message-ID: <20261016134003.GA155960@rigel>
References: <20261016-gpiolib-chip-removal-v2-0-aambrozewicz@nvidia.com>
 <20261016-gpiolib-chip-removal-v2-6-aambrozewicz@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016-gpiolib-chip-removal-v2-6-aambrozewicz@nvidia.com>

On Fri, Oct 16, 2026 at 12:23:38PM +0300, Adrian Ambrozewicz wrote:
> gpiochip_remove() force-frees every IRQ still requested on the chip's
> lines with gpiochip_free_remaining_irqs() before anything else, then
> clears the chip pointer, removes the irqchip, disposing of the IRQ
> mappings, and only at the very end, from gpiolib_cdev_unregister(),
> calls the device notifier on which line requests and v1 line events
> stop edge detection and free their own IRQs. That leaves two windows in
> which the character device frees an IRQ it no longer owns:
> 
> - The notifier runs after the mappings are gone. If an IRQ number freed
>   by gpiochip_irqchip_remove() is allocated to another device in the
>   meantime, irq_has_action() finds that device's action and free_irq()
>   warns "Trying to free already-free IRQ". IRQs requested through the
>   character device after gpiochip_free_remaining_irqs() but before the
>   chip pointer is cleared are still installed when their mappings are
>   disposed of.
> 
> - Releasing a request concurrently with gpiochip_remove() races
>   gpiod_free_irqs(), which can free the action between the release
>   path's irq_has_action() check and its free_irq(), and then
>   gpiochip_irqchip_remove(), which can dispose of the descriptor that
>   free_irq() is still using.
> 
> Call the device notifier from gpiochip_remove() right after the chip
> pointer is cleared and the SRCU grace period has elapsed, when no ioctl
> can request new IRQs any more, and only free the remaining IRQs after
> it. Have the release paths free their IRQs before unregistering from the
> notifier, under the lock that the notifier callback also takes, so that
> the notifier does not return while a release is still freeing an IRQ.
> For v1 line events that needs a new mutex; line requests use their
> config_mutex, which now has to be initialized before the first error
> path. As the chip pointer is NULL by the time gpiod_free_irqs() runs,
> have it call gc->to_irq() directly rather than gpiod_to_irq().
> 
> Every IRQ requested through the character device is thus freed exactly
> once, by the notifier or by the release path, and before
> gpiod_free_irqs() and the removal of the irqchip.
> 
> Moving the character device's part of the removal earlier was proposed
> by Herve Codina before gpiochip_free_remaining_irqs() existed; with that
> in place, only the order of the two is left to fix.
> 
> Reproduced with a test-only GPIO chip that uses the gpiolib hierarchical
> irqchip, unbound from its driver with lines requested through the
> character device. For the first window, the chip hands the IRQ number of
> line 0 to a dummy handler while gpiochip_irqchip_remove() disposes of
> the mappings, and the requests are closed after the unbind. For the
> second, it sleeps in its irq_bus_lock() callback once removal has
> started, and the request is closed while gpiochip_remove() is in
> free_irq(). Each of 30 cycles warns "Trying to free already-free IRQ" in
> both cases, for v2 line requests and v1 line events alike; with this
> change none does.
> 
> Link: https://lore.kernel.org/all/20240227113426.253232-1-herve.codina@bootlin.com/
> Fixes: ec8b6f55b981 ("gpio: free irqs that are still requested when the chip is being removed")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
> ---
> Changes in v2:
> - mutex_destroy() for config_mutex and irq_lock (Andy).
> - The missing ->to_irq() case folded into the irq <= 0 check (Andy).
> - Assisted-by tag.
> 
>  drivers/gpio/gpiolib-cdev.c | 36 ++++++++++++++++++++++++++++--------
>  drivers/gpio/gpiolib.c      | 29 ++++++++++++++++++++++++-----
>  2 files changed, 52 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index 788a36475e5d..b4b3c9ac54c2 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -1588,19 +1588,29 @@ static void linereq_free(struct linereq *lr)
>  {
>  	unsigned int i;
>  
> +	/*
> +	 * Stop edge detection while still registered for the notification, so
> +	 * that gpiochip_remove() does not get past it until the IRQs are freed.
> +	 */
> +	scoped_guard(mutex, &lr->config_mutex) {
> +		for (i = 0; i < lr->num_lines; i++) {
> +			if (lr->lines[i].desc)
> +				edge_detector_stop(&lr->lines[i]);
> +		}
> +	}
> +
>  	if (lr->device_unregistered_nb.notifier_call)
>  		blocking_notifier_chain_unregister(&lr->gdev->device_notifier,
>  						   &lr->device_unregistered_nb);
>  
>  	for (i = 0; i < lr->num_lines; i++) {
> -		if (lr->lines[i].desc) {
> -			edge_detector_stop(&lr->lines[i]);
> +		if (lr->lines[i].desc)
>  			gpiod_free(lr->lines[i].desc);
> -		}
>  	}
>  	kfifo_free(&lr->events);
>  	kfree(lr->label);
>  	gpio_device_put(lr->gdev);
> +	mutex_destroy(&lr->config_mutex);
>  	kvfree(lr);
>  }
>  
> @@ -1671,6 +1681,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
>  	if (!lr)
>  		return -ENOMEM;
>  	lr->num_lines = ulr.num_lines;
> +	mutex_init(&lr->config_mutex);
>  
>  	lr->gdev = gpio_device_get(gdev);
>  
> @@ -1688,7 +1699,6 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
>  			return -ENOMEM;
>  	}
>  
> -	mutex_init(&lr->config_mutex);
>  	init_waitqueue_head(&lr->wait);
>  	INIT_KFIFO(lr->events);
>  	lr->event_buffer_size = ulr.event_buffer_size;
> @@ -1788,6 +1798,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
>   * @eflags: the event flags this line was requested with
>   * @irq: the interrupt that trigger in response to events on this GPIO
>   * @irq_label: the name @irq was requested with
> + * @irq_lock: serializes freeing @irq on release and on chip removal
>   * @wait: wait queue that handles blocking reads of events
>   * @device_unregistered_nb: notifier block for receiving gdev unregister events
>   * @events: KFIFO for the GPIO events
> @@ -1802,6 +1813,8 @@ struct lineevent_state {
>  	u32 eflags;
>  	int irq;
>  	char *irq_label;
> +	/* release vs. chip removal notifier */
> +	struct mutex irq_lock;
>  	wait_queue_head_t wait;
>  	struct notifier_block device_unregistered_nb;
>  	DECLARE_KFIFO(events, struct gpioevent_data, 16);
> @@ -1837,8 +1850,10 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
>  	struct lineevent_state *le = container_of(nb, struct lineevent_state,
>  						  device_unregistered_nb);
>  
> -	free_line_irq(le->irq, le, &le->irq_label);
> -	le->irq = 0;
> +	scoped_guard(mutex, &le->irq_lock) {
> +		free_line_irq(le->irq, le, &le->irq_label);
> +		le->irq = 0;
> +	}
>  
>  	wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
>  
> @@ -1918,14 +1933,19 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
>  
>  static void lineevent_free(struct lineevent_state *le)
>  {
> +	/* As in linereq_free(), free the IRQ before unregistering. */

First part of the comment can rapidly become stale, and the last part
doesn't add anything the code doesn't already say.

> +	scoped_guard(mutex, &le->irq_lock) {
> +		free_line_irq(le->irq, le, &le->irq_label);
> +		le->irq = 0;
> +	}
>  	if (le->device_unregistered_nb.notifier_call)
>  		blocking_notifier_chain_unregister(&le->gdev->device_notifier,
>  						   &le->device_unregistered_nb);
> -	free_line_irq(le->irq, le, &le->irq_label);
>  	if (le->desc)
>  		gpiod_free(le->desc);
>  	kfree(le->label);
>  	gpio_device_put(le->gdev);
> +	mutex_destroy(&le->irq_lock);
>  	kfree(le);
>  }
>  
> @@ -2097,6 +2117,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
>  	le = kzalloc_obj(*le);
>  	if (!le)
>  		return -ENOMEM;
> +	mutex_init(&le->irq_lock);
>  	le->gdev = gpio_device_get(gdev);
>  
>  	if (eventreq.consumer_label[0] != '\0') {
> @@ -2832,5 +2853,4 @@ void gpiolib_cdev_unregister(struct gpio_device *gdev)
>  {
>  	destroy_workqueue(gdev->line_state_wq);
>  	cdev_device_del(&gdev->chrdev, &gdev->dev);
> -	blocking_notifier_call_chain(&gdev->device_notifier, 0, NULL);
>  }
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 31ccdd373765..7dd730228b05 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -851,11 +851,23 @@ bool gpiochip_line_is_valid(const struct gpio_chip *gc,
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
> +	if (gc->to_irq)
> +		irq = gc->to_irq(gc, gpiod_hwgpio(desc));
> +	else
> +		irq = 0;
> +	if (irq <= 0)
> +		return;

Perhaps I'm channelling Andy here, but how about:

	if (!gc->to_irq)
        return;
	irq = gc->to_irq(gc, gpiod_hwgpio(desc));
	if (irq <= 0)
		return;

> +
> +	irqd = irq_to_desc(irq);
> +	if (!irqd)
> +		return;
>  
>  	for (;;) {
>  		/*
> @@ -887,7 +899,7 @@ static void gpiochip_free_remaining_irqs(struct gpio_chip *gc)
>  	struct gpio_desc *desc;
>  
>  	for_each_gpio_desc_with_flag(gc, desc, GPIOD_FLAG_USED_AS_IRQ)
> -		gpiod_free_irqs(desc);
> +		gpiod_free_irqs(gc, desc);
>  }
>  
>  static void gpiodev_release(struct device *dev)
> @@ -1422,7 +1434,6 @@ void gpiochip_remove(struct gpio_chip *gc)
>  	/* FIXME: should the legacy sysfs handling be moved to gpio_device? */
>  	gpiochip_sysfs_unregister(gc);
>  	gpiochip_free_hogs(gc);
> -	gpiochip_free_remaining_irqs(gc);
>  
>  	scoped_guard(mutex, &gpio_devices_lock)
>  		list_del_rcu(&gdev->list);
> @@ -1431,6 +1442,14 @@ void gpiochip_remove(struct gpio_chip *gc)
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
> 

That's all I've got from a first pass of the whole series - looks great.

Cheers,
Kent.
