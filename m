Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A943AFCF3
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935741; cv=none; b=omn/NnoRW0kLB39cAeWcijPWTJrLnSZ6scO7lyMnSB/hnyODDWlTkQVCc4VIRJh2/+OfvNKSllPiXt+MCNTJYhTnQ0Y80EK1OjiAGgsZfmFci2+cP541XpsFI0YegujX3yHjhph9f11iduNyQLvhT+V9VkgA7SD+9H9JHMRqRtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935741; c=relaxed/simple;
	bh=8m0qHbQPp/hJvP1pC38aqaAoDqcsyvTlhcX0iTjRNXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e0DAhOiTBwwbx8uT/r8Ngm1OET9NJZE66bwhUJqB4OgVCugYc4WRKX5+OjomzTAjUOqei+lVEgcXoALVeQ1/K3Xa/tmCqoKPfNFC6YzHheyXIojOmEn3vi5MI8bBTEgNQmzMB/zc1MUTHLmF65L6s/3OXEoWRPn87znYJegnbxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hx9PEHFR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hx9PEHFR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790935738; x=1822471738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8m0qHbQPp/hJvP1pC38aqaAoDqcsyvTlhcX0iTjRNXE=;
  b=hx9PEHFRtK32wg76F54iDwSFdZ+eKzhQNoCcEAWhuzXv5WpVRC8BtEsP
   CIiTHw8e7Q875M8UGmV5KNAl90KC/dGOQXyxLFI9yp1yELgHcH0UwjUOH
   AOm/+KzAIzZtKOva+/ccpeMYj4tYh5kyk5n+qtlEbzeUjfzFYWvdm40m4
   tA/xEloaBklzuJ4FB5acKxWA4jlx/UWohXANOIeewDOiImPt2sigmbC+K
   M6WHOSMg4wsqaTHIz3qGGnP7CRlbVSQCFo4IJwRa5LZrs+kvg9MIzPZ8F
   qJ1o8dlPnSsV6VyJrVAzFCLazvxQEvuz87ZHQqfYprCpEWpTO9wzG+0gF
   w==;
X-CSE-ConnectionGUID: jwpaRh5qQgKILNm99aIlcg==
X-CSE-MsgGUID: /BKbAh+uQLGGMda+x1Vhpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="102224579"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="102224579"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 03:08:57 -0700
X-CSE-ConnectionGUID: R2+VBX3hTQiVxgSnGN7H+A==
X-CSE-MsgGUID: uybC62/kS62whVQD+qGOPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="275412057"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO fedora) ([10.245.244.200])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 03:08:55 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	stable@vger.kernel.org,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v3 1/2] drm/xe: Fix shrinker accounting double-subtraction on nested external pins
Date: Fri,  2 Oct 2026 12:08:29 +0200
Message-ID: <20261002100830.12297-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002100830.12297-1-thomas.hellstrom@linux.intel.com>
References: <20261002100830.12297-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

xe_bo_pin_external() and xe_bo_unpin_external() support nested pins,
since the underlying ttm_bo_pin()/ttm_bo_unpin() maintain a pin_count
refcount rather than a boolean. However, the shrinker accounting calls
xe_ttm_tt_account_subtract() and xe_ttm_tt_account_add() are invoked
unconditionally on every pin_external()/unpin_external() call, instead
of only on the transition into and out of the pinned state.

An external BO (dma-buf) can be pinned more than once while already
pinned, for example when it has multiple attachments/importers, each
independently calling xe_bo_pin_external(). Each such nested pin
subtracts the BO's pages from the shrinker's accounting again, even
though the BO's pages were already removed from consideration by the
first pin. Symmetrically, each nested unpin adds them back again
before the BO is actually unpinned. This desynchronizes the
shrinker's page and object counts from reality, and since they are
declared as signed long but interpreted as unsigned long in
xe_shrinker_count(), the underflow can turn into an enormous
shrinkable/purgeable page count, causing the shrinker to be invoked
excessively under memory pressure.

Guard the accounting calls with the same pin-count transition checks
already used to guard the pinned_link list maintenance, so accounting
is only updated on the outermost pin and the final unpin.

