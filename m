Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A084A92C8
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344813; cv=none; b=WM4o4nQ//SsiIS19JHFQ+mjmRJ22PFFZkDCJ4ydGnIW6X01ySi4Qy6NEAyVY6AbgLAAoxZtsh4zUHMZWj1+G2OZ2Y69guk7rO7uba4fdZlSJo5wOB9/y6ClnuiGAJ3zqygu2w7bIoB+a8x8gUgfCeHPemMjNpAJr8u0sCvl+eIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344813; c=relaxed/simple;
	bh=o6cJivv/VfQF33KG/q30DTCzJt3jsglm2Oj8tzgi5/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TNN9uxKh9SQeYPtX1PyaAQhsxP4VDYzTjqiKsp66OuRHaZIhqS986TRgcINSYkwCkkdDFIle//OH12VOLeUqHAfEUoXBT72IMSWELM6hlrWaioUKBZMt0XqdrzQS0pUPbpk8ske7+qpY4BXPxv6WBRHAaqhVYo61zOOtuAp7LZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Pp8szPut; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Pp8szPut"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 39992C653F6;
	Fri, 25 Sep 2026 14:00:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4C4906073B;
	Fri, 25 Sep 2026 14:00:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C3D30103294F6;
	Fri, 25 Sep 2026 15:59:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790344795; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kVReI9ke85UyIir8w2GPSE/VSeURL4Y7GpIiX34KEE0=;
	b=Pp8szPuta8jc1GXT2fQ450uuWBeThA8/GunqqEMrXpUA6nTb40MukUDGYuJ/VT1LItNw5d
	Sx9kr8+++fDh81DyU2AaRYS5W1Ck9eZdKaGQSbe1LgIRvwi0fObvgw3lzDaFbtpkMK7y2f
	R48+hpK5MBy1uaOQTkrlq/XmF4m0d7o6AyDUdh5T35rfk1vwMgE6KFd5E3Y20soDk63S4b
	DuKEVwzKEMxvS37N+FZ+kJvZC+A8+lMDAd308iO9OnnJIz62udjC889F+u6hZuZbSrvtu4
	gBZN+CLvJRfj60UmZK0kinY8mfuSYLD1mQgFWiV0S8SxPLh4tvy8OKTJJ8So6w==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 25 Sep 2026 15:59:35 +0200
Subject: [PATCH net v2 2/3] net: macb: propagate RX ring refill errors
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260925-macb-close-v2-2-360efa565914@bootlin.com>
References: <20260925-macb-close-v2-0-360efa565914@bootlin.com>
In-Reply-To: <20260925-macb-close-v2-0-360efa565914@bootlin.com>
To: Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Antoine Tenart <atenart@kernel.org>, Eric Dumazet <edumazet@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Russell King <linux@armlinux.org.uk>
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
errors back up the stack, making sure the open fails if no descriptors
were allocated. Change all those to return errno-style ints:
 - gem_rx_refill()
 - its parent gem_init_rx_ring()
 - its grand-parent gem_init_rings()
 - the macbgem_ops.mog_init_rings function pointer
 - its grand-uncle macb_init_rings()

We tolerate some allocation failures: we accept running with the rx ring
only partially filled with successful descriptors. It is important we
refuse the zero-valid-descriptor case: nothing would ever trigger a
refill, which only happens once a frame has been received.

Theoretical bugfix, never encountered in practice. To reproduce,
introduce memory pressure (less than 512 SKBs of free memory) and open
the interface. I expect the last queue to be unusable because it has
zero usable rx buffers.

Note that other callers of refill (resume, HRESP error task, NAPI)
cannot do anything useful with that error and keep their best-effort
refill, hoping it will improve.

Fixes: 4df95131ea80 ("net/macb: change RX path for GEM")
Cc: stable@vger.kernel.org
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |  2 +-
 drivers/net/ethernet/cadence/macb_main.c | 33 +++++++++++++++++++++++++-------
 2 files changed, 27 insertions(+), 8 deletions(-)

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
index 7f25574928d7..18a1b5f7ad91 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1486,7 +1486,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	return packets;
 }
 
-static void gem_rx_refill(struct macb_queue *queue)
+static int gem_rx_refill(struct macb_queue *queue)
 {
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
@@ -1558,6 +1558,14 @@ static void gem_rx_refill(struct macb_queue *queue)
 
 	netdev_vdbg(bp->netdev, "rx ring: queue: %p, prepared head %d, tail %d\n",
 		    queue, queue->rx_prepared_head, queue->rx_tail);
+
+	/* Fail if queue has zero prepared descriptors. This is critical because
+	 * nothing will ever trigger a refill again.
+	 */
+	if (queue->rx_prepared_head == queue->rx_tail)
+		return -ENOMEM;
+
+	return 0;
 }
 
 /* Mark DMA descriptors from begin up to and not including end as unused */
@@ -2804,7 +2812,7 @@ static int macb_alloc(struct macb *bp)
 	return -ENOMEM;
 }
 
-static void gem_init_rx_ring(struct macb_queue *queue)
+static int gem_init_rx_ring(struct macb_queue *queue)
 {
 	unsigned int i;
 
@@ -2814,14 +2822,16 @@ static void gem_init_rx_ring(struct macb_queue *queue)
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
@@ -2834,11 +2844,15 @@ static void gem_init_rings(struct macb *bp)
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
@@ -2853,6 +2867,8 @@ static void macb_init_rings(struct macb *bp)
 	bp->queues[0].tx_head = 0;
 	bp->queues[0].tx_tail = 0;
 	desc->ctrl |= MACB_BIT(TX_WRAP);
+
+	return 0;
 }
 
 static void macb_reset_hw(struct macb *bp)
@@ -3183,7 +3199,9 @@ static int macb_open(struct net_device *netdev)
 		goto pm_exit;
 	}
 
-	bp->macbgem_ops.mog_init_rings(bp);
+	err = bp->macbgem_ops.mog_init_rings(bp);
+	if (err)
+		goto free_rings;
 	macb_init_buffers(bp);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
@@ -3221,6 +3239,7 @@ static int macb_open(struct net_device *netdev)
 		napi_disable(&queue->napi_rx);
 		napi_disable(&queue->napi_tx);
 	}
+free_rings:
 	macb_free(bp);
 pm_exit:
 	pm_runtime_put_sync(&bp->pdev->dev);

-- 
2.55.0

