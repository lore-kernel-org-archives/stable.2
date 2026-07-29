Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E46469832
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344278; cv=none; b=ImDnrganD4qeFGe/m79mXju5Rl14P6tORpkKwz7yN3/ts/7sI3Nq4vt15SNm7RB0t1f59OpEfttQxT7hVe6UaNLBN6RgkJgfcnmL9fdm+QjDEB2s+t3kG3UVTHjqoP+w7Mba3QXS8sL+77Lh9MyQlwWqqHm7MEA3p5zkxgAAhuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344278; c=relaxed/simple;
	bh=/7LE7DfVyKWpOL+PrsPzBVV9vdBprg5Da1dl8yKg+80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvmpBk+V4OcnvgHnprH55KTMC/aFhYnw49MofiCTiItsez2LDk5rXzFqy+Y5Rk165FYclI9IPvBQpS2cKaQi9AnGoEuF2R5p84U6VdZeO/vdr5h9injG7W8yuPQKRuS3Fn8D3rqSI0W/Hx1OFLQDcoorzD7X147Ed7ww0uYBbPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtViSab9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtViSab9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9711F00A3E;
	Wed, 29 Jul 2026 16:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785344277;
	bh=2r9y5HpebsTDdDNGkCIScaqZbWWWmHtSDfATcQFdDSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YtViSab9V4Uw/N5g8ulVEpTSPagHHlLM1sVo8Ace5/r594GUCpb/LoBW/VBd2/uDW
	 yxRiwEixAffJmJjq/YMj7yee9w9ugh+mZDQGcaEdYx5tSQ0Ohi85Q3dw0Gp/qZOBC1
	 CtunpHYX0J63lOk10QPrHYveaqY/jvCjJVMEPhiY1S9l7f0F3g+YW/rYk1aU6d4f1P
	 FIfg3Ax0HwgLW2dam3hTKdST9XNCwoEzbupXXQTzkK4UkUhsBmQ/nNn6/ZJs2s95om
	 0ejKVQB1pRvIEE5G7cB26VzW1I96FPQ8Pk2CsT+zv8W+/jpKGDWbDWan9hKOa09zii
	 q1E5i9zhszhcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 6/6] net: macb: drop in-flight Tx SKBs on close
Date: Wed, 29 Jul 2026 12:57:49 -0400
Message-ID: <20260729165749.3661232-6-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 66233c399306fd..2e97a9375be2f1 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2191,8 +2191,25 @@ static void macb_free_consistent(struct macb *bp)
 	dma_free_coherent(dev, size, bp->queues[0].rx_ring, bp->queues[0].rx_ring_dma);
 
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
 		queue->tx_ring = NULL;
 		queue->rx_ring = NULL;
 	}
-- 
2.53.0

