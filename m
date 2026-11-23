Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464090;
	b=DgxgwQSYKWNXpKDtnD6FEvLaRumABNYdLDwC+LSSq0mZDECXYG6DCZ9G87Z4pcQCXuPp
	 jCruQwMW5JKIxEyxdMb5STtGD6TiJMDKEcp+kxX0BoPVOphfxOkGX9m6aQDbbY1o7tqDP
	 FeoDSpGYLxNmp1pz8t7gusRvOQ/eM8sn412bCCBq1EN9shSC46yvyxv+yLEpFRx9zYiki
	 hZPFQU3wGHK5SMae6dXCd7nC06leWXwM6eo3iA4Z3calXcOV9C+ZgzGEQ17wcjo6s11sm
	 r4KW35VdTZr+Ufnh6uaTTsLB9WNme6Ch8LHf+Cz7HEjIJCKVz99WXQ7ZpC04a7i/+XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464090;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=b79lk37u0SJ8mJ3I7WmNVa3EmDE+Rjthr4bhnCPqMpQ=;
	b=LFNiezF1cyGCe51ytCyQHDRalJ6Hx9EsCb6GES4DGEXkbIRwPqQQxC3GIyOS4iAJl4m9
	 26QZDD0jgySGhoCtaAuf48c+XalF3ZbeF4596JTXUF5PZa48b1KQrOiOvvAURFyjd3C0k
	 B02zBcrHrEAwC+D/CJB1/HjWMpUH0TOCBPNokcAsGOIB62GCw7mcVQo9rfyOY0m1nI03l
	 ZGI9EG9UA02rCHXiEEkSBp8KnLtmAP2Vx//xkVmQN+/Ad2pvTtJQZZOPUpnl47s2vKj0W
	 GQmMzX11GjFHeDRkYgDMnPLfQ4jCek8zw0s0MmdwwUUj2dpqCJ0OBAE2DFY2a0aZ6SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eK70WAKg;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA8D606A32E;
	Mon, 23 Nov 2026 20:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AA8D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eK70WAKg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795464090; x=1827000090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d4BrmHEXpgt7oMAzMDt8SUlATSq1VlxdwbnTLGIvVfA=;
  b=eK70WAKgSG6TLw84A1DukT1wW0QyRZHFuQC5viY/XoWuTqrOSLe5V2Kn
   B3g2EqFsRGvPjSop/QWf/TbkiLkEeIEJN2JbMuNaQBesRGneMaANcBYZY
   UZAQZgmR02JEuuP9f3MmNUwEE3/vIe/m45o15ErOcG9ViuzxCRqM5rKE/
   LV3NfksQYNj+I6d6pTgwTh2CTs6CzHAi60ks/KHFatuwEL+wfHWj6IjNd
   no7tSFOT/mFr2VztjL36BaNHaodT27fjBTJvT/cfi/wbs4qagaHQk0nxq
   cHeTquUaELJWkJ1Bh+KTyXcyG/8XK4RiOBXycw4UfRnuAqruS23bZWBqQ
   g==;
X-CSE-ConnectionGUID: 51mgXu26SYKbY6oN8NH5+w==
X-CSE-MsgGUID: SewgYZoBTpKM/VPKw1faEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4127378"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4127378"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 12:01:27 -0800
X-CSE-ConnectionGUID: aCErOLmZQLSSlaHc6h+Epw==
X-CSE-MsgGUID: RxQv2lpfQ8OSiPc/k+2Ckg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11720551"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 12:01:23 -0800
Date: Mon, 23 Nov 2026 22:01:20 +0200
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
Subject: Re: [PATCH 4/5] pinctrl: upboard: fix I2C pinmux-select set CPLD
 GPIO OUT not function mode
Message-ID: <awSbkAjWErc0ac_n@ashevche-desk.local>
References: <20261123-upboard-pinctrl-add-intc1057-intc105e-support-v1-0-f2322a91686d@gmail.com>
 <20261123-upboard-pinctrl-add-intc1057-intc105e-support-v1-4-f2322a91686d@gmail.com>
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
In-Reply-To: <20261123-upboard-pinctrl-add-intc1057-intc105e-support-v1-4-f2322a91686d@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 23, 2026 at 11:16:17PM +0800, Gary Wang wrote:
> The CPLD I2C pin mode setting following uart & spi used modes array

UART
SPI

> on device AANT0F04.

> CC: stable@vger.kernel.org

Should be better Cc: (CC: works, but looks non-standard).

> Fixes: dca2f73cf19f ("pinctrl: Add pin controller driver for AAEON UP boards")

You need to read the AI slops, test them and add your formal SoB.

-- 
With Best Regards,
Andy Shevchenko


