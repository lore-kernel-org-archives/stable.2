Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3357C3D3481;
	Sun, 27 Sep 2026 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790507469; cv=none; b=TOtxstvZMK9k3U7EW41/saG0aDj1/u8G+zpGM1TLc6iPpz6LZXKJNfbvuoFHjLETZCez5XKAGg8HSaGnzpWVP0Zrdf0W9g8r7JYItuerK5tT3EOvUgs+inQm+50the89vu0r0tPW4ziFwaHiBfYGlWBMZnafsfi99YkCZOezjBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790507469; c=relaxed/simple;
	bh=88fsRerAcP+PudvBfkNrp2PaCLkKGdTF5w2RkkuN5DY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cJ/2bpQQERuNxy1QVQbgBfurydy+zmbzKyghxsR9xz9rvN2rHNr7p5h3tl9aVa5OwyYCnJ0Cc0FvsxLUf7coXgCoHVmkHceB+TDvnd22FQeHxVv5+r98OtejgCgpjMZamwLZuUJQvtFNFqu6pNakn9wSH3QdCToHhtxpAq3BJ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FK3wCglO; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FK3wCglO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Bb
	EXFIoskJ0KUWvgFgmXTqQws+RcgVEEIZZnIYlb4uk=; b=FK3wCglO65J9JH9his
	XtrezK0o2xt3h+zcdIx07mklAFZZZPGB+IpUn3/AtAwL3njklcsOHpQBUJElse2R
	8EqrmA1EyIib4z4WAH+recfpXgaihjCO5ZCi+4krrmMhCirG+ANjs8c4ENApjHj+
	tx+drkCyY/+xLoOR7DVtDb90M=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3_92P+bhqB9V5BA--.4648S6;
	Sun, 27 Sep 2026 19:10:14 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiancheng Xue <xuejiancheng@hisilicon.com>,
	Dongpo Li <lidongpo@hisilicon.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/7] net: hisi_femac: manage the netdev lifetime with devres
Date: Sun, 27 Sep 2026 19:10:01 +0800
Message-Id: <20260927111005.1035089-5-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3_92P+bhqB9V5BA--.4648S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar15AF1kZFyUGryxCr13CFg_yoW5Jr1rpa
	yDJayxKrW8XF1fKwnrtF1jvF15Aw47Kay3GFWrtw1kZ3WayrykJayrKFy0vF4rAFykCF45
	Wa17AayruayDX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEH7K3UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRZspmq4+ZZL9AAA3T

hisi_femac_drv_remove() frees the netdev while the shared managed IRQ
remains registered until devres cleanup. Its handler uses the netdev as
private data, so an interrupt in this window can dereference freed
memory.

Manage the netdev allocation with devres so the later IRQ resource is
released before the netdev.

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

