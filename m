Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F4F23EA94
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 23:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787700687; cv=none; b=Sdw9JgG1hAbtE28rcHrMDMlow6CFIy9xYHRZSZqb6ldbsKF5JJPsvkMVpnh9xiWmIxZxJZMnieGH2Sb+slBtBa92a4Hd/L40+BIB+E02E1HxJetNJWEUNTKLpgK8vlU8mMc9rVqsO7nqImVzTLGeC6vLO6OQylfIOEGnIBNyLxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787700687; c=relaxed/simple;
	bh=5LILO+RXQnT9haN9qvDTgWO/XV3EtWGttHyVANFKwIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4bQAeey8+eFFDwms037iJLsqf5HpjfULrWwXpBLDn9fAFx6gXG/WJkaKf9G7LVOUtuJxnPe3FVmL/qsDmvMqcQS/2Mo7TU6/2MrbQg51Y60mqtl4V6sioaYC2kNUZBckf6CR5mwYhtziyqEOPCEszs/PFntwH6HLVPd8USJgYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=moxUx+OI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="moxUx+OI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787700684; x=1819236684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5LILO+RXQnT9haN9qvDTgWO/XV3EtWGttHyVANFKwIU=;
  b=moxUx+OIipJGWXvh6Q04A84BoK6G9eC5vyvJv/fC+CTZ8RKU90dRh1la
   R7NpBgyle/SXatV+lbdFmDnRiLtp5Pw+97kKcBZrZQWcPvSdTTJNflMCp
   xn1vCIArcy/oIKkDiOB385sRkulLHQjXtFUXkl85YZayBgFbMFCS+GvI4
   XtIMthHed+65mAGr20xQehyYysXJ31s9SV+Q+nbdywxxzNwtyrkL6sssm
   vRWM6mJDeVAnHpq9Db06DfYnaoRMuTfF4NHCLexQUVJ1Ah1fBNg7Js7LI
   SgY+8bxV+orY5AZxN9KyZS+FlJ6+3hl/IMUD/W2vfCrFDu7137rtoTrqQ
   w==;
X-CSE-ConnectionGUID: 0Ie+HkRFQOaPgrSa3sILsg==
X-CSE-MsgGUID: uzMvwI4+QQys8XLTCC5srA==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="99335325"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="99335325"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 16:31:24 -0700
X-CSE-ConnectionGUID: xfLBjrYeRMaqAwUOocimSQ==
X-CSE-MsgGUID: 3ONcrfVdQkuz8JwIp6wEjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="290941864"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.39])
  by fmviesa002.fm.intel.com with ESMTP; 25 Aug 2026 16:31:23 -0700
From: Jia Yao <jia.yao@intel.com>
To: stable@vger.kernel.org
Cc: Jia Yao <jia.yao@intel.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 6.18.y 1/3] drm/xe/guc_ads: allocate UM queues in a separate BO
Date: Tue, 25 Aug 2026 23:30:51 +0000
Message-ID: <20260825233053.1504506-1-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026082036-afterglow-tapered-84a0@gregkh>
References: <2026082036-afterglow-tapered-84a0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move the UM queues into a dedicated BO (ads->um_queue_bo) and avoid
CPU memset operations on it, which eliminates the CPU as a potential
cacheline-polluting agent and helps maintain consistency between GAM
writes and GuC reads.

We also need to ensure the base_dpa for the queue is contiguous on hw
where this is used instead of a GGTT address. Another good reason to
split this out to a separate BO.

Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
Signed-off-by: Jia Yao <jia.yao@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patch.msgid.link/20260804165057.129529-2-jia.yao@intel.com
(cherry picked from commit 99b01815957bd7d848420cb697f79ed11f7f215c)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_bo.h            | 14 +++++
 drivers/gpu/drm/xe/xe_guc.c           |  6 ++
 drivers/gpu/drm/xe/xe_guc_ads.c       | 89 +++++++++++++++++----------
 drivers/gpu/drm/xe/xe_guc_ads_types.h |  5 ++
 4 files changed, 82 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index fef60c8a4e5b..71169b57fbda 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -6,6 +6,7 @@
 #ifndef _XE_BO_H_
 #define _XE_BO_H_
 
+#include <drm/drm_prime.h>
 #include <drm/ttm/ttm_tt.h>
 
 #include "xe_bo_types.h"
