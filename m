Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDBC3D9DB1;
	Tue,  6 Oct 2026 10:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791281953; cv=none; b=ScK7RoHGXESGhFn21aco6twga69gJYpWQzKCt2mRfq1qniQqeUTa91aaTtLYT3/Z6eGWfhGJLhuPALJY6sm+XxO+VU3CKcejvBO5CuN9OLL4cAtpU5kfgeKWmCy20uwcdC8k7/QFuaYiIM5Gj+Ryma06ivua8/W44GS3CP9WJXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791281953; c=relaxed/simple;
	bh=OaNAldnz+9ckvaaYLOdUyTKTxlfPsmmT7rxhIfzTZfI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FVXLD0yDIP3eudbvVCzR+VQoZgcbg3eeyKq7MU2HRoCJcEOapilS3CzVX/Tdsgw4GHHUfpJg+2IihXGhpzsfvnlgxF/wB4RD/1eo57Bikhs7xRoeIOJZ4hL6g/WwjRTnCfoLFhtC9NFPaSP1pSBFXgIxjDVTSvKsWAvFfQVhcKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CUHzSEhs; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CUHzSEhs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791281950; x=1822817950;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OaNAldnz+9ckvaaYLOdUyTKTxlfPsmmT7rxhIfzTZfI=;
  b=CUHzSEhs/pI0coPsrwaTaEvUuOU5oOorbcKG6Vv2UIHs/z5v3r1+L1Dn
   yFOAHE55MN8fS4noTF6Yg8r8kHaA8ejsol8yLmySQJoN4aveR2mBqOvnG
   Xr6Td5qTxq31VlycU9D6JI/bQKQ0559C5RpYOrJF3baFLGlrTA71qnTHx
   9NYs7m6R/XFwfG6uioq+NLa8zWNHTPz54nuO9/sus+Z0GJRAq60EXOKqI
   9kDTMOlTVFawbFaV4TPGTAd1FxiWcqhvYfeNNjOuJ1LTX6jnuIXQCkz6K
   nkubXhgCilbDLtChBhk79iAzXmEuwprQ/IqpKb2xC/e8c+qtzD4Bexzoi
   Q==;
X-CSE-ConnectionGUID: woGwG97VRlOtgBLAQm+GmA==
X-CSE-MsgGUID: uK8qBbD9TduxudWM4LreOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="18262"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="18262"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 03:19:08 -0700
X-CSE-ConnectionGUID: QUQMRA4IRUOXSw9Jo2tKew==
X-CSE-MsgGUID: QBBKzDfhTF+AyiqrjBbPsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="276620896"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 03:19:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 Oct 2026 13:19:02 +0300 (EEST)
To: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
cc: linux-serial <linux-serial@vger.kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, robh@kernel.org, krzk+dt@kernel.org, 
    conor+dt@kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-sunxi@lists.linux.dev, Enzo Adriano <enzo.adriano.code@gmail.com>, 
    stable@vger.kernel.org
Subject: Re: [PATCH 1/3] serial: 8250_dw: Keep the BUSY-safe divisor hook
 when DLF is present
In-Reply-To: <20261005172538.398522-2-vinicius.eduardo.pedrosa@gmail.com>
Message-ID: <e9538164-3565-a702-c26b-bdc0b8cb1c6c@linux.intel.com>
References: <20261005172538.398522-1-vinicius.eduardo.pedrosa@gmail.com> <20261005172538.398522-2-vinicius.eduardo.pedrosa@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 5 Oct 2026, Vinicius Pedrosa wrote:

> dw8250_probe() installs dw8250_set_divisor(), which brackets the
> DLAB/DLL/DLH sequence with dw8250_idle_enter()/dw8250_idle_exit() so that
> a BUSY UART cannot drop the divisor LCR write. dw8250_setup_port() runs
> afterwards and replaces that hook with the dwlib one whenever it detects
> a DLF register. The dwlib hook programs the divisor through
> serial8250_do_set_divisor() without entering idle.

Yeah, non-dwlib code should own the hook if it sets one.

> When termios changes while the UART is transmitting, the LCR|DLAB write
> is ignored and dw8250_check_lcr() retries it between
> dw8250_idle_enter() and dw8250_idle_exit(). dw8250_idle_exit() restores
> IER while DLAB is still set, so the value lands in DLH. The real IER
> keeps the zero written by dw8250_idle_enter(), and the port gets no
> further TX or RX interrupts while up->ier says they're enabled.
> 
> Program DLF from dw8250_set_divisor() inside the idle section and keep
> that hook after dw8250_setup_port().
> 
> Observed on an Allwinner A733 (Radxa Cubie A7Z): the first interactive
> tcsetattr() during console output left hardware IER at 0 and up->ier at
> 0x07. The shell never printed its prompt or read input. With this change
> alone the same boot reached the prompt and echoed input, and hardware
> IER matched up->ier afterwards.
> 
> Fixes: a7b9ce39fbe4 ("serial: 8250_dw: Ensure BUSY is deasserted")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
> ---
> The A733 has no real DLF. Offset 0xc0 is an RS485 control register that
> dw8250_setup_port() mistakes for one (patch 3), which is how this path
> was reached. The new DLF write hasn't been tested on a UART with a real
> DLF register.
> 
>  drivers/tty/serial/8250/8250_dw.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 0ab558230370..ba414306c98a 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -189,6 +189,7 @@ static int dw8250_idle_enter(struct uart_port *p)
>  static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
>  			       unsigned int quot, unsigned int quot_frac)
>  {
> +	struct dw8250_data *d = to_dw8250_data(p->private_data);
>  	struct uart_8250_port *up = up_to_u8250p(p);
>  	int ret;
>  
> @@ -196,6 +197,9 @@ static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
>  	if (ret < 0)
>  		return;
>  
> +	if (d->data.dlf_size)
> +		dw8250_writel_ext(p, DW_UART_DLF, quot_frac);

It might be better to add __dw8250_set_divisor() to dwlib to keep the DLF 
setting code in one place. If the dwlib side does d->data.dlf_size check, 
8250_dw side doesn't need to care about DLF stuff but can just 
unconditionally call __dw8250_set_divisor().

> +
>  	serial_port_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
>  	if (!(serial_port_in(p, UART_LCR) & UART_LCR_DLAB))
>  		goto idle_failed;
> @@ -650,7 +654,6 @@ static int dw8250_probe(struct platform_device *pdev)
>  
>  	p->set_ldisc	= dw8250_set_ldisc;
>  	p->set_termios	= dw8250_set_termios;
> -	p->set_divisor	= dw8250_set_divisor;
>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
> @@ -767,6 +770,13 @@ static int dw8250_probe(struct platform_device *pdev)
>  	if (!data->skip_autocfg)
>  		dw8250_setup_port(p);
>  
> +	/*
> +	 * dw8250_setup_port() installs the library divisor hook when it finds
> +	 * DLF. Keep the BUSY-safe hook instead: it also programs DLF, and it
> +	 * must own DLAB so that a BUSY UART never drops the divisor LCR write.
> +	 */
> +	p->set_divisor = dw8250_set_divisor;
> +
>  	/* If we have a valid fifosize, try hooking up DMA */
>  	if (p->fifosize) {
>  		data->data.dma.rxconf.src_maxburst = p->fifosize / 4;
> 

It might be safer approach to NULL check .set_divisor in dwlib before 
setting it as ordering requirements like this are easy to miss.

-- 
 i.

