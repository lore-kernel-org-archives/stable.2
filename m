Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391797;
	b=zr87JlSFilCyxxxCOctODG6OyrC7bs1nvCFpQzNsbY9bEt4/sBdDp7WrETqYBkvaMd2V
	 QkczPBSBrRNwKfm6SPJYdT9v6SLzDJreqY7NqRB0JZzl6+NGcH4YijXhXbDOl/I+MsFD3
	 q0oySP2R+1zgOIKG/Ww2D2uQrPdQpBqCQkHl1EGBZma4QNT6NQmffPCimrkoBnDwznb7z
	 doXMNh4n1P2Y81oyd1j10t0CNnzonPiFFNBnH0zeXJRARIP0Mav71B5R1lgbgiJimJ0LF
	 qM6WLFwNF8kHzvsKlIAl8/MM3ImI1pMNdMtlqSx+RSHueZtkbmEkRr0EI9vxDKNMwQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391797;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=uxr7prCY9LatADsHmzQTgGcMcdgC/63WFi/9+V6VH44=;
	b=Mn/cLfVAGRlpBTRXmHEl8Rbc45CFZG5wiAZepn+oUBnrLzExxNaHaVlYiQ2q8Mtk0Ms/
	 UfNjKuvx6dX9Kixo06m6IttI/IdfZJh2ym0zzhm48e7MfUMte/JNDRdt1z8QpIH0KrH35
	 W3EDQPy2Lsp0zU2T1pLIdNo/9Jp1O0jI+tSvydnuq56fH46FTIR4H3aihW6QoV11n+IsW
	 b6+mcaskePhjj2PbUpr68UoSIOk85odqD/WG2WUcrO2kvQ0PbwMSrPNX+ocoz/n9L2T8W
	 kOoEk69OZKNejp+K/f8vrmCzQNIQBKvcVv/Of2DLHe/EAM9BhgIhjQZJcba/p+4ZRUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="GHEXUGY/";
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A2B606A332
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 10:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99A2B606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GHEXUGY/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794391797; x=1825927797;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BMnxFsvhvEsTr3QuL/lZAYvYXC/iz08U4mMni2SukH4=;
  b=GHEXUGY/Euud4zzP2XY4gUqJifNR4CGLDV/f4kPZqhjnKa3410V8pAJP
   GIPPNjzIakoIAInsQ1UK9pgcP8brJYjPTayTu5rsuGSxaecHH7uoFHvYK
   1VqaQpyLJGlUyc7KWrUQy4TYH+SVKsZ+l3/x4rFRRyQl+ItU5cYMywM4V
   XeF9u8dobC0SUG/8j0nS8XSyAujp3ZhGwhNrItBng6Uap6eRb7cMDq8FG
   YrazLeXhiqwPHsw2IDUo+JO9cCSbZcMSAq1vqpXSy7EbFI8YWvOQqu9l+
   2ZnotTgJEEuPRjwtug4qYqV38H7KLvTEEHjTndYz6ZmM/0noun5QPQNgS
   A==;
X-CSE-ConnectionGUID: v96CoodESkijIv60eqd8XQ==
X-CSE-MsgGUID: bkyUEB6sRYSuu4FihG4W4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3158170"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3158170"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 02:09:57 -0800
X-CSE-ConnectionGUID: 3Cx5tL99R46FTssmG1yh2Q==
X-CSE-MsgGUID: VXyJeHEyRfCDOYqjyT6g4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8812997"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO fedora) ([10.245.245.171])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 02:09:54 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Dave Airlie <airlied@redhat.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/dma-buf: Validate BOs on export to charge the exporter
Date: Wed, 11 Nov 2026 11:09:29 +0100
Message-ID: <20261111100929.2228-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

xe_gem_prime_export() calls ttm_bo_setup_export() to make sure the
exporter is charged for the memory backing an exported BO. However,
that only populates a TTM_PL_SYSTEM tt. A BO that has been evicted, or
that has deferred backing, will instead get its memory allocated when
the importer maps it. For p2p imports this happens through
xe_bo_validate() in xe_dma_buf_map(), so the importer, not the
exporter, is charged for the allocation.

