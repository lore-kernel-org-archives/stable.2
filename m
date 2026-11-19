Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108998;
	b=wPQwDOOJC8z7/BuwdyM7/ArrRA2vQudzj1ksELcamYv8X4d/yR9+O8IzgAdqb34l+ETO
	 ydnnhnxUBdP+9fPE5ZUW10g7cYiElp8h2XOvUimkCkbcgmaMSOs40OQk/K4Rt0kZsOUuK
	 FHBMwyn/aieLkhucxYCqJUJGITe4wHj8GtnG0q6DTY4u+QyiUcIX9cJnxlUoGc3wJuOAW
	 BrXb201cQn/cVVKvBlgInQ+jWlBdWiN4L6uPRFoH64qCNuW99VNBvbDVS+uXhQDos+YyE
	 VJv2Wk69paYTFoL9EPMQllXdrYykRA3CjMsjSjz2p9NJA6AOWXOhdepqwLY1wfwEeWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108998;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=T/doD335ORQ2aR4heO4AYNHnuzIPWGmhftw39sxPBYA=;
	b=VGtHsntSsLRHt/Z8EYMEQPzidwtuZG6CJPz66g+nKP/1nPIOmLpY6jCUM+Ml6UMcrofI
	 VZFmqou/iDBmqh1WfjRyOd9eHDYAI16ym9Z7lVuC2Gc+7jHpa40gzEaGJ5bMX9xdSQ9wg
	 jm06H8wFX4sP7mTdN64gwC8GYRo6o7aA9chLJWR/1RkL0GyXadcnOcclAdiJ0+fMsMXaC
	 Ohso/c61RC2FdhO51QB41+znureHTNFORPH7amnqfqiVsxANzLSsqgGzUeWOOjwSG4oSV
	 vNXvTGRbxmLLI+AV1Cvn7KDasof41qF9hsaYcAKdxhARTMDL76oZ1XsaOECvcldGr2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YWFW2jy2;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106F8606A337;
	Thu, 19 Nov 2026 17:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 106F8606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YWFW2jy2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795108997; x=1826644997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rbeulK9tHwSJXS4GzNoiB5ScFduP8tzxNEkcrLh/28w=;
  b=YWFW2jy2/5BjRUbVprN2UxlTPZR3cAlx54OhKMgyldhxo6VFfBdgvTX/
   pXkQbQEweBrVVdm9uLUWMyA0QxfMCZ6wGC2AmiiEumu7Nb5dpon6dkvTy
   hx79aoLZM+Y2pVg3pOmcx2BrmzViynTNcbP+tB+CtnNLSHoaY1Zh+lS6H
   1kkn/ylH1Za++QN6VUdMMXsFY28t/c0wtceVnNpdKyP9YRGIKxPCDi4QT
   ySrkM1ksHwL4pDpPSTxGn/iDvOI1lhqFTUCVPpbdtiK0LtMh++4H+U/sM
   vXgZVsESP5sHsDivH7RwA5eIcWyCrJ9C49nyvIqUeG58AzgvV+qFvYUh0
   A==;
X-CSE-ConnectionGUID: CrgmSbswTUms7nPrj6o/lg==
X-CSE-MsgGUID: 1rvKQaLWTBGk9q26W0f5Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4014145"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="4014145"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 09:23:14 -0800
X-CSE-ConnectionGUID: 4dDni44YSrK+KNrtBlUfGQ==
X-CSE-MsgGUID: /0+wv7ofQxy15cnzuEHhag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10576996"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 09:23:09 -0800
Date: Thu, 19 Nov 2026 19:23:07 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Lucas Stankus <lucas.p.stankus@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alexandru Ardelean <ardeleanalex@gmail.com>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 03/10] iio: accel: adxl313: Reject sub-base ODR codes in
 adxl313_read_raw()
Message-ID: <av8we4c71xsdi7-6@ashevche-desk.local>
References: <20261119153151.1397003-1-lee@kernel.org>
 <20261119153151.1397003-4-lee@kernel.org>
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
In-Reply-To: <20261119153151.1397003-4-lee@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 03:30:36PM +0000, Lee Jones wrote:
> When reading IIO_CHAN_INFO_SAMP_FREQ, adxl313_read_raw() extracts the
> 4-bit rate field (0..15) from ADXL313_REG_BW_RATE and subtracts
> ADXL313_RATE_BASE (6) to index adxl313_odr_freqs[].
> 
> ADXL312 and ADXL314 support sub-6.25 Hz rate codes 0..5 and do not
> perform a soft reset during setup, and debugfs register writes or a
> faulty bus read can likewise yield codes below ADXL313_RATE_BASE.  When
> that happens, subtracting ADXL313_RATE_BASE produces a negative index
> and reads before the start of adxl313_odr_freqs[].
> 
> Return -EINVAL if the rate field is below ADXL313_RATE_BASE.

...

> -		ret = FIELD_GET(ADXL313_RATE_MSK, regval) - ADXL313_RATE_BASE;
> +		regval = FIELD_GET(ADXL313_RATE_MSK, regval);
> +		if (regval < ADXL313_RATE_BASE)
> +			return -EINVAL;

Here seems ERANGE is good.

> +		ret = regval - ADXL313_RATE_BASE;

-- 
With Best Regards,
Andy Shevchenko


