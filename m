Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9847C501F25;
	Mon, 28 Sep 2026 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632826; cv=none; b=JwkbvAyCBCXlFA52syGsw8Zy2soygV7v4haRZSLMCrBJBmHP6ot95BoGqQYzTrt3/kmtwTGOeom3R6Qul/dcLeHEeWgU7SxVfqe1wOY5PlEvbUEa+rMUeCMZ1fbd8rQVU2pva2RVRj2KJwseWqRwK7uwzKEF6xNsHWl6Xn6aJmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632826; c=relaxed/simple;
	bh=K9XlFS4J6y/PtmY6TbyiigJXdolXvKGTVPHmmaPtbgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBhKCjWTWleHLJUiPqjGF6sELBsEOQepNl1oZAUSWkIMFo68LtmYQb+fxnu2KDo2sodIPqli2gc7HwE/p+9HoH0bSFNiG4HqbS+ABRDhfgMtH5xtkAW2sOwO78o2+AVxkY3y+zY490EOhJk0vT9APs7Ytnvvx7PcOzpAejPcTRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OfaFa4XC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OfaFa4XC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790632826; x=1822168826;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K9XlFS4J6y/PtmY6TbyiigJXdolXvKGTVPHmmaPtbgY=;
  b=OfaFa4XCkL8qq7FVKtLysk9cg/Iph3j7o3mzPGyZLQ00EScdqPSCeYq/
   9TGKTUILCB5dQMUACPMPPV+54rvgmkbY4nEPu/UUiNoKTdRi24a1VaF6x
   Hamr7tmnEJTgTKcmkfb1GWni/5av5+iZbE7BamxXzcW2BGN48zqV/ofpV
   NrqX3SIm8YzMvOZVDa7Px1XdE17a4yaWwgPaEpPLHF2Cu3L9GKbRtVLXM
   T++y2nqVDrKDnZYAbh4rUXfeBASRFMX+KX3pqTXGD4QmCkEPI5amFXgr8
   1qytQeacCAA7vsSCb9JzkIPvs3ej9TgaN36X5HwbfU6Aasn83yyvbIa4J
   g==;
X-CSE-ConnectionGUID: skB12RO4TDKc4tr3s6wVyg==
X-CSE-MsgGUID: VV1wadh/QMi3Yu5uJR1PFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90562903"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="90562903"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 15:00:25 -0700
X-CSE-ConnectionGUID: +uZWIVohRXKEDl3quPKwYQ==
X-CSE-MsgGUID: MxMa+K4NRUy/O6CtBNCvzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="274710965"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.42])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 15:00:23 -0700
Date: Tue, 29 Sep 2026 01:00:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: dps310: fix overflow in pressure
 compensation
Message-ID: <arrjdFUA3iVa0TVB@ashevche-desk.local>
References: <20260928101803.547005-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928101803.547005-1-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 28, 2026 at 01:18:03PM +0300, Rupesh Majhi wrote:
> p^3 * c30 and t * p^2 * c21 overflow s64 at most oversampling ratios,
> and pressure comes out about 150 Pa low on a DPS310 here.
> 
> Use Horner form, dividing by scale factor at each step. Overflow then
> needs a raw value far outside sensor range and returns -ERANGE.
> 
> Checked against datasheet formula at all eight ratios.

...

> +/* Fixed point one for the compensation fractions */
> +#define DPS310_CALC_ONE		((s64)BIT_ULL(20))

What's the point in having _ULL in this case?

...

> -	*val = (int)min_t(s64, pressure, INT_MAX);
> +	*val = min_t(s64, pressure, INT_MAX);

Avoid using min_t(). It's prone to errors that will be hard to debug.

-- 
With Best Regards,
Andy Shevchenko


