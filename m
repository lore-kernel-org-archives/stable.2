Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7522628505E;
	Sun, 27 Sep 2026 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790507460; cv=none; b=GcXFDcW8FCnbkoA1vOKs7Js0NhPyiezTc7h0q3eGfdi5ufMUDra/VUJ/nc/WsVASsMO9Y3iOIs0zEUhCpxSILmFMVAzxChRKSzYogg/bzNqk1bkP1LI2l0GeHsWc09VjFciqMcwfpA+161Z+Bbv+btk0qoEtIddvZMWBTiu83A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790507460; c=relaxed/simple;
	bh=+gWqokALhrhHgpmCUOKIq2I4EavhWzxSFrfB0Fqjta4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cSc0e0JCb9pyLPwOZtZwdLNK8YThmKriLgSgULcixRKLyYXBs3GVN6o9YdSCQV/YqZG/rTlv4Wr4sWQffx9r3eFO//ZSM6pUILZ2/Oynf1YGDJj0uB392gvIpFCybjPosBXRBf8WcDFNNwFTckPDwBmRZqQ8CSOgxV8aEG9WrT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VCf4Ip2K; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VCf4Ip2K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=8k
	WsfFt/JbdZa2dkHuJUkxweuGkxZHYwJiRCI5KJLj8=; b=VCf4Ip2KMqMsn8AxEH
	a0Xq0a6cOsahc3LEv7Ai0fg1KODyCkhgwlFHTDUgAslshtpZ49chNkvys0HYAoNn
	yp4EaJd0jEStUc9McD0ld4fIoxtPQHk3c53Sl0ehZInEcrjcpS0W6mA9zxSS3zaA
	JDbQke2o0wIfeCGkAmvWiwazo=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3_92P+bhqB9V5BA--.4648S9;
	Sun, 27 Sep 2026 19:10:17 +0800 (CST)
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
Subject: [PATCH 7/7] net: sxgbe: manage IRQ data lifetimes with devres
Date: Sun, 27 Sep 2026 19:10:04 +0800
Message-Id: <20260927111005.1035089-8-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3_92P+bhqB9V5BA--.4648S9
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrWxKry5XF1kZF17Xw4UCFg_yoW5ur1UpF
	ZrJas7AFsYyr4xWFs5Ww4fZFn0yw4ktFW5WFy8twna9r1akr1UWFyxKry0vFyrArykC3W3
	tr42vrWruF4DZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEdcTdUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhptp2q4+ZpiWQAA3U

sxgbe_drv_remove() frees the netdev and hardware operations while
managed IRQs remain registered until the remove callback returns. The
handlers dereference these objects, so an interrupt in that window can
access freed memory.

Allocate both objects with devres. They are acquired before the IRQs and
are consequently released only after the IRQ resources have been
removed.

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

