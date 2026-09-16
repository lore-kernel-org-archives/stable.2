Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA2C5452A8;
	Wed, 16 Sep 2026 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573200; cv=none; b=B2A6/808cQeUTMKu4ry4xVAJagOXa6RDSRjlx8+nCkjwlD1oq1lNBble4d90p8bW9nF6OoK0ANulhE6z5zY072Xlmg++EYRJAKGd/WXETPGeVdn+6pzIYQzVNZx385UzD0JhhQZkgg96LlbTUxBOYy9zUIAEXCbM0p8022mPMN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573200; c=relaxed/simple;
	bh=do7fs/RqIazZyqQPcXOJDXYuoCBird5b0yM0GMe8rv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpwOpO4XPVETn3Jqd+6W5rekrrGZuKG0WZERHKwZ5Dq2h6HpBwOmX9hSLODigtqL8Mlztx8T7hsffnFJu+hGIsol/neaKXlXWxgMDSLkl/inEdOPZd8WHwrVEghcSQp2aZtLq4IH3d+ULbHmEB22e+Igyr8aLMR89WhU6zZdAac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K3IiCsvi; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K3IiCsvi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789573198; x=1821109198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=do7fs/RqIazZyqQPcXOJDXYuoCBird5b0yM0GMe8rv8=;
  b=K3IiCsviL9TPrGqOrMwG7H+VOH3g32ZNcPCrNt8CPyhHi11m6EjtjEeu
   XXRfDswXa+OjO5cLSr5cp6rxtE2ydKGFj2JyPiQdT66u2xxYiDcU0YVBX
   PQbV26Pq4izWhUZqeYFcC8oQ+gLL6pq3rDAb7yvbz202/8FTGGNN14ezZ
   ldiTMnUmotE5P2c3l8tt2lw6ph/zV3rizZo3j9pFUuRVFYqQmLYLN6Rk4
   amYohvHVf8BfaKZO0+HqCqVn5kphXGQogye0LhbRcqoVSCyP5Ou419rEj
   Aqpvfd1vpiK/laLyqL48Mj8rAxwfJrSMqKRId/qIyd24kUE5IRDPNCSdh
   A==;
X-CSE-ConnectionGUID: CudlW9+xS6WQIl3ftGdkVQ==
X-CSE-MsgGUID: YdWqhMKBQI6qpH+yz0aqng==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93656710"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93656710"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 08:39:57 -0700
X-CSE-ConnectionGUID: hKF6xc+KSeSiJwBW663bRQ==
X-CSE-MsgGUID: 2yn5LcLKSd+cphrjWLOTJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="272903448"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.145])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 08:39:54 -0700
Date: Wed, 16 Sep 2026 18:39:52 +0300
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
Message-ID: <aqq4SD2eR9tDQ0aj@ashevche-desk.local>
References: <20260916-adc-fix-div0-v2-1-f702d3ed782c@foss.st.com>
 <aqqqCf6mQPMoKZRj@ashevche-desk.local>
 <538c8203-3880-47aa-ba4e-014a345b3cb9@foss.st.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <538c8203-3880-47aa-ba4e-014a345b3cb9@foss.st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 05:20:48PM +0200, Fabrice Gasnier wrote:
> On 9/16/26 16:39, Andy Shevchenko wrote:

[ snip ]

> > Let's look at the current code in this switch-case
> 
> Thanks for you suggestions !
> 
> Let's keep in the picture the 'normal' raw case:

Ah, an important detail!

> 	case IIO_CHAN_INFO_RAW:
> > 	case IIO_CHAN_INFO_PROCESSED:
> > 		if (!iio_device_claim_direct(indio_dev))
> > 			return -EBUSY;
> > 		if (chan->type == IIO_VOLTAGE)
> > 			ret = stm32_adc_single_conv(indio_dev, chan, val);
> > 		else
> > 			ret = -EINVAL;
> > 
> > 		if (mask == IIO_CHAN_INFO_PROCESSED)
> > 			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
> > 
> > 		iio_device_release_direct(indio_dev);
> > 		return ret;
> > 
> > In the previous version you were trying to keep goto-less approach.
> > However in the current state of affairs I don't think the goto is
> > too bad (after all we need to backport this to the kernels that may
> > not have IIO_DEV_ACQUIRE_DIRECT_MODE() macro).
> > 
> > Also checking 'ret' under another condition seems unusual.
> > 
> > What about
> > 
> > 	case IIO_CHAN_INFO_PROCESSED:
> > 		if (!iio_device_claim_direct(indio_dev))
> > 			return -EBUSY;
> > 		if (chan->type == IIO_VOLTAGE)
> > 			ret = stm32_adc_single_conv(indio_dev, chan, val);
> > 		else
> > 			ret = -EINVAL;
> > 		iio_device_release_direct(indio_dev);
> > 		if (ret)
> > 			return ret;
> > 
> > 		if (*val == 0)
> > 			return -EINVAL;
> 
> So *val == 0 is normally a valid value, for 'normal' raw channels.
> 
> > 		if (mask == IIO_CHAN_INFO_PROCESSED)
> > 			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
> 
> With you suggestion, moving if (*val == 0) to here should be fine ?

Yep.

> 		if (mask == IIO_CHAN_INFO_PROCESSED) {
> 			if (*val == 0)
> 				return -EINVAL;
> 			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
> 		}
> 
> > 		return 0;
> > 
> > ? (Yes, we leave that line untouched, but we get the change cleaner.)

-- 
With Best Regards,
Andy Shevchenko


