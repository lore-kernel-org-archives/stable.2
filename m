Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01693537D0
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 02:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784773762; cv=none; b=BakUnapk9i6odrkxziQgVW05b86vPCxZ9q+c9V+/5NA5A64dWYIImyEZXdnqXI8Jp0NJYy1FbqOl96QuzLFI63W1wQYrgxfjpTDy3imV+zkdcKqGX2NGdQtA+m2J1Ine6jRa7ryhC0DvkRbn5o8JyyUkEC6srtX7nFrgQN58K6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784773762; c=relaxed/simple;
	bh=Megn0y++d24pqNgbiXxgXO0LzeAZp079/cdCTYyBOVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUW1Nn+/SP4GJGnBhJB811a7Em2URlxsz/V5lmpMDWz01pNuC+Gpzt5dvqCQQGcn5Wbbt/VViZSTnqCVMXyfgRYdcageq/w1FgUIlyHmhUUYi2cg/+r1bsdbNtkYMD5JgbsX44xCnnaVS2pJN0ZWrABub2PEeAbaR1JehLcK7js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6HHaOf5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6HHaOf5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D801F00A3E;
	Thu, 23 Jul 2026 02:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784773760;
	bh=q/TWAk5AvcskufTODorMFrjc24qbdAvDkLIS/SWyVc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l6HHaOf5oUl7HiFxxIaE5miPK9RdcddvQy6XuoBv3bPdpISoemLbNdgWp802Ghoh1
	 LasQNO/3wrkHPMYOnQvxU+kuR7HiH35Fs+apbMX7NNfi4u9bnk/e/dOWIYrIgXklOi
	 MU6u+eJ00BFLe4KJBFNHqFtTw35NOxi50/cyE665rbFxynnVs4NUVC2OPIeAe00vFC
	 pw/US7lUbFARpLyRemXPLZ77KpqdRTWTr2apP9Dgo5bglFEg+oZlcbvue+lD1wCj6x
	 pa7yYyhFMYS1CFOhEaz20s084lbiv6KIhQs4zLy0QeN+yCgF5gRabnvQ45falhUA3z
	 YUsl5BexxMjhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tang Bin <tangbin@cmss.chinamobile.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/6] ASoC: mediatek: mt8192-afe-pcm: Simplify probe() with local dev variable
Date: Wed, 22 Jul 2026 22:29:14 -0400
Message-ID: <20260723022915.2845450-5-sashal@kernel.org>
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
index e7e3f2cb3e8f78..29e3a2d121521d 100644
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

