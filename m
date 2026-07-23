Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A093515FF
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 02:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784773761; cv=none; b=cmWbzuMGudSe5g7iNJ+P4V90pSFLbsYaK/TTJd5AcyrlRXY1z5rSjITfJtMydZkwUJ+vbyVsTMONzbdHcUtmuCkIfWdO6usQw/Lkh1LEFcxg1bOuDTNPiE+quSx15ffiRc3BJfhajLfU5w2E11+1JCeclfnx53BEe72sjEArP/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784773761; c=relaxed/simple;
	bh=tk8u7az0+LJKh++UKfwVBCLebMVeAO8yO6Jwv5BStAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpeVk6GWnUu8rGLAechHM5BrR0oOenfiC0r6zXXQirF6Yc6frKVx7RWElx2Px3qKhlqJ7IVpHefi8giaCFJWbTkPklJmpDB8AwqwHn6lCyUIRjKH6gVWRkEtNiY43x/KcAW+ip8E4O/mxfeGLUqNW93XRqBWqI+Sf0pmgHlvYwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHjzft/l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHjzft/l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C0C1F00A3D;
	Thu, 23 Jul 2026 02:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784773759;
	bh=fuoVOVlXUqvS7ofYy5sj9H0WAqzzQ2UtEskeWNkKY4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UHjzft/lrjFnFbL85gwPLFOxYH3TnGTokrcCPR1bn9DFMpn5MffLRk3i+nUCio4wv
	 cEYHq+Rc4ZHlLN7Y2cMEJNKaRHYmjBSNQ4nCCUQFFtf6ouxvzrRO+KqUL5k6N0T5l5
	 VfN4TxFN23IFNbOM+3O2ap6PsdhsCqmhMD2lGrbSg26Q5vQOTyDmu7fqLcL7x8FNq9
	 BFBbhhESxc613tNgfkyDPtDGe0dcC+uTkjIgPkajm1g2huCORfKmp+rSIM2qJRfORI
	 23QUqIHOgcIURxrPXCuNdIJOUiSce06koirT97OxnJRQlnjedpZ9B1hCRiY9p4Ax2D
	 Q/rcYRZGOo1IA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/6] ASoC: mediatek: Use common mtk_afe_pcm_platform with common probe cb
Date: Wed, 22 Jul 2026 22:29:13 -0400
Message-ID: <20260723022915.2845450-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723022915.2845450-1-sashal@kernel.org>
References: <2026072021-woof-etching-9d40@gregkh>
 <20260723022915.2845450-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit 1d2a6b3b5189b6c3e51f29e050aa9b2337b774e8 ]

Since the mtk-afe-platform-driver generic mtk_afe_pcm_platform now has
a common .probe() callback, there is no reason to keep duplicating this
function over and over in the SoC specific AFE-PCM drivers: switch over
to register with the common bits instead.

