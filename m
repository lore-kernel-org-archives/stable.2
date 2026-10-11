Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE54337CD47;
	Sun, 11 Oct 2026 10:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791713373; cv=none; b=raVxnYDV7ygiTUGSq4hQIiAoyUkQpEwq938eohsyWVm1augjKp6dtEKVKypF6KaM7FO/eh72vESq5cXwlA63iFWYuSxjENStJydrKw4aeTq3qs1q6EecJBt8museQ86hou9HSh/pFFri+4ISixBvQJlVSKmZEZQ+TwLkAtd/cEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791713373; c=relaxed/simple;
	bh=jbNmyJjrEXDxOp7d3pKoQ3NSbsUIImzqR3Ryd+bSubI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=my9NpyIYHdjidBBOmfLECLSfy2daIgeL6HuXxKBMHpjuti88AGnfl+VnxEgN2qvuEWMunWQtfm+Ik7/6e+tMxAB1zllSGZtb0sKpGvBhZCcRCxtX2D73mQexoDiuIOjovvWfvCpp2mWbs8ZR+39fdx/2yuhdfTxr8D8Xr7878Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lc2KzYxg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lc2KzYxg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA53D1F0089B;
	Sun, 11 Oct 2026 10:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791713371;
	bh=mkMWltT9oxH5lohmqxjpV5mhcOv97kZTIRXdDoPQww0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Lc2KzYxgPnuJbjk6WVwgPbn4jcbHBvhvSQeQJiveQeYkoOmAS8oKXUgRDFBwo49uu
	 3mjm3ieDCldIKuBo+7h0rQSlGFmpYW7sqeDrdCozMPMSKSRxv8VM+mvoFgl6XOp2pu
	 piCbahEap59H4p39rZMGK7eiW8q9mYP5HVcqU/Ik6DMleVCWL2BAqjZfstUZgbKR/A
	 nuJZxxi9hfHXRMEoQ4IsjAiflT5IP1u1S7D/1H7Thx2iiTDmDIl+yt87T8JNxJqPA/
	 GA3p2nimu2AFhwm7zLpCiCnLGiOn3wOH/yi6ROqVo/PUW/We+l4oaScs/FobytDmNE
	 dFRwMYmRV/VOw==
Subject: Re: [PATCH net v5] net: macb: rate limit netdev error info print in
 the data path
From: netdev-bot+sashiko@kernel.org
To: taozj888@163.com
Cc: theo.lebrun@bootlin.com, stable@vger.kernel.org,
 conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 nicolas.ferre@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 10:09:30 +0000
Message-ID: <179171337032.434549.9838916167952285277@kernel.org>
In-Reply-To: <20261010092134.130564-1-taozj888@163.com>
References: <20261010092134.130564-1-taozj888@163.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says the patch will "rate limit the netdev
  error information print in the receive and transmit data path" of the…

--

net: macb: rate limit netdev error info print in the data path

This commit wraps five netdev_err() calls in gem_rx(), macb_rx(),
macb_interrupt_misc() and macb_start_xmit() with net_ratelimit(). The goal
is to stop the console from flooding when many bad or oversized frames
arrive, for example during boot.

> So rate limit the netdev error information print in the receive
> and transmit data path.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 261a7e87520a4..9f31ad7bf8e13 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

[ ... ]

> @@ -2102,7 +2103,8 @@ static int macb_interrupt_misc(struct macb_queue *queue, u32 status)
>  
>  	if (status & MACB_BIT(HRESP)) {
>  		queue_work(system_bh_wq, &bp->hresp_err_bh_work);
> -		netdev_err(netdev, "DMA bus error: HRESP not OK\n");
> +		if (net_ratelimit())
> +			netdev_err(netdev, "DMA bus error: HRESP not OK\n");
>  		macb_queue_isr_clear(bp, queue, MACB_BIT(HRESP));
>  	}
>  
> @@ -2505,7 +2507,8 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
>  		else
>  			hdrlen = skb_tcp_all_headers(skb);
>  		if (skb_headlen(skb) < hdrlen) {
> -			netdev_err(bp->netdev, "Error - LSO headers fragmented!!!\n");
> +			if (net_ratelimit())
> +				netdev_err(bp->netdev, "Error - LSO headers fragmented!!!\n");
>  			/* if this is required, would need to copy to single buffer */
>  			return NETDEV_TX_BUSY;
>  		}

[Severity: Medium]

The commit message says the patch rate limits error prints "in the receive
and transmit data path". Are there other data path prints in macb_main.c
that need the same change? Several netdev_err() calls on these paths still
have no rate limit.

gem_rx_refill(), which runs at the end of every gem_rx() poll:

	if (unlikely(!skb)) {
		netdev_err(bp->netdev,
			   "Unable to allocate sk_buff\n");
		break;
	}

macb_tx_map(), called from macb_start_xmit():

	netdev_err(bp->netdev, "BUG! empty skb!\n");
	...
dma_error:
	netdev_err(bp->netdev, "TX DMA map failed\n");

at91ether_start_xmit(), the at91rm9200 counterpart of macb_start_xmit():

	netdev_err(netdev, "%s: DMA mapping error\n", __func__);
	...
	} else {
		netdev_err(netdev, "%s called, but device is busy!\n",
			   __func__);
		return NETDEV_TX_BUSY;

This path returns NETDEV_TX_BUSY, so the qdisc requeues and retries.
Wouldn't the message then print again on every retry?

at91ether_interrupt(), the counterpart of macb_interrupt_misc():

	if (intstatus & MACB_BIT(ISR_ROVR))
		netdev_err(netdev, "ROVR error\n");

This prints from hardirq context on every receive overrun, and an inbound
packet flood can cause overruns. Can this produce the same console flood
the commit message describes? The HRESP message in macb_interrupt_misc()
is now rate limited, but this one is not.

Should these sites be converted too? Alternatively, the commit message
could be narrowed to the sites this patch actually changes.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010092134.130564-1-taozj888%40163.com
