Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344563;
	b=KEaDrXXJDatlDPJJIcdo052E9FEdDCgfQ8vSpexYu63pcHCGGjXjkmvVBH9EyxGTFZLz
	 Okx49R1rAUzDwObcpSUkX1Yq7ixjt8C/KKlObSBd6gvJIxtvSzsswNxGx+CvKTtwc3lo7
	 1Fh6Ma6aBGGHcl4c12UbnlVxcAwpblfJrv1443sjs+xcplzVaEfeGISmbr+HHkSLWckaN
	 iup9SbTxyJff+M1VlxOvQIq+FGVALvQBt/9cltx+IbVt2oF0W6q9ckwNxDzIiiJylpqQ3
	 kjBxiVm/P3IlVWuzMV7nDMajAGeo3wjiBIbYJwkp87ef0hMGVMDAYsCAzh6t+SE75Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344563;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=hpKPnv6LQCf20/ZkdM8jFTGSWfWUSzTRAK+io33NZfg=;
	b=2x1vsGBCu+gPzbYdUwHlFLJslYNEYYgwL2XKIePZMcF9+eBd4ixSRZpZgcIjVTM/2x5e
	 3voxGPtOqECPiDmvJzLL/x4cFV2JDRCiwn78ql4v6v1G+AUgTKiVs6YQ8Ve51m+fNj57z
	 gZUe/W9aikPHFyMCEZ73CshPwA43AS5z0xcqZDcDGNOWLh5yqyaxVMF4eyR+3J5AQWj9E
	 8J2NHmjf2pN6W61L7WOOdRH7TCjLiwuxyc05gqbIw/EKiixCOFOmhrjgsfEaoTBd1Y57e
	 Cs4pqNhuN7IM25sLL/YmVUNZYigh06YPrOoCp4gicROeKnHiSxXYD051bqQWO4aEKzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WzGIh2AN;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB2F606A326;
	Tue, 10 Nov 2026 21:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AB2F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WzGIh2AN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794344563; x=1825880563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=63+0yrmJwzlPZjE6WYIeaX8J9iDrfSQT6kKOvmN1rCI=;
  b=WzGIh2ANPuLt0Scv5LqbZRwbLXECnYcWyrAJ9DwOEhtbN8hsNjRJi1p1
   q4MfIHetFght8zssiF4mC7KNEYJGr+Jk2FyJmttf7k6i9woMX5Kczvn3L
   4b32OjU+nY5NbB3rK9LygiURAXK9omk9rSObxw4Oy/saA95HZ/12ZbVg3
   7BuJfEtTgjOsVLLsmfzEcba8e7b87/cHpR+jxOSbyfK4MU4f7qLWat0Mu
   GDEAgmAVq6denWVVRfi1ZCWno5wNCqemmN8B4IWC6hkwfYaNENhCjRwxR
   hXngC1zUKVmPIrgD5xuN3u1HQ4MqUg5jS7tRtYTiOzDhw1D9wqkgCEyam
   Q==;
X-CSE-ConnectionGUID: 4J13QXh9QnO98zNl5HjLXQ==
X-CSE-MsgGUID: XhzOuGxST1GRwTHdotf0/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="2996545"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="2996545"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 13:02:42 -0800
X-CSE-ConnectionGUID: CU/3jIPSSwCRObP1Fv88Wg==
X-CSE-MsgGUID: hOiKvxcgTryr9vIsbA7O6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8578905"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 13:02:38 -0800
Date: Tue, 10 Nov 2026 23:02:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: lee@kernel.org, maz@kernel.org, andy@kernel.org, jic23@kernel.org,
	dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
	mfd@lists.linux.dev, linux-iio@vger.kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mfd: mxs-lradc: Pass parent IRQs to child drivers
Message-ID: <avOGbAYDCQyuzd6Q@ashevche-desk.local>
References: <20261110141934.42490-1-festevam@gmail.com>
 <20261110141934.42490-2-festevam@gmail.com>
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
In-Reply-To: <20261110141934.42490-2-festevam@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 11:19:34AM -0300, Fabio Estevam wrote:
> The MFD driver stores raw DT interrupt indices in IRQ resources but
> registers its child devices without an IRQ domain or IRQ base. The child
> drivers consequently receive the indices as if they were mapped Linux
> IRQ numbers. IRQ index 0 triggers the platform_get_irq_byname() warning:
> 
>   0 is an invalid IRQ number
> 
> The children then try to recover the indices from their resources and
> map them against the parent OF node. Besides duplicating IRQ names in
> the parent and children, this relies on invalid platform IRQ resources
> and fails when IRQ 0 is rejected.
> 
> Resolve the interrupts with platform_get_irq() in the MFD parent and
> store the mapped IRQs in the shared LRADC data. Drop the child IRQ
> resources and duplicated name arrays, and have both child drivers
> request the mapped IRQs directly. Use the MFD memory base support to
> translate a single relative memory resource shared by both cells.
> 
> Tested on an i.MX28 EVK. The mxs-lradc-ts driver probes successfully,
> touch events are reported, and the touch-detect and LRADC channel 7
> interrupt counters increase as expected.
> 
> Cc: stable@vger.kernel.org
> Suggested-by: Lee Jones <lee@kernel.org>
> Closes: https://lore.kernel.org/linux-input/CAOMZO5CgTzo6GuXptD4mFTN=UsJJqpkixDW1Q64gqZGrij8+uQ@mail.gmail.com/

He-he, this rings a bell! I have still a copy of the mbox of this thread
locally to maybe (likely never) look into that. So, I am so glad to see this
being eventually addressed!

> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

...

>  	struct device_node *node = dev->parent->of_node;
>  	struct mxs_lradc *lradc = dev_get_drvdata(dev->parent);
>  	struct mxs_lradc_ts *ts;
> -	int ret, irq, virq, i;
> +	int ret, i;
>  	u32 ts_wires = 0, adapt;

Can we, while at it, kinda follow the reversed xmas tree order here?

...

> -	lradc->soc = (kernel_ulong_t)device_get_match_data(&pdev->dev);
> +	data = device_get_match_data(dev);

Is this driver affected by driver_override case? If so, this has to be checked
against NULL and return -ENODATA.

> +	lradc->soc = data->soc;

-- 
With Best Regards,
Andy Shevchenko


