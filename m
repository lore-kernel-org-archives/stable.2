Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1CF245012
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789091036; cv=none; b=Jz2B/XZqUJG8ZZg9BD+w5rwSDA/pBCSp5J+o/Im7Qs92isRXuujOSzpw58Xfqz9Sg9+azqPcDFFxnf/7VBXMakHWmC4Ui6NOM1OVe3wNb8WdbSFRdAijK0Di5WfvT/uww/SKtQukCkUBWyWMx/w4QHB6eE12s7x/plDJiNvK8P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789091036; c=relaxed/simple;
	bh=jPFyD+1gT76IYMRyaOlVHB5Cb6q83IJKJR3uV9MBsWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sljl04ec9Kx/78wMDB902s/izN9sz/tr2L807aqJsTFpyUBz8eBUi+9Jdobnz97Gb20e+Gyodqk32VrjMwdCd09yu7biY7I11JGURLEhz0aoKm1JWLeRTnf9jwUvSfqvhuZJC9ThH+NilQ9c1HtcexhFHjMcH5w5FDIQ/MwdYzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmoHt9oT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmoHt9oT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501D61F00898;
	Fri, 11 Sep 2026 01:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789091034;
	bh=n6kQUpGEDDMzc3DolS8UmxL5LLKYa2xTjMrRzyOEToo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BmoHt9oT9xPh2SOrnCz4Ob/ePUm5xNZaL9oWpSuVGQ/6DtcowWBxG6FvrmYFZH4Gz
	 G1gWQxDLIAzaP6vbsCYVcLOxaZLAo43IATmNxq9MIBqAyUv1oBqcepfAReMGfq5qlz
	 LoQWB5fLxuzs0R9vPjRbotSaHogwUClCtMxoQbe9qV+b0xCshFodQ9XiZ6TTdL49yj
	 ppAwEkagvG9+eejHART8qklwtQjr6prMvx7H4NUm+dWYGsiJjRECuaI8RbEOUajx/2
	 PDHYr61pwFcrvplPBxB3pAyYnPRDgZC5AXwGuo79wIniQ/04Rhqm+5fAc4ivBmWOlk
	 SyxJvpDMtm8kw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] ASoC: pcm512x: sort the register default table
Date: Thu, 10 Sep 2026 21:43:51 -0400
Message-ID: <20260911014351.4149354-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911014351.4149354-1-sashal@kernel.org>
References: <2026090937-awry-woven-fb0a@gregkh>
 <20260911014351.4149354-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 767d9ae714e3e9b0ae86237c410fbfca7056570a ]

reg_defaults must be sorted by ascending register address, as
regcache_lookup_reg() locates entries in it with bsearch().  See commit
fd80df352ba1 ("regcache: Add support for sorting defaults arrays").

PCM512x_AUTO_MUTE (page 0, register 59) is listed before
PCM512x_ERROR_DETECT (page 0, register 37) and PCM512x_VCOM_CTRL_2
(page 1, register 9) is listed before the page 0 clocking block, so the
bsearch() descends into the wrong half of the table.  24 of the 45
entries are unreachable, among them every PLL coefficient and clock
divider default.  regcache_reg_needs_sync() then cannot compare them
against their default and reports that a sync is needed, so they are
written to the device on every regcache_sync() even when they were
never touched.

Sort the table by register address.

Fixes: 5a3af1293194 ("ASoC: pcm512x: Add PCM512x driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20260805104149.9795-2-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/pcm512x.c | 40 +++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 5182777b93b06..a7702595c894c 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -77,28 +77,10 @@ static const struct reg_default pcm512x_reg_defaults[] = {
 	{ PCM512x_POWER,             0x00 },
 	{ PCM512x_MUTE,              0x00 },
 	{ PCM512x_DSP,               0x00 },
-	{ PCM512x_PLL_REF,           0x00 },
-	{ PCM512x_DAC_REF,           0x00 },
-	{ PCM512x_DAC_ROUTING,       0x11 },
-	{ PCM512x_DSP_PROGRAM,       0x01 },
-	{ PCM512x_CLKDET,            0x00 },
-	{ PCM512x_AUTO_MUTE,         0x00 },
-	{ PCM512x_ERROR_DETECT,      0x00 },
-	{ PCM512x_DIGITAL_VOLUME_1,  0x00 },
-	{ PCM512x_DIGITAL_VOLUME_2,  0x30 },
-	{ PCM512x_DIGITAL_VOLUME_3,  0x30 },
-	{ PCM512x_DIGITAL_MUTE_1,    0x22 },
-	{ PCM512x_DIGITAL_MUTE_2,    0x00 },
-	{ PCM512x_DIGITAL_MUTE_3,    0x07 },
-	{ PCM512x_OUTPUT_AMPLITUDE,  0x00 },
-	{ PCM512x_ANALOG_GAIN_CTRL,  0x00 },
-	{ PCM512x_UNDERVOLTAGE_PROT, 0x00 },
-	{ PCM512x_ANALOG_MUTE_CTRL,  0x00 },
-	{ PCM512x_ANALOG_GAIN_BOOST, 0x00 },
-	{ PCM512x_VCOM_CTRL_1,       0x00 },
-	{ PCM512x_VCOM_CTRL_2,       0x01 },
 	{ PCM512x_BCLK_LRCLK_CFG,    0x00 },
 	{ PCM512x_MASTER_MODE,       0x7c },
+	{ PCM512x_PLL_REF,           0x00 },
+	{ PCM512x_DAC_REF,           0x00 },
 	{ PCM512x_GPIO_DACIN,        0x00 },
 	{ PCM512x_GPIO_PLLIN,        0x00 },
 	{ PCM512x_SYNCHRONIZE,       0x10 },
@@ -116,8 +98,26 @@ static const struct reg_default pcm512x_reg_defaults[] = {
 	{ PCM512x_FS_SPEED_MODE,     0x00 },
 	{ PCM512x_IDAC_1,            0x01 },
 	{ PCM512x_IDAC_2,            0x00 },
+	{ PCM512x_ERROR_DETECT,      0x00 },
 	{ PCM512x_I2S_1,             0x02 },
 	{ PCM512x_I2S_2,             0x00 },
+	{ PCM512x_DAC_ROUTING,       0x11 },
+	{ PCM512x_DSP_PROGRAM,       0x01 },
+	{ PCM512x_CLKDET,            0x00 },
+	{ PCM512x_AUTO_MUTE,         0x00 },
+	{ PCM512x_DIGITAL_VOLUME_1,  0x00 },
+	{ PCM512x_DIGITAL_VOLUME_2,  0x30 },
+	{ PCM512x_DIGITAL_VOLUME_3,  0x30 },
+	{ PCM512x_DIGITAL_MUTE_1,    0x22 },
+	{ PCM512x_DIGITAL_MUTE_2,    0x00 },
+	{ PCM512x_DIGITAL_MUTE_3,    0x07 },
+	{ PCM512x_OUTPUT_AMPLITUDE,  0x00 },
+	{ PCM512x_ANALOG_GAIN_CTRL,  0x00 },
+	{ PCM512x_UNDERVOLTAGE_PROT, 0x00 },
+	{ PCM512x_ANALOG_MUTE_CTRL,  0x00 },
+	{ PCM512x_ANALOG_GAIN_BOOST, 0x00 },
+	{ PCM512x_VCOM_CTRL_1,       0x00 },
+	{ PCM512x_VCOM_CTRL_2,       0x01 },
 };
 
 static bool pcm512x_readable(struct device *dev, unsigned int reg)
-- 
2.53.0

