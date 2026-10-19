Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09E826ED37;
	Mon, 19 Oct 2026 02:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792375855; cv=none; b=flMMj03sBdRYfqakJefp0RChrcT5eJ6gdRedy6NGvi6o8xQUG8FqN/hh9q58HfGfpUluh+/p1dAGrq8eyHGzjguVwQUPcn8RIYNw4GXOMBfRPeb8E+FOZDYaffuEZL2bEZMnfX/rHiFe9sTzVY75yjjun+TC/gH9zu0pyb/zpMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792375855; c=relaxed/simple;
	bh=vShf2Uyc5Saa0WtC6UUzYMpF9DJfavHR7RoV5KiKzag=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EqdQnG8XDWNGFEP2TOwUAi0x2XaKsdT8xYBHqGsB6RFE6Iv9pTM+/qvtIqCa7ehYkImaWsldMUx7o+38NVGI3pViJzNrhb9OHJn1sySAK7tcRCtkgEFv/QfzqOXQ7mNSq6uEHpzkwJ5WQD2WIqk1rQZ6w92XGmICHXsSd+Jz/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ0S8LR6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ0S8LR6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AC41F000C5;
	Mon, 19 Oct 2026 02:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792375853;
	bh=qgANegIRY71lBrjNURSuOuuUvd4jCVBUBvShR4rNr8Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kJ0S8LR6uvF+rg/KbXiQ3ksT5ZzmekncmSQ3G4U6fMSLApawVG4geVdNrtyCsOpvH
	 ITP75Y/VVL/3z/N706m/eTv58xPVp6GPTubYMSaIa6xdmAYHEex7ll8d06RUG2AphY
	 hIrrcqQqu9GSYXUsCVGKPd+GY0JjiLEf03RFDCN4jlcyfXtQJedjnBa4d6TXzssOEW
	 0KLDsEQWazW4ETIbRKxymKWewYzaui44TYcFKDm/hMVdJfXuGgG8RHucLeLXCg7gpF
	 wPhg4Z70OvDAB3e2AXRvSvzeeET8P3cxxfkXaMrWvRRS9hotBPE9mlc+YJhEQaJJAN
	 xkClinMwvotMw==
Subject: Re: [PATCH net v3 2/2] net: nixge: wait for DMA reset before
 releasing buffers
From: netdev-bot+sashiko@kernel.org
To: mhun512@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, ae878000@gmail.com,
 daniel.machon@microchip.com
Date: Mon, 19 Oct 2026 02:10:52 +0000
Message-ID: <179237585255.3135.18388695192416186276@kernel.org>
In-Reply-To: <20261018020840.3851552-3-mhun512@gmail.com>
References: <20261018020840.3851552-3-mhun512@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 (3) · Medium: 1 (2) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch only partly closes the hole it describes.
- [Medium] One reset timeout in nixge_stop() now disables the port for
  good, and nothing in the driver can recover it.
- [Low] On reset timeout, nixge_stop() now returns the error from
  ndo_stop (line 959).

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the DMA error
  recovery tasklet sleeps in atomic context.
- [High] This problem wasn't introduced by this patch, but stale ring
  pointers can be freed twice.
- [High] This problem wasn't introduced by this patch, but DMA error
  recovery races with the data path.
- [Medium] This problem wasn't introduced by this patch, but
  nixge_open()'s error paths leave the DMA engine running and leak the…
- [Medium] This problem wasn't introduced by this patch, but in-flight TX
  skbs and their DMA mappings leak on every stop.

--

net: nixge: wait for DMA reset before releasing buffers

After the IRQ handlers and the error tasklet have been drained, this patch
makes nixge_stop() mask the channel interrupts and clear RUNSTOP a second
time. It then resets the AXI DMA engine and waits for the reset to finish
before releasing the DMA buffers. __nixge_device_reset() now returns the
poll result. On a timeout, the buffers are kept and a new dma_stop_failed
flag makes later opens fail.

> diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
> index 8697a76241394..8bfda27741b26 100644
> --- a/drivers/net/ethernet/ni/nixge.c
> +++ b/drivers/net/ethernet/ni/nixge.c

