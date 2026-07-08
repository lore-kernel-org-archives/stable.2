Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AAF414DD3;
	Wed,  8 Jul 2026 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508071; cv=none; b=drDZgR/0n92Z4iY72yjupLE3TRAOqUEL88OZ5IZYJu0cITetZILkYD+Ji9iX+TytBlyJAy4B/M7o9W+QimJWKeqbUUdSVA/YfNbWmMI382LVCB4dLATtXZonkth9z8otcmoLlxDbU+7vWhqSrad3vpDE3bmoJbvwMa8JUqQ7lf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508071; c=relaxed/simple;
	bh=SVuRNhKLlSbqBXuGu/1ybUpwHQMFzrTVFepcfiVTbMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n53R6TBZbP/DZgxgCsOA/eMUL8cHjYXy8BQFQCuvMqZy12sfGH2Lu1Q67OVVevDG8EsIup3WJtHnxg5IwzQzPRq7/NtRe1SwM2Tp/TKbU6UU81Cm80o97ZkjgzH95x0LBtZoLPcq9vJzT3cIQwiYtBgABc95j2Wf1paeTfwR31w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKo0xBRV; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKo0xBRV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783508065; x=1815044065;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SVuRNhKLlSbqBXuGu/1ybUpwHQMFzrTVFepcfiVTbMY=;
  b=NKo0xBRVfY5KRHrAqkxLKLq5La592ca8AunSEiBnTrbppj3EGG0009NO
   nvpMlgTPYhijSqjMH9BuqD+wmvNLXp3BWQHADoD76Ho2T2e4OBCNkOd2W
   pjBwVeyzJeW0Jt/j5/iHkPUgOVFp57S2/J4ifEc/o8j6Vvyq1eyLhxHJ3
   1hfrDcAK0/y41nrdWldH4jkdFpbHfNEethPABbmAdb0vieDZfghRQpqKL
   eRW3hZSyeQ5UvDezvijLGbmNXWbXPu3PAB2GihgBbbJlz6dzWZ01Mk0yV
   cXnV+knwWWvhORhlw7GmxFNE79bNp771MM6ccekvLRpInLg3N0J1KoUsG
   g==;
X-CSE-ConnectionGUID: wtaCjVoyTS+/eP9gIwMg3g==
X-CSE-MsgGUID: aF1t34JySZKRSqnqojwbCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84041212"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84041212"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 03:54:16 -0700
X-CSE-ConnectionGUID: aBuQXa5DT6m4eBm3sH1V9A==
X-CSE-MsgGUID: HsWc+/BiQ+CWfvqe/u6XJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="284368836"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 03:54:13 -0700
Date: Wed, 8 Jul 2026 13:54:10 +0300
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
Message-ID: <ak4sUmR-5WJWrmdH@ashevche-desk.local>
References: <20260708-add-missing-regmap-v1-0-6d424322e3d4@gmail.com>
 <ak4ApBBYdyVNd1Al@ashevche-desk.local>
 <20260708100150.00002436@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260708100150.00002436@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 08, 2026 at 10:01:50AM +0200, Joshua Crofts wrote:
> On Wed, 8 Jul 2026 10:47:48 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Wed, Jul 08, 2026 at 07:34:11AM +0200, Joshua Crofts wrote:
> > > This series adds missing `select REGMAP` and `select REGMAP_I2C` to the
> > > AD7380/MAX34408/MAX14001 Kconfig entries. Without these, some builds
> > > may result in a failure.  
> > 
> > > Steps to reproduce build failure:
> > > 1. Run `make allnoconfig`.
> > > 2. Run `make menuconfig` and select I2C/SPI, IIO and any of said drivers.
> > > 3. Run `make .` and make will end with regmap-related errors.  
> > 
> > Repeating same mistake from the previous similar contribution. Where is the
> > actual excerpt of the failure? Please, provide one.
> > 
> 
> Here is one of the several errors when compiling.
> 
> drivers/iio/adc/max14001.c: In function ‘max14001_probe’:
> drivers/iio/adc/max14001.c:315:22: error: implicit declaration of function ‘devm_regmap_init’ [-Wimplicit-function-declaration]
>   315 |         st->regmap = devm_regmap_init(dev, NULL, st, &max14001_regmap_config);
>       |                      ^~~~~~~~~~~~~~~~
> drivers/iio/adc/max14001.c:315:20: error: assignment to ‘struct regmap *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
>   315 |         st->regmap = devm_regmap_init(dev, NULL, st, &max14001_regmap_config);
>       |                    ^
> 
> Funny how I essentially copied the cover letter from the series where I added
> missing IIO_TRIGGER_BUFFER entries to Kconfig - to which you didn't require
> an example build error :-)
> 
> Shall I do a v2 or is this reply enough?

For now this reply is enough, but in the future add it to the initial
contribution from the start.

-- 
With Best Regards,
Andy Shevchenko


