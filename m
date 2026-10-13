Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492B33E5ED5
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884334; cv=none; b=C6JyPv5ITTwslDjML3WUfbEj1yYYUrvElai2byR3z4V1CmZoYKEmykNYh6GXspUr2Fo6Gyzu8of2I6P6AgamhsWagFIlNqE+wXIs2f6XS1nEXaPWk5RshgNrRyeYawC2ArzYvJhrtAIzBP8ogGLpAvnRN6vWZDa4wPiyPD2kyDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884334; c=relaxed/simple;
	bh=21I4wPBoOyys6I/I4oz+y6A267LXMtufym+C8onvknE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IrO49V277vcIeKtyrejIS1yU6d+ZL1GdSMtQz3lFYruXz76WEv0YKFC9DuLFPIT2KZCH0xwFiVvVHpWcdEjdHcJzQVk/cprWDTpzVqaLoPxxKiA1A2PoBLZokd4ZAIfOAG78FKYKaSaSgFdXIEaHECb7r6ewiwabPFfqKTPHCtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--treapking.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M5cDc9IU; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--treapking.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M5cDc9IU"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc435388657so3164201a12.3
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 02:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791884332; x=1792489132; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RBOyFTgMZeQrLXq6kleb0kGmt9kObLBDbOVr1IVJhHk=;
        b=M5cDc9IUb/P9p9QI3kOX8z9sO5dMUkNNoVgrnrvCKYJUOaA1CK2hpLPrYUHAG9sJwS
         T4KoNkgHSuVGJx/K5P/fyyKugdxZkMBCgMydNxXRx3H+cqd47Tn1iNtG+5v9SxB16VV/
         2C25FTEuhlai8kfRiyPInkRIu/voOdcfxZTQzOIzfqUEZqw+2RRZt2skjoIPGJXuIYCG
         Rs9VERTXpcq9PN1qOnEbonDzU+qGwWmmColw7Qw7Zs6qxaJR1iGh5xJ8T44XFVLZH40G
         lV8PcuJDenjR74uGUJahYQNufMYd6H2gx68mivge0szWi8WQJH28G1IH1oMZd6La/Pns
         NcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791884332; x=1792489132;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RBOyFTgMZeQrLXq6kleb0kGmt9kObLBDbOVr1IVJhHk=;
        b=UJo29RVou+ZdNw7AZ65BDgNw/o8/etATUnAzdMDA9FTyb+AhmOjlP/h5BT+gw8lD45
         R6gmW3pUvLMB8U8NyUwEdSzT9Gh2xoE+kjorr4TQB2d5KRkwEP2yvDFNr3/OlPFkJrE2
         kCsa3yFumKnsSCWnOhApsuBFuoTzTbo/agObipbF8W7OXqIc95DMlvrSeecTziC3OH+h
         hanohkgh/ZZgq4xC3BAPTCLSl0Solz1whjItsBGVLfvQW2tDu+PM/3VGu3K4x9qdKxGd
         qaAuoSaKJLFN871O5QBUafS3oLTsQ6t9lkyZ0yUM7RBptiG4XrJSVufCLZXzaCNp9o/P
         Mh0A==
X-Gm-Message-State: AFq9FYKM8dZoIrCdqnTJ3Nj42NKH7kCKt4+3fL2szW/Ei1bpNyVFLbyZ
	XlrruQPBUJxc4GWLrW+DAvRQARyWR16+XK1xSsfrUkXRqDjGEq7J48SrFEUKtpPYcFkTOdFDE3O
	V352xXEiYTbcV4zYmVw==
