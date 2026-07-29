Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7409209F43
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 03:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785295215; cv=none; b=NmwBUC90nyZcyujPcpv7UoIlZa7W57lh+KEWqP+VarbfPa3O2etFF8r/4+0HimPtks44Y3drFmv7NMQbiOutfiSoPhILgYP1bIwujoZiUMmwv8PtWR6pNAtmY0LmsLLlQojnF30vK38OZPOHuEnzONRvyelTKfwsgBitDZJUL6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785295215; c=relaxed/simple;
	bh=8jRPc/pvaEIfE2B4mMlT9a55zZnBWRAqsIqYz9uX2JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5kMekTaIaSSYmi5nJb08nlGIlmzQ1oiwhwKz8Jg3HYYI8ds1zDw0sOB3ROze8WZKerPoa0nPpaR9fJ5hiIPDTFXgwlSvIvEoSw9n/JWvQPkeEgxhv+LktmfJavkIwnkyNA/EmL71n/9H2jQPOPfdxpVf71mX0dbkllFJy9egyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1pzl5BQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1pzl5BQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FD01F000E9;
	Wed, 29 Jul 2026 03:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785295213;
	bh=3nce4UTt694Or3CvTwyo/SVCASAOr5kcEyNEq2+Ca8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q1pzl5BQr4XYnghBb7uO7MQf9f8MQ/1SnzJMX7baXzKufSyf+qTXV/r+xVwrqyJ93
	 9BCmfnmQKmBHTrM3GELjnuO/xMGUka8olJQUBtAyoDg3XJ5YjFI60CYKQBCh6Da5ox
	 538O7RtIj7Ut8J8UAN9cdxx03EoUWsvmPlUwVWyacGXnIytDW5Cyp/TodKjFvW8ISe
	 cRTRTyVzuKFt6Y7UQU46yd+v2gCyMCXRMF+vxHn1cU3ZtgppGuP/SbcCA8mwBtxaYv
	 db66KakpKGCC+wQFxhLQg+KVi3I2l0+bzENVkh6zhNNUsiC2+2ec24ZaRR2FKvzUtd
	 7QgMfeNNKmOOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] net: macb: drop in-flight Tx SKBs on close
Date: Tue, 28 Jul 2026 23:20:11 -0400
Message-ID: <20260729032011.1223731-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072141-confess-wrinkly-83cf@gregkh>
References: <2026072141-confess-wrinkly-83cf@gregkh>
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
index f29dc2d3621903..513a1267a6ef7e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2520,8 +2520,26 @@ static void macb_free_consistent(struct macb *bp)
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

