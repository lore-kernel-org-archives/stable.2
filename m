Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795463994;
	b=AHyORLUos4UnAG0hVObUK2tAjbJgRYb89alz4hPbkKHuEOUH+7/tDevPGlMfxAGtsP7S
	 y8jHa6MYNjCeDPw7dbADvJXw7Riq3JFjVMJ1DvNOrJwZIxHWZ4+VGqOiVYMYgI+IvfCRo
	 XipHaSSgGASzvzBGdYaoWwmif95+pCkSv/IpUTfNJZ7IFxqmZItf/X+VhVnqMD2adVj7b
	 XBwDQ94tZd7Ytr+M0z3SCBGdtY5jr8lZFDVMP9vkL00dHAU3jnlo0OVN11X0HOTSmWwPW
	 44LzTahGb7KpkV3AVRW5GJ6VoCm+PsHNqhNx2m2ovQGwIcrbAhzMoNJev/My/unU2Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463994;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=VnWSxFaUVuxiW84dDR6jvECz1EePG70MQgT5lhO/mEg=;
	b=vTYydvvfecr4RmwD3zfAXhKz65pM/oVdnKvqbRUtT2Ql9c7h3ytqfRI58d3Lea9MhM0u
	 kdrr9vAB4PuTzRI40HXRIRNaS/dLInWhO2gGjYiN0NMF+gI1vrL9+v7FUjZ/YckBi9YIy
	 hwoMG4OTmqIsYzTGG2YKOpp2xZCn4kiVP9REMvqZJdy614r9Ke3YJc6Iby8wTqDNK1EJX
	 uavROXqu3vYcuT+gt9ORmtjCByLpQ6ZPAXg/X+8N2qF9nu0bkhSFjR1YmLnSDu5cRopqD
	 SaGA31oZ5eNN6W8C3yrIfpeZp/Jxheoitna8mprWiNlGcmGvCCpoBtKRebjcFEFZZ0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EW+rqPdU;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C3D606A31F;
	Mon, 23 Nov 2026 19:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72C3D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EW+rqPdU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795463994; x=1826999994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bOZSvA0T9zHXhtArb6Sh+ZDBy6QosyZtjxvqLirZQpw=;
  b=EW+rqPdUTu5P9tf7RLn39Bol5d+Q724jyH+uuhXqFggBYTTaTcqymQo2
   nVeHrADTAREeljnYAl75cDc6tbkYXmfdCTz4XIms6TuDC7vqgKatJSUaZ
   VJqyVwvfel7bF0UxY0GaSjhgI/fhLpbmoIC+TD4Pqt52nWGCBT/+ShPAO
   846ccd974bcEIf73b4lboTrxylmGoRQzBx+1JO9HEBmiLsjPPipswWZbB
   K56jBw396IWQWeiPxUdb84E4OWtMHU1oAiZIAg5N9AJOBkzOgSAlbxeDt
   2nRsFIlXBFbBcBKrPHhknj9BfS2PC0529VGQx2BB6EWfFFlbygxIjnJrt
   g==;
X-CSE-ConnectionGUID: FYI3+OIeQmSE43YIqwWrkg==
X-CSE-MsgGUID: ZUG6T+70SRixgHC1L7+u2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4183866"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4183866"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 11:59:54 -0800
X-CSE-ConnectionGUID: 9/x+MlM5S8Gl34imdVIdTg==
X-CSE-MsgGUID: X9FxcLxVTxm0+8ihuWDNNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11341718"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 11:59:51 -0800
Date: Mon, 23 Nov 2026 21:59:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Gary Wang <is0124@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Daniele Cleri <danielecleri@aaeon.eu>,
	JunYingLai <junyinglai@aaeon.com.tw>,
	Louis Chen <louischen@aaeon.com.tw>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, BillyChou <BillyChou@aaeon.com.tw>,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/5] upboard pinctrl support for device id INTC1055 &
 INTC1057 & INTC105E
Message-ID: <awSbNCIxmA3baoRY@ashevche-desk.local>
References: <20261123-upboard-pinctrl-add-intc1057-intc105e-support-v1-0-f2322a91686d@gmail.com>
 <awSa447uHSd9IAXt@ashevche-desk.local>
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
In-Reply-To: <awSa447uHSd9IAXt@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 23, 2026 at 09:58:32PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 23, 2026 at 11:16:13PM +0800, Gary Wang wrote:
> > Add missing groups and functions in Tigerlake & Alderlake & Meteorlake
> > for INTC1055 & INTC1057 & INTC105E.
> > Add support "UP Xtreme ARL","UP Xtreme i14","UP Squared Pro 7000",
> > "UP Squared i12","UP 7000".
> > Fix pinmux-select set CPLD GPIO OUT not function mode for I2C pins
> > on the AANT0F04.
> 
> Can we actually see some activity to eventually implement a missing part to
> support PinGroup() and PinFunction() ACPI resources? With that being done
> this information should be provided by BIOS.
> 
> > The pinctrl-upboard is provide additional driving power & pin mux function
> > through native SOC pins->FPGA/CPLD->hat pins for flexable board level
> > applications. it's probe from ACPI device id AANT0F01 & AANT0F04.
> 
> It's cross-driver series, is there any compile-time dependencies?
> Or how do you consider them to go?

Ah, seems AI generated, no SoB, this unacceptable contribution, sorry.

-- 
With Best Regards,
Andy Shevchenko


