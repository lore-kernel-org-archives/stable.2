Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C7D49B1EA
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884335; cv=none; b=NV4B9CVXBHRzjwDg5FKwpODH3RNkBV5sQOkgOigPTuzEpvk/9J7RVBk2xgp17ASFC4IsHwxp/ucK1PJJckH5u5Ifu5YROKZAAC+XXKRPv0+Xpvb0aUbs5YsdXlt1BKVpOlmMUyYyre6tFp3kqO5CJDkaAFQefOidnjCyXIzDro0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884335; c=relaxed/simple;
	bh=rc+/aN8xSAgKobKKo1Q7NBR686prH9QJn7PjxZWc0+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HRPi1Odor2mkiHEu9OiR05UaROQecO4v7cNN8+dabScjIxS1+fDWzG+7odNkGRWZAAT/DIZ7XnhJy7gFOG5kOrvbuiV8A4uCGQ+KFmYp6zReOPBIN8SQasJukf6bN+Yhd7CrppJ/RXBNRaw2PM0Mtpg0CwFw33NPXg2YoFvCB8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--treapking.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tK+vVRNh; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--treapking.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tK+vVRNh"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39deda201bcso4368896a91.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 02:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791884334; x=1792489134; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Nd0LUyXJPcgM61gsml+83Dhn7O7W6nwmaqvdA15TEM=;
        b=tK+vVRNh9yD7mnS+Gc28MC7ORcgtBHkCFEOx11OvP+dSxKbhoq3h1gLyBHvM/FJwOI
         6h2egnmN5HwJJwk0ccfBlUzhmLC2cOvDgA5+cKG5mCCFwYz9JJGRWFuSPXwz+TQFCXh4
         cIjtN6sq9u8oS7awdcqnjS2lPUjjFgjI4dI71TQhOl2f0seA95WVgKq1Pa0c8BTGubVI
         QxPeI3EABQaAg0+tuqVoXUcJEACse1tUWTnU2J1tnHTOdazYnUEDJRDJ6KMmTiQBiWZm
         /y8RPnVLl3tALxVeiWmug1Z3nKNkvuSSMz5Kqz2d4F5EXtf+5ITxaxM9S71/FWbkMU00
         +IRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791884334; x=1792489134;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Nd0LUyXJPcgM61gsml+83Dhn7O7W6nwmaqvdA15TEM=;
        b=gHdAFdhL7iZ3lSFOelApRgUUcwc9KvthJ5g9CP4fI3Ue4L559HOeVkIA4oZz5KlCNq
         Sdss898cKWnoNHSmcKqQRXBcay4fOr5u+7QwuPMVpi/71JpKX1TmhJRo52m2kBVtUzPh
         zGd6wn5rp11LiAJYx0djZCQACSJj9knxG9eMF1dr0LZiPY+9l4o5+41JTzsGg4eHJvUL
         +xu3tj2uav3VZh1Qh0P69KTZNl8982BYu7Eqoc9s1J0DRhcyEzNf1BAzTvr9WWCWEWo9
         8TMe9lxeAuUv4i9GuPBChI8Adh3faI9SpCLObmJINEEa3ECSSoZPSJtLl9TyKWGUjc4P
         z0Kw==
X-Forwarded-Encrypted: i=1; AKwUvBzI8nRv7TAVWBG3wLLF7fkvUZV7fig7tnlFGfduZ9NkmNiEE0DGufQVeQKJYwJhdL5sBtEi3cI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLmPtunwldlRe+WPM/e35Wh+nLlT175/A9mMhkrKMvFX7o0x/6s
	7EvEf2mjxRNoP096F7bUsWsfBAjLOW6X/Xd1ms/JAUipN9T9E5hwPQmbMR+/2x1fm5tC9jt+s28
	diVpO6QMb1am+jZ21iQ==
