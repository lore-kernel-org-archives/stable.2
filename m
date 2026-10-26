Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012652;
	b=4YPNXuvTuD2UrVP8i4jsOyPNrgSTtN/GUr+8a6vGF0V9EedGqyx2kq9cA1VijT+F5+FI
	 yfoA7VkCq+EFuUZ5ppeZND2v+4C5e7DDh1Okq1BIV67d5CisdddOVRjtAEAwdnxhDVtz5
	 NOwvKWVzunyw2RRRjO7KBpmPY11beapfMrZNwygmnbIBVq5HREwdiiwHIVp1IFnIyHeSs
	 81ySMtPSjzXEU+WBf9c8VQjSuc0EPzDJKDXMVSce6ktVcC0qG7BtEa38tPR2PInhsGGY+
	 CBkN8bBA3Rc6jjmXKXyd2u706Ie4+N7Zj70lyu9oBClKRGmUybhCBlrftW8EzEAcs2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012652;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=+7lSc9bS1/FhK1L6agezkJWt52iS9SoyfWq4Ni3rD1M=;
	b=uwEoWCtqaDJ99NRHFEh15gx5PVdwJMglW9nMvSw4NK01ybIUWBUSnkUO23/ovlIomwUj
	 27O1VhgRrFg8UGsu0jfHsocQBXqtvEPLfBckoZfogzq7KhISHofxg5iDWBon+HNPH7L1N
	 20yvQoDl/v39+s9PTjeUQL/WvGLskO45UvdAl/4gwmgMOwKWOOOYWtqENQrvoS4Qc+fTV
	 MytbPK9QZ8ywOyKtSyTSmGoOhcW65mRh4R9kEFnbdkpO5dPATp9v5iTHpRrnXViT5E7kb
	 zLJA4aeGPB+qwZQlX+rHQM5gnpnAgd5nYzKK3WI99quAD7YInQQJYlmb+3b3y/0DfGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UwKKjowA;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0194606A324;
	Mon, 26 Oct 2026 11:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0194606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UwKKjowA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793012652; x=1824548652;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6eG67Ytw/5AXlsrQajZVFK7YTNbjLHeV4uqlUNul9IA=;
  b=UwKKjowA/Ajb9yEaWzbWnGqubPIUl9k8rNzPu8oXF6hPc4ztexe/OdKc
   +UbNDOvOI170/8zc2RZ7qsxH0mBT7UBarOiWP0cUTyeVKLfqLdD408FNR
   7j0GbP8mBNcMSroqGb7D+4X8wBJlxzy+hKxOBdkcSlZzI3LS4kYF7ncKl
   gDxiF/JN+z9ak5l5ASv6+r767VcWYnPR4QvEZnJfbMwHst+is+hukg9Ho
   EEqlpspN/xPTa91POI3B86H01Lqj0DOcjiiGOaN7LOhuuF73I0EuVLnws
   6wt+ocWL7BdjU+L0rYI0jeMrAJLtj3kMcDbj/sYQg6ZZ1Cpw3zzL42zez
   A==;
X-CSE-ConnectionGUID: HDSN3q+IRyuoD5TG1Md2aA==
X-CSE-MsgGUID: Kzi5PMIESsuCofoo5n7IRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1583637"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1583637"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 04:04:11 -0700
X-CSE-ConnectionGUID: YRbEG+DiRHKgICnjwsLgog==
X-CSE-MsgGUID: xAgWaSUFQDy7fkQ30DF7JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4347067"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 04:04:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 26 Oct 2026 13:04:03 +0200 (EET)
To: James Hilliard <james.hilliard1@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Raul E Rangel <rrangel@chromium.org>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250_dw: preserve BUSY-safe fractional divisor
 programming
In-Reply-To: <20261024-submit-serial-8250-dw-divisor-v1-v2-1-032ca5338359@gmail.com>
Message-ID: <e3567bb4-394c-39bf-fb97-8254585fffa6@linux.intel.com>
References: <20261024-submit-serial-8250-dw-divisor-v1-v2-1-032ca5338359@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 24 Oct 2026, James Hilliard wrote:

