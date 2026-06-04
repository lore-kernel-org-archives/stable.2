Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493463BFAF7;
	Thu,  4 Jun 2026 05:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780549580; cv=none; b=a5Fm78rfLf9INXZU3VC3HhbWxLJZelaQKdsJ5qwRfJDiWsjITI04u5gDd43XF2/TqzIHO+nfMQw8zqSLVoR+6FYR1O7LXCQM8exomz/VqSS/3B/v/pz+BgjEAbovdRSzcBls6lT5S/M9+kv4QE7J6U4dhhAo7tx4EGQpu7VkOaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780549580; c=relaxed/simple;
	bh=2X7FdL3iJviZbY2cMs1TSIGKgzX1YWQLzaeOnV6C59U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAbdZvt6o+vdZ/ldBm9mmFLtvBt+NDUGqdq4TlePrnjB3WvcnSkp3lq0UCboo60nCDdga+f0pvr1EN89cvJY4dRoOfl7pylvnjCm4z63Bv1n6JtOrDwX+/3gRfgvtSTsYRKg/2+aHCRjjVVkpUVDBVuKu/CgY2kM5F0G8eDjfiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwGLz9IG; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwGLz9IG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780549578; x=1812085578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2X7FdL3iJviZbY2cMs1TSIGKgzX1YWQLzaeOnV6C59U=;
  b=CwGLz9IGGWrtGRhTCtOPgKPHnMpXOO0a4vLQVlFpvLXwj0GzJfFGDBBw
   V08O8SHVWxACTax4QSxKYTvT5kPJwhF598nXhF9tZ1VIubGXCFPSQOZ9j
   y+pBMbPhK2gT61NPtPOdOQ1HsLhICS3cYdg/CsSHrqDyy1vKFXULFEUyP
   nSPtQZu5fKyYzFF+ILRfgSsZAuz7gxE3K+PCuLgUPZTvDYPK4GNyxVV8L
   BuypR+zcQYsXHOBEfALH1OevmnytQVUR6FWv6cfNDSKJhtYfTeXjJQJyu
   ppiLIpNfGrTTX4Y4kJ6yO2XunQp1BVaYoEoDkOsJJM0TV7pdWyku9Izg6
   A==;
X-CSE-ConnectionGUID: IYGVfhxwQPGfdEJIleZ5bw==
X-CSE-MsgGUID: 3QhlQlMIRlida0/Ly4AKHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="91943458"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="91943458"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 22:06:17 -0700
X-CSE-ConnectionGUID: +nCjJ2P+RuWmSECo3xtRzw==
X-CSE-MsgGUID: Emlvv+e4QRKTRExI3169mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="246266420"
Received: from ktian1-pkvm.sh.intel.com ([10.239.48.205])
  by fmviesa004.fm.intel.com with ESMTP; 03 Jun 2026 22:06:14 -0700
From: Kevin Tian <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Chris Wright <chrisw@sous-sol.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Asit Mallick <asit.k.mallick@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/9] iommu/vt-d: Force requesting ACS when tboot is enabled
Date: Thu,  4 Jun 2026 05:15:33 +0000
Message-ID: <20260604051540.592925-3-kevin.tian@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604051540.592925-1-kevin.tian@intel.com>
References: <20260604051540.592925-1-kevin.tian@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the conditions of requesting ACS in detect_intel_iommu()
don't include tboot, leading to a possible misconfiguration with ACS
disabled (e.g. due to user opts) while iommu is later forced on by
tboot_force_iommu().

Fix it by checking tboot in detect_intel_iommu().

Fixes: 5d990b627537 ("PCI: add pci_request_acs")
Cc: stable@vger.kernel.org
Signed-off-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/dmar.c  | 15 +++++++++++++--
 drivers/iommu/intel/iommu.c |  2 +-
 drivers/iommu/intel/iommu.h |  2 ++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index d33c119a935e..e8f01e56cf46 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -915,6 +915,18 @@ dmar_validate_one_drhd(struct acpi_dmar_header *entry, void *arg)
 	return 0;
 }
 
+static bool dmar_required(void)
+{
+	/* tboot supersedes any user/platform opt */
+	if (!intel_iommu_tboot_noforce && tboot_enabled())
+		return true;
+
+	if (!no_iommu && (!dmar_disabled || dmar_platform_optin()))
+		return true;
+
+	return false;
+}
+
 void __init detect_intel_iommu(void)
 {
 	int ret;
@@ -928,8 +940,7 @@ void __init detect_intel_iommu(void)
 	if (!ret)
 		ret = dmar_walk_dmar_table((struct acpi_table_dmar *)dmar_tbl,
 					   &validate_drhd_cb);
-	if (!ret && !no_iommu && !iommu_detected &&
-	    (!dmar_disabled || dmar_platform_optin())) {
+	if (!ret && !iommu_detected && dmar_required()) {
 		iommu_detected = 1;
 		/* Make sure ACS will be enabled */
 		pci_request_acs();
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9584ac0ed02f..0365ff4e5092 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -57,7 +57,7 @@ static int rwbf_quirk;
  * (used when kernel is launched w/ TXT)
  */
 static int force_on = 0;
-static int intel_iommu_tboot_noforce;
+int intel_iommu_tboot_noforce;
 static int no_platform_optin;
 
 #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index ef145560aa98..e0ac9efa1aa9 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1343,6 +1343,7 @@ static inline bool ecmd_has_pmu_essential(struct intel_iommu *iommu)
 
 extern int dmar_disabled;
 extern int intel_iommu_enabled;
+extern int intel_iommu_tboot_noforce;
 #else
 static inline int iommu_calculate_agaw(struct intel_iommu *iommu)
 {
@@ -1355,6 +1356,7 @@ static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
 #define dmar_disabled	(1)
 #define intel_iommu_enabled (0)
 #define intel_iommu_sm (0)
+#define intel_iommu_tboot_noforce (0)
 #endif
 
 static inline const char *decode_prq_descriptor(char *str, size_t size,
-- 
2.43.0

