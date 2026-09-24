Received: from mnc015mcc432.ss7-reroute.local (hss.epc.mnc015.mcc432.mobile-node.net [54.38.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A1D4DA528;
	Thu, 24 Sep 2026 20:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.38.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790283396; cv=none; b=rYDsBBSKE5pdafz+co8IoKJEbChiWbHFQR2NbeHYu6BK8KFx++luqAf5P+TAw0Sh0G+10+f2MHDs/chkbqM6f13nnlw2jymiLNESL5C+ZZpshDLaqNu9HBsArRobFUdpqNPz5sbez8ZKIQPVoHhqQ6Eg7HW2xpLL/pO9MiJ4fCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790283396; c=relaxed/simple;
	bh=fjSSq2B3ljhKs9DmDbCMhWj4/1lwutAgolT6zq9Lb34=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pb240si2sFD25+Pg3uLC9PhDPouyu+CDXU2wHgsV9iUyt9G3DQeeP6XlPRLxTlr4vIyQ8PxROTDg0ZF1tR/HBeavJdXIZN3UEVPIthFiAMF/82+wGie9p0zIhgoMe+6emF4waJMShMEBnmqLp0hDc8Kl2fGoFlTsPKlu3Rhs1S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loljews.com; spf=pass smtp.mailfrom=loljews.com; dkim=pass (2048-bit key) header.d=loljews.com header.i=@loljews.com header.b=DwehfZdS; arc=none smtp.client-ip=54.38.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loljews.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loljews.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=loljews.com header.i=@loljews.com header.b="DwehfZdS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loljews.com; s=mail;
	t=1790283374; bh=yTX/3mmRu2MpDNSv8MFx0YS6Eo6ou40rWUku1ywefKk=;
	h=From:To:Cc:Subject:Date;
	b=DwehfZdS0jjpdO4RqQg4uoKnIgx7c4BS1J1AeFBuTx4A6ew988xvT/A+QsG9M0JvX
	 q8i9ks96YgR4qHLtQ7xNiNSOLlREQbloCRbHqol3Rhaq/TEfhtx9rSDr8RSINCpf9j
	 uEyzlPRE/u5GrbPbdc1a6piPaKjYvbijaOtzfx9zFHmpnWq21xBExNRhjWBHj4M5QO
	 EKtd6wD+LTtB4ZE0Az4rYWnJzjd70rylAbEiRanUf00O6nmct7H8SGAuzSoas/9Uhy
	 Y/HdyyVAFiV3VuX6U+Gr8YHsioyhbZ2fCVxydwQnmlHnwctow2mGRRbTzkpCLae5bp
	 MWI33rqz+HOpg==
Received: from mail.loljews.com (changwang [10.222.1.22])
	by postfix (Postfix) with ESMTP id A919327A07D0;
	Thu, 24 Sep 2026 23:56:14 +0300 (EEST)
From: Sandeep Haemoon <sandeeph@loljews.com>
To: netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, stable@vger.kernel.org
Subject: [PATCH net v3] net: ethernet: mtk_eth_soc: allocate dummy netdev
Date: Thu, 24 Sep 2026 23:51:37 +0300
Message-Id: <patch-e52c13380b0768fec63af04c80e4b487@loljews.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

The RX rings and the shared NAPI are carried by an internal "dummy" netdev
(eth->dummy_dev). mtk_probe() creates that dummy device, and adds the
shared tx/rx NAPI to it, only after the MAC netdevs have been registered.
That order has been there since the MT7623 support was added and leaves a
window in which the netdevs are visible to the network core before the
shared NAPI and the dummy device exist.

If anything brings the first netdev up during that window (e.g. netifd
opening the WAN link the instant the interface is registered), the
first-open path runs without them. On NETSYS v2 and later SoCs
mtk_rx_alloc() -> __xdp_rxq_info_reg() then dereferences eth->dummy_dev ==
NULL:

  WARNING: CPU: ... Missing net_device from driver

in net/core/xdp.c and mtk_open() fails with -ENODEV. On NETSYS v1 SoCs
(MT7621/MT7622/MT7623/MT7629) there is no page pool, so the same open
instead calls napi_enable() on a napi_struct that netif_napi_add() has not
initialised yet and dereferences a NULL napi->dev.

Allocate the dummy netdev and add the shared tx/rx NAPI to it before the
register_netdev() loop. Both the dummy-allocation failure and a
register_netdev() failure now unwind through mtk_unreg_dev(), which
unregisters the net_device notifiers and the netdevs registered so far,
stopping a concurrently-opened netdev (ndo_stop) and its NAPI before the
dummy carrier is freed.

A netdev that opened during the window can also have queued the
frame-engine reset worker (via the tx watchdog or phylink), so the probe
error path now cancels eth->pending_work before freeing the shared state,
as mtk_cleanup() already does on remove.

Fixes: 656e705243fd ("net-next: mediatek: add support for MT7623 ethernet")
Signed-off-by: Sandeep Haemoon <sandeeph@loljews.com>
---

Changes in v3:
  - Changelog now also covers the NETSYS v1 SoCs (MT7621/MT7622/MT7623/
    MT7629): there is no page pool, so the same early ndo_open reaches
    napi_enable() on a NAPI that netif_napi_add() has not initialised yet
    and dereferences a NULL napi->dev, not the __xdp_rxq_info_reg() WARN.
  - Fixes: now points at 656e705243fd ("net-next: mediatek: add support for
    MT7623 ethernet"), which introduced the register_netdev()-before-
    init_dummy_netdev() ordering, rather than b209bd6d0bff, which only turned
    the embedded dummy_dev into a late-allocated pointer.
  - The probe error path now cancels eth->pending_work before freeing the
    dummy carrier and the rest of the shared state: a netdev opened during the
    window can have queued the frame-engine reset worker (tx watchdog or
    phylink), which takes rtnl and drives the hardware.
  - Rebased on current net (includes Lorenzo's unregister-net-devices fix).

The notifier-unregister gap on the pre-register error paths (devm_request_irq()/
mtk_mdio_init()/mtk_ppe_init() failures) flagged in the same review is
pre-existing and intentionally left for a separate change.
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 38 ++++++++++++++-------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 2ea5dfe85..ad0fdc413 100644
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
@@ -5376,6 +5380,16 @@ static int mtk_probe(struct platform_device *pdev)
 err_unreg_netdev:
 	mtk_unreg_dev(eth);
 err_deinit_ppe:
+	/* A netdev opened while probe was still registering can have queued
+	 * the frame-engine reset worker, which takes rtnl and drives the
+	 * hardware; cancel it before anything below is torn down.
+	 */
+	cancel_work_sync(&eth->pending_work);
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

