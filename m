Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DC422D7A9
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789090516; cv=none; b=tljfkV2C6zp83Ie8b9Cnse/14T/UrReaDjeZihytFbbyncjXISFCNbqC71/GFYDlpL85ynBp+K9cKeuhuvuu7khJMsVm/2uuBlb8zZ6ZS/KhF5duvzBK55xJ+4fkat6an5XbsJcSL1Zc6ioOQv0fb3tsuh58xjCZrKFHw82E4fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789090516; c=relaxed/simple;
	bh=RAQAMhuT5INDuwlAuBu4zL3YyCNx1tw+hoj63iXOAfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2qPY6WMHW/4brrkFlkRXhfXcAh2O48RHvbY19q3B+93iJdPhsZa/c75YVtsS7+HB3Y1YjkGCv+BJCaryWmfJil79INE7SzukTGeTO4SdJGmA0c0GSCTI+YgBNv6san8xIQ76hbIYv5j1hs01aILaciiJQntM9ksIkvsy/bviQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWKXfEP7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWKXfEP7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196A81F00898;
	Fri, 11 Sep 2026 01:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789090515;
	bh=4cnD4v1m7zxx5okDFPbTBbP+tHS3QkqsrBcxXQR4q/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KWKXfEP7kLTm++KjjQd+9FoowTyAuBpU5VYRq70Uf+FccEP/QEGfHPhpzQB/ryo96
	 x7A0mxcd2GeIx8bTiqCRjLYGQ1Yh4PtJQG5qTTU/NrIs5v/xD4V5Dbw5DFxaFiUtui
	 bWtaGS1ItZUJdAPS5+m6Qmdakvy2O2DIUK4zcDHOEhMAJpnfiTQCUuPWW77iT1NFV8
	 2u0oZJHmmTlBSuYh0M5mzXVQTj2Z66mIbw7P2PERSVCnJ/lUUyRIZBsh+iGuY7a4AL
	 /sODI7SMkSY1XKznl3CSE6cYGekoCvw+HFYjVGBEmDCZ1QzUKGH2xwI6v2wbV39Hav
	 1zuqtiNPyD+nQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jon Hunter <jonathanh@nvidia.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] ASoC: tegra: Fix the MIXER enable default value
Date: Thu, 10 Sep 2026 21:35:12 -0400
Message-ID: <20260911013512.4124796-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911013512.4124796-1-sashal@kernel.org>
References: <2026090905-demeaning-relieve-6022@gregkh>
 <20260911013512.4124796-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jon Hunter <jonathanh@nvidia.com>

[ Upstream commit 5442b8093a2f94ecd4696b3875194be09e2676c5 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/tegra/tegra210_mixer.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/tegra/tegra210_mixer.c b/sound/soc/tegra/tegra210_mixer.c
index 3579bc61589fc..71494e97c2a0d 100644
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
-- 
2.53.0

