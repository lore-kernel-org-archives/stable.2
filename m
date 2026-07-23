Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4B13019D6
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 02:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784773759; cv=none; b=rudh4TgzPRJFX62YnMvw1bpgsaxxSdxHX6XFUMdn/bGuvpda4NHm3cXlw9EJPm4Uf79sXIwQvOtQHvhU9CKTTvkbUSqmYEKwv1fM67oW70e0HLJRxvbOfJWpzu4+cy18B98fHvCUp9xwipoZwEUZt6nxQzS11kNxlkODXjgocMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784773759; c=relaxed/simple;
	bh=KdFMf3/vEwG+M84dzva9GKsbr5kPXyQMuErW/aN3NnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRFPBpxmQ78Z6lqKwmfyS/YJ9YDKobsUlqOKhwtGH6K/4AFXuD9bGpCOXoFTRr4ypkA9ohT0KuT0XxkRJCCX1QUw/etS3wwmsNMBlUaZrtf/1AubiqD0h5u5fk6pODrRwWItsNtt3AqcqjxoguKh6Jwlsvv45AbgEm7QUrCzEeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxXWUEi1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxXWUEi1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8881F1F00A3A;
	Thu, 23 Jul 2026 02:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784773758;
	bh=VF2D6Ns+nmlhrpIUhsfpS5nJzsaUMrYF0WArhX38k7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SxXWUEi1TPB/XustfrXZLMxSa3FufEaNcHdKckU1hxlu4vdmMI8Gt89BcKkJWxTSs
	 5Vw5G2eYW4sTF0GOsTmFnO6ZJPludJgfQwQqf6jK327Pw9pWrATnm2g4w/UP+kyrYy
	 Gzh+cMT8av/YKdfVUT9NED1njKl4vRyvtyvgEkl23KHBaEcfVjdvfQPnw+QZv3rqXw
	 L2AN4guS+gh5+d6UITpr/mcYdK2RsI4k1qHRSkPJtM3JPbe23Rs7blEgiLWQHCnHZT
	 iXcgnMSVUV1Bhac72wpUj/d3wa2jIbkICO52LwDXOEgUMTNCeEawyjfNbgRxLrmOZp
	 VgS1FtL3ubhhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/6] ASoC: mediatek: mt8192-afe-pcm: Convert to devm_pm_runtime_enable()
Date: Wed, 22 Jul 2026 22:29:11 -0400
Message-ID: <20260723022915.2845450-2-sashal@kernel.org>
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
index 364e43da0e2416..99bcc9b0b881a6 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
@@ -2224,21 +2224,20 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
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
@@ -2248,7 +2247,7 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 	ret = regmap_reinit_cache(afe->regmap, &mt8192_afe_regmap_config);
 	if (ret) {
 		dev_err(dev, "regmap_reinit_cache fail, ret %d\n", ret);
-		goto err_pm_disable;
+		return ret;
 	}
 
 	pm_runtime_put_sync(&pdev->dev);
@@ -2261,10 +2260,8 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
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
@@ -2278,26 +2275,22 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
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
@@ -2308,7 +2301,7 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_warn(afe->dev, "dai register i %d fail, ret %d\n",
 				 i, ret);
-			goto err_pm_disable;
+			return ret;
 		}
 	}
 
@@ -2317,7 +2310,7 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_warn(afe->dev, "mtk_afe_combine_sub_dai fail, ret %d\n",
 			 ret);
-		goto err_pm_disable;
+		return ret;
 	}
 
 	/* others */
@@ -2336,7 +2329,7 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 					      &mt8192_afe_component, NULL, 0);
 	if (ret) {
 		dev_warn(dev, "err_platform\n");
-		goto err_pm_disable;
+		return ret;
 	}
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
@@ -2345,15 +2338,10 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
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
 
 static void mt8192_afe_pcm_dev_remove(struct platform_device *pdev)
-- 
2.53.0

