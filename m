Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE9413776B
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611952; cv=none; b=ep+50HjgPnifMcZMGdApRGRz0K2kRyeyhsevvdYXlWuK7AGNPhrkv7aESY5ZNqVnFReJJadVThzMfqoAg2wi64dA1uQk8GoAyRiB0U8YD+fIbcQM4K13BumboeQpXnJf9P57pgyqa1uT0TQIdqTjTxGc+s8FmG/wkJIcfXciXtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611952; c=relaxed/simple;
	bh=zzJOLKdTbBhmdji+yROZmbXXu6fA00jHjTf9utom8lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DTFsp9LJycCw+ORdD/vbRvdMpu5VSzGR0vemwys3SSSkEsZCHhGx+hqZysDNmUdevjcv1+rPFhZdTt/FVM8VeASFD+S9WOF6MjmasTGYwkPyEiHGG3GC5BYSwmDXMWCssUb1SJCnytw+jJ0MEmPqenZXE8pOyn3JzjBDtmhKLQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnSjN/md; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnSjN/md"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D101F00893;
	Thu, 17 Sep 2026 02:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611950;
	bh=+b+7t303eEc2bZUsn8qcG9h5Zdbj63L732JcWTGLiys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YnSjN/md8pJ7kPiSAfB5rRC3vGIdeo4mQthnnjFyDk481PoBEP5g9rfHW0Pqpf7cE
	 K5vRj02SS/YcaywwQ76Xs4FTd0x6Tzg0dx4A/nC8FOi7JB+TcgORofP9c4dt8RPn7e
	 wco0rp3UENaHPJCpM9aTkBgW7nzxcXXAZmeNtdojwa1WRxqMz+Ns7JCfHg41+mGnKz
	 1k6sLsPdyEOeAezNYaGpGyH/Yjr8cMqHoMqgLs3pyF33aRttosuPu/99Uk6UcktPyK
	 5DtxDkzb1W3YKjYqNshyDf4O12Si148wZpoj9ggwBQ38oVpT5hg15OiZTG1W0Cg5eD
	 Ch0T7t0OUpzVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] net: macb: initialize PTP state before registering clock
Date: Wed, 16 Sep 2026 22:25:47 -0400
Message-ID: <20260917022547.3826863-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917022547.3826863-1-sashal@kernel.org>
References: <2026091649-armoire-absurd-8a42@gregkh>
 <20260917022547.3826863-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

[ Upstream commit e1406330d70e56dd44fa6fbafc86e77e5c80c122 ]

gem_ptp_init() registers the PTP clock before initializing
bp->tsu_clk_lock and the TSU hardware. Since ptp_clock_register()
publishes the PTP character device, userspace may invoke PTP callbacks
before the lock and hardware are ready.

In addition, gem_ptp_init() is called from both the interface open and
resume paths. Reinitializing tsu_clk_lock there can reset the lock while
timestamp processing is using it.

This race is theoretical and has not been observed in practice.

Initialize tsu_clk_lock once during probe and initialize the TSU before
registering the PTP clock.

Fixes: ab91f0a9b5f4 ("net: macb: Add hardware PTP support")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/netdev/20260904030439.3994047-1-runyu.xiao@seu.edu.cn/
Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Link: https://patch.msgid.link/20260908103924.607033-1-runyu.xiao@seu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 1 +
 drivers/net/ethernet/cadence/macb_ptp.c  | 5 +----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 8751d6ea9a5e8..1e7402823eb36 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4568,6 +4568,7 @@ static int macb_probe(struct platform_device *pdev)
 
 	spin_lock_init(&bp->lock);
 	spin_lock_init(&bp->stats_lock);
+	spin_lock_init(&bp->tsu_clk_lock);
 
 	/* setup capabilities */
 	macb_configure_caps(bp, macb_config);
diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index 1faca23dc3ccc..ebb3b5dc8ebdc 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -373,6 +373,7 @@ void gem_ptp_init(struct net_device *netdev)
 	bp->tsu_rate = bp->ptp_info->get_tsu_rate(bp);
 	bp->ptp_clock_info.max_adj = bp->ptp_info->get_ptp_max_adj();
 	gem_ptp_init_timer(bp);
+	gem_ptp_init_tsu(bp);
 	bp->ptp_clock = ptp_clock_register(&bp->ptp_clock_info, &netdev->dev);
 	if (IS_ERR(bp->ptp_clock)) {
 		pr_err("ptp clock register failed: %ld\n",
@@ -384,10 +385,6 @@ void gem_ptp_init(struct net_device *netdev)
 		return;
 	}
 
-	spin_lock_init(&bp->tsu_clk_lock);
-
-	gem_ptp_init_tsu(bp);
-
 	dev_info(&bp->pdev->dev, "%s ptp clock registered.\n",
 		 GEM_PTP_TIMER_NAME);
 }
-- 
2.53.0

