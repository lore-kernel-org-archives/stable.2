Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C0E38DC75
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975894; cv=none; b=up2ZURzC5V3ofFSQ0dyKEjUzm6qQBwoft62rr+J/p95ONnyft+PaOKMlncYgurGtVVgBOgnS25WAYTccTBhHhDcFrz8976AxCi1LbKKRXG+EdJVO0Trm5UQpz8N9PLEGDBBx5sKgSl49QrJo4BF6cVAZLBvcxeXg4RhcAZeQhCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975894; c=relaxed/simple;
	bh=AMkBXIjsALz6QWhw1Ggfmw+PxEJowF7rPPfdr7OBNI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOUmUZFnhpm8gf+LS7kGFZDFL7VuxzGXFn5F5Ckg9ev9dN1T1FFmAreRcKYV6/dyO0gp6azS3j79EPQxm/+m48cSYkdluNO2X7MmZ12t908xaWlFT3IoRZ4k/LqAKoH+6PoDoOaY6IC83j34hYwTbuDoOIsEAh4ckh8zMDoVHoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiWIV9lp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiWIV9lp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837F31F000FF;
	Wed,  9 Sep 2026 17:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788975893;
	bh=AF1Dtvo1OrzXr2lHX0LPGtMjDTDthAMDNZNPNLv2TxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fiWIV9lpqmKq5INM3zDAh+/shNLVLYsFHsC/3KRR/yxVbNZd+0p6zc0h9yDFj95NJ
	 v/P7ujz/EJhLj8dIMoeYHb1681EqTsHqEUhi633f0b8koLlm8LDzVWoz46Huy1GpmU
	 1XBzf15EoEkZXBmT6L2WzFK9+qvQgyTZNCVSpZbwwUNo7GfZ9clkWekxIEweRJXXI1
	 WcniDbRPd31XTkApf/t7f0TqYOEYmlufX2uyIt52hCJ6Bh3a0TAsHxJVrLhBZ0SV+y
	 0WcN1XrjxQ/vgIxfZMNkJGSIJF4IZXW3Adw1p9+Sln1IdoRwy8Jn9BciaUbgBhMZT2
	 JnGEM9/tsVi+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net: ravb: avoid dereferencing an invalid PTP clock
Date: Wed,  9 Sep 2026 13:44:50 -0400
Message-ID: <20260909174450.3342232-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090322-pulmonary-valium-161a@gregkh>
References: <2026090322-pulmonary-valium-161a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
[ adjusted context for Linux 5.10’s older ravb_get_ts_info() and ravb_probe() layouts. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/ravb.h      |  1 +
 drivers/net/ethernet/renesas/ravb_main.c |  3 ++-
 drivers/net/ethernet/renesas/ravb_ptp.c  | 15 +++++++++++++--
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 7453b17a37a2c..e41e25cdbffea 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -978,6 +978,7 @@ struct ravb_ptp_perout {
 struct ravb_ptp {
 	struct ptp_clock *clock;
 	struct ptp_clock_info info;
+	int phc_index;
 	u32 default_addend;
 	u32 current_addend;
 	int extts[N_EXT_TS];
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 3e131788a4a3c..e776560cf3788 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1270,7 +1270,7 @@ static int ravb_get_ts_info(struct net_device *ndev,
 		(1 << HWTSTAMP_FILTER_NONE) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
 		(1 << HWTSTAMP_FILTER_ALL);
-	info->phc_index = ptp_clock_index(priv->ptp.clock);
+	info->phc_index = READ_ONCE(priv->ptp.phc_index);
 
 	return 0;
 }
@@ -2119,6 +2119,7 @@ static int ravb_probe(struct platform_device *pdev)
 	priv = netdev_priv(ndev);
 	priv->ndev = ndev;
 	priv->pdev = pdev;
+	priv->ptp.phc_index = -1;
 	priv->num_tx_ring[RAVB_BE] = BE_TX_RING_SIZE;
 	priv->num_rx_ring[RAVB_BE] = BE_RX_RING_SIZE;
 	priv->num_tx_ring[RAVB_NC] = NC_TX_RING_SIZE;
diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index 6984bd5b7da91..66cd690af54b0 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -330,6 +330,7 @@ void ravb_ptp_interrupt(struct net_device *ndev)
 void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	struct ptp_clock *clock;
 	unsigned long flags;
 
 	priv->ptp.info = ravb_ptp_info;
@@ -342,7 +343,15 @@ void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
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
@@ -352,5 +361,7 @@ void ravb_ptp_stop(struct net_device *ndev)
 	ravb_write(ndev, 0, GIC);
 	ravb_write(ndev, 0, GIS);
 
-	ptp_clock_unregister(priv->ptp.clock);
+	WRITE_ONCE(priv->ptp.phc_index, -1);
+	if (priv->ptp.clock)
+		ptp_clock_unregister(priv->ptp.clock);
 }
-- 
2.53.0

