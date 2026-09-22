Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB3A4BD365;
	Tue, 22 Sep 2026 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109480; cv=none; b=KBWnZefRIsUQp1MaZMyKSFRqydLZIDUzVY96psdJUxyCRSRwkg9vV/+DDfWnyVKuruNQRQmu/UAvdwRZpQCcWrjICOqL1CIqsl8uuT2qj9qc4GFxKPs7LuiDkorOg3WeoHqpi006QAij+6JRb0pa+BhAUr4+aOyB9glUclBiShg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109480; c=relaxed/simple;
	bh=kjpw4SxdqzSCXxTXP/7WjWB9WM1yZBrTdsPjT6zL1/A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m4g+R9Lrvw0VbwWoAN9wGRnOw/yx5atMF3hTVu0/mezf2ZoU+sgQk+h0R68TWQEKMPIp9yxF8BR13Kf17qRp21bKTCBJS8tgQokqjhQuSew1QllqQWZit9fnF4HvERZkuROS+v0urrxQvghgySum65qMXI/4tGl/zvkEL67nAnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZP51kpEv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZP51kpEv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4D11F0089F;
	Tue, 22 Sep 2026 20:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790109424;
	bh=PZv3/R7eGwsuzZi6fMOAF2FdovspvlwnVzvxXecbV6g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZP51kpEv28LdkCwNxX24tDbQXN2WDoWddQvIx9kyg5o0NreP3OBVMTfKuPJiGN9Ad
	 49qS6OVsre+dUyjRUuxdp5LCtmfmMNd7uUKB+vhMERSdXb/kppKasKj5YDrCoWyIJL
	 rxNSoGP7mm/PnLxyw5voro3Ka4wXTjA27Y1cEjTPzIcs+D6gwJJts6s5C0q5DGiEpE
	 7LRqirSkEfSV6NljnfWS5SZju9KY+QtgoE8qc0IqcQ51YH/mJ9CAA8QxaqvnFEVgHk
	 5qoGoeeMmLI4dqZUmMhQoWvH70x4C61kuKeh8CqOE4dfrbY2g2kfY6cTbzhDGoh74n
	 iEcG+4FJzVjMQ==
Subject:
 Re: [PATCH net 3/3] net: macb: quiesce IRQs and drain BH on interface close
From: netdev-bot+sashiko@kernel.org
To: theo.lebrun@bootlin.com
Cc: conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 nicolas.ferre@microchip.com, sean.anderson@linux.dev, atenart@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 nb@tipi-net.de, vladimir.kondratiev@mobileye.com, gregory.clement@bootlin.com,
 tawfik.bayouk@mobileye.com, thomas.petazzoni@bootlin.com,
 maxime.chevallier@bootlin.com, stable@vger.kernel.org
Date: Tue, 22 Sep 2026 20:37:03 +0000
Message-ID: <179010942347.2160803.5970158668197373074@kernel.org>
In-Reply-To: <20260918-macb-close-v1-3-05e32ce98813@bootlin.com>
References: <20260918-macb-close-v1-3-05e32ce98813@bootlin.com>
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

