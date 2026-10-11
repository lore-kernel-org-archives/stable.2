Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23273D76;
	Sun, 11 Oct 2026 05:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791697610; cv=none; b=j82g0r3x60rbsUUmpFrh0ZGo0sr7aG1tdt5eyVkOwVTCKIUF5+slJBhY8Vxtzm8qcgczSUDH3nMbeXFSPXGSb9ylaESdiaQESvC6nqsiu3f1I3egcxzDkDiK20PpR+jxTUc7vEuPoXDvfEhxINMPcmW9HjVYJIzcu5AVZMjLHyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791697610; c=relaxed/simple;
	bh=gZJSG8A/67hd3B6zA/aibPN5rKBiq2RmBmooSMkx+x0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I7NA1OV32LFOLLp8aLXlhM+ypxhqs0AFP8hGCJws18HUcZev1Ol9MJYN/kowb2NtQClf+Hv0mXpYG5UgzrHQIptS3z2KsJvt8gJPdBfnrfDvALahdp3eXmp+nsJbnCmnhOkbF10gNJPjQakkEY3owUzTizU5cbbcyd8cRpdRNiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgOfn4ma; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgOfn4ma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC7E1F0089B;
	Sun, 11 Oct 2026 05:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791697609;
	bh=Oesar8D5nvboPxSOo8Pi6hgOJ1kvG714xpYkndMYUF0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jgOfn4maWmQqxaHU2Nk5brkkJElNUBKf3lPAXYY3VF1o/p1onEFkWBGVJYlepOev7
	 cd/v+HpKjox96ArNbHAA9aZJLPDfePgVhVTNxhzvcrYuYW/RBOaBkr62cTIaIcMhH2
	 /j7+Y5dUpo7PBM7rhCzkOdcCpe7qbwviXY0V9XjLt9HFH/tPwOQXe6TYVwEbuf/6ph
	 Bazzm9OMOZOfCVOXPEnQnk7WFNUN5bZWfHjqFcj/5KMkwOSKhQgAW5Ex7DjiiwC8e3
	 3XYHg/M6aWPf6JZ2hMZu2kVcYk2qyxfeK6Eu5jOW2tDowgfLP5vg87pI9jXAEHroK1
	 wFU26UujEHFew==
Subject: Re: [PATCH net v4] net: macb: rate limit netdev error info print in
 the data path
From: netdev-bot+sashiko@kernel.org
To: taozj888@163.com
Cc: theo.lebrun@bootlin.com, stable@vger.kernel.org,
 conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jeff@garzik.org,
 hskinnemoen@atmel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 05:46:48 +0000
Message-ID: <179169760819.434549.4959180308311606456@kernel.org>
In-Reply-To: <20261007053211.572073-1-taozj888@163.com>
References: <20261007053211.572073-1-taozj888@163.com>
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

- [High] The fix is incomplete.
- [Low] macb: mismatch between commit message and implementation for TX
  rate limiting

--

net: macb: rate limit netdev error info print in the data path

This commit wraps the netdev_err() calls in gem_rx(), macb_rx() and
macb_interrupt_misc() with net_ratelimit(). The goal is to stop a flood of
bad RX descriptors from filling the console and delaying boot. It is tagged
for stable as a fix for the original Atmel MACB driver.

> So rate limit the netdev error information print in the receive
> and transmit data path.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 8e5c034dc3a48..ca60960bec362 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1617,16 +1617,16 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
>  		count++;
>  
>  		if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF))) {
> -			netdev_err(bp->netdev,
> -				   "not whole frame pointed by descriptor\n");
> +			if (net_ratelimit())
> +				netdev_err(bp->netdev, "not whole frame pointed by descriptor\n");
>  			bp->netdev->stats.rx_dropped++;
>  			queue->stats.rx_dropped++;
>  			break;
>  		}
>  		skb = queue->rx_skbuff[entry];
>  		if (unlikely(!skb)) {
> -			netdev_err(bp->netdev,
> -				   "inconsistent Rx descriptor chain\n");
> +			if (net_ratelimit())
> +				netdev_err(bp->netdev, "inconsistent Rx descriptor chain\n");
>  			bp->netdev->stats.rx_dropped++;
>  			queue->stats.rx_dropped++;
>  			break;

[Severity: High]
The commit message says prints in both the receive and transmit data
paths are rate limited, but this patch doesn't change any TX path. Are
there other per-packet or per-interrupt netdev_err() calls in
macb_main.c that can still flood the console in the same way?

An empty rx_skbuff[] entry usually means a refill failed. gem_rx() calls
gem_rx_refill() at the end of every NAPI poll, and the print there is
still unconditional:

gem_rx_refill() {
    ...
			skb = netdev_alloc_skb(bp->netdev, bp->rx_buffer_size);
			if (unlikely(!skb)) {
				netdev_err(bp->netdev,
					   "Unable to allocate sk_buff\n");
				break;
			}
    ...
}

Under memory pressure, won't this print on every poll of every queue?

On the TX side, macb_start_xmit() returns NETDEV_TX_BUSY after a print
that has no rate limit:

macb_start_xmit() {
    ...
		if (skb_headlen(skb) < hdrlen) {
			netdev_err(bp->netdev, "Error - LSO headers fragmented!!!\n");
			/* if this is required, would need to copy to single buffer */
			return NETDEV_TX_BUSY;
		}
    ...
}

The qdisc requeues the same skb and tries again. Can this message keep
repeating for as long as that skb stays at the head of the queue?

macb_tx_map() also prints once for every packet whose DMA mapping fails:

macb_tx_map() {
    ...
dma_error:
	netdev_err(bp->netdev, "TX DMA map failed\n");
    ...
}

at91ether_start_xmit() has the same pattern:

			netdev_err(netdev, "%s: DMA mapping error\n", __func__);
			return NETDEV_TX_OK;

at91ether_interrupt() prints from hardirq context on every RX overrun:

	if (intstatus & MACB_BIT(ISR_ROVR))
		netdev_err(netdev, "ROVR error\n");

ISR_ROVR is enabled in IER for at91ether. The driver has only
AT91ETHER_MAX_RX_DESCR (9) RX descriptors and handles RX inside the IRQ
handler. Could a remote sender flooding the link trigger this print in
the way the commit message describes for gem_rx()?

For comparison, the ISR_ROVR handling in macb_interrupt_misc() only
increments a counter.

Since this is going to stable as a fix for console flooding, should
these sites be rate limited as well?

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

[Severity: Low]
The commit message says this rate limits the error prints in the
receive and transmit data paths, but none of the sites changed here
are in the TX path. gem_rx() and macb_rx() are RX. The HRESP print in
macb_interrupt_misc() reports a DMA bus error from the misc interrupt
handler.

The TX side still has unconditional prints that can fire once per
packet. macb_tx_map() prints "TX DMA map failed" every time a mapping
fails. macb_start_xmit() prints
"Error - LSO headers fragmented!!!" before returning NETDEV_TX_BUSY,
so the qdisc requeues the same skb and hits the print again on the
next attempt. This patch does not touch either site.

Should these TX sites be rate limited as well? Or should the commit
message be reworded so it only claims the RX and interrupt paths?
Since this is tagged for stable, the description needs to match what
the backport actually changes.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007053211.572073-1-taozj888%40163.com
