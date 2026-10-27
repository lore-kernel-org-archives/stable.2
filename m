Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793065326;
	b=toDaVXuuMJvHohBjvCpj/WHi09yujEECazq8luTXIPLd1I48+PzRufOLIg5fYRSEsh2m
	 xlO1HPF6nGeKKIwa+eqcGZEoB5Gmsx3TZY9i/39P6H2IKECQlvsz52CehLVRue+70PwSu
	 n9IFsGAIuQshJ3ea8ZXQLii3VmSa6cObevqEK27Blne4U+9ezZqgtmI/G7+R010JFeRfE
	 IvG3BPDxCO6G4ytEpOFGc7RTQXpX3XVKVVxBDH5UsemeoihljqgJlsS3t/nkvlivTRFeM
	 E90RzTeNfJqgohqFDM69ENokkP+7vUtKVkQeALEJ3DNQ/pdlUN4pJDPqV8PSq2vOf/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793065326;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=EP4YgNCg7ZXlQtYlPniwoONbl1AzoccUkYGSOmCIHHc=;
	b=SpQb0OO1abuZB0WDMYT/Cbtwjixd3asNvvjhXrk/0GKzR9Cg/NUT8yfljiLAq53HiJFd
	 Ru1a5XMCpoKMIEwTnCnr6ROiqoz/OLqtlU1ulx2npINP08W3WavLMF2zH8LjHrNmJdUkv
	 M4M/q09Qz589C+XZXBeguGC3VRsmboKBEZrzhQa/P1W2sCKaanrRWqz8TVE0k4ZqANTR9
	 khIoN5y4SP+YSMxrwo2rFnwl2Q7PfJWGBaItCVJttx+amgD548A2v0dQsTIxybjtBflPF
	 DjurfLuSXzOI4sVMfQCZL2Gh+jbyb+oQpeFsFZxQhZSlJoMcCZ26J4QcVvvS+VTe6+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXniuL12;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13322606A31B;
	Tue, 27 Oct 2026 01:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXniuL12
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B3C1F01825;
	Tue, 27 Oct 2026 01:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793065325;
	bh=EP4YgNCg7ZXlQtYlPniwoONbl1AzoccUkYGSOmCIHHc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lXniuL12zqlMN7UmCIEWJf4yx1l6hozChVPvstpRuXB79riVd1CUuGXoGYHuZvxaM
	 EhMRpiRGR6AMdgEwFusyesBjPUXX1BbezXTs6WpbSwtxRgsd6BB+lPEddE88DzImiu
	 UAqelpF0rwmqZBNsLh6GC6gUCN5n9rW1LqtXKWS7X+KOirQKV/mJzy6pDXPyMWOKOZ
	 4BMwbF7Nr+5KANAJ74dj+kE2kL7RA5wmC5khxNCS9eN6iotiQg8dxcLqkRKUnaZT+m
	 yAA+qpwpTw0rWxzwCoVYcqLc5jM0EbwMn3lmWHbdJ/YtiJKTrFjCs3PzK/kjXHI5pJ
	 6Uwf9Scuxzs9A==
Subject:
 Re: [PATCH net v3 1/4] gve: Fix race between stats query and queue reconfig
From: netdev-bot+sashiko@kernel.org
To: hramamurthy@google.com
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 jordanrhee@google.com, willemb@google.com, przemyslaw.kitszel@intel.com,
 nktgrg@google.com, maolson@google.com, jacob.e.keller@intel.com,
 pkaligineedi@google.com, yangchun@google.com, patricion@google.com,
 awogbemila@google.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 treapking@google.com
Date: Tue, 27 Oct 2026 01:42:04 +0000
Message-ID: <179306532408.3134.10931264635310564601@kernel.org>
In-Reply-To: <20261023204706.3112215-2-hramamurthy@google.com>
References: <20261023204706.3112215-2-hramamurthy@google.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message describes the bug wrongly and the Fixes tag
  points at the wrong commit.
- [Low] Baseline decision: not valid for the final state of the series.

Pre-existing issues:
- [Low] Baseline decision: not valid for the final state of the series.

--

gve: Fix race between stats query and queue reconfig

This commit adds a stats_lock spinlock to struct gve_priv. The lock is
taken in the stats readers (ndo_get_stats64, the report stats worker and
the per-queue qstats callbacks) and around the priv->tx/priv->rx updates
in gve_queues_start() and gve_queues_mem_remove(). The qstats callbacks
also return early when the queue arrays are NULL.

> Fix a concurrency bug where network statistics queries race with queue
> reconfiguration or interface teardown, causing a Use-After-Free (UAF) or
> NULL pointer dereference.

[ ... ]

> This issue was discovered and actually triggered by the
> drivers/net/stats.py selftest. When an interface was brought down,
> querying per-queue statistics via Netlink caused a kernel NULL pointer
> dereference in gve_get_rx_queue_stats():

[ ... ]

> Fixes: 2e5e0932dff5 ("gve: add support for basic queue stats")

[Severity: Medium]
Is the crash in this trace a race?

gve sets dev->queue_mgmt_ops, so netdev_need_ops_lock() returns true.
netdev_nl_qstats_get_dumpit() takes the instance lock through
netdev_get_by_index_lock_ops_compat() and
for_each_netdev_lock_ops_compat_scoped(). The struct netdev_stat_ops
comment in include/net/netdev_queues.h says:

  Ops are called under the instance lock if netdev_need_ops_lock()
  returns true, otherwise under rtnl_lock.

