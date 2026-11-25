Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620349;
	b=wtyNznKpSdOOJ4VBlvIEdEEwUWC+T5bUBPo1NBfeTZGO5k44ImHtjLrs8NVshOEVABOD
	 lGI+U8gSy/VZoJQvsAr5J6SkmLbbpT/b/2Kt+CqzqV/JO1HINE/6TAN4ZVVQo/7+gy7lv
	 J4kHyMuLBlCc4l14ez/0R6uCXcdg9YCbY/mDNYnmpxpcvrgZaoIOyr9HXv4LhXRKJOIPC
	 ytijan1bMZSCV9H7FX8dwOro4k0WR+P3Z+IQTCGJynscDxgIp/wkm9+n7MrOqwLk4DCtK
	 UOPLNoCOp87IOEdQALaV9UhYcxSgK4L8gdph3OMNLZRKHuqca65i/jb2ejqAjYKNv3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620349;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xTOKQC8X/QQ8CWzx9e1/q21vZ8bwOtq6T3+hh8LyjvE=;
	b=upIcYtdlTU00wR0R4PSGKmyW2DIO+30LscLuizp3knNzstrc/a8unqYi/nuzsKj39VYk
	 /S+VHx9LLkNp9Ci8VM389RFsduw1cbMLgjabwtSyA53t4eC0r2oevBxrOXAi0SJY62AMr
	 iUSQz7okDPIwQfYi205rdksc8GpJaExsfY0SCeScowGNm5B29LWmGCaaIajeRXPt+XjQs
	 ofX2AL1Ww2bys8x29FtgIMPBcSpNLdzHFfDBo0UmA1v0Yqe49mwJXktWLI0gSeJCoDfcN
	 tnaXQ7rQ+PkDVt01j4+7ok43O6djWtIUAGbXszGJiR4SsUL/RKLS5x78v01e0YS1I8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EAyoRWDM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608AC606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EAyoRWDM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663751F000CF;
	Wed, 25 Nov 2026 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795620349;
	bh=xTOKQC8X/QQ8CWzx9e1/q21vZ8bwOtq6T3+hh8LyjvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EAyoRWDMHUQBhQHpibtYP6rLoOJKoWWTP4YtzWG0vjksgHS/Zjd6gsheBZ8nBj8hb
	 LurruD1LVQbilhgtpmoDXWJ1z2FxDDrwEG3pgPiMb8AEWDeKJOXJIe0mjXkgwRtREn
	 TM3oDL6q4Js6mJC8Mi3dvUlo5NEx3sL3AoXbxg4vtI/V/5rMz1EHU6gN9XOAmINUn7
	 SEz4tlYLJ1eWMdkDaKsQzt4Wj3sWLRbGG8W6/kapUnNkWfvU8B3taZ5Uw+yznQJhF7
	 ZyLAe+WhyTIu+XHksKl1dyyi2JBwmJXWee6IatFtSHfpfBjzhTMsZ4I8Dcq0LhVQeT
	 GfADjDmnnnf3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Debarghya Kundu <debarghyak@google.com>,
	Pin-yen Lin <treapking@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] gve: Fix backward stats when interface goes down or configuration is adjusted
Date: Wed, 25 Nov 2026 10:25:47 -0500
Message-ID: <20261125152501.14635-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112547-canon-stamp-3528@gregkh>
References: <2026112547-canon-stamp-3528@gregkh>
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

From: Debarghya Kundu <debarghyak@google.com>

[ Upstream commit 6752dfc316b94ce02998a79509df62a3aba51d1c ]

gve_get_base_stats() sets all the stats to 0, so the stats go backwards
when interface goes down or configuration is adjusted.
ndo_get_stats64 has the same problem, since gve_get_stats() only sums
the live rings, which are freed when the interface goes down.

This issue was discovered and actually triggered by the
drivers/net/stats.py selftest (check_down test case). Bringing down the
interface caused statistics counters to reset to 0, triggering selftest
assertion failures because netdevice stats must not go backwards.

Fix this by persisting baseline stats across queue teardown in
gve_queues_mem_remove() and single-queue stop in gve_rx_queue_stop().
The baseline is reported by both ndo_get_stats64 and
gve_get_base_stats().

Also report the live XDP TX ring counters in gve_get_base_stats(), as
those rings are not exposed as netdev queues.

This change was tested using the DQO RDA queue format.

Cc: stable@vger.kernel.org
Fixes: f5cedc84a30d ("gve: Add transmit and receive support")
Fixes: 2e5e0932dff5 ("gve: add support for basic queue stats")
Signed-off-by: Debarghya Kundu <debarghyak@google.com>
Co-developed-by: Pin-yen Lin <treapking@google.com>
Signed-off-by: Pin-yen Lin <treapking@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
Link: https://patch.msgid.link/20261109182036.2910559-3-hramamurthy@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Depends on <20261125151623.40338-1-sashal@kernel.org>

 drivers/net/ethernet/google/gve/gve.h      |   7 ++
 drivers/net/ethernet/google/gve/gve_main.c | 125 +++++++++++++++++----
 2 files changed, 110 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 221b059817038..b0a20e04d5970 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -835,6 +835,10 @@ struct gve_ctrl_ops {
 	void (*unmap_db_bar)(struct gve_priv *priv);
 };
 
