Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597888;
	b=gEQSf5935EK1+dgySDjqiioDhUreGKaUcpNzi6MW0s+qh+iJOWeKPSyuo8YCjE17L1lx
	 S/k5R+5aCojvvoKYTp/4Yv8pGW+H0mxSNj7V0pQpET/NojW5fQwsxsP4JBMwh8ryYaT/H
	 M1/vV4t1/sqZJQnjdWSs9WDmfyqo/Yb2gVMP6De/bwrWvQZm9Q/lDGEN5UIF0QRSiTNqN
	 AAm+xgztTvrWO4lUAkMCo+qYSFAUXNLrmTv/IHVjrHMdBOcKkGUh91lT+/a2VaiubxRev
	 EExnut8IXUFtMyEXRnot98qrEuimyaGzAsbiJ8BZolxDmPOI0GV4iC7W+Jeqf86tJmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597888;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=klVAh3x8vX2dmo+oBEBSDu/gV2igrBTPdcTc+eiXguc=;
	b=YPjzdHK6qAi4A3Ur/8pUx76NSnP1JDL4822ImZ5YxtgAif78HDyyp9NuzStKSZkR0Qv6
	 O7TZw/6UcwC4mm4anV+fAQ+IIc4NyGtLgm24bjKYosXfPD7AItoBNd/PFdIoYv8t3xQ++
	 i9RYh4Qwp9LvC/5Ckf/e8oV8qCOWwSV/B+MQLQSQ1FKIRoYnH/Zfny9DmEBFGMfy8gFGz
	 /+D+BpvY/FbXUNF2kkSfT6v5drDAyt0F2LtnfxZkmss8ifTaqfnMNAntfUBLNhg/IOQnk
	 HOOgfL2TIE84vrjFMU6ItrWkIWuAqQjNWDTr7qN5Pxj+MJADVM+GqPsIWdH8KdQcRbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HSl6lOcg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A13606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HSl6lOcg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B1B1F000C6;
	Wed, 25 Nov 2026 09:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795597888;
	bh=klVAh3x8vX2dmo+oBEBSDu/gV2igrBTPdcTc+eiXguc=;
	h=Subject:To:Cc:From:Date;
	b=HSl6lOcgaX9bMC+E+9FEFVNYPsJ4qCAfgB12JTQOK8WmV9jLTxhDzH+QPkKSF1p2i
	 AjtJ4ldWfauuUM8vI1LtAuNIikSDnnMZq33RpbyincaDoDXrNYKIyKC/28Rkuhlvy3
	 3etd9MOYYSMYp2qWTBRJVvRYCbboRs7h0jNulchM=
Subject: FAILED: patch "[PATCH] gve: Fix backward stats when interface goes down or" failed to apply to 7.3-stable tree
To: debarghyak@google.com,hramamurthy@google.com,kuba@kernel.org,treapking@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 09:59:47 +0100
Message-ID: <2026112547-canon-stamp-3528@gregkh>
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


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 6752dfc316b94ce02998a79509df62a3aba51d1c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112547-canon-stamp-3528@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6752dfc316b94ce02998a79509df62a3aba51d1c Mon Sep 17 00:00:00 2001
From: Debarghya Kundu <debarghyak@google.com>
Date: Mon, 9 Nov 2026 18:20:34 +0000
Subject: [PATCH] gve: Fix backward stats when interface goes down or
 configuration is adjusted

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

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 1911d05eb697..e509488a3d3e 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -871,6 +871,10 @@ struct gve_ctrl_ops {
 	int (*report_link_speed)(struct gve_priv *priv);
 };
 
+struct gve_ring_err_stats {
+	u64 rx_alloc_fails;
+};
+
 struct gve_priv {
 	struct net_device *dev;
 	struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
@@ -960,11 +964,14 @@ struct gve_priv {
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
index 45868cc4dd25..b5e2f39a903c 100644
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
 {
-	struct gve_priv *priv = netdev_priv(dev);
-	unsigned int start;
-	u64 packets, bytes;
-	int num_tx_queues;
 	int ring;
 
-	spin_lock_bh(&priv->stats_lock);
-	num_tx_queues = gve_num_tx_queues(priv);
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
+{
+	unsigned int start;
+	u64 packets, bytes;
+	int ring;
+
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
 
@@ -646,6 +696,9 @@ static void gve_queues_mem_remove(struct gve_priv *priv)
 	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 
 	spin_lock_bh(&priv->stats_lock);
+	gve_get_ring_stats(priv, &priv->base_net_stats);
+	gve_get_ring_err_stats(priv, &priv->base_ring_err_stats);
+
 	priv->tx = NULL;
 	priv->rx = NULL;
 	spin_unlock_bh(&priv->stats_lock);
@@ -2690,9 +2743,19 @@ static int gve_rx_queue_stop(struct net_device *dev, void *per_q_mem, int idx)
 
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
 
@@ -2850,12 +2913,30 @@ static void gve_get_base_stats(struct net_device *dev,
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

