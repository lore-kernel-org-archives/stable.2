Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793FE4FE2C3
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698432; cv=none; b=CsdkHdhyZnRTRu4v30Bod7MHdaGfe4gYkeeyFajn2Tq7He+A0Gitase423HFbYXJCiOh+m346TMVE0K1TRt+zsz2t4N9kjVvk1XqxdYDYlqahp1RqFVyp/bVClbXC3QG/ws4+NPiVn3JXDod4cIVRkUFW+t2mRTaNJ9vdTV7YeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698432; c=relaxed/simple;
	bh=/NtRPQaqETSERH/cMXTak1dtW8K2CsbdWKcem/YTl+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FUGuI2y912re011SMTUdDmK1eV9wgOszkkh2+jqeCyi1btZ+bV/LZNFmp7hIDbCsvZ66FlgkpcRzGSVNeo7XXaGwMyQcF4JLGr3OrcAG/athqd6RnMSpAF9NQKWHlRuuVi7iF1hv/PFIMjh0hh4gbtFx6RgDgtPBsvR2wH42LDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXEawM2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXEawM2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9988A1F00893;
	Tue, 29 Sep 2026 16:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790698431;
	bh=5LckvlNO00XW57FS4F69MTr5E/5Xhpo+9DoA4ssnz70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mXEawM2Hgcuqr4xIC9j3QJ5t5QJYf0bbhATrE1S0ocB795nPEHFpmdExHDGJPAsy+
	 yD3OoMi8JWgGE2Of0Lm+a+9TQNUD54KnEX8RNaDGj5UQ526TTtYGoEv4pM9L1ozxa2
	 JXmSrzBrhcWpBIQoAwX+gLWnQZktWV1VP9FDa4s3S6sTlnbM3YrtetS2Bw5qLlK9Y4
	 SpMWZIfXUpP5EtI7mh5BS0pcJ9r3x1eDU7TnnYnLEhPhVo8XJ3utJdsyu/CmLSW0aL
	 nS1dLdqVe0XWCde1DkMbM9JtRlqJOEk+SH4jsr1l8a4I323+0ziE+vVNxpepbNB8Zz
	 34xBGyCLV6ZUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: xinhui pan <xinhui.pan@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] drm/amdgpu: Fix one use-after-free of VM
Date: Tue, 29 Sep 2026 12:13:46 -0400
Message-ID: <20260929161347.4118377-3-sashal@kernel.org>
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

From: xinhui pan <xinhui.pan@amd.com>

[ Upstream commit 7c703a7d3f2b50a6187267420a4d3d7e62fa3206 ]

VM might already be freed when amdgpu_vm_tlb_seq_cb() is called.
We see the calltrace below.

Fix it by keeping the last flush fence around and wait for it to signal

BUG kmalloc-4k (Not tainted): Poison overwritten

0xffff9c88630414e8-0xffff9c88630414e8 @offset=5352. First byte 0x6c
instead of 0x6b Allocated in amdgpu_driver_open_kms+0x9d/0x360 [amdgpu]
age=44 cpu=0 pid=2343
 __slab_alloc.isra.0+0x4f/0x90
 kmem_cache_alloc_trace+0x6b8/0x7a0
 amdgpu_driver_open_kms+0x9d/0x360 [amdgpu]
 drm_file_alloc+0x222/0x3e0 [drm]
 drm_open+0x11d/0x410 [drm]
Freed in amdgpu_driver_postclose_kms+0x3e9/0x550 [amdgpu] age=22 cpu=1
pid=2485
 kfree+0x4a2/0x580
 amdgpu_driver_postclose_kms+0x3e9/0x550 [amdgpu]
 drm_file_free+0x24e/0x3c0 [drm]
 drm_close_helper.isra.0+0x90/0xb0 [drm]
 drm_release+0x97/0x1a0 [drm]
 __fput+0xb6/0x280
 ____fput+0xe/0x10
 task_work_run+0x64/0xb0

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: xinhui pan <xinhui.pan@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: b4f7b4459b1b ("drm/amdgpu: Fix last_update fence leak in amdgpu_vm_init()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 18 +++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  1 +
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ae6001045d953..65808307e824a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1843,10 +1843,14 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 
 	if (!unlocked && (!(flags & AMDGPU_PTE_VALID) || params.table_freed)) {
 		tlb_cb->vm = vm;
-		if (!fence || !*fence ||
-		    dma_fence_add_callback(*fence, &tlb_cb->cb,
-					   amdgpu_vm_tlb_seq_cb))
+		if (fence && *fence &&
+		    !dma_fence_add_callback(*fence, &tlb_cb->cb,
+					   amdgpu_vm_tlb_seq_cb)) {
+			dma_fence_put(vm->last_tlb_flush);
+			vm->last_tlb_flush = dma_fence_get(*fence);
+		} else {
 			amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
+		}
 		tlb_cb = NULL;
 	}
 
@@ -3046,6 +3050,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		vm->update_funcs = &amdgpu_vm_sdma_funcs;
 	vm->last_update = NULL;
 	vm->last_unlocked = dma_fence_get_stub();
+	vm->last_tlb_flush = dma_fence_get_stub();
 
 	mutex_init(&vm->eviction_lock);
 	vm->evicting = false;
@@ -3084,6 +3089,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	vm->root.bo = NULL;
 
 error_free_delayed:
+	dma_fence_put(vm->last_tlb_flush);
 	dma_fence_put(vm->last_unlocked);
 	drm_sched_entity_destroy(&vm->delayed);
 
@@ -3228,6 +3234,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	struct amdgpu_bo_va_mapping *mapping, *tmp;
 	bool prt_fini_needed = !!adev->gmc.gmc_funcs->set_prt;
 	struct amdgpu_bo *root;
+	unsigned long flags;
 	int i;
 
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
@@ -3237,6 +3244,11 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	amdgpu_vm_set_pasid(adev, vm, 0);
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
+	dma_fence_wait(vm->last_tlb_flush, false);
+	/* Make sure that all fence callbacks have completed */
+	spin_lock_irqsave(vm->last_tlb_flush->lock, flags);
+	spin_unlock_irqrestore(vm->last_tlb_flush->lock, flags);
+	dma_fence_put(vm->last_tlb_flush);
 
 	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
 		if (mapping->flags & AMDGPU_PTE_PRT && prt_fini_needed) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 93afd2aa29497..14fbf1d056b26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -286,6 +286,7 @@ struct amdgpu_vm {
 
 	/* Last finished delayed update */
 	atomic64_t		tlb_seq;
+	struct dma_fence	*last_tlb_flush;
 
 	/* Last unlocked submission to the scheduler entities */
 	struct dma_fence	*last_unlocked;
-- 
2.53.0

