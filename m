Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792851278;
	b=Y2cy1gZhW9HLGwK5TK8ad+WlSbJEjfDmR5u9+Hb7qQH2PaO2/7pMgYCw9Gv25c4TXzA8
	 AndgMgcaqJw1xDcWayFg4BteqyGvfsJUtjvcJfTbCT+D4kj4RjfqEqj4SFmFioxE4Z2xJ
	 2eFCIrttpAafP31YZxEN/JXpCnf6zgBezy5Cc1NpaZndH06hk8ruWUpsiPiE8/e2WCdtl
	 tDWnFtS6NiXtfolCDhyBY7uPuoVFcJG88DnfWV07BP9aqTscxMI71OnzAbrYlxfq19Pe6
	 wvG1IMkeiZVKwogTW0d7igyWdaPyg4eMAEqYaQY6e4L5C9RiCTD13T651x5kAE5qNMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792851278;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=8Bv8zm7XNsLRVn3LnImSn0NVeOMUvsqV0SZT9DMvmik=;
	b=kdhIgTcHFWErDmagPOKDjK+bzpOZdgpyxzzb+M6yrhSBpW7t3vppLDP2dJxx7v/QMCyJ
	 7X4NBDm+tdUL+UwxXn3U9RJPR7zjohZKHvtM2jx61GZ/F1kAvgQV5bPWBMQFuc2BodRCf
	 arKkWnXjXGlYVDsLdT9bXHuQFV9CDkKnpYVDxl3e35cKRf5lO+DAORwUKa0IRphqXcsLH
	 UUOzXLqQgZP2ZsX2+0fONGm0ebAqOtZG5CHVbGm7D8bDBozwAiri41cyJgQycWRVNVmYo
	 5++SndNbCtQ5AO7Cp1MgtL36JuxDzoQ8x47gDn/Qyqah7iKT88Q3NYcCBFQh6wgPU/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=db9xt5Mv;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8BF606A31A;
	Sat, 24 Oct 2026 14:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE8BF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=db9xt5Mv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792851277; x=1824387277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=usH5EuShCy2UbML2kbeFVG+kU8NRmf11PsDnNGqiAvY=;
  b=db9xt5MvsIgLQPQyju66o7BxIyHdvOq/y/dzhMddvjYsC1OaqQpJe75w
   x5xOsMWQOyq46zVzdz8eRQQ3dse4VKzUZ9xl8TjDpKrLSzOrkv+U2lUNy
   uDqKqYv7frIu5KI1BJo8toHYYv4VxAqAJHrF1aDGM2q4bNTt2v++8cLkv
   iudxQFrK4niQiKYt6GKviXe/3dvnAGTFtJirkd3PJcw+FyjTU/5mvmmCx
   p40KA1Vkwdt/695SlTtPRGkvz4UnEF9jzOhRLL/jc18SOizcmiB8Q73SG
   txLydsRAiWyH5pw/id1oAbnI4qcW7FTBSdzTRsJYov/mrZVjOKW4+s/Sv
   g==;
X-CSE-ConnectionGUID: qmTp7o6BTOO8YfQmIGa1MA==
X-CSE-MsgGUID: 9pbRMMw7S3mTsPiIfPuaXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1594542"
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="1594542"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 07:14:36 -0700
X-CSE-ConnectionGUID: EfaqV5EhQT26ry0mQSZHHg==
X-CSE-MsgGUID: nV1Z65ktSMOV29IAbSTkqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="3744843"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.221])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 07:14:13 -0700
Date: Sat, 24 Oct 2026 17:14:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Raul E Rangel <rrangel@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_dw: preserve BUSY-safe fractional divisor
 programming
Message-ID: <aty9MzTQX-iKPdt3@ashevche-desk.local>
References: <20261023-submit-serial-8250-dw-divisor-v1-v1-1-f452d4bb1b1f@gmail.com>
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
In-Reply-To: <20261023-submit-serial-8250-dw-divisor-v1-v1-1-f452d4bb1b1f@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 23, 2026 at 11:50:17PM -0600, James Hilliard wrote:
> dw8250_probe() installs a divisor setter that makes the UART idle and
> checks DLAB before writing DLL and DLH. When dw8250_setup_port() detects
> fractional-divisor support, it replaces that setter with the library's
> callback. The replacement writes DLF and uses serial8250_do_set_divisor(),
> bypassing the divisor setter's idle sequence and DLAB readback.
> 
> If the LCR update fails to set DLAB, the subsequent divisor writes can
> reach TX and IER instead of DLL and DLH.
> 
> Install the BUSY-safe setter after hardware discovery and extend it to
> write DLF when fractional divisors are supported. Program both divisor
> fields only after DLAB has been confirmed, retaining the fractional
> divisor calculation selected by dw8250_setup_port().

...

> static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,

>  	if (!(serial_port_in(p, UART_LCR) & UART_LCR_DLAB))
>  		goto idle_failed;
>  
> +	if (pd->dlf_size)
> +		dw8250_writel_ext(p, DW_UART_DLF, quot_frac);

I still think it's better to export dw8250_?et_divisor_dfl() from dwlib and use
both here.

In dwlib:

unsigned int dw8250_get_divisor_dfl(struct uart_port *p, unsigned int baud,
                                    unsigned int *frac)
{
        unsigned int quot, rem, base_baud = baud * 16;
        struct dw8250_port_data *d = p->private_data;

        quot = p->uartclk / base_baud;
        rem = p->uartclk % base_baud;
        *frac = DIV_ROUND_CLOSEST(rem << d->dlf_size, base_baud);

        return quot;
}

void dw8250_set_divisor_dfl(struct uart_port *p, unsigned int baud,
                            unsigned int quot, unsigned int quot_frac)
{
        dw8250_writel_ext(p, DW_UART_DLF, quot_frac);
}


static unsigned int dw8250_get_divisor(struct uart_port *p, unsigned int baud,
                                       unsigned int *frac)
{
        return dw8250_get_divisor_dfl(p, baud, frac);
}

static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
                               unsigned int quot, unsigned int quot_frac)
{
	dw8250_set_divisor_dfl(p, baud, quot, quot_frac);

        serial8250_do_set_divisor(p, baud, quot);
}

In dw:

static unsigned int dw8250_get_divisor(struct uart_port *p, unsigned int baud,
                                       unsigned int *frac)
{
        return dw8250_get_divisor_dfl(p, baud, frac);
}

static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
                               unsigned int quot, unsigned int quot_frac)
{
	...
	if (pd->dfl_size)
		dw8250_set_divisor_dfl(p, baud, quot, quot_frac);
	...
}

...

> +	/* Use the BUSY-safe sequence for both integer and fractional divisors. */

...and here

	p->get_divisor = dw8250_get_divisor;

> +	p->set_divisor = dw8250_set_divisor;


-- 
With Best Regards,
Andy Shevchenko


