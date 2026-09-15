Received: from hwlt.ccpay.ir (hss.epc.mnc015.mcc432.mobile-node.net [54.38.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99504BD790;
	Tue, 15 Sep 2026 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.38.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789498993; cv=none; b=bawkIMe6yDE6Oc4zyNG+9TTflEm3dJ6JWvxySyHiKH9+ANQt7vdQJpYkq7ZA1076y39JxWdTFher83uzDpmlB632FvXJd8/85nEdlmzygA+y0dzh1ppODJLklWY6yQzI4vs53j9U8x+DstziEZE9LPF0DHSNiABtWCcZrO2EP14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789498993; c=relaxed/simple;
	bh=h9ghKK09gVcM32xoOFGr0DekNXQ9tlRaf4xgQstMEmM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lHpRDuT+uK5Qfj2HvuF3c6CHHoo6ZY899LR7T4A8yJbGEj53zEk2izE4DoyxA8GcDul+c5r3CIR8i89YhEx5JimssJng6CZk3yT6pG4JeCyeccKXTO723IKJaVgzNbEM9th1diEkLSwcbpeoZwhSfcLnLnwg7vV8AiqZX3I9ytw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loljews.com; spf=pass smtp.mailfrom=loljews.com; arc=none smtp.client-ip=54.38.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loljews.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loljews.com
Received: from loljews.com (changwang [10.222.1.22])
	by changwang (Postfix) with ESMTP id 1262027A3383;
	Tue, 15 Sep 2026 21:55:54 +0300 (EEST)
From: Sandeep Haemoon <sandeeph@loljews.com>
To: netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 stable@vger.kernel.org
Subject: [PATCH] net: ethernet: mtk_eth_soc: allocate dummy netdev before
 registering netdevs
Date: Tue, 15 Sep 2026 21:55:54 +0300
Message-ID: <patch-12c1a57b1d914b28b89455f24de55ee4@loljews.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
From: Sandeep Haemoon <sandeeph@loljews.com>
Date: Tue, 15 Sep 2026 22:00:00 +0300
Subject: [PATCH] net: ethernet: mtk_eth_soc: allocate dummy netdev before reg=
istering netdevs

The DMA ring and NAPI are shared between the multiple MAC netdevs and are
carried by an internal "dummy" netdev (eth->dummy_dev). mtk_probe() creates
that dummy device only after the MAC netdevs have been registered, so for a
brief window the netdevs are visible to the network core while
eth->dummy_dev is still NULL.

If anything brings the first netdev up during that window (e.g. netifd
opening the WAN link the instant the interface is registered), mtk_open()
takes the first-open path and runs mtk_start_dma() -> mtk_dma_init() ->
mtk_rx_alloc(), which calls __xdp_rxq_info_reg() with eth->dummy_dev =3D=3D
NULL. That triggers

  WARNING: CPU: ... Missing net_device from driver

in net/core/xdp.c and returns -ENODEV, so mtk_open() fails and the
interface (e.g. the WAN port on MediaTek MT7988) stays down until it is
manually brought up after probe has completed.

Allocate the dummy netdev and add the shared tx/rx NAPI to it before
registering the MAC netdevs, and free it from the probe error path instead
of the now-unneeded err_unreg_netdev cleanup.

Signed-off-by: Sandeep Haemoon <sandeeph@loljews.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 31 ++++++++++++++--------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethern=
et/mediatek/mtk_eth_soc.c
index fd7a49a..ae6a19b 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -5337,6 +5337,22 @@ static int mtk_probe(struct platform_device *pdev)
 		}
 	}
=20
+	/* we run 2 devices on the same DMA ring so we need a dummy device
+	 * for NAPI to work. Allocate it before registering the netdevs so a
+	 * concurrent ndo_open (e.g. netifd bringing the first netdev up) never
+	 * observes eth->dummy_dev =3D=3D NULL, which would make mtk_rx_alloc() ->
+	 * __xdp_rxq_info_reg() warn ("Missing net_device from driver",
+	 * net/core/xdp.c) and leave the interface down on boot.
+	 */
+	eth->dummy_dev =3D alloc_netdev_dummy(0);
+	if (!eth->dummy_dev) {
+		err =3D -ENOMEM;
+		dev_err(eth->dev, "failed to allocated dummy device\n");
+		goto err_deinit_ppe;
+	}
+	netif_napi_add(eth->dummy_dev, &eth->tx_napi, mtk_napi_tx);
+	netif_napi_add(eth->dummy_dev, &eth->rx_napi, mtk_napi_rx);
+
 	for (i =3D 0; i < MTK_MAX_DEVS; i++) {
 		if (!eth->netdev[i])
 			continue;
@@ -5351,17 +5367,6 @@ static int mtk_probe(struct platform_device *pdev)
 				   eth->netdev[i]->base_addr, eth->irq[MTK_FE_IRQ_SHARED]);
 	}
=20
-	/* we run 2 devices on the same DMA ring so we need a dummy device
-	 * for NAPI to work
-	 */
-	eth->dummy_dev =3D alloc_netdev_dummy(0);
-	if (!eth->dummy_dev) {
-		err =3D -ENOMEM;
-		dev_err(eth->dev, "failed to allocated dummy device\n");
-		goto err_unreg_netdev;
-	}
-	netif_napi_add(eth->dummy_dev, &eth->tx_napi, mtk_napi_tx);
-	netif_napi_add(eth->dummy_dev, &eth->rx_napi, mtk_napi_rx);
=20
 	platform_set_drvdata(pdev, eth);
 	schedule_delayed_work(&eth->reset.monitor_work,
@@ -5369,9 +5374,9 @@ static int mtk_probe(struct platform_device *pdev)
=20
 	return 0;
=20
-err_unreg_netdev:
-	mtk_unreg_dev(eth);
 err_deinit_ppe:
+	if (eth->dummy_dev)
+		free_netdev(eth->dummy_dev);
 	mtk_ppe_deinit(eth);
 	mtk_mdio_cleanup(eth);
 err_free_dev:
--=20
2.39.2
