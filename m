Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDA620E702
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 02:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784773762; cv=none; b=tU41BZXfHW9RWCqkKhDKHTSfVtUOsmFwsHwZpzZhgmQC1aawGAc5RTXMtntD638PR0u/EvfgtD479S1M66bpUjkXiuWjjM+R8dPPJajoPQHDiNW0LIK3Xh0PyYoeLKGtlweeYcoE2ZIgyLAkMMexGOLaxvM8XmPKD18xncTiu7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784773762; c=relaxed/simple;
	bh=UFwD9fPJbezV05git/fcY+29vx+vt1HYugLaS8Rbmuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZyPWbXpzBaKM8mLUAV6ENZnZER8iuaDf9eURBIYJC8dCJDDkcXCryB+bxu/EuKo0mqDkH7RnINGi9SnJWmRE4N1RjHj7cSUSZwHXvNUPTmgf0IVQG4ulKsGUqVrK9F20rUW+iYi/sQSQA+F1HU9/y7beZTp79Xtbw+QJS+ZY1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Urh1QV1R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Urh1QV1R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9C31F00A3A;
	Thu, 23 Jul 2026 02:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784773761;
	bh=OXuzcAS12+CSi0QmLmWe4SOqRX5TvLIT84yQzxgBEcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Urh1QV1RleYJMmwjunc81YacR+JUC5FdmGlMjb/nmtzZ+BDPZl2wsYsDh4cJFkuC5
	 L+dy2cY89gT8SDMWs2b0bMVWumU5wztAIn+fJ6qn1OeyE8W3BoMdnaRbxZ2cZCr6Yq
	 AVh9xnZV57XMi95OBCZW+DmHJxHuY2sgFlJO57XZ2z5NcogPGN2eI9o9qb+8fLM6x7
	 hNRdsCFjIxYvRb88pOiCvLjOcVB1zDZXr+UAvhW8K79qvLi2kXuZn2gASg37hsm0gx
	 fwpIz8uZsBfb7U5QGsTo9wdxPTWkElO3afx/gVPOTpSBfYuAZeKUNs52hNr9RKYVBB
	 qJOLuTp1YaRoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 6/6] ASoC: mediatek: mt8192: Check runtime resume during probe
Date: Wed, 22 Jul 2026 22:29:15 -0400
Message-ID: <20260723022915.2845450-6-sashal@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

[ Upstream commit e24d5dde56a50946020b134fa8448869093db76a ]

The MT8192 AFE probe enables runtime PM temporarily while reinitializing
the regmap cache from hardware, but it uses pm_runtime_get_sync()
without checking the return value. If runtime resume fails, probe keeps
going without the device necessarily being accessible, and
pm_runtime_get_sync() may leave the PM usage count incremented.

The regmap_reinit_cache() failure path also returns before dropping the
temporary PM reference and before clearing pm_runtime_bypass_reg_ctl.

Use pm_runtime_resume_and_get() so resume failures do not leak a usage
count, and clear the temporary bypass flag after dropping the probe PM
reference on all regmap_reinit_cache() outcomes.

Fixes: 125ab5d588b0 ("ASoC: mediatek: mt8192: add platform driver")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Link: https://patch.msgid.link/20260527-asoc-mt8192-probe-cleanup-v1-2-1bb834d05b72@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
index 29e3a2d121521d..d40f3ef690a67c 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
@@ -2218,15 +2218,19 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	/* enable clock for regcache get default value from hw */
 	afe_priv->pm_runtime_bypass_reg_ctl = true;
-	pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret) {
+		afe_priv->pm_runtime_bypass_reg_ctl = false;
+		return dev_err_probe(dev, ret, "failed to resume device\n");
+	}
 
 	ret = regmap_reinit_cache(afe->regmap, &mt8192_afe_regmap_config);
-	if (ret)
-		return dev_err_probe(dev, ret, "regmap_reinit_cache fail\n");
-
 	pm_runtime_put_sync(dev);
 	afe_priv->pm_runtime_bypass_reg_ctl = false;
 
+	if (ret)
+		return dev_err_probe(dev, ret, "regmap_reinit_cache fail\n");
+
 	regcache_cache_only(afe->regmap, true);
 	regcache_mark_dirty(afe->regmap);
 
-- 
2.53.0

