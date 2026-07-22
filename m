Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17DB1DF748
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 05:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784698513; cv=none; b=nrswg6KB/XymDcQKjeRLYdyxMTpSK/sRyhQUUkLkS1SXmN4Gmi+aNjTuJSXaEONd+ogaZhNnDdNsEmdyma023ydtjdy67Vlnup+E185wwz0C/zPhGEhKWi50H8v+xk0fyjbFMrl5ky2wGij/MVS0myDPIhWWt1aGqVrHkbwi8As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784698513; c=relaxed/simple;
	bh=zPDcuznOvcve02vFBxicq+2KFBZSvFlFzamGzM3kqVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzCfI8w+nffH3HpszIT7GuZjY6KLo1Q9qFKTIssmoSEx+T15vYiC/hwAGmRCMniAD4+vjR6f9sYLxkfdYRNXEIRm143z009LNq7sRyDuL5mB3h+PiIl8rJgODCMe9+5ZukWKBRXFs9VrKjKZfYwaZVPq/e1eC/ofxY5qxbtUsu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l2Jq1i5D; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l2Jq1i5D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784698512; x=1816234512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zPDcuznOvcve02vFBxicq+2KFBZSvFlFzamGzM3kqVw=;
  b=l2Jq1i5DBsm49ugW0CIKyP97j+yqEdHNqMJBXrZMFtYvkUGTlygp+ZWn
   jSd6ttRbch9i1DI0YXbadx6AI76H+AW9Otvvz8LWAwxjRM4Tmbf5AIXeL
   L/3ju+nFaHK46+k61jL/qIIRpaPqZ1ZaeVmZ2otyotr3ePrTn3TIy225D
   AXU2FmgOorHproIbvne0okfTDKXT3uF8/zN9Znc3cXJ+hz01M2keE+y3Q
   cbe9SK4vQg4jEZP+5aCyRd9DGg0c62sv+N35SKe0R2UKjd53//zF1ngti
   WNOY2FSxjM1jcvi3rFZFn1UrLeP3uiSGeBx1cqdu6plGzMyzh6TY5cGMQ
   w==;
X-CSE-ConnectionGUID: gRAevFLYTxuepi9b8nRccQ==
X-CSE-MsgGUID: LNdhie0BTIOymL/ddjExkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="88998396"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="88998396"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 22:35:11 -0700
X-CSE-ConnectionGUID: Hha6/A21QMSR4gk066b4zg==
X-CSE-MsgGUID: ilZ8JNoqQWKmnD0Vfmv+eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="262266067"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.54])
  by orviesa005.jf.intel.com with ESMTP; 21 Jul 2026 22:35:10 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/1] drm/xe/guc_ads: allocate UM queues in a separate UC BO
Date: Wed, 22 Jul 2026 05:34:10 +0000
Message-ID: <20260722053410.2767369-2-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722053410.2767369-1-jia.yao@intel.com>
References: <20260722053410.2767369-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HW unit that writes to the UM fault queue is not always coherent
with the CPU cache. Ensure the UM queue memory is uncached on the CPU
side so that GuC always reads descriptors from memory rather than a
stale CPU cache line.

Allocate the UM queues in a dedicated UC BO (ads->um_queue_bo) instead
of the main ADS blob. This also prevents xe_guc_ads_populate()'s
memset from zeroing any fault descriptor written between GDRST and GuC
restart. On dGFX, VRAM placement gives a well-defined DPA.

v3: simplify commit message and code comments per reviewer feedback;
    add Fixes tag and stable Cc

v2: also fix dGFX (VRAM placement + UC flag); remove now-dead
    guc_ads_um_queues_size/offset helpers

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jia Yao <jia.yao@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_ads.c       | 64 ++++++++++++++++-----------
 drivers/gpu/drm/xe/xe_guc_ads_types.h |  8 +++-
 2 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index c98454545a85..ec36a5db7fc8 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -155,16 +155,6 @@ static size_t guc_ads_capture_size(struct xe_guc_ads *ads)
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
@@ -205,22 +195,12 @@ static size_t guc_ads_capture_offset(struct xe_guc_ads *ads)
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
+		 guc_ads_capture_size(ads);
 
 	return PAGE_ALIGN(offset);
 }
