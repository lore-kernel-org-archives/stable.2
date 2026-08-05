Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7388A40BCD4;
	Wed,  5 Aug 2026 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926486; cv=none; b=MuV/4BrJ93uTH0lKhIA6CPOkRD37XRXHyxz/gLdFlXN5hvf6JOfr1+Lfw78sEaCqh8SLR47AbKWQtSIm2Rlj5asZ8z3Hw1phjCDd3A8zBZryBeOkV4JRWXuMIO/G0ozQCqDKudZl7cUr7idROx79R2AJXsO5f14wJ77wHDlrksg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926486; c=relaxed/simple;
	bh=crubzILu3slF7+7jaX/Boh/C5qHv6VKEfZq3MGDUdvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jhhp1NcwJouDgJpkrNxVGCsVyK56/BJkHWvg8POWSz8abWSIwIEIFMw/VHAMEz/VpYI5l9GgK7EBDP+Kg0HLfgGXsusN5Wp4GAJLHO0NHS85ZhPsomjGr8Bo6tKm5x7SMIIhrZw0y7lOhRa3PWMNXoCkXnwIUt2eWZYYjtSW3ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lfuatggf; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lfuatggf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785926485; x=1817462485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=crubzILu3slF7+7jaX/Boh/C5qHv6VKEfZq3MGDUdvA=;
  b=LfuatggfVz6FJleRbGMk7UHYAcbA0rVbHJEuwFdmT3gHRePR6z4eRYzQ
   bR9cMiYXpzcne4OmHud+hk3f8vjM8s1Uv7WXPh0/gvCEruaUABjsqxtLv
   9I6YrBFsLm6Q71X+1YRNtK5QMclQdoWczQG3MqjZXQ+y619QiaFH7Ny0R
   UWMtRLqnQw3VLf8PRucgPsWfoeKO/lJ1cX5PR0oMhO8V7VAR/JKqArsKj
   pksV1H9aiLTKxOydPEZuRZRlj1NBEIVjBCc1CVyeMBfvWUbXpAhc44nfw
   HhLL7EXgh1Bt+qi2iPRqclve/ybloPEyRX2q9bnoLg4FoUJN09IGmzT7H
   w==;
X-CSE-ConnectionGUID: pGbyNnS8TvebRizAw1hTLw==
X-CSE-MsgGUID: PQptfmeGTWGSWoXBzeAcSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97143853"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="97143853"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 03:41:25 -0700
X-CSE-ConnectionGUID: zlNCyK/CToadS4WdPz9bXw==
X-CSE-MsgGUID: Je0LpmLjQ56DhN7OKrVvtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="265278569"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 03:41:23 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Sen Wang <sen@ti.com>
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 4/5] ASoC: tas2780: sort the register default table
Date: Wed,  5 Aug 2026 13:41:48 +0300
Message-ID: <20260805104149.9795-5-peter.ujfalusi@linux.intel.com>
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

TAS2780_DVC (0x1a) is listed before TAS2780_CHNL_0 (0x03), which makes
it unreachable.  regcache_reg_needs_sync() then cannot compare it
against its default and reports that a sync is needed, so it is written
to the device on every regcache_sync() even when it was never touched.

Sort the table by register address.

Fixes: eae9f9ce181b ("ASoC: add tas2780 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/tas2780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2780.c b/sound/soc/codecs/tas2780.c
index 1ec1c076204f..f1fce4305fa1 100644
--- a/sound/soc/codecs/tas2780.c
+++ b/sound/soc/codecs/tas2780.c
@@ -527,13 +527,13 @@ static const struct reg_default tas2780_reg_defaults[] = {
 	{ TAS2780_PAGE, 0x00 },
 	{ TAS2780_SW_RST, 0x00 },
 	{ TAS2780_PWR_CTRL, 0x1a },
-	{ TAS2780_DVC, 0x00 },
 	{ TAS2780_CHNL_0, 0x00 },
 	{ TAS2780_TDM_CFG0, 0x09 },
 	{ TAS2780_TDM_CFG1, 0x02 },
 	{ TAS2780_TDM_CFG2, 0x0a },
 	{ TAS2780_TDM_CFG3, 0x10 },
 	{ TAS2780_TDM_CFG5, 0x42 },
+	{ TAS2780_DVC, 0x00 },
 };
 
 static const struct regmap_range_cfg tas2780_regmap_ranges[] = {
-- 
2.55.0

