Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E8C471254
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949724; cv=none; b=j8ECUbMONGWqADjNMxTUaELnGgHv9kFUZ6Ur81PjjZFGpXDcdHM36rGeEigtfkFeVV8o9OsMujHWfI/VBomO4gv/id70W/v/aGNfiTG1WtoQODVFfzWpFaCyROScLCb6406VE6qEE7XvzGCV5VFkm4iXTE4ubDxfs+azv+L8v8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949724; c=relaxed/simple;
	bh=1zV/2tYo2i17JVo8f3kZwq91ox8D0oHLPih8vg4fNjs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NNrlNC/Sp1Gu3sR/52RmxPhZT3gEphINKU5tq/DZ5+UYPBIfvzId4yA2evHrYS3hhas0P/fM0eaiQJPKp/iEsPw0E0DI3Z/uy/bDqlK/D1gCifZVlz62BX/6Xpqw/bma+blzX1rZAH6gAlayaj4QRWukezXRXViB2knvA6E9seo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DD5mil3C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DD5mil3C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B90C1F00A3D;
	Wed,  9 Sep 2026 10:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788949723;
	bh=VtbdzC88/ftpsd716lASpn+szqrFNAN6JYZvPPSQljc=;
	h=Subject:To:Cc:From:Date;
	b=DD5mil3CdbueuZvGxj/F2AFsA8h0T4Ie7izjC120MjhOPWiJzDbDguetyHYm1+DXA
	 SrtwVCWrzzHTzXWrWRYnA7hEoXF5PqpzamyZ3ajiOEytWVHYVOtNfeD5jIMtEAX/XK
	 whV6GNP75kcIUxTNPyypqsLSGfgrtpSVqgD2wb8g=
Subject: FAILED: patch "[PATCH] ASoC: tegra: Fix the MIXER enable default value" failed to apply to 6.6-stable tree
To: jonathanh@nvidia.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:18:06 +0200
Message-ID: <2026090906-freebee-snooze-4208@gregkh>
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
git cherry-pick -x 5442b8093a2f94ecd4696b3875194be09e2676c5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090906-freebee-snooze-4208@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5442b8093a2f94ecd4696b3875194be09e2676c5 Mon Sep 17 00:00:00 2001
From: Jon Hunter <jonathanh@nvidia.com>
Date: Fri, 21 Aug 2026 16:37:32 +0100
Subject: [PATCH] ASoC: tegra: Fix the MIXER enable default value

Commit 4b05ccb17f92 ("regcache: Sort the local copy of an unsorted
reg_defaults array") exposed an issue in the Tegra MIXER driver where
the register default for the TEGRA210_MIXER_ENABLE is specified as 1,
but the hardware default is actually 0. After this commit was added the
MIXER driver is no longer working and so fix this by correcting the
default value for this register and explicitly configuring the
MIXER_ENABLE register when runtime resuming the MIXER device.

Fixes: 05bb3d5ec64a ("ASoC: tegra: Add Tegra210 based Mixer driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://patch.msgid.link/20260821153734.158426-3-jonathanh@nvidia.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/tegra/tegra210_mixer.c b/sound/soc/tegra/tegra210_mixer.c
index 8eb4e54b954b..96259a6cbc59 100644
--- a/sound/soc/tegra/tegra210_mixer.c
+++ b/sound/soc/tegra/tegra210_mixer.c
@@ -57,7 +57,7 @@ static const struct reg_default tegra210_mixer_reg_defaults[] = {
 	MIXER_TX_REG_DEFAULTS(3),
 	MIXER_TX_REG_DEFAULTS(4),
 
-	{ TEGRA210_MIXER_ENABLE, 0x1 },
+	{ TEGRA210_MIXER_ENABLE, 0x0 },
 	{ TEGRA210_MIXER_CG, 0x00000001},
 	{ TEGRA210_MIXER_GAIN_CFG_RAM_CTRL, 0x00004000},
 	{ TEGRA210_MIXER_PEAKM_RAM_CTRL, 0x00004000},
@@ -86,11 +86,15 @@ static int tegra210_mixer_runtime_suspend(struct device *dev)
 static int tegra210_mixer_runtime_resume(struct device *dev)
 {
 	struct tegra210_mixer *mixer = dev_get_drvdata(dev);
+	int err;
 
 	regcache_cache_only(mixer->regmap, false);
-	regcache_sync(mixer->regmap);
+	err = regcache_sync(mixer->regmap);
+	if (err)
+		return err;
 
-	return 0;
+	return regmap_write(mixer->regmap, TEGRA210_MIXER_ENABLE,
+			    TEGRA210_MIXER_EN);
 }
 
 static int tegra210_mixer_write_ram(struct tegra210_mixer *mixer,

