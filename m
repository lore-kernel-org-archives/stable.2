Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A077E471D0A
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784807111; cv=none; b=Jwqi3FAxPbC8Ud+FZFeLZJNm0X/d8shRiksIR4Lunutz7RPDD9T6RtsRcm0mMEkz0Or1GaaEplmY8BCkWWdcDHxq7DdLOG1SwdDMBV71JNf6uzF+6xkk1P7mZtsa+dg5oeWE2LvNH3hf06k1DaIB+ghJvn7ujsqEoAQDRjnOrVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784807111; c=relaxed/simple;
	bh=zuwrri4FOWx31FzI5j+4Cl8X1iNe8fdpR4p3nAVfJEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKgyPUjE68d4B6DSX93unGRsw10Pny9H07C19ER3ibo5OVOMG7n01jLMrvDq+1XL8vgVCJBLtkx28hIHYbnQqu31mIJrOybrnj26VhOB4txRHheZy/3smLB6vK2bpmiG4aluPsISf8cqSs6zCvtUE5bkrdj0l4+j/VbuhRe5VSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdDKfPtc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdDKfPtc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11621F00A3E;
	Thu, 23 Jul 2026 11:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784807109;
	bh=KOz+BPLI12htZKqUc9j8/hgbWB2ZYoavcBsrzyWuNiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EdDKfPtcdgiNVZhHJR/z13UwPe4eTO3+Vd9WX611QoqssVC8nGo8CV2X3FAkyfVAB
	 QEfnoZVXbz1ieuxtGlLXS/tGXIcZK4WEm9PSs2ke/rPXBWEkKyRWhEOrJ7w502mdxz
	 we5XooAfC179+v5A6PA+S64tRT5GiWs5+w9kgAwm5elZkrB+6GVL/x+BMcz6J3w828
	 vBv5JvV363+vkJmhhvJZ0cs31Up8ngH/zAjw46mew5HwtoRDST8FhXjEX1/9sHDWk/
	 CZHYXM6iocikVD7M1QajTmOxm2SL+gmeMjxgvN1UNOb9dS3ZWIK1hYRzzRU1YRnRgB
	 acr4OMrRFKu8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/5] ASoC: mediatek: mt8192-afe-pcm: Simplify with dev_err_probe()
Date: Thu, 23 Jul 2026 07:45:03 -0400
Message-ID: <20260723114506.3038609-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723114506.3038609-1-sashal@kernel.org>
References: <2026072022-fading-available-28ca@gregkh>
 <20260723114506.3038609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit 324c603a4efca7d1045e0bf3477ca54970eac72c ]

Simplify the probe function by switching error prints to return
dev_err_probe(), lowering the lines count; while at it, also
beautify some messages and change some others' level from warn
to error.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Link: https://msgid.link/r/20240313110147.1267793-3-angelogioacchino.delregno@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: e24d5dde56a5 ("ASoC: mediatek: mt8192: Check runtime resume during probe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c | 65 ++++++++--------------
 1 file changed, 22 insertions(+), 43 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
index 7ed36a760c87a2..75ceecad408078 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
@@ -2209,17 +2209,12 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	/* reset controller to reset audio regs before regmap cache */
 	rstc = devm_reset_control_get_exclusive(dev, "audiosys");
-	if (IS_ERR(rstc)) {
-		ret = PTR_ERR(rstc);
-		dev_err(dev, "could not get audiosys reset:%d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(rstc))
+		return dev_err_probe(dev, PTR_ERR(rstc), "could not get audiosys reset\n");
 
 	ret = reset_control_reset(rstc);
-	if (ret) {
-		dev_err(dev, "failed to trigger audio reset:%d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to trigger audio reset\n");
 
 	ret = devm_pm_runtime_enable(&pdev->dev);
 	if (ret)
@@ -2227,25 +2222,21 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	/* regmap init */
 	afe->regmap = syscon_node_to_regmap(dev->parent->of_node);
-	if (IS_ERR(afe->regmap)) {
-		dev_err(dev, "could not get regmap from parent\n");
-		return PTR_ERR(afe->regmap);
-	}
+	if (IS_ERR(afe->regmap))
+		return dev_err_probe(dev, PTR_ERR(afe->regmap),
+				     "could not get regmap from parent");
+
 	ret = regmap_attach_dev(dev, afe->regmap, &mt8192_afe_regmap_config);
-	if (ret) {
-		dev_warn(dev, "regmap_attach_dev fail, ret %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "regmap_attach_dev fail\n");
 
 	/* enable clock for regcache get default value from hw */
 	afe_priv->pm_runtime_bypass_reg_ctl = true;
 	pm_runtime_get_sync(&pdev->dev);
 
 	ret = regmap_reinit_cache(afe->regmap, &mt8192_afe_regmap_config);
-	if (ret) {
-		dev_err(dev, "regmap_reinit_cache fail, ret %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "regmap_reinit_cache fail\n");
 
 	pm_runtime_put_sync(&pdev->dev);
 	afe_priv->pm_runtime_bypass_reg_ctl = false;
@@ -2285,30 +2276,22 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(dev, irq_id, mt8192_afe_irq_handler,
 			       IRQF_TRIGGER_NONE, "asys-isr", (void *)afe);
-	if (ret) {
-		dev_err(dev, "could not request_irq for Afe_ISR_Handle\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "could not request_irq for Afe_ISR_Handle\n");
 
 	/* init sub_dais */
 	INIT_LIST_HEAD(&afe->sub_dais);
 
 	for (i = 0; i < ARRAY_SIZE(dai_register_cbs); i++) {
 		ret = dai_register_cbs[i](afe);
-		if (ret) {
-			dev_warn(afe->dev, "dai register i %d fail, ret %d\n",
-				 i, ret);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(afe->dev, ret, "dai %d register fail", i);
 	}
 
 	/* init dai_driver and component_driver */
 	ret = mtk_afe_combine_sub_dai(afe);
-	if (ret) {
-		dev_warn(afe->dev, "mtk_afe_combine_sub_dai fail, ret %d\n",
-			 ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(afe->dev, ret, "mtk_afe_combine_sub_dai fail\n");
 
 	/* others */
 	afe->mtk_afe_hardware = &mt8192_afe_hardware;
@@ -2324,19 +2307,15 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 	/* register platform */
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &mt8192_afe_component, NULL, 0);
-	if (ret) {
-		dev_warn(dev, "err_platform\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Couldn't register AFE component\n");
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &mt8192_afe_pcm_component,
 					      afe->dai_drivers,
 					      afe->num_dai_drivers);
-	if (ret) {
-		dev_warn(dev, "err_dai_component\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Couldn't register AFE-PCM component\n");
 
 	return 0;
 }
-- 
2.53.0

