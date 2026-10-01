Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FC131280D
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862077; cv=none; b=i1zmOlhYhzdWkc9TD7LTeDccO6NiwXNsWpB/AIusda3kgWsTf+q5S97pUAIFBeuxijfxuraVHW2/qkWoDsrn9UiZgQUPrCAq3EQ46suCKy2GMnKXmIb509fsJ6LK9WlSNL577kMETT1fbeZJj4nBNMboR+rDNK9auOhKJfZW7/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862077; c=relaxed/simple;
	bh=TQfDIcIMSUSINRgKCHSFzLoKZwSJ3o+yubGo/Fx30VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXV+fRuyl4kTUc5SDj6oahCGJhntnCUTyHS3BwUwRmXd23J1/njWq0zYNS82kYgwlV9r5CJxCJcHlcZ2pLumke8rBHLtFWmUk4khzq1WX2dag/OpElWnQKfmA1viS+up/MMCJv9FX6EVa7jzCnthB+DLrJqKVConwUefYX8orMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQfUggHT; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQfUggHT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790862074; x=1822398074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TQfDIcIMSUSINRgKCHSFzLoKZwSJ3o+yubGo/Fx30VI=;
  b=eQfUggHTVE8mIzcMG7yRKePwCRXe5JwV0b06hfpm8sQjX54kcKx12L1n
   XfXZ4QDsCXpTi5FSaODTvzdzHTPv0Jo5d1nSv0rD0ttZh2kq0B3AxxpeX
   UgnEt/PNt+p+tEJZVOrJGorQPX08yqJD2RbcTcuPouyb9g993ed3H+TMF
   PhE2ThzKaWLZCHkRvS0JZYWGM9UAYxiiw5JsmBERMPTuXXnKAIf8ZL+7F
   D4VUsUvhBamQX2XMJhZ4pJQi30uclouUnmkpu2GmD64+trzXu1mKgYqsm
   PCAFdewvN6vqgetVqHe1aC/ykMD/OLs2cNMo88Fmmn8KZrozVXl+D1Uhc
   A==;
X-CSE-ConnectionGUID: VoP39kkRSPyiAfDxU+OJ2A==
X-CSE-MsgGUID: EnfdM8euToKtWy3yZHmcAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="100951840"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="100951840"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 06:40:43 -0700
X-CSE-ConnectionGUID: TX18wZmbS92tKK88tnqr+g==
X-CSE-MsgGUID: /enasJJTRt24RKPmV4MrnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="275525136"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO fedora) ([10.245.244.16])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 06:40:41 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	stable@vger.kernel.org,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v2 1/2] drm/xe: Fix shrinker accounting double-subtraction on nested external pins
Date: Thu,  1 Oct 2026 15:40:17 +0200
Message-ID: <20261001134018.111553-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001134018.111553-1-thomas.hellstrom@linux.intel.com>
References: <20261001134018.111553-1-thomas.hellstrom@linux.intel.com>
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

Fixes: 00c8efc3180f ("drm/xe: Add a shrinker for xe bos")
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-xe@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.15+
Reviewed-by: Matthew Auld <matthew.auld@intel.com> # v1
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
---
 drivers/gpu/drm/xe/display/xe_fb_pin.c |  6 +-
 drivers/gpu/drm/xe/xe_bo.c             | 87 +++++++++++++++++++++-----
 drivers/gpu/drm/xe/xe_bo.h             |  2 +
 3 files changed, 75 insertions(+), 20 deletions(-)

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
index f2ab9bf43a86..2fbbba7cf4b0 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -465,6 +465,66 @@ static void xe_ttm_tt_account_subtract(struct xe_device *xe, struct ttm_tt *tt)
 		xe_shrinker_mod_pages(xe->mem.shrinker, -(long)tt->num_pages, 0);
 }
 
