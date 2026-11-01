Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793505680;
	b=GLjBhJ9gz5iALdpmFEkdOvJZL512VciMTy4bKxk13vviUvj22rXpsEelGIJ1bG6og0sv
	 ROh4eCWtKNnd/ydfuzFzK4Xe/68hJKnwUxjVfWJ5sAtCYNsIBgA2bj0w+UPJfaESAlsjm
	 9BXPSQsWpA6kDI0D4y6X5SEoGO5m/O64+Slg0v9MG7VPcShDZ/Y905qeOHtDNFUigXyE3
	 i7RiBLdsqE1gFfW8f3y6vrEV/oJHQymraKJst3IugNLojEJaTZWJzz/zr0uptYqZR5xMb
	 ABpBN2qWRPXQ9zWYZ2khQQMvuio9Oz28efLCG2sWtOfx9p8fZXhGVLsl3batBWVd9sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793505680;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=d8Ignv/TrOiP/x5uaPouN/8qUwlCqRjsjKmrlzgZtfg=;
	b=rH8rfFi1Mldrv/SNJH8F4DdCZJNvP3GYWOMgbnzJthsW11OaGfW2dg8sk+HWDkUGlUWt
	 +UAD4eMxCfWnXJ9kygbl+3cNZ5hlmqin5/e+Y/ywbsHtusqmybzt5LyTm3/dmVhTfdq4r
	 qmydU0apOorOpcUbxGZXeuJB5MczbPAQW7R5pT68qerTcOJn2nIpNfEy9mlO8f/b+ZVQ9
	 CSFULdDeY7VHmn/RWK2jEDDS494LaW2lLMck2mo/YlLlQnBfg8coFo7qvrFC/DY1J8f2Q
	 rF+0Eu4kMEuN3Uyf6vkIVq+1PY20r10Au9zDGie1u6RgkBULWrl2Tiq6Z5rNYEc1uBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mqGwie8P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DEE606A324;
	Sun,  1 Nov 2026 04:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mqGwie8P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BFD1F000C1;
	Sun,  1 Nov 2026 04:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793505680;
	bh=d8Ignv/TrOiP/x5uaPouN/8qUwlCqRjsjKmrlzgZtfg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mqGwie8PoUBxpDe/q2jSMrm0QGvyRuFvzsiqT2K3dNDFXyF764M4DzqiuQn4uU5X7
	 eYYnarHmZEBNkSbOvrx2Exa5j1omW+kX2XA4XhtJ6YW4cB6a1A4am7+a3Hha4oAeRs
	 nSHxnJ+N4/AXVz6MSEuxDrqW+W27zBT7oMrGNnn/AFt6G7+YZF6xaXuqdnSNu6XUax
	 OwmFreYRreoXM/6U/fBOp1PpctNDGwTnYxyzPMNhRuQWnbPQ6AeH6RgJOVUufK4rm4
	 1rZzs20iM9UCL00Da513DEFD4htLKWk81FUqybOsygCTykivUavaZArDiOzpknSvSp
	 zuJXz95jHCoMQ==
Subject: Re: [PATCH net] net: atlantic: stop TX again before freeing rings
From: netdev-bot+sashiko@kernel.org
To: hanson.wang@ugreen.com
Cc: netdev@vger.kernel.org, irusskikh@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 stable@vger.kernel.org
Date: Sun, 01 Nov 2026 04:01:19 +0000
Message-ID: <179350567901.3131.3548905905691532250@kernel.org>
In-Reply-To: <20261031032308.2991494-1-hanson.wang@ugreen.com>
References: <20261031032308.2991494-1-hanson.wang@ugreen.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 (1) · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix depends on the TX queue stopped bit set by the new
  second netif_tx_disable() in aq_nic_stop() (aq_nic.c:1454).

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but
  aq_xdp_xmit() (aq_ring.c:416) never checks that the NIC's TX rings…

--

net: atlantic: stop TX again before freeing rings

This patch adds a second netif_tx_disable() and netif_carrier_off() at the
end of aq_nic_stop(). They run after the service work, IRQs and NAPI have
been torn down. The aim is to keep SKB transmits out of rings that
aq_nic_deinit() is about to free during the driver-internal close/open done
by ndo_set_features, ethtool ring changes and XDP setup.

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> index 42e0fe9248f28..a6ceec0a22dac 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> @@ -1448,6 +1448,12 @@ int aq_nic_stop(struct aq_nic_s *self)
>  
>  	aq_ptp_ring_stop(self);
>  
> +	/* Link updates and TX completion may have woken queues after the
> +	 * first disable. Drain SKB transmit again before the rings are freed.
> +	 */
> +	netif_tx_disable(self->ndev);
> +	netif_carrier_off(self->ndev);

