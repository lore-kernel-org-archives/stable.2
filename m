Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659CC293C4E;
	Thu,  2 Jul 2026 06:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972078; cv=none; b=uc5fTms61sOW+us3Evlt0HEdDMwV6yY8mly6vrOwzqxEg6fBr4fa+0dK+iUMLWox/cED80CtXnxuT1snMAaQHQMUUvSPCSbkXSoShx0epf5jeFpxNlCVyA+Ax3d8izGcWj//4gWKLl5M5XsPKjCS7kVdKS/CPXxA+HZaWe5K+qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972078; c=relaxed/simple;
	bh=ITuJxkDofYGJJAVybAwgFTvm9+F2gZ1xcqbGZmAqvv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APYL46vPuxbW1H8SozkaCrixj/IvgEi5aF0qulEoHBRY/IN+xxL8/i6ntFxzfPx+puLrp0RiZTOXbnEy+ULH9RwVyLmQZR9MvcNZxO9BAJ4dSQ3xpMtFJtEdz3BBsMUfyl0Ygy3FT2P1+1l/zoV1z0ePst5Ns1fNWAYohbk49Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jgFGpdJ5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jgFGpdJ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782972076; x=1814508076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ITuJxkDofYGJJAVybAwgFTvm9+F2gZ1xcqbGZmAqvv8=;
  b=jgFGpdJ56m7XPTAVfZJjcZ5hLjWpKjm4Xy3FlCd9Uepr4rlTaSBAsZST
   sEJxEYjCUMV/2lGWA0O89MlRmr/jtdPgFm1fmw+eU6rvPBavEhXPdNRdp
   z5cO8Cl8SwwodhSkKkuiXDbT5yo/jcJWpkredjLTTH9ztlTAAyQ9f8glO
   CfEAVnTu4sX4ye0lD0rUQsoFxI+eiUelYN6sCZH9Adq9Js6rZZN+WB1m8
   bQSJ2QKZM4en6E7oehUWOAlVyYz1UBF5y/y31fjshxJL7mYBOl1BrfoGb
   5jKwP3KkNcQkfVnz+NzN0gDrvKPPKOOTi/EDQDOri8fVDcHZ1POfOhK3Y
   w==;
X-CSE-ConnectionGUID: XHUZeis2QU+4TRvRgm4w/w==
X-CSE-MsgGUID: zOUfwcZzTZKbmCppXu+K7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="101256461"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="101256461"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 23:01:16 -0700
X-CSE-ConnectionGUID: Zp0wHyjeQFeHlIdFmhMl2g==
X-CSE-MsgGUID: oRy5feFkTTiTFVy6krzSOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="253425787"
Received: from ktian1-pkvm.sh.intel.com ([10.239.48.205])
  by orviesa009.jf.intel.com with ESMTP; 01 Jul 2026 23:01:09 -0700
From: Kevin Tian <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Chris Wright <chrisw@sous-sol.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Asit Mallick <asit.k.mallick@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/9] iommu/vt-d: Force requesting ACS when tboot is enabled
Date: Thu,  2 Jul 2026 06:12:09 +0000
Message-ID: <20260702061216.388743-3-kevin.tian@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702061216.388743-1-kevin.tian@intel.com>
References: <20260702061216.388743-1-kevin.tian@intel.com>
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
index 767ec092accd..e32685402f74 100644
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
index 8668565e5781..4e7ba60f3a0a 100644
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
index 775f1c4ae346..2cee36138d6e 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1354,6 +1354,7 @@ static inline bool ecmd_has_pmu_essential(struct intel_iommu *iommu)
 
 extern int dmar_disabled;
 extern int intel_iommu_enabled;
+extern int intel_iommu_tboot_noforce;
 #else
 static inline int iommu_calculate_agaw(struct intel_iommu *iommu)
 {
@@ -1366,6 +1367,7 @@ static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
 #define dmar_disabled	(1)
 #define intel_iommu_enabled (0)
 #define intel_iommu_sm (0)
+#define intel_iommu_tboot_noforce (0)
 #endif
 
 static inline const char *decode_prq_descriptor(char *str, size_t size,
-- 
2.43.0

