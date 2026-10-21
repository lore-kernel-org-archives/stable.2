Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792591057;
	b=OYPYBAqmqcNUQTrlpIB9lVo9HcYbGITvrKcONsVxiPHManmnMr2hBEni9o20AGs7uFCD
	 55kCNulVHcC7xHpi/zaNWaKX3MNXrxryDQpUdY1BJqUh58Vn7XlD/1sydjUcsRTl8RV+G
	 LBijYIJnW+0i9MMfr3qJy7R8sl/AMYV2a6y//RiJAgqvSEbpXHnK85rcmCbLrKKKZX594
	 Ts6SxeXthO6DgJ4ZI2DWUL9RmVr7TAEW5h+3f829Q4tr+YaJWHaCFDYMqvosvxFg/csdw
	 lcwvpAbAX9KLjWLNrZmn+9RtCndzULsC1Qpu/mnajOVn1kZ3SWYFRj+iPQ8rBU9Iw6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792591057;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=5W+iT+MkSvp3/KJA4Aq2SUM9unr+BuTaqOzLyaskO+o=;
	b=ybjKv0KK0xv4mYx0/srrCiMNaXlW6iRagBCDpbcznAdYpTQp4Q5pJ2eONWHX0lR2gXt5
	 z6gtzui3PYzE8yhe2onIl4qnXES3vU9O8TGLFIrLMTyuz+ebTtgKM08UbpqkmHxpq/Dc6
	 taRr6SuOaI7/ycNcnRYTHBX5/9E3Uc8HuGX9RJ8yMJRke0Qi5E1i+g8Cr5N+No//VO/OM
	 3ON5Ue46ozZ16tAg3i/z7XyRbRaZeqWeAn5J9dVdaeaOEJUQxqCwuo0NOHO/pZd3uW6dj
	 HvbRInHEiBn6thT+h4q966Hfq1K1TKH3CMQ0up4h2k1aVu2LHxmWGlDmL19EVSv22iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UyWaOkPC;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1B6606A31D;
	Wed, 21 Oct 2026 13:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A1B6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UyWaOkPC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792591057; x=1824127057;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Br9EKJwhi7WcbmbtW8Y2iu+BL2cD1Vy7EQOi8VN93i0=;
  b=UyWaOkPCmeSv+UKjF9lAK/rVkvlNAw3pTsXVz2CsBMs84jdAwZ8MtRhw
   5bdWcVRRqqJejtL6QgiEiKvZ0qdX6Vj6VAtkzeO53EYZiFuWQIXpOeVOh
   P3FxmQYprXdKfGgr9cdfz+vrvzf6TpNWd65gVweG6KgoF/63hxMQMISPE
   IbEu+8d7Nj7hxBU2KM1pF3oMtlvxASDxMojMTSsMNMQoQFW77boi+ypGh
   WF/eGl8OPBKD8qqW25LqZtQVvQZv8MUbNY7HJFmarReJix0yjDrWDxYzr
   4guLsMqM/7jQOXh6C8UNvBHEIdmPfDSUfIFKkdcP82UC1GxsVAH2URUfy
   Q==;
X-CSE-ConnectionGUID: /Jy3thBsSiKIMq3YnmbUtQ==
X-CSE-MsgGUID: h5p8iT59R5uE9uzfBXcbQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1332673"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1332673"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 06:57:36 -0700
X-CSE-ConnectionGUID: RAMc1K4zRf+2ZuLiFKfmCQ==
X-CSE-MsgGUID: TgiW3nb/Sby1oVttqXa00Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3115929"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 06:57:33 -0700
Date: Wed, 21 Oct 2026 16:57:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
	Chong Qiao <qiaochong@loongson.cn>,
	Corey Minyard <corey@minyard.net>,
	Huacai Chen <chenhuacai@kernel.org>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 02/28] mfd: ls2kbmc: Unregister GPIO GSI via
 devm_add_action_or_reset()
Message-ID: <atjEyo2VkaJuecMh@ashevche-desk.local>
References: <20261021121245.3111563-1-lee@kernel.org>
 <20261021121245.3111563-2-lee@kernel.org>
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
In-Reply-To: <20261021121245.3111563-2-lee@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 21, 2026 at 12:09:24PM +0000, Lee Jones wrote:
> ls2k_bmc_init() unconditionally calls acpi_unregister_gsi() immediately
> after requesting the GPIO interrupt via devm_request_irq().  This
> prematurely disposes of the active IRQ mapping while the interrupt
> handler remains registered, breaking the GPIO watchdog interrupt and
> causing a use-after-free when devres later frees the disposed IRQ
> descriptor on probe failure or device unbind.
> 
> Register a devm_add_action_or_reset() callback before devm_request_irq()
> so that acpi_unregister_gsi() is invoked only after devres has freed the
> interrupt.

...

> Fixes: d952bba3fbb5 ("mfd: ls2kbmc: Add Loongson-2K BMC reset function support")
> Closes: https://sashiko.dev/#/bug/linux-cab8bfb6-4077-46f3-a173-ac2e2042cf66

Don't we use the official Sachiko's email in Reported-by tag?
Reported-by: Sashiko <sashiko-bot@kernel.org>

> Signed-off-by: Lee Jones <lee@kernel.org>

-- 
With Best Regards,
Andy Shevchenko


