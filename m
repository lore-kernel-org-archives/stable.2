Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69B51D5CFE
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 05:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785475389; cv=none; b=bNFnyI7pCTsyPkncOPzV228F/lYjw0WfFUvcSCjo78k79PEWFSnoX3WDIW5uKX/XiUCdLSzXjP9ImgbPIiLs2O9e2OzofE2v7hbxJkdd+Sm+RKCApcAM135rQxg+TzYwFNmzww5vWLCJGoSe12p5uQ3fGfm0dC6FCHGJTRZOlvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785475389; c=relaxed/simple;
	bh=KKZ5edLQNuhIM7GWjIFXW62KiSrWFJM95fO7XlC0Rdo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QH8yut00t1xUUHPu47roOL6Lx2a6y3563FQgzkXJmOC+O4adtRji4allFTHx7grq298nfs0kMI6fpNMMnzsC9kXmXoiJhoBU/n+QNWnwKBBezD8ejqvySlnhgIGJSxc34ZeX+5CLyoPXdbOyIWsT4qik17X5b3ecseLrF+Us5zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--eddiephillips.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HrkyavxY; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--eddiephillips.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HrkyavxY"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so1130628a91.2
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 22:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785475387; x=1786080187; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zqvJ/gSeUFCAlwhir5qqH4beYaVJjkEk9WrvogcOy/8=;
        b=HrkyavxYv0LbT5n/NbwYagTLpEJb0mRExJ3qCEsEqz64RXGNLoGC3m5+Db/P5Tv3Wl
         yKr3xIj2PAA2ClNUH2h7LUEGGVQYb5hz8hDSNJo2Nw9g/GR+yNbb7N2lOwNVunovYpOt
         g/PGmd9hXwi0Bwc0Q7LmDz+gz9tjNpHe7uCtyiIBFTEO144xDKEFBQ7ZVURAlbcRQHT2
         qMiveqe809g3x/ZPoRgtUx3s40CgPa+oPO6iy4Iia/Tv4X6EIH0Zw6zxzH8pfGXMljTO
         9zq4Qm/dcNB6AM7Ux2F/HpcNbjT1Kl5QJZW7REPqb2gYH0O8/zO5szQEdEH2fDI+kMSS
         QsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785475387; x=1786080187;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zqvJ/gSeUFCAlwhir5qqH4beYaVJjkEk9WrvogcOy/8=;
        b=ggkTddfUdFhECtrezjgGuE/lBxuM+cugVA/hC1rrvkMpdP7kXixrfTsjmcI9jmh0ep
         kclsn0EOFPei7mXCHxLaonY8IA+8A4y1gUEt+Tc+ktCtxhBAONg5A7N+FKOU6qaqiYR5
         3ET/I75uYT0IkrkT43gMm3QpHv45W8XDCA1rkxCK4qICAshjK/ycDeaLDgZCZ9ifp0Hi
         +EEzErOagzpOJssOXkgpSEhEJrVwfcyOYtY+BuZcHTWSBclDyRHSv23KjirEdAj9a71u
         bQEsR3B6imfMDu2s5RkJ49dZjUM/0jSS859X1DYt9RDvex4n4ze9w3Jc61Es3/MNMFaF
         TtsA==
X-Gm-Message-State: AOJu0Yz3q/gpg0RWIFY0hSRNfb0yCBRYJUepyaF3+zWsxN+C6dMNz+Si
	gcDqX+JmeQFMBCR83BZoeWvGwmUb4igmJvGXgm8FY97reH7JHSH70hRm8Gf7WcrCC/XYwp8TIrR
	BawWZIyg+bgtdDjvwpXakJcnFy6RKNF3bRvbuSzN8Md1OE3/sH3KhEc5mR9O0IeYGx7ssPzRNmo
	msM6701S9U9tzEzHkbd7LdAKAVlHWN/VVSv8f2yUgGX4YwIq+zDEq++6yKatihVBhravav7ky6q
	Q==
