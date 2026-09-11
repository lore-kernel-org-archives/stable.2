Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB61305670;
	Fri, 11 Sep 2026 01:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789091038; cv=none; b=dQikMiRoXwhTckRV9SeO1PVKRbR7oevj33SMqzH+tbyb/RuLooHKn7MA6pt8bcm7b+YIrTb0TjnoSqhQld9gR1LZ32Gd3q5kAxN9XP5D2EEqICkLA7CsJhuBJrcFdDJ4SYAUwo2fxugPjRIfsa6YpRl7w8DBVSDo7PxJo1ZzcHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789091038; c=relaxed/simple;
	bh=iXgmn2uOSBBdjl+KPdKCofG37astsLuhw9GxPjsdAwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnYiSWshMCR4AbaWUzLTBRNU5bcSddIn9umEhvzo/cQxkWqdNeBK4WpwyIpbePmbqAby1GyOVGxcdnoSQQ0+Dowof5UEL3txpD6SfG65bAqxTlEYrfGBRp9BTnbeEMroCFGrNPsIzRPHajBfv6ucXqI1I9JHpXK/LNZsBOnoJ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/32rOQX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/32rOQX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D601F000FF;
	Fri, 11 Sep 2026 01:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789091034;
	bh=s2FQts83Us8TWLpDYKUSvEckML760uaH5kF14k0G0is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g/32rOQXM3uuXzsSo8jWDEhKkAlcmmDFIFkqcBk0M7315yGnFxq/+prBItcTuTha+
	 tzY2PbUTg6GgSnqgih2LKnoQR/l5M+acACjxa0ZvOKsFWgmCPnWIDNPrsi8FdWZQ3s
	 Cli26PRHNjpsKt/yvFKaK2ZYdLYYdTqLJD2SK7/u8MxtlNEUfcfokkI8QsmcuJDW0+
	 85b7C75Y+rcvuwfYLtI5wnwGE5XBC5zPgVpfE93DVGSvVFImH3RU97/VGyyhF1q2S9
	 j1x+Rnb/AQ5OcWhbyE8Y3rO3KGI94Q5djLAyJq2WYKLBsaSwCo6/koiBIWrEP0jQdk
	 VxtT+P3K7AE/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kirill Marinushkin <kmarinushkin@birdec.com>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] ASoC: pcm512x: Mend accesses to the I2S_1 and I2S_2 registers
Date: Thu, 10 Sep 2026 21:43:50 -0400
Message-ID: <20260911014351.4149354-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090937-awry-woven-fb0a@gregkh>
References: <2026090937-awry-woven-fb0a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Rosin <peda@axentia.se>

[ Upstream commit 3f4b57ad07d9237acf1b8cff3f8bf530cacef87a ]

Commit 25d27c4f68d2 ("ASoC: pcm512x: Add support for more data formats")
breaks the TSE-850 device, which is using a pcm5142 in I2S and
CBM_CFS mode (maybe not relevant). Without this fix, the result
is:

pcm512x 0-004c: Failed to set data format: -16

And after that, no sound.

This fix is not 100% correct. The datasheet of at least the pcm5142
states that four bits (0xcc) in the I2S_1 register are "RSV"
("Reserved. Do not access.") and no hint is given as to what the
initial values are supposed to be. So, specifying defaults for
these bits is wrong. But perhaps better than a broken driver?

Fixes: 25d27c4f68d2 ("ASoC: pcm512x: Add support for more data formats")
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Kirill Marinushkin <kmarinushkin@birdec.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Link: https://lore.kernel.org/r/2d221984-7a2e-7006-0f8a-ffb5f64ee885@axentia.se
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 767d9ae714e3 ("ASoC: pcm512x: sort the register default table")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/pcm512x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 3677e9029f91e..5182777b93b06 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -116,6 +116,8 @@ static const struct reg_default pcm512x_reg_defaults[] = {
 	{ PCM512x_FS_SPEED_MODE,     0x00 },
 	{ PCM512x_IDAC_1,            0x01 },
 	{ PCM512x_IDAC_2,            0x00 },
+	{ PCM512x_I2S_1,             0x02 },
+	{ PCM512x_I2S_2,             0x00 },
 };
 
 static bool pcm512x_readable(struct device *dev, unsigned int reg)
-- 
2.53.0

