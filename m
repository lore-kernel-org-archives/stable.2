Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792490732;
	b=Mi10RhLgyQazpE92H4bRqpkr8DUnfez7jKhJlnE91gryjTsPLCCP1f+UTmt1g2Y3MQex
	 yhtl1kOAjY9PlD987EYCvlLxYMWByXJFZOjQy+ojppHTdTgaqhKJJ8nGVjLygaGl72fny
	 oYAJGlevCnmfqcioG0/qXaYSfFSzqQpSyU5YufXLmRIkBHYBIBcWMtvuzkzMzAjXJ4nx/
	 gRHxnJo+M88gSLaLCdWpk/ChONXDblEl3zeWLkJHKM7h0z7c8nSGKpuajVlddcKhxoNCj
	 wgQxB8P7Lk7F2n3aXu/EqWDi7eMyT1g7DowduIglQIxKTFNsol3kJba5j1O4u9wcxSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792490732;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Dvp4aasRz96lUnC1XJ9G7ciSSfe/u8ewG748bIPjK4A=;
	b=4Hq3s6uspTIHWQiCfwFlj4/BGh3e4ZXXJrz2osWS1elzrUrpjdlVtCGlXsvhcQXfxIKk
	 W4QLv8XMAUwQuqXG+Z9iE32pOD+zwIZHVm8s+YAP3w2v2WG1grPbvdCDiTtEav+GEdvhA
	 KnCQga5+ojltDiXYzs3qipOKQp0RbKlmF55g1mTCd7Lp9P8G/+2WLUBaWB66PwzRO43Iu
	 qLIlhy32z4oyxJfQRpkdp8kW3O8jU09IIU6tu9XcvY9yMbkACofqaxDwcBi43GmyhCROj
	 TDJuUhwmUREu8RaeqIh1GgIi6R1ZQPaSO9RsPPZZfwveOalVxBfpPyZin03Ztle759A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="YKoT3/ph";
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57F7606A321
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B57F7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YKoT3/ph
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792490732; x=1824026732;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SJT/+gBJHlJD0VXTjaNN+IYFXoWI53OxK9KNOdxe4vI=;
  b=YKoT3/phDLvj5Hpnr55QcDhJ6lnz6lcHPRV0PL/mykdgr/3hTolClcjz
   6j91dez+ZTsSZ0JKayUUis2nNCPzQSiEYpCQkYHfSQXHeTlyza4mJQ9/r
   v3WGwr+sc1byfCyde9BZC2neAzvLip184PwJT5gGx4hmm171QdMj+aRKR
   Zy4K+86C0WY+77rt7LQoqtIhAFb+3ItkJD1RE73w8hmlcbbMCBlmn8oxv
   JWTb+MlfYqeiIhEf1xjcfmWtoTLu48nzXMSd6+ri1xvjCejl7rkCzSS2R
   I5xpMwZvZ+OEfa5Pjb29G7DEq34SZ4F0lEUEv73VTjWoSZejJ5aohwWui
   g==;
X-CSE-ConnectionGUID: ucWyM14HSiyKatF6vQAbnQ==
X-CSE-MsgGUID: 6YHeJAq0QficB3w01aXXXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1224790"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1224790"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 03:05:31 -0700
X-CSE-ConnectionGUID: cEoAk2NCQ/2TR+dmwzZVzg==
X-CSE-MsgGUID: Lt3eBeEJT3eam7z31OBOyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2778351"
Received: from abityuts-desk1.ger.corp.intel.com (HELO fedora) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 03:05:29 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Natalie Vock <nat@pixelcluster.dev>,
	Arun Pravin <arunpravin.paneerselvam@amd.com>,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/ttm, drm/xe: Don't invoke the OOM killer when evicting VRAM at suspend
Date: Tue, 20 Oct 2026 12:05:04 +0200
Message-ID: <20261020100504.46684-1-thomas.hellstrom@linux.intel.com>
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

When evicting user BOs from VRAM at suspend time, allocating system
memory for the eviction may currently invoke the OOM killer. Under
memory pressure it is preferable to abort the suspend and return
-ENOMEM rather than killing processes.

TTM's ttm_resource_manager_evict_all() uses a default operation
context, which doesn't allow the caller to request
__GFP_RETRY_MAYFAIL allocations. Introduce
ttm_resource_manager_evict_all_ctx() taking a caller-supplied
struct ttm_operation_ctx, keeping ttm_resource_manager_evict_all()
as an exported wrapper using a default context so that existing
users are unaffected. Also honor the ctx interruptible setting when
waiting for the eviction fences.

Use the new function from xe_bo_evict_all_user() with
gfp_retry_mayfail set.

Note that the PM notifier eviction is best-effort and ignores errors.
Any remaining BOs are evicted again from the .suspend() callback,
where an -ENOMEM might then cause the suspend to be aborted.