+struct gve_ring_err_stats {
+	u64 rx_alloc_fails;
+};
+
 struct gve_priv {
 	struct net_device *dev;
 	struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
@@ -924,11 +928,14 @@ struct gve_priv {
 	/* Protects the priv->tx/priv->rx arrays, the in-place rewrite of
 	 * priv->rx[idx] and the queue counts against stats readers that do
 	 * not hold the netdev instance lock.
+	 * Also protects base_net_stats and base_ring_err_stats.
 	 */
 	spinlock_t stats_lock;
 	unsigned long service_task_flags;
 	unsigned long state_flags;
 
+	struct gve_ring_err_stats base_ring_err_stats;
+	struct rtnl_link_stats64 base_net_stats;
 	struct gve_stats_report *stats_report;
 	u64 stats_report_len;
 	dma_addr_t stats_report_bus; /* dma address for the stats report */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 920c1fe4c5182..1ffbc52109b87 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -61,16 +61,44 @@ static netdev_tx_t gve_start_xmit(struct sk_buff *skb, struct net_device *dev)
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
+static void gve_add_tx_ring_range_stats(struct gve_priv *priv, int start_ring,
+					int end_ring, u64 *packets, u64 *bytes)
+{
+	int ring;
+
+	for (ring = start_ring; ring < end_ring; ring++) {
+		struct gve_tx_ring *tx = &priv->tx[ring];
+		unsigned int start;
+		u64 pkts, byts;
+
+		do {
+			start = u64_stats_fetch_begin(&tx->statss);
+			pkts = tx->pkt_done;
+			byts = tx->bytes_done;
+		} while (u64_stats_fetch_retry(&tx->statss, start));
+		*packets += pkts;
+		*bytes += byts;
+	}
+}
+
+static void gve_get_ring_stats(struct gve_priv *priv,
+			       struct rtnl_link_stats64 *s)
 {
-	struct gve_priv *priv = netdev_priv(dev);
 	unsigned int start;
 	u64 packets, bytes;
-	int num_tx_queues;
 	int ring;
 
-	spin_lock_bh(&priv->stats_lock);
-	num_tx_queues = gve_num_tx_queues(priv);
 	if (priv->rx) {
 		for (ring = 0; ring < priv->rx_cfg.num_queues; ring++) {
 			do {
@@ -84,19 +112,41 @@ static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
 			s->rx_bytes += bytes;
 		}
 	}
-	if (priv->tx) {
-		for (ring = 0; ring < num_tx_queues; ring++) {
-			do {
-				start =
-				  u64_stats_fetch_begin(&priv->tx[ring].statss);
-				packets = priv->tx[ring].pkt_done;
-				bytes = priv->tx[ring].bytes_done;
-			} while (u64_stats_fetch_retry(&priv->tx[ring].statss,
-						       start));
-			s->tx_packets += packets;
-			s->tx_bytes += bytes;
-		}
+	if (priv->tx)
+		gve_add_tx_ring_range_stats(priv, 0, gve_num_tx_queues(priv),
+					    &s->tx_packets, &s->tx_bytes);
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
 	}
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
 
@@ -647,6 +697,9 @@ static void gve_queues_mem_remove(struct gve_priv *priv)
 	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 
 	spin_lock_bh(&priv->stats_lock);
+	gve_get_ring_stats(priv, &priv->base_net_stats);
+	gve_get_ring_err_stats(priv, &priv->base_ring_err_stats);
+
 	priv->tx = NULL;
 	priv->rx = NULL;
 	spin_unlock_bh(&priv->stats_lock);
@@ -2698,9 +2751,19 @@ static int gve_rx_queue_stop(struct net_device *dev, void *per_q_mem, int idx)
 
 	gve_per_q_mem = (struct gve_rx_ring *)per_q_mem;
 	spin_lock_bh(&priv->stats_lock);
+	priv->base_net_stats.rx_packets += priv->rx[idx].rpackets;
+	priv->base_net_stats.rx_bytes += priv->rx[idx].rbytes;
+	priv->base_ring_err_stats.rx_alloc_fails +=
+		priv->rx[idx].rx_skb_alloc_fail +
+		priv->rx[idx].rx_buf_alloc_fail;
 	*gve_per_q_mem = priv->rx[idx];
 	memset(&priv->rx[idx], 0, sizeof(priv->rx[idx]));
 	spin_unlock_bh(&priv->stats_lock);
+
+	gve_per_q_mem->rpackets = 0;
+	gve_per_q_mem->rbytes = 0;
+	gve_per_q_mem->rx_skb_alloc_fail = 0;
+	gve_per_q_mem->rx_buf_alloc_fail = 0;
 	return 0;
 }
 
@@ -2858,12 +2921,30 @@ static void gve_get_base_stats(struct net_device *dev,
 			       struct netdev_queue_stats_rx *rx,
 			       struct netdev_queue_stats_tx *tx)
 {
-	rx->packets = 0;
-	rx->bytes = 0;
-	rx->alloc_fail = 0;
+	const struct gve_ring_err_stats *base_err_stats;
+	const struct rtnl_link_stats64 *base_stats;
+	struct gve_priv *priv;
 
-	tx->packets = 0;
-	tx->bytes = 0;
+	priv = netdev_priv(dev);
+	base_stats = &priv->base_net_stats;
+	base_err_stats = &priv->base_ring_err_stats;
+
+	spin_lock_bh(&priv->stats_lock);
+	rx->packets = base_stats->rx_packets;
+	rx->bytes = base_stats->rx_bytes;
+	rx->alloc_fail = base_err_stats->rx_alloc_fails;
+
+	tx->packets = base_stats->tx_packets;
+	tx->bytes = base_stats->tx_bytes;
+	/* XDP TX rings are not exposed as netdev queues, so report their live
+	 * counters here to keep the device totals consistent with
+	 * ndo_get_stats64.
+	 */
+	if (priv->tx)
+		gve_add_tx_ring_range_stats(priv, priv->tx_cfg.num_queues,
+					    gve_num_tx_queues(priv),
+					    &tx->packets, &tx->bytes);
+	spin_unlock_bh(&priv->stats_lock);
 }
 
 static const struct netdev_stat_ops gve_stat_ops = {
-- 
2.53.0

