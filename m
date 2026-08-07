Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A93E472F89
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110239; cv=none; b=oOwc0++n7Hoj+ZdD4RgWPyjm19YBAqQWhoSKpkcoRfVNWE1jaobdyR+HymA9zrpg4C1O4IJZ+jmvlhaGpzvtz2sVw+UrO3YNpUaUrKzYP5FeN5XZpCxR8LDGoYQwztBGqrhnPA/Bxl+tJLhjQeuqeoo4vIy7hIdsSDMSPGufToE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110239; c=relaxed/simple;
	bh=SuPXigULcYWu8QpdlSlz5DlxLYvsem6CX551x8tRob4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=G4EGEUFHqAg1GbCBy0zHOZnQMC4Pf7WjrUXpXgW5KzLYkNnrnItj+YaxEEOE2MvuodQlTKoo9HmbnqIWkE8/K3HY1AkRN00XLTDgys74bK8dReOER3iv1l1ONcxWHgngr3vt6w0xm3LMO/HPsVYHyG9pbT6b2FfxTeEVRqgMdwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MfKvb+k7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MfKvb+k7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C461F000E9;
	Fri,  7 Aug 2026 13:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786110233;
	bh=H71VNCq+dM3hZoTI3hA6tPZ6m/cu4gwk+lB0TiJlXpg=;
	h=Subject:To:Cc:From:Date;
	b=MfKvb+k7CD9UK8ZrmuUGJEnqHDKXFbtMPrcwneZzXgVn8lXIo6x8SGtWm7ox/uzMC
	 vuec7i9LySpgzPU90JekfFTgIfNnaUrtgyLvgcufpxRTfERwDB1DDheG7h63xaK6Eo
	 XFK3UKdi40nqn36QqCHZjz6RNimEYI+XYKd14REQ=
Subject: FAILED: patch "[PATCH] drm/xe/madvise: Track purgeability with BO-local counters" failed to apply to 6.18-stable tree
To: arvind.yadav@intel.com,himal.prasad.ghimiray@intel.com,matthew.brost@intel.com,thomas.hellstrom@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 07 Aug 2026 15:43:35 +0200
Message-ID: <2026080735-robe-unease-fe3b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 23fb2ea56cb4fa2587bc072b04e4e698687a48e4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080735-robe-unease-fe3b@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 23fb2ea56cb4fa2587bc072b04e4e698687a48e4 Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav@intel.com>
Date: Wed, 6 May 2026 18:50:27 +0530
Subject: [PATCH] drm/xe/madvise: Track purgeability with BO-local counters
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

xe_bo_recompute_purgeable_state() walks all VMAs of a BO to determine
whether the BO can be made purgeable. This makes VMA create/destroy and
madvise updates O(n) in the number of mappings.

Replace the walk with BO-local counters protected by the BO dma-resv
lock:

  - vma_count tracks the number of VMAs mapping the BO.
  - willneed_count tracks active WILLNEED holders, including WILLNEED
    VMAs and active dma-buf exports for non-imported BOs.

A DONTNEED BO is promoted back to WILLNEED on a 0->1 transition of
willneed_count. A BO is demoted to DONTNEED on a 1->0 transition only
when it still has VMAs, preserving the previous behaviour where a BO
with no mappings keeps its current madvise state.

PURGED remains terminal, preserving the existing "once purged, always
purged" rule.

Fixes: 4f44961eab84 ("drm/xe/vm: Prevent binding of purged buffer objects")

v2:
  - Use early return for imported BOs in all four helpers to avoid
    nesting (Matt B).
  - Group purgeability state into a purgeable sub-struct on struct
    xe_bo (Matt B).
  - Reword xe_bo_willneed_put_locked() kernel-doc to explain that a 1->0
    transition means all remaining active VMAs are DONTNEED (Matt B).

