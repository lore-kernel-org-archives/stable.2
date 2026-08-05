Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED1D2C1595;
	Wed,  5 Aug 2026 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921190; cv=none; b=HtInGJhkcu73kdhzliCQGRpdM2Ir/btUf6ATAG2ADIHTUXibRvuBOyqlu9yEe6S6QAdScppJmCzSA3lUnNDw3aKBpQyQai2Niow87yFwAvcAJlMQ5CdqOX3Hx1r9v66fsoKe47TpW7kaKg6ojtgqDbm2TQX27kfsV7q121JZKtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921190; c=relaxed/simple;
	bh=DlKkKC2MzUCteczgy++7HvHByMaR/H2COWnu4WQvTMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLwCIHwU4YkBP9f1nuK/ZQKhKpmvC549H7bp7epzrA0dbNU5XP60LMaqX9xXbUi5U8ymDZZhvIJQE8NOn8/ya66MYIiPei85R4zz/SST6D3hddj7DAc1ZukxSghnv2dhmiseGd7/GS8gfw3K7fnB15XrVBF+k9BXDpKb5/0mdIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fm3qWo4F; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fm3qWo4F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785921189; x=1817457189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DlKkKC2MzUCteczgy++7HvHByMaR/H2COWnu4WQvTMU=;
  b=Fm3qWo4FsE5k+miO4HsrGW2knnPHY6E9JRWynEWza7HLMn00P+xW1MuK
   5bKxsFcqsOGiD3nTO3CiCC3Qs79Mq9LizIDVTj7xE8Jd5oQJqUOe5Wche
   8ulWxQZO0fYiOsB8Ma+Ft+tAVXjwIsq6+AruvxfhTkV4ev78rag+4yeMG
   aMHM2pt1qLswYTL7mcKemPR3eDG86A+mCtVr+r6GYrhdI4nlsS61lG+Cl
   MWAWYVVrXeAcyx+qzwWzTpjwKXPQUzl9C2KRXxVbUmQG/SLecOTJO3sM+
   v7xP2ceLVG+9QWQ/NB4Dg3fmtDeeDmU8iE00P6eQWk25AlYFkMgWsu0U2
   A==;
X-CSE-ConnectionGUID: NVmJS2IcSfa6aMgziW/aUQ==
X-CSE-MsgGUID: 8hpKcTRGRQqUnEaf9mMdgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86260669"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="86260669"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:13:05 -0700
X-CSE-ConnectionGUID: dLxWoZvCQ16R32XWPmZyoA==
X-CSE-MsgGUID: t02PTo8UTVGKQBZPaQenxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="259993264"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:12:54 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Sen Wang <sen@ti.com>,
	Niranjan H Y <niranjan.hy@ti.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ASoC: tas2783-sdw: sort the register default table
Date: Wed,  5 Aug 2026 12:13:27 +0300
Message-ID: <20260805091327.23944-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805091327.23944-1-peter.ujfalusi@linux.intel.com>
References: <20260805091327.23944-1-peter.ujfalusi@linux.intel.com>
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

tas2783_reg_default[] is grouped by SDCA entity name instead, so the
binary search does not find 120 of its 196 entries.
regcache_reg_needs_sync() then cannot compare those against their default
and reports that a sync is needed, so they are written to the device on
every regcache_sync() even when they were never touched.

Sort the table by register address.

