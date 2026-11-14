Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794677961;
	b=OhkgDgqw69soyza1+QxbFB0G+n25e/tOxLSkAM1B+/OGZs9ftsSocPXRduu1v6Ox3zul
	 kmdCGlNeakPH4vzjkRtGrtO8M8xQ9dX2zBIOlN/J/ZBrJjEm+Hwv7v0jMsislh8wMJD9t
	 nDO84s3z/ff9i0GJ0Ark+3mMnbqNdV5j8Bt94PbNbFhKk3OLAZ7Hz8kaYOlb458WSKWGJ
	 CVhsbJg2hd6veQRNYNf7CD6BtFifjlaLs+rZrONX4RNeR4cYCn3yJAhBIuIPg5iqH5Fa3
	 cYLB113h6STu6Y4UF6DRdbZfm68QzqvxXQkvzmsRBPE/MvzT1NtBHEaDiWu2Bfmvu+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794677961;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=E375JMUregRqR9wSX/dM7UR2ya6XkJRDvPbgBfB7BaQ=;
	b=uMGB2UHrHM7LEeXzRTJJm+DkMq4gs4Trrng+6V8YqBDPpIw9ys/B6914FU9aALWOt6I/
	 jnsLQnnvghTX2kkFTw/VXjSFBUjMuyhnZaZuOKntb9d8VUucvzcQfKL4rWxoW82eJ4dIv
	 OjNwpXzbVc6lRouYD3/+8G1qLDERWpQEiIwIcNp+S8IlcIxkDXIVBktw8ta9sE5z2jaeH
	 dA28rfiyjtN2LH67dqgbtI6mIU+/UllNYfY5nD3uFm5lWgHk0IDlg4dYukurZO/CoTZhK
	 taUq+uVp33FD9MsLkVBxZ2t8LPKOFSnn7e8W7fVguMvvjDON4cKAIp2FVXp/odBi37g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bht+j45B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79914606A32D
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bht+j45B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709A11F000C4;
	Sat, 14 Nov 2026 17:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794677961;
	bh=E375JMUregRqR9wSX/dM7UR2ya6XkJRDvPbgBfB7BaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bht+j45BUvcMfHy7q/mhs8S2/owXW00BdsQGyvyTJ9kVKv3yg9l2mSJMYnLspZTXW
	 7O+e/NXiqka6hPRT8jxIGLs5DJRd4Sv0fX3elgSV5oM0bNqumg5IhSIHJi32lYuvZ8
	 wrTIzF9kYGG7yZqm5lKboBudYkFmbOslKiHCHEdkr1P6+qcDnjm1JDWLr7l3Oj1cAb
	 UaHGs78gwCj25UlbyMJ8AqSNwQ8ATE8rKSnRoZX9OkxfvGx23RTttOAyCm8Sfp5Phj
	 KBuJIkljNrSqMEyUxBDSeB/FCF4+vYLM2zi7c82yzLrmNi6BKwx85eJCBEwKbSCBI9
	 Xdm99H17vEVmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/amdkfd: use the queue's process info for the WPTR BO eviction fence
Date: Sat, 14 Nov 2026 12:39:19 -0500
Message-ID: <20261114173902.306494-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201421-failed-6.6-da2897ee8b81@kernel.org>
References: <20261109201421-failed-6.6-da2897ee8b81@kernel.org>
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
[ sashal: adapted process_info passing to kfd_ioctl_create_queue() using p->kgd_process_info instead of pqm->process->kgd_process_info ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 +++++---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 3 ++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 1be8c4a676096..938a29f8ad837 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -309,7 +309,8 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
 					     void **kptr, uint64_t *size);
 void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
 
-int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo);
+int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo,
+				     struct amdkfd_process_info *process_info);
 
 int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
 					    struct dma_fence **ef);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 05426ac8d9e14..ab04dce3c7ea9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2180,11 +2180,13 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
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
 
@@ -2206,8 +2208,8 @@ int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_b
 		goto err_map_bo_gart_failed;
 	}
 
-	amdgpu_amdkfd_remove_eviction_fence(
-		bo, bo->vm_bo->vm->process_info->eviction_fence);
+	/* bo->vm_bo can be the VM of any file which opened the BO */
+	amdgpu_amdkfd_remove_eviction_fence(bo, process_info->eviction_fence);
 
 	amdgpu_bo_unreserve(bo);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 44cd1b54d020e..a538331477085 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -375,7 +375,8 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
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

