Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E47753FD27
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583837; cv=none; b=S5cl/FfXLx8eFSwbOapLe7uHPd//Lj6Jr6mxVkdKS5kbfTuACey6wfust7HWf4oVLNWvorc5X1dY2rFkd2IMm3CRp6nzcncobtIJF79rSuqa3lvrWBqv/XPmTyTzOdlvX5EfR76LbNKqJ8zLcXGnqZ5+azQldzAMUBd87U+c1pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583837; c=relaxed/simple;
	bh=38DsnRUADEA9KAV32AkPZP45sPj+366JlGJ/FarSlEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ScoDWK0Bm4z2YWZ6eKHntg2P42oqT5M0Z40ObrwOHUlLX4RlLCuhPMoNGXX4VLWlCYY6ihBW0CyLnSUK0Oi/3FuWNgpvCYT03S2r+oH/IrQCwwMhtKL/SJzlo6binC22ddabu/FRGLQj4fy0CGknXAxuOc0y+z6xKPZJo/Nq1fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuzckGGH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuzckGGH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B748F1F0089A;
	Wed, 16 Sep 2026 18:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583803;
	bh=m/mcXmZoul9FgJ2qXkR09O6yTG3MPB+8QQsZcBJ0qDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZuzckGGHPaLZU/9JjxfZXpGoba3mXk9zgMXfTQYBNribShPV9q3c2jXANVj0lKDp3
	 4ShwrjrZEW3xvJfryiqjqYgBN9c+Fl0XcfdvpS6wynkwo6ct9vJRGmShBE8zm1Ol05
	 N/dMZQsmPbRnBMD2HzAMlMAa5LE5JTcMlVowV542+w4OT3plbf96C9WBGFZMpnDP6p
	 MOvC2wUtKKj3mxXnUeXfwpeqB76PeKlxqvSFf8OeKF4AckurUrR2l8yGyeUG/xlt23
	 /MfeGrgrYeaiEJ8QmNyKRfJMfhPpJVUzhShS8mSD/HhonGdurb3BoiUjBhALl1/2Yf
	 kLPsbw/lP4tWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] drm/amdgpu: get rid of amdgpu_ttm_clear_buffer
Date: Wed, 16 Sep 2026 14:36:39 -0400
Message-ID: <20260916183641.1771014-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091636-creole-glorified-e7b6@gregkh>
References: <2026091636-creole-glorified-e7b6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

[ Upstream commit 23bd7e67961ee531386246e98021273bb45b0a84 ]

It's doing the same thing as amdgpu_fill_buffer(src_data=0), so drop it.

The only caveat is that amdgpu_res_cleared() return value is only valid
right after allocation.

---
v2: introduce new "bool consider_clear_status" arg
v6: dont pass a NULL resv when calling amdgpu_fill_buffer from
    amdgpu_bo_create
---

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Stable adaptation for 6.18:

Consolidate allocation clearing and VRAM wiping in amdgpu_fill_buffer,
using the existing high_pr/low_pr drm_sched_entity objects and shared
GART-window mutex. The upstream buffer-entity infrastructure is absent.
Preserve the existing scheduling priorities and reservation dependencies,
only skip cleared regions immediately after allocation, and handle a
successful no-job clear with a NULL fence and an initialized return code.

To prepare the unchanged VMID-flush fix in 87ceb8cba73d, pass these existing
entities explicitly through the map/copy/fill helpers. Remove the unused
direct-submit option (all callers passed false), update the benchmark and
KFD callers, and specialize the fill entry point to zero, its only use.
Use GART window 0 for clearing, matching the target's context. No functions
or dynamic buffer-entity infrastructure are added; the VMID-flush behavior
itself is left for the target commit.

Stable-dep-of: 87ceb8cba73d ("drm/amdgpu: skip the VMID 0 flush for VRAM")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 189 +++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  21 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |   5 +-
 5 files changed, 93 insertions(+), 143 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
