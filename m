Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CED3F8886;
	Mon, 10 Aug 2026 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786378668; cv=none; b=M1qzLYx9VmtDRQgIPdKFVjQM2GZIK6ttX2TqUdAaCYd8dKvokrGW5M6qPJxY+k5tZ0KvtKCbUQ6doP54fvA4RCYhpvPU/L5WBRO+gcox/QdjpGBKiU8U0JBU9er/AUNAREYBQW2eM+tgzjy+zNWP48X/dv2Pq8DSHwznTPMhamk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786378668; c=relaxed/simple;
	bh=HkNyNZT7BLjrADpqU1n8ztglAus49jq8Yw+tgDgVUvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vkqg7M8QtjXwHwnT9pEp1HFd80Agg3JWTBhypL9cAI+UC+vl7INK9Y0e0X4SX8zdHXSgfUrPQqwtCvhug28vQ4gZx0sqcyXnL/OQT4m/gCLSh1bvRkYIuOrBYkJjgqeBnyVgITo1wITC9Uevda7NC7wq6WJBI1/9u+KuAF+T+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2jpmx4Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2jpmx4Q"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5EC8C2BCFA;
	Mon, 10 Aug 2026 16:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786378667;
	bh=HkNyNZT7BLjrADpqU1n8ztglAus49jq8Yw+tgDgVUvU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=i2jpmx4Q4ebk8BEoBUwdjKOUO0z5Z0VxWoyglwAW20nUSmG3OlfLeLxyl2fvFt7jP
	 xYKFvpw3+4j8uai+CcIpp4SnhfuiCrjHa6RZnX5AaZ53Io/9NqCNNlQrgTDf4BDBDx
	 W6QsqdfVUOqzjSts31CxOLyhrBupV+76pNRR7I6cLP+PJwuGd8vcbc6pXwhBG60qNI
	 gGs7Y78WN/YX7pA/1i64DESaTUDqM1zzggxPUa/wVc5EJSNJ3fl6S5cvZbLUcmOyY3
	 11Y3ApOKz/NfiWAhlosKzjkJW5ai4cEpw8HHVZ4c12ft0hKIeGaXLZLfUXOVsuovs1
	 5jSNe7FiF0ZxQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDD9C5AD7B;
	Mon, 10 Aug 2026 16:17:47 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Tue, 11 Aug 2026 00:13:12 +0800
Subject: [PATCH 3/5] drm/amdgpu/userq: bound the eviction fence rearm retry
 loop
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-amdgpu-fixes-v1-3-4954a417b8ff@outlook.com>
References: <20260811-amdgpu-fixes-v1-0-4954a417b8ff@outlook.com>
In-Reply-To: <20260811-amdgpu-fixes-v1-0-4954a417b8ff@outlook.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Junwei Zhang <Jerry.Zhang@amd.com>, 
 =?utf-8?q?Nicolai_H=C3=A4hnle?= <nicolai.haehnle@amd.com>, 
 Prike Liang <Prike.Liang@amd.com>, Arvind Yadav <arvind.yadav@amd.com>, 
 Shashank Sharma <shashank.sharma@amd.com>, Leo Liu <leo.liu@amd.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5540;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=pc/SsaipZ7NjkbbEcRk7SSITnHVNauzCNXg3L1I8WBA=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrMqfSz92XTihnLXcXp3xqavki9yqH1L2sVO2HFpjM
 +XilKVyuskdpSwMYlwMsmKKLMcLLn2z8N2iu8VnSzLMHFYmkCEMXJwCMBGBmwz/ww/FVdWI7Mpu
 +JisIs0z7010snVrz2THoHUyi+O2u/rlMDI07BfkelX35s67M4qbmO7UcvAH1GuneZfsmPoxYfl
 jO1Z+AAhUSms=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

