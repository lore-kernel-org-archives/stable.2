Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E58052120D;
	Tue, 13 Oct 2026 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906511; cv=none; b=aenV6UvNvvQyALLZsCLcw72dsufMTiowvPonNDEMIgnPGrKmyhS8bGb9c6wRhXFbDHr6440JbpQCnGpHzm2ZflAiie6gnw87MUoB2EaA3Ui9tpO0CSDrGUTUmomisFnCCncnJpjtMDNiDmvZgi8EVnDdkSltVJsVxsexhj+6N9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906511; c=relaxed/simple;
	bh=g80R4+/eZeabAUVwDGl5wHDT0KFztyhPDglDl7tKId4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHN3fzSp7T0DxH0vliExjtjtBQiJ/xQAGxmCwudtf9nt2XjzVIs10LfJfkQNn2jpYb/0jUTkp88y44d0eHF60pNyz3uX88sNiYxsASAiL8G6uuaTyZxz+ZTlIhGPFl4sekiutctT7Djxu4htYQYyltJnl+bxkdmU0FW5DZtPdm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GK2y5Vvn; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GK2y5Vvn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791906510; x=1823442510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g80R4+/eZeabAUVwDGl5wHDT0KFztyhPDglDl7tKId4=;
  b=GK2y5VvnDkwjImsmck+YIdkefJhzljRGCI4Z9Md5lwuej38pmKceGPo/
   ugEO5qD/ytbaOrvlwfinCZI2x5tTQTJDnQNIQ61tYB6VdLBP3MwngWtnJ
   fdtsPbubdBAGFX4jK44LmGqy1sNuVMZ5bAlOX6pC3+btpoYKyNgLAG1Bi
   H2fEGkl1Ss+dgFoPqPKnPdajaG3B2PnjTzzlmV/5F1n8+u40vHktZrJZv
   KSJYnnJKpkpGzN0HSbZ5tsHNGYAGU4IkVDEFaj9joCs8IYPlk8skx4lND
   x3DyhzSp5AawSkxKqJBhn2DY/e5RkXbj9gvVn0Gv3RmCxZmU2RTiUjDKh
   w==;
X-CSE-ConnectionGUID: fTEEwFmJQv690hAZtJEnpw==
X-CSE-MsgGUID: pEpSvO7qSNCIM6fLzsh/kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="644525"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="644525"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 08:48:29 -0700
X-CSE-ConnectionGUID: V3c6m8oSRguzy9dQ4arp+Q==
X-CSE-MsgGUID: UWLnhG4TRjiRC6Cfa8QoPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1517171"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 08:48:27 -0700
Date: Tue, 13 Oct 2026 18:48:24 +0300
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
Subject: Re: [PATCH 4/6] gpiolib: cdev: don't sleep in the SRCU read section
 in read()
Message-ID: <as5SyJjLd24B8jde@ashevche-desk.local>
References: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com>
 <20261012-gpiolib-chip-removal-v1-4-aambrozewicz@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-gpiolib-chip-removal-v1-4-aambrozewicz@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 12, 2026 at 04:49:58PM +0300, Adrian Ambrozewicz wrote:
> linereq_read(), lineevent_read() and lineinfo_watch_read() enter the
> gdev->srcu read section to check that the chip is still there and stay
> in it while they sleep waiting for an event. gpiochip_remove() clears
> the chip pointer and then calls synchronize_srcu() on gdev->srcu, which
> cannot return while a reader sleeps there. The wake-up meant for that
> reader is sent by the device notifier, which runs later in
> gpiochip_remove() and would not end the wait anyway, as the wait
> condition only looks at the event FIFO. Unless an event arrives, a
> process blocked in read() on a line request, a v1 line event or a chip
> file with watched lines holds up the removal of the chip until it is
> signalled:
> 
>   task:init state:D stack:0 pid:1 tgid:1 ppid:0
>   Call Trace:
>    __synchronize_srcu
>    gpiochip_remove
>    release_nodes
>    devres_release_all
>    device_unbind_cleanup
>    device_release_driver_internal
>    bus_remove_device
>    device_del
>    platform_device_unregister
>    gpio_sim_device_deactivate
>    gpio_sim_device_config_live_store
>    configfs_write_iter
>    vfs_write
> 
> and since the device lock is held meanwhile, so does device_shutdown()
> on power-off.
> 
> Check the chip pointer in a scoped SRCU section only. Nothing after the
> check dereferences the chip, the request and its FIFO belong to the
> file. Also end the wait once the chip is gone, which the notifiers'
> wake-ups now see, and return -ENODEV if there is no event to report.
> 
> This dates back to the RW semaphore that the SRCU section replaced,
> which these functions also held while sleeping and gpiochip_remove()
> took for writing.
> 
> Reproduced with gpio-sim: one thread blocked in read() on a line
> request while another sets the chip's configfs "live" attribute to 0.
> The write does not return until the reader is killed; with this change
> it returns at once and read() fails with -ENODEV.

...

> -	guard(srcu)(&lr->gdev->srcu);
> -
> -	if (!rcu_access_pointer(lr->gdev->chip))
> -		return -ENODEV;
> +	/*
> +	 * Don't stay in the SRCU read section while sleeping: that would stall
> +	 * gpiochip_remove() until an event arrives.
> +	 */
> +	scoped_guard(srcu, &lr->gdev->srcu) {
> +		if (!rcu_access_pointer(lr->gdev->chip))
> +			return -ENODEV;
> +	}

It's duplicated a few times, perhaps you can make a static helper?

static int ...()
{
	guard(srcu)(&gdev->srcu);

	if (!rcu_access_pointer(gdev->chip))
		return -ENODEV;

	return 0;
}

Caveat: not an SRCU expert, so it might be actually wrong from run-time
behaviour perspective.

-- 
With Best Regards,
Andy Shevchenko


