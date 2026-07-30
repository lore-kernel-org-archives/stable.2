Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450B8468C09
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 23:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454041; cv=none; b=CgW4bjCsB2djsysOV70bhRPi/iuy6V97i1u/Bsu2a4Q96Pq7sl5mig0GIwsJhU7kgIuz2eLZXcqS/Z2PsVVYrFNyUAECBX9Y0d/TJxZDhKlisxEw89eu1KiCCqmxPJ4EpTDOeX2L6UDYcDe6mcoh0KXFDv3VHw2MOvI6oWws0CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454041; c=relaxed/simple;
	bh=WzP6evCvyZOhfBi2sw5tf27C+CR2uraYH7gjYBhdmJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7iq306v1pllTA2NbiRBfLIdSm6+d5mgzNgHg9gSy5sAY2v95/e8noGNvdoT6AxvVp7ISgrWJ1G76nd0WTtmg+6Lr8Y80SWDWrgINB/Eg7e8Bxgc88RT7fEIlDl/kJXIeHu8E3Hn6OH2EZjM0W6o4r776UPJAa254KQBLzCwvSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RZL9MySe; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RZL9MySe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785454038; x=1816990038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WzP6evCvyZOhfBi2sw5tf27C+CR2uraYH7gjYBhdmJo=;
  b=RZL9MySePgfcY827GmO49VIB/e1ZBMDKf9Q2xgg1GyM/knD+5gvM4PLA
   eJqCA1qgz5LFBD7q+21xMvlzRYY2ipOp421mYUhcAZwmtmGXcuQ4Mhfvy
   Bfu7t5yFx7F/SWLZJYc/3h0UGEr0tIIkY1BLApoKSga2e48JRD2CyT56t
   bczwRyTiHhcTKjVDXHetZew2VlKc03dk2y1acSr61RfkxTcSpOmJrqgaR
   MBZ7gdeYliOAD1FvQPm9T9uqFh8dGgQIUbdqJ/0pNJVggmp0W+yK7CF2B
   cm7KTU946f+3jDVcaYe4hcZRrPTRcfwkli4pPRYXn1hpzfzHPimaeDKfT
   w==;
X-CSE-ConnectionGUID: VPsul6HFSx2z1szfltIZrg==
X-CSE-MsgGUID: SoLJeJJqRQOJj9XuOzcqVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="89895249"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="89895249"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 16:27:15 -0700
X-CSE-ConnectionGUID: eR3dmz8yR0Wm7G4Mz2Ws9g==
X-CSE-MsgGUID: 0yuGGIuCRTGftm1RDPakUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="283764149"
Received: from unknown (HELO DUT6094BMGFRD.fm.intel.com) ([10.80.55.54])
  by fmviesa002.fm.intel.com with ESMTP; 30 Jul 2026 16:27:16 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.auld@intel.com,
	gwan-gyeong.mun@intel.com,
	stable@vger.kernel.org,
	Jia Yao <jia.yao@intel.com>
Subject: [PATCH v5 1/3] drm/xe/guc_ads: allocate UM queues in a separate BO
Date: Thu, 30 Jul 2026 23:27:10 +0000
Message-ID: <20260730232712.517989-2-jia.yao@intel.com>
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

xe_guc_ads_populate() calls xe_map_memset() on the ADS BO on every GT
reset.  The UM queue ring buffers were embedded in that same BO, so the
memset discards fault descriptors already written by the GPU, causing
GuC to forward an all-zero descriptor (Faulted Address = 0, ASID = 0).

Move the UM queue ring buffers into a dedicated BO so they are not
affected by the ADS memset.

On pre-Xe3p platforms GAM accesses the UM queue ring via base_dpa, which
must be a contiguous DMA address range.  Round the allocation size up to
the next power of two so that the TTM pool issues a single order-N
alloc_pages() call, maximising the chance of physical contiguity.  Verify
the result with drm_prime_get_contiguous_size() and fail gracefully if
the pages are non-contiguous.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jia Yao <jia.yao@intel.com>
---
 drivers/gpu/drm/xe/xe_guc.c           |  6 ++
 drivers/gpu/drm/xe/xe_guc_ads.c       | 96 ++++++++++++++++++---------
 drivers/gpu/drm/xe/xe_guc_ads_types.h |  5 ++
 3 files changed, 75 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
