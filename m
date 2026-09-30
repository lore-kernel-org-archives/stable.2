Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5782846D2DC;
	Wed, 30 Sep 2026 10:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764090; cv=none; b=MZG6tBk04qS9sWh4hnEVJIPaACNKeKk+HqXnGPZAvMuD18CnKBVcKUmqGje6K3uYzOU6l3+h8TPCuGY6RLm0CiTOjOHkM4KWpUrkArj4VIgzhkQNXSfhR4TFnaP0QaBy5A0EZA7+4HBsxh7O2KdycR4tY7dghigV9TkEPJ+Pm/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764090; c=relaxed/simple;
	bh=QzBr22SqRA5DDIJSL0NN84Cg7nw4qqZbNDCKHoG1P6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDoDcmA7xNBwZ92gZB30HBOhHinZYtXqFCggGWBlaooQU+TYtuSK51dWT60apwZlUPN8WIBBtCQc/d6vFyXBFGoqoln0t2XVsB/EXZDJNt3WnOQGKQqmQbvW+5qOk/pjznY0aLqDMzftE71pGjM0ExND8GA4+MBAKFMyv6o/SuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DXBnNtLo; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DXBnNtLo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790764086; x=1822300086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QzBr22SqRA5DDIJSL0NN84Cg7nw4qqZbNDCKHoG1P6c=;
  b=DXBnNtLoqSL7jmmjec5BTAFrZuJa18FZKrIZEL+5I4VWFQOF+FIYUS7+
   GRl59gP8bPSsKVaNEO2QMWueUTuZXxZu8s8ZmEkTSOAq4LGKzRW5s/rBj
   59jJor8dD2a9b94jSkPygCKnwqUumKQUOC4+z+NBoZS4Ho3oFQcMg7qK9
   FWYLnDZ6sz5beIH0OUdaNgj9tUHmYXL6/jZ1DV7+TcpAmtW0A1s8PEf6W
   Oc3Z0hO+Ho4+8yWg+pNa4FdIiBD4cQ/ZLaZ09KMHaXifZ3600ICHXtFeA
   U1op3Oce10Uni+kP4dY7YWQN8VcGiX9RSIr1gMs1SPFzE38RMiq6VeSRY
   w==;
X-CSE-ConnectionGUID: UT8xwwRbSqq+ee0x3bM7tA==
X-CSE-MsgGUID: rtdH78HkTR+Rrt/j7dKj1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102069339"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="102069339"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 03:28:04 -0700
X-CSE-ConnectionGUID: se4Cym3uTve6cN36bclJ9w==
X-CSE-MsgGUID: u7aexdifRp2OySrLcw3GVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="274846216"
Received: from spandruv-desk1.amr.corp.intel.com (HELO localhost) ([10.245.245.137])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 03:28:01 -0700
Date: Wed, 30 Sep 2026 13:27:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: pressure: dps310: fix overflow in pressure
 compensation
Message-ID: <arzkLlzYkZ3Q6fah@ashevche-desk.local>
References: <20260930085819.886339-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930085819.886339-1-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 30, 2026 at 11:58:19AM +0300, Rupesh Majhi wrote:
> p^3 * c30 and t * p^2 * c21 overflow s64 at most oversampling ratios,
> and pressure comes out about 150 Pa low on a DPS310 here.
> 
> Use Horner form, dividing by scale factor at each step. Overflow then
> needs a raw value far outside sensor range and returns -ERANGE.
> 
> Checked against datasheet formula at all eight ratios.

...

> -	*val = (int)min_t(s64, pressure, INT_MAX);
> +	*val = min(pressure, INT_MAX);

So, in the original form the new one doesn't seem to change behaviour.
With this being said, I think this part should be split to a separate
(non-fix) change.

-- 
With Best Regards,
Andy Shevchenko


