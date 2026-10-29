Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793308599;
	b=c2M9cWS7/4WaoeFaEMEEOkjmD0YnJMuVm16UewJLzu00NQLKT4ghypQtDryYxvxGsgCR
	 3Z93VRG/G7E0AdJgE2WGE+V7UfZkZa8g+Xp6eVNaXMHzSkfxNPxMwAl0qw0uBkdDGYYtC
	 a6WZQYNanDOEUj6l+Z3dZCoYml0bTrEDeUM5ex+EWZe9/CCCYQ2MQ5Z0/NX0GcYSvsxu4
	 +jYcqyM+/2QUKrRN5LI1v8PM7KE2aoV0hDuIYIttLuARzmw7FP6tnS2E6k8QBuk/2Kc+K
	 YNNJqbglytn1d5PZu5IFgmb3FaJJPT7lbdzgF2b5Ul+4v5VFMgQqT0RLJQ0jkyVesIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=PRu/TTlkge+Kkx5jvzfY99nUYMb0NBGl/h033Feyas8=;
	b=td5Rm8cfGgywcb3GBLUR5AJnppC9tk3nd35cb49KAAB6gNb+jjPvwRw0acNtOA2lVTlk
	 AFktvdaGXmo78KRpHD+9D08pJiRnK6CdEZad+Wb+bdcByQsolkETKSTTif3Qu2sF8BlMm
	 nrnaC9UQWgTK7N4pUqVrDizbw8QqG8zl8s4/VD3jcbpowU2LUozWxnAOv+oPgpvkx4+o3
	 4mx6GpN/MH+4feQhApT1q55dfHrnpNIBuT4kWZ4GXI5uPi4j0uhyM4jiIo+kiUVOmuGi0
	 o0tyWVUmPKRrAY3w/WtotLCrpQ0pkCKhAdjjVpLlXvzfXR/bB1fkGcYYMQuZFIoCwgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KD3q5UqV;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F9E606A326
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 21:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4F9E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KD3q5UqV
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc7e0321ec1so24440a12.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793308598; x=1793913398; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PRu/TTlkge+Kkx5jvzfY99nUYMb0NBGl/h033Feyas8=;
        b=KD3q5UqV4UY3/nNZlqqdEizdXrchbTB3zKrDg+0tmEvqFNxMtLxCCNiyz3+hnSQ4VA
         NaJ10mSussPZ2F1XVpuegI8DCV3j0YhCDIuoVinyTwnAE5FcRvfBiUdnhAv5DLuxOfAR
         gYbfVbTDo/wIQ5HeImhVkmD5UWShE4S85HnMwqWTBqlLIbI3IkujpsYkWXzqOFWpfqMX
         8KyyZOGfEfh0gnTYZSrBGyi0Sj0nn7oWiI+Nwrt6Nw8H1rAC4HJJYGfAAX1htvFfbFGi
         IdecOXjgCxMprOzFVJnwTr+T46M0BQy5zklVL7o3w5QiD/QPuXks9JxpZxNyd9fb5lKW
         Fn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793308598; x=1793913398;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PRu/TTlkge+Kkx5jvzfY99nUYMb0NBGl/h033Feyas8=;
        b=1eqgb7Yi09vaiFhTXFdzOByZF8AFfMuhg7n5NYT4tnGCZ7bvTtZuH9DCZk/EsJEdpr
         Q3n+p7M8S3Ofg5BUL29x8bcS7yHk7oAa6WIH/1fD6PZD2TfHDi11R8CgU1QdZIRkmL1U
         O5EWL7dPx0TagLBrt9eF90F3soK9d+bsBwpQR1qSHw9cpP66fKbafMNCCe8EdkBiE7Gh
         y2FvT9q++q8Ev4TfBuyrTkyfHcKvuWXaAcN6jVFtRpJXGRlXpXBrmYEMIAirNIhpIyNW
         LRucBEkEVxmMKPcb/JscQPLWUo2ydSEJ2FPQqrjVmQVbOcbQXM7aJ6xq1LTlKEhKEqrJ
         zbGQ==
