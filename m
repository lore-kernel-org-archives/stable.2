Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775134E3EF8
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952922; cv=none; b=L6hGCXRd++MnR5cq/smfPdAx4bH/bBFYj/vU2/uMN5KSgD7hj3O/S5N8TyK2+CfFdbqjpEDAHBD+CxEdZ2wGY2gBdBofQ3xjrdJQtWfWfEWVUVjZGpnT6QbmmLACltjA66/qXFz322TIoLE4FnlHTDMRM0gFHm866u7sx5ZyaJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952922; c=relaxed/simple;
	bh=vpqjBUjCUd4b+k1tRmZf9wOYjoHMtkk+27pWM3svxdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/kcfWn6pesxv1DADA/PZ2ls2Zh2wOf00hPIbn1LVeHW7mQ3X8Yq512YhkGBid6S0p9A7s+yBshbbOotqu23zF+3qM+77/+VpWd4/09J5Y3A49yUcPd2Xefu4G3v1DeixFYbANJE2KIxCl6egig1G/i0ktIp2PGcQb6ezOTo02M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W++Y5ycB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W++Y5ycB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7341F00A3A;
	Wed,  9 Sep 2026 11:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788952920;
	bh=zbwQPU1DHj2kn5Sw1RoeTqzsGfMSY/O0ziC0PKyteLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W++Y5ycBktu9IJGE3uItUbsTXo2pmhJ4cVfuAdo9uSsxr0eM5z3DiiNfXca7T9HXk
	 uGd5cJBhHWeQWdoI93J2TxD0eD8mPHKu2u6Z43lSVxrN3M4zow3sxGuN1EEw9crtkE
	 Ac8vLqME+Cf9rNYy1qt7dczkVwLv15kCss0FRCaYx/uuMg/czqmMmX5w4wkC2N4Kkj
	 Un6xC6I9BpHvrOdqevNnBOzAkjGYwox++LFcex/CGm+bKa6i0awVLMFL9u1KPFnm6h
	 BMZdIq6u3rmFz+DmRI5CETjJP6g2Ivb2LXOmI4Ufadkr7F/XClMSyFY1JZ1rBuvjJh
	 5oxYXawoboOqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrew Davis <afd@ti.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 7/8] power: supply: lp8788: Use devm_power_supply_register() helper
Date: Wed,  9 Sep 2026 07:21:52 -0400
Message-ID: <20260909112153.1816689-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909112153.1816689-1-sashal@kernel.org>
References: <2026090353-unadorned-buffed-09ad@gregkh>
 <20260909112153.1816689-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrew Davis <afd@ti.com>

[ Upstream commit 2abb571143c39f581df9951d263948726db42d86 ]

Use the device lifecycle managed register function. This helps prevent
mistakes like unregistering out of order in cleanup functions and
forgetting to unregister on error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20240123163653.384385-7-afd@ti.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: 831c29a12d56 ("power: supply: lp8788-charger: fix use-after-free on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/lp8788-charger.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply/lp8788-charger.c
index 20694deb05275..54f663ba95700 100644
--- a/drivers/power/supply/lp8788-charger.c
+++ b/drivers/power/supply/lp8788-charger.c
@@ -406,12 +406,6 @@ static const struct power_supply_desc lp8788_psy_battery_desc = {
 	.get_property	= lp8788_battery_get_property,
 };
 
-static void lp8788_psy_unregister(struct lp8788_charger *pchg)
-{
-	power_supply_unregister(pchg->battery);
-	power_supply_unregister(pchg->charger);
-}
-
 static void lp8788_charger_event(struct work_struct *work)
 {
 	struct lp8788_charger *pchg =
@@ -667,18 +661,16 @@ static int lp8788_psy_register(struct platform_device *pdev,
 	charger_cfg.supplied_to = battery_supplied_to;
 	charger_cfg.num_supplicants = ARRAY_SIZE(battery_supplied_to);
 
-	pchg->charger = power_supply_register(&pdev->dev,
-					      &lp8788_psy_charger_desc,
-					      &charger_cfg);
+	pchg->charger = devm_power_supply_register(&pdev->dev,
+						   &lp8788_psy_charger_desc,
+						   &charger_cfg);
 	if (IS_ERR(pchg->charger))
 		return -EPERM;
 
-	pchg->battery = power_supply_register(&pdev->dev,
-					      &lp8788_psy_battery_desc, NULL);
-	if (IS_ERR(pchg->battery)) {
-		power_supply_unregister(pchg->charger);
+	pchg->battery = devm_power_supply_register(&pdev->dev,
+						   &lp8788_psy_battery_desc, NULL);
+	if (IS_ERR(pchg->battery))
 		return -EPERM;
-	}
 
 	return 0;
 }
@@ -721,7 +713,6 @@ static void lp8788_charger_remove(struct platform_device *pdev)
 
 	flush_work(&pchg->charger_work);
 	lp8788_irq_unregister(pdev, pchg);
-	lp8788_psy_unregister(pchg);
 }
 
 static struct platform_driver lp8788_charger_driver = {
-- 
2.53.0

