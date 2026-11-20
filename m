Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184678;
	b=CG6OtMeeYT4sNTYJSV2xqwOyNYFWXkBDn415rV0b3Pb/FLv6O/qm70GrT/Lls6Z26J1W
	 eScaT5bwLz0yh3+OoHG9JzQChW470R4CgTk4EJ9WQrh5tkR02l6dhaBXA6xBy6BVji5we
	 h5uGzTPyin493PAUi08zQZi0vY+1HaV/HSJ52q1TLZRC/eZILihCmzljtn/nFVuMo+OPw
	 oA+DtdkSDbOxbzvcZG0WFKJin5Y++0lufztcSyxgDD7M+Rk2Ukp8Yu6tCWwgV0prOubLf
	 f2UvA2T69Ky27pjNWcVS6LQCVSmukkY8/dD63BWXal6dZMP3MWHXs5Zh0ZEF6WdEa5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184678;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xRGBG+H8IsQFC0ggZ137F9TX1SsMKn/LIGcOU/7XoYg=;
	b=glUu399B4wn5bvY7ERuQD5JUCzaNPSf4+Mr9KkA4MZjgRIjbNnW9kTNns2lRsWN5WmqR
	 7ro8MZdo1G0guSZX4HCmvnyuGsYLmXZJqbyRk0YlE2aA/NvBQttobhMNyI3/GnKUMm4np
	 6bbCsJuQDi4op5sdV/FFt8LAeHlJbG/r1h0jnLhRotdGlzn8G6rvkNuoZ7wCuqH6hgB8j
	 Ml9HTGXoQZM9cdJBn60oMxn98usREZwq1LSMgP2AMA3LFdRUgKQ+AmJwB/KO1kBKwIVVv
	 EEpuZGO40hW0FsFkgIZzfSLq6MyEFr9rkq4zrxfWQsM6rAUPWzfYdxwz+E5wMxowhKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FipZUaJ6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6556F606A325;
	Fri, 20 Nov 2026 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FipZUaJ6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057461F000D1;
	Fri, 20 Nov 2026 14:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795184677;
	bh=xRGBG+H8IsQFC0ggZ137F9TX1SsMKn/LIGcOU/7XoYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FipZUaJ6gg1t7t3+x7ufdDN7hHjs9ygwD9wTmiIyt92xUC5aJCsWzJPrialvihpxj
	 i1d193JLFLpPCDUgyyuomTqCQaReo0B0DY4Hr3YZfVUW3hE8BY8yzsH3DVhvjQSUgs
	 r5jMqJ0B63sKINUnpc0A/0E0TE/xR0ndMSqSKSvU=
Date: Fri, 20 Nov 2026 15:24:35 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hyunjung Ko <hj351016@gmail.com>
Cc: Kevin Cernekee <cernekee@gmail.com>, Neill Kapron <nkapron@google.com>,
	Felipe Balbi <balbi@ti.com>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: bcm63xx_udc: don't sleep under spinlock in
 udc_stop
Message-ID: <2026112019-gesture-crawling-0b54@gregkh>
References: <20261111072310.3005580-1-hj351016@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111072310.3005580-1-hj351016@gmail.com>

On Wed, Nov 11, 2026 at 04:23:10PM +0900, Hyunjung Ko wrote:
> bcm63xx_udc_stop() clears udc->driver and then calls msleep(100) plus the
> PHY/clock teardown while still holding udc->lock, which is taken with
> spin_lock_irqsave(). Sleeping in that atomic context triggers "BUG:
> scheduling while atomic" (and a CONFIG_DEBUG_ATOMIC_SLEEP splat) when the
> gadget driver is unbound.
> 
> The lock is only needed to clear udc->driver, which serializes against the
> interrupt handler. The settle delay and the bcm63xx_select_phy_mode() /
> set_clocks() teardown only touch hardware and are already called without
> the lock during init, so drop the lock right after clearing udc->driver
> and run the sleep and teardown unlocked.
> 
> Fixes: 613065e53cb1 ("usb: gadget: bcm63xx UDC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> ---
>  drivers/usb/gadget/udc/bcm63xx_udc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/bcm63xx_udc.c b/drivers/usb/gadget/udc/bcm63xx_udc.c
> index ba91b1ebbf57..269063d19f10 100644
> --- a/drivers/usb/gadget/udc/bcm63xx_udc.c
> +++ b/drivers/usb/gadget/udc/bcm63xx_udc.c
> @@ -1847,8 +1847,8 @@ static int bcm63xx_udc_stop(struct usb_gadget *gadget)
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&udc->lock, flags);
> -
>  	udc->driver = NULL;
> +	spin_unlock_irqrestore(&udc->lock, flags);

Why is a lock needed to write a single atomic value?

thanks,

greg k-h
