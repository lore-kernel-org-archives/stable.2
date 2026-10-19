Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A8D1A9F83;
	Mon, 19 Oct 2026 02:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792375854; cv=none; b=O6WeBbVNgqKSXV78WNZ7bCvRCa1wz1gLXxcDfNH03O2yKxYwSZfu+RO1YeNxHktEJ9JUpcNaLQP92d79TQjBVpPZPe1AWJixq8NyhMcGe0MLk6l/B4fINP/bMVhCtyThWZ2K131sVS0TtQ/lfZA7YDdPiB5L06X92qNoiGVwWB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792375854; c=relaxed/simple;
	bh=VT/P0mK2VaKGn/2Oe1CypMGrSWG3URqbodHzPbCSncc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TNdlxT0sCoo3i5vR+Q59/qoIl+EJ0GQyCcNBfTTKvTUS0oznipq+gtL7k8Rm//NyDFd9P6gewe3//tDiqrwyzUF+xHjF34Rv8ISmdi87ZPOVmmcWFA9c7bc32N3N91aNOugbmf//+cff1tJ/H2CkcaK8z2RLXuZX4Lc5CLOeieA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qe/UQloC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qe/UQloC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3ACB1F000C4;
	Mon, 19 Oct 2026 02:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792375852;
	bh=bWQr84Ut4euO4rC2GPXmMy2rcg7Q2xeSpdll7Ym6PCg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Qe/UQloC9XD+E8GtyPhG2hJ10zSLx19wNZTUchNdxrXy0aJR+AKlUEFhGz0J/BiAC
	 BA6CmV+vOpb3EyVgYxKp+/oveTePTtgrSTcVElH6UPi1kzHxmrs5qQ5uh25JIZdrMk
	 Jx8X5oSINwIuyiv7OhEv+VTxpcv/Z1al9tyNDHps76Mnge+h25GlE+BSJ37tFam3yC
	 gv7Z7vxk0UEuReVcaVVMtmxtuvY6HZ+NzfMSKDXB2BEgd/qdYWxAT9wjWV7ajB6BOG
	 4AuaZ+8EFgJUfR86KwTiNQ6GdRcTXrvQJjQBe/13SAs2LRBufht3Eh4j6yb0lx5cAm
	 g6ovnnLrcJ3TA==
Subject: Re: [PATCH net v3 1/2] net: nixge: free IRQs before killing the DMA
 error tasklet
From: netdev-bot+sashiko@kernel.org
To: mhun512@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, ae878000@gmail.com,
 daniel.machon@microchip.com
Date: Mon, 19 Oct 2026 02:10:51 +0000
Message-ID: <179237585120.3135.6029909727102420602@kernel.org>
In-Reply-To: <20261018020840.3851552-2-mhun512@gmail.com>
References: <20261018020840.3851552-2-mhun512@gmail.com>
X-sashiko-severity: Critical
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