X-Received: from pgca6-n1.prod.google.com ([2002:a05:6a02:6386:10b0:cc7:58af:e212])
 (user=treapking job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:278b:10b0:3e1:92ad:a8c5 with SMTP id adf61e73a8af0-3e192adabd2mr4239085637.44.1791884332448;
 Tue, 13 Oct 2026 02:38:52 -0700 (PDT)
Date: Tue, 13 Oct 2026 02:38:32 -0700
In-Reply-To: <20261013093836.1269134-1-treapking@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013093836.1269134-1-treapking@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013093836.1269134-2-treapking@google.com>
Subject: [PATCH net v3 1/5] gve: Fix race between stats query and queue reconfig
From: Pin-yen Lin <treapking@google.com>
To: treapking@google.com
Cc: stable@vger.kernel.org, Debarghya Kundu <debarghyak@google.com>
Content-Type: text/plain; charset="UTF-8"

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

Additionally, concurrent stats queries during queue reconfiguration can
race with gve_queues_mem_remove(), causing a Use-After-Free.

Fix this by introducing stats_lock to serialize stats queries against
queue teardown. In gve_queues_mem_remove(), queue pointers are set to
NULL under stats_lock before freeing. Stats readers acquire the lock
and verify pointers are non-NULL before reading counters.

This change was tested using the DQO RDA queue format.

Cc: stable@vger.kernel.org
Fixes: 2e5e0932dff5 ("gve: add support for basic queue stats")
Co-developed-by: Debarghya Kundu <debarghyak@google.com>
Signed-off-by: Debarghya Kundu <debarghyak@google.com>
Signed-off-by: Pin-yen Lin <treapking@google.com>
---

Changes in v3:
- Retitled from "gve: Add NULL pointer checks for per-queue statistics"
- Protect all stats queries and queue lifecycle updates with spinlock
  (sashiko)
- Refined the commit message

 drivers/net/ethernet/google/gve/gve.h      |  2 ++
 drivers/net/ethernet/google/gve/gve_main.c | 37 +++++++++++++++++++---
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index c280ff35ee77..6f1eef11715b 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -883,6 +883,8 @@ struct gve_priv {
 	struct workqueue_struct *gve_wq;
 	struct work_struct service_task;
 	struct work_struct stats_report_task;
+	/* Synchronizes stats accesses and queue teardown */
+	spinlock_t stats_lock;
 	unsigned long service_task_flags;
 	unsigned long state_flags;
 
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index a6c18e2431cc..b6168bdf2ce7 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -114,6 +114,7 @@ static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
 	int num_tx_queues;
 	int ring;
 
+	spin_lock_bh(&priv->stats_lock);
 	num_tx_queues = gve_num_tx_queues(priv);
 	if (priv->rx) {
 		for (ring = 0; ring < priv->rx_cfg.num_queues; ring++) {
@@ -141,6 +142,7 @@ static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
 			s->tx_bytes += bytes;
 		}
 	}
+	spin_unlock_bh(&priv->stats_lock);
 }
 
 static int gve_alloc_flow_rule_caches(struct gve_priv *priv)
@@ -1386,9 +1388,13 @@ static void gve_queues_mem_remove(struct gve_priv *priv)
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
@@ -1402,6 +1408,7 @@ static int gve_queues_start(struct gve_priv *priv,
 	int err;
 
 	/* Record new resources into priv */
+	spin_lock_bh(&priv->stats_lock);
 	priv->tx = tx_alloc_cfg->tx;
 	priv->rx = rx_alloc_cfg->rx;
 
@@ -1413,10 +1420,11 @@ static int gve_queues_start(struct gve_priv *priv,
 	priv->rx_desc_cnt = rx_alloc_cfg->ring_size;
 	priv->tx_pages_per_qpl = tx_alloc_cfg->pages_per_qpl;
 	priv->rx_pages_per_qpl = rx_alloc_cfg->pages_per_qpl;
+	gve_init_sync_stats(priv);
+	spin_unlock_bh(&priv->stats_lock);
 
 	gve_tx_start_rings(priv, gve_num_tx_queues(priv));
 	gve_rx_start_rings(priv, rx_alloc_cfg->qcfg_rx->num_queues);
-	gve_init_sync_stats(priv);
 
 	err = netif_set_real_num_tx_queues(dev, priv->tx_cfg.num_queues);
 	if (err)
@@ -2296,6 +2304,7 @@ void gve_handle_report_stats(struct gve_priv *priv)
 	if (!gve_get_report_stats(priv))
 		return;
 
+	spin_lock_bh(&priv->stats_lock);
 	be64_add_cpu(&priv->stats_report->written_count, 1);
 	/* tx stats */
 	if (priv->tx) {
@@ -2360,6 +2369,7 @@ void gve_handle_report_stats(struct gve_priv *priv)
 			};
 		}
 	}
+	spin_unlock_bh(&priv->stats_lock);
 }
 
 /* Handle NIC status register changes, reset requests and report stats */
@@ -2775,9 +2785,15 @@ static void gve_get_rx_queue_stats(struct net_device *dev, int idx,
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
@@ -2785,20 +2801,32 @@ static void gve_get_rx_queue_stats(struct net_device *dev, int idx,
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
@@ -2915,6 +2943,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	INIT_WORK(&priv->service_task, gve_service_task);
 	INIT_WORK(&priv->stats_report_task, gve_stats_report_task);
+	spin_lock_init(&priv->stats_lock);
 	priv->tx_cfg.max_queues = max_tx_queues;
 	priv->rx_cfg.max_queues = max_rx_queues;
 
-- 
2.56.0.385.gd3acb90ef8-goog

