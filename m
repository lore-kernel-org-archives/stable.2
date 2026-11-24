Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541671;
	b=yMjWcjp1ZmBdmOUmZ13Xnc+p/W/bp/VtF385H7FEk/at4gSPgPDIPZfQYSSdcqhkooVL
	 HoV++rzMms0YIhH41QaVF3INM+jQksBQXPdS1LN565Oc6epjL/A9XtfXdgBtouYQUnsU0
	 56IdTCBTi58Xtpq23IeG7zI4uFX4iNXkDEOZu/2eMkSqkFT6mhp1HVPCW4VmpV1WWm/GW
	 RabHIraNRbmujHAwyVWecOvEO8stoLMM9gcheYthGyRQZF8gxNaFgQWhCm6xEYkNGbH10
	 QkvdYkXMPGe51fgzfQfmYtqn2OXO6Ny7cmCXV+5clW2abtJDp8GcJBBl9wcfVBGw+1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541671;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=YXBT5fGxQzpSmmec75glwmrejQd84gFLPpxZUqqqdPM=;
	b=SZHyRZpTgHTn6VhQDnRrSQPQ/8aldFBS2kdr5jsi1AoAtU2dH9niUkBQfJPFmqP+cr8z
	 cRRCRHFZofyN6udlYV6h3E0w9ZdYdEoGoPhGe0oaE4QMVWa8oUNwL7yUwuMPWoVj+dqt8
	 sEED3hQrk7z/r7W0avS0WfMHuKDGdR+uuTYtOZMmCHxUwJ1PnWvJ2vaQcO1v/2GAy/H2P
	 iLCCI8B5/Z2FRQ8THihB2KyPR1Lg6kc0T0SyPaWXl7thLKLaBNZ/qnOHlx1seHgcM/Qqq
	 iOjfHFqPPkC3hyRMwya3JczIqbyZ4FxlGxiqo4DJVNp3XMeBMfxf107t+HVDpcT321w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h0kk+JRp;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99023606A31E;
	Tue, 24 Nov 2026 17:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99023606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h0kk+JRp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795541671; x=1827077671;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rLTuWyHOEyXqppVXDLcqIEYXn4SkZFYPT8aClEe3ty0=;
  b=h0kk+JRp+fKQdlzyOFwwVRkCymQZ/o3w6twbIl/y4yYueIA0lRT9MG+D
   uRQJ8XCxrH81GLiSFHpP93FakP+4+CS15ONT0whgWtami21FcIm9VERAU
   kfAI6zoFwvJ8VxoHirisr1GykQqRELi6DH3MVUhQgsf8mooqUjpvkTezL
   VXfURzBd4khfXwQHZd6aj7loLSSM+2PNJz2hTqCqwum4YpucbZrmEWLC3
   kA6lOh2JwONR/E+FjrZK5Fqzrj7MlCZrDHJrKhx3/tPgsll3Fb5BDV8EU
   Z0HAn5fF6U72jt3T2xXn9lS7+Jqzmjgeg2zqlKtzbbUI1u1MCrdV6dZBY
   Q==;
X-CSE-ConnectionGUID: +kKZRzPiS3W3Mc9PaZYrdA==
X-CSE-MsgGUID: SezB1vfDRbOqlhqQODujEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4288890"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4288890"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 09:33:15 -0800
X-CSE-ConnectionGUID: IUmLkCgRQKSS6IcN2EHBJQ==
X-CSE-MsgGUID: yrwsXoOlQFeUpPQO8X3s9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="11921018"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 09:33:12 -0800
Date: Tue, 24 Nov 2026 19:33:09 +0200
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
Message-ID: <awXKVXS0kIGnA0lD@ashevche-desk.local>
References: <20261125-upboard-pinctrl-add-intc1057-intc105e-support-v2-0-c8079f8f569f@gmail.com>
 <awXJd59jTHM2bIlD@ashevche-desk.local>
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
In-Reply-To: <awXJd59jTHM2bIlD@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 07:29:32PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 25, 2026 at 01:10:34AM +0800, Gary Wang wrote:
> > Add missing groups and functions in Tigerlake & Alderlake & Meteorlake
> > for INTC1055 & INTC1057 & INTC105E.
> > Add support "UP Xtreme ARL","UP Xtreme i14","UP Squared Pro 7000",
> > "UP Squared i12","UP 7000".
> > Fix pinmux-select set CPLD GPIO OUT not function mode for I2C pins
> > on the AANT0F04.
> 
> Make the above bullet points to be a regular English text which explains
> all this. It sounds like the second sentence should be first to start
> with what is this and why. Also don't blindly copy what AI provides you,
> edit the text that it's correctly split on the paragraphs and in each
> paragraph use full line length (~72 characters). Each paragraph should
> be separated with a blank line.
> 
> This comment is related to all commit messages in this series.
> 
> > The pinctrl-upboard is provide additional driving power & pin mux function
> > through native SOC pins->FPGA/CPLD->hat pins for flexable board level
> > applications. it's probe from ACPI device id AANT0F01 & AANT0F04.

Also you ignored my comment about how this series is supposed to be applied.
Intel pin control drivers are maintained by me. The rest by Linus. People
won't go through the code to understand if there any compile-time and/or
run-rime dependencies between parts.

> > To: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> No need to bother Mika, he is not maintaining this code anymore. :-(

-- 
With Best Regards,
Andy Shevchenko


