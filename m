Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B754F414400;
	Tue, 13 Oct 2026 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907201; cv=none; b=QZhwzudSly9v6A1vPV3YQfFe8QKj6rABXJ6fbukF+srIoxRQyvFWMYIIbYAqmz6lITE205g5hbDLEs9gaKexdKO/D65PcOJGtnPIyjt5HcKEAcpK07HxtASrdpk6GPposP500PQ7rZcKQtG80LhawXRTqIVIM9oicIVA3gOQjm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907201; c=relaxed/simple;
	bh=9BcnnpAMNt7lEWTiNXiw2QXs3XbawPAecCrgXHb6wJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezFzy4ebM/5bvRRb325dgcorzKZv8puAry9qUdccUe9Xc8iwTm6EiRjZr9IAAwL5sHO3x2DfTfgoOPJKNlWHCQNdFUScTkVH2uFAL8e7/rhD6jXoFGU2sFFNVNxLl5yTzDn9boAGkZGfGVqvFZPMH097wDVcnZuYVVRzU4BAa94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XiNyfejx; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XiNyfejx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791907200; x=1823443200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9BcnnpAMNt7lEWTiNXiw2QXs3XbawPAecCrgXHb6wJ0=;
  b=XiNyfejxGCySVTSiWI8v6uCxNAfC6NyDUP2dJ2rjz3DRFpyDI4SrCHeS
   yLACH3SqOPgomeQAY6eWR0HZoylqUkTWRHPjKQZOV8O8M+IkD6n5XleRG
   nn03S8upj8kMxtkXK/D+WQtuSqmMW7YVFslmM4NJSHTBzzWQATWUkP9Jo
   X1ZJOpZsaCJPR5B2v0Ezoj/W/o/ySMoDjsYO0amkP1UHjClxdTHpHBOmE
   0KOYLbi+YXLG4qpUavt7ZdliksVPBJw2uODq6FteQCZpfk0sgmFGtiQZw
   Ys4Xx15XadUQZoJiMrJiqQ6SzzvCQxHm7dtqMXf0QWIFaWXy6PjA9rmIy
   g==;
X-CSE-ConnectionGUID: luN9UYIeSt+zIbtKJBD3nQ==
X-CSE-MsgGUID: d9ObjsAMTD+mgnMRoPOauQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="655204"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="655204"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 08:59:59 -0700
X-CSE-ConnectionGUID: gJMraqIpQumHn6XrWazB0A==
X-CSE-MsgGUID: +CBWNGPiRHqsel8U8CQEtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1093451"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 08:59:56 -0700
Date: Tue, 13 Oct 2026 18:59:53 +0300
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
Subject: Re: [PATCH 5/6] gpiolib: cdev: don't leak the IRQ name when the chip
 is removed
Message-ID: <as5VeTfADRr9nwRN@ashevche-desk.local>
References: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com>
 <20261012-gpiolib-chip-removal-v1-5-aambrozewicz@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-gpiolib-chip-removal-v1-5-aambrozewicz@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 12, 2026 at 04:49:59PM +0300, Adrian Ambrozewicz wrote:
> The character device requests line IRQs with a copy of the consumer
> label as the name and frees that copy with the name free_irq() returns.
> Since commit ec8b6f55b981 ("gpio: free irqs that are still requested
> when the chip is being removed"), gpiochip_remove() may free the IRQ
> first and drops the name it gets back. The character device then does
> not get it from its own free_irq() call, which since the previous patch
> it does not even make, so the copy leaks:

>   unreferenced object 0xff1100000435b080 (size 8):
>     comm "gpio-hold", pid 108, jiffies 4294695819
>     hex dump (first 8 bytes):
>       72 65 70 72 6f 00 00 00                          repro...
>     backtrace (crc dc8eac94):
>       __kmalloc_node_track_caller_noprof+0x50f/0x6a0
>       kstrdup+0x35/0x90
>       kstrdup_and_replace+0x19/0xe0
>       edge_detector_setup+0x5d8/0x940
>       linereq_create+0x9ec/0xce0
>       gpio_ioctl+0x49c/0xc80
>       __x64_sys_ioctl+0x134/0x1c0
>       do_syscall_64+0x109/0x5d0
>       entry_SYSCALL_64_after_hwframe+0x77/0x7f

For all patches, please, act in accordance with the Submitting Patches
documentation on backtraces in the commit messages.

> Keep the name with the line, or with the v1 line event, and free it
> there whoever freed the IRQ.
> 
> Reproduced with gpio-sim and a line requested with edge detection and
> a consumer label, the chip being removed while the request is open:
> kmemleak reports between 17 and 23 such objects after 30 cycles; with
> this change, none after 100.

...

> -static void free_line_irq(unsigned int irq, void *dev_id)
> +static void free_line_irq(unsigned int irq, void *dev_id, char **label)
>  {
>  	if (irq_has_action(irq))
> -		free_irq_label(free_irq(irq, dev_id));
> +		free_irq(irq, dev_id);
> +	free_irq_label(*label);
> +	*label = NULL;
>  }

This can be modified a bit to prepare for this with the suggestion to check
an irq here. So, in the previous patch you may have it as

	char *name = NULL;

	if (irq && irq_has_action(irq))
		name = free_irq(irq, dev_id);

	free_irq_label(name);

After this patch

	char *name = *label;

	if (irq && irq_has_action(irq))
		free_irq(irq, dev_id);

	free_irq_label(name);
	*label = NULL;

...

While it might be more verbose I think it makes the point clearer.

-- 
With Best Regards,
Andy Shevchenko