index 199693369c7ce..81d0e16fd1fe4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
@@ -37,9 +37,9 @@ static int amdgpu_benchmark_do_move(struct amdgpu_device *adev, unsigned size,
 
 	stime = ktime_get();
 	for (i = 0; i < n; i++) {
-		struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
-		r = amdgpu_copy_buffer(ring, saddr, daddr, size, NULL, &fence,
-				       false, false, 0);
+		r = amdgpu_copy_buffer(adev, &adev->mman.high_pr,
+				       saddr, daddr, size, NULL, &fence,
+				       false, 0);
 		if (r)
 			goto exit_do_move;
 		r = dma_fence_wait(fence, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index cdab2c098cfab..e29bcb090f06d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -728,13 +728,17 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	    bo->tbo.resource->mem_type == TTM_PL_VRAM) {
 		struct dma_fence *fence;
 
-		r = amdgpu_ttm_clear_buffer(bo, bo->tbo.base.resv, &fence);
+		r = amdgpu_fill_buffer(&adev->mman.low_pr, bo,
+				       bo->tbo.base.resv, &fence, true,
+				       AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER);
 		if (unlikely(r))
 			goto fail_unreserve;
 
-		dma_resv_add_fence(bo->tbo.base.resv, fence,
-				   DMA_RESV_USAGE_KERNEL);
-		dma_fence_put(fence);
+		if (fence) {
+			dma_resv_add_fence(bo->tbo.base.resv, fence,
+					   DMA_RESV_USAGE_KERNEL);
+			dma_fence_put(fence);
+		}
 	}
 	if (!bp->resv)
 		amdgpu_bo_unreserve(bo);
@@ -1324,7 +1328,8 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
 	if (r)
 		goto out;
 
-	r = amdgpu_fill_buffer(abo, 0, &bo->base._resv, &fence, true,
+	r = amdgpu_fill_buffer(&adev->mman.low_pr, abo,
+			       &bo->base._resv, &fence, false,
 			       AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
 	if (WARN_ON(r))
 		goto out;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index c48c266cc7a75..dbaba8aacec27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -167,11 +167,11 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
 
 /**
  * amdgpu_ttm_map_buffer - Map memory into the GART windows
+ * @entity: scheduler entity to use
  * @bo: buffer object to map
  * @mem: memory object to map
  * @mm_cur: range to map
  * @window: which GART window to use
- * @ring: DMA ring to use for the copy
  * @tmz: if we should setup a TMZ enabled mapping
  * @size: in number of bytes to map, out number of bytes mapped
  * @addr: resulting address inside the MC address space
@@ -179,14 +179,16 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
  * Setup one of the GART windows to access a specific piece of memory or return
  * the physical address for local memory.
  */
-static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
+static int amdgpu_ttm_map_buffer(struct drm_sched_entity *entity,
+				 struct ttm_buffer_object *bo,
 				 struct ttm_resource *mem,
 				 struct amdgpu_res_cursor *mm_cur,
-				 unsigned int window, struct amdgpu_ring *ring,
+				 unsigned int window,
 				 bool tmz, uint64_t *size, uint64_t *addr)
 {
-	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
 	unsigned int offset, num_pages, num_dw, num_bytes;
+	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
 	uint64_t src_addr, dst_addr;
 	struct amdgpu_job *job;
 	void *cpu_addr;
@@ -227,7 +229,7 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
 	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
 	num_bytes = num_pages * 8 * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
 
-	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.high_pr,
+	r = amdgpu_job_alloc_with_ib(adev, entity,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     num_dw * 4 + num_bytes,
 				     AMDGPU_IB_POOL_DELAYED, &job,
@@ -296,7 +298,7 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 			       struct dma_resv *resv,
 			       struct dma_fence **f)
 {
-	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
+	struct drm_sched_entity *entity = &adev->mman.high_pr;
 	struct amdgpu_res_cursor src_mm, dst_mm;
 	struct dma_fence *fence = NULL;
 	int r = 0;
@@ -322,13 +324,13 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 		cur_size = min3(src_mm.size, dst_mm.size, 256ULL << 20);
 
 		/* Map src to window 0 and dst to window 1. */
-		r = amdgpu_ttm_map_buffer(src->bo, src->mem, &src_mm,
-					  0, ring, tmz, &cur_size, &from);
+		r = amdgpu_ttm_map_buffer(entity, src->bo, src->mem, &src_mm,
+					  0, tmz, &cur_size, &from);
 		if (r)
 			goto error;
 
-		r = amdgpu_ttm_map_buffer(dst->bo, dst->mem, &dst_mm,
-					  1, ring, tmz, &cur_size, &to);
+		r = amdgpu_ttm_map_buffer(entity, dst->bo, dst->mem, &dst_mm,
+					  1, tmz, &cur_size, &to);
 		if (r)
 			goto error;
 
@@ -355,8 +357,8 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 							     write_compress_disable));
 		}
 
-		r = amdgpu_copy_buffer(ring, from, to, cur_size, resv,
-				       &next, false, true, copy_flags);
+		r = amdgpu_copy_buffer(adev, entity, from, to, cur_size, resv,
+				       &next, true, copy_flags);
 		if (r)
 			goto error;
 
@@ -410,7 +412,7 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
 	    (abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE)) {
 		struct dma_fence *wipe_fence = NULL;
 
-		r = amdgpu_fill_buffer(abo, 0, NULL, &wipe_fence,
+		r = amdgpu_fill_buffer(&adev->mman.high_pr, abo, NULL, &wipe_fence,
 				       false, AMDGPU_KERNEL_JOB_ID_MOVE_BLIT);
 		if (r) {
 			goto error;
@@ -2276,19 +2278,16 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 }
 
 static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
-				  bool direct_submit,
+				  struct drm_sched_entity *entity,
 				  unsigned int num_dw,
 				  struct dma_resv *resv,
 				  bool vm_needs_flush,
 				  struct amdgpu_job **job,
-				  bool delayed, u64 k_job_id)
+				  u64 k_job_id)
 {
-	enum amdgpu_ib_pool_type pool = direct_submit ?
-		AMDGPU_IB_POOL_DIRECT :
-		AMDGPU_IB_POOL_DELAYED;
+	enum amdgpu_ib_pool_type pool = AMDGPU_IB_POOL_DELAYED;
 	int r;
-	struct drm_sched_entity *entity = delayed ? &adev->mman.low_pr :
-						    &adev->mman.high_pr;
+
 	r = amdgpu_job_alloc_with_ib(adev, entity,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     num_dw * 4, pool, job, k_job_id);
@@ -2308,20 +2307,22 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
 						   DMA_RESV_USAGE_BOOKKEEP);
 }
 
-int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
+int amdgpu_copy_buffer(struct amdgpu_device *adev,
+		       struct drm_sched_entity *entity,
+		       uint64_t src_offset,
 		       uint64_t dst_offset, uint32_t byte_count,
 		       struct dma_resv *resv,
-		       struct dma_fence **fence, bool direct_submit,
+		       struct dma_fence **fence,
 		       bool vm_needs_flush, uint32_t copy_flags)
 {
-	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
 	unsigned int num_loops, num_dw;
 	struct amdgpu_job *job;
 	uint32_t max_bytes;
 	unsigned int i;
 	int r;
 
-	if (!direct_submit && !ring->sched.ready) {
+	if (!ring->sched.ready) {
 		dev_err(adev->dev,
 			"Trying to move memory with ring turned off.\n");
 		return -EINVAL;
@@ -2330,8 +2331,8 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
 	max_bytes = adev->mman.buffer_funcs->copy_max_bytes;
 	num_loops = DIV_ROUND_UP(byte_count, max_bytes);
 	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->copy_num_dw, 8);
-	r = amdgpu_ttm_prepare_job(adev, direct_submit, num_dw,
-				   resv, vm_needs_flush, &job, false,
+	r = amdgpu_ttm_prepare_job(adev, entity, num_dw,
+				   resv, vm_needs_flush, &job,
 				   AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER);
 	if (r)
 		return r;
@@ -2348,29 +2349,20 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
 
 	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
 	WARN_ON(job->ibs[0].length_dw > num_dw);
-	if (direct_submit)
-		r = amdgpu_job_submit_direct(job, ring, fence);
-	else
-		*fence = amdgpu_job_submit(job);
-	if (r)
-		goto error_free;
-
-	return r;
-
-error_free:
-	amdgpu_job_free(job);
-	dev_err(adev->dev, "Error scheduling IBs (%d)\n", r);
-	return r;
+	*fence = amdgpu_job_submit(job);
+	return 0;
 }
 
-static int amdgpu_ttm_fill_mem(struct amdgpu_ring *ring, uint32_t src_data,
+static int amdgpu_ttm_fill_mem(struct amdgpu_device *adev,
+			       struct drm_sched_entity *entity,
+			       uint32_t src_data,
 			       uint64_t dst_addr, uint32_t byte_count,
 			       struct dma_resv *resv,
 			       struct dma_fence **fence,
-			       bool vm_needs_flush, bool delayed,
+			       bool vm_needs_flush,
 			       u64 k_job_id)
 {
-	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
 	unsigned int num_loops, num_dw;
 	struct amdgpu_job *job;
 	uint32_t max_bytes;
@@ -2380,8 +2372,8 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_ring *ring, uint32_t src_data,
 	max_bytes = adev->mman.buffer_funcs->fill_max_bytes;
 	num_loops = DIV_ROUND_UP_ULL(byte_count, max_bytes);
 	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->fill_num_dw, 8);
-	r = amdgpu_ttm_prepare_job(adev, false, num_dw, resv, vm_needs_flush,
-				   &job, delayed, k_job_id);
+	r = amdgpu_ttm_prepare_job(adev, entity, num_dw, resv,
+				   vm_needs_flush, &job, k_job_id);
 	if (r)
 		return r;
 
@@ -2402,90 +2394,39 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_ring *ring, uint32_t src_data,
 }
 
 /**
- * amdgpu_ttm_clear_buffer - clear memory buffers
- * @bo: amdgpu buffer object
- * @resv: reservation object
- * @fence: dma_fence associated with the operation
- *
- * Clear the memory buffer resource.
- *
- * Returns:
- * 0 for success or a negative error code on failure.
+ * amdgpu_fill_buffer - fill a buffer with 0
+ * @entity: scheduler entity to use
+ * @bo: the bo to fill
+ * @resv: fences contained in this reservation will be used as dependencies.
+ * @out_fence: the fence from the last clear will be stored here. It might be
+ *             NULL if no job was run.
+ * @consider_clear_status: skip regions already cleared, only valid immediately
+ *                         after allocation.
+ * @k_job_id: trace id
  */
-int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
-			    struct dma_resv *resv,
-			    struct dma_fence **fence)
-{
-	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
-	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
-	struct amdgpu_res_cursor cursor;
-	u64 addr;
-	int r = 0;
-
-	if (!adev->mman.buffer_funcs_enabled)
-		return -EINVAL;
-
-	if (!fence)
-		return -EINVAL;
-
-	*fence = dma_fence_get_stub();
-
-	amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &cursor);
-
-	mutex_lock(&adev->mman.gtt_window_lock);
-	while (cursor.remaining) {
-		struct dma_fence *next = NULL;
-		u64 size;
-
-		if (amdgpu_res_cleared(&cursor)) {
-			amdgpu_res_next(&cursor, cursor.size);
-			continue;
-		}
-
-		/* Never clear more than 256MiB at once to avoid timeouts */
-		size = min(cursor.size, 256ULL << 20);
-
-		r = amdgpu_ttm_map_buffer(&bo->tbo, bo->tbo.resource, &cursor,
-					  1, ring, false, &size, &addr);
-		if (r)
-			goto err;
-
-		r = amdgpu_ttm_fill_mem(ring, 0, addr, size, resv,
-					&next, true, true,
-					AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER);
-		if (r)
-			goto err;
-
-		dma_fence_put(*fence);
-		*fence = next;
-
-		amdgpu_res_next(&cursor, size);
-	}
-err:
-	mutex_unlock(&adev->mman.gtt_window_lock);
-
-	return r;
-}
-
-int amdgpu_fill_buffer(struct amdgpu_bo *bo,
-			uint32_t src_data,
-			struct dma_resv *resv,
-			struct dma_fence **f,
-			bool delayed,
-			u64 k_job_id)
+int amdgpu_fill_buffer(struct drm_sched_entity *entity,
+		       struct amdgpu_bo *bo,
+		       struct dma_resv *resv,
+		       struct dma_fence **out_fence,
+		       bool consider_clear_status,
+		       u64 k_job_id)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
-	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
 	struct dma_fence *fence = NULL;
 	struct amdgpu_res_cursor dst;
 	int r;
 
+	if (!entity)
+		return -EINVAL;
+
 	if (!adev->mman.buffer_funcs_enabled) {
 		dev_err(adev->dev,
 			"Trying to clear memory with ring turned off.\n");
 		return -EINVAL;
 	}
 
+	/* All regions may already be clear, with no job needed. */
+	r = 0;
 	amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &dst);
 
 	mutex_lock(&adev->mman.gtt_window_lock);
