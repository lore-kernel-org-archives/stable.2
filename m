Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D43051AFED;
	Wed, 30 Sep 2026 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777383; cv=none; b=ED9NXSqRB3QYjReLOmq3BRMNoPgpiFaF8W6PN8RSv28eBgVfJ0CHp5vAuiroJg+Vh9shbvSoArmrgbt9idILS/5jVWVDZ3LrYdIPApBOzspuhBcRP6V4wBjB4YJG+fmClVgh25WN/HXAZyGTo/U0MG/bbBxMgETY/Uj7DnjCkaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777383; c=relaxed/simple;
	bh=CmNlOEc+M7GHvNnPMcPjj8Al7buuiyY7UjLjA68pNKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQf9OxdpGitrRe5eeZcby+KpFU4tHWtUHn5dRA805ATgC7hw2NFjkc4eqDB9CeIet8tFOtkWeX2d52dNHnlj5898lMvhPLPzhX+TIhunh3+ZQE0bixYAHACdntTcTPsMmTipqVevX7yATVOj1BIDOeaJ9CokPtJaAo1hMDyIPVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NDnQgyHB; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NDnQgyHB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790777380; x=1822313380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CmNlOEc+M7GHvNnPMcPjj8Al7buuiyY7UjLjA68pNKw=;
  b=NDnQgyHBe0SnCvCR8dxyK9bx3qH5kcaKjgcDBNPDcKk9PQBxp7pVMU/w
   wvc+Km1rsDEJDKMaSaz49NzwxDWE3dq1IO97pTyDb2GbH0xhIwFevcruk
   CUmM8zk06HW/zsv8NnABfWl0J+5vcJ/PwAIwUnZqqEblOnjBdhx3A0AJx
   BXlsedk6DIj2hyVrHVevIUQ9fFn8AajRodY2XCg7BxihamoZ36UQrqa0v
   k/P0c5J7/e8tiJMYDoaC5nsK4MfKkiT0KglqD9etuN2ofVnhrSB7HpGRn
   rExJaAmKrXK4a5HB6MDz09UVLsx209zfINyIHAbMnJH4EmjGQfGw+eNJm
   A==;
X-CSE-ConnectionGUID: B7tZ9p9jSFu4SdH9MJQ1/w==
X-CSE-MsgGUID: Ivx+Ps9OQ0ykL1RWQiXC7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="107901139"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="107901139"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 07:09:36 -0700
X-CSE-ConnectionGUID: Nz0eh8baRyKNSYGawz13UQ==
X-CSE-MsgGUID: Dxr047RuTcSACNdlhmjMtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="274314621"
Received: from spandruv-desk1.amr.corp.intel.com (HELO localhost) ([10.245.245.137])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 07:09:34 -0700
Date: Wed, 30 Sep 2026 17:09:31 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hui Peng <benquike@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v7 2/2] serial: core: reject baud_base values that
 overflow port->uartclk in uart_set_info()
Message-ID: <ar0YG3ytLu_PoC9H@ashevche-desk.local>
References: <20260930125901.778868-1-benquike@gmail.com>
 <20260930125901.778868-3-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930125901.778868-3-benquike@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 30, 2026 at 12:59:01PM +0000, Hui Peng wrote:
> In uart_set_info(), new_info->baud_base is multiplied by 16 and stored in
> uport->uartclk (an unsigned int):
> 
>   uport->uartclk = new_info->baud_base * 16;
> 
> While uart_set_info() checks if (uartclk == 0) and
> if (new_info->baud_base < 9600), when new_info->baud_base exceeds
> UINT_MAX / 16 with low bits set (for example, 0x10000001), multiplying
> by 16 wraps around in 32-bit unsigned arithmetic to a small non-zero value
> (16), bypassing both uartclk == 0 and new_info->baud_base < 9600 and
> setting uport->uartclk = 16 (baud_base = 1, well below the required
> minimum of 9600 * 16).
> 
> Use check_mul_overflow(new_info->baud_base, 16, &uartclk) in
> uart_set_info() to reject overflowing baud_base values with -EINVAL.
> 
> Tested in QEMU against Linux 7.3.0-rc3 by calling ioctl(fd, TIOCSSERIAL,
> &ss) with ss.baud_base = 0x10000001 on /dev/ttyS1: on the unfixed kernel
> TIOCSSERIAL succeeds (ret = 0) and wraps uport->uartclk to 16
> (TIOCGSERIAL reports baud_base = 1), whereas with the fix applied
> TIOCSSERIAL returns -EINVAL and preserves the existing uport->uartclk.

...

>  	if (!(uport->flags & UPF_FIXED_PORT)) {
> -		unsigned int uartclk = new_info->baud_base * 16;
> 
>  		/* check needs to be done here before other settings made */
> -		if (uartclk == 0)
> +		unsigned int uartclk;

Don't move the variable definition (by a location) without need. I do not
see any need of doing it like that. Moreover this change will add a (style)
regression, id est unneeded blank line. So, just drop the assignment and
leave the definition as it's now.

> +		if (check_mul_overflow(new_info->baud_base, 16, &uartclk) ||
> +		    uartclk == 0)
>  			return -EINVAL;
>  	}

-- 
With Best Regards,
Andy Shevchenko


