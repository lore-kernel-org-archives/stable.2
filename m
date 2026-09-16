Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E7A44A403;
	Wed, 16 Sep 2026 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789556424; cv=none; b=QusT0QhcI0DYbCLqfxTXKq8SAChSTbAfCthUo4jcqFA+rRFz5Di9GZkPsVBOmI/aLy4e0boDRGdJhKZr0LVa5AvWRoy5Te1vcePVVGz8mk9RHLFMqfS7nlpdDP/8PLc1LoZKAGTuhz+x20S7gKVtSQ+IQ7DtARvSPFwQjgahVYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789556424; c=relaxed/simple;
	bh=jKMCZsqefUPFu4iT0IUKJlmYzNOQK5RGDlACcK0O1Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMCMRD7QDbhhI3GOSgOHagIOWnkD7sYBiUBz42JV5/FkgmhLaAofCdTaCXXpcxVqlyR8QcrFLpVKjStfFpxCKPyKidEws8bBSPf1QNIKBpCzBwWB0ZhaULMETWP5DJMbskQ4sB+U8oPOydGXE6kYEth7r0cT7pXGlZMqA3aJP/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=deXaoumG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="deXaoumG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789556416; x=1821092416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jKMCZsqefUPFu4iT0IUKJlmYzNOQK5RGDlACcK0O1Uc=;
  b=deXaoumGaJWr5Yk12NJiVyddJH3CTSXQpJ/vUB5l+PtGgkZGWyK1xgou
   /tto8bZ4b3Xf26sTz/Y0en9yZtV653elfBObrDwQqmn3ChYpdyglNtsJ+
   Oyha5ehQrTgjdS0h7m0rm1NREhUYdn0LHWAuJc4nfGEim/HtCymOkWH6H
   6k8HtaXBv95kpO7LjtpIkpw5rNwdI7lo8erxdgHr1yBSZr3CG8rU2lraQ
   zazPwGdooRssMyML9dZ6Kdiq5783Zfj7KSJBv3oylVFwlRMrqqapVYOK1
   jKL16Ay3v3vVTvx2BfTrwaoPB7+Xd4T735UQttt/QLIZ1F5XVXale+WzB
   A==;
X-CSE-ConnectionGUID: ONZYN/WjRUqLQgloBxVVjw==
X-CSE-MsgGUID: Zq5gIkNESw6DB2kHTteWyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100595042"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100595042"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 04:00:09 -0700
X-CSE-ConnectionGUID: QxgxPO6ORc2kH+0xVscjdg==
X-CSE-MsgGUID: Rw6uQNYZRCentKvYux1vGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="277432941"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.145])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 04:00:06 -0700
Date: Wed, 16 Sep 2026 14:00:03 +0300
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
Message-ID: <aqp2s5TjgIZS7i-L@ashevche-desk.local>
References: <20260915-adc-fix-div0-v1-1-7daed9e52f2f@foss.st.com>
 <aqpGy9oQkDC-xZGW@ashevche-desk.local>
 <bd47e39c-18e0-46ba-8cdf-9ba35f387793@foss.st.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd47e39c-18e0-46ba-8cdf-9ba35f387793@foss.st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 12:23:38PM +0200, Fabrice Gasnier wrote:
> 
> On 9/16/26 09:35, Andy Shevchenko wrote:
> > On Tue, Sep 15, 2026 at 06:10:40PM +0200, Fabrice Gasnier wrote:
> >> In case the conversion has failed or returned zero, processing *val
> >> can lead to a division by zero.
> >> Need to check for errors, or converted value is zero, before processing
> >> the data.
> >> In case converted value is zero, e.g. the Vrefint channel, this should
> >> be considered as invalid in all case.
> > 
> > Something went very wrong with the indentation of the above.
> 
> Hi Andy,
> 
> Euh, sorry but I don't understand what's wrong with indentation in the
> commit message ? Could you clarify ?

Each sentence seems to be a separate paragraph. Paragraphs are delimited
by a blank lines. But are they (sentences) really so independent?

Compare to:

  In case the conversion has failed or returned zero, processing *val
  can lead to a division by zero. Need to check for errors, or converted
  value is zero, before processing the data. In case converted value
  is zero, e.g. the Vrefint channel, this should be considered as invalid
  in all cases.

(also I fixed the typo, should be plural for 'cases' at the end).

...

> >> -		if (mask == IIO_CHAN_INFO_PROCESSED)
> >> -			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
> >> +		if (mask == IIO_CHAN_INFO_PROCESSED) {
> >> +			if (ret >= 0 && *val)
> >> +				*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
> >> +			else
> >> +				ret = ret < 0 ? ret : -EINVAL;
> >> +		}
> > 
> > Reuse of the *val makes code harder to follow. Add a temporary variable for
> > this and do something like this (also note other simplifications)
> > 
> > 		tmp_choose_good_name = *val;
> 
> In case ret is an error; this lead to evaluate (e.g. read) *val from the
> (maybe uninitialized) stack. Probably not an issue? But would prefer to
> keep reading it only when ret >= 0, as done currently with the if
> condition above ? (e.g. evaluate ret, before *val)

> > 		...
> > 		if (mask == IIO_CHAN_INFO_PROCESSED) {
> > 			if (ret < 0)
> > 				return ret;

Then simply move the assignment here

			tmp_choose_good_name = *val;

> > 			if (tmp == 0)
> > 				return -EINVAL;
> 
> I've started with something similar before, but we can't return directly
> here. Must call iio_device_release_direct() first. This would add more
> lines.
> 
> So I chose to implement above ternary ret = ret < 0 ? ret : -EINVAL, to
> fall-through.
> 
> Please advise on the preferred way,

As per above.

> > 			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / tmp;
> > 		}
> > 
> >>  		iio_device_release_direct(indio_dev);
> >>  		return ret;

-- 
With Best Regards,
Andy Shevchenko


