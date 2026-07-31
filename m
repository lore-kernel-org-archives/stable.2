Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360E3445AFF
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513009; cv=none; b=ZqQCm0cukPKXOpCr8vkN9cKXBIhaMALOtkegmR1zF11yzd+xEuVKkVtXx5FZdqMozMAAjQWdJoCRdxFkZPb14l5bJ/a98gT14yxhUb2ESp7pAj62nWOIIOsOYij4sQLU81EjqKqTuy176nNVI/1d5jI6CoY5NH9Mx48T9GsxjdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513009; c=relaxed/simple;
	bh=lO/wgLU3TwZ0yco1Leu1B1w9kOsztd8NBGfot4dO3qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8fAlMqe8Lal4o7QshnTxuVvwQjsBYbfAjpyYCHzuSkmPi2/8Vx3l9VHPicAgpzXuQn1XqXsdisn2QulHMO/lJimWPMnZzu7oSDcD5nGPLd7et3Cl5pbmeLFi/YUkDnZ0hvdRRemqOhIP0tJxrDrynOiyBGclUNhpdQ+Lz7igE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJVNVgT6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJVNVgT6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15781F00A3E;
	Fri, 31 Jul 2026 15:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785513002;
	bh=UgsiXR8lxpRfAkc5jBVyyUoVEZU3tLmbWL7U5kXZXGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nJVNVgT6HgsqtdSSHpGgKwSCz+YCL1CHBjCH1PMMeKTu+NeVWjM1I+HVDPxQR+LMS
	 l0eMh0WWVhrih1BPVw0cC0dd9A8W2Gw2IkQsz02oB2aNd5hXnT7iFLh2fgW+MuWbvM
	 xIfqIRGeB/sUKTIRSRwsSuH457kgCLfnWiZp0sw9WW9eAMWc613/huq/bo3mIR14lL
	 gnX49/IozK8L25xbmVsBzsl4YawK7KVGokw+F/ZHLvfbxAArcjap3EAS79DQ71ut27
	 KquRLPxkX6hiFCfFd/AxfhvWS8rZzs5icD0BmYBxBuAMnV+Mm/UZW2r6iGpKr69VBX
	 ZVULCvw+EeinQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] drm/amdgpu: give each kernel job a unique id
Date: Fri, 31 Jul 2026 11:49:58 -0400
Message-ID: <20260731154959.602805-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731154959.602805-1-sashal@kernel.org>
References: <2026072909-backlit-bannister-14b9@gregkh>
 <20260731154959.602805-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

[ Upstream commit 256576ed6895b81290690ae3e2b9f62eb7c642fc ]

Userspace jobs have drm_file.client_id as a unique identifier
as job's owners. For kernel jobs, we can allocate arbitrary
values - the risk of overlap with userspace ids is small (given
that it's a u64 value).
In the unlikely case the overlap happens, it'll only impact
trace events.

Since this ID is traced in the gpu_scheduler trace events, this
allows to determine the source of each job sent to the hardware.

To make grepping easier, the IDs are defined as they will appear
in the trace output.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Link: https://lore.kernel.org/r/20250604122827.2191-1-pierre-eric.pelloux-prayer@amd.com
Stable-dep-of: 3e864bf2a32a ("drm/amdgpu/gfx: fix cleaner shader IB buffer overflow")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c     |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  5 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     | 19 +++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c    |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 28 +++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c     |  5 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  8 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  6 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  |  4 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  4 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 12 +++++----
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       |  6 +++--
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c       |  6 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    |  3 ++-
 19 files changed, 84 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 3c2ac5f4e814..bd9ec01101b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1449,7 +1449,8 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	owner = (void *)(unsigned long)atomic_inc_return(&counter);
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
-				     64, 0, &job);
+				     64, 0, &job,
+				     AMDGPU_KERNEL_JOB_ID_CLEANER_SHADER);
 	if (r)
 		goto err;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index f63b5a429b10..9a0239da80e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -664,7 +664,7 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.high_pr,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
