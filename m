Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622873B19AC
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783631950; cv=none; b=jMfQi7UA8Gmzy+4ipkB559YkTXAPQTc8sNa4J7Gkds+S7jPtZlzvakV4DeuhboIzP6R13axgoYOCkowiqiZga17Ok8CtMhXM4nu5fko6pK6SpafQ28pOxintRHW847btaa+qa0UmYLc/hXWUjU2B6yhjiSDLB5etxA5T7lmhzyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783631950; c=relaxed/simple;
	bh=0g/6zbiEcbIQq0OxAyV2Q08ui9MvxNfKFpl/ZYmlVHA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Hjp3KAzz6obsRBU2IUqKnnousa2tVAZ11r8Vn1EnO/WnC5picpAGILYajyBqFO0zmFR/ZuXMeCy7qQV8Tqpqfffb1Tj3dXjejaChVi67IlsV2vWDDbHDwX++4TzYjg9BNWfsQfPPfASY3wbWAPLL1G8tbH0keLMqVzThes/6RxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ODdPRmOo; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ODdPRmOo"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c88aab7c1d4so210000a12.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 14:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783631949; x=1784236749; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+T7RxQXDP6VavQCmW76B4jR7UdEawZb+uP1OIxEgxgI=;
        b=ODdPRmOoRHCUiHwdDtWxbYWnZUMqWLK5coW6GCfL0yIdF67yqIvMC7G9tSzqLUTGdn
         eW57+JoOBnMcj13mM0D1AaZL/Z4wskrVCvv2XMy38tpsoS7ryyG0Qi03h0PBHxCDqYYL
         16cWwY8cQSza0sYmNNDQou39Xr56dlKUaN+yW2MjyZ4R2umlrW67ltkFzv8ONQJQkmKQ
         RuYfv0mDFxbIsx8KQnzRaef0e1KcrlqRG7Qf4ohdIES33jJFc9ssREA0MZ54hYATdBhl
         ZOzm1fBvVdLU/JiGrRO0X3LQr7ohgaZW//UwZnTBAl2YbU/FkJ+qFtxPc6E7KMKClzgX
         1UPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783631949; x=1784236749;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+T7RxQXDP6VavQCmW76B4jR7UdEawZb+uP1OIxEgxgI=;
        b=ELM/mbaS+bIF4qnQ9iH32qL2cr/IkUiRQIw4CKQxDnZn/N2EeOL8WYB+Fr7YX/wxzx
         L86B6GqLIxFUJtnS5Vd0+FUPSkc1+rI8RWZqYEuyYXJgbXBVlO/zXznt5/sBsgVktoTc
         KMOGT/9AcAI4xLgJNJJLxxomyFebWzADhcLK2MAK06f5E7oquX9jz5sJn3gH2VT7Zuzj
         0PWwB0GsfZ9AdhIObZA2BrQS2QJheA5aSl4RYCVSXOKbclaNne7iagzxwbW3ehRfyLhY
         AyosdHLz/XBgISfA0bQxBu3GcvCsSprO+mR2ezaE1oXsdrUnIxmW/z34fjCyadqMnoT3
         aixA==
X-Forwarded-Encrypted: i=1; AHgh+RqwgeCg7c4aHHjbEh7JuxcJLDGKGV0VwI1jiPZ0OUPdBCEOQ1nDvEbLy/FK8xk80t58F2ksUGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx25wpeIA/2OPFIqW6r2kT0P7y+Ywkn0lcGTQEflN+5H+RpujOa
	bpdqmoyv/zPAbKsR0k8cxsbgs5K6rXjQR335Ze4CMwHidcW87LEAoM2QUw5mPGyK/dvgU17yNRS
	Al0krFClS6zm0Qs6+2J4EQqwm3w==
X-Received: from pgmj15.prod.google.com ([2002:a63:594f:0:b0:c96:9e6a:6261])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:918c:b0:3bf:63af:859 with SMTP id adf61e73a8af0-3c0bd0f8fd3mr10854302637.45.1783631948380;
 Thu, 09 Jul 2026 14:19:08 -0700 (PDT)
Date: Thu,  9 Jul 2026 21:19:06 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709211906.3322883-1-hramamurthy@google.com>
Subject: [PATCH net v2] gve: fix Rx queue stall on alloc failure
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, jordanrhee@google.com, nktgrg@google.com, 
	maolson@google.com, thostet@google.com, csully@google.com, bcf@google.com, 
	maciej.fijalkowski@intel.com, linux-kernel@vger.kernel.org, 
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

