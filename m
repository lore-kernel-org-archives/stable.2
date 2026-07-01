Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E878318A92F
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 00:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782867226; cv=none; b=dpJomChNY1UhLiXB6Ym1lYXvOq29+4FV+VkoLJon7803tY06oWKUwYiuYUeyh3FJmWDMMHOvLkijzKvi/bhOfT4f8/usnqa9xUviUV91fLKj8SEGikW5awR6H5BE+eOiTFEY6IU2p3V30XynKqqLtTRVczjCSYl1khJFT22TosY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782867226; c=relaxed/simple;
	bh=bSo7UrGXcDTB6T487uVQHoggxPZSU9AjJIhy2JYY8Nk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qBJAJVbrCu6ULngEnDygYWH3gXR8rqf6AHrYnZvb/xvLTbOizrcUQ5Q2Uny168j9zlUZwoeTtwkm5CMRXjImb+22Ukt38BOG9STSPlBitL1P5ZYVT0uHIsJqH8B7wgLPe8QsKc/+99kHzHn9AGeAlivBIaDYS17SrT7uo0iqbSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bPmAt6pP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bPmAt6pP"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c7f385887bso3657585ad.0
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 17:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782867223; x=1783472023; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TYxx5kClgfNIkaBKfBGqC0VpNEaGmmFN+tkQm/boFWE=;
        b=bPmAt6pPZ0KrClQ53e/YNCpeX3ET55EbEej1ICyuMi8q3ASTB2PvW51i0a9ijl/w4Y
         ToHZNg6wtESkRtT/nZzjiPH7QBGvqcHNtN69HguzF0wNG9eqTtlfpvopc2rpqF/jbuZQ
         X7Y19+dCVzH37ZkvBCeV2un1U/5EV97eTZHxQb74Qbn7eFV6eNBz6SVywnA9SHqbNV9h
         Zqq9NPymkVwIvwEeD2W4SxdZbPKsMQmmJdEbXskeS6iMIPpu77BUT3t/85YEq9ift1EX
         hDg/rlVYg+5+7zsZvARCDtC17G+of4GaOsQ7PyMknOv39raPi3o5b8M/PsLIKUMjgskD
         w+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782867223; x=1783472023;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TYxx5kClgfNIkaBKfBGqC0VpNEaGmmFN+tkQm/boFWE=;
        b=OdaVwuzB0So3ma3yn9yh0V6O3Agz/YkRZ14Gyn4z1SwTlnKg4tIG10S9Bc/xHUTlf/
         A+AvUiHnvlShpX/4YjsthuCxLfPiDUQB9s49JyFueXD0AOcLKOxqTSASwyxaK8iPz3St
         +KVuu+FlUeuki26abR4AScETsw0iwlqUyQVxl/WBrJ0kMU5RHChdTJ/yTBgBy5avcmYT
         NqjB2xlEvcL/lugazO7QtclOkfNeyh1I5y/rml5dOEBioZW49RjvPdytpzyUavoraeOo
         KtS90tIrnRk8sgTVnWoQy6rmOxNTB6o5Op10LFs8bYmK9R/rERGcRG7LL0VA4n2ojEov
         uzQw==
X-Forwarded-Encrypted: i=1; AHgh+RqItS0t4AWJeZRL4zwY5eqvhwzehArKcWpsSgfa71i5VlpcAEw+Gm9kai5uVAlwB+/vtSBOsCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXtJiXCGKYHqbJTqVGa+cllvZ6C1cjo8AHsM9fRw+MTiTJw5ss
	K8k8U06wkLTPIOZv08yL0wsGC2lp8VOUoBv19DWsyeyOyu4vQtJ4n8DJ083TaiJMXQ6dgj9ZgsF
	dqHAY14AMwskdfMUdCPKk+zkwAg==
X-Received: from plblk15.prod.google.com ([2002:a17:903:8cf:b0:2c7:f338:5690])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:da86:b0:2c1:f262:4962 with SMTP id d9443c01a7336-2ca5a59d7e9mr22625805ad.20.1782867222982;
 Tue, 30 Jun 2026 17:53:42 -0700 (PDT)
