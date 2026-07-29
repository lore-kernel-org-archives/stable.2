Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC343E173B
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 21:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785360088; cv=none; b=RxKbXu3yhxXImUZY9caMFfwBfpV7vCH4dcrN2c0EcweaeHbcpsKPM5gJ0N8RzwE1Lv/Lwc5kEVqPbNsN6oXJLsiDVgfaIg7tCdmV2Lt00s5cHS1oiPonpcaRjU3GV7QBK2IkBRaIL5jDQeHPVnfRZJmX7yW+I9UEqgdyb+r8pRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785360088; c=relaxed/simple;
	bh=qz1sAdam29lFnVFfK8gUMW8LZh/jQH+xpnF85IvhW0Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tn+othtPoScQxPgzp1LLWezKYm2q4u30aHW7KfIU8r8Jr4n5Z7R/QVFUa8TJXEdexs+IaDVMRB2TRMEvUoGDzeC6gQqjvCg8qdfMp9wBNHuCwUd+UzPEBfKSGca6mVUDYCmkPcHu0+OMLqGyFRCc/l7R0kTlXZJjADKyGYX0CJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--eddiephillips.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bB9xhusj; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--eddiephillips.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bB9xhusj"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ccd1958e8fso19925545ad.2
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 14:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785360086; x=1785964886; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W7BSAGy20fuvV5DOsfw1998xYbvpMl8+2m0BY0fUgAU=;
        b=bB9xhusj3LpeYEyuTBdPmISbFxIajsxcB/FFqf7qYvW99IkBJyxNijF3IqjDCFRCy9
         VHLIg1hMrhFcR7/GpPzuBUqJDdPLTADpIWyiXrFY2SsRvvQe2Ssr+p1AyAUrQLR++gTC
         Pc/nvW45oana9a/KiZXwGk2RjZxh6Xiu5KrVFAg4o+InK0XTOFW3Gd4yp3FFnBothBH+
         9mP+tbWJatn2CQtyLiqV6g23LW+1o2UfqHwCB7o5VSrj0GVomWSkMIDK9sr5jf4OQB9u
         KMmIWIlTizUkI0xu/YE9XD8luxVRQzQ8Fq0j0h5ykABc6pEeVTDKb/wUZAzMxCcl+0qE
         rL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785360086; x=1785964886;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W7BSAGy20fuvV5DOsfw1998xYbvpMl8+2m0BY0fUgAU=;
        b=VuOZ4huoCVGTm6qlmkFpkKel7ohT9Oy8hm5fMDFpAZX2lQ5+noMzMVi4zf+CpFmMaq
         SSQ6vG2gpTLJkPObsI+eZaqoU0ev/qoeY+XGrQcSNvE7oH6FS1ZLaB3b/XJt8pIN8Amh
         1f5eKIhOtbWLcSyQYah4u9yIU0G3s6H8Kb2N09CQN8IrldXSv0AudL4WNaVGPsU8y8ei
         azLFyuLvcCTaYGeiTvm+LvA0iL2HMukRJ57hqXj32Gc7EUakaGs7nOICCxzn18qIgbyG
         7AC4fDiiQiwV458pab+4Nlr4zt5kIoRZ9HmSn53yb0UXByrzCZr1e2baNqFDtG+R9zQJ
         247w==
X-Gm-Message-State: AOJu0YzcVLLSuA2AIv1LvqnXE+x6ZXk7xfP6fIwEFSUguqdNunqalSNj
	sT6JupPcft2nGDC1Fut7vLKuektWohvdx5p+9bdbHWqlk4zDtzpzWaX7j0YU720Og2KacWHqWdO
	Nm6hhNIRjUy3HsE3vqpMieiRt9PVh6uYIvBKIi730SStyqrt+FtUmsKnjM1iwyAbTArh2y6nlfY
	MARdaXrOb1LDczV55eUlPZhCslNgIgpDV1eGDXIQsnkR5u7O9HmTQvD/ygCFTLSwKthvnUl8NfX
	w==