index 4286bd05c686..4f132bf8539d 100644
--- a/drivers/gpu/drm/xe/xe_guc.c
+++ b/drivers/gpu/drm/xe/xe_guc.c
@@ -732,6 +732,12 @@ static int xe_guc_realloc_post_hwconfig(struct xe_guc *guc)
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
index f0ac00586d3a..3b6e1c45a0e9 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -8,6 +8,7 @@
 #include <linux/fault-inject.h>
 
 #include <drm/drm_managed.h>
+#include <drm/drm_prime.h>
 
 #include <generated/xe_wa_oob.h>
 
@@ -64,10 +65,14 @@ ads_to_map(struct xe_guc_ads *ads)
 
 /*
  * The Additional Data Struct (ADS) has pointers for different buffers used by
- * the GuC. One single gem object contains the ADS struct itself (guc_ads) and
- * all the extra buffers indirectly linked via the ADS struct's entries.
+ * the GuC. One gem object (ads->bo) contains the ADS struct itself (guc_ads)
+ * and most of the extra buffers linked via the ADS struct's entries.  The UM
+ * fault queues (PAGE_FAULT, PAGE_FAULT_RESPONSE, ACCESS_COUNTER rings) are
+ * kept in a separate BO (ads->um_queue_bo) so that the full memset of ads->bo
+ * performed on every GT reset does not discard fault descriptors already
+ * written into the rings by the GPU.
  *
- * Layout of the ADS blob allocated for the GuC:
+ * Layout of the ADS blob (ads->bo):
  *
  *      +---------------------------------------+ <== base
  *      | guc_ads                               |
@@ -99,10 +104,6 @@ ads_to_map(struct xe_guc_ads *ads)
  *      +---------------------------------------+
  *      | padding                               |
  *      +---------------------------------------+ <== 4K aligned
- *      | UM queues                             |
- *      +---------------------------------------+
- *      | padding                               |
- *      +---------------------------------------+ <== 4K aligned
  *      | private data                          |
  *      +---------------------------------------+
  *      | padding                               |
@@ -156,16 +157,6 @@ static size_t guc_ads_capture_size(struct xe_guc_ads *ads)
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
@@ -206,22 +197,12 @@ static size_t guc_ads_capture_offset(struct xe_guc_ads *ads)
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
@@ -461,6 +442,51 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
 
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
+		 * ring via base_dpa, which must be a contiguous DMA address
+		 * range.  Verify that the allocated pages are contiguous in
+		 * DMA address space.
+		 */
+		if (xe_bo_sg(bo) &&
+		    !xe_guc_using_main_gamctrl_queues(ads_to_guc(ads)) &&
+		    unlikely(drm_prime_get_contiguous_size(xe_bo_sg(bo)) <
+			     GUC_UM_QUEUE_SIZE * GUC_UM_HW_QUEUE_MAX)) {
+			drm_err(&xe->drm,
+				"UM fault queue memory is not contiguous in DMA address space; GAM requires contiguous DPA\n");
+			return -ENOMEM;
+		}
+
+		ads->um_queue_bo = bo;
+	}
+
 	return 0;
 }
 ALLOW_ERROR_INJECTION(xe_guc_ads_init, ERRNO); /* See xe_pci_probe() */
@@ -893,7 +919,7 @@ static void guc_mmio_reg_state_init(struct xe_guc_ads *ads)
 
 static void guc_um_init_params(struct xe_guc_ads *ads)
 {
-	u32 um_queue_offset = guc_ads_um_queues_offset(ads);
+	struct xe_bo *um_bo = ads->um_queue_bo;
 	struct xe_guc *guc = ads_to_guc(ads);
 	struct xe_device *xe = ads_to_xe(ads);
 	u64 base_dpa;
@@ -903,8 +929,14 @@ static void guc_um_init_params(struct xe_guc_ads *ads)
 
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

