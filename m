Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA813E557D;
	Wed,  5 Aug 2026 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920563; cv=none; b=OxXnKTBEpWxo975TStIZAel8DChQ7dA6uk/Ow1hXbUQmDUhMF4Et7TxEDk9Q5KGx6A6af4M5IuxjebJdUH7qnrMyu0MlHA0pFr1unIm+e+BHkh214MzsLW02xP7TMXQn4XB76wohMLseCANEVkx6n8C3BqM5QZBZoDEIDhjdi1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920563; c=relaxed/simple;
	bh=B07WwKj4BBTgvh/ocn5ACHi/TMSfH103eV3m172QSgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftxswbkNEPKwZAnPoT8h5BRaE1CPPrfxkKu1sUwIKiCdBgxHfZw+r1uMosJqLR0ITpfg5pJ3JKRyFtZGo9k3JtsCENzJfmH5nhnMJ0RmjAPi6PnJH2nFoVGgzhoditkRUTaU9696E9dCt8QAaGzG10aGuqud4nKqpErmgu7/ByM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zob13WZx; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zob13WZx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785920562; x=1817456562;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B07WwKj4BBTgvh/ocn5ACHi/TMSfH103eV3m172QSgE=;
  b=Zob13WZxLn+ZoCqxEVK8YTcA4ndq5TEcpzCMnlx+i1DBkyD6iIDyEBxt
   qgt6hZr8KIEy0TMHtjBKnKjIwmLWGoxgXvFS3KgGTLHsp5gydVAWoc9iK
   VSSEDT0ZXQZcISCf0IELygUfpSAfKaca7S0pcziE20Xdar0BiymMjxsUs
   OAacOfWS1SZqIHO7RQX0kdSSGzXhcle+1oNZqRcMF35Xng5yVIelPrmrL
   Av74ccWged4Z8rE2QR9rtxlekwv1q1VCyu6MLUyfS03Id+WXWaCY2ZhxM
   Hi1lO61dQrvKKZ4MdP0pwlyd1SycsYJj2Yy2C4vt+/J+Hx6SLi+5dDfJG
   w==;
X-CSE-ConnectionGUID: lim62ECUTRO4nw3jrt7Yag==
X-CSE-MsgGUID: 8Jc65qb9Sla+YmfcZregyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96842798"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="96842798"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:41 -0700
X-CSE-ConnectionGUID: Pj4DzMK5SFSXRkkp1uCoBg==
X-CSE-MsgGUID: eGoHq+XGTCySRV+Y8c9HdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="261814095"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:38 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Oder Chiou <oder_chiou@realtek.com>,
	Shuming Fan <shumingf@realtek.com>,
	Jack Yu <jack.yu@realtek.com>,
	Derek Fang <derek.fang@realtek.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 12/17] ASoC: rt715-sdca: sort the register default tables
Date: Wed,  5 Aug 2026 12:02:35 +0300
Message-ID: <20260805090240.16991-13-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805090240.16991-1-peter.ujfalusi@linux.intel.com>
References: <20260805090240.16991-1-peter.ujfalusi@linux.intel.com>
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

Both tables group the entries by SDCA entity instead: in
rt715_reg_defaults_sdca[] the CX_CLK_SEL control is listed before the
ADC8_9, ADC10_11 and ADC7_27 mute controls (7 of 78 entries unreachable),
and in rt715_mbq_reg_defaults_sdca[] the AMIC_GAIN_EN CH_08 entry is listed
before the DMIC_GAIN_EN entries (1 of 32 entries unreachable).
regcache_reg_needs_sync() then cannot compare those against their default
and reports that a sync is needed, so they are written to the device on
every regcache_sync() even when they were never touched.

Sort both tables by register address.

Fixes: 20d17057f0a8 ("ASoC: rt715-sdca: Add RT715 sdca vendor-specific driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/rt715-sdca-sdw.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt715-sdca-sdw.h b/sound/soc/codecs/rt715-sdca-sdw.h
index 774762480195..d408f2d7d0f2 100644
--- a/sound/soc/codecs/rt715-sdca-sdw.h
+++ b/sound/soc/codecs/rt715-sdca-sdw.h
@@ -76,8 +76,6 @@ static const struct reg_default rt715_reg_defaults_sdca[] = {
 	{ 0x2f52, 0x01 },
 	{ 0x2f5a, 0x02 },
 	{ 0x2f5b, 0x05 },
-	{ SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_CX_CLK_SEL_EN,
-		RT715_SDCA_CX_CLK_SEL_CTRL, CH_00), 0x1 },
 	{ SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_FU_ADC8_9_VOL,
 		RT715_SDCA_FU_MUTE_CTRL, CH_01), 0x01 },
 	{ SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_FU_ADC8_9_VOL,
@@ -98,6 +96,8 @@ static const struct reg_default rt715_reg_defaults_sdca[] = {
 		RT715_SDCA_FU_MUTE_CTRL, CH_01), 0x01 },
 	{ SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_FU_ADC7_27_VOL,
 		RT715_SDCA_FU_MUTE_CTRL, CH_02), 0x01 },
+	{ SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_CX_CLK_SEL_EN,
+		RT715_SDCA_CX_CLK_SEL_CTRL, CH_00), 0x1 },
 	{ SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_SMPU_TRIG_ST_EN,
 		RT715_SDCA_SMPU_TRIG_EN_CTRL, CH_00), 0x02 },
 	{ SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_SMPU_TRIG_ST_EN,
@@ -145,8 +145,6 @@ static const struct reg_default rt715_mbq_reg_defaults_sdca[] = {
 		RT715_SDCA_FU_DMIC_GAIN_CTRL, CH_06), 0x00 },
 	{ SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_FU_AMIC_GAIN_EN,
 		RT715_SDCA_FU_DMIC_GAIN_CTRL, CH_07), 0x00 },
-	{ SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_FU_AMIC_GAIN_EN,
-		RT715_SDCA_FU_DMIC_GAIN_CTRL, CH_08), 0x00 },
 	{ SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_FU_DMIC_GAIN_EN,
 		RT715_SDCA_FU_DMIC_GAIN_CTRL, CH_01), 0x00 },
 	{ SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_FU_DMIC_GAIN_EN,
@@ -161,6 +159,8 @@ static const struct reg_default rt715_mbq_reg_defaults_sdca[] = {
 		RT715_SDCA_FU_DMIC_GAIN_CTRL, CH_06), 0x00 },
 	{ SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_FU_DMIC_GAIN_EN,
 		RT715_SDCA_FU_DMIC_GAIN_CTRL, CH_07), 0x00 },
+	{ SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_FU_AMIC_GAIN_EN,
+		RT715_SDCA_FU_DMIC_GAIN_CTRL, CH_08), 0x00 },
 	{ SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_FU_DMIC_GAIN_EN,
 		RT715_SDCA_FU_DMIC_GAIN_CTRL, CH_08), 0x00 },
 };
-- 
2.55.0

