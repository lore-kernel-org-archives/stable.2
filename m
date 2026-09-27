Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FD22FD1AA;
	Sun, 27 Sep 2026 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790520522; cv=none; b=SxMDOQWGo3+ggeq5gedn/AsxpsfNwAmz/EeiAYlaZ33bQVBOJL0HNToOrvKrNAFx7Zufon073WkNUzwBnznc8/owiUhLTFPmC4p5jq2F7PtywhQkZjpNtK9yBwO31GrNm/AhD1W/QcrLWOktcJDWxu1s+I2/53T20ZkhxCVsaMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790520522; c=relaxed/simple;
	bh=/mO2t/86+Cg39NKdHP4fe3awiVf7bR5eGQk5ePTxbZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n1m4xwEEaM3ikPBzi2cza5hF88xle4LHrHvwVlvTssVEeb/BgPoyGN3wxLXKKt2D/5e257hDA+rbDexYmCAE+jblOu+otgWVgY7XPxfRrNxqMDsG8T/GWyhZc/SFfdHYpqqobpvRVmnddrxETqRquPhuL9cK+WxfJr15yJ3eC7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RGSEq8tF; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RGSEq8tF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=5O
	hdP688pSdJytQbKKOLK2909S4bjL9UYU0xnjDDotQ=; b=RGSEq8tFm1WTojyxse
	VlgC3izih0KPUXg9NNKQo7hgz7oVknd1OBv36vllhpsyBilnTkOXgFPeLGmYssoO
	J5D/dWuhtjz+CVMV6u+1zX6NvbhCDjB/FKx/WOKhIojahGB0cbIQI1hqE9drT/Bi
	Q+BHpMXyizLq82UDzzpAV9B5M=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD330OOLLlqjwJIBA--.47706S5;
	Sun, 27 Sep 2026 22:47:48 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	dingtianhong <dingtianhong@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/7] net: hip04: manage the netdev lifetime with devres
Date: Sun, 27 Sep 2026 22:47:36 +0800
Message-Id: <20260927144741.1320558-4-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD330OOLLlqjwJIBA--.47706S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF15KryrGF1DCrW8Zw4kXrb_yoW8Wr4fpa
	15GayIkFW8tw1Sqa4DXw1jyFyrA3Z2q3y5WryxCwsYv3sIyryUXryDKFyjyF4rJFWkWFsI
	qr40yrs3Z3WkG37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR58nrUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhQ5c2q5LJRNYgAA3U

hip04_remove() frees the netdev before the managed IRQ is released
after the remove callback. Since the IRQ handler receives the netdev as
its data pointer, a late interrupt can access freed memory.

Use a managed netdev allocation. Devres then releases the IRQ, which is
registered later, before releasing the netdev.

Fixes: a41ea46a9a12 ("net: hisilicon: new hip04 ethernet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/ethernet/hisilicon/hip04_eth.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index fc2c47dcfaab..4a643dff22ab 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -905,7 +905,7 @@ static int hip04_mac_probe(struct platform_device *pdev)
 	int irq;
 	int ret;
 
-	ndev = alloc_etherdev(sizeof(struct hip04_priv));
+	ndev = devm_alloc_etherdev(d, sizeof(struct hip04_priv));
 	if (!ndev)
 		return -ENOMEM;
 
@@ -1021,7 +1021,6 @@ static int hip04_mac_probe(struct platform_device *pdev)
 	hip04_free_ring(ndev, d);
 init_fail:
 	of_node_put(priv->phy_node);
-	free_netdev(ndev);
 	return ret;
 }
 
@@ -1038,7 +1037,6 @@ static void hip04_remove(struct platform_device *pdev)
 	unregister_netdev(ndev);
 	of_node_put(priv->phy_node);
 	cancel_work_sync(&priv->tx_timeout_task);
-	free_netdev(ndev);
 }
 
 static const struct of_device_id hip04_mac_match[] = {
-- 
2.34.1

