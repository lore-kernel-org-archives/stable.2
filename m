Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D5645DF47;
	Thu, 30 Jul 2026 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428385; cv=none; b=BqYgaB6qnbUtQ4qRX/ZurA+9wiHIySaLrIhkq/CEI9tkmk6UdTPVsQ472nZMXKSVt6G3U7OJ2HFEZnOvnOR9CgaNULVL2fjK1mxVvTRZdbf1EQV/oaTDK5vCLqYUpqHDsrQ9EGjTIHQ0FEs42B9irlM+VryPfH+h0pBZXmZ5XTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428385; c=relaxed/simple;
	bh=J4NlnHaz/omGmCYU9AmD6hjmMraa2bZuu8sXJ5/ZlKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRYO595mB5ci8HUnUPfz7eP9kbcaQ1kzjb94KmCiFucVk/ZgjSKmYL8fFBcFMc8wCn4+wNLGNFdvcRknaSgCApEvVGl+Ga6i4rbJMnJps/7nDfRj2+WJVbHo78rpW2QP3pY5ueF6Bse3A0Vla0vGviUYb0Rp+2r6gr+gSnMZSFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gJ+Iudwl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gJ+Iudwl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140F91F000E9;
	Thu, 30 Jul 2026 16:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785428383;
	bh=d5YhQuSxaN9ggk4Ig2TZr7TSQfywffl+0lvqM03iM58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gJ+IudwlIkKe5VmpBoTHHp809IFYS63skqSCyag2t2fpEIsvwXUwUbIVoqAPs12ye
	 k+65FcnTaRXwxwCRjZWG9/GU8aCMtIjCtHt8j2LBYWquhRRSxOPeJXeArxthDn3wqG
	 3fPVFUFX3e8qAALSFbUmtR8RZPdK+6m2U+VRYT7I=
Date: Thu, 30 Jul 2026 16:37:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux@armlinux.org.uk, jirislaby@kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tty: serial: amba-pl011: cancel RS485 trigger hrtimers
 before removal
Message-ID: <2026073047-unsorted-stick-b16f@gregkh>
References: <20260721042858.3187311-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721042858.3187311-1-fanwu01@zju.edu.cn>

On Tue, Jul 21, 2026 at 04:28:58AM +0000, Fan Wu wrote:
> pl011_shutdown() calls pl011_rs485_tx_stop() when RS485 is enabled and
> the transmit state machine is still active.  That function may re-arm
> the trigger_stop_tx hrtimer via hrtimer_start() when the TX FIFO is not
> yet empty, or when delay_rts_after_send is configured, and the trigger
> timers can equally be left armed from a prior pl011_rs485_tx_start().
> 
> On removal, uart_remove_one_port() can finish without draining the RS485
> hrtimers, and devm frees the uart_amba_port once pl011_remove() returns.
> The existing teardown syncs do not help here: pl011_disable_interrupts()
> only masks the UART IMSC register, pl011_dma_shutdown() cancels a
> different (DMA rx) timer_list, and free_irq() plus serial_core's
> synchronize_irq() only drain the UART interrupt handler, not the hrtimer
> softirq callbacks.  Either trigger callback can therefore recover uap
> from its embedded hrtimer and access uap->port after the free.
> 
> Cancel both RS485 trigger hrtimers in pl011_shutdown(), after the
> re-arming pl011_rs485_tx_stop() call and before free_irq(), and again
> in pl011_remove() after uart_remove_one_port().  The remove-side
> calls cover paths such as suspend followed by unbind, where serial
> core need not invoke the driver's shutdown callback.  The
> callbacks pl011_trigger_start_tx and pl011_trigger_stop_tx return
> HRTIMER_NORESTART, so hrtimer_cancel() fully drains any pending and
> concurrently running callback without a self-restart loop.  As
> pl011_trigger_start_tx() may re-enable the TX interrupt via
> pl011_start_tx(), call pl011_disable_interrupts() again after the
> cancels to re-mask IMSC before free_irq().  The cancel site does not
> hold uart_port_lock across the cancel
> (pl011_disable_interrupts() already released it) and the callbacks take
> that lock internally, so there is no self-deadlock.  This mirrors the
> RS485 teardown pattern in 8250_port.c (serial8250_em485_destroy),
> which cancels both hrtimers before the embedding object is freed.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 2c1fd53af21b ("serial: amba-pl011: Fix RTS handling in RS485 mode")
> Cc: stable@vger.kernel.org   # v6.14+
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
>  drivers/tty/serial/amba-pl011.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 8ed91e1da22b..021b542b3d99 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2083,6 +2083,16 @@ static void pl011_shutdown(struct uart_port *port)
>  	if ((port->rs485.flags & SER_RS485_ENABLED && uap->rs485_tx_state != OFF))
>  		pl011_rs485_tx_stop(uap);
>  
> +	/*
> +	 * pl011_rs485_tx_stop() above may have (re-)armed the RS485 trigger
> +	 * hrtimers.  A callback may also re-enable the TX interrupt, so
> +	 * cancel them and mask interrupts again before freeing the IRQ.
> +	 * pl011_remove() cancels them again before freeing the owner.
> +	 */
> +	hrtimer_cancel(&uap->trigger_start_tx);
> +	hrtimer_cancel(&uap->trigger_stop_tx);
> +	pl011_disable_interrupts(uap);

Please read the review:
	https://sashiko.dev/#/patchset/20260721042858.3187311-1-fanwu01@zju.edu.cn
and determine if what it reports about this change is correct or not
when you submit your second version.

thanks,

greg k-h
