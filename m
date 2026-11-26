Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795708395;
	b=Jryb5zUuPDGVS7JoEpdRpB8rIsRkb+PK/XcdXI6gIOYvQ7O2oiXizsF7O3wrOedaGDnr
	 lsUigjLf3VLfGwv488UpTcftFpHb1Uf7BoQQR+7iQhH6bg6MI5xm9bVn7IYjubpJ3dh0R
	 2bG2XwyEnhERU2HxXSdD0WAIC5pm9eC6TcxO+NGU3zDNPf2IE78C4st6sKr8IBFjAzuBS
	 JmHWEoYEtYc4Snuvpy73q0LIbNArK4oyOinacTXLvyBECrwM3eVa67C8APoG7/k9LXvVQ
	 5gL+4TklkYNF5/mez0TBO8vFy2eOuqONYxqBM4/4mMu7nMe3Uiv44eOnS9sMVloH+KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795708395;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=Kry3Z9RUQstwZhg75tn4ymi/tsst+B1XBTvLmOJUn5w=;
	b=07VXW+pahxj+6ZvC4Eliv/EY4wQtyTuLmXIV2vdtorfBFeyKL/M9rV4Rskc3pX/IZVje
	 CYqmFYeFudOXB9CP7gNOtEh8R+S75id/JYth9CTrUkgg2BZVMobY3TCXLvWou046R9l3c
	 wn3iCSEudV+JPqI0X5xclfiQPBVQ1yH8w/309XpasqXFeWeP+ankDualE1F6w5eowtEZb
	 uoXSFMSe1kvECGPvl47Y8M0Ngy3qp81L3lHC2u+Jigc3Xc2yq32pRYPavwthcDYi3HdKO
	 JKtiKErhSUwXytcLNnbWBa3g1ssjArs7sZ7o5zjqbHMpx1s+OFzQP+pAzbNGHBlsTlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=czgfANIX;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689DE606A31C;
	Thu, 26 Nov 2026 15:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 689DE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=czgfANIX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795708394; x=1827244394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TxKr8O26zsBT1nq6mdPFpy0AfZIag+YE7HUI/Oq56N4=;
  b=czgfANIXwxEFnX7kO+xg72F/nMIjjbSOm0uHCWTtjPpDxu1VYyJmBUzc
   Kx7d6pC5bxQGNOBZslx7XMerROVjkTy+EjsPB2mwfUBnTI/dy4zLd2ZMl
   IT5M0ettJhwIIP6IXqT1MRsj6Mydu61gjiM+NZZ4JWQHxM4ee8KL64Ieu
   8DL6jDjPL8MPDq9BFd6DHiwfPcB69dAIN1iJNAUUP9RXQ3zmyTeCjWEEq
   0fxdouIZmdiY1tFDvhHoVPfER79kIOuUlhc5QpzuqKnY+jp9jPuslYctb
   ecSLEBIzDvs+H9ILajjxyTClDpXmrKR0MNAjvnq7TzI1ufluoZ5hBpUo2
   w==;
X-CSE-ConnectionGUID: b+Vx18zsR5WXFXcniWywKg==
X-CSE-MsgGUID: 0LcvlZ3ZTD2qcAKs1xSDtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4620013"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4620013"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 07:53:13 -0800
X-CSE-ConnectionGUID: OjVfJP5SSrOKg1lk63KPxw==
X-CSE-MsgGUID: 4sYHL9iyQMiEb8XBWy8opw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="11981224"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.208])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 07:53:11 -0800
Date: Thu, 26 Nov 2026 17:53:08 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: GaryWang <is0124@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Daniele Cleri <danielecleri@aaeon.eu>,
	JunYingLai <junyinglai@aaeon.com.tw>,
	Louis Chen <louischen@aaeon.com.tw>,
	BillyChou <BillyChou@aaeon.com.tw>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 0/5] upboard pinctrl support for device id INTC1055 &
 INTC1057 & INTC105E
Message-ID: <awhV5OkehBYETKAd@ashevche-desk.local>
References: <20261126-upboard-pinctrl-add-intc1057-intc105e-support-v3-0-81d35c9ba246@gmail.com>
 <awhPAzKefJVW2meb@ashevche-desk.local>
 <CANYHO6o-eNMV1YkRfP=W7XxmefBW=U_CALRMyWSixkXzk1uBtw@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANYHO6o-eNMV1YkRfP=W7XxmefBW=U_CALRMyWSixkXzk1uBtw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 26, 2026 at 11:36:48PM +0800, GaryWang wrote:
> On Thu, Nov 26, 2026 at 11:23 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Thu, Nov 26, 2026 at 11:09:43PM +0800, Gary Wang wrote:
> > > Add support for "UP Xtreme ARL","UP Xtreme i14","UP Squared Pro 7000",
> > > "UP Squared i12","UP 7000" and missing groups and functions data for
> > > INTC1055 & INTC1057 & INTC105E.
> > >
> > > Fix pinmux-select set CPLD GPIO OUT not function mode for I2C pins
> > > on the AANT0F04.
> > >
> > > There are no compile-time dependencies for each file, all pin groups
> > > functions data will forward to set default when pinctrl upboard probe.
> > > It shows an error when run-time dependencies are not mapping to right
> > > groups and functions.
> > >
> > > The pinctrl-upboard is provide additional driving power and pin mux
> > > function through native SOC pins->FPGA/CPLD->hat pins for flexible board
> > > level applications. it's probe from ACPI device id AANT0F01 & AANT0F04.
> >
> > Thanks for update! Looks much better now. I'm about to apply, but I want to
> > make one thing clear before that, id est is it indeed ISH has only a single
> > UART? Or do we need to add an index there?
> ISH has 2 UART ports, we can add an index to identify.

Yes, please do in v4.

-- 
With Best Regards,
Andy Shevchenko


