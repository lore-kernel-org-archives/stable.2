Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D9430D402;
	Fri,  4 Sep 2026 03:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491100; cv=none; b=DeH2uqISU71r6evQdh8b8tVaqRcC9mlXg9E3RXi0hurB0oK35wMyzOWp2VlzScNRS6nBCn+bFJihRei7VlVgDd2V6IwDPVXJ7Qa9Tr0jaDtwl2v9ZHc5rzBYm5D+LjLRyfhIrxoFlWn7W6uIaS0WCd8BJSbqKU0cyBn5JRT/538=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491100; c=relaxed/simple;
	bh=Aq69RAkA6FKjqCIzGzLfmtFZtVEuLApBuB2X99ZA0Cg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oIdY+1gruhO8umWRn7V/eUQG+MV+9jrYor49LGBIDgWXsqSOBBOl9SZKo87CBNbtwkK5nytY2Ok47yMBUApwp82l6wsDQu3NIHrEIv9Yvaox5ANyB3jRZ0ulHai7skjTHL/v+OUNqYTiR/sSYgWTma/W74TdB09aoB1I14f687Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=LwEWueuJ; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="LwEWueuJ"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c7f007bc;
	Fri, 4 Sep 2026 11:04:45 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH net v2] net: macb: initialize PTP state before registering clock
Date: Fri,  4 Sep 2026 11:04:39 +0800
Message-Id: <20260904030439.3994047-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260830153520.2710520-1-runyu.xiao@seu.edu.cn>
References: <20260830153520.2710520-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa06a60347203a1kunmd3a8a79322e9a
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaS0JKVkIYTB9KSU1DT0hDGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=LwEWueuJAACMNaAuOMikf3ktS1QF5kerIEBzfET/wpAsQJuloQPmEm1PnQR2q+Kyq7KIHLyVUcH9tShqhRraWPWLMXd3TwnKSoO1sF//zhL9veypjkdAOySFZ/Vbcc4n3GYzrLMdWL+J3m874TWhHoH4uXemeHFcTQsyNSWFMbY=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=WfbpHR/gm8DXEUdNxy+PXw4d5T9/+OG1QRUdwnFdjJE=;
	h=date:mime-version:subject:message-id:from;

gem_ptp_init() registers the PTP clock before initializing
bp->tsu_clk_lock and the TSU hardware. Since ptp_clock_register()
publishes the PTP character device, userspace may invoke PTP callbacks
before the lock and hardware are ready.

In addition, gem_ptp_init() is called from both the interface open and
resume paths. Reinitializing tsu_clk_lock there can reset the lock while
timestamp processing is using it.

Initialize tsu_clk_lock once during probe and initialize the TSU before
registering the PTP clock.

Fixes: ab91f0a9b5f4 ("net: macb: Add hardware PTP support")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260830153520.2710520-1-runyu.xiao@seu.edu.cn/
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
v2:
- Initialize tsu_clk_lock once during probe and initialize the TSU before
  registering the PTP clock.
---
 drivers/net/ethernet/cadence/macb_main.c | 1 +
 drivers/net/ethernet/cadence/macb_ptp.c  | 6 +-----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 76ee4f506..01b42b21a 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5876,6 +5876,7 @@ static int macb_probe(struct platform_device *pdev)
 	}
 	spin_lock_init(&bp->lock);
 	spin_lock_init(&bp->stats_lock);
+	spin_lock_init(&bp->tsu_clk_lock);
 
 	/* setup capabilities */
 	macb_configure_caps(bp, macb_config);
diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index e5195d7da..e9c9c2692 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -334,6 +334,7 @@ void gem_ptp_init(struct net_device *netdev)
 	bp->tsu_rate = bp->ptp_info->get_tsu_rate(bp);
 	bp->ptp_clock_info.max_adj = bp->ptp_info->get_ptp_max_adj();
 	gem_ptp_init_timer(bp);
+	gem_ptp_init_tsu(bp);
 	bp->ptp_clock = ptp_clock_register(&bp->ptp_clock_info, &netdev->dev);
 	if (IS_ERR(bp->ptp_clock)) {
 		pr_err("ptp clock register failed: %ld\n",
@@ -345,10 +346,6 @@ void gem_ptp_init(struct net_device *netdev)
 		return;
 	}
 
-	spin_lock_init(&bp->tsu_clk_lock);
-
-	gem_ptp_init_tsu(bp);
-
 	dev_info(&bp->pdev->dev, "%s ptp clock registered.\n",
 		 GEM_PTP_TIMER_NAME);
 }
@@ -467,4 +464,3 @@ int gem_set_hwtst(struct net_device *netdev,
 
 	return 0;
 }
-
-- 
2.34.1
