Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620654;
	b=VL1x5ZM1tnsG8sFX1c/l50sQPA1/pZKfKAD+AFYzWw0pJcNHZ+fFY0U0Gp+g3/NLeYAp
	 LjPhMnYPORW+6AH0GZn7ndTki0QLZ3KUqJDFMCqDg1S07hP8SP55TuL5BYp32ePCrL0eE
	 DLinHOw8nQo2Q8XYoa8vGqMMz07GM0BAq2w/6gPm0G/RhJyTyA2vURIlRd6M7pZ3rLjCM
	 /AXWLKXti8su3VWHn3WhU1rIG1313/VaPdgajhDaVg5cJVrSXFDc2X3QBqOALW/oyQfr3
	 oRJXNvlMCAX3bATcWh04Wu6I2/Drv5wjx168bnxDSXuH9+zxss0bMR81PBc6bz2PskA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620654;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kXWjigxOU50OVgsQH8t8z+CueAyqYsDhCRTz5fN1CPY=;
	b=rA+ka5i1RNnkf3NhpxT6VuLqyIDVZp/anJnNA3nORn3zXh/Yr5nlv6H40Y94TwooLg1R
	 Job+cz2OEkO0dhqZMRP+Rt3kSEyUUoMqOgjc1QggSUuHnt0WMYaflWn2iKQrwmDmlYFZa
	 ir5s4c62IwMRFp4/uxPczaKT29ETbPChm3xvMaSaZ5mdOtHjt2lVbQbNJGFuHNX7vi4vb
	 VGNPKkIuEfY5VhouU3gIw4TD3UPERxGcfE2I6EXmTeDQLkVtbvu48cwKee4rJBZJW1/wG
	 Wb7YLQbgF75zT1wf8W7putqQXq7FrtbnmIc0/bN22xlbT2ZmzxEzcNZ3tb399+mHgDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lGKIkAHR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD33606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lGKIkAHR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6A01F000D3;
	Wed, 25 Nov 2026 15:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795620653;
	bh=kXWjigxOU50OVgsQH8t8z+CueAyqYsDhCRTz5fN1CPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lGKIkAHRRHQXN9uHXtdFl27JdpeAcxVZqNZIZ6tQMUND26C+lBTU3KQevOx68OT7w
	 Cgj8qP4avluDqembbm/jBHFo1QsfhvY921rlR4T+ndbCpC+Uo1yn3C76WB4PtxkD+D
	 0B+wIn5x/kSbG2Afxwgc2kInATlRL8zWoks0L8+afdymBDQqIWTPNF643jsEySZ4u7
	 dHKa7zz7yXlxhZNgkiHZ3ulgthHvgfDEmEN7r/dh+Qlz3RBgMA5ttOT9GxKDAHU5VS
	 SyWXhP3PdNwZBif/wjoYDiaA2M4dy/j5JEmKa/1YbSqb8KAe7XcrrcGUfdGsSiOblw
	 ttR+bnjlTYkBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pin-yen Lin <treapking@google.com>,
	Debarghya Kundu <debarghyak@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] gve: Fix race between stats query and queue reconfig
Date: Wed, 25 Nov 2026 10:30:51 -0500
Message-ID: <20261125152945.168827-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112501-underpay-modified-f1d3@gregkh>
References: <2026112501-underpay-modified-f1d3@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pin-yen Lin <treapking@google.com>

[ Upstream commit 7de69da15088ac2add08eb2b5f5c0a79fd461c1e ]

Fix a concurrency bug where network statistics queries race with queue
reconfiguration or interface teardown, causing a Use-After-Free (UAF) or
NULL pointer dereference.

Currently, statistics queries access priv->tx and priv->rx without
locking. When an interface is brought down or reconfigured,
gve_queues_mem_remove() frees these arrays. A concurrent stats query
can dereference freed queue structures and crash the kernel.

This issue was discovered and actually triggered by the
drivers/net/stats.py selftest. When an interface was brought down,
querying per-queue statistics via Netlink caused a kernel NULL pointer
dereference in gve_get_rx_queue_stats():

  BUG: kernel NULL pointer dereference, address: 00000000000000a0
  RIP: 0010:gve_get_rx_queue_stats+0x17/0x50 [gve]
  Call Trace:
   <TASK>
   netdev_stat_queue_sum+0x11c/0x250
   netdev_nl_stats_by_netdev+0x21b/0x2d0
   netdev_nl_qstats_get_dumpit+0xd2/0x220
   genl_dumpit+0x32/0x90
   netlink_dump+0x1d2/0x450
   __netlink_dump_start+0x1db/0x2a0
   genl_family_rcv_msg_dumpit+0x9b/0x100
   ...