Note that MT8186 was left out of this because it is registering some
extra sinegen controls in the AFE-PCM probe callback and needs extra
cleanups to be able to use the common bits.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20240416071410.75620-13-angelogioacchino.delregno@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: e24d5dde56a5 ("ASoC: mediatek: mt8192: Check runtime resume during probe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c | 14 +-----------
 sound/soc/mediatek/mt7986/mt7986-afe-pcm.c | 14 +-----------
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 14 +-----------
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c | 21 +-----------------
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c | 25 ++--------------------
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c | 21 +-----------------
 6 files changed, 7 insertions(+), 102 deletions(-)

diff --git a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
index 43038444c43dce..5c9b464f026c10 100644
--- a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
+++ b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
@@ -704,18 +704,6 @@ static int mt6797_afe_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int mt6797_afe_component_probe(struct snd_soc_component *component)
-{
-	return mtk_afe_add_sub_dai_control(component);
-}
-
-static const struct snd_soc_component_driver mt6797_afe_component = {
-	.name		= AFE_PCM_NAME,
-	.probe		= mt6797_afe_component_probe,
-	.pointer	= mtk_afe_pcm_pointer,
-	.pcm_construct	= mtk_afe_pcm_new,
-};
-
 static int mt6797_dai_memif_register(struct mtk_base_afe *afe)
 {
 	struct mtk_base_afe_dai *dai;
@@ -852,7 +840,7 @@ static int mt6797_afe_pcm_dev_probe(struct platform_device *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 
 	/* register component */
-	ret = devm_snd_soc_register_component(dev, &mt6797_afe_component,
+	ret = devm_snd_soc_register_component(dev, &mtk_afe_pcm_platform,
 					      NULL, 0);
 	if (ret) {
 		dev_warn(dev, "err_platform\n");
diff --git a/sound/soc/mediatek/mt7986/mt7986-afe-pcm.c b/sound/soc/mediatek/mt7986/mt7986-afe-pcm.c
index d497e112988993..c1c486e275b9d3 100644
--- a/sound/soc/mediatek/mt7986/mt7986-afe-pcm.c
+++ b/sound/soc/mediatek/mt7986/mt7986-afe-pcm.c
@@ -429,18 +429,6 @@ static int mt7986_afe_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int mt7986_afe_component_probe(struct snd_soc_component *component)
-{
-	return mtk_afe_add_sub_dai_control(component);
-}
-
-static const struct snd_soc_component_driver mt7986_afe_component = {
-	.name = AFE_PCM_NAME,
-	.probe = mt7986_afe_component_probe,
-	.pointer	= mtk_afe_pcm_pointer,
-	.pcm_construct	= mtk_afe_pcm_new,
-};
-
 static int mt7986_dai_memif_register(struct mtk_base_afe *afe)
 {
 	struct mtk_base_afe_dai *dai;
@@ -573,7 +561,7 @@ static int mt7986_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	/* register component */
 	ret = devm_snd_soc_register_component(&pdev->dev,
-					      &mt7986_afe_component,
+					      &mtk_afe_pcm_platform,
 					      NULL, 0);
 	if (ret)
 		return dev_err_probe(dev, ret, "Cannot register AFE component\n");
diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
index cbee5a8764c37f..ae38a44aba6101 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -1043,18 +1043,6 @@ static int mt8183_afe_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int mt8183_afe_component_probe(struct snd_soc_component *component)
-{
-	return mtk_afe_add_sub_dai_control(component);
-}
-
-static const struct snd_soc_component_driver mt8183_afe_component = {
-	.name		= AFE_PCM_NAME,
-	.probe		= mt8183_afe_component_probe,
-	.pointer	= mtk_afe_pcm_pointer,
-	.pcm_construct	= mtk_afe_pcm_new,
-};
-
 static int mt8183_dai_memif_register(struct mtk_base_afe *afe)
 {
 	struct mtk_base_afe_dai *dai;
@@ -1239,7 +1227,7 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	/* register component */
 	ret = devm_snd_soc_register_component(&pdev->dev,
-					      &mt8183_afe_component,
+					      &mtk_afe_pcm_platform,
 					      NULL, 0);
 	if (ret) {
 		dev_warn(dev, "err_platform\n");
diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
index 4a304bffef8bab..b2e2eb959aa5f5 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
@@ -3027,25 +3027,6 @@ static int mt8188_afe_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int mt8188_afe_component_probe(struct snd_soc_component *component)
-{
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
-	int ret;
-
-	snd_soc_component_init_regmap(component, afe->regmap);
-
-	ret = mtk_afe_add_sub_dai_control(component);
-
-	return ret;
-}
-
-static const struct snd_soc_component_driver mt8188_afe_component = {
-	.name = AFE_PCM_NAME,
-	.pointer       = mtk_afe_pcm_pointer,
-	.pcm_construct = mtk_afe_pcm_new,
-	.probe         = mt8188_afe_component_probe,
-};
-
 static int init_memif_priv_data(struct mtk_base_afe *afe)
 {
 	struct mt8188_afe_private *afe_priv = afe->platform_priv;
@@ -3347,7 +3328,7 @@ static int mt8188_afe_pcm_dev_probe(struct platform_device *pdev)
 	}
 
 	/* register component */
-	ret = devm_snd_soc_register_component(dev, &mt8188_afe_component,
+	ret = devm_snd_soc_register_component(dev, &mtk_afe_pcm_platform,
 					      afe->dai_drivers, afe->num_dai_drivers);
 	if (ret) {
 		dev_warn(dev, "err_platform\n");
diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
index 849d0d46c2fa1e..e7e3f2cb3e8f78 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
@@ -2126,22 +2126,6 @@ static int mt8192_afe_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int mt8192_afe_component_probe(struct snd_soc_component *component)
-{
-	return mtk_afe_add_sub_dai_control(component);
-}
-
-static const struct snd_soc_component_driver mt8192_afe_component = {
-	.name = AFE_PCM_NAME,
-	.probe = mt8192_afe_component_probe,
-	.pointer = mtk_afe_pcm_pointer,
-	.pcm_construct = mtk_afe_pcm_new,
-};
-
-static const struct snd_soc_component_driver mt8192_afe_pcm_component = {
-	.name = "mt8192-afe-pcm-dai",
-};
-
 static int mt8192_dai_memif_register(struct mtk_base_afe *afe)
 {
 	struct mtk_base_afe_dai *dai;
@@ -2309,16 +2293,11 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	/* register platform */
 	ret = devm_snd_soc_register_component(&pdev->dev,
-					      &mt8192_afe_component, NULL, 0);
-	if (ret)
-		return dev_err_probe(dev, ret, "Couldn't register AFE component\n");
-
-	ret = devm_snd_soc_register_component(&pdev->dev,
-					      &mt8192_afe_pcm_component,
+					      &mtk_afe_pcm_platform,
 					      afe->dai_drivers,
 					      afe->num_dai_drivers);
 	if (ret)
-		return dev_err_probe(dev, ret, "Couldn't register AFE-PCM component\n");
+		return dev_err_probe(dev, ret, "Couldn't register AFE component\n");
 
 	return 0;
 }
diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
index d1594904ad80e8..c83126a1b75428 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
@@ -2944,25 +2944,6 @@ static int mt8195_afe_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int mt8195_afe_component_probe(struct snd_soc_component *component)
-{
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
-	int ret = 0;
-
-	snd_soc_component_init_regmap(component, afe->regmap);
-
-	ret = mtk_afe_add_sub_dai_control(component);
-
-	return ret;
-}
-
-static const struct snd_soc_component_driver mt8195_afe_component = {
-	.name = AFE_PCM_NAME,
-	.pointer = mtk_afe_pcm_pointer,
-	.pcm_construct = mtk_afe_pcm_new,
-	.probe = mt8195_afe_component_probe,
-};
-
 static int init_memif_priv_data(struct mtk_base_afe *afe)
 {
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
@@ -3164,7 +3145,7 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
 	}
 
 	/* register component */
-	ret = devm_snd_soc_register_component(dev, &mt8195_afe_component,
+	ret = devm_snd_soc_register_component(dev, &mtk_afe_pcm_platform,
 					      afe->dai_drivers, afe->num_dai_drivers);
 	if (ret) {
 		dev_warn(dev, "err_platform\n");
-- 
2.53.0