X-Received: from pjb16.prod.google.com ([2002:a17:90b:2f10:b0:384:f6e1:ff87])
 (user=eddiephillips job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:582c:b0:38e:fea2:df53 with SMTP id 98e67ed59e1d1-38fb11177a1mr739498a91.4.1785475386704;
 Thu, 30 Jul 2026 22:23:06 -0700 (PDT)
Date: Thu, 30 Jul 2026 22:21:36 -0700
In-Reply-To: <2026072934-distort-skimpily-0491@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026072934-distort-skimpily-0491@gregkh>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260731052136.2424945-1-eddiephillips@google.com>
Subject: [PATCH] gve: fix Rx queue stall on alloc failure
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
 drivers/net/ethernet/google/gve/gve_main.c   |  3 ++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 33 ++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 822bdaff66f6..75773524ba81 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -10,6 +10,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
+#include <linux/timer.h>
 #include <linux/u64_stats_sync.h>
 
 #include "gve_desc.h"
@@ -35,6 +36,7 @@
 
 /* Interval to schedule a stats report update, 20000ms. */
 #define GVE_STATS_REPORT_TIMER_PERIOD	20000
+#define GVE_RX_NAPI_RESCHED_MS 20 /* msecs */
 
 /* Numbers of NIC tx/rx stats in stats report. */
 #define NIC_TX_STATS_REPORT_NUM	0
@@ -218,6 +220,7 @@ struct gve_rx_ring {
 	struct u64_stats_sync statss; /* sync stats for 32bit archs */
 
 	struct gve_rx_ctx ctx; /* Info for packet currently being processed in this ring. */
+	struct timer_list starvation_timer; /* for queue starvation recovery */
 };
 
 /* A TX desc ring entry */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index a8fb51e77fea..38333731f5d0 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -508,6 +508,9 @@ static void gve_remove_napi(struct gve_priv *priv, int ntfy_idx)
 {
 	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
+	if (block->rx && !gve_is_gqi(priv))
+		timer_shutdown_sync(&block->rx->starvation_timer);
+
 	netif_napi_del(&block->napi);
 }
 
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 8756f9cbd631..c9bc85293c27 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -16,6 +16,16 @@
 #include <net/ipv6.h>
 #include <net/tcp.h>
 
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
 static int gve_buf_ref_cnt(struct gve_rx_buf_state_dqo *bs)
 {
 	return page_count(bs->page_info.page) - bs->page_info.pagecnt_bias;
@@ -185,6 +195,7 @@ static void gve_rx_free_ring_dqo(struct gve_priv *priv, int idx)
 	completion_queue_slots = rx->dqo.complq.mask + 1;
 	buffer_queue_slots = rx->dqo.bufq.mask + 1;
 
+	timer_shutdown_sync(&rx->starvation_timer);
 	gve_rx_remove_from_block(priv, idx);
 
 	if (rx->q_resources) {
@@ -237,6 +248,7 @@ static int gve_rx_alloc_ring_dqo(struct gve_priv *priv, int idx)
 	memset(rx, 0, sizeof(*rx));
 	rx->gve = priv;
 	rx->q_num = idx;
+	timer_setup(&rx->starvation_timer, gve_rx_starvation_timer, 0);
 	rx->dqo.bufq.mask = buffer_queue_slots - 1;
 	rx->dqo.complq.num_free_slots = completion_queue_slots;
 	rx->dqo.complq.mask = completion_queue_slots - 1;
@@ -334,6 +346,7 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
 	struct gve_rx_compl_queue_dqo *complq = &rx->dqo.complq;
 	struct gve_rx_buf_queue_dqo *bufq = &rx->dqo.bufq;
 	struct gve_priv *priv = rx->gve;
+	u32 num_bufs_avail_to_hw;
 	u32 num_avail_slots;
 	u32 num_full_slots;
 	u32 num_posted = 0;
@@ -374,6 +387,26 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
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
2.55.0.571.g244d577d93-goog

