Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195D93E557D;
	Wed,  5 Aug 2026 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920547; cv=none; b=dHHKPLgroniWGxsr1rwofuW528G90UvAWNKVAOGH3TCGEI+Q1V3a7cWI1X0G18q11FWpyAuvAZwOOj2JuP2KGfCr1pYltffFOuGnnKVyf7Di0bbxyx+WDIpViT8R8lQExokHYBU2x1ZXkrQKABz3ymRS3rF3P8jZpaA/Sk8BwY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920547; c=relaxed/simple;
	bh=d76GoRKMIHPbfUtJdEVeo7oMXgsinjWtP0Dffd3MNtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p51Xx1qsm45OciEWyMloP9bGhKflX0Vu2gy9sHg1Armo15eKD1q4KIMHXmGqIhuSJVp5P/0uFcVaXMEMnQw1TqpIIOjQ1O6yB+nZilaBQNSPrUy4OzWfeQ/5quI4YwPxhRjyKcN5Km1NzSpABfF1zV6uAySzihtv7oGSSWDZGa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SbmWkPlZ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SbmWkPlZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785920547; x=1817456547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d76GoRKMIHPbfUtJdEVeo7oMXgsinjWtP0Dffd3MNtQ=;
  b=SbmWkPlZuaWNU4TpE7yJAVM2nnj39heR0fREKSs2GvzAOswEER6NUHbZ
   4r+OV3/vaZWifsRMLmzP9hhQzlG7yr3F3iBcB9rQ4lsGtOgJX+mIJFWr3
   j6lnBHDQLfERSqPpkpjh88UpODLnYyi3vRRTYiOTsurv1o+vIUGynbM01
   pcyla/kzhInNtVc+8OQQMRHXPrX0DSBwMNlS23fPyP5Tx1DHODZWjMM3/
   Fk+hBX3J6MbCweO+wZNsBaNOy59AnOO5fGDOI68FGQ4iX7K6wKOq3wol4
   wjbJbQy3LUOiKc4DP52qUDqN6RxRJpPzPOCwFVIDu4891MeynswlU26xy
   A==;
X-CSE-ConnectionGUID: n2adxYiYQRuTNk8hdUfvvQ==
X-CSE-MsgGUID: MdS/vxqvRGG9KxWdi3GK4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96842744"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="96842744"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:26 -0700
X-CSE-ConnectionGUID: 7DSxF+waSq6doBBKJhhQaw==
X-CSE-MsgGUID: t4GXXv5JT5uO2wY6JNHPbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="261814015"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:24 -0700
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
Subject: [PATCH 07/17] ASoC: rt711-sdca: sort the register default tables
Date: Wed,  5 Aug 2026 12:02:30 +0300
Message-ID: <20260805090240.16991-8-peter.ujfalusi@linux.intel.com>
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
rt711_sdca_reg_defaults[] the CS01 sample frequency index is listed before
the FU05 controls (1 of 54 entries unreachable), and in
rt711_sdca_mbq_defaults[] the MIC_ARRAY FU1E volumes are listed before the
JACK_CODEC FU0F volumes (2 of 25 entries unreachable).
regcache_reg_needs_sync() then cannot compare those against their default
and reports that a sync is needed, so they are written to the device on
every regcache_sync() even when they were never touched.

Sort both tables by register address.

Fixes: 7ad4d237e7c4 ("ASoC: rt711-sdca: Add RT711 SDCA vendor-specific driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/rt711-sdca-sdw.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt711-sdca-sdw.h b/sound/soc/codecs/rt711-sdca-sdw.h
index 0d774e473ab9..9aa22b52d556 100644
--- a/sound/soc/codecs/rt711-sdca-sdw.h
+++ b/sound/soc/codecs/rt711-sdca-sdw.h
@@ -58,12 +58,12 @@ static const struct reg_default rt711_sdca_reg_defaults[] = {
 	{ 0x2f0f, 0x00 },
 	{ 0x2f50, 0x03 },
 	{ 0x2f5a, 0x00 },
-	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT711_SDCA_ENT_CS01, RT711_SDCA_CTL_SAMPLE_FREQ_INDEX, 0), 0x09 },
 	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT711_SDCA_ENT_USER_FU05, RT711_SDCA_CTL_FU_MUTE, CH_L), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT711_SDCA_ENT_USER_FU05, RT711_SDCA_CTL_FU_MUTE, CH_R), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT711_SDCA_ENT_USER_FU0F, RT711_SDCA_CTL_FU_MUTE, CH_L), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT711_SDCA_ENT_USER_FU0F, RT711_SDCA_CTL_FU_MUTE, CH_R), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT711_SDCA_ENT_PDE28, RT711_SDCA_CTL_REQ_POWER_STATE, 0), 0x03 },
+	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT711_SDCA_ENT_CS01, RT711_SDCA_CTL_SAMPLE_FREQ_INDEX, 0), 0x09 },
 	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT711_SDCA_ENT_USER_FU1E, RT711_SDCA_CTL_FU_MUTE, CH_L), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT711_SDCA_ENT_USER_FU1E, RT711_SDCA_CTL_FU_MUTE, CH_R), 0x01 },
 };
@@ -86,14 +86,14 @@ static const struct reg_default rt711_sdca_mbq_defaults[] = {
 	{ 0x610003f, 0xff12 },
 	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT711_SDCA_ENT_USER_FU05, RT711_SDCA_CTL_FU_VOLUME, CH_L), 0x00 },
 	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT711_SDCA_ENT_USER_FU05, RT711_SDCA_CTL_FU_VOLUME, CH_R), 0x00 },
-	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT711_SDCA_ENT_USER_FU1E, RT711_SDCA_CTL_FU_VOLUME, CH_L), 0x00 },
-	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT711_SDCA_ENT_USER_FU1E, RT711_SDCA_CTL_FU_VOLUME, CH_R), 0x00 },
 	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT711_SDCA_ENT_USER_FU0F, RT711_SDCA_CTL_FU_VOLUME, CH_L), 0x00 },
 	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT711_SDCA_ENT_USER_FU0F, RT711_SDCA_CTL_FU_VOLUME, CH_R), 0x00 },
 	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT711_SDCA_ENT_PLATFORM_FU44, RT711_SDCA_CTL_FU_CH_GAIN, CH_L), 0x00 },
 	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT711_SDCA_ENT_PLATFORM_FU44, RT711_SDCA_CTL_FU_CH_GAIN, CH_R), 0x00 },
 	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT711_SDCA_ENT_PLATFORM_FU15, RT711_SDCA_CTL_FU_CH_GAIN, CH_L), 0x00 },
 	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT711_SDCA_ENT_PLATFORM_FU15, RT711_SDCA_CTL_FU_CH_GAIN, CH_R), 0x00 },
+	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT711_SDCA_ENT_USER_FU1E, RT711_SDCA_CTL_FU_VOLUME, CH_L), 0x00 },
+	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT711_SDCA_ENT_USER_FU1E, RT711_SDCA_CTL_FU_VOLUME, CH_R), 0x00 },
 };
 
 #endif /* __RT711_SDW_SDCA_H__ */
-- 
2.55.0

