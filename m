Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1C045BE3;
	Thu,  2 Jul 2026 06:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972075; cv=none; b=un/w/Atb1PitHUCTO0wjZUrXFfTumEmiNE2l80OJpbvMCRT/WiJSNzQGOILEDoMsmoXxPusS1tr4K/pq3sSwfkdkmx6+kR7swVJvekqV3fpZnoEiG1eRazYmd/VcNg9bqI9LqTrvvg/3moMO3eRImKjiTeOSwKlwZvJ665u3kOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972075; c=relaxed/simple;
	bh=q2Wgw43RZbcIRFK1NOke6KeNW5aJCGqACPvZsSZ61n4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vvs1VuIlq55hrFPiNX8K8toSFhEVxNlf7WXvtu8v4JMMXL+a2iDD62VKrLaX2y0TGmjA4czsB980NkJlNdqDDG4VR1a6qb+gZWdn1SC78m2CpkGQSYF44kQ6LGY4uD2TNinPx5tf44OJJEeMrGBWm7/o6nrfkCcG9iSGNv3JBcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZQWCpjbI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQWCpjbI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782972073; x=1814508073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q2Wgw43RZbcIRFK1NOke6KeNW5aJCGqACPvZsSZ61n4=;
  b=ZQWCpjbIvNAKZ3iZPDbg+/dkQhz0viPvZMTvhgk11x/f0ML7nZ85ko0W
   C72+8ROieFqWSGZTUmHY2O2z5Oe5F7tGH0KfmL500XmyCG+qsj9bde7Td
   wWngsmcYGTWMI7HLeKivCGHwfCABPNz+O6mKbm/lRZOPGsG2s6YwR2uKr
   Z9U8ZsuKHbH6FtmtHWXj18EDPoisw/715BCjvlFjh+pMZ9tJ9jaj5a5+3
   ofSYrgnEoacPG9jyF1dHSIh75Np1JqcwU8h1nyMfKwpDTEwZGayStCd39
   7YcLX2Er/gXPYSqEK1pk4yMhfJkI6sOfl/+wX0eS6stC7TZjxlWmJtfO3
   g==;
X-CSE-ConnectionGUID: XHKt7JGnS/iTBDMMnCu/oQ==
X-CSE-MsgGUID: KuqaZY5HToSK9zH80xolew==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="101256452"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="101256452"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 23:01:13 -0700
X-CSE-ConnectionGUID: n3ffq01hRB2aEiJSmynHyA==
X-CSE-MsgGUID: uNU+6/rQT/anic4wYubiLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="253425765"
Received: from ktian1-pkvm.sh.intel.com ([10.239.48.205])
  by orviesa009.jf.intel.com with ESMTP; 01 Jul 2026 23:01:03 -0700
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
Subject: [PATCH v2 1/9] iommu/vt-d: Fix no_iommu to disable platform optin
Date: Thu,  2 Jul 2026 06:12:08 +0000
Message-ID: <20260702061216.388743-2-kevin.tian@intel.com>
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
index 849d06dfe1ae..8668565e5781 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2482,10 +2482,11 @@ static bool has_external_pci(void)
 
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
@@ -2496,7 +2497,6 @@ static int __init platform_optin_force_iommu(void)
 		iommu_set_default_passthrough(false);
 
 	dmar_disabled = 0;
-	no_iommu = 0;
 
 	return 1;
 }
-- 
2.43.0

