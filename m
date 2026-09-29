Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B042D592D
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790702802; cv=none; b=Tx15hUyBZRJXSJebXxcKQ83zPuSgkWfhXrI3bLZlYGhuE3HIJca+QtgPEwlYx7sFlWlO4U6VDNduWYQibTxBegNjvQM7M/IrwCq8okjuAykLFyzfrny7Pg8Q7MX9W6Tp9TgXBngK4akpUy8y/swMa3SacgJUzTmuJ6RRdlfFpLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790702802; c=relaxed/simple;
	bh=OkhYHVae2IA/s0BNLGEtkQFH/6VDDZScVMqu2Ft01lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hKJJnE6O8n1BJaMY9WJxVZcrWisR4nNSChBEigB8LK2qekAoDfZaaWbCEftgqNyXCOSQsjiNX+7VCLZTqLN36EW7SSI31o3ie79L2hmYnNQFPTAYqmhzZ7Mdg7m7HOJ2wwIKIcDxBWPqss4a8UqC4uheiOiXTfvrNwWPezumcrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIM53fnF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIM53fnF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B301F1F000FF;
	Tue, 29 Sep 2026 17:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790702801;
	bh=j4AN3NybDJyVixQzaCLzkKF8Y4H70egJBEX54/4pbu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dIM53fnF1p7HaDoP/yBJa59BA8+cjqO+ZYRd8Pdc8VydODPrTn3Cnp3pAaHN/8FKD
	 46wUW8RLzevUMxoszNxrhx+wjsC38/+i7wmviLQn/d2ufC0u7Pr6RumlTd0R+0MprS
	 EVvExSFQ7BEdXU6uFWvlSisiT1VZiVicw4vWhc+h11g9eEMrhJJIFrC119kXR2nomH
	 /OI+cCuWFCyMzaN2nHNxk7jKQ/OD5Va5ICpz+ZSOJ/0wWxOWBdx0xG1N/3vJgCcQTz
	 qVWScf9yn1uCOAQrOigw3+UBe1y/QplPNwTaQk1J1HTueZNGPIBfCwPrU8NEPV7ZHh
	 8W0TFndSKv+mQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] drm/amdgpu: simplify VM update tracking a bit
Date: Tue, 29 Sep 2026 13:26:38 -0400
Message-ID: <20260929172639.247672-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092916-hurry-appendix-2bde@gregkh>
References: <2026092916-hurry-appendix-2bde@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian König <christian.koenig@amd.com>

[ Upstream commit e997b82745a5b2419bc5b72735811d7162ac994a ]

Store the 64bit sequence directly. Makes it simpler to use and saves a bit
of fence reference counting overhead.

Signed-off-by: Christian König <christian.koenig@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: b4f7b4459b1b ("drm/amdgpu: Fix last_update fence leak in amdgpu_vm_init()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c  | 40 +++++++-----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c |  9 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h |  2 +-
 4 files changed, 16 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 90e16d14e6c38..5d955069f5775 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -276,19 +276,15 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 	struct amdgpu_device *adev = ring->adev;
 	unsigned vmhub = ring->funcs->vmhub;
 	uint64_t fence_context = adev->fence_context + ring->idx;
-	struct dma_fence *updates = sync->last_vm_update;
 	bool needs_flush = vm->use_cpu_for_update;
-	int r = 0;
+	uint64_t updates = sync->last_vm_update;
+	int r;
 
 	*id = vm->reserved_vmid[vmhub];
-	if (updates && (*id)->flushed_updates &&
-	    updates->context == (*id)->flushed_updates->context &&
-	    !dma_fence_is_later(updates, (*id)->flushed_updates))
-		updates = NULL;
-
 	if ((*id)->owner != vm->immediate.fence_context ||
-	    job->vm_pd_addr != (*id)->pd_gpu_addr ||
-	    updates || !(*id)->last_flush ||
+	    (*id)->pd_gpu_addr != job->vm_pd_addr ||
+	    (*id)->flushed_updates < updates ||
+	    !(*id)->last_flush ||
 	    ((*id)->last_flush->context != fence_context &&
 	     !dma_fence_is_signaled((*id)->last_flush))) {
 		struct dma_fence *tmp;
@@ -302,8 +298,7 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 		tmp = amdgpu_sync_peek_fence(&(*id)->active, ring);
 		if (tmp) {
 			*id = NULL;
-			r = amdgpu_sync_fence(sync, tmp);
-			return r;
+			return amdgpu_sync_fence(sync, tmp);
 		}
 		needs_flush = true;
 	}
@@ -315,10 +310,7 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 	if (r)
 		return r;
 
-	if (updates) {
-		dma_fence_put((*id)->flushed_updates);
-		(*id)->flushed_updates = dma_fence_get(updates);
-	}
+	(*id)->flushed_updates = updates;
 	job->vm_needs_flush = needs_flush;
 	return 0;
 }
