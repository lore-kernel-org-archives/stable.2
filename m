Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6241D470E8C;
	Fri,  2 Oct 2026 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790933166; cv=none; b=eVJOCTUH2Q9fTOEG3ss969kozpCWpVjXegB/7YudhSfCjHzby7dxnJpaiFIdYm//0Qn2D6v2uKxsCFKD/hwO8qKQI6gtjCjTtLowbDXWOMeUsXNlyD1ZOoC8uxqJ6ANy9FNiolVsrakO8MMsjoseCtOkKH6VaiuFYa6ywoDXMis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790933166; c=relaxed/simple;
	bh=cpOoc8HlZ3e2s+YZ6TdqKW93Dns2IJrqALwipRqPtPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7N/Y5Ovs9BkegK1AgnDXpItaLZC/70WGkbqQ7Yf672Q/I/Uu5B4bEv4RaxkTyJ11RpPr7tjzOicyvciKyB1U2WpxiFF7NLL/GcFI+F1rAtciTthIfi0ioKkc+sJBj/icoQ7ZZsCCSSasdHBw6FdzekOlENRmwY7bNet15JRBGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W2H9gbgd; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2H9gbgd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790933164; x=1822469164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cpOoc8HlZ3e2s+YZ6TdqKW93Dns2IJrqALwipRqPtPE=;
  b=W2H9gbgdFQyeJJa6lcsIyz8BB9SxU8M7yiSVYKKa8mUr8zwdOLfDrYmk
   dZ0L9jb1RhuH6Vvuz+4WZBQWNpFXGclwHDOoH22C1zeROc9voPoPpJXRA
   bGhy1B6DEWwUc7qcgmsBRp/y8o/9yjtHhWIB1IqE+P8gpP/zhqU8+/Zq7
   Na2ciszFEhIGTN4RJ4Sd6GCHi0kFMynNi9wVYhywFlS+iQr7EknIMc827
   gh8CnFVHHrD8ZDwPM2aelYwDuz3l8vzKjaXvHcyOgQZCQEwQi6Tzp64Wl
   sOB6KbzRLCWb8+cGRWmK7Cjp/2A6BQ+vodc9q1E5XXU6e4AUq/3NWvIt3
   A==;
X-CSE-ConnectionGUID: V56qQiB7RJ+aXHE88KBUgw==
X-CSE-MsgGUID: tIypn9XSQ0qm7BweQ1geTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90599394"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90599394"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 02:26:03 -0700
X-CSE-ConnectionGUID: ek2Qu9S4QuW+t5wyiK8Oxw==
X-CSE-MsgGUID: Q/uArPbXQuGDlQfIGLVX4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="314199592"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 02:25:57 -0700
Date: Fri, 2 Oct 2026 12:25:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3] iio: pressure: dps310: fix overflow in pressure
 compensation
Message-ID: <ar94oiBYQI8WhOBr@ashevche-desk.local>
References: <20261001121616.109973-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001121616.109973-1-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 01, 2026 at 03:16:16PM +0300, Rupesh Majhi wrote:
> p^3 * c30 and t * p^2 * c21 overflow s64 at most oversampling ratios,
> and pressure comes out about 150 Pa low on a DPS310 here.
> 
> Use Horner form, dividing by scale factor at each step. Overflow then
> needs a raw value far outside sensor range and returns -ERANGE.
> 
> Checked against datasheet formula at all eight ratios.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +	/* Section 4.9.1 of the DPS310 spec, Horner form to avoid overflow */
> +	if (!dps310_horner_step(&prs, data->c30, p, kp) ||
> +	    !dps310_horner_step(&prs, data->c20, p, kp) ||
> +	    !dps310_horner_step(&prs, data->c10, p, kp) ||
> +	    !dps310_horner_step(&tmp, data->c21, p, kp) ||
> +	    !dps310_horner_step(&tmp, data->c11, p, kp) ||
> +	    !dps310_horner_step(&tmp, data->c01, t, kt))
> +		return -ERANGE;

Sorry for nit-picking, but since the above checks for overflow, perhaps makes
sense to use actually -EOVERFLOW here.

> -	pressure += div_s64(rem, 1000000000LL);
> -	if (pressure < 0LL)
> +	pressure = data->c00 + div64_s64(prs + tmp, DPS310_CALC_ONE);
> +	if (pressure < 0)
>  		return -ERANGE;

-- 
With Best Regards,
Andy Shevchenko


