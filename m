Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA2A3BB664;
	Thu, 24 Sep 2026 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790246809; cv=none; b=kUr15vFYc9+uRx01GNZMhkUitoXvmevt1nZkVANU56L8+Qu3SZFv653h01idKXjukdAarSjv0rmrliWvvzrWao61uTBgFQnVVOAK1idqztcY27Ngj/4h1XS6riWFMQiPJePoz42BKRyTW4nOwjv9SpLwTvCy1j8Y8/kmNg4kHRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790246809; c=relaxed/simple;
	bh=Hf+8OA6nDOq9rsRooPPKQbBn+f0TlD0oOYHIClpgVlM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LRhLxIoa0O7dwXmuDEZ2/j2t6IqlSwadmwxVcbbkjwp8qgShiFL2kTQ75hA95cXzEdgW/IGfujlHSdwDDUn2c0nkpbrAeZjT1ZhwUI2kO5Drr7JzfCPPgvH4foY9/Cne88u8FuoYiY45gNbzrirLTX0y3u4zXspKgOA/ljQ2ikA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8/Zd285; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8/Zd285"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABF71F00893;
	Thu, 24 Sep 2026 10:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790246807;
	bh=S1c3/I5Z0LGFiopRYnhVM47PU8oKaDzHF8XxFPsI+fE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=E8/Zd285fVoyaNnbpPBW23u0i5gs2y9FTX/+L5ApSBG2MUNtLcBGKRTjA4bOwrw9m
	 ydrcHBT2LvFYBri3YqeHmVNmdXYaRQphQb0I/8YFDnlcxeITG01Qi0PKZIi6khyImv
	 uHe1QqPFuvbiqk3OiJ02FhXfhw3OfMU+FD6tZPzhAG6EKj8tvuvWtE92Vx9YnoKFB5
	 aYBPYQVRebAaCAJKKJWDSftreSU9mUSb27LlwVxZJWaerUzZpOAUC54fPiuiB93DLV
	 zMIfvJJlyLikMcWvxudjoSCsmgBCH+mujVz8/o1YEJIRAnuUEtj+h4fnT6roGvrHAi
	 HdXIgKaOA6FWA==
Subject: Re: [PATCH net v2 4/9] gve: don't register xsk pool on pre-existing
 queues in RDA mode
From: netdev-bot+sashiko@kernel.org
To: joshwash@google.com
Cc: netdev@vger.kernel.org, hramamurthy@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com,
 willemb@google.com, thostet@google.com, nktgrg@google.com,
 eddiephillips@google.com, pkaligineedi@google.com, jeroendb@google.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 24 Sep 2026 10:46:46 +0000
Message-ID: <179024680611.2160803.12798542968930777994@kernel.org>
In-Reply-To: <20260922194533.631387-5-joshwash@google.com>
References: <20260922194533.631387-5-joshwash@google.com>
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

Critical: 0 · High: 1 (2) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Peer-call-site asymmetry: this patch makes in-place XSK
  registration conditional on gve_is_qpl() in gve_xsk_pool_enable(), but…
- [Medium] In the QPL branch kept by this patch (gve_main.c:1656-1659),
  gve_reg_xsk_pool() publishes the XSK pool into a LIVE queue…

