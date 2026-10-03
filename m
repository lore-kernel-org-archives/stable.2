Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E3E352020;
	Sat,  3 Oct 2026 09:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791018040; cv=none; b=I9ja6T6iLHabeqz5zx1MUUjOaY8f6GklbvSYmjK8aMtW4B61MY8u66v53OuVoPlSiiTddiNJuUW5clFmkV1G3RZrPqOfMFR/0lt+6otS4Uqa/QDZkEQ5btAAGViNvGPQ0czyh2i03+YIXx/wwOlvTyyze6k7B3EVwszLRFtWcjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791018040; c=relaxed/simple;
	bh=p5wRO9uwaoqBZjN6VkCd5F1YRgNUB/n+jeA4HgiLW0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mOC4wRYAdrIUyF+rBDa+EWutxa6XF8ZbRDHIQPZ2UaF4l7gHbmlwunfkJW46GGsD0GQeK4kL5MmOzZ7iojcOXxE5G/uasrubdZIWgXKnUpQYG9EFbKQMxYupURi83gc7rCTVRUKD7cK1eOuorDulMF8nF0bsgb32KpS5rPKduhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DjWGz/BC; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DjWGz/BC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=5q
	2sgbw9Rrc1kTWDCpynbgQBRyIunA7sUOPq0V9eJSY=; b=DjWGz/BCQq805DOdmC
	ZH6SkORAYAhDekZRCgb3PNTYk6qop5rivrmJZGcb5wyBCmHhP892Z5LIpXbbWKHS
	tN8nWtL5TmqSdSolQaDMsdg42R1ZHSTgk9ebf1HuUQiIMGDHGBtfuoqS/YT3qNh6
	ZMNq+wD4k5nVz9G9YSqSgyCCk=
Received: from pc.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXP4b_w8BqInaGCg--.62290S9;
	Sat, 03 Oct 2026 16:59:58 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Byungho An <bh74.an@samsung.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vipul Pandya <vipul.pandya@samsung.com>,
	Siva Reddy <siva.kallam@samsung.com>,
	Girish K S <ks.giri@samsung.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3 7/7] net: sxgbe: manage IRQ data lifetimes with devres
Date: Sat,  3 Oct 2026 16:59:38 +0800
Message-Id: <20261003085940.493951-8-yaojiale02@163.com>
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
X-CM-TRANSID:QCgvCgDXP4b_w8BqInaGCg--.62290S9
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrWxKry5XF1kZF17Xw4UCFg_yoW5uF4DpF
	ZrJas7AFsYyr4xWFs5Ww4rZFn0yw4ktFW5WFy8Jwna9r1akr1UWF18Kry0vFyrArykC3W3
	tr42vrW8uF4DZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pibo7iUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQ7+OWrAxA5F3gAA3-

sxgbe_drv_remove() frees the netdev and hardware operations while
managed IRQs remain registered until the remove callback returns. The
handlers dereference these objects, so an interrupt in that window can
access freed memory.

Allocate both objects with devres. They are acquired before the IRQs and
are consequently released only after the IRQ resources have been
removed.

This issue was found by a static analysis method used in our research.

Fixes: 1edb9ca69e8a ("net: sxgbe: add basic framework for Samsung 10Gb ethernet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 .../net/ethernet/samsung/sxgbe/sxgbe_main.c   | 26 +++++++------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
index 70cf3619555f..ada851477302 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
@@ -2007,7 +2007,7 @@ static int sxgbe_hw_init(struct sxgbe_priv_data * const priv)
 {
 	u32 ctrl_ids;
 
-	priv->hw = kmalloc_obj(*priv->hw);
+	priv->hw = devm_kmalloc(priv->device, sizeof(*priv->hw), GFP_KERNEL);
 	if(!priv->hw)
 		return -ENOMEM;
 
@@ -2058,7 +2058,7 @@ static int sxgbe_sw_reset(void __iomem *addr)
  * @plat_dat: platform data pointer
  * @addr: iobase memory address
  * Description: this is the main probe function used to
- * call the alloc_etherdev, allocate the priv structure.
+ * allocate the netdev and priv structure.
  */
 struct sxgbe_priv_data *sxgbe_drv_probe(struct device *device,
 					struct sxgbe_plat_data *plat_dat,
@@ -2069,8 +2069,8 @@ struct sxgbe_priv_data *sxgbe_drv_probe(struct device *device,
 	int ret;
 	u8 queue_num;
 
-	ndev = alloc_etherdev_mqs(sizeof(struct sxgbe_priv_data),
-				  SXGBE_TX_QUEUES, SXGBE_RX_QUEUES);
+	ndev = devm_alloc_etherdev_mqs(device, sizeof(struct sxgbe_priv_data),
+				       SXGBE_TX_QUEUES, SXGBE_RX_QUEUES);
 	if (!ndev)
 		return NULL;
 
@@ -2086,7 +2086,7 @@ struct sxgbe_priv_data *sxgbe_drv_probe(struct device *device,
 
 	ret = sxgbe_sw_reset(priv->ioaddr);
 	if (ret)
-		goto error_free_netdev;
+		goto error_return;
 
 	/* Verify driver arguments */
 	sxgbe_verify_args();
@@ -2094,16 +2094,16 @@ struct sxgbe_priv_data *sxgbe_drv_probe(struct device *device,
 	/* Init MAC and get the capabilities */
 	ret = sxgbe_hw_init(priv);
 	if (ret)
-		goto error_free_netdev;
+		goto error_return;
 
 	/* allocate memory resources for Descriptor rings */
 	ret = txring_mem_alloc(priv);
 	if (ret)
-		goto error_free_hw;
+		goto error_return;
 
 	ret = rxring_mem_alloc(priv);
 	if (ret)
-		goto error_free_hw;
+		goto error_return;
 
 	ndev->netdev_ops = &sxgbe_netdev_ops;
 
@@ -2191,11 +2191,7 @@ struct sxgbe_priv_data *sxgbe_drv_probe(struct device *device,
 	clk_put(priv->sxgbe_clk);
 error_napi_del:
 	netif_napi_del(&priv->napi);
-error_free_hw:
-	kfree(priv->hw);
-error_free_netdev:
-	free_netdev(ndev);
-
+error_return:
 	return NULL;
 }
 
@@ -2229,10 +2225,6 @@ void sxgbe_drv_remove(struct net_device *ndev)
 	clk_put(priv->sxgbe_clk);
 
 	netif_napi_del(&priv->napi);
-
-	kfree(priv->hw);
-
-	free_netdev(ndev);
 }
 
 #ifdef CONFIG_PM
-- 
2.34.1

