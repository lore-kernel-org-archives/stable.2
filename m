Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A904F33BBC0
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806633; cv=none; b=dFBEyCFx3EqgOwoENZll+Hsg6BFwPC97RybMlebW30Yw7oFie6og9J+Bk0An5APkLLnIRVYfzdsNnJrgRucE+Rof94fFURo/TqIxtFNQ0fBeS9f+lg70ALIxVBBsEQSl1Ohvkyirp2skaurjWtsuSQfQ7hbviZz+pfD/Y0dkkrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806633; c=relaxed/simple;
	bh=MVTXHT+K93Hc+YiQ7lTOPQgQ3wtdsVWr7ihKw6fXl2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVXbs1HiduOl4/+LerGGGOoZL6bQiHPnIrbAF+LqN7F2Z9JVwgp4VIPInw5LITTvMyAgtLgGxUqnd4G3ZiNbxak6r603dRZLLYEXFBNf0AItmTQ/uMmREraFWpryIFgKJv2/dp9wOF+T1EY1qAoMCEyyAbvutNjt1ywKGgLWpX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXYejQ+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXYejQ+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCADA1F000E9;
	Thu, 23 Jul 2026 11:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784806632;
	bh=apBLJWn9MkKY2Ihuf7ukKn+l32Y/2zHOXERpN83Omxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cXYejQ+xBK9/mI7piMe1RLdyJ/lerIor1nEAeavOtOql/BZfK0neGCpk48hXPVC76
	 7F8qwnOrrnbWM1uJjegEhauVAtViIlyMi2MhDS7QOuJ2mZQCD+1giwDw7Td6iiG66K
	 mbZLWBQOaApuyjkjexXpadeYoMC9YNm39u+7v8v1a7RGJOHMjOHAAosElreiTR/So+
	 70in2uyrpuFWykY/SnimW7qrunRSi7zPYE/kWnRwGjafUyCy/ZZ+nRPN+SSMICmF+F
	 fP84CtwMKqUUFBL/ylLyUh1OUWC0ZeZcMJ+HN3aFoyA3a8Fy1KhD1nb0UCT0CMrzJa
	 n9gbohayfG8Ug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/5] ASoC: mediatek: Use common mtk_afe_pcm_platform with common probe cb
Date: Thu, 23 Jul 2026 07:37:05 -0400
Message-ID: <20260723113708.3035236-3-sashal@kernel.org>
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
index 4f4107a415ba5a..b627b822e4ce10 100644
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

