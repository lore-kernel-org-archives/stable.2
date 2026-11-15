Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794743285;
	b=CtIXlt8m8H+83Y56j2ioC8putPP588RIrhT2Jv4GnnQc84kpN9j/ljUofHkXGAKDZLJH
	 /VQ3uZ5xsxAEwpq4ivTCHCiZuVuQQolc84M0YOShstJTP1kebwgS9UtsbOio6X+n7gDxH
	 nC9ZUj6gLnGQeR1OcvBqJ5a9bxBCvidTA1bSQKyCpJp0gcDuzUJGrRHFYOOLguhqT99Hy
	 g8rWmv4kVeSV0YAkgq4dhvAfNI5QBmTQvwHeGwWB3PhtmhoFaMmsPhtlB1FI7gf8FE+tK
	 RjQANLS/7eOURCn7X0pi4d2n9VsEErTAIUYS5FlzbmGfmwMBXrqTzoMSVAjWoo+Xz/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743285;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=Q7p+k82rUA2OsopQlg7GMQsuEU8vxDLBlk9pcfSPr6U=;
	b=1ISgwzzcpHHUdk3lhCID3m5XpFzCXjNKVm2eu9jcyb8Xz8LjUIQ/PM9sop4UU8TgxyNp
	 3gc76yn6n5R6JQ4JR/8dCJcM8mXKaTGgfKIpYF+zji9BQQ9kBuSr/6rGbemsILcZLzZR5
	 jgbuEyGMkzE5+8QLIpL+flepi1TaPSmOS6ppmlQdi/8GGAVifBJ8nTZcgWIl0EFz6NlvK
	 Sz99kBy5CFFKUsKRTTjHX9ZsUuvOBD2vUIELQ+HBNk/SNUhO8VUBvgAjQYS1G6rTiNXry
	 3Br7WmIyXGfwnBHY7gmOK74udI8jjYA9K1cXqH9+1nkzetEuByl9kFyUG6lMd4rCrbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=EAfImHd2;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0562606A33A;
	Sun, 15 Nov 2026 11:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0562606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=EAfImHd2
Received: from [192.168.17.1] (unknown [124.79.98.159])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54b7e04e0;
	Sun, 15 Nov 2026 19:47:54 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject:
 [PATCH net v2] net: calxeda: disable timeout work across ring teardown
Date: Sun, 15 Nov 2026 19:47:51 +0800
Message-ID: <179474327156.103840.6542933288446718978@seu.edu.cn>
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
X-HM-Tid: 0aa1df090a9103a1kunmbac61c98bf789
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGUtNVktCTk8aTxpJS0lMTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VTEJVQkNVSk5CWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	JKVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=EAfImHd2SkOF6cjcbQ9LkzQ/XfN2Wn6GW1H6vYaTOEH29uVA8x6ns9U0YfZUYKwkZ8kDxrF2vc6YHNNVo9VMTWq9DHmIGbLHhubd/OnNWDDWqjJ/ssbLuhm/H1nq4nQpDpBrbCqIyaRyepb9EZHy4C6oWOpcnsGZMLJgrwHAC34=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Q7p+k82rUA2OsopQlg7GMQsuEU8vxDLBlk9pcfSPr6U=;
	h=date:mime-version:subject:message-id:from;

Both the watchdog and the TPS interrupt can queue timeout work. A simple
cancel cannot exclude them during a direct MTU stop/open cycle, and
waiting for the worker after disabling NAPI can deadlock on a second
napi_disable.

Initialize timeout work disabled, enable it only after ring allocation and
NAPI initialization, and disable and drain it before stopping NAPI. Keep
the NAPI-before-TX-disable order so neither a poll nor the recovery worker
can wake TX after its final shutdown. Synchronize the IRQ and re-mask it
after NAPI has stopped, and perform a final work drain before freeing
private state.

Track allocated rings and NAPI enablement explicitly, and give interface
down and system suspend separate references on the work disable counter.
Each path then disables once and enables once, so a concurrent suspend and
ifdown cannot leave the recovery work disabled forever. A failed MTU
reopen must not disable NAPI or work a second time, or free ring pointers
left by a failed allocation.

Found by the author's in-house static analysis tool.

Fixes: 85c10f282861 ("net: add calxeda xgmac ethernet driver")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260928134115.1957-1-getshell@seu.edu.cn/
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Zehao Gao <gaozehao@iie.ac.cn>
---

Discovery: found by the author's in-house static analysis tool.

 drivers/net/ethernet/calxeda/xgmac.c | 60 +++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/calxeda/xgmac.c b/drivers/net/ethernet/calxeda/xgmac.c
index a2410fb..61ffdbe 100644
--- a/drivers/net/ethernet/calxeda/xgmac.c
+++ b/drivers/net/ethernet/calxeda/xgmac.c
@@ -380,6 +380,10 @@ struct xgmac_priv {
 	char tx_pause;
 	int wolopts;
 	struct work_struct tx_timeout_work;
+	bool rings_ready;
+	bool napi_enabled;
+	bool work_disabled_down;
+	bool work_disabled_pm;
 };
 
 /* XGMAC Configuration Settings */