@@ -409,6 +389,30 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
 
 	ads->bo = bo;
 
+	/*
+	 * The HW unit that writes to the UM fault queue is not coherent with
+	 * the CPU cache.  Use a dedicated UC BO to ensure GuC always reads
+	 * descriptors from memory rather than a stale CPU cache line.  A
+	 * separate BO also prevents xe_guc_ads_populate()'s memset from
+	 * zeroing descriptors written between GDRST and GuC restart.  On
+	 * dGFX, VRAM gives a well-defined DPA.
+	 */
+	if (xe->info.has_usm) {
+		u32 um_flags = XE_BO_FLAG_GGTT |
+			       XE_BO_FLAG_GGTT_INVALIDATE |
+			       XE_BO_FLAG_PINNED_NORESTORE |
+			       XE_BO_FLAG_NEEDS_UC |
+			       XE_BO_FLAG_VRAM_IF_DGFX(tile);
+
+		bo = xe_managed_bo_create_pin_map(xe, tile,
+					  GUC_UM_QUEUE_SIZE * GUC_UM_HW_QUEUE_MAX,
+					  um_flags);
+		if (IS_ERR(bo))
+			return PTR_ERR(bo);
+
+		ads->um_queue_bo = bo;
+	}
+
 	return 0;
 }
 ALLOW_ERROR_INJECTION(xe_guc_ads_init, ERRNO); /* See xe_pci_probe() */
@@ -820,9 +824,9 @@ static void guc_mmio_reg_state_init(struct xe_guc_ads *ads)
 
 static void guc_um_init_params(struct xe_guc_ads *ads)
 {
-	u32 um_queue_offset = guc_ads_um_queues_offset(ads);
 	struct xe_guc *guc = ads_to_guc(ads);
 	struct xe_device *xe = ads_to_xe(ads);
+	struct xe_bo *um_bo = ads->um_queue_bo;
 	u64 base_dpa;
 	u32 base_ggtt;
 	bool with_dpa;
@@ -830,8 +834,14 @@ static void guc_um_init_params(struct xe_guc_ads *ads)
 
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
@@ -912,6 +922,10 @@ void xe_guc_ads_populate(struct xe_guc_ads *ads)
 	xe_gt_assert(gt, ads->bo);
 
 	xe_map_memset(ads_to_xe(ads), ads_to_map(ads), 0, 0, xe_bo_size(ads->bo));
+	/*
+	 * um_queue_bo is not zeroed here. GuC resets head/tail via MMIO on
+	 * every restart so stale ring contents are never consumed.
+	 */
 	guc_policies_init(ads);
 	fill_engine_enable_masks(gt, &info_map);
 	guc_mmio_reg_state_init(ads);
diff --git a/drivers/gpu/drm/xe/xe_guc_ads_types.h b/drivers/gpu/drm/xe/xe_guc_ads_types.h
index 48a8e092023f..a63ef000dc8a 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads_types.h
+++ b/drivers/gpu/drm/xe/xe_guc_ads_types.h
@@ -14,8 +14,14 @@ struct xe_bo;
  * struct xe_guc_ads - GuC additional data structures (ADS)
  */
 struct xe_guc_ads {
-	/** @bo: Xe BO for GuC ads blob */
+	/** @bo: Xe BO for GuC ads blob (WB cached) */
 	struct xe_bo *bo;
+	/**
+	 * @um_queue_bo: Dedicated UC BO for the HW fault ring (UM queues).
+	 * The HW unit writing to this ring is not coherent with the CPU cache;
+	 * UC ensures GuC reads descriptors from memory. NULL if no USM support.
+	 */
+	struct xe_bo *um_queue_bo;
 	/** @golden_lrc_size: golden LRC size */
 	size_t golden_lrc_size;
 	/** @regset_size: size of register set passed to GuC for save/restore */
-- 
2.43.0

