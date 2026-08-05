Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D12459AD0;
	Wed,  5 Aug 2026 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932859; cv=none; b=vDm/cSSk3cRnsY0nGMBLB9GFT/1XIrEtKVlaFDEnmJF6mnaWDlewHyc5EjO3madp4eVn+QDdrcRewl9YjSZrvOt+nHb43u7w/QWX9y/zajorq14yYQxY/soxH99bWM29W6bs92n9op07cBFrp/BwO5CwHapuo5CxyO/6ogcb1jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932859; c=relaxed/simple;
	bh=/act6ID0cMO1CjVO2bvQ7S/ahRdEXxB1cKj+E394yzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWyOzDWKClgW59xhpvuaQ5XdIJllSJnSYi9mMOU7XhHaYjmFfsZmHioUfCWi7SbON00ePsJDm24F8CXv6zPxWm9+8ncS2m4Hz0ucPOH3ECix9mwjzopKHBtSXIFf6HmW0+AUTyY8zgNWA4fp1kUFq0j8AfUM63K0Ynbl/v5ho1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/zOalGx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/zOalGx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785932858; x=1817468858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/act6ID0cMO1CjVO2bvQ7S/ahRdEXxB1cKj+E394yzI=;
  b=U/zOalGx7LOWwumyoz4f1vpBk64a6gmvPGuzIsCuXbDS7lxADoU6yiQB
   M54TvrQZKE2DxOCJJzDOFKPUGR+xLThudCZp4RETLpamzVmI27at1cw3D
   0iOhYSVKINrIhvWKWhm/BGlNHTx+OLjC5sEfC+v29KlPVhZtiejfchVDI
   lLxi6XFpaXVqfSRcty8fYWoVeMq/kSrLI7WGaecoDzBVHaUIbmH5skC3o
   p3uvOB127dIQqYAMCy4AYHgvD6FH7uzNhDRBT2ODxlGX6v7YiWk0CMV/5
   5eGamwC5dbAXYzYWzzfc6kbqIGRDqWto2juBwFh+yRDIclL13+LrfvMGo
   A==;
X-CSE-ConnectionGUID: PKDHDmJcS0aXFENQOkOYEg==
X-CSE-MsgGUID: pCwerKU+SOy09pYWHVz6fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97098744"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="97098744"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:27:19 -0700
X-CSE-ConnectionGUID: 0E2S1auAT0CUlIjaoLuq/A==
X-CSE-MsgGUID: 6QcRFmBcRaaVPS8DIm5kzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="265296131"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:27:16 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sheetal <sheetal@nvidia.com>
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/3] ASoC: tegra210_i2s: sort the Tegra264 register default table
Date: Wed,  5 Aug 2026 15:27:47 +0300
Message-ID: <20260805122748.13090-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805122748.13090-1-peter.ujfalusi@linux.intel.com>
References: <20260805122748.13090-1-peter.ujfalusi@linux.intel.com>
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

TEGRA264_I2S_ENABLE (0x100), TEGRA264_I2S_RX_FIFO_WR_ACCESS_MODE (0x30)
and TEGRA264_I2S_TX_FIFO_RD_ACCESS_MODE (0xb0) are listed at the end of
the table, after TEGRA264_I2S_TIMING (0x130), which leaves 4 of the 9
entries unreachable.  regcache_reg_needs_sync() then cannot compare them
against their default and reports that a sync is needed, so they are
written to the device on every regcache_sync() even when they were never
touched.

Sort the table by register address.

Fixes: b3354438d898 ("ASoC: tegra: I2S: Add Tegra264 support")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/tegra/tegra210_i2s.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/tegra/tegra210_i2s.c b/sound/soc/tegra/tegra210_i2s.c
index fd49d2d6ee49..e4d11518ff01 100644
--- a/sound/soc/tegra/tegra210_i2s.c
+++ b/sound/soc/tegra/tegra210_i2s.c
@@ -38,13 +38,13 @@ static const struct reg_default tegra210_i2s_reg_defaults[] = {
 static const struct reg_default tegra264_i2s_reg_defaults[] = {
 	{ TEGRA210_I2S_RX_INT_MASK, 0x00000003 },
 	{ TEGRA210_I2S_RX_CIF_CTRL, 0x00003f00 },
+	{ TEGRA264_I2S_RX_FIFO_WR_ACCESS_MODE, 0x1 },
 	{ TEGRA264_I2S_TX_INT_MASK, 0x00000003 },
 	{ TEGRA264_I2S_TX_CIF_CTRL, 0x00003f00 },
+	{ TEGRA264_I2S_TX_FIFO_RD_ACCESS_MODE, 0x1 },
+	{ TEGRA264_I2S_ENABLE, 0x1 },
 	{ TEGRA264_I2S_CG, 0x1 },
 	{ TEGRA264_I2S_TIMING, 0x0000001f },
-	{ TEGRA264_I2S_ENABLE, 0x1 },
-	{ TEGRA264_I2S_RX_FIFO_WR_ACCESS_MODE, 0x1 },
-	{ TEGRA264_I2S_TX_FIFO_RD_ACCESS_MODE, 0x1 },
 };
 
 static void tegra210_i2s_set_slot_ctrl(struct tegra210_i2s *i2s,
-- 
2.55.0

