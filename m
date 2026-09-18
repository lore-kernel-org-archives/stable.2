Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5642418A29;
	Fri, 18 Sep 2026 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725181; cv=none; b=ViTZyZoOEtYKIzNnCbBX37JVkbCZSHc9hAUJfhhlMytF0l8GC/BWSeNSXGdcake7K7sZYRaQ+DJUz8CTbqEQY2XUap8xV75OJmct85R36Mpvx8yAPKto2v2BEUxfgp1nRrio4sZqc8MtLRy0VXxRN2MJz18k7IQ8AWlsxLiqVYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725181; c=relaxed/simple;
	bh=rwq4Ul/REmuMGoa5ZUeyF4tn5EsdqaXf0ExdF6sYWaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjpF9g+PCC/8o5/WgUT05T7Y1xydm44so+f3N0JYUmw3nXc+r0AAzBc0NS06qBkmGMeIF6oUVPhiMSYRXFn+wIpR507dZriIW3FogsRNZvs0emQUyeKnoXfZWui+fnukgjhiYvRp6zNG0S4diDvNCy6qkgi4d/58aj2hevXwPP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YKb6AUl4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YKb6AUl4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789725179; x=1821261179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rwq4Ul/REmuMGoa5ZUeyF4tn5EsdqaXf0ExdF6sYWaU=;
  b=YKb6AUl4FEtx6jtakS5uCgM3ObAVi4NUa+VgLA+FKhpiHws2UC/TSvuv
   ke5GB5S5znx2DxxDQyLcEJDMw3Seybs1gy2pkKHZXg3GyH1a9wrYVgs3G
   rmvv7dqH8XdeQMCqO3+XO0Mg1GC6X47jFYF3VkQkOxRGTJpEypGdyXNru
   vRrFzSJBo5lqLuVEkD/ySU5ICw9AbG0wXcPZOR+Mv54M1asNpiXHtdwjs
   /m5X6jAhaTPXDubUkna8DfYWZdYFiiVLI2i8MMqSXqT+MtTpo38tKP0yR
   5W4PrtR90aCrZlvlLsVHkXHNs3oEPVpVVMcaqRbbBEPHHtUzjgcILxN3F
   A==;
X-CSE-ConnectionGUID: n8QkvvSNRHa4YiA3rP5CMg==
X-CSE-MsgGUID: U9JVOHifTHO7wX2KnXrhAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90351320"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90351320"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:52:58 -0700
X-CSE-ConnectionGUID: u48c0T0hQIG38KRtmRdXjA==
X-CSE-MsgGUID: ym6KSDOuTsOTxxXmnIGV2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="276290347"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.170])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:52:55 -0700
Date: Fri, 18 Sep 2026 12:52:53 +0300
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
Subject: Re: [PATCH v7 00/11] Refactor Microchip MCP47FEB02 I2C driver in
 separate modules to add support for MCP48FEB02 SPI driver
Message-ID: <aq0J9Vs1_rUAlcoA@ashevche-desk.local>
References: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 18, 2026 at 12:06:26PM +0300, Ariana Lazar wrote:
> Refactor I2C driver implementation into separate modules in order to add
> support for SPI MCP48FxBy1/2/4/8 DAC family on top of the I2C
> implementation. The I2C and SPI devices have the same memory map and
> supported functionalities.

Jonathan, can you pick up the fixes from the series, please?
It will reduce a burden a lot (yeah, I know that it might mess with
Sashiko, but wouldn't simple delay fix this, I mean to give Sashiko
a time it needs and then update the branch?).

-- 
With Best Regards,
Andy Shevchenko