X-Received: from plww3.prod.google.com ([2002:a17:902:d103:b0:2ca:cf09:91ca])
 (user=eddiephillips job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ea04:b0:2cc:f4d4:29a7 with SMTP id d9443c01a7336-2d034131564mr4716235ad.24.1785360086011;
 Wed, 29 Jul 2026 14:21:26 -0700 (PDT)
Date: Wed, 29 Jul 2026 14:21:22 -0700
In-Reply-To: <2026072933-juror-spoof-89d1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026072933-juror-spoof-89d1@gregkh>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260729212123.1421456-1-eddiephillips@google.com>
Subject: [PATCH 6.12.y] gve: fix Rx queue stall on alloc failure
From: Eddie Phillips <eddiephillips@google.com>
To: stable@vger.kernel.org
Cc: Eddie Phillips <eddiephillips@google.com>, Jordan Rhee <jordanrhee@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"

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
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Link: https://patch.msgid.link/20260709211906.3322883-1-hramamurthy@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit b65352a1bac64442ad95e64f385b40ccb9f1b0db)
---
 drivers/net/ethernet/google/gve/gve.h        |  3 ++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 36 ++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 8ddd366d9fde..e19d722e8e9a 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -12,6 +12,7 @@
 #include <linux/ethtool_netlink.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
+#include <linux/timer.h>
 #include <linux/u64_stats_sync.h>
 #include <net/xdp.h>
 
@@ -38,6 +39,7 @@
 
 /* Interval to schedule a stats report update, 20000ms. */
 #define GVE_STATS_REPORT_TIMER_PERIOD	20000
+#define GVE_RX_NAPI_RESCHED_MS 20 /* msecs */
 
 /* Numbers of NIC tx/rx stats in stats report. */
 #define NIC_TX_STATS_REPORT_NUM	0
@@ -311,6 +313,7 @@ struct gve_rx_ring {
 	struct xdp_rxq_info xsk_rxq;
 	struct xsk_buff_pool *xsk_pool;
 	struct page_frag_cache page_cache; /* Page cache to allocate XDP frames */
+	struct timer_list starvation_timer; /* for queue starvation recovery */
 };
 
 /* A TX desc ring entry */
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 1154c1d8f66f..2f7f31e4797c 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -199,6 +199,16 @@ static int gve_alloc_page_dqo(struct gve_rx_ring *rx,
 	return 0;
 }
 
+static void gve_rx_starvation_timer(struct timer_list *t)
+{
+	struct gve_rx_ring *rx = from_timer(rx, t, starvation_timer);
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
@@ -290,10 +300,13 @@ static void gve_rx_reset_ring_dqo(struct gve_priv *priv, int idx)
 void gve_rx_stop_ring_dqo(struct gve_priv *priv, int idx)
 {
 	int ntfy_idx = gve_rx_idx_to_ntfy(priv, idx);
+	struct gve_rx_ring *rx = &priv->rx[idx];
 
 	if (!gve_rx_was_added_to_block(priv, idx))
 		return;
 
+	timer_shutdown_sync(&rx->starvation_timer);
+
 	gve_remove_napi(priv, ntfy_idx);
 	gve_rx_remove_from_block(priv, idx);
 	gve_rx_reset_ring_dqo(priv, idx);
@@ -371,8 +384,10 @@ static int gve_rx_alloc_hdr_bufs(struct gve_priv *priv, struct gve_rx_ring *rx,
 void gve_rx_start_ring_dqo(struct gve_priv *priv, int idx)
 {
 	int ntfy_idx = gve_rx_idx_to_ntfy(priv, idx);
+	struct gve_rx_ring *rx = &priv->rx[idx];
 
 	gve_rx_add_to_block(priv, idx);
+	timer_setup(&rx->starvation_timer, gve_rx_starvation_timer, 0);
 	gve_add_napi(priv, ntfy_idx, gve_napi_poll_dqo);
 }
 
@@ -511,6 +526,7 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
 	struct gve_rx_compl_queue_dqo *complq = &rx->dqo.complq;
 	struct gve_rx_buf_queue_dqo *bufq = &rx->dqo.bufq;
 	struct gve_priv *priv = rx->gve;
+	u32 num_bufs_avail_to_hw;
 	u32 num_avail_slots;
 	u32 num_full_slots;
 	u32 num_posted = 0;
@@ -555,6 +571,26 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
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
 
 static void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_ring *rx,
-- 
2.55.0.508.g3f0d502094-goog

