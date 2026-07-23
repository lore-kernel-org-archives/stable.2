Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C8E472527
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784807113; cv=none; b=YqCtFoBpmdCrpib4M7cLFcBXMc93Bp7UGy56W4nH2aTCl4kOq9rmt2jy6rJakOA0P+mG7p9EPNugYwR/Xd8BvSRc4BraQ2jQvY5T7AQr0B2d9hmXkdfIr9EuHXxg7lIfbL7K97JqzMhPz4MNPJ5A7WKeRZbn/gTafoyje+/rb1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784807113; c=relaxed/simple;
	bh=g6jryLvUh3M2f1Qmk3SB/FxQwPuSj1FcQvIjRKVslWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4FDHsuL990UbgbYW07fmsejy7RmjWlMxXxA/5p7Yv+wHXqOOF1QNMLnS961Uvl+cE3/D8QiJA9ynItWYb+/JMLm4UEgWV22Pc/M/ixnL9ITffTYNTTPhtAd5Q+39PQKsarX6U03zYOx5wYcI27gUJrET+RFYaFTN3ebRVR02Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aG2EMceF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aG2EMceF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525C71F00A3D;
	Thu, 23 Jul 2026 11:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784807111;
	bh=T0eOmDnZ5VnwdUJMWn47jTSdydRq8nIXzA81Yhiznfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aG2EMceFpGL/U6MIDEfBdKc5tr3eKVn2+sU1aIh2ATgAt0hXNZiS7cYcOSOrdAnL1
	 WEH7ZP4Tb5gA9vOGRoeCSjTD50/yOf60EWxoWSzBvhZ82UKEjFzSRRoc+yVzgKSnY6
	 Gl4mlanCzh5sa1n6qW+8oEJZ0jSDsC6hCt3DHJ9s29GvgMHDu1hAgmuRW8KzNF0gv+
	 QMTX2E4nWPZrRoJ9QUmBC0T/f1GFsTFpFBQsIkYB2NhhKZw8z/i/qx65/rIQoCsvIy
	 Cfty/2D8NFsRVXfSacF+5bV1lxa+E7bAp6SLC/M5CMZokEvVHM80jqlq4KeFKSi4/+
	 kukYufnqhO39g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/5] ASoC: mediatek: mt8192: Check runtime resume during probe
Date: Thu, 23 Jul 2026 07:45:06 -0400
Message-ID: <20260723114506.3038609-5-sashal@kernel.org>
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
index 0acf4fc8367d61..765889f3fae0dc 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
@@ -2231,15 +2231,19 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 
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

