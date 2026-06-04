Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2BD30C17E;
	Thu,  4 Jun 2026 05:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780549576; cv=none; b=s02WC0Y6kqbYm3v+D8S1yMHa8Ms0IkYacLETv5Pw+n4kiWdIgCJ61n7L0illZeP8sf853GsbReIAjDUyzTZIpnCNgljN2jWfpIgOQM9kiGnM8gqXX5JUXcKPy2G6Nw4WFmLMKkTfYUwskJbVSSgdIwvmRIclxzS835xy1kHCNxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780549576; c=relaxed/simple;
	bh=l1pxpeAXJEq48i+MwLETzW8tsnYTrq1lRZuD17aSz8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzrhRSH2VOks6UWoWAsQBiVuBMqgv3rBkIkRVR4p8GRnft+V5MOIcQrGgdJA9e2eZbCxtfvSIqimOR8VCmZSYtQFcjL7uM8gC/ynw9+qvjIs3qv0pLxiBApDEvSCHI/EucI17+XMMCx2OoAtUot705QJ5swSsPSTzaAIs2p/t+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Petln7Ip; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Petln7Ip"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780549575; x=1812085575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l1pxpeAXJEq48i+MwLETzW8tsnYTrq1lRZuD17aSz8Q=;
  b=Petln7Ip1IZVkMSC/s7kVryyBhpQDGvKns+/lKNzoOevk1kIcYRYbs9U
   pnlxbI50Tbk7N4H0FfMKY/KwnwyMom0LuELOlJ4Y2uCWJDNvt4ZoFbEWA
   ST8dzmLJyScW0jiDAZXG8I1fmLlvGCvSWvnBiA46bWDmUu021D5ujg2Yx
   ZbA283kPfEsUNmXBWFxjpClY3mW23aYvtAHp5JOb1xwhPHjRTJ5GN5O/X
   PdK3lCPQWqBthEM8WQIxPGLJFOopcgUSKJck2UZt5WWUsyCzpjm4RVRul
   BEAM8JPbqgDcBemRB/LWBoxpEojjWIIL+VsI1OgYaVD33uhYUJXHajpfh
   Q==;
X-CSE-ConnectionGUID: A3ez0wr3SROCo0rXzXr7Ww==
X-CSE-MsgGUID: ixI6/US5Ra65cntIAV6o8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="91943445"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="91943445"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 22:06:14 -0700
X-CSE-ConnectionGUID: heLFom5WRiCGgL11klr0Vw==
X-CSE-MsgGUID: HIOOAphUSDW5Qex+c9FdUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="246266396"
Received: from ktian1-pkvm.sh.intel.com ([10.239.48.205])
  by fmviesa004.fm.intel.com with ESMTP; 03 Jun 2026 22:06:11 -0700
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
Subject: [PATCH 1/9] iommu/vt-d: Fix no_iommu to disable platform optin
Date: Thu,  4 Jun 2026 05:15:32 +0000
Message-ID: <20260604051540.592925-2-kevin.tian@intel.com>
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

If user explicitly requests to disable iommu (via "iommu=off" or
"intel_iommu=off"), there is no reason to force enabling it due
to platform optin (for external-facing devices). User should be
aware of any security implication of doing so.

"intel_iommu=off" implements this policy by setting no_platform_optin
to skip platform optin in platform_optin_force_iommu().

However, "iommu=off" (no_iommu=1) doesn't set no_platform_optin
hence is broken in this aspect:

  - detect_intel_iommu() doesn't request ACS if no_iommu=1
  - platform_optin_force_iommu() forces iommu on if external-facing
    devices exist and no_platform_optin is not set

This leads to a bad configuration with ACS disabled while DMA
remapping is enabled.

Instead of setting no_platform_optin (will soon be removed) for
no_iommu=1, directly check no_iommu in platform_optin_force_iommu().

Fixes: 89a6079df791 ("iommu/vt-d: Force IOMMU on for platform opt in hint")
Cc: stable@vger.kernel.org
Signed-off-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4d0e65bc131d..9584ac0ed02f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2479,10 +2479,11 @@ static bool has_external_pci(void)
 
 static int __init platform_optin_force_iommu(void)
 {
-	if (!dmar_platform_optin() || no_platform_optin || !has_external_pci())
+	if (no_iommu || !dmar_platform_optin() || no_platform_optin ||
+	    !has_external_pci())
 		return 0;
 
-	if (no_iommu || dmar_disabled)
+	if (dmar_disabled)
 		pr_info("Intel-IOMMU force enabled due to platform opt in\n");
 
 	/*
@@ -2493,7 +2494,6 @@ static int __init platform_optin_force_iommu(void)
 		iommu_set_default_passthrough(false);
 
 	dmar_disabled = 0;
-	no_iommu = 0;
 
 	return 1;
 }
-- 
2.43.0