While centralizing this logic into xe_bo_account_pin()/
xe_bo_account_unpin(), also close a second, related accounting gap
affecting imported dma-bufs. For an imported bo's ttm_tt, xe's
ttm_tt_populate hook (xe_ttm_tt_populate()) early-returns without
calling xe_ttm_tt_account_add(), since TTM_TT_FLAG_EXTERNAL is set
without TTM_TT_FLAG_EXTERNAL_MAPPABLE. However, TTM core's
ttm_tt_populate() wrapper unconditionally marks the tt as populated
on driver-hook success, so ttm_tt_is_populated() still reports true
for it. xe_bo_account_pin()/xe_bo_account_unpin() trusted
ttm_tt_is_populated() as a proxy for "these pages are accounted for
by the shrinker", and would subtract/add pages for such a tt that
were never added in the first place, again underflowing the
shrinker's counts. This is reachable today via xe_bo_pin_external(),
and would have become newly reachable via the fb-pin path once this
patch routes __xe_pin_fb_vma() through xe_bo_pin_account() below, so
fix it here rather than in a later patch, to avoid a commit in this
series that introduces the regression before fixing it. Skip the
accounting for imported bos, using the same EXTERNAL &&
!EXTERNAL_MAPPABLE test xe_ttm_tt_populate()/xe_ttm_tt_unpopulate()
use to decide whether to act, via a new xe_ttm_bo_is_imported()
helper (hoisted up from its only prior use site).

Fixes: 00c8efc3180f ("drm/xe: Add a shrinker for xe bos")
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-xe@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.15+
Reviewed-by: Matthew Auld <matthew.auld@intel.com> # v2
Assisted-by: LLM
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

v2:
- Fix the critical issue caught by Sashiko AI review: the pin-count
  transition check introduced here was still bypassed by the fb-pin
  path (__xe_pin_fb_vma()/__xe_unpin_fb_vma()), which could leave a
  stale pinned_link entry and a permanent shrinker accounting leak
  when the fb-unpin performed the true last unpin. Addressed in a
  separate follow-up patch in this series rather than folded in here,
  since it is a distinct bug with its own Fixes: tag.
- Drop the unneeded local "last_unpin" variable in
  xe_bo_unpin_external(), restoring the original inline
  bo->ttm.pin_count == 1 check; it was a no-op rename not used by any
  of the new accounting helpers, and was going to be deleted again by
  the follow-up patch anyway.

v3:
- Exclude imported dma-bufs from the pin/unpin shrinker accounting,
  fixing another underflow caught by Sashiko AI review.
- Add a short comment on the backup-object pin site noting it's
  already populated/accounted at pin time, addressing (as a
  false-positive clarification, no code fix needed) a separate
  Medium-severity accounting-leak concern also caught by Sashiko AI
  review.
---
 drivers/gpu/drm/xe/display/xe_fb_pin.c |   6 +-
 drivers/gpu/drm/xe/xe_bo.c             | 116 +++++++++++++++++++------
 drivers/gpu/drm/xe/xe_bo.h             |   2 +
 3 files changed, 95 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
index b46a2c32ac07..4f5cee474c64 100644
--- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
+++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
@@ -356,7 +356,7 @@ static struct i915_vma *__xe_pin_fb_vma(struct drm_gem_object *obj, bool is_dpt,
 		drm_exec_retry_on_contention(&exec);
 		xe_validation_retry_on_oom(&ctx, &ret);
 		if (!ret)
-			ttm_bo_pin(&bo->ttm);
+			xe_bo_pin_account(bo);
 	}
 	if (ret)
 		goto err;
@@ -373,7 +373,7 @@ static struct i915_vma *__xe_pin_fb_vma(struct drm_gem_object *obj, bool is_dpt,
 
 err_unpin:
 	ttm_bo_reserve(&bo->ttm, false, false, NULL);
-	ttm_bo_unpin(&bo->ttm);
+	xe_bo_unpin_account(bo);
 	ttm_bo_unreserve(&bo->ttm);
 err:
 	kfree(vma);
@@ -393,7 +393,7 @@ static void __xe_unpin_fb_vma(struct i915_vma *vma)
 		xe_ggtt_node_remove(vma->node, false);
 
 	ttm_bo_reserve(&vma->bo->ttm, false, false, NULL);
-	ttm_bo_unpin(&vma->bo->ttm);
+	xe_bo_unpin_account(vma->bo);
 	ttm_bo_unreserve(&vma->bo->ttm);
 	kfree(vma);
 }
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index f2ab9bf43a86..6cc3f0bc0be4 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -465,6 +465,85 @@ static void xe_ttm_tt_account_subtract(struct xe_device *xe, struct ttm_tt *tt)
 		xe_shrinker_mod_pages(xe->mem.shrinker, -(long)tt->num_pages, 0);
 }
 
