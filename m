Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795507334;
	b=O0+Pww9nE4alDiebtVQy9Tt3Ohxsl4EpuatltuSNM/7n7M9QZS2ezL+QfO7JWq06YuDy
	 JQUS0xtR0PCJMSUwCMqvhRYe92NfH1dLXK47p34P4anTYUZdOx8On0OoKbUALtRUwl9jb
	 6l5x8ul/TQgBWOyjYtFWaHI+Mc2lviOw+HuGG9Tic2o0jc4EwPmmEegblA0PXcbbARgcE
	 lTYzgxR0rlPNdnZA9GAkE9QR4wvuRogtgLL+xNFdinXYuwtfN7aozI8cf1vwfZcRBkoH0
	 re4zwbIHjtevOvSbslMBUXk17AUNsy6VUNvj3Lk1zwCTqP2dUnsFCzrrZENgU5puadQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795507334;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+pKXu3qkgJSPLozlW00PL8TqTAeUCLEtzNRMzovbU6c=;
	b=eIwfVzdsYJw+gbWjZ+0IEjxey77V4uM0KVN4qemWHlDPWI2MyD14aWMmndSXdQR5cllX
	 SCZXt1Z6tCQ3KOvRveWy2Rq8B3WlO1Jf5o0FcjqCWa/5e5IoVq9wOvve6t1cQ4N6F269l
	 aN0Gkxm1FP82E22fbqtxLQ5jnYCkUZVObvRW+Aqz8w6zD5IY2dEZ4jJoijNlC9FIbkY2/
	 0OLpZIwGXW8Aw59P/C5br1YDbXXFUGfKrnh5tWCMVmabfH0HHNpy8yKLNKnmItjbJObRK
	 AByM1feJ9vpAI4HM4Q+Gam24fT0FQ+989PDWHSH2V8aKO66EHEL8BrbzhNEYSN/mWcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fXMTKtGL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEF0606A31E;
	Tue, 24 Nov 2026 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fXMTKtGL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDA41F000C0;
	Tue, 24 Nov 2026 08:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795507334;
	bh=+pKXu3qkgJSPLozlW00PL8TqTAeUCLEtzNRMzovbU6c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fXMTKtGLNHeemfUWTOrZ53U0gq5PMgpFosjoZDra4ZDVlRXrcCfAOWlJ26RXadcWF
	 26QoawHDjPyR0sYYJ4kD5wa+k8f8Zjvqce6ieocTLZlm6ag1kE3uLgMFL4UpIOUVRy
	 GftvWGWABuBaXVL3OQYLiMlMKBHH9K6AnTKOruEH8eKkKCEOfEb7WjWNCvn2imBVXk
	 MMFwVDJH2/d2c/baEABqtfxDV+Xt8SuHPxbMRAb4Ajbd/blAwS4YL8kzgkLKldinrB
	 8iTUxHzNhBhUrtQOU205fMBjj3KhaHl2/mf2uxdhOr/vaY7bcdzFEWxpnhp+uiKsnm
	 qXi4DNMmKhTNA==
Subject: Re: [PATCH net] net: stmmac: retry a failed RX refill from a timer
From: netdev-bot+sashiko@kernel.org
To: Anandu.Padinhare@electrifex.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, cfsworks@gmail.com, rmk+kernel@armlinux.org.uk,
 david.wu@rock-chips.com, stable@vger.kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Date: Tue, 24 Nov 2026 08:02:12 +0000
Message-ID: <179550733234.3135.14826070962327647886@kernel.org>
In-Reply-To: <MA0PR01MB921746F36D90C7080287ACC9FD782@MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM>
References: <MA0PR01MB921746F36D90C7080287ACC9FD782@MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] net: stmmac: stmmac_rx() runs receive loop before
  stmmac_rx_refill() on retry
- [Low] The new block comment above stmmac_rx_refill_needed()
  (stmmac_main.c lines 268-271) says: "The RX DMA suspends without an…

Pre-existing issues:
- [High] Suspend/resume while an RX refill is failing hands unpopulated
  and stale descriptors back to the DMA.
- [High] stmmac_setup_tc_block_cb() can leave a channel's DMA RX
  interrupt masked, which stalls RX on that channel.

--

net: stmmac: retry a failed RX refill from a timer

This commit adds a per-channel timer to stmmac. When a poll leaves at most
STMMAC_RX_REFILL_THRESH slots with the DMA, the timer schedules RX NAPI
10 ms later, so a refill that failed in page_pool is retried without
waiting for an RX interrupt. The timer is cancelled after rx_napi is
disabled, and stmmac_enable_all_queues() re-arms it if the ring is still
short of buffers.

