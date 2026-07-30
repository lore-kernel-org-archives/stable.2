Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801B545DF6D;
	Thu, 30 Jul 2026 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428388; cv=none; b=q7MVSkkbjIH6XZiCSVBON8K1SozvQX9gJB1V85RIpca0Z+1hHG7g+fns91ZtQJ1IZ6q4v5jotV4avF8Y0bp8q4Ar9pF7iL0bIINC02XTiaKFCgm/LKIO0W4ym6cg1Ct8Avj3jzS9ZBD6y7T/hhTtmeSsWYjSa1+ySoAdk4yiVxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428388; c=relaxed/simple;
	bh=Bcm7PwwNybl9MXFpgMS1XRpaN8bbWz47tPDToZxXKK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTV5oJGzgYn9dtrgVFLmZ/ga7fcRDHVsBMLkWu7Aq4Pp0jQQJ8TJTQn1BYFNwNnSJWWyxQhAUy7uRoPC0aVmmubRjgpDgdsb4ZWylNjith8Yd3+hgpESanHyf916DXZRFJkRZ7KTcVK8ZTX/jRzFAIrWj0YfVBlaKdneS0pX+xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cFYQT7RD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cFYQT7RD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE0E1F000E9;
	Thu, 30 Jul 2026 16:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785428386;
	bh=MxTH4N+6ClXnahrqFeh6kmGoXh6psOT6YFBR9ItL6sY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cFYQT7RDGzAWQZFLOFIbcew76EyJ+VPrw0hq/cGcH3T1LaeL+ow00zJs2Op61MS6p
	 bLbomOmF3eYQpiNAgePzMcOYNgE2JEZR6e47LiBNmlPNq/f4nHyf6d80WoAeMG8pTY
	 jpd1eu8LiccmI1FHan4bgheIYQlEMw9AqCVVM+vs=
Date: Thu, 30 Jul 2026 16:39:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: jirislaby@kernel.org, broonie@kernel.org, zhao.xichao@vivo.com,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tty: serial: max3100: drain async producers in remove()
 to fix timer UAF
Message-ID: <2026073036-coping-starter-ad07@gregkh>
References: <20260721035631.3186613-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721035631.3186613-1-fanwu01@zju.edu.cn>

On Tue, Jul 21, 2026 at 03:56:31AM +0000, Fan Wu wrote:
> All teardown of the driver's async producers (polling timer, SPI
> workqueue, IRQ) lives in the max3100_shutdown() uart_ops callback.
> On the suspend-then-remove path, max3100_shutdown() returns without
> draining these producers, so max3100_remove() can call kfree() while
> the polling timer remains armed.
> 
> max3100_startup() arms the polling timer via max3100_enable_ms().  The
> timer callback max3100_timeout() unconditionally re-arms itself with
> mod_timer(), and on each tick dereferences the owning struct
> max3100_port (recovered via container_of(), then uart_poll_timeout on
> s->port).
> 
> max3100_shutdown() opens with "if (s->suspending) return;", which
> short-circuits the whole drain block.  max3100_suspend() sets
> s->suspending before calling uart_suspend_port().
> uart_suspend_port() (serial_core.c) clears tty_port_initialized() and
> then invokes ops->shutdown = max3100_shutdown, which takes the
> s->suspending early return above and runs none of the drain.  The
> timer stays armed.
> 
> On a later SPI unbind, max3100_remove() calls uart_remove_one_port(),
> which (serial_core_remove_one_port) invokes tty_port_tty_vhangup() but
> does not invoke ops->shutdown() directly.  ops->shutdown() is reachable
> only through tty_port_shutdown() and uart_port_shutdown(), but
> tty_port_shutdown() is gated on tty_port_initialized(), which suspend
> clears.  The removal path therefore does not invoke max3100_shutdown(),
> and max3100_remove() proceeds directly to kfree(max3100s[i]) with the
> timer still armed.
> 
> A port that was opened before system suspend can retain its polling
> timer.  If the SPI device is then unbound before resume, max3100_remove()
> frees the port while the timer can still run and re-arm itself.
> 
> Factor a drain helper with a final-teardown argument.  Both variants
> stop the timer, IRQ, and workqueue in that order.  Normal shutdown uses
> timer_delete_sync(), which preserves the timer for a later open.  Final
> remove uses timer_shutdown_sync(), because max3100_timeout() re-arms via
> mod_timer() and the object is about to be freed; shutdown makes a racing
> re-arm a no-op.
> 
> Track whether request_irq() succeeded separately from port->irq.  The
> latter is the hardware resource number and must survive a normal close
> for the next startup; irq_requested makes the drain idempotent without
> changing it.
> 
> Call the non-final form from max3100_shutdown() and the final form
> after uart_remove_one_port() in max3100_remove().  The s->suspending
> early return in max3100_shutdown() remains intact, while remove()
> drains unconditionally.
> 
> timer_shutdown_sync() is available since v6.2.

Yes, but that's not needed here, right?

LLMs love to write text, please don't let it and write your own
changelog that actually makes sense :)

> This issue was found by an in-house static analysis tool.
> 
> Fixes: 7831d56b0a35 ("tty: MAX3100")
> Cc: stable@vger.kernel.org # 6.2+
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
>  drivers/tty/serial/max3100.c | 37 ++++++++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
> index 44b745fa26c6..9dac733a9b81 100644
> --- a/drivers/tty/serial/max3100.c
> +++ b/drivers/tty/serial/max3100.c
> @@ -107,6 +107,7 @@ struct max3100_port {
>  	int  force_end_work;
>  	/* need to know we are suspending to avoid deadlock on workqueue */
>  	int suspending;
> +	bool irq_requested;
>  
>  	struct timer_list	timer;
>  };
> @@ -306,6 +307,29 @@ static void max3100_dowork(struct max3100_port *s)
>  		queue_work(s->workqueue, &s->work);
>  }
>  
> +/*
> + * Stop async producers before tearing down the workqueue.  A normal
> + * shutdown must leave the timer re-armable for the next open, while final
> + * removal uses timer_shutdown_sync() to prevent max3100_timeout() from
> + * re-arming a timer embedded in an object about to be freed.
> + */
> +static void max3100_drain_async(struct max3100_port *s, bool final)

Having a bool here makes no sense at all, and it's a horrible api as now
you have to look up the documentation each time you run across it.

Also, you didn't even document it (well, the LLM didn't...)

Please be more careful.

> +{
> +	s->force_end_work = 1;
> +	if (final)
> +		timer_shutdown_sync(&s->timer);
> +	else
> +		timer_delete_sync(&s->timer);
> +	if (s->irq_requested) {
> +		free_irq(s->port.irq, s);
> +		s->irq_requested = false;

It's not "requested" it's "is an interrupt registered or not", right?

thanks,

greg k-h
