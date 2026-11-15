Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794743290;
	b=Swuj3qoAtPsorb9sw3UVk10ODQQnsKUfCk+jx1NVZX7kqZCVWFI/BkZQt8nGCruMQlx4
	 CvRGJ0MzU6CyhFVfRV91u2RG+YBdM3YrUflj2r6sMRVO9IX0aZSsry5vJzEYFkX3aE57a
	 us/MHStS3g1Bxv7ujb9BpHyaNQ+qYdEpqDRrKmw7dsJshdCKFXfWWc9cQfTOg6tnmiwY2
	 0c8QoHBYl5ehh2ZcMqWYkBsftOnHmh4jNVqtNyojhrUdsinVqzrvDk1UyEvOkvsMa4IOY
	 XMbzgtQXsGcEpnVPl0bsz9QVfGiQyqbDJf5CrYv03hTFzobtC3mFBz7fgQwQABfC0vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743290;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=/D7tIxsT4IR1YwrCz/NcocODzdYpSRSpzVxJ8FTgUhI=;
	b=tsj4HxUrZ3nuGSvFTPqVjJV/XV/XQGIDhywaukLkwsWOqK4iRkWFHOmY3orU8R+mGvLq
	 Um6X7JidlpVUfyxG6FIBaFOigEUCRqZzcgQCMycOtQXRyKulANYa7pSqUua6P/khD3j8h
	 EHqnpx+DY+ZtyGCvpHPwSS56cXCz763tEFxw1JehUh5DEe8sdszHHGztyY1ZvgtNa2Q8+
	 HUH8yxHN0BhZ3d4B8LFLKC5zcpiwlJY1H2X7jZulyQEIlQsCKFbPVfi11Vh8jpbhnBiaq
	 qAeVhP2j4lVBohR5knA8pwX+RrCR08v0aWRbe0RXQMPpDIpLZp9tIaBFBQyrHSvIgXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=ighMaP15;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AF760A2622;
	Sun, 15 Nov 2026 11:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9AF760A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=ighMaP15
Received: from [192.168.17.1] (unknown [124.79.98.159])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54b7e04ee;
	Sun, 15 Nov 2026 19:48:04 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Stephan Gerhold <stephan@gerhold.net>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David S. Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v6 3/3] net: wwan: qcom_bam_dmux: stop state publishers
 before remove
Date: Sun, 15 Nov 2026 19:48:02 +0800
Message-ID: <179474328234.103840.17148768812628919135@seu.edu.cn>
In-Reply-To: <179474327647.103840.9539614513141118915@seu.edu.cn>
References: <179474327647.103840.9539614513141118915@seu.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa1df0934af03a1kunmbac61c98bf7ad
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTBlNVh4eGkkdHk8YSkpDGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VTEJVQkNVSk5CWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	JKVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=ighMaP15k99hb75WLGZg5n97055WxUKlJ/5ZBpsALoA/EGP71sGqCnTWC0DA6Zesj7U1idRdsDxsSNBEI5qs9/M2Q34n8v4jiqZ/g+v7t/IrcV07KVYSslcRUo+jL4LtLR0jJ8G2em/KCz/pZ413yilp+mrUG8RBhqFMlroV7MA=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=/D7tIxsT4IR1YwrCz/NcocODzdYpSRSpzVxJ8FTgUhI=;
	h=date:mime-version:subject:message-id:from;

The RX callback can process another OPEN command after the removal path
has cancelled register_netdev_work, allowing a late registration to
outlive the devm-managed DMUX. It can also inspect netdev state while
those netdevs are being unregistered. PC-ack remains live past the final
PC shutdown.

Set a removal gate under the RX callback lock, then permanently disable
and drain registration work before unregistering interfaces. Continue to
recycle RX buffers until normal power shutdown so ndo_stop can still
send its CLOSE command. Drain PC-ack as well as PC before the final
power cleanup. This separates the removal fix from the normal power-
control state change.

Found by the author's in-house static analysis tool.

