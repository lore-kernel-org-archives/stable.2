Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795544349;
	b=ypuOriz5/zNZzjXjJIhX4aRVcoRVxMXBgbIf/Cv6PE7YqsRCnqsVM4O+HCLJ99ilV9xo
	 4PYoewElbhAhr/2DBOUcwgmaDoi3XU29A4zK8vC94ctH3Hjo4ao1pnQ3hSGV+8qaimxot
	 SduMhPXdwGOeHHH74uvMIdJFPsP8eym6cAXOLqllenduaj64lmTlltpbK7pG6uzXEvwId
	 7l2nQcDZAhfb3B0B8FKqlgYhzqsgN9417zKHn4EkMjsi8sulnie+uVWMQvEM+nB7ciX7I
	 RVppfUa9CK2C/7PShW1r4kj8cA7UC2mMk9U+gWAI3h2vWeh7CZWFi8Gn9ys3Ms/38ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795544349;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=AQDvl+X/Rd7CTblufTQQVMUfiWZM3uTTjJQc3OJZx7Q=;
	b=aXglLryvVZOZ7uUpRD5CTKv5ohmhG4n/LAdSvqujg7lrO1ofVJzs40dFvKvHzORN/+kZ
	 vlMptk8bu9ehSbqpb5UAUbkuLZWABwQ91HoG1Q74bUJLs9tOrUwcw4Tyea9uw5fZPVqf9
	 EB8PEtrbhF6W0fHgeW7J+aYMQ7xnSWVtaVd/qhiUuj0OMOdXD7Mqq1PEIAsqPe9Pw6YiB
	 2G8Szi5qrlQFHK6adTrTVj2OACYd+FLNgxbfDVFDjQscDr5HSPtjK3IEW/58jgiRPYLJN
	 fi4t/Bz2mSnr5MkEbW3sY9c04NX7RL8cG3yiNsOO/64rQjsSmwIMbRzyhWUpOjimc+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=POzmhQx3;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978E3606A693;
	Tue, 24 Nov 2026 18:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 978E3606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=POzmhQx3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795544345; x=1827080345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cGOOjqPPP9DPkFeOPFRhFkHSbuP38nKReBfH3FUCAbE=;
  b=POzmhQx3m0OUOjVh/RghjCe1fIigdvb0UIWmOTDuJpCpElEwy1gxPVi8
   +/zZQa6dno/eOjJ1RiTWHTd5zPxRXdoobQuO8e8Nja8piwpSqf0JqULb8
   z96501sXbtdulyW+1m7vJmyRfnKR/7TmbrcryWrwqqXX0IgYFla63mRuG
   m6+D7NLNQRVg3fLxru52gnvRfEgnX9H+bxEaA9vH/jL1wjR26lgqKOltM
   aZWZEm6irqtjaP3cb9EchMlWxwnwoFwj1X3Osz9Crx6u26DoMgfxgLkqo
   w+xPafk+68CQc/kABtmk5OGk8g831up+aA7ciwyMUkalwRpbiNTdQfQ9x
   g==;
X-CSE-ConnectionGUID: QSzmKrTZSuWGar5qsvLqKw==
X-CSE-MsgGUID: 9qz8dTvDRtihPm3iwh7P1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4399210"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4399210"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 09:39:21 -0800
X-CSE-ConnectionGUID: aG2WGNXrRwGhCUHCYttOyg==
X-CSE-MsgGUID: LB0DQFG1TTGg3XNiumhbnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="11819137"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 09:29:30 -0800
Date: Tue, 24 Nov 2026 19:29:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Gary Wang <is0124@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Daniele Cleri <danielecleri@aaeon.eu>,
	JunYingLai <junyinglai@aaeon.com.tw>,
	Louis Chen <louischen@aaeon.com.tw>,
	BillyChou <BillyChou@aaeon.com.tw>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/5] upboard pinctrl support for device id INTC1055 &
 INTC1057 & INTC105E
Message-ID: <awXJd59jTHM2bIlD@ashevche-desk.local>
References: <20261125-upboard-pinctrl-add-intc1057-intc105e-support-v2-0-c8079f8f569f@gmail.com>
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
In-Reply-To: <20261125-upboard-pinctrl-add-intc1057-intc105e-support-v2-0-c8079f8f569f@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 25, 2026 at 01:10:34AM +0800, Gary Wang wrote:
> Add missing groups and functions in Tigerlake & Alderlake & Meteorlake
> for INTC1055 & INTC1057 & INTC105E.
> Add support "UP Xtreme ARL","UP Xtreme i14","UP Squared Pro 7000",
> "UP Squared i12","UP 7000".
> Fix pinmux-select set CPLD GPIO OUT not function mode for I2C pins
> on the AANT0F04.

Make the above bullet points to be a regular English text which explains
all this. It sounds like the second sentence should be first to start
with what is this and why. Also don't blindly copy what AI provides you,
edit the text that it's correctly split on the paragraphs and in each
paragraph use full line length (~72 characters). Each paragraph should
be separated with a blank line.

This comment is related to all commit messages in this series.

> The pinctrl-upboard is provide additional driving power & pin mux function
> through native SOC pins->FPGA/CPLD->hat pins for flexable board level
> applications. it's probe from ACPI device id AANT0F01 & AANT0F04.

> To: Mika Westerberg <mika.westerberg@linux.intel.com>

No need to bother Mika, he is not maintaining this code anymore. :-(

-- 
With Best Regards,
Andy Shevchenko


