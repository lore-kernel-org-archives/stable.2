Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335265;
	b=utHyJorWpH/EwkKQcfhJn9g8JzVWz0TXpNz/6rcEbHHDuREKWEgWYr45IeNYY4+fj6Yq
	 yuU51oDrEbuUcUxMZ+nAgPkpUvBtHqv5iIHbDrS9IcPmpPP+DbFQaoH2StGd9nI+8yDEs
	 itIXMM2+rfy/BJ2OWj81CYOyBqdz7cOQOD9gUDsIczvbGOKqg+t0EVzIEwlwTSmqGT8SR
	 Gsv7x+mIEPXQ67SHPaIf9OYwlBuO83Matq/a/d7mKuZpfRTyolsWb5yHEI/IFcvSoWQ2U
	 dWFWDF3rPFbuPkEvxawUbrtCdfrwDeYPpgcQgOMcsley4qiX7O2L+hhBBOghfp1SBsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335265;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=K6RqFpIaJuoxXK6UBupIRm/B0Zem6kXCuruptk8GJPA=;
	b=Ofc+o2u6Rpj5hRpkBsQePZ2sArKiFiR6rp9nGZolpolSNK5M1Uy5V6tMcMyrsRcGyiyy
	 K5yfR+m9zCfcbfQARNsNFPBuEP4rImtF/+jRcKRqgudDd2o8r74dqIzo9H/vH2igVAFFl
	 eAyu4cwpzMWKlQx9mbv9gSVKAq+b/8wc5SedrnPLzfv7j9iHAPTJeUOCLhHLHRsNmFe30
	 7VuPyyOQZ80/JCmSZilSFNObOYUhFNtg7Ai+4hUObqRGxt3FZKDaYtjKnQEftEaP1USIR
	 UIqH91MKCqM5NKsQGnrCPSdKFLhqfBpJowXaeY80L0curXm9Bj+4h+fUgNtBZogBiuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Szsn7Fb0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61398606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Szsn7Fb0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774BE1F008A1;
	Tue, 10 Nov 2026 18:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794335265;
	bh=K6RqFpIaJuoxXK6UBupIRm/B0Zem6kXCuruptk8GJPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Szsn7Fb0reQp5UUnTlF9VfacKp0Wf9XZXVZmxm8Chk9dF2WWE4TMeaWIqVin678kO
	 tacPCMkZ3Iqo4KDz3Vws7tqjTYs/VM3Yl6RVXOV+qIZ9ZsNpR8M9hTeaGaoCAelwLw
	 kxIFr42Gj+eGY2+PXSZUy0SvTymLucCMchK2disXazQLPWSkNKzqLzYXmWNcu6Rhwb
	 2a3eMXgMm3fSg7pZO/9QzSfFEWqULHPduLKcPAmAJueo3Q3raeHqUXip67jQe8UHV1
	 uP+7MmAmwftMqJ3X9HzHChL+7+wczMUkYiZyIg+4zD4NuigpeOSLWhQZXvwFOLOGgw
	 bHIiY1pakvm2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] irqchip/imx-intmux: Convert to platform_driver::remove_new() callback
Date: Tue, 10 Nov 2026 13:27:42 -0500
Message-ID: <20261110182731.3159957-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053525-failed-6.6-b167c1a30e9e@kernel.org>
References: <20261107053525-failed-6.6-b167c1a30e9e@kernel.org>
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
index 6d9a08238c9d0..cdd6c47e589d3 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -282,7 +282,7 @@ static int imx_intmux_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx_intmux_remove(struct platform_device *pdev)
+static void imx_intmux_remove(struct platform_device *pdev)
 {
 	struct intmux_data *data = platform_get_drvdata(pdev);
 	int i;
@@ -298,8 +298,6 @@ static int imx_intmux_remove(struct platform_device *pdev)
 	}
 
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -354,11 +352,11 @@ static const struct of_device_id imx_intmux_id[] = {
 
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

