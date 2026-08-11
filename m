Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8885D47ACFE;
	Tue, 11 Aug 2026 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786486530; cv=none; b=O/JTK8XpwI6DyH8cKU9jZ4EbBRaGLxkg/oWtYnnH42eUsxcLv5kOsZQiPmU3emMigRdlqsbGsovwCQvsgS3AIZ05D8Z05CFQy9IV1jQDZcpq/aI6/G+BPOdbUIO0gMsJOJ5Fb6VSWQDnDlb4onRK9MlyMGE7z/goZKSBJPM5g5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786486530; c=relaxed/simple;
	bh=3VayIqBljY2zj6PG+9CzOp98uansXUhL6licl98H/fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnGWkVZZPINJCMdY7S/lrFSFZqqeW30YfwaLoX5bnn4TLoSO59CTsDEfnVPKF2W896mqHALfIRCkFjbPQI3j9V+hYPOmBIg0KiilDKos0gWqacsIW7jVbi8VPj3MXe5uzibsIzMqwym1JX3Yfq8YKe6AVGWtkxsbsgjpWC5icF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OVSfxtQa; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OVSfxtQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786486529; x=1818022529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3VayIqBljY2zj6PG+9CzOp98uansXUhL6licl98H/fM=;
  b=OVSfxtQaEi75k70hmohfcvEeewMsy3CKNfnw01G05IABcpe19pz8/Wtp
   U6Ju+b2eX4CK7tQvmSSncz5acIR2Lhm/mTxhLnPOe2RiSbZFuNYL75NTq
   yLLhrpCryT0CKxpHiRP5Pl31IkuOJT6O38F0y0xE8U/eYdk/ehOFcpJNB
   SBCAfzhYA7cOsKEy8Xs3kG0DzWOA42uB9IHQHwWILEZQvSPoP4PqW+NcW
   j+WwrVtSJADO08Wow/UbeI+LgQTKHUAw4L6bw4HzG4TT43nT/ukQbxp9p
   dIykMCcEdGRAHeWlfMWPtJ7RBMKgy203W8skAkMoO/j8TgY9n3MvzZXTL
   w==;
X-CSE-ConnectionGUID: XQG77aj3TBGMaeSWTcPPFg==
X-CSE-MsgGUID: qKdzggDCSIi1ZoalJMdjbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97374787"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="97374787"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 15:15:25 -0700
X-CSE-ConnectionGUID: /uC0sc+kRaylmJT5d3Y6wA==
X-CSE-MsgGUID: ke90iEbiTjmx+CrEmrT/sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="262138185"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa010.jf.intel.com with ESMTP; 11 Aug 2026 15:15:25 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sammiee5311@gmail.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 5/6] platform/x86: ISST: Use PP level enable mask
Date: Tue, 11 Aug 2026 15:15:13 -0700
Message-ID: <20260811221514.3905817-6-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811221514.3905817-1-srinivas.pandruvada@linux.intel.com>
References: <20260811221514.3905817-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add check for enabled levels only when reading MMIO. Some levels can be
disabled by BIOS. If the level is not enabled, return an error.

Reset the enable and allowed level masks if there is a failure to add a
perf level.

Fixes: ea009e4769fa3 ("platform/x86: ISST: Add SST-PP support via TPMI")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel/speed_select_if/isst_tpmi_core.c   | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index ee2e1ec1b103..f1b35714a4e9 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -336,8 +336,11 @@ static int sst_add_perf_profiles(struct auxiliary_device *auxdev,
 	int i;
 
 	pd_info->perf_levels = devm_kcalloc(dev, levels, sizeof(struct perf_level), GFP_KERNEL);
-	if (!pd_info->perf_levels)
+	if (!pd_info->perf_levels) {
+		pd_info->pp_header.allowed_level_mask = 0;
+		pd_info->pp_header.level_en_mask = 0;
 		return 0;
+	}
 
 	pd_info->ratio_unit = pd_info->pp_header.ratio_unit;
 	pd_info->avx_levels = SST_MAX_AVX_LEVELS;
@@ -911,7 +914,7 @@ static int isst_if_get_perf_level(void __user *argp)
 		      SST_PP_FEATURE_STATE_START, SST_PP_FEATURE_STATE_WIDTH, SST_MUL_FACTOR_NONE)
 	perf_level.enabled = !!(power_domain_info->sst_header.cap_mask & BIT(1));
 
-	level_mask = perf_level.level_mask;
+	level_mask = perf_level.level_mask & power_domain_info->pp_header.level_en_mask;
 	perf_level.sst_bf_support = 0;
 	for_each_set_bit(level, &level_mask, BITS_PER_BYTE) {
 		/*
@@ -1349,6 +1352,9 @@ static int isst_if_get_base_freq_info(void __user *argp)
 	if (base_freq.level > power_domain_info->max_level)
 		return -EINVAL;
 
+	if (!(power_domain_info->pp_header.level_en_mask & BIT(base_freq.level)))
+		return -EINVAL;
+
 	_read_bf_level_info("p1_high", base_freq.high_base_freq_mhz, base_freq.level,
 			    SST_BF_INFO_0_OFFSET, SST_BF_P1_HIGH_START, SST_BF_P1_HIGH_WIDTH,
 			    SST_MUL_FACTOR_FREQ)
@@ -1388,6 +1394,9 @@ static int isst_if_get_base_freq_mask(void __user *argp)
 	if (cpumask.level > power_domain_info->max_level)
 		return -EINVAL;
 
+	if (!(power_domain_info->pp_header.level_en_mask & BIT(cpumask.level)))
+		return -EINVAL;
+
 	_read_bf_level_info("BF-cpumask", mask, cpumask.level, SST_BF_INFO_1_OFFSET,
 			    P1_HI_CORE_MASK_START, P1_HI_CORE_MASK_WIDTH,
 			    SST_MUL_FACTOR_NONE)
@@ -1483,6 +1492,9 @@ static int isst_if_get_turbo_freq_info(void __user *argp)
 	if (turbo_freq.level > power_domain_info->max_level)
 		return -EINVAL;
 
+	if (!(power_domain_info->pp_header.level_en_mask & BIT(turbo_freq.level)))
+		return -EINVAL;
+
 	turbo_freq.max_buckets = TRL_MAX_BUCKETS;
 	turbo_freq.max_trl_levels = TRL_MAX_LEVELS;
 	turbo_freq.max_clip_freqs = SST_TF_MAX_LP_CLIP_RATIOS;
-- 
2.53.0

