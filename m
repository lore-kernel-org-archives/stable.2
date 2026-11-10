Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305202;
	b=nr6YiqvFnSHHTW2M3ZoCgI3e2CBtyMGW9tJ4jviInuhuiJOyGGtA/3Y632A5u/p0JP/F
	 gM0esJM0jzYp+/tOjYL1dSqG9e/zkW4KeXLV4O/ywf/4j4mEaDyUWnfM2LARSy/mcqxMm
	 JlnUZObEkS5LRFqaMvcviBTcr3QZCMBSCEsOvEuvKKFu8xs663I1AU76wRcRRlmE7OxCL
	 fq8f5TJlLagddSv1QET1XWbIOBFIwPWh+Nh3kakSVC2rwUNffcmeQbLGcIcuZgVT1H20l
	 NAdK8l/FFffFDqKrXVoDUpLP/EyqLCtcyqVa18fnustI1zP/aKJSgd2Qe4ZOL0Cm3IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305202;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=0+56BmH46cTzz6cgAVlQ2fzvLFOPeYUgDkfm7Fk/6qk=;
	b=ab0fGi/HZwL0ez8goGZB6AnORqjRMZIRCHiCw67Tdtffjpty+UaCxan3qmH5puIc86vP
	 O5nNe4egTFASf95ub9PLnvXBDRj2oXRI7t8ba7owYQF6eyg7ENL+g8XSPQ8y6v+ktHms6
	 UcJFLM0FokV+uTEcr6kfYeGecM2GnZoAYAJZov1W/2OcF5TD3zPL2shr/HepaYEYMNkRA
	 fRnsqjAh1dB7lthNZIKyVYBxlKqO2h+Jk85mZHHwuetc/XAsghgt7uGkQBCYXNQ9v4bQv
	 rK3GtFgnNRMan4iOiKRCwLJ/I4DBt512RhAB+gnNjhMl8IJNhArZbMl/uo1RJEWZ3Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="NwD/ThYC";
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614BA606A325;
	Tue, 10 Nov 2026 10:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 614BA606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NwD/ThYC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794305202; x=1825841202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hPyoBw1zcnjyYyX+GWkyUwYoq6TCM3E4M22B/6C4Ed4=;
  b=NwD/ThYCEmBc5Zs9ar2Vq4hl1pxmD9AtOj8iHNcSBYeqGyymZwsueUnv
   sNSqeeb4lmwJD8AIXBLrPBoYiLKOIlY+rrdgKpPT5/rrL0xDWkZle/iQk
   JomEF1lpWh4Cbp7/wHMf4lWz/jCgrfwZMagWoIK7cfB7U3YT38ANd28ns
   HkbloCcfBfkD/wwvnzsZrKxrm4j6Ir1As+CVDAJ9rBoUhDSrfbPNq0NvC
   F7Zqu5DwrOcjhnX9sB63I+Lj9FlAGl8hoFr7UcPmGF6vJNbC+sD+Ww74u
   uRyr8ibPP7RAtoCgRnneqObYev/8kDpKQ5dIVGAtkaagp5n3fWFgxqjZ+
   g==;
X-CSE-ConnectionGUID: zux3HgRHRHKvhopm6dRszg==
X-CSE-MsgGUID: BLM4AXdHR1ql4J4jvRhfLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3035498"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3035498"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 02:06:41 -0800
X-CSE-ConnectionGUID: lHQLPFhaT8WI8G9crvQsXw==
X-CSE-MsgGUID: eiwTZ/71QaS3vGs1UpQTTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="7944534"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 02:06:38 -0800
Date: Tue, 10 Nov 2026 12:06:36 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Kent Gibson <warthog618@gmail.com>,
	Adrian Ambrozewicz <aambrozewicz@nvidia.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 4/5] gpiolib: don't overwrite the entire flags field
 in gpiod_free_commit()
Message-ID: <avLsrOqdXSFSH6WM@ashevche-desk.local>
References: <20261109-gpio-desc-flags-atomic-v2-0-c4c54b476628@oss.qualcomm.com>
 <20261109-gpio-desc-flags-atomic-v2-4-c4c54b476628@oss.qualcomm.com>
 <avJAv_3ACjvyc9VU@ashevche-desk.local>
 <gw26q2blrbmmxwzv7vfjxwc5bzqzfgt57zs7bvt2kdx7x6a6qk@6i5z3a3crqft>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gw26q2blrbmmxwzv7vfjxwc5bzqzfgt57zs7bvt2kdx7x6a6qk@6i5z3a3crqft>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 09:54:11AM +0100, Bartosz Golaszewski wrote:
> On Mon, Nov 09, 2026 at 11:53:03PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 09, 2026 at 11:27:08AM +0100, Bartosz Golaszewski wrote:

...

> > >  #include <linux/acpi.h>
> > >  #include <linux/array_size.h>
> > >  #include <linux/bitmap.h>
> > > +#include <linux/bitops.h>
> > >  #include <linux/cleanup.h>
> > >  #include <linux/compat.h>
> > >  #include <linux/debugfs.h>
> > 
> > No need, bitmap API implies all bitops.
> 
> I honestly have no idea what the policy is on "proxy" headers. In some
> cases people advise against them, in others they say to include them.
> 
> Is this documented anywhere?

No, but feel free to start such a documentation. In IIO we did a huge work
to enforce IWYU principle, and there we have some tribe knowledge about
the dependencies and guarantees. (Cc'ed some people.) In this case the
bitops.h inclusion is guaranteed by bitmap.h. If it stops doing like this
it will be a flag day.

-- 
With Best Regards,
Andy Shevchenko