Every caller of gve_queues_mem_remove() also holds the instance lock:
gve_close() via ndo_stop, gve_adjust_config() via ethtool and XDP, and
gve_handle_reset()/suspend/shutdown via netdev_lock(). So the qstats
callbacks can't overlap with teardown.

The trace looks like a NULL dereference that happens every time instead.
netdev_nl_stats_by_netdev() sums the queues even when the device is down:

	netdev_stat_queue_sum(netdev, 0, netdev->real_num_rx_queues, &rx_sum,
			      0, netdev->real_num_tx_queues, &tx_sum);

and gve_get_rx_queue_stats() then computed &priv->rx[idx] with priv->rx
set to NULL. The new NULL check fixes that. The spinlock in the qstats
callbacks makes no difference on this path.

The lockless readers that do race with gve_queues_mem_remove() are:

  gve_get_stats(): ndo_get_stats64, reached under RCU only from
  /proc/net/dev via dev_seq_printf_stats()->dev_get_stats()

  gve_handle_report_stats(): runs from gve_wq

The priv->rx check-then-use in gve_get_stats() dates back to
f5cedc84a30d ("gve: Add transmit and receive support") from 2019, which
predates 2e5e0932dff5.

Should the Fixes tag point at the older commit? Stable trees without
qstats won't otherwise pick up the ndo_get_stats64 use-after-free fix.
Also, could the commit message keep the qstats NULL dereference separate
from the ndo_get_stats64 and report stats race?

> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
> index b7ce6e8632db6..104468c2c07f8 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -957,6 +957,8 @@ struct gve_priv {
>  	struct workqueue_struct *gve_wq;
>  	struct work_struct service_task;
>  	struct work_struct stats_report_task;
> +	/* Synchronizes stats accesses and queue teardown */
> +	spinlock_t stats_lock;

[Severity: Low]
Does this lock cover every place that rewrites priv->rx[idx] in place?
gve_rx_queue_stop() still copies the ring out and clears it without
taking stats_lock:

drivers/net/ethernet/google/gve/gve_main.c:gve_rx_queue_stop() {
    ...
	gve_per_q_mem = (struct gve_rx_ring *)per_q_mem;
	*gve_per_q_mem = priv->rx[idx];
	memset(&priv->rx[idx], 0, sizeof(priv->rx[idx]));
	return 0;
}

gve_get_stats() (from /proc/net/dev under RCU) and
gve_handle_report_stats() (from gve_wq) hold only stats_lock. During a
single-queue restart they can read a partly zeroed ring, including the
statss seqcount. The result is briefly torn or zeroed rx counters. It is
not a use-after-free, because the priv->rx array is still allocated.

The next patch in the series, "gve: Fix backward stats when interface
goes down or configuration is adjusted", moves this copy and memset under
spin_lock_bh(&priv->stats_lock).

After that patch, two writes in gve_rx_queue_start() still happen without
the lock: the struct copy priv->rx[idx] = *gve_per_q_mem and the
abort-path memset. Both only replace zero counters with zero counters.
The incoming ring is either freshly allocated (memset(rx, 0, sizeof(*rx))
in gve_rx_alloc_ring_dqo()/gve_rx_alloc_ring_gqi()) or the old ring,
whose counters gve_rx_queue_stop() zeroes. Readers would not see wrong
values, but KCSAN could still report the race.

>  	unsigned long service_task_flags;
>  	unsigned long state_flags;
>  
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 2437cd8ba6331..26fdd22644f4d 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c

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
> +	rx = &priv->rx[idx];
> +

[ ... ]

>  static void gve_get_tx_queue_stats(struct net_device *dev, int idx,
>  				   struct netdev_queue_stats_tx *tx_stats)
>  {
>  	struct gve_priv *priv = netdev_priv(dev);
> -	struct gve_tx_ring *tx = &priv->tx[idx];
> +	struct gve_tx_ring *tx;
>  	unsigned int start;
>  
> +	spin_lock_bh(&priv->stats_lock);
> +	if (!priv->tx)
> +		goto unlock;
> +
> +	tx = &priv->tx[idx];
> +

[ ... ]

> +
> +unlock:
> +	spin_unlock_bh(&priv->stats_lock);
>  }
>  
>  static void gve_get_base_stats(struct net_device *dev,

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch. With
the early returns above, device-level qstats now drop to zero after
ifdown, because gve_get_base_stats() still hardcodes zeros:

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

Once gve_queues_mem_remove() sets priv->rx and priv->tx to NULL, the
per-queue callbacks add nothing, so the totals equal the zero base. That
goes against the get_base_stats contract in include/net/netdev_queues.h.
It would also fail the "went backwards" check in check_down() in
tools/testing/selftests/drivers/net/stats.py on this commit.

The next patch in the series, "gve: Fix backward stats when interface
goes down or configuration is adjusted", fixes this. It accumulates ring
stats into base_net_stats and base_ring_err_stats under stats_lock in
gve_queues_mem_remove() and gve_rx_queue_stop(), and gve_get_base_stats()
then reports those accumulators.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023204706.3112215-1-hramamurthy%40google.com
