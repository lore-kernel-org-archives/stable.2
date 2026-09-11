Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7334315A
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789090516; cv=none; b=EzIH66KyJ+EDZk31zlt8bVV61XP/CunvCH452zccf5oylLGrj1f/0slpeLvAV8qyS45xA83ZhgTSfu5/Mwhs6WQiJzTIuIpbnvzWPhoqEwmL+A+dMOxg5D/y6PI/36tRNpcVE+Wsu5yQiLJ0RPDjhYDIHD4ugo5k2Tlttj9bXZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789090516; c=relaxed/simple;
	bh=9EYmeImTra4E+NzOB0n4f0kzadCcxo+aBkAo6I2PPh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTCgsvkyTYSDR5a2xW28lYksrP4eOQ98WZQtSun1PAexcJzkeSxUNO6mTQtL6HD340jVglvdI9g89Ne5KsmNRGqxYZFppf8V56igo2T5Cse0yx4DyaGkjt7f1tFoY0fQie6M7toTiSx+xs2qFf6XV96yCVfLkwFCS0EU1CxtOmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCEyNPXl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCEyNPXl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573F31F000FF;
	Fri, 11 Sep 2026 01:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789090514;
	bh=ZKYDNwU5g+CsoQSkJSjeM9yCWuGorPiv/FfKGb3S1oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CCEyNPXljUcuJ0J0tciyCuHB1A3/K0OpNMKeX6Uq0D8qhxDdGcIZDWWMO442lpjCA
	 biFjWutD6XbFudfqR5cLaNMGxBzPUXcr/eoWxwk3obpDp/wVAnrGKiIp9Iv9LA9zPH
	 FD4GRwp7AC7NeTPfjjmZDYQbFT4W1KEHL11OtRlNh/ps6x6FcG+u6NjPxRerpV/I8m
	 QyQyJy+Vc1NbQyJCLQO3d/e2ASfTMpuGZVJGRIVUISFsHwvnmeR6l+rPHqKUsqx5vr
	 E7wT9mpwN6kSj8DXpm+gL4urD0nhbsEBZL1ejj4BMO+JQBeex1nftPOnTRUCEuxG2/
	 BpfbcmNDPYJ7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] ASoC: tegra210_mixer: sort the register default table
Date: Thu, 10 Sep 2026 21:35:11 -0400
Message-ID: <20260911013512.4124796-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090905-demeaning-relieve-6022@gregkh>
References: <2026090905-demeaning-relieve-6022@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit f70bc276fc7f712ff5c8e995d5050558a3198df2 ]

reg_defaults must be sorted by ascending register address, as
regcache_lookup_reg() locates entries in it with bsearch().  See commit
fd80df352ba1 ("regcache: Add support for sorting defaults arrays").

TEGRA210_MIXER_ENABLE (0x400) is the last entry of the table, after
TEGRA210_MIXER_PEAKM_RAM_CTRL (0x434), which makes it unreachable.
regcache_reg_needs_sync() then cannot compare it against its default and
reports that a sync is needed, so it is written to the device on every
regcache_sync() even when it was never touched.

Sort the table by register address.

Fixes: 05bb3d5ec64a ("ASoC: tegra: Add Tegra210 based Mixer driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20260805122748.13090-4-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 5442b8093a2f ("ASoC: tegra: Fix the MIXER enable default value")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/tegra/tegra210_mixer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/tegra/tegra210_mixer.c b/sound/soc/tegra/tegra210_mixer.c
index 95d69a7e027f5..3579bc61589fc 100644
--- a/sound/soc/tegra/tegra210_mixer.c
+++ b/sound/soc/tegra/tegra210_mixer.c
@@ -57,10 +57,10 @@ static const struct reg_default tegra210_mixer_reg_defaults[] = {
 	MIXER_TX_REG_DEFAULTS(3),
 	MIXER_TX_REG_DEFAULTS(4),
 
+	{ TEGRA210_MIXER_ENABLE, 0x1 },
 	{ TEGRA210_MIXER_CG, 0x00000001},
 	{ TEGRA210_MIXER_GAIN_CFG_RAM_CTRL, 0x00004000},
 	{ TEGRA210_MIXER_PEAKM_RAM_CTRL, 0x00004000},
-	{ TEGRA210_MIXER_ENABLE, 0x1 },
 };
 
 /* Default gain parameters */
-- 
2.53.0

