Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47534363082
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 05:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782884977; cv=none; b=oSZUyy/sz1BP4iltr7DcuABynRnbCrDOvEpVGktySB6N0FREKTyf+P3Dst3DbOI+i4KRdna9O9xYJOtCCJtFwSyMwNR88HcDVhZxmB2qcwEyrYuZ4E5ZtIeiZ7cXrostDtsDqWcgo2KVB+oQDmvEaw0+DvYIdaIx3jGhszoruXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782884977; c=relaxed/simple;
	bh=v1ueM0dwe6N3NoizG/3DpBtYbUPxQDnS5+MX8TeAjmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dauTD4RYwBAAdCY/+OVDbiarXNoIW/k22C37rRPVqXzzAscAJIL33Axxm9z3rbWg9AxjU8+AStyetrP6Lx/Fg+WCEBDh1gVIubwdAbj32KcGqUUwDFtmblpgXfmZCd8AVprpDVobxY15wa70pNpE42/HGV2wyou1/XkHB4uqPdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqX89Ggl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqX89Ggl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782884977; x=1814420977;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v1ueM0dwe6N3NoizG/3DpBtYbUPxQDnS5+MX8TeAjmo=;
  b=lqX89GglZJznOOCgPb+6nl6d8tB3oOrBvO/BGRnbz950I3U3gaRt659t
   nUO9WxrFeVtcYTMt7I8+S2QFetqXLjekCzYOhB6MZ2bnuVD+aYVNDIvo0
   wtT/m/sICRuihF02sPsZefDEw6UIa6mr6hbFQKAH0I3/LIzkReuAv2gtA
   j92qoiEae6Ag3fGVHpCOBIhjxeI5lZh2YusGejXtRN/MGmGsH7vkpdC55
   wzeLAkU8GNFTXiEOGbOrLkFlUE2bhuy5LCInH3EREQQr9nH6884fL/jJi
   CuoZ0ECZoA7BBn/ZywJc55bMJknAETdE3YPwqUxd1ryDrxiYCE6l8IVcC
   A==;
X-CSE-ConnectionGUID: Hw3DgvUzSZC2fFr1juZ3wg==
X-CSE-MsgGUID: 0nVBPWQ3TGqfeJQDX9/+kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="87519362"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="87519362"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 22:49:36 -0700
X-CSE-ConnectionGUID: WUeu4p63SRKS5gWOuRkQDA==
X-CSE-MsgGUID: K/6vQlLiThe1xmDbEOa7OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="246119054"
Received: from nitin-super-server.iind.intel.com ([10.190.238.72])
  by fmviesa009.fm.intel.com with ESMTP; 30 Jun 2026 22:49:33 -0700
From: Nitin Gote <nitin.r.gote@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Nitin Gote <nitin.r.gote@intel.com>,
	stable@vger.kernel.org,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Christian Konig <christian.koenig@amd.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH] drm/ttm: Fix UAF on dma-buf attach failure for sg BOs
Date: Wed,  1 Jul 2026 11:56:00 +0530
Message-ID: <20260701062559.3731993-2-nitin.r.gote@intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a dma-buf importer creates a ttm_bo_type_sg BO with bo->base.resv
pointing at the exporter's dma_buf->resv and dma_buf_dynamic_attach()
fails, no dma_buf reference is held. The exporter can be freed before
the delayed_delete worker calls dma_resv_lock(bo->base.resv), causing a
use-after-free:

  Oops: general protection fault, probably for non-canonical address
        0x6b6b6b6b6b6b6b9c
  Workqueue: ttm ttm_bo_delayed_delete [ttm]
  RIP: 0010:mutex_can_spin_on_owner+0x3f/0xc0

ttm_bo_individualize_resv() skips the resv swap for all sg BOs to keep
the shared resv available for delayed_delete to release the dma-buf
mapping. A BO whose attach never succeeded has no mapping to release,
yet it keeps bo->base.resv pointing at the exporter resv that
delayed_delete later locks once the exporter is gone.

Fix this by checking bo->base.import_attach, which is set only after a
successful attach. The check is placed after dma_resv_copy_fences() so
successful imports still copy fences to _resv before returning, keeping
the shared resv for delayed_delete. Failed imports fall through to swap
resv to _resv, so delayed_delete never locks the stale exporter resv.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8023
Fixes: d99fbd9aab62 ("drm/ttm: Always take the bo delayed cleanup path for imported bos")
Cc: stable@vger.kernel.org # v6.8+
Cc: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
Cc: Christian Konig <christian.koenig@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
---
Hi Thomas/Christian,
Thank you for the review. Addressed the v3 review comments in this 
v4 version.

v4:
- Moved import_attach check to after dma_resv_copy_fences() so fences
  are copied before returning for successful imports (Thomas).
- Removed exporter-alive claim from commit message (Thomas).

v3:
- Dropped the xe-side reordering approach since importer_priv must be
  valid when dma_buf_dynamic_attach() publishes the attachment.
- Per Christian's suggestion on the v1 thread, keyed the check on
  import_attach rather than removing the sg guard entirely.
- Fixes both xe and amdgpu in a single TTM patch.

 drivers/gpu/drm/ttm/ttm_bo.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index bcd76f6bb7f0..9b6341f69805 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -203,15 +203,21 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
 	if (r)
 		return r;
 
-	if (bo->type != ttm_bo_type_sg) {
-		/* This works because the BO is about to be destroyed and nobody
-		 * reference it any more. The only tricky case is the trylock on
-		 * the resv object while holding the lru_lock.
-		 */
-		spin_lock(&bo->bdev->lru_lock);
-		bo->base.resv = &bo->base._resv;
-		spin_unlock(&bo->bdev->lru_lock);
-	}
+	/*
+	 * Successfully imported sg BOs need the shared resv for dma-buf
+	 * cleanup. Failed imports have no attachment or mapping and can
+	 * use the private _resv.
+	 */
+	if (bo->type == ttm_bo_type_sg && bo->base.import_attach)
+		return 0;
+
+	/* This works because the BO is about to be destroyed and nobody
+	 * references it any more. The only tricky case is the trylock on
+	 * the resv object while holding the lru_lock.
+	 */
+	spin_lock(&bo->bdev->lru_lock);
+	bo->base.resv = &bo->base._resv;
+	spin_unlock(&bo->bdev->lru_lock);
 
 	return r;
 }
-- 
2.50.1