X-Forwarded-Encrypted: i=1; AKwUvBzkN10PMHBmZPeMYWe9FCMOIIJOB1dHpAG8urMErULLq/Wj2ysTX5Aa34p1CAA3nBbJl8Tn8Zs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhPlAYXT3DS8F0av9ESwJh8l7oyBPqwRsJ9weqtR351VpzsYZX
	ysBK2jxjD9OXEJT8a91OpWzHAmaeeElE5aiVodUBdAQLWlqgkjcEJC6RDFxTf6aN/kP0sPzIdJN
	PjNlk9yK7l6QVHF17idpD0AtH2A==
X-Received: from pgjy4.prod.google.com ([2002:a63:e244:0:b0:cc7:9d5b:c2a1])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:4323:b0:3da:b8b4:91d7 with SMTP id adf61e73a8af0-3e92878440bmr486900637.2.1793308597798;
 Thu, 29 Oct 2026 14:16:37 -0700 (PDT)
Date: Thu, 29 Oct 2026 21:16:31 +0000
In-Reply-To: <20261029211634.2232784-1-hramamurthy@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029211634.2232784-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261029211634.2232784-2-hramamurthy@google.com>
Subject: [PATCH net v4 1/4] gve: Fix race between stats query and queue reconfig
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	jordanrhee@google.com, willemb@google.com, przemyslaw.kitszel@intel.com, 
	nktgrg@google.com, maolson@google.com, jacob.e.keller@intel.com, 
	pkaligineedi@google.com, yangchun@google.com, patricion@google.com, 
	awogbemila@google.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pin-yen Lin <treapking@google.com>, Debarghya Kundu <debarghyak@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Pin-yen Lin <treapking@google.com>

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
This affects gve_get_stats() and gve_handle_report_stats(), which do
not hold the instance lock.

Fix this by introducing stats_lock to serialize stats queries against
queue teardown. In gve_queues_mem_remove(), queue pointers are set to
NULL under stats_lock before freeing. Stats readers acquire the lock
and verify pointers are non-NULL before reading counters.
The per-queue stats callbacks also take stats_lock so that all readers
follow the same locking rule.

This change was tested using the DQO RDA queue format.

Cc: stable@vger.kernel.org
Fixes: f5cedc84a30d ("gve: Add transmit and receive support")
Co-developed-by: Debarghya Kundu <debarghyak@google.com>
Signed-off-by: Debarghya Kundu <debarghyak@google.com>
Signed-off-by: Pin-yen Lin <treapking@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---

Changes in v4:
- Clarify in the commit message that the qstats NULL dereference is not
  a race, and which readers race with queue teardown (Sashiko)
- Change the Fixes tag to f5cedc84a30d (Sashiko)

Changes in v3:
- Retitled from "gve: Add NULL pointer checks for per-queue statistics"
- Protect all stats queries and queue lifecycle updates with spinlock
  (sashiko)
- Refined the commit message

 drivers/net/ethernet/google/gve/gve.h      |  2 ++
 drivers/net/ethernet/google/gve/gve_main.c | 37 +++++++++++++++++++---
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index b7ce6e8632db..104468c2c07f 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -957,6 +957,8 @@ struct gve_priv {
 	struct workqueue_struct *gve_wq;
 	struct work_struct service_task;
 	struct work_struct stats_report_task;
+	/* Synchronizes stats accesses and queue teardown */
+	spinlock_t stats_lock;
 	unsigned long service_task_flags;
 	unsigned long state_flags;
 
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 2437cd8ba633..26fdd22644f4 100644
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
@@ -2786,9 +2796,15 @@ static void gve_get_rx_queue_stats(struct net_device *dev, int idx,
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
@@ -2796,20 +2812,32 @@ static void gve_get_rx_queue_stats(struct net_device *dev, int idx,
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
@@ -2935,6 +2963,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	INIT_WORK(&priv->service_task, gve_service_task);
 	INIT_WORK(&priv->stats_report_task, gve_stats_report_task);
+	spin_lock_init(&priv->stats_lock);
 	priv->tx_cfg.max_queues = max_tx_queues;
 	priv->rx_cfg.max_queues = max_rx_queues;
 
-- 
2.56.0.313.g2479322e68-goog

