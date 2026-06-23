Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5130135DA7B;
	Tue, 23 Jun 2026 20:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246206; cv=none; b=O0qE0u2JlYu7igB/rxAOAaWgHGGhRHpdevneQ9kZ6Rh/pNIg9LUYAmX9CHWpAwxR91U5XEN+BGnZYBuN0EeLuFoIRHCre2r38uXz6YTD59wN8IbDgiNskWS2IDl9fPCSBEHIDjIEcQ6TorH/7JIAp7UkXJ/2/ZojlVJdPUcG8Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246206; c=relaxed/simple;
	bh=15faP+ApOLh3ds+1OIn1FuNBNnTZfi1gAVLl7GOMuEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPKKIzLLIqGc5TejtBfWS3pKrTi6PwjpX01X6f5n6ZoZKHH4QPVKzf+AslWk30+tpQnk3uiZ0yE21Sq/iVSve6zzdCBTbflFU2T7mPwwQp1WCwHtA8awZFOb5MHuTYziXaleGcmdcIzamTOHUt6j8Wf3N6EhEyKoaS29TM1UGbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fiH5bBiR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fiH5bBiR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782246205; x=1813782205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=15faP+ApOLh3ds+1OIn1FuNBNnTZfi1gAVLl7GOMuEo=;
  b=fiH5bBiRM2+rWnoCAIcmkuYEE3KNtOyEAbyGIi2vEV8y3MbkcQslGDnc
   iI6sFjF7rOe7IHXS861M/ason9wWIfWXeCgyyW/t60SsyYjRZRNqTKAwx
   tEfrar6084S2QPeGeQ4oXVu+A79lQrziQYoopNkXhFToYujWdEyC7ZcAs
   2qDyjo/BdUfF4134aCTdjQ1cn9/EknIuhWWEV8ZbQQIjozP2syWjJckW2
   QRvect63HIJTvgebn1EdK1xetd67xfxMPSSXQoCqY5OFmPvcZjpZEFTow
   yNe0hgy7q3dgzW/0RRCK1Ln5H08T6S9cNptLJhoyKuFWZICWoCaLnH6w5
   Q==;
X-CSE-ConnectionGUID: NRN2tDO/SXqefR737V8nCQ==
X-CSE-MsgGUID: cPeEzZOjQL2WEp8Z/pgdiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="94493894"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="94493894"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 13:23:24 -0700
X-CSE-ConnectionGUID: 5j53VBgJQDW4ZBL9w6iMcw==
X-CSE-MsgGUID: 7b9EAwXyR4ujyNCIUSPHFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="249644650"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 13:23:21 -0700
Date: Tue, 23 Jun 2026 23:23:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix timestamping by limiting
 FIFO reading
Message-ID: <ajrrN9yPzr2yxqef@ashevche-desk.local>
References: <20260623-inv-icm42600-fix-watermark-fifo-reading-v1-1-f3f5694a818a@tdk.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623-inv-icm42600-fix-watermark-fifo-reading-v1-1-f3f5694a818a@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 23, 2026 at 06:44:22PM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:

> Timestamps are made by measuring the chip clock using the watermark
> interrupts. If we read more than watermark samples as done today, we
> are reducing the period between interrupts and distort the period
> measurement. Fix that by reading only watermark samples in the
> interrupt case.
> 
> Better watermark computation using gcd and store watermark value for
> FIFO reading.

...

> +		/* use the shortest period and the gcd of the latencies */
> +		period = min(period_gyro, period_accel);
> +		latency = gcd(latency_gyro, latency_accel);

If gyro is 5 and accel is 7 the gcd() will give 1. I don't think it's what you
want.

Did you think of lcm()?

...

> +	/* update effective watemarks */
> +	st->fifo.watermark.value = max(latency / period, 1);
> +	if (wm_gyro)
> +		st->fifo.watermark.eff_gyro = max(latency / period_gyro, 1);
> +	if (wm_accel)
> +		st->fifo.watermark.eff_accel = max(latency / period_accel, 1);

In my example this ends up with 1 in both cases.

-- 
With Best Regards,
Andy Shevchenko


