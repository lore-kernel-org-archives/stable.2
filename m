Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BD841F5CD;
	Wed,  5 Aug 2026 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926484; cv=none; b=slA8/PUzlpZ7onIUTdBHh4veoh+9bLVmkLeTf6TnESxtg0mHb+4Gviagkbdk2EI6/aNlKQ1W8Uxf/3XHQnPKm97SXYXegFsihM3RdVSjDyYJJI9ggP7vnprecy505g7mM7oFEpcFo2L04i1fDxBf1sgrmxMhbCcj4YI2qitkaCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926484; c=relaxed/simple;
	bh=xfmi5D5p7VaHyafsBV9wbvGfTuG3FAaKnQuzF/uSLsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBUft7zsvfOhAalCtDuqg+iFtTlZ+ZGu4MnODvSFAGZRy/KHCR46f4ntnpmeBll7Sxo67XOvyE4wb97JKhy+dOa/kufFg/t0Nmekz7B1yVpaAbaKbVoVZtOlyvVwQm5Fqnc7eWIGlxNccTPON2+ocS+UygM1WxDKmprCW5OMKj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mH47mX3O; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mH47mX3O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785926483; x=1817462483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xfmi5D5p7VaHyafsBV9wbvGfTuG3FAaKnQuzF/uSLsE=;
  b=mH47mX3O9GR4mJsY641NN5BygZreBsHYC0DiPnwLrfIBu57xPoKtiCP/
   gpt1OrLP/pjwyhKuLTMv3vMjAF4f5ToKQRjlQfh6e42MNF8a6Iaj7Geoi
   rPFn6x5x8p3gyyrlI/IKz6U1269rqh/hd1i1nCQft9ZmVCDVyePwNDeWi
   GgNCH+SB7DPXokwzq17L6uYlczxo7M6eRdt/PScLHy4anJYjff0jbW5GN
   JXWSp9YfnU9C0VAxt+rRBaWdvLCq01rpzx3dRgHyERUeMsJ4qKpt46IgW
   ko2ng/MR37hIUXIIDhaJ3m6rqEDb7QiauloIhV/Y286Vdvzb7rQdfCHUk
   Q==;
X-CSE-ConnectionGUID: S1tB20+pQ5ibumqjxEjQEw==
X-CSE-MsgGUID: Q83ZsmDLRCioagKP8Tpghw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97143836"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="97143836"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 03:41:22 -0700
X-CSE-ConnectionGUID: ZAKy/j0rTWKHha6orr6Y5A==
X-CSE-MsgGUID: zCorZ7G5Tnapzq1L8yrQvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="265278555"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 03:41:20 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Sen Wang <sen@ti.com>
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/5] ASoC: tas2764: sort the register default table
Date: Wed,  5 Aug 2026 13:41:47 +0300
Message-ID: <20260805104149.9795-4-peter.ujfalusi@linux.intel.com>
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

TAS2764_DVC (0x1a) is listed before TAS2764_CHNL_0 (0x03), which makes
it unreachable.  regcache_reg_needs_sync() then cannot compare it
against its default and reports that a sync is needed, so it is written
to the device on every regcache_sync() even when it was never touched.

Sort the table by register address.

Fixes: 827ed8a0fa50 ("ASoC: tas2764: Add the driver for the TAS2764")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/tas2764.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index b11b998aa32a..f9c65c9f6d0a 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -897,13 +897,13 @@ static const struct reg_default tas2764_reg_defaults[] = {
 	{ TAS2764_PAGE, 0x00 },
 	{ TAS2764_SW_RST, 0x00 },
 	{ TAS2764_PWR_CTRL, 0x1a },
-	{ TAS2764_DVC, 0x00 },
 	{ TAS2764_CHNL_0, 0x28 },
 	{ TAS2764_TDM_CFG0, 0x09 },
 	{ TAS2764_TDM_CFG1, 0x02 },
 	{ TAS2764_TDM_CFG2, 0x0a },
 	{ TAS2764_TDM_CFG3, 0x10 },
 	{ TAS2764_TDM_CFG5, 0x42 },
+	{ TAS2764_DVC, 0x00 },
 	{ TAS2764_INT_CLK_CFG, 0x19 },
 };
 
-- 
2.55.0

