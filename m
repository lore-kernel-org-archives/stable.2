Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D00236F914
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 02:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785292206; cv=none; b=PphDexsAqBTElIYQmqQiaaoNqBT8+YAW3lBSyWB1wi952bkrVVhDdr1yACU+S3ryeSd37zuaUJVavv3bwHUgsFkxw7X6oa6TpukLwfYEFDnHGlY/PKaiOELEMZYmwQseS6zw3JAX8vAVJxRzLvdEmP16Vlnwp2/oz6S2S/NmX+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785292206; c=relaxed/simple;
	bh=gNl5Z/CQYpz1tYYsLd+Tt72cVMR69RwFJD/uA0IsEG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNhEd0DD1y9iMQ0Eu/3i5x9pLaPieHiCjtY/zQRR3hDxAobJO5CUj/Z2wI/DrBxSQ/T6sVDF1qU5uWOJ0JTpeDHYA8Not1pUPGT91kLnnrGFMwi6xGgCC10GhM688lRi99rcjb3nvWQE0llMrUB9TB243HpeCNhVBNarFvvR/uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nimk9wD3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nimk9wD3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E72C1F00A3D;
	Wed, 29 Jul 2026 02:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785292204;
	bh=z4yT0KrkIt8Tiiw84eKfiDcmd5QY2QlAnPToIZIDOkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nimk9wD37fsta/ub3gEPvfuBLRZmfpCEu2v2+tU/kJqsUcw3qirq1EpWEog+CHkRz
	 pfnXZpnjG5LGO6Z6FB4S8SgIDH5wzjHgjo8X8kPAeb9uWvhoG+/83P6KWE3gfpPz5S
	 d/x8lhC0dl4OQr9043yqGBesJQAe87cp0Lb5zNmbsxgg4cI5/Lx1g6UXwk3Br32/me
	 T1KOF4GuIKZDNNopyrm2ZMpDwabkCSaS6/PqHDV9sYps7qJDj4S4G5XKWueqLN0mc4
	 KySFNU/CUv1edHokQM2w7eoPaV9EMB3PWGfXnGXenSvii9HCtfz+Aqy1cIrtfRPF8K
	 FSLoPpnqw3erw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] net: macb: drop in-flight Tx SKBs on close
Date: Tue, 28 Jul 2026 22:30:02 -0400
Message-ID: <20260729023002.1113287-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072140-catacomb-activator-d955@gregkh>
References: <2026072140-catacomb-activator-d955@gregkh>
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
index fbf8d0ba9c4732..67b16aca565ce9 100644
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

