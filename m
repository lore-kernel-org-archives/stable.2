Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3F6344DB7;
	Tue, 28 Jul 2026 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785261636; cv=none; b=rcN8CHOb/S09ihO37BBQqJGXnZun1sllITT6IaKIR6jRUKiLnECbKSfhZ2LCCabH02p52dxwUnyWjGN/n0wNbXAoNUHG72yv+VSAfnWwjkKn1xibp9lJIf2F6ydLsqHLMUO02lF/fnM9fYn4qDyg9RzhFwj8OzQr5PFtpjHf3Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785261636; c=relaxed/simple;
	bh=pWRkzgAQIkEo6EMVkEbvv7XRhG0KN5EvmaYgPkdV5Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8YDGV1oAe+yhvNoXIAF/czNqf8/i7XafpoI7wS6M+Gkhiqvz5AfToy+Ioajv2/TjAO1xZOPWowBz39Dw9kLndSyhOqzofkTULf3gQs8k2i7gVUsST29KAcwM+rTbw9biPvQ6I6ygL4ZI1FSN8m77qot2p1bYxMUrZNY6cpyZeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQGpHGnj; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQGpHGnj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785261634; x=1816797634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pWRkzgAQIkEo6EMVkEbvv7XRhG0KN5EvmaYgPkdV5Qc=;
  b=IQGpHGnjJ/UBroUi8s1RTE6Yb3GNuuSi9tBGF1NLfrjygpn81q08edwV
   vr6Q0hPUvV7bnp3o2LOvJhzW9PCnm+bkUq3hSouJVVjKgLXhd3T/4skPq
   +GbRkZ/mEhX8yW7EIWMEJ4S1C5kLjWxSC7elpOGUlV+FO9el3tqlU3QDN
   Yu/Q4Xzs5IbhG3d8UhXC06c1J2kVAFqu3/Y65TKAbvovde8lJGn3zipwe
   eAaJKlyigg7LdlNRmxvedh26+vGOL85NhEqARyfwxaCiHPRgwcW1hG0Df
   9Fzxjk58XjR3VKQdU5sdWBYvpwbB8NSXB6m7MUczCFS7OXYtohNeNQG4l
   Q==;
X-CSE-ConnectionGUID: X8isRgkgTH6JqtqN7HGlQA==
X-CSE-MsgGUID: JtuYkRndRiW6fgVV+t5PPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="108655417"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="108655417"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 11:00:34 -0700
X-CSE-ConnectionGUID: ddtPXouXSIi3x8S3KN1ONw==
X-CSE-MsgGUID: 0ARB6pVYQ36+vGIa1F++1w==
X-ExtLoop1: 1
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.69])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 11:00:31 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 6E190121C2B;
	Tue, 28 Jul 2026 21:00:30 +0300 (EEST)
Date: Tue, 28 Jul 2026 21:00:30 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Serin Yeh <serin.yeh@intel.com>
Cc: linux-media@vger.kernel.org, jimmy.su@intel.com, sarang.sapre@intel.com,
	bod@kernel.org, kieran.bingham@ideasonboard.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] media: i2c: ov8856 : remove ACPI node bypass
 mechanism
Message-ID: <amjuPjYBw5akS06k@kekkonen.localdomain>
References: <20260723074036.369363-1-serin.yeh@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723074036.369363-1-serin.yeh@intel.com>

Hi Serin,

On Thu, Jul 23, 2026 at 03:40:36PM +0800, Serin Yeh wrote:
> The driver currently skips power-on and power-off sequences when
> running with ACPI devices by checking is_acpi_node(). This results in
> all power configuration steps (GPIO, and regulators) being bypassed.
> 
> Remove the is_acpi_node() checks to ensure that the full power
> sequence is always executed regardless of the firmware interface.
> 
> With these changes, the driver behaves consistently across DT and ACPI
> platforms and ensures correct hardware initialization.
> 
> Fixes: d2fa1134a48b ("media: i2c: ov8856: Use V4L2 legacy sensor clock helper")
> Cc: stable@vger.kernel.org
> Signed-off-by: Serin Yeh <serin.yeh@intel.com>
> ---
>  drivers/media/i2c/ov8856.c | 29 ++++++++++-------------------
>  1 file changed, 10 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
> index 8bedb47cd7cf..9d2b0469a576 100644
> --- a/drivers/media/i2c/ov8856.c
> +++ b/drivers/media/i2c/ov8856.c
> @@ -2082,9 +2082,6 @@ static int ov8856_power_on(struct device *dev)
>  	struct ov8856 *ov8856 = to_ov8856(sd);
>  	int ret;
>  
> -	if (is_acpi_node(dev_fwnode(dev)))
> -		return 0;
> -
>  	ret = clk_prepare_enable(ov8856->xvclk);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to enable xvclk\n");
> @@ -2120,9 +2117,6 @@ static int ov8856_power_off(struct device *dev)
>  	struct v4l2_subdev *sd = dev_get_drvdata(dev);
>  	struct ov8856 *ov8856 = to_ov8856(sd);
>  
> -	if (is_acpi_node(dev_fwnode(dev)))
> -		return 0;
> -
>  	gpiod_set_value_cansleep(ov8856->reset_gpio, 1);
>  	regulator_bulk_disable(ARRAY_SIZE(ov8856_supply_names),
>  			       ov8856->supplies);
> @@ -2293,21 +2287,18 @@ static int ov8856_get_hwcfg(struct ov8856 *ov8856)
>  		dev_warn(dev, "external clock rate %u is unsupported",
>  			 xvclk_rate);
>  
> -	if (!is_acpi_node(fwnode)) {
> -		ov8856->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> -							     GPIOD_OUT_LOW);
> -		if (IS_ERR(ov8856->reset_gpio))
> -			return PTR_ERR(ov8856->reset_gpio);
> +	ov8856->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> +						     GPIOD_OUT_LOW);
> +	if (IS_ERR(ov8856->reset_gpio))
> +		return PTR_ERR(ov8856->reset_gpio);
>  
> -		for (i = 0; i < ARRAY_SIZE(ov8856_supply_names); i++)
> -			ov8856->supplies[i].supply = ov8856_supply_names[i];
> +	for (i = 0; i < ARRAY_SIZE(ov8856_supply_names); i++)
> +		ov8856->supplies[i].supply = ov8856_supply_names[i];
>  
> -		ret = devm_regulator_bulk_get(dev,
> -					      ARRAY_SIZE(ov8856_supply_names),
> -					      ov8856->supplies);
> -		if (ret)
> -			return ret;
> -	}
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ov8856_supply_names),
> +				      ov8856->supplies);

Can you fix this (multiple devm_regulator_bulk_get() should never have been
done) first in a separate patch, as Bryan suggested?

> +	if (ret)
> +		return ret;
>  
>  	ep = fwnode_graph_get_next_endpoint(fwnode, NULL);
>  	if (!ep)

-- 
Regards,

Sakari Ailus
