Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF5D3D5253;
	Tue, 29 Sep 2026 02:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790647264; cv=none; b=R7W7Xn5wqZQRkGQmFHiN/uTDZKqfOphpKJmy30fCSSG3bEh8kwbhcQd/cdVZVnn8F5NPfBNrjsvAZ4vyKLkpubLo5wfvuKvi4y79A1+8i+LD6i+4td6UNIAovphLIUaFKR2+6SbzKBWmkplOGQpss9yxpv/45xmXvOke7OAx+A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790647264; c=relaxed/simple;
	bh=vhveI+VpM2M5EjkEy180JUJaGCKmCcsnhwDz89B4Ivg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JBPxpaILx+5xoxNA2NEAPJgewDp8hPDvNHVJZOdQoTTsH22tK9tb8kIWon9rDkaL2bkkJCOzs+wfCPhPrYBTMudnqFdQKV7KAC+HF55CvrGS5lem5URK+xQil9EaH/y+xLCpDWoQeNnSdGtUHX0vuXQXV0JLOyY2E5Kjo85Vkuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ma5UCy7p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ma5UCy7p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E231F00893;
	Tue, 29 Sep 2026 02:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790647261;
	bh=IdrgE2AwpocAuSQ9pWRMKupK+ZBkH4Q9c26cS1NFTSY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ma5UCy7p+cYo8Mop2plNl00cuj2LJ4/CZKM3ix3hjQdk8frovQvq63YgNJ1FS1+Co
	 +2RHpn/BL3gkhiRViFkGcSy4o3WjhxecnC1euDldtpdz6KOpPRBeU7rWeD5/kjwGcl
	 vfTUHEb1mSorqn2vTopWMqbneqXvib56jHc2Om64c/ZCN4k8H2yMlVPoANMguRjxtN
	 jmJ98n6r05WPudclKlxtMS/TlfY33Dnu0WmrtWJU8Cmem1aDr97/+CVCW9NbA8VRfH
	 8Mztn6GLOjqxIiIqfgh0X26aBgkyGefpYFe682if0DPjam0+N52sgPTEnRD3lHcBG3
	 fQOnunnQqZSAQ==
Subject: Re: [PATCH net v2 2/3] net: macb: propagate RX ring refill errors
From: netdev-bot+sashiko@kernel.org
To: theo.lebrun@bootlin.com
Cc: conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sean.anderson@linux.dev,
 atenart@kernel.org, edumazet@kernel.org, nicolas.ferre@microchip.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 nb@tipi-net.de, vladimir.kondratiev@mobileye.com, gregory.clement@bootlin.com,
 tawfik.bayouk@mobileye.com, thomas.petazzoni@bootlin.com,
 maxime.chevallier@bootlin.com, stable@vger.kernel.org
Date: Tue, 29 Sep 2026 02:00:59 +0000
Message-ID: <179064725991.434549.9604367757264555991@kernel.org>
In-Reply-To: <20260925-macb-close-v2-2-360efa565914@bootlin.com>
References: <20260925-macb-close-v2-2-360efa565914@bootlin.com>
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

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch adds a failure path to macb_open(): if
  mog_init_rings() (gem_init_rings()) finds any queue with zero prepared…
- [Medium] The patch treats a GEM RX queue with zero prepared descriptors
  as unrecoverable.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  macb_hresp_error_task() re-initialises every RX ring with no exclusion…

--

net: macb: propagate RX ring refill errors

This commit changes gem_rx_refill(), gem_init_rx_ring(), gem_init_rings(),
macb_init_rings() and the mog_init_rings op so they return errno-style ints.
gem_rx_refill() now returns -ENOMEM when a queue ends up with zero prepared
RX descriptors, and macb_open() fails in that case. The other refill callers
(resume, the HRESP error task and NAPI) still ignore the result.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 7f25574928d71..18a1b5f7ad916 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

[ ... ]

> @@ -1558,6 +1558,14 @@ static void gem_rx_refill(struct macb_queue *queue)
>  
>  	netdev_vdbg(bp->netdev, "rx ring: queue: %p, prepared head %d, tail %d\n",
>  		    queue, queue->rx_prepared_head, queue->rx_tail);
> +
> +	/* Fail if queue has zero prepared descriptors. This is critical because
> +	 * nothing will ever trigger a refill again.
> +	 */
> +	if (queue->rx_prepared_head == queue->rx_tail)
> +		return -ENOMEM;
> +
> +	return 0;
>  }

[Severity: Medium]

This comment says a queue with zero prepared descriptors can never be
refilled. What happens when the other callers reach that state? Only
macb_open() checks the new return value. The other three paths drop it:

gem_rx()
    gem_rx_refill(queue);

macb_hresp_error_task()
    bp->macbgem_ops.mog_init_rings(bp);

macb_resume()
    if (macb_is_gem(bp))
        gem_init_rx_ring(queue);

gem_init_rx_ring() resets rx_tail and rx_prepared_head to 0 and sets RX_USED
on every descriptor. gem_rx_refill() stops at the first failed
netdev_alloc_skb() or dma_map_single(). So resume and HRESP recovery end up
with zero armed descriptors whenever slot 0 has no skb and its allocation
fails.

In the NAPI path, gem_rx() can drain up to rx_prepared_head, and then the
end-of-poll refill can fail on the first empty slot.

Once there, macb_rx_pending() returns early:

    if (macb_is_gem(bp) && queue->rx_tail == queue->rx_prepared_head)
        return false;

