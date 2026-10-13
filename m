Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EA8476060;
	Tue, 13 Oct 2026 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907525; cv=none; b=H11zAWbQQ/gYmlPvz3Zo54oCW6LrLXxazGfBZdCQllKrOjc0HGhVTLQwrKClFRcIwhddEC69of4oLxn0e+4GQgvzH8YahTLRxVTdCZv+AQuXETRqW14MfXyDmePSfU4lsHRMbvD3WEhzDGMsYlWafDH8MvI2kmE8lInXJBr8kzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907525; c=relaxed/simple;
	bh=tCU/t7EhRQuLlUkGUJc5NkWcHiEXca55pCicTyVe2kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLCpsAA77tI21a4jlba7eyEsht9f5AUBfSQJJR26555wGy9fgHxhz8wG4osqDBgZZQ9zSYqgVtaBP2NKnL+RVL1wWdJ3k5JR/zo8UUYg8jQqRPhjs34leTaVCqfn9Z3xiDQ0tF+VJqv7lap0iT+yaN84JSDptTLn9CER1DPitYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fPUHOL2G; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fPUHOL2G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791907524; x=1823443524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tCU/t7EhRQuLlUkGUJc5NkWcHiEXca55pCicTyVe2kQ=;
  b=fPUHOL2G5T7nX1jIXvFJwnuwDqFmcoINxOcljZmj2TmvL/MGgIYmb9XM
   PxUK2bnu0oLAGmCbYN4mMatf+8d7+E3LZYlw5vtMbzdRdZ2OwrrKCVp7e
   axDvB/QvBgsTk/BMyvYFhmAV5DfGonSXW5fgvhVsr3+TroWXMk++yzeqi
   NUe4poksgAIehztL0hYLGdbDgtiBzErryu7rDoaZ+uz8DX6UrgUIoFKlA
   1LagcRzLGMrTB9msLQ3WpJZrvleNqqO66sRegN+uF5YPdO6o6fBfSCtRL
   U5/3pG3KPwRImOFsQ4hPjPCDUKVOuUljexcEU5kmiAnKXju/fqZAolSFT
   w==;
X-CSE-ConnectionGUID: vurwWbgISd6ZRy+jPJYhxA==
X-CSE-MsgGUID: a+lxYfabQl6EvJSRJI63wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="536080"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="536080"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 09:05:19 -0700
X-CSE-ConnectionGUID: yfOxLhhuTD+RC3tADfenRw==
X-CSE-MsgGUID: XndIgdilRdaGAUijWIBxVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1119722"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 09:05:16 -0700
Date: Tue, 13 Oct 2026 19:05:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 6/6] gpiolib: let the character device free its IRQs
 first on chip removal
Message-ID: <as5WuQ2G62ThE2ds@ashevche-desk.local>
References: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com>
 <20261012-gpiolib-chip-removal-v1-6-aambrozewicz@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-gpiolib-chip-removal-v1-6-aambrozewicz@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 12, 2026 at 04:50:00PM +0300, Adrian Ambrozewicz wrote:
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

...

> +	mutex_init(&lr->config_mutex);

You might also want to add the respective mutex_destroy() calls.

...

> +	mutex_init(&le->irq_lock);

Ditto,

...

> -	struct irq_desc *irqd = irq_to_desc(irq);
> +	struct irq_desc *irqd;
>  	void *cookie;
> +	int irq;
> +
> +	/* Called with gdev->chip already NULL, so gpiod_to_irq() can't be used. */
> +	if (!gc->to_irq)
> +		return;
> +
> +	irq = gc->to_irq(gc, gpiod_hwgpio(desc));
> +	if (irq <= 0)

Are you sure about 0?

> +		return;

This can be combined with the above, right?

	if (gc->to_irq)
		irq = gc->to_irq(gc, gpiod_hwgpio(desc));
	else
		irq = -ENOENT;
	if (irq < 0)
		return;

> +	irqd = irq_to_desc(irq);
> +	if (!irqd)
> +		return;

-- 
With Best Regards,
Andy Shevchenko


