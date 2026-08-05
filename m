Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CABD442B11;
	Wed,  5 Aug 2026 12:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932800; cv=none; b=TDpF2FsV1E/RQgXRogOnodcrMsXuNF151TMn1mf65bCX4fm0O3Da4bws8fvPLLe6086L89NBnudpLccsH5+89WzkOQCGOz4wdu1znKsisyXv5a61OqxprFrPAMGq4VMMAPQH4pgW+evseDhDmRQyzhlTug6qFGl5i9L7kFrNRnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932800; c=relaxed/simple;
	bh=YscUxjb6Qh7IOOCTqoN2Bc9Zq1HmEs/pLqDTD7YeYuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QzFxeqZA+zgLLdvnKjndHjwb7AYGy+1FBuhhkzRzeA1R5tajJ7JHPYos6oKSzdl/9UWTJT/sx2UqfpA4OWK1tI7cuxh/kytyyAiKxiteaywLGB40A26v62Vr7MZ9gmUVtfIaVI1sq0u1vZYa/axvvMvcqxFAIqUZiv015xP3YQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NfN8NN7T; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NfN8NN7T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785932798; x=1817468798;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YscUxjb6Qh7IOOCTqoN2Bc9Zq1HmEs/pLqDTD7YeYuw=;
  b=NfN8NN7T5RWo6R+G+VneTJoCmjPZQYZSZ7w8zMixItIGvJk53pwTCqeu
   sDpiRzNcCW7DciFcJXuAsYv1YZ4+ye/rZXLy8iX3EzwUO8NDcoUUhXFct
   vCUrS6Hvw67l0qCb0s4IF1RK1zHtLrU5E+Qdxb6OsyCzp+CVKHHlbyWjh
   88BiveFgICIdC9J6wDiJ2Nlfc3VbRGBfVLPrCtTrl8uFSNl/NspVaOfbN
   6dv46D0rYbO9x2/nHQOOv65+2f7MOSYPBdkHahpstrEv8tge9Ha96xZ0Y
   sxdFdY3jLqiCIl56EvfLagqpcsyzp7+mdu4HJXC/nCwCfPMUDBF+L8nk0
   w==;
X-CSE-ConnectionGUID: Y3JDcVBcSyGGoamWph7Yaw==
X-CSE-MsgGUID: bSaiR7DnTlON6OzVsso5qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86583107"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="86583107"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:26:38 -0700
X-CSE-ConnectionGUID: qt74ynT4RFKMl+dDcOTDjA==
X-CSE-MsgGUID: VUlx2/DqR9acWdKYww9qyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="258460145"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:26:35 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: adau1761: sort the register default table
Date: Wed,  5 Aug 2026 15:27:13 +0300
Message-ID: <20260805122713.11376-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reg_defaults must be sorted by ascending register address, as
regcache_lookup_reg() locates entries in it with bsearch().  See commit
fd80df352ba1 ("regcache: Add support for sorting defaults arrays").

The table lists the ADAU1761 specific registers (0x4008 and up) before
the block shared with the ADAU1381/ADAU1781, which starts at
ADAU17X1_CLOCK_CONTROL (0x4000), so bsearch() descends into the wrong
half and 28 of the 52 entries are unreachable.
regcache_reg_needs_sync() then cannot compare them against their default
and reports that a sync is needed, so they are written to the device on
every regcache_sync() even when they were never touched.

Sort the table by register address.

