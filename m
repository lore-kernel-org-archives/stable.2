Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0898847045C
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 11:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806635; cv=none; b=G+vpyWwleaGtkZ/J7kobw1g1NUQnO6NiVsbNv0cUlES4K5o1DvQKBPAZuN1zfkcwU16754WIOTui9saR2iwefbsaQONAucZaka1dN6y9QkgePXhVBYuVGuKyZ/SaTEB0XsKt34SFvB0hu8cdK5o40+LUvmSYBEeevBPPvd7iaGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806635; c=relaxed/simple;
	bh=t/Ws42OUuVOVDI6E67eX7AnajSIPXghoWG6A8Zi5QTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmfhkbzMAVqAzp3eNj2yfCh056b8pB7M9iJMQJeutL5+BMREQwbKGcsJmd5UbuRaPeGzfFklpHnjcB0+fyYkZ/8QlraXYx6l+22HWQccVjuPFxw+izopDajoNGqd+yuryEkAbL5tVaipXU7Jt59RwnCql5ZuZOChS00pJVtd0lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZJeb+ID; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZJeb+ID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF7A1F00AC4;
	Thu, 23 Jul 2026 11:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784806633;
	bh=tJeRJOs3aZPp2UZ41W1fqq2SB5dRO9hACNDb3T+WdkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GZJeb+IDtOiS9MDYXDg/ttoofNHRA3RdGY3rjGk6+OCZE3qSZj0LmfA3MFj82zLa5
	 AWY7CCdP7GCCfyk51pl+gJ9uW13ZtUE5oD9t1zca5VIcpLN09qV50Tf9Fh5rRkcE8M
	 NnOfbtG/Ux03r73j40HAmVaQborCJbE+snpf3w7KfdpzghmhGFTgxE+zkMxYlI7hju
	 LqOx2SifM3r+caFE5+mYJnAOBWq8/zJxb7tnuXkLNhK4cyZaktyZGkpFv5eLTgnv/u
	 o/7Ms6UsUC3HJLMJAuNKUYYexVZ3O7SlmAY246V7rIJFZnkSd4cLAq/Y91GjT/DB0E
	 TQeGTqRKDVDKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/5] ASoC: mediatek: mt8192: Check runtime resume during probe
Date: Thu, 23 Jul 2026 07:37:07 -0400
Message-ID: <20260723113708.3035236-5-sashal@kernel.org>
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
index 345343e8842017..c533b7c7e80970 100644
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

