Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6CD4457BC
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513002; cv=none; b=JxqqbFYGIX11OpkWWgTWmCNrEyFb0qpGQU8qRbVdSUCRFGRLQCs3gJR0k+j2f16mB1IMVFz/eFhkv5nCo85WXprekzREa9EJrt2ejq78Pq+VBtSvRjlLeFKYXobyMhSo92Su4roF3xxZ1HpudJ6OOvvJmUHJ75cG5pOsxsPEK5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513002; c=relaxed/simple;
	bh=iM3dxF0sKeAv4JZYTocrxUw50oozLkUr5AWkgbdZSDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3CyXxUpI6QsVO1yaj96GjisNgrgBhZT4gHHnLmW+dwh4Itv3N4YyWiZMYWw3wRS9q/LF6K99Evf8NU5olt4RMfXuMvJoI8erTH4H7NL6T0VQJR4B/G56r3I7QuDxMwz+sl4syC93picibcc6Ze/h6DwVUNHdgCMEyvb3BUDdQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUQrT+RO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUQrT+RO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B711F000E9;
	Fri, 31 Jul 2026 15:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785512997;
	bh=ENe3lkijHHAh3UGZdUyssno8IaaBce5tpNqaJmU+KOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UUQrT+ROih4mVpjEq8C+0Ylw19FlSZ/vltTPYU5ODRWQNk5Dk1CTgokrxv2DqPaEx
	 GjOvlCdUHsIIC4eH4N4xn6/dFACOIlxqCiPmlLBhMmgMoRkFFX8b298aEC+OWVjzS4
	 C8Sk/niaYkHax4axafWlsXfp3zY02NTa9hqK4rM2qt1RcK41kbV1IiIC+JuUd1gtQM
	 vP5EXBRCknpgPt9p6kQpCTL2FM4NdHvrKlF5gv7VlPufjCLUgQkpV+JZpsxWFEUpmG
	 OdyLPIz16pEsaLVLz3HsU3gUkzMQJPP7CvH5KOxSv07ZM4+gPE157xDDMio+W6OI5q
	 2I30NwmaPO6pA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] dma-buf/drivers: make reserving a shared slot mandatory v4
Date: Fri, 31 Jul 2026 11:49:54 -0400
Message-ID: <20260731154955.602576-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072937-showplace-silt-1cf7@gregkh>
References: <2026072937-showplace-silt-1cf7@gregkh>
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
 drivers/dma-buf/dma-resv.c                       | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c     |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c   |  4 ++--
 drivers/gpu/drm/i915/i915_vma.c                  |  2 +-
 drivers/gpu/drm/lima/lima_gem.c                  |  2 +-
 drivers/gpu/drm/msm/msm_gem_submit.c             |  2 +-
 drivers/gpu/drm/nouveau/nouveau_fence.c          |  2 +-
 drivers/gpu/drm/qxl/qxl_release.c                |  2 +-
 drivers/gpu/drm/radeon/radeon_vm.c               |  2 +-
 drivers/gpu/drm/ttm/ttm_bo.c                     |  4 ++--
 drivers/gpu/drm/ttm/ttm_execbuf_util.c           |  4 ++--
 drivers/gpu/drm/vc4/vc4_gem.c                    |  2 +-
 drivers/gpu/drm/vgem/vgem_fence.c                |  2 +-
 drivers/gpu/drm/virtio/virtgpu_gem.c             |  9 +++++++++
 include/linux/dma-resv.h                         |  2 +-
 18 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index bcce96d4a753..e36d11ff8b96 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -131,7 +131,7 @@ void dma_resv_fini(struct dma_resv *obj)
 EXPORT_SYMBOL(dma_resv_fini);
 
 /**
- * dma_resv_reserve_shared - Reserve space to add shared fences to
+ * dma_resv_reserve_fences - Reserve space to add shared fences to
  * a dma_resv.
  * @obj: reservation object
  * @num_fences: number of fences we want to add
@@ -142,7 +142,7 @@ EXPORT_SYMBOL(dma_resv_fini);
  * RETURNS
  * Zero for success, or -errno
  */
-int dma_resv_reserve_shared(struct dma_resv *obj, unsigned int num_fences)
+int dma_resv_reserve_fences(struct dma_resv *obj, unsigned int num_fences)
 {
 	struct dma_resv_list *old, *new;
 	unsigned int i, j, k, max;
@@ -205,7 +205,7 @@ int dma_resv_reserve_shared(struct dma_resv *obj, unsigned int num_fences)
 
 	return 0;
 }
-EXPORT_SYMBOL(dma_resv_reserve_shared);
+EXPORT_SYMBOL(dma_resv_reserve_fences);
 
 #ifdef CONFIG_DEBUG_MUTEXES
 /**
@@ -213,7 +213,7 @@ EXPORT_SYMBOL(dma_resv_reserve_shared);
  * @obj: the dma_resv object to reset
  *
  * Reset the number of pre-reserved shared slots to test that drivers do
- * correct slot allocation using dma_resv_reserve_shared(). See also
+ * correct slot allocation using dma_resv_reserve_fences(). See also
  * &dma_resv_list.shared_max.
  */
 void dma_resv_reset_shared_max(struct dma_resv *obj)
