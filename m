Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794358052;
	b=XF5VkTQeUB8APa1eNbrPwvQBTWFMQUs/QF5cWML/ukOhU5//Hvs+1Pr+gWfTKVW349bJ
	 xSyshloCN1tiPdDChD9HUTGYbZSHQIZn/UXRXpWhrywOH/3SSEL296Tnbd5D1iYjFXa7K
	 AGyP/K1ZyiL1TOZjDM/gg3VywS+J/K0kdOPSuWJBBkoQYHyS+dFKzyEOqHWIU8iuiw5bK
	 nPzugoGnAZo6OvZ0BlB76rhMNbQw7vUjNJ9tjEazAEOEHZGA2aHFSUG50O3A6dv5qvhSg
	 jEH+dzMOb608YgvFphaoTQBH7kGql0oj2CYoQixpatJM7JvGXU7slvWxI1juygKzuJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794358052;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ODsW1EWyQZzNwWTjRsAg8jJN5H4r3UYMrtQn3MWkF/8=;
	b=KpnJIDJ0NtAhLFe1z1ZmyFJrR/5rcAtrA3mS2GQNhYKPPEi1yePNkqAbX335RHzypw5Q
	 OpVdQQkJZ5WzyNMPUHpAeoD8xkolbcmGOI3p14IvC5i0rt1al+3PhS8kPXTa9Jg2HMaku
	 +w+Pq8dbsgohcAx6ld8DOekeKMngsDDApqsKBvnjrkIc/6EYeid9Xgl31iIOTo53PAIxv
	 hY/5KINL7vLiou4+dK9m+gnD5w/x+c66pRhwbxQNrrzoGD4iwj6legcNInhU0L/V2F/NT
	 nE+ABF62lbxLwbcvq1TWd9doj86D2h6zhaAypBrC/eCknTnYOA3RCfGaqBIfsNuj3Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nwiZjSw4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19EF606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nwiZjSw4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B4B1F0089F;
	Wed, 11 Nov 2026 00:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794358052;
	bh=ODsW1EWyQZzNwWTjRsAg8jJN5H4r3UYMrtQn3MWkF/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nwiZjSw4nbqBouLJKdWQK3QMCCGvWlJZznP2jqzYSq1egMKrLkO6Q5OPDzWrTTive
	 WHGjsmQ6FnVkP1H9n1IqVnfbPeAK6VB3hvHFBaejIQPKFzcN3Frjta48svXqgjYi5C
	 YHoiodql19jXN0sodKH9tSnHnzq+NRtpKRzoWy3LwGQVXTGr00xLD4yad3WdKQ54vw
	 8tJME05ZPYWWRKBAxA2S+YYWYOmiNjfGz5cfKibjTNyuXSThx+QAMbp9wiKELUGjkd
	 TGnMhYLfolv13HEuwBlbzz1Dy3rAbK238lPs4TthYJ1WY0xyXx2gZz+XVHl080h66X
	 wRDVJpe5yNX4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Emily Deng <Emily.Deng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] drm/amdkfd: Run restore_workers on freezable WQs
Date: Tue, 10 Nov 2026 19:47:29 -0500
Message-ID: <20261111004705.313340-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053959-failed-6.6-3254ed0b15f2@kernel.org>
References: <20261107053959-failed-6.6-3254ed0b15f2@kernel.org>
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

From: Felix Kuehling <Felix.Kuehling@amd.com>

[ Upstream commit 9a1c1339abf972477aeef4ea037e650f49c5892d ]

Make restore workers freezable so we don't have to explicitly flush them
in suspend and GPU reset code paths, and we don't accidentally try to
restore BOs while the GPU is suspended. Not having to flush restore_work
also helps avoid lock/fence dependencies in the GPU reset case where we're
not allowed to wait for fences.

A side effect of this is, that we can now have multiple concurrent threads
trying to signal the same eviction fence. Rework eviction fence signaling
and replacement to account for that.

The GPU reset path can no longer rely on restore_process_worker to resume
queues because evict/restore workers can run independently of it. Instead
call a new restore_process_helper directly.

This is an RFC and request for testing.

v2:
- Reworked eviction fence signaling
- Introduced restore_process_helper

v3:
- Handle unsignaled eviction fences in restore_process_bos

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Tested-by: Emily Deng <Emily.Deng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 3254ed0b15f2 ("drm/amdkfd: stop restore retries on device unplug")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 68 +++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 87 +++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  4 +-
 3 files changed, 104 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index b2c5f99b2e57a..e1a4073f8865c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1348,7 +1348,6 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 				  amdgpu_amdkfd_restore_userptr_worker);
 
 		*process_info = info;
