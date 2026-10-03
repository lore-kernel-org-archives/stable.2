Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAD736197E;
	Sat,  3 Oct 2026 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791018040; cv=none; b=urGrIpNuHSj8Iy2epwldlDL4GSXzXfd2e/lBrxLpkNQwFXz9eegKccGHIs4p6beLSaLOPzcK5Fy64ftuYbLExZlXQZMUb+pWxIj8N6JA6bDs5Y8vdAkZbLAQqjp9xlbOZlVyga5YbfyE2xpqs8ohu5XeBuzHusnzy+n1ftgUCcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791018040; c=relaxed/simple;
	bh=pL7V1T2911GCpEAVh5GQTxvVppLjM0wV0JVActJVR+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GQYn2DDSzsNKwJToEjGO+hdqodnDEINZKzliOpcKwJBWtRYcsHopP/IMwxvg6IQh7BcRuM/FiwNkVY99Uh5NNV9u2egE/FjbJIwdjl0R/gHsq7bwCWZIKtsNdSBBUeamTdJJEHoP1IwATiUxc13Rls/hK1+zMMoxinS74h8E0LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dd1nuHbD; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dd1nuHbD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=tH
	zxyjRVKHXodpzPlrYp99M9Bqz0YCWq/ZrlUMWQ9II=; b=dd1nuHbDmae1afaRIL
	dssSGsZwbncjQVASDwF6ODVyKS4jEWUfQ0l/kYJa1NsDG/09TmoRg2AuXF2rvvun
	IY843yWtVjSrJF5zBbQHCIxyJMuQdvSRzQQ4CwoWPn16vkT5wvFO5BralF69/mEv
	GilrWbsuNYemRXz/CZVmPetiI=
Received: from pc.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXP4b_w8BqInaGCg--.62290S6;
	Sat, 03 Oct 2026 16:59:54 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Dongpo Li <lidongpo@hisilicon.com>,
	Jiancheng Xue <xuejiancheng@hisilicon.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3 4/7] net: hisi_femac: manage the netdev lifetime with devres
Date: Sat,  3 Oct 2026 16:59:35 +0800
Message-Id: <20261003085940.493951-5-yaojiale02@163.com>
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
X-CM-TRANSID:QCgvCgDXP4b_w8BqInaGCg--.62290S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar15AF1kZFyUXrW3CFykZrb_yoW5JFy8pa
	yDJayxKrW8WF1fKwnrt3WjvF15Aw47Kay3GFWrtw1kZ3WayrykJa1rKFy0vF4rAFWkCF45
	Wa12yayruayDX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pijQ6AUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wv9OGrAxAvkwAAA3g

hisi_femac_drv_remove() frees the netdev while the shared managed IRQ
remains registered until devres cleanup. Its handler uses the netdev as
private data, so an interrupt in this window can dereference freed
memory.

Manage the netdev allocation with devres so the later IRQ resource is
released before the netdev.

This issue was found by a static analysis method used in our research.

Fixes: 542ae60af24f ("net: hisilicon: Add Fast Ethernet MAC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/ethernet/hisilicon/hisi_femac.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
index d244a40df430..d369824fa4e8 100644
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -774,7 +774,7 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
 	struct phy_device *phy;
 	int ret;
 
-	ndev = alloc_etherdev(sizeof(*priv));
+	ndev = devm_alloc_etherdev(dev, sizeof(*priv));
 	if (!ndev)
 		return -ENOMEM;
 
@@ -788,26 +788,26 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
 	priv->port_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->port_base)) {
 		ret = PTR_ERR(priv->port_base);
-		goto out_free_netdev;
+		goto out_return;
 	}
 
 	priv->glb_base = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(priv->glb_base)) {
 		ret = PTR_ERR(priv->glb_base);
-		goto out_free_netdev;
+		goto out_return;
 	}
 
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		dev_err(dev, "failed to get clk\n");
 		ret = -ENODEV;
-		goto out_free_netdev;
+		goto out_return;
 	}
 
 	ret = clk_prepare_enable(priv->clk);
 	if (ret) {
 		dev_err(dev, "failed to enable clk %d\n", ret);
-		goto out_free_netdev;
+		goto out_return;
 	}
 
 	priv->mac_rst = devm_reset_control_get(dev, "mac");
@@ -887,9 +887,7 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
 	phy_disconnect(phy);
 out_disable_clk:
 	clk_disable_unprepare(priv->clk);
-out_free_netdev:
-	free_netdev(ndev);
-
+out_return:
 	return ret;
 }
 
@@ -903,7 +901,6 @@ static void hisi_femac_drv_remove(struct platform_device *pdev)
 
 	phy_disconnect(ndev->phydev);
 	clk_disable_unprepare(priv->clk);
-	free_netdev(ndev);
 }
 
 #ifdef CONFIG_PM
-- 
2.34.1

