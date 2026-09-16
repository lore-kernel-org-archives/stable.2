Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BF61A2C04;
	Wed, 16 Sep 2026 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569554; cv=none; b=uDxOeAR4+BZ/epIhlk+1jnhC5Tgb+lui75JcBDXet9kPnKhmRAEn+GlD58/10yOAQqwLpAbQQrzSIkduLi9PdskUCZiVQZXpEnmnSPFjRhBwd1AVTX9cSdKm+WYnbtycV38yX9TrIG0Bry1wjDHeM3YQFb5eymGZX2Mq/O3i4Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569554; c=relaxed/simple;
	bh=XrmV5AYtnPtVAHzQnffCQxg/8kqWWYTjiNeJHagDZwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXIVawgHc5j4ms6ohTarAgiLNAKvZwAda3AdZqJBDOTEyXFJTV6BspLPA7Y8dbL/60CkgyJeLcFGkhFjE1gQ5cm2tsCKUOX+eWUzHDO9BRDPIwFiFfTn9e56/Q7Q2QAXBPpmLJzLQpPesn5RIFeMmwZp2XvUNM7bHqpsokIqsWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D6CFO0S1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D6CFO0S1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789569552; x=1821105552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XrmV5AYtnPtVAHzQnffCQxg/8kqWWYTjiNeJHagDZwA=;
  b=D6CFO0S1w+nn0EgQ/98MN60pbVFmLwYXLXQIaz1OqGiKDNEyU+fDTfjR
   THotq6gTlNha3qwi4g5yt3IHYuVUnRBHGIDUVZD0ABSO+Y1Cd5nEqq5lg
   UWhR33O7o4lRcAlAErrUhr5ukGu55oJqr6bUCKlCbsrI7zBxIzOZzlIQf
   itu+5ZJLNDszmX9E/gZUOU9MEOhP3LXO7la9B8l3kXLipijMdqKt+fls8
   QuPk/yYyIvtJTY91pxWqH0j+LSxVPsyQk9gC2LJIGeQ853sIobsE0QiQd
   jkag1GA+zfF1XJMvw03oIU7mPXQNsFBc0RVZImn3kKktut48Z3mc1TQiE
   A==;
X-CSE-ConnectionGUID: 6mWlzFzuSxiNLC7pUq3ztg==
X-CSE-MsgGUID: gBaOFpSZTPSeB0UWbgBOCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="115483549"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="115483549"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 07:39:11 -0700
X-CSE-ConnectionGUID: FstFep20SDOsQTM+1NaYBw==
X-CSE-MsgGUID: qK+yDxxsQBWJyllQdob0Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269657357"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.145])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 07:39:07 -0700
Date: Wed, 16 Sep 2026 17:39:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: stm32-adc: fix possible division by zero in
 processed channel
Message-ID: <aqqqCf6mQPMoKZRj@ashevche-desk.local>
References: <20260916-adc-fix-div0-v2-1-f702d3ed782c@foss.st.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-adc-fix-div0-v2-1-f702d3ed782c@foss.st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 04:10:05PM +0200, Fabrice Gasnier wrote:
> In case the conversion has failed or returned zero, processing *val
> can lead to a division by zero. Need to check for errors, or converted
> value is zero, before processing the data. In case the converted value
> is zero, e.g. the Vrefint channel, this should be considered as invalid
> in all cases.

...

> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/all/20260911161555.244F31F000FF@smtp.kernel.org/

Closes: ^^^


> +		if (mask == IIO_CHAN_INFO_PROCESSED) {
> +			int vrefint_raw;
> +
> +			if (ret < 0) {
> +				iio_device_release_direct(indio_dev);
> +				return ret;
> +			}
> +
> +			vrefint_raw = *val;

> +

Unneeded blank line.

> +			if (vrefint_raw == 0) {
> +				iio_device_release_direct(indio_dev);
> +				return -EINVAL;
> +			}
> +
> +			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / vrefint_raw;
> +		}

Let's look at the current code in this switch-case

	case IIO_CHAN_INFO_PROCESSED:
		if (!iio_device_claim_direct(indio_dev))
			return -EBUSY;
		if (chan->type == IIO_VOLTAGE)
			ret = stm32_adc_single_conv(indio_dev, chan, val);
		else
			ret = -EINVAL;

		if (mask == IIO_CHAN_INFO_PROCESSED)
			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;

		iio_device_release_direct(indio_dev);
		return ret;

In the previous version you were trying to keep goto-less approach.
However in the current state of affairs I don't think the goto is
too bad (after all we need to backport this to the kernels that may
not have IIO_DEV_ACQUIRE_DIRECT_MODE() macro).

Also checking 'ret' under another condition seems unusual.

What about

	case IIO_CHAN_INFO_PROCESSED:
		if (!iio_device_claim_direct(indio_dev))
			return -EBUSY;
		if (chan->type == IIO_VOLTAGE)
			ret = stm32_adc_single_conv(indio_dev, chan, val);
		else
			ret = -EINVAL;
		iio_device_release_direct(indio_dev);
		if (ret)
			return ret;

		if (*val == 0)
			return -EINVAL;

		if (mask == IIO_CHAN_INFO_PROCESSED)
			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;

		return 0;

? (Yes, we leave that line untouched, but we get the change cleaner.)


-- 
With Best Regards,
Andy Shevchenko


