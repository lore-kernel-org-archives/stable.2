Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AB241DDE5
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806634; cv=none; b=a9GdALRpgxMTcjYNo1IqHu02hasbyWVaw25uMFGVN5B/DlWm2n+cVTpYLzVeQgZcniL7WO3qeRn1MtCEZ991YWiqCScnBUgP/oOONoj4TMtlTKCji/gGoGPecjjb/Wp2W1ssrj6U5iEHVQ8rySRRk11dH+N67myMaImJXiE5Nkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806634; c=relaxed/simple;
	bh=wugj+hZNOz+Oq7ymLokNrlPsz5qNmHio3Zyd0cBXQkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNJsMH62Vni3KRKy0JNhiv85rVKZgBJFM3CZ3XvrwMAJxsiaMiroiiikWbKFPdVpS/krJZJYdLZKD6nQezwP3OlglFY8LP4YDX9kke5uk15uWwmufuBCbOziflQckUL4ov+DZubtJCyAywzkXZdoBfTrZ805Tyfx4nnH40ekVBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUA+SgLl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUA+SgLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02991F00A3A;
	Thu, 23 Jul 2026 11:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784806633;
	bh=172DACFbwUKcliP2BpwMYb4iXdpdYSXCFztaOdtl1oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lUA+SgLlLotxjkAccVQRYFWL/RkqIzs8KdR+R6DyYVy/6RSQ7glUU9GfYXm/scwQk
	 sEwRXni3dNy4E/vex3gCDG2nu0dR7AYZNLWdJKfBYj+IDJEbOReDSYW3FXHkhbN4jQ
	 4t/1Ks+OmDsqwMyRuxg4+h5eZxvZ8V3XT+YL8/G/ccZyJME7tJtZ7ueK8MDjPd/e2Q
	 lV/DiWtc4+aJeUHQkmVSb7J7xTFR1CpW0AjALDXa8N2hiQXu81Ex1TKXxLWvS9Ri6+
	 kFuLqpf3aFREth+vcTMn6lSXN2Iane4y+M5xAxh+nD7KrhRa8qgHUtN/NomLnnTaK7
	 o+0JC/CWGo3Ng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tang Bin <tangbin@cmss.chinamobile.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/5] ASoC: mediatek: mt8192-afe-pcm: Simplify probe() with local dev variable
Date: Thu, 23 Jul 2026 07:37:06 -0400
Message-ID: <20260723113708.3035236-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723113708.3035236-1-sashal@kernel.org>
References: <2026072022-taps-consensus-7d8b@gregkh>
 <20260723113708.3035236-1-sashal@kernel.org>
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
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
index b627b822e4ce10..345343e8842017 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
@@ -2178,27 +2178,26 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
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
 
 	/* init audio related clock */
 	ret = mt8192_init_clock(afe);
@@ -2216,7 +2215,7 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to trigger audio reset\n");
 
-	ret = devm_pm_runtime_enable(&pdev->dev);
+	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return ret;
 
@@ -2305,12 +2304,12 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe->runtime_suspend = mt8192_afe_runtime_suspend;
 
 	/* register platform */
-	ret = devm_snd_soc_register_component(&pdev->dev,
+	ret = devm_snd_soc_register_component(dev,
 					      &mt8192_afe_component, NULL, 0);
 	if (ret)
 		return dev_err_probe(dev, ret, "Couldn't register AFE component\n");
 
-	ret = devm_snd_soc_register_component(&pdev->dev,
+	ret = devm_snd_soc_register_component(dev,
 					      &mt8192_afe_pcm_component,
 					      afe->dai_drivers,
 					      afe->num_dai_drivers);
-- 
2.53.0

