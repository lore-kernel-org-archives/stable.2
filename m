Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0BD51992E
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583835; cv=none; b=ohXBXxEKO3iQBJaQEXxgYcmuW7+lunygDE0IJq3jF+S9jM2TTq8y+Z+qyfGwJet0VB4bJKFKWHcRvLFYspLzkmLZGCoZONcDKvVkENhPEbhhqmTXFssDguRvRQ4ZZIRBgsZp+GOubsTTMIEZQ3KSaOJoTl8PAZcUy4Rc7acQTTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583835; c=relaxed/simple;
	bh=bbUY+kWB21fk5jP6Ve7N8Uu3EbVmtKBXswsmmXoocNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VT0D4ntILao0lULvBctHZeX2zPfia7XuHg1WMJIrzaF9W8HpklDD4neWipQmYLnRF7FmE8uhBu8oqYfK/hlZ9zF1qDcz/WBY8snI/rRApzpDaZOW9Abk1s7lB5dAqxqHnjS1/Vcsse+vVSkvOYsLBIKhxg6xpKdBofTfwxfwnmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+XQF03O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+XQF03O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892B01F0089F;
	Wed, 16 Sep 2026 18:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583804;
	bh=e+vRpJ8m4bjYH3WhZFhkH0WVrZ0TSbXg1FSvSqNxOQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d+XQF03O0XtRSOdcKEmvFhexGoIRLNSttRN3NTUe1P9sRF2DNqfuvKYqMepXrj3bP
	 kIh68aXIU92DA/GBGTRzMWNDUlQ0D10Dvta731l/TnM7/L1+54SwrJYpLQMWhg6Wkq
	 dfPIoNcBBpJLnVzAR2XDRsvnK89llGUdXTU6aN2AzWN3sqU+gvZSuW4Swi0Oc0HoWS
	 TZmkS+nHfNi95glD/kJj6bXVOGjDVd9lRXF7K0peYVGLbBMSDUiEjppkSWtIA8P0EB
	 pjwo5NhUmYXX8Zj8zq++CLlO2y7wVwcSF/YuaVYFal16SU9qi2jj0baO0g1/TxSE7b
	 2liXhe962YZcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] drm/amdgpu: rename amdgpu_fill_buffer as amdgpu_ttm_clear_buffer
Date: Wed, 16 Sep 2026 14:36:40 -0400
Message-ID: <20260916183641.1771014-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916183641.1771014-1-sashal@kernel.org>
References: <2026091636-creole-glorified-e7b6@gregkh>
 <20260916183641.1771014-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

[ Upstream commit 5bd8aab55bc18a744577bff79a8c58b031e3c05d ]

This is the only use case for this function.

---
v2: amdgpu_ttm_clear_buffer instead of amdgpu_clear_buffer
---

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Stable adaptation for 6.18:

The preceding stable dependency already specialized amdgpu_fill_buffer
for zeroing and removed its src_data argument. Retain that adaptation
and limit this dependency to renaming the existing helper, its declaration,
its kernel-doc heading, and all three callers.

Keep the existing drm_sched_entity type, high_pr/low_pr selection, shared
GART-window locking, reservation dependencies, and no-job return handling.
The upstream amdgpu_ttm_buffer_entity infrastructure and next-clear-entity
helper are absent from this stable tree and are not needed for the rename.
No functions are added. The VMID-flush changes remain in the target commit,
whose unchanged patch applies cleanly after this dependency.

Stable-dep-of: 87ceb8cba73d ("drm/amdgpu: skip the VMID 0 flush for VRAM")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 18 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    | 12 ++++++------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index e29bcb090f06d..4def8b6640891 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -728,9 +728,9 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	    bo->tbo.resource->mem_type == TTM_PL_VRAM) {
 		struct dma_fence *fence;
 
-		r = amdgpu_fill_buffer(&adev->mman.low_pr, bo,
-				       bo->tbo.base.resv, &fence, true,
-				       AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER);
+		r = amdgpu_ttm_clear_buffer(&adev->mman.low_pr, bo,
+					    bo->tbo.base.resv, &fence, true,
+					    AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER);
 		if (unlikely(r))
 			goto fail_unreserve;
 
@@ -1328,9 +1328,9 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
 	if (r)
 		goto out;
 
-	r = amdgpu_fill_buffer(&adev->mman.low_pr, abo,
-			       &bo->base._resv, &fence, false,
-			       AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
+	r = amdgpu_ttm_clear_buffer(&adev->mman.low_pr, abo,
+				    &bo->base._resv, &fence, false,
+				    AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
 	if (WARN_ON(r))
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index dbaba8aacec27..8a433a0920e74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -412,8 +412,8 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
 	    (abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE)) {
 		struct dma_fence *wipe_fence = NULL;
 
-		r = amdgpu_fill_buffer(&adev->mman.high_pr, abo, NULL, &wipe_fence,
-				       false, AMDGPU_KERNEL_JOB_ID_MOVE_BLIT);
+		r = amdgpu_ttm_clear_buffer(&adev->mman.high_pr, abo, NULL, &wipe_fence,
+					    false, AMDGPU_KERNEL_JOB_ID_MOVE_BLIT);
 		if (r) {
 			goto error;
 		} else if (wipe_fence) {
@@ -2394,7 +2394,7 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_device *adev,
 }
 
 /**
- * amdgpu_fill_buffer - fill a buffer with 0
+ * amdgpu_ttm_clear_buffer - fill a buffer with 0
  * @entity: scheduler entity to use
  * @bo: the bo to fill
  * @resv: fences contained in this reservation will be used as dependencies.
@@ -2404,12 +2404,12 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_device *adev,
  *                         after allocation.
  * @k_job_id: trace id
  */
-int amdgpu_fill_buffer(struct drm_sched_entity *entity,
-		       struct amdgpu_bo *bo,
-		       struct dma_resv *resv,
-		       struct dma_fence **out_fence,
-		       bool consider_clear_status,
-		       u64 k_job_id)
+int amdgpu_ttm_clear_buffer(struct drm_sched_entity *entity,
+			    struct amdgpu_bo *bo,
+			    struct dma_resv *resv,
+			    struct dma_fence **out_fence,
+			    bool consider_clear_status,
+			    u64 k_job_id)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct dma_fence *fence = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index fc5133af30485..c5f7efd78409a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -178,12 +178,12 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 			       uint64_t size, bool tmz,
 			       struct dma_resv *resv,
 			       struct dma_fence **f);
-int amdgpu_fill_buffer(struct drm_sched_entity *entity,
-		       struct amdgpu_bo *bo,
-		       struct dma_resv *resv,
-		       struct dma_fence **out_fence,
-		       bool consider_clear_status,
-		       u64 k_job_id);
+int amdgpu_ttm_clear_buffer(struct drm_sched_entity *entity,
+			    struct amdgpu_bo *bo,
+			    struct dma_resv *resv,
+			    struct dma_fence **out_fence,
+			    bool consider_clear_status,
+			    u64 k_job_id);
 
 int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
 void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
-- 
2.53.0

