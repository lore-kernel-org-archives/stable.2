Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F3A325495;
	Tue, 29 Sep 2026 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687714; cv=none; b=tRrJoQLBz7Q9NNfcprJe/Wk2f8DjEq73mCBB2BuILySkN25r8NsoajhuUsoeeEd7YhYakuLnk6ur0kFZcIWtA2NrVFISul5Q9C157iqZXoRGEphb6xID3r8Et7eV+kwF/XnZ+vmnetgU3LNQ5REHhk5rh0voNTCXg3e6bUln0bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687714; c=relaxed/simple;
	bh=aoIuFFo7gc2k0Uz9ne5lIdpH2hF7oBBHJHcieb2Hihw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kc5y7RbSu9AjTdWeCOVhkCq6+AfN5LtnUPeAeNtDjMMtEX/Y5JvqQxBmBw6sGatCaivfWVyMcCNhVU7Xi4/kUcS0xjwPBc6C5ecctrlIULNjZsgCfdIMhpkymgIpPcQ3U0hPdt4cuRK3gWfBzHueRXy6k1+zzB4AmxvUK8NULsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csdDFOw4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csdDFOw4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C2C1F000FF;
	Tue, 29 Sep 2026 13:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790687713;
	bh=lSavdoFmy+Kb3PHSTLm5nJg+pSYQg3yA9X70sBZTBNA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=csdDFOw4YwZIYlQPaYQeZOB1GIJJGXyehrwM9aZ2l70QwGWw8+SGql4ToF+Tw//Ik
	 GFUH6+eNrsNBlJJfFrtjfOrSEgGqSaXSEDAlBXqL4fauCx+qqAMrfSbDWUpKkahrVK
	 +ja673MDeJHy5UE+w3Zt/T4oFu8dfrwu2eGjyJbPtKR3KtgKykXxKKNaCToFrRWqKv
	 2DyY5P5AP/t3nR2d0UMPKlDs/RiyixcBiELCOi2xhrzZhLadffDqZk0DJprrM55HHZ
	 WgyLsjs3llhOmrwr8+U+8vRV0N8tTJnO/lB7BYDxB9IUtw0UfYB8FIo/28D7cHlip+
	 oG+yp/4709qJQ==
Subject: Re: [PATCH net] net: macb: init workqueues before register_netdev()
From: netdev-bot+sashiko@kernel.org
To: theo.lebrun@bootlin.com
Cc: conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, nb@tipi-net.de,
 vladimir.kondratiev@mobileye.com, gregory.clement@bootlin.com,
 thomas.petazzoni@bootlin.com, stable@vger.kernel.org, sashiko@sashiko.dev
Date: Tue, 29 Sep 2026 13:15:11 +0000
Message-ID: <179068771181.434549.17825924833749424287@kernel.org>
In-Reply-To:
 <20260925-macb-netdev-register-race-v1-1-752f90ce1c39@bootlin.com>
References: <20260925-macb-netdev-register-race-v1-1-752f90ce1c39@bootlin.com>
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

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The Fixes tag points at the wrong commit.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but macb_close()
  never cancels or flushes bp->hresp_err_bh_work before it resets the…
