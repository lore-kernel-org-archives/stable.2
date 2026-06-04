Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26D4288C0E
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583435; cv=none; b=kioSkcPhLrd22l+p+wfoKWHmUYmEql5n/HXLlMmyw8MnUEQCqAuf5xe/hEtBSgX1yCuwP7nsGsjB0nSK57ubNcLpvBfAmwoLggMhviqMENix8lj2M5/9dYkVimyRGfBV9S65ZGA/HjSP6RfF9QsAG9lSP/F1wysC06xqWHIDTgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583435; c=relaxed/simple;
	bh=Enmy6FQoyYgQLfqK6BzANkCO+df+B2+HXZCLI3Ib6p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8S+81Vpdhx/64MctEFMWoxZKjXhUweWKKCA3q5LZLICKAOzgZhl4eruw6zdc3Q4DjMAdaqWBu1TX0Wd4OW+qr9/2KeSSr/aJR2m0z5TO6U0taOgXq3taduDIw+wmnBVdfXI/cHdV6weTKz1l+mLitD/k8AafkyTkNzeMDZVkKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qdiq9cqr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qdiq9cqr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051CB1F00899;
	Thu,  4 Jun 2026 14:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780583434;
	bh=l2Mu1ZDv9uh8xwQvspCIBJoTJocb0SRkXCNgQ6T0m+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qdiq9cqrNaI4g2naWsooB+RCU+gS9OLh/gtsUf2YeLjr6z6QgMZ22hM925e3xv6TE
	 sO5ub+CcwlpUFmfP4i+ocLcYnO4hisI0W+JC4hiKHGlb5veC2MlnyVN58cxeApocq7
	 rf3D/NlVFDIYSg1q8KtXfJ+xPBTVmP9G7IRobgm9rwK8h0rCPn3K7KweGpXm4foP9M
	 kr5cQ40Y0GzZhyHwOOJVIx9foOYrRA+FxNwqSKaCwEWP0l6BMZf+9rmV8fgUF1IBt8
	 aHfqYZVdW0PGuZvZXN0CN7qo4OjI2kQAfpwwC88Dr8pUwWY0PInsKJi8oXdOzg/5wv
	 sSR5j443No0Ag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] iio: adc: npcm: Convert to platform remove callback returning void
Date: Thu,  4 Jun 2026 10:30:30 -0400
Message-ID: <20260604143031.3608772-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604143031.3608772-1-sashal@kernel.org>
References: <2026060419-driver-wreath-7a8d@gregkh>
 <20260604143031.3608772-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 5253a5cc7709688b9a000f7928bfaa3366d0af98 ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.
To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20230919174931.1417681-18-u.kleine-koenig@pengutronix.de
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 0d42e2c0bd6c ("iio: adc: npcm: fix unbalanced clk_disable_unprepare()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/npcm_adc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
index beaa52512991a9..4aecdf908a7e0d 100644
--- a/drivers/iio/adc/npcm_adc.c
+++ b/drivers/iio/adc/npcm_adc.c
@@ -297,7 +297,7 @@ static int npcm_adc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int npcm_adc_remove(struct platform_device *pdev)
+static void npcm_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct npcm_adc *info = iio_priv(indio_dev);
@@ -310,13 +310,11 @@ static int npcm_adc_remove(struct platform_device *pdev)
 	if (!IS_ERR(info->vref))
 		regulator_disable(info->vref);
 	clk_disable_unprepare(info->adc_clk);
-
-	return 0;
 }
 
 static struct platform_driver npcm_adc_driver = {
 	.probe		= npcm_adc_probe,
-	.remove		= npcm_adc_remove,
+	.remove_new	= npcm_adc_remove,
 	.driver		= {
 		.name	= "npcm_adc",
 		.of_match_table = npcm_adc_match,
-- 
2.53.0