The per-queue stats callbacks run under the netdev instance lock, so
this NULL dereference is not a race; it happens on any query while the
interface is down.

Additionally, concurrent stats queries during queue reconfiguration can
race with gve_queues_mem_remove(), causing a Use-After-Free.
This affects gve_get_stats(), which does not hold the instance lock.
gve_handle_report_stats() also runs without it; it is stopped before
queue teardown, but can still read priv->rx[idx] while the single-queue
restart path rewrites it.

Fix this by introducing stats_lock to serialize stats queries against
queue teardown. In gve_queues_mem_remove(), queue pointers are set to
NULL under stats_lock before freeing. Stats readers acquire the lock
and verify pointers are non-NULL before reading counters.
The per-queue stats callbacks already run under the instance lock, but
take stats_lock as well for consistency.
The single-queue restart path also rewrites priv->rx[idx] in place, so
gve_rx_queue_stop() and gve_rx_queue_start() do those writes under
stats_lock as well.

This change was tested using the DQO RDA queue format.

Cc: stable@vger.kernel.org
Fixes: f5cedc84a30d ("gve: Add transmit and receive support")
Fixes: 2e5e0932dff5 ("gve: add support for basic queue stats")
Co-developed-by: Debarghya Kundu <debarghyak@google.com>
Signed-off-by: Debarghya Kundu <debarghyak@google.com>
Signed-off-by: Pin-yen Lin <treapking@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
Link: https://patch.msgid.link/20261109182036.2910559-2-hramamurthy@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: Adjusted context in gve_queues_start() and gve_queues_mem_remove() because this tree lacks the qpl, header-split and packet-buffer-size lines, so the unlock follows rx_desc_cnt. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/google/gve/gve.h      |  5 +++
 drivers/net/ethernet/google/gve/gve_main.c | 43 ++++++++++++++++++++--
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index f0bc910dd6d44..2aecaf892d659 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -877,6 +877,11 @@ struct gve_priv {
 	struct workqueue_struct *gve_wq;
 	struct work_struct service_task;
 	struct work_struct stats_report_task;
+	/* Protects the priv->tx/priv->rx arrays, the in-place rewrite of
+	 * priv->rx[idx] and the queue counts against stats readers that do
+	 * not hold the netdev instance lock.
+	 */
+	spinlock_t stats_lock;
 	unsigned long service_task_flags;
 	unsigned long state_flags;
 
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 9b1f8933813cb..66a3b526b5a6f 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -113,6 +113,7 @@ static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
 	int num_tx_queues;
 	int ring;
 
+	spin_lock_bh(&priv->stats_lock);
 	num_tx_queues = gve_num_tx_queues(priv);
 	if (priv->rx) {
 		for (ring = 0; ring < priv->rx_cfg.num_queues; ring++) {
@@ -140,6 +141,7 @@ static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
 			s->tx_bytes += bytes;
 		}
 	}
+	spin_unlock_bh(&priv->stats_lock);
 }
 
 static int gve_alloc_flow_rule_caches(struct gve_priv *priv)
@@ -1343,9 +1345,13 @@ static void gve_queues_mem_remove(struct gve_priv *priv)
 	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
 
 	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
-	gve_queues_mem_free(priv, &tx_alloc_cfg, &rx_alloc_cfg);
+
+	spin_lock_bh(&priv->stats_lock);
 	priv->tx = NULL;
 	priv->rx = NULL;
+	spin_unlock_bh(&priv->stats_lock);
+
+	gve_queues_mem_free(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 }
 
 /* The passed-in queue memory is stored into priv and the queues are made live.
@@ -1359,6 +1365,7 @@ static int gve_queues_start(struct gve_priv *priv,
 	int err;
 
 	/* Record new resources into priv */
+	spin_lock_bh(&priv->stats_lock);
 	priv->tx = tx_alloc_cfg->tx;
 	priv->rx = rx_alloc_cfg->rx;
 
@@ -1368,10 +1375,11 @@ static int gve_queues_start(struct gve_priv *priv,
 	priv->rx_cfg = *rx_alloc_cfg->qcfg_rx;
 	priv->tx_desc_cnt = tx_alloc_cfg->ring_size;
 	priv->rx_desc_cnt = rx_alloc_cfg->ring_size;
+	gve_init_sync_stats(priv);
+	spin_unlock_bh(&priv->stats_lock);
 
 	gve_tx_start_rings(priv, gve_num_tx_queues(priv));
 	gve_rx_start_rings(priv, rx_alloc_cfg->qcfg_rx->num_queues);
-	gve_init_sync_stats(priv);
 
 	err = netif_set_real_num_tx_queues(dev, priv->tx_cfg.num_queues);
 	if (err)
@@ -2265,6 +2273,7 @@ void gve_handle_report_stats(struct gve_priv *priv)
 	if (!gve_get_report_stats(priv))
 		return;
 
+	spin_lock_bh(&priv->stats_lock);
 	be64_add_cpu(&priv->stats_report->written_count, 1);
 	/* tx stats */
 	if (priv->tx) {
@@ -2329,6 +2338,7 @@ void gve_handle_report_stats(struct gve_priv *priv)
 			};
 		}
 	}
