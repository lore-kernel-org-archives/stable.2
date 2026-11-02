Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654322;
	b=bNP3FOfjpaAxSEYO6Xnnx2QUuWZZ6yRULio+RKzfLeKvY/z6CtpViiU3MZeAA+mXx3qp
	 JCqCiJVNwsYvHTmr+/P+y+gF27s8UFVscTwekxH1In4cxEWF+69bKlhEPAhcz9G2qyRkn
	 88bJM7kARtOMBxkwD09RQ1reojE68odZuJ4mJDQblvZrMBGxAGnlIDNW4TwzdnwNr7LQe
	 pQBsy6loRnLj2055LC5QrmeHl3D7b4/loMCErnRR7EYtrKvdKR3pyDTjBEX3EW91OVEhp
	 mdKfiK6ARxm+9d203rUXa6lYPtuvekYOhcwh/uCBqCWZvC5jRd2s3sx0EAsrEJ84ejg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654322;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=iK0bBm29YrOPAyq71JAOJajUy7iZCEfkMr1yytTGjtU=;
	b=R/A5WvDk3lKM2OYbzJWwq6QRxXcR2jRcpdFd3y+AqTa527ENZEzWzqn6xUDRWh+zmzrl
	 vRzKws4hb0yroRTjp+KM2954+5KZNTp6PpUJTRhM7sXQFnwjXuFblYxTgFDm7KBYzL6oJ
	 HmBPNpjzL8qnaqp8ZMYOWcGIKAiegYaKjk8tIG6Fkc3nK6JQzusdhBNqOsI5Q0bIMdgzI
	 0/rjiD6JKB1uYPPSRlr/aAccRjj3YCgdgmu61oMjJnjWavZRmkWU0R+LnFtY84ZqLQrag
	 BeQesWmnu1F5Fk8mgkRnX5VcvE68PP1M8njgI6c/f7136ECFnsa+J7eGiyVEgC3vYgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XtGdxjy0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247CE606A32F;
	Mon,  2 Nov 2026 21:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XtGdxjy0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06481F00A16;
	Mon,  2 Nov 2026 21:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793654321;
	bh=iK0bBm29YrOPAyq71JAOJajUy7iZCEfkMr1yytTGjtU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XtGdxjy0L3RwgVzTgMKbe38DuMMj4W/ecDyE+/gXtvtD1JUtjDcFlmKdJRpWSFg6O
	 2nPjMExsBhUqfoXLLDmeT5kL3Dnuq/anmLSSgOG5ThhwsA9CogR6f2GIUamN6p8kXV
	 OFNcNXtAQp+Lk/XREFtDmr0/Rx1of9nGqXsAjnJ9IjNN8PV82iV+DMwOZO1PUgiqDu
	 Zs/4f57vxfxjGZUXaI1fgTq2otkbv6eTGVVG8gpbzlUZj301T3uaIXkyUQ5EC/7k8y
	 C0FaB3+dROjM6VtGd5EpPXGPLdC9GtL0GI403KW7xIWuCOK9Hl04tCrsbTl6clRCzj
	 d0I6DJPhJ+RjQ==
Subject: Re: [PATCH net v4 2/4] gve: Fix backward stats when interface goes
 down or configuration is adjusted
From: netdev-bot+sashiko@kernel.org
To: hramamurthy@google.com
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 jordanrhee@google.com, willemb@google.com, przemyslaw.kitszel@intel.com,
 nktgrg@google.com, maolson@google.com, jacob.e.keller@intel.com,
 pkaligineedi@google.com, yangchun@google.com, patricion@google.com,
 awogbemila@google.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 treapking@google.com
Date: Mon, 02 Nov 2026 21:18:40 +0000
Message-ID: <179365432027.3131.11809571157881551820@kernel.org>
In-Reply-To: <20261029211634.2232784-3-hramamurthy@google.com>
References: <20261029211634.2232784-3-hramamurthy@google.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message and the Fixes tag describe only part of what
  the patch changes.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but on 32-bit
  SMP kernels tx->statss of an XDP TX ring has writers that are not…
- [Low] This problem wasn't introduced by this patch, but check_down() in
  tools/testing/selftests/drivers/net/stats.py has the docstring "Test…
