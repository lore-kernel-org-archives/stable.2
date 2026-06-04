Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D043947F2C6
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581291; cv=none; b=tigItQmWdq00PEWkUWKifLmVyQ4ODRwgazgET8Vj8XIgQAcmV0Hx7UL1o6S78jXTlVwLBo3rKpmv5ctOOoG/Hg21Msk3TBJnzIbwJlgcF7r2Y+hr5FqaTEnOwC3Q9KKE+8J2NtxBC1da3fQhdTaGMh37bbC2UG3GNxlKgpnLLqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581291; c=relaxed/simple;
	bh=oMlWWFZzKq2si3f9gUJpyk6mtrpOc8EH7Xofqcj28YU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GlovaYuV2jSXZBOzT3YIWh06qE6ZwBIc62m/OZM403E82pP5RhJoQ2EN92iRIT+uxEXZjNRdgLcauVzf/Hc2EqvDYAAH0zeFf4ryHXSEc7FVDdw4emb6PDugENQ2CX+PnoAZbnvOJ3nlDUwyIlnmytvTpmrNnZaZdcBO/wEvM5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m31fIvnK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m31fIvnK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446471F00898;
	Thu,  4 Jun 2026 13:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780581290;
	bh=HQ83PhwKa8kaM3c2P3g/kNKvrKLO3CEjnuMKvFJ30O8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m31fIvnKSAZ2tLIM0a35/9UJZMiLqqW0iwTNzfhny3QUIxU/3QO7NALr+mFnaE/g9
	 jUVFNLTtC4mEB6NfVA2tygTdfFzsSfLYiA0+e1Fgn911Pnz4SiYojYl2Nmw4KY3WdE
	 KrkSkP6H/50HbCL4BUQVoQP9zci1tzfYXTJOWwhwt69zTCEibsqBtCBq5sFQXfTRSG
	 6MSUjJMbswSj2UvWut6KeDWX3kTMC/gr4R+LHz4eRFxL0L14uoI9Mrsnsurx3ZaItx
	 h22mp57A3iO241NaanIDLD/brraYPXfNtwBndFJcPYRF8lAaM1qVWCeFD3aDSMTUwf
	 CWeFBznFylS7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] iio: adc: npcm: Convert to platform remove callback returning void
Date: Thu,  4 Jun 2026 09:54:46 -0400
Message-ID: <20260604135447.3493139-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604135447.3493139-1-sashal@kernel.org>
References: <2026060418-roving-osmosis-79bc@gregkh>
 <20260604135447.3493139-1-sashal@kernel.org>
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

