Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8E43537F7
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 02:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784773755; cv=none; b=IJ2347kRx04PpkIm96FIGUeFPTBFgUcXAq9rA/lfB2XPH4qp+KMBymyoL0JllMZ0Wh12/toXAlvZF7OswhhJDrXBMVHbP+Gre+WNchowftF8BQuL4kNMDN30rhCj3o/Pl+hmhNXj+zQlTBTB2P7B5kwixGk4CJ6Ans21VTyh9vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784773755; c=relaxed/simple;
	bh=o/7LX+E+R8GwIqs8MPaAZMihTQvAN2S1dSGDckWsS9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTXH1tugdfeYf1ntbSvZYDNbYi8TIr1dtkYAOv8MoMvXRnolKvK5NbQkl4SWTNhSmdYnWRo7are7A0GQ53SkKzcqOkXbkUry24HyXpckGgsC90MurCwk2ojUqYYfTO0kr/w1Uy0NmdGSBa6Fgr39oszz6lUhzspB/O+Z93enNF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGiyjGKD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGiyjGKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E591F00A3E;
	Thu, 23 Jul 2026 02:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784773754;
	bh=NIcC5VztLdQpxI6nIOl7y2qwGpZglbMjFz4/OodLC7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lGiyjGKDpoeNXdSbrRL2rVdf/1yXybQMOFzR8Y37dQxCXSKl3SLKHpsReNxyfivAm
	 8Ldb+GYuff5cfsKSCGwOQcisv95DW/o92yj4zXt1pxoZrfcNblB/iv+aC5iCb+9Dym
	 WVzYM3pf9DlkPsPrez3vfPM/PENjofpFgjv9h+9SZ3FAa755+9S+oEzFuWsr4VleMz
	 ruJAs2rh6xQ753DyXXRTcm5ZzlDj+kuOlDGzfzr2hzkKe9y9AjSC9G9ofCKElmaN3j
	 PMeUqy+nH+NYI6Eg/jRM9ZRGVUXRj+l5788eUrhl2K/Nx/SCHrkwX3QY8+1UCBG/08
	 J+CfsX0vynraw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] ASoC: mediatek: mt8183: Check runtime resume during probe
Date: Wed, 22 Jul 2026 22:29:09 -0400
Message-ID: <20260723022909.2845199-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723022909.2845199-1-sashal@kernel.org>
References: <2026072039-ladies-ducking-f84d@gregkh>
 <20260723022909.2845199-1-sashal@kernel.org>
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
index 7f644c8249630e..9d68d56d47cc77 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -1015,17 +1015,21 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	/* enable clock for regcache get default value from hw */
 	afe_priv->pm_runtime_bypass_reg_ctl = true;
-	pm_runtime_get_sync(dev);
-
-	ret = regmap_reinit_cache(afe->regmap, &mt8183_afe_regmap_config);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret) {
-		dev_err(dev, "regmap_reinit_cache fail, ret %d\n", ret);
+		afe_priv->pm_runtime_bypass_reg_ctl = false;
 		goto err_pm_disable;
 	}
 
+	ret = regmap_reinit_cache(afe->regmap, &mt8183_afe_regmap_config);
 	pm_runtime_put_sync(dev);
 	afe_priv->pm_runtime_bypass_reg_ctl = false;
 
+	if (ret) {
+		dev_err(dev, "regmap_reinit_cache fail, ret %d\n", ret);
+		goto err_pm_disable;
+	}
+
 	regcache_cache_only(afe->regmap, true);
 	regcache_mark_dirty(afe->regmap);
 
-- 
2.53.0