-				     &job);
+				     &job, AMDGPU_KERNEL_JOB_ID_FLUSH_GPU_TLB);
 	if (r)
 		goto error_alloc;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 4b3f00db75d9..99e9e96f5b7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -218,11 +218,12 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
 			     struct drm_sched_entity *entity, void *owner,
 			     size_t size, enum amdgpu_ib_pool_type pool_type,
-			     struct amdgpu_job **job)
+			     struct amdgpu_job **job, u64 k_job_id)
 {
 	int r;
 
-	r = amdgpu_job_alloc(adev, NULL, entity, owner, 1, job, 0);
+	r = amdgpu_job_alloc(adev, NULL, entity, owner, 1, job,
+			     k_job_id);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index f9de93cc3ba3..4fb05c737840 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -44,6 +44,22 @@
 struct amdgpu_fence;
 enum amdgpu_ib_pool_type;
 
+/* Internal kernel job ids. (decreasing values, starting from U64_MAX). */
+#define AMDGPU_KERNEL_JOB_ID_VM_UPDATE              (18446744073709551615ULL)
+#define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES         (18446744073709551614ULL)
+#define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE        (18446744073709551613ULL)
+#define AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR            (18446744073709551612ULL)
+#define AMDGPU_KERNEL_JOB_ID_TTM_MAP_BUFFER         (18446744073709551611ULL)
+#define AMDGPU_KERNEL_JOB_ID_TTM_ACCESS_MEMORY_SDMA (18446744073709551610ULL)
+#define AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER        (18446744073709551609ULL)
+#define AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE       (18446744073709551608ULL)
+#define AMDGPU_KERNEL_JOB_ID_MOVE_BLIT              (18446744073709551607ULL)
+#define AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER       (18446744073709551606ULL)
+#define AMDGPU_KERNEL_JOB_ID_CLEANER_SHADER         (18446744073709551605ULL)
+#define AMDGPU_KERNEL_JOB_ID_FLUSH_GPU_TLB          (18446744073709551604ULL)
+#define AMDGPU_KERNEL_JOB_ID_KFD_GART_MAP           (18446744073709551603ULL)
+#define AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST          (18446744073709551602ULL)
+
 struct amdgpu_job {
 	struct drm_sched_job    base;
 	struct amdgpu_vm	*vm;
@@ -95,7 +111,8 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
 			     struct drm_sched_entity *entity, void *owner,
 			     size_t size, enum amdgpu_ib_pool_type pool_type,
-			     struct amdgpu_job **job);
+			     struct amdgpu_job **job,
+			     u64 k_job_id);
 void amdgpu_job_set_resources(struct amdgpu_job *job, struct amdgpu_bo *gds,
 			      struct amdgpu_bo *gws, struct amdgpu_bo *oa);
 void amdgpu_job_free_resources(struct amdgpu_job *job);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index f96a79a4d539..4b0e34f9249a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -192,7 +192,8 @@ static int amdgpu_jpeg_dec_set_reg(struct amdgpu_ring *ring, uint32_t handle,
 	int i, r;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw * 4,
-				     AMDGPU_IB_POOL_DIRECT, &job);
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index fc588ef598c0..1576ea1704c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1266,7 +1266,8 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
 	if (r)
 		goto out;
 
-	r = amdgpu_fill_buffer(abo, 0, &bo->base._resv, &fence, true);
+	r = amdgpu_fill_buffer(abo, 0, &bo->base._resv, &fence, true,
+			       AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
 	if (WARN_ON(r))
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 40dd04a4f7df..2146035c1998 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -229,7 +229,8 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
 	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.high_pr,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     num_dw * 4 + num_bytes,
-				     AMDGPU_IB_POOL_DELAYED, &job);
+				     AMDGPU_IB_POOL_DELAYED, &job,
+				     AMDGPU_KERNEL_JOB_ID_TTM_MAP_BUFFER);
 	if (r)
 		return r;
 
