Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E63471439
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784807111; cv=none; b=ReLS4+cKGbb8m5fdiR+W7r+Bm+I+6CImq/yj25r0ZhyNuCsR55tqtKy+84KsMSDWTM9KOsndEBybQgeNrD8w356z6Q/vXaVBKwHaGeDw+ttgEAqBKD6CR8jSJkLFbfQuhU4CeSmmfhYZEG0x6oPdZmQUeT3KY6hQV/Wa19BykrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784807111; c=relaxed/simple;
	bh=j1SBGA0q4T6heruKm2Wl7n9LqARS/u1965P+INtL5c8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AscsRlqC/VV20voHOjJor4QZdF3JQV6dcdd3fXhAy1Mt1QKH+Y/HDBh9iBtt2ebO5ar18/7KZIL+tQE4aPAu7p1mOXesxmC2HnDyPWZOXW8EJ4q1c9vS8tj0u0fNqRtZ3h0pNGteIwif4IMUadSZX09qzVly9y6Y/g4kwIztYCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpftdTPW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpftdTPW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8DB1F000E9;
	Thu, 23 Jul 2026 11:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784807108;
	bh=Va+pgGRCI6GVegSWt+xBlj5KfTrKEm9ohr0o6Yr//tI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JpftdTPW0N3hZ6pOEwGehm3zRgFT9dx6TAUDXbD9QRsGC/A3DAhf4NsREWR+/Urfz
	 oL1EIqpA/MXPEm9mnxYtKeXLn+7Yttt5sSbrW7fLdzH8Imi2vJcJe9cPx3ZAcXD5dF
	 8I2/0H4RlEEROWP/Z/PT4qtOTZ4sraiXBJg6KA35JUNXW86TiW8ZdOb0oFcgbxl8ly
	 Mg3nKIR/NLPTL2z8TUDfO47V57l/fL7WBPLBHOvkzm0OhynL85gV673wCYJ+usieWL
	 xJKxZYH6Vex9tucBunDjukIzJrivx5UakQP0kmF0r1IeFRJSW3ElzC35PefHPK13xE
	 k/e25JOUmemww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/5] ASoC: mediatek: mt8192-afe-pcm: Convert to devm_pm_runtime_enable()
Date: Thu, 23 Jul 2026 07:45:02 -0400
Message-ID: <20260723114506.3038609-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072022-fading-available-28ca@gregkh>
References: <2026072022-fading-available-28ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit 7aaaa22de56ce0dae15fd9f42a69a1d1a7a6e078 ]

Switch from pm_runtime_enable() to devm_pm_runtime_enable(), allowing
to remove all gotos from the probe function.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Link: https://msgid.link/r/20240313110147.1267793-2-angelogioacchino.delregno@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: e24d5dde56a5 ("ASoC: mediatek: mt8192: Check runtime resume during probe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c | 46 ++++++++--------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
index 31c280339c503b..7ed36a760c87a2 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
@@ -2221,21 +2221,20 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	pm_runtime_enable(&pdev->dev);
-	if (!pm_runtime_enabled(&pdev->dev))
-		goto err_pm_disable;
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
 
 	/* regmap init */
 	afe->regmap = syscon_node_to_regmap(dev->parent->of_node);
 	if (IS_ERR(afe->regmap)) {
 		dev_err(dev, "could not get regmap from parent\n");
-		ret = PTR_ERR(afe->regmap);
-		goto err_pm_disable;
+		return PTR_ERR(afe->regmap);
 	}
 	ret = regmap_attach_dev(dev, afe->regmap, &mt8192_afe_regmap_config);
 	if (ret) {
 		dev_warn(dev, "regmap_attach_dev fail, ret %d\n", ret);
-		goto err_pm_disable;
+		return ret;
 	}
 
 	/* enable clock for regcache get default value from hw */
@@ -2245,7 +2244,7 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 	ret = regmap_reinit_cache(afe->regmap, &mt8192_afe_regmap_config);
 	if (ret) {
 		dev_err(dev, "regmap_reinit_cache fail, ret %d\n", ret);
-		goto err_pm_disable;
+		return ret;
 	}
 
 	pm_runtime_put_sync(&pdev->dev);
@@ -2258,10 +2257,8 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe->memif_size = MT8192_MEMIF_NUM;
 	afe->memif = devm_kcalloc(dev, afe->memif_size, sizeof(*afe->memif),
 				  GFP_KERNEL);
-	if (!afe->memif) {
-		ret = -ENOMEM;
-		goto err_pm_disable;
-	}
+	if (!afe->memif)
+		return -ENOMEM;
 
 	for (i = 0; i < afe->memif_size; i++) {
 		afe->memif[i].data = &memif_data[i];
@@ -2275,26 +2272,22 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe->irqs_size = MT8192_IRQ_NUM;
 	afe->irqs = devm_kcalloc(dev, afe->irqs_size, sizeof(*afe->irqs),
 				 GFP_KERNEL);
-	if (!afe->irqs) {
-		ret = -ENOMEM;
-		goto err_pm_disable;
-	}
+	if (!afe->irqs)
+		return -ENOMEM;
 
 	for (i = 0; i < afe->irqs_size; i++)
 		afe->irqs[i].irq_data = &irq_data[i];
 
 	/* request irq */
 	irq_id = platform_get_irq(pdev, 0);
-	if (irq_id < 0) {
-		ret = irq_id;
-		goto err_pm_disable;
-	}
+	if (irq_id < 0)
+		return irq_id;
 
 	ret = devm_request_irq(dev, irq_id, mt8192_afe_irq_handler,
 			       IRQF_TRIGGER_NONE, "asys-isr", (void *)afe);
 	if (ret) {
 		dev_err(dev, "could not request_irq for Afe_ISR_Handle\n");
-		goto err_pm_disable;
+		return ret;
 	}
 
 	/* init sub_dais */
@@ -2305,7 +2298,7 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_warn(afe->dev, "dai register i %d fail, ret %d\n",
 				 i, ret);
-			goto err_pm_disable;
+			return ret;
 		}
 	}
 
@@ -2314,7 +2307,7 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_warn(afe->dev, "mtk_afe_combine_sub_dai fail, ret %d\n",
 			 ret);
-		goto err_pm_disable;
+		return ret;
 	}
 
 	/* others */
@@ -2333,7 +2326,7 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 					      &mt8192_afe_component, NULL, 0);
 	if (ret) {
 		dev_warn(dev, "err_platform\n");
-		goto err_pm_disable;
+		return ret;
 	}
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
@@ -2342,15 +2335,10 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 					      afe->num_dai_drivers);
 	if (ret) {
 		dev_warn(dev, "err_dai_component\n");
-		goto err_pm_disable;
+		return ret;
 	}
 
 	return 0;
-
-err_pm_disable:
-	pm_runtime_disable(&pdev->dev);
-
-	return ret;
 }
 
 static int mt8192_afe_pcm_dev_remove(struct platform_device *pdev)
-- 
2.53.0

