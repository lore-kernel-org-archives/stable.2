Received: from va-2-30.ptr.blmpb.com (va-2-30.ptr.blmpb.com [209.127.231.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D3E3002D8
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 02:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782269363; cv=none; b=H/E6PKSJjUQClkKcoNxi2tqhGW5teOR5TlTekJVcFR8xtE7XE5GYpiLCo8CMZ2wPHpUG0Amw+7Ksq4OS+wxhdUcSRsISbhjJ2UAUhRX9re6J0vaq9Xv+/viJfFS6TqtdXdhRrXk0AQ2SkJ5EA/R8ARQNQiF8DZ3GDA93KLyMW28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782269363; c=relaxed/simple;
	bh=IPrXncu2hiGlR9FfELgR/4ZkZtSAmPp48tUCR+Gkkp8=;
	h=To:Cc:Subject:Content-Type:Content-Disposition:References:Date:
	 Mime-Version:From:Message-Id:In-Reply-To; b=WChXT7FbydX/fSIPRKZRyMiaU7vX69G81hUJgendAhVmCd6aIQjWQgx2zjxMr84ntjP2s6oevzZxqQJD3pP5uSsIzIdMETEebqW+dag4n4Qt30sX0hFUitD7uPZEgSXNXFY6nt1JF5a7yqYrtNlQ0xSbGqRyqWAChQc95mTOkQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=NezUof0A; arc=none smtp.client-ip=209.127.231.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="NezUof0A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1782269351;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=QUg0DylQni8fWh1dKXPQWwrNglC7DjoIeCKSed/uDCQ=;
 b=NezUof0AaB7d33ZbmD8NI1tUCShi4d81GQccC0CcwPPHJNjrV+IAWHr19ZOlt0wrEcBg+I
 40WkE7KXVbe8NTcCIi2xrZq4s8WlisxSCrQXsI+SlkB3bQdmwxH2+baLeuAKyvFa7DFG5B
 VgMPoCJoD8qLK3T8HyA7ncbhsHuuRG6H94OgEibtomQ2JhLsGUb7PmM6iFJeKasGIWgV33
 8JOV9ToV0sj3kQPoPxQnPpToWn5ddR62S95LTf1lC4HxbeZUZr5GPwgOxQp2o68A2jdx4a
 QFiBmEJalUKhd3By6dk3nf75nIzK0ZfkoI2dJve7/cBMo6CflHe42C95WzVXYw==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, 
	"Jiri Slaby" <jirislaby@kernel.org>, 
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Xin Zhao" <jackzxcui1989@163.com>, 
	"Andy Shevchenko" <andy.shevchenko@gmail.com>, 
	"Kees Cook" <kees@kernel.org>, "Ingo Molnar" <mingo@kernel.org>, 
	"Bing Fan" <tombinfan@tencent.com>, 
	"Guanbing Huang" <albanhuang@tencent.com>, 
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Cc: <stable@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: serialize shared IRQ startup
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Received: from MiniServer ([183.34.167.222]) by smtp.feishu.cn with ESMTPS; Wed, 24 Jun 2026 10:49:07 +0800
X-Lms-Return-Path: <lba+26a3b45a5+cbade3+vger.kernel.org+wangzhaolong@fnnas.com>
References: <20260527092052.2086342-1-wangzhaolong@fnnas.com>
Date: Wed, 24 Jun 2026 10:49:05 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: "Wang Zhaolong" <wangzhaolong@fnnas.com>
Message-Id: <ajtFoTHUQHJGYV5Q@MiniServer>
In-Reply-To: <20260527092052.2086342-1-wangzhaolong@fnnas.com>
X-Original-From: Wang Zhaolong <wangzhaolong@fnnas.com>

On Wed, May 27, 2026 at 05:20:51PM +0800, Wang Zhaolong wrote:
> Concurrent startup of two 8250 ports sharing the same IRQ can trigger an
> IRQ core warning:
> 
>   Unbalanced enable for IRQ 3
>   WARNING: CPU: 0 PID: 580 at kernel/irq/manage.c:774 __enable_irq+0x3b/0x60
>   Call Trace:
>    enable_irq+0x8d/0x120
>    serial8250_do_startup+0x80d/0xa80
>    uart_port_startup+0x13d/0x440
>    uart_port_activate+0x5b/0xb0
>    tty_port_open+0xa1/0x120
>    uart_open+0x1e/0x30
>    tty_open+0x140/0x7a0
> 
> The second port can then run the shared-IRQ startup test while the IRQ core
> is still enabling the line for the first port.  The local
> disable_irq_nosync()/enable_irq() pair is balanced, but the interleaving can
> still unbalance the IRQ core disable depth.
> 
> That makes the QEMU legacy serial ports enter the shared-IRQ THRE test path:
> 
>   serial8250_do_startup()
>     if (port->irqflags & IRQF_SHARED)
>       disable_irq_nosync(port->irq)
>     ...
>     if (port->irqflags & IRQF_SHARED)
>       enable_irq(port->irq)
> 
> One possible interleaving is:
> 
>   CPU0, ttyS1                         CPU1, ttyS3
> 
>   serial_link_irq_chain()
>     hash_add(i)
>     i->head = &ttyS1
>     request_irq()
>                                         serial_link_irq_chain()
>                                           find i in irq_lists
>                                           list_add(&ttyS3, i->head)
>                                         serial8250_do_startup()
>                                           disable_irq_nosync(irq)
>     irq_startup()
>       desc->depth = 0
>                                           enable_irq(irq)
>                                             WARN: Unbalanced enable for IRQ 3
> 
> Keep hash_mutex held in serial_link_irq_chain() until the first request_irq()
> has completed.  This prevents another 8250 port sharing the IRQ from joining
> the chain and running the THRE test while the IRQ core is still starting the
> interrupt.
> 
> This was reproduced in QEMU with ttyS1 and ttyS3 sharing IRQ 3.  With this
> change, 100000 synchronized open/close iterations on /dev/ttyS1 and /dev/ttyS3
> completed without the warning.
> 
> Fixes: 64c79dfbc458 ("serial: 8250_pnp: Support configurable reg shift property")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221579
> Cc: stable@vger.kernel.org # 6.10+
> Assisted-by: Codex:gpt-5
> Signed-off-by: Wang Zhaolong <wangzhaolong@fnnas.com>
> ---
>  drivers/tty/serial/8250/8250_core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index a428e88938eb..64eed4dc343f 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -132,12 +132,10 @@ static void serial_do_unlink(struct irq_info *i, struct uart_8250_port *up)
>   */
>  static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_port *up)
>  {
>  	struct irq_info *i;
>  
> -	guard(mutex)(&hash_mutex);
> -
>  	hash_for_each_possible(irq_lists, i, node, up->port.irq)
>  		if (i->irq == up->port.irq)
>  			return i;
>  
>  	i = kzalloc_obj(*i);
> @@ -154,10 +152,12 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
>  static int serial_link_irq_chain(struct uart_8250_port *up)
>  {
>  	struct irq_info *i;
>  	int ret;
>  
> +	guard(mutex)(&hash_mutex);
> +
>  	i = serial_get_or_create_irq_info(up);
>  	if (IS_ERR(i))
>  		return PTR_ERR(i);
>  
>  	scoped_guard(spinlock_irq, &i->lock) {
> @@ -169,10 +169,15 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
>  
>  		INIT_LIST_HEAD(&up->list);
>  		i->head = &up->list;
>  	}
>  
> +	/*
> +	 * Keep the shared-IRQ chain locked until the first handler is installed.
> +	 * Otherwise another UART can join early and run startup IRQ masking while
> +	 * the IRQ core is still enabling the line, unbalancing the disable depth.
> +	 */
>  	ret = request_irq(up->port.irq, serial8250_interrupt, up->port.irqflags, up->port.name, i);
>  	if (ret < 0)
>  		serial_do_unlink(i, up);
>  
>  	return ret;
> -- 
> 2.54.0

Hi Maintainers,

Friendly ping on this patch.

This is a clean and simple one-line relocation fix for the shared IRQ race condition.

I noticed there is another ongoing thread attempting to address the same bug with a
much more complex approach, but it seems to miss the regression test cases.

Could you please take a look at this simpler alternative when you have time? Any
feedback or reviews would be highly appreciated.

Thanks,
Wang
