Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2297C37F730
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789091041; cv=none; b=sGspgR/+gYooIjh/+aRe6woK2HS9cIwZP3eaCv1/2qcGj97sXaCvNYUuvkyZTZDLrEYhymEf90io94YVMHSwfOvAKNpDfyuzX2dvd3YJkw3JUoaibs3kpqvtwG8ne/NMH6v1/nEIe995zLo0BmefDqmGcDTHI8tIyK8FId/W5vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789091041; c=relaxed/simple;
	bh=iXK4aAfvif2Zh6OcXKiYx6cT2TSXVdOyEqVyZ4OHKDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HG9QqlYnY4KrK9cOmjxmjsn2eGGKXapJ4smLqqzjCCCWLSzOjntvROXLqEtnUm4PhG3DwIq/rtxKB+py3EoioTQ/NBol76lfIXJdtOnUgPEAiK3MjnGbOB/Jxs95buqLjhkejO4xBjnkOV0oGjUusIywMASs/pT1dlY1cjzb7EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz/ZuRB/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz/ZuRB/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89ACE1F0089D;
	Fri, 11 Sep 2026 01:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789091040;
	bh=c/ie7P2lvWlcUMN7xDU+ZMXoo7mtwfOHtC/I/It8S7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sz/ZuRB/luqbpCr3KmQh3E3TUryDKo+maiq8C3+6OSL/hwgkKj0y0TwVRNi1sBAVs
	 ImbNfIqAsTQve6nATvjbkrea5jqX05KIZ6mQB8oiaYeWQlmrvOdch3a0SW4v9SFi71
	 1MS3zGWyUqqo4PopXKN4SpAg1ppZBdwcsPVu9Jnl6WlDCXgKRyZes8U6odNpYMkFef
	 db31Y5cZBtmN5rVPcMm30N0fu7oNwQE23+hhcSOwiqCPqyh6ZF3iOI0XO92IugxYiN
	 4QlKYBzlmTysOsivG5FwCbEjNc+7Jshl4yM7k3+qJgU7bJvBXkBWzCWl6BPrzIHgFz
	 DvnXUSwAVIx9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jon Hunter <jonathanh@nvidia.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] ASoC: tegra: Fix the MIXER enable default value
Date: Thu, 10 Sep 2026 21:43:57 -0400
Message-ID: <20260911014357.4149699-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911014357.4149699-1-sashal@kernel.org>
References: <2026090906-choice-delicate-818c@gregkh>
 <20260911014357.4149699-1-sashal@kernel.org>
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
index 7808a54810626..f368729066caa 100644
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
@@ -86,11 +86,15 @@ static int __maybe_unused tegra210_mixer_runtime_suspend(struct device *dev)
 static int __maybe_unused tegra210_mixer_runtime_resume(struct device *dev)
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

