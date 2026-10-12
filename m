Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEBB48F827
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817013; cv=none; b=a8X74HAi2c7bD3j2ocQzpkJsjnNtSoYbBYwGJMNDOAQNxA1DSvhdMjSxyay8Wr1pN1W5Z75oNOsUjBye4+z0bG3O+5vrQ4tIg1dLSEXxpf9gzcPwI7P8zECeEJQt0JiRRBuYlk7Ln1RJg9tUkQ0mbNuP+5hSvOxpcWfYHymWF9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817013; c=relaxed/simple;
	bh=i3PENDnt6IhqPnrvgnNU36uIC6dpm9VwSxUVQOrQCLU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kbtO8braJe8iC+Np8snTcI6if4Gt2kxwDeOvSP4i0m/4ld1yK0wxZbMmIYStVgnnynYKM6+T6QEjSiyCkTTqkVk6suAxOI8LIbGBtXZ42MxrrLBS03cOJaBsXUiixXALO5UjeROFJ7vm6wbMGdXDUp7L+F5KTAcNJtz1vNF9wVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RslF5tsz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RslF5tsz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AB41F0089B;
	Mon, 12 Oct 2026 14:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791817011;
	bh=s/Fs4rbuZbJV/CcD2MgojVaTtIfNuSJxQNY/euDdc1k=;
	h=Subject:To:Cc:From:Date;
	b=RslF5tsz1pCmkx91G/gdNkjxtCBDgY1Dgl5UCXTGb1O1AyxPDXUN/CPtdcORSmz2J
	 75HX9VdRa8cM0nwvWwBFBKvj9sN5nOLdeYM4xB4aCUuok0LEG6Qb+z6EObDbUrjPIl
	 lYXoiBCCUs+fRcxb/xCvJ0fmsSHzIoZoo2g1dueA=
Subject: FAILED: patch "[PATCH] net: xilinx: axienet: Free outstanding DMA buffers on" failed to apply to 6.12-stable tree
To: suraj.gupta2@amd.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 16:56:48 +0200
Message-ID: <2026101248-endanger-limpness-b70f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x bcf2573a68a808a5b54cadafa72b6672e662c2bf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101248-endanger-limpness-b70f@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bcf2573a68a808a5b54cadafa72b6672e662c2bf Mon Sep 17 00:00:00 2001
From: Suraj Gupta <suraj.gupta2@amd.com>
Date: Tue, 29 Sep 2026 00:12:07 +0530
Subject: [PATCH] net: xilinx: axienet: Free outstanding DMA buffers on
 dmaengine stop

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

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index fcd3aaef27fc..c63d99686d0b 100644
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
index 1722b7038f34..09443623a3e2 100644
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
 	lp->tx_skb_ring = kzalloc_objs(*lp->tx_skb_ring, TX_BD_NUM_MAX);
 	if (!lp->tx_skb_ring) {
 		ret = -ENOMEM;
@@ -1752,20 +1762,42 @@ static int axienet_stop(struct net_device *ndev)
 		free_irq(lp->rx_irq, ndev);
 		axienet_dma_bd_release(ndev);
 	} else {
-		dmaengine_terminate_sync(lp->tx_chan);
-		dmaengine_synchronize(lp->tx_chan);
-		dmaengine_terminate_sync(lp->rx_chan);
-		dmaengine_synchronize(lp->rx_chan);
+		struct skbuf_dma_descriptor *skbuf_dma;
 
-		for (i = 0; i < TX_BD_NUM_MAX; i++)
-			kfree(lp->tx_skb_ring[i]);
-		kfree(lp->tx_skb_ring);
-		for (i = 0; i < RX_BUF_NUM_DEFAULT; i++)
-			kfree(lp->rx_skb_ring[i]);
-		kfree(lp->rx_skb_ring);
+		spin_lock_bh(&lp->rx_submit_lock);
+		lp->stopping = true;
+		spin_unlock_bh(&lp->rx_submit_lock);
+
+		dmaengine_terminate_sync(lp->tx_chan);
+		dmaengine_terminate_sync(lp->rx_chan);
 
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
@@ -3065,6 +3097,7 @@ static int axienet_probe(struct platform_device *pdev)
 
 	spin_lock_init(&lp->rx_cr_lock);
 	spin_lock_init(&lp->tx_cr_lock);
+	spin_lock_init(&lp->rx_submit_lock);
 	INIT_WORK(&lp->rx_dim.work, axienet_rx_dim_work);
 	lp->rx_dim_enabled = true;
 	lp->rx_dim.profile_ix = 1;

