Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14A1370D56
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607611; cv=none; b=eZfTOGkCATobGBKuDScVJZ86eWHB/kNwGeJHXFyqEnb0cDrGijmFRkp0UQFf9kVkBFY5RqvQ+HYcyMQCZzPxgmUvy9ggQ7JCEVKCXeupjPg/nP6UIS7ll0q82ru76JcTf+5BhvKvea1Fn1Io6M86ffcLSAS8VdHfsGMlv72BQrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607611; c=relaxed/simple;
	bh=UqyZLJcv6rmWii+r+AmUaGuYMu8qQprjiMlKLTND9Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dP45n7qZEYcIP0Pgj8x9fW9moq+aqfs2nUYo/wywYyzSWK41Uxf66eCtfYnPMH27JZVW/ptVnDZWle+8Nb0fZNpPL/6yvFqZKqqS4uwDMxf/4x3s/PfVCwE1NBGctcWriSmfrs2/YdYImTLa0vv3PtegLPIPABJDfiHJeyhHngs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d745MLQE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d745MLQE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D67C1F0089D;
	Thu, 17 Sep 2026 01:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789607605;
	bh=y3CDE/idmty7GXdOrX/P9V+fr3EOX5lyho03sq/KI8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d745MLQEaHhpXpPBKPsy16XYJ8OOWSySDl5P0MbZHRjcsbSHqixZ598N7GmzsBIeK
	 dkJZ/LyE3KLqMgol6PcJm65mC4u0evbEizhu8Eg/A8tmfjc9OvHPWcPq9Dwy4FwqnW
	 n/4LHysyXa8bxWr7EmyHS958U4ODZLOTo7uhCPFMFIXCXx8L4+kACuJrIY2UzG8L71
	 t0u0WgZCUX8m0mOKgHmmecWlUI6FoN9Gk8o1tAMu8vVpT2dx2mlfPwbaHz2kqlY/2f
	 PcKHxigpFRIkk9kb/UG621QEQ7jXcRT/jxrWb4SLOJtU53eLRO4r2590MUsSwf5gxZ
	 vJr0C1Ihw87rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] net: macb: Introduce macb_queue_isr_clear() helper function
Date: Wed, 16 Sep 2026 21:13:19 -0400
Message-ID: <20260917011322.3531179-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917011322.3531179-1-sashal@kernel.org>
References: <2026091646-swoop-cubical-81ce@gregkh>
 <20260917011322.3531179-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kevin Hao <haokexin@gmail.com>

[ Upstream commit 5986ff6e4136105f16d481bd0532b7da2c6344ae ]

The current implementation includes several occurrences of the
following pattern:
	if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
		queue_writel(queue, ISR, value);

Introduces a helper function to consolidate these repeated code
segments. No functional changes are made.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Link: https://patch.msgid.link/20260402-macb-irq-v2-2-942d98ab1154@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: e1406330d70e ("net: macb: initialize PTP state before registering clock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb.h      |  7 ++++
 drivers/net/ethernet/cadence/macb_main.c | 51 +++++++-----------------
 2 files changed, 22 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 0d3c6eb72163f..51ea68fd1a1fd 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1394,6 +1394,13 @@ static inline bool gem_has_ptp(struct macb *bp)
 	return !!(bp->caps & MACB_CAPS_GEM_HAS_PTP);
 }
 
+static inline void macb_queue_isr_clear(struct macb *bp,
+					struct macb_queue *queue, u32 value)
+{
+	if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
+		queue_writel(queue, ISR, value);
+}
+
 /**
  * struct macb_platform_data - platform data for MACB Ethernet used for PCI registration
  * @pclk:		platform clock
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 6099084143746..d6dc6df66f1a5 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1731,8 +1731,7 @@ static int macb_rx_poll(struct napi_struct *napi, int budget)
 		 */
 		if (macb_rx_pending(queue)) {
 			queue_writel(queue, IDR, bp->rx_intr_mask);
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-				queue_writel(queue, ISR, MACB_BIT(RCOMP));
+			macb_queue_isr_clear(bp, queue, MACB_BIT(RCOMP));
 			netdev_vdbg(bp->dev, "poll: packets pending, reschedule\n");
 			napi_schedule(napi);
 		}
@@ -1819,8 +1818,7 @@ static int macb_tx_poll(struct napi_struct *napi, int budget)
 		 */
 		if (macb_tx_complete_pending(queue)) {
 			queue_writel(queue, IDR, MACB_BIT(TCOMP));
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-				queue_writel(queue, ISR, MACB_BIT(TCOMP));
+			macb_queue_isr_clear(bp, queue, MACB_BIT(TCOMP));
 			netdev_vdbg(bp->dev, "TX poll: packets pending, reschedule\n");
 			napi_schedule(napi);
 		}
@@ -1887,8 +1885,7 @@ static irqreturn_t macb_wol_interrupt(int irq, void *dev_id)
 		netdev_vdbg(bp->dev, "MACB WoL: queue = %u, isr = 0x%08lx\n",
 			    (unsigned int)(queue - bp->queues),
 			    (unsigned long)status);