X-Received: from pjbx88.prod.google.com ([2002:a17:90a:38e1:b0:3a8:28d0:2510])
 (user=treapking job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1d4f:b0:3aa:6b5d:a00a with SMTP id 98e67ed59e1d1-3ab3ac7912fmr9994278a91.53.1791884333344;
 Tue, 13 Oct 2026 02:38:53 -0700 (PDT)
Date: Tue, 13 Oct 2026 02:38:33 -0700
In-Reply-To: <20261013093836.1269134-1-treapking@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013093836.1269134-1-treapking@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013093836.1269134-3-treapking@google.com>
Subject: [PATCH net v3 2/5] gve: Fix backward stats when interface goes down
 or configuration is adjusted
From: Pin-yen Lin <treapking@google.com>
To: treapking@google.com
Cc: Debarghya Kundu <debarghyak@google.com>, stable@vger.kernel.org, 
	Harshitha Ramamurthy <hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Debarghya Kundu <debarghyak@google.com>

gve_get_base_stats() sets all the stats to 0, so the stats go backwards
when interface goes down or configuration is adjusted.

This issue was discovered and actually triggered by the
drivers/net/stats.py selftest (check_down test case). Bringing down the
interface caused statistics counters to reset to 0, triggering selftest
assertion failures because netdevice stats must not go backwards.

Fix this by persisting baseline stats across queue teardown in
gve_queues_mem_remove() and single-queue stop in gve_rx_queue_stop().

This change was tested using the DQO RDA queue format.

Cc: stable@vger.kernel.org
Fixes: 2e5e0932dff5 ("gve: add support for basic queue stats")
Signed-off-by: Debarghya Kundu <debarghyak@google.com>
Co-developed-by: Pin-yen Lin <treapking@google.com>
Signed-off-by: Pin-yen Lin <treapking@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
---

Changes in v3:
- Drop u64_stats_sync for the base stats and use spinlock to protect
  them instead
- Save base stats in gve_queues_mem_remove() instead of gve_close()
- Save base stats in gve_rx_queue_stop() for single-queue restarts
- Drop unused rx_dropped and tx_dropped accumulation in gve_add_base_stats()
- Refined the commit message

Changes in v2:
- Add a NULL pointer check in gve_get_ring_err_stats() (Sashiko)
- Use local variable to prevent inflates from u64_stats_fetch_retry()
  (Sashiko)
- Add u64_stats_fetch/begin to protect base stats (Sashiko)

 drivers/net/ethernet/google/gve/gve.h      |  6 ++
 drivers/net/ethernet/google/gve/gve_main.c | 83 +++++++++++++++++++---
 2 files changed, 81 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 6f1eef11715b..96eab15e7a74 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -797,6 +797,10 @@ struct gve_ptp {
 	struct gve_priv *priv;
 };
 
+struct gve_ring_err_stats {
+	u64 rx_alloc_fails;
+};
+
 struct gve_priv {
 	struct net_device *dev;
 	struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
@@ -888,6 +892,8 @@ struct gve_priv {
 	unsigned long service_task_flags;
 	unsigned long state_flags;
 
+	struct gve_ring_err_stats base_ring_err_stats;
+	struct rtnl_link_stats64 base_net_stats;
 	struct gve_stats_report *stats_report;
 	u64 stats_report_len;
 	dma_addr_t stats_report_bus; /* dma address for the stats report */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index b6168bdf2ce7..5bd6549e99b2 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -106,15 +106,25 @@ static netdev_tx_t gve_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		return gve_tx_dqo(skb, dev);
 }
 
-static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
+static void gve_add_base_stats(struct gve_priv *priv,
+			       struct rtnl_link_stats64 *s)
+{
+	struct rtnl_link_stats64 *base_stats = &priv->base_net_stats;
+
+	s->rx_packets += base_stats->rx_packets;
+	s->rx_bytes += base_stats->rx_bytes;
+	s->tx_packets += base_stats->tx_packets;
+	s->tx_bytes += base_stats->tx_bytes;
+}
+
+static void gve_get_ring_stats(struct gve_priv *priv,
+			       struct rtnl_link_stats64 *s)
 {
-	struct gve_priv *priv = netdev_priv(dev);
 	unsigned int start;
 	u64 packets, bytes;
 	int num_tx_queues;
 	int ring;
 
-	spin_lock_bh(&priv->stats_lock);
 	num_tx_queues = gve_num_tx_queues(priv);
 	if (priv->rx) {
 		for (ring = 0; ring < priv->rx_cfg.num_queues; ring++) {
@@ -142,6 +152,38 @@ static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
 			s->tx_bytes += bytes;
 		}
 	}
+}
+
+static void gve_get_ring_err_stats(struct gve_priv *priv,
+				   struct gve_ring_err_stats *err_stats)
+{
+	int ring;
+
+	if (!priv->rx)
+		return;
+
+	for (ring = 0; ring < priv->rx_cfg.num_queues; ring++) {
+		struct gve_rx_ring *rx = &priv->rx[ring];
+		unsigned int start;
+		u64 rx_alloc_fails;
+
+		do {
+			start = u64_stats_fetch_begin(&rx->statss);
+			rx_alloc_fails = rx->rx_skb_alloc_fail +
+					 rx->rx_buf_alloc_fail;
+		} while (u64_stats_fetch_retry(&rx->statss, start));
+
+		err_stats->rx_alloc_fails += rx_alloc_fails;
+	}
+}
+
+static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
+{
+	struct gve_priv *priv = netdev_priv(dev);
+
+	spin_lock_bh(&priv->stats_lock);
+	gve_get_ring_stats(priv, s);
+	gve_add_base_stats(priv, s);
 	spin_unlock_bh(&priv->stats_lock);
 }
 
@@ -1390,6 +1432,9 @@ static void gve_queues_mem_remove(struct gve_priv *priv)
 	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 
 	spin_lock_bh(&priv->stats_lock);
+	gve_get_ring_stats(priv, &priv->base_net_stats);
+	gve_get_ring_err_stats(priv, &priv->base_ring_err_stats);
+
 	priv->tx = NULL;
 	priv->rx = NULL;
 	spin_unlock_bh(&priv->stats_lock);
@@ -2678,8 +2723,20 @@ static int gve_rx_queue_stop(struct net_device *dev, void *per_q_mem, int idx)
 	gve_turnup_and_check_status(priv);
 
 	gve_per_q_mem = (struct gve_rx_ring *)per_q_mem;
+	spin_lock_bh(&priv->stats_lock);
+	priv->base_net_stats.rx_packets += priv->rx[idx].rpackets;
+	priv->base_net_stats.rx_bytes += priv->rx[idx].rbytes;
+	priv->base_ring_err_stats.rx_alloc_fails +=
+		priv->rx[idx].rx_skb_alloc_fail +
+		priv->rx[idx].rx_buf_alloc_fail;
 	*gve_per_q_mem = priv->rx[idx];
 	memset(&priv->rx[idx], 0, sizeof(priv->rx[idx]));
+	spin_unlock_bh(&priv->stats_lock);
+
+	gve_per_q_mem->rpackets = 0;
+	gve_per_q_mem->rbytes = 0;
+	gve_per_q_mem->rx_skb_alloc_fail = 0;
+	gve_per_q_mem->rx_buf_alloc_fail = 0;
 	return 0;
 }
 
@@ -2833,12 +2890,22 @@ static void gve_get_base_stats(struct net_device *dev,
 			       struct netdev_queue_stats_rx *rx,
 			       struct netdev_queue_stats_tx *tx)
 {
-	rx->packets = 0;
-	rx->bytes = 0;
-	rx->alloc_fail = 0;
+	const struct gve_ring_err_stats *base_err_stats;
+	const struct rtnl_link_stats64 *base_stats;
+	struct gve_priv *priv;
+
+	priv = netdev_priv(dev);
+	base_stats = &priv->base_net_stats;
+	base_err_stats = &priv->base_ring_err_stats;
+
+	spin_lock_bh(&priv->stats_lock);
+	rx->packets = base_stats->rx_packets;
+	rx->bytes = base_stats->rx_bytes;
+	rx->alloc_fail = base_err_stats->rx_alloc_fails;
 
-	tx->packets = 0;
-	tx->bytes = 0;
+	tx->packets = base_stats->tx_packets;
+	tx->bytes = base_stats->tx_bytes;
+	spin_unlock_bh(&priv->stats_lock);
 }
 
 static const struct netdev_stat_ops gve_stat_ops = {
-- 
2.56.0.385.gd3acb90ef8-goog