Critical: 1 · High: 0 (3) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] In this commit, nixge_stop() in
  drivers/net/ethernet/ni/nixge.c clears RUNSTOP on both channels (lines…

Pre-existing issues:
- [High] nixge_dma_err_handler() runs as a tasklet (softirq, atomic
  context).
- [High] nixge_hw_dma_bd_release() frees priv->rx_bd_v, its RX skbs,
  priv->tx_skb and priv->tx_bd_v, but never sets those pointers to NULL.
- [High] nixge_dma_err_handler() takes no lock and does not quiesce NAPI
  or the TX queue.

--

net: nixge: free IRQs before killing the DMA error tasklet

This patch reorders nixge_stop() so the TX and RX IRQs are freed before
tasklet_kill() runs on dma_err_tasklet. The aim is to stop the IRQ
handlers from rescheduling the error tasklet after it has been drained
and the descriptor rings have been released.

> diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
> index 230d5ff99dd7e..8697a76241394 100644
> --- a/drivers/net/ethernet/ni/nixge.c
> +++ b/drivers/net/ethernet/ni/nixge.c
> @@ -927,11 +927,12 @@ static int nixge_stop(struct net_device *ndev)
>  	nixge_dma_write_reg(priv, XAXIDMA_TX_CR_OFFSET,
>  			    cr & (~XAXIDMA_CR_RUNSTOP_MASK));
>  
> -	tasklet_kill(&priv->dma_err_tasklet);
> -
> +	/* Remove both producers before draining the error tasklet. */
>  	free_irq(priv->tx_irq, ndev);
>  	free_irq(priv->rx_irq, ndev);
>  
> +	tasklet_kill(&priv->dma_err_tasklet);
> +
>  	nixge_hw_dma_bd_release(ndev);

[Severity: Critical]
Can the error tasklet restart the DMA engine here, after RUNSTOP has
already been cleared above?

Suppose nixge_tx_irq() or nixge_rx_irq() scheduled dma_err_tasklet
before free_irq(). Then tasklet_kill() waits for it to run to
completion. nixge_dma_err_handler() resets the AXI DMA, re-enables
XAXIDMA_IRQ_ALL_MASK, and sets RUNSTOP on both channels again. The RX
channel ends up owning the whole RX ring:

nixge_dma_err_handler() {
    ...
	nixge_dma_write_desc_reg(lp, XAXIDMA_RX_CDESC_OFFSET, lp->rx_bd_p);
	cr = nixge_dma_read_reg(lp, XAXIDMA_RX_CR_OFFSET);
	nixge_dma_write_reg(lp, XAXIDMA_RX_CR_OFFSET,
			    cr | XAXIDMA_CR_RUNSTOP_MASK);
	nixge_dma_write_desc_reg(lp, XAXIDMA_RX_TDESC_OFFSET, lp->rx_bd_p +
			    (sizeof(*lp->rx_bd_v) * (RX_BD_NUM - 1)));
    ...
	nixge_dma_write_reg(lp, XAXIDMA_TX_CR_OFFSET,
			    cr | XAXIDMA_CR_RUNSTOP_MASK);
}

Nothing stops the engine again before nixge_hw_dma_bd_release() unmaps
and frees the RX skbs and calls dma_free_coherent() on both rings.

Could the device then DMA received frames into freed memory, or fetch
freed descriptors?

The old ordering (RUNSTOP clear, tasklet_kill(), free_irq()) had the
same restart window, so the reordering does not create it. The next
patch in this series, "net: nixge: wait for DMA reset before releasing
buffers", looks like it closes the window. After tasklet_kill() it
clears RUNSTOP and IRQ_ALL on both channels again and does a polled AXI
DMA reset before the release. If the reset fails, it keeps the buffers.

>  
>  	return 0;

[Severity: High]
This isn't a bug introduced by this patch, but nixge_stop() now relies
on draining dma_err_tasklet. Is it safe for that tasklet to call a
sleeping poll helper?

nixge_dma_err_handler() runs in softirq context and calls
__nixge_device_reset() for both channels, which does:

__nixge_device_reset() {
    ...
	err = nixge_dma_poll_timeout(priv, offset, status,
				     !(status & XAXIDMA_CR_RESET_MASK), 10,
				     1000);
    ...
}

nixge_dma_poll_timeout() wraps readl_poll_timeout(). With a nonzero
sleep_us, poll_timeout_us() calls might_sleep_if() and then
usleep_range() between polls.

Wouldn't every error recovery run trigger a "sleeping function called
from invalid context" warning? And if the reset bit has not cleared on
the first read, wouldn't it hit "scheduling while atomic"?

Using readl_poll_timeout_atomic(), or moving recovery into a work item,
would avoid this. The problem goes back to the driver's introduction.

[Severity: High]
This is a pre-existing issue, but nixge_hw_dma_bd_release(), called
from nixge_stop() above, frees priv->rx_bd_v, the RX skbs, priv->tx_skb
and priv->tx_bd_v. It never sets those pointers to NULL.

nixge_hw_dma_bd_init() assigns the pointers one at a time and calls
nixge_hw_dma_bd_release() on failure:

nixge_hw_dma_bd_init() {
    ...
	priv->tx_bd_v = dma_alloc_coherent(ndev->dev.parent,
					   sizeof(*priv->tx_bd_v) * TX_BD_NUM,
					   &priv->tx_bd_p, GFP_KERNEL);
	if (!priv->tx_bd_v)
		goto out;
    ...
out:
	nixge_hw_dma_bd_release(ndev);
	return -ENOMEM;
}

Consider an open/stop cycle followed by a second open where the tx_bd_v
or tx_skb allocation fails. At that point priv->rx_bd_v still points at
the ring that was already freed.

Would release then read freed descriptor memory, call
dma_unmap_single() on stale addresses, call dev_kfree_skb() on skbs
that were already freed, and call dma_free_coherent() on the RX ring a
second time?

A stale tx_skb would also reach devm_kfree() for a resource that no
longer exists, which triggers the WARN_ON in devres_destroy().

nixge_device_reset() only logs the -ENOMEM:

	if (nixge_hw_dma_bd_init(ndev))
		netdev_err(ndev, "%s: descriptor allocation failed\n",
			   __func__);

So nixge_open() carries on with tx_bd_v == NULL or with freed rings.
Couldn't nixge_start_xmit() then dereference priv->tx_bd_v, and the
next nixge_stop() release the same stale pointers again?

[Severity: High]
This isn't a bug introduced by this patch, but nixge_dma_err_handler()
takes no lock and does not quiesce NAPI or the TX queue while it walks
the rings:

nixge_dma_err_handler() {
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

TX and RX use separate IRQ lines. An RX error can schedule the tasklet
while nixge_tx_irq()->nixge_start_xmit_done() is running on another
CPU. In that case both sides call nixge_tx_skb_unmap() on the same
entries:

nixge_tx_skb_unmap() {
    ...
	if (tx_skb->skb) {
		dev_kfree_skb_any(tx_skb->skb);
		tx_skb->skb = NULL;
	}
}

Can both sides pass the tx_skb->skb check and free the same skb twice,
or unmap the same mapping twice? Clearing XAXIDMA_IRQ_ALL_MASK in the
error path only blocks future interrupts. It does not stop a handler
that is already running.

nixge_start_xmit() has the same exposure. Only the netdev TX lock
serializes it, so it can fill tx_skb[] and advance tx_bd_tail while the
tasklet clears and resets them. nixge_recv() under NAPI can also
advance rx_bd_ci while the tasklet resets it.

Could this free an skb that was just queued, or leave the ring indices
out of sync?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018020840.3851552-1-mhun512%40gmail.com