@@ -235,7 +235,7 @@ EXPORT_SYMBOL(dma_resv_reset_shared_max);
  * @fence: the shared fence to add
  *
  * Add a fence to a shared slot, obj->lock must be held, and
- * dma_resv_reserve_shared() has been called.
+ * dma_resv_reserve_fences() has been called.
  */
 void dma_resv_add_shared_fence(struct dma_resv *obj, struct dma_fence *fence)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index f34a5d23a43b..07aa9f8de264 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1236,7 +1236,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 				  AMDGPU_FENCE_OWNER_KFD, false);
 	if (ret)
 		goto wait_pd_fail;
-	ret = dma_resv_reserve_shared(vm->root.bo->tbo.base.resv, 1);
+	ret = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 1);
 	if (ret)
 		goto reserve_shared_fail;
 	amdgpu_bo_fence(vm->root.bo,
@@ -2461,7 +2461,7 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
 	 * Add process eviction fence to bo so they can
 	 * evict each other.
 	 */
-	ret = dma_resv_reserve_shared(gws_bo->tbo.base.resv, 1);
+	ret = dma_resv_reserve_fences(gws_bo->tbo.base.resv, 1);
 	if (ret)
 		goto reserve_shared_fail;
 	amdgpu_bo_fence(gws_bo, &process_info->eviction_fence->base, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 77997a7ca534..256f2e5399ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3008,7 +3008,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	if (r)
 		goto error_free_root;
 
-	r = dma_resv_reserve_shared(root_bo->tbo.base.resv, 1);
+	r = dma_resv_reserve_fences(root_bo->tbo.base.resv, 1);
 	if (r)
 		goto error_unreserve;
 
@@ -3459,7 +3459,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		value = 0;
 	}
 
-	r = dma_resv_reserve_shared(root->tbo.base.resv, 1);
+	r = dma_resv_reserve_fences(root->tbo.base.resv, 1);
 	if (r) {
 		pr_debug("failed %d to reserve fence slot\n", r);
 		goto error_unlock;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index d21bebfa884e..ff776944793a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -512,7 +512,7 @@ svm_range_vram_node_new(struct amdgpu_device *adev, struct svm_range *prange,
 		goto reserve_bo_failed;
 	}
 
-	r = dma_resv_reserve_shared(bo->tbo.base.resv, 1);
+	r = dma_resv_reserve_fences(bo->tbo.base.resv, 1);
 	if (r) {
 		pr_debug("failed %d to reserve bo\n", r);
 		amdgpu_bo_unreserve(bo);
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
index 90488ab8c6d8..f8c0ab3eabf4 100644
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
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index 0d480867fc0c..86e8f48e352b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -958,7 +958,7 @@ static int eb_validate_vmas(struct i915_execbuffer *eb)
 		}
 
 		if (!(ev->flags & EXEC_OBJECT_WRITE)) {
-			err = dma_resv_reserve_shared(vma->resv, 1);
+			err = dma_resv_reserve_fences(vma->resv, 1);
 			if (err)
 				return err;
 		}
@@ -2160,7 +2160,7 @@ static int eb_parse(struct i915_execbuffer *eb)
 		goto err_trampoline;
 	}
 
-	err = dma_resv_reserve_shared(shadow->resv, 1);
+	err = dma_resv_reserve_fences(shadow->resv, 1);
 	if (err)
 		goto err_trampoline;
 
diff --git a/drivers/gpu/drm/i915/i915_vma.c b/drivers/gpu/drm/i915/i915_vma.c
index d9ca42203517..2c329ff29119 100644
--- a/drivers/gpu/drm/i915/i915_vma.c
+++ b/drivers/gpu/drm/i915/i915_vma.c
@@ -1278,7 +1278,7 @@ int i915_vma_move_to_active(struct i915_vma *vma,
 		obj->read_domains = 0;
 	} else {
 		if (!(flags & __EXEC_OBJECT_NO_RESERVE)) {
-			err = dma_resv_reserve_shared(vma->resv, 1);
+			err = dma_resv_reserve_fences(vma->resv, 1);
 			if (unlikely(err))
 				return err;
 		}
diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
index 65c4327b6d10..a45970245014 100644
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
index 2ffb2ca88ffe..09ca040c811b 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -349,7 +349,7 @@ static int submit_fence_sync(struct msm_gem_submit *submit, bool no_implicit)
 			 * strange place to call it.  OTOH this is a
 			 * convenient can-fail point to hook it in.
 			 */
-			ret = dma_resv_reserve_shared(obj->resv, 1);
+			ret = dma_resv_reserve_fences(obj->resv, 1);
 			if (ret)
 				return ret;
 		}
diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
index af2b71e3058c..19daebaef0aa 100644
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
index b19f2f00b215..0abffbe3c1fa 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -200,7 +200,7 @@ static int qxl_release_validate_bo(struct qxl_bo *bo)
 			return ret;
 	}
 