@@ -408,7 +409,7 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
 		struct dma_fence *wipe_fence = NULL;
 
 		r = amdgpu_fill_buffer(abo, 0, NULL, &wipe_fence,
-				       false);
+				       false, AMDGPU_KERNEL_JOB_ID_MOVE_BLIT);
 		if (r) {
 			goto error;
 		} else if (wipe_fence) {
@@ -1512,7 +1513,8 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.high_pr,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     num_dw * 4, AMDGPU_IB_POOL_DELAYED,
-				     &job);
+				     &job,
+				     AMDGPU_KERNEL_JOB_ID_TTM_ACCESS_MEMORY_SDMA);
 	if (r)
 		goto out;
 
@@ -2149,7 +2151,7 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
 				  struct dma_resv *resv,
 				  bool vm_needs_flush,
 				  struct amdgpu_job **job,
-				  bool delayed)
+				  bool delayed, u64 k_job_id)
 {
 	enum amdgpu_ib_pool_type pool = direct_submit ?
 		AMDGPU_IB_POOL_DIRECT :
@@ -2159,7 +2161,7 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
 						    &adev->mman.high_pr;
 	r = amdgpu_job_alloc_with_ib(adev, entity,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
-				     num_dw * 4, pool, job);
+				     num_dw * 4, pool, job, k_job_id);
 	if (r)
 		return r;
 
@@ -2198,7 +2200,8 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
 	num_loops = DIV_ROUND_UP(byte_count, max_bytes);
 	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->copy_num_dw, 8);
 	r = amdgpu_ttm_prepare_job(adev, direct_submit, num_dw,
-				   resv, vm_needs_flush, &job, false);
+				   resv, vm_needs_flush, &job, false,
+				   AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER);
 	if (r)
 		return r;
 
@@ -2233,7 +2236,8 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_ring *ring, uint32_t src_data,
 			       uint64_t dst_addr, uint32_t byte_count,
 			       struct dma_resv *resv,
 			       struct dma_fence **fence,
-			       bool vm_needs_flush, bool delayed)
+			       bool vm_needs_flush, bool delayed,
+			       u64 k_job_id)
 {
 	struct amdgpu_device *adev = ring->adev;
 	unsigned int num_loops, num_dw;
@@ -2246,7 +2250,7 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_ring *ring, uint32_t src_data,
 	num_loops = DIV_ROUND_UP_ULL(byte_count, max_bytes);
 	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->fill_num_dw, 8);
 	r = amdgpu_ttm_prepare_job(adev, false, num_dw, resv, vm_needs_flush,
-				   &job, delayed);
+				   &job, delayed, k_job_id);
 	if (r)
 		return r;
 
@@ -2316,7 +2320,8 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
 			goto err;
 
 		r = amdgpu_ttm_fill_mem(ring, 0, addr, size, resv,
-					&next, true, true);
+					&next, true, true,
+					AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER);
 		if (r)
 			goto err;
 
@@ -2335,7 +2340,8 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 			uint32_t src_data,
 			struct dma_resv *resv,
 			struct dma_fence **f,
-			bool delayed)
+			bool delayed,
+			u64 k_job_id)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
@@ -2364,7 +2370,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 			goto error;
 
 		r = amdgpu_ttm_fill_mem(ring, src_data, to, cur_size, resv,
-					&next, true, delayed);
+					&next, true, delayed, k_job_id);
 		if (r)
 			goto error;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 3c883f1cf068..7c020e3fbfb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -180,7 +180,8 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 			uint32_t src_data,
 			struct dma_resv *resv,
 			struct dma_fence **fence,
-			bool delayed);
+			bool delayed,
+			u64 k_job_id);
 
 int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
 void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 65bb26215e86..7ead73c204f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1136,7 +1136,8 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->uvd.entity,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     64, direct ? AMDGPU_IB_POOL_DIRECT :
