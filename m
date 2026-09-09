Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B9B5335AD
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951272; cv=none; b=N8tUWh5et1WgHjZLqtutBOq2Pp0r168M7ZmrKJlBVy/pJs403is7rUVLLoi68mk4GgAlKZPQ/xtlHigrve+Xe4twVjAFixytEAKkcqLO/1b7gapWIqBjayIzBWD/4BDNwi8PCCMgJR3k+M9bDHyzRtMI/8FjdN1dYTcLz/N45WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951272; c=relaxed/simple;
	bh=tKmd8PTSrAiy9d9P+675GgbsbCbqMeskIcP/hlTtHwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mphBMyCIslCrqmUxBAOHHcXeNzwqTRb/ez2wrBUYcvgXl2+T38UoCEImhi5V3SZR1qEGh51G74n936AqSV+47l7pptDQdESpQy7123NbfiHMtVWF+URERAHrTyVZAiTSwA+9QA4Xt18dC+ojxsBvj2GQkjftQduKsFlNgosyxgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHMrg1hW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHMrg1hW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24B61F00A3A;
	Wed,  9 Sep 2026 10:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951268;
	bh=YJ01DRH4CfAGsIVaBEq5hj7D9iEJ9Mv5Iu6VSyKramg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YHMrg1hWWK0VAfuDnh1Ow0rvu3Bph79FQtPU8AkuTs6ySoXWlQ98X5IRoDA0pKBle
	 F6CY+4fJk0CW66XZKz+tyJHc2UwohMji5RjupL8X0BbVf9MwOeDJK2pGRMLK3dVE0V
	 y+flMUefHPeT7ut0WOlkJEXfoUCiMlAComGs+I3KnuODNIqbzEYZ75vc0dAfR7TX1s
	 R1rf3zZxq34U2CXv47gsDljBR0aaApmZp9untJSyrldD8XadQyYeOgFI00Mo1zGSJO
	 rgyRPZpNDbO1y9LVwu96yXNkfZRGN3roFcJczIXx4gdAkLt8YVXYr/JqFNpu0Sf/uV
	 yOCUCtH7BfrKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] power: supply: charger-manager: Convert to platform remove callback returning void
Date: Wed,  9 Sep 2026 06:54:25 -0400
Message-ID: <20260909105426.1621293-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090320-shirt-underuse-eb92@gregkh>
References: <2026090320-shirt-underuse-eb92@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 403eebf95c38302cacc48c127e575461f0e798be ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.
To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() is renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20230918133700.1254499-8-u.kleine-koenig@pengutronix.de
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: c57cb36f76eb ("power: supply: charger-manager: register regulators before exposing sysfs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/charger-manager.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index b874947b84f2b..42a7e4f045d82 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1630,7 +1630,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int charger_manager_remove(struct platform_device *pdev)
+static void charger_manager_remove(struct platform_device *pdev)
 {
 	struct charger_manager *cm = platform_get_drvdata(pdev);
 	struct charger_desc *desc = cm->desc;
@@ -1650,8 +1650,6 @@ static int charger_manager_remove(struct platform_device *pdev)
 	power_supply_unregister(cm->charger_psy);
 
 	try_charger_enable(cm, false);
-
-	return 0;
 }
 
 static const struct platform_device_id charger_manager_id[] = {
@@ -1742,7 +1740,7 @@ static struct platform_driver charger_manager_driver = {
 		.of_match_table = charger_manager_match,
 	},
 	.probe = charger_manager_probe,
-	.remove = charger_manager_remove,
+	.remove_new = charger_manager_remove,
 	.id_table = charger_manager_id,
 };
 
-- 
2.53.0

