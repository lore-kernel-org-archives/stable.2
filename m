Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793282234;
	b=g3jsXI7bxLXGcpOkrsvTJc9LVlMZBX+3BQK0uuQHipsBox8uagnuzagvoF4XE1SIss3f
	 gUiF2NzkcHyuo64LlpIh+a1L7h/R0WrpOh1TmTAVIpOt3LkihYL1VTHH4+LaIgOLOprg6
	 zh0HrfNLcVxgjCz7i42rKI3JrkqkaVjmEMltlzvTPHbcQlLBL0in5IuFtd2GhBWV0N4CO
	 gE5WMzrp3Pc2NlmxKomPok7ywAIFPJfJRsMijPCz6fkoRXRIfyDIkGKy8C25bMCQwk0Sf
	 dTqL5keDlGBnFIeb8c2qGsPn/x2q1LnIzFXDSHIvcP9FsU4et0bVVTjl9HSfr6709LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282234;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=NiX/cLR+QfDZhplLTlVQLvgD5zI9h5feELCeYcvxbYE=;
	b=bd3p42THB85veCNrslDVTvkp5B5WrVs5X5POMRLEzfdcamD2U9BgmS4uDkc+d70Wn5MT
	 Lu2bLjjYd5HZsHri+bJ4//dVaqhtgtw43iq2KxY+sy0+WfP33kjp/olJnkEogPmpupfGC
	 c1S6f5JIxkvtLdNz4jNtPCmH4e3kiKFpqbNAkg8AB66HSKhNTtj9JIQcqeoE9pVk/J2j4
	 EduQ6A1nXdUl4DBLfpX4LT3MNYrsWSMWUsKZuTumXeKbK5hyFv1v/Iy8GgauhVRtOo8v9
	 oc7/d8CeW09STLGXpFK8P3Sd/3NopATLZo+qd0E3TJVsfbUe1HZ90fAZAxEKlWFJ64Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LWh1OtRI;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D0D606A31D;
	Thu, 29 Oct 2026 13:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06D0D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LWh1OtRI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793282233; x=1824818233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UTwuOZzBKT+oSeIKRBmbdLB4Bl52OeZiXuXEIQeBCAY=;
  b=LWh1OtRIVDdxnDPmaIBw8RNClw1ZA44Tt9nPL2FPVvaifGdZ6/TeO92Y
   WXdGhy/o/C2Id1deckQW+YTEAOa5bsyLi8yoSzhbKCm1/Kcvrw+sBfD60
   7+dATvjj8o/LvMazBjR6ivr4vek16MtpLZBD+PRD4E2Pct/oYJrhfkdRY
   Mi2A/234pABT7nwP4R8vn7QK44pyxDIogvbRoXEVhxaYu+fTCvFwygdNu
   fn4WXUse0Q0NyPz0YLHSLWGG98i26dEPeJyntLSg7lrKe2CDW2sihxJMs
   1oZSlCnv1VzZV5AA+RAa31XV9/md88GP15nP6guVCClzZsQMaOfPlkhJK
   g==;
X-CSE-ConnectionGUID: uNtvhw8+QGqlkW5EPqFotg==
X-CSE-MsgGUID: 1IRrpUrYQRGsPvrkFz4ZiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2022198"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2022198"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:57:13 -0700
X-CSE-ConnectionGUID: 3L6qMBxPQHGxrz9O4tQEmQ==
X-CSE-MsgGUID: 3h8p5xRmSp6MI0Cr4QH+iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5050203"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:57:10 -0700
Date: Thu, 29 Oct 2026 15:57:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Antoine Pichot <antoine.pichot@gmail.com>
Cc: linux-media@vger.kernel.org, sakari.ailus@linux.intel.com,
	mchehab@kernel.org, hansg@kernel.org, dan.scally@ideasonboard.com,
	djrscally@gmail.com, dmanresa@gmail.com,
	dave.stevenson@raspberrypi.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/9] media: i2c: ov7251: Use in-range PLL1 dividers
 for the 319.2 MHz link
Message-ID: <auNQs08xnsmvr8bI@ashevche-desk.local>
References: <20261028112154.855185-1-antoine.pichot@gmail.com>
 <20261028112154.855185-2-antoine.pichot@gmail.com>
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
In-Reply-To: <20261028112154.855185-2-antoine.pichot@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 28, 2026 at 08:21:46PM +0900, Antoine Pichot wrote:
> The 19.2 MHz PLL1 table for the 319.2 MHz link frequency puts a
> pre-divider of 1 before the multiplier of 133 and a divider of 4 after
> it, so the PLL1 multiplier output (the VCO) runs at 19.2 x 133 =
> 2553.6 MHz before being divided down to 638.4 MHz. The OV7750/OV7251
> datasheet (rev 2.12, table 2-11) limits it to 300 to 800 MHz.
> 
> Use pre-divider 4 (register 0x30B4 = 0x04) and divider 1 (0x30B1 =
> 0x01). The multiplier output is then 4.8 x 133 = 638.4 MHz, inside the
> range, and the MIPI clock stays 638.4 Mbps, so the link frequency does
> not change. The Windows driver programs these values for the Surface
> Book 2's Windows Hello mode.
> 
> On ACPI systems this table has been unreachable since it was added,
> because ov7251_check_hwcfg() selects the wrong index. The next patch
> fixes the index, so the two must go in together. With the index fix
> alone, a Surface Pro 7+ (IPU6) had CSI-2 errors in 7 of 10 150-frame
> runs, 3 of them stalls; with this change 0 of 13. A Surface Book 2
> (IPU3) streams clean with either table. Dave Stevenson measured on a
> 24 MHz Raspberry Pi board that the out-of-range tables miss their
> nominal frequency and proposed the same values. The 24 MHz tables are
> left alone because nobody in the thread can test a change to them.

> Fixes: ed9566ce1946 ("media: i2c: Add support for new frequencies to ov7251")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/linux-media/6ae0e944.b6db0abd.16b13d.d261@mx.google.com/
> Link: https://lore.kernel.org/linux-media/CAPY8ntBFJJPg3y46gC=bNq_55QifC7mKmeq8+pAEDVN42fGUXw@mail.gmail.com/

These Links are not referred in the text above, make sure they are being
referred, otherwise Linus T. becomes grumpy on this. On top, consider
using Reported-by and Closes tags if applicable.

...

Code wise LGTM (I followed the discussion).

-- 
With Best Regards,
Andy Shevchenko