Fixes: dab464b60b24 ("ASoC: Add ADAU1361/ADAU1761 audio CODEC support")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/adau1761.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/adau1761.c b/sound/soc/codecs/adau1761.c
index a70c46dd5d76..27ce03b0fb91 100644
--- a/sound/soc/codecs/adau1761.c
+++ b/sound/soc/codecs/adau1761.c
@@ -68,23 +68,33 @@
 #define ADAU1761_FIRMWARE "adau1761.bin"
 
 static const struct reg_default adau1761_reg_defaults[] = {
-	{ ADAU1761_DEJITTER,			0x03 },
+	{ ADAU17X1_CLOCK_CONTROL,		0x00 },
+	{ ADAU17X1_PLL_CONTROL,			0x00 },
 	{ ADAU1761_DIGMIC_JACKDETECT,		0x00 },
+	{ ADAU17X1_REC_POWER_MGMT,		0x00 },
 	{ ADAU1761_REC_MIXER_LEFT0,		0x00 },
 	{ ADAU1761_REC_MIXER_LEFT1,		0x00 },
 	{ ADAU1761_REC_MIXER_RIGHT0,		0x00 },
 	{ ADAU1761_REC_MIXER_RIGHT1,		0x00 },
 	{ ADAU1761_LEFT_DIFF_INPUT_VOL,		0x00 },
+	{ ADAU1761_RIGHT_DIFF_INPUT_VOL,	0x00 },
+	{ ADAU17X1_MICBIAS,			0x00 },
 	{ ADAU1761_ALC_CTRL0,			0x00 },
 	{ ADAU1761_ALC_CTRL1,			0x00 },
 	{ ADAU1761_ALC_CTRL2,			0x00 },
 	{ ADAU1761_ALC_CTRL3,			0x00 },
-	{ ADAU1761_RIGHT_DIFF_INPUT_VOL,	0x00 },
-	{ ADAU1761_PLAY_LR_MIXER_LEFT,		0x00 },
+	{ ADAU17X1_SERIAL_PORT0,		0x00 },
+	{ ADAU17X1_SERIAL_PORT1,		0x00 },
+	{ ADAU17X1_CONVERTER0,			0x00 },
+	{ ADAU17X1_CONVERTER1,			0x00 },
+	{ ADAU17X1_ADC_CONTROL,			0x00 },
+	{ ADAU17X1_LEFT_INPUT_DIGITAL_VOL,	0x00 },
+	{ ADAU17X1_RIGHT_INPUT_DIGITAL_VOL,	0x00 },
 	{ ADAU1761_PLAY_MIXER_LEFT0,		0x00 },
 	{ ADAU1761_PLAY_MIXER_LEFT1,		0x00 },
 	{ ADAU1761_PLAY_MIXER_RIGHT0,		0x00 },
 	{ ADAU1761_PLAY_MIXER_RIGHT1,		0x00 },
+	{ ADAU1761_PLAY_LR_MIXER_LEFT,		0x00 },
 	{ ADAU1761_PLAY_LR_MIXER_RIGHT,		0x00 },
 	{ ADAU1761_PLAY_MIXER_MONO,		0x00 },
 	{ ADAU1761_PLAY_HP_LEFT_VOL,		0x00 },
@@ -93,20 +103,6 @@ static const struct reg_default adau1761_reg_defaults[] = {
 	{ ADAU1761_PLAY_LINE_RIGHT_VOL,		0x00 },
 	{ ADAU1761_PLAY_MONO_OUTPUT_VOL,	0x00 },
 	{ ADAU1761_POP_CLICK_SUPPRESS,		0x00 },
-	{ ADAU1761_JACK_DETECT_PIN,		0x00 },
-	{ ADAU1761_CLK_ENABLE0,			0x00 },
-	{ ADAU1761_CLK_ENABLE1,			0x00 },
-	{ ADAU17X1_CLOCK_CONTROL,		0x00 },
-	{ ADAU17X1_PLL_CONTROL,			0x00 },
-	{ ADAU17X1_REC_POWER_MGMT,		0x00 },
-	{ ADAU17X1_MICBIAS,			0x00 },
-	{ ADAU17X1_SERIAL_PORT0,		0x00 },
-	{ ADAU17X1_SERIAL_PORT1,		0x00 },
-	{ ADAU17X1_CONVERTER0,			0x00 },
-	{ ADAU17X1_CONVERTER1,			0x00 },
-	{ ADAU17X1_LEFT_INPUT_DIGITAL_VOL,	0x00 },
-	{ ADAU17X1_RIGHT_INPUT_DIGITAL_VOL,	0x00 },
-	{ ADAU17X1_ADC_CONTROL,			0x00 },
 	{ ADAU17X1_PLAY_POWER_MGMT,		0x00 },
 	{ ADAU17X1_DAC_CONTROL0,		0x00 },
 	{ ADAU17X1_DAC_CONTROL1,		0x00 },
@@ -114,12 +110,16 @@ static const struct reg_default adau1761_reg_defaults[] = {
 	{ ADAU17X1_SERIAL_PORT_PAD,		0xaa },
 	{ ADAU17X1_CONTROL_PORT_PAD0,		0xaa },
 	{ ADAU17X1_CONTROL_PORT_PAD1,		0x00 },
+	{ ADAU1761_JACK_DETECT_PIN,		0x00 },
+	{ ADAU1761_DEJITTER,			0x03 },
 	{ ADAU17X1_DSP_SAMPLING_RATE,		0x01 },
 	{ ADAU17X1_SERIAL_INPUT_ROUTE,		0x00 },
 	{ ADAU17X1_SERIAL_OUTPUT_ROUTE,		0x00 },
 	{ ADAU17X1_DSP_ENABLE,			0x00 },
 	{ ADAU17X1_DSP_RUN,			0x00 },
 	{ ADAU17X1_SERIAL_SAMPLING_RATE,	0x00 },
+	{ ADAU1761_CLK_ENABLE0,			0x00 },
+	{ ADAU1761_CLK_ENABLE1,			0x00 },
 };
 
 static const DECLARE_TLV_DB_SCALE(adau1761_sing_in_tlv, -1500, 300, 1);
-- 
2.55.0

