Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D947C52844E;
	Tue, 13 Oct 2026 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906280; cv=none; b=ZdVP05T+jLxLGdMrv7W8OS+Rvf8REBY25z8cF+7vZqPMRrirvyCoLXiYmCA6fNNcFlvZz3UUZE/EJi5AjNn2zwv34Db6ETLLQf2PN68F8TJizlC8UsP+sZi9DkMVoKDoq79OVGE/wYLnsrKRtSHsYHH3sel35nKjzIbdUtPmqis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906280; c=relaxed/simple;
	bh=bpYiHUkiDLSsNZGmb/pnOyEnoZtbpqX2C3B3Y7PD/5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEuJbkfs5tsEqLSjcF3UjWuyZxwvgvNJfbJmhoUhPaadd47plvJfhXY2P7oK1oY6+EskotgkFX1Nj33bu8cV+HVyD3DlN1cBYSTWEgpnYJvo0RY/P/4MahboJwEJ4V3cN6D9R0k99Ikc0HDhWrw6Z9MHiFzylmi2WAxGc5Zu9IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lsDydDwk; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lsDydDwk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791906279; x=1823442279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bpYiHUkiDLSsNZGmb/pnOyEnoZtbpqX2C3B3Y7PD/5w=;
  b=lsDydDwkw1f2MOo24OKuiGLfhGia/430X3/F45y+DbUm6x3h2FIrmffq
   U6ZzLDaLtel0RI4vcU1k/XBHi5jWAKDbRp908Ax9dJpdoQx6J91wSCZoV
   y1IfPhOaNslRPLo26mQLisMz+oF+cbOEqCT3xL4EETCLqwEqzxIKWaGMl
   JUDixzWAqGg/qczIqGOKh/XllsDZB8iUoAU9jxuNR5CbjB/90NVaGCMP7
   tn5yuFyP4beWlvIswTmxB7PdIJ9SPSBkcHG9o0Tb3Ss00Usp0r2g1PG0+
   wdam+sTYxLbUtoECyhKovxPI9CwJmmnoaBBj7TXA/X6mzzQMmKD7vZquO
   w==;
X-CSE-ConnectionGUID: Y5LkYIVESEemeIDiW+p/4Q==
X-CSE-MsgGUID: oK0b/QmbRCqmI4P1p0fdWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="536893"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="536893"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 08:44:38 -0700
X-CSE-ConnectionGUID: mPNPvy5VTbWCXF9BKy9NEg==
X-CSE-MsgGUID: FWoakw2QR7y+UgC0upoBZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1632690"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 08:44:36 -0700
Date: Tue, 13 Oct 2026 18:44:33 +0300
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
Subject: Re: [PATCH 3/6] gpiolib: cdev: do not free line IRQs again after the
 chip is removed
Message-ID: <as5R4WDqXfMXkD2L@ashevche-desk.local>
References: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com>
 <20261012-gpiolib-chip-removal-v1-3-aambrozewicz@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-gpiolib-chip-removal-v1-3-aambrozewicz@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 12, 2026 at 04:49:57PM +0300, Adrian Ambrozewicz wrote:
> Since commit ec8b6f55b981 ("gpio: free irqs that are still requested
> when the chip is being removed"), gpiochip_remove() calls free_irq() for
> every action still installed on the lines of the chip. The character
> device does not know about this: a line request or v1 line event that
> user space keeps open across the removal still holds the IRQ number and
> calls free_irq() on it again when it is released.
> 
> What that second free_irq() does depends on what happened to the IRQ
> number in the meantime. If the chip disposed of its mapping, the
> descriptor is gone and the call returns early, or, when it races with
> the RCU-deferred free of the descriptor, it touches freed memory, as
> reported with virtio-gpio. If the number was handed out again, for
> instance because the same chip was set up again, the call finds a live
> descriptor without our action and warns:
> 
>   Trying to free already-free IRQ 28
>   WARNING: kernel/irq/manage.c:1881 at free_irq+0x193/0x2d0, CPU#2: gpio-hold/111
>   Call Trace:
>    <TASK>
>    linereq_free+0xd2/0x120
>    linereq_release+0xd/0x20
>    __fput+0xed/0x2a0
>    __x64_sys_close+0x38/0x80
>    do_syscall_64+0x109/0x5d0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>
> 
> Stop edge detection from the device notifier that gpiochip_remove()
> already calls into, rather than when the request is released, and only
> free the IRQ there if it still has an action: chips that never mark
> their lines as used for IRQs, which gpiochip_lock_as_irq() leaves to
> the driver, keep theirs past gpiod_free_irqs(). The release path then
> finds no IRQ left to free. The notifier takes the request's
> config_mutex, which is otherwise only taken by the ioctls, so that it
> does not race with a concurrent reconfiguration of the lines.
> 
> Reproduced with gpio-sim: request a line with edge detection, set the
> chip's configfs "live" attribute to 0 while the request is open, set it
> up again and request the same line, then close the first request. Each
> of 30 cycles warns as above, for v2 requests with and without software
> debouncing and for v1 line events; with this change, 100 cycles of each
> pass without a warning.

...

> +/*
> + * gpiochip_remove() frees the interrupts still requested on the lines of the
> + * chip being removed, so once the chip is going away the IRQ may no longer be
> + * ours to free.
> + */
> +static void free_line_irq(unsigned int irq, void *dev_id)
> +{
> +	if (irq_has_action(irq))
> +		free_irq_label(free_irq(irq, dev_id));

In all cases it also checks for irq to be valid, so embed it here and drop
those checks below.

	if (irq && irq_has_action(irq))

> +}

...

>  static void edge_detector_stop(struct line *line)
>  {
>  	if (line->irq) {
> -		free_irq_label(free_irq(line->irq, line));
> +		free_line_irq(line->irq, line);
>  		line->irq = 0;
>  	}

This, for instance, will become

	free_line_irq(line->irq, line);
	line->irq = 0;


...

> +static int linereq_unregistered_notify(struct notifier_block *nb,
> +				       unsigned long action, void *data)
> +{
> +	struct linereq *lr = container_of(nb, struct linereq,
> +					  device_unregistered_nb);

Slightly better to have it

	struct linereq *lr = container_of(nb, struct linereq, device_unregistered_nb);

or

	struct linereq *lr =
		container_of(nb, struct linereq, device_unregistered_nb);

> +	unsigned int i;

Not used outside of the loop.

> +	/*
> +	 * Stop edge detection now rather than when the request is released:
> +	 * by then the IRQ numbers of the removed chip may be in use again.
> +	 */
> +	scoped_guard(mutex, &lr->config_mutex) {
> +		for (i = 0; i < lr->num_lines; i++)

		for (unsigned int i = 0; i < lr->num_lines; i++)

> +			edge_detector_stop(&lr->lines[i]);
> +	}
> +
> +	wake_up_poll(&lr->wait, EPOLLIN | EPOLLERR);
> +
> +	return NOTIFY_OK;
> +}

-- 
With Best Regards,
Andy Shevchenko


