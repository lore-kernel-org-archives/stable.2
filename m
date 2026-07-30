Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1C525B09C
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 00:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785372485; cv=none; b=dXyh4UA3MVhp3mWIl7f5RgWzdHCWb06vkSgYGMQmhv1PZ1C9c+mubz9TZY3ikSPCvLo7YE02ODJhevpGYHTwpWNb1K34jemH5H2dbZKPTCbeSiSUNx4kKV1vIOTMYvIaD0sGVeYWEvbjuqe+hWUroMR5J+tt9/VXTFjrGYewXX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785372485; c=relaxed/simple;
	bh=p1o9nHdqBIEmzwRhLvhdgmT5ujlyImk7jUbtTJjgS28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J20lRBSNaZgkGgn5igductV2bh9A0BxLXO1W+43GqSwpCir4mDvpVc5SymPHzf9RGUDUET9J7ErwwKMqjtYbxmaHpFKfm5dOyI7fPrixT5SfmqyWinL8hzbSs1L1GdLcHQbaCd+La4pMJ8K3x0sM7+CrLYa78+k9hg3ojXIO/rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VqENbWe5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VqENbWe5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785372483; x=1816908483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p1o9nHdqBIEmzwRhLvhdgmT5ujlyImk7jUbtTJjgS28=;
  b=VqENbWe5uW0+UP+jqZ17xFnATd0fcFmCHT7s9XGadVyf+FWWpk0EmSDG
   YvVumbC2mSEFRXRi9dIKEJwkrTf54u2UmCs3TLTV7XAOu6bESB25kYpJZ
   Zsjv3TKIgI9N2humTYVPrSUhn1bFsFRkVFMVSluPYHXfzafWclwfCgEEN
   JGgrCCFENbqbhcxt24h0+tiNoWdjeVSnmXeNN8iIgtyV9L1+s8c0TbP1T
   zhBvR7RkyZsqMcbYN4EW+wFADSvZlWJsEBimDnDKyi9CZql/nVggX4doh
   mohJ8syCMZeqT1RM+Yi9yzed3yAc367UcvuDNhfel49wuFn4M5h+wDyf3
   A==;
X-CSE-ConnectionGUID: VU+OsSYJTg2CPGddWh4ayg==
X-CSE-MsgGUID: Iuk4vxCPScmHr1LpLYUL+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85935348"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="85935348"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 17:48:03 -0700
X-CSE-ConnectionGUID: NvDJS+czSV2YP1waaDPLDQ==
X-CSE-MsgGUID: UKXZnaLhR1KgXnhKXyF8Vg==
X-ExtLoop1: 1
Received: from unknown (HELO DUT6094BMGFRD.fm.intel.com) ([10.80.55.54])
  by fmviesa003.fm.intel.com with ESMTP; 29 Jul 2026 17:48:03 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.auld@intel.com,
	gwan-gyeong.mun@intel.com,
	stable@vger.kernel.org,
	Jia Yao <jia.yao@intel.com>
Subject: [PATCH v4 2/3] drm/xe/guc_ads: allocate UM queues in VRAM on dGFX
Date: Thu, 30 Jul 2026 00:47:34 +0000
Message-ID: <20260730004735.344627-3-jia.yao@intel.com>
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

On dGFX the original ADS BO is explicitly migrated to VRAM by
xe_guc_realloc_post_hwconfig() so that xe_bo_main_addr() returns a
real device-physical address (DPA) rather than an IOMMU IOVA.  A
separate SYSTEM BO for the UM queues would not go through that migration
path, so its IOVA would differ from the physical address on systems
where pages are allocated above 4 GB.  GuC/GAM accesses the UM queue
ring via base_dpa (with_dpa=true on pre-Xe3p), so an incorrect DPA
causes all-zero fault descriptors to be forwarded to the driver.

Use XE_BO_FLAG_VRAM_IF_DGFX() for the UM queue BO so that on dGFX the
BO is allocated directly in VRAM and xe_bo_main_addr() returns the
correct DPA without needing a post-hwconfig migration step.

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
index 21cf3edef922..4023700ff2a9 100644
--- a/drivers/gpu/drm/xe/xe_guc.c
+++ b/drivers/gpu/drm/xe/xe_guc.c
@@ -714,12 +714,6 @@ static int xe_guc_realloc_post_hwconfig(struct xe_guc *guc)
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
index 7f371f9c7268..53636333fb45 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -409,11 +409,12 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
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

