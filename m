Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12C541DDE6;
	Wed,  5 Aug 2026 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926482; cv=none; b=bIWJIb6cNaZEdsBBPRRcC+nF3YD3JXggaBiGu4CegN7sBO9CN46XXBZTptn0gCYyqYaMkEQPM9cj2QUr7fH6S7rppzriJicOSRs9nuM/oElsS8j+Rbb7OsMPuR3EFC0kLDsgdgAlj13T8AA8AlLWnMluS0pEpbyVF60lADPS+9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926482; c=relaxed/simple;
	bh=pFkIgRskdPI3aFANfgs4ldaon5DyqzMuhfXuAcbdtEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0F3pFsTi+ozz9fqPfdevVnyxjmCoNQfcuKwtMoCwUGlf+dH6yA+34cvO+RFVM5ND9cbGtfhidliJJ+6vlNf+SNZlnLVrRhnK3KX8OciauF8R4B0UWu0R5DGDxCbgexWLzHif9v1TeSFO45wYbeBMcj9RwMuEVxgkV297P598O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CphGIVw4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CphGIVw4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785926481; x=1817462481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pFkIgRskdPI3aFANfgs4ldaon5DyqzMuhfXuAcbdtEU=;
  b=CphGIVw4v/6hiuG5YN+2gQypTHdH1shyj32mVI9dYhuV0F0SC65QgaIR
   grqkjjzGQKDuYVSyPoHAFK6W5RpAhpa8SZiCFSgL91krvVey+XuZA6YBG
   lfcF2/fvqO3G6s6Aa3ZbWVSDK/se/G6Op8Mra5CYVZKKOj3zNPrkqzA/e
   LdBKo3hs3uJorMRD/AAGY1r11m+zwEoARElmyi+mc5g0vpEPpihbIH1Mi
   +fGWyOoOXIzTQ01qVf3mMERrO2T8Rcoeo9dTT5OTr6cEPKJEffQ7Xktn7
   x4iFp+IuNhL/2+CBhMpIDvijQ6+1Num3X7F3rgpChQMkfljskWWQSnhPt
   w==;
X-CSE-ConnectionGUID: Ic5hJRzyRF6TYVuqGrNYZg==
X-CSE-MsgGUID: ee60rAYHRCyU8eDuXYln5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97143825"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="97143825"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 03:41:20 -0700
X-CSE-ConnectionGUID: b8Z0+X2xQTGzk0N+IB5W2Q==
X-CSE-MsgGUID: BK7lhrnhQGGBW3ITQKGu1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="265278543"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 03:41:18 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Sen Wang <sen@ti.com>
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/5] ASoC: tas2552: sort the register default table
Date: Wed,  5 Aug 2026 13:41:46 +0300
Message-ID: <20260805104149.9795-3-peter.ujfalusi@linux.intel.com>
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

TAS2552_OUTPUT_DATA (0x07), TAS2552_PDM_CFG (0x11), TAS2552_PGA_GAIN
(0x12) and TAS2552_BOOST_APT_CTRL (0x14) are listed before
TAS2552_RESERVED_0D (0x0d), TAS2552_LIMIT_RATE_HYS (0x0e) and
TAS2552_CFG_2 (0x02), which leaves 7 of the 21 entries unreachable.
regcache_reg_needs_sync() then cannot compare them against their
default and reports that a sync is needed, so they are written to the
device on every regcache_sync() even when they were never touched.

Sort the table by register address.

Fixes: 5df7f71d5cdf ("ASoC: tas2552: Support TI TAS2552 Amplifier")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/tas2552.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 1a7650b9b2a7..ea083d1cec2b 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -31,25 +31,25 @@
 
 static const struct reg_default tas2552_reg_defs[] = {
 	{TAS2552_CFG_1, 0x22},
+	{TAS2552_CFG_2, 0xef},
 	{TAS2552_CFG_3, 0x80},
 	{TAS2552_DOUT, 0x00},
-	{TAS2552_OUTPUT_DATA, 0xc0},
-	{TAS2552_PDM_CFG, 0x01},
-	{TAS2552_PGA_GAIN, 0x00},
-	{TAS2552_BOOST_APT_CTRL, 0x0f},
-	{TAS2552_RESERVED_0D, 0xbe},
-	{TAS2552_LIMIT_RATE_HYS, 0x08},
-	{TAS2552_CFG_2, 0xef},
 	{TAS2552_SER_CTRL_1, 0x00},
 	{TAS2552_SER_CTRL_2, 0x00},
+	{TAS2552_OUTPUT_DATA, 0xc0},
 	{TAS2552_PLL_CTRL_1, 0x10},
 	{TAS2552_PLL_CTRL_2, 0x00},
 	{TAS2552_PLL_CTRL_3, 0x00},
 	{TAS2552_BTIP, 0x8f},
 	{TAS2552_BTS_CTRL, 0x80},
+	{TAS2552_RESERVED_0D, 0xbe},
+	{TAS2552_LIMIT_RATE_HYS, 0x08},
 	{TAS2552_LIMIT_RELEASE, 0x04},
 	{TAS2552_LIMIT_INT_COUNT, 0x00},
+	{TAS2552_PDM_CFG, 0x01},
+	{TAS2552_PGA_GAIN, 0x00},
 	{TAS2552_EDGE_RATE_CTRL, 0x40},
+	{TAS2552_BOOST_APT_CTRL, 0x0f},
 	{TAS2552_VBAT_DATA, 0x00},
 };
 
-- 
2.55.0

