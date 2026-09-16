Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B693A16BC;
	Wed, 16 Sep 2026 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572383; cv=none; b=dp8lgrAgF24c2uDoLLMWBTbw8Cuja6mpbHwFv1oEEF89vaGTiV4SMmXi2UKOstq5hofkGCY9P2RCNlYsqEz1/fchb45Yf8+NZuTUUGGNPa9F3KHF+HMRfmaCKnJ1fIFGM7wJ0X+QMAyOT7Nj5wR3Z/Mbb3foWa286uBMJfzKgwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572383; c=relaxed/simple;
	bh=P/3kVvl/+MVGXlLV6b5BiQ4YrijCIDMiEz8CHu3rQME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTkUdc90MZ3KG/HzQrrgx8eop+dHLtWbMt/BLGKZJXQx6QEYqep/O0hbxeEqoaVFoOPEkKAn6CPk1iZFEwXKpApIcUszFoMHxe1Tr3FGH1l8cyLGR7IEF0Cguo9p0KNEiGUzRaMyD2S3K8ZUyRip4nxorPrqxzjqVH14nln6jpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FLasjkSE; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FLasjkSE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789572380; x=1821108380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P/3kVvl/+MVGXlLV6b5BiQ4YrijCIDMiEz8CHu3rQME=;
  b=FLasjkSEP6TLHNR5SsXejpR7BQbANYYxY6A8/+7fCI9cKy9DmAD6rh4a
   O27th1wNUJGk1RYSXZXQRi4T1lt+wUqB5jVnch30yGpApU+Z6oeh4eelT
   2HSDvvFTmD1iE4tup8WVKsOB/8z7vgPyO09QTS4cFtThbBjhqc9hzP6E0
   fp/TUq/+EwdroZQ0CRYhgl4iRxkjCHZgN2l3kcUstre1pKuJLxF2HvmBM
   DbUwvP2gAx2kvUmlXQRJNxZsMiTYc1ylYVb54SKtBl6fM8XmL9fPboZKY
   SzQE/MI2oCrzruXpVCNdfJ0jm4uVb3tbLkeBF9ps1QFG30fAAVFaISxPM
   A==;
X-CSE-ConnectionGUID: BaTgzQydRGaRqsGs3P04mQ==
X-CSE-MsgGUID: aB2D2ww8SICSimDN1GMTPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93654490"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93654490"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 08:26:13 -0700
X-CSE-ConnectionGUID: yyUv/mjSTFKCoKjg95Tg+w==
X-CSE-MsgGUID: +qMTG9wpTgerNpODGfYsyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269667368"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.145])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 08:26:09 -0700
Date: Wed, 16 Sep 2026 18:26:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	sashiko-bot@kernel.org, stable@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v6 00/11] Refactor Microchip MCP47FEB02 I2C driver in
 separate modules to add support for MCP48FEB02 SPI driver
Message-ID: <aqq1Dxeu7njVPI6R@ashevche-desk.local>
References: <20260916-mcp47feb02_refactor-v6-0-285464651f89@microchip.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-mcp47feb02_refactor-v6-0-285464651f89@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 05:16:26PM +0300, Ariana Lazar wrote:
> Refactor I2C driver implementation into separate modules in order to add
> support for SPI MCP48FxBy1/2/4/8 DAC family on top of the I2C
> implementation. The I2C and SPI devices have the same memory map and
> supported functionalities.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
> Changes in v6:
> - use field_get() in Gain, Vref and Power-Down registers channel formulas
> - rebase from 7.2 to 7.3-rc1
> - add fixes tags and Cc stable in the commit messages
> - add numeric constants in front of time defines for better readability
> - replaced dev_err() with dev_warn_probe() for missing label
> - if match data is not found at probe, return -ENODATA and a suitable
>     error message
> - Link to v5: https://lore.kernel.org/r/20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com

My main comment against this version is the usage of Reported-by + Closes +
Fixes versus Suggested-by. Note, some of the changes doesn't look like a fix,
such as a typo in the comment, I dunno if Reported + Closes (no Fixes) is
legitimate approach there.

-- 
With Best Regards,
Andy Shevchenko