v3:
  - Move DONTNEED/PURGED reject from vma_lock_and_validate() into
    xe_vma_create(), gated on attr->purgeable_state == WILLNEED.
    Fixes vm_bind bypass and partial-unbind rejection on DONTNEED
    BOs (Matt B).
  - Drop .check_purged from MAP and REMAP; keep it for PREFETCH and
    add a comment why (Matt B).
  - Skip BO validation in vma_lock_and_validate() for non-WILLNEED
    VMA remnants so cleanup/remap paths do not repopulate
    DONTNEED/PURGED BOs.

Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20260506132027.2556046-1-arvind.yadav@intel.com
Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 5ce60d161e09..eaa3a4ee9111 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -884,10 +884,10 @@ void xe_bo_set_purgeable_state(struct xe_bo *bo,
 		  new_state == XE_MADV_PURGEABLE_PURGED);
 
 	/* Once purged, always purged - cannot transition out */
-	xe_assert(xe, !(bo->madv_purgeable == XE_MADV_PURGEABLE_PURGED &&
+	xe_assert(xe, !(bo->purgeable.state == XE_MADV_PURGEABLE_PURGED &&
 			new_state != XE_MADV_PURGEABLE_PURGED));
 
-	bo->madv_purgeable = new_state;
+	bo->purgeable.state = new_state;
 	xe_bo_set_purgeable_shrinker(bo, new_state);
 }
 
@@ -2355,7 +2355,7 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
 	INIT_LIST_HEAD(&bo->vram_userfault_link);
 
 	/* Initialize purge advisory state */
-	bo->madv_purgeable = XE_MADV_PURGEABLE_WILLNEED;
+	bo->purgeable.state = XE_MADV_PURGEABLE_WILLNEED;
 
 	drm_gem_private_object_init(&xe->drm, &bo->ttm.base, size);
 
diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index 68dea7d25a6b..6340317f7d2e 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -251,7 +251,7 @@ static inline bool xe_bo_is_protected(const struct xe_bo *bo)
 static inline bool xe_bo_is_purged(struct xe_bo *bo)
 {
 	xe_bo_assert_held(bo);
-	return bo->madv_purgeable == XE_MADV_PURGEABLE_PURGED;
+	return bo->purgeable.state == XE_MADV_PURGEABLE_PURGED;
 }
 
 /**
@@ -268,11 +268,95 @@ static inline bool xe_bo_is_purged(struct xe_bo *bo)
 static inline bool xe_bo_madv_is_dontneed(struct xe_bo *bo)
 {
 	xe_bo_assert_held(bo);
-	return bo->madv_purgeable == XE_MADV_PURGEABLE_DONTNEED;
+	return bo->purgeable.state == XE_MADV_PURGEABLE_DONTNEED;
 }
 
 void xe_bo_set_purgeable_state(struct xe_bo *bo, enum xe_madv_purgeable_state new_state);
 
+/**
+ * xe_bo_willneed_get_locked() - Acquire a WILLNEED holder on a BO
+ * @bo: Buffer object
+ *
+ * Increments willneed_count and, on a 0->1 transition, promotes the BO
+ * from DONTNEED to WILLNEED. PURGED is terminal and is never modified.
+ *
+ * Caller must hold the BO's dma-resv lock.
+ */
+static inline void xe_bo_willneed_get_locked(struct xe_bo *bo)
+{
+	xe_bo_assert_held(bo);
+
+	/* Imported BOs are owned externally; do not track purgeability. */
+	if (drm_gem_is_imported(&bo->ttm.base))
+		return;
+
+	if (bo->purgeable.willneed_count++ == 0 && xe_bo_madv_is_dontneed(bo))
+		xe_bo_set_purgeable_state(bo, XE_MADV_PURGEABLE_WILLNEED);
+}
+
+/**
+ * xe_bo_willneed_put_locked() - Release a WILLNEED holder on a BO
+ * @bo: Buffer object
+ *
+ * Decrements willneed_count and, on a 1->0 transition, marks the BO
+ * DONTNEED only if it still has VMAs (implying all active VMAs are
+ * DONTNEED). If the last VMA is being removed, preserve the current BO
+ * state to match the previous VMA-walk semantics.
+ *
+ * PURGED is terminal and the BO state is never modified.
+ *
+ * Caller must hold the BO's dma-resv lock.
+ */
+static inline void xe_bo_willneed_put_locked(struct xe_bo *bo)
+{
+	xe_bo_assert_held(bo);
+
+	if (drm_gem_is_imported(&bo->ttm.base))
+		return;
+
+	xe_assert(xe_bo_device(bo), bo->purgeable.willneed_count > 0);
+	if (--bo->purgeable.willneed_count == 0 && bo->purgeable.vma_count > 0 &&
+	    !xe_bo_is_purged(bo))
+		xe_bo_set_purgeable_state(bo, XE_MADV_PURGEABLE_DONTNEED);
+}
+
+/**
+ * xe_bo_vma_count_inc_locked() - Account a new VMA on a BO
+ * @bo: Buffer object
+ *
+ * Increments vma_count.
+ *
+ * Caller must hold the BO's dma-resv lock.
+ */
+static inline void xe_bo_vma_count_inc_locked(struct xe_bo *bo)
+{
+	xe_bo_assert_held(bo);
+
+	if (drm_gem_is_imported(&bo->ttm.base))
+		return;
+
+	bo->purgeable.vma_count++;
+}
+
+/**
+ * xe_bo_vma_count_dec_locked() - Account a VMA removal on a BO
+ * @bo: Buffer object
+ *
+ * Decrements vma_count.
+ *
+ * Caller must hold the BO's dma-resv lock.
+ */
+static inline void xe_bo_vma_count_dec_locked(struct xe_bo *bo)
+{
+	xe_bo_assert_held(bo);
+
+	if (drm_gem_is_imported(&bo->ttm.base))
+		return;
+
+	xe_assert(xe_bo_device(bo), bo->purgeable.vma_count > 0);
+	bo->purgeable.vma_count--;
+}
+
 static inline void xe_bo_unpin_map_no_vm(struct xe_bo *bo)
 {
 	if (likely(bo)) {
diff --git a/drivers/gpu/drm/xe/xe_bo_types.h b/drivers/gpu/drm/xe/xe_bo_types.h
index 9c199badd9b2..fcc63ae3f455 100644
--- a/drivers/gpu/drm/xe/xe_bo_types.h
+++ b/drivers/gpu/drm/xe/xe_bo_types.h
@@ -111,10 +111,32 @@ struct xe_bo {
 	u64 min_align;
 
 	/**
-	 * @madv_purgeable: user space advise on BO purgeability, protected
-	 * by BO's dma-resv lock.
+	 * @purgeable: Purgeability state and accounting.
+	 *
+	 * All fields are protected by the BO's dma-resv lock.
 	 */
-	u32 madv_purgeable;
+	struct {
+		/**
+		 * @purgeable.state: BO purgeability state
+		 *                   (WILLNEED/DONTNEED/PURGED).
+		 */
+		u32 state;
+
+		/**
+		 * @purgeable.vma_count: Number of VMAs currently mapping this BO.
+		 */
+		u32 vma_count;
+
+		/**
+		 * @purgeable.willneed_count: Number of active WILLNEED holders.
+		 *
+		 * Counts WILLNEED VMAs plus active dma-buf exports for
+		 * non-imported BOs. The BO flips to DONTNEED on a 1->0
+		 * transition only when VMAs still exist; if the last VMA is
+		 * removed, the previous BO state is preserved.
+		 */
+		u32 willneed_count;
+	} purgeable;
 };
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index b9828da15897..855d32ba314d 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -193,6 +193,18 @@ static int xe_dma_buf_begin_cpu_access(struct dma_buf *dma_buf,
 	return 0;
 }
 
+static void xe_dma_buf_release(struct dma_buf *dmabuf)
+{
+	struct drm_gem_object *obj = dmabuf->priv;
+	struct xe_bo *bo = gem_to_xe_bo(obj);
+
+	xe_bo_lock(bo, false);
+	xe_bo_willneed_put_locked(bo);
+	xe_bo_unlock(bo);
+
+	drm_gem_dmabuf_release(dmabuf);
+}
+
 static const struct dma_buf_ops xe_dmabuf_ops = {
 	.attach = xe_dma_buf_attach,
 	.detach = xe_dma_buf_detach,
@@ -200,7 +212,7 @@ static const struct dma_buf_ops xe_dmabuf_ops = {
 	.unpin = xe_dma_buf_unpin,
 	.map_dma_buf = xe_dma_buf_map,
 	.unmap_dma_buf = xe_dma_buf_unmap,
-	.release = drm_gem_dmabuf_release,
+	.release = xe_dma_buf_release,
 	.begin_cpu_access = xe_dma_buf_begin_cpu_access,
 	.mmap = drm_gem_dmabuf_mmap,
 	.vmap = drm_gem_dmabuf_vmap,
@@ -241,18 +253,26 @@ struct dma_buf *xe_gem_prime_export(struct drm_gem_object *obj, int flags)
 		ret = -EINVAL;
 		goto out_unlock;
 	}
+
+	xe_bo_willneed_get_locked(bo);
 	xe_bo_unlock(bo);
 
 	ret = ttm_bo_setup_export(&bo->ttm, &ctx);
 	if (ret)
-		return ERR_PTR(ret);
+		goto out_put;
 
 	buf = drm_gem_prime_export(obj, flags);
-	if (!IS_ERR(buf))
-		buf->ops = &xe_dmabuf_ops;
+	if (IS_ERR(buf)) {
+		ret = PTR_ERR(buf);
+		goto out_put;
+	}
 
+	buf->ops = &xe_dmabuf_ops;
 	return buf;
 
+out_put:
+	xe_bo_lock(bo, false);
+	xe_bo_willneed_put_locked(bo);
 out_unlock:
 	xe_bo_unlock(bo);
 	return ERR_PTR(ret);
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index c3836f6eab35..e5db3e25849c 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1120,6 +1120,25 @@ static struct xe_vma *xe_vma_create(struct xe_vm *vm,
 
 		xe_bo_assert_held(bo);
 
+		/*
+		 * Reject only WILLNEED mappings on DONTNEED/PURGED BOs. This
+		 * gates new vm_bind ioctls (user supplies WILLNEED) while
+		 * still allowing partial-unbind / remap splits whose new VMAs
+		 * inherit the parent's DONTNEED attr. It must also run before
+		 * xe_bo_willneed_get_locked() below so a 0->1 holder bump
+		 * cannot silently promote DONTNEED back to WILLNEED.
+		 */
+		if (vma->attr.purgeable_state == XE_MADV_PURGEABLE_WILLNEED) {
+			if (xe_bo_madv_is_dontneed(bo)) {
+				xe_vma_free(vma);
+				return ERR_PTR(-EBUSY);
+			}
+			if (xe_bo_is_purged(bo)) {
+				xe_vma_free(vma);
+				return ERR_PTR(-EINVAL);
+			}
+		}
+
 		vm_bo = drm_gpuvm_bo_obtain_locked(vma->gpuva.vm, &bo->ttm.base);
 		if (IS_ERR(vm_bo)) {
 			xe_vma_free(vma);
@@ -1131,6 +1150,10 @@ static struct xe_vma *xe_vma_create(struct xe_vm *vm,
 		vma->gpuva.gem.offset = bo_offset_or_userptr;
 		drm_gpuva_link(&vma->gpuva, vm_bo);
 		drm_gpuvm_bo_put(vm_bo);
+
+		xe_bo_vma_count_inc_locked(bo);
+		if (vma->attr.purgeable_state == XE_MADV_PURGEABLE_WILLNEED)
+			xe_bo_willneed_get_locked(bo);
 	} else /* userptr or null */ {
 		if (!is_null && !is_cpu_addr_mirror) {
 			struct xe_userptr_vma *uvma = to_userptr_vma(vma);
@@ -1208,7 +1231,10 @@ static void xe_vma_destroy(struct xe_vma *vma, struct dma_fence *fence)
 		xe_bo_assert_held(bo);
 
 		drm_gpuva_unlink(&vma->gpuva);
-		xe_bo_recompute_purgeable_state(bo);
+
+		xe_bo_vma_count_dec_locked(bo);
+		if (vma->attr.purgeable_state == XE_MADV_PURGEABLE_WILLNEED)
+			xe_bo_willneed_put_locked(bo);
 	}
 
 	xe_vm_assert_held(vm);
@@ -3016,7 +3042,7 @@ static void vm_bind_ioctl_ops_unwind(struct xe_vm *vm,
  * @res_evict: Allow evicting resources during validation
  * @validate: Perform BO validation
  * @request_decompress: Request BO decompression
- * @check_purged: Reject operation if BO is purged
+ * @check_purged: Reject operation if BO is DONTNEED or PURGED
  */
 struct xe_vma_lock_and_validate_flags {
 	u32 res_evict : 1;
@@ -3030,6 +3056,7 @@ static int vma_lock_and_validate(struct drm_exec *exec, struct xe_vma *vma,
 {
 	struct xe_bo *bo = xe_vma_bo(vma);
 	struct xe_vm *vm = xe_vma_vm(vma);
+	bool validate_bo = flags.validate;
 	int err = 0;
 
 	if (bo) {
@@ -3044,7 +3071,11 @@ static int vma_lock_and_validate(struct drm_exec *exec, struct xe_vma *vma,
 				err = -EINVAL; /* BO already purged */
 		}
 
-		if (!err && flags.validate)
+		/* Don't validate the BO for DONTNEED/PURGED remap remnants. */
+		if (vma->attr.purgeable_state != XE_MADV_PURGEABLE_WILLNEED)
+			validate_bo = false;
+
+		if (!err && validate_bo)
 			err = xe_bo_validate(bo, vm,
 					     xe_vm_allow_vm_eviction(vm) &&
 					     flags.res_evict, exec);
@@ -3152,7 +3183,7 @@ static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
 								    op->map.immediate,
 							.request_decompress =
 							op->map.request_decompress,
-							.check_purged = true,
+							.check_purged = false,
 						    });
 		break;
 	case DRM_GPUVA_OP_REMAP:
@@ -3174,7 +3205,7 @@ static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
 							    .res_evict = res_evict,
 							    .validate = true,
 							    .request_decompress = false,
-							    .check_purged = true,
+							    .check_purged = false,
 						    });
 		if (!err && op->remap.next)
 			err = vma_lock_and_validate(exec, op->remap.next,
@@ -3182,7 +3213,7 @@ static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
 							    .res_evict = res_evict,
 							    .validate = true,
 							    .request_decompress = false,
-							    .check_purged = true,
+							    .check_purged = false,
 						    });
 		break;
 	case DRM_GPUVA_OP_UNMAP:
@@ -3211,9 +3242,11 @@ static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
 		}
 
 		/*
-		 * Prefetch attempts to migrate BO's backing store without
-		 * repopulating it first. Purged BOs have no backing store
-		 * to migrate, so reject the operation.
+		 * PREFETCH is the only op that still gates on BO purge state.
+		 * MAP/REMAP handle this inside xe_vma_create() so partial
+		 * unbind on a DONTNEED BO still works. PREFETCH skips
+		 * xe_vma_create() and would migrate a BO with no backing
+		 * store, so reject DONTNEED/PURGED here.
 		 */
 		err = vma_lock_and_validate(exec,
 					    gpuva_to_vma(op->base.prefetch.va),
diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_vm_madvise.c
index c78906dea82b..c4fb29004195 100644
--- a/drivers/gpu/drm/xe/xe_vm_madvise.c
+++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
@@ -185,147 +185,6 @@ static void madvise_pat_index(struct xe_device *xe, struct xe_vm *vm,
 	}
 }
 
-/**
- * xe_bo_is_dmabuf_shared() - Check if BO is shared via dma-buf
- * @bo: Buffer object
- *
- * Prevent marking imported or exported dma-bufs as purgeable.
- * For imported BOs, Xe doesn't own the backing store and cannot
- * safely reclaim pages (exporter or other devices may still be
- * using them). For exported BOs, external devices may have active
- * mappings we cannot track.
- *
- * Return: true if BO is imported or exported, false otherwise
- */
-static bool xe_bo_is_dmabuf_shared(struct xe_bo *bo)
-{
-	struct drm_gem_object *obj = &bo->ttm.base;
-
-	/* Imported: exporter owns backing store */
-	if (drm_gem_is_imported(obj))
-		return true;
-
-	/* Exported: external devices may be accessing */
-	if (obj->dma_buf)
-		return true;
-
-	return false;
-}
-
-/**
- * enum xe_bo_vmas_purge_state - VMA purgeable state aggregation
- *
- * Distinguishes whether a BO's VMAs are all DONTNEED, have at least
- * one WILLNEED, or have no VMAs at all.
- *
- * Enum values align with XE_MADV_PURGEABLE_* states for consistency.
- */
-enum xe_bo_vmas_purge_state {
-	/** @XE_BO_VMAS_STATE_WILLNEED: At least one VMA is WILLNEED */
-	XE_BO_VMAS_STATE_WILLNEED = 0,
-	/** @XE_BO_VMAS_STATE_DONTNEED: All VMAs are DONTNEED */
-	XE_BO_VMAS_STATE_DONTNEED = 1,
-	/** @XE_BO_VMAS_STATE_NO_VMAS: BO has no VMAs */
-	XE_BO_VMAS_STATE_NO_VMAS = 2,
-};
-
-/*
- * xe_bo_recompute_purgeable_state() casts between xe_bo_vmas_purge_state and
- * xe_madv_purgeable_state. Enforce that WILLNEED=0 and DONTNEED=1 match across
- * both enums so the single-line cast is always valid.
- */
-static_assert(XE_BO_VMAS_STATE_WILLNEED == (int)XE_MADV_PURGEABLE_WILLNEED,
-	      "VMA purge state WILLNEED must equal madv purgeable WILLNEED");
-static_assert(XE_BO_VMAS_STATE_DONTNEED == (int)XE_MADV_PURGEABLE_DONTNEED,
-	      "VMA purge state DONTNEED must equal madv purgeable DONTNEED");
-
-/**
- * xe_bo_all_vmas_dontneed() - Determine BO VMA purgeable state
- * @bo: Buffer object
- *
- * Check all VMAs across all VMs to determine aggregate purgeable state.
- * Shared BOs require unanimous DONTNEED state from all mappings.
- *
- * Caller must hold BO dma-resv lock.
- *
- * Return: XE_BO_VMAS_STATE_DONTNEED if all VMAs are DONTNEED,
- *         XE_BO_VMAS_STATE_WILLNEED if at least one VMA is not DONTNEED,
- *         XE_BO_VMAS_STATE_NO_VMAS if BO has no VMAs
- */
-static enum xe_bo_vmas_purge_state xe_bo_all_vmas_dontneed(struct xe_bo *bo)
-{
-	struct drm_gpuvm_bo *vm_bo;
-	struct drm_gpuva *gpuva;
-	struct drm_gem_object *obj = &bo->ttm.base;
-	bool has_vmas = false;
-
-	xe_bo_assert_held(bo);
-
-	/* Shared dma-bufs cannot be purgeable */
-	if (xe_bo_is_dmabuf_shared(bo))
-		return XE_BO_VMAS_STATE_WILLNEED;
-
-	drm_gem_for_each_gpuvm_bo(vm_bo, obj) {
-		drm_gpuvm_bo_for_each_va(gpuva, vm_bo) {
-			struct xe_vma *vma = gpuva_to_vma(gpuva);
-
-			has_vmas = true;
-
-			/* Any non-DONTNEED VMA prevents purging */
-			if (vma->attr.purgeable_state != XE_MADV_PURGEABLE_DONTNEED)
-				return XE_BO_VMAS_STATE_WILLNEED;
-		}
-	}
-
-	/*
-	 * No VMAs => preserve existing BO purgeable state.
-	 * Avoids incorrectly flipping DONTNEED -> WILLNEED when last VMA unmapped.
-	 */
-	if (!has_vmas)
-		return XE_BO_VMAS_STATE_NO_VMAS;
-
-	return XE_BO_VMAS_STATE_DONTNEED;
-}
-
-/**
- * xe_bo_recompute_purgeable_state() - Recompute BO purgeable state from VMAs
- * @bo: Buffer object
- *
- * Walk all VMAs to determine if BO should be purgeable or not.
- * Shared BOs require unanimous DONTNEED state from all mappings.
- * If the BO has no VMAs the existing state is preserved.
- *
- * Locking: Caller must hold BO dma-resv lock. When iterating GPUVM lists,
- * VM lock must also be held (write) to prevent concurrent VMA modifications.
- * This is satisfied at both call sites:
- * - xe_vma_destroy(): holds vm->lock write
- * - madvise_purgeable(): holds vm->lock write (from madvise ioctl path)
- *
- * Return: nothing
- */
-void xe_bo_recompute_purgeable_state(struct xe_bo *bo)
-{
-	enum xe_bo_vmas_purge_state vma_state;
-
-	if (!bo)
-		return;
-
-	xe_bo_assert_held(bo);
-
-	/*
-	 * Once purged, always purged. Cannot transition back to WILLNEED.
-	 * This matches i915 semantics where purged BOs are permanently invalid.
-	 */
-	if (bo->madv_purgeable == XE_MADV_PURGEABLE_PURGED)
-		return;
-
-	vma_state = xe_bo_all_vmas_dontneed(bo);
-
-	if (vma_state != (enum xe_bo_vmas_purge_state)bo->madv_purgeable &&
-	    vma_state != XE_BO_VMAS_STATE_NO_VMAS)
-		xe_bo_set_purgeable_state(bo, (enum xe_madv_purgeable_state)vma_state);
-}
-
 /**
  * madvise_purgeable - Handle purgeable buffer object advice
  * @xe: XE device
@@ -359,12 +218,6 @@ static void madvise_purgeable(struct xe_device *xe, struct xe_vm *vm,
 		/* BO must be locked before modifying madv state */
 		xe_bo_assert_held(bo);
 
-		/* Skip shared dma-bufs - no PTEs to zap */
-		if (xe_bo_is_dmabuf_shared(bo)) {
-			vmas[i]->skip_invalidation = true;
-			continue;
-		}
-
 		/*
 		 * Once purged, always purged. Cannot transition back to WILLNEED.
 		 * This matches i915 semantics where purged BOs are permanently invalid.
@@ -377,13 +230,14 @@ static void madvise_purgeable(struct xe_device *xe, struct xe_vm *vm,
 
 		switch (op->purge_state_val.val) {
 		case DRM_XE_VMA_PURGEABLE_STATE_WILLNEED:
-			vmas[i]->attr.purgeable_state = XE_MADV_PURGEABLE_WILLNEED;
 			vmas[i]->skip_invalidation = true;
-
-			xe_bo_recompute_purgeable_state(bo);
+			/* Only act on a real DONTNEED -> WILLNEED transition. */
+			if (vmas[i]->attr.purgeable_state == XE_MADV_PURGEABLE_DONTNEED) {
+				vmas[i]->attr.purgeable_state = XE_MADV_PURGEABLE_WILLNEED;
+				xe_bo_willneed_get_locked(bo);
+			}
 			break;
 		case DRM_XE_VMA_PURGEABLE_STATE_DONTNEED:
-			vmas[i]->attr.purgeable_state = XE_MADV_PURGEABLE_DONTNEED;
 			/*
 			 * Don't zap PTEs at DONTNEED time -- pages are still
 			 * alive. The zap happens in xe_bo_move_notify() right
@@ -391,7 +245,11 @@ static void madvise_purgeable(struct xe_device *xe, struct xe_vm *vm,
 			 */
 			vmas[i]->skip_invalidation = true;
 
-			xe_bo_recompute_purgeable_state(bo);
+			/* Only act on a real WILLNEED -> DONTNEED transition. */
+			if (vmas[i]->attr.purgeable_state == XE_MADV_PURGEABLE_WILLNEED) {
+				vmas[i]->attr.purgeable_state = XE_MADV_PURGEABLE_DONTNEED;
+				xe_bo_willneed_put_locked(bo);
+			}
 			break;
 		default:
 			/* Should never hit - values validated in madvise_args_are_sane() */
diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.h b/drivers/gpu/drm/xe/xe_vm_madvise.h
index 39acd2689ca0..a3078f634c7e 100644
--- a/drivers/gpu/drm/xe/xe_vm_madvise.h
+++ b/drivers/gpu/drm/xe/xe_vm_madvise.h
@@ -13,6 +13,4 @@ struct xe_bo;
 int xe_vm_madvise_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *file);
 
-void xe_bo_recompute_purgeable_state(struct xe_bo *bo);
-
 #endif

