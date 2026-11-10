Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272995;
	b=izzJnD4W8iuR19IyX9/rlTw1CnrLEt7fa4mwEJqKaj6IpcPJAttK9rg21EVBQkT9c5p8
	 Cc/6DfxvX770EIIyxznZ/+8DruUoiYVOmFn4+ccqNeXyoSTBjn+oGDeR/0L2lLka2rQzS
	 B7OCy6UoEf86q2/bcE8k1qZxMJzWcYkI7dgk5mnkTdh3GsMk3SVOVLsroeOGx+qKBaVgZ
	 +kmfeasDtfzR/202VymCgqehlIHokAXRkNfNt8eNoEcyveeIV1EalCUaebuy9tE9idaNN
	 T7s6M204h0Zk9hsS62t+aI+fNeIvYKLfCU5WmCKa4amu0k82CIjwNX/Ncg8CyeljiXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272995;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Y6JP0tOxL2Vh1iOSHvWyB6mpp9ngRgyTyeU5or19sy8=;
	b=GuO6SpS4EHKPPV7iDdlPQbFL1rn9rPOkmLpjtuLslCBNFA2okTRF7fL3OELfxmo/DP6t
	 Xwo9NP+TAaxU3nZ54+YHvV7SVgInJcqx4ukEYIYJle8N7Kw51Y/2qogDfy4kxS8I1A2XY
	 rd6m9vs+MqW/p76NLQCtMxhMfE+xib5fji9TYHW97n98Rd8pNnbwSQRP11uwIpXo0MGc+
	 fz/qp7yslIt9XXlZjmEW/WajlXeC0YfrNjzV1U5NWd/U4rXv85XOuPzQFSL7PTDVlgRMb
	 xEcZQw0B9O8OcJQQy3tk5mqegE0fZvDvlGPRB5nVEUg+lEpfSLfNv5MGeL/YEcovQJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZ2Afq7H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1701E606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZ2Afq7H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575CD1F0089F;
	Tue, 10 Nov 2026 01:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272994;
	bh=Y6JP0tOxL2Vh1iOSHvWyB6mpp9ngRgyTyeU5or19sy8=;
	h=From:To:Cc:Subject:Date;
	b=hZ2Afq7HN57pwdfKmCB04VgwA9gIFmRYHhAYe/v9+WQAxpjKnuCombn7KPiPBWiDW
	 ok6QAGws6Ff3A4SneaElPw7Pv662vKXKpAWxsCP0E5I6pnPM3MSaCV7wxilXE/paRe
	 BUNd4y+65K79Bx/tKJnlXpn8WMi7Q8MgPXj4ymEw6derm8CPWRwgJnh/lLEiF2/Fhy
	 vkDkP1UbE4Whz97zVcZUckZdh2l6WuR2tehRKU8t94hVXUMF+oKlHKAX8CSGxHLoz3
	 WCeAuFsoyF3wZaKyPxIp92ZE0dmIf4OtfXExwsrxDQ6eFCfyZIk7Lh8CfVmPBwZXc2
	 ZNq2dWji8e7+Q==
From: Sasha Levin <sashal@kernel.org>
To: jesse.zhang@amd.com,
	felix.kuehling@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdkfd: use the queue's process info for the WPTR BO eviction fence" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:09:53 -0500
Message-ID: <20261109200953-failed-6.12-da2897ee8b81@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x da2897ee8b811945fd40ecc4aaf03291c14ce61c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200953-failed-6.12-da2897ee8b81@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From da2897ee8b811945fd40ecc4aaf03291c14ce61c Mon Sep 17 00:00:00 2001
From: Jesse Zhang <Jesse.Zhang@amd.com>
Date: Sat, 24 Oct 2026 01:26:49 +0800
Subject: [PATCH] drm/amdkfd: use the queue's process info for the WPTR BO
 eviction fence

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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h             | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c       | 8 +++++---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 3 ++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 77c0504cc158d..74dc307e5140a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -344,7 +344,8 @@ int amdgpu_amdkfd_gpuvm_map_bo_to_kernel(struct kgd_mem *mem, void **kptr,
 					 u64 *size, u32 domain);
 void amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(struct kgd_mem *mem);
 
-int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart);
+int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart,
+				     struct amdkfd_process_info *process_info);
 
 int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
 					    struct dma_fence __rcu **ef);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 3a4b3424b5b29..c399b85731b47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2261,11 +2261,13 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
  * amdgpu_amdkfd_map_gtt_bo_to_gart - Map BO to GART and increment reference count
  * @bo: Buffer object to be mapped
  * @bo_gart: Return bo reference
+ * @process_info: KFD process info of the queue the BO is for
  *
  * Before return, bo reference count is incremented. To release the reference and unpin/
  * unmap the BO, call amdgpu_amdkfd_free_kernel_mem.
  */
-int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart)
+int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart,
+				     struct amdkfd_process_info *process_info)
 {
 	int ret;
 
@@ -2287,8 +2289,8 @@ int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo
 		goto err_map_bo_gart_failed;
 	}
 
-	amdgpu_amdkfd_remove_eviction_fence(
-		bo, bo->vm_bo->vm->process_info->eviction_fence);
+	/* bo->vm_bo can be the VM of any file which opened the BO */
+	amdgpu_amdkfd_remove_eviction_fence(bo, process_info->eviction_fence);
 
 	amdgpu_bo_unreserve(bo);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 78ab759ad8549..4c4a3a8587f46 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -303,7 +303,8 @@ static int init_user_queue(struct process_queue_manager *pqm,
 		}
 
 		retval = amdgpu_amdkfd_map_gtt_bo_to_gart(q_properties->wptr_bo,
-							  &(*q)->wptr_bo_gart);
+							  &(*q)->wptr_bo_gart,
+							  pqm->process->kgd_process_info);
 		if (retval) {
 			pr_err("Failed to map wptr bo to GART\n");
 			goto free_gang_ctx_bo;
-- 
2.53.0




