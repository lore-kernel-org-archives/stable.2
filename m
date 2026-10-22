Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792675263;
	b=g9x7Kxi5P76nneFFhL71eD7l2iRxczZyWnja58awi3iDT2RYvDd5sL+zW77az/QE2ufw
	 9DYcIhtHtj6IHeat5KEVx7fbjuo6peZJQCCDNqZCEhNYvWfYp9/rIotMdQXfrnRNKUWGb
	 o2onKzb3P2z3yRt63E9DRujFuPuNq91v4SCCgnsSnif5fJubIUEsO7P7Nbjl825uudfDt
	 faydzD35LNtSSMWonBKEpvi+t+ZEKEgQofZMQo9kMaf0Pakt39eM4kkSFPWrO51DPspm1
	 xa5Mu8GjsJgrreYMlzljUk4m+hEOui7bIHM3jKTfYsTBW1obqBVw4br/QIbe+ONMlUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792675263;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=J1cJunRtziCQSI57V0U3l58lyDmUupWkdJUEjrp/6ac=;
	b=rpR7kpNpbKIYpQ1KxFWRzL3NbULT0yhdpyoRIXDSsppEvTavjew27YJFVxWDq2mZPCdo
	 8j93t46W2/Zc5SnaX0l3g6diztMGS59KI/ZS2mpGoBBaaY/qBGVDwsUlPuGufQPqCQ+HH
	 AEJdNfVdo2j2Za3D8uilo3pmb6cYRI4Xpk6ycXSlqGFe/gHi2g43HYYc9eCy7+mPNZkCZ
	 tzo/+9fbJLj1C0wmg7OQIqI2ZrrkPnmQdFF17Fdr/WQDkfRyWPoBCF809f9Dupqe/qIM4
	 nKodkJDq2jo/FMcWiYiRrZpanFCI9wJIGkdu/6Rt7W6ohHITYDyXUmIz1AiuqrWrkUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ee8Yj8lF;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F9F606A31F;
	Thu, 22 Oct 2026 13:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99F9F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ee8Yj8lF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792675261; x=1824211261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RPtVW+zJYuGYEvqqnTvxnUJoTo1amg8ZRAWoVfiCZ18=;
  b=ee8Yj8lFP3xZ4G0Kk9wK363HLDaSZ95iOWqRtW2aTWS81hHDvDVnOVjc
   y8lFbglR03fmeEqpgnCzF8jw+1Vq5XOBg+Z/RhwjodOeH6BmOyrQV+MZu
   YlOAgjupMBxrOKFlAIEUFpur+B5UnZxCqdzZURxDWxIzWCwJ/jdd98w9F
   yH1rGv9IEa2Mqym+r/5NkaEeZ/g7nJ1nBnkSHLCFdH74ymJiihXqPYs3q
   v1TLWvdyqdMliXEhGFTPch+KPQPGHrxfQCRYceQ17rOjeT+745xSDQm1L
   UAmRGxzjKSlRFE3SpxNhJ1lWQwNijXjRxpKcywNA02ZoJ1xQOhmuqjFPq
   w==;
X-CSE-ConnectionGUID: hwwiFS/sRiObncYI47L/9g==
X-CSE-MsgGUID: KcC4JQZ7Tim7S3WcSkkkeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1456206"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1456206"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 06:21:00 -0700
X-CSE-ConnectionGUID: 81646FC0QK+lTVLsXp90pg==
X-CSE-MsgGUID: Ef+DEytISBOPzyqcvoN+FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3293950"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 06:20:57 -0700
Date: Thu, 22 Oct 2026 16:20:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
	Manish Narani <manish.narani@xilinx.com>, stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: xilinx-ams: fix out-of-bounds accesses when
Message-ID: <atoNtka8rCO3Cil3@ashevche-desk.local>
References: <20261021225356.625288-1-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261021225356.625288-1-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 22, 2026 at 04:23:34AM +0530, Arnav Kapoor wrote:

 Subject: [PATCH] iio: adc: xilinx-ams: fix out-of-bounds accesses when

when what?..

Please, read what you about to send. Most likely you used AI for all this and
hence people tend to stop checking all the crap it produces...

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
> ams_get_ext_chan() and fail with -ENOSPC when a module does not fit,
> instead of writing past the buffer. Also reject reg values below 20, as
> the binding requires.

> This was previously reported by Weigang He, but the thread stalled
> before the changes were picked up.

Convert this paragraph to Reported-by, Closes, and respective Link tags.

...

> +		ret = ams_get_ext_chan(fwnode, channels, num_channels,
> +					max_channels);

Perhaps a single line?

...

>  	if (fwnode_device_is_available(fwnode)) {
> -		ret = ams_init_module(indio_dev, fwnode, ams_channels);
> +		ret = ams_init_module(indio_dev, fwnode, ams_channels,
> +				      (int)(ams_size - num_channels));

Why do we need casting? is ams_init_module() is aware of negative numbers?
If so, it can also be aware of some "big" number.

>  		if (ret < 0)
>  			return ret;

...

> static int ams_parse_firmware(struct iio_dev *indio_dev)

>  	device_for_each_child_node_scoped(dev, child) {
> -		ret = ams_init_module(indio_dev, child, ams_channels + num_channels);
> +		ret = ams_init_module(indio_dev, child,
> +				      ams_channels + num_channels,
> +				      (int)(ams_size - num_channels));

Ditto.

>  		if (ret < 0)
>  			return ret;

-- 
With Best Regards,
Andy Shevchenko


