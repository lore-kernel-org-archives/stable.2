Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8F8443C16;
	Fri, 16 Oct 2026 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157905; cv=none; b=e/+T5Andek2in9v4oytyqQ59teMAm8nT49qjrwVZ9SItPIajn0dPfzgzBZkz6+95p0UCfIAq1KKnY+9kRpeZ8Np38lTbeCDNJHf9v7PVhxaw4l7bxZcLdeC0eotOQPCTk/jZAY7aoX+gMKi24E8Bk3zu9V8EApndwMdg8HM9isQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157905; c=relaxed/simple;
	bh=dYBQheE5YI+tUxHvhPBifEUhQ4mSth+IuUGzJ2KlQqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOnx6tsoOFvdOIyn4EgcYCQl2r8DTIGvx0Lhnl5sKGLAy9pgpjk4snfTSFRtmQjAjSAFAni3E+QxGxdh1kreDLSFQNw0tCCfNBtXy44PKqpurVAumCD81Agd0i2vduE+zkL6GNtqxBRuukHAYb+1Mee5nvkLsbrti/DdX4zc1JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DO/CKQF0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DO/CKQF0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792157904; x=1823693904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dYBQheE5YI+tUxHvhPBifEUhQ4mSth+IuUGzJ2KlQqg=;
  b=DO/CKQF0Xn/ynydHXnbQgUh0ddxSJ8nroZggXvYn4eK4CmENk5zs25Fa
   2srnK81c7O0o3DeMZp4nGnZYYvStkLuS7RbsRVpuqIHJuDG1wqXbceULH
   5KSX3TYdyuvQ4eLpJHH+HGGX2JAWubVrJOxMHst8BsgAJ3dShFHjGKZov
   0KYmkfKQTz28Mj+SV7gSvcMFNUcF6jouA4WqiFGhu29UaWm/0ODT3A6tC
   td2gqX0ezzQqQ2q3wTKyO+R/40NQib6ypJaOKyI1iPF+JLU0+bE5F8QIF
   qh0eIwFPfTkywFgkS68yfQByzhTx2pCYDFY5D71DA4g4TqNiwryVmP0+U
   A==;
X-CSE-ConnectionGUID: K3Q9HHgLRJu25UmBFfqR6g==
X-CSE-MsgGUID: qjzdqibYTDiZPrGOH2UqHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="1040812"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1040812"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 06:38:10 -0700
X-CSE-ConnectionGUID: rpGYeulgQ2iTiC4VxbkeRg==
X-CSE-MsgGUID: +RJ33BCSRqy1DuJ7qTiRDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1933627"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.35])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 06:38:05 -0700
Date: Fri, 16 Oct 2026 16:38:03 +0300
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
Subject: Re: [PATCH v2 2/6] gpiolib: free the label of lines released after
 their chip was removed
Message-ID: <atIouwa5R8sb0nS-@ashevche-desk.local>
References: <20261016-gpiolib-chip-removal-v2-0-aambrozewicz@nvidia.com>
 <20261016-gpiolib-chip-removal-v2-2-aambrozewicz@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016-gpiolib-chip-removal-v2-2-aambrozewicz@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 16, 2026 at 12:23:34PM +0300, Adrian Ambrozewicz wrote:
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
>   unreferenced object (size 32):
>     comm "gpio-hold"
>     backtrace:

Be consistent, in other patch it's called Call Trace:. Is it really different
wording in the Oopses you got?

>       desc_set_label
>       gpiod_request_commit
>       gpiod_request
>       linereq_create
>       gpio_ioctl
> 
> Commit 1f2bcb8c8ccd ("gpio: protect the descriptor label with SRCU")
> cleared the label unconditionally; it moved under the chip check with
> the removal of gpio_lock. Return early only for a line that is not
> requested on a live chip, and clear the label before the chip check, so
> that it is also freed when the chip is gone. The ->free() callback, the
> flags update and the line state notification still need the chip and
> stay under the check; with the chip gone, no character device file can
> receive the notification any more.
> 
> The label is now often freed just before the last reference to the GPIO
> device goes away, which depends on gpiodev_release() waiting for pending
> label frees (previous patch).
> 
> Reproduced with gpio-sim: request a line through the character device,
> set the chip's configfs "live" attribute to 0 while the request is open,
> then close it. Without this change kmemleak reports between 15 and 30
> such objects after 30 cycles; with it, none after 100.

-- 
With Best Regards,
Andy Shevchenko