Fixes: c6a4d46ec1d7 ("drm/xe: evict user memory in PM notifier")
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Natalie Vock <nat@pixelcluster.dev>
Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
Cc: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.16+
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9615
Assisted-by: LLM
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/ttm/ttm_resource.c | 37 +++++++++++++++++++++++-------
 drivers/gpu/drm/xe/xe_bo_evict.c   |  5 +++-
 include/drm/ttm/ttm_resource.h     |  5 ++++
 3 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index 4e6d3d658d85..5296b32a2e92 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -568,24 +568,26 @@ void ttm_resource_manager_init(struct ttm_resource_manager *man,
 }
 EXPORT_SYMBOL(ttm_resource_manager_init);
 
-/*
- * ttm_resource_manager_evict_all
- *
+/**
+ * ttm_resource_manager_evict_all_ctx() - Evict all objects from a manager
  * @bdev: device to use
  * @man: manager to use
+ * @ctx: operation context for the eviction
  *
  * Evict all the objects out of a memory manager until it is empty.
  * Part of memory manager cleanup sequence.
+ *
+ * Return: 0 on success, negative error code on failure.
  */
-int ttm_resource_manager_evict_all(struct ttm_device *bdev,
-				   struct ttm_resource_manager *man)
+int ttm_resource_manager_evict_all_ctx(struct ttm_device *bdev,
+				       struct ttm_resource_manager *man,
+				       struct ttm_operation_ctx *ctx)
 {
-	struct ttm_operation_ctx ctx = { };
 	struct dma_fence *fence;
 	int ret, i;
 
 	do {
-		ret = ttm_bo_evict_first(bdev, man, &ctx);
+		ret = ttm_bo_evict_first(bdev, man, ctx);
 		cond_resched();
 	} while (!ret);
 
@@ -600,7 +602,7 @@ int ttm_resource_manager_evict_all(struct ttm_device *bdev,
 		if (fence && !dma_fence_is_signaled(fence)) {
 			dma_fence_get(fence);
 			spin_unlock(&man->eviction_lock);
-			ret = dma_fence_wait(fence, false);
+			ret = dma_fence_wait(fence, ctx->interruptible);
 			dma_fence_put(fence);
 			if (ret)
 				return ret;
@@ -611,6 +613,25 @@ int ttm_resource_manager_evict_all(struct ttm_device *bdev,
 
 	return ret;
 }
+EXPORT_SYMBOL(ttm_resource_manager_evict_all_ctx);
+
+/**
+ * ttm_resource_manager_evict_all() - Evict all objects from a manager
+ * @bdev: device to use
+ * @man: manager to use
+ *
+ * Same as ttm_resource_manager_evict_all_ctx() using a default,
+ * non-interruptible operation context.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int ttm_resource_manager_evict_all(struct ttm_device *bdev,
+				   struct ttm_resource_manager *man)
+{
+	struct ttm_operation_ctx ctx = { };
+
+	return ttm_resource_manager_evict_all_ctx(bdev, man, &ctx);
+}
 EXPORT_SYMBOL(ttm_resource_manager_evict_all);
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_bo_evict.c b/drivers/gpu/drm/xe/xe_bo_evict.c
index 7661fca7f278..a37316a27573 100644
--- a/drivers/gpu/drm/xe/xe_bo_evict.c
+++ b/drivers/gpu/drm/xe/xe_bo_evict.c
@@ -114,6 +114,9 @@ void xe_bo_notifier_unprepare_all_pinned(struct xe_device *xe)
  */
 int xe_bo_evict_all_user(struct xe_device *xe)
 {
+	struct ttm_operation_ctx ctx = {
+		.gfp_retry_mayfail = true,
+	};
 	struct ttm_device *bdev = &xe->ttm;
 	u32 mem_type;
 	int ret;
@@ -135,7 +138,7 @@ int xe_bo_evict_all_user(struct xe_device *xe)
 			continue;
 
 		if (man) {
-			ret = ttm_resource_manager_evict_all(bdev, man);
+			ret = ttm_resource_manager_evict_all_ctx(bdev, man, &ctx);
 			if (ret)
 				return ret;
 		}
diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
index 714c533622c2..6cf9187a12eb 100644
--- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -42,6 +42,7 @@ struct dmem_cgroup_device;
 struct dmem_cgroup_region;
 struct drm_printer;
 struct ttm_device;
+struct ttm_operation_ctx;
 struct ttm_resource_manager;
 struct ttm_resource;
 struct ttm_place;
@@ -488,6 +489,10 @@ void ttm_resource_manager_set_dmem_region(struct ttm_resource_manager *man,
 int ttm_resource_manager_dmem_reclaim(struct dmem_cgroup_pool_state *pool,
 				      u64 target_bytes, void *priv);
 
+int ttm_resource_manager_evict_all_ctx(struct ttm_device *bdev,
+				       struct ttm_resource_manager *man,
+				       struct ttm_operation_ctx *ctx);
+
 int ttm_resource_manager_evict_all(struct ttm_device *bdev,
 				   struct ttm_resource_manager *man);
 
-- 
2.56.0

