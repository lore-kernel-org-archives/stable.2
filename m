Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795463914;
	b=QbGmBdYRYBMsA3FFiHWlM1zkjULl0KIO21bTvKwCE84saWmqJtUw6Dh553Y6xd3cxkyK
	 oCoeIP4yYSKny5LLj+Y36kh/dCeOenu325pGxsgbFFERJCHDgilS1Fh5WbgEB2L0jp7dy
	 SWdmvkLlGYqWjjDm2n6s9CzaWcOWbRBy7GI7EcLsUnLq0bSWwXwjO7FLRjuyUa62DRRd8
	 AlNhQTdzJ3T1Xvsnlt+JtFphtRGNUxKtogSNAe1JEphFxyCzWg4xHVlUz4eLId80uhQtL
	 DdhKk2DgvOyUhMayFXeVCEryy4QejQLwz2HXeu0H64x69cRpy3C6kK7CURTjkMI5Bcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463914;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Jbgjqw32VLBRaeFrxNCfaOtdz5dT39ANdUeCJfLoCZE=;
	b=WeT4JOwBy9EhmY4QMfRl+3MAZx3CH3iexKDiKLZlsY62A2j+eD4SDNedn683kIRxzk/S
	 y5VUvadQXFwLUTpQd2Lw6DSDsM/w6XZ3J9+7rzPrkT6uZQwg/rcvxGAFn++yCvy5Nbxem
	 hCnymlA37wTCfjCJuPFWrzYhUOYFvY6CKaTKHSx57j/e04VIfzOaGRw2dyhEYFB7FUYCe
	 u2J7IUYvBDxuO5TAtsJoB32KTn3vflsDzl9H4M/Fc30QoN39tk3wvREkK42H39P/dw5md
	 RK4CTad2xNsFa5Uiyq96tepuCFrCZtdbtCW62xmYJNv2/sD9Ob/QN89XLqCHm+NiMCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mKpDCKPa;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1599E606A31E;
	Mon, 23 Nov 2026 19:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1599E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mKpDCKPa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795463914; x=1826999914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=97YcdWLc2+JkIa8bZoIY0I1lj7BEeb8HYpmUcAy1Gro=;
  b=mKpDCKPaY4IawuaDnVJkHzZCJE/UUmUCAK+U+KQooNeo5SdZ4VUR2nto
   7h3XwBiX92q0gn4S2IKJyZNRZYEpCsU7AAQXSCOiKYBpisg5h1yXinHBA
   wxQQrT3SLKl4fgvAVPDgacBzrwgApbtZb9NyuAAMBGHjnW40mHcZaPq6V
   kMS9NnputU8a+ZOtNhgS8e2740J9u8yNml+tXr1jX2A712wo7ueMdo1Yk
   6EtRd/TFd4VsX65EHxN21RHV2bmsa/+V/Kniq6F2L8xN2m7OISI+yyyLx
   4KpDP+RyyLLPDjFjgicysLHtp3O5iUGBIg3zDsMmztlJbdB4tzRowI0/V
   Q==;
X-CSE-ConnectionGUID: jnka5orvSMW0mGSE8TCMDQ==
X-CSE-MsgGUID: mqEHItI+TVSm1pO2y2f64Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4262808"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4262808"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 11:58:33 -0800
X-CSE-ConnectionGUID: CcaAgwlcT8exNpy91VNXrw==
X-CSE-MsgGUID: ZC2uiqIYQL6TB4N6dqdSgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11756296"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 11:58:30 -0800
Date: Mon, 23 Nov 2026 21:58:27 +0200
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
Message-ID: <awSa447uHSd9IAXt@ashevche-desk.local>
References: <20261123-upboard-pinctrl-add-intc1057-intc105e-support-v1-0-f2322a91686d@gmail.com>
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
In-Reply-To: <20261123-upboard-pinctrl-add-intc1057-intc105e-support-v1-0-f2322a91686d@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 23, 2026 at 11:16:13PM +0800, Gary Wang wrote:
> Add missing groups and functions in Tigerlake & Alderlake & Meteorlake
> for INTC1055 & INTC1057 & INTC105E.
> Add support "UP Xtreme ARL","UP Xtreme i14","UP Squared Pro 7000",
> "UP Squared i12","UP 7000".
> Fix pinmux-select set CPLD GPIO OUT not function mode for I2C pins
> on the AANT0F04.

Can we actually see some activity to eventually implement a missing part to
support PinGroup() and PinFunction() ACPI resources? With that being done
this information should be provided by BIOS.

> The pinctrl-upboard is provide additional driving power & pin mux function
> through native SOC pins->FPGA/CPLD->hat pins for flexable board level
> applications. it's probe from ACPI device id AANT0F01 & AANT0F04.

It's cross-driver series, is there any compile-time dependencies?
Or how do you consider them to go?

-- 
With Best Regards,
Andy Shevchenko


