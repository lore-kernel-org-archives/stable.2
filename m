Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4953A3C0637
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 23:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787700689; cv=none; b=VpEvxpVzVPC97EABaAHPzJsZuWzq8Q98OozhYUpVFDSIG81J4Fy7i0C1jAG52pNRMEHNdTcvClZ9aLjhLUPzZIumdFzxtM7iI5jreL4yOgA+/7qgBue+wvNK/WnrhGrKQlWAz62C9WxzoUlZRXib2c6VyRxkLa2sEM3KHYkKlRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787700689; c=relaxed/simple;
	bh=KkG6n8vavfeqlovIvNo37KxYZ+Y5l0hXnO2jU5rpx7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZjwC6011jnBXpA591oJ0+l52OiSlulAR8azoXnSTdPhogY+tlhGq1kDiSpio14JnnbX68wt1rsUHFDp555xzsPcLGKtdesjQjqyA15fsEH8ON1+FYUZu+HVzrwJBd6aFAEO7IrZw+ZSbIjrYX/SlFUgkiW3kS+8PgLzMuwJl3fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VD+cDhPb; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VD+cDhPb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787700687; x=1819236687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KkG6n8vavfeqlovIvNo37KxYZ+Y5l0hXnO2jU5rpx7Y=;
  b=VD+cDhPbrOdn3ZQ2qdrEmoRSlkGR0wURUoc2B5ko+mksK8dqXY5VuWTJ
   ydP2zgKXMdvQ5n/oCWNXPxX5Kq/HOCgUVpmjMFG93M+/MCQjWw03Uya4M
   M/8wRbkElzpUfwhzt5wsDwSK4anHnrHbYmHoAKlgLnN0LEncRZzb0s9Ph
   0fhsxyNYBv9MgcPoX4poUazjyTBoOsDMlVa+fXQQY/jHpNr8k2ieixHqi
   anWC4Z1xbJ854nNEo92m8nfmQXB/U3gx6r5ka5sX79mP5xD77Re4MpkBe
   kLDI3tNL8LXY0Fki2yiyGHdX3n3Yeyd462t4bMza8c3u/F0FPZkFGSdvP
   w==;
X-CSE-ConnectionGUID: iZACij08TAmtzJI5+9QaPQ==
X-CSE-MsgGUID: 3oFEU++XST271ob4XWHz9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="99335331"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="99335331"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 16:31:27 -0700
X-CSE-ConnectionGUID: ituqUMiYQZWwWRGUo/jxBQ==
X-CSE-MsgGUID: KHDXko3gS2iS8QzRAMUUIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="290941875"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.39])
  by fmviesa002.fm.intel.com with ESMTP; 25 Aug 2026 16:31:27 -0700
From: Jia Yao <jia.yao@intel.com>
To: stable@vger.kernel.org
Cc: Jia Yao <jia.yao@intel.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 6.18.y 2/3] drm/xe/guc_ads: allocate UM queues in VRAM on dGFX
Date: Tue, 25 Aug 2026 23:30:52 +0000
Message-ID: <20260825233053.1504506-2-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825233053.1504506-1-jia.yao@intel.com>
References: <2026082036-afterglow-tapered-84a0@gregkh>
 <20260825233053.1504506-1-jia.yao@intel.com>
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
(cherry picked from commit f342810a141f8a7e8b3786a6e4b6c0695a078a74)
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
index 86e6651c0036..4f48356ae622 100644
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

