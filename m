Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615825;
	b=C2Ea53OqY+Y8wVOi1uLkHtAZclO7Wyp2k7lggIduxrt1fiPqx+eXcW3K5pAlOfW4qf1G
	 9C/e4u/A9wRzL7zf+TCODDZQ49ewquCkvTFiEDEK1ruQr3U2qGkQCdFOI9Dlh3FWFjLdI
	 xHT/S7ExX0enOyylkkqSYPQovJZgVYf2vJA+kiEjafiXg3Dnwz/3YxB96N0RWwOCF9PQi
	 bJoTs5jW1pWi6Y22ydusJguEOsEN8aYYP/VFM5WCbHPUvp7R95kdoOkI1IwQCy/++0fpO
	 LAocRRoEwfKiX2P8qLim4KaLVrVK5EzkrNbfh9DZkCJRoYXO0MYBWjY62aA1FnIiPNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615825;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=u9SSYNv5gh6TzeVPoMYWvvKxu3judphYtRhULaZWPAg=;
	b=w7uTlVO+BFMwsnYe6uaC224xPwhS8g5X1QkcGk8AWW6LQ3vYqubjD20YyhfaPh/oTjJR
	 TmiKmfSBtj52wJoT7R9UoNnX59+UFvoK4byrb6d56uioV367bMuhS4VPctei+blyfRXLv
	 YC6fA3v5FO2puNYRg2aDLw9eZzebzve88r4RAu8Z1LiV4RzHbte2N2TbcjcQ3MVLL0hZx
	 Xu0/QUdex9a/fczBUgqLxfkwCTyyLMAImKeDVgHKQG/9NVxgOCrb1h0E712klsy0QM+Ot
	 XMGnFa/xvDQNcswd8FuOo71MiLjR9rZ6uM2tkXExRZsWPeUr/9c/oKDpWOvVFAflhvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VX2YPsyn;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22199606A31E;
	Wed, 25 Nov 2026 14:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22199606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VX2YPsyn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795615825; x=1827151825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GGGb/fI9GrCDO76JXsZ5ObRdwXbMZk36J1eFJvVKu9Q=;
  b=VX2YPsyn/5XcS44DAmvUEJR3ah2BS1eTbqjONWarxo5a5iwZmehasowi
   OHB1QJuIcwxZJS+rm74WKlk5zGnjj2c+oXRJuxfzfwrJnEEulxmGhzU1m
   76JcDifiFtf/uzH/A4csVNiKse3lnxlzVJ/D/Sl1wlUUIPxqFttDVD9Gy
   NvRYmH3wXZqfnOzxINzdkIxzRo51mnz3idmnWClvpH6zMgp39eq4akU/M
   K4Jo6fqZuzW0bQwKq7Ye/g5eLSnOKBI4xo/EmKkJ9w/nwiuKkJor71t0H
   pghaXiGnlGZ+gk89Hwtoqzxy0WSSbEr3Vh3KbWj1ylHy5XSNN41uEUAi3
   g==;
X-CSE-ConnectionGUID: MfoZQMMlSMuLCLYBLYLoFg==
X-CSE-MsgGUID: 8TKlZV5kRRmty7teCQwL0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4575832"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4575832"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 06:01:55 -0800
X-CSE-ConnectionGUID: ehpr+mSNS1G0q/hSzA4X+g==
X-CSE-MsgGUID: CgRsuseOSqyK+N3YNhZ+0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="12199585"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 06:01:51 -0800
Date: Wed, 25 Nov 2026 16:01:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: GaryWang <is0124@gmail.com>
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
Message-ID: <awbqTVUWZg3c8kfc@ashevche-desk.local>
References: <20261125-upboard-pinctrl-add-intc1057-intc105e-support-v2-0-c8079f8f569f@gmail.com>
 <awXJd59jTHM2bIlD@ashevche-desk.local>
 <awXKVXS0kIGnA0lD@ashevche-desk.local>
 <CANYHO6q7Cx1ah7cJMfyeu83v80VAFcx-2TQNNWM6kNSv0zB7pg@mail.gmail.com>
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
In-Reply-To: <CANYHO6q7Cx1ah7cJMfyeu83v80VAFcx-2TQNNWM6kNSv0zB7pg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 25, 2026 at 09:58:53PM +0800, GaryWang wrote:
> On Wed, Nov 25, 2026 at 1:34 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Nov 24, 2026 at 07:29:32PM +0200, Andy Shevchenko wrote:

...

> > Also you ignored my comment about how this series is supposed to be applied.
> > Intel pin control drivers are maintained by me. The rest by Linus. People
> > won't go through the code to understand if there any compile-time and/or
> > run-rime dependencies between parts.
> >
> There are no compile-time dependencies for each file.
> All pin groups/functions data will forward to set default when pinctrl
> upboard probe.
> It shows an error when run time dependencies are not mapping to right
> groups/functions.

Okay, make sure you put a summary of this into the cover letter of v3.

-- 
With Best Regards,
Andy Shevchenko