Fixes: 21a0ffd9b38c ("net: wwan: Add Qualcomm BAM-DMUX WWAN network driver")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/30dc9ad2-0ff7-4d97-8b01-ab2267fb56b8@redhat.com/
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Zehao Gao <gaozehao@iie.ac.cn>
---

Discovery: found by the author's in-house static analysis tool.

 drivers/net/wwan/qcom_bam_dmux.c | 102 ++++++++++++-------------------
 1 file changed, 40 insertions(+), 62 deletions(-)

diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
index 48ad1bc..b83cb51 100644
--- a/drivers/net/wwan/qcom_bam_dmux.c
+++ b/drivers/net/wwan/qcom_bam_dmux.c
@@ -88,6 +88,7 @@ struct bam_dmux {
 	struct dma_chan *rx, *tx;
 	spinlock_t rx_lock; /* Protect RX callbacks against shutdown */
 	bool rx_active;
+	bool removing; /* Protected by rx_lock */
 	struct bam_dmux_skb_dma rx_skbs[BAM_DMUX_NUM_SKB];
 	struct bam_dmux_skb_dma tx_skbs[BAM_DMUX_NUM_SKB];
 	spinlock_t tx_lock; /* Protect tx_skbs, tx_next_skb */
@@ -491,65 +492,25 @@ static void bam_dmux_register_netdev_work(struct work_struct *work)
 	}
 }
 
