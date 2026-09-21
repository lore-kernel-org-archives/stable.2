Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5C0364940;
	Mon, 21 Sep 2026 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789974346; cv=none; b=qFGZBmOfWtA6ouAgk7HxGd4JZ58XcW4JbEk+4/vgCh96oMxGinra6HiMwdRO5D4G4kWaX4+308pHCc+5aprh4C9xP8Ic/hmWuPslf91MmhcexSZkWXxEcpjckCIt5NZ5Z6Fg3F0lwdbzUkTCyg4yzyyzYMNm2hGOTvUqavepYZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789974346; c=relaxed/simple;
	bh=V2UZAgtXxVj/e+y0JQbgyORtl55iUuBuEkAAYF8S1F8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=sBSLPWJ7Rbcr4DKaMnsg5yBBVWtKkssKA+LWkc8HWafKesacc6sb2uDjTIghCqSv6q4NqzKOt+nt+zlAoc+v9ItpcbcbiiJ52/Z+3apIIqWOFOImZwgrGDvdJE3dYl8BFYawKlLaJaegfrRC1/FOlXM+4X+BjJ82LSYcAmg/aPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=F07TSrcx; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="F07TSrcx"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2D78A3808;
	Mon, 21 Sep 2026 09:05:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789974341; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/8mDAteS44LsiHToHeb3hAOQ+hMRfbMMGevkpmGBA6o=;
	b=F07TSrcxjPB6bN9L46YngYeVnX2u3DmYYYMreOjHgZS2pa1hts26B9AUuUAZMNkI1cP/YI
	sCubETKyH65PKc4fFyKpeKrURZ3adzhSdIk5TJxclS03BikAz/Xx70yAccXVxJLfWLFxoO
	G3E3mEcZwiMQgko7bR+q8doDSNOD4QSHYUta+Nqz0HYTnnj2zNjuDGGb9WpkkmRdrgki0O
	455OoM2/aOUNPbacWED0/mOR3uNwblaLc2fA1WyXz7csYXl9b7wmvDVEjEKxPuF8evF/fI
	0Z/azghAF2W+xBUyBwhad68b1/Q9jh7w6/dSEzzVZvEvW2pK0p39toFfuJzZbA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Sep 2026 09:05:39 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Sean Anderson <sean.anderson@linux.dev>,
 Antoine Tenart <atenart@kernel.org>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] net: macb: propagate RX ring refill errors
In-Reply-To: <20260918-macb-close-v1-2-221d916b7961@bootlin.com>
References: <20260918-macb-close-v1-0-221d916b7961@bootlin.com>
 <20260918-macb-close-v1-2-221d916b7961@bootlin.com>
Message-ID: <0eeb123ad32558ac42762827eb509110@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Théo

On 18.9.2026 22:32, Théo Lebrun wrote:
> gem_rx_refill() is responsible for Rx SKB allocation, including at 
> open,
> but its prototype indicates a void return value.
> 
> Therefore we change the code to propagate allocation and DMA mapping
> errors back up the stack, making sure the open fails if it occurs.
> Change all those to return errno-style ints:
>  - gem_rx_refill()
>  - its parent gem_init_rx_ring()
>  - its grand-parent gem_init_rings()
>  - the macbgem_ops.mog_init_rings function pointer
>  - its grand-uncle macb_init_rings()
> 
> Theoretical bugfix, never encountered in practice. To reproduce,
> introduce memory pressure (less than 512 SKBs of free memory) and open
> the interface. I expect the last queue to be unuseable because it has
> zero usable rx buffers. Nothing will ever trigger a refill on that
> queue which only happens once a frame has been received.
> 
> Note that other callers of refill (resume, HRESP error task, NAPI)
> cannot do anything useful with that error and keep their best-effort
> refill, hoping it will improve.
> 
> Fixes: 4df95131ea80 ("net/macb: change RX path for GEM")
> Cc: stable@vger.kernel.org
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---

> [...]

> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index 751fa9e68099..c418f859cc34 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

> [...]

>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> @@ -2813,11 +2820,15 @@ static void gem_init_rings(struct macb *bp)
>  		queue->tx_head = 0;
>  		queue->tx_tail = 0;
> 
> -		gem_init_rx_ring(queue);
> +		err = gem_init_rx_ring(queue);
> +		if (err)
> +			last_err = err;

A partly filled queue refills itself on the next gem_rx().  AFAIU only a
queue with zero buffers can get stuck. Fail the open just for that case?

> [...]

>  static void macb_reset_hw(struct macb *bp)
> @@ -3162,7 +3175,9 @@ static int macb_open(struct net_device *netdev)
>  		goto pm_exit;
>  	}
> 
> -	bp->macbgem_ops.mog_init_rings(bp);
> +	err = bp->macbgem_ops.mog_init_rings(bp);
> +	if (err)
> +		goto free_rings;

macb_set_ringparam() ignores macb_open()'s error, so NAPI stays disabled
with netif_running() == true and the next close will hang in 
napi_disable().

Should macb_set_ringparam() return the error?

> [...]

Thanks,
Nicolai