-				     AMDGPU_IB_POOL_DELAYED, &job);
+				     AMDGPU_IB_POOL_DELAYED, &job,
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index fa89c69b750a..37d390d9cc89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -449,7 +449,7 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 	r = amdgpu_job_alloc_with_ib(ring->adev, &ring->adev->vce.entity,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     ib_size_dw * 4, AMDGPU_IB_POOL_DIRECT,
-				     &job);
+				     &job, AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
 	if (r)
 		return r;
 
@@ -540,7 +540,8 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     ib_size_dw * 4,
 				     direct ? AMDGPU_IB_POOL_DIRECT :
-				     AMDGPU_IB_POOL_DELAYED, &job);
+				     AMDGPU_IB_POOL_DELAYED, &job,
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 43f44cc201cb..0e2fef666dd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -553,7 +553,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
 				     64, AMDGPU_IB_POOL_DIRECT,
-				     &job);
+				     &job, AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
 	if (r)
 		goto err;
 
@@ -733,7 +733,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
 				     ib_size_dw * 4, AMDGPU_IB_POOL_DIRECT,
-				     &job);
+				     &job, AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
 	if (r)
 		goto err;
 
@@ -863,7 +863,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
 				     ib_size_dw * 4, AMDGPU_IB_POOL_DIRECT,
-				     &job);
+				     &job, AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
 	if (r)
 		return r;
 
@@ -930,7 +930,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
 				     ib_size_dw * 4, AMDGPU_IB_POOL_DIRECT,
-				     &job);
+				     &job, AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a29d01202b5b..5aaad322af4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -838,7 +838,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	params.vm = vm;
 	params.immediate = immediate;
 
-	r = vm->update_funcs->prepare(&params, NULL);
+	r = vm->update_funcs->prepare(&params, NULL,
+				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES);
 	if (r)
 		goto error;
 
@@ -1007,7 +1008,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		dma_fence_put(tmp);
 	}
 
