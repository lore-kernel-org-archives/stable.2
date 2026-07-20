Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4914071D2
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550923; cv=none; b=YPM0AQI0RXDYWVTh0HPNBGXgprDKtQsDVafBiC67AK+z2t0A+oOl2CElTo5GoVpT1rGQ4Ref+Dc2vjasgRIrhcoPFmQxRZ7LVTRRCUE+zUR0JTXF/H+iqxkieYINqRG7+L4RWIQXepp1uHwkq2Tey35ExYg3N6ZZnI95HxxvdIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550923; c=relaxed/simple;
	bh=ErxKQeaMH/fBTewpplDzJ0YkvNffUgHYJg+h6SXcnHw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=q0rrY62gvDIAfm1R9ybtHtRmH5KOGjEWUPU5N3mYemlXfFPJrdE56iWinpKMKG/iTTlHBYqQO6UBTSbUp+zXRE6wm3W+A+RC2wGYbam9NCqPVaVj0ROYl6EbwMcKVHksmCsO7p7yVr6mZfN+zJ5p2vZLaR42ME/3W6ok3pNxeMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bnt8JxLZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bnt8JxLZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD1C1F000E9;
	Mon, 20 Jul 2026 12:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784550922;
	bh=5IxctR19URYJwWh6rox/vG0xyLrsakMZr6WzeoueZDA=;
	h=Subject:To:Cc:From:Date;
	b=bnt8JxLZ4otEbiSd8S/y6UsZMWpiUqZjyDmhRPh27pcJmBQHrDP5ipVTwXajsQbRI
	 FlMB18ZjG5xB7r5rKRTwFTyrbZPEMdK8S24s7ul0QVenOUemCD4nadldxf6ZhWuRFJ
	 1dJnw18nt7w2T8skD/FQUwrReH7XWet1zk6o6p6E=
Subject: FAILED: patch "[PATCH] ASoC: mediatek: mt8192: Check runtime resume during probe" failed to apply to 5.15-stable tree
To: cassiogabrielcontato@gmail.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:32:22 +0200
Message-ID: <2026072022-fading-available-28ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e24d5dde56a50946020b134fa8448869093db76a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072022-fading-available-28ca@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e24d5dde56a50946020b134fa8448869093db76a Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Wed, 27 May 2026 10:55:47 -0300
Subject: [PATCH] ASoC: mediatek: mt8192: Check runtime resume during probe
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
index 9f5057eeeff9..db0ae44a86af 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
@@ -2227,15 +2227,19 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 
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
 