Link: https://lore.kernel.org/netdev/20260331195927.3353cc6d@kernel.org/
Link: https://lore.kernel.org/netdev/20260402174049.0ac088cc@kernel.org/

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index a685ce4638f61..ad9873aaf2dba 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -263,6 +265,32 @@ static void stmmac_verify_args(void)
>  		pr_warn("stmmac: module parameter 'flow_ctrl' is obsolete - please remove from your module configuration\n");
>  }
>  
> +/* The RX DMA suspends without an interrupt once it has used all its buffers,
> + * so a refill that failed for lack of memory would never be retried. Retry it
> + * from a timer when few slots are left with the DMA.
> + */

[Severity: Low]
This isn't a bug, but is the first sentence of this comment accurate for
dwmac4?

In dwmac4_dma.h, DMA_CHAN_INTR_ABNORMAL includes DMA_CHAN_INTR_ENA_RBU.
That macro is part of DMA_CHAN_INTR_DEFAULT_MASK, which is written to
DMA_CHAN_INTR_ENA. dwmac4_dma_interrupt() then gets the RBU status but
only counts it:

	if (unlikely(intr_status & DMA_CHAN_STATUS_RBU))
		x->rx_buf_unav_irq++;

The sentence is true for dwxgmac2, where XGMAC_DMA_INT_DEFAULT_EN has no
RBUE, and for dwmac1000. The commit message also says the RBU interrupt
"is not enabled on every core and kernel version".

Could the comment say that RBU is not enabled on every core, or is not
used to drive the refill, rather than that there is no interrupt?

> +static bool stmmac_rx_refill_needed(struct stmmac_priv *priv, u32 queue)
> +{
> +	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
> +
> +	return CIRC_SPACE(rx_q->cur_rx, rx_q->dirty_rx,
> +			  priv->dma_conf.dma_rx_size) < STMMAC_RX_REFILL_THRESH;
> +}

[ ... ]

> @@ -328,8 +360,17 @@ static void stmmac_enable_all_queues(struct stmmac_priv *priv)
>  			continue;
>  		}
>  
> -		if (queue < rx_queues_cnt)
> +		if (queue < rx_queues_cnt) {
> +			/* Disabling the queues cancelled any pending refill
> +			 * retry, but the ring may have been kept as it was.
> +			 * Check it while no poll can run.
> +			 */
> +			bool refill = stmmac_rx_refill_needed(priv, queue);

[Severity: High]
This is a pre-existing issue, but does the "ring may have been kept as it
was" case also need to cover stmmac_resume() after a failed refill?

When stmmac_rx_refill() stops at a page_pool allocation failure, the
slots in [dirty_rx, cur_rx) keep buf->page == NULL. The DMA write-back
has already overwritten their buffer address words (RDES0/RDES1 on
dwmac4).

If the system suspends at that point, stmmac_suspend() leaves the ring as
it is, and resume does:

stmmac_resume()
  stmmac_reset_queues_param()
    stmmac_reset_rx_queue()
      rx_q->cur_rx = 0;
      rx_q->dirty_rx = 0;
  stmmac_clear_descriptors()
    stmmac_clear_rx_descriptors()
      stmmac_init_rx_desc()
        dwmac4_rd_init_rx_desc()
          dwmac4_set_rx_owner(p, disable_rx_ic);
  stmmac_hw_setup()
    stmmac_init_dma_engine()
      stmmac_set_queue_rx_tail_ptr(priv, rx_q, chan,
                                   rx_q->buf_alloc_num);
  stmmac_enable_all_queues()

Nothing in this sequence rewrites the buffer addresses from buf_pool.
Every descriptor gets the OWN bit, and the tail pointer gives the whole
ring to the DMA.

Could the DMA then write received frames to addresses taken from old
write-back data? Those may be garbage, or the stale DMA address of a page
already returned to the stack or page_pool.

When stmmac_rx() later reaches such a slot, it would call
dma_sync_single_for_cpu() on a stale buf->addr and page_address() on a
NULL buf->page, and pass the result to xdp_prepare_buff() and
napi_build_skb().

The new check here does not see this case. Resume has just set cur_rx
and dirty_rx to the same value, so stmmac_rx_refill_needed() returns
false and no retry is armed.

Even if a retry were armed, stmmac_rx_dirty() would return 0, so
stmmac_rx_refill() would not fill the NULL slots before the DMA uses
them.

> +
>  			napi_enable(&ch->rx_napi);
> +			if (refill)
> +				stmmac_rx_refill_timer_arm(ch);
> +		}

