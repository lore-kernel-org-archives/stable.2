Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B873AFCE6;
	Tue, 13 Oct 2026 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897409; cv=none; b=lqZjtC3wI+IT+DEjkW0p/U6XGwOtCL71GFV5le4lT019zNBnWbB1qaxboYLlEHh4EtVS9tlmDflVI0HIG4fNWit8j+e0sr/yIU2GuEqkanOpefD3ZGKOcXc+aLNVyAyLj3DLr7R8cD3M2E7c50deqZo3aLfApJai22EkKiasKJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897409; c=relaxed/simple;
	bh=FIPSuuAhJUZjRKHszZhAldZlUkr1RYeuYNKC12aR3Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nw7NbyC2eaU6XZ6+W4kUjbpbmipW+EV5MMhbjHDymmjimNKjzJG+ZOanHlzXZsktwQC6i6GtlBx2mSr2XUxFhxQHPwxWjIfGNeIEdi4sir+5gVUREfaSqGF8EcPyxLfCXd+6/3H8hIV8c3nmeq+J343ck1VCsaqJji509Rn2KMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lp4/79zN; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lp4/79zN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791897409; x=1823433409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FIPSuuAhJUZjRKHszZhAldZlUkr1RYeuYNKC12aR3Nk=;
  b=Lp4/79zN8HEbIVOG+qG6R8jFSlbNv78t0I9W1sqEuBibvFTpFq3lN6iU
   p3xDeK5MkP1b/XNz5pfWLLo/el2T4MAH8DLLPnFxoiW/yviKMvVwUf+1S
   MdW09QPWtdML4mjWAm4ID9al+xfQIKAhKvr33EPjtER3l1iLWoi7xE3wH
   6KkKtKmEkCLGeZEA8cr41UTjrxGc24UNCgATED7X/O6A5ZnXqByNRlXdw
   5/XlURqWFDt8cWEls+GZh684zID8hlYR0aJyTHUoVjQP9mx0ITJ+NoG5I
   7oZFL8Il6Qltb7jZuP+046GSsOAh7sKfnvIajKKOtKkvHicUNYrrEyg+t
   w==;
X-CSE-ConnectionGUID: TAuF8MoZScyrZ7FS+1Oq1g==
X-CSE-MsgGUID: 2SRmDVnHTIKQwUp7qKhcoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="716911"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="716911"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:16:48 -0700
X-CSE-ConnectionGUID: SurxRxWWR++Z/RD+iIDdww==
X-CSE-MsgGUID: s+kdQgkrTRKlo3wJuiMFgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1091049"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:16:44 -0700
Date: Tue, 13 Oct 2026 16:16:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ma Ke <make_ruc2021@163.com>
Cc: antonio.borneo@foss.st.com, linusw@kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	fabien.dessenne@foss.st.com, linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH] pinctrl: stm32: Fix fwnode reference leak in
 stm32_gpiolib_register_bank()
Message-ID: <as4vOoSRE0zjh8NT@ashevche-desk.local>
References: <20261011061722.3159941-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011061722.3159941-1-make_ruc2021@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 11, 2026 at 02:17:22PM +0800, Ma Ke wrote:
> stm32_gpiolib_register_bank() walks the "gpio-ranges" property with
> fwnode_property_get_reference_args().  As documented in
> drivers/base/property.c:
> 
>  * The caller is responsible for calling fwnode_handle_put() on the
>  * returned @args->fwnode pointer.
> 
> The returned reference is never put.  The function calls the helper
> twice, once directly and then repeatedly in a while loop, and each
> call overwrites args, so only the last reference is even reachable
> and all the earlier ones are leaked for good.
> 
> Put the reference as soon as args.args[] has been consumed, both for
> the initial call and for every iteration of the loop.
> 
> Found by code review.

...

>  		/* get the last defined gpio line (offset + nb of pins) */
>  		npins = args.args[0] + args.args[2];
> -		while (!fwnode_property_get_reference_args(fwnode, "gpio-ranges", NULL, 3, ++i, &args))
> +		fwnode_handle_put(args.fwnode);
> +
> +		while (!fwnode_property_get_reference_args(fwnode, "gpio-ranges", NULL, 3, ++i, &args)) {
>  			npins = max(npins, (int)(args.args[0] + args.args[2]));
> +			fwnode_handle_put(args.fwnode);
> +		}

Can we use GPIOLIB facility to fulfil the task? Yeah, it seems non-trivial
change, so for the quick fix the above seems okay.

-- 
With Best Regards,
Andy Shevchenko


