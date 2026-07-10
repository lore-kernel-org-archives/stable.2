Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE33C2E7369
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674046; cv=none; b=YyN8Mj+l+CrT/hO7+6lj4QtOlqbY2Pqi4jhGNEVC/ErqWT/gQefv5z6hPSO+D9UXwiuXl7PcQ6/HHqdjXZUy5AnoBlibT+hjoqdiQhTF/e5/Wf5Coa6DJFxrNCBHrOl4O7xtJbyU8DJKot9EEJgw6KSWiaIkOne9uLq+SZ72Dyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674046; c=relaxed/simple;
	bh=t/e+U3Z0wpXRkH0IrSd7f7tFJ2iGfunn4K2GwdPJuO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jSxvuq+L5O4rcB+iK0HYJoe6nixCDjFNhUtSyMx3AWHqHEKBsucR+xiEy17F5s++ZRt1fUOkpRMr5fJeH+2zUzOjvVTj6KJSYCjrrvs2l3PQejODDl0KoocW1qcmFg5MJNLAHrBPw//XvvYpnWKfW1LbhbpdMFMNydiX5y2/FvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fmhf7kX4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fmhf7kX4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783674044; x=1815210044;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t/e+U3Z0wpXRkH0IrSd7f7tFJ2iGfunn4K2GwdPJuO4=;
  b=fmhf7kX4ambZeeHDHDS5j1MLgWrWpyeeevkdEbf47Y4s7PoFWD+HxW8S
   zU1Tg7dBdHyPtwZgw2d9PKfFhmsAA/qM3Z+sKDkJD73eWL1Pgj6CmzuCD
   uth3sUIR+zyobBZuoXvL2m0zN5wRDMWvQwZGQAYNzD7aBlOUZ7tJV2kSd
   mRED3WPv0cL+wmVy9F5aAY9wEtj8oicFWVbc1eD43XGq4N68RW4UShAj8
   mFKpUU6KlZA90zt0rpG0O3/hQ8ATiDVb11ppM99EEjuqjrdI80nbqZWP1
   Rxa0YRtfY9onFpdjWn0+eqmQDAnKsC3bPZk7uROYeL7tyie9K0unEKRpw
   A==;
X-CSE-ConnectionGUID: mvu6po4SSjuvgBr6Dy8btQ==
X-CSE-MsgGUID: xyOtphtnQYCLnYynVpjjOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84342695"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84342695"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 02:00:44 -0700
X-CSE-ConnectionGUID: THqrvSopSAa9MYEXiKGltQ==
X-CSE-MsgGUID: M5Cv1rmpR8Kwf43iY35Gsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="279243958"
Received: from nitin-super-server.iind.intel.com ([10.190.238.72])
  by fmviesa001.fm.intel.com with ESMTP; 10 Jul 2026 02:00:41 -0700
From: Nitin Gote <nitin.r.gote@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Nitin Gote <nitin.r.gote@intel.com>,
	stable@vger.kernel.org,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Christian Konig <christian.koenig@amd.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH] drm/xe: Hold a dma-buf reference for imported BOs
Date: Fri, 10 Jul 2026 15:07:27 +0530
Message-ID: <20260710093726.43324-2-nitin.r.gote@intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

An imported dma-buf BO is created as a ttm_bo_type_sg BO whose
reservation object is the exporter's dma_buf->resv. The importer,
however, only takes a dma-buf reference after a successful
dma_buf_dynamic_attach(). Until then nothing keeps the exporter alive,
so if the exporter is freed while the BO still references its resv, a
later access to that resv is a use-after-free:

  Oops: general protection fault, probably for non-canonical address
        0x6b6b6b6b6b6b6b9c
  Workqueue: ttm ttm_bo_delayed_delete [ttm]
  RIP: 0010:mutex_can_spin_on_owner+0x3f/0xc0

This can be reached on two paths:

 - dma_buf_dynamic_attach() fails, or
 - ttm_bo_init_reserved() fails during BO creation.

In both cases the BO already has bo->base.resv pointing at the exporter
resv, and sg BOs are always torn down via ttm_bo_delayed_delete(), which
locks bo->base.resv asynchronously - potentially after the exporter has
been freed.