amdgpu_userq_ensure_ev_fence() loops until the eviction fence is both
present and unsignaled.  The only producer of such a fence is
amdgpu_evf_mgr_rearm(), which runs as the very last step of
amdgpu_userq_vm_validate().  Every failure point ahead of it - the
kzalloc() in the rearm itself, amdgpu_hmm_range_alloc(), the
ttm_bo_validate() calls, the GART binding of the wptr BOs - makes
amdgpu_userq_restore_worker() give up with only a drm_file_err().
Nothing propagates that back, so the waiting thread reschedules the
worker and flushes it again, forever.

Both flush_delayed_work() and mutex_lock() sleep in
TASK_UNINTERRUPTIBLE, so the looping task cannot be killed and the OOM
killer cannot reclaim it. An unprivileged render node client
reaches this from both AMDGPU_USERQ and AMDGPU_USERQ_SIGNAL.

The eviction fence sequence number is already bumped by every
successful rearm, so use it as the loop's progress condition: if a
completed flush of the restore worker did not move it then no rearm
happened and retrying cannot help.  Return -ENOMEM in that case and
let both callers report it to userspace.

Fixes: a242a3e4b5be ("drm/amdgpu: simplify eviction fence suspend/resume")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c       | 21 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 10 +++++++++-
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index bec107216811..208b53ae5bd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -448,12 +448,16 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
  * Ensures that a valid and not yet signaled eviction fence is attached to the
  * usermode queue before any queue operations proceed. If it is signalled, then
  * rearm a new eviction fence.
+ *
+ * Returns 0 with @uq_mgr->userq_mutex held, or -ENOMEM with the mutex released
+ * when the restore worker could not rearm the fence.
  */
-void
+int
 amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
 			     struct amdgpu_eviction_fence_mgr *evf_mgr)
 {
 	struct dma_fence *ev_fence;
+	int seq, prev_seq = -1;
 
 retry:
 	/* Flush any pending resume work to create ev_fence */
@@ -463,7 +467,16 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
 	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
 	if (dma_fence_is_signaled(ev_fence)) {
 		dma_fence_put(ev_fence);
+		seq = atomic_read(&evf_mgr->ev_fence_seq);
 		mutex_unlock(&uq_mgr->userq_mutex);
+		/*
+		 * The sequence number is only bumped by a successful rearm, so
+		 * if the flush above ran the worker without moving it then the
+		 * restore failed and looping again would never terminate.
+		 */
+		if (seq == prev_seq)
+			return -ENOMEM;
+		prev_seq = seq;
 		/*
 		 * Looks like there was no pending resume work,
 		 * add one now to create a valid eviction fence
@@ -472,6 +485,8 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
 		goto retry;
 	}
 	dma_fence_put(ev_fence);
+
+	return 0;
 }
 
 
@@ -747,7 +762,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	if (r)
 		goto clean_mqd;
 
-	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
+	r = amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
+	if (r)
+		goto erase_doorbell;
 
 	/* don't map the queue if scheduling is halted */
 	if (!adev->userq_halt_for_enforce_isolation ||
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 6412a7f7b6ef..c35909bf7ceb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -164,8 +164,8 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
 
 void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
 
-void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
-				  struct amdgpu_eviction_fence_mgr *evf_mgr);
+int amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
+				 struct amdgpu_eviction_fence_mgr *evf_mgr);
 
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev);
 bool amdgpu_userq_enabled(struct drm_device *dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 7e80442ec3e5..1c287ce59736 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -523,7 +523,15 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		goto put_queue;
 
 	/* We are here means UQ is active, make sure the eviction fence is valid */
-	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
+	r = amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
+	if (r) {
+		/* The fence is not initialized yet, so unwind it by hand */
+		amdgpu_userq_fence_put_fence_drv_array(fence);
+		amdgpu_userq_fence_driver_put(fence->fence_drv);
+		kvfree(fence->fence_drv_array);
+		kfree(fence);
+		goto put_queue;
+	}
 
 	/* Create the new fence */
 	amdgpu_userq_fence_init(queue, fence, wptr);

-- 
2.51.2