-static void bam_dmux_rx_callback(void *data)
+static void bam_dmux_rx_callback(void *data);
+
+static bool bam_dmux_skb_dma_submit_rx(struct bam_dmux_skb_dma *skb_dma)
 {
-	struct bam_dmux_skb_dma *skb_dma = data;
 	struct bam_dmux *dmux = skb_dma->dmux;
-	struct bam_dmux_hdr *hdr;
-	struct sk_buff *skb;
-	unsigned long flags;
-
-	spin_lock_irqsave(&dmux->rx_lock, flags);
-	if (!dmux->rx_active) {
-		spin_unlock_irqrestore(&dmux->rx_lock, flags);
-		return;
-	}
-
-	skb = skb_dma->skb;
-	hdr = (struct bam_dmux_hdr *)skb->data;
-	bam_dmux_skb_dma_unmap(skb_dma, DMA_FROM_DEVICE);
-	if (dmux->removing) {
-		spin_unlock_irqrestore(&dmux->rx_lock, flags);
-		goto requeue;
-	}
-	spin_unlock_irqrestore(&dmux->rx_lock, flags);
-
-	if (hdr->magic != BAM_DMUX_HDR_MAGIC) {
-		dev_err(dmux->dev, "Invalid magic in header: %#x\n", hdr->magic);
-		goto requeue;
-	}
-
-	if (hdr->ch >= BAM_DMUX_NUM_CH) {
-		dev_dbg(dmux->dev, "Unsupported channel: %u\n", hdr->ch);
-		goto requeue;
-	}
+	struct dma_async_tx_descriptor *desc;
 
-	switch (hdr->cmd) {
-	case BAM_DMUX_CMD_DATA:
-		bam_dmux_cmd_data(skb_dma);
-		break;
-	case BAM_DMUX_CMD_OPEN:
-		bam_dmux_cmd_open(dmux, hdr);
-		break;
-	case BAM_DMUX_CMD_CLOSE:
-		bam_dmux_cmd_close(dmux, hdr);
-		break;
-	default:
-		dev_err(dmux->dev, "Unsupported command %u on channel %u\n",
-			hdr->cmd, hdr->ch);
-		break;
+	desc = dmaengine_prep_slave_single(dmux->rx, skb_dma->addr,
+					   skb_dma->skb->len, DMA_DEV_TO_MEM,
+					   DMA_PREP_INTERRUPT);
+	if (!desc) {
+		dev_err(dmux->dev, "Failed to prepare RX DMA buffer\n");
+		return false;
 	}
 
-requeue:
-	/*
-	 * Recheck the gate: power-off may have stopped refill while the
-	 * command was dispatched without the lock.
-	 */
-	spin_lock_irqsave(&dmux->rx_lock, flags);
-	if (dmux->rx_active &&
-	    bam_dmux_skb_dma_queue_rx(skb_dma, GFP_ATOMIC))
-		dma_async_issue_pending(dmux->rx);
-	spin_unlock_irqrestore(&dmux->rx_lock, flags);
+	desc->callback = bam_dmux_rx_callback;
+	desc->callback_param = skb_dma;
+	desc->cookie = dmaengine_submit(desc);
+	return true;
 }
 
 static bool bam_dmux_skb_dma_queue_rx(struct bam_dmux_skb_dma *skb_dma, gfp_t gfp)
@@ -648,21 +609,28 @@ static void bam_dmux_rx_callback(void *data)
 	unsigned long flags;
 
 	spin_lock_irqsave(&dmux->rx_lock, flags);
-	if (!dmux->rx_active)
-		goto out_unlock;
+	if (!dmux->rx_active) {
+		spin_unlock_irqrestore(&dmux->rx_lock, flags);
+		return;
+	}
 
 	skb = skb_dma->skb;
 	hdr = (struct bam_dmux_hdr *)skb->data;
 	bam_dmux_skb_dma_unmap(skb_dma, DMA_FROM_DEVICE);
+	if (dmux->removing) {
+		spin_unlock_irqrestore(&dmux->rx_lock, flags);
+		goto requeue;
+	}
+	spin_unlock_irqrestore(&dmux->rx_lock, flags);
 
 	if (hdr->magic != BAM_DMUX_HDR_MAGIC) {
 		dev_err(dmux->dev, "Invalid magic in header: %#x\n", hdr->magic);
-		goto out;
+		goto requeue;
 	}
 
 	if (hdr->ch >= BAM_DMUX_NUM_CH) {
 		dev_dbg(dmux->dev, "Unsupported channel: %u\n", hdr->ch);
-		goto out;
+		goto requeue;
 	}
 
 	switch (hdr->cmd) {
@@ -681,10 +649,15 @@ static void bam_dmux_rx_callback(void *data)
 		break;
 	}
 
-out:
-	if (bam_dmux_skb_dma_queue_rx(skb_dma, GFP_ATOMIC))
+requeue:
+	/*
+	 * Recheck the gate: power-off may have stopped refill while the
+	 * command was dispatched without the lock.
+	 */
+	spin_lock_irqsave(&dmux->rx_lock, flags);
+	if (dmux->rx_active &&
+	    bam_dmux_skb_dma_queue_rx(skb_dma, GFP_ATOMIC))
 		dma_async_issue_pending(dmux->rx);
-out_unlock:
 	spin_unlock_irqrestore(&dmux->rx_lock, flags);
 }
 
@@ -1077,8 +1050,12 @@ static void bam_dmux_remove(struct platform_device *pdev)
 	LIST_HEAD(list);
 	int i;
 
+	/* Stop RX publication before unregistering any network interface. */
+	scoped_guard(spinlock_irqsave, &dmux->rx_lock)
+		dmux->removing = true;
+	disable_work_sync(&dmux->register_netdev_work);
+
 	/* Unregister network interfaces */
-	cancel_work_sync(&dmux->register_netdev_work);
 	rtnl_lock();
 	for (i = 0; i < BAM_DMUX_NUM_CH; ++i)
 		if (dmux->netdevs[i])
@@ -1099,6 +1076,7 @@ static void bam_dmux_remove(struct platform_device *pdev)
 		dev_err(dev, "Timed out waiting for remote side to suspend\n");
 
 	/* Make sure everything is cleaned up before we return */
+	disable_irq(dmux->pc_ack_irq);
 	disable_irq(dmux->pc_irq);
 	mutex_lock(&dmux->power_lock);
 	bam_dmux_power_off(dmux);
-- 
2.50.1.windows.1
