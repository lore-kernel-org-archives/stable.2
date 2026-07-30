Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB0F2DB791
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 00:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785372484; cv=none; b=U9m49wiSTa6Zjki2E3Katb2JEP26fOrBjt41jOhxXXrbj0SQCECXapdactOiNBmslqmqCFw7pGmcmhbCLOnWuGTayDDfbl1O6/hIqMEaFpGQKEF6wpT2JZMY6aV30SiMrPxnikNw8VUEpmdowa01tBezOzUmPy4aaUUe4mzkJgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785372484; c=relaxed/simple;
	bh=LiVRcBLcwM9vAPBGawgBNt9x7E5i1I1e/jKXZgphzOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zfhx2LznGWQ2H+DTgmXNfqy1kIZXh5AFmD8VNgd/e6eg6Xj3Mv7hPuPGGg64r3EE29kcthMI9XghnVcZqEkdRMrfT39skCtlUDTyMPAR2gf4ZvxME5f6P7ZhKQQ76PGT8NAqEx/VM+94qMnOXu9g6FivCrH1pS1ze8vb3unEmhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BD5NyOSn; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BD5NyOSn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785372482; x=1816908482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LiVRcBLcwM9vAPBGawgBNt9x7E5i1I1e/jKXZgphzOA=;
  b=BD5NyOSnu+ZIBIIWYwcuRRVpgtvzsnR14DkH+6FJCustKnyMde5JbQj0
   Bqua89NnZ1fbBfMqnPUXpLJg8wRivORqQcjIclDkXKmpbzdJ3gHhSqJCm
   op30z1pbTf9Kn9R6UCvXh0QlcBCGO4YBmPTXs70rHNu/0VzGI7GLYSvZe
   gMQ+eUx6TBy4gGIC17OCueiMEopoqEIaZnXDVWEL1WJOKJ/PhrGHmBqqI
   1jJQHAYSypp9PIxVEmHkgx2d2XAbseUVw6y6Udh52G4CBfN9puuiQZSsy
   Nr7RraPNIygO89arfwqIrmyAMv3GSQeFJa6uz+ZXs4dNbVKnNNpDrBsUl
   Q==;
X-CSE-ConnectionGUID: jdCAIaOAQJKhj9iRQvUx7Q==
X-CSE-MsgGUID: R9kO2/kFRiW9imHkS63LcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85935344"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="85935344"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 17:48:01 -0700
X-CSE-ConnectionGUID: qoajePhaQU2H4kVdnP7wBA==
X-CSE-MsgGUID: CRWefjceR5yxUqDRnIp3BQ==
X-ExtLoop1: 1
Received: from unknown (HELO DUT6094BMGFRD.fm.intel.com) ([10.80.55.54])
  by fmviesa003.fm.intel.com with ESMTP; 29 Jul 2026 17:48:01 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.auld@intel.com,
	gwan-gyeong.mun@intel.com,
	stable@vger.kernel.org,
	Jia Yao <jia.yao@intel.com>
Subject: [PATCH v4 1/3] drm/xe/guc_ads: allocate UM queues in a separate BO
Date: Thu, 30 Jul 2026 00:47:33 +0000
Message-ID: <20260730004735.344627-2-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730004735.344627-1-jia.yao@intel.com>
References: <20260722053410.2767369-1-jia.yao@intel.com>
 <20260730004735.344627-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xe_guc_ads_populate() calls xe_map_memset() on the ADS BO on every GT
reset.  The UM queue ring buffers were embedded in that same BO, so the
memset discards fault descriptors already written by the GPU, causing
GuC to forward an all-zero descriptor (Faulted Address = 0, ASID = 0).

Move the UM queue ring buffers into a dedicated BO so they are not
affected by the ADS memset.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jia Yao <jia.yao@intel.com>
---
 drivers/gpu/drm/xe/xe_guc.c           |  6 ++
 drivers/gpu/drm/xe/xe_guc_ads.c       | 98 ++++++++++++++++++++-------
 drivers/gpu/drm/xe/xe_guc_ads_types.h |  5 ++
 3 files changed, 84 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
