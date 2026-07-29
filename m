Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E711384250
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344276; cv=none; b=N7t8301b7stYOeRW7AGQJ8uH4iAL93GCXNsEhdVd8+Pz1jOVx9IG6XtZX2mxC0PVPRPvNCzx7TkEAUrzIfzOFy/5ld46b2TuMvLDZfovotTJ2MA4QyQRSvC8OR1UM+G6VMLr+2M3QbyXyX6ZIYckQVoiunV9tRrq/u+39TUJoHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344276; c=relaxed/simple;
	bh=BHt+QVy8lZcaY4g9biQkTqgWFDeeMwpeIYCzafdx03Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzWz+UGOqlSc5U/ahhhFY6yYntV6Hr8F72nbPff19b+TwGENx5RKSrhHD3trKQHhLV2YVKbbfeBrQu2N7R1SYZ6YkXyr2g0gjuuobCXBiYaAw97c5nLfPH/QUkbVZOqj+EX+Li1yKeLXrB2TpM1mNTW1+PxFPRo/oBfXFqVDnmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcxAjZ8g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcxAjZ8g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FB31F00A3F;
	Wed, 29 Jul 2026 16:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785344273;
	bh=wdvfNPnkS1lm8IJMIK+P3nAHYIP0EGntdOQOP0TvgJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RcxAjZ8gq6WydhfCJv8eoUfnxFfK1x5IokRv13bYv07yYF1FUw6Q7PnFWBS2hmEUD
	 bqqwHjaelGmSZJTbXekmXcbbsLMefD13HMXjueM0Wq51R2MwVQmVIvO0/ZDvjG6ylM
	 rRNQPUAocDhy5bt9nESCZBY32AGvWfUuK99umzSbYmiCzTvJKpQ6xg9XRVClhNcQuq
	 uwQdI0TMlZahk8MnEWLdo01r7mDZn95bp3v/2Kwrz8GA8aKhHdZXVWO1jYGk/+/6zr
	 sZYqtPy+SVAWbhRiYD0vObwVkxN/O9lSxBy0irPnN05CnYiVuNP7y+CYWUx4CopbYs
	 FgFjRjm3WfCBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/6] net: macb: remove illusion about TBQPH/RBQPH being per-queue
Date: Wed, 29 Jul 2026 12:57:46 -0400
Message-ID: <20260729165749.3661232-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729165749.3661232-1-sashal@kernel.org>
References: <2026072142-acorn-watch-76da@gregkh>
 <20260729165749.3661232-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Théo Lebrun <theo.lebrun@bootlin.com>

[ Upstream commit fca3dc859b200ca4dcdd2124beaf3bb2ab80b0f7 ]

The MACB driver acts as if TBQPH/RBQPH are configurable on a per queue
basis; this is a lie. A single register configures the upper 32 bits of
each DMA descriptor buffers for all queues.

Concrete actions:

 - Drop GEM_TBQPH/GEM_RBQPH macros which have a queue index argument.
   Only use MACB_TBQPH/MACB_RBQPH constants.

 - Drop struct macb_queue->TBQPH/RBQPH fields.

 - In macb_init_buffers(): do a single write to TBQPH and RBQPH for all
   queues instead of a write per queue.

 - In macb_tx_error_task(): drop the write to TBQPH.

 - In macb_alloc_consistent(): if allocations give different upper
   32-bits, fail. Previously, it would have lead to silent memory
   corruption as queues would have used the upper 32 bits of the alloc
   from queue 0 and their own low 32 bits.

 - In macb_suspend(): if we use the tie off descriptor for suspend, do
   the write once for all queues instead of once per queue.

Fixes: fff8019a08b6 ("net: macb: Add 64 bit addressing support for GEM")
Fixes: ae1f2a56d273 ("net: macb: Added support for many RX queues")
Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250923-macb-fixes-v6-2-772d655cdeb6@bootlin.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 27f575836cfe ("net: macb: drop in-flight Tx SKBs on close")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb.h      |  4 --
 drivers/net/ethernet/cadence/macb_main.c | 48 ++++++++++--------------
 2 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 7ce391209cdd14..538af24d9f9363 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -193,10 +193,8 @@
 
 #define GEM_ISR(hw_q)		(0x0400 + ((hw_q) << 2))
 #define GEM_TBQP(hw_q)		(0x0440 + ((hw_q) << 2))
-#define GEM_TBQPH(hw_q)		(0x04C8)
 #define GEM_RBQP(hw_q)		(0x0480 + ((hw_q) << 2))
 #define GEM_RBQS(hw_q)		(0x04A0 + ((hw_q) << 2))
-#define GEM_RBQPH(hw_q)		(0x04D4)
 #define GEM_IER(hw_q)		(0x0600 + ((hw_q) << 2))
 #define GEM_IDR(hw_q)		(0x0620 + ((hw_q) << 2))
 #define GEM_IMR(hw_q)		(0x0640 + ((hw_q) << 2))
