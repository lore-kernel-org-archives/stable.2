Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EF5480965
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862281; cv=none; b=n3rI8qlrXMe/9gGl60gDF9UU8V1tCpi4oxB3zmoGTAZWD+LTW/PiSgq9WHFyXmU8WcdvI7qxY17lJF0jP5x8HnrkBi9Tw6mbwWPZcg1gS5b+PBoYpKRdHKDyPKlfY3fT1pS/3Kh/XICbNAL4fK5OcFzK8PId8vxP7EXADwhK9u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862281; c=relaxed/simple;
	bh=afJvUjA7HtA/giCuqIOtJyk6SF2sQJUwOlBo1xAK/BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awo/k9cWhOGHX9+E8UKFMMmkMYv7O4FCN2XPd0umD29Af7drPUN70Yw32y5VKQW+HUkgO11Q3VjWq+DCLEs2ghy6UGOLwXRUw+bSOxu6M0tKRU3H3ZzoMNBf1d6Ca9F+s+1qcCHv4exJRwqd0pUWPnkzSgc7YGrty9WjYs7krOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENR0LcYf; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENR0LcYf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785862270; x=1817398270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=afJvUjA7HtA/giCuqIOtJyk6SF2sQJUwOlBo1xAK/BM=;
  b=ENR0LcYfeAYUPyCAVKcVFcB8xFry5V8hm00r/oO5YHS1GS0GQOQtJVM3
   sEW5lFWpaj4/FZmomcFbBu9mZzFle3wXqaZ8jX+Mjriom3YEVYjndp5HY
   A9RW1cf+C2ycKFOfQrhRuISDZUxVqeZNX5XReG6GEUaR5BX7fZuapmE+5
   c7CHAaYWRmSScXEac6LiCrG11qhurAfa4WDkm3ot6OsnvEkamwYLJ0b7O
   S2rNZVVNby4RBceShCpMVWvaIHrK1Xcx1ib77UcZpvfh09ZwF+HW8085R
   dPTQpOpko4UZkO2TomkGBk36q6hvgbj5RQnaKG8HprXi3eSfYAEpOukGD
   Q==;
X-CSE-ConnectionGUID: G/AR0KXzSKyP0ze093tBgQ==
X-CSE-MsgGUID: Iek8sKTcTDSu7aU9+K09XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97925419"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="97925419"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 09:51:07 -0700
X-CSE-ConnectionGUID: QWSwzKDETiOhglbqVei8fw==
X-CSE-MsgGUID: QtT58CQ3SfyGAS2JV+L7lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="265063691"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.44])
  by orviesa003.jf.intel.com with ESMTP; 04 Aug 2026 09:51:08 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v8 2/3] drm/xe/guc_ads: allocate UM queues in VRAM on dGFX
Date: Tue,  4 Aug 2026 16:50:56 +0000
Message-ID: <20260804165057.129529-3-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804165057.129529-1-jia.yao@intel.com>
References: <20260804165057.129529-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On iGPU, the UM queue BO is allocated in system memory. On dGFX, the BO
was previously created in system memory and later reallocated in
xe_guc_realloc_post_hwconfig().  Allocate the UM queue BO directly in
VRAM on dGFX, where it is ultimately required.

Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
Signed-off-by: Jia Yao <jia.yao@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
---
 drivers/gpu/drm/xe/xe_guc.c     | 6 ------
 drivers/gpu/drm/xe/xe_guc_ads.c | 8 +++++---
 2 files changed, 5 insertions(+), 9 deletions(-)

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
index f8c679cef003..77429ff4d2a9 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -445,15 +445,17 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
 		/*
 		 * Allocate a separate BO for the HW fault ring (UM queues).
 		 *
-		 * Round the size up to the next power of two so that
+		 * Round the size up to the next power of two so that on iGPU
 		 * (system memory, no IOMMU) the TTM pool issues a single
 		 * alloc_pages(order=N) call, maximising the chance of getting
 		 * a physically contiguous block.  GuC requires contiguous DPA.
 		 */
-		size_t um_size = roundup_pow_of_two(GUC_UM_QUEUE_SIZE *
+		size_t um_size = IS_DGFX(xe) ?
+				 GUC_UM_QUEUE_SIZE * GUC_UM_HW_QUEUE_MAX :
+				 roundup_pow_of_two(GUC_UM_QUEUE_SIZE *
 						    GUC_UM_HW_QUEUE_MAX);
 
-		u32 um_flags = XE_BO_FLAG_SYSTEM |
+		u32 um_flags = XE_BO_FLAG_VRAM_IF_DGFX(tile) |
 			       XE_BO_FLAG_GGTT |
 			       XE_BO_FLAG_GGTT_INVALIDATE |
 			       XE_BO_FLAG_PINNED_NORESTORE;
-- 
2.43.0

