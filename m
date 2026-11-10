Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336128;
	b=PYyc4US2hXbYi+T5lMXIblLmBlJHhYir69pVq+ZaXl8s6hQ1gcdrWG0awP06wHh9yjAb
	 9sE33D8eutPGI+47xbO8iSwC33dwh/7uLN1JcPqi2WjXLf1tO9crrzcGT38ga0Av80RAi
	 lw+v6d2b5vqgNwGaFrcLIFOagFPaoFyXAC2c4ovfXes94BtDCAlclrKmsEWmjntVq2uY3
	 qQkElsDAawHjzabDT7KPdSyD1SQ+LCrW6kIo3fiE8usOER4JrzsAws5yKlRMaRkDag48Q
	 FRLTV7bYBNsTnczWHvIuH5rdXGllseBrIOXfkGQQOJe+u5TpS8P2hu/wg1Nrs50K+4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336128;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3Ed71Ht4/yAOsTBOT+Rc7LwUZtJOf5FuO6p5djaZN9c=;
	b=XaW0JnfIuBEPD0AZOUnfYbVG4Jm8xZRwbqp+tNNaDkmIXOYnhEINgPqFBwdZ9XicReu9
	 bRQvZSEkpXeqA9mE2vG0KNw6SXCII/Dav0GFrkYxGgDF99wPKQp3neNuMfriOGJEsx+OI
	 tWltmd0m79/ViKmbwbh7uMzA9w+GDjYTRhajT1+TFi7aemPvUgy0KFY1EboAHYuacam73
	 xLsM6xrlogeUg/J2wJZMwRAkLjyZh9wIe0Wr7PYelPrs9TKlpP6Y0iDWOxxAriKegDBVl
	 f5u2fKM7Ykp3EAWpylpX+419aF6p75Krg9CBiYnyi6Vz66G8w6gncAI82XMtyzCtJUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="l+h2/Hx+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCD1606A916
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l+h2/Hx+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388501F0089F;
	Tue, 10 Nov 2026 18:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336127;
	bh=3Ed71Ht4/yAOsTBOT+Rc7LwUZtJOf5FuO6p5djaZN9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l+h2/Hx+i7crHfUR1QT5nsywn1WuYmsBf1pKQjTDaJAb4BYzvSPlP9ngVCqhNej1a
	 wqh9FsKpbHVzNV/I3EDvqMEZcyW0IXvTZaUDwoXRNzMuh6DmRRL2crurUMwEPERbKS
	 nAhEyjz5dH+Pne7qFzDzKpccznxnPWzrZwVtOs961kZmpDmkFrxTOvZZ/+F1PItMPU
	 E6fsUa7fKJHPWepz8n/HT7nnaO7iAXwzXyY210dEE5bCue434T7q7xxUU2O5hLpbrp
	 xCaxZzDb1aFTFSACZDQ0PNIkkxNer2zJWkV/zJiYim3QF8Hn8FEt3sq3fnR1R+jYcC
	 f1Ci3Babt2J4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] irqchip/imx-intmux: Convert to platform_driver::remove_new() callback
Date: Tue, 10 Nov 2026 13:42:04 -0500
Message-ID: <20261110184112.3296356-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054940-failed-6.1-b167c1a30e9e@kernel.org>
References: <20261107054940-failed-6.1-b167c1a30e9e@kernel.org>
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
index 80aaea82468aa..c7bf73dcb7a10 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -281,7 +281,7 @@ static int imx_intmux_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx_intmux_remove(struct platform_device *pdev)
+static void imx_intmux_remove(struct platform_device *pdev)
 {
 	struct intmux_data *data = platform_get_drvdata(pdev);
 	int i;
@@ -297,8 +297,6 @@ static int imx_intmux_remove(struct platform_device *pdev)
 	}
 
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -353,11 +351,11 @@ static const struct of_device_id imx_intmux_id[] = {
 
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

