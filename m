Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E528A367293
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607614; cv=none; b=sjtI3uLe4S6784odSPZC4Zs0EOipYg/fg/8JQD6d8LThjc7ByBqy8qWXTWCdiS0YnU6cBkkQSigBDM4tTT1r96Rapb6NqLVCGFSGZaQ87F6aPSOnAoLrKoBFqxAGhgsDGys9vu9l5JzoRM06Zqgxb08J8q0vzIXYTO3SwTGyTs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607614; c=relaxed/simple;
	bh=VHkSGm9y3tpPGThtm9WDocVDRjNZ8ifOrRRfbTEssV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDBGnbLTcpLo4jAeLwO0WWliIw1Yk1+jTunfWdriGc9UF9YPMtjAnEvgIR5Fa0E0PJN88VplWL9p9OfatFnX0/290M0eE0ptfy04kwsFkMfZ8dmJ652GEh9dUULQy0uxwoR2N1PGPv9/jrZoAqS8kIGTBxUNhtdmgWdESKGpyrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AP864fj3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AP864fj3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2651F00898;
	Thu, 17 Sep 2026 01:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789607608;
	bh=og0PZuQRxaE9VSL0ZQ+AcE8SDuX4SSaqkTamcdwZXPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AP864fj3YYqwgvDlkMmPz3ge10l3DvOd8OF/F4JrM5G4tD2mWlOLn6v43StI3QvJy
	 K9S3Hf5tFhrQl03fcTGb6cNTjXr0dX8HrojBiUg5MCx1QUFgkVkN8v4dhpjTz+CNPq
	 UeDie8p+Thd1vkM4JSpkKwsOBykzGZpFiBCq0rJ0a5v8l5i7mgB3IqMiYfU/cZrUWT
	 o/VC2plw6u/xFVSUdZpKp/L9Mrs5DyDJX4LKD6kW4fj/rCrhYuUkbSEsmdhnHH1N65
	 5WXSV3ILAJ5b5Pi2bjnA/3vf6VPAuW8JoR9Z9N4ul//vHvrKrFzaST3iTX3tN6DYj5
	 hlq+Gi4uImZOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/5] net: macb: initialize PTP state before registering clock
Date: Wed, 16 Sep 2026 21:13:22 -0400
Message-ID: <20260917011322.3531179-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917011322.3531179-1-sashal@kernel.org>
References: <2026091646-swoop-cubical-81ce@gregkh>
 <20260917011322.3531179-1-sashal@kernel.org>
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
index d5a9def09e1dd..dabf1e91e5920 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5079,6 +5079,7 @@ static int macb_probe(struct platform_device *pdev)
 
 	spin_lock_init(&bp->lock);
 	spin_lock_init(&bp->stats_lock);
+	spin_lock_init(&bp->tsu_clk_lock);
 
 	/* setup capabilities */
 	macb_configure_caps(bp, macb_config);
diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index ee696f45110db..bb0fd27bb696b 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -378,6 +378,7 @@ void gem_ptp_init(struct net_device *netdev)
 	bp->tsu_rate = bp->ptp_info->get_tsu_rate(bp);
 	bp->ptp_clock_info.max_adj = bp->ptp_info->get_ptp_max_adj();
 	gem_ptp_init_timer(bp);
+	gem_ptp_init_tsu(bp);
 	bp->ptp_clock = ptp_clock_register(&bp->ptp_clock_info, &netdev->dev);
 	if (IS_ERR(bp->ptp_clock)) {
 		pr_err("ptp clock register failed: %ld\n",
@@ -389,10 +390,6 @@ void gem_ptp_init(struct net_device *netdev)
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