-	ret = dma_resv_reserve_shared(bo->tbo.base.resv, 1);
+	ret = dma_resv_reserve_fences(bo->tbo.base.resv, 1);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/radeon_vm.c
index f2fc8ef99139..c38b4d5d6a14 100644
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
index 391ed462f7fb..a92c2e8da504 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -767,7 +767,7 @@ static int ttm_bo_add_move_fence(struct ttm_buffer_object *bo,
 
 	dma_resv_add_shared_fence(bo->base.resv, fence);
 
-	ret = dma_resv_reserve_shared(bo->base.resv, 1);
+	ret = dma_resv_reserve_fences(bo->base.resv, 1);
 	if (unlikely(ret)) {
 		dma_fence_put(fence);
 		return ret;
@@ -826,7 +826,7 @@ int ttm_bo_mem_space(struct ttm_buffer_object *bo,
 	bool type_found = false;
 	int i, ret;
 
-	ret = dma_resv_reserve_shared(bo->base.resv, 1);
+	ret = dma_resv_reserve_fences(bo->base.resv, 1);
 	if (unlikely(ret))
 		return ret;
 
diff --git a/drivers/gpu/drm/ttm/ttm_execbuf_util.c b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
index 071c48d672c6..f04db8672882 100644
--- a/drivers/gpu/drm/ttm/ttm_execbuf_util.c
+++ b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
@@ -104,7 +104,7 @@ int ttm_eu_reserve_buffers(struct ww_acquire_ctx *ticket,
 			if (!entry->num_shared)
 				continue;
 
-			ret = dma_resv_reserve_shared(bo->base.resv,
+			ret = dma_resv_reserve_fences(bo->base.resv,
 								entry->num_shared);
 			if (!ret)
 				continue;
@@ -121,7 +121,7 @@ int ttm_eu_reserve_buffers(struct ww_acquire_ctx *ticket,
 		}
 
 		if (!ret && entry->num_shared)
-			ret = dma_resv_reserve_shared(bo->base.resv,
+			ret = dma_resv_reserve_fences(bo->base.resv,
 								entry->num_shared);
 
 		if (unlikely(ret != 0)) {
diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index a52736cf1f7a..ff77aee38977 100644
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
index 539cf4ee5767..eccf778d6950 100644
--- a/drivers/gpu/drm/vgem/vgem_fence.c
+++ b/drivers/gpu/drm/vgem/vgem_fence.c
@@ -161,7 +161,7 @@ int vgem_fence_attach_ioctl(struct drm_device *dev,
 	dma_resv_lock(resv, NULL);
 	if (arg->flags & VGEM_FENCE_WRITE)
 		dma_resv_add_excl_fence(resv, fence);
-	else if ((ret = dma_resv_reserve_shared(resv, 1)) == 0)
+	else if ((ret = dma_resv_reserve_fences(resv, 1)) == 0)
 		dma_resv_add_shared_fence(resv, fence);
 	dma_resv_unlock(resv);
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 48d3c9955f0d..1820ca6cf673 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -214,6 +214,7 @@ void virtio_gpu_array_add_obj(struct virtio_gpu_object_array *objs,
 
 int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs)
 {
+	unsigned int i;
 	int ret;
 
 	if (objs->nents == 1) {
@@ -222,6 +223,14 @@ int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs)
 		ret = drm_gem_lock_reservations(objs->objs, objs->nents,
 						&objs->ticket);
 	}
+	if (ret)
+		return ret;
+
+	for (i = 0; i < objs->nents; ++i) {
+		ret = dma_resv_reserve_fences(objs->objs[i]->resv, 1);
+		if (ret)
+			return ret;
+	}
 	return ret;
 }
 
diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
index ef9f94ce2cc3..8a9348c8b91a 100644
--- a/include/linux/dma-resv.h
+++ b/include/linux/dma-resv.h
@@ -364,7 +364,7 @@ static inline struct dma_resv_list *dma_resv_shared_list(struct dma_resv *obj)
 
 void dma_resv_init(struct dma_resv *obj);
 void dma_resv_fini(struct dma_resv *obj);
-int dma_resv_reserve_shared(struct dma_resv *obj, unsigned int num_fences);
+int dma_resv_reserve_fences(struct dma_resv *obj, unsigned int num_fences);
 void dma_resv_add_shared_fence(struct dma_resv *obj, struct dma_fence *fence);
 void dma_resv_add_excl_fence(struct dma_resv *obj, struct dma_fence *fence);
 int dma_resv_get_fences(struct dma_resv *obj, struct dma_fence **pfence_excl,
-- 
2.53.0

