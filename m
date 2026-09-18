Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D528A524AE4;
	Fri, 18 Sep 2026 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763731; cv=none; b=gOp0wn1ZoCbDA3YnQ/3H19Bc6G98OQaYc9Zt6A5EVbBXRgsvlcNLiXrI2fwR9vG3KStfhp/NnwrXHJeFiRKqrAHIFSR8jgek7Ki7urF+du4/5PopG73b2IOEYbr5hAbN4l1dOf7dMAbFQvxZE00OlcoaDnpaQkpoC/PoR70K8RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763731; c=relaxed/simple;
	bh=qXeso4G9JOJSfSUyHMb0bEYqyspr0J0X6c8OuiOuc+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GWHVSghAFx0nL40HaFrRos2Q1mnzbJqjZIuA4lKJZ4zkeq9wCfxU8MPsnPyBt+0PH33tdsGkWafXVcGrQFKvzwv7a0IbUMKVnnfX66V+LlIBHHekm2Es4yhxfFmEK5TVjwYvOyGnd/BC6jl9a1UIYypeqI83Aab1u6GWIIpMYys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a1sbgYDQ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a1sbgYDQ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 74ECB1A099D;
	Fri, 18 Sep 2026 20:35:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 488AE60649;
	Fri, 18 Sep 2026 20:35:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 309CD1032907C;
	Fri, 18 Sep 2026 22:35:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789763722; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/mAkVh9vqUyP4Y71/1fJoyfrZD8rk6C0eOjg+j/FQBw=;
	b=a1sbgYDQ21K61aUfm3x5mp3Om9ainMMaCdQQi3sMa+nRCON/lAcbVB2WbUZyZKcqdFyg/k
	+J1l6qdaHM0YCDD9s+uUVvtvGZDx9/wU7an2rKRTRAemcTsq0y31Vi/GNu1wkcK1gRXJWv
	/5Zn+Nl2BPYG92Ct2onOS2l3wErEUescHDKcXgSSEXaW/AmgcKWN4LGLUafelGAkFR1xdr
	o19vQ2P/f5FQtRDjG3QBuINMYZRGjwaYG2efq02BY3HBwB29BLlahp5SJuosiQrrIh1IE9
	3Ijn/1jFTizvSxSVzZ/hx2ARyK/FJ1MIkI93kzKWGTpGJppfS0X9/4/VBORbZA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 18 Sep 2026 22:35:05 +0200
Subject: [PATCH net 2/3] net: macb: propagate RX ring refill errors
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260918-macb-close-v1-2-05e32ce98813@bootlin.com>
References: <20260918-macb-close-v1-0-05e32ce98813@bootlin.com>
In-Reply-To: <20260918-macb-close-v1-0-05e32ce98813@bootlin.com>
To: Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Antoine Tenart <atenart@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

gem_rx_refill() is responsible for Rx SKB allocation, including at open,
but its prototype indicates a void return value.

Therefore we change the code to propagate allocation and DMA mapping
errors back up the stack, making sure the open fails if it occurs.
Change all those to return errno-style ints:
 - gem_rx_refill()
 - its parent gem_init_rx_ring()
 - its grand-parent gem_init_rings()
 - the macbgem_ops.mog_init_rings function pointer
 - its grand-uncle macb_init_rings()

Theoretical bugfix, never encountered in practice. To reproduce,
introduce memory pressure (less than 512 SKBs of free memory) and open
the interface. I expect the last queue to be unuseable because it has
zero usable rx buffers. Nothing will ever trigger a refill on that
queue which only happens once a frame has been received.

Note that other callers of refill (resume, HRESP error task, NAPI)
cannot do anything useful with that error and keep their best-effort
refill, hoping it will improve.

Fixes: 4df95131ea80 ("net/macb: change RX path for GEM")
Cc: stable@vger.kernel.org
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |  2 +-
 drivers/net/ethernet/cadence/macb_main.c | 30 +++++++++++++++++++++++-------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index d6931c41f39d..cfaa0ca49f1a 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1197,7 +1197,7 @@ struct macb_queue;
 struct macb_or_gem_ops {
 	int	(*mog_alloc_rx_buffers)(struct macb *bp);
 	void	(*mog_free_rx_buffers)(struct macb *bp);
-	void	(*mog_init_rings)(struct macb *bp);
+	int	(*mog_init_rings)(struct macb *bp);
 	int	(*mog_rx)(struct macb_queue *queue, struct napi_struct *napi,
 			  int budget);
 };
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 751fa9e68099..c418f859cc34 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1486,13 +1486,14 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	return packets;
 }
 
