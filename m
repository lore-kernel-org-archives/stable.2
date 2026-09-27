Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC533D332C;
	Sun, 27 Sep 2026 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790507493; cv=none; b=gN6zVoP8Xv/ueKeEAdqf5UpuSfBb1MnWQZoiX/g8eWFLsy0Eog0nKzgMqYF5ksUigJO6S8WHPsLfJ7SnLfz0+Kbk7kibIkKiwisxNk88rajh6bax1woIdTf0lyWsRVHr7rvlQZ0NRAEjsmPbyfHIxIZN1ZXC8rKirLFcgLjFz80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790507493; c=relaxed/simple;
	bh=cIk4QrP5/r+EhsssxQH7YX2yCz6977xIeE6KCqk7ekE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jKmNE56EhCmJ349S+UHIdfQYuJuAx/wcE8jijFA2mzZ2jXQlzB3blHjbgVRo++25G84554wNZyxvo+LZPaFM+FN5awqtp5NURN+gpYNSmq5fbzZdCsz6qZrQcyyDkvrNgrQ8lxlWX+uXE1I7hvleiwQJhskRR5nqCZlJ7FeuCrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VS7zyrDx; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VS7zyrDx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=qO
	ISqubq90H10iOVl1x0pZn7YD/H1NJNZnWEQskYgtc=; b=VS7zyrDx9cRA0I+3PB
	5Gs636YAW18qu4/FskLa38uAUz+3vcP1kI46qX/AfqfXDTpaSGH8kA9AD/o3wi/r
	NcHDJ2f4Z90mNTsJa1PYhiW45VwlRhKOE/F24mbD8a+Tb7BCXHRTlPEkYGmpuqhr
	37iekIP5wWDVjqgjGu9zb2P7U=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3_92P+bhqB9V5BA--.4648S3;
	Sun, 27 Sep 2026 19:10:10 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Soren Brinkmann <soren.brinkmann@xilinx.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/7] net: macb: manage the netdev lifetime with devres
Date: Sun, 27 Sep 2026 19:09:58 +0800
Message-Id: <20260927111005.1035089-2-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260927111005.1035089-1-yaojiale02@163.com>
References: <20260927111005.1035089-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_92P+bhqB9V5BA--.4648S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF4fGrW7KF4DKr4DCw1kAFb_yoW5Cw48pa
	y7CFWrKr4kWFW3twn7Kw1UZF1rCw4ft34xKay2kw4rX3yYyrykXFy8XryjvFW8JFZ5Aw4S
	vF1jyrW8Za1kJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE_Ma7UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7xNrpWq4+ZP3VwAA3q

macb_remove() frees the netdev while its managed IRQs are only
released after the remove callback returns. An interrupt in that window
can dereference the freed netdev or queue data.

Allocate the netdev with devres as well. Since the IRQs are registered
later, devres releases them before freeing the netdev and closes the
lifetime gap.

Fixes: 0a4acf08ea62 ("net: macb: Use devm_request_irq()")

Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b8234ac4b602..ebf6ffb1cc4f 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5812,7 +5812,8 @@ static int macb_probe(struct platform_device *pdev)
 		goto err_disable_clocks;
 	}
 
-	netdev = alloc_etherdev_mq(sizeof(*bp), num_queues);
+	netdev = devm_alloc_etherdev_mqs(&pdev->dev, sizeof(*bp),
+					 num_queues, num_queues);
 	if (!netdev) {
 		err = -ENOMEM;
 		goto err_disable_clocks;
@@ -5859,7 +5860,7 @@ static int macb_probe(struct platform_device *pdev)
 			IS_ENABLED(CONFIG_MACB_USE_HWSTAMP)) {
 		dev_err(&pdev->dev, "Timer adjust mode is not supported\n");
 		err = -EINVAL;
-		goto err_out_free_netdev;
+		goto err_disable_clocks;
 	}
 
 	/* By default we set to partial store and forward mode for zynqmp.
@@ -5893,7 +5894,7 @@ static int macb_probe(struct platform_device *pdev)
 		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
 		if (err) {
 			dev_err(&pdev->dev, "failed to set DMA mask\n");
-			goto err_out_free_netdev;
+			goto err_disable_clocks;
 		}
 		bp->caps |= MACB_CAPS_DMA_64B;
 	}
@@ -5903,7 +5904,7 @@ static int macb_probe(struct platform_device *pdev)
 	netdev->irq = platform_get_irq(pdev, 0);
 	if (netdev->irq < 0) {
 		err = netdev->irq;
-		goto err_out_free_netdev;
+		goto err_disable_clocks;
 	}
 
 	/* MTU range: 68 - 1518 or 10240 */
@@ -5932,7 +5933,7 @@ static int macb_probe(struct platform_device *pdev)
 
 	err = of_get_ethdev_address(np, bp->netdev);
 	if (err == -EPROBE_DEFER)
-		goto err_out_free_netdev;
+		goto err_disable_clocks;
 	else if (err)
 		macb_get_hwaddr(bp);
 
@@ -5946,7 +5947,7 @@ static int macb_probe(struct platform_device *pdev)
 	/* IP specific init */
 	err = macb_init(pdev, macb_config);
 	if (err)
-		goto err_out_free_netdev;
+		goto err_disable_clocks;
 
 	err = macb_mii_init(bp);
 	if (err)
@@ -5988,9 +5989,6 @@ static int macb_probe(struct platform_device *pdev)
 err_out_phy_exit:
 	phy_exit(bp->phy);
 
-err_out_free_netdev:
-	free_netdev(netdev);
-
 err_disable_clocks:
 	macb_clks_disable(pclk, hclk, tx_clk, rx_clk, tsu_clk);
 	pm_runtime_disable(&pdev->dev);
@@ -6024,7 +6022,6 @@ static void macb_remove(struct platform_device *pdev)
 		pm_runtime_dont_use_autosuspend(&pdev->dev);
 		pm_runtime_set_suspended(&pdev->dev);
 		phylink_destroy(bp->phylink);
-		free_netdev(netdev);
 	}
 }
 
-- 
2.34.1