That means macb_rx_poll() does not reschedule NAPI. RCOMP also cannot fire
while every descriptor is software-owned. On top of that,
macb_hresp_error_task() goes on to set NCR.RE|TE and call
netif_carrier_on() and netif_tx_start_all_queues() on that ring.

The commit message says:

  "Note that other callers of refill (resume, HRESP error task, NAPI)
   cannot do anything useful with that error and keep their best-effort
   refill, hoping it will improve."

Doesn't the new comment say the opposite, that nothing will trigger another
refill? Would the queue then stay dead until the interface is taken down and
brought back up, while carrier and TX still report up? On a single-queue GEM
that would be all RX.

One caveat: ISR_ROVR is part of rx_intr_mask, and macb_interrupt() schedules
napi_rx on it. If the hardware raises receive-overrun while no descriptors
are available, NAPI would run and retry the refill, which would contradict
the new comment. The code alone doesn't settle this.

[ ... ]

> @@ -2814,14 +2822,16 @@ static void gem_init_rx_ring(struct macb_queue *queue)
>  	for (i = 0; i < queue->bp->rx_ring_size; i++)
>  		macb_rx_desc(queue, i)->addr |= MACB_BIT(RX_USED);
>  
> -	gem_rx_refill(queue);
> +	return gem_rx_refill(queue);
>  }
>  
> -static void gem_init_rings(struct macb *bp)
> +static int gem_init_rings(struct macb *bp)

[ ... ]

> @@ -2834,11 +2844,15 @@ static void gem_init_rings(struct macb *bp)
>  		queue->tx_head = 0;
>  		queue->tx_tail = 0;
>  
> -		gem_init_rx_ring(queue);
> +		err = gem_init_rx_ring(queue);
> +		if (err)
> +			last_err = err;
>  	}
> +
> +	return last_err;
>  }

[Severity: High]

This is a pre-existing issue, not one introduced by this patch.
macb_hresp_error_task() re-initialises every RX ring through this helper,
and nothing stops a NAPI RX poll from running at the same time.

macb_interrupt_misc() queues the task on system_bh_wq, on whichever CPU took
the HRESP interrupt:

    queue_work(system_bh_wq, &bp->hresp_err_bh_work);

The task masks interrupts through IDR and clears NCR.RE/TE. It then calls
mog_init_rings() -> gem_init_rx_ring() -> gem_rx_refill(). That resets
rx_tail and rx_prepared_head and re-arms every slot whose rx_skbuff[entry]
is non-NULL.

Meanwhile, gem_rx() for another queue (or threaded NAPI) can be running on
another CPU:

    skb = queue->rx_skbuff[entry];
    ...
    queue->rx_skbuff[entry] = NULL;

After that it unmaps the buffer, passes the skb to napi_gro_receive(), and
calls gem_rx_refill() itself.

Neither path takes bp->lock, and the task never calls napi_disable() or
otherwise synchronises with NAPI. Can the HRESP refill see a stale non-NULL
rx_skbuff[entry] and clear RX_USED on a descriptor whose buffer was just
unmapped and handed to the stack?

If so, the MAC would DMA into memory owned by the network stack once NCR.RE
is set again. The two refills could also both allocate for the same NULL
slot, leaking one skb and its DMA mapping.

This looks unresolved at the end of the series too. "net: macb: quiesce
IRQs and drain BH on interface close" drains this work only in close and in
the open error path. macb_hresp_error_task() still does not disable or
synchronise with NAPI.

[ ... ]

> @@ -3183,7 +3199,9 @@ static int macb_open(struct net_device *netdev)
>  		goto pm_exit;
>  	}
>  
> -	bp->macbgem_ops.mog_init_rings(bp);
> +	err = bp->macbgem_ops.mog_init_rings(bp);
> +	if (err)
> +		goto free_rings;
>  	macb_init_buffers(bp);
>  
>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {

[Severity: High]

Could this new failure path turn a ring size change into a hang on the next
ifdown? On a running interface, macb_set_ringparam() does:

    if (netif_running(bp->netdev)) {
        reset = 1;
        macb_close(bp->netdev);
    }
    ...
    if (reset)
        macb_open(bp->netdev);

    return 0;

It ignores the return value of macb_open(). By this point macb_close() has
already called napi_disable() on every napi_rx/napi_tx, plus macb_free()
and pm_runtime_put().

If mog_init_rings() now fails here, goto free_rings skips the napi_enable()
loop. NAPI stays disabled, but the netdev still has IFF_UP and
__LINK_STATE_START set.

The next "ip link set dev X down" calls macb_close() again. Its
napi_disable() ends up in napi_disable_locked():

    while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
        usleep_range(20, 200);
        val = READ_ONCE(n->state);
    }

Won't this loop forever while holding RTNL? The second macb_close() would
also call pm_runtime_put() again and underflow the runtime PM usage count.

Before this patch, the same GFP_ATOMIC netdev_alloc_skb() failure let
macb_open() succeed with one degraded queue. The unchecked macb_open() in
macb_set_ringparam() could already be hit through macb_alloc() failures,
but this new failure path makes it much more likely.

This also looks unresolved at the end of the series. macb_set_ringparam()
still ignores the return value of macb_open(), and macb_close() ->
macb_quiesce_start() still calls napi_disable() on the already-disabled
NAPI.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925-macb-close-v2-0-360efa565914%40bootlin.com
