Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A109F4AFE37
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952920; cv=none; b=Gwh1cC5jgWfcH1mZGaqUYLVnNK57GT3/dqzw2d1oda2VXad9TSGz5yzyIGod1kSE2qBxjjz0WYef59P06nxy2RZD2E4PCmTtCovQ9cttNY3UMQ7bS3vt+8IeMysPaXLuwB/WtJjp3LTtMUaQ75VA1eA5W1GyU7nEICMNpdPoW6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952920; c=relaxed/simple;
	bh=NRYJTMuDKvqQtARc94tv8QzXu148Ghh+/W61KRyZd7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thhG5lb/h1oLcuzhBILbIldnmgFpTOBSRCHdqD7k0tLM3PQSkdcgD9REJQW1SB/Z0redUZvBY53vkfyrP61qiXxymeaWippQMX/LQKLAuR/FVsmx/8ZLeDQH04f8NjwDLYpwZSz5CmJkp4TIf+zkCNgzGCa91f4BnthZ4liyYBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANPiAREy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANPiAREy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9301F00ACF;
	Wed,  9 Sep 2026 11:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788952919;
	bh=5ybfotvkXt3gwt1T0LhKrFi/lD14Qzkxhd8Qi+MMN4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ANPiAREylw+it4Qjmc2HEKgHl0z2SM9HIdCYlDIeALvAW17W+q7spzKpGVVizWsEQ
	 cJfTS2nHIi59qxnEvX89dTBi+Sv1d00pTbG9avJdMcX4LPu+8srdOwi09p6NUPSAXs
	 TiqCVlOu3/MCkd725wfoYr5kls5Zofh7T2rMm3Dw41Cck7vqvCeAFqbkZXPFZxOU8M
	 5S+fxOnEhBGucaJU2jPnFvCaWi10L16cOTlbz+vJZYpdkVDkGVwmy7WYnhmyUxDeb4
	 R3V9v5pbGRsqaWwyJcCeNB4XslzsVWaTp7o0eqJcEbRV4/159tuDM7Hz87ioh5nD9N
	 yVzTi0LCU5l9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 6/8] power: supply: lp8788-charger: Convert to platform remove callback returning void
Date: Wed,  9 Sep 2026 07:21:51 -0400
Message-ID: <20260909112153.1816689-6-sashal@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 7810ba3c5110ce66652ec6bd2abb92da5d726c3b ]

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
Link: https://lore.kernel.org/r/20230918133700.1254499-17-u.kleine-koenig@pengutronix.de
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: 831c29a12d56 ("power: supply: lp8788-charger: fix use-after-free on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/lp8788-charger.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply/lp8788-charger.c
index 397e5a03b7d9a..20694deb05275 100644
--- a/drivers/power/supply/lp8788-charger.c
+++ b/drivers/power/supply/lp8788-charger.c
@@ -715,20 +715,18 @@ static int lp8788_charger_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int lp8788_charger_remove(struct platform_device *pdev)
+static void lp8788_charger_remove(struct platform_device *pdev)
 {
 	struct lp8788_charger *pchg = platform_get_drvdata(pdev);
 
 	flush_work(&pchg->charger_work);
 	lp8788_irq_unregister(pdev, pchg);
 	lp8788_psy_unregister(pchg);
-
-	return 0;
 }
 
 static struct platform_driver lp8788_charger_driver = {
 	.probe = lp8788_charger_probe,
-	.remove = lp8788_charger_remove,
+	.remove_new = lp8788_charger_remove,
 	.driver = {
 		.name = LP8788_DEV_CHARGER,
 	},
-- 
2.53.0

