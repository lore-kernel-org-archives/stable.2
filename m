Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654320;
	b=TMI9E6FS+7Fg7MixsQv2pusiR0WeiYJqoWCBzMTw14E0c/6IWFMM3WoSp5ASsJL2usXo
	 IC2iJMNbqJOm/GEBwNs+2IRdiJ4VNgniKMWlTfzuMr82po9ofKOZyGVmq3ci75V/qWYLw
	 luABtVlkDT6oUUCrDQ5BrxB9kUvTfFzcmNZ07WT9w+W3PXfCI+9Qgk6HsIPpVpVYXcXK6
	 n1f7xyoY97Dtv0sovcLnSbFGCngzxy26F0FauGD+ejZ3+f9MKfyWLuC39uPTj8t91cN8K
	 897+BD+eSHFIvIiFv21srAjhvcZlpXbRmjml8LsfAb8WF4vNHiDqSaPFoDXWcEUhtVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654320;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=rl48m3jJ2xS06P2qcXQwJOKm4gx7uXbMxJVDiFVFToc=;
	b=oF6CNL+/8D8ZjcbY67paGy2OSDWppysg/iyLtpkTpQMeFxzEKp77p7STusbGD7FP35Us
	 x4Lnj9d5zN1zlUJgD16CAgezj2RqgwfO9fzc3928zMedJPtOu+Svtn0BevbsJbc5AZG/V
	 RLuA3yGMUShdF2BFvFneRk6zLfSm7nf7+auV5M5og2FIiGNqXPTrgmestIL5QDVe0FSgv
	 mX5uIfAvew1dVtNpbj+Bo5qJxZNHMQFOJpTZpBTvv2JD+TtGnfcv+gm5ehx8HN6IEBm6M
	 r1XwavhQ9+gaMufyX2SeOXPzm6svUDSuoKuYRvJuN4pPRe0shaUy3G7cBFWYeshGGOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bT+xlbfB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C1F606A324;
	Mon,  2 Nov 2026 21:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bT+xlbfB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028691F00A16;
	Mon,  2 Nov 2026 21:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793654320;
	bh=rl48m3jJ2xS06P2qcXQwJOKm4gx7uXbMxJVDiFVFToc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bT+xlbfBZeKxg9jB6Os+0UWar1+NsVt2A4p9JfvYQcMvvagwgqek6qF9u/p6JM34K
	 zUWSCjdCWzQv1hB8TvwuV5+GzwNI1ag6SJGFecGGJDXo7JXX7JI/I0E/O0l1yUtCTP
	 K0baDvd34ZOPyYhXY8p/jYinaqCIpPdiZMuShKodxiZLV1fYryIKSIbh2+76UiIt10
	 7AG7DLqPvq4lmEzlO9Z59wZ8SyHaNlYdRLZeXhCH2Gwn1u2Sjamcix/umdoXWbvXbK
	 UfbODVVM48cdqqKc4PPm1TqrVyzS2sIAXPwhpuQP/vgwTrngPGjU4not8ZMUuaQzLT
	 MKJtyQ5Osz7zA==
Subject:
 Re: [PATCH net v4 1/4] gve: Fix race between stats query and queue reconfig
From: netdev-bot+sashiko@kernel.org
To: hramamurthy@google.com
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 jordanrhee@google.com, willemb@google.com, przemyslaw.kitszel@intel.com,
 nktgrg@google.com, maolson@google.com, jacob.e.keller@intel.com,
 pkaligineedi@google.com, yangchun@google.com, patricion@google.com,
 awogbemila@google.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 treapking@google.com
Date: Mon, 02 Nov 2026 21:18:38 +0000
Message-ID: <179365431852.3131.15974768163319773656@kernel.org>
In-Reply-To: <20261029211634.2232784-2-hramamurthy@google.com>
References: <20261029211634.2232784-2-hramamurthy@google.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] At this commit, the new priv->stats_lock is not taken by the
  single-queue (queue-mgmt API) writers of priv->rx[idx].
- [Medium] At this commit, the device-level qstats totals drop to 0 once
  the interface is down.

--

gve: Fix race between stats query and queue reconfig

