Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707097;
	b=s6sbYu/SpdFDMYnKYzIBU2im37Jq//qfy3uWOSbJ9Rg5MWFA2KMRZnXsYShmIqoS6shX
	 FTCwUyrdjl+bW1X/B7E/NDkY6HXy3yMGnu1j6UCxrVrISXWFHNv4ospBhqE9zS/zVnYNX
	 50hsSYv3j3mLGGerf9gzEW1xWJ/vIeoFkc9kSFGGARPXsvGWCGQvYJ8xl6K094xWMXkR9
	 VUPjyo1tP3cIgM4/mFEWwJZnECinr5BGcor/J7EAz81qT50gWEreIgD9LDVlVBq3Dmshb
	 GGsFTMwqDXRlYFbkR8+VhJZdCHvNgC5ODYA9FfMr09aFaU9RcZqxYe2lg1vg+4v67NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707097;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=tQNqYmCO8U6RJi6uvaLNBKhLSSUT6e27NTsnReOP5Uo=;
	b=rhXAwNSmxKy6E100zqoNG6SwG545n4GbjUK5dnotj7MwyTOqXufrh6pbzXH6fnsjOKo1
	 G0wAEKX7+CihgAMJb89+5ldiyD+vT/RiOMXE+CC8RPJEvrNDI2q0IGSEQQljk79O8HJ2r
	 6rjoWY2fzBBEFKtI0TsGKIj9HaVtLA07c9QjsovMeLOfgiRTyRFrFhxeNGE97SVgy+Ptg
	 QKGPj1fvo6lNNGWvtlKtzl4T0Q8CiM3sKX+l+qRsdazGgCpRH7dFjFSz4bmvkGQgbwhw8
	 UKSbU6/951p8WsAumHI978K7yzsldNo7BVWgNY1Im1XwKkKcuvqu7UpTZ9l373yOlbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="fU/Go9g1";
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0F1606A31E;
	Thu, 26 Nov 2026 15:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D0F1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fU/Go9g1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795707097; x=1827243097;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WPpUQImv+mfRbVWcaasBa39HKBziPr14wNhR5TVYdI4=;
  b=fU/Go9g1OFaAdID099iAo1f3CjQJnuHjpzB+gSEZXcgGYK3joXNmjTBF
   vH6EMDMRf8CwXpSKBHY/qLPMt/x2HtUNlJ10Bpaklk4L15z2SlIe6hmM3
   OVA0kxHDLLlk2dUSAZpLYjRt2sp4CMzoFdlLOjc2gVZv9149KDZqRhFHb
   ffwYiOwPvqiQAQDyD4SYjdxV9tN1RDTx0ERLT+YB4RvU3K2XMozjvPsvP
   8BGCPwhSZrzD9z+PGXKO55Ur5YSU7cQ7ROLRuBqBZzT5v81l5JwBNeXh0
   IWrMml4nBV+gNvjSqRCwABhQKXDPwU3jnqy7sw3V2haOLlRvCifiDCxZL
   A==;
X-CSE-ConnectionGUID: ze0PDmWNRoq3SCUEVEUnCw==
X-CSE-MsgGUID: tiOYv10HQWC+a+SZ0AwcOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4617975"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4617975"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 07:31:36 -0800
X-CSE-ConnectionGUID: HSpzvcUSRaa7pSYZQB7NhQ==
X-CSE-MsgGUID: z5WCboktQ6OpjR5IViJMlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="12528604"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.208])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 07:31:33 -0800
Date: Thu, 26 Nov 2026 17:31:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Gary Wang <is0124@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Daniele Cleri <danielecleri@aaeon.eu>,
	JunYingLai <junyinglai@aaeon.com.tw>,
	Louis Chen <louischen@aaeon.com.tw>,
	BillyChou <BillyChou@aaeon.com.tw>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 4/5] pinctrl: upboard: fix I2C pinmux-select set CPLD
 GPIO OUT not function mode
Message-ID: <awhQ0mvdzSw9NaVM@ashevche-desk.local>
References: <20261126-upboard-pinctrl-add-intc1057-intc105e-support-v3-0-81d35c9ba246@gmail.com>
 <20261126-upboard-pinctrl-add-intc1057-intc105e-support-v3-4-81d35c9ba246@gmail.com>
 <awhPbIZjDazImfBf@ashevche-desk.local>
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
In-Reply-To: <awhPbIZjDazImfBf@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 26, 2026 at 05:25:37PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 26, 2026 at 11:09:47PM +0800, Gary Wang wrote:
> > The CPLD I2C pin mode setting through pinmux-select is not correct.
> > Should be set UPBOARD_PIN_MODE_FUNCTION on AANT0F04 devices.
> > 
> > Set UPBOARD_PIN_MODE_FUNCTION to 1 to prevent a NULL pointer
> > dereference error on .modes[i] for any pin group using this setting.

Hmm... bit how the modes[i] can be messed up here? 0 is integer
and NULL is void *...

Can you provide a compiler warning or traceback of broken kernel with this?

-- 
With Best Regards,
Andy Shevchenko


