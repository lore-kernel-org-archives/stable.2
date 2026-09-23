Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D00485936;
	Wed, 23 Sep 2026 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158548; cv=none; b=pZ+ENxf1KStKnBdUuhtBjkHhsuy4mEkhpSEyeOXxWEmOYiK7X9yenE0//K3M/4xymUby82d/qjgln/cIY1I8dizRWBsPtYJ0d/Xt2OD4HcBfLXCmpkX+QknHfhL7/0OGp9ClDkLZqx16PdSnKIu5NPhYNTGVY8wr6x37jGS3l9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158548; c=relaxed/simple;
	bh=IPqOfsGa0DArR4DFEj+yLFOa0Iyhls9HPZyVcFmiROo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POp/9qmgSoRKwui1o83dcyUxGeL8BI0YSDZD8QMpv6EJzNXRMQzQCMD04wcM6X3nHBFKK6iawg8HSzfV49NxERdGcj4FZnCGYSJtPhM38FAg8tvEpxIgm4C13l4ZSaCHM21OvPQIjgSPPqZrGTeCMNMkzJX6/uP2HQvvRSE0MrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1TUgeNDJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1TUgeNDJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579C51F000FF;
	Wed, 23 Sep 2026 10:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790158542;
	bh=cCkKiUkI5CBIxSOf3Rl7yoSbI+AcG0DMzQZmanndQ7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1TUgeNDJyGUoHMu/7rF9Ji1boADsBw1BJyz35sEUatTZhXYmj08V9bUcE1ybhn28W
	 EdImQ5WA/1qzuUeX26KQCb/97MOuqzjtUCUVc1gddBnydJ1akeGHsEhBYWZM6uMsqb
	 oshEVtAX94ty+yZr6i8IqJQpqD++YdebYHPlWl9g=
Date: Wed, 23 Sep 2026 12:15:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Dmitry Rokosov <ddrokosov@sberdevices.ru>,
	linux-serial@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] tty: serial: meson: fix UART driver lifetime
Message-ID: <2026092344-unlawful-hurling-c87e@gregkh>
References: <20260913034148.15068-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913034148.15068-1-mhun512@gmail.com>

On Sat, Sep 12, 2026 at 11:41:48PM -0400, Myeonghun Pak wrote:
> Moving Amlogic UART registration into probe left the first driver
> registration behind if uart_add_one_port() failed. Adding the separate
> ttyS driver later also exposed a global last-port test: removing the last
> port of one driver kept it registered whenever the other had a port.
> 
> Track whether probe registered the driver and undo it when port addition
> fails. On remove, retain the current driver only if a remaining port maps
> to that driver. Serialize the shared lifecycle decisions against parallel
> probe and remove operations.
> 
> This issue was identified during our ongoing static-analysis research while
> reviewing kernel code.
> 
> Fixes: bcb5645f99ef ("tty: serial: meson: redesign the module to platform_driver")
> Fixes: e71aab9d6132 ("tty: serial: meson: apply ttyS devname instead of ttyAML for new SoCs")
> Cc: stable@vger.kernel.org
> Assisted-by: OpenAI:GPT-5.6
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/tty/serial/meson_uart.c | 52 +++++++++++++++++++++++++--------
>  1 file changed, 40 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index a6cb2a535..4bd9d9826 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -12,6 +12,7 @@
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/kernel.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> @@ -80,6 +81,7 @@ static struct uart_driver meson_uart_driver_ttyAML;
>  static struct uart_driver meson_uart_driver_ttyS;
>  
>  static struct uart_port *meson_ports[AML_UART_PORT_NUM];
> +static DEFINE_MUTEX(meson_uart_mutex);
>  
>  struct meson_uart_data {
>  	struct uart_driver *uart_driver;
> @@ -692,6 +694,16 @@ static struct uart_driver *meson_uart_current(const struct meson_uart_data *pd)
>  		pd->uart_driver : &meson_uart_driver_ttyAML;
>  }
>  
> +static bool meson_uart_has_ports(struct uart_driver *uart_driver)

As you require a lock to be held here, document it properly so the
compiler will catch it when you get it wrong.

> +{
> +	for (int id = 0; id < AML_UART_PORT_NUM; id++)
> +		if (meson_ports[id] &&
> +		    meson_uart_current(meson_ports[id]->private_data) == uart_driver)
> +			return true;
> +
> +	return false;
> +}
> +
>  static int meson_uart_probe(struct platform_device *pdev)
>  {
>  	const struct meson_uart_data *priv_data;
> @@ -702,6 +714,7 @@ static int meson_uart_probe(struct platform_device *pdev)
>  	int ret = 0;
>  	int irq;
>  	bool has_rtscts;
> +	bool registered = false;
>  
>  	if (pdev->dev.of_node)
>  		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
> @@ -731,11 +744,6 @@ static int meson_uart_probe(struct platform_device *pdev)
>  	of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
>  	has_rtscts = of_property_read_bool(pdev->dev.of_node, "uart-has-rtscts");
>  
> -	if (meson_ports[pdev->id]) {
> -		return dev_err_probe(&pdev->dev, -EBUSY,
> -				     "port %d already allocated\n", pdev->id);
> -	}
> -
>  	port = devm_kzalloc(&pdev->dev, sizeof(struct uart_port), GFP_KERNEL);
>  	if (!port)
>  		return -ENOMEM;
> @@ -748,11 +756,22 @@ static int meson_uart_probe(struct platform_device *pdev)
>  
>  	uart_driver = meson_uart_current(priv_data);
>  
> +	mutex_lock(&meson_uart_mutex);

guard?

thanks,

greg k-h
