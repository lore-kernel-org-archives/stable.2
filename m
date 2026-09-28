Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5837746F484;
	Mon, 28 Sep 2026 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583786; cv=none; b=OAAJQRLyxlBcn+JlMTpVs9KvfXKa1W/KZPKbhg1KIEf468pmimqtohsyEmRELnPpD6pt7MpY4jDZ80kv2UNXU8HFrcPxCjs1Jq4dO/3zhxS2TnOnv6Ky6K2QbI+aP7UxCdcipG/s02JqlE9VvFUqXvG17bZgxKNpfWZzzzMO7uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583786; c=relaxed/simple;
	bh=1wocS/8MUk0c5FYoePcc+sCMjbYoo1qq/BetZNUrGpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTGSHrEPaIlHl08egj35eq5f9ojV8syI7cZKDnvIVu7qy7bahhZtsLKGiFLK4O0QpRT2uXnNuWROl/x671bae9fCf6J7qhkJgbAAfb5H6p+8h7S+3Yjn1y2Nzy+TIMSgqJ0Jr2cOfGz+kkipWvcdbGK43C7BQjAZ52aOll0B/L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dFCSke2w; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dFCSke2w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790583785; x=1822119785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1wocS/8MUk0c5FYoePcc+sCMjbYoo1qq/BetZNUrGpM=;
  b=dFCSke2wKSJEFP4A6p13L9R1QdcFt/uTCcSZvV7NlkZB+a9dDl9vUAP4
   11oRMbFoyQRnHMt9Y2wbTSQRNkQgaybImTrKXNPj6xflwYKI/9HYLhiHm
   Xv3ugrWs+KPzVTM2omrjJaVY7DV7hPyy953YrLvYwLjXILVWrhxkJtNfk
   Ox12LUDm95smlR2Oba5khLzPhvOIT2y+e1vuZ9U2uNQOye575Ze/2Sc9y
   PPT/uNGFqe3wtrC28Xxl7WthpycOcsfKq1BfC/dkmVTdtv2i6MxPvFXsr
   0gzBOhUcj7D1GVYxJm7XrKwBcUaGrHDoCwFr7tQP1XU/xdnl7O8wMJLUY
   Q==;
X-CSE-ConnectionGUID: ExkWOPogR+CAwgdL8SewKg==
X-CSE-MsgGUID: AXsQDLXrT4i0xV5URw6mlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="108765977"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="108765977"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 01:23:05 -0700
X-CSE-ConnectionGUID: U0XgYB7cQzujYAq8DGQ0OQ==
X-CSE-MsgGUID: WlXpRSZvTRSRmYdNxQYmvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="274220575"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.42])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 01:23:02 -0700
Date: Mon, 28 Sep 2026 11:22:59 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Weigang He <geoffreyhe2@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: adc: xilinx-ams: fix out-of-bounds accesses when
 parsing channels
Message-ID: <aroj4-Wag_kxuBxH@ashevche-desk.local>
References: <20260926055456.3289189-1-geoffreyhe2@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926055456.3289189-1-geoffreyhe2@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Sep 26, 2026 at 03:54:56PM +1000, Weigang He wrote:
> ams_parse_firmware() allocates room for ARRAY_SIZE(ams_ps_channels) +
> ARRAY_SIZE(ams_pl_channels) + ARRAY_SIZE(ams_ctrl_channels) = 51
> channel specs and lets ams_init_module() fill them for the AMS node and
> each of its children, without telling it how much room is left.
> 
> For the PL-SYSMON node, ams_get_ext_chan() appends one channel per
> "channel@N" child after the 10 fixed PL channels. The binding allows
> reg values 20..50, so a PL node can have up to 31 such children, i.e.
> up to 41 PL channels, while only 31 are budgeted for it. Together with
> the 13 PS and 7 AMS control channels, this writes past the end of the
> buffer. Since the modules are filled in device tree order, the fixed
> channel blocks copied after the PL node can overflow as well.
> 
> ams_get_ext_chan() also only checks the upper bound of reg. ext_chan is
> unsigned, so a reg below 20 makes it wrap and ams_pl_channels[] is read
> far out of bounds.
> 
> Pass the remaining capacity down to ams_init_module() and
> ams_get_ext_chan() and fail with -EINVAL when a module does not fit,
> instead of writing past the buffer. Also reject reg values below 20, as
> the binding requires.
> 
> Found by static analysis tool CodeQL.

...

>  	fwnode_for_each_child_node(chan_node, child) {

It seems better to switch to _scoped() variant at some point.

>  		ret = fwnode_property_read_u32(child, "reg", &reg);
> -		if (ret || reg > AMS_PL_MAX_EXT_CHANNEL + 30)
> +		if (ret || reg < 30 - AMS_PL_MAX_FIXED_CHANNEL ||
> +		    reg > AMS_PL_MAX_EXT_CHANNEL + 30)
>  			continue;
>  
> +		if (num_channels >= max_channels) {
> +			fwnode_handle_put(child);
> +			return -EINVAL;

-ECHRNG

> +		}

...

>  	if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams-ps")) {
> +		if (max_channels < ARRAY_SIZE(ams_ps_channels))
> +			return -EINVAL;

ENOSPC?

...

>  	} else if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams-pl")) {
> +		if (max_channels < AMS_PL_MAX_FIXED_CHANNEL)
> +			return -EINVAL;

Ditto.

...

>  	} else if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams")) {
> +		if (max_channels < ARRAY_SIZE(ams_ctrl_channels))
> +			return -EINVAL;

Ditto.

-- 
With Best Regards,
Andy Shevchenko


