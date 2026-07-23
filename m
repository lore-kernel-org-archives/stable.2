Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B552D471435
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784807111; cv=none; b=UUDRwpZsZrxdMVmkkKzFiUZURRgjHGX3Ok+6vgb5+frIRnP0SH+15NgygPWhpESH0DdcCPoDeWUHTrZMWSKVjHvClizL3B44TVSu1cwLASdOrPuQTUWt2iGhllBzZK6Lgsc6m1WJJpmC4DR5iKH0FXMiH7Q/l9fdj8StDfP9AYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784807111; c=relaxed/simple;
	bh=J/GFYocq/F6751sG1R/dhEAzGIX+REfdDM+5vd0y/rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLoVmlVh4vuFcXsqdPzJfy6PuDAaSN6RmUwJCwVdB9KJoS71hQs5QMVI829RPBFZNLy4yLHQkjjX94ATeBlMyN4qJEsvtOrWy+I8qECfPbgDh2nooxZg06sj82J+Ef+ydwAvYJUscnpJvwA9D+ZB8+xJGqFJO2cRiXUqLOIIZTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTIt0hqJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTIt0hqJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35861F00ACA;
	Thu, 23 Jul 2026 11:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784807110;
	bh=zOz6b/v0DB9MrLDjuXlzPs5DBiCoOyMJgkN2crDq+1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oTIt0hqJ7tUqK765I6QlDoJbzrA+Kv5VG7sX7r5MLbxKZB/+qt/tWYhXjl31g4dzr
	 faN8cm21SXbuK8MoEt+tYVQRjKpMapFnUhTEbf/GS1WIN1o08NPGfHadUvC0p7A10t
	 hhxxcsaZrQCH1qr2Kam78KZkbBrYUupmbhFmQQ4YZ0UhIZxtXXECQq4ahGlFptLEx5
	 7oLkZU/ubcRg+ZXJ3kzXr36j9laMAQV2ntJuO+s90Zk9A+1V94bflyXZQEDcjGg6qs
	 Ai1D4ukxLezS4tiHGPOTCRu++PYMMgK3AbIJJ6DhZlCuHf2LLhskjNoSQ2SxghSNw1
	 l9wRRgIDt6/NQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/5] ASoC: mediatek: Use common mtk_afe_pcm_platform with common probe cb
Date: Thu, 23 Jul 2026 07:45:04 -0400
Message-ID: <20260723114506.3038609-3-sashal@kernel.org>
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
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
index 75ceecad408078..7562bea5b34c05 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
@@ -2232,13 +2232,13 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 
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
-- 
2.53.0