Date: Wed,  1 Jul 2026 00:53:41 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701005341.3699161-1-hramamurthy@google.com>
Subject: [PATCH net] gve: fix Rx queue stall on alloc failure
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bpf@vger.kernel.org, sdf@fomichev.me, 
	willemb@google.com, jordanrhee@google.com, nktgrg@google.com, 
	maolson@google.com, jacob.e.keller@intel.com, thostet@google.com, 
	csully@google.com, bcf@google.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Eddie Phillips <eddiephillips@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Eddie Phillips <eddiephillips@google.com>

When the system is under extreme memory pressure, page allocations can
fail during the Rx buffer refill loop. If the number of buffers posted
to hardware falls below a critical low threshold and the refill loop
exits due to allocation failures, the queue can stall:

1. The device drops incoming packets because there are no descriptors.
2. Since no packets are processed, no Rx completions are generated.
3. Because no completions occur, NAPI is never scheduled, preventing
   the refill loop from running again even after memory is freed.

This results in a permanent queue stall.

Resolve this by introducing a starvation recovery timer for each Rx queue.
If the number of buffers posted to hardware falls below a critical low
threshold, start a timer to periodically reschedule NAPI. Once NAPI runs
and successfully refills the queue above the threshold, the timer is
not rescheduled.

Also add a new ethtool statistic "rx_critical_low_bufs" to track the
number of times the starvation recovery timer is triggered.

Cc: stable@vger.kernel.org
Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Eddie Phillips <eddiephillips@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         |  4 ++++
 drivers/net/ethernet/google/gve/gve_ethtool.c | 14 +++++++++++++-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 2f7bd330..8378bef2 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -13,6 +13,7 @@
 #include <linux/netdevice.h>
 #include <linux/net_tstamp.h>
 #include <linux/pci.h>
+#include <linux/timer.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/u64_stats_sync.h>
 #include <net/page_pool/helpers.h>
@@ -41,6 +42,7 @@
 
 /* Interval to schedule a stats report update, 20000ms. */
 #define GVE_STATS_REPORT_TIMER_PERIOD	20000
+#define GVE_RX_NAPI_RESCHED_MS 20 /* msecs */
 
 /* Numbers of NIC tx/rx stats in stats report. */
 #define NIC_TX_STATS_REPORT_NUM	0
