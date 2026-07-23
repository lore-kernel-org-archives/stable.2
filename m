Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B263C1F
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784775186; cv=none; b=Kgi/W41+PxdId/dRpCYETEwRkC6y2z2ccm55tbJZf+Og4SduALJ/6Uw6a+VUjOmlwvqaPgscljvh1D9xJPm4VGxqpzdgbjyg7PVajpe9wJUVxwzWvi1P2H0I4Qj9QX+qYUX8K0lW0NJibUPsu0EDWqoOpXcKDYr7volyWbn+XZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784775186; c=relaxed/simple;
	bh=Al4JrWy5LJZoTcV08JuH5h8XiNK0za2tHvH3h8OoR70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHn1Lkk9fTVQzHkCTsSUA4CnPJWNYVJ93XBnT2Tafw3QxM8JmRFTN/l7NvdXsfUxTsV5ZhjqlaYJmPWIiqsNJ0JsFXnGYaNQMSGIRQQl+fbtfJt74PGz2P3dxxSfP5dSINQcjsND/OVBWH8b8SrvepZjjyC6WRM7zajEwmf1xxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiyJn59q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiyJn59q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F39B1F000E9;
	Thu, 23 Jul 2026 02:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784775184;
	bh=7C3UCcFrEG4UbkMhRUZgPLXMhktQYF+ObDLJDOM7IqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AiyJn59qanordMRpquDxhWWIsaq0XCzX4tYHTiVQWr2Ety/BrPB0Bhw2QBWzre6uf
	 WyG0eCMVlEWzTO3ljfzyOy3K+eaE+JMov/+MnkoeVKVOwZol6CwEmlHNpwthzwIu/S
	 7Fbo2NYSHYrY5E4VOfq0r9qyqrcKt1R2qxkUXe9d2MaL3AtSrln9D80h6K+9EBjYP/
	 CFjZdXpjidQBqIeGim/ok44czQ3CiiTDFzQaQOn0A7x/VlYQkKduiLiILdeWIluA35
	 eNSsBBYy2DMWDJzdcvfD5/ueRRJ/XpCpfw1XV30USRNL7luTTSNkyIcYjUtdh+qaw/
	 FFBflwpMYxMCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ASoC: mediatek: mt8183: Check runtime resume during probe
Date: Wed, 22 Jul 2026 22:53:02 -0400
Message-ID: <20260723025302.2872512-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072039-snuff-nuptials-7e1d@gregkh>
References: <2026072039-snuff-nuptials-7e1d@gregkh>
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
index cbee5a8764c37f..0aab664cc28139 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -1150,17 +1150,21 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 
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

