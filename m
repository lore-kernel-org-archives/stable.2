Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E544374E60
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974270; cv=none; b=iNPnEkndCnTO84F42OpA4lfLHblyL2P4221zHm9JhEmZH0y1U6KcTAGZRkJyM5sy3YU17j5vpCui267DKqorH3dKmNL+LuVuEjSFnegZ/Cm/rTJ992ro47C0cjY2VvDH9NUZ3vPU+8K/SQZcciv2UkDil///BeOlVLlnhoL9rgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974270; c=relaxed/simple;
	bh=joIws44X7GisngHo0zn0p7saEWv2vvXH9G7W2TZQWJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNIFI2Gpl3jOxOnYSxMDZPfKQzSjBLDgbikC7EWDxto7/XasoI0f2bbSy57VDWkNXGV4uvx6D6PhvqgOOzUT1WlHtYO4TyWmKSk1erbOrU/ODhpzKYV8vILXr7VG38kC7CcKYh9Pup/t5uF1eALvz0SHZsp2XPWBh10MX1kBX10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoGtUvSn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoGtUvSn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB951F000FF;
	Wed,  9 Sep 2026 17:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788974268;
	bh=mv75MPJl6XciRnOTPLHzaFVmy6OyBJU6J5gLCAty/GM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LoGtUvSn6L8toVEu3DExU/FkPf2dED0X8/+qfAfW/FRVpHIWZM2/hCCnGOWJHUaHQ
	 wtWjSZT2t3fD0ULcJLvUJFnZhG2SFYidjqfKi2e0N3WshMxCeKQM0smJ203lGCaPLd
	 YXls1tZ3j0UjiRVFhzrtVnsY+VRQClWIeju5fsM1R2DCFEuRyAUTbM45WtGB+7uvqh
	 3CT3e9jtoi+0hACmSGuyDCrg/aeb1nsiUWkSRTUEMBDkSZJG1YJmYH+PaIr+urCgMu
	 I2y9MYi7YEwKJr3uPLVsjNQs78hBNPIOU2tuasQj0VGD0jdmULGLoKJixDjxRWtLeY
	 G1I0etU9nJ6qA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/7] net: ravb: Move getting/requesting IRQs in the probe() method
Date: Wed,  9 Sep 2026 13:17:40 -0400
Message-ID: <20260909171743.3248398-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909171743.3248398-1-sashal@kernel.org>
References: <2026090333-magnolia-munchkin-24b0@gregkh>
 <20260909171743.3248398-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

[ Upstream commit 32f012b8c01ca9fd26a28134cc2165ead93c22d0 ]

The runtime PM implementation will disable clocks at the end of
ravb_probe(). As some IP variants switch to reset mode as a result of
setting module standby through clock disable APIs, to implement runtime PM
the resource parsing and requesting are moved in the probe function and IP
settings are moved in the open function. This is done because at the end of
the probe some IP variants will switch anyway to reset mode and the
registers content is lost. Also keeping only register settings operations
in the ravb_open()/ravb_close() functions will make them faster.

Commit moves IRQ requests to ravb_probe() to have all the IRQs ready when
the interface is open. As now getting/requesting IRQs is done in a single
place there is no need to keep intermediary data (like ravb_rx_irqs[] and
ravb_tx_irqs[] arrays or IRQs in struct ravb_private).

In order to avoid accessing the IP registers while the IP is runtime
suspended (e.g. in the timeframe b/w the probe requests shared IRQs and
IP clocks are enabled) in the interrupt handlers were introduced
pm_runtime_active() checks. The device runtime PM usage counter has been
incremented to avoid disabling the device's clocks while the check is in
progress (if any).