-static void gem_rx_refill(struct macb_queue *queue)
+static int gem_rx_refill(struct macb_queue *queue)
 {
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
 	struct sk_buff *skb;
 	unsigned int entry;
 	dma_addr_t paddr;
+	int err = 0;
 
 	while (CIRC_SPACE(queue->rx_prepared_head, queue->rx_tail,
 			bp->rx_ring_size) > 0) {
@@ -1509,6 +1510,7 @@ static void gem_rx_refill(struct macb_queue *queue)
 			if (unlikely(!skb)) {
 				netdev_err(bp->netdev,
 					   "Unable to allocate sk_buff\n");
+				err = -ENOMEM;
 				break;
 			}
 
@@ -1518,6 +1520,7 @@ static void gem_rx_refill(struct macb_queue *queue)
 					       DMA_FROM_DEVICE);
 			if (dma_mapping_error(&bp->pdev->dev, paddr)) {
 				dev_kfree_skb(skb);
+				err = -ENOMEM;
 				break;
 			}
 
@@ -1558,6 +1561,8 @@ static void gem_rx_refill(struct macb_queue *queue)
 
 	netdev_vdbg(bp->netdev, "rx ring: queue: %p, prepared head %d, tail %d\n",
 		    queue, queue->rx_prepared_head, queue->rx_tail);
+
+	return err;
 }
 
 /* Mark DMA descriptors from begin up to and not including end as unused */
@@ -2783,7 +2788,7 @@ static int macb_alloc(struct macb *bp)
 	return -ENOMEM;
 }
 
-static void gem_init_rx_ring(struct macb_queue *queue)
+static int gem_init_rx_ring(struct macb_queue *queue)
 {
 	unsigned int i;
 
@@ -2793,14 +2798,16 @@ static void gem_init_rx_ring(struct macb_queue *queue)
 	for (i = 0; i < queue->bp->rx_ring_size; i++)
 		macb_rx_desc(queue, i)->addr |= MACB_BIT(RX_USED);
 
-	gem_rx_refill(queue);
+	return gem_rx_refill(queue);
 }
 
-static void gem_init_rings(struct macb *bp)
+static int gem_init_rings(struct macb *bp)
 {
 	struct macb_queue *queue;
 	struct macb_dma_desc *desc = NULL;
+	int last_err = 0;
 	unsigned int q;
+	int err;
 	int i;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
@@ -2813,11 +2820,15 @@ static void gem_init_rings(struct macb *bp)
 		queue->tx_head = 0;
 		queue->tx_tail = 0;
 
-		gem_init_rx_ring(queue);
+		err = gem_init_rx_ring(queue);
+		if (err)
+			last_err = err;
 	}
+
+	return last_err;
 }
 
-static void macb_init_rings(struct macb *bp)
+static int macb_init_rings(struct macb *bp)
 {
 	int i;
 	struct macb_dma_desc *desc = NULL;
@@ -2832,6 +2843,8 @@ static void macb_init_rings(struct macb *bp)
 	bp->queues[0].tx_head = 0;
 	bp->queues[0].tx_tail = 0;
 	desc->ctrl |= MACB_BIT(TX_WRAP);
+
+	return 0;
 }
 
 static void macb_reset_hw(struct macb *bp)
@@ -3162,7 +3175,9 @@ static int macb_open(struct net_device *netdev)
 		goto pm_exit;
 	}
 
-	bp->macbgem_ops.mog_init_rings(bp);
+	err = bp->macbgem_ops.mog_init_rings(bp);
+	if (err)
+		goto free_rings;
 	macb_init_buffers(bp);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
@@ -3200,6 +3215,7 @@ static int macb_open(struct net_device *netdev)
 		napi_disable(&queue->napi_rx);
 		napi_disable(&queue->napi_tx);
 	}
+free_rings:
 	macb_free(bp);
 pm_exit:
 	pm_runtime_put_sync(&bp->pdev->dev);

-- 
2.55.0

