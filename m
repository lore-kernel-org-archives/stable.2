Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433190;
	b=zq2eJ/2jCJVRrpmYOliVYkPVX60C+PaD1OxagXF3rcIKzLg7EpzRQUhgp5n//VKnd6c/
	 89u8v5QlrlZ30Ma0tNLq7nw+De97a9mzHUg1C+GEPQl1eocKSRl99UuvQ0J/FMKgj8H8l
	 yN9Fg4D9GJF4beLFPU07bEHSjm37pKPUiA0aAYyurMKcAU9VFZwxaUkz+E6+QaLGUFUcz
	 D3+HOmStm6MV3EfDk1enGsGXNpE5DxLOQ0rt8SpQBh9xl/VTysnFzKJcqQFTc45Il4dyu
	 kxlHJbalDg956yetGXZiBgGJNTiUelEUTDRjpsyQLAZsGwD7d1CCfqJk+Eo1Dymosyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433190;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=eRHJYff7xbuoGc4caiW1C1gZpXcbzwTAvEFSpmbyqfs=;
	b=SX8D8bAO+e10vB70yCfDnS3vmU/sJlyPV2fl6G9icXQq6IS+DZ3KFA/t6SxShBiOusf9
	 EJqzXg1g35/9mWYIr7nQq9DUir5LxaUn20LIEjIB48QxMCZEmZBNRGxQLkn86weHp+yMV
	 fX/7kn8PDM+3ZoC25ekVuEMKli0/NjgSZoc/618900nprSW+v52NYUUj9EcVn/mOpbc3G
	 pgJiWMyympYbbfc6f8RK6inGj1Ca+lyUIB6rI24QR2+FnbZggmBjefdZH7IIFZERV49Qo
	 LC8xCQrr4Z74uM6NAYVMkA1YGV+MXbiAbtzSzv086jpHM4nCSazhTeoPjfxLPuxaq1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MgENCpS4;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E38D606A31A;
	Mon, 23 Nov 2026 11:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E38D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MgENCpS4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795433190; x=1826969190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=scRuyMIVv2lSRt7Jqqyl2xDUabYgnyyzF+RNayr6wKA=;
  b=MgENCpS4ION/zXFfXyRtERugp/JjLOb8jhVWPJF88eVlKyHUY0arZsjq
   VH2aIpJKj289Mfh3COQOZzhZELvDJ6Y/h/cxTUlHLlrG4/cEO2Kgb2LrR
   wjMv5APOiv+VMk+sAKNnXzl5Kzn5Pl8TISd6vw4XPi8v0/6Sys+FfDzLJ
   ubxpRfRVyxoVY392CzL3e6zZCiDBatdnLewZcaWw7zO++FJ1w0s6qjeBX
   0XwzXcZIGAOL6SpDGvNMIoHEkBTWDQa3f7hIEOehaWJlEoTtXDSI62loS
   0Q8OmEnC0lE7srEOUc1hHJ5a3EY4CnetB5Gju6kr+Yvz+Yq4UuBzVFsFU
   A==;
X-CSE-ConnectionGUID: LKd5JXJwQ2CDmMarhiXT/Q==
X-CSE-MsgGUID: U8uIx+IPRWW/KovgHkeJ/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4145911"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4145911"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 03:26:30 -0800
X-CSE-ConnectionGUID: cbCy/wYMRJyyTIi9MGLbzg==
X-CSE-MsgGUID: yZuAygo+QousR0HtCJACrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11363503"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 03:26:27 -0800
Date: Mon, 23 Nov 2026 13:26:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Bogdan Bolocan <bogdan.bolocan@microchip.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 4/7] iio: adc: pac1934: Fix custom attribute
 allocation and channel bounds
Message-ID: <awQi4MTY4CMM0hsV@ashevche-desk.local>
References: <20261123075122.373060-1-lee@kernel.org>
 <20261123075122.373060-5-lee@kernel.org>
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
In-Reply-To: <20261123075122.373060-5-lee@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 23, 2026 at 07:50:30AM +0000, Lee Jones wrote:
> pac1934_prep_custom_attributes() sizes the pac1934_custom_attr pointer
> array using sizeof(*pac1934_group) instead of
> sizeof(*pac1934_custom_attr) and adds 1 byte rather than one pointer
> element for the terminating NULL entry.  When active_channels_count is
> zero, only a single byte is allocated and iio_device_register_sysfs()
> reads past the allocation when scanning the attribute list.
> 
> In addition, active_channels_count is counted over info->phys_channels,
> whereas the population steps unconditionally inspect all four entries of
> info->active_channels[], which can write past the end of the array on
> 1-, 2-, and 3-channel chip variants.

...

>  - Order local variables in reverse Christmas tree style (Andy,
>    Jonathan)

Oh, I meant only this for the case when we touch the content.
Since now it's not changed there, no need to do it, probably?

...

>  static int pac1934_prep_custom_attributes(struct pac1934_chip_info *info,
>  					  struct iio_dev *indio_dev)
>  {
> -	int i, active_channels_count = 0;
> +	struct device *dev = &info->client->dev;
>  	struct attribute **pac1934_custom_attr;
>  	struct attribute_group *pac1934_group;
> -	struct device *dev = &info->client->dev;
> +	int i, active_channels_count = 0;

It took me a while to understand why, but no need to resend, if Jonathan is not
okay with that, this hunk may not be applied while the rest is fine.

TL;DR:
Up to Jonathan (but personally I would leave this as in the original code).

-- 
With Best Regards,
Andy Shevchenko


