Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AD2517BCC
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949738; cv=none; b=Ro0LPGeXt8CMMbKPt3TWXRwzdK5SFrkTRppWTpACQUqM4j2cD1KqB+Gb37Iz31SZF/CIkr5mXU0VUnATQEqk25h41BHL0OlB2tHUekU7VVsgiWTrHMGk6jWJXX/B/rNw6bOKL+aIn/UYfiuVpvhYEfK2YeL4NEoaZu4CaDY3Bp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949738; c=relaxed/simple;
	bh=FLszQW2XUwNKiv4NyYl5RZVP8/LXX7Z2ZmSKHhJBFjg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IquTiup2xqINAEyFNI+gmIdIi5I2UvuskyvF1nrmjt0k4Rg6CyS1yjEbgJ2InCjWYAZKFxFPxG4mcV4r7gmAHSzGr3j/G8KW5MC4vPRl2S0rDI/DkCVSxGirmt1k+Q3eSiVb+2MldsxjV2+2U/JXsOJfLKNn/HARZ3+UtDY+Pgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B0KSk9Fz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B0KSk9Fz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DCD1F00A3A;
	Wed,  9 Sep 2026 10:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788949737;
	bh=XlPezjyb4cd4+5wtTC9Me3Wl+wecmO3j35UxHQQfql8=;
	h=Subject:To:Cc:From:Date;
	b=B0KSk9FzSOWQ1SsX6dyOCMH7nmSEZJQAUdegS3WFPDRYL34xXMt/Or8M2QrDKifvF
	 98Wp/m7EFsTRZ/g5BkXJ5MyEOsbIZSXlPPCsCeX1gZdv7P1KWULKey8wN3lmEB4+ev
	 s5+Bur6YxPBVTcIkXPRBAc2EPpLBiHUzuGbP9m4g=
Subject: FAILED: patch "[PATCH] ASoC: tegra: Fix the I2S enable default value" failed to apply to 6.18-stable tree
To: jonathanh@nvidia.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:18:23 +0200
Message-ID: <2026090923-handcraft-dean-921f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 53dd1c1de851280c71385f49a24715e5615c926c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090923-handcraft-dean-921f@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 53dd1c1de851280c71385f49a24715e5615c926c Mon Sep 17 00:00:00 2001
From: Jon Hunter <jonathanh@nvidia.com>
Date: Fri, 21 Aug 2026 16:37:31 +0100
Subject: [PATCH] ASoC: tegra: Fix the I2S enable default value

Commit 4b05ccb17f92 ("regcache: Sort the local copy of an unsorted
reg_defaults array") exposed an issue in the Tegra I2S driver where the
register default for the TEGRA210_I2S_ENABLE is specified as 1, but the
hardware default is actually 0. After this commit was added the I2S
driver is no longer working and so fix this by correcting the default
value for this register and explicitly configuring the I2S_ENABLE
register when runtime resuming the I2S device.

The I2S_ENABLE register offset is different on Tegra264 devices than
other Tegra devices and so add a 'enable_reg' variable to the SoC data
structure to specify the offset for different SoC devices.

Fixes: c0bfa98349d1 ("ASoC: tegra: Add Tegra210 based I2S driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://patch.msgid.link/20260821153734.158426-2-jonathanh@nvidia.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/tegra/tegra210_i2s.c b/sound/soc/tegra/tegra210_i2s.c
index 84506576437d..79a2f898ea28 100644
--- a/sound/soc/tegra/tegra210_i2s.c
+++ b/sound/soc/tegra/tegra210_i2s.c
@@ -23,7 +23,7 @@ static const struct reg_default tegra210_i2s_reg_defaults[] = {
 	{ TEGRA210_I2S_RX_CIF_CTRL, 0x00007700 },
 	{ TEGRA210_I2S_TX_INT_MASK, 0x00000003 },
 	{ TEGRA210_I2S_TX_CIF_CTRL, 0x00007700 },
-	{ TEGRA210_I2S_ENABLE, 0x1 },
+	{ TEGRA210_I2S_ENABLE, 0x0 },
 	{ TEGRA210_I2S_CG, 0x1 },
 	{ TEGRA210_I2S_TIMING, 0x0000001f },
 	/*
@@ -42,7 +42,7 @@ static const struct reg_default tegra264_i2s_reg_defaults[] = {
 	{ TEGRA264_I2S_TX_INT_MASK, 0x00000003 },
 	{ TEGRA264_I2S_TX_CIF_CTRL, 0x00003f00 },
 	{ TEGRA264_I2S_TX_FIFO_RD_ACCESS_MODE, 0x1 },
-	{ TEGRA264_I2S_ENABLE, 0x1 },
+	{ TEGRA264_I2S_ENABLE, 0x0 },
 	{ TEGRA264_I2S_CG, 0x1 },
 	{ TEGRA264_I2S_TIMING, 0x0000001f },
 };
@@ -201,9 +201,21 @@ static int tegra210_i2s_runtime_resume(struct device *dev)
 	}
 
 	regcache_cache_only(i2s->regmap, false);
-	regcache_sync(i2s->regmap);
+	err = regcache_sync(i2s->regmap);
+	if (err)
+		goto err;
+
+	err = regmap_write(i2s->regmap, i2s->soc_data->enable_reg, I2S_EN);
+	if (err)
+		goto err;
 
 	return 0;
+
+err:
+	regcache_cache_only(i2s->regmap, true);
+	clk_disable_unprepare(i2s->clk_i2s);
+
+	return err;
 }
 
 static void tegra210_i2s_set_data_offset(struct tegra210_i2s *i2s,
@@ -1133,6 +1145,7 @@ static const struct tegra_i2s_soc_data soc_data_tegra210 = {
 	.regmap_conf		= &tegra210_regmap_conf,
 	.i2s_cmpnt		= &tegra210_i2s_cmpnt,
 	.max_ch			= TEGRA210_I2S_MAX_CHANNEL,
+	.enable_reg		= TEGRA210_I2S_ENABLE,
 	.tx_offset		= TEGRA210_I2S_TX_OFFSET,
 	.i2s_ctrl_offset	= TEGRA210_I2S_CTRL_OFFSET,
 	.fsync_width_mask	= I2S_CTRL_FSYNC_WIDTH_MASK,
@@ -1144,6 +1157,7 @@ static const struct tegra_i2s_soc_data soc_data_tegra264 = {
 	.regmap_conf		= &tegra264_regmap_conf,
 	.i2s_cmpnt		= &tegra264_i2s_cmpnt,
 	.max_ch			= TEGRA264_I2S_MAX_CHANNEL,
+	.enable_reg		= TEGRA264_I2S_ENABLE,
 	.tx_offset		= TEGRA264_I2S_TX_OFFSET,
 	.i2s_ctrl_offset	= TEGRA264_I2S_CTRL_OFFSET,
 	.fsync_width_mask	= TEGRA264_I2S_CTRL_FSYNC_WIDTH_MASK,
diff --git a/sound/soc/tegra/tegra210_i2s.h b/sound/soc/tegra/tegra210_i2s.h
index 42be2137342c..82292f96ab36 100644
--- a/sound/soc/tegra/tegra210_i2s.h
+++ b/sound/soc/tegra/tegra210_i2s.h
@@ -150,6 +150,7 @@ struct tegra_i2s_soc_data {
 	const struct regmap_config *regmap_conf;
 	const struct snd_soc_component_driver *i2s_cmpnt;
 	unsigned int max_ch;
+	unsigned int enable_reg;
 	unsigned int tx_offset;
 	unsigned int i2s_ctrl_offset;
 	unsigned int fsync_width_mask;