-		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-			queue_writel(queue, ISR, MACB_BIT(WOL));
+		macb_queue_isr_clear(bp, queue, MACB_BIT(WOL));
 		pm_wakeup_event(&bp->pdev->dev, 0);
 	}
 
@@ -1916,8 +1913,7 @@ static irqreturn_t gem_wol_interrupt(int irq, void *dev_id)
 		netdev_vdbg(bp->dev, "GEM WoL: queue = %u, isr = 0x%08lx\n",
 			    (unsigned int)(queue - bp->queues),
 			    (unsigned long)status);
-		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-			queue_writel(queue, ISR, GEM_BIT(WOL));
+		macb_queue_isr_clear(bp, queue, GEM_BIT(WOL));
 		pm_wakeup_event(&bp->pdev->dev, 0);
 	}
 
@@ -1944,8 +1940,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 		/* close possible race with dev_close */
 		if (unlikely(!netif_running(dev))) {
 			queue_writel(queue, IDR, -1);
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-				queue_writel(queue, ISR, -1);
+			macb_queue_isr_clear(bp, queue, -1);
 			break;
 		}
 
@@ -1961,19 +1956,15 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 			 * now.
 			 */
 			queue_writel(queue, IDR, bp->rx_intr_mask);
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-				queue_writel(queue, ISR, MACB_BIT(RCOMP));
-
+			macb_queue_isr_clear(bp, queue, MACB_BIT(RCOMP));
 			napi_schedule(&queue->napi_rx);
 		}
 
 		if (status & (MACB_BIT(TCOMP) |
 			      MACB_BIT(TXUBR))) {
 			queue_writel(queue, IDR, MACB_BIT(TCOMP));
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-				queue_writel(queue, ISR, MACB_BIT(TCOMP) |
-							 MACB_BIT(TXUBR));
-
+			macb_queue_isr_clear(bp, queue, MACB_BIT(TCOMP) |
+							MACB_BIT(TXUBR));
 			if (status & MACB_BIT(TXUBR)) {
 				queue->txubr_pending = true;
 				wmb(); // ensure softirq can see update
@@ -1985,10 +1976,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 		if (unlikely(status & (MACB_TX_ERR_FLAGS))) {
 			queue_writel(queue, IDR, MACB_TX_INT_FLAGS);
 			schedule_work(&queue->tx_error_task);
-
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-				queue_writel(queue, ISR, MACB_TX_ERR_FLAGS);
-
+			macb_queue_isr_clear(bp, queue, MACB_TX_ERR_FLAGS);
 			break;
 		}
 
@@ -2008,9 +1996,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 			macb_writel(bp, NCR, ctrl & ~MACB_BIT(RE));
 			wmb();
 			macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
-
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-				queue_writel(queue, ISR, MACB_BIT(RXUBR));
+			macb_queue_isr_clear(bp, queue, MACB_BIT(RXUBR));
 		}
 
 		if (status & MACB_BIT(ISR_ROVR)) {
@@ -2021,17 +2007,13 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 			else
 				bp->hw_stats.macb.rx_overruns++;
 			spin_unlock(&bp->stats_lock);
-
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-				queue_writel(queue, ISR, MACB_BIT(ISR_ROVR));
+			macb_queue_isr_clear(bp, queue, MACB_BIT(ISR_ROVR));
 		}
 
 		if (status & MACB_BIT(HRESP)) {
 			tasklet_schedule(&bp->hresp_err_tasklet);
 			netdev_err(dev, "DMA bus error: HRESP not OK\n");
-
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-				queue_writel(queue, ISR, MACB_BIT(HRESP));
+			macb_queue_isr_clear(bp, queue, MACB_BIT(HRESP));
 		}
 		status = queue_readl(queue, ISR);
 	}
@@ -2724,8 +2706,7 @@ static void macb_reset_hw(struct macb *bp)
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		queue_writel(queue, IDR, -1);
 		queue_readl(queue, ISR);
-		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-			queue_writel(queue, ISR, -1);
+		macb_queue_isr_clear(bp, queue, -1);
 	}
 }
 
@@ -5273,8 +5254,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 			/* Disable all interrupts */
 			queue_writel(queue, IDR, -1);
 			queue_readl(queue, ISR);
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-				queue_writel(queue, ISR, -1);
+			macb_queue_isr_clear(bp, queue, -1);
 		}
 		/* Enable Receive engine */
 		macb_writel(bp, NCR, tmp | MACB_BIT(RE));
@@ -5379,8 +5359,7 @@ static int __maybe_unused macb_resume(struct device *dev)
 		}
 		/* Clear ISR on queue 0 */
 		queue_readl(bp->queues, ISR);
-		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-			queue_writel(bp->queues, ISR, -1);
+		macb_queue_isr_clear(bp, bp->queues, -1);
 		spin_unlock_irqrestore(&bp->lock, flags);
 
 		/* Replace interrupt handler on queue 0 */
-- 
2.53.0

