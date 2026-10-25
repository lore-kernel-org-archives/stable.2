Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792964199;
	b=MvgduQDbnBcpKp82hykCVjnT6fEs3/Ken64igNEzICVT1lpFQ2lPa0LH1DwfYazcF88s
	 I1U+SmLceQ1Rvg1fzC5DdjFU3pabBY/CXNg0iDbJXZZL4nw0oBydxBhffEuYA7c96IDwb
	 Y4RIxAgEPq4DX6u9xEXsClbVjLaJh2R7NyZGQ1ie7XWBnuUq8dGO5Ekk53G+olZUjXFOo
	 LEiLkARtGnyGo6dQvGRIl+u/qVj6OP1W4s+hwsVRzJQe1iuI7p0cph01AwWHc334Ndvlo
	 z4ucQHqD3kT3CTt5TaRM9RCWk07eglPS5/5dOO8X7WkiuecZNys3/fz6s9YQERpq/Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792964199;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Mb6pxKAujLPk12AlZl7vRWjM+xDBUM6FM5qmBikWJIQ=;
	b=bInr3FtKiDgC5EDWhXiOTYQSPaan05Fv7sFrBnMOGoWTuHLa0A020UalHE7CEtbnXLYw
	 AS/GN1+TmrmPxl4w9AYqhi9XoO5AIHr84GI9oYvYC9pRBaywVL9BciLpsttYooHGGNesr
	 RGUnbRL3GadvNFAv2s/MaPR+C2pkDKszyYroSQ3YlR2iz00L1mkThfzJczj+ey3pvn+av
	 t/A3PdLmVj9JyK04GVtr4kkTIMZtmjzCyDnbabpWEPa+fLZegXKz/TNb5BLTFrBjfkw2z
	 Wml7gzFr1446Xc4/damnFqQr09alLiCIvF33CnsAhk79dHOeao/pAE4nY4Yip3HwFDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k4eTvIZ+;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591A3606A31A;
	Sun, 25 Oct 2026 21:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 591A3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k4eTvIZ+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792964198; x=1824500198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HY0XPjDdSPPKHca1nCACsDvdTCwxvjZJX/zz5u57Fcw=;
  b=k4eTvIZ+gatLgkpB8b4mvyFwMhJtfMSmVG/JK9Em7mb9j7whRbYfke/k
   HwZoEc3QO26jsRfEV+vH23oVkH2oHcopxEQRogqhUf/Mn5puaL0PR88Dx
   9YSd9YnU5e1qqZVFBegnWoV3cfarDJ5pSPlZhco9iCsGy8Gya4hPZKx2V
   2WgTKkbioQesDISNaJi3OLxYTbWPV2YX9mAEtpqFSKZsBqPwHD6N4oCvy
   N6AhHbp3jNv/HI2t08SM+Z92q0636NDsGqlqonkEVc/R1nk1ri7grrud2
   YNvgOGqD+kAuBeT5LrSVQaTB6zDbZTqLsWk53T2StoLdVnHypvayo1mav
   w==;
X-CSE-ConnectionGUID: 99i5xuH+TJWGpcjcdcGfrA==
X-CSE-MsgGUID: rX/7B0D8Ro6we+2xkrvlzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1621352"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1621352"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 14:36:38 -0700
X-CSE-ConnectionGUID: f95TgzKVSsmKxB/GArbA2w==
X-CSE-MsgGUID: RjBOwiIASJuws4WsoDeL7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4229071"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 14:36:35 -0700
Date: Sun, 25 Oct 2026 23:36:33 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Carlier <devnexen@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Ariana Lazar <ariana.lazar@microchip.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: dac: mcp47feb02: reject out-of-range raw values
Message-ID: <at52YVZzewqXH-by@ashevche-desk.local>
References: <20261025211856.256491-1-devnexen@gmail.com>
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
In-Reply-To: <20261025211856.256491-1-devnexen@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 25, 2026 at 09:18:56PM +0000, David Carlier wrote:
> mcp47feb02_write_raw() writes the user supplied raw value to the DAC
> register without checking it against the chip resolution. The parts
> are 8, 10 or 12 bit, and the bits above the resolution are not
> implemented, so writing 300 to out_voltage0_raw on an 8-bit part sets
> the output to code 44 instead of failing, and -1 is written as 0xffff.
> 
> The out-of-range value is also cached in dac_data, so it is written
> back on resume and stored to EEPROM by store_eeprom.
> 
> Return -EINVAL for values outside [0, 2^resolution - 1].

LGTM now,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