Fixes: 4cc9bd8d7b32 ("ASoc: tas2783A: Add soundwire based codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/tas2783-sdw.c | 170 ++++++++++++++++-----------------
 1 file changed, 85 insertions(+), 85 deletions(-)

diff --git a/sound/soc/codecs/tas2783-sdw.c b/sound/soc/codecs/tas2783-sdw.c
index c520251cc3be..e5d27266370e 100644
--- a/sound/soc/codecs/tas2783-sdw.c
+++ b/sound/soc/codecs/tas2783-sdw.c
@@ -141,6 +141,7 @@ static const struct reg_default tas2783_reg_default[] = {
 	{TASDEV_REG_SDW(0, 0, 0x41), 0x14},
 	{TASDEV_REG_SDW(0, 0, 0x5c), 0x19},
 	{TASDEV_REG_SDW(0, 0, 0x5d), 0x80},
+	{TASDEV_REG_SDW(0, 0, 0x60), 0x21},
 	{TASDEV_REG_SDW(0, 0, 0x63), 0x48},
 	{TASDEV_REG_SDW(0, 0, 0x65), 0x08},
 	{TASDEV_REG_SDW(0, 0, 0x66), 0xb2},
@@ -156,7 +157,6 @@ static const struct reg_default tas2783_reg_default[] = {
 	{TASDEV_REG_SDW(0, 0, 0x73), 0x08},
 	{TASDEV_REG_SDW(0, 0, 0x75), 0xe0},
 	{TASDEV_REG_SDW(0, 0, 0x7a), 0x60},
-	{TASDEV_REG_SDW(0, 0, 0x60), 0x21},
 	{TASDEV_REG_SDW(0, 1, 0x02), 0x00},
 	{TASDEV_REG_SDW(0, 1, 0x17), 0xc0},
 	{TASDEV_REG_SDW(0, 1, 0x19), 0x60},
@@ -175,63 +175,44 @@ static const struct reg_default tas2783_reg_default[] = {
 	{TASDEV_REG_SDW(0, 0xfd, 0x39), 0x00},
 	{TASDEV_REG_SDW(0, 0xfd, 0x3e), 0x00},
 	{TASDEV_REG_SDW(0, 0xfd, 0x45), 0x00},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_CS21, 0x02, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_CS21, 0x10, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_CS24, 0x02, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_CS24, 0x10, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_CS26, 0x02, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_CS26, 0x10, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_CS28, 0x02, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_CS28, 0x10, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_CS127, 0x02, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_CS127, 0x10, 0), 0x0},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU21, 0x01, 1), 0x1},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU21, 0x02, 1), 0x9c00},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU23, 0x01, 0), 0x1},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU23, 0x01, 1), 0x1},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU23, 0x0b, 1), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU23, 0x10, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU26, 0x01, 1), 0x1},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU26, 0x01, 0), 0x1},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU26, 0x01, 1), 0x1},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU26, 0x0b, 1), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU26, 0x10, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU127, 0x01, 0), 0x1},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU127, 0x01, 1), 0x1},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU127, 0x01, 2), 0x1},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU127, 0x0b, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU127, 0x0b, 1), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU127, 0x0b, 2), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU127, 0x10, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x01, 0), 0x1},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x06, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x07, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x08, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x09, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x0a, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_CS24, 0x02, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_CS21, 0x02, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_CS26, 0x02, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_CS28, 0x02, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_PDE23, 0x1, 0), 0x3},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_SAPU29, 0x05, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_PPU21, 0x06, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_PPU26, 0x06, 0), 0x0},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT21, 0x04, 0), 0x0},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT21, 0x08, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT21, 0x10, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT21, 0x11, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT29, 0x04, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT29, 0x08, 0), 0x0},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT26, 0x04, 0), 0x0},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT26, 0x08, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT26, 0x10, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT26, 0x11, 0), 0x0},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT28, 0x04, 0), 0x0},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT28, 0x08, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT28, 0x10, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT28, 0x11, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT29, 0x04, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT29, 0x08, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT29, 0x10, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT29, 0x11, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU21, 0x01, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU21, 0x04, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU21, 0x05, 0), 0x1},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU21, 0x08, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU21, 0x10, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU21, 0x11, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU21, 0x12, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU26, 0x01, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU26, 0x04, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU26, 0x05, 0), 0x1},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU26, 0x08, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU26, 0x10, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU26, 0x11, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU26, 0x12, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT24, 0x04, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT24, 0x08, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT23, 0x04, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT23, 0x08, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT25, 0x04, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT25, 0x08, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT28, 0x04, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT28, 0x08, 0), 0x0},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MU26, 0x01, 0), 0x0},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MU26, 0x01, 1), 0x0},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MU26, 0x01, 2), 0x0},
