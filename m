Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F6746D2DC
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515411; cv=none; b=eYXCoifgtCi9UBD+wh5qWJIDvpiv8a1Sbmm3iWym60ZAWypanKDz+5v45D4qrghDRPxdjsgGek5/7Gc5Gca12p48uJXF3jKtjBTTAvN3pP5YSp0ua5N5cxxPsJ4KuTQKT4hyWkZIe68mCL++f86oBA1qEqxBjxcnBbiaUKFgMKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515411; c=relaxed/simple;
	bh=64eAfVZHadYyCV9NQrrVrTq3ag6fbkAYlpQ1Yu9eFFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MmwVP0JMfZkgmVdcBAEk+GkCohrlHll5UQLWEcjPCySvgknP+WbAbYb3Bem4GwKxR2tJwgYoH0eSxVQ873nLqmy3p7m+JhlhyHWkXVyoty/q387CJr4iJIfy6zGOnlhMZHzG4hJ4RL+fJukSSw3rLJ5LeaWxDw/JOni0+/8u4iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKO5nlvS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKO5nlvS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDCE1F00AC4;
	Fri, 31 Jul 2026 16:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785515408;
	bh=uDgBPYcFoRY5e3XFy+GCUo9TsJqdHGReo1O+cVsoBp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jKO5nlvSaEF9nuv5BJ7dup4bv3reD7PdHLlMjz7PJo/wpZkDPK3jYLaOvo8K94Sut
	 jn2QAANDMj3DhLlwuFQDhA1JsZDXdbwp6/caGqCpN73sggofzuwrEuHte7pfkJWiEj
	 OkxILcpeJkuBakRBDfGv4J8jh+FdvKOc4E+KrljbP64oFLwSJpLjaMW6+cXWY125hx
	 MpsvZKAEhCCjDbsk7+J5OxmR1Iuwt4WEDAFVusSpUzuAgcilHOXE+OAkp1wagw/+o+
	 KcEHItt3huRx3RyFdtxwMtjqKghyIcB6QHFrHLyywviWkWLcPEmyygR0MuazIfEUbl
	 iXxGK/HxVYfWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] dma-buf/drivers: make reserving a shared slot mandatory v4
Date: Fri, 31 Jul 2026 12:30:04 -0400
Message-ID: <20260731163005.805250-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072938-nearby-drab-19c2@gregkh>
References: <2026072938-nearby-drab-19c2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian König <christian.koenig@amd.com>

[ Upstream commit c8d4c18bfbc4ab467188dbe45cc8155759f49d9e ]

Audit all the users of dma_resv_add_excl_fence() and make sure they
reserve a shared slot also when only trying to add an exclusive fence.

This is the next step towards handling the exclusive fence like a
shared one.

v2: fix missed case in amdgpu
v3: and two more radeon, rename function
v4: add one more case to TTM, fix i915 after rebase

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20220406075132.3263-2-christian.koenig@amd.com
Stable-dep-of: a48bbcc7ac73 ("drm/virtio: use uninterruptible resv lock for plane updates")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma-buf/dma-resv.c                       | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c     | 2 +-
 drivers/gpu/drm/i915/i915_vma.c                  | 2 +-
 drivers/gpu/drm/lima/lima_gem.c                  | 2 +-
 drivers/gpu/drm/msm/msm_gem_submit.c             | 2 +-
 drivers/gpu/drm/nouveau/nouveau_fence.c          | 2 +-
 drivers/gpu/drm/qxl/qxl_release.c                | 2 +-
 drivers/gpu/drm/radeon/radeon_vm.c               | 2 +-
 drivers/gpu/drm/ttm/ttm_bo.c                     | 4 ++--
 drivers/gpu/drm/ttm/ttm_execbuf_util.c           | 4 ++--
 drivers/gpu/drm/vc4/vc4_gem.c                    | 2 +-
 drivers/gpu/drm/vgem/vgem_fence.c                | 2 +-
 include/linux/dma-resv.h                         | 2 +-
 15 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index 72e87380b61a..1a1dab99a11f 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -173,7 +173,7 @@ void dma_resv_fini(struct dma_resv *obj)
 EXPORT_SYMBOL(dma_resv_fini);
 
 /**
- * dma_resv_reserve_shared - Reserve space to add shared fences to
+ * dma_resv_reserve_fences - Reserve space to add shared fences to
  * a dma_resv.
  * @obj: reservation object
  * @num_fences: number of fences we want to add
@@ -184,7 +184,7 @@ EXPORT_SYMBOL(dma_resv_fini);
  * RETURNS
  * Zero for success, or -errno
  */
-int dma_resv_reserve_shared(struct dma_resv *obj, unsigned int num_fences)
+int dma_resv_reserve_fences(struct dma_resv *obj, unsigned int num_fences)
 {
 	struct dma_resv_list *old, *new;
 	unsigned int i, j, k, max;
@@ -250,7 +250,7 @@ int dma_resv_reserve_shared(struct dma_resv *obj, unsigned int num_fences)
 
 	return 0;
 }
