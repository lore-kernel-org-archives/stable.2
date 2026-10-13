Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154B53FA5C4
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902375; cv=none; b=R0VAAWS6bYiJ067mepZyiFMg0vHqfx3hOuo833FkrC1vRFMY/F5/cKDYCrdNA0M4M/oBAFEA0Kndrv7yy+sVNBj1rWld4zISDGaBVqRFFDjNZIVjx35Z8WnyuqzArZVIsOSwO6b5+VsSPdcWnFb+yTdF1lbyrd0Dv4xhIAnSFrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902375; c=relaxed/simple;
	bh=BLFxR1a5VrO+qQGU2eoqQL/pZTgHI+4BXkTKzVZAkaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qq9ouajclS3cStz9XBgXdL5Yv9UAeN0/tE+VAdFJGFEW9Qprv2la1A70Lv36Mw9SndR0Ywq6PV6NrCfTzWrVXNXcP4XSlbM7U+kE7HgufZ9aNzgmuKDoCffcj2K26Eb1nY15jgoCZ62vG63N1beyyLvtK4mDikgPPK7lmTTypB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvSfJeHK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvSfJeHK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8EC1F000FF;
	Tue, 13 Oct 2026 14:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791902373;
	bh=UEAGAMMJB2vyN9TOZ4fgo6AWHi24a1s5NXq4JvmSGu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WvSfJeHK/9nkhqzuK60F4vbayTT2GpwZ4idUnQsdPOkSAXhoPPgEyS/E2+8qkjaJx
	 A67vju+9wTRW1Ct9qSB3ooXGP2YFpZEu5O+uhCeM/K0U07j5JApl/JoMCb8o/lJ5Sd
	 fQi0nz52lxHWNnd09ItOkeBeyZ4Acd3GpWt+kb08vrNN60M6oKRVRZhTZLTYOwM3df
	 shXKM7WwMUlAr044SP9AC1x5zH10V7W/3f5/Y2XA2nn1tl/SPhmFiW7aKmhpE9iAvN
	 nsHFZcC92bstSl3z+qtMbIkl+bcJp1x52KUsWm80+/hnQrCu3Uy90s6NeVCoTQlhyd
	 4M5mAxatXol6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Suraj Gupta <suraj.gupta2@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] net: xilinx: axienet: Free outstanding DMA buffers on dmaengine stop
Date: Tue, 13 Oct 2026 10:39:31 -0400
Message-ID: <20261013143852.4045066-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101248-aerospace-flatly-8c3f@gregkh>
References: <2026101248-aerospace-flatly-8c3f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Suraj Gupta <suraj.gupta2@amd.com>

[ Upstream commit bcf2573a68a808a5b54cadafa72b6672e662c2bf ]

In the dmaengine path the driver pre-submits RX buffers and holds
in-flight TX buffers whose SKBs are DMA-mapped by the driver and freed
only in the completion callbacks. On ndo_stop() dmaengine_terminate_sync()
aborts these descriptors without running their callbacks, and the driver
then frees only the ring shells, leaking every SKB still owned by the
engine and its DMA mapping on each ifdown. With 128 RX buffers pre-posted
per channel, the mapping leak can eventually exhaust a limited IOMMU
aperture.

Clear the slot's skb in the TX and RX callbacks so a non-NULL skb marks a
slot that still owns a live, DMA-mapped buffer, and on stop unmap and free
every such buffer.

axienet_dma_rx_cb() runs from the DMA tasklet and re-arms the RX ring on
each completion, so it can race axienet_stop(): a completion may submit a
fresh buffer after dmaengine_terminate_sync() has returned, leaving the
channel armed with a buffer the teardown then frees while the engine may
still write into it (dma_release_channel() does not stop it either). Add a
lock that axienet_dma_rx_cb() holds across the @stopping check and the
resubmit, and axienet_stop() holds to set @stopping before terminating.
Once @stopping is set no callback can arm a new buffer, and any armed just
before is aborted by the terminate, so teardown only frees buffers the
engine no longer owns.