@@ -241,19 +222,60 @@ static const struct reg_default tas2783_reg_default[] = {
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MU26, 0x01, 6), 0x0},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MU26, 0x01, 7), 0x0},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MU26, 0x06, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT23, 0x04, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT23, 0x08, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT24, 0x04, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT24, 0x08, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT127, 0x04, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT127, 0x08, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU127, 0x01, 0), 0x1},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU127, 0x01, 1), 0x1},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU127, 0x01, 2), 0x1},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU127, 0x0b, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU127, 0x0b, 1), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU127, 0x0b, 2), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_CS127, 0x02, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU21, 0x01, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU21, 0x04, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU21, 0x05, 0), 0x1},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU21, 0x08, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU26, 0x01, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU26, 0x04, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU26, 0x05, 0), 0x1},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU26, 0x08, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU23, 0x10, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU26, 0x10, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x10, 0), 0x1},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x12, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x13, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x14, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x15, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x16, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_CS24, 0x10, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_CS21, 0x10, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_CS26, 0x10, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_CS28, 0x10, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_PDE23, 0x10, 0), 0x3},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_UDMPU23, 0x10, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_SAPU29, 0x10, 0), 0x1},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_SAPU29, 0x11, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_SAPU29, 0x12, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_PPU21, 0x10, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_PPU21, 0x11, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_PPU21, 0x12, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_PPU21, 0x13, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_PPU26, 0x10, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_PPU26, 0x11, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_PPU26, 0x12, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_PPU26, 0x13, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_TG23, 0x10, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT21, 0x10, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT21, 0x11, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT29, 0x10, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT29, 0x11, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT26, 0x10, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT26, 0x11, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT28, 0x10, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_IT28, 0x11, 0), 0x0},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT24, 0x11, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT25, 0x04, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT25, 0x08, 0), 0x0},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT25, 0x11, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT28, 0x04, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT28, 0x08, 0), 0x0},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT28, 0x11, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT127, 0x04, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT127, 0x08, 0), 0x0},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT127, 0x11, 0), 0x0},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT127, 0x12, 0), 0x0},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT127, 0x12, 1), 0x0},
@@ -263,6 +285,14 @@ static const struct reg_default tas2783_reg_default[] = {
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT127, 0x12, 5), 0x0},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT127, 0x12, 6), 0x0},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT127, 0x12, 7), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU127, 0x10, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_CS127, 0x10, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU21, 0x10, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU21, 0x11, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU21, 0x12, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU26, 0x10, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU26, 0x11, 0), 0x0},
+	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_MFPU26, 0x12, 0), 0x0},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT127, 0x12, 8), 0x0},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT127, 0x12, 9), 0x0},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT127, 0x12, 0xa), 0x0},
@@ -271,36 +301,6 @@ static const struct reg_default tas2783_reg_default[] = {
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT127, 0x12, 0xd), 0x0},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT127, 0x12, 0xe), 0x0},
 	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_OT127, 0x12, 0xf), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_PDE23, 0x1, 0), 0x3},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_PDE23, 0x10, 0), 0x3},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_PPU21, 0x06, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_PPU21, 0x10, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_PPU21, 0x11, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_PPU21, 0x12, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_PPU21, 0x13, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_PPU26, 0x06, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_PPU26, 0x10, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_PPU26, 0x11, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_PPU26, 0x12, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_PPU26, 0x13, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_SAPU29, 0x05, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_SAPU29, 0x10, 0), 0x1},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_SAPU29, 0x11, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_SAPU29, 0x12, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_TG23, 0x10, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x01, 0), 0x1},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x06, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x07, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x08, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x09, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x0a, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x10, 0), 0x1},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x12, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x13, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x14, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x15, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_XU22, 0x16, 0), 0x0},
-	{SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_UDMPU23, 0x10, 0), 0x0},
 };
 
 static const struct reg_sequence tas2783_init_seq[] = {
-- 
2.55.0

