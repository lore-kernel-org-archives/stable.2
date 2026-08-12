Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21929484236
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549484; cv=none; b=djBbHvum7lYD8ZErXQh8MktCmHrJmKj26L8znpLXxdIg76yIMqPaYV4Jho54EaKySXUELgcWhCagAYwnMFumM7RCyNxuX3S+Jr9/BNh3X+zl0OK7P8cGa7sSERkqi3NyMN22M3s3BDQZ/5we1V7lfUrlrgWVs5YLqXg1DYefKFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549484; c=relaxed/simple;
	bh=JQ4/ZnxZEIcOh4xLFLARXOpongZPSOUrm4ZrvwcS3Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7Mx7gyvkuf67VMV8aHLuTb2HAXIALzTKbazj4AK5dUIPm9vxI8M6iyafE4QuTwLRIgCeEyc3ioMLw3bqupPAisbgMV4LJHQvRhEvsUiSGr91jtjAinEDO+i1REwyoSRmGZeCXRiKUJ9lZ9HGXw5EV8Kq2dFgL5DJ5yd6FRWsi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6KVNsUL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6KVNsUL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CD71F00A3F;
	Wed, 12 Aug 2026 15:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786549482;
	bh=rvqH4gEvzFYMOA8ewJJdDPOAP5GGoaPOKRZtX/V0Rig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a6KVNsULx23F9mjfPuaHRABNcGmvya7vAR7imKW6KSBcfa0z+P0Bp8HIbKWyBsjaH
	 DdRZsHkadxKjXS+fCqz0iMpwVn8li/clJ2O6li+EJFoEWfUd9NS3msDTbvl4BKJYxs
	 h/0RhFCCzCpMT8Oa1FqA3uVd3rxI0z0N+Fjkw5Yy5rNMwATrHsByQq9/AOma59PgVQ
	 sSD41hdRtv+5qcyvJ9tk7b1W0KUyEoSh6N8Ik+2IW3yTNg1Bk+8x1SdWHAMoySHfOb
	 rPvZoYTosIkNh1Ix67aBSB9l/yMVMzxnoQUgRSi7ALf+Jr8Ph4skrxYWxOpB3u4OQt
	 zwK8g2LMqcUGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yunxiang Li <Yunxiang.Li@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] drm/amdgpu: remove unused function parameter
Date: Wed, 12 Aug 2026 11:44:38 -0400
Message-ID: <20260812154439.2235925-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080542-reload-plentiful-f343@gregkh>
References: <2026080542-reload-plentiful-f343@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yunxiang Li <Yunxiang.Li@amd.com>

[ Upstream commit a541a6e865ecd8dfd8df6eeb134cc20e7139d329 ]

amdgpu_vm_bo_invalidate doesn't use the adev parameter and not all
callers have a reference to adev handy, so remove it for cleanliness.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241219151411.1150-5-Yunxiang.Li@amd.com
Signed-off-by: Christian König <christian.koenig@amd.com>
Stable-dep-of: d8726ef11512 ("drm/amdgpu: move debug_vm handling to amdgpu_cs_parser_fini")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      | 3 +--
 6 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 43308c631037b..8bb5201d88d87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1109,7 +1109,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	 * We can't use gang submit on with reserved VMIDs when the VM changes
 	 * can't be invalidated by more than one engine at the same time.
 	 */
-	if (p->gang_size > 1 && !p->adev->vm_manager.concurrent_flush) {
+	if (p->gang_size > 1 && !adev->vm_manager.concurrent_flush) {
 		for (i = 0; i < p->gang_size; ++i) {
 			struct drm_sched_entity *entity = p->entities[i];
 			struct drm_gpu_scheduler *sched = entity->rq->sched;
@@ -1193,7 +1193,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 			if (!bo)
 				continue;
 
-			amdgpu_vm_bo_invalidate(adev, bo, false);
+			amdgpu_vm_bo_invalidate(bo, false);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 951ab989d668b..0b576481f2314 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -382,7 +382,7 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
 	/* FIXME: This should be after the "if", but needs a fix to make sure
 	 * DMABuf imports are initialized in the right VM list.
 	 */
-	amdgpu_vm_bo_invalidate(adev, bo, false);
+	amdgpu_vm_bo_invalidate(bo, false);
 	if (!bo->tbo.resource || bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
 		return;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 51875f00084c3..d52ef14d92850 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -840,7 +840,6 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *filp)
 {
-	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct drm_amdgpu_gem_op *args = data;
 	struct drm_gem_object *gobj;
 	struct amdgpu_vm_bo_base *base;
@@ -900,7 +899,7 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			robj->allowed_domains |= AMDGPU_GEM_DOMAIN_GTT;
 
 		if (robj->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID)
-			amdgpu_vm_bo_invalidate(adev, robj, true);
+			amdgpu_vm_bo_invalidate(robj, true);
 
 		amdgpu_bo_unreserve(robj);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 1db8ca26f1e17..08f7927c1048a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1152,7 +1152,6 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 			   bool evict,
 			   struct ttm_resource *new_mem)
 {
-	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
 	struct ttm_resource *old_mem = bo->resource;
 	struct amdgpu_bo *abo;
 
@@ -1160,7 +1159,7 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 		return;
 
 	abo = ttm_to_amdgpu_bo(bo);
-	amdgpu_vm_bo_invalidate(adev, abo, evict);
+	amdgpu_vm_bo_invalidate(abo, evict);
 
 	amdgpu_bo_kunmap(abo);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 8864e43a165e2..ad3b71bc0b233 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2139,14 +2139,12 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
 /**
  * amdgpu_vm_bo_invalidate - mark the bo as invalid
  *
- * @adev: amdgpu_device pointer
  * @bo: amdgpu buffer object
  * @evicted: is the BO evicted
  *
  * Mark @bo as invalid.
  */
-void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
-			     struct amdgpu_bo *bo, bool evicted)
+void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
 {
 	struct amdgpu_vm_bo_base *bo_base;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 095209a2cb336..9a951e1bfee1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -511,8 +511,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
 			bool clear);
 bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
-void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
-			     struct amdgpu_bo *bo, bool evicted);
+void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted);
 uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr);
 struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
 				       struct amdgpu_bo *bo);
-- 
2.53.0