[ ... ]

> @@ -391,7 +392,7 @@ static int nixge_hw_dma_bd_init(struct net_device *ndev)
>  	return -ENOMEM;
>  }
>  
> -static void __nixge_device_reset(struct nixge_priv *priv, off_t offset)
> +static int __nixge_device_reset(struct nixge_priv *priv, off_t offset)
>  {
>  	u32 status;
>  	int err;
> @@ -407,6 +408,8 @@ static void __nixge_device_reset(struct nixge_priv *priv, off_t offset)
>  				     1000);
>  	if (err)
>  		netdev_err(priv->ndev, "%s: DMA reset timeout!\n", __func__);
> +
> +	return err;
>  }

[Severity: High]
This is a pre-existing issue, but since this helper is being changed: can
__nixge_device_reset() sleep in softirq context?

The poll uses a non-zero sleep_us:

	err = nixge_dma_poll_timeout(priv, offset, status,
				     !(status & XAXIDMA_CR_RESET_MASK), 10,
				     1000);

nixge_dma_poll_timeout() wraps readl_poll_timeout(). That does
might_sleep_if(sleep_us != 0) and calls usleep_range() between polls.

nixge_dma_err_handler() is a tasklet scheduled from nixge_tx_irq() and
nixge_rx_irq(), and it starts with:

	__nixge_device_reset(lp, XAXIDMA_TX_CR_OFFSET);
	__nixge_device_reset(lp, XAXIDMA_RX_CR_OFFSET);

So any DMA error interrupt leads to:

nixge_tx_irq() / nixge_rx_irq()
  tasklet_schedule()
    nixge_dma_err_handler()
      __nixge_device_reset()
        readl_poll_timeout(..., 10, 1000)
          usleep_range()

Wouldn't this trigger "scheduling while atomic" whenever the reset bit is
still set on the first read? Would readl_poll_timeout_atomic() on the
tasklet path, or moving recovery to a workqueue, fit better?

[Severity: High]
This is also a pre-existing issue that this patch didn't introduce: does
nixge_dma_err_handler() race with the data path?

