Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C583448BA8;
	Wed, 16 Sep 2026 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544166; cv=none; b=UxBmm9A/6Kkx2Gm2M09M4/R+yQKCsCKsIc82VKF+Vb4itsUx1H6IKgNiZgXzvo4t1EB71qvneyT9I7vrZSgTQGVREHk0NELb/ypPpNYBM0UmL/FzWvaGFvon0Vc82yhgAt8IRREE1tTEcE+eW0XHXo+WwB6cr89YwVp04uhDkvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544166; c=relaxed/simple;
	bh=GkzRMnHLUAmW3pw+F+QgiPFULxg/81kYYY7dmuCPp9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+4/pQ+Zb8UxKT59Ehvz1qZhLIjSIwuAiQZ+V1W6ZCZO0dIFpg0V/5zGM5T7wX7un/RbfY/hh44JbhRWBu5MKGlDfWc0lkMILTV/m/hLAgQPck8nG8V37iSqafY1eiVFDKPmEiEd2EUC9lhMb+hn6VFUeJqTVDnZEyWri9LUjQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZtTpbNLU; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZtTpbNLU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789544149; x=1821080149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GkzRMnHLUAmW3pw+F+QgiPFULxg/81kYYY7dmuCPp9U=;
  b=ZtTpbNLUgmgo63ZMEqbwtHA8YhY3XW6BCAoZO2Kp2sGhPhVm0mipgZ7z
   Z0d5ooc/7EP9Z4LUWLYQqHRita9Gonf+EyC4u+4Ms1wVyp0uaSk2z/KU+
   vYTwjXVmkunH1vKIYGn5hl6Rx1pNk2Hxd4NN5WegMXaPiUkPzDRoT6Oty
   XqJEBLTQUtS6FC18ZTGvMgr0+YmMJPpnsS7/lgMXv8llFTgCuD1cQFpYK
   J2XUAHQwk815rHP48b+Jom46hktlSPiMLyDj6eS+HGIAegysAXRvda3Vf
   WXuNqzFhww1PMoQXfVPD08F8VhA20NfEMoN8xNHNjgSMVD6tZpKEWEL2Q
   w==;
X-CSE-ConnectionGUID: mgO986L7Riem/cLgPbKw1w==
X-CSE-MsgGUID: 5Uad1/FiS2KF6tykk3DA7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="88851660"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="88851660"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 00:35:45 -0700
X-CSE-ConnectionGUID: GSN9yJVbRO2xpOZsPAj3VA==
X-CSE-MsgGUID: VOs25VG+S32ijjFd8p0pTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="267043796"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.145])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 00:35:41 -0700
Date: Wed, 16 Sep 2026 10:35:39 +0300
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
Subject: Re: [PATCH] iio: adc: stm32-adc: fix possible division by zero in
 processed channel
Message-ID: <aqpGy9oQkDC-xZGW@ashevche-desk.local>
References: <20260915-adc-fix-div0-v1-1-7daed9e52f2f@foss.st.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915-adc-fix-div0-v1-1-7daed9e52f2f@foss.st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 15, 2026 at 06:10:40PM +0200, Fabrice Gasnier wrote:
> In case the conversion has failed or returned zero, processing *val
> can lead to a division by zero.
> Need to check for errors, or converted value is zero, before processing
> the data.
> In case converted value is zero, e.g. the Vrefint channel, this should
> be considered as invalid in all case.

Something went very wrong with the indentation of the above.

...

> -		if (mask == IIO_CHAN_INFO_PROCESSED)
> -			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
> +		if (mask == IIO_CHAN_INFO_PROCESSED) {
> +			if (ret >= 0 && *val)
> +				*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
> +			else
> +				ret = ret < 0 ? ret : -EINVAL;
> +		}

Reuse of the *val makes code harder to follow. Add a temporary variable for
this and do something like this (also note other simplifications)

		tmp_choose_good_name = *val;
		...
		if (mask == IIO_CHAN_INFO_PROCESSED) {
			if (ret < 0)
				return ret;
			if (tmp == 0)
				return -EINVAL;

			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / tmp;
		}

>  		iio_device_release_direct(indio_dev);
>  		return ret;

-- 
With Best Regards,
Andy Shevchenko


