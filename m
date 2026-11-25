Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597922;
	b=VCmX8kSWflOs4dB6cEzTXhs8SPTdkOpUIa8jCPtsW6SdL2cdedWjZWH25o+zaTexiHlJ
	 /8yCt78GGHG2oHqdKZE/3/Fyiz4AXiLph7ic0d8yOtiev13v9BMYcORYDckCr41ArHAC8
	 crMw+KELlmISk0DmMHLMrJhMCUHLu1DeYFEC28ZPPtGchWYJHfUwpWw4ILRPkM8w3Nlww
	 KsK+Uoj138nmnS9ayzVSohQ+xdTPI0J0pZ4fYLAJU1pqU4a7Un0BjxKrzKAtUvKaBKFH5
	 XexGHo51nOYV8otoDoNcX/OYPxCkiUa7tc299EpmHXINpXmJYaBZ1GGy9c9ioHB5UfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597922;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=T9/3JWSFtzOyIU42eY/kNxUthAkQbcIa4UT8V/rgw7c=;
	b=0IBIRyvkm7kwiZpLUah2UWJ8WCtz/5+EYNNm6kz7BPgJJfzzf4zExEIkbHkX1buucPhT
	 TYYb2bQI+J9MR8LcyW5RC/eoYjslgcJdKPbGb/mc4VQiD6umTy5nRijNCNpoop1mixI72
	 8DfIQ7PRFq+7+X+eydTR9fAXoHh2m/4GZsTruXncNZazW4NaFFmWdfVmNt/cG8HAMyijG
	 ziPPj27xuMEyn0xnyqZtDVKThvSICUihkuU6yhnnilTIEHRFuY7UyEoxM0PWSsG0yVUBJ
	 GeL9/q4Pxcgjx9ds7mc0AlQGRWBO+HUGJ9h0qXfqJGF9tV/cf9JwsaRv+/FlKi+5xXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bXjfIKYY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA94606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bXjfIKYY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64391F000C0;
	Wed, 25 Nov 2026 09:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795597921;
	bh=T9/3JWSFtzOyIU42eY/kNxUthAkQbcIa4UT8V/rgw7c=;
	h=Subject:To:Cc:From:Date;
	b=bXjfIKYYmJJ9y5sJdq3NIunExVB51NmD9M6M34l65TR/QHTUUjPYIhjDyl4GfcBoF
	 E21AvGQC65JLJAPYrFtzj0xXqeE0QKh15adIZf8Z6hODHSbBu7J04qhNVPb85OcM6S
	 vLT6TQSE/mLdAqlqACVSHOX2gG8IZQMkwAz84PL8=
Subject: FAILED: patch "[PATCH] gve: Fix race between stats query and queue reconfig" failed to apply to 6.18-stable tree
To: treapking@google.com,debarghyak@google.com,hramamurthy@google.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 10:00:01 +0100
Message-ID: <2026112501-underpay-modified-f1d3@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 7de69da15088ac2add08eb2b5f5c0a79fd461c1e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112501-underpay-modified-f1d3@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7de69da15088ac2add08eb2b5f5c0a79fd461c1e Mon Sep 17 00:00:00 2001
From: Pin-yen Lin <treapking@google.com>
Date: Mon, 9 Nov 2026 18:20:33 +0000
Subject: [PATCH] gve: Fix race between stats query and queue reconfig

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

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index b7ce6e8632db..1911d05eb697 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -957,6 +957,11 @@ struct gve_priv {
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
index 2437cd8ba633..45868cc4dd25 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -69,6 +69,7 @@ static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
 	int num_tx_queues;
 	int ring;
 
+	spin_lock_bh(&priv->stats_lock);
 	num_tx_queues = gve_num_tx_queues(priv);
 	if (priv->rx) {
 		for (ring = 0; ring < priv->rx_cfg.num_queues; ring++) {
@@ -96,6 +97,7 @@ static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
 			s->tx_bytes += bytes;
 		}
 	}
+	spin_unlock_bh(&priv->stats_lock);
 }
 
 static int gve_alloc_flow_rule_caches(struct gve_priv *priv)