- [High] This problem wasn't introduced by this patch, but macb_init()
  requests each queue IRQ with `devm_request_irq(&pdev->dev, queue->irq,…

--

net: macb: init workqueues before register_netdev()

This patch moves the INIT_WORK() for hresp_err_bh_work and the
INIT_DELAYED_WORK() for tx_lpi_work in macb_probe() ahead of
register_netdev(). Both work items are then initialised before the
interface becomes visible to userspace.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918-macb-close-v1-0-05e32ce98813%40bootlin.com
Link: https://lore.kernel.org/netdev/179010942347.2160803.5970158668197373074@kernel.org/

> Theoretical bugfix. The main reason for fix is to avoid future Sashiko
> reports which triggers if we grow the race condition (by touching those
> workqueues at open for example). The likeliness of this bug sounds
> tiny, but I've not spent any time trying to reproduce it.
>
> Fixes: c5092ba3155e ("net: macb: Convert tasklet API to new bottom half workqueue mechanism")
> Cc: stable@vger.kernel.org

[Severity: Medium]
Does the Fixes tag point at the right commit? In macb_probe(),
c5092ba3155e only swapped tasklet_setup() on hresp_err_tasklet for
INIT_WORK() on hresp_err_bh_work. The call was already after
register_netdev() and stayed there.

The HRESP handler has been set up after register_netdev() since
032dc41ba6e2 ("net: macb: Handle HRESP error"). That commit added
tasklet_init() right after the register_netdev() error check, and added
tasklet_schedule() in macb_interrupt() at the same time.

The tx_lpi_work half, which the commit message names, comes from
0cc425f18f59 ("net: cadence: macb: implement EEE TX LPI support").

With Cc: stable, the Fixes tag decides where this lands. Older LTS trees
that have the tasklet version of the same ordering would not get the fix.
In those trees, a zeroed tasklet could reach t->func(t->data) with a NULL
func, or tasklet_init() could re-initialise a tasklet that is already
queued.

Trees that have c5092ba3155e but not 0cc425f18f59 would also get a hunk
that moves an INIT_DELAYED_WORK(&bp->tx_lpi_work, ...) line they don't
have.

Would Fixes: 032dc41ba6e2 for the HRESP work plus Fixes: 0cc425f18f59 for
the LPI work be more accurate? Alternatively, could the message say which
trees it is meant to cover?

The message also describes this as a theoretical fix that hasn't been
reproduced, meant mainly to avoid future Sashiko reports. The stable kernel
rules usually don't accept theoretical races unless a trigger is described.
Is the Cc: stable intended?

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 8e5c034dc3a48..76260b97a07b6 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -5968,15 +5968,15 @@ static int macb_probe(struct platform_device *pdev)
>  	if (err)
>  		goto err_out_unregister_mdio;
>  
> +	INIT_WORK(&bp->hresp_err_bh_work, macb_hresp_error_task);

[Severity: High]
This isn't a bug introduced by this patch, but it concerns the same work
item: does macb_close() wait for hresp_err_bh_work before it frees the
rings?

macb_close() only cancels tx_lpi_work:

macb_close() {
    ...
	cancel_delayed_work_sync(&bp->tx_lpi_work);
    ...
	spin_lock_irqsave(&bp->lock, flags);
	macb_reset_hw(bp);
	netif_carrier_off(netdev);
	spin_unlock_irqrestore(&bp->lock, flags);

	macb_free(bp);
    ...
}

Suppose an HRESP interrupt arrives just before dev_close() clears
__LINK_STATE_START. macb_interrupt_misc() then does:

	queue_work(system_bh_wq, &bp->hresp_err_bh_work);

macb_hresp_error_task() takes no lock and does not check netif_running().
If it runs during or after macb_free(), it does this:

	bp->macbgem_ops.mog_init_rings(bp);

	/* Initialize TX and RX buffers */
	macb_init_buffers(bp);

By then macb_free() has already released the descriptor rings with
dma_free_coherent(). The task then sets RE/TE and IER again, and calls
netif_carrier_on() and netif_tx_start_all_queues() on a closed device.

Can this write into the freed DMA descriptor memory, and restart DMA with
the controller's queue pointers still pointing at it?

dev_deactivate_many() calls synchronize_net() only when sync_needed is set.
With a noqueue root qdisc there is no grace period at all. Even with
synchronize_net(), a BH work that is queued but hasn't started yet is not
waited for (softirq deferred to ksoftirqd, threadirqs, PREEMPT_RT).

The only cancel_work_sync() for this work is in macb_remove(). It runs
after unregister_netdev() has already gone through macb_close() and
macb_free(), so the remove path has the same window:

macb_remove() {
    ...
	unregister_netdev(netdev);
    ...
	cancel_work_sync(&bp->hresp_err_bh_work);
    ...
}

> +	INIT_DELAYED_WORK(&bp->tx_lpi_work, macb_tx_lpi_work_fn);
> +
>  	err = register_netdev(netdev);
>  	if (err) {
>  		dev_err(&pdev->dev, "Cannot register net device, aborting.\n");
>  		goto err_out_free_tieoff;
>  	}

[Severity: High]
This is a pre-existing issue, but the err_out_free_tieoff path ends in
free_netdev() while the queue IRQs requested by macb_init() are still
registered. Can macb_interrupt() then run with a dev_id that has been
freed?

macb_init() requests each queue IRQ as a devm-managed shared IRQ, with a
dev_id inside netdev_priv():

	err = devm_request_irq(&pdev->dev, queue->irq, macb_interrupt,
			       IRQF_SHARED, netdev->name, queue);

Here queue is &bp->queues[q]. Devres releases the IRQs only after probe or
remove returns. Before that, free_netdev() runs on two kinds of paths:

  - the probe error labels after macb_init(): err_out_phy_exit and
    err_out_free_netdev, plus err_out_free_tieoff, which falls through to
    them
  - macb_remove()

With CONFIG_DEBUG_SHIRQ, __free_irq() calls the handler for IRQF_SHARED
actions:

	action->handler(irq, dev_id);

The first thing macb_interrupt() does is queue_readl(queue, ISR), which
expands to:

	(queue)->bp->macb_reg_readl((queue)->bp, (queue)->reg)

That is an indirect call through a function pointer loaded from freed
memory.

Without DEBUG_SHIRQ, the same can happen if another device on the shared
line raises an interrupt in that window. If ISR reads as non-zero,
spin_lock(&bp->lock) also writes into freed memory.

Should the IRQs be freed or disabled on these paths before free_netdev(),
for example with devm_free_irq()?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925-macb-netdev-register-race-v1-1-752f90ce1c39%40bootlin.com
