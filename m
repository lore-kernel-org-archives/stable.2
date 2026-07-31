Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BD43E49DF
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785520401; cv=none; b=ePUt1qg43WD6YTeu1MsnySxgOKAaMpTh+GMSgRBkNtUprqMBMY0oGhdOaM1x1IXQGa5h51CPvQfJWL6KeHibwjidh0HEbPvnVWw2qQ2RPRYzKMI5pGx92d9GcMjlosBJxjkRyv1K5rbQ0CCV0kx4MRB6A9H9m2QqXR4NrccAwXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785520401; c=relaxed/simple;
	bh=OylEw/4IArY2a2cXRsuFlX95bJNhHqo8HYkud3pDEP4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aPaRjsuLDr0rZw/Xhzc4Y47TJ5Ac09+lEJOlE2Y5maMp58fZicr8bkWkU5AoJjxRGofkKRSd9tmzHzIXOkFtZNvzYT32DyDJYK6pqRxyWXAxBvaafxYr55YXt38PE8+MwqxOp54ogkdD65kPY+vZbWpOvVcv9s/AhpQqZdc3iHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--eddiephillips.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vbko+wtd; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--eddiephillips.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vbko+wtd"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f57e31b6eso1251373a91.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 10:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785520399; x=1786125199; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8a+WyDaPrF35faJf4BoZQTKcw4eEVS7LTRZe0rtD/hA=;
        b=Vbko+wtdzQuoDsYtNViB2h9ngE04mTtBsdjJ+At1iVEIH6RD0KJLRGLxx39OPR9a4R
         TNcNVFwPccQ94lv+auyKlCD0iDHOFE4okDUyw+yczanvOvUVUBhjOyKmiXKyEbzHUB1/
         YlPRNIS39nxfwKSEZKdtZ11Oz+s73hyfpG+h9NY+9pzH2uNi/FZftdtk438U2Ov3Re3q
         r0A7bxXMmBx1cYnLPW/aJlXz+hJsNLNs/ScyEcdqto4ffvlAlnRm0qTKavhSKp51Nvl6
         GfL0zbu/HHrXCdzU99r7Vg1ZkwTU5HQMZsLOh1dw3NYY3rJWUEggO5PXRedDFDA7hdiv
         bySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785520399; x=1786125199;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8a+WyDaPrF35faJf4BoZQTKcw4eEVS7LTRZe0rtD/hA=;
        b=L2r6gkxL2wcMzgvyP7eH0OTIs5XVYPP+yoBJSBJrWZ11wp5gUMi9t3NFMXt1wojgMx
         vZUpE2UlgaoJJy9vfQCgYXkggOtQQeBDtayTZ2dLoe2581eWdNvFqWMgpbuJ9cC8mGOb
         xxY6ECeUvmEH72dYAtPUXaM3KoAo3HwZ4DdKau47ZkjGtnDKL9e9xGSKqacQQX3tySE5
         xZZRLCrp5NGZd8ew22YodoU1k8+vVpwHogYJ7mt/hOsRGHMsh47SD4wrLgMQN+M099qW
         AvALROUf2LQR8gG/H4DjEiG57qdVr579ZN2oxHYGsAs7rBJ3FGtwZZjrXDHNcL7CxcAX
         zWzQ==
X-Gm-Message-State: AOJu0YyGVebSqW/NjUDtHS+OPtbp0Wf+lPeuiF311xtibQj14/qQMzhN
	WiVLgyaXY/tYHFyYLjUD2+i7Cqorup+KkQrG+gqsuz3TnWx7c4Qr2sdKRAGg5oKuuFbhGQFGkLR
	1rrmhdC3WHLtlkov+Ba3Bil0fQLIzZdVoxTBkMv+xSs7B4bstneegmY2o9dd+A6p6t6DAUyHOyY
	jQeiZMQP9li8cn1Y3IkDp7uQgy5jyIpmJoGajDjsMziQ6yf7VMQQ3XUfVcCcEVa37wRoh+4r9tf
	g==
X-Received: from pjbsx15.prod.google.com ([2002:a17:90b:2ccf:b0:38e:befb:90c6])
 (user=eddiephillips job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:55c8:b0:38e:11ba:992c with SMTP id 98e67ed59e1d1-38fbc44261fmr603801a91.12.1785520399146;
 Fri, 31 Jul 2026 10:53:19 -0700 (PDT)
Date: Fri, 31 Jul 2026 10:52:09 -0700
In-Reply-To: <2026072934-rule-library-9954@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026072934-rule-library-9954@gregkh>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260731175209.2862108-1-eddiephillips@google.com>
Subject: [PATCH v2 6.1.y] gve: fix Rx queue stall on alloc failure
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
Changes in v2:
- v1 Link: https://lore.kernel.org/stable/20260731154449.2755799-1-eddiephillips@google.com/
- Included backports in gve_main.c and gve_rx_dqo.c. v1 only included
gve.h by mistake. Sorry for the noise.
---
 drivers/net/ethernet/google/gve/gve.h        |  3 ++
 drivers/net/ethernet/google/gve/gve_main.c   |  3 ++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 33 ++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index c5e1312b9283..7de492b0d361 100644
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
@@ -226,6 +228,7 @@ struct gve_rx_ring {
 	struct u64_stats_sync statss; /* sync stats for 32bit archs */
 
 	struct gve_rx_ctx ctx; /* Info for packet currently being processed in this ring. */
+	struct timer_list starvation_timer; /* for queue starvation recovery */
 };
 
 /* A TX desc ring entry */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 209e9526a6fd..fc2a516a3bee 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -529,6 +529,9 @@ static void gve_remove_napi(struct gve_priv *priv, int ntfy_idx)
 {
 	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
+	if (block->rx && !gve_is_gqi(priv))
+		timer_shutdown_sync(&block->rx->starvation_timer);
+
 	netif_napi_del(&block->napi);
 	disable_irq(block->irq);
 }
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 0a36b284de10..adae0f5181ea 100644
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
@@ -337,6 +349,7 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
 	u32 num_avail_slots;
 	u32 num_full_slots;
 	u32 num_posted = 0;
+	u32 num_bufs_avail_to_hw;
 
 	num_full_slots = (bufq->tail - bufq->head) & bufq->mask;
 	num_avail_slots = bufq->mask - num_full_slots;
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

