Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB3A3F660F;
	Wed, 30 Sep 2026 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762293; cv=none; b=RuN+gYMlAfPZtZiJxRiDxmvSD9NIS2d0m0nqZtHqgIkWk2bMtnNP1xLzH2Yj2QYXPnpo47DwpGXDKeu3VpNImPIXtlPAmFgJy5B3PGhu5qK22OUyjPYQYNU1B87vN06tTuUZq4tczduSOCiJBOBKZEZsSrUf5qEOyfeYRxeDqiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762293; c=relaxed/simple;
	bh=oKsJDc73Zi+fxkCwnw1HfmEgyMWQ78AWNfJm26oHnWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H47bzVTr9LQbEMQ+8AWceR53lAtKOxafyUuWvQI40djnJ7VEHJPvURdtVipVePGkwXeGGSJQYO2s9vwuVLtr5eJ814X8ZMYqr45MYK+FvBb/J/f8J4AKunX5VbDc06FK1uhAFrmiYAZQiliL5kNxxL0jxjpatKu/XJrKhnfz+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VSMbZaq7; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VSMbZaq7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790762292; x=1822298292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oKsJDc73Zi+fxkCwnw1HfmEgyMWQ78AWNfJm26oHnWM=;
  b=VSMbZaq7Wu2oaLMt452FxFx60ef7dCjUl6AWNxmlArwVEiuUER2ks++y
   p3L+1Z8F4D7rpUX21C3DQCYOGpjcvW/PN3VqSi7LBvY0qxo5Se5s3uG8s
   NwkqunpEqZREgCEzbqedssMcE5tSMZlWJ5uqOqfTwqoIV9LYrKHCCsk/e
   GnXH+TlBV39nWSKjv0M4elL56KOa9Jb1JqEALDVABUnQQKnZ4wIYUBkI1
   qaBzIoCbUodjX/ZwD/4sCwadk9rnzkWEZTeuKtP0yOhdcxTz8jxO4pxQg
   Z2vCBcolMegAmdfBmHtOSwXppZF1COmRsYe7HVrKXuBdBQ+n6dbMZihFu
   g==;
X-CSE-ConnectionGUID: NBgdiB8WRZqh3VjxjBciDw==
X-CSE-MsgGUID: pcEebxc3RUezInPru/VBOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102067195"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="102067195"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:58:11 -0700
X-CSE-ConnectionGUID: 4cnboKPaRhmQPjO+qr3xAA==
X-CSE-MsgGUID: G7eqwfBURripQFb5y7//zQ==
X-ExtLoop1: 1
Received: from spandruv-desk1.amr.corp.intel.com (HELO localhost) ([10.245.245.137])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:58:08 -0700
Date: Wed, 30 Sep 2026 12:58:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Karol Wrona <k.wrona@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] iio: ssp: Serialize watchdog timer state changes
Message-ID: <arzdLtzXQ4cvObrL@ashevche-desk.local>
References: <20260930070319.2933744-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930070319.2933744-1-runyu.xiao@seu.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 30, 2026 at 03:03:19PM +0800, Runyu Xiao wrote:
> The SSP watchdog timer rearms itself from its callback, but the driver uses
> timer_delete_sync() when the last sensor is disabled and during suspend.
> Those operations do not prevent a concurrent enable or callback from
> rearming the timer after the deletion has completed.  The final remove path
> also used timer_delete_sync(), which does not provide the shutdown
> guarantee needed before releasing the device state.
> 
> Protect the watchdog state and enable reference count with a mutex.  The
> callback checks a state flag before rearming. Reusable stops clear the flag
> before deleting the timer. Use timer_shutdown_sync() for the final remove
> path so that any later rearm attempt is rejected permanently.
> 
> Cancel watchdog work after releasing wdt_lock because the reset work can
> wait for the threaded IRQ handler, which may synchronously wait for refresh
> work that re-enables sensors and takes wdt_lock. Remove the MFD children
> before destroying the locks because IIO child teardown can disable an
> active sensor.

...

> struct ssp_data {

>  	struct spi_device *spi;
>  	const struct ssp_sensorhub_info *sensorhub_info;
>  	struct timer_list wdt_timer;
> +	struct mutex wdt_lock; /* protects watchdog timer state */
> +	bool wdt_enabled;
>  	struct work_struct work_wdt;
>  	struct delayed_work work_refresh;

Does `pahole` agree with the given layout?

>  _mod:
> +	if (READ_ONCE(data->wdt_enabled))

What are we going to do if just after this wdt_enabled becomes false?
(Is it a possible case?)

> +		mod_timer(&data->wdt_timer,
> +			  jiffies + msecs_to_jiffies(SSP_WDT_TIME));
> +}

Same Q to all the below. Hmm... It seems they are all protected by the mutex?

-- 
With Best Regards,
Andy Shevchenko