-		*ef = dma_fence_get(&info->eviction_fence->base);
 	}
 
 	if (cmpxchg(&vm->process_info, NULL, *process_info) != NULL) {
@@ -1382,6 +1381,8 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 	list_add_tail(&vm->vm_list_node,
 			&(vm->process_info->vm_list_head));
 	vm->process_info->n_vms++;
+
+	*ef = dma_fence_get(&vm->process_info->eviction_fence->base);
 	mutex_unlock(&vm->process_info->lock);
 
 	return 0;
@@ -1394,10 +1395,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 	vm->process_info = NULL;
 already_acquired:
 	if (info) {
-		/* Two fence references: one in info and one in *ef */
 		dma_fence_put(&info->eviction_fence->base);
-		dma_fence_put(*ef);
-		*ef = NULL;
 		*process_info = NULL;
 		put_pid(info->pid);
 create_evict_fence_fail:
@@ -1591,7 +1589,8 @@ int amdgpu_amdkfd_criu_resume(void *p)
 		goto out_unlock;
 	}
 	WRITE_ONCE(pinfo->block_mmu_notifications, false);
-	schedule_delayed_work(&pinfo->restore_userptr_work, 0);
+	queue_delayed_work(system_freezable_wq,
+			   &pinfo->restore_userptr_work, 0);
 
 out_unlock:
 	mutex_unlock(&pinfo->lock);
@@ -2425,7 +2424,8 @@ int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
 				       KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
 		if (r)
 			pr_err("Failed to quiesce KFD\n");
-		schedule_delayed_work(&process_info->restore_userptr_work,
+		queue_delayed_work(system_freezable_wq,
+			&process_info->restore_userptr_work,
 			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
 	}
 	mutex_unlock(&process_info->notifier_lock);
@@ -2748,7 +2748,8 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 
 	/* If validation failed, reschedule another attempt */
 	if (evicted_bos) {
-		schedule_delayed_work(&process_info->restore_userptr_work,
+		queue_delayed_work(system_freezable_wq,
+			&process_info->restore_userptr_work,
 			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
 
 		kfd_smi_event_queue_restore_rescheduled(mm);
@@ -2757,6 +2758,23 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 	put_task_struct(usertask);
 }
 
+static void replace_eviction_fence(struct dma_fence **ef,
+				   struct dma_fence *new_ef)
+{
+	struct dma_fence *old_ef = rcu_replace_pointer(*ef, new_ef, true
+		/* protected by process_info->lock */);
+
+	/* If we're replacing an unsignaled eviction fence, that fence will
+	 * never be signaled, and if anyone is still waiting on that fence,
+	 * they will hang forever. This should never happen. We should only
+	 * replace the fence in restore_work that only gets scheduled after
+	 * eviction work signaled the fence.
+	 */
+	WARN_ONCE(!dma_fence_is_signaled(old_ef),
+		  "Replacing unsignaled eviction fence");
+	dma_fence_put(old_ef);
+}
+
 /** amdgpu_amdkfd_gpuvm_restore_process_bos - Restore all BOs for the given
  *   KFD process identified by process_info
  *
@@ -2780,7 +2798,6 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 	struct amdkfd_process_info *process_info = info;
 	struct amdgpu_vm *peer_vm;
 	struct kgd_mem *mem;
-	struct amdgpu_amdkfd_fence *new_fence;
 	struct list_head duplicate_save;
 	struct amdgpu_sync sync_obj;
 	unsigned long failed_size = 0;
@@ -2887,22 +2904,35 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 	/* Wait for validate and PT updates to finish */
 	amdgpu_sync_wait(&sync_obj, false);
 
-	/* Release old eviction fence and create new one, because fence only
-	 * goes from unsignaled to signaled, fence cannot be reused.
-	 * Use context and mm from the old fence.
+	/* The old eviction fence may be unsignaled if restore happens
+	 * after a GPU reset or suspend/resume. Keep the old fence in that
+	 * case. Otherwise release the old eviction fence and create new
+	 * one, because fence only goes from unsignaled to signaled once
+	 * and cannot be reused. Use context and mm from the old fence.
+	 *
+	 * If an old eviction fence signals after this check, that's OK.
+	 * Anyone signaling an eviction fence must stop the queues first
+	 * and schedule another restore worker.
 	 */
-	new_fence = amdgpu_amdkfd_fence_create(
+	if (dma_fence_is_signaled(&process_info->eviction_fence->base)) {
+		struct amdgpu_amdkfd_fence *new_fence =
+			amdgpu_amdkfd_fence_create(
 				process_info->eviction_fence->base.context,
 				process_info->eviction_fence->mm,
 				NULL);
-	if (!new_fence) {
-		pr_err("Failed to create eviction fence\n");
-		ret = -ENOMEM;
-		goto validate_map_fail;
+
+		if (!new_fence) {
+			pr_err("Failed to create eviction fence\n");
+			ret = -ENOMEM;
+			goto validate_map_fail;
+		}
+		dma_fence_put(&process_info->eviction_fence->base);
+		process_info->eviction_fence = new_fence;
+		replace_eviction_fence(ef, dma_fence_get(&new_fence->base));
+	} else {
+		WARN_ONCE(*ef != &process_info->eviction_fence->base,
+			  "KFD eviction fence doesn't match KGD process_info");
 	}
-	dma_fence_put(&process_info->eviction_fence->base);
-	process_info->eviction_fence = new_fence;
-	*ef = dma_fence_get(&new_fence->base);
 
 	/* Attach new eviction fence to all BOs except pinned ones */
 	list_for_each_entry(mem, &process_info->kfd_bo_list, validate_list) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 93740b8fc3f44..4dcde572103ad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -666,7 +666,8 @@ int kfd_process_create_wq(void)
 	if (!kfd_process_wq)
 		kfd_process_wq = alloc_workqueue("kfd_process_wq", 0, 0);
 	if (!kfd_restore_wq)
-		kfd_restore_wq = alloc_ordered_workqueue("kfd_restore_wq", 0);
+		kfd_restore_wq = alloc_ordered_workqueue("kfd_restore_wq",
+							 WQ_FREEZABLE);
 
 	if (!kfd_process_wq || !kfd_restore_wq) {
 		kfd_process_destroy_wq();
@@ -1646,6 +1647,7 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 	struct amdgpu_fpriv *drv_priv;
 	struct amdgpu_vm *avm;
 	struct kfd_process *p;
+	struct dma_fence *ef;
 	struct kfd_node *dev;
 	int ret;
 
@@ -1665,11 +1667,12 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 
 	ret = amdgpu_amdkfd_gpuvm_acquire_process_vm(dev->adev, avm,
 						     &p->kgd_process_info,
-						     &p->ef);
+						     &ef);
 	if (ret) {
 		dev_err(dev->adev->dev, "Failed to create process VM object\n");
 		return ret;
 	}
+	RCU_INIT_POINTER(p->ef, ef);
 	pdd->drm_priv = drm_file->private_data;
 	atomic64_set(&pdd->tlb_seq, 0);
 
@@ -1916,6 +1919,21 @@ kfd_process_gpuid_from_node(struct kfd_process *p, struct kfd_node *node,
 	return -EINVAL;
 }
 
+static int signal_eviction_fence(struct kfd_process *p)
+{
+	struct dma_fence *ef;
+	int ret;
+
+	rcu_read_lock();
+	ef = dma_fence_get_rcu_safe(&p->ef);
+	rcu_read_unlock();
+
+	ret = dma_fence_signal(ef);
+	dma_fence_put(ef);
+
+	return ret;
+}
+
 static void evict_process_worker(struct work_struct *work)
 {
 	int ret;
@@ -1928,31 +1946,46 @@ static void evict_process_worker(struct work_struct *work)
 	 * lifetime of this thread, kfd_process p will be valid
 	 */
 	p = container_of(dwork, struct kfd_process, eviction_work);
-	WARN_ONCE(p->last_eviction_seqno != p->ef->seqno,
-		  "Eviction fence mismatch\n");
-
-	/* Narrow window of overlap between restore and evict work
-	 * item is possible. Once amdgpu_amdkfd_gpuvm_restore_process_bos
-	 * unreserves KFD BOs, it is possible to evicted again. But
-	 * restore has few more steps of finish. So lets wait for any
-	 * previous restore work to complete
-	 */
-	flush_delayed_work(&p->restore_work);
 
 	pr_debug("Started evicting pasid 0x%x\n", p->pasid);
 	ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_TTM);
 	if (!ret) {
-		dma_fence_signal(p->ef);
-		dma_fence_put(p->ef);
-		p->ef = NULL;
-		queue_delayed_work(kfd_restore_wq, &p->restore_work,
+		/* If another thread already signaled the eviction fence,
+		 * they are responsible stopping the queues and scheduling
+		 * the restore work.
+		 */
+		if (!signal_eviction_fence(p))
+			queue_delayed_work(kfd_restore_wq, &p->restore_work,
 				msecs_to_jiffies(PROCESS_RESTORE_TIME_MS));
+		else
+			kfd_process_restore_queues(p);
 
 		pr_debug("Finished evicting pasid 0x%x\n", p->pasid);
 	} else
 		pr_err("Failed to evict queues of pasid 0x%x\n", p->pasid);
 }
 
+static int restore_process_helper(struct kfd_process *p)
+{
+	int ret = 0;
+
+	/* VMs may not have been acquired yet during debugging. */
+	if (p->kgd_process_info) {
+		ret = amdgpu_amdkfd_gpuvm_restore_process_bos(
+			p->kgd_process_info, &p->ef);
+		if (ret)
+			return ret;
+	}
+
+	ret = kfd_process_restore_queues(p);
+	if (!ret)
+		pr_debug("Finished restoring pasid 0x%x\n", p->pasid);
+	else
+		pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid);
+
+	return ret;
+}
+
 static void restore_process_worker(struct work_struct *work)
 {
 	struct delayed_work *dwork;
@@ -1978,24 +2011,15 @@ static void restore_process_worker(struct work_struct *work)
 	 */
 
 	p->last_restore_timestamp = get_jiffies_64();
-	/* VMs may not have been acquired yet during debugging. */
-	if (p->kgd_process_info)
-		ret = amdgpu_amdkfd_gpuvm_restore_process_bos(p->kgd_process_info,
-							     &p->ef);
+
+	ret = restore_process_helper(p);
 	if (ret) {
 		pr_debug("Failed to restore BOs of pasid 0x%x, retry after %d ms\n",
 			 p->pasid, PROCESS_BACK_OFF_TIME_MS);
 		ret = queue_delayed_work(kfd_restore_wq, &p->restore_work,
 				msecs_to_jiffies(PROCESS_BACK_OFF_TIME_MS));
 		WARN(!ret, "reschedule restore work failed\n");
-		return;
 	}
-
-	ret = kfd_process_restore_queues(p);
-	if (!ret)
-		pr_debug("Finished restoring pasid 0x%x\n", p->pasid);
-	else
-		pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid);
 }
 
 void kfd_suspend_all_processes(void)
@@ -2006,14 +2030,9 @@ void kfd_suspend_all_processes(void)
 
 	WARN(debug_evictions, "Evicting all processes");
 	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
-		cancel_delayed_work_sync(&p->eviction_work);
-		flush_delayed_work(&p->restore_work);
-
 		if (kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SUSPEND))
 			pr_err("Failed to suspend process 0x%x\n", p->pasid);
-		dma_fence_signal(p->ef);
-		dma_fence_put(p->ef);
-		p->ef = NULL;
+		signal_eviction_fence(p);
 	}
 	srcu_read_unlock(&kfd_processes_srcu, idx);
 }
@@ -2025,7 +2044,7 @@ int kfd_resume_all_processes(void)
 	int ret = 0, idx = srcu_read_lock(&kfd_processes_srcu);
 
 	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
-		if (!queue_delayed_work(kfd_restore_wq, &p->restore_work, 0)) {
+		if (restore_process_helper(p)) {
 			pr_err("Restore process %d failed during resume\n",
 			       p->pasid);
 			ret = -EFAULT;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 006ba258e683f..988c9da95bf54 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1898,7 +1898,7 @@ static void svm_range_restore_work(struct work_struct *work)
 	/* If validation failed, reschedule another attempt */
 	if (evicted_ranges) {
 		pr_debug("reschedule to restore svm range\n");
-		schedule_delayed_work(&svms->restore_work,
+		queue_delayed_work(system_freezable_wq, &svms->restore_work,
 			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
 
 		kfd_smi_event_queue_restore_rescheduled(mm);
@@ -1974,7 +1974,7 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 			pr_debug("failed to quiesce KFD\n");
 
 		pr_debug("schedule to restore svm %p ranges\n", svms);
-		schedule_delayed_work(&svms->restore_work,
+		queue_delayed_work(system_freezable_wq, &svms->restore_work,
 			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
 	} else {
 		unsigned long s, l;
-- 
2.53.0