index 4023700ff2a9..21cf3edef922 100644
--- a/drivers/gpu/drm/xe/xe_guc.c
+++ b/drivers/gpu/drm/xe/xe_guc.c
@@ -714,6 +714,12 @@ static int xe_guc_realloc_post_hwconfig(struct xe_guc *guc)
 	if (ret)
 		return ret;
 
+	if (guc->ads.um_queue_bo) {
+		ret = xe_managed_bo_reinit_in_vram(xe, tile, &guc->ads.um_queue_bo);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index c98454545a85..7f371f9c7268 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -16,6 +16,7 @@
 #include "regs/xe_gt_regs.h"
 #include "regs/xe_guc_regs.h"
 #include "xe_bo.h"
+#include "xe_res_cursor.h"
 #include "xe_gt.h"
 #include "xe_gt_ccs_mode.h"
 #include "xe_gt_mcr.h"
@@ -155,16 +156,6 @@ static size_t guc_ads_capture_size(struct xe_guc_ads *ads)
 	return PAGE_ALIGN(ads->capture_size);
 }
 
-static size_t guc_ads_um_queues_size(struct xe_guc_ads *ads)
-{
-	struct xe_device *xe = ads_to_xe(ads);
-
-	if (!xe->info.has_usm)
-		return 0;
-
-	return GUC_UM_QUEUE_SIZE * GUC_UM_HW_QUEUE_MAX;
-}
-
 static size_t guc_ads_private_data_size(struct xe_guc_ads *ads)
 {
 	return PAGE_ALIGN(ads_to_guc(ads)->fw.private_data_size);
@@ -205,22 +196,12 @@ static size_t guc_ads_capture_offset(struct xe_guc_ads *ads)
 	return PAGE_ALIGN(offset);
 }
 
-static size_t guc_ads_um_queues_offset(struct xe_guc_ads *ads)
-{
-	u32 offset;
-
-	offset = guc_ads_capture_offset(ads) +
-		 guc_ads_capture_size(ads);
-
-	return PAGE_ALIGN(offset);
-}
-
 static size_t guc_ads_private_data_offset(struct xe_guc_ads *ads)
 {
 	size_t offset;
 
-	offset = guc_ads_um_queues_offset(ads) +
-		guc_ads_um_queues_size(ads);
+	offset = guc_ads_capture_offset(ads) +
+		guc_ads_capture_size(ads);
 
 	return PAGE_ALIGN(offset);
 }
@@ -409,6 +390,67 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
 
 	ads->bo = bo;
 
