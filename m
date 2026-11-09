Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248442;
	b=wa80AxA7uKy5zBFRvIuCCxtxj3maIgKRmu8p6E+4P+5Evaf1EQ3k10ruwC3yLPVS2QWT
	 jy6XXYOBwjHR4AHSvvkq/ym8VXhfXbBCTTLnJYxCzAZ3t25VLElsaMhpweTqqXGHJswQ0
	 cTbSdCZouLx5sFZBfXZBUXDS2w8JyII/O56SIHHlc8kA7YmvHdq6QrW01B9es6pHEBcry
	 Mho+UyHzNqvj+pN0w7qVfiuZUOxPkYqRz/62k+qEvR5i5wNSoppDN2CswYnydlYUFThcI
	 elMXHE9+Z2Z7wmxCRd+lorJYGV3tI4GEE8/IPtUhhLR5SFDoihcoMyN+7DXbawJ+SvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248442;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=lfVYwOwlmOHEv+pgBlq6g3ijvDmEPFvnXdWNbTNiVLo=;
	b=VY8hv6PrDJMqHWl1npWgjW73uRSD4wKRVUPbX16nCKLe+tHHufL7rk3OpHW2acL5qzwT
	 a2i91fWnwG797R5XRXsWW4GsroqZj5sjzXNNVb5f8qchfFRRJO2c5AoFQeRloOuAsKQpM
	 2NFMXQ5e0KRmiJd7hJchP8gHOXvSfHuJ0chaMdpJ4eMCn3b9xykaA0nN2uFxOwaICRUmz
	 gaf990xPSK+qYW7BW3EQ+SeoYppTR8pxjJd/DaHGo0z07QAxqHK0jOFQdzCXZ24S0E2Hl
	 TogH9q0D3jmMvNEv4MszW/BjDeVMCQeMmdxza2/bPe4xAhVi+foSqpSRVR6woqSYLjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FMrzx31N;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A0F606A330
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 18:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47A0F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FMrzx31N
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b0a098dbc7so1068510a91.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 10:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248442; x=1794853242; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lfVYwOwlmOHEv+pgBlq6g3ijvDmEPFvnXdWNbTNiVLo=;
        b=FMrzx31N5zswF2yYK4bFeLwe68Wz3lqY3cKQLAxHLjVMktvM1muU1ORgcni15Fe+YC
         uVGU64BEaEAHoeDgvNSeTAmdZWYk5L6BUEA1OP0kZKNdBeZtOuuoWRfbxB+AifNi/0w/
         jxRmhays8yGQcDm0wHOaVX8boLAYGDBMfpGGCY45Bt5ZSgMidbRDA5JgSvvTxso2eLWj
         2hnRQbtHX/L+qc8c+THpLYIwZarmKxP/jpa6kYMRCdPpe0dP4CZR2zrn1DcHmzd+uPax
         Gf/q1Au+M8ERsR2Fn+bo7ZzIrTjPqHvSdKo5IeWa6gQNORdflXspM/+/HBMA88GZBsrO
         C9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248442; x=1794853242;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lfVYwOwlmOHEv+pgBlq6g3ijvDmEPFvnXdWNbTNiVLo=;
        b=E5EH27dGCCcIMBUTWfs/+KD1t3fXSws7yrfcd9AFeTJAf289V2TUT0zagLHqA19nwu
         Iwk58RIQ2/PjGrGElqRKh90SloWFZFxsu55tuAPMOp1FIaFeh9B3H4YUgICKo6J+eqQS
         NMY4PTu6TykETQDqE8ulzrchBnaU+TRCCHt6mQGVSvZfOLp5X6o1gBCX+DhD7kFFC934
         N9T9UVBDcuDIlT98XNbNIpcyHc39tK7UcEeriMOuwv+lhKRsySQSoGhJjrp5Zpt+UHxi
         vrpZqoWRxfdoQDTfnqdDQtpwJfwChUhS7lxwUyBUiYlOHZpqIUcKTSS9wqO+YApRYyZp
         93sw==
X-Forwarded-Encrypted: i=1; AL+hErHJeh+I7dI0f0c4fZtCTZ1hJVsLxJ/h+uaRkhZ260IbILwVaYeFF0hnn+NrfQp7+T4EyNuPlmg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Dk6UU9b4IRwUGKDZxQhwZfGDgGoi2bfG/krAd4fxaoFMIHud0
	4j2Kn21QQ1MW90F1c03jms7cB3K4C2XCgrihcCjBW1qjYnty/y2EJDjXw6FXOyBFOUAPW9xLHyx
	Ac9aSdNl1QwiYu0T68nxojs5iiw==
X-Received: from pjbge16.prod.google.com ([2002:a17:90b:e10:b0:3ac:75d5:7398])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5805:b0:3ac:b44c:2d84 with SMTP id 98e67ed59e1d1-3b166c89a3dmr485885a91.13.1794248439674;
 Mon, 09 Nov 2026 10:20:39 -0800 (PST)
Date: Mon,  9 Nov 2026 18:20:33 +0000
In-Reply-To: <20261109182036.2910559-1-hramamurthy@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261109182036.2910559-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261109182036.2910559-2-hramamurthy@google.com>
Subject: [PATCH net v5 1/4] gve: Fix race between stats query and queue reconfig
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	jordanrhee@google.com, willemb@google.com, przemyslaw.kitszel@intel.com, 
	nktgrg@google.com, maolson@google.com, jacob.e.keller@intel.com, 
	pkaligineedi@google.com, yangchun@google.com, patricion@google.com, 
	awogbemila@google.com, csully@google.com, jonolson@google.com, 
	lrizzo@google.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
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
---

Changes in v5:
- Take stats_lock around the priv->rx[idx] writes in
  gve_rx_queue_stop() and gve_rx_queue_start(), moved from patch 2
  (Sashiko)
- Add a Fixes tag for 2e5e0932dff5, and clarify the commit message and
  the stats_lock comment

Changes in v4:
- Clarify in the commit message that the qstats NULL dereference is not
  a race, and which readers race with queue teardown (Sashiko)
- Change the Fixes tag to f5cedc84a30d (Sashiko)

Changes in v3:
- Retitled from "gve: Add NULL pointer checks for per-queue statistics"
- Protect all stats queries and queue lifecycle updates with spinlock
  (sashiko)
- Refined the commit message

 drivers/net/ethernet/google/gve/gve.h      |  5 +++
 drivers/net/ethernet/google/gve/gve_main.c | 43 ++++++++++++++++++++--
 2 files changed, 44 insertions(+), 4 deletions(-)

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
 
-- 
2.56.0.455.g6c5a503b38-goog

