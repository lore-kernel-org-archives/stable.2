Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087FA33F5A8;
	Sun,  4 Oct 2026 04:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791087253; cv=none; b=T7heG+GaIp5/s6NKGjVDFepl3LhFohSNy7EoII539Nw0DniEVlAO6c0QRMr7Vk3yUfEW+uwz158N8I0WE5UGI4O53ht5k+PVRPdfJM6noY5bHTqF+WSVZR0wDI8hSRjHEWk/LLhXL2EZUsKOQqvg3lWnFnt6BRJLzuDjt/8Dbhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791087253; c=relaxed/simple;
	bh=xa9NTkckUMyxXuEwMSmBav9bUwr4wMGfSVMtxwHCZoQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GuGkWqop4mp5VE5oLn92WL2brmo9PHEg7Z2gjrnRm+0Tb2i+skuHMu6mp2QCEHUItVM7UKJDEgI0IOBxvDgChvEtCDv36bHAz+y/cj3SfdqicSAaALUwh4Rc0MMtc44/iQIALdMPdei/LtghWqV9Sn40kYVCHxvNPOdav4KSCT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yia2Rf9l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yia2Rf9l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90A81F000FF;
	Sun,  4 Oct 2026 04:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791087251;
	bh=w042URQOWJm0xXcaq6wAsR+4q/Uu+c3l4MG9/jdVExw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Yia2Rf9lWgE3UjR06Tw3+xy7isYYHpgRbMuA7AurqMnUaqP2YXk/kEywu4h823VCJ
	 EYFCfqldtLTqa4aqGE6awBJBE3tCtUx+TvBxbmmtKHEdEN/7UETmdGuAZUuBu1Pl8G
	 7iZHK0lA7dpssNNhtaA/sQTtV60/LulALRo+jiNopmy66AWdv1S0D1/suWrp2RALsY
	 4R7RnaPqsnTcK9RX4fJSNOZ2FRRXb0pUoBuRIx7QjPj7ekE1yfHHdLSNmtm3ZWROpk
	 cjO8joMFo/kHqMm2hj9RM+unSXsKU5Y0+7O16q8c2A070atJTrTrdpE3JkBM65FxZ2
	 KRVd/ZEcYyH0Q==
Subject: Re: [PATCH net] net: nixge: stop IRQ producers before draining DMA
 error tasklet
From: netdev-bot+sashiko@kernel.org
To: mhun512@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, ae878000@gmail.com
Date: Sun, 04 Oct 2026 04:14:10 +0000
Message-ID: <179108725013.434549.7036380491047031962@kernel.org>
In-Reply-To: <20261003041242.650599-1-mhun512@gmail.com>
References: <20261003041242.650599-1-mhun512@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (3) · Medium: 0 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The second stop the patch adds to nixge_stop() (lines 937-943)
  only clears DMACR.RS on the RX and TX AXI DMA channels.

Pre-existing issues:
- [High] nixge_hw_dma_bd_release()
  (drivers/net/ethernet/ni/nixge.c:244-281) frees priv->rx_bd_v, the RX…
- [High] The DMA error tasklet nixge_dma_err_handler() runs in softirq
  context and starts by calling __nixge_device_reset() for TX and RX…
- [High] nixge_dma_err_handler() takes no lock while it resets tx_bd_ci,
  tx_bd_tail and rx_bd_ci (lines 816-818), rewrites every TX descriptor,…
- [Medium] nixge_hw_dma_bd_release() calls devm_kfree(priv->tx_skb) (line
  273) and frees tx_bd_v without first calling nixge_tx_skb_unmap() on…
- [Medium] nixge_open() calls nixge_device_reset() first.

--

net: nixge: stop IRQ producers before draining DMA error tasklet

This reorders nixge_stop() so both IRQs are freed before tasklet_kill()
drains the DMA error tasklet. That stops the interrupt handlers from
rescheduling the tasklet afterwards. It also clears RUNSTOP on both DMA
channels a second time after tasklet_kill(), in case error recovery
restarted them.

> diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
> index 230d5ff99dd7e..7bba6f8e64fe1 100644
> --- a/drivers/net/ethernet/ni/nixge.c
> +++ b/drivers/net/ethernet/ni/nixge.c

[ ... ]

> @@ -927,11 +928,20 @@ static int nixge_stop(struct net_device *ndev)
>  	nixge_dma_write_reg(priv, XAXIDMA_TX_CR_OFFSET,
>  			    cr & (~XAXIDMA_CR_RUNSTOP_MASK));
>  
> -	tasklet_kill(&priv->dma_err_tasklet);
> -
> +	/* Remove both producers before draining the error tasklet. */
>  	free_irq(priv->tx_irq, ndev);
>  	free_irq(priv->rx_irq, ndev);

