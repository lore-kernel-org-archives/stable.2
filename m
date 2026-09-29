Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71714F3901
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698432; cv=none; b=kxxwR1CQRi4teDnSIPSPkBpspJ7F2WyiljvFUqmxTJni8diz83xEvi3Gy31usMusoUF3cPRyhImMNUG0EkeY7FDJ0vQLdwY8M3s0ZigBoTcwJtZkZDBuBIKyXUIK4kZi79h7p1HV9PcsM4cOf5jtsb2pIWPCkytUobmRosyJa3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698432; c=relaxed/simple;
	bh=BIg0PbF6fQrXVgNrHN/RGVOVTUprB2bP44xSEMKT9V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CjVyMT6rLO2x3ojEt03TZJoqmPjDtWIo9jRGw5clTTGvEmdjODVTiX+vl+bd+uvNpCvc0HnGx7oGCwE9NLR78rP4svAvJv6tdaXcmM6yLg03ZPXgC8gfSaQbkY+r6Io9TSYSQxN8PhqykEZg6lajwh6pNgQNCEegRyjPoSZKg2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVPFyVvy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVPFyVvy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FBC1F00898;
	Tue, 29 Sep 2026 16:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790698430;
	bh=aWVdc+RfTc2uTXL9zK4DsdZ95jcrkn/s4J1avzLlp9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GVPFyVvyTvaUbwbGt4DiMRklhIMEKcS7WiAjPiFmGQ5nOXmg2LV0/zRPkXI7w+Vux
	 mp0c33LzhLjeTbtgtL/0AcqiK6LBUZSQPSi4IcHeU9PRnlMjfO8mvsgP48J09B5i2J
	 ewpf3BU5p9iGU+OwKysFfNRy+cTJmeSmt2s6Zp12ql1WcAxt9jbznOPQN+3J2Wlvl/
	 zHwEXn3TJfTxnKk5FcTbIfgpE2AIPn2bdYFcvO/LnWXevxlHJifbcEq6pEpaVXOcKA
	 +XjxYKRe+niBye2i8YMxqAVQa4kNO8uam+LlE5uLrGySo5GTW/u3c5ZX7c3ZPqZZhf
	 RU93KrSbUWdMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] drm/amdgpu: rework TLB flushing
Date: Tue, 29 Sep 2026 12:13:45 -0400
Message-ID: <20260929161347.4118377-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929161347.4118377-1-sashal@kernel.org>
References: <2026092916-yearling-rise-4267@gregkh>
 <20260929161347.4118377-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian König <christian.koenig@amd.com>

[ Upstream commit 5255e146c99a677d4d55fdb988544bd20c539a0b ]

Instead of tracking the VM updates through the dependencies just use a
sequence counter for page table updates which indicates the need to
flush the TLB.

This reduces the need to flush the TLB drastically.

v2: squash in NULL check fix (Christian)

Signed-off-by: Christian König <christian.koenig@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: b4f7b4459b1b ("drm/amdgpu: Fix last_update fence leak in amdgpu_vm_init()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  8 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c  |  6 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 20 ---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   | 57 ++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   | 15 +++++++
 6 files changed, 76 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 98c842cf03e4a..e2723e2be3133 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -793,7 +793,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	r = amdgpu_sync_vm_fence(&p->job->sync, fpriv->prt_va->last_pt_update);
+	r = amdgpu_sync_fence(&p->job->sync, fpriv->prt_va->last_pt_update);
 	if (r)
 		return r;
 
@@ -804,7 +804,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		if (r)
 			return r;
 
-		r = amdgpu_sync_vm_fence(&p->job->sync, bo_va->last_pt_update);
+		r = amdgpu_sync_fence(&p->job->sync, bo_va->last_pt_update);
 		if (r)
 			return r;
 	}
@@ -823,7 +823,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		if (r)
 			return r;
 
-		r = amdgpu_sync_vm_fence(&p->job->sync, bo_va->last_pt_update);
+		r = amdgpu_sync_fence(&p->job->sync, bo_va->last_pt_update);
 		if (r)
 			return r;
 	}
