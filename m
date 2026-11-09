Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248443;
	b=m4uAHuRQF2ciwzPb3ks/c8U6dzFg+QWHcc4oFKZfTb4SEArqZFTsIEHC69cD+52or4ip
	 EqMwaj+sZmAM0zmFc/HBZRYcFQDxKAEPcKbVFdLRbUsEqIJoLGitq8mJZ93+YcOkCn1hk
	 3ZkkuKfmQlIjKIkLDnC2lHCIu+YYeQysFzHnlGjBuMD1wZ1E9BnRqB1SIsZIyrp3Vr7sb
	 YPI909oqQ1dtlOvfLantRGYri2Y4pQB5jNdC3HkLNPOmryOonu7BtTGS7MkxZM/FN50X4
	 oChf7w6PmtFlJ+Lnzp3kE7gxGeglA89tP14bTfmDrlDBOyLpSRF+x/DE74loGYB4zvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=hb1e5T/1/BrBF37EIpY7Y1LmfoCtKyJu5XTK4YaH3kg=;
	b=TCKve5i1LCTYXBgpBPpiQLDhY9elKyrIMdZfGZD828Lb+xksRiA0xqpTu/Z4MGPecLKx
	 1BPCH55MMH7KXx3Mfo7BF6guO2KEp+UycO6bPMT8wDQEOSjPdUW/sE/7bIcmf5RnD07DW
	 htLNkzRv1vTc5N4SaeygwZlp1q+U8u3ATSrOUkgwPVPHNa1i2q/kMzsk42Bxhul5Gk1rE
	 FrqqdJ3ErUABRWJjn+1Ri7sDKBcZL4e/PYe/2WXC3Ma/0sRA+aNv/O2QybJRZ1IgfD0nO
	 8UzELEqV9jJ7erfhnkIMKrYZGWko4psL+ZbrPr5VEAp/84TeX9C76nbBuRpkUIrv7cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NcdrjhzZ;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9E360A2604
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 18:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D9E360A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NcdrjhzZ
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdb91ba399fso616240a12.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 10:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248442; x=1794853242; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hb1e5T/1/BrBF37EIpY7Y1LmfoCtKyJu5XTK4YaH3kg=;
        b=NcdrjhzZG1AAEURh3INjyF7trYPywuNZJj61GltKZL/KQzlCeznRo7EcVRTr9E/kIK
         YRgYHTp6i0CIaEtXTuOx/4ZZMDZ1nRvM4nI9YNoBlw+nvZFL6o4gB4V2JIOyYFKtBvOh
         2DPAdI7IAERyOhqJHZ7mkHtfrbS0Sr+7yp7L/OKW66++YM01bEymYKV1P70C06znzs14
         OpNeGxxGY2a58FA6z0wOt+b5/W1eVW5I3VPJWUaqiIsmOKtGTde396EuoFZ5fTk7nTYM
         ZIihSMBKeSZsQEDaoWQwoQU73hAUGIdMQvL70MP7rcrjAjqfBBAK5mROCDfy0KodwCYy
         u3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248442; x=1794853242;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hb1e5T/1/BrBF37EIpY7Y1LmfoCtKyJu5XTK4YaH3kg=;
        b=c5WQmPa62bZeyknxaG1nvazAXUPTGW94wI4wZXnpAaiwvu3T0/Z5WbDwB6YAo3Hhqy
         Z4nsXPJuMxw9CXRJMnI3gL6MflLw/KafMZna9qO47GuUeqJhWtWQ8uGiwaTq0xLeRepO
         3sKyLd5f3dyR02Xy1HobnzysdUXQ36Hc63jJ8+nhzxXwvNPiLqsokRDOcxf3Oi087qpi
         GAIuiUcjoWcQeZ+lnoEEvKWAdwLZZK1WRTFoCJcW+4ly7DR8AeVFC5AvQc60SA40Ep/A
         Xdl8COuzffBg/a+br1CzuQIOWcUOjYMZBuo4EjWkRDhalirDvjO0vY1BEhvklIHDzSvB
         FcNA==
X-Forwarded-Encrypted: i=1; AL+hErFkq4NbHF+AjZ01FacN8rQFiTUXxZSd7BNItVNSZIW7QEK+zZmTesvU4DjlKBx9zB8STDP1kCI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HaRRUTKrWr+GQRMPYxNTTNB2dXZZUHHTjb0HJeyPVvh7jijV6
	jL8DdxaNsJ0uZM5Aorj2B/XVvHg1A2QSG5/lEHyR32qNmlZQtVtc79hlH9tLmG8WEB+uJhREH3X
	CymVoSqPpGiFYI1nvrjIJ0fDeBg==
X-Received: from pjuj5.prod.google.com ([2002:a17:90a:d005:b0:3b1:29ae:3c64])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2b44:b0:3ac:4e18:237c with SMTP id 98e67ed59e1d1-3b1668deba8mr553043a91.0.1794248442209;
 Mon, 09 Nov 2026 10:20:42 -0800 (PST)
Date: Mon,  9 Nov 2026 18:20:34 +0000
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
Message-ID: <20261109182036.2910559-3-hramamurthy@google.com>
Subject: [PATCH net v5 2/4] gve: Fix backward stats when interface goes down
 or configuration is adjusted
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	jordanrhee@google.com, willemb@google.com, przemyslaw.kitszel@intel.com, 
	nktgrg@google.com, maolson@google.com, jacob.e.keller@intel.com, 
	pkaligineedi@google.com, yangchun@google.com, patricion@google.com, 
	awogbemila@google.com, csully@google.com, jonolson@google.com, 
	lrizzo@google.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Debarghya Kundu <debarghyak@google.com>, Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Debarghya Kundu <debarghyak@google.com>

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
---

Changes in v5:
- Move the stats_lock around the priv->rx[idx] writes in
  gve_rx_queue_stop() and gve_rx_queue_start() to patch 1 (Sashiko)
- Mention the ndo_get_stats64 counters in the commit message and add a
  Fixes tag for f5cedc84a30d (Sashiko)
- Document that stats_lock also protects the baseline stats

Changes in v4:
- Report the live XDP TX ring counters in gve_get_base_stats() (Sashiko)
- Take stats_lock around the priv->rx[idx] writes in
  gve_rx_queue_start() (Sashiko)

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

 drivers/net/ethernet/google/gve/gve.h      |   7 ++
 drivers/net/ethernet/google/gve/gve_main.c | 125 +++++++++++++++++----
 2 files changed, 110 insertions(+), 22 deletions(-)

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
-- 
2.56.0.455.g6c5a503b38-goog