-	r = vm->update_funcs->prepare(&params, sync);
+	r = vm->update_funcs->prepare(&params, sync,
+				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE);
 	if (r)
 		goto error_free;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index a451f405afe3..095209a2cb33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -305,7 +305,7 @@ struct amdgpu_vm_update_params {
 struct amdgpu_vm_update_funcs {
 	int (*map_table)(struct amdgpu_bo_vm *bo);
 	int (*prepare)(struct amdgpu_vm_update_params *p,
-		       struct amdgpu_sync *sync);
+		       struct amdgpu_sync *sync, u64 k_job_id);
 	int (*update)(struct amdgpu_vm_update_params *p,
 		      struct amdgpu_bo_vm *bo, uint64_t pe, uint64_t addr,
 		      unsigned count, uint32_t incr, uint64_t flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index f80b611ce190..f078db3fef79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -42,12 +42,14 @@ static int amdgpu_vm_cpu_map_table(struct amdgpu_bo_vm *table)
  *
  * @p: see amdgpu_vm_update_params definition
  * @sync: sync obj with fences to wait on
+ * @k_job_id: the id for tracing/debug purposes
  *
  * Returns:
  * Negativ errno, 0 for success.
  */
 static int amdgpu_vm_cpu_prepare(struct amdgpu_vm_update_params *p,
-				 struct amdgpu_sync *sync)
+				 struct amdgpu_sync *sync,
+				 u64 k_job_id)
 {
 	if (!sync)
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 54ae0e9bc6d7..ba7bd65f5b7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -26,6 +26,7 @@
 #include "amdgpu.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_vm.h"
+#include "amdgpu_job.h"
 
 /*
  * amdgpu_vm_pt_cursor - state for for_each_amdgpu_vm_pt
@@ -395,7 +396,8 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.vm = vm;
 	params.immediate = immediate;
 
-	r = vm->update_funcs->prepare(&params, NULL);
+	r = vm->update_funcs->prepare(&params, NULL,
+				      AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR);
 	if (r)
 		goto exit;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 46d9fb433ab2..36805dcfa159 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -40,7 +40,7 @@ static int amdgpu_vm_sdma_map_table(struct amdgpu_bo_vm *table)
 
 /* Allocate a new job for @count PTE updates */
 static int amdgpu_vm_sdma_alloc_job(struct amdgpu_vm_update_params *p,
-				    unsigned int count)
+				    unsigned int count, u64 k_job_id)
 {
 	enum amdgpu_ib_pool_type pool = p->immediate ? AMDGPU_IB_POOL_IMMEDIATE
 		: AMDGPU_IB_POOL_DELAYED;
@@ -56,7 +56,7 @@ static int amdgpu_vm_sdma_alloc_job(struct amdgpu_vm_update_params *p,
 	ndw = min(ndw, AMDGPU_VM_SDMA_MAX_NUM_DW);
 
 	r = amdgpu_job_alloc_with_ib(p->adev, entity, AMDGPU_FENCE_OWNER_VM,
-				     ndw * 4, pool, &p->job);
+				     ndw * 4, pool, &p->job, k_job_id);
 	if (r)
 		return r;
 
@@ -69,16 +69,17 @@ static int amdgpu_vm_sdma_alloc_job(struct amdgpu_vm_update_params *p,
  *
  * @p: see amdgpu_vm_update_params definition
  * @sync: amdgpu_sync object with fences to wait for
+ * @k_job_id: identifier of the job, for tracing purpose
  *
  * Returns:
  * Negativ errno, 0 for success.
  */
 static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_update_params *p,
-				  struct amdgpu_sync *sync)
+				  struct amdgpu_sync *sync, u64 k_job_id)
 {
 	int r;
 
-	r = amdgpu_vm_sdma_alloc_job(p, 0);
+	r = amdgpu_vm_sdma_alloc_job(p, 0, k_job_id);
 	if (r)
 		return r;
 
@@ -249,7 +250,8 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 			if (r)
 				return r;
 
-			r = amdgpu_vm_sdma_alloc_job(p, count);
+			r = amdgpu_vm_sdma_alloc_job(p, count,
+						     AMDGPU_KERNEL_JOB_ID_VM_UPDATE);
 			if (r)
 				return r;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index e05e81d6fbd4..71a16073c43b 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -217,7 +217,8 @@ static int uvd_v6_0_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t handle
 	int i, r;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw * 4,
-				     AMDGPU_IB_POOL_DIRECT, &job);
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
 	if (r)
 		return r;
 
@@ -281,7 +282,8 @@ static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
 	int i, r;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw * 4,
-				     AMDGPU_IB_POOL_DIRECT, &job);
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index e3c20cbc7a00..bc0fca75417c 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -225,7 +225,8 @@ static int uvd_v7_0_enc_get_create_msg(struct amdgpu_ring *ring, u32 handle,
 	int i, r;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw * 4,
-				     AMDGPU_IB_POOL_DIRECT, &job);
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
 	if (r)
 		return r;
 
@@ -288,7 +289,8 @@ static int uvd_v7_0_enc_get_destroy_msg(struct amdgpu_ring *ring, u32 handle,
 	int i, r;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw * 4,
-				     AMDGPU_IB_POOL_DIRECT, &job);
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 52246f16cc24..ca6c48e3703c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -68,7 +68,8 @@ svm_migrate_gart_map(struct amdgpu_ring *ring, uint64_t npages,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     num_dw * 4 + num_bytes,
 				     AMDGPU_IB_POOL_DELAYED,
-				     &job);
+				     &job,
+				     AMDGPU_KERNEL_JOB_ID_KFD_GART_MAP);
 	if (r)
 		return r;
 
-- 
2.53.0

