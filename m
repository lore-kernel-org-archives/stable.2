Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E0A469845
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344278; cv=none; b=jUr7R1Qz2VCTNRmZls3a1PgkwosD/WS/gWCdwyKI93z8iZqDjQMdmqdCUde9o7yrP+CqVBdufg/NkI8Y0xZOilmRVny70w7AD7xaOi+6u44e+Rc+D4CUB0gGmh3Eza+JM7gfOk3KPDWBv9+gc5sxeOqFfwySS5f2WvwYUGwnfmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344278; c=relaxed/simple;
	bh=Vx8k9LqApIp4I4HUp4g+XWFZIRWjbzncZQFMY7nWA0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jeS5jFJrWIsFdgwk01qczXHOaQprI4XUtbDFBANTcf/Cih++fj937k1GNufaK8vnBP1FceZqYF6912BEhiefen5bpmWwfPqlaIXKCYNt1IGpVmn10ovs2cX3ztSENexIMmOuv/BkA3cArEqQihAsnwxNKXjd1CUHKne6c9WdXLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSiFrfyu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSiFrfyu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304F71F000E9;
	Wed, 29 Jul 2026 16:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785344276;
	bh=lk+TiKfGgzrGLne98qr2yZnwf5awrHwnI+X8SPkG3dE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CSiFrfyuv6sgLPDDtmm43YRV/O2DCwAl4eWri69UXwh49K+vo/EYEDe2og5AntF/Z
	 FY7jMgmRe3j31doaJJDan7HYrb9vnSKP6mhAZLYCXgQhpt3xS+OOQ42ksjrBVvIkKK
	 hEFNdBT2h/iEfoqbPpwIXJ8pgtWzq7JwkibonaxR+wA3lBbYW8zp7CrpZc1X9B1NeO
	 zAwB2jhLrzK5W73gfPPoLEPQBmkVy73ahE0yrhDEZA2oqyJPxuHQrWCQTmrIGuHZ6k
	 NEvCH1ZG13wU2zmU+p1kGQb63AFZJ1qSy98sKZZ4zQyObxCt8xL9v6zeqr0T5ypDf8
	 e0VjRAOtrxaQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/6] net: macb: single dma_alloc_coherent() for DMA descriptors
Date: Wed, 29 Jul 2026 12:57:48 -0400
Message-ID: <20260729165749.3661232-5-sashal@kernel.org>
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

[ Upstream commit 78d901897b3cae06b38f54e48a2378cf9da21175 ]

Move from 2*NUM_QUEUES dma_alloc_coherent() for DMA descriptor rings to
2 calls overall.

Issue is with how all queues share the same register for configuring the
upper 32-bits of Tx/Rx descriptor rings. Taking Tx, notice how TBQPH
does *not* depend on the queue index:

	#define GEM_TBQP(hw_q)		(0x0440 + ((hw_q) << 2))
	#define GEM_TBQPH(hw_q)		(0x04C8)

	queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
	#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
	if (bp->hw_dma_cap & HW_DMA_CAP_64B)
		queue_writel(queue, TBQPH, upper_32_bits(queue->tx_ring_dma));
	#endif

To maximise our chances of getting valid DMA addresses, we do a single
dma_alloc_coherent() across queues. This improves the odds because
alloc_pages() guarantees natural alignment. Other codepaths (IOMMU or
dev/arch dma_map_ops) don't give high enough guarantees
(even page-aligned isn't enough).

Two consideration:

 - dma_alloc_coherent() gives us page alignment. Here we remove this
   constraint meaning each queue's ring won't be page-aligned anymore.

 - This can save some tiny amounts of memory. Fewer allocations means
   (1) less overhead (constant cost per alloc) and (2) less wasted bytes
   due to alignment constraints.

   Example for (2): 4 queues, default ring size (512), 64-bit DMA
   descriptors, 16K pages:
    - Before: 8 allocs of 8K, each rounded to 16K => 64K wasted.
    - After:  2 allocs of 32K => 0K wasted.

Fixes: 02c958dd3446 ("net/macb: add TX multiqueue support for gem")
Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Tested-by: Nicolas Ferre <nicolas.ferre@microchip.com> # on sam9x75
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250923-macb-fixes-v6-4-772d655cdeb6@bootlin.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 27f575836cfe ("net: macb: drop in-flight Tx SKBs on close")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 78 ++++++++++++------------
 1 file changed, 40 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b7aeab39e2ccbe..66233c399306fd 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2177,26 +2177,24 @@ static unsigned int macb_rx_ring_size_per_queue(struct macb *bp)
 
 static void macb_free_consistent(struct macb *bp)
 {
+	struct device *dev = &bp->pdev->dev;
 	struct macb_queue *queue;
 	unsigned int q;
+	size_t size;
 
 	bp->macbgem_ops.mog_free_rx_buffers(bp);
 
+	size = bp->num_queues * macb_tx_ring_size_per_queue(bp);
+	dma_free_coherent(dev, size, bp->queues[0].tx_ring, bp->queues[0].tx_ring_dma);
+
+	size = bp->num_queues * macb_rx_ring_size_per_queue(bp);
+	dma_free_coherent(dev, size, bp->queues[0].rx_ring, bp->queues[0].rx_ring_dma);
+
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		kfree(queue->tx_skb);
 		queue->tx_skb = NULL;
-		if (queue->tx_ring) {
-			dma_free_coherent(&bp->pdev->dev,
-					  macb_tx_ring_size_per_queue(bp),
-					  queue->tx_ring, queue->tx_ring_dma);
-			queue->tx_ring = NULL;
-		}
-		if (queue->rx_ring) {
-			dma_free_coherent(&bp->pdev->dev,
-					  macb_rx_ring_size_per_queue(bp),
-					  queue->rx_ring, queue->rx_ring_dma);
-			queue->rx_ring = NULL;
-		}
+		queue->tx_ring = NULL;
+		queue->rx_ring = NULL;
 	}
 }
 