@@ -346,7 +338,7 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
 	unsigned vmhub = ring->funcs->vmhub;
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	uint64_t fence_context = adev->fence_context + ring->idx;
-	struct dma_fence *updates = sync->last_vm_update;
+	uint64_t updates = sync->last_vm_update;
 	int r;
 
 	job->vm_needs_flush = vm->use_cpu_for_update;
@@ -354,7 +346,6 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
 	/* Check if we can use a VMID already assigned to this VM */
 	list_for_each_entry_reverse((*id), &id_mgr->ids_lru, list) {
 		bool needs_flush = vm->use_cpu_for_update;
-		struct dma_fence *flushed;
 
 		/* Check all the prerequisites to using this VMID */
 		if ((*id)->owner != vm->immediate.fence_context)
@@ -368,8 +359,7 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
 		     !dma_fence_is_signaled((*id)->last_flush)))
 			needs_flush = true;
 
-		flushed  = (*id)->flushed_updates;
-		if (updates && (!flushed || dma_fence_is_later(updates, flushed)))
+		if ((*id)->flushed_updates < updates)
 			needs_flush = true;
 
 		if (needs_flush && !adev->vm_manager.concurrent_flush)
@@ -382,11 +372,7 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
 		if (r)
 			return r;
 
-		if (updates && (!flushed || dma_fence_is_later(updates, flushed))) {
-			dma_fence_put((*id)->flushed_updates);
-			(*id)->flushed_updates = dma_fence_get(updates);
-		}
-
+		(*id)->flushed_updates = updates;
 		job->vm_needs_flush |= needs_flush;
 		return 0;
 	}
@@ -432,8 +418,6 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 			goto error;
 
 		if (!id) {
-			struct dma_fence *updates = sync->last_vm_update;
-
 			/* Still no ID to use? Then use the idle one found earlier */
 			id = idle;
 
@@ -442,8 +426,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 			if (r)
 				goto error;
 
-			dma_fence_put(id->flushed_updates);
-			id->flushed_updates = dma_fence_get(updates);
+			id->flushed_updates = sync->last_vm_update;
 			job->vm_needs_flush = true;
 		}
 
@@ -609,7 +592,6 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
 			struct amdgpu_vmid *id = &id_mgr->ids[j];
 
 			amdgpu_sync_free(&id->active);
-			dma_fence_put(id->flushed_updates);
 			dma_fence_put(id->last_flush);
 			dma_fence_put(id->pasid_mapping);
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index 0c3b4fa1f9360..06c8a0034fa52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -47,7 +47,7 @@ struct amdgpu_vmid {
 
 	uint64_t		pd_gpu_addr;
 	/* last flushed PD/PT update */
-	struct dma_fence	*flushed_updates;
+	uint64_t		flushed_updates;
 
 	uint32_t                current_gpu_reset_count;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index 6a22bc41c2056..c246d1662fc72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -49,7 +49,7 @@ static struct kmem_cache *amdgpu_sync_slab;
 void amdgpu_sync_create(struct amdgpu_sync *sync)
 {
 	hash_init(sync->fences);
-	sync->last_vm_update = NULL;
+	sync->last_vm_update = 0;
 }
 
 /**
@@ -183,7 +183,7 @@ int amdgpu_sync_vm_fence(struct amdgpu_sync *sync, struct dma_fence *fence)
 	if (!fence)
 		return 0;
 
-	amdgpu_sync_keep_later(&sync->last_vm_update, fence);
+	sync->last_vm_update = max(sync->last_vm_update, fence->seqno);
 	return amdgpu_sync_fence(sync, fence);
 }
 
@@ -376,8 +376,7 @@ int amdgpu_sync_clone(struct amdgpu_sync *source, struct amdgpu_sync *clone)
 		}
 	}
 
-	dma_fence_put(clone->last_vm_update);
-	clone->last_vm_update = dma_fence_get(source->last_vm_update);
+	clone->last_vm_update = source->last_vm_update;
 
 	return 0;
 }
@@ -419,8 +418,6 @@ void amdgpu_sync_free(struct amdgpu_sync *sync)
 		dma_fence_put(e->fence);
 		kmem_cache_free(amdgpu_sync_slab, e);
 	}
-
-	dma_fence_put(sync->last_vm_update);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
index 7c0fe20c470d4..876c1ee8869c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
@@ -43,7 +43,7 @@ enum amdgpu_sync_mode {
  */
 struct amdgpu_sync {
 	DECLARE_HASHTABLE(fences, 4);
-	struct dma_fence	*last_vm_update;
+	uint64_t	last_vm_update;
 };
 
 void amdgpu_sync_create(struct amdgpu_sync *sync);
-- 
2.53.0

