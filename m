Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7396245FFA0;
	Wed,  5 Aug 2026 12:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932860; cv=none; b=TFvyW/hljdWdi2g4rbUJfYQzUDqDfPdlqpO7D6JJo2V6XAptBuaRU099bJsyZYy2wte/CY2hN14yIJUUZl/CYllsL1+s2WFJKdAXcYr9i5Lu9MrRo0c/UgzK6lHPlyXWPbFROSEpVKgKn+gEswhHjmi/G8znmHiDMyWiUDFN5A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932860; c=relaxed/simple;
	bh=NUGNqifI2tWXrWLjYhI8L/MiSRc+OkzBMlhQ+a6LmIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhNBeeNDhmhkw8wwKnY2ZEcxV/PxoDsonoFctxFGx9caTicBH8sGthk6qpzWiY62AULgkVB9zfjj+uuWulJ5GlgeHFfdky3Xn6l/sBUp8fq2MayabgtFErTVel7BDsPw7dfR7QI8O9AZOfLnFs8MJHWxWZKVlvAAcaeTUsYDiSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lLV4u/+F; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lLV4u/+F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785932859; x=1817468859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NUGNqifI2tWXrWLjYhI8L/MiSRc+OkzBMlhQ+a6LmIU=;
  b=lLV4u/+FW4Hl6sZy670YlblY2laEGPC35frJ9LRfLXoUtcxnabVzr9r6
   k/4EfvqjJlbsWbsrmRJndIip0+F6nXf6DA+c6HMids1Ilmu9rUBGeZJue
   vkwJPTGwzcN43hfDFQIRxfKdMziYAljEvobWoJOv+3byReeScb+/raPut
   UgRiF9rNxJZfe0bzEgjpgxK6wm0W3rX3xT128VaR3RiYkMcTwVan3L0zr
   mlYA6gGemsCvKrARlynoZZMuM1aqTxLAzfs9C0kddKUGwi7SReXgASa32
   WgNduMIzyHZXTSyThiC2pIpaR9XCN0+waJU3FAHbHC+IzgDfZ5fON90a6
   w==;
X-CSE-ConnectionGUID: CimSgEdtQkaIVEHNiaSMMg==
X-CSE-MsgGUID: bYgewJiKSCi3JbhnLI+9Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97098754"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="97098754"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:27:20 -0700
X-CSE-ConnectionGUID: fI6gurDPSg+C8MADTbId7A==
X-CSE-MsgGUID: 08AauQcdSFO6dK3EM5ZBBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="265296170"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:27:18 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sheetal <sheetal@nvidia.com>
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/3] ASoC: tegra210_mixer: sort the register default table
Date: Wed,  5 Aug 2026 15:27:48 +0300
Message-ID: <20260805122748.13090-4-peter.ujfalusi@linux.intel.com>
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

TEGRA210_MIXER_ENABLE (0x400) is the last entry of the table, after
TEGRA210_MIXER_PEAKM_RAM_CTRL (0x434), which makes it unreachable.
regcache_reg_needs_sync() then cannot compare it against its default and
reports that a sync is needed, so it is written to the device on every
regcache_sync() even when it was never touched.

Sort the table by register address.

Fixes: 05bb3d5ec64a ("ASoC: tegra: Add Tegra210 based Mixer driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/tegra/tegra210_mixer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/tegra/tegra210_mixer.c b/sound/soc/tegra/tegra210_mixer.c
index a69774578d69..8eb4e54b954b 100644
--- a/sound/soc/tegra/tegra210_mixer.c
+++ b/sound/soc/tegra/tegra210_mixer.c
@@ -57,10 +57,10 @@ static const struct reg_default tegra210_mixer_reg_defaults[] = {
 	MIXER_TX_REG_DEFAULTS(3),
 	MIXER_TX_REG_DEFAULTS(4),
 
+	{ TEGRA210_MIXER_ENABLE, 0x1 },
 	{ TEGRA210_MIXER_CG, 0x00000001},
 	{ TEGRA210_MIXER_GAIN_CFG_RAM_CTRL, 0x00004000},
 	{ TEGRA210_MIXER_PEAKM_RAM_CTRL, 0x00004000},
-	{ TEGRA210_MIXER_ENABLE, 0x1 },
 };
 
 /* Default gain parameters */
-- 
2.55.0

