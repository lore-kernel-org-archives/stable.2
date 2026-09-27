Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2F83403FA;
	Sun, 27 Sep 2026 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790520542; cv=none; b=FrNr71jqRr3+RV77jwtACrJjUIj7Yw8L3otf32oK7t6NpuQv42n0IpBJPDQX0SHBpLq87428q/yLcmxB14Lw4y66rxcHTBqS+wkht9IQJLMPKsHvNmrvAspQzHP0hjcA9rgM/yTyV4/0+gHIcrQH/78pYnCAdXHF1TtTE7e9VlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790520542; c=relaxed/simple;
	bh=src+JEaWGbrdvbEvnQzVfZVOM/Zxo3bXNi38rgyNxks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qjODCCHd5yyIj775uZzJQQNScFbWjW05scoTXvj99CT4wNEFXmzRI6X8l15iDexoY01zguwARWtEMMJ7g9jGrRtn4CHv2MNQUepR+oFXEPMGu1cP2LiHORqjSd/lk/AYDjFmlGGHVSzFnX1OIkd5R/KAzxA5RcruE9KI0uD5ktE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WwSqNdb5; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WwSqNdb5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=kV
	ifqwF4YNDwXiRhnU+RuHceo4kgguEk1ZAJfdAe0d8=; b=WwSqNdb5Jlf0BaGtyy
	ORLJblxRQS88owU+eJf13QqxSVnA1mu7NYYMvGyqzCEMsuVuI+cmfr3BjE53BtgB
	N3NPZZsnB1zM/6A49bRM1xcJCOka5XDvxA7+vh44Pv0qCwqlJ5FQSLoMqZBG8bQg
	44UlkgvimrbS3pyVaM4NRfwII=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD330OOLLlqjwJIBA--.47706S7;
	Sun, 27 Sep 2026 22:47:51 +0800 (CST)
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
Subject: [PATCH v2 5/7] net: hix5hd2: manage the netdev lifetime with devres
Date: Sun, 27 Sep 2026 22:47:38 +0800
Message-Id: <20260927144741.1320558-6-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260927144741.1320558-1-yaojiale02@163.com>
References: <20260927144741.1320558-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD330OOLLlqjwJIBA--.47706S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr15GF4kJFWrJF15tw45trb_yoW5GF43p3
	WUGFWa9ry8Xw4ft34Dtr4UZFyrAa18Kay5CFW7Kwn3ZasIyrykXF4FkFy0vF4FyFWkGF4Y
	qr42yr4ruan8urDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE2YLdUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8Bc5c2q5LJd9oAAA3Y

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