@@ -318,6 +320,7 @@ struct gve_rx_ring {
 	u64 rx_copied_pkt; /* free-running total number of copied packets */
 	u64 rx_skb_alloc_fail; /* free-running count of skb alloc fails */
 	u64 rx_buf_alloc_fail; /* free-running count of buffer alloc fails */
+	u64 rx_critical_low_bufs; /* count of critical low buffer events */
 	u64 rx_desc_err_dropped_pkt; /* free-running count of packets dropped by descriptor error */
 	/* free-running count of unsplit packets due to header buffer overflow or hdr_len is 0 */
 	u64 rx_hsplit_unsplit_pkt;
@@ -334,6 +337,7 @@ struct gve_rx_ring {
 	struct gve_queue_resources *q_resources; /* head and tail pointer idx */
 	dma_addr_t q_resources_bus; /* dma address for the queue resources */
 	struct u64_stats_sync statss; /* sync stats for 32bit archs */
+	struct timer_list starvation_timer; /* for queue starvation recovery */
 
 	struct gve_rx_ctx ctx; /* Info for packet currently being processed in this ring. */
 
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index a0e0472b..71b6efbf 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -46,6 +46,7 @@ static const char gve_gstrings_main_stats[][ETH_GSTRING_LEN] = {
 	"rx_hsplit_unsplit_pkt",
 	"interface_up_cnt", "interface_down_cnt", "reset_cnt",
 	"page_alloc_fail", "dma_mapping_error", "stats_report_trigger_cnt",
+	"rx_critical_low_bufs",
 };
 
 static const char gve_gstrings_rx_stats[][ETH_GSTRING_LEN] = {
@@ -58,6 +59,7 @@ static const char gve_gstrings_rx_stats[][ETH_GSTRING_LEN] = {
 	"rx_xdp_aborted[%u]", "rx_xdp_drop[%u]", "rx_xdp_pass[%u]",
 	"rx_xdp_tx[%u]", "rx_xdp_redirect[%u]",
 	"rx_xdp_tx_errors[%u]", "rx_xdp_redirect_errors[%u]", "rx_xdp_alloc_fails[%u]",
+	"rx_critical_low_bufs[%u]",
 };
 
 static const char gve_gstrings_tx_stats[][ETH_GSTRING_LEN] = {
@@ -151,12 +153,14 @@ gve_get_ethtool_stats(struct net_device *netdev,
 {
 	u64 tmp_rx_pkts, tmp_rx_hsplit_pkt, tmp_rx_bytes, tmp_rx_hsplit_bytes,
 		tmp_rx_skb_alloc_fail, tmp_rx_buf_alloc_fail,
+		tmp_rx_critical_low_bufs,
 		tmp_rx_desc_err_dropped_pkt, tmp_rx_hsplit_unsplit_pkt,
 		tmp_tx_pkts, tmp_tx_bytes,
 		tmp_xdp_tx_errors, tmp_xdp_redirect_errors;
 	u64 rx_buf_alloc_fail, rx_desc_err_dropped_pkt, rx_hsplit_unsplit_pkt,
 		rx_pkts, rx_hsplit_pkt, rx_skb_alloc_fail, rx_bytes, tx_pkts, tx_bytes,
-		tx_dropped, xdp_tx_errors, xdp_redirect_errors;
+		rx_critical_low_bufs, tx_dropped, xdp_tx_errors,
+		xdp_redirect_errors;
 	int rx_base_stats_idx, max_rx_stats_idx, max_tx_stats_idx;
 	int stats_idx, stats_region_len, nic_stats_len;
 	struct stats *report_stats;
@@ -197,6 +201,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
 
 	for (rx_pkts = 0, rx_bytes = 0, rx_hsplit_pkt = 0,
 	     rx_skb_alloc_fail = 0, rx_buf_alloc_fail = 0,
+	     rx_critical_low_bufs = 0,
 	     rx_desc_err_dropped_pkt = 0, rx_hsplit_unsplit_pkt = 0,
 	     xdp_tx_errors = 0, xdp_redirect_errors = 0,
 	     ring = 0;
@@ -212,6 +217,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
 				tmp_rx_bytes = rx->rbytes;
 				tmp_rx_skb_alloc_fail = rx->rx_skb_alloc_fail;
 				tmp_rx_buf_alloc_fail = rx->rx_buf_alloc_fail;
+				tmp_rx_critical_low_bufs =
+					rx->rx_critical_low_bufs;
 				tmp_rx_desc_err_dropped_pkt =
 					rx->rx_desc_err_dropped_pkt;
 				tmp_rx_hsplit_unsplit_pkt =
@@ -226,6 +233,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
 			rx_bytes += tmp_rx_bytes;
 			rx_skb_alloc_fail += tmp_rx_skb_alloc_fail;
 			rx_buf_alloc_fail += tmp_rx_buf_alloc_fail;
+			rx_critical_low_bufs += tmp_rx_critical_low_bufs;
 			rx_desc_err_dropped_pkt += tmp_rx_desc_err_dropped_pkt;
 			rx_hsplit_unsplit_pkt += tmp_rx_hsplit_unsplit_pkt;
 			xdp_tx_errors += tmp_xdp_tx_errors;
@@ -269,6 +277,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	data[i++] = priv->page_alloc_fail;
 	data[i++] = priv->dma_mapping_error;
 	data[i++] = priv->stats_report_trigger_cnt;
+	data[i++] = rx_critical_low_bufs;
 	i = GVE_MAIN_STATS_LEN;
 
 	rx_base_stats_idx = 0;
@@ -337,6 +346,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
 				tmp_rx_hsplit_bytes = rx->rx_hsplit_bytes;
 				tmp_rx_skb_alloc_fail = rx->rx_skb_alloc_fail;
 				tmp_rx_buf_alloc_fail = rx->rx_buf_alloc_fail;
+				tmp_rx_critical_low_bufs =
+					rx->rx_critical_low_bufs;
 				tmp_rx_desc_err_dropped_pkt =
 					rx->rx_desc_err_dropped_pkt;
 				tmp_xdp_tx_errors = rx->xdp_tx_errors;
@@ -381,6 +392,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
 			} while (u64_stats_fetch_retry(&priv->rx[ring].statss,
 						       start));
 			i += GVE_XDP_ACTIONS + 3; /* XDP rx counters */
+			data[i++] = tmp_rx_critical_low_bufs;
 		}
 	} else {
 		i += priv->rx_cfg.num_queues * NUM_GVE_RX_CNTS;
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 02cba280..303db4fa 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -18,6 +18,16 @@
 #include <net/tcp.h>
 #include <net/xdp_sock_drv.h>
 
+static void gve_rx_starvation_timer(struct timer_list *t)
+{
+	struct gve_rx_ring *rx = timer_container_of(rx, t, starvation_timer);
+	struct gve_priv *priv = rx->gve;
+	struct gve_notify_block *block;
+
+	block = &priv->ntfy_blocks[rx->ntfy_id];
+	napi_schedule(&block->napi);
+}
+
 static void gve_rx_free_hdr_bufs(struct gve_priv *priv, struct gve_rx_ring *rx)
 {
 	struct device *hdev = &priv->pdev->dev;
@@ -120,6 +130,7 @@ void gve_rx_stop_ring_dqo(struct gve_priv *priv, int idx)
 
 	if (rx->dqo.page_pool)
 		page_pool_disable_direct_recycling(rx->dqo.page_pool);
+	timer_delete_sync(&rx->starvation_timer);
 	gve_remove_napi(priv, ntfy_idx);
 	gve_rx_remove_from_block(priv, idx);
 	gve_rx_reset_ring_dqo(priv, idx);
@@ -136,6 +147,8 @@ void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
 	u32 qpl_id;
 	int i;
 
+	timer_shutdown_sync(&rx->starvation_timer);
+
 	completion_queue_slots = rx->dqo.complq.mask + 1;
 	buffer_queue_slots = rx->dqo.bufq.mask + 1;
 
@@ -232,6 +245,7 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 	rx->gve = priv;
 	rx->q_num = idx;
 	rx->packet_buffer_size = cfg->packet_buffer_size;
+	timer_setup(&rx->starvation_timer, gve_rx_starvation_timer, 0);
 
 	if (cfg->xdp) {
 		rx->packet_buffer_truesize = GVE_XDP_RX_BUFFER_SIZE_DQO;
@@ -365,6 +379,7 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
 	struct gve_rx_compl_queue_dqo *complq = &rx->dqo.complq;
 	struct gve_rx_buf_queue_dqo *bufq = &rx->dqo.bufq;
 	struct gve_priv *priv = rx->gve;
+	u32 num_bufs_avail_to_hw;
 	u32 num_avail_slots;
 	u32 num_full_slots;
 	u32 num_posted = 0;
@@ -400,6 +415,23 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
 	}
 
 	rx->fill_cnt += num_posted;
+
+	/* If the queue has fewer than GVE_RX_BUF_THRESH_DQO descriptors
+	 * visible to the hardware, and no doorbell was written, the hardware
+	 * is in danger of starving and cannot trigger interrupts. Start the
+	 * timer to periodically reschedule NAPI and recover from starvation.
+	 */
+	num_bufs_avail_to_hw =
+		((bufq->tail & ~(GVE_RX_BUF_THRESH_DQO - 1)) -
+		 bufq->head) & bufq->mask;
+
+	if (num_bufs_avail_to_hw < GVE_RX_BUF_THRESH_DQO) {
+		u64_stats_update_begin(&rx->statss);
+		rx->rx_critical_low_bufs++;
+		u64_stats_update_end(&rx->statss);
+		mod_timer(&rx->starvation_timer,
+			  jiffies + msecs_to_jiffies(GVE_RX_NAPI_RESCHED_MS));
+	}
 }
 
 static void gve_rx_skb_csum(struct sk_buff *skb,
-- 
2.55.0.rc2.803.g1fd1e6609c-goog