+	if (xe->info.has_usm) {
+		/*
+		 * Allocate a separate BO for the HW fault ring (UM queues).
+		 *
+		 * xe_guc_ads_populate() clears the entire ADS BO via
+		 * xe_map_memset() on every GT reset.  Keeping the UM queues
+		 * in a dedicated BO prevents that memset from discarding fault
+		 * descriptors the GPU has already written into the ring,
+		 * which would cause GuC to forward an all-zero descriptor to
+		 * the driver (Faulted Address = 0, ASID = 0).
+		 *
+		 * Round the size up to the next power of two so that on iGPU
+		 * (system memory, no IOMMU) the TTM pool issues a single
+		 * alloc_pages(order=N) call, maximising the chance of getting
+		 * a physically contiguous block.  GuC requires contiguous DPA.
+		 */
+		size_t um_size = roundup_pow_of_two(GUC_UM_QUEUE_SIZE *
+						    GUC_UM_HW_QUEUE_MAX);
+
+		bo = xe_managed_bo_create_pin_map(xe, tile, um_size,
+						  XE_BO_FLAG_SYSTEM |
+						  XE_BO_FLAG_GGTT |
+						  XE_BO_FLAG_GGTT_INVALIDATE |
+						  XE_BO_FLAG_PINNED_NORESTORE);
+		if (IS_ERR(bo))
+			return PTR_ERR(bo);
+
+		/*
+		 * On pre-Xe3p platforms, GAM (not GuC) accesses the UM queue
+		 * ring via base_dpa, which must be a contiguous device physical
+		 * address range.  Without IOMMU, DMA addresses equal physical
+		 * addresses and the allocator may return non-contiguous pages;
+		 * verify contiguity.  With IOMMU, the DMA mapping is a single
+		 * contiguous IOVA so no check is needed.
+		 */
+		if (unlikely(!device_iommu_mapped(xe->drm.dev)) &&
+		    !xe_bo_is_vram(bo) &&
+		    !xe_guc_using_main_gamctrl_queues(ads_to_guc(ads))) {
+			struct xe_res_cursor cur;
+			int i;
+
+		xe_res_first_sg(xe_bo_sg(bo), 0,
+				GUC_UM_QUEUE_SIZE * GUC_UM_HW_QUEUE_MAX, &cur);
+			for (i = 1; i < GUC_UM_HW_QUEUE_MAX; i++) {
+				dma_addr_t expected = xe_res_dma(&cur) +
+						      GUC_UM_QUEUE_SIZE;
+
+				xe_res_next(&cur, GUC_UM_QUEUE_SIZE);
+				if (xe_res_dma(&cur) != expected) {
+					drm_err(&xe->drm,
+						"UM fault queue %d is physically non-contiguous (got %pad, expected %pad); GAM requires contiguous DPA. Enable IOMMU (intel_iommu=on) to fix.\n",
+						i, &(dma_addr_t){xe_res_dma(&cur)},
+						&expected);
+					return -ENOMEM;
+				}
+			}
+		}
+
+		ads->um_queue_bo = bo;
+	}
+
 	return 0;
 }
 ALLOW_ERROR_INJECTION(xe_guc_ads_init, ERRNO); /* See xe_pci_probe() */
@@ -820,7 +862,7 @@ static void guc_mmio_reg_state_init(struct xe_guc_ads *ads)
 
 static void guc_um_init_params(struct xe_guc_ads *ads)
 {
-	u32 um_queue_offset = guc_ads_um_queues_offset(ads);
+	struct xe_bo *um_bo = ads->um_queue_bo;
 	struct xe_guc *guc = ads_to_guc(ads);
 	struct xe_device *xe = ads_to_xe(ads);
 	u64 base_dpa;
@@ -830,8 +872,14 @@ static void guc_um_init_params(struct xe_guc_ads *ads)
 
 	with_dpa = !xe_guc_using_main_gamctrl_queues(guc);
 
-	base_ggtt = xe_bo_ggtt_addr(ads->bo) + um_queue_offset;
-	base_dpa = xe_bo_main_addr(ads->bo, PAGE_SIZE) + um_queue_offset;
+	if (um_bo) {
+		/* All USM platforms: UM queues in dedicated um_queue_bo */
+		base_ggtt = xe_bo_ggtt_addr(um_bo);
+		base_dpa = xe_bo_main_addr(um_bo, PAGE_SIZE);
+	} else {
+		/* Platform does not support USM: no UM queues, nothing to do */
+		return;
+	}
 
 	for (i = 0; i < GUC_UM_HW_QUEUE_MAX; ++i) {
 		/*
diff --git a/drivers/gpu/drm/xe/xe_guc_ads_types.h b/drivers/gpu/drm/xe/xe_guc_ads_types.h
index 48a8e092023f..845c1fbd93a4 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads_types.h
+++ b/drivers/gpu/drm/xe/xe_guc_ads_types.h
@@ -16,6 +16,11 @@ struct xe_bo;
 struct xe_guc_ads {
 	/** @bo: Xe BO for GuC ads blob */
 	struct xe_bo *bo;
+	/**
+	 * @um_queue_bo: Dedicated BO for the HW fault ring (UM queues).
+	 * NULL if the platform does not support USM.
+	 */
+	struct xe_bo *um_queue_bo;
 	/** @golden_lrc_size: golden LRC size */
 	size_t golden_lrc_size;
 	/** @regset_size: size of register set passed to GuC for save/restore */
-- 
2.43.0

