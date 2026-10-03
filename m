Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B3D3168E6;
	Sat,  3 Oct 2026 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791018041; cv=none; b=GUFoscYg13LJjRQazw8Ih5aw0uZeWzfRwnDKLNfV9VIBbh6qqJeEk92WQ2YVR62P3S9vQIEAyK+Y8FoSZnmNtZer0cYj+r2qOoC+SQCUKhUpt/ihSGYSpaNrNcWmBLnRgci1Gq3kRJsLBRoDJyQpkBoT3IN34dkT2vW+ATfR3PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791018041; c=relaxed/simple;
	bh=BPUu/DDjPu9FhT+Az+IgzKA/3f0Dhuss26P9gX0X/5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OeAeUzP0VM7Au8wXZRHGSr/AGo6AwTNUjVwhBiGV+EXws+NdQmPPUte/AKUvHiIa8GAYToxNhssdO3u6ke51clVIPL0JtirEvE4IrzaUAyRMD8zjelIPCZxPIFHVDQo+Vqoz/UypcQF+LCceJ//ZZ/sGx++gl5ZcZh7z58/p4Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OufmXyw7; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OufmXyw7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Rq
	zR6Q6qSJdPOr4kPYZPEYw6DzO74iQbBwGqyg1djt4=; b=OufmXyw7HN9yPr3/LU
	Ns2llUvamo//i5kxpZmmC6R5a2SicU0ei9qAMzNZUHjj+fsnmuv8zCWtu48VKXHB
	xEQdwqFUs9Nt1Q1OFjcPs20Zd6RESn/nYRHmaqgFfehAcKgfdM6eh5HX4leaGtud
	n1WBYIzrM27C/r2SFN5qjxZQQ=
Received: from pc.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXP4b_w8BqInaGCg--.62290S7;
	Sat, 03 Oct 2026 16:59:55 +0800 (CST)
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
Subject: [PATCH net v3 5/7] net: hix5hd2: manage the netdev lifetime with devres
Date: Sat,  3 Oct 2026 16:59:36 +0800
Message-Id: <20261003085940.493951-6-yaojiale02@163.com>
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
X-CM-TRANSID:QCgvCgDXP4b_w8BqInaGCg--.62290S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr15GF4kJFWrJF15tw45trb_yoW5Xr47pa
	1DGFWa9ry8Xw4fK34Dtr4UZFyrAa18Kay5CFWxKwn3ZasIyrykJF4rKFy0vF4FyFWkGF4a
	qr4Iyr4ruan8urDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE2YLdUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8Az+OWrAxAza6gAA3p

hix5hd2_dev_remove() manually frees the netdev before devres releases
the IRQ. The interrupt handler receives that netdev as its data pointer
and can access it during this teardown window.

Allocate the netdev through devres so its later registered IRQ is
released first.

This issue was found by a static analysis method used in our research.

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

