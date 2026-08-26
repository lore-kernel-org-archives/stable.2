Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6533232B100;
	Wed, 26 Aug 2026 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787729001; cv=none; b=mfErXmJeYylHLgeZVpPBO77MMUAQRAzzHUJtmzn8+tMfrEUUQP0ywK0KZtJQvLfDkA0JsB4ppMCgZHpnsc9vX4jXG4yaHwrhUYhJ9J7V5ysrA+PoUcsAn+OYV96s2kzxNNXCN28xmER8P6tJO+GP6frn+MuRF49m4OsCVmzORaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787729001; c=relaxed/simple;
	bh=06Hkz8ZM9DD5KKjIquavD+wryvYHLo+7oSJJmkYdrmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrDn01sMjLGGdJuBZWAO1fTguj7ZL/Bo7UUEpzES9MTbs72+gKQp9LZwT3Y9LQPZA9HN8CxIW95HoPu5iAYXkdHqhfZzWP5lCFXN2fz1/gZCHDXVuppxXxT2ge9dHWvaD/d7sfTut2E+JbBVvwdjPadT1qMlzX2HGTXNnuFrGPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bm1t1u1q; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bm1t1u1q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787728999; x=1819264999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=06Hkz8ZM9DD5KKjIquavD+wryvYHLo+7oSJJmkYdrmk=;
  b=Bm1t1u1qJex7eXJDzd836EFmJrlDdty4fn7se4hfAqLwnbLhzmHD8s0v
   Z0XT/H4kmEeeWSgHYWeCTqIN+Rq6wcpek4PGnr8TdyzUYwzvSmydBUCsf
   ai8j6LBwQEO4mTHLO5tVPH/S8AaIxEMBhFnHiwuCGl83dndwHmReyHKMM
   QdbHwxxmsbDUNlYMtDnD6a2TcDMagMbdoczGM9J57qay5rTI7npsaU/Tm
   lSvNEHKCBOB4JYHTHL8bgE4m9VDM8dUCj/E8WsAHj2iRFHKldxzuW3vt+
   I6OTQN5pkGzD9ejD1B2lueBTINbFsGFvlclTXOLQqELnS05Nf14a+xPS9
   Q==;
X-CSE-ConnectionGUID: vGvF/UU9SnG4zDa979G/dA==
X-CSE-MsgGUID: GXg7NBc4QF+7RwdOxJFh8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="99364065"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="99364065"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 00:23:19 -0700
X-CSE-ConnectionGUID: btMtcuYsTsefNQhEZOLVEg==
X-CSE-MsgGUID: PZtXuhvYQTq2aHzqPG1OZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="271704479"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 00:23:16 -0700
Date: Wed, 26 Aug 2026 10:23:13 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ade9000: fix NULL pointer dereference in
 clkout registration
Message-ID: <ao6UYYBFrpxJmY27@ashevche-desk.local>
References: <20260824125210.1644319-1-lilinmao@kylinos.cn>
 <aoxecT3hNa-M3UMn@ashevche-desk.local>
 <d8d17463-cde2-47a0-9e18-ffa5d8cab52b@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8d17463-cde2-47a0-9e18-ffa5d8cab52b@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 26, 2026 at 10:24:18AM +0800, Linmao Li wrote:
> 
> 在 2026/8/24 23:08, Andy Shevchenko 写道:
> > On Mon, Aug 24, 2026 at 08:52:10PM +0800, Linmao Li wrote:
> > > ade9000_setup_clkout() passes NULL as the register address when
> > > registering a divider clock. During clock registration, the common
> > > clock framework calls clk_divider_recalc_rate(), which dereferences
> > > the address through readl(). As a result, probing an ADE9000 configured
> > > as a clock provider with an external input clock crashes.
> > > 
> > > CLKOUT passes CLKIN through without changing its rate. Register it as
> > > a 1:1 fixed-factor clock, which does not require register access.
> > Do you have HW to test? What will be the result for the internal clock case?
> No, unfortunately I do not have access to the hardware, so this is
> based on code inspection only.
> 
> For the crystal oscillator case, the device tree does not provide a
> clocks property. devm_clk_get_optional_enabled() therefore returns
> NULL, and ade9000_setup_clkout() returns here:
> 
>         if (!device_property_present(dev, "#clock-cells") || !st->clkin)
>                 return 0;
> 
> No clock provider is registered in that case. This behavior is
> unchanged by the patch. The modified registration path is reached only
> when an external input clock is present and the device is configured as
> a clock provider.

Then add a sentence to summarise this, something like "this change doesn't
affect the configuration with the internal clock".

-- 
With Best Regards,
Andy Shevchenko