[Severity: High]
This is a pre-existing issue, but what serializes nixge_dma_err_handler()
against the TX paths? The tasklet takes no lock while it unmaps every
tx_skb[] entry and resets the ring indices:

drivers/net/ethernet/ni/nixge.c:nixge_dma_err_handler() {
    ...
	for (i = 0; i < TX_BD_NUM; i++) {
		cur_p = &lp->tx_bd_v[i];
		tx_skb = &lp->tx_skb[i];
		nixge_tx_skb_unmap(lp, tx_skb);
    ...
	lp->tx_bd_ci = 0;
	lp->tx_bd_tail = 0;
	lp->rx_bd_ci = 0;
    ...
}

Two other paths update the same state:

- nixge_start_xmit(), which holds only netif_tx_lock. The error IRQ
  handlers never stop the TX queue.
- nixge_tx_irq()->nixge_start_xmit_done(), in hardirq context. This can
  run on another CPU because tx_irq and rx_irq are separate lines.

For example:

CPU1
nixge_rx_irq()            /* DMA error */
  tasklet_schedule()
nixge_dma_err_handler()
  lp->tx_bd_tail = 0;

CPU0
nixge_start_xmit()
  tx_skb->skb = skb;      /* tx_skb[tx_bd_tail] */
  ++priv->tx_bd_tail;

Another case: a TX completion on CPU0 runs nixge_start_xmit_done(), which
calls nixge_tx_skb_unmap() on the same entry the tasklet is unmapping.

nixge_tx_skb_unmap() checks and then frees tx_skb->mapping and tx_skb->skb
without a lock. Can this cause a double dma unmap and a double
dev_kfree_skb_any()? Could the tasklet also free an skb whose descriptor
the hardware then transmits from? The sleeping reset poll at the start of
the tasklet makes this window wider.

nixge_stop() has a similar window between the first RUNSTOP clear and the
free_irq() calls above.

>  
> +	tasklet_kill(&priv->dma_err_tasklet);
> +

[Severity: High]
This isn't a bug introduced by this patch, but nixge_stop() now waits
here for the error tasklet to finish its recovery. Can
nixge_dma_err_handler() sleep in softirq context?

nixge_dma_err_handler()
  __nixge_device_reset()
    nixge_dma_poll_timeout(priv, offset, status, ..., 10, 1000)
      readl_poll_timeout()
        usleep_range()

nixge_dma_poll_timeout() wraps readl_poll_timeout(), not
readl_poll_timeout_atomic(). With sleep_us set to 10, it calls
might_sleep_if(). It then calls usleep_range() whenever the reset bit has
not cleared on the first read. The comment in __nixge_device_reset() says
the reset "takes a while to complete", so the sleeping path is expected
to run.

Would every TX or RX DMA error interrupt then trigger "BUG: scheduling
while atomic"? Using readl_poll_timeout_atomic(), or moving the recovery
to a workqueue, would avoid that.

> +	/* Error recovery may have restarted DMA, so stop both channels again. */
> +	cr = nixge_dma_read_reg(priv, XAXIDMA_RX_CR_OFFSET);
> +	nixge_dma_write_reg(priv, XAXIDMA_RX_CR_OFFSET,
> +			    cr & (~XAXIDMA_CR_RUNSTOP_MASK));
> +	cr = nixge_dma_read_reg(priv, XAXIDMA_TX_CR_OFFSET);
> +	nixge_dma_write_reg(priv, XAXIDMA_TX_CR_OFFSET,
> +			    cr & (~XAXIDMA_CR_RUNSTOP_MASK));
> +

[Severity: High]
Is clearing RUNSTOP enough to quiesce the engines before
nixge_hw_dma_bd_release() frees the rings?

On AXI DMA, clearing DMACR.RS only requests a halt. The engine stops
after it finishes or flushes the current transfer and any outstanding
descriptor updates. Nothing here polls XAXIDMA_RX_SR_OFFSET or
XAXIDMA_TX_SR_OFFSET for the halted bit, and the channels are not reset.

This block is meant for the case where the error tasklet has just
restarted the engines. In that case nixge_dma_err_handler() has
re-enabled the interrupts and handed the whole RX ring back to the
hardware:

drivers/net/ethernet/ni/nixge.c:nixge_dma_err_handler() {
    ...
	cr |= XAXIDMA_IRQ_ALL_MASK;
	/* Finally write to the Rx channel control register */
	nixge_dma_write_reg(lp, XAXIDMA_RX_CR_OFFSET, cr);
    ...
	nixge_dma_write_reg(lp, XAXIDMA_RX_CR_OFFSET,
			    cr | XAXIDMA_CR_RUNSTOP_MASK);
	nixge_dma_write_desc_reg(lp, XAXIDMA_RX_TDESC_OFFSET, lp->rx_bd_p +
			    (sizeof(*lp->rx_bd_v) * (RX_BD_NUM - 1)));
    ...
}

Right after the posted RS clear, nixge_hw_dma_bd_release() unmaps and
frees the RX skbs and frees both coherent BD rings. Can an in-flight
frame or a BD status writeback land in that freed memory?

Frames can still arrive if phy_disconnect() did not power down the PHY,
for example when the PHY driver has no suspend callback or WoL is
enabled.

The bare RS clear also leaves the coalesce, delay and error interrupt
enables set by the tasklet, even though the handlers are now freed.

Other drivers for the same IP wait for the halt:

- axienet_dma_stop() in xilinx_axienet_main.c clears RS and the IRQ
  enables, polls XAXIDMA_SR_HALT_MASK, and then resets "to ensure DMA is
  really stopped".
- xilinx_dma_stop_transfer() in drivers/dma/xilinx/xilinx_dma.c polls
  DMASR.HALTED after clearing RUNSTOP.

The commit message says:

    Stop them again after tasklet_kill() returns so error recovery cannot
    undo the final stop before the descriptors are released.

Would one of these be a better final quiesce before the release?

- Call the existing __nixge_device_reset() on both channels here. It
  writes XAXIDMA_CR_RESET_MASK and waits for it to clear.
- Wait for the halted bit before releasing the descriptors.

>  	nixge_hw_dma_bd_release(ndev);

[Severity: High]
This isn't a bug introduced by this patch, but nixge_hw_dma_bd_release()
frees rx_bd_v, the RX skbs, tx_skb and tx_bd_v without setting the
pointers back to NULL. What happens on the next ifup if an allocation in
nixge_hw_dma_bd_init() fails?

For example, if dma_alloc_coherent() for tx_bd_v fails, tx_bd_v is NULL.
rx_bd_v and tx_skb still hold the addresses that the previous
nixge_stop() freed:

nixge_open()
  nixge_device_reset()
    nixge_hw_dma_bd_init()
      out:
        nixge_hw_dma_bd_release()

The release then does the following with stale pointers:

- Walks the freed rx_bd_v ring.
- Calls dma_unmap_single() and dev_kfree_skb() on skbs that were already
  freed.
- Calls dma_free_coherent() on rx_bd_v a second time.
- Calls devm_kfree() on a tx_skb that is no longer on the devres list.

If the failure happens partway through the RX skb loop, the release also
unmaps descriptors whose phys field was never filled in.

nixge_device_reset() only logs the error:

	if (nixge_hw_dma_bd_init(ndev))
		netdev_err(ndev, "%s: descriptor allocation failed\n",
			   __func__);

So nixge_open() still returns success with NULL or freed rings.
nixge_start_xmit() and the IRQ handlers then use those rings. The next
nixge_stop() calls nixge_hw_dma_bd_release() on the same stale pointers
again.

Should the release set the pointers to NULL, and should
nixge_device_reset() return the -ENOMEM to nixge_open()?

[Severity: Medium]
This is also a pre-existing issue, but does nixge_stop() leak the pending
TX skbs and their DMA mappings? nixge_hw_dma_bd_release() frees the
tx_skb array and tx_bd_v without first calling nixge_tx_skb_unmap() on
each entry:

	if (priv->tx_skb)
		devm_kfree(ndev->dev.parent, priv->tx_skb);

TX skbs are only unmapped and freed in two places:

- nixge_start_xmit_done(), on a TX completion interrupt.
- nixge_dma_err_handler().

Some TX descriptors may still be pending when nixge_stop() clears
RUNSTOP and frees the IRQs. For example, the link may have gone down, or
a completion interrupt may be held back by coalescing. Are those skbs
and their mappings then lost on every ifdown?

[Severity: Medium]
This is another pre-existing issue, not introduced by this patch, but the
nixge_open() error paths skip this release entirely.
nixge_device_reset() allocates the rings, allocates and maps 128 RX
skbs, and sets RUNSTOP on both channels. If of_phy_connect() or either
request_irq() fails, nixge_open() takes these paths:

	phy = of_phy_connect(ndev, priv->phy_node,
			     &nixge_handle_link_change, 0, priv->phy_mode);
	if (!phy)
		return -ENODEV;
    ...
err_rx_irq:
	free_irq(priv->tx_irq, ndev);
err_tx_irq:
	napi_disable(&priv->napi);
	phy_stop(phy);
	phy_disconnect(phy);
	tasklet_kill(&priv->dma_err_tasklet);

Neither path calls nixge_hw_dma_bd_release() or stops the DMA. Do the
coherent rings, the RX skbs and their mappings leak here, with RX DMA
still running into them?

The next nixge_open() overwrites tx_bd_v, tx_skb and rx_bd_v, so these
allocations can never be reclaimed.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261003041242.650599-1-mhun512%40gmail.com
