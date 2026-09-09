Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A285678FD
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963286; cv=none; b=eMYr97WbRV3VRzdJVwCz2z9KOzOw4SC7WTj7xkC4gx6gi/AS9eSKuz77Rvmqystrp8cduVViFaHb2BNsn/w61pVPnvTdnNkyaf/fcabghByOSgb0AOsFpOSmgbQvrSSOFyvp00QKcVLdnUxYH2ZkZcyLG6uRoWG3IeZrrvIlGe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963286; c=relaxed/simple;
	bh=g6y/FYhYwTDH3lxfHKMZ428C7tO1ehpjcG/S8xXWnS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5ayoN7sjpEDYtJ8aDMHbP9C390Ln5/F+LSIVImbhx1NBfWPhPVZgUae2Nxy5Ch89Uij+HPICVXfGuU8kC2KSGYzweK5NopBrmQ7lpx04pV163/J3Nokmm0l+L0lYDCfBfv9qbrJpABfJLllK5nqP2BXzFG+ZrJjZwkBTqdWiNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlUvMNdH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlUvMNdH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DA01F00A3D;
	Wed,  9 Sep 2026 14:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963285;
	bh=YnnBMeIqDaaL7fCJcgWj5mH+XAtw01UaQUuJRmwUBLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WlUvMNdHpprn05rMmnM04HubNH5FWB8S8BI5rvklfRzx9h57CpjK/a7pz3ugQDVg/
	 Y4ENxH7uLASfZ0d7wkSecaJNsaXoDi84l6znCOL3kpJy16qD2+9Ce8F2kTwe+xn9ip
	 KD6ACITcoktl6ksDviancakBkAlNXRxBxzojXLSdzxXKGF1W1zRUOfjQFUw2VC9TNU
	 RMs0tB/zTMFi2pRG00BDPxAEXDiuK0CmygaFjkSjZy+VN/K0JscWGY9uXpoP/moNwq
	 UJVma0Thwc7hV70+MFFLXeqnLu8kMYZITAqFHyK5vpfy2nKLWcyUD/x1fwRd/0jbxH
	 eWOkUeaKTwsvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] platform/x86: ISST: Use PP level enable mask
Date: Wed,  9 Sep 2026 10:14:43 -0400
Message-ID: <20260909141443.2392757-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090355-unicorn-work-b00a@gregkh>
References: <2026090355-unicorn-work-b00a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 9b9026943b19d06ebf520b1f4786621947cf43c8 ]

Add check for enabled levels only when reading MMIO. Some levels can be
disabled by BIOS. If the level is not enabled, return an error.

Reset the enable and allowed level masks if there is a failure to add a
perf level.

Fixes: ea009e4769fa3 ("platform/x86: ISST: Add SST-PP support via TPMI")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20260811221514.3905817-6-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[ Adapted per-level BF/TF support checks to the older level-0-only interface. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../intel/speed_select_if/isst_tpmi_core.c    | 33 +++++++++++++++----
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index df0b0118b751f..90cb656e77432 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -316,8 +316,11 @@ static int sst_add_perf_profiles(struct auxiliary_device *auxdev,
 	pd_info->perf_levels = devm_kcalloc(&auxdev->dev, levels,
 					    sizeof(struct perf_level),
 					    GFP_KERNEL);
-	if (!pd_info->perf_levels)
+	if (!pd_info->perf_levels) {
+		pd_info->pp_header.allowed_level_mask = 0;
+		pd_info->pp_header.level_en_mask = 0;
 		return 0;
+	}
 
 	pd_info->ratio_unit = pd_info->pp_header.ratio_unit;
 	pd_info->avx_levels = SST_MAX_AVX_LEVELS;
@@ -714,12 +717,16 @@ static int isst_if_get_perf_level(void __user *argp)
 		      SST_PP_FEATURE_STATE_START, SST_PP_FEATURE_STATE_WIDTH, SST_MUL_FACTOR_NONE)
 	perf_level.enabled = !!(power_domain_info->sst_header.cap_mask & BIT(1));
 
-	_read_bf_level_info("bf_support", perf_level.sst_bf_support, 0, 0,
-			    SST_BF_FEATURE_SUPPORTED_START, SST_BF_FEATURE_SUPPORTED_WIDTH,
-			    SST_MUL_FACTOR_NONE);
-	_read_tf_level_info("tf_support", perf_level.sst_tf_support, 0, 0,
-			    SST_TF_FEATURE_SUPPORTED_START, SST_TF_FEATURE_SUPPORTED_WIDTH,
-			    SST_MUL_FACTOR_NONE);
+	perf_level.sst_bf_support = 0;
+	perf_level.sst_tf_support = 0;
+	if (power_domain_info->pp_header.level_en_mask & BIT(0)) {
+		_read_bf_level_info("bf_support", perf_level.sst_bf_support, 0, 0,
+				    SST_BF_FEATURE_SUPPORTED_START, SST_BF_FEATURE_SUPPORTED_WIDTH,
+				    SST_MUL_FACTOR_NONE);
+		_read_tf_level_info("tf_support", perf_level.sst_tf_support, 0, 0,
+				    SST_TF_FEATURE_SUPPORTED_START, SST_TF_FEATURE_SUPPORTED_WIDTH,
+				    SST_MUL_FACTOR_NONE);
+	}
 
 	if (copy_to_user(argp, &perf_level, sizeof(perf_level)))
 		return -EFAULT;
@@ -1052,6 +1059,9 @@ static int isst_if_get_base_freq_info(void __user *argp)
 	if (base_freq.level > power_domain_info->max_level)
 		return -EINVAL;
 
+	if (!(power_domain_info->pp_header.level_en_mask & BIT(base_freq.level)))
+		return -EINVAL;
+
 	_read_bf_level_info("p1_high", base_freq.high_base_freq_mhz, base_freq.level,
 			    SST_BF_INFO_0_OFFSET, SST_BF_P1_HIGH_START, SST_BF_P1_HIGH_WIDTH,
 			    SST_MUL_FACTOR_FREQ)
@@ -1088,6 +1098,12 @@ static int isst_if_get_base_freq_mask(void __user *argp)
 	if (!power_domain_info)
 		return -EINVAL;
 
+	if (cpumask.level > power_domain_info->max_level)
+		return -EINVAL;
+
+	if (!(power_domain_info->pp_header.level_en_mask & BIT(cpumask.level)))
+		return -EINVAL;
+
 	_read_bf_level_info("BF-cpumask", mask, cpumask.level, SST_BF_INFO_1_OFFSET,
 			    P1_HI_CORE_MASK_START, P1_HI_CORE_MASK_WIDTH,
 			    SST_MUL_FACTOR_NONE)
@@ -1164,6 +1180,9 @@ static int isst_if_get_turbo_freq_info(void __user *argp)
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