@@ -1128,10 +1126,8 @@ struct macb_queue {
 	unsigned int		IDR;
 	unsigned int		IMR;
 	unsigned int		TBQP;
-	unsigned int		TBQPH;
 	unsigned int		RBQS;
 	unsigned int		RBQP;
-	unsigned int		RBQPH;
 
 	unsigned int		tx_head, tx_tail;
 	struct macb_dma_desc	*tx_ring;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b116d6778f8f90..25a7e63f20e144 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -439,19 +439,19 @@ static void macb_init_buffers(struct macb *bp)
 	struct macb_queue *queue;
 	unsigned int q;
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		queue_writel(queue, RBQP, lower_32_bits(queue->rx_ring_dma));
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
-			queue_writel(queue, RBQPH,
-				     upper_32_bits(queue->rx_ring_dma));
+	/* Single register for all queues' high 32 bits. */
+	if (bp->hw_dma_cap & HW_DMA_CAP_64B) {
+		macb_writel(bp, RBQPH,
+			    upper_32_bits(bp->queues[0].rx_ring_dma));
+		macb_writel(bp, TBQPH,
+			    upper_32_bits(bp->queues[0].tx_ring_dma));
+	}
 #endif
+
+	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		queue_writel(queue, RBQP, lower_32_bits(queue->rx_ring_dma));
 		queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
-			queue_writel(queue, TBQPH,
-				     upper_32_bits(queue->tx_ring_dma));
-#endif
 	}
 }
 
@@ -983,10 +983,6 @@ static void macb_tx_error_task(struct work_struct *work)
 
 	/* Reinitialize the TX desc queue */
 	queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-	if (bp->hw_dma_cap & HW_DMA_CAP_64B)
-		queue_writel(queue, TBQPH, upper_32_bits(queue->tx_ring_dma));
-#endif
 	/* Make TX ring reflect state of hardware */
 	queue->tx_head = 0;
 	queue->tx_tail = 0;
@@ -2239,6 +2235,7 @@ static int macb_alloc_consistent(struct macb *bp)
 {
 	struct macb_queue *queue;
 	unsigned int q;
+	u32 upper;
 	int size;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
@@ -2246,7 +2243,9 @@ static int macb_alloc_consistent(struct macb *bp)
 		queue->tx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
 						    &queue->tx_ring_dma,
 						    GFP_KERNEL);
-		if (!queue->tx_ring)
+		upper = upper_32_bits(queue->tx_ring_dma);
+		if (!queue->tx_ring ||
+		    upper != upper_32_bits(bp->queues[0].tx_ring_dma))
 			goto out_err;
 		netdev_dbg(bp->dev,
 			   "Allocated TX ring for queue %u of %d bytes at %08lx (mapped %p)\n",
@@ -2260,8 +2259,11 @@ static int macb_alloc_consistent(struct macb *bp)
 
 		size = RX_RING_BYTES(bp) + bp->rx_bd_rd_prefetch;
 		queue->rx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
-						 &queue->rx_ring_dma, GFP_KERNEL);
-		if (!queue->rx_ring)
+						    &queue->rx_ring_dma,
+						    GFP_KERNEL);
+		upper = upper_32_bits(queue->rx_ring_dma);
+		if (!queue->rx_ring ||
+		    upper != upper_32_bits(bp->queues[0].rx_ring_dma))
 			goto out_err;
 		netdev_dbg(bp->dev,
 			   "Allocated RX ring of %d bytes at %08lx (mapped %p)\n",
@@ -3735,12 +3737,6 @@ static int macb_init(struct platform_device *pdev)
 			queue->TBQP = GEM_TBQP(hw_q - 1);
 			queue->RBQP = GEM_RBQP(hw_q - 1);
 			queue->RBQS = GEM_RBQS(hw_q - 1);
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-			if (bp->hw_dma_cap & HW_DMA_CAP_64B) {
-				queue->TBQPH = GEM_TBQPH(hw_q - 1);
-				queue->RBQPH = GEM_RBQPH(hw_q - 1);
-			}
-#endif
 		} else {
 			/* queue0 uses legacy registers */
 			queue->ISR  = MACB_ISR;
@@ -3749,12 +3745,6 @@ static int macb_init(struct platform_device *pdev)
 			queue->IMR  = MACB_IMR;
 			queue->TBQP = MACB_TBQP;
 			queue->RBQP = MACB_RBQP;
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-			if (bp->hw_dma_cap & HW_DMA_CAP_64B) {
-				queue->TBQPH = MACB_TBQPH;
-				queue->RBQPH = MACB_RBQPH;
-			}
-#endif
 		}
 
 		/* get irq: here we use the linux queue index, not the hardware
-- 
2.53.0

