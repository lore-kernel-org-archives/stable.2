Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3EA47DF96;
	Tue, 11 Aug 2026 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786486531; cv=none; b=dJ9N+KEbzzOZj98CXFTU+EKUYe9jKamxVWKMPxGJaYknK80c6TScbbls1uMKXNBc5ZaRCBLsW19MYzPo/+aMt8hneIL51ebxdHwXxFos9fTb0RfcqIXr8Kf5jGAnHx7FBZDOSPiik1q47uwSjydv88aUHh2iYn8/2lm9WpFqxUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786486531; c=relaxed/simple;
	bh=8rWtIV+KldI7q1gwI6b9bqnvu64L5LHL1O5zKnundec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n90BaIvDFIISUjnJsNDjD/ow/hvUS7JrWPjvsF67RIFj9Elk/Lnh+bvPOIVpFV3fTZxabgt83vpWBnrOy4WP7T2ASTLiFm8ocD/dS39UYhgtzkdyQ0nUbSR7i1MVJtfiieeLbaHm01negdILJ3mC7izpr/WNfn6tIvwpaudWpvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CADKoyJk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CADKoyJk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786486529; x=1818022529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8rWtIV+KldI7q1gwI6b9bqnvu64L5LHL1O5zKnundec=;
  b=CADKoyJkxZqTJYZRlIOR2pm4S8GECE/nkXooJtIlbOp0k2k1tjjhj+X7
   K+hY6UDn6NDE7n5JnFOM/2Ewyjs1eN7DFUVivTXMmzt1ZtOByXjZYf6NF
   qadsp16/BKoIL96zX0DWq2oEYdUKyll+cMZfBWqPECgrUD2UucyQGsLsD
   HSD8y1wpTDUYUlrMQPKczDMMJXNomp9kOBK8ENVfwaVgqi5SmYls6m1ZR
   sZS05TFSkeUI/3BmVGOILlWBOrbbezGIZ+3T14dCHhuprS8pPUJWEGQK/
   yStMStKnJhT7JZlqFwzQWlNXKcy8zJzfG8Ect+DZ99nAOqtHphij9c8+v
   A==;
X-CSE-ConnectionGUID: ycYZEiC1ToWIC19+2vQEeg==
X-CSE-MsgGUID: 84ORPb9sQ+uvt+YdigUWBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97374790"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="97374790"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 15:15:25 -0700
X-CSE-ConnectionGUID: GrvKTo82SROrSmoYyqqdHg==
X-CSE-MsgGUID: Pa7Yk7/pSpykWwl8Wo6m1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="262138186"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa010.jf.intel.com with ESMTP; 11 Aug 2026 15:15:26 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sammiee5311@gmail.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 6/6] platform/x86: ISST: Just allow 2 bits for SST feature enable
Date: Tue, 11 Aug 2026 15:15:14 -0700
Message-ID: <20260811221514.3905817-7-srinivas.pandruvada@linux.intel.com>
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

Currently only 2 features SST-TF and SST-BF are supported, so only allow
bit 0 and bit 1.

Fixes: ea009e4769fa3 ("platform/x86: ISST: Add SST-PP support via TPMI")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index f1b35714a4e9..92d420e706f6 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -882,6 +882,7 @@ static long isst_if_clos_assoc(void __user *argp)
 
 #define SST_PP_FEATURE_STATE_START	8
 #define SST_PP_FEATURE_STATE_WIDTH	8
+#define SST_PP_FEATURE_STATE_VALID_MASK	GENMASK(1, 0)
 
 #define SST_BF_FEATURE_SUPPORTED_START	12
 #define SST_BF_FEATURE_SUPPORTED_WIDTH	1
@@ -1035,6 +1036,9 @@ static int isst_if_set_perf_feature(void __user *argp)
 	if (power_domain_info->write_blocked || !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (perf_feature.feature & ~SST_PP_FEATURE_STATE_VALID_MASK)
+		return -EINVAL;
+
 	_write_pp_info("perf_feature", perf_feature.feature, SST_PP_CONTROL_OFFSET,
 		       SST_PP_FEATURE_STATE_START, SST_PP_FEATURE_STATE_WIDTH,
 		       SST_MUL_FACTOR_NONE)
-- 
2.53.0

