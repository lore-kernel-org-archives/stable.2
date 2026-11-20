Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184586;
	b=liGJ5jf01b6fK1R1HGXYWT2OX6l3csvuMVQaP0mfsERwfV8GMUqfXHdCuDHN5Q2oJWm8
	 WwlULiZSmUVTqeOxP0heVM+8tfwuBsD3xAyhNHqlg696ow+vjv7SeGA6RHkbmjF9zTxhY
	 WONe9rryJnx5at0LNig1Xe0c3scWruvsNRRX3vzU3NiRVP4cz6J0H71laZUeYKWukc3Iy
	 e/j7mY97WF6f1CxbWWtp6k0hc/Rh4g6YPdlUNl/bqq6ZvbvmgjvnKxWlhmNXbDXavUG3P
	 qSjL9tppuy1xaf3Uv2wQP4iahxlqvbjYVfuOGH91BmriuTwX80tRWssLh/ln2LorM/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184586;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lusnGRfk+umHymzkE0cY3hSploaM39BQgbgUI4luLX0=;
	b=z7R+oNUxiPq8in/H1ZtnZSmZILsf99SKsNF7suzuP0yzT5OOGcMBJPQfsHa17pI+bWUB
	 TPBX/zZOiiIJO5ah+VQReWMAJ8W65S4WOZL9fA8QRuUtbflTY9gRrptFVt6zK6OCt8LLo
	 MQHp5pFhewfA9VEF8KTSoWgFpSM86VIZZn1fBnZXMlKJB/IjTZDabuUtb82xTclFmW4da
	 OOu9evj+RRGlaz3TTANeyYZxgu8MSktUnKstAtUzl5mGIvRl95nLMgjMJ0RgysmhJRqC+
	 d49Ax+gpH+rEnL3VwXSql6hOvSsLV7IbuoOvQg44UFq4DyNnhMF36kMda6BiXr2Yp5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="BpKVSuP/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652CD606A320;
	Fri, 20 Nov 2026 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=BpKVSuP/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFB91F000C0;
	Fri, 20 Nov 2026 14:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795184586;
	bh=lusnGRfk+umHymzkE0cY3hSploaM39BQgbgUI4luLX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BpKVSuP/TcUHJ2kfTbFOMqN3DShNbmQJKTfMJhvilCLmvJAExqzmDsavDi2HwQlTV
	 zRZE8ZVK5I08Kt+GpeVAxmBeHd7beXgLwKshV2blTIcNZUzdFH+/QkknvCGutpVjfd
	 wAZP3R/I5TnuWnq7qtqm8wtdHap/xOzOXlLU4f+4=
Date: Fri, 20 Nov 2026 15:23:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: Re: [PATCH v2] usb: gadget: lpc32xx_udc: drain pullup work before
 teardown
Message-ID: <2026112007-lumber-pounce-3ec2@gregkh>
References: <179474326988.103840.10326852247134349070@seu.edu.cn>
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
In-Reply-To: <179474326988.103840.10326852247134349070@seu.edu.cn>

On Sun, Nov 15, 2026 at 07:47:49PM +0800, Hongyan Xu wrote:
> The pullup worker accesses the transceiver I2C client and UDC
> state. IRQs can leave it pending when remove or a late probe
> failure releases those resources. Cancelling the final pullup
> work would also discard the requested disconnect.
> 
> After the gadget core has stopped its callbacks, explicitly free
> and synchronize the registered UDC IRQs. Request pullup-off and
> flush its worker while the transceiver client is still retained.
> The worker needs no UDC IRQ to finish its I2C transaction.
> 
> Track successful IRQ registrations during probe so late failure
> also stops all acquired producers and drains pullup work before
> destroying DMA resources and dropping the I2C client.
> 
> Found by the author's in-house static analysis tool.
> 
> Fixes: 24a28e428351 ("USB: gadget driver for LPC32xx")
> Cc: stable@vger.kernel.org
> Suggested-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> Link: https://lore.kernel.org/all/20260928134158.117-1-getshell@seu.edu.cn/
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> Signed-off-by: Zehao Gao <gaozehao@iie.ac.cn>
> ---
> 
> Discovery: found by the author's in-house static analysis tool.
> 
>  drivers/usb/gadget/udc/lpc32xx_udc.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
> index 94355d3..d627a2a 100644
> --- a/drivers/usb/gadget/udc/lpc32xx_udc.c
> +++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
> @@ -2978,10 +2978,17 @@ static struct lpc32xx_usbd_cfg lpc32xx_usbddata = {
>  
>  static u64 lpc32xx_usbd_dmamask = ~(u32) 0x7F;
>  
> +static void lpc32xx_udc_free_irqs(struct lpc32xx_udc *udc, unsigned int count)
> +{
> +	while (count--)
> +		devm_free_irq(udc->dev, udc->udp_irq[count], udc);
> +}

This is "funny", please unwind things in a better way.  Also, have you
ever hit this in an actual device?  If not, don't make changes like
this.

thanks,

greg k-h
