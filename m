Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34224CEE71;
	Tue, 22 Sep 2026 20:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109437; cv=none; b=CMBa/cMdvKogdR6mZLfMdHPwFrGXUJnkfj/AfjPy419D90///AjS84vR6eUvPgpn/CMCAckCvxKBCm8xj/ed8qgrNX2BxPSgZt+0h/wAnC9ihym8CQUbvT+bLxtpsJkN2RUwBySbPh1YvzoUdDBj6cdtdpC8XsW2v1VNwWjOYvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109437; c=relaxed/simple;
	bh=2YnWH9cax97AUtQ38BU1f+kCyda35lBFk7PhQuymp04=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ESvNnUTRwgZ91KaZvTuSuyKjWzEZgcdrrw5TXM15jm9KzWBOlm+ZnRWFOnDuXVcXPHnNOneYYw4RZjADdVc7e87DpRggldyyHlBxfTeNr0wYYhkFZq2I7KxvLJVDzSGK36ZJDYaAgCuf4vIhGLoDJMVCIlCbv15774WeynFz/98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYk8xtcm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYk8xtcm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769DC1F0089B;
	Tue, 22 Sep 2026 20:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790109421;
	bh=rCabQF8E/QYx6N0UAExqR+EIo5OJEHmS/2vGxtXACq0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gYk8xtcmurToLaTNHIBtPQhf2s7wwOG6ycpklK6JAxglcZ8IznaETWmhvakfOLBsk
	 /BA9bkkwZAGZmJWUmc2/ZkniarUd7y3MuGVZRfd1xIfTA+8LqhWSwXqB11sY1pRfc3
	 NPX8OPVOZbdJWukaSZP/Qbdh0D7vbvFj8F5V9sRaqd8PkIVWg9bJTLWl+eDeQHeRm+
	 o39XaHAfeDx5gU1yPumLl6566YTcwM2tRtRuum7HuWG8fM6/d/fPq1lEc1izfzvTYU
	 Fj3bLcprBZ6KNFhlTEyKtXSZ3suX4aSd5VarjpXdT7lvrQRaJsd4ZxZQEU3BnG3nTf
	 KXWmyIC4j4Aaw==
Subject: Re: [PATCH net 1/3] net: macb: never give hardware a NULL RX buffer
From: netdev-bot+sashiko@kernel.org
To: theo.lebrun@bootlin.com
Cc: conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 nicolas.ferre@microchip.com, sean.anderson@linux.dev, atenart@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 nb@tipi-net.de, vladimir.kondratiev@mobileye.com, gregory.clement@bootlin.com,
 tawfik.bayouk@mobileye.com, thomas.petazzoni@bootlin.com,
 maxime.chevallier@bootlin.com, stable@vger.kernel.org
Date: Tue, 22 Sep 2026 20:37:00 +0000
Message-ID: <179010942002.2160803.8691011751847108495@kernel.org>
In-Reply-To: <20260918-macb-close-v1-1-05e32ce98813@bootlin.com>
References: <20260918-macb-close-v1-1-05e32ce98813@bootlin.com>
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

Critical: 0 · High: 2 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] gem_init_rx_ring()
  (drivers/net/ethernet/cadence/macb_main.c:2793) now sets…
- [High] gem_init_rx_ring() now publishes MACB_BIT(RX_USED) on every RX
  descriptor of a queue, resets queue->rx_tail/rx_prepared_head and then…

--

net: macb: never give hardware a NULL RX buffer

This makes gem_init_rx_ring() set the RX_USED bit on every RX descriptor
before calling gem_rx_refill(), so that a refill that fails part way
through does not leave descriptors owned by hardware while their skb
pointers are still NULL.  The change affects macb_open(), macb_resume(),
the HRESP error recovery path and set_ringparam().

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index b8234ac4b602..751fa9e68099 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2785,9 +2785,14 @@ static int macb_alloc(struct macb *bp)
>  
>  static void gem_init_rx_ring(struct macb_queue *queue)
>  {
> +	unsigned int i;
> +
>  	queue->rx_tail = 0;
>  	queue->rx_prepared_head = 0;
>  
> +	for (i = 0; i < queue->bp->rx_ring_size; i++)
> +		macb_rx_desc(queue, i)->addr |= MACB_BIT(RX_USED);
> +

[Severity: High]

Does RX_USED now carry two different meanings that the RX consume path
cannot tell apart?

gem_rx() uses RX_USED at queue->rx_tail as the only indication that
hardware delivered a frame, and it has no bound against
queue->rx_prepared_head:

drivers/net/ethernet/cadence/macb_main.c:gem_rx() {
	rxused = (desc->addr & MACB_BIT(RX_USED)) ? true : false;
	addr = macb_get_addr(bp, desc);

	if (!rxused)
		break;
	...
	queue->rx_tail++;
	count++;

	if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF))) {
		netdev_err(bp->netdev,
			   "not whole frame pointed by descriptor\n");
		bp->netdev->stats.rx_dropped++;
		queue->stats.rx_dropped++;
		break;
	}
	skb = queue->rx_skbuff[entry];
	if (unlikely(!skb)) {
		netdev_err(bp->netdev,
			   "inconsistent Rx descriptor chain\n");
		...
}