Call xe_bo_validate() at export time instead, so that the BO is moved
into its preferred placement and the exporter is charged.

Do the purgeable checks and the validation in the same
xe_validation_guard() transaction, to avoid locking the BO twice.

The commit message and code was drafted using LLM.

Link: https://patchwork.freedesktop.org/patch/747480/?series=172524&rev=1
Fixes: 91494dee1091 ("xe: populate buffers before exporting them.")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-xe@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.18+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_dma_buf.c | 76 +++++++++++++++++----------------
 1 file changed, 39 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index 5bf13dc4b61d..90c9b90de552 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -263,60 +263,62 @@ struct drm_gem_object *xe_dma_buf_to_gem(struct drm_device *dev,
 struct dma_buf *xe_gem_prime_export(struct drm_gem_object *obj, int flags)
 {
 	struct xe_bo *bo = gem_to_xe_bo(obj);
+	struct xe_validation_ctx ctx;
+	struct drm_exec exec;
 	struct dma_buf *buf;
-	struct ttm_operation_ctx ctx = {
-		.interruptible = true,
-		.no_wait_gpu = true,
-		/* We opt to avoid OOM on system pages allocations */
-		.gfp_retry_mayfail = true,
-		.allow_res_evict = false,
-	};
-	int ret;
+	int ret = 0;
 
 	if (bo->vm)
 		return ERR_PTR(-EPERM);
 
-	/*
-	 * Reject exporting purgeable BOs. DONTNEED BOs can be purged
-	 * at any time, making the exported dma-buf unusable. Purged BOs
-	 * have no backing store and are permanently invalid.
-	 */
-	ret = xe_bo_lock(bo, true);
-	if (ret)
-		return ERR_PTR(ret);
+	xe_validation_guard(&ctx, &xe_bo_device(bo)->val, &exec,
+			    (struct xe_val_flags) {.interruptible = true}, ret) {
+		ret = drm_exec_lock_obj(&exec, &bo->ttm.base);
+		drm_exec_retry_on_contention(&exec);
+		if (ret)
+			break;
 
-	if (xe_bo_madv_is_dontneed(bo)) {
-		ret = -EBUSY;
-		goto out_unlock;
-	}
+		/*
+		 * Reject exporting purgeable BOs. DONTNEED BOs can be purged
+		 * at any time, making the exported dma-buf unusable. Purged BOs
+		 * have no backing store and are permanently invalid.
+		 */
+		if (xe_bo_madv_is_dontneed(bo)) {
+			ret = -EBUSY;
+			break;
+		}
 
-	if (xe_bo_is_purged(bo)) {
-		ret = -EINVAL;
-		goto out_unlock;
-	}
+		if (xe_bo_is_purged(bo)) {
+			ret = -EINVAL;
+			break;
+		}
 
-	xe_bo_willneed_get_locked(bo);
-	xe_bo_unlock(bo);
+		/*
+		 * Make sure the BO is backed in its preferred placement so that
+		 * the exporter, rather than the importer, is charged for the
+		 * memory allocation.
+		 */
+		ret = xe_bo_validate(bo, NULL, false, &exec);
+		drm_exec_retry_on_contention(&exec);
+		xe_validation_retry_on_oom(&ctx, &ret);
+		if (ret)
+			break;
 
-	ret = ttm_bo_setup_export(&bo->ttm, &ctx);
+		xe_bo_willneed_get_locked(bo);
+	}
 	if (ret)
-		goto out_put;
+		return ERR_PTR(ret);
 
 	buf = drm_gem_prime_export(obj, flags);
 	if (IS_ERR(buf)) {
-		ret = PTR_ERR(buf);
-		goto out_put;
+		xe_bo_lock(bo, false);
+		xe_bo_willneed_put_locked(bo);
+		xe_bo_unlock(bo);
+		return buf;
 	}
 
 	buf->ops = &xe_dmabuf_ops;
 	return buf;
-
-out_put:
-	xe_bo_lock(bo, false);
-	xe_bo_willneed_put_locked(bo);
-out_unlock:
-	xe_bo_unlock(bo);
-	return ERR_PTR(ret);
 }
 
 static struct drm_gem_object *
-- 
2.56.0

