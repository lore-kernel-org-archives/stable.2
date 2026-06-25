Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B366B1D89EF
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 05:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782364880; cv=none; b=R2zF5En8CZSOgpd9LEBatCQfK6H3z7rJ/ia+BVkv2wPdCFLohhvrmm17Jn3i6Y2hSdWquiBJfaxLVVK4AV5IKTn6Ya8lRtOP948nAX0KiJCWMhVt/exCS9cH8ueEidFWAifhj1U4DuFNY1Q26f6qmX4Jiizm9VJHIM+MJc6sOoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782364880; c=relaxed/simple;
	bh=gYsM5zxBNKvNiFGNYcYNrn6JwgorvGz1VH4jZTyvu58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pRDChdwm5T36ScgkTHaDhNwgdsEf+JHTyxMTtM0TpbPGtDJWLogr+gT9JnsK80jB6NTyeNQ2CaI9RQXq4WVA0JgY9ar7o08ymk6W/JsiK86i+Bu1Gykt6B72IW6h0Zk/y2G75ov6fv9dEmiyJ6HKS1BG+zSRQuwG5cJZMk2dJz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=exjO5TuH; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exjO5TuH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782364879; x=1813900879;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gYsM5zxBNKvNiFGNYcYNrn6JwgorvGz1VH4jZTyvu58=;
  b=exjO5TuHa6vED3H+B6xhx0cx/B8Hh9nQe7+Wwp3RfS0KsF/S4dMRkr4a
   vsU8hhHRPQWhu8d+RyxnoQTOe3OHMoq+YOWfjwYj3qHBk7ITk0uaIR2m7
   vqIoD/cw3qyyytt85k9ez2T+f8I8a5ZW6ZWyk/i7SoN6/SVq+SLbndGsW
   vP2frPyUhzHRx7wTb1BOc0z6YjE6m4ubo8FSplJcG8YKYcrmbTXB0Fm1H
   XC8NRx15xjtp8ZJdl/todNXu0NqfAq4LU3yhEzmF9fTIEBZz2YY3xTWQo
   O/IhaQK6zV2SwtYMRdrxZE7feIa0dtpjcA6nTnNcrpfcc+ylK4hqDpTsv
   A==;
X-CSE-ConnectionGUID: t5fTBufAReWCx0aUrRPSnQ==
X-CSE-MsgGUID: KDaF2OckQZCTbNon4xgSHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="94532147"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="94532147"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 22:21:18 -0700
X-CSE-ConnectionGUID: F2IbV+htRj2bfZnEMoI+qg==
X-CSE-MsgGUID: mWHcRgS1Tgy+jt7BPxrwRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="254575067"
Received: from nitin-super-server.iind.intel.com ([10.190.238.72])
  by orviesa004.jf.intel.com with ESMTP; 24 Jun 2026 22:21:16 -0700
From: Nitin Gote <nitin.r.gote@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Nitin Gote <nitin.r.gote@intel.com>,
	stable@vger.kernel.org,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Christian Konig <christian.koenig@amd.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH] drm/ttm: Fix UAF on dma-buf attach failure for sg BOs
Date: Thu, 25 Jun 2026 11:27:35 +0530
Message-ID: <20260625055734.2831607-2-nitin.r.gote@intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Fix this by checking bo->base.import_attach, which is only set after
successful dma_buf_dynamic_attach(). Failed imports now individualize
normally, so delayed_delete operates on the BO's private _resv. The
exporter remains alive during individualize as it runs synchronously
in ttm_bo_release(), while the gem_prime_import caller still holds
its dma_buf reference.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8023
Fixes: d99fbd9aab62 ("drm/ttm: Always take the bo delayed cleanup path for imported bos")
Cc: stable@vger.kernel.org # v6.8+
Cc: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
Cc: Christian Konig <christian.koenig@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
---
v3:
- Dropped the xe-side reordering approach since importer_priv must be
  valid when dma_buf_dynamic_attach() publishes the attachment.
- Per Christian's suggestion on the v1 thread, keyed the check on
  import_attach rather than removing the sg guard entirely.
- Exporter lifetime: individualize runs synchronously inside
  ttm_bo_release(), called from drm_gem_object_put() in the
  gem_prime_import error path while drm_gem_prime_fd_to_handle()
  still holds its dma_buf reference.
- Fixes both xe and amdgpu in a single TTM patch.

 drivers/gpu/drm/ttm/ttm_bo.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index bcd76f6bb7f0..bf8eaec0e9ca 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -196,6 +196,14 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
 	if (bo->base.resv == &bo->base._resv)
 		return 0;
 
+	/*
+	 * Successfully imported sg BOs need the shared resv for dma-buf
+	 * cleanup. Failed imports have no attachment or mapping and can
+	 * use the private _resv.
+	 */
+	if (bo->type == ttm_bo_type_sg && bo->base.import_attach)
+		return 0;
+
 	BUG_ON(!dma_resv_trylock(&bo->base._resv));
 
 	r = dma_resv_copy_fences(&bo->base._resv, bo->base.resv);
@@ -203,15 +211,13 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
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

