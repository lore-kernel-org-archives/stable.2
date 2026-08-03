Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EED73976A0
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787732; cv=none; b=iRtmSL+3yc30S+g8Hl49tWYXROaLHeZnJbS0cQwibLin93/Zs6uIy6LDtdtjM/cg1GMK3m+JJs9E8/fuDzGAk5QjmQujfNYwp7qsPCHeRxiLBZ8SAb3MajB/r/w01mtaeXMmUE09fRCqw1/vjbFTh4k8k+d0RCaJBBGe6k2x53c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787732; c=relaxed/simple;
	bh=CwS9fHkTnM7JQq3329RHTjMV+cV7Er8Ekc+pDcVUk68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfSg0TtjORR+n7QlukyHgkpKERhmxSS4CBI4UHOkXKr7V4Gj/yd9eY4PXdCHrOeUvxuMMAw3hD6iq2BHLDiagz025qjj/b12/3tGk3K6UhM05GMDWlWYJW2OfbcJSrTd96zB0F5Hd6W8r7V1hv6f+a4o2mq0njTvVo0+Z+js/ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LMKpoOWe; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LMKpoOWe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785787730; x=1817323730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CwS9fHkTnM7JQq3329RHTjMV+cV7Er8Ekc+pDcVUk68=;
  b=LMKpoOWe9gS+ygDp+yfa+ezV9kNgUhEDAmhPDRy2g5wWKghj+YSbsW4x
   mfHaS9m4L9WTd7KlnkLY351xGuzqGC+pCQEHOUrXB6Qy8o//myB5LnUh7
   Bd7RYKQmbxmPRnLe/hiNLQtKvteC9PLLR7/0bF6j4ASd6GyXbYNB+/f2o
   8+nHEhz1HzX8bYXOLo8vP5BC02VfdwF2kNU+A3nLgJhYh64/CI6vt7X+v
   eIFK4MfiGto2KtN+gBRm1QE7Fz0nyVwUwcfEKsL/PzbM/1I5Elm6ztQjL
   s+3IZujMAqtMh56YaZI0zoDalRjhTnWNvqvtl1atXWPkVfPRhkG50Cn1+
   w==;
X-CSE-ConnectionGUID: q6uTHJu8TfiiIcMzjlvpqQ==
X-CSE-MsgGUID: QVJHZNz9SDi3ZZAwAgtvDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86188514"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86188514"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 13:08:49 -0700
X-CSE-ConnectionGUID: VZdakwgmRO6mkltQT9ek0g==
X-CSE-MsgGUID: xMANrt27RTqmBg+VLl/6SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="266433156"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.44])
  by fmviesa005.fm.intel.com with ESMTP; 03 Aug 2026 13:08:49 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v7 2/3] drm/xe/guc_ads: allocate UM queues in VRAM on dGFX
Date: Mon,  3 Aug 2026 20:08:37 +0000
Message-ID: <20260803200838.98826-3-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803200838.98826-1-jia.yao@intel.com>
References: <20260803200838.98826-1-jia.yao@intel.com>
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
---
 drivers/gpu/drm/xe/xe_guc.c     |  6 ------
 drivers/gpu/drm/xe/xe_guc_ads.c | 17 ++++++++++-------
 2 files changed, 10 insertions(+), 13 deletions(-)

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
index ef8e9cc35c8c..a69ec584cc0f 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -446,19 +446,22 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
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

