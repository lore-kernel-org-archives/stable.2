Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572835;
	b=eTKHJ+iBCLVUxEIygQ6zMCcWWCPaPoVC4HCbx3v6zgApUxme4csHXJJhfhrv8juQuVU3
	 jlhmxEG1gk4N6f8wgyaFj8NylwjHum/fmTeGw+DtZpgCExNahLUGuBdtC3wleTSxB5br+
	 KNlN87GE3F2APTQHsl6gQl+TNElnFLfOfTd/NmN75gIeAJvnq9HaeydlJ+dPNTdO3MXzn
	 BQYHPEMog6v49soDKO240tSOMvxCQjt+vOa0kWHk2cA4KFwFJJjjFT6qP89Yez0kkgmHc
	 gIEGDdVtVgm2qBm0aAXZAzalvIAyn6jIhuZpNxVa8082pimizBBrnTcD8v6HS6t0EsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572835;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=+gssuiItGuzjstQSCnR+QwXunoGmNsNH8w+n929Ric4=;
	b=Z5CHJfNaz5wN7lxNz3Y444bu1HBd0EoWv+X465TZNk9DzFhxdYPil/IYV2ZAX4AjaVdc
	 4vWLCObkTWR7SzstA7j2JOp31XGXLqB3yu+1RW1bd56pRYyrg3Dy26fySAkJ9bzQljQ45
	 wUBNjqwLssjMgeYJ0r83rF7j/8RdONW27FjHzFIDa/VjNVVLN8itJ/tvngk7pv/F0j5rE
	 QfNrWxXLfmUsEO6d9vaeHGZfWvbesFoxMvZ2RYpGridEzdgqjaI0uv2Nftfd3k2ySbes8
	 lI0bOk7LGe4cnY4qY5S0rhgYmndH4DaG0eB+q2eLtw3XoOCXxf5Z7vP6CenvJMxf4qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="GecEL7/E";
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A659606A32A;
	Fri, 13 Nov 2026 12:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A659606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GecEL7/E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794572835; x=1826108835;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GONH34euy6I7ShZZRm0xnOysRcup10XSU9Kp2VTdGj4=;
  b=GecEL7/E4dNLaqf6Xr4YLgqyMR7/UxmLgnhbpcyU8Y2+rTI240K8m1nq
   3NeGKCwOSdKxx7opLulrtrix1dxFj0mPU7a7yOkTvLAEwiOiOCMxoeWt2
   uyvgF6oem6WCbQdguBv+GnlTSvwwzOFK8lfne7eumvUwb+GuorTyBqFse
   BBVJIKlJ93o/1wknmZnqQC78+hmBqTDHpjYf8FH4DfmxiFkhluqtgL9N7
   Zen0fTLj84Zu17OTNUs+H09PU67Y8bTzYgINYn24idKKXU725zcZo4CSd
   zCT9sFxSRmb5Vm38GZ/6yv1Bcvn6fz8m2ww49AfA6R9Vi8EGPN2y/KIX8
   g==;
X-CSE-ConnectionGUID: ZvxZ1Vr5QIuI7mpP8YklHA==
X-CSE-MsgGUID: ajvYS+gjRJC3ofrWGMIDsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3382941"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3382941"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 04:27:12 -0800
X-CSE-ConnectionGUID: nSdeYu7uRzi8MAv3gVutgQ==
X-CSE-MsgGUID: h+udWmwPSjC0+1RLFsK54g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="8799457"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 04:27:09 -0800
Date: Fri, 13 Nov 2026 14:27:07 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Parthiban Nallathambi <pn@denx.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: light: vcnl4035: Fix swapped raw channel readings
Message-ID: <avcCGwCYK-AiQ1mE@ashevche-desk.local>
References: <20261113110123.96084-1-dennylin0707@gmail.com>
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
In-Reply-To: <20261113110123.96084-1-dennylin0707@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 13, 2026 at 11:01:23AM +0000, Hungyu Lin wrote:
> The IIO_LIGHT channel has channel number 0 and the IIO_INTENSITY
> channel has channel number 1. vcnl4035_read_info_raw() selects the ALS
> register for a nonzero channel number, so in_illuminance_raw returns
> the white-channel sample and in_intensity_both_raw returns the ALS
> sample. This also causes the illuminance scale to be applied to a
> white-channel sample.
> 
> Select the ALS data register for IIO_LIGHT and the white data register
> for the intensity channel.
> 
> Fixes: 55707294c4eb ("iio: light: Add support for vishay vcnl4035")
> Link: https://www.vishay.com/docs/84251/vcnl4035x01.pdf

Make a Link tag with a reference: Link: $URL [1], and refer to that in the
commit message. Or make it a Datasheet tag. Otherwise intention of this
Link is odd.

-- 
With Best Regards,
Andy Shevchenko


