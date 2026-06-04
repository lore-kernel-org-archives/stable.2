Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60359413D95
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 11:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572359; cv=none; b=Vt6Nphe2IiwuymTjYknIYCNjdjP/qIJJgS0XlL7Wzr2e8J3LXXKOBXQTXdWqeF8rbuATvwb4u7LiK+Ouao1daGjLESdp/N38tkC8MhuGKDFGBzcDwsKWj6whgrLsXMfD9zFIRfeO5M5ZiLKPBCSaxVI7XbhXhyREtiuSIv9zvFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572359; c=relaxed/simple;
	bh=oMlWWFZzKq2si3f9gUJpyk6mtrpOc8EH7Xofqcj28YU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxaysk78VK8tQ9Gla3BYY7ugprf6KJN9GUoNABMadPR5W12soMTfvCKr258QPUpfGPAS90xU2rJCYyNL1viq7w93VC0CTdRGyONnkhiUV6NeM/2eorHIFw6ptOwnM/4ZQ6448x0P/xTmgVE0b56chgyKvUItVOzMSs7CPzHMlE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcfG47B+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcfG47B+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BD81F00893;
	Thu,  4 Jun 2026 11:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780572358;
	bh=HQ83PhwKa8kaM3c2P3g/kNKvrKLO3CEjnuMKvFJ30O8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NcfG47B+Y6WbFdspqhdhWAGh2yLJVK1yUlxFqbkUHV1oGdaGlcPwFkvWbCZBYDSCb
	 W3Ce9zsc+W0/Uc9gOEEyQ0qYcV099YeIBAKL5QAEm6iHFeeRSkw71MNO2oq9nqmxt/
	 9wA16ncXzFxXFQqOSH+t3CEXMz6Gxw6tW8B78nz43kaiAiqCJx0ZN68raA1OI1cwWz
	 dxwPuY63nTYOQcAdOWIKlJ3nIKz9lJvyLcPdmIpyAK/+ER7JmhdadixlG8WAnSBneB
	 G6R7bNaUY9PUQ37n7JzBUu/X1BbIDiYU6ZvhfJW5YNsPNSAbX6gkxiZ+27ygBgaPBW
	 8yxmSlO6YrXKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] iio: adc: npcm: Convert to platform remove callback returning void
Date: Thu,  4 Jun 2026 07:25:55 -0400
Message-ID: <20260604112556.3253850-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060417-editor-stylishly-7101@gregkh>
References: <2026060417-editor-stylishly-7101@gregkh>
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
index 3d9207c160eb99..3a55465951e793 100644
--- a/drivers/iio/adc/npcm_adc.c
+++ b/drivers/iio/adc/npcm_adc.c
@@ -320,7 +320,7 @@ static int npcm_adc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int npcm_adc_remove(struct platform_device *pdev)
+static void npcm_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct npcm_adc *info = iio_priv(indio_dev);
@@ -333,13 +333,11 @@ static int npcm_adc_remove(struct platform_device *pdev)
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

