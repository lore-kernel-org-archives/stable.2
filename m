Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A21282F10;
	Sat,  3 Oct 2026 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791018097; cv=none; b=tD1dLHgkiExa9ZwLZgqwv+v/bVUAbhjPLr3BHu5OufKzx/htekx1NY2rUhbUeKcQq1fd/9xusTeDVoD9I8iuPDY6yXBplNmzctHZU96i1W0W3bEWKv3l6ZBhejkYPlTQphRAFVBqjjz/Tp946E9K5BsP4Jm9muxDaV3615EUnSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791018097; c=relaxed/simple;
	bh=YHrkyXqtM4Z0wLaLyRUxMhSSEibDiGAQ1BuWvcUa21k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=beCXpsLqOfQfy56HNnhYIt8PBPzCZJocXMv+mXmZ5kgago2slpV8E8BJHI0qSPd7viH2DBICtO7eU9BL/bQcMmgdWHe6+evDsdh7jYBekN+PvSL0REw0yT3bZH8A1m8g90MIt1ZEU6t0HMEgqbuUrN5OjQ8w/qK1czm2NiCqC6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oqGdbRAv; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oqGdbRAv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=BR
	mpX/LchmwfC/G9d3AFu1t86Np0Bwo7NP2BycY+MNg=; b=oqGdbRAvQ7C4L8qvcO
	t6eCGPv7NPfuDDU5wHACgZJWTMaGqFfaq1LDp29H5IH34L/4UE6wgWsc8tpw5PUH
	JLhomM3tzNn0fwQnFX+Mx5vxMtpB9LdeR+sngRIsxTF5XzChp8yhw6PqurXeJVZS
	z5Fb5maQIafdfSH3RIMN/mYoY=
Received: from pc.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXP4b_w8BqInaGCg--.62290S4;
	Sat, 03 Oct 2026 16:59:49 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Wei Fang <wei.fang@nxp.com>,
	Frank Li <frank.li@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3 2/7] net: fec: release IRQs before dependent resources
Date: Sat,  3 Oct 2026 16:59:33 +0800
Message-Id: <20261003085940.493951-3-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261003085940.493951-1-yaojiale02@163.com>
References: <20261003085940.493951-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDXP4b_w8BqInaGCg--.62290S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF45Aw45tFy3WFy8tFy3XFb_yoW5tFy7pF
	Z7JayfKrW8Wr12gw1UJr4UAFy5C34xt39rW34xGrWfZ3s0yryvgF18XFW2vFWrAFWkAFn3
	JF47Zr48Zas8XF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pKg4h7UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8AX8N2rAxAXaoQAA3u

fec_drv_remove() leaves the managed IRQs active until after the remove
callback returns. The handler can then run after the device has been
unregistered, its clocks have been disabled, and its other resources have
been torn down.

Mask the hardware interrupt sources and disable each IRQ before
unregistering the netdev. Mask the sources again afterwards because
fec_stop() restores the default interrupt mask. Also perform the same
cleanup on probe failures, and manage the netdev with devres so it remains
alive until the IRQ resources are released.

This issue was found by a static analysis method used in our research.

Fixes: 0d9b2ab1c376 ("fec: Use devm_request_irq()")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 28 ++++++++++++++---------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 794ec427b0ee..b0fc5b39c748 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -5219,8 +5219,9 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_get_queue_num(pdev, &num_tx_qs, &num_rx_qs);
 
 	/* Init network device */
-	ndev = alloc_etherdev_mqs(sizeof(struct fec_enet_private) +
-				  FEC_STATS_SIZE, num_tx_qs, num_rx_qs);
+	ndev = devm_alloc_etherdev_mqs(&pdev->dev,
+				       sizeof(struct fec_enet_private) +
+				       FEC_STATS_SIZE, num_tx_qs, num_rx_qs);
 	if (!ndev)
 		return -ENOMEM;
 
@@ -5247,10 +5248,8 @@ fec_probe(struct platform_device *pdev)
 	pinctrl_pm_select_default_state(&pdev->dev);
 
 	fep->hwp = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(fep->hwp)) {
-		ret = PTR_ERR(fep->hwp);
-		goto failed_ioremap;
-	}
+	if (IS_ERR(fep->hwp))
+		return PTR_ERR(fep->hwp);
 
 	fep->pdev = pdev;
 	fep->dev_id = dev_id++;
@@ -5455,6 +5454,9 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_mii_remove(fep);
 failed_mii_init:
 failed_irq:
+	fec_irqs_disable(ndev);
+	while (i--)
+		disable_irq(fep->irq[i]);
 	fec_enet_deinit(ndev);
 failed_init:
 	if (fep->bufdesc_ex)
@@ -5479,9 +5481,6 @@ fec_probe(struct platform_device *pdev)
 failed_ipc_init:
 failed_phy:
 	dev_id--;
-failed_ioremap:
-	free_netdev(ndev);
-
 	return ret;
 }
 
@@ -5491,7 +5490,7 @@ fec_drv_remove(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	struct device_node *np = pdev->dev.of_node;
-	int ret;
+	int i, irq_cnt, ret;
 
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0)
@@ -5502,7 +5501,15 @@ fec_drv_remove(struct platform_device *pdev)
 	cancel_work_sync(&fep->tx_timeout_work);
 	if (fep->bufdesc_ex)
 		fec_ptp_stop(pdev);
+	if (ret >= 0)
+		fec_irqs_disable(ndev);
+	irq_cnt = fec_enet_get_irq_cnt(pdev);
+	for (i = 0; i < irq_cnt; i++)
+		disable_irq(fep->irq[i]);
 	unregister_netdev(ndev);
+	/* fec_stop() enables the default interrupt mask. */
+	if (ret >= 0)
+		fec_irqs_disable(ndev);
 	fec_enet_mii_remove(fep);
 	if (fep->reg_phy)
 		regulator_disable(fep->reg_phy);
@@ -5522,7 +5529,6 @@ fec_drv_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 	fec_enet_deinit(ndev);
-	free_netdev(ndev);
 }
 
 static int fec_suspend(struct device *dev)
-- 
2.34.1

