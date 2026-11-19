Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795109662;
	b=c/S3vXx6CjL0cqRdvUNh/1uONmJkdlIBHdbtranqJxqo3fyh95Aa9EmbxVFTD41upD4z
	 yZ8YrhauIcdOlG7KW3Q2hw/G6HuJ+FgIzr1uoQZCQuAx84sJIELOKjFU50sBRUBNfoAL1
	 60xKfH/mdu4eB9w+BRdfk6iaotyGwOJuZC3Mu0j2hMHxdnRQyKqhWjwh/6ieVgvpfuwWl
	 Dgemape0vN5AXcriERgx/SPDQuGF+RchEASLVKGMXFk8R5AOH0cBpDQxdIP3FYOaGpNdn
	 7mTD8QKhnGDkkpBbD6LUdp7eexL9x5nYdSOIaF9Sgd2D2zAj1zHuRH7/2Fw4bs82Tgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109662;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Rujiu5z69Ch+cWckCro087llWTMTfJcyA8eIXXNMcbo=;
	b=DG5ihFSkAkBn4DRpLLctRcZLiFsZXxAx0RVdoNHkH+hWc+mQKcz3COxTBXj4W4m9veUm
	 Gy+3VN7cX79MgM7Alwx60Wbi1/e1chK30YvbKILcrc3fz1z1AonzTGatFWu4PP9+muReU
	 zOvuJmnlLWau2mA8HVmk/EmXCxYCRe2xdIuVWdQMvF4yoPT1nXZr966u3rA5D+OZiBQq1
	 VfT1WkF9k8DqeTCUZ8e0syUk4LnOgm0EVKlcr3z0CKdk4IqT7I0cJ5MendXERePyiL5lQ
	 vdasJL3FQGZxy1wmhsY4akW1YBgaIDXHig5pTu2L3HuzzsQyCCrtIntpYzkRE9dzwCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="BWxg/3eb";
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138B3606A32A;
	Thu, 19 Nov 2026 17:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 138B3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BWxg/3eb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795109662; x=1826645662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LPXHRcSnIba10GcheUlL+DWif/qpX3CwCRVi2ePPTIg=;
  b=BWxg/3ebGoKGCoLVoGrd4Eu330GlBw087Z01J7wnGVa3aB8flumj8EdH
   3tsjtorVyUFB1ZKEJhjkHsGj5UAdPbZIftNeDeia8Iv1y2aAvNQLFFcPV
   dTZNzCkZIk2hSJcVm4uB24rytyBURuACEzWsXaADX8GUcZ0+SBath6goL
   s7u3wKpbOX2d4rvro9wp6nJX7i/Kz/PaWlGUCqYLIzMU5YvAG6prfyMry
   8ZQXfvRsf4pGrHskqgdTdTFKDDSY3ppHgJjWsAWnAN6wSmTTcWa2idPBQ
   zrRsc4/xgev5Bp54O/0k/lEp3jLeAHYkrJo0oKpAUj6REipyw1WcAjB4Z
   g==;
X-CSE-ConnectionGUID: YQVtli/KQMewPMZyipHUtw==
X-CSE-MsgGUID: XO+WNVbQTs+ivghZFqz1GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3858536"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3858536"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 09:34:19 -0800
X-CSE-ConnectionGUID: 62sRMc+1QmyKVyBumj+7wQ==
X-CSE-MsgGUID: Mqf4wRE7Qz6ujJDux7LlpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="12330860"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 09:34:16 -0800
Date: Thu, 19 Nov 2026 19:34:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mathieu Othacehe <othacehe@gnu.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 09/10] iio: proximity: isl29501: Fix division by zero and
 overflow in isl29501_set_freq()
Message-ID: <av8zEwS8KnZoSUb9@ashevche-desk.local>
References: <20261119153151.1397003-1-lee@kernel.org>
 <20261119153151.1397003-10-lee@kernel.org>
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
In-Reply-To: <20261119153151.1397003-10-lee@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 03:30:42PM +0000, Lee Jones wrote:
> isl29501_set_freq() computes freq = val * 1000000 + val2 % 1000000 in a
> signed 32-bit int and passes it directly to do_div() without checking
> for zero or negative inputs.  Writing 0 to the sampling_frequency
> attribute triggers a division by zero in the kernel, while valid
> frequencies above 2147 Hz up to the sensor's 2222 Hz limit overflow
> signed int.
> 
> Validate that val and val2 are non-negative, compute freq as an unsigned
> int within [1, 2222000000], and return -ERANGE otherwise.

...

> -	int freq;
> +	unsigned int freq;
>  	unsigned long long sample_time;

Make it reversed xmas tree while at it?

> +	if (val < 0 || val2 < 0 || val > 2222)
> +		return -ERANGE;

I would see it be grouped by variable

	if (val < 0 || val > 2222 || val2 < 0)

>  	/* sample_freq = 1 / (0.000450 * (sample_time + 1) * 10^-6) */
> -	freq = val * 1000000 + val2 % 1000000;
> +	freq = val * 1000000U + val2 % 1000000U;

While at it Use HZ_PER_MHZ and similar multipliers from units.h.

> +	if (!freq || freq > 2222000000U)
> +		return -ERANGE;

-- 
With Best Regards,
Andy Shevchenko