+static bool xe_ttm_bo_is_imported(struct ttm_buffer_object *tbo)
+{
+	dma_resv_assert_held(tbo->base.resv);
+
+	return tbo->ttm &&
+		(tbo->ttm->page_flags & (TTM_TT_FLAG_EXTERNAL | TTM_TT_FLAG_EXTERNAL_MAPPABLE)) ==
+		TTM_TT_FLAG_EXTERNAL;
+}
+
+/*
+ * Account @bo's pages as pinned for the shrinker. Removes @bo's pages
+ * from the shrinker's shrinkable / purgeable counts on the transition
+ * from unpinned to pinned. Must be called with @bo's dma-resv held,
+ * after &ttm_buffer_object.pin_count has been incremented by
+ * ttm_bo_pin(). Safe to call unconditionally regardless of which pin
+ * path (kernel, external, framebuffer, backup object, ...) is pinning
+ * @bo, since it only acts on the true 0->1 pin_count transition.
+ *
+ * Imported bos (xe_ttm_bo_is_imported()) are excluded: for those,
+ * xe_ttm_tt_populate() never actually populates the tt or calls
+ * xe_ttm_tt_account_add(), but TTM core's ttm_tt_populate() still
+ * unconditionally marks the tt as populated on driver-hook success.
+ * Relying on ttm_tt_is_populated() for these would subtract pages that
+ * were never added, underflowing the shrinker's counts.
+ */
+static void xe_bo_account_pin(struct xe_bo *bo)
+{
+	struct xe_device *xe = xe_bo_device(bo);
+
+	if (bo->ttm.pin_count == 1 && bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm) &&
+	    !xe_ttm_bo_is_imported(&bo->ttm))
+		xe_ttm_tt_account_subtract(xe, bo->ttm.ttm);
+}
+
+/*
+ * Counterpart to xe_bo_account_pin(). Must be called with @bo's dma-resv
+ * held, before &ttm_buffer_object.pin_count is decremented by
+ * ttm_bo_unpin(), so that the check against the true 1->0 transition sees
+ * the pin count that is about to be released. See xe_bo_account_pin() for
+ * why imported bos are excluded.
+ */
+static void xe_bo_account_unpin(struct xe_bo *bo)
+{
+	struct xe_device *xe = xe_bo_device(bo);
+
+	if (bo->ttm.pin_count == 1 && bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm) &&
+	    !xe_ttm_bo_is_imported(&bo->ttm))
+		xe_ttm_tt_account_add(xe, bo->ttm.ttm);
+}
+
+/**
+ * xe_bo_pin_account() - Pin a bo and account its pages for the shrinker
+ * @bo: The buffer object to pin.
+ *
+ * Pins @bo via ttm_bo_pin() and updates the shrinker's shrinkable /
+ * purgeable page accounting to match. Must be called with @bo's dma-resv
+ * held. Safe to call regardless of which pin path (kernel, external,
+ * framebuffer, backup object, ...) is pinning @bo.
+ */
+void xe_bo_pin_account(struct xe_bo *bo)
+{
+	ttm_bo_pin(&bo->ttm);
+	xe_bo_account_pin(bo);
+}
+
+/**
+ * xe_bo_unpin_account() - Unpin a bo and account its pages for the shrinker
+ * @bo: The buffer object to unpin.
+ *
+ * Counterpart to xe_bo_pin_account(). Updates the shrinker's shrinkable /
+ * purgeable page accounting to match, then unpins @bo via ttm_bo_unpin().
+ * Must be called with @bo's dma-resv held.
+ */
+void xe_bo_unpin_account(struct xe_bo *bo)
+{
+	xe_bo_account_unpin(bo);
+	ttm_bo_unpin(&bo->ttm);
+}
+
 static void update_global_total_pages(struct ttm_device *ttm_dev,
 				      long num_pages)
 {
@@ -1396,7 +1475,8 @@ int xe_bo_notifier_prepare_pinned(struct xe_bo *bo)
 		}
 
 		backup->parent_obj = xe_bo_get(bo); /* Released by bo_destroy */
-		ttm_bo_pin(&backup->ttm);
+		/* Note: XE_BO_FLAG_SYSTEM resolves to XE_PL_TT so already populated. */
+		xe_bo_pin_account(backup);
 		bo->backup_obj = backup;
 	}
 
@@ -1416,7 +1496,7 @@ int xe_bo_notifier_unprepare_pinned(struct xe_bo *bo)
 {
 	xe_bo_lock(bo, false);
 	if (bo->backup_obj) {
-		ttm_bo_unpin(&bo->backup_obj->ttm);
+		xe_bo_unpin_account(bo->backup_obj);
 		xe_bo_put(bo->backup_obj);
 		bo->backup_obj = NULL;
 	}
@@ -1627,7 +1707,7 @@ int xe_bo_restore_pinned(struct xe_bo *bo)
 	xe_bo_vunmap(backup);
 	if (!bo->backup_obj) {
 		if (xe_bo_is_pinned(backup))
-			ttm_bo_unpin(&backup->ttm);
+			xe_bo_unpin_account(backup);
 		xe_bo_put(backup);
 	}
 out_unlock_bo:
@@ -2019,15 +2099,6 @@ static vm_fault_t xe_err_to_fault_t(int err)
 	return VM_FAULT_SIGBUS;
 }
 
