Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D574847ACFE;
	Tue, 11 Aug 2026 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786486899; cv=none; b=RHZPIeneN083z0IIVg+HpAGf33D57KgxFNjZDlsdQfiGYfo3rh3A5AoSYPNZnTuc5XZ7qRPshhSDxs631nQg7e8r+9VGul7qwWIATYftEZ/1W4yzegJRdPWqV3swIMw3bkftuLLQAKBd7xx3h4424KsWHVW+YwOQXnkI/eBVdEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786486899; c=relaxed/simple;
	bh=zmCJYGCK0lU9UBF6rdg0W2C5quLIfK3VG5UjJFGg0PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5ujsdJWX/zhglEgRUzj9fcGIIGqWsEJaBO9KjoIj4AgPtps6i1TJ3gn2cg6I2IeCX0FuR3pCy8IxIN4DnWNLteeLHu/xmi2Wr2dsdpuEt8azS4KHw4Sbao8z6/1tez4VkW1bwbuTHPzZQ09Tumgr1oYQcXMh/YNb4poQ+obOQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xx1XPVH4; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xx1XPVH4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786486898; x=1818022898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zmCJYGCK0lU9UBF6rdg0W2C5quLIfK3VG5UjJFGg0PI=;
  b=Xx1XPVH4FF4ifNC6MuZVNhg/da+ROgmczHE1gLryVjnXiOENE560gOxx
   tsj7wPsy6yLJgeCHy51gI+v7WRBWzqgMrm54N9GUBSUwirGx15CEceRs2
   uaXahyQ8esQu5jiAx9FlxIByJ/stB3LZrzjFp0I6qu9Y3uNE0pvgmOY2n
   meft9XiEShUxicbNhogDtWIdB3LIff6MSyhMlRAgXIEX7qfb6sQgNE/eb
   nFsB2A80L8lcSvmtr8SMCus8yrDQyei/OssN5qZMtl2Bs5Gkol3M2bs/z
   UB4ygiT2azLAvaRu9XNelOo+mKbgyCfXa2s71VpxVRrBURoE2JpVaMC4R
   g==;
X-CSE-ConnectionGUID: lOnPc9z6SieDCsXlfeYIWw==
X-CSE-MsgGUID: cRrMOrnvSqygygBZKoYxAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87041817"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="87041817"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 15:21:36 -0700
X-CSE-ConnectionGUID: Zkq+YQ0ISsqEl3D21Fry9A==
X-CSE-MsgGUID: YuUKFXWARcSzH3y4/Fpo/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="259189855"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa006.fm.intel.com with ESMTP; 11 Aug 2026 15:21:35 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sammiee5311@gmail.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: ISST: Return error during profile addition
Date: Tue, 11 Aug 2026 15:21:33 -0700
Message-ID: <20260811222134.3912626-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811222134.3912626-1-srinivas.pandruvada@linux.intel.com>
References: <20260811222134.3912626-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If sst_add_perf_profiles() fails for memory allocation, it continues
to allow SST-CP (core-power) feature. But in practice this is not
very useful as to achieve some frequencies via SST-CP, an SST-PP
(perf-profile) level change is required.

Fixes: 0ab147bb840f ("platform/x86: ISST: Parse SST MMIO and update instance")
Cc: HyeongJun An <sammiee5311@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel/speed_select_if/isst_tpmi_core.c         | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index a8c89970993c..68c3a06004eb 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -339,7 +339,7 @@ static int sst_add_perf_profiles(struct auxiliary_device *auxdev,
 	if (!pd_info->perf_levels) {
 		pd_info->pp_header.allowed_level_mask = 0;
 		pd_info->pp_header.level_en_mask = 0;
-		return 0;
+		return -ENOMEM;
 	}
 
 	pd_info->ratio_unit = pd_info->pp_header.ratio_unit;
@@ -370,7 +370,7 @@ static int sst_add_perf_profiles(struct auxiliary_device *auxdev,
 static int sst_main(struct auxiliary_device *auxdev, struct tpmi_per_power_domain_info *pd_info)
 {
 	struct device *dev = &auxdev->dev;
-	int i, mask, levels;
+	int i, ret, mask, levels;
 
 	*((u64 *)&pd_info->sst_header) = readq(pd_info->sst_base);
 	pd_info->sst_header.cp_offset *= 8;
@@ -402,8 +402,12 @@ static int sst_main(struct auxiliary_device *auxdev, struct tpmi_per_power_domai
 			levels = i;
 		mask <<= 1;
 	}
+
+	ret = sst_add_perf_profiles(auxdev, pd_info, levels + 1);
+	if (ret)
+		return ret;
+
 	pd_info->max_level = levels;
-	sst_add_perf_profiles(auxdev, pd_info, levels + 1);
 
 	return 0;
 }
-- 
2.55.0

