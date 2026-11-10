Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296330;
	b=nw/nNbHCgTNjG/eOKLzRME2eeFreg/tMRGDvoiNit7LJUBnXvgsMhW45Zl8tpjYuh7bM
	 Jem3A1pQCUEDA9bAStwj9GqxPC8Rt6EaWsuuUJw6p7vqpUHE9fxS1P8d8Ko4LFypuJr96
	 QxM/azcwwHpcR2CDfTEv4lXIZsSNu9Xz+pLUJIf549p/MHZ916WPlfkZjp2jQW5UQXcc9
	 VW2B8Dwox5U9Ona3WkM6xlVf9iJ12amg/IlaZj+DrWkPB3IO698wFsEKYwl40IDTYu4J0
	 IsPGtrgqk/v1QIFkMqVPQLnV3QJhU/Xexl2C9FOIURalT2yNmfpRAUGO37CBGw037/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296330;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=8t3XsmkH4X5jtPd+1XnonFJPOxRdvH+YlQwa+M77eiU=;
	b=dxtnnFbFcj4lzoEt2bp0ZbaT4m+zjlpja99GQfFQq6fmY/USBkW3BoFlClGhOYN9E99U
	 J7NoSpINnoTJ+ldR3eSGgZOC+392rOpEkip9wws3qDflAXXvmM+wIrRwCD+d2TWaMD4Zp
	 PqIUntDIBPJbWCiQTq2QMwPdUV67KlXSE14POPW1NV7wMCSfMpbH7+85AYTO4WlLiVkEo
	 7hkE1diQghplcQKqxUiuv+BZ+vrAbnDU4is/YLQJyXVGELS1sqTpQezWzcL2UwlIaLvW1
	 FBTAiWpkbFU3C6gzsI0fJR3+7zdjt2ZDi+GfyfJg2UFqWTwHSlFVxgwv3back0/fOXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WJI7vfhE;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F88606A331;
	Tue, 10 Nov 2026 07:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1F88606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WJI7vfhE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794296329; x=1825832329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CmpiFBayGQ11aSA55tG7scFVqAlN/E57mwp8MKmRI+Q=;
  b=WJI7vfhENbb1EgmCGh157pXzEnmwr/ewFvnWNOAuDJeKFebKDyYS4EFA
   tFUKacnaTQvDhMIAiWpeQwRb+ZHcwsQkAztS3a87Zbkd7BCy3e8C6E6Xh
   gfpl8rSKc6+bNzA87s6V0erH09eUxq4/YgrSH8sDLd1KDtoP3aS/kYVsC
   2ZSVNDU1XWAif6615y8QM8Ze9I1kDFFmO5S/pkcFtbAaSCrDeIcna8DJd
   XTAUerncVQjLu8HcJ16c/k+mIMRvZ9whBRsSlBt3BmPeUgaUGPmrb672i
   g4PLoJSuohgEzhZ57E9Fn9x5kLwiEE4pX+q4rrFgrn+WRCZHYbksV5i5E
   Q==;
X-CSE-ConnectionGUID: Rw0jUrUwQVCccNnuK/oHFw==
X-CSE-MsgGUID: j4u7HMnbSEil6nwm3Jeyng==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3069716"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3069716"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 23:38:48 -0800
X-CSE-ConnectionGUID: +A52Wz9vS/GrJkZUz+DobA==
X-CSE-MsgGUID: sd++91SqTZG3OrqooQ0q7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8660899"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 23:38:46 -0800
Date: Tue, 10 Nov 2026 09:38:43 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Sergey Khimich <serghox@gmail.com>,
	Sia Jee Heng <jee.heng.sia@intel.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dmaengine: dw-axi-dmac: poll the correct enable
 bit during termination
Message-ID: <avLKA9He_lz81Kfz@ashevche-desk.local>
References: <20261109-submit-dw-axi-dma-stop-pause-v1-v2-0-64adc48df793@gmail.com>
 <20261109-submit-dw-axi-dma-stop-pause-v1-v2-1-64adc48df793@gmail.com>
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
In-Reply-To: <20261109-submit-dw-axi-dma-stop-pause-v1-v2-1-64adc48df793@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 09, 2026 at 08:06:00PM -0700, James Hilliard wrote:
> For channels 16 through 31, the channel enable bits occupy bits 32 through
> 47 of the extended DMAC_CHEN register. dma_chan_terminate_all() only reads
> the low word and tests BIT(chan->id), so it can conclude that an upper-bank
> channel has stopped while its actual enable bit remains set. Descriptors
> can then be freed while hardware still owns them.
> 
> Poll axi_chan_is_hw_enable(), which already handles both register banks
> and the smaller channel layouts, instead of constructing another mask.

...

> -	ret = readl_poll_timeout_atomic(chan->chip->regs + DMAC_CHEN, val,
> -					!(val & chan_active), 1000, 50000);
> +	ret = readx_poll_timeout_atomic(axi_chan_is_hw_enable, chan, enabled, !enabled,
> +				       1 * USEC_PER_MSEC, 50 * USEC_PER_MSEC);

Indentation of the second line is broken, and the first one is too long, check
how I recommended to put in my reply to v1.

-- 
With Best Regards,
Andy Shevchenko


