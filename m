Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337033;
	b=dihVExVItAEYQKCazRVSO76Mk+G1R3LOKuEgWqZ9Dpq4KVBDlsDY+I8cBJv6RVbY8OxS
	 N23MNH8KB5QeJnGnQeuFOlFlQmG4xIZm/NbGPfPoKVM8Rwlxn6F/WOOnFXGqdSRqkyy1Z
	 SrOpSjQz61llWSUomf+rfLqOqQCH/kn4DlfjI3+sldm/A9+ELOl7b0yxxNZyxCm/Uxly/
	 1uqwYa+ude3JDar1fLpfZGr7rdl+jiu7uLk6EFaiQahcopkNxxw3ZTwS6MrxmRilAcwXq
	 jVR0/uQ6Ftlk/lUp62Jj0uBN+fJ2CUxMUA7/plJtJNpIvWw4FBoeqmSiEisXlQU1v6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337033;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7FODtIMqB2gibRBwtCmOMQ4lfz+AdCp9r35VaGjhkeg=;
	b=RR96EaEJ5URcGrQaT4mQOz5y48dTlMPO9EtkoVDG4kMjpKFhCfNOChUVxsbTbQyxAFFy
	 s5mdvDS8dpcXDenoCA0JAFKkvp5A+nNN5NnK45jzV7mq+7lS4x1xsU822ahv8337FEpV3
	 MLD7WzAb8+bginKpJsirIoyK4/wBCq9suhrCX36naP2jc4nK6M+eE0FCl4Spi3lfTsKgE
	 /neq1aUMStjE84rXZbP5nSkZ02s8dTtV4GOyKImptmkCbNsVnhPjAE1aHyvwtNldjBjdF
	 WIgHeltcAgB8N/4+rGMGD9e5nEM40v+01++HSp85sYjElkOCBlVL1EUHJTW1LGxhHjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IK6xXWcd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBE6606A323
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IK6xXWcd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F7A1F008A2;
	Tue, 10 Nov 2026 18:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794337033;
	bh=7FODtIMqB2gibRBwtCmOMQ4lfz+AdCp9r35VaGjhkeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IK6xXWcd2eQiy7S0gvjOMy/P5z6ojQ7+WAVHC0KRo2HfYvinTUA2zj0K1VNuLkXiu
	 r0WXces5i98srm3kVlQ7Shsocp51Z6RRs+WKPxprHauhmDkpk1Zhc4+K6SVay0NXU2
	 OCPAEb0s6VQWd3nkbhihgYYU6nuB1323sTjBtQVk5nzxZtsJM0a3qrE/4Fq8iPrLnX
	 5WK+Hfj9cvp7gZpHPqijwFn9aWfo+kA/NeMo5qxqnAuCqun3Q6qDbXJtKreTgupOEt
	 KFRs8P3yy9aJK3+5mYNr5+lw667eq2mEjAEjIwIzbemxclw+DTme9uEkQWA14DTJMP
	 uacrZDCtXhTaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] irqchip/imx-intmux: Convert to platform_driver::remove_new() callback
Date: Tue, 10 Nov 2026 13:57:10 -0500
Message-ID: <20261110185655.3415962-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060640-failed-5.15-b167c1a30e9e@kernel.org>
References: <20261107060640-failed-5.15-b167c1a30e9e@kernel.org>
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
index e86ff743e98c3..45d2ac494a82d 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -283,7 +283,7 @@ static int imx_intmux_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx_intmux_remove(struct platform_device *pdev)
+static void imx_intmux_remove(struct platform_device *pdev)
 {
 	struct intmux_data *data = platform_get_drvdata(pdev);
 	int i;
@@ -299,8 +299,6 @@ static int imx_intmux_remove(struct platform_device *pdev)
 	}
 
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -355,11 +353,11 @@ static const struct of_device_id imx_intmux_id[] = {
 
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

