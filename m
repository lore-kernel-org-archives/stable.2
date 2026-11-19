Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088717;
	b=wo+ue4a3tpESK1Lmb7UYmUT6geDnMrjLxTElFdfamOd0qrNiJXgLp151CwZ/vbAE80+R
	 kMhV1Qh0Klpp5FkMvb1JATXya7loRccLtLPUBlQNHWnxywJthbPE1xHbS/PN2gTi9rs5o
	 srLI/MAtNUHV0pyaBX3RFnEdjAgdQF2kF0T+XGrcZgp97ejuwhbp4/rWmyYyVwmzUh9sY
	 qlowaSaMyJnQWynrpmPHCiwk6IOLcjEL/9n+z+GAyAXIsTn8Wj7IYvvzStOhOHm7bO2FM
	 2Yo6PurzgP57elllTZEe3O+99KtyxLVMfsGqb6YVv6sgr+EbnRFIXkTmg7hQzJYViJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088717;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=zh6vGIi1cn8nLgq25z2IUTb+iqyzGxr2ajVOKqOgZe8=;
	b=3rKhqRfbD63F5oOBRT7bwOGfcU56rWaKvvhW1UnjbaN22H4lPg/y0rreE1pegU6YX/CP
	 Vp74tYGNJKsp66AGNgNXCsxJdQuKq+4p2x/tKo9Sb2TRSt2BU9f4K8f7kNvLhwkG/Cjxg
	 HHUKYjurEgc6GyeE0i0QyCgcSfH7cnGCxTAjIBQWi1WLlPXzk5Jg4AO12E0irOs+yP/9G
	 WTbitpi0KXha27Rqy5JtjpL0vbMUsUmD99Ysi5qV7ixMCttf/X4A4nINvGOyuW9yJc8aZ
	 mNH0pfvmcq3A/oud5ypuGRgq6jhjDRy4+77IstE2bxB6ud++zb9pqWzUKi6rGWlHQ4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dxxFflYH;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBD8606A326;
	Thu, 19 Nov 2026 11:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEBD8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dxxFflYH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795088717; x=1826624717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1/6LAGJBHClDVL9Ne1gNjU6JeFi1vntvqEaI95GEOnw=;
  b=dxxFflYHWAF95QLXuq40OTAXnPQnSfnEsw3xLyDCuUQyXrSMCK0aoUlJ
   1pRW6lmYSERmjLAvp6JdXTZ5CO+A+XvP9ISszmapcpXGe4M4FI2swWbzK
   1ytqSTlnQvZRxaAAhXO7/u+mCa07AQxvnp+vfsDWpQlBZ5ptGEIPJBE8b
   XEm0zTId7XDg8P8OlAHOyudEGtcvEYFtp1cpA/H/LT5eanWHY8VlodwN4
   eWUlUD81iKETsYxCIkJ0+TPh/+exhz+omOeuMLgqaPxtTwh2AbWZsaOR8
   3bT2FAT1emDSw4hXdiQqEhP4529JK8HhcoDPJJPPnKpAyomzCQicQPP/2
   w==;
X-CSE-ConnectionGUID: 3j7rxseLQ7eD14bwzOmjGw==
X-CSE-MsgGUID: Ro8HuDY7QFOcXvn13j3UJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3941594"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3941594"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 03:45:16 -0800
X-CSE-ConnectionGUID: 3X2QGbLZQP2DRfHaJ8mRSA==
X-CSE-MsgGUID: zzEqJzeIRxS+sBDMZOVVtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10225399"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 03:45:13 -0800
Date: Thu, 19 Nov 2026 13:45:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: silverducks@altlinux.org
Cc: linux-gpio@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-acpi@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add ignore_wake quirk for Gigabyte B650
 GAMING X AX
Message-ID: <av7hR1X9HC2QSJYs@ashevche-desk.local>
References: <20261119083813.390337-1-silverducks@altlinux.org>
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
In-Reply-To: <20261119083813.390337-1-silverducks@altlinux.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 11:38:13AM +0300, silverducks@altlinux.org wrote:

Thanks for the report and fix!

> The firmware's _AEI table on the Gigabyte B650 GAMING X AX declares AMD
> GPIO pin 3 as GpioInt(Edge, ActiveLow, ExclusiveAndWake). gpiolib-acpi
> requests it as "ACPI:Event" and amd_gpio_irq_set_wake() arms the hardware
> S3 wake bit for that pin. The firmware then sends the signal a few seconds
> after entering S3, so the machine resumes on it's own six to ten seconds
> after suspend.
> 
> Pin 3 is the only wake signal the OS can see for the whole GPP7 PCIe
> domain, and GPP7 has no _PRW, so ignoring this wake flag is the only way to
> keep S3 reliable on this board. Wake from USB keyboards/mouse and
> Wake-on-LAN through that domain is lost as a consequence, but I figure S3
> not working at all is worse. The power button still wakes the machine as
> normal

> Quirk tested on upstream kernel v7.4-rc2.  Also tested on stable kernel
> 6.12, which is the version where the issue was originally diagnosed.

This can be moved to the comment block after '---' line below.

> Signed-off-by: silverducks <silverducks@altlinux.org>

We need a real name.

-- 
With Best Regards,
Andy Shevchenko