The threshold is set to 32 because a single maximum-sized Receive Segment
Coalescing (RSC) packet can consume up to 19 descriptors in the Rx path.
Lower thresholds (such as 8 or 16) would be insufficient to process a
complete maximum-sized RSC packet, risking packet drops or unexpected
hardware behavior under memory pressure. Setting the threshold to 32
guarantees a safe margin to handle at least one full RSC packet.

Cc: stable@vger.kernel.org
Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Eddie Phillips <eddiephillips@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
Changes in v2:
- Link to v1: https://lore.kernel.org/netdev/20260701005341.3699161-1-hramamurthy@google.com/
- Relocated the starvation timer to the end of gve_rx_ring to avoid polluting
hotpath cachelines
- Decoupled timer lifecycle from allocation cycles by moving initialization
and shutdown to start/stop pathways instead of setup/remove pathways.
- Added explicit rationale for the 32-descriptor threshold
(GVE_RX_BUF_THRESH_DQO) ensuring it is safe for maximum-sized RSC packets.
- Removed addition of a stat tracking critical low buffer events

 drivers/net/ethernet/google/gve/gve.h        |  3 +++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 2f7bd330..bdd53d08 100644
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
@@ -341,6 +343,7 @@ struct gve_rx_ring {
 	struct xdp_rxq_info xdp_rxq;
 	struct xsk_buff_pool *xsk_pool;
 	struct page_frag_cache page_cache; /* Page cache to allocate XDP frames */
+	struct timer_list starvation_timer; /* for queue starvation recovery */
 };
 
 /* A TX desc ring entry */
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 02cba280..8271f731 100644
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
+	timer_shutdown_sync(&rx->starvation_timer);
 	gve_remove_napi(priv, ntfy_idx);
 	gve_rx_remove_from_block(priv, idx);
 	gve_rx_reset_ring_dqo(priv, idx);
@@ -208,8 +219,10 @@ static int gve_rx_alloc_hdr_bufs(struct gve_priv *priv, struct gve_rx_ring *rx,
 void gve_rx_start_ring_dqo(struct gve_priv *priv, int idx)
 {
 	int ntfy_idx = gve_rx_idx_to_ntfy(priv, idx);
+	struct gve_rx_ring *rx = &priv->rx[idx];
 
 	gve_rx_add_to_block(priv, idx);
+	timer_setup(&rx->starvation_timer, gve_rx_starvation_timer, 0);
 	gve_add_napi(priv, ntfy_idx, gve_napi_poll_dqo);
 }
 
@@ -365,6 +378,7 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
 	struct gve_rx_compl_queue_dqo *complq = &rx->dqo.complq;
 	struct gve_rx_buf_queue_dqo *bufq = &rx->dqo.bufq;
 	struct gve_priv *priv = rx->gve;
+	u32 num_bufs_avail_to_hw;
 	u32 num_avail_slots;
 	u32 num_full_slots;
 	u32 num_posted = 0;
@@ -400,6 +414,26 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
 	}
 
 	rx->fill_cnt += num_posted;
+
+	/* If the queue has fewer than GVE_RX_BUF_THRESH_DQO descriptors
+	 * visible to the hardware, the hardware is in danger of starving
+	 * and cannot trigger interrupts.
+	 *
+	 * We use a threshold of 32 because a single maximum-sized RSC
+	 * packet can consume up to 19 descriptors in the Rx path. Lower
+	 * thresholds (e.g., 8 or 16) would be unsafe as they could cause
+	 * the device to drop/stall on a maximum-sized RSC packet.
+	 *
+	 * Start the timer to periodically reschedule NAPI and recover.
+	 */
+	num_bufs_avail_to_hw =
+		((bufq->tail & ~(GVE_RX_BUF_THRESH_DQO - 1)) -
+		 bufq->head) & bufq->mask;
+
+	if (num_bufs_avail_to_hw < GVE_RX_BUF_THRESH_DQO) {
+		mod_timer(&rx->starvation_timer,
+			  jiffies + msecs_to_jiffies(GVE_RX_NAPI_RESCHED_MS));
+	}
 }
 
 static void gve_rx_skb_csum(struct sk_buff *skb,
-- 
2.55.0.795.g602f6c329a-goog

