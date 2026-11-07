Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794052860;
	b=sgYSApAuwWgjXibfiJZRFp2Xh8Cgj4mz96buWxG8B4M77Inj4ygI1Hv+qOlM4CT1AKI3
	 QBCLGBpTM0DXVa5G0uqhw5AFfNXdXScsB+mnTh3TygxChDqblPVn9MFYkwGigWYjfsT/l
	 UzYvSYPwg3SYmkIFw52OoQ8UxS/Y8QuDCCxYLAIG9XIeDhCYdLaXeqJw3L8PXz6dmVOeQ
	 b8Uzybu+lp3nZZWgR8WLFHkGApT7eUWH0sE+rEQC1nWJHqBRaG5VTn/+7VfGxTYq67Kj6
	 ZzY9lXK3O2s/W+quycRrqIcjsCD/eaMMUeo5GPqYr+YGOOqOYnqQYty83Q8GOfRREXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794052860;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wmkOVTO6/HcciH7e0IPrV6/8aI7VC/wYHlVJ4GKyU2E=;
	b=cp/BItP4+eWauimog9EUDqXi8GY2JY33SgCPlvyhaP57Ukza65vd/6Uj5/VR4RjP47sh
	 YD+NxNokYce8IQET3zikUZxbb6LRKOvesrvbOYcitWXc5LCZVLwjiIGfxn6TxQyesVN8A
	 KHy9yxc5QLvkCKldNU6dAA4924p16ecagYEraXSrdiypyLxEpMmkCB3p9TtDe0BciLWeJ
	 D+LM3zxtOTu0PVHKcIWms2lLLTdDqtq74C0oZcJFdw+Vfvz87FToF6DtfufO8oYEZRcqw
	 YO/SVZpJUG7lXNIq9ao58V5xbj60GjbhrppXzz5DhoS8IahoeI/ypLhjtJa6pxphymw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WtwMqNKz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441CC606A326;
	Sat,  7 Nov 2026 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WtwMqNKz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E7A1F008A1;
	Sat,  7 Nov 2026 12:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794052859;
	bh=wmkOVTO6/HcciH7e0IPrV6/8aI7VC/wYHlVJ4GKyU2E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WtwMqNKz0FGtXDFPhkQFgSodpjMHv0P3NcjzE5y3oFhAZ8GJDEE9KuvBRft/ejWK0
	 b4p4rRPqrvbvZSBr4hwm43JCJctHeEqGEdYEqxdeU2LNqBuVQJBqLNNJ+UMaG2RVLi
	 R1F5Yu3cMKPfpTN9TBYH8UkVSZucQdtGHH5uU8lr4XLSBXVT7BKkyBtfoO/8joR2ia
	 VDM7dOoeCW433BS8xj/1o0eBNozNLARHATtQK0qrKqzCZkZiK3UqHUd4c5NEFP4JWn
	 15d81Rhgf6ESMxErI1d8GCujs26WscPth6T8wnZacc+yJX1DItwvz0vp8DNE30R9GK
	 BTJD+4J12ITnQ==
Subject: Re: [PATCH] net: mvpp2: free pending TX timestamp skbs when the port
 is stopped
From: netdev-bot+sashiko@kernel.org
To: vulab@iscas.ac.cn
Cc: marcin.s.wojtas@gmail.com, linux@armlinux.org.uk, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 07 Nov 2026 12:00:58 +0000
Message-ID: <179405285872.994134.2557194195988942800@kernel.org>
In-Reply-To: <20261103100535.1310088-1-vulab@iscas.ac.cn>
References: <20261103100535.1310088-1-vulab@iscas.ac.cn>
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new mvpp2_tx_hwtstamp_flush()
  (drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:3422-3436) checks,…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is a
  serious race on the same data.
- [Low] Baseline decision: not a valid finding against this patch.

--

net: mvpp2: free pending TX timestamp skbs when the port is stopped

This commit adds mvpp2_tx_hwtstamp_flush(). It frees any skbs still held
in port->tx_hwtstamp_queue[] that are waiting for a hardware TX timestamp.
It is called from mvpp2_stop() after the port interrupts have been
released, so the extra references taken by mvpp2_tx_hw_tstamp() are not
leaked.

> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 317af54369cfe..fc020b8c88301 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -3419,6 +3419,22 @@ static void mvpp2_isr_handle_ptp(struct mvpp2_port *port)
>  		mvpp2_isr_handle_ptp_queue(port, 1);
>  }
>  
> +static void mvpp2_tx_hwtstamp_flush(struct mvpp2_port *port)
> +{
> +	struct mvpp2_hwtstamp_queue *queue;
> +	int nq, i;
> +
> +	for (nq = 0; nq < ARRAY_SIZE(port->tx_hwtstamp_queue); nq++) {
> +		queue = &port->tx_hwtstamp_queue[nq];
> +		for (i = 0; i < ARRAY_SIZE(queue->skb); i++) {
> +			if (!queue->skb[i])
> +				continue;
> +			dev_kfree_skb_any(queue->skb[i]);
> +			queue->skb[i] = NULL;

[Severity: High]
Can this race with mvpp2_tx_hw_tstamp() on another CPU and free the same
skb twice?

mvpp2_stop() is not only reached through ndo_stop, where
__dev_close_many() has already quiesced TX. It is also called directly
on running devices:

mvpp2_xdp_setup():
	if (running && reset)
		mvpp2_stop(port->dev);

mvpp2_change_mtu()->mvpp2_bm_switch_buffers():
	for (i = 0; i < priv->port_count; i++) {
		port = priv->port_list[i];
		status[i] = netif_running(port->dev);
		if (status[i])
			mvpp2_stop(port->dev);
	}

The second path stops every running port on the controller, including
ports whose MTU did not change.

mvpp2_stop_dev() does set_bit(0, &port->state), which mvpp2_tx() never
checks. It also disables interrupts and NAPI and calls phylink_stop().

The only TX gating is netif_tx_stop_all_queues() in mvpp2_mac_link_down().
It does not wait for an mvpp2_tx() that is already running on another
CPU. On ports without phylink, the TX queues are not stopped at all.

Meanwhile the xmit path works on the same array:

mvpp2_tx_hw_tstamp():
	i = queue->next;
	queue->next = (i + 1) & 31;
	if (queue->skb[i])
		dev_kfree_skb_any(queue->skb[i]);
	queue->skb[i] = skb_get(skb);

Suppose the flush and an in-flight xmit both see the same skb in skb[i].
Both would then call dev_kfree_skb_any() on it. TX completion has already
dropped the stack's reference, so that skb only holds the skb_get()
reference.

On phylink ports the window is limited to an xmit that started before
netif_tx_stop_all_queues(). That window is not bounded on PREEMPT_RT.
mvpp2_cleanup_txqs() already has the same missing TX quiescence on these
paths, but the flush adds a new unsynchronized writer.

Should TX be quiesced before mvpp2_tx_hwtstamp_flush() runs on these
paths?

[Severity: High]
This isn't a bug introduced by this patch, but concurrent transmits also
do not appear to protect this per-port array.

port->tx_hwtstamp_queue[] and its next index are per-port. mvpp2 is not
LLTX, so the core holds only the per-txq lock. XPS maps each CPU to its
own txq, so mvpp2_tx() can run on several CPUs at once.

The only driver lock in mvpp2_tx() is conditional and per-thread:

	if (test_bit(thread, &port->priv->lock_map))
		spin_lock_irqsave(&port->tx_lock[thread], flags);

That lock does not serialize two threads in mvpp2_tx_hw_tstamp().

If two CPUs read the same queue->next value while skb[i] holds a pending
skb, could both call dev_kfree_skb_any() on it? If skb[i] is NULL, one
skb_get() reference would be overwritten, and that skb and its socket
write memory would be leaked.

The slot-reuse free in mvpp2_tx_hw_tstamp() also looks like it can race
with the consumer in mvpp2_isr_handle_ptp_queue():

	skb = queue->skb[id];
	queue->skb[id] = NULL;
	if (skb) {

Once TX HW timestamping is enabled on the port, a process without any
capability can set SO_TIMESTAMPING with SOF_TIMESTAMPING_TX_HARDWARE and
send PTP frames from several CPUs.

The new flush adds another unlocked accessor to this array.

> +		}
> +	}
> +}
> +

[ ... ]

> @@ -4914,6 +4930,7 @@ static int mvpp2_stop(struct net_device *dev)
>  		free_irq(port->port_irq, port);
>  
>  	mvpp2_irqs_deinit(port);
> +	mvpp2_tx_hwtstamp_flush(port);

[Severity: Low]
This is a pre-existing issue, but the stop path does not touch the
hardware PTP TX result FIFOs (MVPP22_PTP_TX_Q0_R0..R2 and the Q1
equivalents). It also does not reset queue->next.

A stale record for a reused slot could be matched to a new skb after
reopen. That happens the same way with or without this patch. In
practice, mvpp2_open() normally drains latched PTP causes before TX
restarts.

The effect specific to this patch is smaller. Some timestamps have
already been captured by the hardware but not yet read when the port
stops. Those records now find a NULL slot in mvpp2_isr_handle_ptp_queue()
and are dropped, instead of being delivered to the original skb.

Would it make sense to drain both hardware queues with
mvpp2_isr_handle_ptp_queue() before freeing the remaining skbs here?

>  	if (!port->has_tx_irqs) {
>  		for (thread = 0; thread < port->priv->nthreads; thread++) {
>  			port_pcpu = per_cpu_ptr(port->pcpu, thread);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103100535.1310088-1-vulab%40iscas.ac.cn
