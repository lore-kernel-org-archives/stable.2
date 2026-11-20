Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184515;
	b=lHQkTuH/ejOqA3eMMHR8RfjVfhcufPKD9d+w2BFCx5lhdalW1Ilf7fjvMsa3+yYzbe+i
	 tOUBqKPTXhLqieLVQWQfLKhIfAn6zxU/qlipElT9xAu6yQ1X5m7l3kKktWBHAcsuMTCUt
	 hPVC/Mx6H/TL6kPdkzk3DpCW5zKe2R4lH/+4JEs+HQtb1btfjFLvvcw05cgwlnvZ9ZYj9
	 cZZXpQ/fRkfOIGAfC8A2YRDp9UlHZA7xzklhipV9VM6fRe+YqmefMDDUohAmiGV18/Ap1
	 SQ1/fRiOpLn5DYglKY0/csV29huGmeBBfXVTdpuGuRqlaVKHo4WtoLJ/AEOzWhOnHHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184515;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=b8v+t+OSB4EchFvCdH8uiX9uT/Ot90vpwiBcqriqClE=;
	b=jmNWtnhn4ty8ZQd0TYD3n/JNfHScUO26aklJ+l1zCamB61VCM/SEETMHnOxCMc9Cjf2Z
	 dk0S08+EfeXiXrNiZRz4kzlm69BoX75W1GhR+2nDTcIe20JcuCQy8z82tE6eJIa5gwM4n
	 UPfwtaaGiXam2eDWeOgqQ7IvYKwCNm4X+s4avELruQP9iT2i7hDeLIFyVyiaU3Hyj2VON
	 m+KNcSTWMYitgiZqDcy3Lf9BK3a0CKcDyEMw3SUn7sEwBcc//UNcm5BmjAuVJlYsXUnaR
	 8h15Cp/aB9TbPln+DNl/KjdPhUn6N9Dk0zR/p2MjUOqM0At0bJpFhvtFbKf5Gw1SWfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=p4Oi7dQ4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FF3606A32A;
	Fri, 20 Nov 2026 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=p4Oi7dQ4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C92A1F000C4;
	Fri, 20 Nov 2026 14:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795184514;
	bh=b8v+t+OSB4EchFvCdH8uiX9uT/Ot90vpwiBcqriqClE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=p4Oi7dQ4PiwYFyPdNXEMk2OPBSY+ONAvQblcEfI+aCStepVgr7a6JzeK7TNaDc+Mx
	 1ZteiylYz+HchFxQrS12M5gQg6jXcDgnlwR6LMsUvjEdwa1qvDjFagfdHIBK13j9pF
	 kgIPNOXogrLZSSOLCo8oiMUn2uSTHZbVbsx1RdAk=
Date: Fri, 20 Nov 2026 15:21:52 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hyunjung Ko <hj351016@gmail.com>
Cc: Neill Kapron <nkapron@google.com>, Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Roland Stigge <stigge@antcom.de>, Arnd Bergmann <arnd@arndb.de>,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: lpc32xx_udc: drain the pullup work on
 removal
Message-ID: <2026112036-strategic-deviation-bf21@gregkh>
References: <20261110114351.2524921-1-hj351016@gmail.com>
 <20261110120243.2540098-1-hj351016@gmail.com>
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
In-Reply-To: <20261110120243.2540098-1-hj351016@gmail.com>

On Tue, Nov 10, 2026 at 09:02:43PM +0900, Hyunjung Ko wrote:
> isp1301_pullup_enable() schedules udc->pullup_job to perform the slow
> isp1301 i2c pull-up access from process context. The work handler
> (pullup_work) dereferences udc and touches the isp1301 i2c client.
> 
> udc is allocated with devm_kmemdup(), so devres frees it after
> lpc32xx_udc_remove() returns. remove() calls pullup(udc, 0) -- which
> queues pullup_job to clear the D+ pull-up -- but never drains it, so the
> work can run after udc has been freed (and the isp1301 client put),
> dereferencing freed memory -- a use-after-free.
> 
> Flush pullup_job in lpc32xx_udc_remove() after the final pullup(udc, 0).
> flush_work() (rather than cancel_work_sync()) lets the queued pull-up
> disable actually complete before the udc and its isp1301 client are
> released, so the transceiver is left with D+ deasserted.
> 
> Found by static analysis; not runtime-reproduced (needs LPC32xx USB
> gadget hardware with the isp1301 transceiver).
> 
> Fixes: 24a28e428351 ("USB: gadget driver for LPC32xx")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> ---
> v2: flush_work() instead of cancel_work_sync(), so the pull-up disable
>     queued by pullup(udc, 0) completes rather than being dropped
>     (OTG1_DP_PULLUP would otherwise stay asserted after unbind) -- per
>     Sashiko review of v1.
> 
>  drivers/usb/gadget/udc/lpc32xx_udc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
> index 94355d3d930f..b98faf5b71e5 100644
> --- a/drivers/usb/gadget/udc/lpc32xx_udc.c
> +++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
> @@ -3187,6 +3187,13 @@ static void lpc32xx_udc_remove(struct platform_device *pdev)
>  	udc_disable(udc);
>  	pullup(udc, 0);
> 
> +	/*
> +	 * pullup(udc, 0) queues pullup_job to clear the D+ pull-up over i2c;
> +	 * flush it so that disable completes and no work can run after the
> +	 * devm-allocated udc (and its isp1301 i2c client) are released.
> +	 */

This comment makes no sense to me, sorry.  WHy is it needed at all?
