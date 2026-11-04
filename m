Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793829341;
	b=MNP90IjmutBjCd8qiuobX3qWVDKB8tqeBOGQp20/AY1eMfbkDlNk3i/UZdD31cNF7lE2
	 Tshoz/uMpG9iyUcOspErBFgO3Sm0/E1vM+wqpOhjt70B9RoN1/R/D4+bfAhw+0rRuwtZC
	 zdZM8x0P4968JMcbk3aJDZ+adlhvyZiUM/AU+7Sw/qGLvjE/DyA93PKQ6+OL+4Bjck/7L
	 gfkfNgrwMoKB0euk/JzvGuldSumUSwSR7aeB1RpaD9jRKw71g/WvjSJUmHlYIR/NFejYl
	 Hb1tzsGYdwb1hcr8ySS2crUc2raiS0f4pSwppnOcN2xDAPZfW23Q4qxNbMo4I+VlBWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829341;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=mNv4xjMMy7I5DQm+piFsVss84RDUYiAkm8TSEYtVupw=;
	b=go46UjkzCvP1jpjUlfffGxgo3NwzaXghxXLOoNzRjsWRrfkO1KcN7aAFHqbjWXp3DqFB
	 hmrdbB5HKovtUrpcC65KQiwUpddZIPniNysesr5gL5B6hNxXwA/SzbEfFREy5kwCC8vAF
	 Ka2PMbQYIKWUOEK0Kw0Zgr8QPQGumbRjAfbISPJfVUPBhHUFHUPQs63feY7ZP4BTDlnh7
	 IWOLCdGAmjdvzS7qF0hmjKyx/uZpF/1jv4WxvY40GzYeCn/hQ3FSj1DZZXvrMZxeWCoIR
	 YMCv41d1H9nqtTW5WmEx1ovykJzZmqonFrHtQfnuC7Lpe/uq7ZVw+o3z5qf9O5wyk1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KRixRl9F;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F171C607491C;
	Wed,  4 Nov 2026 21:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F171C607491C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KRixRl9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793829340; x=1825365340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dTKkmVA2sw1NSzd9GEd1jGm3jnMpihGVWC4Korlnq8k=;
  b=KRixRl9F6R6ois8phQEPTCrmsGi+Bw2XxFI7vgE4FJweDEl6F2m6135W
   cNHLsNlQALHNpYkNswmOBfUOJgJl40DGqeuUUIr/hs/cek0MyR6FpckM8
   uQMArJG4f9gMxtA9QQkyol2Zua72yAKnCCXGrMY8yf4xngIgifbIjtWSk
   1WO+VpOz+SGvdIYBtm9+3cMNXLOmL278qFSSvBgb7w8x08D9sXzYU9r4B
   cZFgEMtmJNYEa+lgxrZfJsl8pWDYC8bdjai7VuIXSMXEDqUJ81ditsie7
   dRsMfkedXUb7VfUdhICM4ukSUEFq5OfSGw2y25h/+aDni+looAp0rvKBl
   g==;
X-CSE-ConnectionGUID: hTbf9BYPR6u0e0lUoCRp6A==
X-CSE-MsgGUID: LGxuMFe5RXmDsCe1QxkDHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2607141"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2607141"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 13:55:39 -0800
X-CSE-ConnectionGUID: 6E8Y/IVmRJ2LTESdn8bWGA==
X-CSE-MsgGUID: wxIaTqaoRWCrl8aEME/UCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="8609220"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 13:55:37 -0800
Date: Wed, 4 Nov 2026 23:55:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Kent Gibson <warthog618@gmail.com>,
	Adrian Ambrozewicz <aambrozewicz@nvidia.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/5] gpio: cdev: don't overwrite the whole flags field
 when configuring lines
Message-ID: <auup1z79S7Rv6cMe@ashevche-desk.local>
References: <20261104-gpio-desc-flags-atomic-v1-0-e23cedf619ba@oss.qualcomm.com>
 <20261104-gpio-desc-flags-atomic-v1-5-e23cedf619ba@oss.qualcomm.com>
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
In-Reply-To: <20261104-gpio-desc-flags-atomic-v1-5-e23cedf619ba@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 04:37:00PM +0100, Bartosz Golaszewski wrote:
> linehandle_flags_to_desc_flags() and
> gpio_v2_line_config_flags_to_desc_flags() read the flags word with
> READ_ONCE(), modify the local copy and write it back with WRITE_ONCE().
> 
> The per-request config_mutex does not exclude sysfs, the irq core or
> drivers touching the same descriptor, so bits they set or clear
> concurrently can be lost.
> 
> Build the mask of bits owned by the line configuration and their new
> values locally and apply them with gpiod_update_flags(). The whole
> group changes in a single atomic step.

...

> -	unsigned long flags = READ_ONCE(*flagsp);

> +	unsigned long val = 0;

Why variable renaming?

...

> +{
> +	const unsigned long mask = BIT(GPIOD_FLAG_ACTIVE_LOW) |
> +				   BIT(GPIOD_FLAG_EDGE_RISING) |
> +				   BIT(GPIOD_FLAG_EDGE_FALLING) |
> +				   BIT(GPIOD_FLAG_OPEN_DRAIN) |
> +				   BIT(GPIOD_FLAG_OPEN_SOURCE) |
> +				   BIT(GPIOD_FLAG_PULL_UP) |
> +				   BIT(GPIOD_FLAG_PULL_DOWN) |
> +				   BIT(GPIOD_FLAG_BIAS_DISABLE) |
> +				   BIT(GPIOD_FLAG_EVENT_CLOCK_REALTIME) |
> +				   BIT(GPIOD_FLAG_EVENT_CLOCK_HTE);
> +	unsigned long val = 0;

Ditto.

-- 
With Best Regards,
Andy Shevchenko