@@ -642,9 +644,13 @@ static void gve_queues_mem_remove(struct gve_priv *priv)
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
 
 static void gve_free_control_plane_resources(struct gve_priv *priv)
@@ -1383,6 +1389,7 @@ static int gve_queues_start(struct gve_priv *priv,
 	int err;
 
 	/* Record new resources into priv */
+	spin_lock_bh(&priv->stats_lock);
 	priv->tx = tx_alloc_cfg->tx;
 	priv->rx = rx_alloc_cfg->rx;
 
@@ -1396,10 +1403,11 @@ static int gve_queues_start(struct gve_priv *priv,
 	priv->rx_pages_per_qpl = rx_alloc_cfg->pages_per_qpl;
 	priv->header_split_enabled = rx_alloc_cfg->enable_header_split;
 	priv->rx_cfg.packet_buffer_size = rx_alloc_cfg->packet_buffer_size;
+	gve_init_sync_stats(priv);
+	spin_unlock_bh(&priv->stats_lock);
 
 	gve_tx_start_rings(priv, gve_num_tx_queues(priv));
 	gve_rx_start_rings(priv, rx_alloc_cfg->qcfg_rx->num_queues);
-	gve_init_sync_stats(priv);
 
 	err = netif_set_real_num_tx_queues(dev, priv->tx_cfg.num_queues);
 	if (err)
@@ -2266,6 +2274,7 @@ void gve_handle_report_stats(struct gve_priv *priv)
 	if (!gve_get_report_stats(priv))
 		return;
 
+	spin_lock_bh(&priv->stats_lock);
 	be64_add_cpu(&priv->stats_report->written_count, 1);
 	/* tx stats */
 	if (priv->tx) {
@@ -2330,6 +2339,7 @@ void gve_handle_report_stats(struct gve_priv *priv)
 			};
 		}
 	}
+	spin_unlock_bh(&priv->stats_lock);
 }
 
 /* Handle NIC status register changes, reset requests and report stats */
@@ -2679,8 +2689,10 @@ static int gve_rx_queue_stop(struct net_device *dev, void *per_q_mem, int idx)
 	gve_turnup_and_check_status(priv);
 
 	gve_per_q_mem = (struct gve_rx_ring *)per_q_mem;
+	spin_lock_bh(&priv->stats_lock);
 	*gve_per_q_mem = priv->rx[idx];
 	memset(&priv->rx[idx], 0, sizeof(priv->rx[idx]));
+	spin_unlock_bh(&priv->stats_lock);
 	return 0;
 }
 
@@ -2734,7 +2746,9 @@ static int gve_rx_queue_start(struct net_device *dev,
 		return -EAGAIN;
 
 	gve_per_q_mem = (struct gve_rx_ring *)per_q_mem;
+	spin_lock_bh(&priv->stats_lock);
 	priv->rx[idx] = *gve_per_q_mem;
+	spin_unlock_bh(&priv->stats_lock);
 
 	/* Single-queue creation requires quiescence on all queues */
 	gve_turndown(priv);
@@ -2770,7 +2784,9 @@ static int gve_rx_queue_start(struct net_device *dev,
 	 * which needs the rtnl lock, will not run till this func returns and
 	 * its caller gives up the lock.
 	 */
+	spin_lock_bh(&priv->stats_lock);
 	memset(&priv->rx[idx], 0, sizeof(priv->rx[idx]));
+	spin_unlock_bh(&priv->stats_lock);
 	return err;
 }
 
@@ -2786,9 +2802,15 @@ static void gve_get_rx_queue_stats(struct net_device *dev, int idx,
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
@@ -2796,20 +2818,32 @@ static void gve_get_rx_queue_stats(struct net_device *dev, int idx,
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
@@ -2935,6 +2969,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	INIT_WORK(&priv->service_task, gve_service_task);
 	INIT_WORK(&priv->stats_report_task, gve_stats_report_task);
+	spin_lock_init(&priv->stats_lock);
 	priv->tx_cfg.max_queues = max_tx_queues;
 	priv->rx_cfg.max_queues = max_rx_queues;
 