[Severity: High]

Can the driver's own ndo_xdp_xmit path clear the stopped bit again after
this netif_tx_disable()?

The commit message says "the stopped bit then keeps later SKB transmits
out". It describes ndo_xdp_xmit only as a path that "is not covered".

aq_nic_ndev_init() always advertises NETDEV_XDP_ACT_NDO_XMIT. During the
internal close done by aq_ndev_set_features(), aq_set_ringparam() and
aq_xdp_setup(), the device stays IFF_UP. So a frame redirected from another
NIC can still reach aq_xdp_xmit()->aq_nic_xmit_xdpf(), which does:

aq_nic_xmit_xdpf() {
	...
	__netif_tx_lock(nq, cpu);

	aq_ring_update_queue_state(tx_ring);

	/* Above status update may stop the queue. Check this. */
	if (__netif_subqueue_stopped(aq_nic_get_ndev(aq_nic), queue_index))
		goto out;
	...
}

aq_ring_update_queue_state() only looks at descriptor accounting:

aq_ring_update_queue_state() {
	if (aq_ring_avail_dx(ring) <= AQ_CFG_SKB_FRAGS_MAX)
		aq_ring_queue_stop(ring);
	else if (aq_ring_avail_dx(ring) > AQ_CFG_RESTART_DESC_THRES)
		aq_ring_queue_wake(ring);
}

A stopped, drained ring has plenty of free descriptors. So this calls
aq_ring_queue_wake()->netif_wake_subqueue(), which clears the stopped bit
and reschedules the qdisc.

Suppose one redirected frame arrives after this new netif_tx_disable() but
before aq_ring_free() in aq_nic_deinit(). That window includes hw_stop(),
with its descriptor cache poll of up to 10 ms, and aq_vec_deinit().

Wouldn't the next qdisc or IGMP timer transmit then pass the stopped check
in sch_direct_xmit() and reach aq_nic_xmit()->aq_nic_map_skb() with
buff_ring == NULL?

That looks like the same NULL + sw_tail store as the oops in the changelog.
An SKB that gets in before the free could also race with
aq_ring_tx_deinit(), which walks buff_ring without a lock.

The driver clears the stopped bit itself, so a second netif_tx_disable()
doesn't seem to be enough. Would one of these be needed instead?

- a driver-side running or rings-valid check in the xmit paths
- skipping the wake in aq_ring_update_queue_state() during close
- netif_device_detach()/netif_device_attach() around the internal
  close/open

[Severity: Critical]

This is a pre-existing issue and was not introduced by this patch, but
aq_xdp_xmit() never checks that the TX rings exist before it uses them:

aq_xdp_xmit() {
	...
	ring = aq_nic->aq_ring_tx[AQ_NIC_CFG_TCVEC2RING(aq_cfg, 0, vec)];
	...
}

In the set_features and xdp_setup close windows, aq_ring_free() has set
buff_ring to NULL, but aq_ring_tx[] still points at the ring structs. After
the wake described above, aq_nic_map_xdp() writes through
&ring->buff_ring[ring->sw_tail]:

	dx = ring->sw_tail;
	dx_buff = &ring->buff_ring[dx];
	dx_buff->flags = 0U;

Is that a NULL + offset write?

The aq_set_ringparam() path looks worse:

aq_set_ringparam() {
	...
	err = aq_nic_realloc_vectors(aq_nic);
	if (err)
		goto err_exit;

	if (ndev_running)
		err = aq_ndev_open(ndev);
	...
}

aq_nic_realloc_vectors()->aq_nic_free_vectors()->aq_vec_free() calls
kfree() on each aq_vec, and struct aq_ring_s is embedded in struct aq_vec_s.

aq_ring_tx[] is never cleared. It is set only by aq_vec_ring_alloc() via
aq_nic_set_tx_ring(), which runs at the next aq_nic_init().

Between the realloc and the reopen, can redirected XDP frames read and write
freed aq_vec memory through aq_ring_tx[]? That would include
ring->stats.tx.queue_restarts, the buff_ring/sw_tail state in
aq_nic_map_xdp(), and the hw_ring_tx_xmit() updates.

If aq_nic_realloc_vectors() or aq_ndev_open() fails, the device stays
IFF_UP, so that window never closes.

>  	return self->aq_hw_ops->hw_stop(self->aq_hw);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261031032308.2991494-1-hanson.wang%40ugreen.com
