Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337687;
	b=jsZo+L/goYZFGg4GqJYbqp8oOvAvYfawy/pug3IUTITVTPLERzDStV69l1XUYJMlYfqt
	 G4Ftlr9urKKZzwqWn7b8GfxdovzqYxrxV9OE/B533P9g9efh4PoP9EkPakSq5tIl0d+Kp
	 zHjQBfsJeNdgwPeYduCqRk3MZkmAtArnhVSneQZ/++DlwWgINqwPlf8AI9x1vGso8rEKn
	 l4W/cof/CcgwO3MTWf5SjXU3rhtgFsKFjrxF0yGovb4CYpQU4HDHC1DAYMTGg/UQyZUX0
	 1l6S0gSKeljr9V4NmPtMYbMHjz7LQZBylcj5seNEH1NZp0MbY/Xm1sndI5k+T2HqJtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337687;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=uIq4SR6mPk1dtWIThEmM/IDNP7REJu7Wm2Jtzs+pJ2M=;
	b=RxrZ8uojkB4sAGAWdSxc04oaiyHLM1luLj/8JvAmzaB3RBN/EVoySyOgi6wWgP3NDhet
	 S5/9gOXFoBM4LaWmpbJVRkBF4j6WHVrxS6ZVepI0Puw55pa24U3ZCeZSoK8BzgL0WzfMS
	 x1PNy2ZRLbq6EurdGN8Szhoy+A0YQWYAoiGxw3ehUk3OgniAnXUtNffi+9GDR3RURZi5b
	 WN0Pe/iC24M8+YttLWAB/na29zGYf3BjINTjXO9zD9QuwXVaxBMi1e+9IjOG3pYYNz+hn
	 YVdfmlTVetN2OyXtLuZb4LXnUq/FGy3YVXRi1viUz7LYGu/8IAxEkC1blYo1LfJ9yog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BQnahPWS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92006606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BQnahPWS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952B31F0089F;
	Tue, 10 Nov 2026 19:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794337687;
	bh=uIq4SR6mPk1dtWIThEmM/IDNP7REJu7Wm2Jtzs+pJ2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BQnahPWSKmFN9h2A1z0B+I5m/EkqvL0WtjNF9kaTohaXY/n0/LifaueKYPCbzhTgr
	 fC1S3vwX7ZMdvtJ7UHeHHzxlQxvIpzxUxv0yd1LF6riz/TKoxD0BRv1BCJz/Ygu9jq
	 Qw+ZY/RsPfWjNhOBgnJ+8+594uSz5iRdBIIklw3S4tti35lonYoB/9GHMDA5MhdDAV
	 2TlSaDs5I6MtOrTkv0bj5obz4gZQFm9NpRc8H7PsaoUUyJqEQlqmH3AWlVwM8uhrgQ
	 LqGTAqA3Gg9cTwy9PNKRVXF+kyD/lglW7RCwgtzlr5pssvgCEpX2AG0pk11M0NQr5k
	 1QjyTSQF0BQMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] irqchip/imx-intmux: Convert to platform_driver::remove_new() callback
Date: Tue, 10 Nov 2026 14:08:03 -0500
Message-ID: <20261110190704.3466855-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062335-failed-5.10-b167c1a30e9e@kernel.org>
References: <20261107062335-failed-5.10-b167c1a30e9e@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 984e5c7b8d7bac9efd3818e06dcf1f7aab7701b2 ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/edeee074956dd943d3c67da894a01dc5f0d33bd7.1703284359.git.u.kleine-koenig@pengutronix.de
Stable-dep-of: b167c1a30e9e ("irqchip/imx-intmux: Fix runtime PM teardown on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-imx-intmux.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index 7709f9712cb3b..576f28c9ebdb3 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -286,7 +286,7 @@ static int imx_intmux_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx_intmux_remove(struct platform_device *pdev)
+static void imx_intmux_remove(struct platform_device *pdev)
 {
 	struct intmux_data *data = platform_get_drvdata(pdev);
 	int i;
@@ -302,8 +302,6 @@ static int imx_intmux_remove(struct platform_device *pdev)
 	}
 
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -358,11 +356,11 @@ static const struct of_device_id imx_intmux_id[] = {
 
 static struct platform_driver imx_intmux_driver = {
 	.driver = {
-		.name = "imx-intmux",
-		.of_match_table = imx_intmux_id,
-		.pm = &imx_intmux_pm_ops,
+		.name		= "imx-intmux",
+		.of_match_table	= imx_intmux_id,
+		.pm		= &imx_intmux_pm_ops,
 	},
-	.probe = imx_intmux_probe,
-	.remove = imx_intmux_remove,
+	.probe		= imx_intmux_probe,
+	.remove_new	= imx_intmux_remove,
 };
 builtin_platform_driver(imx_intmux_driver);
-- 
2.53.0

