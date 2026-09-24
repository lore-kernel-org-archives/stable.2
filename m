Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17DC4825CA;
	Thu, 24 Sep 2026 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790246815; cv=none; b=B5yBCJ8rNNox2lhWVgUDRrDjyaHO3My+Qvq7CIjo6HmzLA8siwtvUTjL3UpWwsjDNeuJAzQl4QLGdVSGoK0pTB0XMtdUVO2GG7jSXKzYjFVmD5F4lq1WTvhTbbuueJ7/3qiJaokFdicNC1MpW3PbjxXN+iBnfFj560sxvkdHWfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790246815; c=relaxed/simple;
	bh=2jtADkn1BgxtUvdbhqB1UgfQe/+O9kWKnWH4f6TxX6Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YkaZbXgeMK/Moeg6WqI4GtmyXL7asmzvtMOFbwENeraz5EhcdN4qF+aY6CLtqIlfhJobFvLdk5BZm1At9iJLXedYkrvIribgiLC2mkWRBcP0ALtgo3MhzIJBWnR9cgGDp1oYuRnMlTtyhEdMyt55ndWT20QcbB50NLmKnFBYZPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTXVgASZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTXVgASZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BE91F00898;
	Thu, 24 Sep 2026 10:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790246813;
	bh=8UElynLT9i+3LaZQXtW/vHZJ6E11ggkVk86HYaTG5ho=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CTXVgASZV5qo/19NBlWAhF0Y5+XPt2jzx4CWtDin+AvBvnslX24EGNm1ek73avAom
	 2DAM3vX19ts3gB0X962Y/+do4sS60HoDp9KSpSFGn3CAvV4hwBHPBcjA+fnlzMXc8S
	 +2O1JYUBIjl+nKqn19zwMlaM9u7uQYvUSQJ3Lfi+RRblgG3JCVrD2jSXpoOIIKn/PA
	 KfePfL+UG6uJlE+UbL9+gZE4EgDaI1mjhreBqMNFUHyIWA13AZhGWibZe/Q8+45XuR
	 LoAZ3qRUviDhr7NEuZ0rT6h6iGnsr0jfv9OlMOhKXtVs/pg/30fkcKTc2hIpDi+Wdg
	 bD8bQOAwETHBA==
Subject: Re: [PATCH net v2 8/9] gve: ensure XDP mem model is registered when
 disabling XSK pools
From: netdev-bot+sashiko@kernel.org
To: joshwash@google.com
Cc: netdev@vger.kernel.org, hramamurthy@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com,
 willemb@google.com, thostet@google.com, nktgrg@google.com,
 eddiephillips@google.com, pkaligineedi@google.com, jeroendb@google.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 24 Sep 2026 10:46:51 +0000
Message-ID: <179024681184.2160803.3219756831858750953@kernel.org>
In-Reply-To: <20260922194533.631387-9-joshwash@google.com>
References: <20260922194533.631387-9-joshwash@google.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 1 · High: 1 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] Use-after-free in gve_restart_rings()
  (drivers/net/ethernet/google/gve/gve_main.c) when gve_queues_stop()…
- [High] gve_xsk_pool_disable()
  (drivers/net/ethernet/google/gve/gve_main.c) only checks…
- [Medium] After an XSK pool is disabled, DQO-RDA RX page pools
  permanently lose NAPI direct recycling.
- [Medium] Stale pending_packets[].state after the in-place TX ring reset
  weakens completion validation.
- [Low] Incomplete QPL counter reset in gve_tx_reset_ring_dqo() /
  gve_tx_init_ring_state_dqo()…
- [Low] Stray blank line in drivers/net/ethernet/google/gve/gve_tx_dqo.c.
- [Low] The commit message describes the QPL half of the change as a
  functional bug fix, but it has no functional effect.

--

gve: ensure XDP mem model is registered when disabling XSK pools

In QPL mode, this patch changes gve_xsk_pool_disable() to re-register the
XDP memory model in place through a new helper, gve_unreg_xsk_pool_live().
In RDA mode, a new helper, gve_restart_rings(), stops and restarts the
existing rings instead of re-allocating them through
gve_configure_rings_xdp(). To support the in-place restart, the DQO TX ring
state setup moves into gve_tx_init_ring_state_dqo(), and
gve_tx_stop_ring_dqo() now calls a new gve_tx_reset_ring_dqo().

> QPL mode, which does not need to reconfigure rings due to not posting
> XSK umem to the hardware ring, simply misses registering the RXQ XDP
> info with the MEM_TYPE_PAGE_SHARED memory model.

[Severity: Low]
Is this description accurate for QPL mode?

gve_unreg_xsk_pool() calls xdp_rxq_info_unreg_mem_model(), and
xdp_unreg_mem_model() does:

net/core/xdp.c:xdp_unreg_mem_model() {
    ...
	mem->id = 0;
	mem->type = 0;
    ...
}

MEM_TYPE_PAGE_SHARED is 0. When the allocator is NULL,
__xdp_reg_mem_model() only sets mem->type = type and returns. So after the
unregister the QPL rxq is already MEM_TYPE_PAGE_SHARED. The new
registration in gve_unreg_xsk_pool_live() leaves it in the same state.

Should the commit message say that only RDA mode had a functional problem?

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index f2bd4011de23f..787d311ff99bd 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c

[ ... ]

> +static int gve_restart_rings(struct gve_priv *priv)
> +{
> +	struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
> +	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
> +	int err;
> +
> +	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
> +	err = gve_queues_stop(priv);
> +	if (err)
> +		return err;
> +
> +	err = gve_queues_start(priv, &tx_alloc_cfg, &rx_alloc_cfg);

[Severity: Critical]
Can this reuse freed ring memory if gve_queues_stop() takes its error path?

tx_alloc_cfg.tx and rx_alloc_cfg.rx are copies of priv->tx and priv->rx,
taken before the stop. Suppose gve_destroy_rings() or gve_unregister_qpls()
fails while no reset is in progress. Then gve_queues_stop() does:

gve_queues_stop()
  gve_reset_and_teardown(priv, true)
    gve_close()
      gve_queues_mem_remove()   <- frees priv->tx / priv->rx and the rings
  return gve_reset_recovery(priv, false)

With was_up == false, gve_reset_recovery() only calls gve_init_priv(). It
returns 0 without allocating new rings.

gve_restart_rings() then sees err == 0 and passes the stale pointers to
gve_queues_start():

gve_queues_start()
    priv->tx = tx_alloc_cfg->tx;
    priv->rx = rx_alloc_cfg->rx;
    ...
    gve_tx_start_rings()
      gve_tx_start_ring_dqo()
        gve_tx_add_to_block()
          tx->ntfy_id = ntfy_idx;   <- write into freed memory

After that, gve_reg_xdp_info() and gve_create_rings() would also give the
device the DMA addresses (q_resources_bus, bus, complq_bus_dqo) of freed
coherent buffers.

The commit message says "failure to stop the rings would result in a safer
device reset". Isn't this the path where it goes wrong?

The old gve_configure_rings_xdp() -> gve_adjust_config() path allocated
new rings before calling gve_close(), so it didn't have this problem.

[Severity: Medium]
Does this restart leave the RX page pools without direct recycling?

gve_rx_create_page_pool() sets .napi = &priv->ntfy_blocks[ntfy_id].napi,
but only when it creates the pool. gve_queues_stop() -> gve_rx_stop_rings()
-> gve_rx_stop_ring_dqo() calls:

	if (rx->dqo.page_pool)
		page_pool_disable_direct_recycling(rx->dqo.page_pool);

That clears pool->p.napi.

gve_queues_start() -> gve_rx_start_ring_dqo() keeps the same
rx->dqo.page_pool and only calls gve_rx_add_to_block(), timer_setup() and
gve_add_napi(). Nothing calls page_pool_enable_direct_recycling().

So once an XSK pool is disabled on a DQO-RDA interface, no RX queue's pool
has a NAPI owner until the next full reconfiguration. The old
gve_adjust_config() path created new pools, so this didn't happen before.

> +	return err;
> +}
> +

[ ... ]