The tasklet rebuilds the rings without holding a lock:

	for (i = 0; i < TX_BD_NUM; i++) {
		cur_p = &lp->tx_bd_v[i];
		tx_skb = &lp->tx_skb[i];
		nixge_tx_skb_unmap(lp, tx_skb);
	[ ... ]
	lp->tx_bd_ci = 0;
	lp->tx_bd_tail = 0;
	lp->rx_bd_ci = 0;

It then does read-modify-writes of RX_CR and TX_CR.

Before scheduling it, nixge_tx_irq() and nixge_rx_irq() only mask
XAXIDMA_IRQ_ALL_MASK. They don't stop the TX queue or disable NAPI. So at
the same time:

- nixge_start_xmit() on another CPU can fill tx_skb[tx_bd_tail] and
  advance tx_bd_tail
- nixge_poll()->nixge_recv() can walk rx_bd_v[rx_bd_ci] and
  read-modify-write RX_CR
- a TX IOC interrupt already running on another CPU can call
  nixge_start_xmit_done()->nixge_tx_skb_unmap() on the same entries

With no shared lock, can two contexts both see tx_skb->skb != NULL and
both call dev_kfree_skb_any()? The same interleavings could also unmap
twice, corrupt the ring indices, and lose CR updates.

[ ... ]

> @@ -869,6 +872,10 @@ static int nixge_open(struct net_device *ndev)
>  	struct phy_device *phy;
>  	int ret;
>  
> +	/* A failed stop retained buffers which DMA may still be using. */
> +	if (priv->dma_stop_failed)
> +		return -EIO;
> +

[Severity: Medium]
Is there any way to recover once dma_stop_failed is set?

nixge_stop() sets the flag after a single __nixge_device_reset() poll, which
allows 1 ms in 10 us steps. Nothing ever clears the flag. Every later
nixge_open() returns -EIO without re-reading the DMA status or retrying the
reset.

nixge_remove() doesn't retry the reset or reclaim the kept buffers either.
The BD rings, the RX skbs and their mappings therefore stay leaked even
after unbind.

nixge_stop() also issues the reset without first waiting for the channels to
halt after clearing RUNSTOP. xilinx_axienet drives the same AXI DMA IP. Its
axienet_dma_stop() waits for XAXIDMA_SR_HALT_MASK on each channel, and
__axienet_device_reset() then allows 50 ms for the reset bit to clear:

	ret = read_poll_timeout(axienet_dma_in32, value,
				!(value & XAXIDMA_CR_RESET_MASK),
				DELAY_OF_ONE_MILLISEC, 50000, false, lp,
				XAXIDMA_TX_CR_OFFSET);

Is 1 ms enough for a stop-time reset of a busy engine?

The commit message says:

    If reset times out, retain the DMA buffers and reject subsequent opens

It doesn't mention that the port then stays unusable until the driver is
rebound.

>  	nixge_device_reset(ndev);
>  
>  	phy = of_phy_connect(ndev, priv->phy_node,

[Severity: Medium]
This isn't a bug introduced by this patch, but the error paths in
nixge_open() leave the DMA engine running and leak the rings.

nixge_device_reset()->nixge_hw_dma_bd_init() allocates the TX/RX BD rings,
maps the RX skbs, enables XAXIDMA_IRQ_ALL_MASK and sets RUNSTOP on both
channels. If of_phy_connect() then fails:

	if (!phy)
		return -ENODEV;

If request_irq() fails, the err_rx_irq/err_tx_irq labels only free the
other IRQ, disable NAPI, disconnect the PHY and kill the tasklet.

Neither path clears RUNSTOP, resets the DMA or calls
nixge_hw_dma_bd_release(). nixge_stop() is not called after a failed open.

On the next open, nixge_device_reset() still ignores the reset results.
nixge_hw_dma_bd_init() then overwrites priv->tx_bd_v, priv->tx_skb and
priv->rx_bd_v.

Doesn't that leak the old rings and RX skbs? If that reset timed out,
wouldn't DMA also still be pointed at them? A nixge_remove() after a failed
open also calls free_netdev() with RUNSTOP still set.

[ ... ]

> @@ -933,6 +942,23 @@ static int nixge_stop(struct net_device *ndev)
>  
>  	tasklet_kill(&priv->dma_err_tasklet);
>  
> +	/* Error recovery may have restarted DMA and enabled interrupts. */
> +	cr = nixge_dma_read_reg(priv, XAXIDMA_RX_CR_OFFSET);
> +	nixge_dma_write_reg(priv, XAXIDMA_RX_CR_OFFSET,
> +			    cr & ~(XAXIDMA_CR_RUNSTOP_MASK | XAXIDMA_IRQ_ALL_MASK));
> +	cr = nixge_dma_read_reg(priv, XAXIDMA_TX_CR_OFFSET);
> +	nixge_dma_write_reg(priv, XAXIDMA_TX_CR_OFFSET,
> +			    cr & ~(XAXIDMA_CR_RUNSTOP_MASK | XAXIDMA_IRQ_ALL_MASK));
> +
> +	/* Either channel's reset quiesces the entire AXI DMA engine. */
> +	ret = __nixge_device_reset(priv, XAXIDMA_TX_CR_OFFSET);

[Severity: High]
Does this checked reset come too late to protect the TX buffers?

Suppose a DMA error interrupt scheduled recovery before free_irq(). The
tasklet_kill() above then waits for nixge_dma_err_handler() to finish. That
handler does its own reset and drops both results:

	__nixge_device_reset(lp, XAXIDMA_TX_CR_OFFSET);
	__nixge_device_reset(lp, XAXIDMA_RX_CR_OFFSET);

	for (i = 0; i < TX_BD_NUM; i++) {
		cur_p = &lp->tx_bd_v[i];
		tx_skb = &lp->tx_skb[i];
		nixge_tx_skb_unmap(lp, tx_skb);

nixge_tx_skb_unmap() does dma_unmap_single()/dma_unmap_page() and
dev_kfree_skb_any(). The handler then rewrites CDESC/TDESC and sets
XAXIDMA_IRQ_ALL_MASK and RUNSTOP on both channels.

So the sequence is:

nixge_stop()
  free_irq()
  tasklet_kill()
    nixge_dma_err_handler()
      __nixge_device_reset()   <- times out, result ignored
      nixge_tx_skb_unmap()     <- unmaps and frees in-flight TX skbs
  __nixge_device_reset()       <- result checked only here
    priv->dma_stop_failed = true

If the tasklet's reset timed out, the TX buffers are already unmapped and
freed while the engine may still be reading them. Setting dma_stop_failed
afterwards can't undo that.

The open path has the same gap. nixge_device_reset() ignores both reset
results. nixge_hw_dma_bd_init() then installs new ring pointers and sets
RUNSTOP on an engine that may still be in reset.

Should nixge_dma_err_handler() and nixge_device_reset() also check the new
return value of __nixge_device_reset(), and skip releasing or re-arming on
failure?

> +	if (ret) {
> +		/* Retain DMA buffers and prevent a subsequent open replacing them. */
> +		priv->dma_stop_failed = true;
> +		netdev_err(ndev, "DMA stop failed; retaining DMA buffers\n");
> +		return ret;

[Severity: Low]
Does this return value reach anyone? __dev_close_many() ignores the
ndo_stop() result and marks the device down anyway:

		if (ops->ndo_stop)
			ops->ndo_stop(dev);

		netif_rx_mode_cancel_retry(dev);
		netif_set_up(dev, false);

So "ip link set down" appears to succeed. The only signs of the failure are
the dmesg line and a later -EIO from nixge_open().

Documentation/networking/driver.rst also requires that after ndo_stop the
hardware no longer receives or transmits data. This branch can't guarantee
that or report it.

> +	}
> +
>  	nixge_hw_dma_bd_release(ndev);

[Severity: High]
This is a pre-existing issue, but can nixge_hw_dma_bd_release() free the
rings twice?

It frees the RX skbs, rx_bd_v, tx_skb and tx_bd_v, but never resets
priv->rx_bd_v, priv->tx_skb or priv->tx_bd_v to NULL.

Take a normal open/stop cycle, followed by an open where
nixge_hw_dma_bd_init() fails its first allocation:

	priv->tx_bd_v = dma_alloc_coherent(ndev->dev.parent,
					   sizeof(*priv->tx_bd_v) * TX_BD_NUM,
					   &priv->tx_bd_p, GFP_KERNEL);
	if (!priv->tx_bd_v)
		goto out;

The out label calls nixge_hw_dma_bd_release() while priv->rx_bd_v and
priv->tx_skb still hold stale pointers. Wouldn't that walk freed coherent
memory and dma_unmap_single() stale addresses? It would also
dev_kfree_skb() skbs that are already freed, and dma_free_coherent()/
devm_kfree() the same buffers again.

If a later allocation in nixge_hw_dma_bd_init() fails instead, the out path
frees the rings but leaves the pointers set. nixge_device_reset() only logs
the failure:

	if (nixge_hw_dma_bd_init(ndev))
		netdev_err(ndev, "%s: descriptor allocation failed\n",
			   __func__);

nixge_open() then carries on, nixge_start_xmit() uses the freed
tx_bd_v/tx_skb, and this unconditional nixge_hw_dma_bd_release() frees
everything a second time.

[Severity: Medium]
This also wasn't introduced by this patch, but does nixge_stop() leak the
in-flight TX skbs and their DMA mappings?

nixge_hw_dma_bd_release() never walks priv->tx_skb[]. It only does:

	if (priv->tx_skb)
		devm_kfree(ndev->dev.parent, priv->tx_skb);

Only nixge_start_xmit_done() (from the TX IRQ) and the error tasklet call
nixge_tx_skb_unmap(). By this point the IRQ handlers are freed, the tasklet
is drained and the engine has been reset. Frames that were queued but not
yet completed are therefore never unmapped or freed.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018020840.3851552-1-mhun512%40gmail.com