- [Low] This problem wasn't introduced by this patch, but
  pkt_byte_sum.stat_cmp() in…
- [Low] This problem wasn't introduced by this patch, but the single-
  queue RX restart path never calls u64_stats_init() on the new ring's…
- [Low] This problem wasn't introduced by this patch, but
  gve_rx_post_buffers_dqo() updates rx->statss (rx_buf_alloc_fail)…

--

gve: Fix backward stats when interface goes down or configuration is adjusted

This patch keeps baseline rx/tx packet, byte and alloc-fail counters in
gve_priv. They are saved during full queue teardown in
gve_queues_mem_remove() and during a single RX queue stop in
gve_rx_queue_stop(). Both ndo_get_stats64 and the netdev_stat_ops base
stats report these baselines, and gve_get_base_stats() also reports the
live XDP TX ring counters.

> gve_get_base_stats() sets all the stats to 0, so the stats go backwards
> when interface goes down or configuration is adjusted.

[ ... ]

> Fixes: 2e5e0932dff5 ("gve: add support for basic queue stats")

[Severity: Low]

Does this description cover everything the patch changes? The message
blames gve_get_base_stats(). The patch also changes ndo_get_stats64:
gve_get_stats() now calls gve_add_base_stats().

That part fixes an older bug. In the tree before 2e5e0932dff5,
gve_close() already freed the rings on every ifdown:

gve_close()
    gve_queues_stop(priv);
    gve_queues_mem_remove(priv);

gve_queues_mem_remove() set priv->tx and priv->rx to NULL, and
gve_get_stats() only summed the live rings. So the ip -s link and
/proc/net/dev counters already went back to 0 on ifdown.
Documentation/networking/statistics.rst says:

  Statistics must persist across routine operations like bringing the
  interface down and up.

Could the changelog mention the rtnl counter change, and could the
Fixes: tag be revisited? With the current tag, stable backporters may
treat trees without netdev_stat_ops (older than 6.13) as unaffected,
even though they have the rtnl reset on ifdown.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 26fdd22644f4d..b5e2f39a903c5 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c

[ ... ]

> @@ -84,19 +112,41 @@ static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)

[ ... ]

> +static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
> +{
> +	struct gve_priv *priv = netdev_priv(dev);
> +
> +	spin_lock_bh(&priv->stats_lock);
> +	gve_get_ring_stats(priv, s);
> +	gve_add_base_stats(priv, s);
>  	spin_unlock_bh(&priv->stats_lock);
>  }

[Severity: Low]

This is a pre-existing issue and was not introduced by this patch. The
commit message cites the check_down test case in
tools/testing/selftests/drivers/net/stats.py. Its docstring says:

    """ Test statistics (interface and qstat) are not impacted by ifdown """

However, check_down() only compares qstats from netfam.qstats_get()
before and after ip link set down. It never reads the rtnl stats64.

If the new gve_add_base_stats() call in gve_get_stats() regressed,
wouldn't check_down() still pass?

[ ... ]

