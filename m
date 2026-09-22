Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3A84AB1DC;
	Tue, 22 Sep 2026 20:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109438; cv=none; b=rC6kxVXRTrhGVwqRnXo7KT27ABqeOhLsPDaFx0AuLJdAyl1uirqhxJMmu9xUGmJZcSc/CD7uWKoy0KyCZgbp9LO2OTV2rFklSPzzOuF0FovnyYUX2rWT1PnUd0rC3WjyR3ldEazZJVTbcOhO4M2fxZNUFVpRV/x8VFqCWdKmBo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109438; c=relaxed/simple;
	bh=d3csPslYIziOC0R7LhjPuYgG7RxPE7Qu4TLRopm6vTY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gLUjNIzSARVzhBZXnNCNjVaJGjc3nTxpFB1nO+UcbllkR7YWIf7R8utlDdDD6lyz69vMOYZuITsPyIwcR8hmx77sHKfZCY5tdbETbkiXirAQPN31/N8nQvNw4juYL3gYEQjER6G7dkfmBfgbDEx1DmsxhXpFrQcA0ue1OG9sSQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDDiwjoJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDDiwjoJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6F91F00898;
	Tue, 22 Sep 2026 20:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790109423;
	bh=W39bp12GNfWIwx2ln5PK2AHicqGywbx2D2WipXSsH9U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DDDiwjoJF+t5AKURCuKoLR72enjuGjMRZoHVPY1cQv7TNTaroRi1c9HILFBDJl4OW
	 vqwpu+r1tTiiUwcD0hULS1VCJzCYJOQ8k6nU31udtE2XlHcgk9ko51ziteobk7UZHw
	 ppr4TRlysZWL/JG+XupbrOMQ8bIPYGTGuk0K08kKF65vnfzwn02h0sfxn5OaXiL9ky
	 b3STbK7FewZiyULb1CMfdia9V3YzlICQNta3xd9QerW1PxoZ/Hw5crzO855V5v5Rhz
	 zvQOnK5223MDjJoq2/AK5Fe18Suxi8LAcmTSSDDMuVZLrVOF9f5eTrHa0YxBZ42qE9
	 fRcC7vlnoIZsQ==
Subject: Re: [PATCH net 2/3] net: macb: propagate RX ring refill errors
From: netdev-bot+sashiko@kernel.org
To: theo.lebrun@bootlin.com
Cc: conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 nicolas.ferre@microchip.com, sean.anderson@linux.dev, atenart@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 nb@tipi-net.de, vladimir.kondratiev@mobileye.com, gregory.clement@bootlin.com,
 tawfik.bayouk@mobileye.com, thomas.petazzoni@bootlin.com,
 maxime.chevallier@bootlin.com, stable@vger.kernel.org
Date: Tue, 22 Sep 2026 20:37:01 +0000
Message-ID: <179010942168.2160803.12593263624100762709@kernel.org>
In-Reply-To: <20260918-macb-close-v1-2-05e32ce98813@bootlin.com>
References: <20260918-macb-close-v1-2-05e32ce98813@bootlin.com>
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

Critical: 0 · High: 2 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the new errno from
  gem_rx_refill()/gem_init_rx_ring()/mog_init_rings() is discarded by…
- [High] macb_set_ringparam()
  (drivers/net/ethernet/cadence/macb_main.c:3737-3749) closes and…

Pre-existing issues:
- [High] macb_hresp_error_task() (macb_main.c:1998-2035, BH-workqueue
  context) calls bp->macbgem_ops.mog_init_rings(bp) -> gem_init_rings()…

--

net: macb: propagate RX ring refill errors

This changes gem_rx_refill(), gem_init_rx_ring(), gem_init_rings(),
macb_init_rings() and the macbgem_ops.mog_init_rings function pointer to
return errno-style ints, so that macb_open() fails when RX skb allocation
or DMA mapping fails. The other refill callers (resume, HRESP error task,
NAPI) keep their best-effort behaviour.

> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index d6931c41f39d..cfaa0ca49f1a 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -1197,7 +1197,7 @@ struct macb_queue;
>  struct macb_or_gem_ops {
>  	int	(*mog_alloc_rx_buffers)(struct macb *bp);
>  	void	(*mog_free_rx_buffers)(struct macb *bp);
> -	void	(*mog_init_rings)(struct macb *bp);
> +	int	(*mog_init_rings)(struct macb *bp);
>  	int	(*mog_rx)(struct macb_queue *queue, struct napi_struct *napi,
>  			  int budget);
>  };
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 751fa9e68099..c418f859cc34 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1486,13 +1486,14 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
>  	return packets;
>  }
>  
> -static void gem_rx_refill(struct macb_queue *queue)
> +static int gem_rx_refill(struct macb_queue *queue)
>  {
>  	struct macb *bp = queue->bp;
>  	struct macb_dma_desc *desc;
>  	struct sk_buff *skb;
>  	unsigned int entry;
>  	dma_addr_t paddr;
> +	int err = 0;
>  
>  	while (CIRC_SPACE(queue->rx_prepared_head, queue->rx_tail,
>  			bp->rx_ring_size) > 0) {
> @@ -1509,6 +1510,7 @@ static void gem_rx_refill(struct macb_queue *queue)
>  			if (unlikely(!skb)) {
>  				netdev_err(bp->netdev,
>  					   "Unable to allocate sk_buff\n");
> +				err = -ENOMEM;
>  				break;
>  			}
>  
> @@ -1518,6 +1520,7 @@ static void gem_rx_refill(struct macb_queue *queue)
>  					       DMA_FROM_DEVICE);
>  			if (dma_mapping_error(&bp->pdev->dev, paddr)) {
>  				dev_kfree_skb(skb);
> +				err = -ENOMEM;
>  				break;
>  			}
>  
> @@ -1558,6 +1561,8 @@ static void gem_rx_refill(struct macb_queue *queue)
>  
>  	netdev_vdbg(bp->netdev, "rx ring: queue: %p, prepared head %d, tail %d\n",
>  		    queue, queue->rx_prepared_head, queue->rx_tail);
> +
> +	return err;
>  }

[Severity: High]
The commit message says:

    Note that other callers of refill (resume, HRESP error task, NAPI)
    cannot do anything useful with that error and keep their best-effort
    refill, hoping it will improve.

Is the "hoping it will improve" part true for those callers, given the
same analysis used to justify the open() fix?

gem_init_rx_ring() first marks every descriptor as software owned and
resets both cursors:

	queue->rx_tail = 0;
	queue->rx_prepared_head = 0;

	for (i = 0; i < queue->bp->rx_ring_size; i++)
		macb_rx_desc(queue, i)->addr |= MACB_BIT(RX_USED);

	return gem_rx_refill(queue);

gem_rx_refill() then breaks out on the first netdev_alloc_skb() or
dma_mapping_error() failure, so it can return with zero descriptors handed
to the hardware.

With no hardware-owned descriptor, can the controller ever complete a
receive and raise RCOMP?  bp->rx_intr_mask is only MACB_RX_INT_FLAGS
(RCOMP | ISR_ROVR) unless the part has MACB_CAPS_NEEDS_RSTONUBR:

	bp->rx_intr_mask = MACB_RX_INT_FLAGS;
	if (bp->caps & MACB_CAPS_NEEDS_RSTONUBR)
		bp->rx_intr_mask |= MACB_BIT(RXUBR);

and even on those parts macb_interrupt_misc() only toggles NCR.RE without
refilling.  The single remaining refill trigger, gem_rx(), is only reached
through napi_schedule on RCOMP/ROVR.

The callers that discard the new return value re-arm the receiver anyway:

macb_resume():

	if (macb_is_gem(bp))
		gem_init_rx_ring(queue);
	...
	macb_init_hw(bp);

macb_hresp_error_task():

	bp->macbgem_ops.mog_init_rings(bp);
	...
	ctrl |= MACB_BIT(RE) | MACB_BIT(TE);
	macb_writel(bp, NCR, ctrl);

gem_rx():

	gem_rx_refill(queue);

	return count;

So can a queue still end up permanently RX-dead after resume, after HRESP
recovery, or at runtime when a poll drains every armed descriptor and the
following refill fails on its first allocation, with recovery only through
an administrative down/up?  Would it make sense for those paths to retry
(NAPI reschedule or delayed work), or to keep the receiver disabled for
the affected queue, rather than only propagating the error at open()?

