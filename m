Received: from mnc015mcc432.ss7-reroute.local (hss.epc.mnc015.mcc432.mobile-node.net [54.38.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B31D3A9612;
	Sun, 20 Sep 2026 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.38.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789925920; cv=none; b=GTe5xuHGk9fTNDEEjGSnXxLAlVC5bgDDxIAztyqvwySTB4aXEiJ/OQRk+XAv03AxrkQ1TdJeY22Jc7hOuSymKvoGV0nufAz4MX+eiXBrXiAEQ1boSrjx/GPctcqMxFFJuphGW0yR9pl08YrqANFqPLDV10mPeBjPjxo8D3RUzaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789925920; c=relaxed/simple;
	bh=BFWxtLpjdhG4PSirV3O/j5PXlgZSxMjUcbtLx5OvGEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPTXJOSU7gMFKoNheh7sV7SHo6JY8NVlHfVFjJaivyyPbIqfuBodz2VTaw2FHVm5PfznGAvXWcjAgY12tfKo+Caw/Sg5mQGdFPBejQfxdDWW0+tfafmx9e/TTickBMwhpP2TNL3qsF4+bSo9E2TF2+RqdeZ7Co7HPis/XhdMd9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loljews.com; spf=pass smtp.mailfrom=loljews.com; dkim=pass (2048-bit key) header.d=loljews.com header.i=@loljews.com header.b=dTZk3pMO; arc=none smtp.client-ip=54.38.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loljews.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loljews.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=loljews.com header.i=@loljews.com header.b="dTZk3pMO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loljews.com; s=mail;
	t=1789925902; bh=rMvW9g6b98IWmu/JxIOw/6+KL8WT93Bp4R/k6rj/XJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dTZk3pMOej0d2q3Dfxd4QN0BsHtpOZoCmzzXkki9UFSZTDdAB+8Qf/EkbgjgGw0PR
	 O7e6HO3zKYWc9zMM7qA0uiKaAB9mK6j/CknHt375kpWFd1kRGkqNNyzi2y8mwv8QJ2
	 uPWZQu/pfU4YtNuekXOVRFLzihZqe7zhj2LIzLuFDCyG2JBU/MGim1v6rDwZd+amG9
	 ttdNDxgFpz0plhbRnZ474FoErx3BB/HHFFqNVHPRkm5/V9RZW0ONVRRO/4OM7s1AbQ
	 fPelRVMveV4Qg2C8LLDHlTX9Xb0JKxLrUJ0+0hyGnzdVVk51wLHNwFD8XCeUKnpcvO
	 2ikMYVV9MBzgg==
Received: from mail.loljews.com (changwang [10.222.1.22])
	by postfix (Postfix) with ESMTP id 4253D27A07E5;
	Sun, 20 Sep 2026 20:38:22 +0300 (EEST)
From: Sandeep Haemoon <sandeeph@loljews.com>
To: netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, stable@vger.kernel.org
Subject: [PATCH net v2] net: ethernet: mtk_eth_soc: allocate dummy netdev before registering netdevs
Date: Sun, 20 Sep 2026 20:38:15 +0300
Message-Id: <patch-33e50d280ef35a7fd2f2dc09deea463a@loljews.com>
In-Reply-To: <patch-12c1a57b1d914b28b89455f24de55ee4@loljews.com>
References: <patch-12c1a57b1d914b28b89455f24de55ee4@loljews.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

The RX rings and the shared NAPI are carried by an internal "dummy" netdev
(eth->dummy_dev). mtk_probe() creates that dummy device only after the MAC
netdevs have been registered, so for a brief window the netdevs are visible
to the network core while eth->dummy_dev is still NULL.

If anything brings the first netdev up during that window (e.g. netifd
opening the WAN link the instant the interface is registered), mtk_open()
takes the first-open path and runs mtk_start_dma() -> mtk_dma_init() ->
mtk_rx_alloc(), which calls __xdp_rxq_info_reg() with eth->dummy_dev ==
NULL. That triggers

  WARNING: CPU: ... Missing net_device from driver

in net/core/xdp.c and returns -ENODEV, so mtk_open() fails and the
interface stays down until it is manually brought up once probe finishes.

Allocate the dummy netdev and add the shared tx/rx NAPI to it before the
register_netdev() loop. Both the dummy-allocation failure and a
register_netdev() failure now unwind through mtk_unreg_dev(), which
unregisters the net_device notifiers and the netdevs registered so far -
stopping a concurrently-opened netdev (ndo_stop) and its NAPI before the
dummy carrier is freed. The never-registered netdevs are skipped thanks to
the NETREG_REGISTERED guard in mtk_unreg_dev() and freed directly.

Fixes: b209bd6d0bff ("net: mediatek: mtk_eth_sock: allocate dummy net_device dynamically")
Signed-off-by: Sandeep Haemoon <sandeeph@loljews.com>
---
Version 2:
  - Rebased on top of netdev/net.git, which now carries Lorenzo Bianconi's
    "mtk_eth_soc: unregister net_devices in case of probe failure" fix; the
    dummy allocation sits before the register_netdev() loop and both its
    failure and a register_netdev() failure unwind through mtk_unreg_dev(),
    unregistering the net_device notifiers and every netdev registered so
    far (never-registered ones are skipped by the NETREG_REGISTERED guard)
    before the dummy carrier is freed.
  - Error path stops any concurrently-opened netdev (ndo_stop, NAPI
    disabled) via that unregister, then frees the dummy carrier; a
    dummy-allocation failure likewise cleans the notifier chain that
    mtk_add_mac() registered.
  - Add Fixes: b209bd6d0bff, the commit that made eth->dummy_dev dynamic
    and introduced the NULL window.

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 33 +++++++++++++--------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 2ea5dfe85..5e7d8b8be 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -5341,6 +5341,22 @@ static int mtk_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* we run 2 devices on the same DMA ring so we need a dummy device
+	 * for NAPI to work. Allocate it before registering the netdevs so a
+	 * concurrent ndo_open (e.g. netifd bringing the first netdev up the
+	 * instant it is registered) never observes eth->dummy_dev == NULL in
+	 * mtk_dma_init() -> mtk_rx_alloc() -> __xdp_rxq_info_reg() (net/core/xdp.c
+	 * "Missing net_device from driver") and fails the first open.
+	 */
+	eth->dummy_dev = alloc_netdev_dummy(0);
+	if (!eth->dummy_dev) {
+		err = -ENOMEM;
+		dev_err(eth->dev, "failed to allocated dummy device\n");
+		goto err_unreg_netdev;
+	}
+	netif_napi_add(eth->dummy_dev, &eth->tx_napi, mtk_napi_tx);
+	netif_napi_add(eth->dummy_dev, &eth->rx_napi, mtk_napi_rx);
+
 	for (i = 0; i < MTK_MAX_DEVS; i++) {
 		if (!eth->netdev[i])
 			continue;
@@ -5355,18 +5371,6 @@ static int mtk_probe(struct platform_device *pdev)
 				   eth->netdev[i]->base_addr, eth->irq[MTK_FE_IRQ_SHARED]);
 	}
 
-	/* we run 2 devices on the same DMA ring so we need a dummy device
-	 * for NAPI to work
-	 */
-	eth->dummy_dev = alloc_netdev_dummy(0);
-	if (!eth->dummy_dev) {
-		err = -ENOMEM;
-		dev_err(eth->dev, "failed to allocated dummy device\n");
-		goto err_unreg_netdev;
-	}
-	netif_napi_add(eth->dummy_dev, &eth->tx_napi, mtk_napi_tx);
-	netif_napi_add(eth->dummy_dev, &eth->rx_napi, mtk_napi_rx);
-
 	platform_set_drvdata(pdev, eth);
 	schedule_delayed_work(&eth->reset.monitor_work,
 			      MTK_DMA_MONITOR_TIMEOUT);
@@ -5376,6 +5380,11 @@ static int mtk_probe(struct platform_device *pdev)
 err_unreg_netdev:
 	mtk_unreg_dev(eth);
 err_deinit_ppe:
+	if (eth->dummy_dev) {
+		netif_napi_del(&eth->tx_napi);
+		netif_napi_del(&eth->rx_napi);
+		free_netdev(eth->dummy_dev);
+	}
 	mtk_ppe_deinit(eth);
 	mtk_mdio_cleanup(eth);
 err_free_dev:
-- 
2.53.0


