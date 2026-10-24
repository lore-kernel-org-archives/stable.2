Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792838671;
	b=ZBN0KMMiu4+J1CO1uDIDrgi5vtK0TZnKINKgu0zfC/TXn+HrLo4UlGvC7djRyJskAocY
	 lqHd6PjjkHMvZiuknaGrmJZsTHEE3AqudOEMSCNBbk2JoxQ6FYfBmVlMKGg4JpIn4Zx7i
	 AfdCYJxMMo4FqdPEp6OLSLuCVTuyerGv9ArkXDmcd/W7DA+v8/G8W9d1SUvgaDEQ5sdlp
	 6xLjvbfB2p99vl2SyR4Ch6w17rMI22Ltf2v+lZm0C6WLrFK48k3gf8ml3wgz/bP19FhRW
	 xovRY7JGARGDDuPWxtXQyYOmA40RZQDEgwNglTCrgSxBJWpNMxB9tDHZ2974VvGEZ6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792838671;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=cP4QIQsJrDFe00ukZI5ghLcu5/zmP+CrOQ2Y1+X9TAI=;
	b=fzlU+1AQuVFfAb7UfvL4kFcVSGA6XTaeU3WKsn94TZo0m9vcvrqeHXI/xUIvYH89umxL
	 hnpCCv26U/B94xwUiDd1ikR5swiWnzSEvB/6GIBEq1STy/Yulj5rFireC/7tlC6OqKz5y
	 N3cx6LM1bPnSejsrgZmSxLumspyVfxBjr+GAn10YKEa+f+8A5Pke9k5d3lu6n0gdp/5Kw
	 gXZT2gp754Vt49y4WrXZYlkNhMB34D92wqv96060zK7KpvgGEGe6BY6cmoGp8Yv4qcBjD
	 5WtK47BD0Bn+xNXyn5IBovZ+0vG8irgGHd4VLM+Yyyz1HyChNiQKD6tCZA0raxbldbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L+DJkps9;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4CF606A31A;
	Sat, 24 Oct 2026 10:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C4CF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L+DJkps9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792838670; x=1824374670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TE+an+keRkU9QPvmaNWoK8GFR78TtYIwI4t/FxzwmYo=;
  b=L+DJkps9Pyz8W20fZ4pyj5aUu7rc9788FI5gKZFLK/rTyLACOgTkIltW
   LgWPr6Mi2ACk8CWHubQDkPQoDbr0OhWbUYWvb6gRQvPvMhrqBFj/ecOp4
   m3I1+Dh/35t+z3S2P53pXm/ovg9ClYSIvySs5C+RsFQkFygcD+saxgJ1Z
   uIHNNcgGXMr06+lWaplb41ZQ2va0S2ptST6xsfesMbzZ+JgH7PZvGnqlf
   grfdkE3GETZ6zCxwciCRIqIYO5t+mPmszj+umRQwuw1ZQJCDyYNyQDDCl
   g1ylcf2RUv9kyXU8Bfu/SXDZVRueRvgTrlDNk+2/bitsH1SFfWTk2S8RF
   g==;
X-CSE-ConnectionGUID: iEMTucg1Saa0uMeri+PXew==
X-CSE-MsgGUID: azLjltajSCK4q3jWmVFdiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1453841"
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="1453841"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 03:44:30 -0700
X-CSE-ConnectionGUID: u5rblvWGQjiDufgMHdjsgA==
X-CSE-MsgGUID: UYPyOwUbR4G2HOZsvvcXLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="5600527"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.221])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 03:44:27 -0700
Date: Sat, 24 Oct 2026 13:44:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, stable@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: proximity: sx9324: fix out-of-bounds read of
 scan period table
Message-ID: <atyMCCJsBDPdgl2Q@ashevche-desk.local>
References: <20261023192700.221344-1-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261023192700.221344-1-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 24, 2026 at 12:56:51AM +0530, Arnav Kapoor wrote:
> The scan period of the SX9324 is selected by the 5 bit wide
> SX9324_REG_GNRL_CTRL0_SCANPERIOD field, so it has 32 possible values.
> sx9324_scan_period_table[] however only has 16 entries, it was copied
> over from the SX9310 driver where the field is only 4 bits wide.
> 
> sx9324_wait_for_sample() indexes the table with the raw field value, so
> all the codes from 16 to 31 read past the end of the array. The default
> value of the register is SX9324_REG_GNRL_CTRL0_SCANPERIOD_100MS (0x16,
> i.e. 22), so the out-of-bounds read happens with the default
> configuration of the device. It is only avoided when the device has an
> interrupt line, as the wait is only done in the polling case.
> 
> The value read is then used as the duration of an msleep() call, so the
> sensor is polled with a completely random delay.
> 
> Fill the table with the scan periods of all 32 codes, which are the
> periods documented for the corresponding sx9324_samp_freq_table[]
> entries, and add a static assertion to keep both tables in sync.

...

> +/*
> + * The scan period of the SX9324 is selected by the 5 bit wide

5-bit

> + * SX9324_REG_GNRL_CTRL0_SCANPERIOD field. The values below are the scan
> + * periods in ms of the corresponding sx9324_samp_freq_table[] entries.
> + */
>  static const unsigned int sx9324_scan_period_table[] = {
> -	2,   15,  30,  45,   60,   90,	 120,  200,
> -	400, 600, 800, 1000, 2000, 3000, 4000, 5000,
> +	1, 2, 4, 6, 8, 10, 14, 18,			/* 0x00 - 0x07 */
> +	22, 26, 30, 34, 38, 42, 46, 50,			/* 0x08 - 0x0f */
> +	56, 62, 68, 74, 80, 90, 100, 200,		/* 0x10 - 0x17 */
> +	300, 400, 600, 800, 1000, 2000, 3000, 4000,	/* 0x18 - 0x1f */
>  };

Haven't checked if this is part of any ABI. Otherwise LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


