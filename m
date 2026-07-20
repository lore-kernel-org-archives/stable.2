Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A36A4195A0
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550931; cv=none; b=BOjhsFm9dkihG8id1lDLikDkHWQ7ZivO/BhToSx4HVZbh+jcXZp8YyoSuKG5HNTa+IwStbITccFCaye6nQI/V3B9Vagk20tUc8YwOV9nDePy9Mld4dXgexpQqRLQ2n4vjrlNc/M6w6UZ/53KynXEhbantw1hK5TN/PJijgDs1TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550931; c=relaxed/simple;
	bh=fy5TqwPwMAmi7SPMJY9IoZc+cw4I9ajkbHWiRFIbVnU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SQ37O7p4Io6EtJcG2zXVxd/Jfr4RXBzlh0mC49913VBo4DDitaqDaXlZxCZTfnZ1aoynwhWDoRPLGkoThnHopeK218mlybPLnsKW2fBMU33fSjcB8xPngymhYbwyRamHf1WOVG4XwwVW4fzHJG0FERE1a0GGjvoVRDdxWeIie8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uLeh0YWx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uLeh0YWx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2121F000E9;
	Mon, 20 Jul 2026 12:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784550930;
	bh=bDkgjWY3R7gB7rfa8a3/H+9uc3/tdXIVnANl926tv1Y=;
	h=Subject:To:Cc:From:Date;
	b=uLeh0YWxRgGPPWkQGWQtaKLYUv7/kZTNj9loMiGiFPZQghWyiXZ2SASrQp07ll4ch
	 XSfE2GRtqQP0QsPykNt8HjwLiTCRqvb0KWfqnP6X6xugB4KoVOMuWKUv51stwqCIS3
	 wQQu0E6bCTaNBgfOieWFPqkgk1ybm1nySE8/kaP4=
Subject: FAILED: patch "[PATCH] ASoC: mediatek: mt8183: Check runtime resume during probe" failed to apply to 6.12-stable tree
To: cassiogabrielcontato@gmail.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:32:39 +0200
Message-ID: <2026072039-ladies-ducking-f84d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f0334fbfd107682d0c95f3f71e25f6127038e2b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072039-ladies-ducking-f84d@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f0334fbfd107682d0c95f3f71e25f6127038e2b9 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Wed, 27 May 2026 10:41:49 -0300
Subject: [PATCH] ASoC: mediatek: mt8183: Check runtime resume during probe
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
index 49a69728fd72..2634699534db 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -844,17 +844,21 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	/* enable clock for regcache get default value from hw */
 	afe_priv->pm_runtime_bypass_reg_ctl = true;
-	pm_runtime_get_sync(dev);
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
 
-	pm_runtime_put_sync(dev);
-	afe_priv->pm_runtime_bypass_reg_ctl = false;
-
 	regcache_cache_only(afe->regmap, true);
 	regcache_mark_dirty(afe->regmap);
 