Critical: 0 · High: 0 (2) · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] macb_close() now calls macb_quiesce_start() (synchronize_irq()
  on every queue IRQ, cancel_work_sync(&bp->hresp_err_bh_work),…

Pre-existing issues:
- [High] macb_suspend()/macb_resume() still open-code the per-queue
  napi_disable()/napi_enable() loops without setting/clearing…
- [High] macb_set_ringparam() calls macb_close() and then macb_open()
  while discarding macb_open()'s return value and always returning 0.
- [Medium] bp->hresp_err_bh_work and bp->tx_lpi_work are initialized by
  INIT_WORK()/INIT_DELAYED_WORK() only *after* register_netdev() in…

--

net: macb: quiesce IRQs and drain BH on interface close

This adds macb_quiesce_start()/macb_quiesce_end() helpers plus a new
bp->irq_quiesced flag so that macb_interrupt() self-disarms while the
interface is down, and reorders macb_close() to drain IRQs, the two work
items, NAPI and the LPI delayed work in a defined order. macb_open() uses
the same helpers on its success and error paths.

A few questions below.

> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index cfaa0ca49f1a..1cb2778fe49e 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -1382,6 +1382,11 @@ struct macb {
>  	struct delayed_work	tx_lpi_work;
>  	u32			tx_lpi_timer;
>  
> +	/* ISR must not drive NAPI & BH mechanisms. True when the interface
> +	 * is closed. Protected by bp->lock.
> +	 */
> +	bool			irq_quiesced;
> +
>  	int	rx_bd_rd_prefetch;
>  	int	tx_bd_rd_prefetch;
>  
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index c418f859cc34..75bbde81d62c 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1995,6 +1995,53 @@ static int macb_tx_poll(struct napi_struct *napi, int budget)
>  	return work_done;
>  }
>  
> +static void macb_quiesce_start(struct macb *bp)
> +{
> +	struct macb_queue *queue;
> +	unsigned long flags;
> +	unsigned int q;
> +
> +	spin_lock_irqsave(&bp->lock, flags);
> +	bp->irq_quiesced = true;
> +	spin_unlock_irqrestore(&bp->lock, flags);
> +
> +	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
> +		synchronize_irq(queue->irq);
> +
> +	cancel_work_sync(&bp->hresp_err_bh_work);

[Severity: Medium]
This isn't a bug introduced by this patch, but can this cancel_work_sync()
run on a work_struct that has not been initialized yet?

In macb_probe(), register_netdev() happens before the two work items are
set up:

	err = register_netdev(netdev);
	if (err) {
		dev_err(&pdev->dev, "Cannot register net device, aborting.\n");
		goto err_out_free_tieoff;
	}

	INIT_WORK(&bp->hresp_err_bh_work, macb_hresp_error_task);
	INIT_DELAYED_WORK(&bp->tx_lpi_work, macb_tx_lpi_work_fn);

The queue IRQ handlers were already installed earlier by
macb_init_dflt()'s devm_request_irq(..., macb_interrupt, ...), and
register_netdev() publishes the device, so an 'ip link set up' racing with
the tail of probe can reach macb_open() -> macb_quiesce_end(), which clears
bp->irq_quiesced. From there an HRESP interrupt would let
macb_interrupt_misc() do queue_work(system_bh_wq, &bp->hresp_err_bh_work)
on a zeroed work_struct whose ->func is NULL, and macb_close() or the
macb_open() error path would call cancel_work_sync() /
cancel_delayed_work_sync() on the same uninitialized objects.

The pre-existing macb_close() already had the cancel_delayed_work_sync() on
bp->tx_lpi_work, so this only widens an existing window. Would moving both
INIT_WORK()/INIT_DELAYED_WORK() calls ahead of macb_init()/register_netdev()
be reasonable?

> +
> +	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> +		/* Must be done before NAPI is disabled: the task ends with a
> +		 * napi_enable() call.
> +		 */
> +		cancel_work_sync(&queue->tx_error_task);
> +
> +		napi_disable(&queue->napi_rx);
> +		napi_disable(&queue->napi_tx);
> +	}
> +
> +	/* Must be done after napi_tx is disabled: its completion re-arms
> +	 * the LPI timer.
> +	 */
> +	cancel_delayed_work_sync(&bp->tx_lpi_work);
> +}
> +
> +static void macb_quiesce_end(struct macb *bp)
> +{
> +	struct macb_queue *queue;
> +	unsigned long flags;
> +	unsigned int q;
> +
> +	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> +		napi_enable(&queue->napi_rx);
> +		napi_enable(&queue->napi_tx);
> +	}
> +
> +	spin_lock_irqsave(&bp->lock, flags);
> +	bp->irq_quiesced = false;
> +	spin_unlock_irqrestore(&bp->lock, flags);
> +}
> +
>  static void macb_hresp_error_task(struct work_struct *work)
>  {
>  	struct macb *bp = from_work(bp, work, hresp_err_bh_work);
> @@ -2137,8 +2184,8 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
>  	spin_lock(&bp->lock);
>  
>  	while (status) {
> -		/* close possible race with dev_close */
> -		if (unlikely(!netif_running(netdev))) {
> +		/* self-disarm while the netdev is closed */
> +		if (unlikely(bp->irq_quiesced)) {
>  			queue_writel(queue, IDR, -1);
>  			macb_queue_isr_clear(bp, queue, -1);
>  			break;

[Severity: High]
This is a pre-existing issue, but does the new gating condition need a
companion change in macb_suspend()/macb_resume()?

macb_suspend() still open-codes the NAPI loop, with no bp->irq_quiesced
update, no synchronize_irq() and no draining of queue->tx_error_task or
bp->hresp_err_bh_work:

	netif_device_detach(netdev);
	for (q = 0, queue = bp->queues; q < bp->num_queues;
	     ++q, ++queue) {
		napi_disable(&queue->napi_rx);
		napi_disable(&queue->napi_tx);
	}

	if (!(bp->wol & MACB_WOL_ENABLED)) {
		rtnl_lock();
		phylink_stop(bp->phylink);
		rtnl_unlock();
		...
		macb_reset_hw(bp);

In the non-WOL path the interrupt enables left by macb_mac_link_up()
(bp->rx_intr_mask | MACB_TX_INT_FLAGS | MACB_BIT(HRESP)) are still unmasked
until that later macb_reset_hw(), and netif_device_detach() does not affect
netif_running(), so the ISR stays armed with bp->irq_quiesced == false.

A TX error interrupt in that window reaches macb_interrupt_misc():

	if (unlikely(status & (MACB_TX_ERR_FLAGS))) {
		queue_writel(queue, IDR, MACB_TX_INT_FLAGS);
		schedule_work(&queue->tx_error_task);

and macb_tx_error_task() begins with napi_disable(&queue->napi_tx) on a NAPI
that macb_suspend() already disabled. napi_disable_locked() then never
returns:

net/core/dev.c:napi_disable_locked() {
	...
		while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
			usleep_range(20, 200);
			val = READ_ONCE(n->state);
		}
	...
}

The worker wedges holding the netdev instance lock, so macb_resume()'s
napi_enable() blocks as well. The same window lets macb_hresp_error_task()
re-init every ring and rewrite IER/NCR/carrier behind suspend's back.

The new comment says "ISR must not drive NAPI & BH mechanisms. True when
the interface is closed.", and the commit message lists suspend/WOL as
future work ("we'll reuse that flag in suspend/WOL, set_ringparam and
change_mtu"). Given that the old netif_running() check is now gone, should
macb_suspend()/macb_resume() switch to macb_quiesce_start()/
macb_quiesce_end() in this patch rather than later?

> @@ -3155,8 +3202,6 @@ static int macb_open(struct net_device *netdev)
>  {
>  	size_t bufsz = netdev->mtu + ETH_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;
>  	struct macb *bp = netdev_priv(netdev);
> -	struct macb_queue *queue;
> -	unsigned int q;
>  	int err;
>  
>  	netdev_dbg(bp->netdev, "open\n");
> @@ -3180,10 +3225,7 @@ static int macb_open(struct net_device *netdev)
>  		goto free_rings;
>  	macb_init_buffers(bp);
>  
> -	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> -		napi_enable(&queue->napi_rx);
> -		napi_enable(&queue->napi_tx);
> -	}
> +	macb_quiesce_end(bp);
>  
>  	macb_init_hw(bp);
>  
> @@ -3210,11 +3252,10 @@ static int macb_open(struct net_device *netdev)
>  	phy_power_off(bp->phy);
>  
>  reset_hw:
> +	/* The netdev stays down: quiesce and drain, as macb_close() does. */
> +	macb_quiesce_start(bp);
> +
>  	macb_reset_hw(bp);
> -	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> -		napi_disable(&queue->napi_rx);
> -		napi_disable(&queue->napi_tx);
> -	}
>  free_rings:
>  	macb_free(bp);
>  pm_exit:

[Severity: High]
This is a pre-existing issue, but does the new reset_hw path make the
macb_set_ringparam() failure case worse?

macb_set_ringparam() drops the macb_open() return value entirely:

	if (netif_running(bp->netdev)) {
		reset = 1;
		macb_close(bp->netdev);
	}

	bp->rx_ring_size = new_rx_size;
	bp->tx_ring_size = new_tx_size;

	if (reset)
		macb_open(bp->netdev);

	return 0;

Failures before macb_quiesce_end() (pm_runtime_resume_and_get(),
macb_alloc()'s dma_alloc_coherent(), mog_init_rings() RX skb allocation)
return with the NAPI instances still disabled from the preceding
macb_close(). Failures after it now take the reset_hw label, which calls
macb_quiesce_start() and disables them a second time.

Since this path bypasses dev_open()/dev_close(), netif_running() stays
true, so the next ndo_stop ('ip link set dev ethX down', another
ethtool -G, or macb_suspend()) re-enters macb_close() ->
macb_quiesce_start() -> napi_disable() on an already disabled NAPI, and
napi_disable_locked() spins forever with RTNL and the netdev instance lock
held.

Should macb_set_ringparam() propagate macb_open()'s error, and should
macb_quiesce_start()/macb_quiesce_end() be made robust against being
called twice in a row?

> @@ -3225,19 +3266,17 @@ static int macb_open(struct net_device *netdev)
>  static int macb_close(struct net_device *netdev)
>  {
>  	struct macb *bp = netdev_priv(netdev);
> -	struct macb_queue *queue;
>  	unsigned long flags;
>  	unsigned int q;
>  
> -	netif_tx_stop_all_queues(netdev);
> +	macb_quiesce_start(bp);
>  
> -	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> -		napi_disable(&queue->napi_rx);
> -		napi_disable(&queue->napi_tx);
> +	/* Drain the BH contexts before stopping the queues: NAPI completion
> +	 * and tx_error_task wake them up.
> +	 */
> +	netif_tx_stop_all_queues(netdev);
> +	for (q = 0; q < bp->num_queues; ++q)
>  		netdev_tx_reset_queue(netdev_get_tx_queue(netdev, q));
> -	}
> -
> -	cancel_delayed_work_sync(&bp->tx_lpi_work);

[Severity: Medium]
Moving netif_tx_stop_all_queues() after the whole quiesce sequence looks
fine for the ndo_stop path, where the core already ran
dev_deactivate_many() so no xmit can happen. Is it also safe for the direct
caller?

macb_set_ringparam() calls macb_close() with the netdev up and the qdisc
still live:

	if (netif_running(bp->netdev)) {
		reset = 1;
		macb_close(bp->netdev);
	}

In that path macb_start_xmit() remains callable for the whole
macb_quiesce_start() window (synchronize_irq() per queue,
cancel_work_sync() on hresp_err_bh_work and each tx_error_task,
two napi_disable() per queue, cancel_delayed_work_sync() on tx_lpi_work),
since ethtool only holds RTNL.

Two consequences I am unsure about:

Frames mapped into the TX ring and kicked with NCR.TSTART after napi_tx is
disabled and after macb_interrupt() started answering with
queue_writel(queue, IDR, -1) will never be reaped; they are dropped by
macb_free()'s unmap loop and only counted in queue->stats.tx_dropped.

An xmit landing after netdev_tx_reset_queue()'s dql_reset() calls
netdev_tx_sent_queue() for completions that are never accounted, since
macb_free() does no BQL accounting and macb_open() does not reset BQL
again, so dql->num_queued > num_completed persists across the resize. Can
that leave the queue XOFF-ed?

The commit message explains the new ordering as "Drain the BH contexts
before stopping the queues: NAPI completion and tx_error_task wake them
up", and the recap table only lists 'swap' as a future context. Would
keeping netif_tx_stop_all_queues() first, or converting
macb_set_ringparam() to dev_close()/dev_open() semantics, address this?

>  	phylink_stop(bp->phylink);
>  	phylink_disconnect_phy(bp->phylink);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918-macb-close-v1-0-05e32ce98813%40bootlin.com