@@ -836,7 +836,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	r = amdgpu_sync_vm_fence(&p->job->sync, vm->last_update);
+	r = amdgpu_sync_fence(&p->job->sync, vm->last_update);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 3d3d07f74d6b1..240304670ba45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -277,7 +277,7 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 	unsigned vmhub = ring->funcs->vmhub;
 	uint64_t fence_context = adev->fence_context + ring->idx;
 	bool needs_flush = vm->use_cpu_for_update;
-	uint64_t updates = sync->last_vm_update;
+	uint64_t updates = amdgpu_vm_tlb_seq(vm);
 	int r;
 
 	*id = vm->reserved_vmid[vmhub];
@@ -338,7 +338,7 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
 	unsigned vmhub = ring->funcs->vmhub;
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	uint64_t fence_context = adev->fence_context + ring->idx;
-	uint64_t updates = sync->last_vm_update;
+	uint64_t updates = amdgpu_vm_tlb_seq(vm);
 	int r;
 
 	job->vm_needs_flush = vm->use_cpu_for_update;
@@ -426,7 +426,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 			if (r)
 				goto error;
 
-			id->flushed_updates = sync->last_vm_update;
+			id->flushed_updates = amdgpu_vm_tlb_seq(vm);
 			job->vm_needs_flush = true;
 		}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index 98e928f638837..7e95be03f2594 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -51,7 +51,6 @@ static struct kmem_cache *amdgpu_sync_slab;
 void amdgpu_sync_create(struct amdgpu_sync *sync)
 {
 	hash_init(sync->fences);
-	sync->last_vm_update = 0;
 }
 
 /**
@@ -171,23 +170,6 @@ int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f)
 	return 0;
 }
 
-/**
- * amdgpu_sync_vm_fence - remember to sync to this VM fence
- *
- * @sync: sync object to add fence to
- * @fence: the VM fence to add
- *
- * Add the fence to the sync object and remember it as VM update.
- */
-int amdgpu_sync_vm_fence(struct amdgpu_sync *sync, struct dma_fence *fence)
-{
-	if (!fence)
-		return 0;
-
-	sync->last_vm_update = max(sync->last_vm_update, fence->seqno);
-	return amdgpu_sync_fence(sync, fence);
-}
-
 /* Determine based on the owner and mode if we should sync to a fence or not */
 static bool amdgpu_sync_test_fence(struct amdgpu_device *adev,
 				   enum amdgpu_sync_mode mode,
@@ -394,8 +376,6 @@ int amdgpu_sync_clone(struct amdgpu_sync *source, struct amdgpu_sync *clone)
 		}
 	}
 
-	clone->last_vm_update = source->last_vm_update;
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
index 876c1ee8869c1..2d5c613cda102 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
@@ -43,12 +43,10 @@ enum amdgpu_sync_mode {
  */
 struct amdgpu_sync {
 	DECLARE_HASHTABLE(fences, 4);
-	uint64_t	last_vm_update;
 };
 
 void amdgpu_sync_create(struct amdgpu_sync *sync);
 int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f);
-int amdgpu_sync_vm_fence(struct amdgpu_sync *sync, struct dma_fence *fence);
 int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
 		     struct dma_resv *resv, enum amdgpu_sync_mode mode,
 		     void *owner);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 572d5c64ad093..ae6001045d953 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -88,6 +88,21 @@ struct amdgpu_prt_cb {
 	struct dma_fence_cb cb;
 };
 
