Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8323D6682;
	Sun, 27 Sep 2026 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790507478; cv=none; b=iC3t6qgM3j5fRFmQ0yBItH+2HUFw/VUHGAX7kMlVjH1bERdeYfrmv7exh23Qlhz7CKxc/Zc1QavinaHaB/8YMpizpX/HWemOXo0yJ0u3B9s+7Yxt1u3MND402gQJPlCkwYSJ4KAnMqMQ0UCJZc6X2RzrvlzuGJmeD2ft13Wpy2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790507478; c=relaxed/simple;
	bh=lxQau7rdSBUfC4pIN+G7FeHThK/fHGnglOIgm///PGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tpsTt0LLSgL1aDinlwnv7JfI408wSnQT0u95/2jy2bBCpBZ85FCBUDzxEWAjlF5+0b+FYS9LZQnnI4w701jNDoK7FE0QvaOJsFHpPMzm2nImPq2VdpChXVFLnTXnTdIIIkcR8p7NwLw7Tzu5M8xk1n0Wn378hA8K+dEwHGAgZiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=j+qgCtcc; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="j+qgCtcc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Qe
	bRdh/CpwjUxYMBPp87PjY20S3fC/Abh0i40bIiQWk=; b=j+qgCtccl3eXiH0D7i
	o88EbMf6VSDNeVfuiZIk4+/o+H/4Opnji+oOz3fzbfWNYkkAH1fN75AE0VaY2oUS
	llJNdLLnE9UHr4A+oYHubL3akiVPS04JuFRks41MczHEoTlPSUpMxgsFfMQH4NRV
	ZOq/g9Ejd9KbPPZKIbHo2fWEU=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3_92P+bhqB9V5BA--.4648S5;
	Sun, 27 Sep 2026 19:10:13 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	dingtianhong <dingtianhong@huawei.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/7] net: hip04: manage the netdev lifetime with devres
Date: Sun, 27 Sep 2026 19:10:00 +0800
Message-Id: <20260927111005.1035089-4-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3_92P+bhqB9V5BA--.4648S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF15KryrGF1DCrW8Zw4kXrb_yoW8Wr4fpa
	15GayIkFW8tw1Sqa4DXw1jyFyrA3Z2q3y5WryxCwsYv3sIyryUXryDKFyjyF4rJFWkWFsI
	qr40yrs3Z3WkG37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRw0edUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7xVspmq4+ZX3kQAA3o

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

