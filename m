Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792960648;
	b=srH5vmBKX7mBq+aD+fJAejHMcu7f+CPYRnk1WI2JPDv94xsqzIWf3ls3mnglMnFoYvvU
	 Xfh+OHpOtjbo7CzxRdJNuuwbVVe1SDWAkDkf6IN4pyGO6V6hTSF1Gx1a0uEsS1LnmExpQ
	 QNwISpJDoSDavGPndYW73agl7GNtn262V4dIcUwaZhSB1ARjAYinWVXTGPXCfsmvfO2P6
	 ySTy+yUIDLhu6YFYT3wK0JKRc+HTJSGWVzEj0mojzE8rdpG+1tdmXQSEUoIEahlr6DVa0
	 5bAzwf6d/jH1ueY2Ul7qwiv1+G1SpfGQ9xUwO15quuXVFf3/ismwjMWRkkSiSDt3Ckw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792960648;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=hZB4+AYsf/DtYXDALVo9SOym6jgNg09OgCyh9KMIRLQ=;
	b=BA8X5mARNtR0avGJagIfWRHMQHuEFCckauMqZ6mi7Dfj7ZkfRiiLc2S3qccdjSQsjop4
	 DSLxtnK7Wof3yeCy6cD4NO3X4UGuFMzFfEZJlxpZSrkDmjQ4OQ4I3KnjoyqEh3livC9IM
	 pif1AKvN+1gd3VOy/mFL6Jkz9KvDsiRfPuplpIHcsYSY+N/gmPz+Tl/1qEm8uR1yPcLKE
	 iT2CUzfey2XQ5TpiupVFyh3tOzpL82xNaG9ZLDpEpb+9alfVtDkjGjg+Di1cNiYC8P6J8
	 D5sZY4aK7ZIYrjNYoGt49y8BOYtk5WiII/9ROtCDgGIQDbphRpcptneA4dY3dg+ENJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lDbE8i1H;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF461606A31A;
	Sun, 25 Oct 2026 20:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF461606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lDbE8i1H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792960647; x=1824496647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qc7wzHuQuaoaFa5mQg5ILqY0cjmDLwcKFWuxOa/iIPE=;
  b=lDbE8i1H9l66iTHYsPQg9Bi0P41wgOFRueqYHO2ntRFOFSPGV9lrRVjM
   lmhe6qggrUz5u8BRdZqoMWW30blW8sOJfcvMYfBSsSInUmZLrIdU2kPjU
   cD+Gyv2TWckFLR3J0mDYrpC5b7EhntdbiphGS8lVcfgMtSSOd+3aI8vIj
   iFdkXc/Kd+4rxkSiHCqGm4gGM7HOFzeBX3Q13l4X/tiDjDZ0CYVnxfNpe
   SfLMEXcPsdrjV8WbHfXL6f7wmSijwgqLWuwDUYsk1x8pPOoA402M+7iqK
   g54QFd1Jd1/IvyUtEThDAPcJWMKYYlEuw696NCdPxav7mL2FXFXic7dT0
   w==;
X-CSE-ConnectionGUID: Dj9iFyI9QG+2niuiBH7spw==
X-CSE-MsgGUID: xLbpurXkSMmXz/hX0n2ptQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1734449"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1734449"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 13:37:26 -0700
X-CSE-ConnectionGUID: XTvKxVe0TBCs+9B+cHGtrw==
X-CSE-MsgGUID: J0mcAmDwRCCGSW6R/Gv8GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4437822"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 13:37:24 -0700
Date: Sun, 25 Oct 2026 22:37:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Carlier <devnexen@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Ariana Lazar <ariana.lazar@microchip.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: dac: mcp47feb02: reject out-of-range raw values
Message-ID: <at5ogu8JaXFbQpHg@ashevche-desk.local>
References: <20261024214423.865635-1-devnexen@gmail.com>
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
In-Reply-To: <20261024214423.865635-1-devnexen@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 24, 2026 at 10:44:23PM +0100, David Carlier wrote:
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
> 
> Found by code inspection. Build tested with W=1 (=m and =y) only;
> no hardware was available for runtime testing.

...

>  	case IIO_CHAN_INFO_RAW:
> +		if (val < 0 || val >= BIT(data->chip_features->resolution))

If resolution is 32, this will suck. (Yes, this is a bit theoretical case.)

> +			return -EINVAL;

Not sure about this error code. Do other IIO drivers use same in the similar
situation?

-- 
With Best Regards,
Andy Shevchenko