Pre-existing issues:
- [High] gve_xsk_pool_disable()
  (drivers/net/ethernet/google/gve/gve_main.c, ~line 1690-1696 at this…
- [High] NULL-pointer dereference on the error path of
  gve_xsk_pool_enable(): the RDA branch routes a…

--

gve: don't register xsk pool on pre-existing queues in RDA mode

This makes gve_xsk_pool_enable() register the XSK pool in place only for
QPL devices, and rely on the ring reconfiguration in
gve_configure_rings_xdp() for DQO RDA, dropping the now unused
err_xsk_pool_registered unwind label.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 9cc343a162712..b9bcdc7619b23 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1654,20 +1654,18 @@ static int gve_xsk_pool_enable(struct net_device *dev,
>  	if (!priv->xdp_prog || !netif_running(dev))
>  		return 0;
>  
> -	err = gve_reg_xsk_pool(priv, dev, pool, qid);
> -	if (err)
> -		goto err_xsk_pool_dma_mapped;
> -
> -	/* Stop and start RDA queues to repost buffers. */
> -	if (!gve_is_qpl(priv)) {
> +	if (gve_is_qpl(priv)) {
> +		err = gve_reg_xsk_pool(priv, dev, pool, qid);
> +		if (err)
> +			goto err_xsk_pool_dma_mapped;

[Severity: Medium]
Is the QPL branch still exposed to the same class of race the commit
message describes?  gve_reg_xsk_pool() publishes the pool into a queue
that is still being polled, with no NAPI quiescing and no barrier:

gve_main.c:gve_reg_xsk_pool() {
	err = xdp_rxq_info_reg_mem_model(&rx->xdp_rxq,
					 MEM_TYPE_XSK_BUFF_POOL, pool);
	...
	rx->xsk_pool = pool;

	tx_qid = gve_xdp_tx_queue_id(priv, qid);
	priv->tx[tx_qid].xsk_pool = pool;
}

The teardown side treats those same stores as datapath visible state and
brackets them:

gve_main.c:gve_xsk_pool_disable() {
	napi_disable(napi_rx); /* make sure current rx poll is done */
	...
	napi_disable(napi_tx); /* make sure current tx poll is done */

	gve_unreg_xsk_pool(priv, qid);
	smp_mb(); /* Make sure it is visible to the workers on datapath */
	...
}

so the smp_mb() on the disable side has no counterpart on the enable
side.  A concurrent poll in gve_xdp_redirect() reads rx->xsk_pool and
rx->xdp_rxq:

gve_rx.c:gve_xdp_redirect() {
	if (rx->xsk_pool)
		return gve_xsk_pool_redirect(dev, rx, orig->data,
					     len, xdp_prog);
	...
	xdp_init_buff(&new, total_len, &rx->xdp_rxq);
}

Can it observe rx->xsk_pool set before the mem model switch is visible,
or the mem model already switched to MEM_TYPE_XSK_BUFF_POOL while
rx->xsk_pool still reads NULL, so a buffer is freed through the wrong
allocator?

A later patch in this series, "gve: disable NAPI when registering XSK
pools in QPL mode", adds a gve_disable_xsk_napis()/smp_mb()/
gve_enable_xsk_napis() bracket around this call, which would close the
window.  Would it make sense to order that change before this one?

> +	} else {
> +		/* Stop and start RDA queues to repost buffers. */
>  		err = gve_configure_rings_xdp(priv, priv->rx_cfg.num_queues);
>  		if (err)
> -			goto err_xsk_pool_registered;
> +			goto err_xsk_pool_dma_mapped;
>  	}
>  	return 0;
>  
> -err_xsk_pool_registered:
> -	gve_unreg_xsk_pool(priv, qid);
>  err_xsk_pool_dma_mapped:
>  	clear_bit(qid, priv->xsk_pools);

[Severity: High]
This isn't a bug introduced by this patch, since the same clear_bit() was
already reachable through the removed err_xsk_pool_registered label, but
can priv->xsk_pools be NULL here?

The error returned by gve_configure_rings_xdp() can come from a path that
already tore down and reallocated the bitmap:

gve_main.c:gve_queues_stop() {
err:
	if (gve_get_reset_in_progress(priv))
		return err;
	/* Otherwise reset before returning */
	gve_reset_and_teardown(priv, true);
	return gve_reset_recovery(priv, false);
}

gve_main.c:gve_teardown_priv_resources() {
	...
	bitmap_free(priv->xsk_pools);
	priv->xsk_pools = NULL;
}

If the subsequent gve_init_priv() fails (adminq allocation, the
bitmap_zalloc() returning -ENOMEM, or gve_setup_device_resources()
failing and taking the err_free_xsk_bitmap path which re-NULLs the
bitmap), the non-zero error propagates back here with priv->xsk_pools ==
NULL and clear_bit(qid, NULL) faults.

Even when the recovery succeeds, the bitmap is a freshly zeroed
allocation, so bits for other queues whose pools are still DMA mapped are
silently dropped.  Should this path check priv->xsk_pools before clearing
the bit?

> 	xsk_pool_dma_unmap(pool,

[Severity: High]
This is a pre-existing issue rather than something this patch introduces,
but the mirror of the ordering problem fixed here still exists on the
disable side.  gve_xsk_pool_disable() unmaps the pool while the RX
datapath for that queue is still live:

gve_main.c:gve_xsk_pool_disable() {
	clear_bit(qid, priv->xsk_pools);

	pool = xsk_get_pool_from_qid(dev, qid);
	if (pool)
		xsk_pool_dma_unmap(pool,
				   DMA_ATTR_SKIP_CPU_SYNC |
				   DMA_ATTR_WEAK_ORDERING);

	if (!netif_running(dev) || !priv->tx_cfg.num_xdp_queues)
		return 0;
	...
}

rx->xsk_pool is only cleared much later, by the ring restart in
gve_configure_rings_xdp() or by gve_unreg_xsk_pool() after
napi_disable().  In that window the consumer still gates on rx->xsk_pool
alone, not on the priv->xsk_pools bit:

gve_buffer_mgmt_dqo.c:gve_alloc_buffer() {
	if (rx->xsk_pool) {
		buf_state = gve_alloc_buf_state(rx);
		...
		buf_state->xsk_buff = xsk_buff_alloc(rx->xsk_pool);
		...
		desc->buf_addr =
			cpu_to_le64(xsk_buff_xdp_get_dma(buf_state->xsk_buff));
	}
}

Can a concurrent gve_rx_post_buffers_dqo() therefore post descriptors
built from a pool whose dma_pages have already been kvfree()d by
xp_dma_unmap(), i.e. the same failure signature quoted in the commit
message but on the teardown side?  The DQO RDA branch does not stop the
queue until gve_configure_rings_xdp(), which first does a full
gve_queues_mem_alloc(), so the window looks wide.

The later patch "gve: fix NULL dereference from premature XSK pool DMA
unmap" moves this unmap to an unmap_and_return: label that runs only
after the queue has been quiesced.

[Severity: High]
Now that in-place registration is conditional on gve_is_qpl(), should the
unregister in gve_xsk_pool_disable() become conditional too?  It is still
unconditional, and in DQO RDA mode it runs after the rings were already
re-created:

gve_main.c:gve_xsk_pool_disable() {
	clear_bit(qid, priv->xsk_pools);
	...
	if (!gve_is_qpl(priv) && priv->xdp_prog) {
		err = gve_configure_rings_xdp(priv, priv->rx_cfg.num_queues);
		if (err)
			return err;
	}
	...
	gve_unreg_xsk_pool(priv, qid);
	smp_mb(); /* Make sure it is visible to the workers on datapath */
	...
}

Since the qid bit was cleared first, the ring restart registers the page
pool mem model for that queue:

gve_main.c:gve_reg_xdp_info() {
	...
	else
		err = xdp_rxq_info_reg_mem_model(&rx->xdp_rxq,
						 MEM_TYPE_PAGE_POOL,
						 rx->dqo.page_pool);
}

and gve_unreg_xsk_pool() is mode agnostic:

gve_main.c:gve_unreg_xsk_pool() {
	rx->xsk_pool = NULL;
	if (xdp_rxq_info_is_reg(&rx->xdp_rxq))
		xdp_rxq_info_unreg_mem_model(&rx->xdp_rxq);
	...
}

Does this end up calling page_pool_destroy() on the page pool that the
running queue is still allocating from, with the ring teardown later
destroying the same pool again?

The final state of this series drops the unconditional call, using
gve_unreg_xsk_pool_live() only for gve_is_qpl(priv) and
gve_restart_rings() for RDA, in "gve: ensure XDP mem model is registered
when disabling XSK pools".

>  	xsk_pool_dma_unmap(pool,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922194533.631387-1-joshwash%40google.com
