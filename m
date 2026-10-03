Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED0333DEC8;
	Sat,  3 Oct 2026 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791018042; cv=none; b=ZQsBHUOLiAA1Us5dVhFpam3vzVEW4cF7s+Xv35oVfp13dhU8WZxrebJZ/II2qKeJoQQFUYtASjXujbp8DQJkvucRESpZIo4leD/OKQgulpotiXs8sJL5cz97QOQwiX/j+MlxS6OtIWci1xoj++B/IOe4r5bNioNy6UFLWnLa43E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791018042; c=relaxed/simple;
	bh=8nMlaKrjrvlbUkGBil2GRK+3KJMsMqVAgQCr0R/RoxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aVvP2yM8/NZ2almH9xjvabSoSrL9KNqGrK/C6kT1yntUt9wqAlOXd8DiuLJ5tSSzkRBqiNLuLqugkLN55btGUNu67PsP6NZQm+mnvXVd0mNCkTEDw8ryno1m++QOIXk+RnS96jlHCv9VVf72FiY4mYr63toU6gltko27CFNswQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AQcDCzZg; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AQcDCzZg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=7D
	EFuNn/FrHovg0OFV96ehePaBL+VFhK1x6DJl4HTuo=; b=AQcDCzZgkElTP1FFJi
	No9+ZzIg56BTacOoa21TBMI+mlPQ8rZKGECPHs2R4Yt++WH1tImixzEUfBa5fUI7
	uBjZM1jWhsRAYNHpZ/JvXEkDzBi0KosOdQMeATHs6sVRpgGKU1unA5ffWMSxDhWp
	Zc2fKTysW6FiSn67a8ktWjaLM=
Received: from pc.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXP4b_w8BqInaGCg--.62290S5;
	Sat, 03 Oct 2026 16:59:53 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	dingtianhong <dingtianhong@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3 3/7] net: hip04: manage the netdev lifetime with devres
Date: Sat,  3 Oct 2026 16:59:34 +0800
Message-Id: <20261003085940.493951-4-yaojiale02@163.com>
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
X-CM-TRANSID:QCgvCgDXP4b_w8BqInaGCg--.62290S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF15KryrGF1DCrW5Gr43Awb_yoW8WFWxpa
	y5GayakFW8tw1SqayDXw4jyFyrC3Z2q3y5WFyxCwsYvwnIyryUXryDKFyjyF4rJFWkWana
	qr40yrZ3ZFn5G37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR58nrUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8An9OGrAxAnazQAA3M

hip04_remove() frees the netdev before the managed IRQ is released
after the remove callback. Since the IRQ handler receives the netdev as
its data pointer, a late interrupt can access freed memory.

Use a managed netdev allocation. Devres then releases the IRQ, which is
registered later, before releasing the netdev.

This issue was found by a static analysis method used in our research.

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

