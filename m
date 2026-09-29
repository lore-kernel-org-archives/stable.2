Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C98392C3A;
	Tue, 29 Sep 2026 02:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790647265; cv=none; b=RHkIymB63UHH2fNPCOl+OdcmsURKZppyTfIvfCO25GO0WhbahsQ2Y+wLTzhWf82Qg+/dQteG4Rw5W7TXtS+klNNh7BS1hg/hBt1SRVKWaRkRmJKYCEbMdZ8esKf/EeJW2NNnBiJsz252k44ZoaqPwX193rX+hE4S1ZT4O9SLSf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790647265; c=relaxed/simple;
	bh=RCTQuE4F2aGMnkcpjYqcqy/zc44r0VWCD9wX/iIxS44=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=js+aOLwWC8ZRoZte+05So6ArX4aC/mbU4oWkBYWGESVPpAh/MCYMj7SOZi7g/sYLo2GDJamjQ5NfYBvL5A4H9YJbirkKf/CuHPogjGHak4XKOb2AA1QJEOhqRrsgkRkiBvQf3rUE6jTPIm7GjU1WT5wV13hbS9cp15QN58rbVPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b45IHmFY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b45IHmFY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4431D1F000FF;
	Tue, 29 Sep 2026 02:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790647263;
	bh=RA5QKocbe+ww7hQlp2se6ktybAyAo3VCbKapHFlHH5w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=b45IHmFYa1tuc5j1jVXbWxBceBAgb2hErenJw8uGrN87WhV7IAa2EZglBGeWXMy5g
	 2s3iDYveVa4aAKQHshOrma4aQ7KOVDNDc8sYL+jXquS5mzAGthuBm1vQNUdiCkulam
	 MhPUATLW8Fg8OuG0P/Sl2lJCJwTo6MCHHC5xkiJyOMPKANJxn/wWb7U7EdJ8xPj1Ig
	 0Io+RjjZFAGDEslqsYoG5wjOk6IRR3Q4G8dnSR5oXAey214X0Qt7d77IfP2jsT6yj3
	 MN/BjAEK7F7F5LU0kSUbC2PJib4fasjS+OSYmoas0hXhjt6twrpf6rksybA8m6ZjQ5
	 mf9OFcESyrfug==
Subject: Re: [PATCH net v2 3/3] net: macb: quiesce IRQs and drain BH on
 interface close
From: netdev-bot+sashiko@kernel.org
To: theo.lebrun@bootlin.com
Cc: conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sean.anderson@linux.dev,
 atenart@kernel.org, edumazet@kernel.org, nicolas.ferre@microchip.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 nb@tipi-net.de, vladimir.kondratiev@mobileye.com, gregory.clement@bootlin.com,
 tawfik.bayouk@mobileye.com, thomas.petazzoni@bootlin.com,
 maxime.chevallier@bootlin.com, stable@vger.kernel.org
