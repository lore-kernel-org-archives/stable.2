Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436815;
	b=ttDPSYDDjLRGrZUEXUir+PLGrmH+8LP629o795cFPmY52sPAg0YZlWmG64kGYyXjEALc
	 SdrDxxj8Qlx5348aLps0Zfx2VCWf3u5HBxTS+NrhMxYDX6o+bxK1sbdcPFwjwKU5/+HQD
	 XtbWIb8SsPib0cpI9nfPPiK+S7Y03+MZrzLe6FwYe5HSEXVR5TtiEZfDTydma6++J5pMX
	 PAbnQDkJSR9z83Khe1u0CYV2Y+LSU+RA2E5Ecpp0StijG/T8HBvE8A/AQ/v+k3+pHWDsZ
	 CjYakmtB7n1L+Ndr7gtEjuFw+cW9xG9XF7jOdIve3+1FEZfY/6Fq96XTsrfurg0kdoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436815;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=eJ3KSdw/oco7NK/JJEH/QyQBpiIoD47j1DGgYtFv1Hk=;
	b=mAPH4Jx//KtKOyb4/ouQhdIHn2Y1ZJ4GX/dpEQuZi0meJFJyOmFbusIZCXkovW9v8NXs
	 h2sRuNq47VLVO5PasdJrlMfdLNXRE3BtdF0VJGij5piAPxHOyiRtj6JXlsRc9zYP5OlsW
	 Xkl5acbTjDORhcLnYgk19UmaVNcwYlxkU/wP3YojOpUFdvj6l/Cx3Q2dUYRGACfEVfBji
	 9Z1vmESqUnzzlvm5PhtQJHkuC3Kr+P33HRsk+U2y1Q9FeXlVRYuRpxUS7/lDnlJ/KLtsP
	 12G2aVB+3VILmk58VMOeJBCK0JfMyquJJAfiQgH2CvzzN+MJSmRtQ0tD5UH3FKa74Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y04muWZO;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE32606A322;
	Mon, 19 Oct 2026 19:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AE32606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y04muWZO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792436814; x=1823972814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZvmmG/j7C2uFnjYLLbt2EwQOQ4DYeskU4W145d6EpJc=;
  b=Y04muWZOycVF0jN4RMSXnHteLASKZfXATL4mWz6In8upWJLkUKq9zhNL
   au+XasSSEcSIkTeabFigUPc0EyB4xJwbCYIhuLrIVF2KxV9qthVV9p1Ls
   2QAhXrT9x0M8EEdXWXdD2Ul6KaBATQ1Gv3gnLB89B2xoFOJYFubmvZayu
   kn/1mk2RlWZf50FU/1DNs8DmQWquTvhOTfOFqY0uL1H9pCje0dR3Ne3yd
   aKbvnzxWZIuuCQgTKoHW28rluZ5duzFSeqhI6am3l1LvLe0tckU7QMetD
   LGQOweDfBcXesb152ID1mjzl0WIbGhZnbPOefugC3heEXLUzvUOHp8bT7
   g==;
X-CSE-ConnectionGUID: xNqdzzzDTa+HTEWpshY45g==
X-CSE-MsgGUID: z97CwH4ERDe0ENWYFDPFyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1023702"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1023702"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 12:06:54 -0700
X-CSE-ConnectionGUID: BThpq8gjToqSYUoKUD4OAQ==
X-CSE-MsgGUID: qHqcI3fAQ02qkBE9hiyzTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2988333"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 12:06:51 -0700
Date: Mon, 19 Oct 2026 22:06:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: dps310: wait for a new sample after a
 ratio change
Message-ID: <atZqSXI14WojGso5@ashevche-desk.local>
References: <20261019153328.80739-1-zoone.rupert@gmail.com>
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
In-Reply-To: <20261019153328.80739-1-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 06:33:28PM +0300, Rupesh Majhi wrote:
> After an oversampling ratio change, the sample waiting in the result
> registers and the one being measured are both from the old ratio, but
> are scaled with the new one. Pressure ratio 2 to 16 reads 192 kPa instead
> of 103 kPa, and temperature is off by hundreds of degrees. Pressure is
> also wrong after a temperature ratio change, as it is compensated with
> the cached temperature.
> 
> Discard those two samples on a ratio change, and for temperature cache
> the one after. The ratio write now blocks until then.
> 
> That wait can be longer than the 1/rate timeout, after which the driver
> resets the chip and the ratio silently goes back to 1. Allow two periods.

...

>  /* Make sure sleep time is <= 30ms for usleep_range */
>  #define DPS310_POLL_SLEEP_US(t)		min(30000, (t) / 8)

Seems the use of USEC_PER_SEC below should be postponed to a regular cleanup.
Because otherwise it will be inconsistent with the above where it would need
to be 30 * USEC_PER_MSEC

> -/* Silently handle error in rate value here */
> -#define DPS310_POLL_TIMEOUT_US(rc)	((rc) <= 0 ? 1000000 : 1000000 / (rc))
> +/* A period plus a measurement time; silently handle error in rate value */
> +#define DPS310_POLL_TIMEOUT_US(rc)	(2 * USEC_PER_SEC / max(rc, 1))

-- 
With Best Regards,
Andy Shevchenko


