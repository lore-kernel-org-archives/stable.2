Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971542EEE75;
	Sun,  4 Oct 2026 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115013; cv=none; b=HsE78A6PqBHzCsZjMJhfoFMr73d8YKkLEYlSh+rclsIpx/mSrmWHarFzVzY3jg2rsfHnLq0a7ENJNS9TWOy7qcy3yhQQLpUYa72h51+24qlZkcNhEiTKvpPIp7FgYAYKDK5UwAwG66PYUoOUN0NwfLac2JMwwPE/M5Z28nFrfr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115013; c=relaxed/simple;
	bh=4e1cggxNcpNhzjwVlx5Tr8gCS/0Wm34WDbMKjABmtCo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bOk4CPmJSsMFCVTl7v6odZgQMhlgFcen5KVdPyObK/lGsY1RKyMcNYZi8BdjbI9cQ4v0ex6LOcxbD7K8/x/nGGgMkiw05L3Wwo8mpZ/bowxhiWSiKZgM1AzP3LxYyXJJT0ozgbs4Fo3buLcVPtzXsQfuW4nQE38GFVPbjntHtZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xi3uw4c/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xi3uw4c/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFFB1F000FF;
	Sun,  4 Oct 2026 11:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791115012;
	bh=sCLAUkbhpcI/kDJevY41b6eZab5uxLiANrpl2/hnmQ8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Xi3uw4c/F1Bv0NPLI9+5z0aM5ZdBVBXbDqAwolhyVxtrBgdKE2PB1GvGgltu5w/Mh
	 g/QsNTJesZC7sEDTXjQWV7Tg2r39D8p699PODjHztCNEy9IQn1N31YGVbQTKW1Dmkf
	 hiCrgFJr1DDwTcP7euTvxp/6qCwKCGejxvXJsHag8BbIvKbsNvM1XiG1q5i2kT/bxB
	 zAdMcP1/3yemSGlFNDAzFmQaYoieU3zTU9C8gYMt07ot/iLOVa5BjpPPfK1iSd04NJ
	 IXLUb17l7uxvTDNLhs5PZzO70aMHzabnN8PwAux7IcGGDlZBMC1OiB7mUrKQcbsm25
	 1POj5Oqw5XA4g==
Subject: Re: [PATCH net v2] net: macb: rate limit netdev error info print in
 the data path
From: netdev-bot+sashiko@kernel.org
To: taozj888@163.com
Cc: theo.lebrun@bootlin.com, stable@vger.kernel.org,
 conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 hskinnemoen@atmel.com, jeff@garzik.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 04 Oct 2026 11:56:51 +0000
Message-ID: <179111501100.434549.3605361274069666617@kernel.org>
In-Reply-To: <20260930113520.392025-1-taozj888@163.com>
References: <20260930113520.392025-1-taozj888@163.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix does not cover what its commit message claims.
- [Low] The author identity "taozijin <taozj888@163.com>" does not match
  the Signed-off-by trailer "Zijin Tao <taozj888@163.com>".

--

net: macb: rate limit netdev error info print in the data path

This patch wraps four netdev_err() calls in the macb driver with
net_ratelimit(). Two are in gem_rx(), one is the RX queue corruption
message in macb_rx(), and one is the HRESP DMA bus error in
macb_interrupt_misc(). The goal is to stop console floods at boot when
many bad or oversized frames arrive.

> Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Zijin Tao <taozj888@163.com>

[Severity: Low]
This isn't a bug, but the name in the Author line does not match the
name in the Signed-off-by. The email address is the same:

  Author: taozijin <taozj888@163.com>
  Signed-off-by: Zijin Tao <taozj888@163.com>

checkpatch.pl reports this as FROM_SIGN_OFF_MISMATCH.

Also, a blank line separates the Fixes: and Cc: tags from the
Signed-off-by, so they don't form a single trailer block.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 8e5c034dc3a48..ca60960bec362 100644
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

[Severity: High]
The commit message says:

  So rate limit the netdev error information print in the receive
  and transmit data path.

Does the patch match that description? The only non-RX print it
converts is this HRESP one in macb_interrupt_misc(). That is a DMA bus
error interrupt, not the transmit data path. No TX data path print
seems to be rate limited.

Several prints of the same kind in macb_main.c look like they are still
unlimited. at91ether_interrupt() runs in hard IRQ context and still
does:

	if (intstatus & MACB_BIT(ISR_ROVR))
		netdev_err(netdev, "ROVR error\n");

at91ether_open() enables ISR_ROVR. A line rate flood from a link peer
would cause exactly this RX overrun, which is the scenario in the commit
message. macb_interrupt_misc() handles the same bit by only incrementing
hw_stats rx_overruns.

gem_rx_refill() runs at the end of every gem_rx() poll and still has:

	if (unlikely(!skb)) {
		netdev_err(bp->netdev,
			   "Unable to allocate sk_buff\n");
		break;
	}

Under memory pressure, would this log again on every poll, right next
to the gem_rx() prints that are now rate limited?

On the TX side, these still print without a limit:

  macb_tx_map():
	netdev_err(bp->netdev, "TX DMA map failed\n");

  macb_start_xmit():
	netdev_err(bp->netdev, "Error - LSO headers fragmented!!!\n");
	/* if this is required, would need to copy to single buffer */
	return NETDEV_TX_BUSY;

  at91ether_start_xmit():
	netdev_err(netdev, "%s: DMA mapping error\n", __func__);
	...
	netdev_err(netdev, "%s called, but device is busy!\n",
		   __func__);
	return NETDEV_TX_BUSY;

  macb_tx_error_task():
	netdev_err(bp->netdev,
		   "BUG: TX buffers exhausted mid-frame\n");

The comment in macb_tx_error_task() says that last print is meant to be
loud, so it may be fine to leave as is.

For the two paths that return NETDEV_TX_BUSY, won't the qdisc requeue
the same skb and print the message again on every retry?

This is tagged for stable. Should the remaining RX, IRQ and TX data path
sites be converted too? Or should the commit message only describe the
RX and HRESP prints this patch changes?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930113520.392025-1-taozj888%40163.com
