Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0D721FF2E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951360; cv=none; b=Tby9WGD+ynFeaE81uR2elJKey9RCHSiqbd2HcO2YCpQmlsydM2eMGOVO74ImGS66Rx7j5qPuf62cfEgzsu82KHoim2zhWFwlgklanJJrxKRPy9hqEs4Fz4Kubv34oZezbGc9eSEGz4QZ2PFo/DGdVzJAf5R7/cmGEMNgIVH8tNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951360; c=relaxed/simple;
	bh=RHD+C6EW9bO1yExgkvo5pMuaBliUg1K7yVEoYwCFCKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivkTAMmUIVFZ4Awllg/RMNQTKNV1m1EFad6P7Pt8KcgQmsMgU49CK/3ZmCL4UKodiw9RaeenPReA94+XU8vloZ7jsx6y+x24Z1QP5vCgV9I8lboB6eqCZar85AyuKaSKklUkCkv0v586/Yfn55HJZjV6WWQs6tVZC9DWCJZkx+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fynebS4U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fynebS4U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE741F00A3F;
	Wed,  9 Sep 2026 10:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951357;
	bh=3ITnxAdohqRzHvUSxbdLy8lVcL0F7SFSqPL7/coWPc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fynebS4UZ8+7kMMsqUzewuMTK6kKB/cdmptDgryNC7wrErGTKjBlhjae9T8NqyMOH
	 N/IGXw2hmMxKFIILqz5J5TUvzBkyBVV5eVDdlNqRKJxtK9L5QPDnJHoovYaJ6T+u+2
	 kbD1MzH8QnXX0LBVDLv6O6AB6ZQFNiASH0I0j3W3n56dLX/bTrRHWB7+RT5UKT2qnw
	 5PlaSFFEEL+E0eJz6KTv6eHn52OJxHwpZZvodas/em2GuV1GByXpw9vXPL7hl4tNZf
	 zHdfeEIbtZUX0cQfJDiQtimMSxRCJPzcEDxGtLku72ZRoTM9b3HsMF2vPLnVxlu0Jg
	 tlCfONVzh5Z4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrew Davis <afd@ti.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] power: supply: lp8788: Use devm_power_supply_register() helper
Date: Wed,  9 Sep 2026 06:55:53 -0400
Message-ID: <20260909105554.1634698-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909105554.1634698-1-sashal@kernel.org>
References: <2026090352-math-comrade-6046@gregkh>
 <20260909105554.1634698-1-sashal@kernel.org>
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
index 2c81be82a41a4..72b170b4ac46a 100644
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
@@ -666,18 +660,16 @@ static int lp8788_psy_register(struct platform_device *pdev,
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
@@ -720,7 +712,6 @@ static void lp8788_charger_remove(struct platform_device *pdev)
 
 	flush_work(&pchg->charger_work);
 	lp8788_irq_unregister(pdev, pchg);
-	lp8788_psy_unregister(pchg);
 }
 
 static struct platform_driver lp8788_charger_driver = {
-- 
2.53.0

