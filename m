Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D0C5505EF;
	Thu, 15 Oct 2026 15:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792078488; cv=none; b=p1yKErWM3jMvL+eI2RjKFbR0Bo5h5LNnjgE2BysAgGFNBZnMq3xFi14y99wrqLPiYpKLsme74Wqd6Sf5/3A3vnGNAw+vuclobdVgz3+oIS9UaztOKX5DPJW8LQGbxncb7gHVbRTB9V3CfLL3xB2UrCId5+OS8ESbqZauYWwjILk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792078488; c=relaxed/simple;
	bh=QaKRgkR0woy1vA5kmFEGr+R5MHpjVLEeKSVoWkJFbyo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NUzsqEGqsMo4/8vcZPuuqFLn51owh9+ch3YGeQaA7DSksb1SFAWvtz9CP9cMP1IlFlhHFABxYa9Crvt9IuYzIbspy4kaEAnqR+L1nQMeNEQRvU4lLQ/+cb+YP6xx6CTfN3fpqVcB2RiDOvMnwc5BDYEKeYuMBCgsT559YZD55/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=xbq8JDhw; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="xbq8JDhw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=FXysBoh7T/b5vIIQVT7Cjj+2PwX+ORp+Pnle7zngK5E=; b=xbq8JDhwVaZ+FeyTtxc90afsX7
	rQ2I5IaR/QqG0fQGZAiA6EKlH/ap/qkzC5wqxbRBSy+MFQcG+2E8MCbSxxhGeQlBOmW0Rj4GjYdfI
	xw5wugsNGDOjAF6iWA1tb2wGQVIBzZSR+jqdMi19gvfWcY3+Zc6itfNEaPSM0o/ybOrU=;
Received: from [70.80.174.168] (helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xHNTN-000000005Ee-2F2h;
	Thu, 15 Oct 2026 11:34:23 -0400
Date: Thu, 15 Oct 2026 11:34:22 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Hui Peng <benquike@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, John Ogness <john.ogness@linutronix.de>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v8 2/2] serial: core: reject baud_base values that
 overflow port->uartclk in uart_set_info()
Message-Id: <20261015113422.007d26d4c5135aa6a3add4a4@hugovil.com>
In-Reply-To: <20261007094719.1362769-3-benquike@gmail.com>
References: <20261007094719.1362769-1-benquike@gmail.com>
	<20261007094719.1362769-3-benquike@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

Hi Hui,

On Wed,  7 Oct 2026 09:47:18 +0000
Hui Peng <benquike@gmail.com> wrote:

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
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v8:
> - Dropped secondary Fixes: 6eabce6608d6 tag per Hugo Villeneuve feedback.
> 
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

If you leave uartclk declaration before the comments, the diff will be
simpler.

> +
> +		if (check_mul_overflow(new_info->baud_base, 16, &uartclk) ||
> +		    uartclk == 0)
>  			return -EINVAL;
>  	}
> -- 
> 2.47.3
> 


-- 
Hugo Villeneuve