@@ -455,6 +456,19 @@ void xe_bo_dev_fini(struct xe_bo_dev *bo_device);
 
 struct sg_table *xe_bo_sg(struct xe_bo *bo);
 
+/**
+ * xe_bo_sg_is_contiguous() - Check if a BO's DMA address space is contiguous.
+ * @bo: the BO to check (must have a valid sg table, i.e. !xe_bo_is_vram())
+ * @len: required contiguous length in bytes
+ *
+ * Returns true if the first @len bytes of the BO are mapped to a contiguous
+ * DMA address range.
+ */
+static inline bool xe_bo_sg_is_contiguous(struct xe_bo *bo, size_t len)
+{
+	return drm_prime_get_contiguous_size(xe_bo_sg(bo)) >= len;
+}
+
 /*
  * xe_sg_segment_size() - Provides upper limit for sg segment size.
  * @dev: device pointer
diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
index ae0c88da422b..cc5741f751b9 100644
--- a/drivers/gpu/drm/xe/xe_guc.c
+++ b/drivers/gpu/drm/xe/xe_guc.c
@@ -700,6 +700,12 @@ static int xe_guc_realloc_post_hwconfig(struct xe_guc *guc)
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
index db71823b2538..86e6651c0036 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -65,10 +65,14 @@ ads_to_map(struct xe_guc_ads *ads)
 
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
@@ -100,10 +104,6 @@ ads_to_map(struct xe_guc_ads *ads)
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
@@ -157,16 +157,6 @@ static size_t guc_ads_capture_size(struct xe_guc_ads *ads)
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
@@ -207,22 +197,12 @@ static size_t guc_ads_capture_offset(struct xe_guc_ads *ads)
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
@@ -408,6 +388,45 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
 
 	ads->bo = bo;
 
+	if (xe->info.has_usm) {
+		/*
+		 * Allocate a separate BO for the HW fault ring (UM queues).
+		 *
+		 * Round the size up to the next power of two so that
+		 * (system memory, no IOMMU) the TTM pool issues a single
+		 * alloc_pages(order=N) call, maximising the chance of getting
+		 * a physically contiguous block.  GuC requires contiguous DPA.
+		 */
+		size_t um_size = roundup_pow_of_two(GUC_UM_QUEUE_SIZE *
+						    GUC_UM_HW_QUEUE_MAX);
+
+		u32 um_flags = XE_BO_FLAG_SYSTEM |
+			       XE_BO_FLAG_GGTT |
+			       XE_BO_FLAG_GGTT_INVALIDATE |
+			       XE_BO_FLAG_PINNED_NORESTORE;
+
+		bo = xe_managed_bo_create_pin_map(xe, tile, um_size, um_flags);
+		if (IS_ERR(bo))
+			return PTR_ERR(bo);
+
+		/*
+		 * On pre-Xe3p platforms, GAM (not GuC) accesses the UM queue
+		 * ring via base_dpa, which must be a contiguous DMA address
+		 * range.  Verify that the allocated pages are contiguous in
+		 * DMA address space.
+		 */
+		if (!xe_bo_is_vram(bo) &&
+		    unlikely(!xe_bo_sg_is_contiguous(bo,
+						     GUC_UM_QUEUE_SIZE *
+						     GUC_UM_HW_QUEUE_MAX))) {
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
@@ -824,13 +843,19 @@ static void guc_mmio_reg_state_init(struct xe_guc_ads *ads)
 
 static void guc_um_init_params(struct xe_guc_ads *ads)
 {
-	u32 um_queue_offset = guc_ads_um_queues_offset(ads);
+	struct xe_bo *um_bo = ads->um_queue_bo;
 	u64 base_dpa;
 	u32 base_ggtt;
 	int i;
 
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
 		ads_blob_write(ads, um_init_params.queue_params[i].base_dpa,
diff --git a/drivers/gpu/drm/xe/xe_guc_ads_types.h b/drivers/gpu/drm/xe/xe_guc_ads_types.h
index 70c132458ac3..acb5366f76ef 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads_types.h
+++ b/drivers/gpu/drm/xe/xe_guc_ads_types.h
@@ -16,6 +16,11 @@ struct xe_bo;
 struct xe_guc_ads {
 	/** @bo: XE BO for GuC ads blob */
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

