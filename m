Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D6852ED3E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951553; cv=none; b=KP1bE3PPvms3wzY9E/QI1oMV7aF9R1cpN2vYjkp5a3wCuVEUeaXlhy7vI1mYgqV313Wambr8NbEuanUuht+gK16z2hqv21Cz7YY/uBmRSOEq6ir5uPOxOSHxsjbWW3Ey4YI4FX5sRF7Fdj4xGPPBRNhjyTAHvTaMLSf40KiCgcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951553; c=relaxed/simple;
	bh=73R9wakaIKq5N8E0+ac/ForqvyuY0In3CUJPDk3D6/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXdnV5QitJ2/S4FapLES6AZ4pHTl6+N1VabgRI5g9zKblV5XU0TMksKWnw/0YOzaSK9tcG/dGtE8Oq5BGaC97Nk0unLzX58ACqUWlV/sXuALqvnG1bBtYxSRsqjeftd39MSUpN0fjiA8wOVO4TQb9BhUVcwByMoB0upYwzRv/Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CS3WEdkd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CS3WEdkd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE171F00A3E;
	Wed,  9 Sep 2026 10:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951546;
	bh=d6urDsTSBiIEKp/3yeTAI6HrU+TimLcZsNEvBpsMBD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CS3WEdkd+Y3drPXoWlRY+q9je2TUeyM8eQQkfJrS4lVjhXCc4uOVYgDQjFMno0Hb8
	 dK3hUtoeYXOEWToZ4+6IDGIFHWeKnkYiAXk0GgLOCNzsNe51LFGLjEV5VPiepPwHet
	 9bMO6X5JTPeno8/OHXjHxukAZyPcJ3QG0uDGYTe9BiT6m95AAIqFwYmXMrdg4ijvZB
	 wb4uGQeZCCkDEbiZS9r/vhlM0PWM9fU/aTCa3GhMXmGSTB54Sh7d8X2XqKKbZ30F0m
	 ClRPa3u2RgVKhit74HwtLeeTmUOPZxWn/Cc1devJ+29YkLNBewusH2WmjgFj6mYjQS
	 SFK46k7E6aRhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrew Davis <afd@ti.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] power: supply: lp8788: Use devm_power_supply_register() helper
Date: Wed,  9 Sep 2026 06:59:02 -0400
Message-ID: <20260909105903.1646806-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909105903.1646806-1-sashal@kernel.org>
References: <2026090352-shoptalk-president-e8c6@gregkh>
 <20260909105903.1646806-1-sashal@kernel.org>
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
index 3cf8cec8cca6b..98c15b7abfb88 100644
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