This is a preparatory change to add runtime PM support for all IP variants.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 1cb9663789c5 ("net: ravb: serialize PTP clock teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/ravb.h      |   4 -
 drivers/net/ethernet/renesas/ravb_main.c | 299 ++++++++++-------------
 2 files changed, 130 insertions(+), 173 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index e0f8276cffedd..e3506888cca6e 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1089,10 +1089,6 @@ struct ravb_private {
 	int msg_enable;
 	int speed;
 	int emac_irq;
-	int erra_irq;
-	int mgmta_irq;
-	int rx_irqs[NUM_RX_QUEUE];
-	int tx_irqs[NUM_TX_QUEUE];
 
 	unsigned no_avb_link:1;
 	unsigned avb_link_active_low:1;
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 58507bd4075e8..0da019d1a2fd5 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -40,16 +40,6 @@
 		 NETIF_MSG_RX_ERR | \
 		 NETIF_MSG_TX_ERR)
 
-static const char *ravb_rx_irqs[NUM_RX_QUEUE] = {
-	"ch0", /* RAVB_BE */
-	"ch1", /* RAVB_NC */
-};
-
-static const char *ravb_tx_irqs[NUM_TX_QUEUE] = {
-	"ch18", /* RAVB_BE */
-	"ch19", /* RAVB_NC */
-};
-
 void ravb_modify(struct net_device *ndev, enum ravb_reg reg, u32 clear,
 		 u32 set)
 {
@@ -1094,11 +1084,23 @@ static irqreturn_t ravb_emac_interrupt(int irq, void *dev_id)
 {
 	struct net_device *ndev = dev_id;
 	struct ravb_private *priv = netdev_priv(ndev);
+	struct device *dev = &priv->pdev->dev;
+	irqreturn_t result = IRQ_HANDLED;
+
+	pm_runtime_get_noresume(dev);
+
+	if (unlikely(!pm_runtime_active(dev))) {
+		result = IRQ_NONE;
+		goto out_rpm_put;
+	}
 
 	spin_lock(&priv->lock);
 	ravb_emac_interrupt_unlocked(ndev);
 	spin_unlock(&priv->lock);
-	return IRQ_HANDLED;
+
+out_rpm_put:
+	pm_runtime_put_noidle(dev);
+	return result;
 }
 
 /* Error interrupt handler */
@@ -1178,9 +1180,15 @@ static irqreturn_t ravb_interrupt(int irq, void *dev_id)
 	struct net_device *ndev = dev_id;
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
+	struct device *dev = &priv->pdev->dev;
 	irqreturn_t result = IRQ_NONE;
 	u32 iss;
 
+	pm_runtime_get_noresume(dev);
+
+	if (unlikely(!pm_runtime_active(dev)))
+		goto out_rpm_put;
+
 	spin_lock(&priv->lock);
 	/* Get interrupt status */
 	iss = ravb_read(ndev, ISS);
@@ -1224,6 +1232,9 @@ static irqreturn_t ravb_interrupt(int irq, void *dev_id)
 	}
 
 	spin_unlock(&priv->lock);
+
+out_rpm_put:
+	pm_runtime_put_noidle(dev);
 	return result;
 }
 
@@ -1232,9 +1243,15 @@ static irqreturn_t ravb_multi_interrupt(int irq, void *dev_id)
 {
 	struct net_device *ndev = dev_id;
 	struct ravb_private *priv = netdev_priv(ndev);
+	struct device *dev = &priv->pdev->dev;
 	irqreturn_t result = IRQ_NONE;
 	u32 iss;
 
+	pm_runtime_get_noresume(dev);
+
+	if (unlikely(!pm_runtime_active(dev)))
+		goto out_rpm_put;
+
 	spin_lock(&priv->lock);
 	/* Get interrupt status */
 	iss = ravb_read(ndev, ISS);
@@ -1256,6 +1273,9 @@ static irqreturn_t ravb_multi_interrupt(int irq, void *dev_id)
 	}
 
 	spin_unlock(&priv->lock);
+
+out_rpm_put:
+	pm_runtime_put_noidle(dev);
 	return result;
 }
 
@@ -1263,8 +1283,14 @@ static irqreturn_t ravb_dma_interrupt(int irq, void *dev_id, int q)
 {
 	struct net_device *ndev = dev_id;
 	struct ravb_private *priv = netdev_priv(ndev);
+	struct device *dev = &priv->pdev->dev;
 	irqreturn_t result = IRQ_NONE;
 
+	pm_runtime_get_noresume(dev);
+
+	if (unlikely(!pm_runtime_active(dev)))
+		goto out_rpm_put;
+
 	spin_lock(&priv->lock);
 
 	/* Network control/Best effort queue RX/TX */
@@ -1272,6 +1298,9 @@ static irqreturn_t ravb_dma_interrupt(int irq, void *dev_id, int q)
 		result = IRQ_HANDLED;
 
 	spin_unlock(&priv->lock);
+
+out_rpm_put:
+	pm_runtime_put_noidle(dev);
 	return result;
 }
 
@@ -1746,85 +1775,21 @@ static const struct ethtool_ops ravb_ethtool_ops = {
 	.set_wol		= ravb_set_wol,
 };
 
-static inline int ravb_hook_irq(unsigned int irq, irq_handler_t handler,
-				struct net_device *ndev, struct device *dev,
-				const char *ch)
-{
-	char *name;
-	int error;
-
-	name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s", ndev->name, ch);
-	if (!name)
-		return -ENOMEM;
-	error = request_irq(irq, handler, 0, name, ndev);
-	if (error)
-		netdev_err(ndev, "cannot request IRQ %s\n", name);
-
-	return error;
-}
-
 /* Network device open function for Ethernet AVB */
 static int ravb_open(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
-	struct platform_device *pdev = priv->pdev;
-	struct device *dev = &pdev->dev;
 	int error;
 
 	napi_enable(&priv->napi[RAVB_BE]);
 	if (info->nc_queues)
 		napi_enable(&priv->napi[RAVB_NC]);
 
-	if (!info->multi_irqs) {
-		error = request_irq(ndev->irq, ravb_interrupt, IRQF_SHARED,
-				    ndev->name, ndev);
-		if (error) {
-			netdev_err(ndev, "cannot request IRQ\n");
-			goto out_napi_off;
-		}
-	} else {
-		error = ravb_hook_irq(ndev->irq, ravb_multi_interrupt, ndev,
-				      dev, "ch22:multi");
-		if (error)
-			goto out_napi_off;
-		error = ravb_hook_irq(priv->emac_irq, ravb_emac_interrupt, ndev,
-				      dev, "ch24:emac");
-		if (error)
-			goto out_free_irq;
-		error = ravb_hook_irq(priv->rx_irqs[RAVB_BE], ravb_be_interrupt,
-				      ndev, dev, "ch0:rx_be");
-		if (error)
-			goto out_free_irq_emac;
-		error = ravb_hook_irq(priv->tx_irqs[RAVB_BE], ravb_be_interrupt,
-				      ndev, dev, "ch18:tx_be");
-		if (error)
-			goto out_free_irq_be_rx;
-		error = ravb_hook_irq(priv->rx_irqs[RAVB_NC], ravb_nc_interrupt,
-				      ndev, dev, "ch1:rx_nc");
-		if (error)
-			goto out_free_irq_be_tx;
-		error = ravb_hook_irq(priv->tx_irqs[RAVB_NC], ravb_nc_interrupt,
-				      ndev, dev, "ch19:tx_nc");
-		if (error)
-			goto out_free_irq_nc_rx;
-
-		if (info->err_mgmt_irqs) {
-			error = ravb_hook_irq(priv->erra_irq, ravb_multi_interrupt,
-					      ndev, dev, "err_a");
-			if (error)
-				goto out_free_irq_nc_tx;
-			error = ravb_hook_irq(priv->mgmta_irq, ravb_multi_interrupt,
-					      ndev, dev, "mgmt_a");
-			if (error)
-				goto out_free_irq_erra;
-		}
-	}
-
 	/* Device init */
 	error = ravb_dmac_init(ndev);
 	if (error)
-		goto out_free_irq_mgmta;
+		goto out_napi_off;
 	ravb_emac_init(ndev);
 
 	/* Initialise PTP Clock driver */
@@ -1845,26 +1810,6 @@ static int ravb_open(struct net_device *ndev)
 	if (info->gptp)
 		ravb_ptp_stop(ndev);
 	ravb_stop_dma(ndev);
-out_free_irq_mgmta:
-	if (!info->multi_irqs)
-		goto out_free_irq;
-	if (info->err_mgmt_irqs)
-		free_irq(priv->mgmta_irq, ndev);
-out_free_irq_erra:
-	if (info->err_mgmt_irqs)
-		free_irq(priv->erra_irq, ndev);
-out_free_irq_nc_tx:
-	free_irq(priv->tx_irqs[RAVB_NC], ndev);
-out_free_irq_nc_rx:
-	free_irq(priv->rx_irqs[RAVB_NC], ndev);
-out_free_irq_be_tx:
-	free_irq(priv->tx_irqs[RAVB_BE], ndev);
-out_free_irq_be_rx:
-	free_irq(priv->rx_irqs[RAVB_BE], ndev);
-out_free_irq_emac:
-	free_irq(priv->emac_irq, ndev);
-out_free_irq:
-	free_irq(ndev->irq, ndev);
 out_napi_off:
 	if (info->nc_queues)
 		napi_disable(&priv->napi[RAVB_NC]);
@@ -2219,19 +2164,6 @@ static int ravb_close(struct net_device *ndev)
 
 	cancel_work_sync(&priv->work);
 
-	if (info->multi_irqs) {
-		free_irq(priv->tx_irqs[RAVB_NC], ndev);
-		free_irq(priv->rx_irqs[RAVB_NC], ndev);
-		free_irq(priv->tx_irqs[RAVB_BE], ndev);
-		free_irq(priv->rx_irqs[RAVB_BE], ndev);
-		free_irq(priv->emac_irq, ndev);
-		if (info->err_mgmt_irqs) {
-			free_irq(priv->erra_irq, ndev);
-			free_irq(priv->mgmta_irq, ndev);
-		}
-	}
-	free_irq(ndev->irq, ndev);
-
 	if (info->nc_queues)
 		napi_disable(&priv->napi[RAVB_NC]);
 	napi_disable(&priv->napi[RAVB_BE]);
@@ -2655,6 +2587,90 @@ static void ravb_parse_delay_mode(struct device_node *np, struct net_device *nde
 	}
 }
 