Fixes: 6a91b846af85 ("net: axienet: Introduce dmaengine support")
Cc: stable@vger.kernel.org
Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
Link: https://patch.msgid.link/20260928184207.2361931-1-suraj.gupta2@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: Adjusted context to retain kcalloc() instead of upstream’s kzalloc_objs(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  7 ++-
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 51 +++++++++++++++----
 2 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index fcd3aaef27fc3..c63d99686d0ba 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -523,8 +523,9 @@ struct skbuf_dma_descriptor {
  * @stats_work: Work for reading the hardware statistics counters often enough
  *              to catch overflows.
  * @dma_err_task: Work structure to process Axi DMA errors
- * @stopping:   Set when @dma_err_task shouldn't do anything because we are
- *              about to stop the device.
+ * @stopping:   Set when we are about to stop the device: makes @dma_err_task
+ *              a no-op (legacy DMA path) and fences RX descriptor
+ *              resubmission in axienet_dma_rx_cb() (dmaengine path).
  * @tx_irq:	Axidma TX IRQ number
  * @rx_irq:	Axidma RX IRQ number
  * @eth_irq:	Ethernet core IRQ number
@@ -545,6 +546,7 @@ struct skbuf_dma_descriptor {
  * @tx_ring_tail: TX skb ring buffer tail index.
  * @rx_ring_head: RX skb ring buffer head index.
  * @rx_ring_tail: RX skb ring buffer tail index.
+ * @rx_submit_lock: Protects RX ring resubmission vs teardown in dmaengine path.
  */
 struct axienet_local {
 	struct net_device *ndev;
@@ -626,6 +628,7 @@ struct axienet_local {
 	int tx_ring_tail;
 	int rx_ring_head;
 	int rx_ring_tail;
+	spinlock_t rx_submit_lock;
 };
 
 /**
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index eefe54ce66852..50ddc7c53b630 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -881,6 +881,7 @@ static void axienet_dma_tx_cb(void *data, const struct dmaengine_result *result)
 	u64_stats_update_end(&lp->tx_stat_sync);
 	dma_unmap_sg(lp->dev, skbuf_dma->sgl, skbuf_dma->sg_len, DMA_TO_DEVICE);
 	dev_consume_skb_any(skbuf_dma->skb);
+	skbuf_dma->skb = NULL;
 	netif_txq_completed_wake(txq, 1, len,
 				 CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX),
 				 2);
@@ -1171,6 +1172,7 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
 						       &meta_max_len);
 	dma_unmap_single(lp->dev, skbuf_dma->dma_address, lp->max_frm_size,
 			 DMA_FROM_DEVICE);
+	skbuf_dma->skb = NULL;
 
 	if (IS_ERR(app_metadata)) {
 		if (net_ratelimit())
@@ -1193,10 +1195,17 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
 	u64_stats_update_end(&lp->rx_stat_sync);
 
 rx_submit:
+	spin_lock(&lp->rx_submit_lock);
+	if (lp->stopping) {
+		spin_unlock(&lp->rx_submit_lock);
+		return;
+	}
+
 	for (i = 0; i < CIRC_SPACE(lp->rx_ring_head, lp->rx_ring_tail,
 				   RX_BUF_NUM_DEFAULT); i++)
 		axienet_rx_submit_desc(lp->ndev);
 	dma_async_issue_pending(lp->rx_chan);
+	spin_unlock(&lp->rx_submit_lock);
 }
 
 /**
@@ -1541,6 +1550,7 @@ static int axienet_init_dmaengine(struct net_device *ndev)
 	lp->tx_ring_head = 0;
 	lp->rx_ring_tail = 0;
 	lp->rx_ring_head = 0;
+	lp->stopping = false;
 	lp->tx_skb_ring = kcalloc(TX_BD_NUM_MAX, sizeof(*lp->tx_skb_ring),
 				  GFP_KERNEL);
 	if (!lp->tx_skb_ring) {
@@ -1754,20 +1764,42 @@ static int axienet_stop(struct net_device *ndev)
 		free_irq(lp->rx_irq, ndev);
 		axienet_dma_bd_release(ndev);
 	} else {
+		struct skbuf_dma_descriptor *skbuf_dma;
+
+		spin_lock_bh(&lp->rx_submit_lock);
+		lp->stopping = true;
+		spin_unlock_bh(&lp->rx_submit_lock);
+
 		dmaengine_terminate_sync(lp->tx_chan);
-		dmaengine_synchronize(lp->tx_chan);
 		dmaengine_terminate_sync(lp->rx_chan);
-		dmaengine_synchronize(lp->rx_chan);
-
-		for (i = 0; i < TX_BD_NUM_MAX; i++)
-			kfree(lp->tx_skb_ring[i]);
-		kfree(lp->tx_skb_ring);
-		for (i = 0; i < RX_BUF_NUM_DEFAULT; i++)
-			kfree(lp->rx_skb_ring[i]);
-		kfree(lp->rx_skb_ring);
 
 		dma_release_channel(lp->rx_chan);
 		dma_release_channel(lp->tx_chan);
+
+		/* Unmap and free any buffer the terminate did not reclaim, so it
+		 * is not leaked; a non-NULL skb marks such a slot.
+		 */
+		for (i = 0; i < TX_BD_NUM_MAX; i++) {
+			skbuf_dma = lp->tx_skb_ring[i];
+			if (skbuf_dma && skbuf_dma->skb) {
+				dma_unmap_sg(lp->dev, skbuf_dma->sgl,
+					     skbuf_dma->sg_len, DMA_TO_DEVICE);
+				dev_kfree_skb_any(skbuf_dma->skb);
+			}
+			kfree(skbuf_dma);
+		}
+		kfree(lp->tx_skb_ring);
+
+		for (i = 0; i < RX_BUF_NUM_DEFAULT; i++) {
+			skbuf_dma = lp->rx_skb_ring[i];
+			if (skbuf_dma && skbuf_dma->skb) {
+				dma_unmap_single(lp->dev, skbuf_dma->dma_address,
+						 lp->max_frm_size, DMA_FROM_DEVICE);
+				dev_kfree_skb_any(skbuf_dma->skb);
+			}
+			kfree(skbuf_dma);
+		}
+		kfree(lp->rx_skb_ring);
 	}
 
 	netdev_reset_queue(ndev);
@@ -3060,6 +3092,7 @@ static int axienet_probe(struct platform_device *pdev)
 
 	spin_lock_init(&lp->rx_cr_lock);
 	spin_lock_init(&lp->tx_cr_lock);
+	spin_lock_init(&lp->rx_submit_lock);
 	INIT_WORK(&lp->rx_dim.work, axienet_rx_dim_work);
 	lp->rx_dim_enabled = true;
 	lp->rx_dim.profile_ix = 1;
-- 
2.53.0