> dw8250_probe() installs a divisor setter that makes the UART idle and
> checks DLAB before writing DLL and DLH. When dw8250_setup_port() detects
> fractional-divisor support, it replaces that setter with the library's
> callback. The replacement writes DLF and uses serial8250_do_set_divisor(),
> bypassing the divisor setter's idle sequence and DLAB readback.
> 
> If the LCR update fails to set DLAB, the subsequent divisor writes can
> reach TX and IER instead of DLL and DLH.
> 
> Expose the library's fractional-divisor calculation and DLF write as
> shared helpers. Install the BUSY-safe setter after hardware discovery and
> use the shared DLF helper to program the fractional field only after DLAB
> has been confirmed, alongside DLL and DLH. Select the shared calculator
> when fractional divisors are supported, preserving the core calculation
> for integer-only ports.
> 
> Fixes: a7b9ce39fbe4 ("serial: 8250_dw: Ensure BUSY is deasserted")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes in v2:
> - Share the fractional-divisor calculation and DLF write through exported
>   dwlib helpers, and use them in the platform driver as requested by Andy.
> - Select the fractional calculator only when DLF is implemented, preserving
>   the existing core calculation for integer-only ports.
> - Link to v1: https://lore.kernel.org/r/20261023-submit-serial-8250-dw-divisor-v1-v1-1-f452d4bb1b1f@gmail.com
> 
> Previously included in the DMA cancellation series v4:
> https://lore.kernel.org/r/20261023-submit-serial-8250-dma-cancel-v1-v4-0-e759de1839de@gmail.com
> 
> Changes in DMA cancellation v4:
> - Keep DesignWare's BUSY-safe divisor setter after fractional-divisor
>   discovery, writing DLF and DLL/DLH only after confirming DLAB.
> - Link to v3: https://patch.msgid.link/20261023-submit-serial-8250-dma-cancel-v1-v3-0-d78f9e4c4932@gmail.com
> ---
>  drivers/tty/serial/8250/8250_dw.c    |  9 ++++++++-
>  drivers/tty/serial/8250/8250_dwlib.c | 15 +++++++++++----
>  drivers/tty/serial/8250/8250_dwlib.h |  2 ++
>  3 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index eca02e8bd6d1..d036a2fe258a 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -190,6 +190,7 @@ static int dw8250_idle_enter(struct uart_port *p)
>  static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
>  			       unsigned int quot, unsigned int quot_frac)
>  {
> +	struct dw8250_port_data *pd = p->private_data;
>  	struct uart_8250_port *up = up_to_u8250p(p);
>  	int ret;
>  
> @@ -201,6 +202,8 @@ static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
>  	if (!(serial_port_in(p, UART_LCR) & UART_LCR_DLAB))
>  		goto idle_failed;
>  
> +	if (pd->dlf_size)

Why does 8250_dw.c have to care about this detail? It feels 8250_dw is 
still crossing "layer" entirely unnecessarily here, can't dwlib's 
dw8250_set_divisor_dlf() just do nothing if dlf_size is not set? That is, 
do this in dw8250_set_divisor_dlf():

	if (!pd->dlf_size)
		return;

-- 
 i.

> +		dw8250_set_divisor_dlf(p, quot_frac);
>  	serial_dl_write(up, quot);
>  	serial_port_out(p, UART_LCR, up->lcr);
>  
> @@ -651,7 +654,6 @@ static int dw8250_probe(struct platform_device *pdev)
>  
>  	p->set_ldisc	= dw8250_set_ldisc;
>  	p->set_termios	= dw8250_set_termios;
> -	p->set_divisor	= dw8250_set_divisor;
>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
> @@ -768,6 +770,11 @@ static int dw8250_probe(struct platform_device *pdev)
>  	if (!data->skip_autocfg)
>  		dw8250_setup_port(p);
>  
> +	/* Use the BUSY-safe sequence for both integer and fractional divisors. */
> +	if (data->data.dlf_size)
> +		p->get_divisor = dw8250_get_divisor_dlf;
> +	p->set_divisor = dw8250_set_divisor;
> +
>  	/* If we have a valid fifosize, try hooking up DMA */
>  	if (p->fifosize) {
>  		data->data.dma.rxconf.src_maxburst = p->fifosize / 4;
> diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
> index 9bb02a4ab11f..88562c8d5d1d 100644
> --- a/drivers/tty/serial/8250/8250_dwlib.c
> +++ b/drivers/tty/serial/8250/8250_dwlib.c
> @@ -23,8 +23,8 @@
>   * we have: div(F) * (16 * baud) = rem
>   * so frac = 2^dlf_size * rem / (16 * baud) = (rem << dlf_size) / (16 * baud)
>   */
> -static unsigned int dw8250_get_divisor(struct uart_port *p, unsigned int baud,
> -				       unsigned int *frac)
> +unsigned int dw8250_get_divisor_dlf(struct uart_port *p, unsigned int baud,
> +				  unsigned int *frac)
>  {
>  	unsigned int quot, rem, base_baud = baud * 16;
>  	struct dw8250_port_data *d = p->private_data;
> @@ -35,11 +35,18 @@ static unsigned int dw8250_get_divisor(struct uart_port *p, unsigned int baud,
>  
>  	return quot;
>  }
> +EXPORT_SYMBOL_GPL(dw8250_get_divisor_dlf);
> +
> +void dw8250_set_divisor_dlf(struct uart_port *p, unsigned int quot_frac)
> +{
> +	dw8250_writel_ext(p, DW_UART_DLF, quot_frac);
> +}
> +EXPORT_SYMBOL_GPL(dw8250_set_divisor_dlf);
>  
>  static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
>  			       unsigned int quot, unsigned int quot_frac)
>  {
> -	dw8250_writel_ext(p, DW_UART_DLF, quot_frac);
> +	dw8250_set_divisor_dlf(p, quot_frac);
>  	serial8250_do_set_divisor(p, baud, quot);
>  }
>  
> @@ -217,7 +224,7 @@ void dw8250_setup_port(struct uart_port *p)
>  
>  	if (reg) {
>  		pd->dlf_size = fls(reg);
> -		p->get_divisor = dw8250_get_divisor;
> +		p->get_divisor = dw8250_get_divisor_dlf;
>  		p->set_divisor = dw8250_set_divisor;
>  	}
>  
> diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
> index 39fcb1b323ad..7191cabfb086 100644
> --- a/drivers/tty/serial/8250/8250_dwlib.h
> +++ b/drivers/tty/serial/8250/8250_dwlib.h
> @@ -97,6 +97,8 @@ struct dw8250_port_data {
>  	int		srbr;
>  };
>  
> +unsigned int dw8250_get_divisor_dlf(struct uart_port *p, unsigned int baud, unsigned int *frac);
> +void dw8250_set_divisor_dlf(struct uart_port *p, unsigned int quot_frac);
>  void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, const struct ktermios *old);
>  void dw8250_setup_port(struct uart_port *p);
>  
> 
> ---
> base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
> change-id: 20261023-submit-serial-8250-dw-divisor-v1-5f1689ed05a8
> 
> Best regards,
> --  
> James Hilliard <james.hilliard1@gmail.com>
> 
