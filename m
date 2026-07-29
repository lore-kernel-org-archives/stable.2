Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43FE4570EE
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323512; cv=none; b=le+eTMxXYKNwZNYCYELYOily908UEVMW2YgFdk8XC2OV2Lt7xufSVYBwDL/oOjA7LN2N9Vu5eihYlHuHL7poRI/YRdVt1R13xFej/S8C23L+f9LRw6xoMupEsqssEQ7lKnu5JViEJbgUXextLHBIMn+LU5AVEQ+jzTALfL8fFA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323512; c=relaxed/simple;
	bh=Uw9HIMic1B5koHRyaQN9ZXoQUEymUbTZwf9kdSy5LDs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=K7tMokzIo9NiIkRPmu7s8BuLhCdVBon2KHmlvRcCT5mhMqFM9dSIopka7dMXDiYJ3uvDO2HCLjEk5tvx800YTi5DRgEOuckJA3NP5RctZrpk5qOFJvCUJlHg4OCI/b8VnlKkO44UJcOoc+5eT0dzjwJmLi2qPETfx4HiktMGFT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0JPzk96C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0JPzk96C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83541F00A3A;
	Wed, 29 Jul 2026 11:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785323510;
	bh=bffX5pidttfXHty6Vuuo9TeUY2bIODy2N6xI55fMLnw=;
	h=Subject:To:Cc:From:Date;
	b=0JPzk96CH6e36Yu9NXZpjvu+zqhK9H73zaSDeQ2z368nx0SBKesQbvErRppq73t7v
	 UNaUcGgOB5JPFcjk83bUjZAjRTUtLnsCf/3ICFio6bFhmum/FClPz/dCzChommUtyI
	 JMfp95rcwR6axd+vvNNxpAhwEsYsiHDJSz3Qrc6U=
Subject: FAILED: patch "[PATCH] drm/xe: Hold a dma-buf reference for imported BOs" failed to apply to 6.12-stable tree
To: nitin.r.gote@intel.com,christian.koenig@amd.com,matthew.auld@intel.com,thomas.hellstrom@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 13:11:25 +0200
Message-ID: <2026072925-decathlon-canopener-953d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 62775525a27c3b0d56382e08ba81ee2d322058b6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072925-decathlon-canopener-953d@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 62775525a27c3b0d56382e08ba81ee2d322058b6 Mon Sep 17 00:00:00 2001
From: Nitin Gote <nitin.r.gote@intel.com>
Date: Sat, 11 Jul 2026 00:40:28 +0530
Subject: [PATCH] drm/xe: Hold a dma-buf reference for imported BOs
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

v2:
  - Reworked the fix to avoid creating the imported sg BO before
    dma_buf_dynamic_attach() succeeds.
  - Attach with importer_priv == NULL and make invalidate_mappings ignore
    incomplete imports.

v3:
  - Dropped the xe-side reordering approach since importer_priv must be
    valid when dma_buf_dynamic_attach() publishes the attachment.
  - Per Christian's suggestion on the v1 thread, keyed the check on
    import_attach rather than removing the sg guard entirely.
  - Fixes both xe and amdgpu in a single TTM patch.

v4:
  - Moved import_attach check to after dma_resv_copy_fences() so fences
    are copied before returning for successful imports (Thomas).
  - Removed exporter-alive claim from commit message (Thomas).

v5:
  - Add drm/xe patch to keep imported sg BOs off the LRU before attach
    succeeds; the TTM fix alone is not sufficient for xe if the BO is
    already LRU-visible. (Thomas)
    v4 patch:
    https://patchwork.freedesktop.org/patch/736663/?series=169129&rev=2
  - Patch 1 (drm/ttm) carries Christian's Reviewed-by from v4.

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

v7:
  - Move changelog above --- so it stays in the commit message.
  - Reorder changelog entries oldest-to-newest. (Thomas)

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8023
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: stable@vger.kernel.org
Cc: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
Cc: Christian Konig <christian.koenig@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Suggested-by: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patch.msgid.link/20260710191027.260160-2-nitin.r.gote@intel.com
(cherry picked from commit 3516f3fae6be35642f8f06f8a218da6425c0306a)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 4c80bac67622..ddbaf4242c79 100644
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

