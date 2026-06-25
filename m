Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A983603DD;
	Thu, 25 Jun 2026 06:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782370060; cv=none; b=nY3wDHmUg0bpqAbCBwiUP0jTopWshRRrZgk8hkZdMqbo4+2Ukg2Gr6JH7eL1wsDQKHNe5Ck9x9TeO7OyQpUP9Rt1G+61N9yY1nA9tFrt7VNEf2zUd1PgTHXLxFUTicN7k+tfdDpw7qZOYhuC62QQCQL1ZVzhC92s3+b/CAB1csI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782370060; c=relaxed/simple;
	bh=sT9AUDXoZXbX/LvG9aBlSZtQT/tVz9SWQAsVaALAx/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfxtHqdQKKOCb0UqVUVD9X/eBDn2dNPlNfITGzOzScaaXHIMBhR2X8yugDh1CS3pP2Jcv1to1EVePvwcmqW4oJTuqkV7zMmJQvucFKZ1iQFQ/9i4DkXY+Ikkgwk3lqEIlazK4d5d215TwemjW0DXsb6x3gmE5bkOYGXD9iNyIBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TKVl0U5O; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TKVl0U5O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782370059; x=1813906059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sT9AUDXoZXbX/LvG9aBlSZtQT/tVz9SWQAsVaALAx/M=;
  b=TKVl0U5OCaT5YIZPs7M4eR30UOn+E+azOEZBLvIX9wPXSfl6G+QKa+NQ
   PerQnKcVzy1cWwT6ci5p5yef7PzLkpsdNslQO0Vo9Oxc2PF9aDdMy6GEv
   MjjzNkjI9s57GdSwdNGGqlOjaxsm6eepHNOAYLgEIKwWFHlK8pKpfZonH
   w7FwGMBdIUEzWcE+vWPP+faqQmR/eDchp9JgMcED3GRwecvTxIP5M6F/I
   EOnayedpyL9AO2sxBWRfS3K5S9sZb+3ebm7S6mNQZNSgTEDlTHMLoJ+7K
   qgNCh31GGDj1MMZFbh09A+exZeFk8HRCcMiC2PFHWicI77HVlpoNe2r2s
   Q==;
X-CSE-ConnectionGUID: h/p+LoQARSu4ZTc8MuAD3A==
X-CSE-MsgGUID: gyWrQK7JRXqP3dOMYWrjlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="86984527"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="86984527"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:47:38 -0700
X-CSE-ConnectionGUID: yaQvzyw6TUuiU7wJ/u5+1A==
X-CSE-MsgGUID: Syi74KuIQ7eWr92JMXlltQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="247928173"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:47:35 -0700
Date: Thu, 25 Jun 2026 09:47:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Dan Murphy <dmurphy@ti.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v2] iio: adc: ti-ads124s08: Return reset GPIO lookup
 errors
Message-ID: <ajzPBWPKTra82lb_@ashevche-desk.local>
References: <20260624055325.32388-1-pengpeng@iscas.ac.cn>
 <20260625054407.82228-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625054407.82228-1-pengpeng@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 25, 2026 at 01:44:07PM +0800, Pengpeng Hou wrote:
> devm_gpiod_get_optional() returns NULL when the optional GPIO is absent,
> but returns an ERR_PTR when the GPIO provider lookup fails, including
> probe deferral.
> 
> Probe currently logs the ERR_PTR case as if the reset GPIO were simply
> absent and keeps the error pointer in reset_gpio. Later ads124s_reset()
> treats any non-NULL reset_gpio as a valid descriptor and passes it to
> gpiod_set_value_cansleep().

The GPIOLIB code will print an error message each time that's called.
This might flood the logs with a noise.

> Return the lookup error instead of retaining the ERR_PTR.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

It's good as a fix for backport, but can you consider switching to use reset
framework and reset-gpio driver instead? (As a separate change on top of this
one.)

-- 
With Best Regards,
Andy Shevchenko


