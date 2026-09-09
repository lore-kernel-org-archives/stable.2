Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE072517BC2
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949736; cv=none; b=a35EadPGH52papErY85MpZ6AD38UtxDLqqI7xIER8+HZWb5mGVqN+U53MvDBBzDMHs/OmmD5q66LZm/Zd5UCzzT4JcD7P8gBlCTbI8uyw6V+jS2EMnfnbKs0bVUrdMmRufskZEsMkzCBVFDTs9Md8Lj1UHu1vEmkDm6R5WeCjFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949736; c=relaxed/simple;
	bh=aM/dU/iQ5m63/kUOy+ofy/A4vO6rdjOx2tog9JmfqvM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gqOWvquyhzXYhvvXbvxfqghXq85ZRzxo+0CvE+6HhjCN+Je/mKH99HFv86S4vM5Avb7OFTNmPAYz5raIPWoGxCO+i0IWthWpHBCTHP9FHdbhURYR6bMkC9Tfmg9Hcl5fvsDKJnDnEz9+KJ/mggB8X81cJ1j1OSJEuPoK2Wxjh/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zwC+IOwv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zwC+IOwv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F42001F00A3A;
	Wed,  9 Sep 2026 10:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788949734;
	bh=mxoQK3I/WlUZdusIdn+1lAiaC0abX90vNpho95WCTBY=;
	h=Subject:To:Cc:From:Date;
	b=zwC+IOwvLxWX12otuscBA4fz5oqhBNdbIdyvfiA7Ag+cSwg5CprZB2428stneE6zT
	 IUiFvXm2HR1SseCYq9cMEHd72QOkllX3NdwOPwCGOIDa3aMq/006nCCjaqPMzDBJVh
	 SJeBLjnyd2lSQIsQdZOci3iZca6eqQ7p0wgV/vic=
Subject: FAILED: patch "[PATCH] ASoC: tegra: Fix the MIXER enable default value" failed to apply to 6.1-stable tree
To: jonathanh@nvidia.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:18:07 +0200
Message-ID: <2026090906-motive-vocalize-6051@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5442b8093a2f94ecd4696b3875194be09e2676c5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090906-motive-vocalize-6051@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

