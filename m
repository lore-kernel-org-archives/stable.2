Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC6421FF30
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 01:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769439; cv=none; b=gNf1q9j1JhbrgdbJd4KMpVdXKG5+TnopDJvZTWwCM4Hy7bvSIogtFervdgcOm5FliTC3CLvxbsAKY95R1O+lmjL9Azte5kq9rutmMIBr+nyCOjgzSQnjqw/lWKo4ucOX8dKUlkc8nxyggNVLJg2wvMI/AkrZ6lMpFAQIJ89r5E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769439; c=relaxed/simple;
	bh=qb6q8xyY2/9OoYgKIZsE7gXcH+G4BTkjcvIlz06XsTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+4Pzs4LelZSo0YtNn39kMA4oEJPT088NzUXj+HXZkhEF56qAjHS1yK50WCkdhAuo/W+lY3qWfiH9gXBTFLN2GjsXVJD0FpZOJkLhz2ZUI5G1Nf1bLCHq7rYTxdbv2Nll7rup9opdoJmYPcprwsp+aVDR2jFD4hQXnc1g/aLjao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcPnrUG/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcPnrUG/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134D91F00A3E;
	Thu, 23 Jul 2026 01:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784769438;
	bh=qOujskWLY/dVyHsBmKa3kFKkOyRO5Mqjzqv+KM788Vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bcPnrUG/6eAjGAIb8nSRmTsmZrWRrOJ+ybFm4R5vH7MaLiNmEvzzBP1R335uSFJnO
	 Of26bGPWnasuEtmEgzEROqYs5fEWCOybt5W2QdwDuQnFJMVvK6MG11cLHxrQxa3kZ/
	 qnhA/vZZ4+Q+qGGvguJ//8ZhqIE8XdR/5m0EFI6hUziGwcLFWDpwH1ZkkSBFeqnVOu
	 GLfboPyNv/rMBcetDo5UcDQ22hcQFefSbvZFAtrPHQO9BDczBKWJLNzfqdI9/5+d0E
	 DcPfIQUkXyOYkefqQwrBnLJQ/ari6e2Sn/l6cRjUSjkXPdPLwU37e+t+l5y26lmF4e
	 YUIoZP4jCfjag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] ASoC: mediatek: mt8192: Check runtime resume during probe
Date: Wed, 22 Jul 2026 21:17:15 -0400
Message-ID: <20260723011715.2780615-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723011715.2780615-1-sashal@kernel.org>
References: <2026072021-slicer-fleshed-2403@gregkh>
 <20260723011715.2780615-1-sashal@kernel.org>
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
index 6638307935ee9c..52939d481fa136 100644
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