So for a slot that gem_rx_refill() never got to prepare (the exact
memory-pressure case in the commit message, where it breaks out of the
loop on netdev_alloc_skb() or dma_map_single() failure), gem_rx() no
longer stops at "if (!rxused) break;".  It advances rx_tail, counts the
slot as work, hits the SOF/EOF test with ctrl == 0 on a fresh ring, emits
a non-ratelimited netdev_err() and bumps rx_dropped.

Then does the poll reschedule itself forever?  macb_rx_poll() consults
macb_rx_pending(), which also looks only at RX_USED at rx_tail:

drivers/net/ethernet/cadence/macb_main.c:macb_rx_pending() {
	entry = macb_rx_ring_wrap(bp, queue->rx_tail);
	desc = macb_rx_desc(queue, entry);
	rmb();
	return (desc->addr & MACB_BIT(RX_USED)) != 0;
}

The next slot is also software-marked RX_USED, so macb_rx_poll() calls
napi_schedule() again.  Since gem_rx_refill() only fills up to
CIRC_SPACE(rx_prepared_head, rx_tail, rx_ring_size), the slot at rx_tail
is never the one refilled, so while allocations keep failing nothing
clears RX_USED ahead of rx_tail.  Can this turn into a self-sustaining
NAPI/softirq loop with two unratelimited error lines and one bogus
rx_dropped per iteration, and once allocations recover, a full ring
traversal (rx_ring_size, 512 by default) of phantom completions that
walks rx_tail past slots hardware never wrote?

Before this patch gem_rx() stopped at those same slots on
"if (!rxused) break;".

Reachable at least via macb_resume() and macb_hresp_error_task(), which
both ignore the refill result and re-enable RX and NAPI afterwards.

[Severity: High]

Is any exclusion against a running RX poll needed here now that the whole
ring is published as RX_USED?

macb_hresp_error_task() runs from system_bh_wq, masks queue interrupts,
clears RE/TE, and then calls mog_init_rings() with no napi_disable(), no
napi_synchronize() and no lock:

drivers/net/ethernet/cadence/macb_main.c:macb_hresp_error_task() {
	netif_tx_stop_all_queues(netdev);
	netif_carrier_off(netdev);

	bp->macbgem_ops.mog_init_rings(bp);
	...
}

Masking interrupts does not stop a poll that is already scheduled or
running on another CPU (per-queue IRQs can be affinitized, and NAPI can
be threaded).  Previously such a concurrent gem_rx() would stop at the
first hardware-owned descriptor; with every descriptor marked RX_USED,
does it now walk the entire ring reading stale desc->ctrl (the new loop
does not clear ctrl), setting queue->rx_skbuff[entry] = NULL,
dma_unmap_single()ing and napi_gro_receive()ing the buffers?

Meanwhile gem_rx_refill() called from gem_init_rx_ring() walks the same
entries, and for any entry whose rx_skbuff it still sees as non-NULL it
takes the else branch:

drivers/net/ethernet/cadence/macb_main.c:gem_rx_refill() {
	} else {
		desc->ctrl = 0;
		dma_wmb();
		desc->addr &= ~MACB_BIT(RX_USED);
	}
}

which re-arms hardware with the address of a buffer the concurrent poll
may have just unmapped and handed to the stack.  Can the device then DMA
into stack-owned memory?  The two contexts also both write
queue->rx_tail / rx_prepared_head and can both allocate for the same
entry, leaking an skb and its DMA mapping.

>  	gem_rx_refill(queue);
>  }
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918-macb-close-v1-0-05e32ce98813%40bootlin.com
