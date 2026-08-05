Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AAE3EEAE7;
	Wed,  5 Aug 2026 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920556; cv=none; b=JpJV2l0+syLBM3z1x7PG2beKK8ZVCwxWKsGI/YrF4BPHoD3Og+TP9Id9m+xd4K5nSTWHq4VAEN3BlyGoazc8RgNw2Uu9o8cBE4q3+wmUISA1ki4Si6htIkzfN+haE8mkA/moMG/37W5QV5IH9G8x1DtQD/vV5RBgIKCmYOA9M1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920556; c=relaxed/simple;
	bh=x0xFPvYR0dT5BhSbKD9qypKTurwL3BZi0jJA2/9vN8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/9/5/BaCKOQVomQRsvvGBeR6THxSWJBPU3DKVKT64V/Iq3QPsSBc/SSACD0Wp8HmFKq/8mSCd7vmulT2YW8wm9H3jygjOq5sfA63J3oHRHlTuBQGvRJpEoa0YmvTnlBt+kLH10LdiXzS5PVGHjb5WYGW+zPwI7Z4+RgFaALrg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fRhyrkAS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fRhyrkAS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785920553; x=1817456553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x0xFPvYR0dT5BhSbKD9qypKTurwL3BZi0jJA2/9vN8U=;
  b=fRhyrkASG2sdSDtReoN9iyH9JI5a2Ye2IbXt5G/6DijZkNbgqRhzl6VE
   H3zRmfOgI7Zi6tTprysL9xaymr62thYsLhYX2iDaRAvHiqh5BCM3q3IW7
   0xiPSMo3+6JCOOb3LYRvqyXfLkPQJiVX/VVPRpbikacMohhD8AwGEZy2x
   YCIgRBh6IJ5iQzyaWYeY89SZd6UpSyADej9hAftfiz5C/Y14gQGf7KZB6
   E/xnEei3PgRR91RQ4MOPl3SsgqYiS1PnLhJHnHOXE9cl/dCtBxRfFUqDP
   J5qI+4cl0j3UBn9S0R+iAPbGvR5GkCq5rQAXwRjDpFtn0aR5gtm89+P56
   Q==;
X-CSE-ConnectionGUID: 1/KCeJ2MQ++mBShyu6fzKg==
X-CSE-MsgGUID: Lwt7Y61fReWBs8kAtC66qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96842774"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="96842774"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:32 -0700
X-CSE-ConnectionGUID: QBGchuHKQsuo1I9vU+87+w==
X-CSE-MsgGUID: itH1R9/SQSKZIlfEdeSFZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="261814041"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:29 -0700
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
Subject: [PATCH 09/17] ASoC: rt712-sdca-sdw: sort the register default table
Date: Wed,  5 Aug 2026 12:02:32 +0300
Message-ID: <20260805090240.16991-10-peter.ujfalusi@linux.intel.com>
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

rt712_sdca_reg_defaults[] is grouped by SDCA function instead, so the
binary search does not find 4 of its entries.  regcache_reg_needs_sync()
then cannot compare those against their default and reports that a sync
is needed, so they are written to the device on every regcache_sync()
even when they were never touched.

One of them is the Mic Array Clock Source 0x1C Sample Frequency Index
control, which a part without that function rejects:

  soundwire_intel.link.0: Msg ignored for Slave 6, addr: 0x8e00

Sort the table by register address.

Fixes: 936abb09c1c7 ("ASoC: rt712-sdca: add the function for version B")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/rt712-sdca-sdw.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt712-sdca-sdw.h b/sound/soc/codecs/rt712-sdca-sdw.h
index 99fd2d67f04d..7ad25cc27f62 100644
--- a/sound/soc/codecs/rt712-sdca-sdw.h
+++ b/sound/soc/codecs/rt712-sdca-sdw.h
@@ -11,21 +11,21 @@
 #include <linux/regmap.h>
 #include <linux/soundwire/sdw_registers.h>
 
+/* must stay sorted by register address, regcache_lookup_reg() does a bsearch() */
 static const struct reg_default rt712_sdca_reg_defaults[] = {
-
-	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT712_SDCA_ENT_CS01, RT712_SDCA_CTL_SAMPLE_FREQ_INDEX, 0), 0x09 },
-	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT712_SDCA_ENT_CS11, RT712_SDCA_CTL_SAMPLE_FREQ_INDEX, 0), 0x09 },
 	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT712_SDCA_ENT_USER_FU05, RT712_SDCA_CTL_FU_MUTE, CH_01), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT712_SDCA_ENT_USER_FU05, RT712_SDCA_CTL_FU_MUTE, CH_02), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT712_SDCA_ENT_USER_FU0F, RT712_SDCA_CTL_FU_MUTE, CH_01), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT712_SDCA_ENT_USER_FU0F, RT712_SDCA_CTL_FU_MUTE, CH_02), 0x01 },
-	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT712_SDCA_ENT_PDE40, RT712_SDCA_CTL_REQ_POWER_STATE, 0), 0x03 },
 	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT712_SDCA_ENT_PDE12, RT712_SDCA_CTL_REQ_POWER_STATE, 0), 0x03 },
-	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT712_SDCA_ENT_CS1C, RT712_SDCA_CTL_SAMPLE_FREQ_INDEX, 0), 0x09 },
+	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT712_SDCA_ENT_CS01, RT712_SDCA_CTL_SAMPLE_FREQ_INDEX, 0), 0x09 },
+	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT712_SDCA_ENT_CS11, RT712_SDCA_CTL_SAMPLE_FREQ_INDEX, 0), 0x09 },
+	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT712_SDCA_ENT_PDE40, RT712_SDCA_CTL_REQ_POWER_STATE, 0), 0x03 },
 	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT712_SDCA_ENT_USER_FU1E, RT712_SDCA_CTL_FU_MUTE, CH_01), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT712_SDCA_ENT_USER_FU1E, RT712_SDCA_CTL_FU_MUTE, CH_02), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT712_SDCA_ENT_USER_FU1E, RT712_SDCA_CTL_FU_MUTE, CH_03), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT712_SDCA_ENT_USER_FU1E, RT712_SDCA_CTL_FU_MUTE, CH_04), 0x01 },
+	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT712_SDCA_ENT_CS1C, RT712_SDCA_CTL_SAMPLE_FREQ_INDEX, 0), 0x09 },
 	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT712_SDCA_ENT_CS1F, RT712_SDCA_CTL_SAMPLE_FREQ_INDEX, 0), 0x09 },
 	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT712_SDCA_ENT_USER_FU06, RT712_SDCA_CTL_FU_MUTE, CH_01), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT712_SDCA_ENT_USER_FU06, RT712_SDCA_CTL_FU_MUTE, CH_02), 0x01 },
@@ -34,6 +34,7 @@ static const struct reg_default rt712_sdca_reg_defaults[] = {
 	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT712_SDCA_ENT_OT23, RT712_SDCA_CTL_VENDOR_DEF, 0), 0x00 },
 };
 
+/* must stay sorted by register address, regcache_lookup_reg() does a bsearch() */
 static const struct reg_default rt712_sdca_mbq_defaults[] = {
 	{ 0x2000004, 0xaa01 },
 	{ 0x200000e, 0x21e0 },
-- 
2.55.0

