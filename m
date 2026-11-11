Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794359405;
	b=GJvbjEcVsguwblmJ+sYwkR0vOHpgZ7dDGVW8Q08fq2aDOcYx0w+D3TqHxw6SqlDQ0n/7
	 8KaOa7nxVcdBbnFKgihnUzKfC12brXRgorBNTn8NDiM7tieax+b0Cr64S6Jinz+Z9pNj8
	 JMnPCveyqT0xxaQWYzVFPyui8stglBRqzp1ZLRPaO9yvIgGluX7nfROQnMu7GAIi4V6Ya
	 qEaM4CKGUARXxrLgYqEyxkeBrdxHot705Jixc44Tx04wJ5qE1OtMqpdfGImMtwPS34XBx
	 kq2sULB7EKVkXPppE3/Zv/LT/VX2XJFJSafP4lU2eSE0fCxMHRGdEssNviKtiT0LMlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359405;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GwTyGutd8yv4Q/cO6eb4sVObfcN5ns1jOIZR8aKjOCU=;
	b=dwa1gzs8IHvytP0PYZpMn1xJ4unwjlKjA+dzbB7RStywh+UsQ2hyA8mkQiX75l0dXflN
	 iMWA2LvnmNQKnOTSSRN6XCt5QAilTfWU2ipDmt5B1+5kWipuBdFocE0CHhU/EvcJhKWF1
	 +TgAWMYz/J34Nm/KjU8GxTS9Tn3pgnQK5Qn2xavAROEkIB/JV/R06vnTaGQ7LUO05MzYN
	 vAIvATHNy8aRcM3ToWQbD/2CelV8kiLg5dqbfDufASGj+H1fPRyKIUai9iuBIb0HXk5A0
	 apmGmhj9atHVwU/GpOmf/KNkcvm26PT848tVdU3SDE9hNzzcESgwy1sh3U7h0ElOj7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c+tACHnc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737E1606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c+tACHnc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3FF1F0089F;
	Wed, 11 Nov 2026 01:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794359404;
	bh=GwTyGutd8yv4Q/cO6eb4sVObfcN5ns1jOIZR8aKjOCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c+tACHnc1f4FdHXvLhFRs2ptfFtcDrY6d9B6g3bXqtfDAl8apmQQf42luH9iEcZQk
	 iXEFMIOR+xCvzhdIaQom8K1ztpbcto2DQliF8VaY5ke9SEsMesyH21kD3oOn/K6lKp
	 sFJJSAAuPtSyYqzmXd5OFzy2gvxa9rpGLmDaZdtzH0KMgob3JsS31buybxGxed2wSE
	 GoeZjBb3CHd3Kiq62zqNbvww6vOd2CWkYerpfnD4fP6EsR9hnjAATg37ycpW4Y/l/L
	 1jQAYASkzCbVOYL4G4occ/MqLr0vwl4FTFQIP/NV61mTI2mvLdXxSpRjEiYJx+re7v
	 0B/7DSSRE91Aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
	Xiaogang Chen <xiaogang.chen@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/amdkfd: stop restore retries on device unplug
Date: Tue, 10 Nov 2026 20:10:02 -0500
Message-ID: <20261111010850.346598-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061250-failed-5.15-3254ed0b15f2@kernel.org>
References: <20261107061250-failed-5.15-3254ed0b15f2@kernel.org>
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
[ sashal: Adapted notifier-locked retry handling to the existing atomic eviction counter checks. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c    | 17 ++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c            |  8 +++++---
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 07aa9f8de2644..b89bcf84cfa9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2188,6 +2188,7 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 	struct task_struct *usertask;
 	struct mm_struct *mm;
 	int evicted_bos;
+	int ret;
 
 	evicted_bos = atomic_read(&process_info->evicted_bos);
 	if (!evicted_bos)
@@ -2205,7 +2206,8 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 
 	mutex_lock(&process_info->lock);
 
-	if (update_invalid_user_pages(process_info, mm))
+	ret = update_invalid_user_pages(process_info, mm);
+	if (ret)
 		goto unlock_out;
 	/* userptr_inval_list can be empty if all evicted userptr BOs
 	 * have been freed. In that case there is nothing to validate
@@ -2215,7 +2217,8 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 		if (atomic_read(&process_info->evicted_bos) != evicted_bos)
 			goto unlock_out; /* Concurrent eviction, try again */
 
-		if (validate_invalid_user_pages(process_info))
+		ret = validate_invalid_user_pages(process_info);
+		if (ret)
 			goto unlock_out;
 	}
 	/* Final check for concurrent evicton and atomic update. If
@@ -2224,8 +2227,10 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
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
@@ -2239,8 +2244,10 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 	mmput(mm);
 	put_task_struct(usertask);
 
-	/* If validation failed, reschedule another attempt */
-	if (evicted_bos)
+	/* If validation failed, reschedule another attempt, unless the
+	 * device is gone for good
+	 */
+	if (evicted_bos && ret != -ENODEV)
 		schedule_delayed_work(&process_info->restore_userptr_work,
 			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ff776944793a8..0b20ef89c4ad5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1575,7 +1575,7 @@ static void svm_range_restore_work(struct work_struct *work)
 	struct mm_struct *mm;
 	int evicted_ranges;
 	int invalid;
-	int r;
+	int r = 0;
 
 	svms = container_of(dwork, struct svm_range_list, restore_work);
 	evicted_ranges = atomic_read(&svms->evicted_ranges);
@@ -1645,8 +1645,10 @@ static void svm_range_restore_work(struct work_struct *work)
 	mutex_unlock(&svms->lock);
 	mmap_write_unlock(mm);
 
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

