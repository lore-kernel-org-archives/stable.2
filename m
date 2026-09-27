Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1A62949E0;
	Sun, 27 Sep 2026 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790520592; cv=none; b=REUfgwu5fiBAdfwdoXXovp0KWFJsH8XApQyQK1fZBZEzlMGyKkEpfExlJrS4x9oAdIcAnD4P9GdSS6kqMualE/n26VDpY/2yNUAnGCecoUxNCAkUmZCvNtwfciT+0Y6D5gRYsmBaD5lOI/6fjcK/c0pv5g83vmhSBsjRID8ZTH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790520592; c=relaxed/simple;
	bh=PUe3957DnGN33LCRPpEhFs+Radc1/nniYEfXmRNK7AQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HNotxkrn7gwwYz9oIai9rniPVwpVjKIwiWfFNX/m9vJSANDzQHcYztzGtkMWbS8OQrsKoIs19LmL8wWsxpnUR6dW/7mmy6Z98H/IyFKeD9Hqf4Wg+qCyd/41aaO1y/5yOimQbfBK0zyVWgNu1DwhFmkWj30k71NBwFjnL4q0h8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kvp8RORE; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kvp8RORE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ib
	YWpP2OD5um9Lhj3sBU8JS6T73jA2kttEYd9+/YHAU=; b=kvp8ROREZ4dZUH9+Z5
	PAOHM7wNDyUcTpher80CVJv6EOajlX1EEbddjfk6VD2AcHXLuiEAQ7DLe9PLcijI
	6b/HEpSMRLyKGEQS8a6DyaGjpEJMRj4T6b4Mc6XG7tkUFmL/ZQIQFluWjnopsoqo
	/fLrjPn+YjvONPOWIVuouK87c=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD330OOLLlqjwJIBA--.47706S4;
	Sun, 27 Sep 2026 22:47:47 +0800 (CST)
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
Subject: [PATCH v2 2/7] net: fec: manage the netdev lifetime with devres
Date: Sun, 27 Sep 2026 22:47:35 +0800
Message-Id: <20260927144741.1320558-3-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD330OOLLlqjwJIBA--.47706S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFW3GF1ftw15JrW7uFy7trb_yoW8Wry5pF
	WDJay09rykGr17W3WDJr48AFy5C3y7t34DW3yxK3yfZ3s0yr1qgr1kXFWj9r4rZrW8uF1S
	gw4jvryfZ3Z8XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pKg4h7UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRM4cmq5LJPHAwAA38

fec_drv_remove() frees the netdev before devres releases the managed
IRQs whose handlers use it as their data pointer. A late interrupt can
therefore access the freed netdev.

Allocate the netdev with devres so that the later IRQ registrations are
released first during teardown.

Fixes: 0d9b2ab1c376 ("fec: Use devm_request_irq()")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 794ec427b0ee..23e794a31ce8 100644
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
 
@@ -5480,8 +5481,6 @@ fec_probe(struct platform_device *pdev)
 failed_phy:
 	dev_id--;
 failed_ioremap:
-	free_netdev(ndev);
-
 	return ret;
 }
 
@@ -5522,7 +5521,6 @@ fec_drv_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 	fec_enet_deinit(ndev);
-	free_netdev(ndev);
 }
 
 static int fec_suspend(struct device *dev)
-- 
2.34.1

