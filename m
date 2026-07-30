Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2134A45C6E6;
	Thu, 30 Jul 2026 16:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428379; cv=none; b=ZIQcDHo2bMXokd1lfaaCaZjwlwBdNKIY6AwwjjXtgQPNEK93a88Y7BJVcn78todS0hOFYuJ3rfikbAmlSA9FkELBgrsXqPItOBpsDtxm9jQhFNuUfxjecT2q+rWbidABeKNQ+BKKl8xCynpbpH5z0OPScMzR+Uzp6GYpYLudAKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428379; c=relaxed/simple;
	bh=0E5556cEF/86q9Nxt49YB9AoDYsqlnwRU7N3yXmGaXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Td+b4/fFDZGY6U0F4IAtXdeBExTgwMo3RL+O6lPzRuSzdBJxp06gtitzQZZAXe6kXwx6vgAfB++gQ/hEBobyXuDe9giurMdwjgVkLv9FokzQaEY2fEgtL8mqPoBfMywj7b1Nj9Mo4VDnh6/hsCXMq2fwAlC+vjm3YW2M6VWxC6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xjb5XdHB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xjb5XdHB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC9B1F000E9;
	Thu, 30 Jul 2026 16:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785428377;
	bh=LBSRmBZqvSMofNWLtUeCzHkwk0Rv6M/cR5ZCysz+mVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=xjb5XdHB3bEwG5hD2Vgy9wHHpxY1Nx6jOh8fjWDWFq3wWJEZZjksW5khODV5MjOEa
	 FTPmFjXrPLOXlVZLf48kCxK3POQBEbLgiH7H47ff4O55nKAwrtP6nwkRc+0xS3UMr+
	 VLHA0eFpHXqraRbrgydIh6Lw3YUjbY3RPUxe77yI=
Date: Thu, 30 Jul 2026 16:31:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] serial: imx: serialize imx_uart_ports[] lifetime
Message-ID: <2026073011-crock-utmost-6392@gregkh>
References: <20260719221014.44354-1-kmehltretter@gmail.com>
 <20260719221014.44354-5-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719221014.44354-5-kmehltretter@gmail.com>

On Mon, Jul 20, 2026 at 12:10:14AM +0200, Karl Mehltretter wrote:
> imx_uart_probe() publishes the port in imx_uart_ports[] before
> uart_add_one_port(), because console setup during that call uses the
> table. The entry is not cleared if adding the port fails or after
> imx_uart_remove() removes it.
> 
> The port is devm-allocated, so a failed probe or unbind leaves the table
> pointing at freed memory. A later registration of the shared console can
> then dereference the stale entry. Reproduced on QEMU's mcimx6ul-evk by
> unbinding a sibling UART, unbinding the console UART and rebinding the
> sibling:
> 
>   BUG: KASAN: slab-use-after-free in imx_uart_console_setup+0xd0/0x3d8
> 
> The entry must remain valid until uart_remove_one_port() unregisters the
> console. Clearing it afterward without serialization still races a
> sibling probe: the sibling can register the shared console using the
> dying entry before it is cleared. The next console write then
> dereferences NULL.
> 
> Use a driver-wide mutex to serialize table publication, port addition
> and rollback with port removal and table clearing. Console callbacks
> remain lockless because uart_add_one_port() may invoke setup while
> probe holds the mutex.
> 
> The probe-failure path also relies on "serial: core: do fallible
> allocations before the console can be registered", which moves the
> uport->name and uport->tty_groups allocations before console
> registration. Both changes should be backported together.
> 
> Fixes: dbff4e9ea2e8 ("IMX UART: remove statically initialized tables")
> Fixes: 9f322ad064f9 ("imx: serial: handle initialisation failure correctly")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/all/20260719162850.043B41F000E9@smtp.kernel.org
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 251a50c8aa38..def874f9cd00 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -22,6 +22,7 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/ktime.h>
> +#include <linux/mutex.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/rational.h>
>  #include <linux/slab.h>
> @@ -2080,6 +2081,15 @@ static const struct uart_ops imx_uart_pops = {
>  
>  static struct imx_port *imx_uart_ports[UART_NR];
>  
> +/*
> + * Store the port in imx_uart_ports[] before uart_add_one_port() and clear
> + * it only after uart_remove_one_port() returns. Console callbacks in both
> + * calls use the table, so this mutex serializes these sequences between
> + * sibling ports. Callbacks must not take it because uart_add_one_port()
> + * may invoke setup while it is held.
> + */
> +static DEFINE_MUTEX(imx_uart_ports_lock);

Again, LLMs love to write comments/text, be sane please.  This comment
has nothing to do with the storing and such.

> +
>  #if IS_ENABLED(CONFIG_SERIAL_IMX_CONSOLE)
>  static void imx_uart_console_putchar(struct uart_port *port, unsigned char ch)
>  {
> @@ -2632,11 +2642,14 @@ static int imx_uart_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	imx_uart_ports[sport->port.line] = sport;
> -
>  	platform_set_drvdata(pdev, sport);
>  
> +	mutex_lock(&imx_uart_ports_lock);

guard()?

> +	imx_uart_ports[sport->port.line] = sport;
>  	ret = uart_add_one_port(&imx_uart_uart_driver, &sport->port);
> +	if (ret)
> +		imx_uart_ports[sport->port.line] = NULL;
> +	mutex_unlock(&imx_uart_ports_lock);
>  
>  err_clk:
>  	clk_disable_unprepare(sport->clk_ipg);
> @@ -2647,8 +2660,12 @@ static int imx_uart_probe(struct platform_device *pdev)
>  static void imx_uart_remove(struct platform_device *pdev)
>  {
>  	struct imx_port *sport = platform_get_drvdata(pdev);
> +	unsigned int line = sport->port.line;

Why are you reading this outside of the lock?

>  
> +	mutex_lock(&imx_uart_ports_lock);

guard()?

thanks,

greg k-h