+	spin_unlock_bh(&priv->stats_lock);
 }
 
 /* Handle NIC status register changes, reset requests and report stats */
@@ -2601,8 +2611,10 @@ static int gve_rx_queue_stop(struct net_device *dev, void *per_q_mem, int idx)
 	gve_turnup_and_check_status(priv);
 
 	gve_per_q_mem = (struct gve_rx_ring *)per_q_mem;
+	spin_lock_bh(&priv->stats_lock);
 	*gve_per_q_mem = priv->rx[idx];
 	memset(&priv->rx[idx], 0, sizeof(priv->rx[idx]));
+	spin_unlock_bh(&priv->stats_lock);
 	return 0;
 }
 
@@ -2656,7 +2668,9 @@ static int gve_rx_queue_start(struct net_device *dev,
 		return -EAGAIN;
 
 	gve_per_q_mem = (struct gve_rx_ring *)per_q_mem;
+	spin_lock_bh(&priv->stats_lock);
 	priv->rx[idx] = *gve_per_q_mem;
+	spin_unlock_bh(&priv->stats_lock);
 
 	/* Single-queue creation requires quiescence on all queues */
 	gve_turndown(priv);
@@ -2692,7 +2706,9 @@ static int gve_rx_queue_start(struct net_device *dev,
 	 * which needs the rtnl lock, will not run till this func returns and
 	 * its caller gives up the lock.
 	 */
+	spin_lock_bh(&priv->stats_lock);
 	memset(&priv->rx[idx], 0, sizeof(priv->rx[idx]));
+	spin_unlock_bh(&priv->stats_lock);
 	return err;
 }
 
@@ -2708,9 +2724,15 @@ static void gve_get_rx_queue_stats(struct net_device *dev, int idx,
 				   struct netdev_queue_stats_rx *rx_stats)
 {
 	struct gve_priv *priv = netdev_priv(dev);
-	struct gve_rx_ring *rx = &priv->rx[idx];
+	struct gve_rx_ring *rx;
 	unsigned int start;
 
+	spin_lock_bh(&priv->stats_lock);
+	if (!priv->rx)
+		goto unlock;
+
+	rx = &priv->rx[idx];
+
 	do {
 		start = u64_stats_fetch_begin(&rx->statss);
 		rx_stats->packets = rx->rpackets;
@@ -2718,20 +2740,32 @@ static void gve_get_rx_queue_stats(struct net_device *dev, int idx,
 		rx_stats->alloc_fail = rx->rx_skb_alloc_fail +
 				       rx->rx_buf_alloc_fail;
 	} while (u64_stats_fetch_retry(&rx->statss, start));
+
+unlock:
+	spin_unlock_bh(&priv->stats_lock);
 }
 
 static void gve_get_tx_queue_stats(struct net_device *dev, int idx,
 				   struct netdev_queue_stats_tx *tx_stats)
 {
 	struct gve_priv *priv = netdev_priv(dev);
-	struct gve_tx_ring *tx = &priv->tx[idx];
+	struct gve_tx_ring *tx;
 	unsigned int start;
 
+	spin_lock_bh(&priv->stats_lock);
+	if (!priv->tx)
+		goto unlock;
+
+	tx = &priv->tx[idx];
+
 	do {
 		start = u64_stats_fetch_begin(&tx->statss);
 		tx_stats->packets = tx->pkt_done;
 		tx_stats->bytes = tx->bytes_done;
 	} while (u64_stats_fetch_retry(&tx->statss, start));
+
+unlock:
+	spin_unlock_bh(&priv->stats_lock);
 }
 
 static void gve_get_base_stats(struct net_device *dev,
@@ -2848,6 +2882,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	INIT_WORK(&priv->service_task, gve_service_task);
 	INIT_WORK(&priv->stats_report_task, gve_stats_report_task);
+	spin_lock_init(&priv->stats_lock);
 	priv->tx_cfg.max_queues = max_tx_queues;
 	priv->rx_cfg.max_queues = max_rx_queues;
 
-- 
2.53.0