[Severity: High]
This is a pre-existing issue, but can stmmac_setup_tc_block_cb() leave the
channel's DMA RX interrupt masked? The new re-arm logic does not cover
that case.

Consider this sequence:

CPU1 (RX interrupt and NAPI)
stmmac_napi_check()
  stmmac_disable_dma_irq(priv, priv->ioaddr, chan, 1, 0);
  __napi_schedule()
stmmac_napi_poll_rx()
  work_done == budget, so the IRQ re-enable is skipped

CPU2 (CAP_NET_ADMIN adds a tc u32 or flower offload rule)
stmmac_setup_tc_block_cb()
  __stmmac_disable_all_queues()
    napi_disable()    <- sets NAPI_STATE_DISABLE

Then __napi_poll() in net/core/dev.c does this:

	if (unlikely(napi_disable_pending(n))) {
		napi_complete(n);
		return work;
	}

The core completes NAPI itself and napi_disable() returns. The only place
the RX IRQ is re-enabled, in stmmac_napi_poll_rx(), never runs:

	if (work_done < budget && napi_complete_done(napi, work_done)) {
		...
		stmmac_enable_dma_irq(priv, priv->ioaddr, chan, 1, 0);

stmmac_enable_all_queues() then calls napi_enable(). It arms the refill
timer only when stmmac_rx_refill_needed() is true, which is usually not
the case because stmmac_rx() has refilled the ring.

The open, resume and XDP setup paths call stmmac_enable_all_dma_irq() or
schedule a poll. stmmac_setup_tc_block_cb() does neither.

On dwmac4, the RBU interrupt recovers the channel once the ring fills.
dwxgmac2 also uses dwmac510_tc_ops, but RBUE is not in
XGMAC_DMA_INT_DEFAULT_EN.

With per-channel MSI, or with RX-only traffic, would the dwxgmac2 channel
stay dead until the interface is reopened?

Would scheduling rx_napi after napi_enable() in this path fix both this
stall and the refill case?

[ ... ]

> @@ -6164,6 +6205,8 @@ static int stmmac_napi_poll_rx(struct napi_struct *napi, int budget)
>  	u64_stats_update_end(&rxq_stats->napi_syncp);
>  
>  	work_done = stmmac_rx(priv, budget, chan);
> +	if (unlikely(stmmac_rx_refill_needed(priv, chan)))
> +		stmmac_rx_refill_timer_arm(ch);
>  	if (work_done < budget && napi_complete_done(napi, work_done)) {
>  		unsigned long flags;
>  

[Severity: Medium]
Once memory is available again, does the retry poll deliver the frame
that is already waiting in the ring?

When the ring has run completely dry, stmmac_rx() stops on the last
descriptor the DMA completed, at rx_q->cur_rx. It stops there because
the next entry equals rx_q->dirty_rx:

	next_entry = STMMAC_NEXT_ENTRY(rx_q->cur_rx,
				       priv->dma_conf.dma_rx_size);
	if (unlikely(next_entry == rx_q->dirty_rx))
		break;

The refill only runs after the receive loop, at the end of stmmac_rx().
The timer-driven poll that finally succeeds then does this:

stmmac_rx_refill_timer()
  napi_schedule(&ch->rx_napi)
stmmac_napi_poll_rx()
  stmmac_rx()
    receive loop breaks at once on next_entry == rx_q->dirty_rx,
    count == 0
    stmmac_rx_refill()    <- succeeds, dirty_rx catches up to cur_rx
  stmmac_rx_refill_needed()    <- false, timer not re-armed
  napi_complete_done(napi, 0)

The DMA wrote the descriptor at cur_rx before it suspended, and it
resumes at the entry after it. It will not raise another RX interrupt
for that descriptor, and nothing else schedules a poll.

So the frame stays in the ring until another packet arrives on that
queue. If the frame spans several descriptors, the same applies to its
last segment, with the partial skb kept in rx_q->state.skb. On a quiet
queue that can take a long time, and this is the recovery path the
patch adds.

There is a smaller effect while allocations keep failing. Every 10 ms
retry calls stmmac_rx_status() again on the same descriptor at cur_rx
before it breaks. Any per-frame counters that call updates in
priv->xstats are counted again on each retry.

Could stmmac_rx() go back through the receive loop when the refill has
made room? Or could stmmac_napi_poll_rx() schedule another poll when
the refill advanced dirty_rx? Another option would be to refill before
the receive loop when the ring is full. Which of these fits the ring
accounting from commit 0bb05e6adfa9 best?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/MA0PR01MB921746F36D90C7080287ACC9FD782%40MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM
