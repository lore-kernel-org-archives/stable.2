Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD3B35E94F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974080; cv=none; b=RI1YqCbXy/dGTEXTp9V3aVEFGxmgH85BvzRuyaWHJT6NVSkMrXah02oqdJSfBQpHEl29SR6C+kVLRmbZneMJo7ykDBiyqAjPWWYpjFrQ0n7hQBZ5ohw5Aai4CETMhWWwB5GaSXOumtnAIgX08kIb6RvDpN3/qlzB8mEFGo9k414=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974080; c=relaxed/simple;
	bh=4Kp8496Dvvs8QWtTioiKo0Zl4UMLGY43/o1Jzp2hyjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjgA0PQPTzIn4D2oxI4xrGE6Pc0fM/JK8JYrkk1pGSfbbEm6dztwLif1cdrP8wQP1zBioRH03Aqgo+d7OvTaOhajmyE+0NFCq1TJoA9RWPhEn0oKTYi0BLwrOhHpUY+V05WQQrH8KF6ZiVHGbNPpaoAmNs1wJGrlXjjWP80qzzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4TijkmT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4TijkmT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357101F000FF;
	Wed,  9 Sep 2026 17:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788974078;
	bh=b6ctqXcIR2smcfkvfprGz/3D/q6pjrQmGrE5PxuZdNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O4TijkmTIQzdXpBbaW7vnGxSHvUdL4yw0tNJFiELK1zJYD/naUSaYAUriGcNWIbeY
	 dzgupjhYUY+QqzuPVZXt9eMgEN96S6kjWx+Tuxm8w+jBxcP5DGNhO7qVkAvO/u8R+p
	 xSrZzJJwi0ddMCpf0Lb6I4VzZQtHG2cMwuI5cWR2eEjlv3fyFGQX9T8Lhm4Uky401f
	 npwaqj5Og/yEcr/ahNw5t7NRUqkJkRoP+0o+aNKVMtCNVf+O/aRNQgnAOYmerqOyLS
	 HQTo5ypRxOz4WzSoi3GFnp6d4Q61BoqzJ9v5haz36FoTCvR3D9L2HvX0zpjsm6dRP9
	 7ZLOTJO1XYdaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 6/7] net: ravb: avoid dereferencing an invalid PTP clock
Date: Wed,  9 Sep 2026 13:14:29 -0400
Message-ID: <20260909171431.3234845-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909171431.3234845-1-sashal@kernel.org>
References: <2026090333-maroon-numerate-89b5@gregkh>
 <20260909171431.3234845-1-sashal@kernel.org>
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
Stable-dep-of: 1cb9663789c5 ("net: ravb: serialize PTP clock teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/ravb.h      |  1 +
 drivers/net/ethernet/renesas/ravb_main.c |  3 ++-
 drivers/net/ethernet/renesas/ravb_ptp.c  | 15 +++++++++++++--
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index e3506888cca6e..8bd94180113d2 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1005,6 +1005,7 @@ struct ravb_ptp_perout {
 struct ravb_ptp {
 	struct ptp_clock *clock;
 	struct ptp_clock_info info;
+	int phc_index;
 	u32 default_addend;
 	u32 current_addend;
 	int extts[N_EXT_TS];
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 35b58ffb5c2d6..b2fe8c45ce936 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1713,7 +1713,7 @@ static int ravb_get_ts_info(struct net_device *ndev,
 			(1 << HWTSTAMP_FILTER_NONE) |
 			(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
 			(1 << HWTSTAMP_FILTER_ALL);
-		info->phc_index = ptp_clock_index(priv->ptp.clock);
+		info->phc_index = READ_ONCE(priv->ptp.phc_index);
 	}
 
 	return 0;
@@ -2712,6 +2712,7 @@ static int ravb_probe(struct platform_device *pdev)
 	priv->rstc = rstc;
 	priv->ndev = ndev;
 	priv->pdev = pdev;
+	priv->ptp.phc_index = -1;
 	priv->num_tx_ring[RAVB_BE] = BE_TX_RING_SIZE;
 	priv->num_rx_ring[RAVB_BE] = BE_RX_RING_SIZE;
 	if (info->nc_queues) {
diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index 6e4ef7af27bf3..fd674f1210865 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -325,6 +325,7 @@ void ravb_ptp_interrupt(struct net_device *ndev)
 void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	struct ptp_clock *clock;
 	unsigned long flags;
 
 	priv->ptp.info = ravb_ptp_info;
@@ -337,7 +338,15 @@ void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
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
@@ -347,5 +356,7 @@ void ravb_ptp_stop(struct net_device *ndev)
 	ravb_write(ndev, 0, GIC);
 	ravb_write(ndev, 0, GIS);
 
-	ptp_clock_unregister(priv->ptp.clock);
+	WRITE_ONCE(priv->ptp.phc_index, -1);
+	if (priv->ptp.clock)
+		ptp_clock_unregister(priv->ptp.clock);
 }
-- 
2.53.0