+/**
+ * amdgpu_vm_tlb_seq_cb - Helper to increment the TLB flush sequence
+ */
+struct amdgpu_vm_tlb_seq_cb {
+	/**
+	 * @vm: pointer to the amdgpu_vm structure to set the fence sequence on
+	 */
+	struct amdgpu_vm *vm;
+
+	/**
+	 * @cb: callback
+	 */
+	struct dma_fence_cb cb;
+};
+
 /**
  * amdgpu_vm_set_pasid - manage pasid and vm ptr mapping
  *
@@ -1672,6 +1687,23 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
 	return 0;
 }
 
+/**
+ * amdgpu_vm_tlb_seq_cb - make sure to increment tlb sequence
+ * @fence: unused
+ * @cb: the callback structure
+ *
+ * Increments the tlb sequence to make sure that future CS execute a VM flush.
+ */
+static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
+				 struct dma_fence_cb *cb)
+{
+	struct amdgpu_vm_tlb_seq_cb *tlb_cb;
+
+	tlb_cb = container_of(cb, typeof(*tlb_cb), cb);
+	atomic64_inc(&tlb_cb->vm->tlb_seq);
+	kfree(tlb_cb);
+}
+
 /**
  * amdgpu_vm_bo_update_mapping - update a mapping in the vm page table
  *
@@ -1707,6 +1739,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 				bool *table_freed)
 {
 	struct amdgpu_vm_update_params params;
+	struct amdgpu_vm_tlb_seq_cb *tlb_cb;
 	struct amdgpu_res_cursor cursor;
 	enum amdgpu_sync_mode sync_mode;
 	int r, idx;
@@ -1714,6 +1747,12 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 	if (!drm_dev_enter(&adev->ddev, &idx))
 		return -ENODEV;
 
+	tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
+	if (!tlb_cb) {
+		r = -ENOMEM;
+		goto error_unlock;
+	}
+
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
@@ -1732,7 +1771,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 	amdgpu_vm_eviction_lock(vm);
 	if (vm->evicting) {
 		r = -EBUSY;
-		goto error_unlock;
+		goto error_free;
 	}
 
 	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
@@ -1745,7 +1784,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 
 	r = vm->update_funcs->prepare(&params, resv, sync_mode);
 	if (r)
-		goto error_unlock;
+		goto error_free;
 
 	amdgpu_res_first(pages_addr ? NULL : res, offset,
 			 (last - start + 1) * AMDGPU_GPU_PAGE_SIZE, &cursor);
@@ -1794,7 +1833,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 		tmp = start + num_entries;
 		r = amdgpu_vm_update_ptes(&params, start, tmp, addr, flags);
 		if (r)
-			goto error_unlock;
+			goto error_free;
 
 		amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
 		start = tmp;
@@ -1802,9 +1841,21 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 
 	r = vm->update_funcs->commit(&params, fence);
 
+	if (!unlocked && (!(flags & AMDGPU_PTE_VALID) || params.table_freed)) {
+		tlb_cb->vm = vm;
+		if (!fence || !*fence ||
+		    dma_fence_add_callback(*fence, &tlb_cb->cb,
+					   amdgpu_vm_tlb_seq_cb))
+			amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
+		tlb_cb = NULL;
+	}
+
 	if (table_freed)
 		*table_freed = *table_freed || params.table_freed;
 
+error_free:
+	kfree(tlb_cb);
+
 error_unlock:
 	amdgpu_vm_eviction_unlock(vm);
 	drm_dev_exit(idx);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 85fcfb8c5efd1..93afd2aa29497 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -284,6 +284,9 @@ struct amdgpu_vm {
 	struct drm_sched_entity	immediate;
 	struct drm_sched_entity	delayed;
 
+	/* Last finished delayed update */
+	atomic64_t		tlb_seq;
+
 	/* Last unlocked submission to the scheduler entities */
 	struct dma_fence	*last_unlocked;
 
@@ -462,4 +465,16 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
 void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
 #endif
 
+/**
+ * amdgpu_vm_tlb_seq - return tlb flush sequence number
+ * @vm: the amdgpu_vm structure to query
+ *
+ * Returns the tlb flush sequence number which indicates that the VM TLBs needs
+ * to be invalidated whenever the sequence number change.
+ */
+static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
+{
+	return atomic64_read(&vm->tlb_seq);
+}
+
 #endif
-- 
2.53.0

