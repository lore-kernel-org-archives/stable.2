Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A3452FE4D
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 23:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602825; cv=none; b=WNDyGRkTO4QAj60DJkKojzpSxQYOSmHmCxuoiii/LD/K3KiNx1Bysw7zoN+k3izizwHuoDCOQeS64Et2pyXY4yByQMwQCZN7PP3E+sMb0Mkd1cVr/0Fb05C2mlfPwkqI1pyz3Jv7Gd6PQdhdU4HbwkyOSwsdGt06iU+2V6bzjlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602825; c=relaxed/simple;
	bh=/Zfvu6Gdr2sT54E9kTVfBeIrohynKw1/N6l5iJEfztw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dC7kL9pZNdbI3w/26S8G2ULswApgef4Ig0d7tDDgeROobpLKHZ1JNfFKS2aDcZibDQwCxmuEOG6QP0nmmK6zK5SiPTybbT8uKgPj0sRtbmLYUkPSs6XXreTcKcT8GFVcn0xQanUJk19jVqWPLIYbDkcLGo0kr1LbNXR+mrteShQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVtNIRfY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVtNIRfY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C051F000FF;
	Wed, 16 Sep 2026 23:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602823;
	bh=9jgovaQ3Iz1fplA8KNPGfQXxlZAqYrGZwpvrfgOPiO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OVtNIRfY/TTe8Mf1Z56HkjJEhLP20lWHoelQnSphYh4fkrHzDTprwp+d1UeQ3JYjz
	 P0PjrnFOVenA6HfKVGjj/hdmDLHgYkXsdV5A+T6BgfJU9fY4t9E4+yyQPV1SxpixuW
	 mpXX6IQSy7RYR6M8iw6S6mutOyWZFiAY6XGeojWxsCQznvbt6X14mB9GgFZk/Zapwn
	 7Db2HXkl/DpjX91UWizJBLKIEC68cSUMMW6Y9H/bRYSFw3yhFlBDaUKcguLxuqkeFW
	 mit7m9fF1vvm/nXf+w7ao8QwWtzSjfTz6/x5tdCkkYRmm6mdybIaL88Fe8DuFbUeie
	 Hros5KS3DSwkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] net: macb: initialize PTP state before registering clock
Date: Wed, 16 Sep 2026 19:53:38 -0400
Message-ID: <20260916235338.3313589-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916235338.3313589-1-sashal@kernel.org>
References: <2026091642-wasting-vagueness-0a57@gregkh>
 <20260916235338.3313589-1-sashal@kernel.org>
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
index d0afcefb3e4c8..e4211fa03ffe5 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5655,6 +5655,7 @@ static int macb_probe(struct platform_device *pdev)
 	}
 	spin_lock_init(&bp->lock);
 	spin_lock_init(&bp->stats_lock);
+	spin_lock_init(&bp->tsu_clk_lock);
 
 	/* setup capabilities */
 	macb_configure_caps(bp, macb_config);
diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index 085795e8aae72..d961a5faf355d 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -332,6 +332,7 @@ void gem_ptp_init(struct net_device *netdev)
 	bp->tsu_rate = bp->ptp_info->get_tsu_rate(bp);
 	bp->ptp_clock_info.max_adj = bp->ptp_info->get_ptp_max_adj();
 	gem_ptp_init_timer(bp);
+	gem_ptp_init_tsu(bp);
 	bp->ptp_clock = ptp_clock_register(&bp->ptp_clock_info, &netdev->dev);
 	if (IS_ERR(bp->ptp_clock)) {
 		pr_err("ptp clock register failed: %ld\n",
@@ -343,10 +344,6 @@ void gem_ptp_init(struct net_device *netdev)
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

