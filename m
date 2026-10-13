Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC44522690;
	Tue, 13 Oct 2026 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905925; cv=none; b=gAWrJjdJO0Lo5pZ1ESZMMytH4/VOH/aGokAE0AxqSGS1I1Azi9r5M7gAfH2tfwUK/f7VWpc7KMGWbXLk443a+gGdgfdFmcEXAe15zmBM78h+OLytvCh883tVyta10E5ZtVdSFGt0TREuTQwmQV9LzV9C+JAXB/YQHWlCGAeab+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905925; c=relaxed/simple;
	bh=CnWWEy/ddbqgJgBpiyf6uiuVBIV4KpQJhpSdyAUwKRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGJuldVkZ9fYubulXhXpwqN5fQJaeUnyedbJP58q52FGpRAS8GZ/K97e7p7XFZeN8KxOYMTjAiQvRTSIQZOc+bCX8puBJlYKaXMCAb9Y4Kf1HNLJTBxipgSJusYFXWzElrDAbdgvlrPbdH3v8nsbt/qjdVJTcXTrMNk3ygEpDMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ABw4N1PW; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ABw4N1PW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791905924; x=1823441924;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CnWWEy/ddbqgJgBpiyf6uiuVBIV4KpQJhpSdyAUwKRI=;
  b=ABw4N1PW2ttBxGfT4Th3wONADz2jGNzaS3qT/TSZgjhfbzG2jzXlwdkr
   ZFyF5/wjsSCWMzTK6+3rtz28hx3uTZrlNTKZNAGMxKvfOroIiUu4XGj55
   jmhZgVy3MCylBqhrDRfMjLjvhg1KSZM3jc7DAOsQEUJx5tblLTjqnMHi4
   Eqk3MGJC6xynfsdopOU5hWqDCulsuwjNlXTqj+IMNJgvM+uj9wRoaNPed
   XqezrCAF0NvhZ4o99xVbdImslGdSXsZLq3XJB1T5YSDkp+hvov1p0D+9e
   ty1uqRgVdsixF6GAzGWlvugO22hiaDJPRzw4vODbtVcyduc9OEOXeT0mj
   g==;
X-CSE-ConnectionGUID: 4KTNyfbkS7CWFso0pI68Ig==
X-CSE-MsgGUID: MF5v0vJLRau6+Wh3pPR/3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="646646"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="646646"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 08:38:43 -0700
X-CSE-ConnectionGUID: 2RemoOKoSWiO6bLMBLSNCQ==
X-CSE-MsgGUID: dmxwydZrQOyan6SyCnVJsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1515449"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 08:38:41 -0700
Date: Tue, 13 Oct 2026 18:38:38 +0300
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
Subject: Re: [PATCH 2/6] gpiolib: free the label of lines released after
 their chip was removed
Message-ID: <as5QfrAaQQO_q0dr@ashevche-desk.local>
References: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com>
 <20261012-gpiolib-chip-removal-v1-2-aambrozewicz@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-gpiolib-chip-removal-v1-2-aambrozewicz@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 12, 2026 at 04:49:56PM +0300, Adrian Ambrozewicz wrote:
> gpiod_free_commit() only drops the consumer label while the chip is
> still there:
> 
> 	if (guard.gc && test_bit(GPIOD_FLAG_REQUESTED, &flags)) {
> 		...
> 		desc_set_label(desc, NULL);
> 
> A line that is still requested when gpiochip_remove() runs, for instance
> by a character device line request that user space keeps open, is
> released only afterwards, when gdev->chip is already NULL. Its label is
> then never freed, as gpiodev_release() frees the descriptor array but
> not the labels, and kmemleak reports one object per such line:
> 
>   unreferenced object 0xff110000057b63c0 (size 32):
>     comm "gpio-hold", pid 111, jiffies 4294696675
>     hex dump (first 32 bytes):
>       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>       3f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ?...............
>     backtrace (crc 7ff222d9):
>       __kmalloc_noprof+0x4ee/0x670
>       desc_set_label+0x32/0x110
>       gpiod_request_commit+0x1dd/0x320
>       gpiod_request+0x28/0x100
>       linereq_create+0x61a/0xce0
>       gpio_ioctl+0x49c/0xc80
>       __x64_sys_ioctl+0x134/0x1c0
>       do_syscall_64+0x109/0x5d0
>       entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Commit 1f2bcb8c8ccd ("gpio: protect the descriptor label with SRCU")
> cleared the label unconditionally; it moved under the chip check with
> the removal of gpio_lock. Clear it when the chip is gone as well. The
> ->free() callback and the line state notification still need the chip
> and stay where they are.
> 
> The label is now often freed just before the last reference to the GPIO
> device goes away, which depends on gpiodev_release() waiting for pending
> label frees (previous patch).
> 
> Reproduced with gpio-sim: request a line through the character device,
> set the chip's configfs "live" attribute to 0 while the request is open,
> then close it. Without this change kmemleak reports between 15 and 30
> such objects after 30 cycles; with it, none after 100.

...

> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2689,6 +2689,9 @@ void gpiod_free_commit(struct gpio_desc *desc)
>  		WRITE_ONCE(desc->debounce_period_us, 0);
>  #endif
>  		gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_RELEASED);
> +	} else if (!guard.gc) {
> +		/* The chip is gone but the consumer label is still ours. */
> +		desc_set_label(desc, NULL);
>  	}
>  }

I have two questions here.

1/ Do we still need to notify user space in the case of the chip gone?
2/ Can we write the above as

	if (guard.gc && !test_bit(GPIOD_FLAG_REQUESTED, &flags))
		return;

	desc_set_label(desc, NULL);

	if (guard_gc) {
		...current code...
	}

-- 
With Best Regards,
Andy Shevchenko


