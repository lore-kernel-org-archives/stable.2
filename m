Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184617;
	b=ubx8kkwqaMXcU0Ro39NxpAGTsdYOKLMp6tzXzf7TsMIxYiOzcVUfqrh22KALfoOhFO8e
	 TUBdmYjnowNRcuQs83BMOvler4IfuycGuY2hQSgWVYS+MXQthqhHFybv6uo8HVKXffD2f
	 ozpCA5aHkZK44do3rVSsTqH9ah97krU+sRoH2SwYm9PBHcN5nJyPa8emfypv0om0snsAo
	 0GehYoO7dPvdTvcO4vLCJGQV7Dtb633omaZj1xkv/rWyhLpg0LHBSNS1Sc4OWoj5sxSL1
	 29CTeYwtQBaVxdL4ElCbvtGH0sf9Pn10XGVMdnPESZvs9IHsC/YZ8EejkfwnH2rAJWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184617;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4KYuo7FdU68DsPajG3eePVYny09UrQMaX1Lx+TuzLaY=;
	b=qOwgbhdkcIpiQOW1tOmuOb08gxAwu59+nkSn4qF3tlWO+A3hLUh6OABiD/fLfel90wmn
	 T5T4GOyR60bxvD+MIsX66xdVlWbeQuSwWVYnpM9U1yuKJLBf3NtF7uFQIvRau+CCArscp
	 WtLSbakLEdmvJJAHZ/dH6mkpWjfmxFEt7AB8JPjtl7KuPZ1Z74LwQw2cFSaP/UOeFFIy/
	 xBJSJXisknQqDsmJMJiKhueM4IaS2C3aeSfJttFPL/7y8ptK6ayFgFeIBFuFlA9U39dFv
	 88iaUX4+owHoJxFXyDbroDpPL+nRpcHTp9LJA/XqWRd7vFO3C4krnPo1Zm+QaZl4p2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=txk2FobC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3B9606A320;
	Fri, 20 Nov 2026 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=txk2FobC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A37D1F000D8;
	Fri, 20 Nov 2026 14:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795184616;
	bh=4KYuo7FdU68DsPajG3eePVYny09UrQMaX1Lx+TuzLaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=txk2FobCLE0AC67/e5/J/x9/WWzKuRMeZa4PN2EvMYHVv7Fwoag55XJKa/gLEXXi6
	 UxCpDQ/lhXxJlUApt2jZMm7lIxok4FC7GS8Yk4ReGdsEFECDOYbJk5JzI3PEj/lom6
	 OEnFcZKYctT7T66Q73nYfLaCA5C1P0m7TvMZaa6E=
Date: Fri, 20 Nov 2026 15:23:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: linux-usb@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Johan Hovold <johan@kernel.org>, Roland Stigge <stigge@antcom.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH] usb: gadget: lpc32xx_udc: handle interrupts with an
 empty queue
Message-ID: <2026112017-curfew-neuter-44d7@gregkh>
References: <20261109121035.34561-1-fangxy@xiaopeng.com>
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
In-Reply-To: <20261109121035.34561-1-fangxy@xiaopeng.com>

On Mon, Nov 09, 2026 at 08:10:35PM +0800, Fang Xieyan wrote:
> A request can be dequeued after a DMA transfer has completed and filled
> both endpoint buffers, while the delayed endpoint or DMA interrupt is
> still pending.  lpc32xx_ep_dequeue() removes the request from ep->queue
> and gives it back via done() without clearing the pending endpoint or
> DMA interrupt status.
> 
> When the interrupt handler then runs with an empty queue,
> list_entry(ep->queue.next, ...) derives an invalid request pointer from
> the list head; list_entry() does not return NULL.  Passing that pointer
> to done() in udc_handle_eps(), or dereferencing req->dd_desc_ptr in
> udc_handle_dma_ep(), results in invalid memory accesses and can crash
> the kernel.
> 
> Check whether the request queue is empty before touching the request in
> both handlers.  In udc_handle_eps(), do this before sending the deferred
> ZLP and disable the endpoint interrupt when there is nothing to
> complete.  In udc_handle_dma_ep(), still disable the DMA channel and
> clear the pending EOT/NDDRT (and SYSERR) interrupt status so the
> interrupt does not keep firing, without dereferencing the missing
> request.
> 
> Fixes: 24a28e428351 ("USB: gadget driver for LPC32xx")
> Cc: stable@vger.kernel.org
> Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
> ---
>  drivers/usb/gadget/udc/lpc32xx_udc.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
> index 044c31869cfb..67b0d6f73e43 100644
> --- a/drivers/usb/gadget/udc/lpc32xx_udc.c
> +++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
> @@ -1945,6 +1945,13 @@ static void udc_handle_eps(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
>  	/* Get endpoint status */
>  	epstatus = udc_clearep_getsts(udc, ep->hwep_num);
>  
> +	/* If there isn't a request waiting, something went wrong */
> +	if (list_empty(&ep->queue)) {
> +		ep->req_pending = 0;
> +		uda_disable_hwepint(udc, ep->hwep_num);
> +		return;
> +	}
> +
>  	/*
>  	 * This should never happen, but protect against writing to the
>  	 * buffer when full.
> @@ -1958,7 +1965,6 @@ static void udc_handle_eps(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
>  	} else
>  		return;
>  
> -	/* If there isn't a request waiting, something went wrong */
>  	req = list_entry(ep->queue.next, struct lpc32xx_request, queue);
>  
>  	done(ep, req, 0);
> @@ -1985,6 +1991,23 @@ static void udc_handle_dma_ep(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
>  	ep->totalints++;
>  #endif
>  
> +	if (list_empty(&ep->queue)) {
> +		u32 mask = 1U << ep->hwep_num;
> +
> +		ep->req_pending = 0;
> +		ep_err(ep, "DMA interrupt on no req!\n");

Why spam the kernel log for something like this?

And how was this tested?

thanks,

greg k-h