@@ -1027,6 +1031,12 @@ static int xgmac_open(struct net_device *dev)
 	xgmac_mac_enable(ioaddr);
 
 	napi_enable(&priv->napi);
+	priv->napi_enabled = true;
+	priv->rings_ready = true;
+	if (priv->work_disabled_down) {
+		enable_work(&priv->tx_timeout_work);
+		priv->work_disabled_down = false;
+	}
 	netif_start_queue(dev);
 
 	/* Enable interrupts */
@@ -1046,9 +1056,21 @@ static int xgmac_stop(struct net_device *dev)
 {
 	struct xgmac_priv *priv = netdev_priv(dev);
 
-	if (readl(priv->base + XGMAC_DMA_INTR_ENA))
+	if (!priv->rings_ready)
+		return 0;
+
+	if (!priv->work_disabled_down) {
+		disable_work_sync(&priv->tx_timeout_work);
+		priv->work_disabled_down = true;
+	}
+	if (priv->napi_enabled) {
 		napi_disable(&priv->napi);
+		priv->napi_enabled = false;
+	}
 
+	writel(0, priv->base + XGMAC_DMA_INTR_ENA);
+	synchronize_irq(dev->irq);
+	/* An in-flight interrupt may have restored the interrupt mask. */
 	writel(0, priv->base + XGMAC_DMA_INTR_ENA);
 
 	netif_tx_disable(dev);
@@ -1058,6 +1080,7 @@ static int xgmac_stop(struct net_device *dev)
 
 	/* Release and free the Rx/Tx resources */
 	xgmac_free_dma_desc_rings(priv);
+	priv->rings_ready = false;
 
 	return 0;
 }
@@ -1713,6 +1736,8 @@ static int xgmac_probe(struct platform_device *pdev)
 	ndev->ethtool_ops = &xgmac_ethtool_ops;
 	spin_lock_init(&priv->stats_lock);
 	INIT_WORK(&priv->tx_timeout_work, xgmac_tx_timeout_work);
+	disable_work(&priv->tx_timeout_work);
+	priv->work_disabled_down = true;
 
 	priv->device = &pdev->dev;
 	priv->dev = ndev;
@@ -1830,6 +1855,7 @@ static void xgmac_remove(struct platform_device *pdev)
 	free_irq(priv->pmt_irq, ndev);
 
 	unregister_netdev(ndev);
+	disable_work_sync(&priv->tx_timeout_work);
 	netif_napi_del(&priv->napi);
 
 	iounmap(priv->base);
@@ -1858,11 +1884,18 @@ static int xgmac_suspend(struct device *dev)
 	struct xgmac_priv *priv = netdev_priv(ndev);
 	u32 value;
 
-	if (!ndev || !netif_running(ndev))
+	if (!ndev || !netif_running(ndev) || !priv->rings_ready)
 		return 0;
 
 	netif_device_detach(ndev);
-	napi_disable(&priv->napi);
+	if (!priv->work_disabled_pm) {
+		disable_work_sync(&priv->tx_timeout_work);
+		priv->work_disabled_pm = true;
+	}
+	if (priv->napi_enabled) {
+		napi_disable(&priv->napi);
+		priv->napi_enabled = false;
+	}
 	writel(0, priv->base + XGMAC_DMA_INTR_ENA);
 
 	if (device_may_wakeup(priv->device)) {
@@ -1884,18 +1917,33 @@ static int xgmac_resume(struct device *dev)
 	struct xgmac_priv *priv = netdev_priv(ndev);
 	void __iomem *ioaddr = priv->base;
 
-	if (!netif_running(ndev))
+	if (!netif_running(ndev) || !priv->rings_ready) {
+		/* Drop the reference taken by suspend, even when the
+		 * interface was brought down while the system slept.
+		 */
+		if (priv->work_disabled_pm) {
+			enable_work(&priv->tx_timeout_work);
+			priv->work_disabled_pm = false;
+		}
 		return 0;
+	}
 
 	xgmac_pmt(ioaddr, 0);
 
-	/* Enable the MAC and DMA */
+	/* Enable NAPI and timeout recovery before interrupt publication. */
+	if (!priv->napi_enabled) {
+		napi_enable(&priv->napi);
+		priv->napi_enabled = true;
+	}
+	if (priv->work_disabled_pm) {
+		enable_work(&priv->tx_timeout_work);
+		priv->work_disabled_pm = false;
+	}
 	xgmac_mac_enable(ioaddr);
 	writel(DMA_INTR_DEFAULT_MASK, ioaddr + XGMAC_DMA_STATUS);
 	writel(DMA_INTR_DEFAULT_MASK, ioaddr + XGMAC_DMA_INTR_ENA);
 
 	netif_device_attach(ndev);
-	napi_enable(&priv->napi);
 
 	return 0;
 }
-- 
2.50.1.windows.1