+static int ravb_setup_irq(struct ravb_private *priv, const char *irq_name,
+			  const char *ch, int *irq, irq_handler_t handler)
+{
+	struct platform_device *pdev = priv->pdev;
+	struct net_device *ndev = priv->ndev;
+	struct device *dev = &pdev->dev;
+	const char *dev_name;
+	unsigned long flags;
+	int error;
+
+	if (irq_name) {
+		dev_name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s", ndev->name, ch);
+		if (!dev_name)
+			return -ENOMEM;
+
+		*irq = platform_get_irq_byname(pdev, irq_name);
+		flags = 0;
+	} else {
+		dev_name = ndev->name;
+		*irq = platform_get_irq(pdev, 0);
+		flags = IRQF_SHARED;
+	}
+	if (*irq < 0)
+		return *irq;
+
+	error = devm_request_irq(dev, *irq, handler, flags, dev_name, ndev);
+	if (error)
+		netdev_err(ndev, "cannot request IRQ %s\n", dev_name);
+
+	return error;
+}
+
+static int ravb_setup_irqs(struct ravb_private *priv)
+{
+	const struct ravb_hw_info *info = priv->info;
+	struct net_device *ndev = priv->ndev;
+	const char *irq_name, *emac_irq_name;
+	int error, irq;
+
+	if (!info->multi_irqs)
+		return ravb_setup_irq(priv, NULL, NULL, &ndev->irq, ravb_interrupt);
+
+	if (info->err_mgmt_irqs) {
+		irq_name = "dia";
+		emac_irq_name = "line3";
+	} else {
+		irq_name = "ch22";
+		emac_irq_name = "ch24";
+	}
+
+	error = ravb_setup_irq(priv, irq_name, "ch22:multi", &ndev->irq, ravb_multi_interrupt);
+	if (error)
+		return error;
+
+	error = ravb_setup_irq(priv, emac_irq_name, "ch24:emac", &priv->emac_irq,
+			       ravb_emac_interrupt);
+	if (error)
+		return error;
+
+	if (info->err_mgmt_irqs) {
+		error = ravb_setup_irq(priv, "err_a", "err_a", &irq, ravb_multi_interrupt);
+		if (error)
+			return error;
+
+		error = ravb_setup_irq(priv, "mgmt_a", "mgmt_a", &irq, ravb_multi_interrupt);
+		if (error)
+			return error;
+	}
+
+	error = ravb_setup_irq(priv, "ch0", "ch0:rx_be", &irq, ravb_be_interrupt);
+	if (error)
+		return error;
+
+	error = ravb_setup_irq(priv, "ch1", "ch1:rx_nc", &irq, ravb_nc_interrupt);
+	if (error)
+		return error;
+
+	error = ravb_setup_irq(priv, "ch18", "ch18:tx_be", &irq, ravb_be_interrupt);
+	if (error)
+		return error;
+
+	return ravb_setup_irq(priv, "ch19", "ch19:tx_nc", &irq, ravb_nc_interrupt);
+}
+
 static void ravb_set_delay_mode(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -2674,9 +2690,8 @@ static int ravb_probe(struct platform_device *pdev)
 	struct reset_control *rstc;
 	struct ravb_private *priv;
 	struct net_device *ndev;
-	int error, irq, q;
 	struct resource *res;
-	int i;
+	int error, q;
 
 	if (!np) {
 		dev_err(&pdev->dev,
@@ -2703,20 +2718,6 @@ static int ravb_probe(struct platform_device *pdev)
 	if (error)
 		goto out_free_netdev;
 
-	if (info->multi_irqs) {
-		if (info->err_mgmt_irqs)
-			irq = platform_get_irq_byname(pdev, "dia");
-		else
-			irq = platform_get_irq_byname(pdev, "ch22");
-	} else {
-		irq = platform_get_irq(pdev, 0);
-	}
-	if (irq < 0) {
-		error = irq;
-		goto out_reset_assert;
-	}
-	ndev->irq = irq;
-
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 
 	priv = netdev_priv(ndev);
@@ -2731,6 +2732,10 @@ static int ravb_probe(struct platform_device *pdev)
 		priv->num_rx_ring[RAVB_NC] = NC_RX_RING_SIZE;
 	}
 
+	error = ravb_setup_irqs(priv);
+	if (error)
+		goto out_reset_assert;
+
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		error = PTR_ERR(priv->clk);
@@ -2778,50 +2783,6 @@ static int ravb_probe(struct platform_device *pdev)
 	priv->avb_link_active_low =
 		of_property_read_bool(np, "renesas,ether-link-active-low");
 
-	if (info->multi_irqs) {
-		if (info->err_mgmt_irqs)
-			irq = platform_get_irq_byname(pdev, "line3");
-		else
-			irq = platform_get_irq_byname(pdev, "ch24");
-		if (irq < 0) {
-			error = irq;
-			goto out_rpm_put;
-		}
-		priv->emac_irq = irq;
-		for (i = 0; i < NUM_RX_QUEUE; i++) {
-			irq = platform_get_irq_byname(pdev, ravb_rx_irqs[i]);
-			if (irq < 0) {
-				error = irq;
-				goto out_rpm_put;
-			}
-			priv->rx_irqs[i] = irq;
-		}
-		for (i = 0; i < NUM_TX_QUEUE; i++) {
-			irq = platform_get_irq_byname(pdev, ravb_tx_irqs[i]);
-			if (irq < 0) {
-				error = irq;
-				goto out_rpm_put;
-			}
-			priv->tx_irqs[i] = irq;
-		}
-
-		if (info->err_mgmt_irqs) {
-			irq = platform_get_irq_byname(pdev, "err_a");
-			if (irq < 0) {
-				error = irq;
-				goto out_rpm_put;
-			}
-			priv->erra_irq = irq;
-
-			irq = platform_get_irq_byname(pdev, "mgmt_a");
-			if (irq < 0) {
-				error = irq;
-				goto out_rpm_put;
-			}
-			priv->mgmta_irq = irq;
-		}
-	}
-
 	ndev->max_mtu = info->rx_max_buf_size - (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
 	ndev->min_mtu = ETH_MIN_MTU;
 
-- 
2.53.0

