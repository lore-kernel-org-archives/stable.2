Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12AC44CF25;
	Wed, 16 Sep 2026 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544736; cv=none; b=JbokZlszTq/2GKiLVKgCqdo/siwU+N7F4D0pnEt6gBe1nW6H1j6y9s3672Axsr2CPC4rsqwQadb7ftPTw04x3CbSmJl9nGlAVAG1itavVZ9Mhs8HIy2SvTDvtrhDyh20rcHsXHeTlHnolw6mEF2KUdJ8KhSl+uWQoIvj3MbXIc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544736; c=relaxed/simple;
	bh=2oleBu2ZyXTqH7IkiY2FnDAfDfVgurItEBflxV+93NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIgXfKDuAHyGiZ1cVzKxTwqekexgZG9dGsV8sKI2PXiLajxGZOMlSMyB6+pU3+MmC2E2mznC3h8x6GiLvEM9Pbz848w2vhEAsBDbZxmzU3OziFIWAorlvRykBiVHviwS6g3zA9BLfNZzLf4jjqTi519C0SXIxHvwnkZ4ak8LlJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=neiHH7CZ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="neiHH7CZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789544726; x=1821080726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2oleBu2ZyXTqH7IkiY2FnDAfDfVgurItEBflxV+93NA=;
  b=neiHH7CZ2f2V6X6V3WQnZWUl9zDDtJqEs8Aznk+6VZXQ1AKcaz8XCB3A
   7zESbcLYSeKcT1CFx2eE6bOr4ln61Aq3HWCKKwYU6/y7nJG87v5/aDGu3
   zlisxm/tu8KOWKj1PMmqUYDaxFg+KBv3eKssNqMiTWFJ3pWIJuS7BCnr8
   ZhQbT7I4lbc+h+N4ylG14P9qmZNZZ6NFm6NgO7m0LFJkD893j/+P0HJmg
   72vTWSXlDfTrJ4ykJYzQdUg1WWTTH/roCb+PEr32kzUIP9MU8UykkaQUS
   gCJpw6puwXwx5/Chst4udGlmsO/5RPTJwPxbDw+GofCwBlckn2U1gqLFG
   g==;
X-CSE-ConnectionGUID: f495BNdiSIi1gypaAS8fgg==
X-CSE-MsgGUID: LJI3tdTHQFOhfynah/WMyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100579786"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100579786"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 00:45:20 -0700
X-CSE-ConnectionGUID: BQV/x/2rRbWb7yalBTZ5Qw==
X-CSE-MsgGUID: QduNPbCCTtG8DYwiVMlcrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="272788606"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.145])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 00:45:16 -0700
Date: Wed, 16 Sep 2026 10:45:14 +0300
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
Subject: Re: [PATCH] iio: adc: stm32-adc: fix check on internal channel
 availability
Message-ID: <aqpJCsBNKDSKlfFD@ashevche-desk.local>
References: <20260915-adc-fix-intchan-v1-v1-1-761a1b35001b@foss.st.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915-adc-fix-intchan-v1-v1-1-761a1b35001b@foss.st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 15, 2026 at 06:15:49PM +0200, Fabrice Gasnier wrote:
> If an unsupported internal channel like vddgpu is requested, the driver
> prints a warning but falls through and assigns it a valid int_ch below.
> 
> This causes a problem later during setup:
> stm32_adc_int_ch_enable() {
>     ...
>     case STM32_ADC_INT_CH_VDDGPU:
>         stm32_adc_set_bits(adc, adc->cfg->regs->or_vddgpu.reg,
>                            adc->cfg->regs->or_vddgpu.mask);
>     ...
> }
> 
> Because the register offset is uninitialized (0), this performs a
> read-modify-write on offset 0, which corresponds to the ISR register.
> 
> Fix this by returning before a valid int_ch is assigned.
> Choice is made to just warn about the channel name as it could
> be confusing, rather than making the probe fail.

Are this and the other patch made with AI assistance?

...

>  	struct stm32_adc *adc = iio_priv(indio_dev);
>  	u16 vrefint;
> -	int i, ret;
> +	int i, ret = 0;

No, either assign closer to its first user, or do even better.

>  	for (i = 0; i < STM32_ADC_INT_CH_NB; i++) {
>  		if (!strncmp(stm32_adc_ic[i].name, ch_name, STM32_ADC_CH_SZ)) {
> @@ -2267,31 +2267,36 @@ static int stm32_adc_populate_int_ch(struct iio_dev *indio_dev, const char *ch_n
>  			switch (i) {
>  			case STM32_ADC_INT_CH_VDDCORE:
>  				if (!adc->cfg->regs->or_vddcore.reg)
> -					dev_warn(&indio_dev->dev,
> -						 "%s channel not available\n", ch_name);
> +					ret = -ENOENT;

This is a repetition of the same value. Instead add a boolean flag and do here

	bool na;
	...
			na = false; // or can be dropped with 'default' case
			switch (i) {
			case STM32_ADC_INT_CH_VDDCORE:
				na = !adc->cfg->regs->or_vddcore.reg;

>  				break;
>  			case STM32_ADC_INT_CH_VDDCPU:
>  				if (!adc->cfg->regs->or_vddcpu.reg)
> -					dev_warn(&indio_dev->dev,
> -						 "%s channel not available\n", ch_name);
> +					ret = -ENOENT;
>  				break;
>  			case STM32_ADC_INT_CH_VDDQ_DDR:
>  				if (!adc->cfg->regs->or_vddq_ddr.reg)
> -					dev_warn(&indio_dev->dev,
> -						 "%s channel not available\n", ch_name);
> +					ret = -ENOENT;
>  				break;
>  			case STM32_ADC_INT_CH_VREFINT:
>  				if (!adc->cfg->regs->ccr_vref.reg)
> -					dev_warn(&indio_dev->dev,
> -						 "%s channel not available\n", ch_name);
> +					ret = -ENOENT;
>  				break;
>  			case STM32_ADC_INT_CH_VBAT:
>  				if (!adc->cfg->regs->ccr_vbat.reg)
> -					dev_warn(&indio_dev->dev,
> -						 "%s channel not available\n", ch_name);
> +					ret = -ENOENT;
>  				break;

Don't you also need a default?

			default:
				return -EINVAL; // for example...

>  			}

			if (na) {
				...
				return 0;
			}

>  
> +			if (ret) {
> +				/*
> +				 * Confusing channel label matches an internal STM32 ADC channel.
> +				 * Just warn about it, as there's normally no restriction on the
> +				 * name but that's not among supported internal channels.
> +				 */
> +				dev_warn(&indio_dev->dev, "no %s internal channel\n", ch_name);
> +				return 0;

My gosh, the ret value is even ignored!

> +			}

-- 
With Best Regards,
Andy Shevchenko


