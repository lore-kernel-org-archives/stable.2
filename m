Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794261527;
	b=lK4ly8DvrWmLcs1kNwHwGSXHgVutoMMhIUxLN7zQN6BBy5e9QDAuvP3NdKmU5TyxuSVI
	 FJTKzYu/j744Nh8S7dqYpsPLU8OsH7Mnyq0ZLjMOUqqJnv4yT8g/ICs9ttg8BlZmsnCmj
	 z2TVCoGJbAEE2JzjdEM6ek5LQ+s4/ycyIxeSRsdLX4LMesb1HhqHEtvSty6XjVSoZKUDI
	 EQGLKLyJpXCZLEPMRlXFDXSshCiBVpQR5N6Q7wIo6bOCJrms813btYDx/qII+sJLz0glX
	 co6dd0S19Ghny4zm26Im8DYAJfO6qucRBmM7gISQTs2T4HjCL1JuXFtzO77BAeZQL4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794261527;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=uuKGJFIAQTv+RlaHpzDx+37smg+UIdatunDm/wqv+7s=;
	b=APdNqsmiWrlBOs0GqoHBRgRN0BSmrICsdl3OIt48TdR9J7qTxQSTW+F5Sze2qH9waXTc
	 slL7HRvfxvcE2VPbuHulYbfUposm0rDjUnEzFzlx5Mv+xuKFFy8jPkuA+rNX5DYAKeENV
	 iZwAbuUAFau0yKMIsbPCJNlfrhEjzAm2bk5JORj5qcTTzOU+W/YG6b/yRvlL7a7IymoLS
	 UhAqQm27yq4CPrERz//mlATaOPZbRB+P+x9qGb6xcn30cwcfBmXU9vHwIyXkEgGCpEdTi
	 YtGUtvi/UUAel+7puq56PoOxdF34FiURjVMLj5hAaVAkhLVAZYh2Yf1nfOpMVOM3bYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YSue7FtR;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C92606A31C;
	Mon,  9 Nov 2026 21:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8C92606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YSue7FtR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794261526; x=1825797526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gNtUecHaPmKuaL6tSyYP7NTuJUMVrc+ZsiUj1ZvKFIw=;
  b=YSue7FtRSlLeXM6/8ztZy4eOVt6VeaOTQC6NdAfCdGFsdWr8qmhKAUGD
   EaAHUHxqdEUEESydCw9DTPZix24qnKCjNKR9+Q8gPAU4YsCAAlcleJfje
   f4s28co8Sjapa6KbBgu6rbWlTMDy95Ij8B9NfPqpJBmNX6XGCWs0iBTCZ
   kqLw0T4BSujzzq6scROH7q3iUprgvPb7AeTrl2Gg0UoSY4g358/olGXPv
   USARbTtVoMZQcUJZM3wbEf+4Z+Iz1gVw+R5GY4kYS9+M8gYvOmS2rt877
   320pdf6aSi7SLOc0EnG8sYfIax1/SdxrUbjbW00EZUf5FUSPGfiS9BnTV
   A==;
X-CSE-ConnectionGUID: dUx6eaANReSXdngUr1ASNg==
X-CSE-MsgGUID: Qv3R1GUBTeyQvQEoay+byw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2875380"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2875380"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:58:45 -0800
X-CSE-ConnectionGUID: C84YxAV5Q3OA++szL5UfqA==
X-CSE-MsgGUID: gtpJKZIjSgK2DJb4/V6/DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="9723857"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:58:44 -0800
Date: Mon, 9 Nov 2026 23:58:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Kent Gibson <warthog618@gmail.com>,
	Adrian Ambrozewicz <aambrozewicz@nvidia.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 5/5] gpio: cdev: don't overwrite the whole flags field
 when configuring lines
Message-ID: <avJCETUZidpmICKR@ashevche-desk.local>
References: <20261109-gpio-desc-flags-atomic-v2-0-c4c54b476628@oss.qualcomm.com>
 <20261109-gpio-desc-flags-atomic-v2-5-c4c54b476628@oss.qualcomm.com>
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
In-Reply-To: <20261109-gpio-desc-flags-atomic-v2-5-c4c54b476628@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 09, 2026 at 11:27:09AM +0100, Bartosz Golaszewski wrote:
> linehandle_flags_to_desc_flags() and
> gpio_v2_line_config_flags_to_desc_flags() read the flags word with
> READ_ONCE(), modify the local copy and write it back with WRITE_ONCE().
> 
> The per-request config_mutex does not exclude sysfs, the irq core or
> drivers touching the same descriptor, so bits they set or clear
> concurrently can be lost.
> 
> Build the mask of bits owned by the line configuration and their new
> values locally and apply them with gpiod_update_flags(). The whole
> group changes in a single atomic step.
> 
> While at it: rename the functions whose semantics changed from
> "conversion" to "flags update" accordingly.