@@ -2238,41 +2236,45 @@ static int macb_alloc_rx_buffers(struct macb *bp)
 
 static int macb_alloc_consistent(struct macb *bp)
 {
+	struct device *dev = &bp->pdev->dev;
+	dma_addr_t tx_dma, rx_dma;
 	struct macb_queue *queue;
 	unsigned int q;
-	u32 upper;
-	int size;
+	void *tx, *rx;
+	size_t size;
+
+	/*
+	 * Upper 32-bits of Tx/Rx DMA descriptor for each queues much match!
+	 * We cannot enforce this guarantee, the best we can do is do a single
+	 * allocation and hope it will land into alloc_pages() that guarantees
+	 * natural alignment of physical addresses.
+	 */
+
+	size = bp->num_queues * macb_tx_ring_size_per_queue(bp);
+	tx = dma_alloc_coherent(dev, size, &tx_dma, GFP_KERNEL);
+	if (!tx || upper_32_bits(tx_dma) != upper_32_bits(tx_dma + size - 1))
+		goto out_err;
+	netdev_dbg(bp->dev, "Allocated %zu bytes for %u TX rings at %08lx (mapped %p)\n",
+		   size, bp->num_queues, (unsigned long)tx_dma, tx);
+
+	size = bp->num_queues * macb_rx_ring_size_per_queue(bp);
+	rx = dma_alloc_coherent(dev, size, &rx_dma, GFP_KERNEL);
+	if (!rx || upper_32_bits(rx_dma) != upper_32_bits(rx_dma + size - 1))
+		goto out_err;
+	netdev_dbg(bp->dev, "Allocated %zu bytes for %u RX rings at %08lx (mapped %p)\n",
+		   size, bp->num_queues, (unsigned long)rx_dma, rx);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		size = macb_tx_ring_size_per_queue(bp);
-		queue->tx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
-						    &queue->tx_ring_dma,
-						    GFP_KERNEL);
-		upper = upper_32_bits(queue->tx_ring_dma);
-		if (!queue->tx_ring ||
-		    upper != upper_32_bits(bp->queues[0].tx_ring_dma))
-			goto out_err;
-		netdev_dbg(bp->dev,
-			   "Allocated TX ring for queue %u of %d bytes at %08lx (mapped %p)\n",
-			   q, size, (unsigned long)queue->tx_ring_dma,
-			   queue->tx_ring);
+		queue->tx_ring = tx + macb_tx_ring_size_per_queue(bp) * q;
+		queue->tx_ring_dma = tx_dma + macb_tx_ring_size_per_queue(bp) * q;
+
+		queue->rx_ring = rx + macb_rx_ring_size_per_queue(bp) * q;
+		queue->rx_ring_dma = rx_dma + macb_rx_ring_size_per_queue(bp) * q;
 
 		size = bp->tx_ring_size * sizeof(struct macb_tx_skb);
 		queue->tx_skb = kmalloc(size, GFP_KERNEL);
 		if (!queue->tx_skb)
 			goto out_err;
-
-		size = macb_rx_ring_size_per_queue(bp);
-		queue->rx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
-						    &queue->rx_ring_dma,
-						    GFP_KERNEL);
-		upper = upper_32_bits(queue->rx_ring_dma);
-		if (!queue->rx_ring ||
-		    upper != upper_32_bits(bp->queues[0].rx_ring_dma))
-			goto out_err;
-		netdev_dbg(bp->dev,
-			   "Allocated RX ring of %d bytes at %08lx (mapped %p)\n",
-			   size, (unsigned long)queue->rx_ring_dma, queue->rx_ring);
 	}
 	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
 		goto out_err;
-- 
2.53.0

