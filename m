Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F17F223DE5
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 23:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454045; cv=none; b=C/BIcp5HxkgxQPxXExpUU7VMWmDDfT99xqmau08GInCJsXSc97xWDGXLZKKm2HD34c9gDFklHZfKa7KdFVaB06oTzkogIf1L75Dzoc1dN4ViWqa/2RlMQnJp0ClFUGyoXaGvZxIQZJAN0ltyoaCC7jIodam3Xw4yL6wjLS/uT3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454045; c=relaxed/simple;
	bh=c06bulpfqKxGKzJcgyLQBmeDhSjy0u6O1VX8Mvk6Yic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFhc5aokz16xB2c1QvNcDVio5GClu4my8wjLWgGsS3iC5Rv8eTcAOO8K7laWxGlutTktPNrWr2mPpWwNjsOP/TRdivHTMieBoeYXjWxQYQKEv0qI0+FrmUA04JTVKJH8yylBcXuMnZgSy+xKecznW4DX9NN0fn4QE/C0USxOjb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bN2Uahw3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bN2Uahw3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785454039; x=1816990039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c06bulpfqKxGKzJcgyLQBmeDhSjy0u6O1VX8Mvk6Yic=;
  b=bN2Uahw3Jy4g7fBy0FPHS/TKspOcPiaT4RGEvNtcSBM9sQbrVoIArvSg
   jXlGdiuW5L4QCh9vAX4GRpa01Jg/KyfWVDvwW/QVq+FYeeBR3TVvfSAU6
   zXYNz6kc9vF3SVvXc5bp/KUfiSFCY81FaZ+Em3IEmmv4KmwlzQEOBoNQq
   ojQEMitHvZR+x5NIhFCzCjh7orHUgmjhpQ9Z5SXCDz49OC6+5B4FhjNqn
   NqNBW4ISGPD9PxaPRNDj2XsPdGSzwwtYTPyV0gDyZXXsOohWExz2RU2HT
   fmVE1Cbk7zl9KRNlB9fn0lpFOFJ+FghC77S8mkS8pYewCZB4ogEePUpWw
   g==;
X-CSE-ConnectionGUID: lDLu0hOOTyamJTGTRhofmA==
X-CSE-MsgGUID: PEkba/S5Sb+qXO2Z9WHlMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="89895251"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="89895251"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 16:27:17 -0700
X-CSE-ConnectionGUID: 4P652JnmSX6ViozzFiJIRQ==
X-CSE-MsgGUID: 1Tq8ICO/S0aVM8Kqeq4wwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="283764152"
Received: from unknown (HELO DUT6094BMGFRD.fm.intel.com) ([10.80.55.54])
  by fmviesa002.fm.intel.com with ESMTP; 30 Jul 2026 16:27:17 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.auld@intel.com,
	gwan-gyeong.mun@intel.com,
	stable@vger.kernel.org,
	Jia Yao <jia.yao@intel.com>
Subject: [PATCH v5 2/3] drm/xe/guc_ads: allocate UM queues in VRAM on dGFX
Date: Thu, 30 Jul 2026 23:27:11 +0000
Message-ID: <20260730232712.517989-3-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730232712.517989-1-jia.yao@intel.com>
References: <20260722053410.2767369-1-jia.yao@intel.com>
 <20260730232712.517989-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On pre-Xe3p dGFX, GuC/GAM accesses the UM queue ring buffer via
base_dpa, which is interpreted as a raw device-physical address.
Unlike the GGTT PTE, there is no flag to indicate whether base_dpa
points to VRAM or system memory; the hardware assumes it is always
a VRAM address.

A separate SYSTEM BO for the UM queues would cause xe_bo_main_addr()
to return an IOMMU IOVA instead of a true VRAM device-physical address.
GuC then accesses the wrong memory and forwards all-zero fault
descriptors to the driver (Faulted Address = 0, ASID = 0).

Use XE_BO_FLAG_VRAM_IF_DGFX() so that on dGFX the UM queue BO is
placed directly in VRAM and xe_bo_main_addr() returns the correct
device-physical address.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jia Yao <jia.yao@intel.com>
---
 drivers/gpu/drm/xe/xe_guc.c     |  6 ------
 drivers/gpu/drm/xe/xe_guc_ads.c | 11 ++++++-----
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
index 4f132bf8539d..4286bd05c686 100644
--- a/drivers/gpu/drm/xe/xe_guc.c
+++ b/drivers/gpu/drm/xe/xe_guc.c
@@ -732,12 +732,6 @@ static int xe_guc_realloc_post_hwconfig(struct xe_guc *guc)
 	if (ret)
 		return ret;
 
-	if (guc->ads.um_queue_bo) {
-		ret = xe_managed_bo_reinit_in_vram(xe, tile, &guc->ads.um_queue_bo);
-		if (ret)
-			return ret;
-	}
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index 3b6e1c45a0e9..57a0614dbf6d 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -461,11 +461,12 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
 		size_t um_size = roundup_pow_of_two(GUC_UM_QUEUE_SIZE *
 						    GUC_UM_HW_QUEUE_MAX);
 
-		bo = xe_managed_bo_create_pin_map(xe, tile, um_size,
-						  XE_BO_FLAG_SYSTEM |
-						  XE_BO_FLAG_GGTT |
-						  XE_BO_FLAG_GGTT_INVALIDATE |
-						  XE_BO_FLAG_PINNED_NORESTORE);
+		u32 um_flags = XE_BO_FLAG_VRAM_IF_DGFX(tile) |
+			       XE_BO_FLAG_GGTT |
+			       XE_BO_FLAG_GGTT_INVALIDATE |
+			       XE_BO_FLAG_PINNED_NORESTORE;
+
+		bo = xe_managed_bo_create_pin_map(xe, tile, um_size, um_flags);
 		if (IS_ERR(bo))
 			return PTR_ERR(bo);
 
-- 
2.43.0