...

> @@ -3,6 +3,7 @@
>  #include <linux/anon_inodes.h>
>  #include <linux/atomic.h>
>  #include <linux/bitmap.h>
> +#include <linux/bitops.h>
>  #include <linux/build_bug.h>
>  #include <linux/cdev.h>
>  #include <linux/cleanup.h>

Unneeded hunk as explained in the previous reply.

...

> -static void linehandle_flags_to_desc_flags(u32 lflags, unsigned long *flagsp)
> +static void linehandle_update_desc_flags(u32 lflags, struct gpio_desc *desc)
>  {
> -	unsigned long flags = READ_ONCE(*flagsp);
> +	const unsigned long mask = BIT(GPIOD_FLAG_ACTIVE_LOW) |
> +				   BIT(GPIOD_FLAG_OPEN_DRAIN) |
> +				   BIT(GPIOD_FLAG_OPEN_SOURCE) |
> +				   BIT(GPIOD_FLAG_PULL_UP) |
> +				   BIT(GPIOD_FLAG_PULL_DOWN) |
> +				   BIT(GPIOD_FLAG_BIAS_DISABLE);

Usually we don't do such an assignments in the definition blocks.
I believe the split will look better.

> +	unsigned long flags = 0;
>  

	mask = ...;

(and with longer line you may combine close bits, like OD/OS or PD,PU, and
 DISABLE).

> -	assign_bit(GPIOD_FLAG_ACTIVE_LOW, &flags,
> -		   lflags & GPIOHANDLE_REQUEST_ACTIVE_LOW);
> -	assign_bit(GPIOD_FLAG_OPEN_DRAIN, &flags,
> -		   lflags & GPIOHANDLE_REQUEST_OPEN_DRAIN);
> -	assign_bit(GPIOD_FLAG_OPEN_SOURCE, &flags,
> -		   lflags & GPIOHANDLE_REQUEST_OPEN_SOURCE);
> -	assign_bit(GPIOD_FLAG_PULL_UP, &flags,
> -		   lflags & GPIOHANDLE_REQUEST_BIAS_PULL_UP);
> -	assign_bit(GPIOD_FLAG_PULL_DOWN, &flags,
> -		   lflags & GPIOHANDLE_REQUEST_BIAS_PULL_DOWN);
> -	assign_bit(GPIOD_FLAG_BIAS_DISABLE, &flags,
> -		   lflags & GPIOHANDLE_REQUEST_BIAS_DISABLE);
> +	__assign_bit(GPIOD_FLAG_ACTIVE_LOW, &flags,
> +		     lflags & GPIOHANDLE_REQUEST_ACTIVE_LOW);
> +	__assign_bit(GPIOD_FLAG_OPEN_DRAIN, &flags,
> +		     lflags & GPIOHANDLE_REQUEST_OPEN_DRAIN);
> +	__assign_bit(GPIOD_FLAG_OPEN_SOURCE, &flags,
> +		     lflags & GPIOHANDLE_REQUEST_OPEN_SOURCE);
> +	__assign_bit(GPIOD_FLAG_PULL_UP, &flags,
> +		     lflags & GPIOHANDLE_REQUEST_BIAS_PULL_UP);
> +	__assign_bit(GPIOD_FLAG_PULL_DOWN, &flags,
> +		     lflags & GPIOHANDLE_REQUEST_BIAS_PULL_DOWN);
> +	__assign_bit(GPIOD_FLAG_BIAS_DISABLE, &flags,
> +		     lflags & GPIOHANDLE_REQUEST_BIAS_DISABLE);

...

> +static void linereq_update_desc_flags(u64 lflags,
> +						    struct gpio_desc *desc)

This is ugliest part of this patch in my opinion. Just make it a single line.
`clang-format` is in use I assume?

...

> +	const unsigned long mask = BIT(GPIOD_FLAG_ACTIVE_LOW) |
> +				   BIT(GPIOD_FLAG_EDGE_RISING) |
> +				   BIT(GPIOD_FLAG_EDGE_FALLING) |
> +				   BIT(GPIOD_FLAG_OPEN_DRAIN) |
> +				   BIT(GPIOD_FLAG_OPEN_SOURCE) |
> +				   BIT(GPIOD_FLAG_PULL_UP) |
> +				   BIT(GPIOD_FLAG_PULL_DOWN) |
> +				   BIT(GPIOD_FLAG_BIAS_DISABLE) |
> +				   BIT(GPIOD_FLAG_EVENT_CLOCK_REALTIME) |
> +				   BIT(GPIOD_FLAG_EVENT_CLOCK_HTE);

Same comment as before.

> +	unsigned long flags = 0;

-- 
With Best Regards,
Andy Shevchenko


