Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C16302146
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787629315; cv=none; b=Cafbjr9RRAGPTMoBgWiry9Vc7PtrRFbbHmiBnAgRedDcptamC4+i5iy9SeGmFJ7EcNydbAGjoHgyGZ1fTZUbG6fzToDF0OgK4u/BGiH6nJRu35F8MnKncNtKP3dlHhjOW0ztSf7DHerRqlTNdrAezcyCzUCd0kF5KVUlKYL0s1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787629315; c=relaxed/simple;
	bh=p4YaERHiWD54g86AkyQIFAOW31S/LR0GVuy0PYB+SyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBOoZnJmMwHf3659NPk0UQq9XXrPPCXErLPBlBpfBP6oE9qkZABLqzc3glj7JqgaqbQnNtsZEB6cwYSO9Dl5lnhsx9ypiKRELG0Wo8YHGev5rFiTrSSVXXL7Nv4ooW4/10T+wP2V5CFoLydA0W05bDelfvL1YS6nidZ8C/2455s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j32O1dYh; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j32O1dYh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787629314; x=1819165314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p4YaERHiWD54g86AkyQIFAOW31S/LR0GVuy0PYB+SyY=;
  b=j32O1dYh6IEA2KH4+nkviWWdKX/jNa7MyOTtXhH4Tm8Tgc8kWTqNZseA
   LoVRZOVlLQXoUKzyO5lRwC/2y/eFz/QoFiMR88rlW1jndvvTPTg/z209G
   o6EzYzcpzR+ruGXjBrGiwOoj22Q8icY9cw1fX++H6A93yGcYG+tNnQdHR
   vsmnz8nK2aFdhPiYUDKINWG9PnBXv1voOexfHLkvgi3Og5Lzhp10URinz
   wIvf71Pi5eY6+M6T87KcP0X+S5wgV6UWCGTXpSn6mtJij59VBakQ2wH0W
   VmtgcbxYz9hRoPEPqmgVdxdKcyhefnJgJVMyMw5ulElEj3OtINru0zTN9
   g==;
X-CSE-ConnectionGUID: H/6n95/TQu6rojKA05I69A==
X-CSE-MsgGUID: R1EW+dAURFmqjpz9341KOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="91767789"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="91767789"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 20:41:54 -0700
X-CSE-ConnectionGUID: MkAexTvjRIagUGyQKoYJbg==
X-CSE-MsgGUID: jkWUTwi/TKeh1uODTgUzHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="266632674"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.39])
  by orviesa008.jf.intel.com with ESMTP; 24 Aug 2026 20:41:53 -0700
From: Jia Yao <jia.yao@intel.com>
To: stable@vger.kernel.org
Cc: Jia Yao <jia.yao@intel.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 6.12.y 2/3] drm/xe/guc_ads: allocate UM queues in VRAM on dGFX
Date: Tue, 25 Aug 2026 03:41:12 +0000
Message-ID: <20260825034113.642528-2-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825034113.642528-1-jia.yao@intel.com>
References: <2026082037-mutual-coroner-efeb@gregkh>
 <20260825034113.642528-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patch.msgid.link/20260804165057.129529-3-jia.yao@intel.com
(cherry picked from commit ace076ef0a854ab5940bacc539bf66afd61d118c)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_guc.c     | 6 ------
 drivers/gpu/drm/xe/xe_guc_ads.c | 8 +++++---
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
index 75ab0730c6cc..bedd9894e182 100644
--- a/drivers/gpu/drm/xe/xe_guc.c
+++ b/drivers/gpu/drm/xe/xe_guc.c
@@ -293,12 +293,6 @@ static int xe_guc_realloc_post_hwconfig(struct xe_guc *guc)
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
index 1bb74e04ed77..35168447a90b 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -400,15 +400,17 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
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