> @@ -2744,7 +2809,9 @@ static int gve_rx_queue_start(struct net_device *dev,
>  		return -EAGAIN;
>  
>  	gve_per_q_mem = (struct gve_rx_ring *)per_q_mem;
> +	spin_lock_bh(&priv->stats_lock);
>  	priv->rx[idx] = *gve_per_q_mem;
> +	spin_unlock_bh(&priv->stats_lock);

[Severity: Low]

This isn't a bug introduced by this patch, but is rx->statss ever
initialized on the single-queue restart path?

gve_rx_queue_mem_alloc() calls gve_rx_alloc_ring_gqi() or
gve_rx_alloc_ring_dqo(), which zero the ring. The only u64_stats_init()
calls for RX rings are in gve_init_sync_stats():

	for (i = 0; i < priv->rx_cfg.num_queues; i++)
		u64_stats_init(&priv->rx[i].statss);

That function only runs on a full queue start. gve_rx_queue_start() then
copies the uninitialized statss into priv->rx[idx].

On 32-bit kernels with CONFIG_DEBUG_LOCK_ALLOC, the seqcount's lockdep
map is never initialized. Can later stats updates or reads then trigger
lockdep warnings? The stats_lock added around this copy doesn't change
that.

[Severity: Low]

This is also a pre-existing issue and not introduced by this patch. Later
in gve_rx_queue_start(), the DQO path calls gve_rx_post_buffers_dqo()
from preemptible process context:

	else
		gve_rx_post_buffers_dqo(&priv->rx[idx]);

When a buffer allocation fails, that function writes rx->statss:

		if (unlikely(gve_alloc_buffer(rx, desc))) {
			u64_stats_update_begin(&rx->statss);
			rx->rx_buf_alloc_fail++;
			u64_stats_update_end(&rx->statss);

On 32-bit non-RT kernels, __u64_stats_update_begin() uses
preempt_disable_nested(). That only asserts that preemption is already
disabled; it does not disable it.

If the writer is preempted while the sequence is odd, can a reader on
the same CPU spin until the writer runs again? gve_get_stats() under
spin_lock_bh(&priv->stats_lock) is one such reader. Lockdep builds would
also warn here. gve_create_rings() reaches the same code regardless of
this patch.

[ ... ]

> @@ -2844,12 +2913,30 @@ static void gve_get_base_stats(struct net_device *dev,
>  			       struct netdev_queue_stats_rx *rx,
>  			       struct netdev_queue_stats_tx *tx)
>  {

[ ... ]

> +	tx->packets = base_stats->tx_packets;
> +	tx->bytes = base_stats->tx_bytes;
> +	/* XDP TX rings are not exposed as netdev queues, so report their live
> +	 * counters here to keep the device totals consistent with
> +	 * ndo_get_stats64.
> +	 */
> +	if (priv->tx)
> +		gve_add_tx_ring_range_stats(priv, priv->tx_cfg.num_queues,
> +					    gve_num_tx_queues(priv),
> +					    &tx->packets, &tx->bytes);
> +	spin_unlock_bh(&priv->stats_lock);
>  }

[Severity: Low]

This is a pre-existing issue in the selftest and was not introduced by
this patch. Does pkt_byte_sum() in stats.py really check that these
totals match ndo_get_stats64? stat_cmp() returns at the first key that
differs:

    def stat_cmp(rstat, qstat):
        for key in ['tx-packets', 'tx-bytes', 'rx-packets', 'rx-bytes']:
            if rstat[key] != qstat[key]:
                return rstat[key] - qstat[key]
        return 0

With live TX traffic, a correctly increasing tx-packets decides the
result before tx-bytes or the RX counters are compared. The test can
therefore pass while rtnl and qstats disagree in the later fields. That
includes the XDP TX contribution added here.

[Severity: Medium]

This isn't a bug introduced by this patch, but are the writers of
tx->statss on the XDP TX rings serialized on 32-bit SMP kernels?

gve_xdp_xmit_dqo() picks the ring as smp_processor_id() %
num_xdp_queues, so several CPUs can share one ring. It updates statss
after releasing the lock that serializes those CPUs:

	spin_unlock(&tx->dqo_tx.xdp_lock);

	u64_stats_update_begin(&tx->statss);
	tx->xdp_xmit += n;
	tx->xdp_xmit_errors += n - i;
	u64_stats_update_end(&tx->statss);

gve_xdp_xmit() in gve_tx.c does the same after
spin_unlock(&tx->xdp_lock). gve_clean_tx_done_dqo() also updates the
same statss from NAPI:

	u64_stats_update_begin(&tx->statss);
	tx->bytes_done += pkt_compl_bytes + reinject_compl_bytes;
	tx->pkt_done += pkt_compl_pkts + reinject_compl_pkts;

Could overlapping write_seqcount_begin()/end() calls tear the 64-bit
reads? Could they lose a sequence increment and leave the count odd? If
so, the retry loop in gve_add_tx_ring_range_stats() would spin forever
with stats_lock held and BH disabled.

gve_get_stats() and gve_get_ethtool_stats() already read these counters
before this patch, so the new reader in gve_get_base_stats() neither
creates nor widens the exposure. Hitting it needs a 32-bit kernel and
XDP_REDIRECT into gve from several CPUs while completions are running.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029211634.2232784-1-hramamurthy%40google.com
