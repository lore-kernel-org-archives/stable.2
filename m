Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A48468C2F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952065; cv=none; b=ssdXIS324Ys0bUBub2vXAH1qp0KQbn+ugwv1nD+YpGkBcKHs13JYkNn/veRSqOA3Q+xSJDQFtir4b2F8aqQETqZLZAPg7RKAMoNS3jJtgYadoFMHCJAjKdN/E67g+K9Z2C3w2fcNEifnmpb1AztsSk5dvTNysZo/xLE/CBI6MGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952065; c=relaxed/simple;
	bh=NRYJTMuDKvqQtARc94tv8QzXu148Ghh+/W61KRyZd7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pxETr8yu2qm9GXUN9NRlQDw8iXNs4jv6AgoiHGyhJF9bIyWRw9EUshdUiiJJJBxOGWQeql9w4qEKwtFM1Wk8thHG1VoZVrIP6n3nbXvhO8qVF7kIRv/dPes1o9l17tT/OP0RQwGYV8ozB1Q/8hZZKaiAV2zet36w/setX9o7nmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boCJCgrJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boCJCgrJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD831F00A3D;
	Wed,  9 Sep 2026 11:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788952060;
	bh=5ybfotvkXt3gwt1T0LhKrFi/lD14Qzkxhd8Qi+MMN4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=boCJCgrJxycLPbHWCTf9KPZnqixChl16b4vJTiPXHSy9cVHbK+32KFDizvr0029Z3
	 plzbOk5x3YQSbDCdszf3dke+cNMtkOZ0CmH3D4uNjntqLpNGbeMFoiL8/6WKUrc/UC
	 yl4zMqL6xDiaJMajJDCHsmHv4S60qChHi1s3xUnH+Y4bLE3lQOF7y2QhcAxfhrC8eI
	 +AChxSxwlYr7ksKFqjzz1mFCb4ivcOKv7FrOQgon9v3FDatLX2mKIQn0qc1c/e5s9o
	 EF+vJuFf1WteJv0EbSGqb+H4FVGMCvazyBnjlexJDjJXMZVDvC0nCOUshu3oL2t58b
	 7M+H6NNLT8X4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] power: supply: lp8788-charger: Convert to platform remove callback returning void
Date: Wed,  9 Sep 2026 07:07:35 -0400
Message-ID: <20260909110737.1741580-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090352-endanger-avenue-c367@gregkh>
References: <2026090352-endanger-avenue-c367@gregkh>
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

