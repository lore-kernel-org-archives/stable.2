Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3405053FD3C;
	Wed, 16 Sep 2026 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569742; cv=none; b=EvuhroK2FgwToBZjWw0kaHCJOqfHkTustEuHQ0l9P0j6GXXzlcAzKOAkxB3nKu5T1zZ25IftFo7Dtzyqm685Xoh3kV/pvrJE14nWaePIpeJNn0bQPw+n3OTR3AaD7VlxN93MVxoRbda9hm26kMDIYtmjMrIdckOH0+ykOyRpzEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569742; c=relaxed/simple;
	bh=cbIbcN2NjFJuDqfTD/XK1wViyDpDBpXaPgRkFuFpLJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqWoZjsUw/6s5A1Ar2PASb7Ro7K/t78oO789ZF9cjSCoQnfPCSiuVlzzsbeK3SkFT0Vj64TbgPgSL/4EWt7dOj1kJxEe+FSI8toGOy/x3a6GoAh1EKRjiUxJBoj40MsMY8bWBJnXPNZtbQxfTrt26zvg2wNshrTLDgnsR20kV50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UKID+2rj; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UKID+2rj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789569739; x=1821105739;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cbIbcN2NjFJuDqfTD/XK1wViyDpDBpXaPgRkFuFpLJU=;
  b=UKID+2rjy7lsG5jJnM0hcCA0TnucUcjF3I1hF9OiHwpLWKQF0P0hRBXh
   8+VHw6UJ2laZjsgqKLFE00j/laLe4aWATG3LOKfya6ktWwzycBQiwe7/0
   30/GKaUDzD1DRXvfYhfy9uhxwTyDAfqXfhoKTUkfgJA7WpNJ/gg+Kpz9o
   yR4Ld5nNLsMWbaidQJwdvvwifEyvPuClOWg5U17vIfPRhsG/nOk8/F2NH
   irN7942iDCe3cUZghlZDXjiAIIilggt7jevnnrfwv3BDX8EE4V+yk1Cb7
   G8o+SMyOUWDkoc5/gbThEIQtpd8/4NJbO0+3SswsckrIx4+cvTBmUoPEk
   w==;
X-CSE-ConnectionGUID: P6snf/oKSHaCuatY4dpnrQ==
X-CSE-MsgGUID: 9Rzo2gCaSp+Ur6dOEZsuHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93772594"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93772594"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 07:42:18 -0700
X-CSE-ConnectionGUID: KQrFpFo2QC+AYMHhteg1DA==
X-CSE-MsgGUID: ZrzcNjOASNGVSByuCdYPoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="271905206"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.145])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 07:42:15 -0700
Date: Wed, 16 Sep 2026 17:42:12 +0300
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
Subject: Re: [PATCH v2] iio: adc: stm32-adc: fix check on internal channel
 availability
Message-ID: <aqqqxMakUVzXM9te@ashevche-desk.local>
References: <20260916-adc-fix-intchan-v1-v2-1-ef70baecd082@foss.st.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-adc-fix-intchan-v1-v2-1-ef70baecd082@foss.st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 04:13:23PM +0200, Fabrice Gasnier wrote:
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
> Fix this by returning before a valid int_ch is assigned. Choice is
> made to keep current driver behavior to warn about the channel name.
> 
> Fixes: cf0fb80ae167 ("iio: adc: stm32-adc: add stm32mp13 support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/all/20260911162602.D323F1F000FF@smtp.kernel.org/

Closes: ^^^

> Cc: stable@vger.kernel.org
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> Changes in v2:
> - Review comments from Andy: use bool flag closer to the channel
>   availabilty checks. Add a default case.
> - Link to v1: https://patch.msgid.link/20260915-adc-fix-intchan-v1-v1-1-761a1b35001b@foss.st.com

With the above amendment,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


