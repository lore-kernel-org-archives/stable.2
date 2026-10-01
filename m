Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7404AF140;
	Thu,  1 Oct 2026 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790844912; cv=none; b=lqgumbCJ69alXVgVvCnZdJwH9dAPkozr+p0NSK2nBRXB8nusbWEWUIkSAqGmeLZPNN1ZxDqkOtvuScOdGVGDdDljk4qtWkWfKr2VIwDDkDc7B2/3fWlqxRM0rFLkD/N23y2LdVVg/hP+XFKhq4sEIz6qxf/U/+0kFsD3OlzK3VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790844912; c=relaxed/simple;
	bh=86GSpWgF6ODI17iA7K0Sy177jjL7FlVcDAW7bkq0hBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQd2gi9y2Vdq8nc0FlnaDMFDhNsXATcHw9d7uknA7ChIVmxrqI1QO+KPQJcH3UP5CXgt/yB0PdCgKbce/x3ntAxTniGQZYjoYO00QOvB5kMw/2+dnqxUUtGX/6oZRVp2AMvORL8+25aP2OBUptUhNCnuu/xDhJ6H2pXPdO7CJAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hzc1t0ej; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hzc1t0ej"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E241F000FF;
	Thu,  1 Oct 2026 08:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790844910;
	bh=YZQhGaMx5gpdajoW7WcwVHxtRU76til3eqZlwRyEZ2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hzc1t0ejAEU0dEd5L71br6zXADOnSEWwNEne+LvnZLX5Nx8CTMT1WyK4jYJ6on6Al
	 1yUdtghqvcKEkqRzZCyFzk12p6wIQ8622sn0dURWpDv2fAkirS4cLZolnaAJeoUlrE
	 jgcdpAzDEe8F/0nE9Q/130hBvveQoR4/+hh9WtLk=
Date: Thu, 1 Oct 2026 10:55:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hui Peng <benquike@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v7 2/2] serial: core: reject baud_base values that
 overflow port->uartclk in uart_set_info()
Message-ID: <2026100143-alphabet-blazer-13d5@gregkh>
References: <20260930125901.778868-1-benquike@gmail.com>
 <20260930125901.778868-3-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260930125901.778868-3-benquike@gmail.com>

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
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 6eabce6608d6 ("serial: core: check uartclk for zero to avoid divide by zero")
> Cc: stable@vger.kernel.org
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v7:
> - Use check_mul_overflow() instead of raw UINT_MAX / 16 comparison as
>   suggested by Jiri Slaby.
> 
>  drivers/tty/serial/serial_core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 6ed0195e6912..9a8f4c2e1180 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -14,6 +14,7 @@
>  #include <linux/tty_flip.h>
>  #include <linux/serial_core.h>
>  #include <linux/console.h>
> +#include <linux/overflow.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/kernel.h>
>  #include <linux/of.h>
> @@ -931,9 +932,11 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
>  	old_custom_divisor = uport->custom_divisor;
> 
>  	if (!(uport->flags & UPF_FIXED_PORT)) {
> -		unsigned int uartclk = new_info->baud_base * 16;
> 
>  		/* check needs to be done here before other settings made */
> -		if (uartclk == 0)
> +		unsigned int uartclk;

As Andy said, this style change is not ok.

Please slow down and be more careful.

thanks,

greg k-h