-EXPORT_SYMBOL(dma_resv_reserve_shared);
+EXPORT_SYMBOL(dma_resv_reserve_fences);
 
 /**
  * dma_resv_add_shared_fence - Add a fence to a shared slot
@@ -258,7 +258,7 @@ EXPORT_SYMBOL(dma_resv_reserve_shared);
  * @fence: the shared fence to add
  *
  * Add a fence to a shared slot, obj->lock must be held, and
- * dma_resv_reserve_shared() has been called.
+ * dma_resv_reserve_fences() has been called.
  */
 void dma_resv_add_shared_fence(struct dma_resv *obj, struct dma_fence *fence)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index ad89377404dd..a574c89193bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -950,7 +950,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 				  AMDGPU_FENCE_OWNER_KFD, false);
 	if (ret)
 		goto wait_pd_fail;
-	ret = dma_resv_reserve_shared(vm->root.base.bo->tbo.base.resv, 1);
+	ret = dma_resv_reserve_fences(vm->root.base.bo->tbo.base.resv, 1);
 	if (ret)
 		goto reserve_shared_fail;
 	amdgpu_bo_fence(vm->root.base.bo,
@@ -2205,7 +2205,7 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
 	 * Add process eviction fence to bo so they can
 	 * evict each other.
 	 */
-	ret = dma_resv_reserve_shared(gws_bo->tbo.base.resv, 1);
+	ret = dma_resv_reserve_fences(gws_bo->tbo.base.resv, 1);
 	if (ret)
 		goto reserve_shared_fail;
 	amdgpu_bo_fence(gws_bo, &process_info->eviction_fence->base, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ad3de971a087..499e8c842809 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2904,7 +2904,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_free_root;
 
-	r = dma_resv_reserve_shared(root->tbo.base.resv, 1);
+	r = dma_resv_reserve_fences(root->tbo.base.resv, 1);
 	if (r)
 		goto error_unreserve;
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
index ddf539f26f2d..9ff895c615df 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
@@ -180,7 +180,7 @@ static int submit_fence_sync(struct etnaviv_gem_submit *submit)
 		struct dma_resv *robj = bo->obj->base.resv;
 
 		if (!(bo->flags & ETNA_SUBMIT_BO_WRITE)) {
-			ret = dma_resv_reserve_shared(robj, 1);
+			ret = dma_resv_reserve_fences(robj, 1);
 			if (ret)
 				return ret;
 		}
diff --git a/drivers/gpu/drm/i915/i915_vma.c b/drivers/gpu/drm/i915/i915_vma.c
index 50a86fd89d00..991dacd28c03 100644
--- a/drivers/gpu/drm/i915/i915_vma.c
+++ b/drivers/gpu/drm/i915/i915_vma.c
@@ -1241,7 +1241,7 @@ int i915_vma_move_to_active(struct i915_vma *vma,
 		obj->write_domain = I915_GEM_DOMAIN_RENDER;
 		obj->read_domains = 0;
 	} else {
-		err = dma_resv_reserve_shared(vma->resv, 1);
+		err = dma_resv_reserve_fences(vma->resv, 1);
 		if (unlikely(err))
 			return err;
 
diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
index 894175f2ed49..9c1a2c2d2bcd 100644
--- a/drivers/gpu/drm/lima/lima_gem.c
+++ b/drivers/gpu/drm/lima/lima_gem.c
@@ -263,7 +263,7 @@ static int lima_gem_sync_bo(struct lima_sched_task *task, struct lima_bo *bo,
 	int err = 0;
 
 	if (!write) {
-		err = dma_resv_reserve_shared(lima_bo_resv(bo), 1);
+		err = dma_resv_reserve_fences(lima_bo_resv(bo), 1);
 		if (err)
 			return err;
 	}
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index c4e5037512b9..817e1c2d7f64 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -230,7 +230,7 @@ static int submit_fence_sync(struct msm_gem_submit *submit, bool no_implicit)
 			 * strange place to call it.  OTOH this is a
 			 * convenient can-fail point to hook it in.
 			 */
-			ret = dma_resv_reserve_shared(msm_obj->base.resv,
+			ret = dma_resv_reserve_fences(msm_obj->base.resv,
 								1);
 			if (ret)
 				return ret;
diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
index d31bf9e49bcd..12e32a061586 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -349,7 +349,7 @@ nouveau_fence_sync(struct nouveau_bo *nvbo, struct nouveau_channel *chan, bool e
 	int ret = 0, i;
 
 	if (!exclusive) {
-		ret = dma_resv_reserve_shared(resv, 1);
+		ret = dma_resv_reserve_fences(resv, 1);
 
 		if (ret)
 			return ret;
diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index b2a475a0ca4a..c157ac9b0849 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -239,7 +239,7 @@ static int qxl_release_validate_bo(struct qxl_bo *bo)
 			return ret;
 	}
 
-	ret = dma_resv_reserve_shared(bo->tbo.base.resv, 1);
+	ret = dma_resv_reserve_fences(bo->tbo.base.resv, 1);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/radeon_vm.c
index cb75ff1f6f2c..75a3f7d41b8e 100644
--- a/drivers/gpu/drm/radeon/radeon_vm.c
+++ b/drivers/gpu/drm/radeon/radeon_vm.c
@@ -831,7 +831,7 @@ static int radeon_vm_update_ptes(struct radeon_device *rdev,
 		int r;
 
 		radeon_sync_resv(rdev, &ib->sync, pt->tbo.base.resv, true);
-		r = dma_resv_reserve_shared(pt->tbo.base.resv, 1);
+		r = dma_resv_reserve_fences(pt->tbo.base.resv, 1);
 		if (r)
 			return r;
 
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 8fe3be20af62..bf9fd5e8a381 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -830,7 +830,7 @@ static int ttm_bo_add_move_fence(struct ttm_buffer_object *bo,
 
 	dma_resv_add_shared_fence(bo->base.resv, fence);
 
-	ret = dma_resv_reserve_shared(bo->base.resv, 1);
+	ret = dma_resv_reserve_fences(bo->base.resv, 1);
 	if (unlikely(ret)) {
 		dma_fence_put(fence);
 		return ret;
@@ -950,7 +950,7 @@ int ttm_bo_mem_space(struct ttm_buffer_object *bo,
 	bool type_found = false;
 	int i, ret;
 
-	ret = dma_resv_reserve_shared(bo->base.resv, 1);
+	ret = dma_resv_reserve_fences(bo->base.resv, 1);
 	if (unlikely(ret))
 		return ret;
 
diff --git a/drivers/gpu/drm/ttm/ttm_execbuf_util.c b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
index 8a8f1a6a83a6..1e22f6ce817a 100644
--- a/drivers/gpu/drm/ttm/ttm_execbuf_util.c
+++ b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
@@ -106,7 +106,7 @@ int ttm_eu_reserve_buffers(struct ww_acquire_ctx *ticket,
 			if (!entry->num_shared)
 				continue;
 
-			ret = dma_resv_reserve_shared(bo->base.resv,
+			ret = dma_resv_reserve_fences(bo->base.resv,
 								entry->num_shared);
 			if (!ret)
 				continue;
@@ -123,7 +123,7 @@ int ttm_eu_reserve_buffers(struct ww_acquire_ctx *ticket,
 		}
 
 		if (!ret && entry->num_shared)
-			ret = dma_resv_reserve_shared(bo->base.resv,
+			ret = dma_resv_reserve_fences(bo->base.resv,
 								entry->num_shared);
 
 		if (unlikely(ret != 0)) {
diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index e4f20b93c33e..82b413ae11ac 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -644,7 +644,7 @@ vc4_lock_bo_reservations(struct drm_device *dev,
 	for (i = 0; i < exec->bo_count; i++) {
 		bo = &exec->bo[i]->base;
 
-		ret = dma_resv_reserve_shared(bo->resv, 1);
+		ret = dma_resv_reserve_fences(bo->resv, 1);
 		if (ret) {
 			vc4_unlock_bo_reservations(dev, exec, acquire_ctx);
 			return ret;
diff --git a/drivers/gpu/drm/vgem/vgem_fence.c b/drivers/gpu/drm/vgem/vgem_fence.c
index f860ff1db648..84b0c73bcf0c 100644
--- a/drivers/gpu/drm/vgem/vgem_fence.c
+++ b/drivers/gpu/drm/vgem/vgem_fence.c
@@ -162,7 +162,7 @@ int vgem_fence_attach_ioctl(struct drm_device *dev,
 	dma_resv_lock(resv, NULL);
 	if (arg->flags & VGEM_FENCE_WRITE)
 		dma_resv_add_excl_fence(resv, fence);
-	else if ((ret = dma_resv_reserve_shared(resv, 1)) == 0)
+	else if ((ret = dma_resv_reserve_fences(resv, 1)) == 0)
 		dma_resv_add_shared_fence(resv, fence);
 	dma_resv_unlock(resv);
 
diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
index d44a77e8a7e3..f35f264cac1a 100644
--- a/include/linux/dma-resv.h
+++ b/include/linux/dma-resv.h
@@ -273,7 +273,7 @@ dma_resv_get_excl_rcu(struct dma_resv *obj)
 
 void dma_resv_init(struct dma_resv *obj);
 void dma_resv_fini(struct dma_resv *obj);
-int dma_resv_reserve_shared(struct dma_resv *obj, unsigned int num_fences);
+int dma_resv_reserve_fences(struct dma_resv *obj, unsigned int num_fences);
 void dma_resv_add_shared_fence(struct dma_resv *obj, struct dma_fence *fence);
 
 void dma_resv_add_excl_fence(struct dma_resv *obj, struct dma_fence *fence);
-- 
2.53.0

