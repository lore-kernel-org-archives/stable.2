Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792788431;
	b=0HHh/DJhrQgDPp6UbisHDYek8p0Gxv7D50FFDmMLbfCT5e9B1A0PWRLQXDL2eyirgzHw
	 dGDqf9Yu+kAwrmeWiQ/VZmkdj/Y6pZUN75vwRiQYfgWf0i1yhn+VSRNYkmqF6iB5YkHrT
	 4GwS+h41qUOS3OBIq0EXJypk0RrkrFv+uXEwUW/cVXDV6+6SU77Ir3GRgCVJvL0N4k6p9
	 u8ImxP+4hXHFwtxNE9XGPcl4V/je47KjlQyKhiHArlaeg3y/8BIp0Y+YeTvnxQ21L+NKA
	 VSQr88weEL22f2JOLHJwp62qlOJJzGEv/1qtHV3H6wR6WZ9LBawbItAFywo+HnkHZ3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788431;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=qbPbO3PKUXjF84+J52hRtmYnr8K0qVr7xP7r7MG3eYo=;
	b=R2JjlIY5K80iC0WFFeEXqVM1sVjfhMe+oGRG3MBEh25udVW01hGDHy8oy2JtPuUl8rv4
	 BCUia9YSJv2JhGWSeov6x7N6QhPxLKSta1XDhx8BnEC9A1bSqrQNctBxoJZYVL1SY8fm8
	 nlBl917/j5F7pLk8B4G0dx6oVrhLI0NSYKgptExmmcFLnQu8yKLi6fnOut1TsZMbP0YMk
	 PrzxjB3jffOHfXadHwQJ5WT1aBTr4IkrM30NFosDb8JblYv0PpMYI6CBGvRFsADJVz5uZ
	 jhC/IahjLBS3PvvB2/xOoCKGf6aY2K05x2Itro4PxQw36aerXuOUIouFTbcrPztMNOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=v5t5MV02;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B73606A334
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 20:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7B73606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=v5t5MV02
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ab7f1efe5dso2178805a91.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 13:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792788430; x=1793393230; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qbPbO3PKUXjF84+J52hRtmYnr8K0qVr7xP7r7MG3eYo=;
        b=v5t5MV02yiLcFkwPrMm0RSjKxpXbSvNB29FDszP5i7AsxCW1nIjR+DEBZOZB9DDJ8O
         ksoEYzAtrJzjkz8KeD6+pzxLWx09Hrm7rk4zSpM0Ny2O6S8DeYHAYqmtfRnW3Mp30BO9
         JqQoJWvNkM6bdqMhX4GvhZkOFkdkI2R7ieGHpwFp0mx/XIuM8ByYCmmVsWYAM4/oijbY
         HGfcf4Pse25pRuzBt+75Zr9ba39IZEFoDVnDM/1oMKRiMObfoK3mYZMY0qzgRyjZ3CeH
         eZZs+1ZJ2Nac5rnBF8TuHMOVuS0nWqyIfpBa/sjD4tC6VOv5LBW+CjsO1m0+q3oQlj84
         ukbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792788430; x=1793393230;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qbPbO3PKUXjF84+J52hRtmYnr8K0qVr7xP7r7MG3eYo=;
        b=ob+d2cjQfkVKvDS1mMUAgjCCOEzPr55qnewukwxe+kBbHNnWRtM2EzDDPtHlqhu9TS
         bvHHz1if4jLimGsMYhFu/3hGGGP2+8TLtQz4CRtjp1fKd7XrijPD4T+8FCuOvOsH+qfH
         YnPESEE9S+kpOmkU0UxxE9V0K1mj1Awtx/sTFQNFyzFwyv9EKfj35nD91zhr7rgFCnNY
         eFIMKbxM/WwqdMIpZcWgcge9m+7hqJt9bCoX13LIiJXu2R/uEGRrhU678pEDXZLRrznK
         62+RCfNtFrkIxr6aUlVuKc3E0HeUbMIaJq3i42MzbOOPceFYW23MmQnmLz1mw03AcC3C
         juhg==
X-Forwarded-Encrypted: i=1; AKwUvBxsRABDb/0WWeL/odxKtzsQUbFAaqn4simwHGwvl9Z4IZBgve2QYuO/FQEyqKYogbnLuNTTZ6c=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEDgsuCwMxHMA8vNqK0A7haqCCSEgYD/Ogx1VRpmwLD4fmpnay
	Lonci2PIrNv7EDjlZEjwRRdYhrXRZO1gprfkKerl2kZuw8HbWplxhlpjU4+qyui+mOb4aDbqJ/u
	tZoZW4hYWW0h86oU5hZbqu4luKg==
X-Received: from pjbok17.prod.google.com ([2002:a17:90b:1d51:b0:3ab:1a0f:bf1d])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4e8b:b0:39e:6a80:b799 with SMTP id 98e67ed59e1d1-3adeafd219dmr316667a91.41.1792788429997;
 Fri, 23 Oct 2026 13:47:09 -0700 (PDT)
Date: Fri, 23 Oct 2026 20:47:04 +0000
In-Reply-To: <20261023204706.3112215-1-hramamurthy@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261023204706.3112215-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261023204706.3112215-3-hramamurthy@google.com>
Subject: [PATCH net v3 2/4] gve: Fix backward stats when interface goes down
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

This change was tested using the DQO RDA queue format.

Cc: stable@vger.kernel.org
Fixes: 2e5e0932dff5 ("gve: add support for basic queue stats")
Signed-off-by: Debarghya Kundu <debarghyak@google.com>
Co-developed-by: Pin-yen Lin <treapking@google.com>
Signed-off-by: Pin-yen Lin <treapking@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
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
index 26fdd22644f4..52c152a986eb 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -61,15 +61,25 @@ static netdev_tx_t gve_start_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -97,6 +107,38 @@ static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
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
 
@@ -646,6 +688,9 @@ static void gve_queues_mem_remove(struct gve_priv *priv)
 	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 
 	spin_lock_bh(&priv->stats_lock);
+	gve_get_ring_stats(priv, &priv->base_net_stats);
+	gve_get_ring_err_stats(priv, &priv->base_ring_err_stats);
+
 	priv->tx = NULL;
 	priv->rx = NULL;
 	spin_unlock_bh(&priv->stats_lock);
@@ -2689,8 +2734,20 @@ static int gve_rx_queue_stop(struct net_device *dev, void *per_q_mem, int idx)
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
 
@@ -2844,12 +2901,22 @@ static void gve_get_base_stats(struct net_device *dev,
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
2.56.0.257.gf7497c7d27-goog

