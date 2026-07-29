Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0700C486BB8
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342275; cv=none; b=ep7q2CvJNDSMZERsV3DwdPwOZ/eg4ccbnaAR7dOEFvrm/xQvKZmbwZwXU1+3aGvTCqMgfJ0BWlnwroGNKTlv6lIzmDot96ofuVV+JQgT8Yy8JztD45oRNRegCtI4EOGV8LoVnJbaLrKpPux16aHRrE36WgL/7QJoY6FmeDcta6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342275; c=relaxed/simple;
	bh=y6dV2W2AVAWRCr58M2ITxxd+qMp8tQtOwj13ClNBz2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2qhiqln4BxXhF6WarK2kjfDhLEDVa32uA8LTfdtqOLtCa96lUvn45k+csG9oWzhtZ8dzgHEYzNznCmlL4PQtLATkvMvNIWKjxMZOZ8HaotJWLf++CQD7S25qTUUBAb48qncNiA3aXu0L4zmojjPzOxcIbkrgQ4Xj0eUUv8usBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCQXTp7Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCQXTp7Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67A61F00A3A;
	Wed, 29 Jul 2026 16:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785342272;
	bh=CxOv0wEitUxHntczsJdoeclbVCs35siBeFTkuY2EGLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cCQXTp7Q2y98z4//pUHaG4RT6WO0LPTPB4PeV4dy8WXvkSClAG7RC4rpKnh3KAYwZ
	 gmx5TeFFjTYd+6FBV2lbjCnx3lK+h4zkHWpfKB4KbbDIVylqTCTPPnrQ+wBSlgdDyL
	 Aj30F8oZskuuoh9Aq0K+EVvqMplC3AOD2xqK+DRyREmKvMUF33mS0KE/WmiNoEVGp6
	 gWI1vnHEHTtomUaujt+OYRm9zG0VC85ZiGG0Ct4L3oA2LdUYJ3XQCOXiBiXsvo0XKj
	 TN4M76qlshU3bDu5BD+dnVp+cJUjJbnE+Gp4QkTT5KOd2WKF2Tly8dX709zSHc7soY
	 qYsHlREgpnvMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/6] net: macb: move ring size computation to functions
Date: Wed, 29 Jul 2026 12:24:25 -0400
Message-ID: <20260729162427.3522161-4-sashal@kernel.org>
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

[ Upstream commit 92d4256fafd8d0a14d3aaa10452ac771bf9b597c ]

The tx/rx ring size calculation is somewhat complex and partially hidden
behind a macro. Move that out of the {RX,TX}_RING_BYTES() macros and
macb_{alloc,free}_consistent() functions into neat separate functions.

In macb_free_consistent(), we drop the size variable and directly call
the size helpers in the arguments list. In macb_alloc_consistent(), we
keep the size variable that is used by netdev_dbg() calls.

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250923-macb-fixes-v6-3-772d655cdeb6@bootlin.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 27f575836cfe ("net: macb: drop in-flight Tx SKBs on close")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 27 ++++++++++++++----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 7c7232244c309e..e012d28678556c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -51,14 +51,10 @@ struct sifive_fu540_macb_mgmt {
 #define DEFAULT_RX_RING_SIZE	512 /* must be power of 2 */
 #define MIN_RX_RING_SIZE	64
 #define MAX_RX_RING_SIZE	8192
-#define RX_RING_BYTES(bp)	(macb_dma_desc_get_size(bp)	\
-				 * (bp)->rx_ring_size)
 
 #define DEFAULT_TX_RING_SIZE	512 /* must be power of 2 */
 #define MIN_TX_RING_SIZE	64
 #define MAX_TX_RING_SIZE	4096
-#define TX_RING_BYTES(bp)	(macb_dma_desc_get_size(bp)	\
-				 * (bp)->tx_ring_size)
 
 /* level of occupied TX descriptors under which we wake up TX process */
 #define MACB_TX_WAKEUP_THRESH(bp)	(3 * (bp)->tx_ring_size / 4)
@@ -2360,11 +2356,20 @@ static void macb_free_rx_buffers(struct macb *bp)
 	}
 }
 
+static unsigned int macb_tx_ring_size_per_queue(struct macb *bp)
+{
+	return macb_dma_desc_get_size(bp) * bp->tx_ring_size + bp->tx_bd_rd_prefetch;
+}
+
+static unsigned int macb_rx_ring_size_per_queue(struct macb *bp)
+{
+	return macb_dma_desc_get_size(bp) * bp->rx_ring_size + bp->rx_bd_rd_prefetch;
+}
+
 static void macb_free_consistent(struct macb *bp)
 {
 	struct macb_queue *queue;
 	unsigned int q;
-	int size;
 
 	bp->macbgem_ops.mog_free_rx_buffers(bp);
 
@@ -2372,14 +2377,14 @@ static void macb_free_consistent(struct macb *bp)
 		kfree(queue->tx_skb);
 		queue->tx_skb = NULL;
 		if (queue->tx_ring) {
-			size = TX_RING_BYTES(bp) + bp->tx_bd_rd_prefetch;
-			dma_free_coherent(&bp->pdev->dev, size,
+			dma_free_coherent(&bp->pdev->dev,
+					  macb_tx_ring_size_per_queue(bp),
 					  queue->tx_ring, queue->tx_ring_dma);
 			queue->tx_ring = NULL;
 		}
 		if (queue->rx_ring) {
-			size = RX_RING_BYTES(bp) + bp->rx_bd_rd_prefetch;
-			dma_free_coherent(&bp->pdev->dev, size,
+			dma_free_coherent(&bp->pdev->dev,
+					  macb_rx_ring_size_per_queue(bp),
 					  queue->rx_ring, queue->rx_ring_dma);
 			queue->rx_ring = NULL;
 		}
@@ -2430,7 +2435,7 @@ static int macb_alloc_consistent(struct macb *bp)
 	int size;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		size = TX_RING_BYTES(bp) + bp->tx_bd_rd_prefetch;
+		size = macb_tx_ring_size_per_queue(bp);
 		queue->tx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
 						    &queue->tx_ring_dma,
 						    GFP_KERNEL);
@@ -2448,7 +2453,7 @@ static int macb_alloc_consistent(struct macb *bp)
 		if (!queue->tx_skb)
 			goto out_err;
 
-		size = RX_RING_BYTES(bp) + bp->rx_bd_rd_prefetch;
+		size = macb_rx_ring_size_per_queue(bp);
 		queue->rx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
 						    &queue->rx_ring_dma,
 						    GFP_KERNEL);
-- 
2.53.0

