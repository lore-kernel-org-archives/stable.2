Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3AA3D3012;
	Sun, 27 Sep 2026 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790507460; cv=none; b=mP4ur1JDTJKpanKSM6keP2jDHJkdEyKbNa9d3VkOKoxVK5Y3GjSAeLMk55fYApiyAAzm8PXRugTl9sO/Zvvh4VvyTTts/PlWrX0b5xpeyQ7agJNCQ0VTvceyc4ybbOM70VhcQ5G3rjo2IB+QhGC/1HiTD+29pVPICxlHOhA60As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790507460; c=relaxed/simple;
	bh=/q4wAXBEAGQ32gx0VWqHuJ93LPgUIRHq2IkmfG3dsIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OSXMwHoFLmsVdswVu/xFscLu17SVSEO69uxChOhIM9ObOZAet6plgO1mXoyj7i5MJPkTsg2Pvr0wljcUHjUxUrN7eNDL/ePxjaEgIP4z8Gd321wj1VcsXJdwBQdm2lcuzw8oRNfCb4ZqzBxa0ENvtnI7UyY2QJPsxk2J1F7aS/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DL7R3WCm; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DL7R3WCm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=oR
	BG98w2GuYcMXXzEm5Pb5Z5Tt8jpFdSwhDK1zNz4NM=; b=DL7R3WCmW6yO3wUlUQ
	fOqDTksf0jCpr5SF/Y+dEPUAbVSJV/z3YQCi6Mh2kKvaPHlS9o3DiuZNb+WN9vqX
	dOPaSSMX+T7tY519+xddRn0adIR2U+d6pGFrdbRNUIPmvFk11bmk8sSbTsGTBkZR
	svXZlqf3I4mkrhpl6o+C0i8dc=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3_92P+bhqB9V5BA--.4648S7;
	Sun, 27 Sep 2026 19:10:15 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 5/7] net: hix5hd2: manage the netdev lifetime with devres
Date: Sun, 27 Sep 2026 19:10:02 +0800
Message-Id: <20260927111005.1035089-6-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3_92P+bhqB9V5BA--.4648S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr15GF4kJFWrJF15tw45trb_yoW5GF43p3
	WUGFWa9ry8Xw4ft34Dtr4UZFyrAa18Kay5CFW7Kwn3ZasIyrykXF4FkFy0vF4FyFWkGF4Y
	qr42yr4ruan8urDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_Xo23UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7xdspmq4+Zf3xQAA38

hix5hd2_dev_remove() manually frees the netdev before devres releases
the IRQ. The interrupt handler receives that netdev as its data pointer
and can access it during this teardown window.

Allocate the netdev through devres so its later registered IRQ is
released first.

Fixes: 57c5bc9ad7d7 ("net: hisilicon: add hix5hd2 mac driver")

Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
index 02282dc86faf..ffcb281230eb 100644
--- a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
@@ -1100,7 +1100,7 @@ static int hix5hd2_dev_probe(struct platform_device *pdev)
 	struct mii_bus *bus;
 	int ret;
 
-	ndev = alloc_etherdev(sizeof(struct hix5hd2_priv));
+	ndev = devm_alloc_etherdev(dev, sizeof(struct hix5hd2_priv));
 	if (!ndev)
 		return -ENOMEM;
 
@@ -1115,26 +1115,26 @@ static int hix5hd2_dev_probe(struct platform_device *pdev)
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base)) {
 		ret = PTR_ERR(priv->base);
-		goto out_free_netdev;
+		goto out_return;
 	}
 
 	priv->ctrl_base = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(priv->ctrl_base)) {
 		ret = PTR_ERR(priv->ctrl_base);
-		goto out_free_netdev;
+		goto out_return;
 	}
 
 	priv->mac_core_clk = devm_clk_get(&pdev->dev, "mac_core");
 	if (IS_ERR(priv->mac_core_clk)) {
 		netdev_err(ndev, "failed to get mac core clk\n");
 		ret = -ENODEV;
-		goto out_free_netdev;
+		goto out_return;
 	}
 
 	ret = clk_prepare_enable(priv->mac_core_clk);
 	if (ret < 0) {
 		netdev_err(ndev, "failed to enable mac core clk %d\n", ret);
-		goto out_free_netdev;
+		goto out_return;
 	}
 
 	priv->mac_ifc_clk = devm_clk_get(&pdev->dev, "mac_ifc");
@@ -1271,9 +1271,7 @@ static int hix5hd2_dev_probe(struct platform_device *pdev)
 	clk_disable_unprepare(priv->mac_ifc_clk);
 out_disable_mac_core_clk:
 	clk_disable_unprepare(priv->mac_core_clk);
-out_free_netdev:
-	free_netdev(ndev);
-
+out_return:
 	return ret;
 }
 
@@ -1291,7 +1289,6 @@ static void hix5hd2_dev_remove(struct platform_device *pdev)
 	hix5hd2_destroy_hw_desc_queue(priv);
 	of_node_put(priv->phy_node);
 	cancel_work_sync(&priv->tx_timeout_task);
-	free_netdev(ndev);
 }
 
 static const struct of_device_id hix5hd2_of_match[] = {
-- 
2.34.1