Date: Tue, 29 Sep 2026 02:01:01 +0000
Message-ID: <179064726179.434549.12262058149502187159@kernel.org>
In-Reply-To: <20260925-macb-close-v2-3-360efa565914@bootlin.com>
References: <20260925-macb-close-v2-3-360efa565914@bootlin.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] macb_probe() initializes bp->hresp_err_bh_work and
  bp->tx_lpi_work (lines 6056-6057) only after register_netdev() (line…

Pre-existing issues:
- [High] The suspend path still has the same tx_error_task vs. NAPI
  deadlock that this patch fixes for close.
- [High] macb_set_ringparam()
  (drivers/net/ethernet/cadence/macb_main.c:3801-3812) calls…
- [High] macb_set_ringparam() (line 3803) calls macb_close() directly,
  holding only RTNL, so the core's…

--

net: macb: quiesce IRQs and drain BH on interface close

This patch adds an irq_quiesced flag. macb_interrupt() checks it and
disarms itself while the interface is closed. It also adds
macb_quiesce_start() and macb_quiesce_end(). macb_quiesce_start() drains
the IRQ handlers, hresp_err_bh_work, tx_error_task, NAPI and tx_lpi_work,
in that order. macb_close() and the macb_open() error path now use these
helpers.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 18a1b5f7ad916..1d6361c0d8bc9 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2009,6 +2009,53 @@ static int macb_tx_poll(struct napi_struct *napi, int budget)
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

[Severity: Low]
macb_probe() initializes these works only after register_netdev() has
returned:

drivers/net/ethernet/cadence/macb_main.c:macb_probe() {
    ...
	err = register_netdev(netdev);
	...
	INIT_WORK(&bp->hresp_err_bh_work, macb_hresp_error_task);
	INIT_DELAYED_WORK(&bp->tx_lpi_work, macb_tx_lpi_work_fn);
    ...
}

Userspace can open the interface inside that window, for example in
response to the registration uevent. Suppose the open then fails in
phy_set_mode_ext(), phy_power_on() or macb_phylink_connect(), or the
interface is closed right away. Can cancel_work_sync() here then trigger
the WARN_ON(!work->func) in __flush_work() on a work that is still
zeroed?

The close path already cancelled tx_lpi_work before this patch. The new
parts are the hresp_err_bh_work cancel and the cancels on the macb_open()
error path.

Would moving INIT_WORK() and INIT_DELAYED_WORK() before register_netdev(),
or into macb_init_dflt(), avoid this?

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

[Severity: High]
This is a pre-existing issue and was not introduced by this patch.
macb_suspend() still seems to have the same tx_error_task vs. NAPI
deadlock that this patch fixes for close. It disables NAPI without
setting irq_quiesced and without cancelling tx_error_task or
hresp_err_bh_work:

drivers/net/ethernet/cadence/macb_main.c:macb_suspend() {
    ...
	netif_device_detach(netdev);
	for (q = 0, queue = bp->queues; q < bp->num_queues;
	     ++q, ++queue) {
		napi_disable(&queue->napi_rx);
		napi_disable(&queue->napi_tx);
	}
    ...
}

In the non-WoL branch the IRQs are still unmasked at this point. On a TX
error, macb_interrupt()->macb_interrupt_misc() can still call
schedule_work(&queue->tx_error_task). On HRESP it can queue
hresp_err_bh_work.

In the WoL branch, a tx_error_task queued just before the IDR write can
also run after the napi_disable() calls.

macb_tx_error_task() then calls this on a NAPI that is already disabled:

	napi_disable(&queue->napi_tx);

Would that spin forever in napi_disable_locked() while holding
netdev_lock? macb_resume() then calls napi_enable(), which takes the same
netdev_lock, so it looks like resume would never complete.

The commit message says the flag will be reused for suspend/WOL, and the
patch is Cc: stable for this class of deadlock. Could macb_suspend() and
macb_resume() use macb_quiesce_start() and macb_quiesce_end() too?

[ ... ]

> @@ -3234,11 +3276,10 @@ static int macb_open(struct net_device *netdev)
>  	phy_power_off(bp->phy);
>  
>  reset_hw:
> +	/* The netdev stays down: quiesce and drain, as macb_close() does. */
> +	macb_quiesce_start(bp);

[Severity: High]
This isn't a bug introduced by this patch, but macb_set_ringparam() calls
macb_close() and macb_open() directly and ignores macb_open()'s return
value:

drivers/net/ethernet/cadence/macb_main.c:macb_set_ringparam() {
    ...
	if (netif_running(bp->netdev)) {
		reset = 1;
		macb_close(bp->netdev);
	}
    ...
	if (reset)
		macb_open(bp->netdev);

	return 0;
}

Every macb_open() failure path leaves NAPI disabled. The macb_alloc() and
mog_init_rings() failures jump past macb_quiesce_end(). The later failures
call macb_quiesce_start() here.

These paths also free the rings and drop the runtime PM reference, but
__LINK_STATE_START stays set. A large ring size can make macb_alloc() fail
under memory pressure, and ethtool -G still reports success.

A later ip link set down, or another ethtool -G, calls
macb_close()->macb_quiesce_start() again. Does napi_disable() then wait
forever in napi_disable_locked() with RTNL held? If that step were somehow
passed, would macb_free() and pm_runtime_put() run a second time?

This also doesn't match the new comments. They describe irq_quiesced as
"True when the interface is closed" and say it is "cleared by macb_open()
and re-armed by macb_close()".

> +
>  	macb_reset_hw(bp);
> -	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> -		napi_disable(&queue->napi_rx);
> -		napi_disable(&queue->napi_tx);
> -	}
>  free_rings:
>  	macb_free(bp);
>  pm_exit:
> @@ -3249,19 +3290,17 @@ static int macb_open(struct net_device *netdev)
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

[Severity: High]
This is a pre-existing issue, but it is about draining contexts before
teardown. macb_set_ringparam() calls macb_close() directly under RTNL, so
the core's dev_deactivate_many()/synchronize_net() never runs to drain an
ndo_start_xmit that is already in flight.

netif_tx_stop_all_queues() only sets the XOFF bits. It doesn't take the
xmit lock, and it doesn't wait for a macb_start_xmit() that has already
passed the queue-stopped check.

macb_start_xmit() writes queue->tx_skb and the TX descriptors under
queue->tx_ptr_lock. Neither macb_close() nor macb_free() takes that lock
before this:

drivers/net/ethernet/cadence/macb_main.c:macb_free() {
    ...
			kfree(queue->tx_skb);
			queue->tx_skb = NULL;
    ...
}

The same applies to the dma_free_coherent() of the TX ring.

Can an xmit that is still running during ethtool -G then write into the
freed tx_skb array or the freed TX ring? This seems more likely on
PREEMPT_RT, where the xmit path and tx_ptr_lock can be preempted.

Would netif_tx_disable() or an explicit synchronize_net() here close this
window?

> +	for (q = 0; q < bp->num_queues; ++q)
>  		netdev_tx_reset_queue(netdev_get_tx_queue(netdev, q));

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925-macb-close-v2-0-360efa565914%40bootlin.com
