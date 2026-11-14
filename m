Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794679740;
	b=Vizvx2qZo7aAEOof4a215uqpsKEuc7bGLS90tu8fFnbTYJrd/1TNSXtwvR/++QqO6IZD
	 GcXiv8pBLGSzPXqOmGBic+H3OJlrDcI5mJHuaR6oyBMZW8/xBX8c1ZjNjEh20cv9BQslE
	 CuGRw+pX1gH/StGFOqdCFXWN+0JKXjwgKzDXXvaOnyECgRLp2IvhLNfIB4MnyJ56c90s5
	 aRLtD+Xr8mN/FzKgdCupXO0FyC2bPQbOK359fPdYmalD8Z8xoVzYnc4E05U0SS0/zAZtU
	 0jZtUXqRAdw3Ekq/auIu+j3mCfbdYAOXHmrMx4hS4JW4WmvfZmJjxaxtArhh5tBBPvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794679740;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mDVfGMNKuKmMgPDUO0i3tvTJlQmoOmD1MigQIiDSGH0=;
	b=tr8gabXT7w62j5h7he38mgQyCZmGn2gSr4+l6xOdWR2xPw7KKJxX6XsJ/kI79rD4aRbL
	 AM3Vfu3EQtdH3GRQ1IwGHa2dYoSxrgBBKMkxbd05pVzj/mrgp/XNOtFZQ8JYETGguiES9
	 CVBTLg0GAifoI5zMyLCgWLKSN0iZVQSlaH9Dct9VFuZvrEuXW4ekOYEIhWaBJJqKvK30C
	 SBMwSs18Y+koYFuMPUOR2IT5SO8q3v94ads/oVjNJbLcyk0NdCx1eEK7OHPMW6mxQy7aQ
	 lJ54oMQ3vwA/SlgMCHaky0Ypz6YV3QTTbh7ZDCsPob1Duu/ZHMdjvHsoww3xxVO1kAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOg1rcOH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA51606A327
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOg1rcOH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14241F000C4;
	Sat, 14 Nov 2026 18:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794679740;
	bh=mDVfGMNKuKmMgPDUO0i3tvTJlQmoOmD1MigQIiDSGH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VOg1rcOHyW5zeZOtEIUGCXSTr8DcRBu/qydONyAEDKkJVy1hsMzK+VBrGU0JWVFz0
	 JEMjHHmGdnnuiONsHsmbBK7XAlPpDHjsw1GzlG7/2JPeEVNggUvfV4KC1pzvlW+t+Y
	 3CAB0QkGFXbNUupCRI3JCoOFZlrugI9BMCJS6IY5jwfpqwGUNjZCu5YfRi7usrEWp1
	 tyohK8eFSTW5MdmoxMoIaiZ4ZX92IAwHxNZ0D0khesLsWPCGrleN+7bt9HKwc8akni
	 FFAI8205nWw9eQH1wB+LBeVniHZ4NbIl84uFaFLNZ8R3oRGipE5A2K7ibXvD0+lTJY
	 3rUwzTtGBFmxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/amdkfd: use the queue's process info for the WPTR BO eviction fence
Date: Sat, 14 Nov 2026 13:08:58 -0500
Message-ID: <20261114180840.359293-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201925-failed-6.1-da2897ee8b81@kernel.org>
References: <20261109201925-failed-6.1-da2897ee8b81@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jesse Zhang <Jesse.Zhang@amd.com>

[ Upstream commit da2897ee8b811945fd40ecc4aaf03291c14ce61c ]

amdgpu_amdkfd_map_gtt_bo_to_gart() removes the eviction fence of
bo->vm_bo->vm->process_info from the WPTR BO of a new queue. bo->vm_bo
is the VM which opened the BO last, not necessarily the KFD process' VM,
and a render node VM has no process info.

On navi31, an unprivileged process which exports its WPTR BO with
AMDKFD_IOC_EXPORT_DMABUF and imports it on a second render node fd
oopses in AMDKFD_IOC_CREATE_QUEUE:

  BUG: kernel NULL pointer dereference, address: 0000000000000060
  RIP: 0010:amdgpu_amdkfd_map_gtt_bo_to_gart+0x86/0x1a0 [amdgpu]
   init_user_queue.part.0+0x180/0x250 [amdgpu]
   pqm_create_queue+0x32d/0x730 [amdgpu]
   kfd_ioctl_create_queue+0x583/0x9f0 [amdgpu]

Pass the process info of the queue instead. With the fix, the queue is
created and destroyed normally.

Fixes: 7f347e3f8217 ("drm/amdkfd: Fix NULL pointer error for GC 11.0.1 on mGPU")
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 6b4157498a176bd1c6083f6bb5aaf8a257a2027e)
Cc: stable@vger.kernel.org
[ sashal: adapted the process_info argument to the existing adev-based mapping API in kfd_ioctl_create_queue() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 +++++---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 3 ++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index ba065f7887aad..ed0f5e76324e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -294,7 +294,8 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
 					     void **kptr, uint64_t *size);
 void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
 
-int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo);
+int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo,
+				     struct amdkfd_process_info *process_info);
 
 int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
 					    struct dma_fence **ef);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index eb4d652afbb60..49b9e0033be9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2163,11 +2163,13 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
  * amdgpu_amdkfd_map_gtt_bo_to_gart - Map BO to GART and increment reference count
  * @adev: Device to which allocated BO belongs
  * @bo: Buffer object to be mapped
+ * @process_info: KFD process info of the queue the BO is for
  *
  * Before return, bo reference count is incremented. To release the reference and unpin/
  * unmap the BO, call amdgpu_amdkfd_free_gtt_mem.
  */
-int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo)
+int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo,
+				     struct amdkfd_process_info *process_info)
 {
 	int ret;
 
@@ -2189,8 +2191,8 @@ int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_b
 		goto err_map_bo_gart_failed;
 	}
 
-	amdgpu_amdkfd_remove_eviction_fence(
-		bo, bo->vm_bo->vm->process_info->eviction_fence);
+	/* bo->vm_bo can be the VM of any file which opened the BO */
+	amdgpu_amdkfd_remove_eviction_fence(bo, process_info->eviction_fence);
 
 	amdgpu_bo_unreserve(bo);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index a08c84556ace4..4212d8c77de3b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -368,7 +368,8 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 			goto err_wptr_map_gart;
 		}
 
-		err = amdgpu_amdkfd_map_gtt_bo_to_gart(dev->adev, wptr_bo);
+		err = amdgpu_amdkfd_map_gtt_bo_to_gart(dev->adev, wptr_bo,
+						    p->kgd_process_info);
 		if (err) {
 			pr_err("Failed to map wptr bo to GART\n");
 			goto err_wptr_map_gart;
-- 
2.53.0