@@ -2493,16 +2434,22 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 		struct dma_fence *next;
 		uint64_t cur_size, to;
 
+		if (consider_clear_status && amdgpu_res_cleared(&dst)) {
+			amdgpu_res_next(&dst, dst.size);
+			continue;
+		}
+
 		/* Never fill more than 256MiB at once to avoid timeouts */
 		cur_size = min(dst.size, 256ULL << 20);
 
-		r = amdgpu_ttm_map_buffer(&bo->tbo, bo->tbo.resource, &dst,
-					  1, ring, false, &cur_size, &to);
+		r = amdgpu_ttm_map_buffer(entity, &bo->tbo, bo->tbo.resource, &dst,
+					  0, false, &cur_size, &to);
 		if (r)
 			goto error;
 
-		r = amdgpu_ttm_fill_mem(ring, src_data, to, cur_size, resv,
-					&next, true, delayed, k_job_id);
+		r = amdgpu_ttm_fill_mem(adev, entity,
+					0, to, cur_size, resv,
+					&next, true, k_job_id);
 		if (r)
 			goto error;
 
@@ -2513,9 +2460,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 	}
 error:
 	mutex_unlock(&adev->mman.gtt_window_lock);
-	if (f)
-		*f = dma_fence_get(fence);
-	dma_fence_put(fence);
+	*out_fence = fence;
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 0be2728aa8729..fc5133af30485 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -165,10 +165,12 @@ int amdgpu_ttm_init(struct amdgpu_device *adev);
 void amdgpu_ttm_fini(struct amdgpu_device *adev);
 void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev,
 					bool enable);
