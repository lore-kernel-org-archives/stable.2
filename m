Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672AB23E320
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 02:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784775504; cv=none; b=lkQq9sJ6jHpbUqzJEJYiQCyJJcXdrPL0aZL4O6ubjk8BtgETJfQFrKVac39WrfgeL+9/O/d5dueye4LGN4dlURtDhBvXKSu7mpFuybwYUouk1bM8Gq7S6ggeOxtLBVBx+cRggQixp6OY06oukRmtFY832Xipy2bFyUtygP9RGes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784775504; c=relaxed/simple;
	bh=ANT9lD5Z9Ux/D8a31U+ja8pR8oXEcgwhSR5gp+eUfjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K2bYxPzGMJ/GixJB1YfoMxaxc5CyQ1Qrwd1A+XviCyd+UTOH3EIW79DZucn5tiSgSoI4tNcPR5jEwOieRMfh28Z28IPzM66ipuaEO5UyOHQqFVOf+fQ8rAQWzAnD/4OGkmjv6zFKb803pZE5NDyaFaCOGW7XboE4NWgm1bAaFf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htGrmWlG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htGrmWlG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C391F000E9;
	Thu, 23 Jul 2026 02:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784775503;
	bh=NXH1PYPmRQBXgOGLghuwu0WU8atzjVHdE/+F1JWr3Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=htGrmWlGcVk44OZJYbJc29AObsTjOTBQ8pu+SeeJ836H+4B5pxVB01CRw2u7Q6aYI
	 dfBFdMHDACcw9I0bNd6gW1B2FpFb1kXIDblt5dXXUJuGhuRx5YC0laKAJ6yXHdvwE2
	 rEOMA8mSO9jCetYYt/6DkMKmZvWvcWTaV+LQ2jL5sOBpLt9CDmHtqTScr75TsM2hk2
	 2FEMpVdCH28peNQotqdXwgdkSOMGCmmkJAvkHBMHLxyx60DU5kpdt5Dp2H4vYn1t4o
	 bz8B+QO1QAXlTh+V9KWZh57/g2DMwut7tsK79Y0LoW9waWcSUqzc754baeVVh+qAE0
	 f6QqdCneMlYkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ASoC: mediatek: mt8183: Check runtime resume during probe
Date: Wed, 22 Jul 2026 22:58:19 -0400
Message-ID: <20260723025819.2878065-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072040-onward-copious-5c04@gregkh>
References: <2026072040-onward-copious-5c04@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

[ Upstream commit f0334fbfd107682d0c95f3f71e25f6127038e2b9 ]

The MT8183 AFE probe uses pm_runtime_get_sync() before reading hardware
defaults into the regmap cache, but does not check whether runtime resume
failed. If regmap_reinit_cache() then fails, the temporary runtime PM
usage count is also not released.

Use pm_runtime_resume_and_get() so resume failures abort probe without
leaking a usage count, and release the temporary reference before
handling the regmap cache result.

Fixes: a94aec035a12 ("ASoC: mediatek: mt8183: add platform driver")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Link: https://patch.msgid.link/20260527-asoc-mt8183-probe-cleanup-v1-2-4f4f5593c8d1@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
index 86c8a523fe9e37..abbda87c29a248 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -1143,17 +1143,21 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	/* enable clock for regcache get default value from hw */
 	afe_priv->pm_runtime_bypass_reg_ctl = true;
-	pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret) {
+		afe_priv->pm_runtime_bypass_reg_ctl = false;
+		goto err_pm_disable;
+	}
 
 	ret = regmap_reinit_cache(afe->regmap, &mt8183_afe_regmap_config);
+	pm_runtime_put_sync(dev);
+	afe_priv->pm_runtime_bypass_reg_ctl = false;
+
 	if (ret) {
 		dev_err(dev, "regmap_reinit_cache fail, ret %d\n", ret);
 		goto err_pm_disable;
 	}
 
-	pm_runtime_put_sync(&pdev->dev);
-	afe_priv->pm_runtime_bypass_reg_ctl = false;
-
 	regcache_cache_only(afe->regmap, true);
 	regcache_mark_dirty(afe->regmap);
 
-- 
2.53.0

