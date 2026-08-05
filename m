Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286AD41C30F;
	Wed,  5 Aug 2026 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926480; cv=none; b=AMnFWvb0VKTajhGZRu70PbXd7T2F7neF20NnlAO/b8hrQmcd6krr/qjvOzJxaJDwo5m9hIDikW58H28lTpnxDIFalQ1SrutzZLvM5Pzr2GbO7mWCqso9mKoBjTI2h1YHAmUT8TFRL/daMVzQ+2yFz9WbHp9WFprX1BmEC8XwpUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926480; c=relaxed/simple;
	bh=vIbvFiwiMihr5EPCa6FXGnA9FCSPT8f4jpsHPBwIWc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n47onHgYGKhnYjmz5jr1TrTLTS/gMZnYbVNLpDpTZkZbRzHtvMWVnt0wIfGceenmsyADZnQffqPGf6eZg5icbgX5TAvvL9l/I+DCeLT5pvsCuxXfSel/Z+UA5ZWSvxnnsHGvpXd6+rlwKpofJEyQYfrC+7TJPsZIVKg33yfV2V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RxKOhKGq; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RxKOhKGq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785926479; x=1817462479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vIbvFiwiMihr5EPCa6FXGnA9FCSPT8f4jpsHPBwIWc0=;
  b=RxKOhKGq73Muk1UM5t+GeNmzOydvdMu4EL66iGo7B8sFXKplMacv9w1o
   gwDdPy71otTq31CJ1QtJIbnKm6pTF66VKaXv1wXlDuycDXSdthRbgvnmK
   L4wT185ZBRIYKu0oFk31zlH8IJOnhW2rl6L6tHSWrJhxm/aUh3QsFSfCD
   p6nZLEwc32LGsl6oSSFc5UUPlG2BSWM1y4By0EVs7+Jk+T6TGVCuuAfn6
   gKvh+/nCiJIrmtgkdf+jzbJz7tqPoGQGdlZNFnjOUPb99eZgFnQplufKd
   PKg2VMoLX0TTZgQhgMoIQ2ubvO67863Te2MRIIMZUHYsszoj1J9L8/BVM
   g==;
X-CSE-ConnectionGUID: bcuX8NndQPqWT4Sgmh9MSg==
X-CSE-MsgGUID: 34nQMosfRFmlx8lv6ak46g==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97143819"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="97143819"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 03:41:17 -0700
X-CSE-ConnectionGUID: +pp/pyXMQYiH9ZLpjaUllQ==
X-CSE-MsgGUID: DVRboZBzT8S7g0MwoEttYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="265278528"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 03:41:15 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Sen Wang <sen@ti.com>
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/5] ASoC: pcm512x: sort the register default table
Date: Wed,  5 Aug 2026 13:41:45 +0300
Message-ID: <20260805104149.9795-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805104149.9795-1-peter.ujfalusi@linux.intel.com>
References: <20260805104149.9795-1-peter.ujfalusi@linux.intel.com>
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
---
 sound/soc/codecs/pcm512x.c | 40 +++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index fe3b5011fa16..03b1fcb1bf96 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -78,28 +78,10 @@ static const struct reg_default pcm512x_reg_defaults[] = {
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
@@ -117,8 +99,26 @@ static const struct reg_default pcm512x_reg_defaults[] = {
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
2.55.0

