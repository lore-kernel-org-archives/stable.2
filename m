Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3438740BCD4;
	Wed,  5 Aug 2026 10:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926489; cv=none; b=jE3ifwjX1+bnVDUaVhYSsI+JrhO2zxvMSICbsCl+3VdJDvlMOJeWNr6VB1L0hTw7jvVxMAJCT1DF36yNXs4Gvh7B7U3ZYzUG7/iDtShfTSXcQ4MPddq4ywpbz9JpAUUNgv5sdtNfUPIpcXRJ4o/crGqKw6HYoq7wn8LWRShG654=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926489; c=relaxed/simple;
	bh=53A621aMDW1e4JixPr2oVIEFewwmLBWDjtAB5QHHUf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S34t4LBYxHVD0OSCFFx94z+IPs/wrDIeZbAHkQ/YhVXQG8U9tx6mSIa8/re0ULpCmffzYIXhjGAdJY+efBm/w4a/QOXKDmQsRn8IBBuJDgFdrmM3JuWvONAYZ2PRvGw/PTCR2UDdJvELu0iyYQoEyY4J+glzvXm145zOVM7l67M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jOJNMcHg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jOJNMcHg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785926488; x=1817462488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=53A621aMDW1e4JixPr2oVIEFewwmLBWDjtAB5QHHUf8=;
  b=jOJNMcHgMS4XwqwDHCD7pmWuqQw2hkvlvGTd8s7vWFoWqOh5ksKgo0bd
   1VkyIxmtNf6tpQhK7is2WByDO91bWXMx6kgV9OAcG8ZjXU316HZHveXfX
   Q/44BwmvQWv9LfFwaWlj/bj1OWrnRU1h5yfKUPAI8WlDvG0/7+ZS0NdkF
   CwC3QmVsCJcy5f+bFLqB1TwqA7UtrpWtHk2WeC1jc/2DaoUjw1eDTD8Bz
   6jTp9INvFDlQ+VwE00E+Yd44DEservt1v3HYQ8TWM6VWSCL0K9UVuDsD/
   gWdSoFgb1JswMzzY05yBZTbzzYhyRLjgxuPf+W3zJleLdFnk4yTGjh2n6
   A==;
X-CSE-ConnectionGUID: 3kUMgkvsRiWTF7faLEh65g==
X-CSE-MsgGUID: KdkGDDk0RFmWH08maallpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97143861"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="97143861"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 03:41:28 -0700
X-CSE-ConnectionGUID: MXUpuKn5Qk2vVVfnONgRxA==
X-CSE-MsgGUID: gMuiy0frSsWYdF7zWRdHRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="265278576"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 03:41:26 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Sen Wang <sen@ti.com>
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 5/5] ASoC: tas675x: sort the register default table
Date: Wed,  5 Aug 2026 13:41:49 +0300
Message-ID: <20260805104149.9795-6-peter.ujfalusi@linux.intel.com>
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

TAS675X_AC_LDG_CTRL_REG (0xb5), TAS675X_TWEETER_DETECT_CTRL_REG (0xb6),
TAS675X_TWEETER_DETECT_THRESH_REG (0xb7) and TAS675X_AC_LDG_FREQ_CTRL_REG
(0xb8) are listed before the 0x7c - 0xa0 block, which leaves 14 of the
69 entries unreachable.  regcache_reg_needs_sync() then cannot compare
them against their default and reports that a sync is needed, so they
are written to the device on every regcache_sync() even when they were
never touched.

Sort the table by register address.

Fixes: 133c81f84471 ("ASoC: codecs: Add TAS67524 quad-channel audio amplifier driver")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/tas675x.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/tas675x.c b/sound/soc/codecs/tas675x.c
index 82526362de7b..404706b62156 100644
--- a/sound/soc/codecs/tas675x.c
+++ b/sound/soc/codecs/tas675x.c
@@ -1924,15 +1924,6 @@ static const struct reg_default tas675x_reg_defaults[] = {
 	{ TAS675X_PWM_PHASE_M_CTRL_CH2_REG, 0x00 },
 	{ TAS675X_PWM_PHASE_M_CTRL_CH3_REG, 0x00 },
 	{ TAS675X_PWM_PHASE_M_CTRL_CH4_REG, 0x00 },
-	{ TAS675X_DC_LDG_CTRL_REG,         0x00 },
-	{ TAS675X_DC_LDG_LO_CTRL_REG,      0x00 },
-	{ TAS675X_DC_LDG_TIME_CTRL_REG,    0x00 },
-	{ TAS675X_DC_LDG_SL_CH1_CH2_CTRL_REG, 0x11 },
-	{ TAS675X_DC_LDG_SL_CH3_CH4_CTRL_REG, 0x11 },
-	{ TAS675X_AC_LDG_CTRL_REG,         0x10 },
-	{ TAS675X_TWEETER_DETECT_CTRL_REG, 0x08 },
-	{ TAS675X_TWEETER_DETECT_THRESH_REG, 0x00 },
-	{ TAS675X_AC_LDG_FREQ_CTRL_REG,    0xC8 },
 	{ TAS675X_REPORT_ROUTING_1_REG,    0x00 },
 	{ TAS675X_OTSD_RECOVERY_EN_REG,    0x00 },
 	{ TAS675X_REPORT_ROUTING_2_REG,    0xA2 },
@@ -1943,6 +1934,15 @@ static const struct reg_default tas675x_reg_defaults[] = {
 	{ TAS675X_GPIO1_OUTPUT_SEL_REG,    0x00 },
 	{ TAS675X_GPIO2_OUTPUT_SEL_REG,    0x00 },
 	{ TAS675X_GPIO_CTRL_REG,           TAS675X_GPIO_CTRL_RSTVAL },
+	{ TAS675X_DC_LDG_CTRL_REG,         0x00 },
+	{ TAS675X_DC_LDG_LO_CTRL_REG,      0x00 },
+	{ TAS675X_DC_LDG_TIME_CTRL_REG,    0x00 },
+	{ TAS675X_DC_LDG_SL_CH1_CH2_CTRL_REG, 0x11 },
+	{ TAS675X_DC_LDG_SL_CH3_CH4_CTRL_REG, 0x11 },
+	{ TAS675X_AC_LDG_CTRL_REG,         0x10 },
+	{ TAS675X_TWEETER_DETECT_CTRL_REG, 0x08 },
+	{ TAS675X_TWEETER_DETECT_THRESH_REG, 0x00 },
+	{ TAS675X_AC_LDG_FREQ_CTRL_REG,    0xC8 },
 	{ TAS675X_OTW_CTRL_CH1_CH2_REG,    0x11 },
 	{ TAS675X_OTW_CTRL_CH3_CH4_REG,    0x11 },
 };
-- 
2.55.0

