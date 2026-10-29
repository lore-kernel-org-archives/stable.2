Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793308599;
	b=x/M+XgxenT7ebnN8ZbEXWhY2NM6svxyDek4UgKVXzvEmwfST2Fu4CWyL9UTCPrr1a2BN
	 u1mCbJiZLmV+hBezD/TM0SpXj0bq9cL26oeaFF5tCy+9FwY9OViixvMVGqm2muf+7pw6L
	 k/Y7eeZ3shTgrzGjeIs+8RivQ9td6sBJkM0hmrYCrb7Q6NXdoH14/8hLnNHtMKEmq4gQe
	 V1CJAXUEqQbWXkQ731Hdx9zS23tEel12CzWMpLYS+7gh8mKHVLS3IRebRcf/tlwAikQDL
	 r2ktA1d9ww+BUIekSpxwTKvDjIywIm3Vlgb0bShevvXowwKgKpK9JEt3qciJJYau0qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ubPnJzRS8C1+M2WmRVf76+mZlKCt4O18wsj2CRU6IKw=;
	b=orjZsCouUiW3NHqnKPWoHzC87CZ+lhD+LloUvQ0kTWGT6IB/OyOUlvaOwghtZJh7hMop
	 BhGWtCd+d1+ksr/x+dbsD9wjBOd7QtlVy/61J6SI7pcYuaZZDjy4eQVdpHH1igVt8MUtz
	 IllADSkc10Hd1Ol1Og3qnuid6S7pqt3V/nbqyUDeYqwS2eYO8p+4cV54r//n0nG4iKZ7n
	 JAf6PE1jWxk0LaOPfnyHnEztDLXAELwKa/h5Uzpm9k3Kges+AXrw/EWEYfXrrNtGpknzv
	 0wdl7aW/RRMb/VA3W7O1GXK6BNrjHAerTDwAtfBV0kur85SKlz1Hjh1sIEi8TDika8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oA8bBns3;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A14606A331
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 21:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78A14606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oA8bBns3
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ade5b3ae97so52255a91.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793308599; x=1793913399; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ubPnJzRS8C1+M2WmRVf76+mZlKCt4O18wsj2CRU6IKw=;
        b=oA8bBns3TAyYqiYf2YWxAO7LMvAAee3flytLjR8v8+nT5ayS4RVnq8kwS6pBsuDUkE
         r0VQJLzydMDgjfbqh7hiRjTsdus+I24ucjHA5OSgLEg/DBQWawnA63VxFQyT8cscVu6u
         jJLggqoB2MAAGBfjhlsxRpGYYVgS3XgRHMS6hzpbc4Hiz/SkCpFk+uh8Mj4tpn2kiNjv
         r3cfwTjVNEGIyA7TzosVR5XKvFjVNUjE1aZlPszEFMfS/x+4xWhGBPj5PEa9B1gr0kYD
         bZPVrbXsoNvgchoHzHmjmN5/Ug7KRb95BP3HJH1pLkLTzQfQ38HHOkDRRzHBgJhYX6SP
         cCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793308599; x=1793913399;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ubPnJzRS8C1+M2WmRVf76+mZlKCt4O18wsj2CRU6IKw=;
        b=MWQASmrHzdsHcuKbUpWe9gQ989sOsKa4r6cw17cBL4BbqSk3mwGV/o5ycqiTKlAVZt
         nDXMLu6RII7mWA5vJXB+zdskEHkf22s4DuuKbytGYOtcZR5I3x1C+4kPmjX6h7QTa9iO
         FFASMUwtRouORUHqg9m+1tpCJMWFkn6xlI4hp8sKYzFH2PsgXGg/i5X9MRE+t8sNvSGH
         6muJ8pEC2lMzAoOPj139JC9pEvP1q7htBjT+VKStBhCoxhFTp5U4NmBwcxQfWUZZi81k
         hyvg5Gdc5luzqWIdpWqBH5jYrQzYffBGJMXdyqqqFACWR2ZDEZqcORG5tvWRwdWGQIZ8
         n8Jw==