+/*
+ * Account @bo's pages as pinned for the shrinker. Removes @bo's pages
+ * from the shrinker's shrinkable / purgeable counts on the transition
+ * from unpinned to pinned. Must be called with @bo's dma-resv held,
+ * after &ttm_buffer_object.pin_count has been incremented by
+ * ttm_bo_pin(). Safe to call unconditionally regardless of which pin
+ * path (kernel, external, framebuffer, backup object, ...) is pinning
+ * @bo, since it only acts on the true 0->1 pin_count transition.
+ */
+static void xe_bo_account_pin(struct xe_bo *bo)
+{
+	struct xe_device *xe = xe_bo_device(bo);
+
+	if (bo->ttm.pin_count == 1 && bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
+		xe_ttm_tt_account_subtract(xe, bo->ttm.ttm);
+}
+
+/*
+ * Counterpart to xe_bo_account_pin(). Must be called with @bo's dma-resv
+ * held, before &ttm_buffer_object.pin_count is decremented by
+ * ttm_bo_unpin(), so that the check against the true 1->0 transition sees
+ * the pin count that is about to be released.
+ */
+static void xe_bo_account_unpin(struct xe_bo *bo)
+{
+	struct xe_device *xe = xe_bo_device(bo);
+
+	if (bo->ttm.pin_count == 1 && bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
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
@@ -1396,7 +1456,7 @@ int xe_bo_notifier_prepare_pinned(struct xe_bo *bo)
 		}
 
 		backup->parent_obj = xe_bo_get(bo); /* Released by bo_destroy */
-		ttm_bo_pin(&backup->ttm);
+		xe_bo_pin_account(backup);
 		bo->backup_obj = backup;
 	}
 
@@ -1416,7 +1476,7 @@ int xe_bo_notifier_unprepare_pinned(struct xe_bo *bo)
 {
 	xe_bo_lock(bo, false);
 	if (bo->backup_obj) {
-		ttm_bo_unpin(&bo->backup_obj->ttm);
+		xe_bo_unpin_account(bo->backup_obj);
 		xe_bo_put(bo->backup_obj);
 		bo->backup_obj = NULL;
 	}
@@ -1627,7 +1687,7 @@ int xe_bo_restore_pinned(struct xe_bo *bo)
 	xe_bo_vunmap(backup);
 	if (!bo->backup_obj) {
 		if (xe_bo_is_pinned(backup))
-			ttm_bo_unpin(&backup->ttm);
+			xe_bo_unpin_account(backup);
 		xe_bo_put(backup);
 	}
 out_unlock_bo:
@@ -3148,12 +3208,13 @@ uint64_t vram_region_gpu_offset(struct ttm_resource *res)
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
@@ -3165,9 +3226,7 @@ int xe_bo_pin_external(struct xe_bo *bo, bool in_place, struct drm_exec *exec)
 		spin_unlock(&xe->pinned.lock);
 	}
 
-	ttm_bo_pin(&bo->ttm);
-	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
-		xe_ttm_tt_account_subtract(xe, bo->ttm.ttm);
+	xe_bo_pin_account(bo);
 
 	/*
 	 * FIXME: If we always use the reserve / unreserve functions for locking
@@ -3223,9 +3282,7 @@ int xe_bo_pin(struct xe_bo *bo, struct drm_exec *exec)
 		spin_unlock(&xe->pinned.lock);
 	}
 
-	ttm_bo_pin(&bo->ttm);
-	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
-		xe_ttm_tt_account_subtract(xe, bo->ttm.ttm);
+	xe_bo_pin_account(bo);
 
 	/*
 	 * FIXME: If we always use the reserve / unreserve functions for locking
@@ -3259,9 +3316,7 @@ void xe_bo_unpin_external(struct xe_bo *bo)
 		list_del_init(&bo->pinned_link);
 	spin_unlock(&xe->pinned.lock);
 
-	ttm_bo_unpin(&bo->ttm);
-	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
-		xe_ttm_tt_account_add(xe, bo->ttm.ttm);
+	xe_bo_unpin_account(bo);
 
 	/*
 	 * FIXME: If we always use the reserve / unreserve functions for locking
@@ -3289,14 +3344,12 @@ void xe_bo_unpin(struct xe_bo *bo)
 
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

