Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BE238B135;
	Thu, 30 Jul 2026 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428370; cv=none; b=W13PH9IznoN/19v/EGX7Y0IUbfyV+Avi/4ZlM0wfc1H9nlZsuqcUSP3PzB5K2MJQYlU1NqQLJZKNWUHeWHP+L7Z38zze223kyd178hdTCrXLEnTpIbxCTuU/CxwJR2/P3Okk8vNkTQ6ILVWJ3qWHNEQMp8pmcV3LvCYBbAd+ESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428370; c=relaxed/simple;
	bh=RYVKTX6h3fRrnmGf20lJS+F/Ek+0xZ9IanpkiG0PAk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdTWOijHQaWHsn0sSrT+Uc4t1m8hoBQPIz6t2cNSZFHiZu4wABIn901gQfW5XlUFtN6O5M7bfO9PGb9RqNImrho2+1vEQIJMyO6U40dZMOFQ+5Z8E5QnJ4Pi0ZlG89xW5UT0RTYcqYNIvBfvBug7Hr9O183x309euXpM2g7lcXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bq4xfnbh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bq4xfnbh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0D21F000E9;
	Thu, 30 Jul 2026 16:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785428369;
	bh=4YV3RgJ3MIMo6yQVwYJ8dSAMBKSsBsm+yiCxLQER138=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bq4xfnbhQ8a3UjgNpgkxAVXuDHITCJGPG2M6IDdbZNT/Fw7ZZZ9D2nmaSxrSyatDu
	 idkCH3EtKQirBpWp5RrW3XStHeDlHj9PRDgEPvWtPqsFq8ekpCZW4vNqHNGomb+P1h
	 2kCOvDATVo8Cuez6y4VjDoPvCtD7Fbjj63jBviF0=
Date: Thu, 30 Jul 2026 16:28:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] serial: core: do fallible allocations before the
 console can be registered
Message-ID: <2026073056-embargo-rejoicing-87c2@gregkh>
References: <20260719221014.44354-1-kmehltretter@gmail.com>
 <20260719221014.44354-2-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719221014.44354-2-kmehltretter@gmail.com>

On Mon, Jul 20, 2026 at 12:10:11AM +0200, Karl Mehltretter wrote:
> serial_core_add_one_port() allocates uport->tty_groups after
> uart_configure_port() has already registered the port's console. If
> that allocation fails, the function returns -ENOMEM with the console
> still registered, and the driver's probe error path then tears down
> the port state the console callbacks depend on.
> 
> Reproduced with fault injection on qemu's raspi1ap board. Failing the
> tty_groups allocation during a PL011 sysfs bind makes
> uart_add_one_port() return -ENOMEM. pl011_register_port() then clears
> amba_ports[0], but ttyAMA0 remains registered as a console. The nbcon
> printer thread dereferences the NULL entry and oopses:
> 
>   Unhandled fault: page domain fault (0x01b) at 0x00000178
>   CPU: 0 UID: 0 PID: 43 Comm: pr/ttyAMA0 Not tainted 7.2.0-rc3+ #1
>   PC is at pl011_console_write_thread+0x2c/0x168
> 
> This is not PL011-specific: the failing allocation is in serial core,
> after uart_configure_port() has registered the console, so any console
> UART driver is exposed. On i.MX the retained console references a
> devm-allocated port that the failed probe frees, causing a
> use-after-free. Reproduced on qemu's mcimx6ul-evk using the same
> fail-nth harness under KASAN:
> 
>   BUG: KASAN: slab-use-after-free in imx_uart_console_write_thread+0x50/0x278
>   Read of size 4 at addr c5246048 by task pr/ttymxc0/63
>    imx_uart_console_write_thread from nbcon_emit_next_record+0x360/0x50c
>    nbcon_emit_next_record from nbcon_emit_one+0x140/0x184
>   Allocated by task 1:
>    devm_kmalloc from imx_uart_probe+0x90/0xa5c
>   Freed by task 1:
>    devres_release_all from device_unbind_cleanup+0x38/0xdc
>    device_unbind_cleanup from really_probe+0x2b4/0x388
> 
> The pre-existing kasprintf() failure path has a related problem: it
> returns with state->uart_port already pointing at a port whose probe
> is about to unwind and free it.
> 
> Reorder the function so the uport->name and uport->tty_groups
> allocations both happen before the port is linked into the driver
> state table and before uart_configure_port() registers the console:
> 
>  1. Allocate uport->name.
>  2. Allocate the tty_groups array with room for three entries
>     unconditionally (serial core group, optional driver group, NULL
>     terminator). The optional group cannot be examined at this point:
>     config_port() may only supply uport->attr_group during
>     uart_configure_port(), e.g. 8250 sets it after autodetection.
>  3. Only then link the port into the driver state table and run
>     uart_configure_port().
>  4. Fill in the optional attr_group slot afterwards.
> 
> A fail-nth sweep over the whole bind path on both boards left the
> console unregistered after every failed bind and did not reproduce the
> i.MX use-after-free.
> 
> Fixes: 266dcff03eed ("Serial: allow port drivers to have a default attribute group")
> Fixes: f7048b15900f ("tty: serial_core: Add name field to uart_port struct")
> Cc: stable@vger.kernel.org

As this can only be duplicated with fault-injection, it really doesn't
need to go to any stable kernels, right?



> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  drivers/tty/serial/serial_core.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index a530ad372b43..887b1dd80ad2 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3056,7 +3056,6 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
>  	struct uart_state *state;
>  	struct tty_port *port;
>  	struct device *tty_dev;
> -	int num_groups;
>  
>  	if (uport->line >= drv->nr)
>  		return -EINVAL;
> @@ -3068,6 +3067,23 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
>  	if (state->uart_port)
>  		return -EINVAL;
>  
> +	uport->name = kasprintf(GFP_KERNEL, "%s%u", drv->dev_name,
> +				drv->tty_driver->name_base + uport->line);
> +	if (!uport->name)
> +		return -ENOMEM;
> +
> +	/*
> +	 * uart_configure_port() may set uport->attr_group and register the
> +	 * console. Allocate room for both groups and a NULL terminator first.
> +	 */
> +	uport->tty_groups = kzalloc_objs(*uport->tty_groups, 3);
> +	if (!uport->tty_groups) {
> +		kfree(uport->name);
> +		uport->name = NULL;

Why set this to NULL?

thanks,

greg k-h
