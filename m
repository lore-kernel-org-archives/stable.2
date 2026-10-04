Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD502F0661;
	Sun,  4 Oct 2026 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791103232; cv=none; b=Voo0gG2bS1BaAABFsbLm6DRntzVOP2hsp/WVpDPE/nCwurF0loY30IT/ub8Hn6IJHslbU5BRe3l+EWCr4rsmo2ogMo8qVxxWhmkmypwkzejIpCed/jTVK5t64+gu5PMLA1HSn2pzw1txwknRowXsMUqTYKgMzGDz1rVURncbEB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791103232; c=relaxed/simple;
	bh=XNntfym4tCch+zSlU8Wn7sbDuve181DhutZT19j5h7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuKEqbeAU3SltxLTVTdQ6/wMwpgz55qhXRUgFJusTnW9TvoAGw3Aqi5Tl3QJOrfQiW+bR5LFutNFGsbJJ8X55BERBFT/GtPCgWrN0bkKysWQFl28gaVMf31Xn+iKMG7iz5pR96fqB1oTFeZ697Cw2hK49EAvFCwy20eNPSPodLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7zpUmmj; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7zpUmmj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791103231; x=1822639231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XNntfym4tCch+zSlU8Wn7sbDuve181DhutZT19j5h7I=;
  b=Y7zpUmmjfqtUVn5TsnJV4Chr/+jbg+vM/z2ksmMUshRNZ6RyjTDtu7ZM
   pGetPD8BSaykzUUfeqqyVhIBiBC8MP95JLtTlCc8hBbj7s0XxdPfGoisj
   wTgTRQq9aFR11RrhaBZnNXW+FWczv2P8lKcrnWoKaK0KkDVQOyVDBH9TJ
   aellP0P7MWNEX5/8YAtDTIAOfDDdNZIpCxXQtHugXRa88LQIhhclPbiMC
   gUq4Il91ZU5800RbblQLpQ0seqkTBFpiQobuJdQO+TRWVsCdG3oVE4OuG
   EKHa8XN3ZwLN1ojD/+NSe6wy54s31sgvH5V+RINaTgMQJKdOH3akS9wlI
   w==;
X-CSE-ConnectionGUID: UZBghlimRR++LJ6D6N1rAA==
X-CSE-MsgGUID: MucGCTefRlODUiSOyS0Xpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="94288894"
X-IronPort-AV: E=Sophos;i="6.27,139,1787036400"; 
   d="scan'208";a="94288894"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 01:40:30 -0700
X-CSE-ConnectionGUID: qydToNTrQPqRlmYbYybmGA==
X-CSE-MsgGUID: nhZ5LfQITjK4WMGO/v6k8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,139,1787036400"; 
   d="scan'208";a="302814897"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 01:40:28 -0700
Date: Sun, 4 Oct 2026 11:40:26 +0300
From: Andriy Shevchenko <andriy.shevchenko@intel.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Karol Wrona <k.wrona@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v2] iio: ssp: Serialize watchdog timer state changes
Message-ID: <asIQ-lnNBk8isPa0@ashevche-desk.local>
References: <arzdLtzXQ4cvObrL@ashevche-desk.local>
 <20261004053927.1139035-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004053927.1139035-1-runyu.xiao@seu.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 04, 2026 at 01:39:27PM +0800, Runyu Xiao wrote:
> The SSP watchdog timer rearms itself from its callback, but the driver uses
> timer_delete_sync() when the last sensor is disabled and during suspend.
> Those operations do not prevent a concurrent enable or callback from
> rearming the timer after deletion. The final remove path also used
> timer_delete_sync(), which does not permanently prevent rearming before the
> device state is released.
> 
> Protect watchdog state and the enable reference count with wdt_lock. The
> timer callback rearms only while the timer is enabled, and synchronous
> deletion drains an in-flight callback. Use timer_shutdown_sync() for final
> removal so later rearm attempts are rejected permanently.
> 
> A refresh work item can call ssp_sync_available_sensors() and
> ssp_enable_sensor() during suspend. If the enable count is zero when
> suspend checks it, that work can otherwise start the watchdog after the
> suspend stop. Track the suspended state under wdt_lock. Sensor enables may
> update the count without restarting the timer. Stop the watchdog before
> sending the suspend command, and restart it only after resume succeeds or
> suspend fails.
> 
> Cancel watchdog work after releasing wdt_lock because reset work can wait
> for the threaded IRQ handler, which may synchronously wait for refresh work
> that enables sensors. Remove MFD children before destroying the locks;
> IIO child teardown can disable an active sensor.

General rule of thumb is to defer a new version until the discussion is settled
down in the previous round(s).

...

> struct ssp_data {

>  	struct spi_device *spi;
>  	const struct ssp_sensorhub_info *sensorhub_info;
>  	struct timer_list wdt_timer;
> +	struct mutex wdt_lock; /* protects watchdog timer state */
> +	bool wdt_enabled;
> +	bool wdt_suspended;
>  	struct work_struct work_wdt;
>  	struct delayed_work work_refresh;

Same Q here, can you reduce the gap by 4 bytes by rearranging the new members?

-- 
With Best Regards,
Andy Shevchenko


