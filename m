Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7212950EBE0
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949701; cv=none; b=BM71sdZpyLRUr2FArUOT3R5vLH7CJZDkXSTM80pvl9SvDfwjt9tRZaRU0VwoeBASssy95XyxCpfPjMUgAdBgoo0NrTBSfxXLV54j0XeVSZJBHqw9SRha8ZOUeBG5ROnFvKIPEV8olX6Y9ty1UH014CvcZGj1IhTs9zubePcvb6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949701; c=relaxed/simple;
	bh=7oIESQhV8kLJ/t5zVX5hvE8HTe9un/gCen7VPVzVeIc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nJWzdsB2iDCjIOSA3pF6wnhrIHA3Q6LDEbGWXihitFLxzlIasB1XSn+FW8BnDAAqBZJtkj/tBYZIsIBgMP0bNAEnvp9bvn8la8EgVbI6ZIMo7Owe/vU9qdknqY3m9y6XElP/sk2tQ4lumoeMhvXm6JfjbPj2OHKbiNMzEvNjfJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kbgv/xgb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kbgv/xgb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8941F00A3A;
	Wed,  9 Sep 2026 10:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788949700;
	bh=hnKAChUjzQSkP8ksk09K6FknV0wuzFTiJ+OX4Bl7YOM=;
	h=Subject:To:Cc:From:Date;
	b=Kbgv/xgb+bIlhdaeALB2M+/LyxNGxce1PaNQXBRUkvsRac1QlVs+StA97WxSnKPhi
	 geiZxUpMHW7Y5mGEsIiUvPVBlTbuLhOKJKqg39/58nixYkgYrAURvpzI9K+FwIkWoH
	 7ApMnqf1TvJSp+/f3lsrMWz36Z7KxyCKVuTwLPMI=
Subject: FAILED: patch "[PATCH] ASoC: tegra: Sort MBDRC register defaults" failed to apply to 6.6-stable tree
To: jonathanh@nvidia.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:17:32 +0200
Message-ID: <2026090932-settle-expose-47b3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x abb5bed6f48d54d3b82724a430fd462579ecd876
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090932-settle-expose-47b3@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From abb5bed6f48d54d3b82724a430fd462579ecd876 Mon Sep 17 00:00:00 2001
From: Jon Hunter <jonathanh@nvidia.com>
Date: Fri, 21 Aug 2026 16:37:34 +0100
Subject: [PATCH] ASoC: tegra: Sort MBDRC register defaults

Commit 4b05ccb17f92 ("regcache: Sort the local copy of an unsorted
reg_defaults array") exposed an issue with the Tegra MBDRC driver and
now the following warning is observed:

 tegra210-ope 2908000.processing-engine: Driver needs fixing: Unsorted
  reg_defaults, sorting the copy

This warning occurs because register defaults in the structure
tegra210_mbdrc_reg_defaults are not specified in ascending order which
is required by regmap. Fix this by sorting the register defaults
according to their address. Note that in order to do this it is
necessary to replace the macro MBDRC_FILTER_REG_DEFAULTS with a per
register macro MBDRC_FILTER_PARAM_REG_DEFAULTS.

Fixes: 7358a803c778 ("ASoC: tegra: Add Tegra210 based OPE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://patch.msgid.link/20260821153734.158426-5-jonathanh@nvidia.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/tegra/tegra210_mbdrc.c b/sound/soc/tegra/tegra210_mbdrc.c
index f5d4a93dd6f1..1d78b4c1cc88 100644
--- a/sound/soc/tegra/tegra210_mbdrc.c
+++ b/sound/soc/tegra/tegra210_mbdrc.c
@@ -20,33 +20,33 @@
 #define MBDRC_FILTER_REG(reg, id)					    \
 	((reg) + ((id) * TEGRA210_MBDRC_FILTER_PARAM_STRIDE))
 
-#define MBDRC_FILTER_REG_DEFAULTS(id)					    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_IIR_CFG, id), 0x00000005},	    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_IN_ATTACK, id), 0x3e48590c},	    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_IN_RELEASE, id), 0x08414e9f},	    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_FAST_ATTACK, id), 0x7fffffff},    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_IN_THRESHOLD, id), 0x06145082},   \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_OUT_THRESHOLD, id), 0x060d379b},  \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_RATIO_1ST, id), 0x0000a000},	    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_RATIO_2ND, id), 0x00002000},	    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_RATIO_3RD, id), 0x00000b33},	    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_RATIO_4TH, id), 0x00000800},	    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_RATIO_5TH, id), 0x0000019a},	    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_MAKEUP_GAIN, id), 0x00000002},    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_INIT_GAIN, id), 0x00066666},	    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_GAIN_ATTACK, id), 0x00d9ba0e},    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_GAIN_RELEASE, id), 0x3e48590c},   \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_FAST_RELEASE, id), 0x7ffff26a},   \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_CFG_RAM_CTRL, id), 0x4000}
+#define MBDRC_FILTER_PARAM_REG_DEFAULTS(reg, val)			    \
+	{ MBDRC_FILTER_REG(reg, 0), val},				    \
+	{ MBDRC_FILTER_REG(reg, 1), val},				    \
+	{ MBDRC_FILTER_REG(reg, 2), val}
 
 static const struct reg_default tegra210_mbdrc_reg_defaults[] = {
 	{ TEGRA210_MBDRC_CFG, 0x0030de51},
 	{ TEGRA210_MBDRC_CHANNEL_MASK, 0x00000003},
 	{ TEGRA210_MBDRC_FAST_FACTOR, 0x30000800},
 
-	MBDRC_FILTER_REG_DEFAULTS(0),
-	MBDRC_FILTER_REG_DEFAULTS(1),
-	MBDRC_FILTER_REG_DEFAULTS(2),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_IIR_CFG, 0x00000005),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_IN_ATTACK, 0x3e48590c),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_IN_RELEASE, 0x08414e9f),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_FAST_ATTACK, 0x7fffffff),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_IN_THRESHOLD, 0x06145082),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_OUT_THRESHOLD, 0x060d379b),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_RATIO_1ST, 0x0000a000),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_RATIO_2ND, 0x00002000),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_RATIO_3RD, 0x00000b33),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_RATIO_4TH, 0x00000800),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_RATIO_5TH, 0x0000019a),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_MAKEUP_GAIN, 0x00000002),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_INIT_GAIN, 0x00066666),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_GAIN_ATTACK, 0x00d9ba0e),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_GAIN_RELEASE, 0x3e48590c),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_FAST_RELEASE, 0x7ffff26a),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_CFG_RAM_CTRL, 0x4000),
 };
 
 /* Default MBDRC parameters */