> @@ -1735,31 +1776,11 @@ static int gve_xsk_pool_disable(struct net_device *dev,
>  	if (!netif_running(dev) || !priv->tx_cfg.num_xdp_queues)
>  		goto unmap_and_return;
>  

[ ... ]

> +	if (gve_is_qpl(priv)) {
> +		err = gve_unreg_xsk_pool_live(priv, dev, qid);
> +	} else {
> +		/* Stop and start RDA queues to repost buffers. */
> +		err = gve_restart_rings(priv);

[Severity: High]
Can this dereference a NULL priv->tx when the netdev is running but has no
rings?

The code above only checks netif_running() and num_xdp_queues. priv->tx
and priv->rx can be NULL while the device is still running, for example:

- gve_reset() -> gve_reset_recovery(was_up=true) -> gve_open() fails.
- An earlier gve_restart_rings() failed in gve_reg_xdp_info() and
  gve_queues_start() took its stop_and_free_rings path.

In that state gve_restart_rings() copies tx = NULL and rx = NULL.
gve_queues_stop() does nothing and returns 0: device_rings_ok is clear,
and gve_unreg_xdp_info(), gve_tx_stop_rings() and gve_rx_stop_rings() all
return early on NULL rings. Then:

gve_queues_start()
    priv->tx = tx_alloc_cfg->tx;   <- NULL
    gve_tx_start_rings()           <- no !priv->tx check
      gve_tx_start_ring_dqo()
        gve_tx_add_to_block()
          struct gve_tx_ring *tx = &priv->tx[queue_idx];
          tx->ntfy_id = ntfy_idx;

The old RDA path allocated rings in gve_adjust_config() before using them,
so it didn't crash here.

On the QPL side, gve_unreg_xsk_pool_live() also reads
priv->rx[qid].ntfy_id without a check, but the old code already did that.

Should both live paths first check that the rings exist?

>  	}
>  
>  unmap_and_return:
> diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> index 80ab0a449ff54..78f946ae72649 100644
> --- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> @@ -208,6 +208,78 @@ static void gve_tx_clean_pending_packets(struct gve_tx_ring *tx)
>  	}
>  }
>  
> +static void gve_tx_init_ring_state_dqo(struct gve_tx_ring *tx)
> +{
> +	int i;
> +
> +	atomic_set_release(&tx->dqo_compl.hw_tx_head, 0);
> +
> +	/* Set up linked list of pending packets */
> +	for (i = 0; i < tx->dqo.num_pending_packets - 1; i++)
> +		tx->dqo.pending_packets[i].next = i + 1;

[Severity: Medium]
When this runs from gve_tx_reset_ring_dqo(), should it also reset
pending_packets[i].state and type?

Before this patch, pending_packets was always freshly kvzalloc'd, and
gve.h relies on that:

	/* Packet is in free list, available to be allocated.
	 * This should always be zero since state is not explicitly initialized.
	 */
	GVE_PACKET_STATE_UNALLOCATED,

With the in-place restart, gve_tx_clean_pending_packets() frees skb/xdpf
and sets the pointer to NULL. In-flight slots still keep their old state
(PENDING_DATA_COMPL, PENDING_REINJECT_COMPL or TIMED_OUT_COMPL). This loop
then puts every slot back on the free list without touching state, type
or prev.

gve_handle_packet_completion() relies on this check to reject completions
for unallocated slots:

	if (unlikely(pending_packet->state !=
		     GVE_PACKET_STATE_PENDING_DATA_COMPL)) {

After the restart, a stale completion from the device for one of these
slots would pass the check. For an SKB slot, the code then reads
pending_packet->skb->len while skb is NULL. It also calls
gve_free_pending_packet() on a slot that is already on the free list.

Could that corrupt the free list and let the same slot be handed out
twice?

> +
> +	tx->dqo.pending_packets[tx->dqo.num_pending_packets - 1].next = -1;
> +	atomic_set_release(&tx->dqo_compl.free_pending_packets, -1);

[ ... ]

> +	/* Generate free TX buf list */
> +	if (tx->dqo.tx_qpl_buf_next) {
> +		for (i = 0; i < tx->dqo.num_tx_qpl_bufs - 1; i++)
> +			tx->dqo.tx_qpl_buf_next[i] = i + 1;
> +		tx->dqo.tx_qpl_buf_next[tx->dqo.num_tx_qpl_bufs - 1] = -1;
> +
> +		atomic_set_release(&tx->dqo_compl.free_tx_qpl_buf_head, -1);
> +		atomic_set_release(&tx->dqo_compl.free_tx_qpl_buf_cnt, 0);

[Severity: Low]
Should dqo_tx.alloc_tx_qpl_buf_cnt and dqo_tx.free_tx_qpl_buf_cnt also be
reset here?

gve_has_free_tx_qpl_bufs() uses them as a pair:

	num_avail = tx->dqo.num_tx_qpl_bufs -
		(tx->dqo_tx.alloc_tx_qpl_buf_cnt -
		 tx->dqo_tx.free_tx_qpl_buf_cnt);

It also refreshes the cached dqo_tx.free_tx_qpl_buf_cnt from
dqo_compl.free_tx_qpl_buf_cnt. gve_tx_reset_ring_dqo() leaves
alloc_tx_qpl_buf_cnt at its running value.

If a QPL ring were restarted in place, the first refresh would compare 0
against a large alloc count. num_avail would go negative and the queue
would stall.

This can't happen today: gve_restart_rings() only runs in RDA mode, and
the other callers of gve_tx_stop_ring_dqo() free the ring right after.

> +	}
> +}

[ ... ]

> @@ -304,6 +369,7 @@ void gve_tx_start_ring_dqo(struct gve_priv *priv, int idx)
>  	gve_add_napi(priv, ntfy_idx, gve_napi_poll_dqo);
>  }
>  
> +

[Severity: Low]
This isn't a bug, but it adds a second blank line before
gve_tx_alloc_ring_dqo().

>  static int gve_tx_alloc_ring_dqo(struct gve_priv *priv,
>  				 struct gve_tx_alloc_rings_cfg *cfg,
>  				 struct gve_tx_ring *tx,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922194533.631387-1-joshwash%40google.com
