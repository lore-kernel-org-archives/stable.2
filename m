Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794358641;
	b=aQW/2xMET9yxuVf8lsAcm81QzqcA6JpIRjpzBsBAMRrLVopzXgGWLGtiQoUz8htCKOPf
	 2wcyJPPCQXfLzEjt+OD+9sRfj3G1cS6yybpVvJSC3/cR4XuU9ubWYQSQwOhFNzL6arl1c
	 Ys9Y7IzrGtKmMVR8HDwEAUQdr/sMV+pIEzxvEzEZ71S1gejTg9KcvguL63vVxC/wRGzpH
	 GSA9oyO2GtzbIdKKaz10QcNQ8SN5XsYn2VPlmJy/dwqW4HyWWEi6Zcd80bg7nMrJ4dEYb
	 7HrSJsGHAfGJQABoT6+ncmbRgWhENFnpEICns/i0lZJ+3OJiu/Qs7xpKlYjRKTDhYMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794358641;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sQi5Oh5rP5tDj0Cc3mU6Kf/1ZJ5eniiB45pRRUL+yPc=;
	b=4NDXoSIiCesQHAtDTi0u5sjgN0//Ws6JDU8WB99hoL0ynV39bMOYCqEg/4V7Y1/FXLsE
	 9087Fjs42tipPASv0m4Uv2Qp/hrCq8I5kfYEvbCM24ZkVIl7rTuOoHAtVBsLHhBexP1DO
	 1Qf/4B/4Kp+pJnf5V100BbCq3yFyid9ZTnKyTHNviRPbIi2awGswV9NjIYIRVtQv8oDdC
	 Wq0+zzCk+RWXo/hYry9mz/jdA8uCo7r89tcLISHTBiOoKnEJrtz2KtFzcSVHaMoNNt7Yd
	 JhJU1O/7q2iHbgsL9DkA835o2QJ8a4ABi1bgX8lpefj+GRgK1GznoZOircIAs7speyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WrG1KxJj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C690F606A330
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WrG1KxJj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C8A1F0089F;
	Wed, 11 Nov 2026 00:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794358641;
	bh=sQi5Oh5rP5tDj0Cc3mU6Kf/1ZJ5eniiB45pRRUL+yPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WrG1KxJjCzGzYZunljRneIBLW960OZSRADDJA4bl4PMyKyqyeW/MXMJdRwP/JHr0j
	 pDmZ1+OjxAU40yNoJ6lOARda5G5KTxPxotAbXBiIDs+XDZ1zhwKbNiR/UYTYj5N9CY
	 NyfszlygMKrnZAz5PNqWjlTWH8oCDqNrRocN1G7epaAhY2588EX+1gs4bJNMoZnJ8O
	 A8tLBEsVKEiUmYpQgCkP6rRkazwkC1eWrUhmI2e/VyHaAnGeICVEkL/noGJHDHOsp5
	 oykxP9US/RIRdhOjDE5pbtuamwKOSbqoP6T+pV0gRYNDb8K99C3RZMKij6VPIRoMAr
	 3vVL5E3tZonmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
	Xiaogang Chen <xiaogang.chen@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/amdkfd: stop restore retries on device unplug
Date: Tue, 10 Nov 2026 19:57:19 -0500
Message-ID: <20261111005656.329071-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055554-failed-6.1-3254ed0b15f2@kernel.org>
References: <20261107055554-failed-6.1-3254ed0b15f2@kernel.org>
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

From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>

[ Upstream commit 3254ed0b15f2fe656c9cb36ccb59b92422440bf8 ]

amdgpu_amdkfd_restore_userptr_worker() and svm_range_restore_work()
reschedule themselves when validation fails with evicted objects
pending. After a surprise removal the restore paths fail with -ENODEV
permanently, so rescheduling just spins the worker uselessly until
cancel_delayed_work_sync() in fini finally stops it - which can take
a while, since process teardown itself is delayed by the dead device.

Treat -ENODEV as terminal in both workers.

Cc: Xiaogang Chen <xiaogang.chen@amd.com>
Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 266fab83139600e58db7e900e930c722e619b78c)
Cc: stable@vger.kernel.org
[ sashal: Adapted retry handling to existing atomic eviction counters instead of notifier locking. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c    | 17 ++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c            |  8 +++++---
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 59ea50b0962e5..4372317b63019 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2609,6 +2609,7 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 	struct task_struct *usertask;
 	struct mm_struct *mm;
 	int evicted_bos;
+	int ret;
 
 	evicted_bos = atomic_read(&process_info->evicted_bos);
 	if (!evicted_bos)
@@ -2626,7 +2627,8 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 
 	mutex_lock(&process_info->lock);
 
-	if (update_invalid_user_pages(process_info, mm))
+	ret = update_invalid_user_pages(process_info, mm);
+	if (ret)
 		goto unlock_out;
 	/* userptr_inval_list can be empty if all evicted userptr BOs
 	 * have been freed. In that case there is nothing to validate
@@ -2636,7 +2638,8 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 		if (atomic_read(&process_info->evicted_bos) != evicted_bos)
 			goto unlock_out; /* Concurrent eviction, try again */
 
-		if (validate_invalid_user_pages(process_info))
+		ret = validate_invalid_user_pages(process_info);
+		if (ret)
 			goto unlock_out;
 	}
 	/* Final check for concurrent evicton and atomic update. If
@@ -2645,8 +2648,10 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 	 * reference counting inside KFD will handle this case.
 	 */
 	if (atomic_cmpxchg(&process_info->evicted_bos, evicted_bos, 0) !=
-	    evicted_bos)
+	    evicted_bos) {
+		ret = -EAGAIN;
 		goto unlock_out;
+	}
 	evicted_bos = 0;
 	if (kgd2kfd_resume_mm(mm)) {
 		pr_err("%s: Failed to resume KFD\n", __func__);
@@ -2658,8 +2663,10 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 unlock_out:
 	mutex_unlock(&process_info->lock);
 
-	/* If validation failed, reschedule another attempt */
-	if (evicted_bos) {
+	/* If validation failed, reschedule another attempt, unless the
+	 * device is gone for good
+	 */
+	if (evicted_bos && ret != -ENODEV) {
 		schedule_delayed_work(&process_info->restore_userptr_work,
 			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index e60ab76d3e6f6..13ae155bd5325 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1692,7 +1692,7 @@ static void svm_range_restore_work(struct work_struct *work)
 	struct mm_struct *mm;
 	int evicted_ranges;
 	int invalid;
-	int r;
+	int r = 0;
 
 	svms = container_of(dwork, struct svm_range_list, restore_work);
 	evicted_ranges = atomic_read(&svms->evicted_ranges);
@@ -1766,8 +1766,10 @@ static void svm_range_restore_work(struct work_struct *work)
 	mmap_write_unlock(mm);
 	mutex_unlock(&process_info->lock);
 
-	/* If validation failed, reschedule another attempt */
-	if (evicted_ranges) {
+	/* If validation failed, reschedule another attempt, unless the
+	 * device is gone for good
+	 */
+	if (evicted_ranges && r != -ENODEV) {
 		pr_debug("reschedule to restore svm range\n");
 		schedule_delayed_work(&svms->restore_work,
 			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
-- 
2.53.0

