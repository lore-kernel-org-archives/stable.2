Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F338339395
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973633; cv=none; b=V5jIBQWflkqKYxAil1Mh4kg9GXvzMz1aK1JOgSOg+sgyiBEU1SC3KoMWwdH8cUIOfuB5b6sMQgmewDWiOEpDTveWeMgSq05LHJbwPmNqg+W2wNgT+wHK6Xh/rzKw4wGQWO7pmWkHdX447Bc+89q66hUz89Srdx6d0qX9ZNB6saQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973633; c=relaxed/simple;
	bh=OeIWVz0FBUMMNilMHGSqbM55aTmErnEf8TwXHESb2cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WoUUaP4j1BvUQZ+ruLrjjyO/OFUaxQGUWW4bIb5ghXOoZSaCNbVjNm7G5yDa5thaEgUicEXfLlEk7CZW9H+VcCapIse7RtUBcWh+Av9ZWBnljh42Z3TYmXP/LDtFTIUNxYV6GGz4G29WVu9mS4CMW3S6thLJi4zJLUB9G1BLJ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmJKsBd6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmJKsBd6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB491F00898;
	Wed,  9 Sep 2026 17:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973632;
	bh=ObWaDUuHe+qVQlPZ17gy6S8/q6/YUyr/3cY3TLBDRkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HmJKsBd6ex0jXFJYy3flZ/ak/w3xH6F0ygj2j3s6FF8q+F+HfLIuaiJXSKizDjdwb
	 /22vMG87P38qp3V4DBi9Z1uaztEl1GhUidxXTUs6v44TDCKk/7YspiC++A98/ff0Br
	 n8K+B5gXqTGpnI4vUb39LFekFkonm22rJDCVOyqUT5kZIS4t+sIwN1Uyg1ETM9QuEL
	 OhE67Ga6rMdXTLrvxgslj/srIQzXFj++/R+ESxD097qjRDyR4y6F7Kmj09uqgdE6e4
	 JJnyw8bWx6JDE51QY5gbDsLHcscFrrVc2AIHpmPq2x6bkeUfXltD4++C4VWAN2n/oe
	 cJM11txgzO26Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] net: ravb: avoid dereferencing an invalid PTP clock
Date: Wed,  9 Sep 2026 13:07:01 -0400
Message-ID: <20260909170701.3189413-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909170701.3189413-1-sashal@kernel.org>
References: <2026090322-boss-emu-7014@gregkh>
 <20260909170701.3189413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

[ Upstream commit 1f77af0aaf277413ff32f6ff8c2c4282bd64c897 ]

The PTP clock is unavailable before the first open, so querying its
index can dereference a NULL pointer. Registration failures can also
leave an error pointer in priv->ptp.clock.

Cache the PHC index separately and report -1 while no clock is
registered. Normalize registration errors to NULL and preserve the
static timestamping capabilities.

Fixes: a0d2f20650e8 ("Renesas Ethernet AVB PTP clock driver")
Cc: stable@vger.kernel.org
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Link: https://patch.msgid.link/20260811103733.62599-2-xuanqiang.luo@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/ravb.h      |  1 +
 drivers/net/ethernet/renesas/ravb_main.c |  3 ++-
 drivers/net/ethernet/renesas/ravb_ptp.c  | 15 +++++++++++++--
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index a475f54a6b63c..33486234c1218 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -973,6 +973,7 @@ struct ravb_ptp_perout {
 struct ravb_ptp {
 	struct ptp_clock *clock;
 	struct ptp_clock_info info;
+	int phc_index;
 	u32 default_addend;
 	u32 current_addend;
 	int extts[N_EXT_TS];
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 2e36be812945a..9b7b66fcfce8d 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1334,7 +1334,7 @@ static int ravb_get_ts_info(struct net_device *ndev,
 			(1 << HWTSTAMP_FILTER_NONE) |
 			(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
 			(1 << HWTSTAMP_FILTER_ALL);
-		info->phc_index = ptp_clock_index(priv->ptp.clock);
+		info->phc_index = READ_ONCE(priv->ptp.phc_index);
 	}
 
 	return 0;
@@ -2247,6 +2247,7 @@ static int ravb_probe(struct platform_device *pdev)
 	priv->rstc = rstc;
 	priv->ndev = ndev;
 	priv->pdev = pdev;
+	priv->ptp.phc_index = -1;
 	priv->num_tx_ring[RAVB_BE] = BE_TX_RING_SIZE;
 	priv->num_rx_ring[RAVB_BE] = BE_RX_RING_SIZE;
 	priv->num_tx_ring[RAVB_NC] = NC_TX_RING_SIZE;
diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index c099656dd75b6..ac73ca2a98f8d 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -332,6 +332,7 @@ void ravb_ptp_interrupt(struct net_device *ndev)
 void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	struct ptp_clock *clock;
 	unsigned long flags;
 
 	priv->ptp.info = ravb_ptp_info;
@@ -344,7 +345,15 @@ void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
 	ravb_modify(ndev, GCCR, GCCR_TCSS, GCCR_TCSS_ADJGPTP);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	priv->ptp.clock = ptp_clock_register(&priv->ptp.info, &pdev->dev);
+	clock = ptp_clock_register(&priv->ptp.info, &pdev->dev);
+	if (IS_ERR(clock)) {
+		netdev_err(ndev, "failed to register PTP clock: %pe\n", clock);
+		clock = NULL;
+	}
+
+	priv->ptp.clock = clock;
+	if (clock)
+		WRITE_ONCE(priv->ptp.phc_index, ptp_clock_index(clock));
 }
 
 void ravb_ptp_stop(struct net_device *ndev)
@@ -354,5 +363,7 @@ void ravb_ptp_stop(struct net_device *ndev)
 	ravb_write(ndev, 0, GIC);
 	ravb_write(ndev, 0, GIS);
 
-	ptp_clock_unregister(priv->ptp.clock);
+	WRITE_ONCE(priv->ptp.phc_index, -1);
+	if (priv->ptp.clock)
+		ptp_clock_unregister(priv->ptp.clock);
 }
-- 
2.53.0

