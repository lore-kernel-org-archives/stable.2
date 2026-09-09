Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E27353FD34
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952698; cv=none; b=L5aAf6pfIAJSRfN8U06T4a5oDF4fD/nQ2YaHRBh0+x18wylrB12fYt0idlBYLB0L8WkxQK7uwnZDDkKQOo/UFtK3hezSZkya5ayDDo2TTvO62Bg9r5cCXjVuiRkSBjVQR5DiVO3WlGN0oUoeJi1ngieln/umCRtpKfE1che6TFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952698; c=relaxed/simple;
	bh=0gHy5JO4+ILTsX6zj3ToHy8N3nYWqn1R/HOfvrXJhLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q94jw1V4MxxU1PMOGx8CoKX/vi9e57k/9QFF1GdfT1k/exo5/Edzer9tmvAJTPCmUjvtvXfjHvR2Un+RwSFDVLwGc4j1nAO87JMPvsY/85Tm1hO1DJ5hC7jE7UTUpItyrLVf7NkNFA6Shure1SKUmowWicC5bOzFTX9QJFFE1ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwgJlVO9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwgJlVO9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458551F00A3E;
	Wed,  9 Sep 2026 11:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788952691;
	bh=0wb0a+RxITSiab3eSuAisW+gLiYbijcXK6vHSDYRD2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KwgJlVO9kYTsGbq5EjXT/V2lZjwHZC+a1jS/DgpJwqWheVzw/NlIzy1m23ABb7YFu
	 Ucwo4BkSxq4dU6PnMsbCLTnfAQb4vuvNfwBEmYrf6dHsIeOvVJPkYUdSTvE0xDn6Au
	 WrM8WR4AZvtOYf8YK+1vmkgER62wd+OEaZRClXMxi7nr33j8mNiuSR1NH9M585nZ+C
	 dBy9jsi+2k8iTyFUweBYqkhYTLmA0/9uC0rj1dk6za2Dzeh4A8/YSVFz+Ho3YBuvtd
	 wi505RdsXw/Q7u3FdkfV13XdQYVNSnWTEBsTSuhABwKywGtyDCovqtwaxccRpl4Gba
	 6MuIBX9vmDX6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 6/7] power: supply: charger-manager: Convert to platform remove callback returning void
Date: Wed,  9 Sep 2026 07:18:04 -0400
Message-ID: <20260909111805.1804682-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909111805.1804682-1-sashal@kernel.org>
References: <2026090322-humbling-ninth-d3ad@gregkh>
 <20260909111805.1804682-1-sashal@kernel.org>
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
index fa13f54849090..a5b8b5de06215 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1633,7 +1633,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int charger_manager_remove(struct platform_device *pdev)
+static void charger_manager_remove(struct platform_device *pdev)
 {
 	struct charger_manager *cm = platform_get_drvdata(pdev);
 	struct charger_desc *desc = cm->desc;
@@ -1653,8 +1653,6 @@ static int charger_manager_remove(struct platform_device *pdev)
 	power_supply_unregister(cm->charger_psy);
 
 	try_charger_enable(cm, false);
-
-	return 0;
 }
 
 static const struct platform_device_id charger_manager_id[] = {
@@ -1745,7 +1743,7 @@ static struct platform_driver charger_manager_driver = {
 		.of_match_table = charger_manager_match,
 	},
 	.probe = charger_manager_probe,
-	.remove = charger_manager_remove,
+	.remove_new = charger_manager_remove,
 	.id_table = charger_manager_id,
 };
 
-- 
2.53.0