X-Forwarded-Encrypted: i=1; AKwUvBxbaboqThckrirFBMeVeVpM1MxTz2lZF1TeHhPP9tv5/8KUr6WwRbj8LsL2wJMkMp8hZxHfm7k=@vger.kernel.org
X-Gm-Message-State: AFq9FYIKj2Ie+l3Bw1tYMFykJzprWgMZZQDwY40YyOfDlVnNvgSODfsu
	FmCXm9tQtwfAwGxJQctZAUYBuvwYy1rRT87W+NHn+B9x+j8Y/Aj5WiGvBVGFfYQ6Ue87EoSXDto
	BKnPp0W/0APAxdx1LXXgFz5y93w==
X-Received: from pjbci19.prod.google.com ([2002:a17:90a:fc93:b0:3ad:3715:39c8])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e7c5:b0:3a8:337d:228a with SMTP id 98e67ed59e1d1-3ae89559886mr128445a91.6.1793308598543;
 Thu, 29 Oct 2026 14:16:38 -0700 (PDT)
Date: Thu, 29 Oct 2026 21:16:32 +0000
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
Message-ID: <20261029211634.2232784-3-hramamurthy@google.com>
Subject: [PATCH net v4 2/4] gve: Fix backward stats when interface goes down
 or configuration is adjusted
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	jordanrhee@google.com, willemb@google.com, przemyslaw.kitszel@intel.com, 
	nktgrg@google.com, maolson@google.com, jacob.e.keller@intel.com, 
	pkaligineedi@google.com, yangchun@google.com, patricion@google.com, 
	awogbemila@google.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Debarghya Kundu <debarghyak@google.com>, Pin-yen Lin <treapking@google.com>
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

Also report the live XDP TX ring counters in gve_get_base_stats(), as
those rings are not exposed as netdev queues, and take stats_lock around
the priv->rx[idx] writes in gve_rx_queue_start().

This change was tested using the DQO RDA queue format.

Cc: stable@vger.kernel.org
Fixes: 2e5e0932dff5 ("gve: add support for basic queue stats")
Signed-off-by: Debarghya Kundu <debarghyak@google.com>
Co-developed-by: Pin-yen Lin <treapking@google.com>
Signed-off-by: Pin-yen Lin <treapking@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---

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

 drivers/net/ethernet/google/gve/gve.h      |   6 +
 drivers/net/ethernet/google/gve/gve_main.c | 131 +++++++++++++++++----
 2 files changed, 115 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 104468c2c07f..37070bc14c87 100644
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
@@ -962,6 +966,8 @@ struct gve_priv {
 	unsigned long service_task_flags;
 	unsigned long state_flags;
 
+	struct gve_ring_err_stats base_ring_err_stats;
+	struct rtnl_link_stats64 base_net_stats;
 	struct gve_stats_report *stats_report;
 	u64 stats_report_len;
 	dma_addr_t stats_report_bus; /* dma address for the stats report */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 26fdd22644f4..b5e2f39a903c 100644
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
@@ -2689,8 +2742,20 @@ static int gve_rx_queue_stop(struct net_device *dev, void *per_q_mem, int idx)
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
 
@@ -2744,7 +2809,9 @@ static int gve_rx_queue_start(struct net_device *dev,
 		return -EAGAIN;
 
 	gve_per_q_mem = (struct gve_rx_ring *)per_q_mem;
+	spin_lock_bh(&priv->stats_lock);
 	priv->rx[idx] = *gve_per_q_mem;
+	spin_unlock_bh(&priv->stats_lock);
 
 	/* Single-queue creation requires quiescence on all queues */
 	gve_turndown(priv);
@@ -2780,7 +2847,9 @@ static int gve_rx_queue_start(struct net_device *dev,
 	 * which needs the rtnl lock, will not run till this func returns and
 	 * its caller gives up the lock.
 	 */
+	spin_lock_bh(&priv->stats_lock);
 	memset(&priv->rx[idx], 0, sizeof(priv->rx[idx]));
+	spin_unlock_bh(&priv->stats_lock);
 	return err;
 }
 
@@ -2844,12 +2913,30 @@ static void gve_get_base_stats(struct net_device *dev,
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
 
-	tx->packets = 0;
-	tx->bytes = 0;
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
2.56.0.313.g2479322e68-goog

