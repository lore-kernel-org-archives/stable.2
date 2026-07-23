Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC82263F4A
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 03:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784775796; cv=none; b=g5eQLqPWmdKo7GUUatQynoULfTxwJwTXVNxtn9v2U2oLrEt6Av0qWaFS12i3FATSqir6ccoeA5PrrNKh+1/XDsiKN37I40uttyTb+I5fVruE3jUJTD6k8DMt72+jXezjwjzX+lyNBZ5yXU1OODORjqyKEJlFr8v6KOtrzy1wKOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784775796; c=relaxed/simple;
	bh=do1f0h0IMMnXjfAKh4KC35nlRD2CXgT/D28b+nTlJ6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWVuY0ht2R1g91cls4i0nUjytrzRBXtUHa/nKmhFfGNYXAYlHgWixGdzXP2DyJHPEFEY8cbhriaf6Pi5l4O2wANkV5t2ASWU1rSz5xb2nGxq+UiTrNnpEps98zBvrh5aNBWIk4iuLnY28i15DQzUdzOZZC70YtkpbpJ2PyeuDhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWh4vb4g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWh4vb4g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F761F000E9;
	Thu, 23 Jul 2026 03:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784775795;
	bh=aNUVtWYoKjl7QqXgBek8O0phHBuJaUWrTJRDn41696k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BWh4vb4gT9SfY1ez2YDAVUjDab2TyiubUEb8jKSS7HjSgJtno8rdTFv+HX7ALYlno
	 mhPHX/dYqFEN31ZGQcyFyDVP4ZbAALFJk9+tvyxLJH6PKp2Xk4z/g1LL3XIHgItgra
	 87vm+WYh46nly09w+o48oHE7Cc1ZElZSGKSMpkX2pl8hAjK3lWxCwauFVKrt92Mofo
	 DATXChz+tdPcLkdReMFTqwGSTuZDYYpWFIqUIL9jaVq19XzB3ov3vKxfJp0S+gNBVx
	 wD+fkdQupjJICNkl4YZe2pW49YV/FLAIVIuozClxasK6UQzEdX+Atp7ITXfWVqDU3b
	 9pv5Dke0gg0UQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ASoC: mediatek: mt8183: Check runtime resume during probe
Date: Wed, 22 Jul 2026 23:03:12 -0400
Message-ID: <20260723030312.2905679-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072040-jujitsu-heroics-da23@gregkh>
References: <2026072040-jujitsu-heroics-da23@gregkh>
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
index 14e77df06b0111..03936c85541c19 100644
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

