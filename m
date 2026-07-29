Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE89247F2F7
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342273; cv=none; b=HeMR0taX0d6S5x3rjo0y+9vBQQYWelOslgVaLn1xp4dg/lM31THnIbLxOJjQVhjVlHxrv2aYWaUCecFkh4OEO498oIqJfK/lVg6WJehxSf9ryI65sZGaO+3BjqC8IrIay3aXuiq2yftx93ZIFN0BYuAuLiCrlCD4dzz47b8RUS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342273; c=relaxed/simple;
	bh=UnrSCpkAJpQGVDxYwOzFXf0U5Nj3SsVL8la6dvFoi9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+T2MDg5q6+Hio8/M6IAXQerMlM1FpuXW+eQDWjhrSROZZmAEHD9OGgDPD+3ZIwpRfNV0mtaPAy998/3gKBWzPiQZGJFpwSbQnU0jsN+6+FXTytGCx0ADfG79g8VKfxQEfYyUS9KOKLIF4qZar3i/OFEvIv15R6/t1k6OhtQrJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSnKxMxR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSnKxMxR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFD91F00A3F;
	Wed, 29 Jul 2026 16:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785342271;
	bh=cojWr7H+ZAeDJIA8bIkBIe8CYhK9ZfscFR0P4Qk13gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aSnKxMxRBCfPte31jDe+TzFRLynKRyrt8FKAhlJBcRbJxSBQbxqVkyJRdbHnTbB/3
	 90rPhcsAW04ePAGXt/ckdUTSfM3g9b+Zt+4cYr35F1+I5ZoxIeDtEa1kTqqyRgTOPu
	 wewi9G5Rpbsb/M86qY+PgkDNx5fDHZ+utIXUQpkB1sbJ931ZEf8qtczMFdBxtGA6o5
	 UF0BpnL4n4E6ol7VnqeWV35zoep9ylQTMZ5AeHAv92vfk4/G9CqJpBtcex8BQowNMv
	 BldId5AcLJmCFH2LxFKrl23mUhatiFOmcYrgoH3j5oMjxi6zNerK5seEgdQ0/L1RGX
	 Vnfd/CGcIBBTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/6] net: macb: remove illusion about TBQPH/RBQPH being per-queue
Date: Wed, 29 Jul 2026 12:24:24 -0400
Message-ID: <20260729162427.3522161-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729162427.3522161-1-sashal@kernel.org>
References: <2026072141-overrate-gratified-54e6@gregkh>
 <20260729162427.3522161-1-sashal@kernel.org>
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
index d3d1b9237d5945..9ea2698fcfe283 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -208,10 +208,8 @@
 
 #define GEM_ISR(hw_q)		(0x0400 + ((hw_q) << 2))
 #define GEM_TBQP(hw_q)		(0x0440 + ((hw_q) << 2))
-#define GEM_TBQPH(hw_q)		(0x04C8)
 #define GEM_RBQP(hw_q)		(0x0480 + ((hw_q) << 2))
 #define GEM_RBQS(hw_q)		(0x04A0 + ((hw_q) << 2))
-#define GEM_RBQPH(hw_q)		(0x04D4)
 #define GEM_IER(hw_q)		(0x0600 + ((hw_q) << 2))
 #define GEM_IDR(hw_q)		(0x0620 + ((hw_q) << 2))
 #define GEM_IMR(hw_q)		(0x0640 + ((hw_q) << 2))
@@ -1195,10 +1193,8 @@ struct macb_queue {
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
index 42a2a768fa64e6..7c7232244c309e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -443,19 +443,19 @@ static void macb_init_buffers(struct macb *bp)
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
 
@@ -1143,10 +1143,6 @@ static void macb_tx_error_task(struct work_struct *work)
 
 	/* Reinitialize the TX desc queue */
 	queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-	if (bp->hw_dma_cap & HW_DMA_CAP_64B)
-		queue_writel(queue, TBQPH, upper_32_bits(queue->tx_ring_dma));
-#endif
 	/* Make TX ring reflect state of hardware */
 	queue->tx_head = 0;
 	queue->tx_tail = 0;
@@ -2430,6 +2426,7 @@ static int macb_alloc_consistent(struct macb *bp)
 {
 	struct macb_queue *queue;
 	unsigned int q;
+	u32 upper;
 	int size;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
@@ -2437,7 +2434,9 @@ static int macb_alloc_consistent(struct macb *bp)
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
@@ -2451,8 +2450,11 @@ static int macb_alloc_consistent(struct macb *bp)
 
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
@@ -3937,12 +3939,6 @@ static int macb_init(struct platform_device *pdev)
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
@@ -3951,12 +3947,6 @@ static int macb_init(struct platform_device *pdev)
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