-static bool xe_ttm_bo_is_imported(struct ttm_buffer_object *tbo)
-{
-	dma_resv_assert_held(tbo->base.resv);
-
-	return tbo->ttm &&
-		(tbo->ttm->page_flags & (TTM_TT_FLAG_EXTERNAL | TTM_TT_FLAG_EXTERNAL_MAPPABLE)) ==
-		TTM_TT_FLAG_EXTERNAL;
-}
-
 static vm_fault_t xe_bo_cpu_fault_fastpath(struct vm_fault *vmf, struct xe_device *xe,
 					   struct xe_bo *bo, bool needs_rpm)
 {
@@ -3148,12 +3219,13 @@ uint64_t vram_region_gpu_offset(struct ttm_resource *res)
 int xe_bo_pin_external(struct xe_bo *bo, bool in_place, struct drm_exec *exec)
 {
 	struct xe_device *xe = xe_bo_device(bo);
+	bool first_pin = !xe_bo_is_pinned(bo);
 	int err;
 
 	xe_assert(xe, !bo->vm);
 	xe_assert(xe, xe_bo_is_user(bo));
 
-	if (!xe_bo_is_pinned(bo)) {
+	if (first_pin) {
 		if (!in_place) {
 			err = xe_bo_validate(bo, NULL, false, exec);
 			if (err)
@@ -3165,9 +3237,7 @@ int xe_bo_pin_external(struct xe_bo *bo, bool in_place, struct drm_exec *exec)
 		spin_unlock(&xe->pinned.lock);
 	}
 
-	ttm_bo_pin(&bo->ttm);
-	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
-		xe_ttm_tt_account_subtract(xe, bo->ttm.ttm);
+	xe_bo_pin_account(bo);
 
 	/*
 	 * FIXME: If we always use the reserve / unreserve functions for locking
@@ -3223,9 +3293,7 @@ int xe_bo_pin(struct xe_bo *bo, struct drm_exec *exec)
 		spin_unlock(&xe->pinned.lock);
 	}
 
-	ttm_bo_pin(&bo->ttm);
-	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
-		xe_ttm_tt_account_subtract(xe, bo->ttm.ttm);
+	xe_bo_pin_account(bo);
 
 	/*
 	 * FIXME: If we always use the reserve / unreserve functions for locking
@@ -3259,9 +3327,7 @@ void xe_bo_unpin_external(struct xe_bo *bo)
 		list_del_init(&bo->pinned_link);
 	spin_unlock(&xe->pinned.lock);
 
-	ttm_bo_unpin(&bo->ttm);
-	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
-		xe_ttm_tt_account_add(xe, bo->ttm.ttm);
+	xe_bo_unpin_account(bo);
 
 	/*
 	 * FIXME: If we always use the reserve / unreserve functions for locking
@@ -3289,14 +3355,12 @@ void xe_bo_unpin(struct xe_bo *bo)
 
 		if (bo->backup_obj) {
 			if (xe_bo_is_pinned(bo->backup_obj))
-				ttm_bo_unpin(&bo->backup_obj->ttm);
+				xe_bo_unpin_account(bo->backup_obj);
 			xe_bo_put(bo->backup_obj);
 			bo->backup_obj = NULL;
 		}
 	}
-	ttm_bo_unpin(&bo->ttm);
-	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
-		xe_ttm_tt_account_add(xe, bo->ttm.ttm);
+	xe_bo_unpin_account(bo);
 }
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index 341fa93a71e4..4a3b79b73789 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -228,6 +228,8 @@ int xe_bo_pin_external(struct xe_bo *bo, bool in_place, struct drm_exec *exec);
 int xe_bo_pin(struct xe_bo *bo, struct drm_exec *exec);
 void xe_bo_unpin_external(struct xe_bo *bo);
 void xe_bo_unpin(struct xe_bo *bo);
+void xe_bo_pin_account(struct xe_bo *bo);
+void xe_bo_unpin_account(struct xe_bo *bo);
 int xe_bo_validate(struct xe_bo *bo, struct xe_vm *vm, bool allow_res_evict,
 		   struct drm_exec *exec);
 
-- 
2.55.0