This commit adds priv->stats_lock to serialize the stats readers
(gve_get_stats(), gve_handle_report_stats() and the per-queue qstats
callbacks) against queue teardown in gve_queues_mem_remove(). Queue
pointers are now cleared under the lock before the ring memory is freed.
The per-queue callbacks also return early when priv->rx or priv->tx is
NULL.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 2437cd8ba6331..26fdd22644f4d 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -69,6 +69,7 @@ static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
>  	int num_tx_queues;
>  	int ring;
>  
> +	spin_lock_bh(&priv->stats_lock);
>  	num_tx_queues = gve_num_tx_queues(priv);
>  	if (priv->rx) {
>  		for (ring = 0; ring < priv->rx_cfg.num_queues; ring++) {

[Severity: Medium]
Does stats_lock cover every writer of priv->rx[idx]? The single-queue
restart path still rewrites the ring contents without taking the lock,
and priv->rx stays non-NULL the whole time:

drivers/net/ethernet/google/gve/gve_main.c:gve_rx_queue_stop() {
    ...
	gve_per_q_mem = (struct gve_rx_ring *)per_q_mem;
	*gve_per_q_mem = priv->rx[idx];
	memset(&priv->rx[idx], 0, sizeof(priv->rx[idx]));
	return 0;
}

drivers/net/ethernet/google/gve/gve_main.c:gve_rx_queue_start() {
    ...
	gve_per_q_mem = (struct gve_rx_ring *)per_q_mem;
	priv->rx[idx] = *gve_per_q_mem;
    ...
abort:
    ...
	memset(&priv->rx[idx], 0, sizeof(priv->rx[idx]));
	return err;
}

These run under rtnl and the instance lock. gve_get_stats() (via
ndo_get_stats64) and gve_handle_report_stats() (from the stats report
worker) hold neither of those. They only take stats_lock.

Suppose a devmem, XSK or page-pool queue restart races with a read of
/proc/net/dev or with the stats report worker. Could the reader then see
a partly copied or zeroed ring, including its statss? It would then
report torn rpackets, rbytes, desc.seqno or fill_cnt values.

The readers only copy scalar counters, so this looks like wrong
statistics, not memory corruption.

The later patch in this series, "gve: Fix backward stats when interface
goes down or configuration is adjusted", wraps these writes in
spin_lock_bh(&priv->stats_lock). This patch is tagged for stable. Would
it make sense to move that part into this patch?

[ ... ]

> @@ -2786,9 +2796,15 @@ static void gve_get_rx_queue_stats(struct net_device *dev, int idx,
>  				   struct netdev_queue_stats_rx *rx_stats)
>  {
>  	struct gve_priv *priv = netdev_priv(dev);
> -	struct gve_rx_ring *rx = &priv->rx[idx];
> +	struct gve_rx_ring *rx;
>  	unsigned int start;
>  
> +	spin_lock_bh(&priv->stats_lock);
> +	if (!priv->rx)
> +		goto unlock;
> +

[Severity: Medium]
When the interface is down, this early return (and the matching one in
gve_get_tx_queue_stats()) leaves rx_stats and tx_stats untouched.
netdev_nl_stats_add() then skips them as NETDEV_STAT_NOT_SET. At this
commit gve_get_base_stats() still reports zero:

static void gve_get_base_stats(struct net_device *dev,
			       struct netdev_queue_stats_rx *rx,
			       struct netdev_queue_stats_tx *tx)
{
	rx->packets = 0;
	rx->bytes = 0;
	rx->alloc_fail = 0;

	tx->packets = 0;
	tx->bytes = 0;
}

After some traffic and then ip link set dev down, does the device-level
qstats total drop from the live counters to 0? That looks like it would
still fail check_down() in tools/testing/selftests/drivers/net/stats.py.
That check requires every qstats key to be non-decreasing across ifdown.

The NULL dereference is fixed, but the totals now go backwards. The next
patch in the series, "gve: Fix backward stats when interface goes down
or configuration is adjusted", seems to fix this. It folds the ring
counters into priv->base_net_stats and priv->base_ring_err_stats in
gve_queues_mem_remove() and reports them from gve_get_base_stats().

Given the stable tag, is it intended that this patch alone leaves the
qstats totals non-monotonic across ifdown?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029211634.2232784-1-hramamurthy%40google.com
