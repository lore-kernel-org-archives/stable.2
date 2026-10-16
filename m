Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC334734F4;
	Fri, 16 Oct 2026 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158091; cv=none; b=M62sznrkPUhsz92gnUQj0EQwA1qmIoHYK2d2kH3GMx5lcSodeEAfiMcNg5DInz8uPq2LdBWI1FZ9v1ltPyoyylNQW5KC7fGgVAqAN5e03340FXDMa6hm4MI3Watpg6NbohVb7atAFA1mf+xu8uojvBqMQcrH3xGYmrv3i1YvAxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158091; c=relaxed/simple;
	bh=RS8GOwiJ5+p1ti0i8RowYRnod4LZsV78AZkhddv9OoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPuaB4wYqPlarYMUUBWCZrmvJVYaJIY8AO2Xp24pfdJaxV0xsO//dRBd38VjkYC4yc82SNtCpnEWsQ3HGAVGeYzoNrA8fp9XeMhivyR0lpQc/weiNJlpYBlcFtT4Zcz/PqNKmdTokMQm18kzNFC2yyP1rsJyzRAw06schQQcAs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jLU8Vxnj; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jLU8Vxnj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792158090; x=1823694090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RS8GOwiJ5+p1ti0i8RowYRnod4LZsV78AZkhddv9OoY=;
  b=jLU8VxnjOTpF+dO6djWWTIP2a4jeOsVeDp4XaWf8D4SjJ6or2lB1UW4G
   /W9IFIpBJMHW8evRKqKbUKjtt1k1UkNaoLQf8Uhh3kGQ56ALmO/bPPnrz
   py7C7e0Sl2/QcvkEJ8unX19ov3ScfdkxsyF+txTOsEDKVt0Dmo0KK7ilr
   zQYCsMBWIx0okhY5Ozy9E806jOpvdhRMe7KNThibkKeH7zpRQub7P/i2E
   LmkyVGsmNz7Wma3AYBFw1nm5E5DdpcvuS/CK8U7Vw8OlW2yoPwq+hzm6L
   F1RsXtFTj8k9Krag9j8TJjuzVxKBGpigY6vWit4S8i6NDTEc+JV3pp/kX
   w==;
X-CSE-ConnectionGUID: e0b6fP9GQoyTTAT7RQOvHg==
X-CSE-MsgGUID: JLYqRj6ZTA6fL0jPydaqaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="953875"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="953875"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 06:41:29 -0700
X-CSE-ConnectionGUID: +fJis/UUQjK2lu9BeE6KpQ==
X-CSE-MsgGUID: cbELm30bSEKDw1a4T/s7CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2327404"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.35])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 06:41:27 -0700
Date: Fri, 16 Oct 2026 16:41:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 5/6] gpiolib: cdev: don't leak the IRQ name when the
 chip is removed
Message-ID: <atIpg2E8PeJ0oGNS@ashevche-desk.local>
References: <20261016-gpiolib-chip-removal-v2-0-aambrozewicz@nvidia.com>
 <20261016-gpiolib-chip-removal-v2-5-aambrozewicz@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016-gpiolib-chip-removal-v2-5-aambrozewicz@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 16, 2026 at 12:23:37PM +0300, Adrian Ambrozewicz wrote:
> The character device requests line IRQs with a copy of the consumer
> label as the name and frees that copy with the name free_irq() returns.
> Since commit ec8b6f55b981 ("gpio: free irqs that are still requested
> when the chip is being removed"), gpiochip_remove() may free the IRQ
> first and drops the name it gets back. The character device then does
> not get it from its own free_irq() call, which since the previous patch
> it does not even make, so the copy leaks:
> 
>   unreferenced object (size 8):
>     comm "gpio-hold"
>     backtrace:
>       kstrdup
>       kstrdup_and_replace
>       edge_detector_setup
>       linereq_create
>       gpio_ioctl
> 
> Keep the name with the line, or with the v1 line event, and free it
> there whoever freed the IRQ.
> 
> Reproduced with gpio-sim and a line requested with edge detection and
> a consumer label, the chip being removed while the request is open:
> kmemleak reports between 17 and 23 such objects after 30 cycles; with
> this change, none after 100.

...

> struct line {

>  	struct linereq *req;
>  	unsigned int irq;
> +	char *irq_label;

Have you checked this with `pahole`? Is it good layout?

...

> struct lineevent_state {

>  	struct gpio_desc *desc;
>  	u32 eflags;
>  	int irq;
> +	char *irq_label;
>  	wait_queue_head_t wait;
>  	struct notifier_block device_unregistered_nb;
>  	DECLARE_KFIFO(events, struct gpioevent_data, 16);

Ditto.

-- 
With Best Regards,
Andy Shevchenko