>  
>  /* Mark DMA descriptors from begin up to and not including end as unused */

[ ... ]

> @@ -2793,14 +2798,16 @@ static int macb_alloc(struct macb *bp)
>  	for (i = 0; i < queue->bp->rx_ring_size; i++)
>  		macb_rx_desc(queue, i)->addr |= MACB_BIT(RX_USED);
>  
> -	gem_rx_refill(queue);
> +	return gem_rx_refill(queue);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but it sits on the call chain
being changed here, so it may be worth a look: is the HRESP path allowed to
re-run gem_init_rx_ring()/gem_rx_refill() while an RX poll is in flight?

macb_hresp_error_task() runs in BH workqueue context and only masks the
device interrupt sources:

	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
		queue_writel(queue, IDR, bp->rx_intr_mask |
					 MACB_TX_INT_FLAGS |
					 MACB_BIT(HRESP));
	}
	...
	bp->macbgem_ops.mog_init_rings(bp);

There is no napi_disable() or napi_synchronize(), and neither side takes
bp->lock around queue->rx_tail, queue->rx_prepared_head, queue->rx_skbuff[]
or the descriptors.  Can this sequence happen?

CPU0, gem_rx() poll at entry E (hardware has completed that descriptor)

CPU1, HRESP worker, gem_rx_refill() sees rx_skbuff[E] still non-NULL:
	} else {
		desc->ctrl = 0;
		dma_wmb();
		desc->addr &= ~MACB_BIT(RX_USED);
	}

CPU0 then continues in gem_rx():
	queue->rx_skbuff[entry] = NULL;
	...
	dma_unmap_single(&bp->pdev->dev, addr,
			 bp->rx_buffer_size, DMA_FROM_DEVICE);

and passes the skb up.  Once macb_hresp_error_task() rewrites NCR with
RE|TE, does the DMA engine then write the next frame into a buffer that is
already unmapped and owned by the stack?  The unsynchronised resets of
rx_tail and rx_prepared_head to 0 against gem_rx()/gem_rx_refill()'s own
updates of the same counters also look like they could arm a descriptor
twice or leak an skb.

[ ... ]

> @@ -3162,7 +3175,9 @@ static int macb_open(struct net_device *netdev)
>  		goto pm_exit;
>  	}
>  
> -	bp->macbgem_ops.mog_init_rings(bp);
> +	err = bp->macbgem_ops.mog_init_rings(bp);
> +	if (err)
> +		goto free_rings;

[Severity: High]
This adds a new, fairly easy to hit macb_open() failure path that returns
before the napi_enable() loop.  Does macb_set_ringparam() need updating for
it?  It closes and reopens the interface and discards the result:

	if (netif_running(bp->netdev)) {
		reset = 1;
		macb_close(bp->netdev);
	}

	bp->rx_ring_size = new_rx_size;
	bp->tx_ring_size = new_tx_size;

	if (reset)
		macb_open(bp->netdev);

	return 0;

Because the ops are called directly rather than through __dev_open(), the
netdev stays marked running while the rings are freed and both NAPI
instances are left disabled.  The next close then calls napi_disable() on
instances that were never re-enabled, and napi_disable_locked() spins:

net/core/dev.c:napi_disable_locked() {
	...
	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
		usleep_range(20, 200);
		val = READ_ONCE(n->state);
	}
	...
}

Nothing clears those bits without an intervening napi_enable(), so can an
"ethtool -G" resize that fails allocation under memory pressure leave the
next "ip link set dev down" looping forever with rtnl_lock held?

>  	macb_init_buffers(bp);
>  
>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> @@ -3200,6 +3215,7 @@ static int macb_open(struct net_device *netdev)
>  		napi_disable(&queue->napi_rx);
>  		napi_disable(&queue->napi_tx);
>  	}
> +free_rings:
>  	macb_free(bp);
>  pm_exit:
>  	pm_runtime_put_sync(&bp->pdev->dev);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918-macb-close-v1-0-05e32ce98813%40bootlin.com
