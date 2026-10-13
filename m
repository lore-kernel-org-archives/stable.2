Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBC553163D;
	Tue, 13 Oct 2026 21:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791926021; cv=none; b=cKkC6NstTCun5dQp99MM+dlUp+VcnAQRLqusy2kHT/ArC10e6Yn3Oj9h/HgXAbTeJZ7Wns1qBinodpzemh4h/fs57bIhQRHiJjmBKKy3rkcCvwutz5PlNR833FL8oaGAwLXRPh4gJYgkDipEa7wR4NQ1BuJAlB3LaDdkQ5RnT6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791926021; c=relaxed/simple;
	bh=PFDwp3ve20Tz9F5GKmdlFdLeXZwU0oECJgtbAN1tiFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGZqNG4xMz9/AcqsyT3p7FpI3hW3V0Q4ydix+UMCeDw6AYz/ivDaO5AktxZjcfxfr91jDHubh/y3aVJZPw5L4eH3xOMtsTvqjlG8L64tZzz0qZdhXL2TvWvKCguCJGszWzndJiWg1pJHzuKFndO0rIFObbt+FvLUJamSzXVatKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nMAYHWZa; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nMAYHWZa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791926019; x=1823462019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PFDwp3ve20Tz9F5GKmdlFdLeXZwU0oECJgtbAN1tiFw=;
  b=nMAYHWZawtDZzPZG/Qs2mhX7ygeLizXJP0D3VO7UjhUbi/bsaSVu//Yt
   fcBLXXeGq+YjFN8ls5jjS20Q3I2GYU1Z/TutcAuxkNrI+16huTzXCs8pQ
   Y8vMMKJ16YHn0WWOJJPsFnqct89UAN0v0Ys8ZDImFsLUQwUeO/QU1mTIJ
   HIdEGumM7QQo6HRBuPVquEFNyuDjQQcUzvZI+lKkX/z66azrvyoxEuiVb
   xqn83nFQOEBqZx49tHncdFeY6+cBiqTvhLQT65wty8+5DL5UV+IWxx5RQ
   Hsta3O1MYYTUUdnOVM72fb5LiJSz+G64F3l5vFk4FXygbT+kfkDmsUpkR
   w==;
X-CSE-ConnectionGUID: Y9yAIoFxSuusrgu9Bxhhpw==
X-CSE-MsgGUID: y7piBJlPTX6BlNKHejDMew==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="552933"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="552933"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 14:13:38 -0700
X-CSE-ConnectionGUID: JA9yd4VORrWtRwQw7FOb0Q==
X-CSE-MsgGUID: FYCBG7gWRFS2d+4JnZdz8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1702672"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 14:13:36 -0700
Date: Wed, 14 Oct 2026 00:13:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 4/6] serial: 8250_lpss: do not touch uninitialized
 line in ehl_serial_exit()
Message-ID: <as6e_qLKWT5bXR9V@ashevche-desk.local>
References: <cover.1791873876.git.jirislaby@kernel.org>
 <f389df34aaa538270313ebd4cea75c2baaf46b95.1791873876.git.jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f389df34aaa538270313ebd4cea75c2baaf46b95.1791873876.git.jirislaby@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 08:48:49AM +0200, Jiri Slaby (SUSE) wrote:
> lpss8250_probe() calls lpss->board->exit() on its error path. For the
> EHL board, that is ehl_serial_exit() and it does:
> serial8250_get_port(lpss->data.line)->dma = NULL;
> 
> But when lpss8250_dma_setup() or serial8250_register_8250_port() fails,
> lpss->data.line was never assigned. As lpss is kzalloc()ed, line is 0
> and ehl_serial_exit() clears the dma pointer of an unrelated port --
> serial8250_ports[0], i.e. ttyS0, which is often the console.
> 
> Initialize lpss->data.line to -1 in probe and skip the clearing in
> ehl_serial_exit() if no port was registered.

Thanks for the catch and the fix, my comments below.

> Fixes: 5318f70da7e8 ("serial: 8250_lpss: Balance reference count for PCI DMA device")
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Assisted-by: LLM
> Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: stable@vger.kernel.org
> -- pick
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: linux-serial@vger.kernel.org
> 
> [v2] no declaration in the middle of a function (Ilpo)
> ---

Hmm... Something went wrong with the Cc list, I would expect to see

  Assisted-by: LLM
  Cc: stable@vger.kernel.org
  ---
  Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
  Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Cc: linux-serial@vger.kernel.org

  [v2] no declaration in the middle of a function (Ilpo)
  ---

...

>  static void ehl_serial_exit(struct lpss8250 *lpss)
>  {
> -	struct uart_8250_port *up = serial8250_get_port(lpss->data.line);
> -
> -	up->dma = NULL;
> +	if (lpss->data.line >= 0)
> +		serial8250_get_port(lpss->data.line)->dma = NULL;

I would rather make it more readable by splitting the operations.

	struct uart_8250_port *up;

	if (lpss->data.line < 0)
		return;

	up = serial8250_get_port(lpss->data.line);
	up->dma = NULL;

>  }

-- 
With Best Regards,
Andy Shevchenko


