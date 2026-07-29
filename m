Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80168388E55
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785292815; cv=none; b=Njen8a8K7zdk1GUmyCu+iJdJz6prq3TD39o8sWTq5rQxxsdKpaPvjWnlDO3lpe/0izpPXdREa37h71+uUIRmyHnqTpN20X9FkoROIVKs8VbeV2ZVk2FEmCm5cmuj2At+MEgW0H8mvatmvA4WrKvAG+m1gdn2nH5HuDrOYLHjMNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785292815; c=relaxed/simple;
	bh=xXCzUXDtDCKw0uy0Sl4pzz4FcQ9cWslhr2y1UzcUQEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LhXb3NjbCqDrpv9J/1vTRS+uo6rn1lj3xnMtrFigNDBjWldzqde+TIuTR9IGev1005BuGpcnZ+b173fybeLi4vbbyrDMum/bYw+sQumSP8upDEOLaQess2siPwuKS08OegsMwpE5wxg9g6unSPrSlxdQhMkuKp4rO4Yzy9ut/Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlXO4F/s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlXO4F/s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487341F00A3D;
	Wed, 29 Jul 2026 02:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785292811;
	bh=vReaguJkf/K+S0rlhIEuiIAh0d9fDhJ5Dl57cjkk0uI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nlXO4F/sG/knK801H1iQGt4P3vEmKx8GbtnGa4Pu+3kbBuXncm5z00dnRI4F1R0pA
	 GJbnTPx0iH10nfCjMu2JqdBOEpM9k6kRebdAOlO+RkD0I64PLkf+YxIeiqQ+LWBPnM
	 UJIQjMjoJVdPYYn3itPNgjgK1mxU/PWQ1WBrnE98V/XaD5CZhqS/zh+7Z80fo/yFgA
	 QFdSLVLOQJo6hW9EvkEtstiugBNwh6V+ZWrr976LbTXcvrdgpH/eeZhWr4A1OcsvVd
	 BzXF4lbvEbGnL7v82IJ32AvIeV3pnazwWFmBRpoEMtcwEZhWPaElC2mvp1+oxBjFEI
	 ZY8iqhJx6FVHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] net: macb: drop in-flight Tx SKBs on close
Date: Tue, 28 Jul 2026 22:40:09 -0400
Message-ID: <20260729024009.1127546-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072141-computing-awaken-54dc@gregkh>
References: <2026072141-computing-awaken-54dc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Théo Lebrun <theo.lebrun@bootlin.com>

[ Upstream commit 27f575836cfebbf872dec020428742b10650a955 ]

The MACB driver has since forever leaked the outgoing SKBs that
have not yet been marked as completed. They live in queue->tx_skb
which gets freed without remorse nor checking.

macb_free_consistent() gets called in a few codepaths, but only close will
trigger the added expressions. In macb_open() and macb_alloc_consistent()
failure cases, queues' tx_skb just got allocated and are empty.

Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
Cc: stable@vger.kernel.org
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Link: https://patch.msgid.link/20260702-macb-drop-tx-v4-1-1c833eebdbc8@bootlin.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ adjusted context to free each queue's Tx/Rx rings individually since 6.12 lacks the single-dma_alloc_coherent refactor ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index aac62db4ee1460..399a41a3962f70 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2582,8 +2582,26 @@ static void macb_free_consistent(struct macb *bp)
 	bp->macbgem_ops.mog_free_rx_buffers(bp);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		kfree(queue->tx_skb);
-		queue->tx_skb = NULL;
+		if (queue->tx_skb) {
+			unsigned int dropped = 0, tail;
+
+			for (tail = queue->tx_tail; tail != queue->tx_head;
+			     tail++) {
+				if (macb_tx_skb(queue, tail)->skb)
+					dropped++;
+				macb_tx_unmap(bp, macb_tx_skb(queue, tail), 0);
+			}
+
+			queue->stats.tx_dropped += dropped;
+			bp->dev->stats.tx_dropped += dropped;
+
+			kfree(queue->tx_skb);
+			queue->tx_skb = NULL;
+		}
+
+		queue->tx_head = 0;
+		queue->tx_tail = 0;
+
 		if (queue->tx_ring) {
 			size = TX_RING_BYTES(bp) + bp->tx_bd_rd_prefetch;
 			dma_free_coherent(&bp->pdev->dev, size,
-- 
2.53.0

