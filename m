Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B592FF675
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787629358; cv=none; b=BD+PClG/IWimegKy2Ml80r9oBN9zGL2qIGKGgoG4yUCxRepomor3UfBFCbUSkHnllcwyu+mbahh4hQFfeBbZBeuhSjmkErEvcM5e5mn+pgp1N20Y32ueJ9sQKdiZzHWonQeQh9FDaJHBSDRF0gSCDQqJawi4MjXJtW2uEG/zaqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787629358; c=relaxed/simple;
	bh=BSAJWn5srkqf9/jXyzvu8cwTXPC4dEkPfKfPxuUQPPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4gGJjXkvtx0Sz7htUCQE1cIaeY3kTu3koYUTqE7JeUzhkQQfMsq+Hyd9cWD84pusJjS59cQ7Yihch0g10UJmI8H0oulnDZD/9F26EN8+XriFB1Ku3ehQVyQFNZtZkuqKdeGVzK39UjWTRdnORWz4B9edMGZIM73TgvNFpuD7z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0olAk/o; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0olAk/o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787629356; x=1819165356;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BSAJWn5srkqf9/jXyzvu8cwTXPC4dEkPfKfPxuUQPPc=;
  b=I0olAk/oW4E1U3e/6Wx+vh1E3l2omwwzrV9iyotlYxRpJahRTt0QKc/N
   t2yCkObFoTTz5e0uf4jT62hCkbEi0B3ObjL9QQroRfnT1pZcNTmtI1ec7
   UKZ2CACDsuc5430HVAQ0KTUc0HQLdRtj75izNOkp8pbBib/9ORtk6UPJm
   PmW9Holh2Jl5CYrLFEUESv7yFlyhFC6dYKfZz1sstmmWi/kgj+U5T73+j
   11dbEt+V2uf7g7oqZ4hh4SbCC4NMLWG+cGRah7LM78RkluCJyTI9hyOlk
   hsie0F0dnD1cyHWD8o3DovhLucfDbtUT96mjVEE05OFNp8hBvVPvLrZez
   w==;
X-CSE-ConnectionGUID: z5tK3hCyTXm3c6pZusrkfQ==
X-CSE-MsgGUID: yTNe/RPUR0amEj7JPkip+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="105469228"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="105469228"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 20:42:35 -0700
X-CSE-ConnectionGUID: 2/tpNHBUTIOqwhfbofTOwA==
X-CSE-MsgGUID: 6rapOUG5QvqiS8przQeNNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="267228496"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.39])
  by orviesa007.jf.intel.com with ESMTP; 24 Aug 2026 20:42:35 -0700
From: Jia Yao <jia.yao@intel.com>
To: stable@vger.kernel.org
Cc: Jia Yao <jia.yao@intel.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 6.18.y 2/3] drm/xe/guc_ads: allocate UM queues in VRAM on dGFX
Date: Tue, 25 Aug 2026 03:42:23 +0000
Message-ID: <20260825034224.642641-2-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825034224.642641-1-jia.yao@intel.com>
References: <2026082036-afterglow-tapered-84a0@gregkh>
 <20260825034224.642641-1-jia.yao@intel.com>
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
index cc5741f751b9..ae0c88da422b 100644
--- a/drivers/gpu/drm/xe/xe_guc.c
+++ b/drivers/gpu/drm/xe/xe_guc.c
@@ -700,12 +700,6 @@ static int xe_guc_realloc_post_hwconfig(struct xe_guc *guc)
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
index 806c2618a7cd..4c3e21b5e60e 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -392,15 +392,17 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
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

