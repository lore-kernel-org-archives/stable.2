Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4451E42E8D6;
	Tue, 11 Aug 2026 22:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786486529; cv=none; b=tCnQGWG6knNS514YtiPr3awoY/AwpLHALHf19M8BbrEFQWr7Ps4OFmhWkfmDI7LfyD2LVmX+lseCyBawNu9bPhLg7s8z0ztbIkH4QpKL6cAt9AZ7fNZTisrOPDudBEOZjiVmIqLF4xjEkSlXE7N66tZK/Wy5otLrCdt7ialXX/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786486529; c=relaxed/simple;
	bh=wen2TTivPfcuzyaIwp4PjkL8MEdm4AHGvn+e9kYX3Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfgaCYLIbSZM4Cu33adYIDFdqQsX5WJeH578QHrNPjCwolTXUMmaa09vYPolznhTHAkrHk6J4F1o8rs2cgRsIt0cuPXRXPiqXyjTbz08qGIiGMCHhO1r2/bCiqAuAJxO8mQSsP0HQ+oBIqoMoJWJqosKVp7hKzcgErqsLrwooNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mEP1EKO4; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mEP1EKO4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786486528; x=1818022528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wen2TTivPfcuzyaIwp4PjkL8MEdm4AHGvn+e9kYX3Mw=;
  b=mEP1EKO4NpYBrv6gWu/r55H4+eMEZjFFeu19IuuoBX3x/lImvTEl6I+D
   mCNuRN55XS9Y7aaRtDUULyY+DffaLWVE0iPWz217nrsaaF0xhgFEZuqls
   Yx10pAmAR+WOOfAH+WzrzQbxKFSLJwxGQOIq7xikLlISmlX4M3bPtv0OV
   ArwNJYq3PtQh2ZTGYD6E5oidILLf8FXFBU4plXe+8gqkThieEyiJatwxD
   UuhvkETt5/DyTJ8ioolmLKDu9+sTQ7rorbe8Qq35BJ6FSB+yRFoOXzN3s
   gpxSZH2vCSUG2dZeeTl22MXrMjw3GUCGKnOHLOjwzjwxg0cJ4CHdwcLsK
   w==;
X-CSE-ConnectionGUID: 30IskS8bT52TCQGBplw11Q==
X-CSE-MsgGUID: y5BHxSbXSK2hdjsFfStfJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97374785"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="97374785"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 15:15:25 -0700
X-CSE-ConnectionGUID: yvnZYH9BQdWYUqQp9YGLbQ==
X-CSE-MsgGUID: GGDcIW//S1SAM4ReIn613w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="262138182"
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
Subject: [PATCH 3/6] platform/x86: ISST: Validate parameter for core power state
Date: Tue, 11 Aug 2026 15:15:11 -0700
Message-ID: <20260811221514.3905817-4-srinivas.pandruvada@linux.intel.com>
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

Allow only 0 or 1 for core_power enable and priority_type parameters.

Fixes: 12a7d2cb811d ("platform/x86: ISST: Add SST-CP support via TPMI")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../platform/x86/intel/speed_select_if/isst_tpmi_core.c    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 7be50d4167be..8f63694da897 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -599,6 +599,9 @@ static bool disable_dynamic_sst_features(void)
 #define SST_CP_PRIORITY_TYPE_START	1
 #define SST_CP_PRIORITY_TYPE_WIDTH	1
 
+#define SST_CP_MAX_ENABLE		1
+#define SST_CP_MAX_PRIORITY_TYPE	1
+
 static long isst_if_core_power_state(void __user *argp)
 {
 	struct tpmi_per_power_domain_info *power_domain_info;
@@ -618,6 +621,10 @@ static long isst_if_core_power_state(void __user *argp)
 		if (power_domain_info->write_blocked || !capable(CAP_SYS_ADMIN))
 			return -EPERM;
 
+		if (core_power.enable > SST_CP_MAX_ENABLE ||
+		    core_power.priority_type > SST_CP_MAX_PRIORITY_TYPE)
+			return -EINVAL;
+
 		_write_cp_info("cp_enable", core_power.enable, SST_CP_CONTROL_OFFSET,
 			       SST_CP_ENABLE_START, SST_CP_ENABLE_WIDTH, SST_MUL_FACTOR_NONE)
 		_write_cp_info("cp_prio_type", core_power.priority_type, SST_CP_CONTROL_OFFSET,
-- 
2.53.0

