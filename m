Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E0C1DA62E
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 01:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769440; cv=none; b=AKlvlaJPW2d2usN7IBpfl8c2U1Egs0yTSL/JK0OOpYGaEdYpCHgeDLYuUedeWDnFooPS5EzEoUzbKFFBNhYVc52mJjSITg0h1DqtjPPcS5lIqlBfoVe7gIqD31vbJWoHh8ilksolszKVkfcxLU3M3/7D86Y4oa/255W+5vSYmT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769440; c=relaxed/simple;
	bh=YWFi661txqnIl7PJWOxLQKYXlCTzjd2/9+sV3sDU5KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fksMBk+E4MH+n36Qd9CK96UEobGdIyY9MH2OvAJUlz7vFGWk8ZbX+pexXZW/KXruI/hlgttPvyceI0V+z7aaeRwi5r8SnBi9Dz/5OdjxAChGZUoyC3NoTt20JlOkFZ8HyLaJTSfWgGbwwGsjS1O/lS6I3zPXNCMsSAOfQffc004=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW00lwLw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW00lwLw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574631F000E9;
	Thu, 23 Jul 2026 01:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784769437;
	bh=jXmIUw/0l85H9aKyiO3rj7vuuunTxEz4OaXNEKHj4uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NW00lwLwvedqrwnF0lx6jNB+yEGCXOZNut29cPJBG4LOP6a1cSb1vTb/U5NcZC2Ab
	 wAUNljOOzOqQ6WeRYzkcoCYUyGc08CKPelk/BJIxI0WbyY1Hl0ZlKYGn7RVvFtivo9
	 PuxAmpwpExM9L9BdsWEzlnDgqFgepREyr6IqXqq7hCbyxzlJ5V+JZKeqkqTgpnkutv
	 sRhZMubtXp6t4FlMh7wo45VXNXreQnVJlU0cGBzuPBM/3hC1N+DCMxnFyxHvOGCpv0
	 MwjDrL656SQrLHYAvmvOTqQ7VV1p69GJ/ueNly6RfAkkpMmwLNOKMT/nsTHdzdxOHD
	 dG+nHIa0gkjcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tang Bin <tangbin@cmss.chinamobile.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] ASoC: mediatek: mt8192-afe-pcm: Simplify probe() with local dev variable
Date: Wed, 22 Jul 2026 21:17:14 -0400
Message-ID: <20260723011715.2780615-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072021-slicer-fleshed-2403@gregkh>
References: <2026072021-slicer-fleshed-2403@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Bin <tangbin@cmss.chinamobile.com>

[ Upstream commit 01981565c764c554cc96e2d30a71c42975171416 ]

Simplify the function mt8192_afe_pcm_dev_probe() by
using local 'dev' instead of '&pdev->dev'.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
Link: https://patch.msgid.link/20241025080026.2393-1-tangbin@cmss.chinamobile.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: e24d5dde56a5 ("ASoC: mediatek: mt8192: Check runtime resume during probe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
index 69ed34495d0f73..6638307935ee9c 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
@@ -2159,27 +2159,26 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 {
 	struct mtk_base_afe *afe;
 	struct mt8192_afe_private *afe_priv;
-	struct device *dev;
+	struct device *dev = &pdev->dev;
 	struct reset_control *rstc;
 	int i, ret, irq_id;
 
-	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(34));
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(34));
 	if (ret)
 		return ret;
 
-	afe = devm_kzalloc(&pdev->dev, sizeof(*afe), GFP_KERNEL);
+	afe = devm_kzalloc(dev, sizeof(*afe), GFP_KERNEL);
 	if (!afe)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, afe);
 
-	afe->platform_priv = devm_kzalloc(&pdev->dev, sizeof(*afe_priv),
+	afe->platform_priv = devm_kzalloc(dev, sizeof(*afe_priv),
 					  GFP_KERNEL);
 	if (!afe->platform_priv)
 		return -ENOMEM;
 	afe_priv = afe->platform_priv;
 
-	afe->dev = &pdev->dev;
-	dev = afe->dev;
+	afe->dev = dev;
 
 	ret = of_reserved_mem_device_init(dev);
 	if (ret) {
@@ -2203,7 +2202,7 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to trigger audio reset\n");
 
-	ret = devm_pm_runtime_enable(&pdev->dev);
+	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return ret;
 
@@ -2219,13 +2218,13 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	/* enable clock for regcache get default value from hw */
 	afe_priv->pm_runtime_bypass_reg_ctl = true;
-	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_get_sync(dev);
 
 	ret = regmap_reinit_cache(afe->regmap, &mt8192_afe_regmap_config);
 	if (ret)
 		return dev_err_probe(dev, ret, "regmap_reinit_cache fail\n");
 
-	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_put_sync(dev);
 	afe_priv->pm_runtime_bypass_reg_ctl = false;
 
 	regcache_cache_only(afe->regmap, true);
@@ -2292,7 +2291,7 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe->runtime_suspend = mt8192_afe_runtime_suspend;
 
 	/* register platform */
-	ret = devm_snd_soc_register_component(&pdev->dev,
+	ret = devm_snd_soc_register_component(dev,
 					      &mtk_afe_pcm_platform,
 					      afe->dai_drivers,
 					      afe->num_dai_drivers);
-- 
2.53.0