-int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
+int amdgpu_copy_buffer(struct amdgpu_device *adev,
+		       struct drm_sched_entity *entity,
+		       uint64_t src_offset,
 		       uint64_t dst_offset, uint32_t byte_count,
 		       struct dma_resv *resv,
-		       struct dma_fence **fence, bool direct_submit,
+		       struct dma_fence **fence,
 		       bool vm_needs_flush, uint32_t copy_flags);
 int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 			       const struct amdgpu_copy_mem *src,
@@ -176,15 +178,12 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 			       uint64_t size, bool tmz,
 			       struct dma_resv *resv,
 			       struct dma_fence **f);
-int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
-			    struct dma_resv *resv,
-			    struct dma_fence **fence);
-int amdgpu_fill_buffer(struct amdgpu_bo *bo,
-			uint32_t src_data,
-			struct dma_resv *resv,
-			struct dma_fence **fence,
-			bool delayed,
-			u64 k_job_id);
+int amdgpu_fill_buffer(struct drm_sched_entity *entity,
+		       struct amdgpu_bo *bo,
+		       struct dma_resv *resv,
+		       struct dma_fence **out_fence,
+		       bool consider_clear_status,
+		       u64 k_job_id);
 
 int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
 void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index c47c9bda51f64..87d51e80df20f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -153,8 +153,9 @@ svm_migrate_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
 			goto out_unlock;
 		}
 
-		r = amdgpu_copy_buffer(ring, gart_s, gart_d, size * PAGE_SIZE,
-				       NULL, &next, false, true, 0);
+		r = amdgpu_copy_buffer(adev, &adev->mman.high_pr,
+				       gart_s, gart_d, size * PAGE_SIZE,
+				       NULL, &next, true, 0);
 		if (r) {
 			dev_err(adev->dev, "fail %d to copy memory\n", r);
 			goto out_unlock;
-- 
2.53.0

