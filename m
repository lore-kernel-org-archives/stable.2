Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541474;
	b=11NexC6UXqfdLbkC/GYUhVBeTTVecjMj5j4nS8YGn1zOsUk62OyfYIIXRpO6cfhaStu+
	 kBfPbLAW09J/SC3hg0xFCfGK4Iyv2tw33nPoXI1LrbA1/Jucp2t8cJnOqJJzHJcS7zJNX
	 HOqYOTQRfZmbLGBaXNqiWrHrjJEYgZlpggKHmFRLSZHkXQuOI4+FmKVXuAmcGSBXKAiRb
	 imXpJzRTbPOFHYKMfdi6ptXDq56cHlkP3sc8VzM0C4vFNNRmZHUtKMaB2trcgWfqcgmTE
	 5jxu6B96qSEXFeQta+0JlyAR9ufhlN46Auk/1enPCh/Fw2KBZEw/8o29YJH/zMrbOkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541474;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=KB7C1eMFvEpAkKAm29IzBOF4vvBEZNc+lMvP8sAbtwY=;
	b=W2mnbHU6ep/MU4RE1mxW1gkcCuzjfFeCqHJJ5L4qGML/kXG9es/DYoR6B66Sma2z2gyN
	 inANQGPZ+VjSaoDzs3lY11DwL43VE1MdEeETxQ59FttF/cMSJ6Xu0L/Nkn5CvJqpv9feD
	 OoCyUrKI6efVFB8sRjuPooNPqoz0dmcqB26EbhbtlJaW/DXAK1Za3kvI9Ylt8nTTJEeZr
	 w+fmEt672VwIIeDVNVeIZzK49z+q4rO8mtXlbXEAQ8hS7ekoa9PGerjJLNqjfBxOhysW6
	 ogkxGPG28iemudPZkBphX8c/UKOQAAm+hjJlZ1u3r3y9NLlujZhsZhmu0CNcjPSsYlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d273tAsN;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECDF606A327;
	Tue, 24 Nov 2026 17:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ECDF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d273tAsN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795541474; x=1827077474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bIUrMAQbM2kqyk0KcHV9n2AymUp3v+Q2zyPcEJ2YyuM=;
  b=d273tAsNRzXlhvWL5bt3E+TrEZKCM0FV7ape8ETEDiJS/twpFPYoNhkP
   oISGhGgTF68nJ63Aeo0DS4WI56+IAu3yZZmXcfnCh12qZBfySYEpRaLOU
   NOjBQYtcHuL0aJIki4FW4wtZEiqN8lf3bzY2mIzeCmqq1cYJOXtA5nFgu
   nro0M2ookkEjcStF94NYoxkfV8k3qLGJJzGAW360cB/7v/XEwCHdz1ITh
   Kp+ZbhxyRZTjyFv41NNuidI8pA6N7fpvS0xMuh0dMTAtW9npCxNyMpPE8
   oY6PLoI9Vq2TXc6l7N+HSdpSHaHKsFt5srUFksser9CKwiE8X9QMNXvEt
   Q==;
X-CSE-ConnectionGUID: 7aC+87jxRI28GKD2nGUUUw==
X-CSE-MsgGUID: bYdVf6alQD+jqHILgDESXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4334080"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4334080"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 09:31:14 -0800
X-CSE-ConnectionGUID: eEbY6/VvTL2OBHoiAYYXXA==
X-CSE-MsgGUID: YOpTlkumQWOuvsCEqAY8CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="12076339"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 09:31:11 -0800
Date: Tue, 24 Nov 2026 19:31:08 +0200
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
Subject: Re: [PATCH v2 4/5] pinctrl: upboard: fix I2C pinmux-select set CPLD
 GPIO OUT not function mode
Message-ID: <awXJ3Ki8i9b-Kokp@ashevche-desk.local>
References: <20261125-upboard-pinctrl-add-intc1057-intc105e-support-v2-0-c8079f8f569f@gmail.com>
 <20261125-upboard-pinctrl-add-intc1057-intc105e-support-v2-4-c8079f8f569f@gmail.com>
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
In-Reply-To: <20261125-upboard-pinctrl-add-intc1057-intc105e-support-v2-4-c8079f8f569f@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 25, 2026 at 01:10:38AM +0800, Gary Wang wrote:
> The CPLD I2C pin mode setting through pinmux-select is not correct.
> Should be set UPBOARD_PIN_MODE_FUNCTION on AANT0F04 devices.

> CC: stable@vger.kernel.org

I already mentioned that it's better to use 'Cc: ...'.

> Fixes: dca2f73cf19f ("pinctrl: Add pin controller driver for AAEON UP boards")
> 

No blank lines in the tag block.

> Signed-off-by: Gary Wang <is0124@gmail.com>

-- 
With Best Regards,
Andy Shevchenko


