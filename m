Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1BC340A6F
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 16:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590119; cv=none; b=WRSLaa1XHsXrkYO8JxAHgKsCo6jqyQVJ8o2QAvUpRteobkLXNLVixRMeMbUq/hwRpvRReAqX5qChHcBUZV2OFk04T9pAeJ+vNYFkbtzkbn1+zoETwcNvYf5zMmKGo29HEcYRo7YxG0Vj5q44gc5XhwsxkOnMr+x39eOmJT5UPsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590119; c=relaxed/simple;
	bh=FTJWmMeI4Kz3wqR8TPjgyQe/Aj5Zc03ZC6bM8nWyYK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3Zg+NMoZm1nYrAbPCKG0Mt9t8FgOUOxzHpu9iBY+1hbCeqgcEaOMbjaNg+vTEl6By8y6KsfIwepRGCWk8qNb6WJj0nMFH5zkdC0Ef//P3lc3XgEkYzLvb0SCzCaEq5DmVQgFJRYlrFFCcIE5LyUPMuI3fs6zhii0khsjm3d5MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M7BAGdbQ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M7BAGdbQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787590118; x=1819126118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FTJWmMeI4Kz3wqR8TPjgyQe/Aj5Zc03ZC6bM8nWyYK0=;
  b=M7BAGdbQ53wrtq3sWhLQKhR6mHmZ9sPbxafwn/4rI79YrLczVaVSaIx5
   5SjOrlT7m+YqeWQLHyX4GzpykehW9RVL8JHEEzAuJLHNFdWkjZhJ7ylLb
   hexjSWaY7kd8iphwr7rrN1loVfE/Ut1eZVV9iyLduXoQKgENrzUarb0h3
   EcnlOj2UU6izoDCBR8sJBliBK0jt0OXOGsFa+yvt3/H4QQRRW1i2aIABW
   BqfhxaFaSXsTEvjhPRdKvKn/ruFYMVeP3L/12sO8X0LNAldIFrvDaUrDG
   cV0fZxj12TiWfphTwh2BTseJCHMcg66kDJFILpAuHvEhjxXqNnu1thsyx
   g==;
X-CSE-ConnectionGUID: JbDdA8LTRxGwxmFOzKASfg==
X-CSE-MsgGUID: +RonV+xLRE6o3HyySIbsyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98722911"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98722911"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 09:48:37 -0700
X-CSE-ConnectionGUID: KiKGiegiSWC5b4M8oX6Dqw==
X-CSE-MsgGUID: aVyegrS1Qlaf7Z+qyje+Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="270839922"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.39])
  by orviesa004.jf.intel.com with ESMTP; 24 Aug 2026 09:48:38 -0700
From: Jia Yao <jia.yao@intel.com>
To: stable@vger.kernel.org
Cc: Jia Yao <jia.yao@intel.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 2/3] drm/xe/guc_ads: allocate UM queues in VRAM on dGFX
Date: Mon, 24 Aug 2026 16:48:27 +0000
Message-ID: <20260824164828.498481-2-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824164828.498481-1-jia.yao@intel.com>
References: <2026082055-unhinge-monstrous-7eeb@gregkh>
 <20260824164828.498481-1-jia.yao@intel.com>
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
(cherry picked from commit f342810a141f8a7e8b3786a6e4b6c0695a078a74)
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

