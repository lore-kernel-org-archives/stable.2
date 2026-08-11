Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F18A42AFAA;
	Tue, 11 Aug 2026 22:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786486529; cv=none; b=tgizJpYUAyJBcYCUmGWRmNCsSjHjQ9TzNLicZjFhCjA9GWyPxiaUSAL3qHXDrHhmI85flL+HMfUkUtCJTNMjh30Tduuu4oNQgh9jqvL5tIsBjTAcOA+mLn2t1YpfDm7S5fj+SUVy5/HWcoNUfwRInGZrqpTJM56CF8JDglr2lEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786486529; c=relaxed/simple;
	bh=EQNGWRjDj1b6sRCFXqjtjilWqIFb6oKpbleOlJw4/Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xo97WGtJ6wjWGsPH0apt5JQUQ292mGqvMtCiWhst+Ag9AoCfnLATZw1x9czGAvjJSVwmi0UIhNIx/uQ5P+znLZhHPZh4pB4wyIr9QgAIPSg6Spok6Nx03hYeiRIcEN69JPdXOFTOLx1hegtzGamjp0RAoT+VbYjbgVRip5nQSbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bAWT2gFT; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bAWT2gFT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786486528; x=1818022528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EQNGWRjDj1b6sRCFXqjtjilWqIFb6oKpbleOlJw4/Rg=;
  b=bAWT2gFT63TOu+HrFHNIqobiiVZkl9xHU7qUkI56nDOqBbZuPMkS5K3l
   2tk7n3hhoK4fgh82kff/VtPjTBPJfCuO1MFL7+LGvlTnYzRBoD1Cbkha8
   oun9XrXst/yxyZxwzpYNGFbdm9rxa/HU3DgO2BdUzTGqqU8uRDXBBaoZR
   A//tpTjNL7n3saLiOv8QfwDHX+Rs7RnEFw7rITyTgVsapBtHxiorxfK5T
   X7RXIpcV3e4y4c0+tCkgXgwrDASxi8xNvOq6GqjyJ7MOUGlyLE+Opp9KG
   G5ly5+SX5Jvh4k3YZcbVoccW5NCFm+5Pvh0Wk7XODk3PmZNCv1vhsIzhc
   w==;
X-CSE-ConnectionGUID: ezIHY9ZCQTiAewWYQPulAQ==
X-CSE-MsgGUID: Wwma8FQfQn2+Nt5w3Kl5sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97374780"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="97374780"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 15:15:25 -0700
X-CSE-ConnectionGUID: YonjDjBlSiquq8Bos4w29w==
X-CSE-MsgGUID: 36OovBskR7OPDeEoYJza9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="262138184"
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
Subject: [PATCH 4/6] platform/x86: ISST: Validate parameter for frequency and priority
Date: Tue, 11 Aug 2026 15:15:12 -0700
Message-ID: <20260811221514.3905817-5-srinivas.pandruvada@linux.intel.com>
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

Validate range for frequency and proportional priority while setting
CLOS parameters.

Fixes: 12a7d2cb811d ("platform/x86: ISST: Add SST-CP support via TPMI")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel/speed_select_if/isst_tpmi_core.c       | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 8f63694da897..ee2e1ec1b103 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -658,6 +658,9 @@ static long isst_if_core_power_state(void __user *argp)
 
 #define SST_MAX_CLOS			3
 
+#define SST_MAX_FREQ			0xff
+#define SST_CLOS_MAX_PRIORITY		0x0f
+
 static long isst_if_clos_param(void __user *argp)
 {
 	struct tpmi_per_power_domain_info *power_domain_info;
@@ -677,6 +680,15 @@ static long isst_if_clos_param(void __user *argp)
 		if (power_domain_info->write_blocked || !capable(CAP_SYS_ADMIN))
 			return -EPERM;
 
+		if (!in_range(clos_param.min_freq_mhz / SST_MUL_FACTOR_FREQ, 0, SST_MAX_FREQ + 1))
+			return -EINVAL;
+
+		if (!in_range(clos_param.max_freq_mhz / SST_MUL_FACTOR_FREQ, 0, SST_MAX_FREQ + 1))
+			return -EINVAL;
+
+		if (!in_range(clos_param.prop_prio, 0, SST_CLOS_MAX_PRIORITY + 1))
+			return -EINVAL;
+
 		_write_cp_info("clos.min_freq", clos_param.min_freq_mhz,
 			       (SST_CLOS_CONFIG_0_OFFSET + clos_param.clos * SST_REG_SIZE),
 			       SST_CLOS_CONFIG_MIN_START, SST_CLOS_CONFIG_MIN_WIDTH,
-- 
2.53.0

