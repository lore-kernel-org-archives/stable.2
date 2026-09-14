Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F463472F7F
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789393599; cv=none; b=LqkJbrQ7ZRx0dY2Pn44KFDaqjXwVH/bs57sVGnMfFwjFdtyTec+fuwFUGR3nIqr/gYRnLrtxie+oMC46p0Krk1N2quaCVln/ZTlGAWFqOEdrXywNmBFdDnzMrz7xq+X8uMVGs37FdjM8QmvwjtR7oNiFEz4rNmq4hMO+nymrFhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789393599; c=relaxed/simple;
	bh=37/I50gHD62uU09PTix/xJg2/GrSVvG3mPPsk36PprA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D7BUu5LJB75Djjlh45iuHgVH5M57ZZj1azzwbKVnKM4beigNeApM3CHrsP0tjlX+M87vV5dKC5mV/pgMIHUpYfB+O1zcD7becVkCNJfZ8SRdcOp/dFpANdv1r0PBSFu6kEM6a2QJOiYbisOiapQKb176c0tG+a5rlQ7ANaAejhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UFmhgXLx; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UFmhgXLx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789393597; x=1820929597;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=37/I50gHD62uU09PTix/xJg2/GrSVvG3mPPsk36PprA=;
  b=UFmhgXLxLecZ+6ap/0z/1jBTFakkPw2i2poEFxXDbVnOzWBDMPiWgn4i
   1t4eShUV0EAXrkE2Sx1B/Uljfezv58hNgoKlWn30/6AQbZTTWyrHh1Shm
   Lc3a4IfT/bih90AJk1diuDq+U8KYyZM94gD721VoWxmBTmRZP1ZWsXSmW
   VLEGa4VOWOhjrWuT4Eu9aqaG5KXWFFcpwDDqzyztdKkX2LXxVqMQKkBbb
   FJj1X3nkEeisua1gSL87dIK/A/+51388CB8iZjX6IU0+h/HrrdpWRxiI9
   0WuC8Snx7bS26B8/OHJjesoZZEnY+6ndj108RZIsrbOxgb4UL1Mdisn6D
   Q==;
X-CSE-ConnectionGUID: P8oPVGJkSJqQ1RpnZg2Hyw==
X-CSE-MsgGUID: F93zEYOpRkyZQdPcNlC6NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="89786698"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="89786698"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 06:46:36 -0700
X-CSE-ConnectionGUID: p0ibdEcpRIyq/hYTks3olw==
X-CSE-MsgGUID: hmmk0UGCSiGZWhvZEXYn7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="310917857"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO fedora) ([10.245.245.65])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 06:46:35 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: Fix shrinker accounting double-subtraction on nested external pins
Date: Mon, 14 Sep 2026 15:45:40 +0200
Message-ID: <20260914134540.385186-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.55.0
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
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-xe@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.15+
Assisted-by: LLM
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 9f3f0cb95afa..f46ff260be9b 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -3141,12 +3141,13 @@ uint64_t vram_region_gpu_offset(struct ttm_resource *res)
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
@@ -3159,7 +3160,7 @@ int xe_bo_pin_external(struct xe_bo *bo, bool in_place, struct drm_exec *exec)
 	}
 
 	ttm_bo_pin(&bo->ttm);
-	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
+	if (first_pin && bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
 		xe_ttm_tt_account_subtract(xe, bo->ttm.ttm);
 
 	/*
@@ -3242,18 +3243,19 @@ int xe_bo_pin(struct xe_bo *bo, struct drm_exec *exec)
 void xe_bo_unpin_external(struct xe_bo *bo)
 {
 	struct xe_device *xe = xe_bo_device(bo);
+	bool last_unpin = bo->ttm.pin_count == 1;
 
 	xe_assert(xe, !bo->vm);
 	xe_assert(xe, xe_bo_is_pinned(bo));
 	xe_assert(xe, xe_bo_is_user(bo));
 
 	spin_lock(&xe->pinned.lock);
-	if (bo->ttm.pin_count == 1 && !list_empty(&bo->pinned_link))
+	if (last_unpin && !list_empty(&bo->pinned_link))
 		list_del_init(&bo->pinned_link);
 	spin_unlock(&xe->pinned.lock);
 
 	ttm_bo_unpin(&bo->ttm);
-	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
+	if (last_unpin && bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
 		xe_ttm_tt_account_add(xe, bo->ttm.ttm);
 
 	/*
-- 
2.55.0

