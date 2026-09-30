Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDE634E774
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 01:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790730784; cv=none; b=YDupwsVpA3gcppY4aKU5bGL1gK5CAIcHpvOemjeHMSMz3VhzR2MbA2WEr9mwyPaM5qX2rfAq9lI1jH4xZKT+ssgzrnlJFpaKmX/j0zvFgKq0IwhPmqN65wbdbu+vvZwWXq0DLAygsBkORmbVdLN4a1vlDcYyO7Rkj2PlXYO2ZGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790730784; c=relaxed/simple;
	bh=U9hUDvq5HwkPT3TJZtXNQ0ri12NaTsaBw19ReDYw9Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMj6Fn2/5dx8Os+4s0NQWRlhryphGy+BK8HoFA5hJO/GF/wc8rxcD7fg4EaXgLO/EmobFOmKDFC51zWcGGxayQh1V0IOimCvuLFwzt7ngs7yhJuYP+nnf1GIsvpNx//Gshm9WxWVSGrKeTho3gpTpF5KsiM4Pm0iHa4LPWOO+I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbFtUdx0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbFtUdx0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0CB1F000FF;
	Wed, 30 Sep 2026 01:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790730783;
	bh=wfUsCdUx9Iiz8bjQ1bpU9wFshtyZeYSRmKpmq+r3H8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WbFtUdx0XiJZIvOfsd/gDIqTNxpK0KwHapDRzbi2In7x5tnCknrn2shx0Y52/i6gp
	 oMreOi5iJFqijscBASF794mj2NkPDiPq+3PIW/avflOTml+8TsYhU4/xitb/QMKdNJ
	 xyLwxlNbp2OShhmgZoJbs6l5pfdwYCaDLmOtA375XstNVU+ozqcuRHU7i/0gYYBNal
	 AHxa+eBaPJxUtL2xvNkW8k+SwODQkY8AHAbKlVY3WBUI+znI3TC0tVjcaonlsZxGu5
	 KCE+uAqgslVuPvxtu+mP6nsTC/5bT2a2Ip9jQA7tb8HazHr0/rF2SkEFxqnayJSoyq
	 RR+u4TG/3IRmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] net: macb: fix dma_alloc_coherent() leak on macb_alloc() error paths
Date: Tue, 29 Sep 2026 21:13:00 -0400
Message-ID: <20260930011300.3257219-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092901-evaluator-improvise-eb56@gregkh>
References: <2026092901-evaluator-improvise-eb56@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Théo Lebrun <theo.lebrun@bootlin.com>

[ Upstream commit 23d42b9a3bcd55b17d3b371544fedc708c2397e9 ]

Fix 3 leaks in macb_alloc() error paths:
- Tx buffer allocated but crossing a 4G boundary: Tx leaked.
- Rx buffer allocation fails: Tx leaked.
- Rx buffer allocated but crossing a 4G boundary: Tx & Rx leaked.

This is because our error handling calls macb_free(bp) which in turn
frees the buffers stored in bp->queues[0], but nothing has been stored
in there. Fix by storing allocated buffers into bp->queues[0] ASAP.

Fixes: 78d901897b3c ("net: macb: single dma_alloc_coherent() for DMA descriptors")
Cc: stable@vger.kernel.org
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Link: https://patch.msgid.link/20260918-macb-alloc-leak-v1-1-aba9a3d4f6e3@bootlin.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 02fd4bd04487a..1eaf9be483153 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2663,14 +2663,24 @@ static int macb_alloc_consistent(struct macb *bp)
 
 	size = bp->num_queues * macb_tx_ring_size_per_queue(bp);
 	tx = dma_alloc_coherent(dev, size, &tx_dma, GFP_KERNEL);
-	if (!tx || upper_32_bits(tx_dma) != upper_32_bits(tx_dma + size - 1))
+	if (!tx)
+		goto out_err;
+	/* Record the buffer so that the error path frees it. */
+	bp->queues[0].tx_ring = tx;
+	bp->queues[0].tx_ring_dma = tx_dma;
+	if (upper_32_bits(tx_dma) != upper_32_bits(tx_dma + size - 1))
 		goto out_err;
 	netdev_dbg(bp->dev, "Allocated %zu bytes for %u TX rings at %08lx (mapped %p)\n",
 		   size, bp->num_queues, (unsigned long)tx_dma, tx);
 
 	size = bp->num_queues * macb_rx_ring_size_per_queue(bp);
 	rx = dma_alloc_coherent(dev, size, &rx_dma, GFP_KERNEL);
-	if (!rx || upper_32_bits(rx_dma) != upper_32_bits(rx_dma + size - 1))
+	if (!rx)
+		goto out_err;
+	/* Record the buffer so that the error path frees it. */
+	bp->queues[0].rx_ring = rx;
+	bp->queues[0].rx_ring_dma = rx_dma;
+	if (upper_32_bits(rx_dma) != upper_32_bits(rx_dma + size - 1))
 		goto out_err;
 	netdev_dbg(bp->dev, "Allocated %zu bytes for %u RX rings at %08lx (mapped %p)\n",
 		   size, bp->num_queues, (unsigned long)rx_dma, rx);
-- 
2.53.0

