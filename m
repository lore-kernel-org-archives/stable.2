Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C49C3C09FE;
	Wed,  8 Jul 2026 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508147; cv=none; b=m2uxcJlDgR8gfUagzXW9rRM6rSa03wb/42v47s3v4Uc1F5OKKafFUsmhoT4+W4QNNhB9Fty/KPA8brMXYHdpT2tEQm5Fr7p+RbNjNNq6WnNjEu0g13jE46WItofeI3TtDsqUM5PZHtV2qc5hYd1140K3Hgh9QL6WPERBHqzwSVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508147; c=relaxed/simple;
	bh=aMBco8sdazwnk4KPza4ON2ECyBlRQLZFTYPb2ZivFZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwxBwHFZSLrjltWTh67PMMKSoyc3z8wfn8ziD2sQHQPwzPHdjjmNi1qsT3BETp9O/OBmHrRKYi+YdENWFi57alvt1ul7PDZTdfdRzuDm1jPhmjWlAmyZOH4zBS7P4vY2kfGMhDXAcAz0kPrteJEDfyiC+gkmLkUVvbal4cfBFR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/ULR2K9; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/ULR2K9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783508144; x=1815044144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aMBco8sdazwnk4KPza4ON2ECyBlRQLZFTYPb2ZivFZ4=;
  b=l/ULR2K9V5cg80EGsv+VJG5NkMeMFA9R+Rcybtbid0QxQADdDIh2/pel
   ndYmvok7CACKIF1RmbhyX2dudkiKO7dHpbEDtDFs/QjVIFloUESGmTZ1E
   MLYSfiENu9hyVjyQC/LFHvXjEZjYDZEtOap6pFdXiFZteFUVrJALgMZrH
   NLdk7QRSrbYySDJ+Bho+bqytaUb4av7mrixjz+OTmnmARxY3Hgmo10II9
   kiEUETxhdJHCfbzUvTLCSTdTqUizttu/JUrGpurWHrNLDt/Pgb8Gp9p16
   bAmSoMbhGE3AuXsKWI9UkvabHIS4xlRvntzVRKo7NtZwBORwLe46WmIIO
   w==;
X-CSE-ConnectionGUID: 6cEqEDoyT2GMxTPfe3afBg==
X-CSE-MsgGUID: t+p0s9ZMQ5ytPYgR6V2Lrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="83945310"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="83945310"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 03:55:38 -0700
X-CSE-ConnectionGUID: 9hBYBX1QRCSFbPbMG3gVXw==
X-CSE-MsgGUID: 8KapFLm9QaO2avoRMW2bqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277469880"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 03:55:34 -0700
Date: Wed, 8 Jul 2026 13:55:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stefan Popa <stefan.popa@analog.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: adc: add missing 'select REGMAP' to Kconfig
Message-ID: <ak4so4KAztmqaUgk@ashevche-desk.local>
References: <20260708-add-missing-regmap-v1-0-6d424322e3d4@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708-add-missing-regmap-v1-0-6d424322e3d4@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 08, 2026 at 07:34:11AM +0200, Joshua Crofts wrote:
> This series adds missing `select REGMAP` and `select REGMAP_I2C` to the
> AD7380/MAX34408/MAX14001 Kconfig entries. Without these, some builds
> may result in a failure.
> 
> Steps to reproduce build failure:
> 1. Run `make allnoconfig`.
> 2. Run `make menuconfig` and select I2C/SPI, IIO and any of said drivers.
> 3. Run `make .` and make will end with regmap-related errors.

Taking into account the real build failures as pointed in the replies,
the fixes LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