Take the dma-buf reference in xe_bo_init_locked(), before
ttm_bo_init_reserved(), so it also covers a creation failure there, and
release it in xe_ttm_bo_destroy(). The reference is held for the whole
BO lifetime, keeping the shared resv alive on every path.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8023
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: stable@vger.kernel.org
Cc: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
Cc: Christian Konig <christian.koenig@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Suggested-by: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
---
Thank you Thomas for suggesting this simpler approach over the earlier
TTM/LRU handling.

v6:
 - Reworked the fix based on Thomas' suggestion. Instead of the TTM resv
   individualization (v1-v5) plus the xe off-LRU/placement handling (v5),
   just hold a dma-buf reference for the imported BO lifetime so the
   shared resv can never be freed while the BO still references it.
   Single xe patch, no TTM change. (Thomas)
 - Take the reference in xe_bo_init_locked() before ttm_bo_init_reserved()
   so a TTM creation failure is covered too (Thomas).
 - Dropped the v5 series (drm/ttm + drm/xe off-LRU); the off-LRU approach
   also regressed in CI BAT via ttm_bo_pipeline_gutting() creating a ghost
   BO that outlived the exporter.
   Link to v5: https://patchwork.freedesktop.org/series/169984/
   
v5:
 - Add drm/xe patch to keep imported sg BOs off the LRU before attach
   succeeds; the TTM fix alone is not sufficient for xe if the BO is
   already LRU-visible. (Thomas)
   v4 patch:
   https://patchwork.freedesktop.org/patch/736663/?series=169129&rev=2
  - Patch 1 (drm/ttm) carries Christian's Reviewed-by from v4.

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


 drivers/gpu/drm/xe/xe_bo.c       | 24 ++++++++++++++++++++----
 drivers/gpu/drm/xe/xe_bo.h       |  3 ++-
 drivers/gpu/drm/xe/xe_bo_types.h |  2 ++
 drivers/gpu/drm/xe/xe_dma_buf.c  |  2 +-
 4 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 85e6d9a0f575..ae730bd6f4b2 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1349,7 +1349,7 @@ int xe_bo_notifier_prepare_pinned(struct xe_bo *bo)
 		backup = xe_bo_init_locked(xe, NULL, NULL, bo->ttm.base.resv, NULL, xe_bo_size(bo),
 					   DRM_XE_GEM_CPU_CACHING_WB, ttm_bo_type_kernel,
 					   XE_BO_FLAG_SYSTEM | XE_BO_FLAG_NEEDS_CPU_ACCESS |
-					   XE_BO_FLAG_PINNED, &exec);
+					   XE_BO_FLAG_PINNED, NULL, &exec);
 		if (IS_ERR(backup)) {
 			drm_exec_retry_on_contention(&exec);
 			ret = PTR_ERR(backup);
@@ -1490,7 +1490,7 @@ int xe_bo_evict_pinned(struct xe_bo *bo)
 						   xe_bo_size(bo),
 						   DRM_XE_GEM_CPU_CACHING_WB, ttm_bo_type_kernel,
 						   XE_BO_FLAG_SYSTEM | XE_BO_FLAG_NEEDS_CPU_ACCESS |
-						   XE_BO_FLAG_PINNED, &exec);
+						   XE_BO_FLAG_PINNED, NULL, &exec);
 			if (IS_ERR(backup)) {
 				drm_exec_retry_on_contention(&exec);
 				ret = PTR_ERR(backup);
@@ -1826,6 +1826,8 @@ static void xe_ttm_bo_destroy(struct ttm_buffer_object *ttm_bo)
 
 	if (bo->ttm.base.import_attach)
 		drm_prime_gem_destroy(&bo->ttm.base, NULL);
+	if (bo->dma_buf)
+		dma_buf_put(bo->dma_buf);
 	drm_gem_object_release(&bo->ttm.base);
 
 	xe_assert(xe, list_empty(&ttm_bo->base.gpuva.list));
@@ -2283,6 +2285,8 @@ void xe_bo_free(struct xe_bo *bo)
  * @cpu_caching: The cpu caching used for system memory backing store.
  * @type: The TTM buffer object type.
  * @flags: XE_BO_FLAG_ flags.
+ * @dma_buf: The dma-buf to reference for the BO lifetime (imported BOs),
+ * or NULL.
  * @exec: The drm_exec transaction to use for exhaustive eviction.
  *
  * Initialize or create an xe buffer object. On failure, any allocated buffer
@@ -2294,7 +2298,8 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
 				struct xe_tile *tile, struct dma_resv *resv,
 				struct ttm_lru_bulk_move *bulk, size_t size,
 				u16 cpu_caching, enum ttm_bo_type type,
-				u32 flags, struct drm_exec *exec)
+				u32 flags, struct dma_buf *dma_buf,
+				struct drm_exec *exec)
 {
 	struct ttm_operation_ctx ctx = {
 		.interruptible = true,
@@ -2383,6 +2388,17 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
 	placement = (type == ttm_bo_type_sg ||
 		     bo->flags & XE_BO_FLAG_DEFER_BACKING) ? &sys_placement :
 		&bo->placement;
+
+	/*
+	 * For imported BOs, keep the exporter dma-buf alive for the BO
+	 * lifetime. Taken before ttm_bo_init_reserved() to also cover a
+	 * creation failure there. Released in xe_ttm_bo_destroy().
+	 */
+	if (dma_buf) {
+		get_dma_buf(dma_buf);
+		bo->dma_buf = dma_buf;
+	}
+
 	err = ttm_bo_init_reserved(&xe->ttm, &bo->ttm, type,
 				   placement, alignment,
 				   &ctx, NULL, resv, xe_ttm_bo_destroy);
@@ -2500,7 +2516,7 @@ __xe_bo_create_locked(struct xe_device *xe,
 			       vm && !xe_vm_in_fault_mode(vm) &&
 			       flags & XE_BO_FLAG_USER ?
 			       &vm->lru_bulk_move : NULL, size,
-			       cpu_caching, type, flags, exec);
+			       cpu_caching, type, flags, NULL, exec);
 	if (IS_ERR(bo))
 		return bo;
 
diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index 6340317f7d2e..7ae1d9ac0574 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -118,7 +118,8 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
 				struct xe_tile *tile, struct dma_resv *resv,
 				struct ttm_lru_bulk_move *bulk, size_t size,
 				u16 cpu_caching, enum ttm_bo_type type,
-				u32 flags, struct drm_exec *exec);
+				u32 flags, struct dma_buf *dma_buf,
+				struct drm_exec *exec);
 struct xe_bo *xe_bo_create_locked(struct xe_device *xe, struct xe_tile *tile,
 				  struct xe_vm *vm, size_t size,
 				  enum ttm_bo_type type, u32 flags,
diff --git a/drivers/gpu/drm/xe/xe_bo_types.h b/drivers/gpu/drm/xe/xe_bo_types.h
index fcc63ae3f455..e45f24301050 100644
--- a/drivers/gpu/drm/xe/xe_bo_types.h
+++ b/drivers/gpu/drm/xe/xe_bo_types.h
@@ -36,6 +36,8 @@ struct xe_bo {
 	struct xe_bo *backup_obj;
 	/** @parent_obj: Ref to parent bo if this a backup_obj */
 	struct xe_bo *parent_obj;
+	/** @dma_buf: Imported dma-buf ref to keep its resv alive. */
+	struct dma_buf *dma_buf;
 	/** @flags: flags for this buffer object */
 	u32 flags;
 	/** @vm: VM this BO is attached to, for extobj this will be NULL */
diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index 8a920e58245c..bf0728838ead 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -302,7 +302,7 @@ xe_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
 
 		bo = xe_bo_init_locked(xe, NULL, NULL, resv, NULL, dma_buf->size,
 				       0, /* Will require 1way or 2way for vm_bind */
-				       ttm_bo_type_sg, XE_BO_FLAG_SYSTEM, &exec);
+				       ttm_bo_type_sg, XE_BO_FLAG_SYSTEM, dma_buf, &exec);
 		drm_exec_retry_on_contention(&exec);
 		if (IS_ERR(bo)) {
 			ret = PTR_ERR(bo);
-- 
2.50.1

