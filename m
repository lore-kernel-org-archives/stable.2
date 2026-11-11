Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794358053;
	b=xUPH7XIVUpUkU4olEESfogtEjWmi+IJ4r0UWba3MfR35hO3HsWdDHEKa/9BnBRtcjyCb
	 3eimaPrNr8H79nMxKEUr6u+HzLNIcCcMZWBEAGEuFbo+yu0oJpuLEDv5AYnu6CfqjhUx5
	 ff2nfv6NfGPLZuhQmHVeZKRbEEIFK/Rz2QVLvaGsY7tdrur7JJg4lXptdrgbX9qRueeQw
	 DLLahIBD6LrbYR31sWrBUqXj/OnmlqnHWMune54bySjA3fys5/l/voylpW2RgdLsmq3G3
	 VLoqw87hscEki79IguPEFmSRJTlNTsErx5ate7POMZ2N79bS1iaZCQIlQtYUJcuYlxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794358053;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=W66L99/7MAb//MBTahrFp2ltTkS2qzJVbpqkL9+FRAs=;
	b=BoXHVJTdOwHykSwCeEUvDaXwaNje3ZXfnTA7YGDKgKoJgqh+uNO/F6xte/uVpCCre4Cz
	 hOpOWyI3TBtUm1t9ydZcwwcbEbKUHquptNr824fQovrust97XJltaaFDRUXXgwu6GFCoC
	 NUvSeQesyBwgingkB6J6rp4KQWNYG3Na2J7I3Q1PN+m+HGgN4TBprIPuQngR4d/vG6Gc6
	 LQlVo//macrIdp2o77pa5mOdG24Mxzr9yqB6b2LxF3cr49IL4vudkZ4F7hglFWNuTgeny
	 3Vh+7Ud30mWXHM3oufETmpv5cnYKPt8uG6RJ9hXyHjTsOTGEh5RjbazdPtXsRyO9v+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bo9D1Sj9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E7E606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bo9D1Sj9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803531F0093D;
	Wed, 11 Nov 2026 00:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794358053;
	bh=W66L99/7MAb//MBTahrFp2ltTkS2qzJVbpqkL9+FRAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bo9D1Sj9JoDaGwh/cRlSl4IVZwP3sgP1L0JjtYTx2jfW9Z6qsPJdqXOV0xoleLVhj
	 JFjr5wI4k5IA9IK078Kd4aohgBmsFVaX/A3DcKdxIfc1pPOjYRGfTen14ik+mV/Kt7
	 JcqNHo+Ir7kaR/r45fYAX6A+e3NZnnJGyLQEBrog4aEtqrjp408KqybRXjT5smMtOJ
	 19IMfJmGSOXjJYAdVS7bXIKBivnjboh+4qeULfPaiIbYXlCIXhzTDYMV/VlEswJZn0
	 Qg+5scAY/4IwyxbxEozV3ePXFiC33QEimjAbSqqL2wlkWfzT0DtGH9aRpcZEu5Wu5F
	 Ouxg+BGgouzsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
	Xiaogang Chen <xiaogang.chen@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] drm/amdkfd: stop restore retries on device unplug
Date: Tue, 10 Nov 2026 19:47:30 -0500
Message-ID: <20261111004705.313340-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111004705.313340-1-sashal@kernel.org>
References: <20261107053959-failed-6.6-3254ed0b15f2@kernel.org>
 <20261111004705.313340-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 18 +++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c           |  8 +++++---
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index e1a4073f8865c..43b0163b796d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2689,6 +2689,7 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 	struct task_struct *usertask;
 	struct mm_struct *mm;
 	uint32_t evicted_bos;
+	int ret;
 
 	mutex_lock(&process_info->notifier_lock);
 	evicted_bos = process_info->evicted_bos;
@@ -2708,14 +2709,16 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 
 	mutex_lock(&process_info->lock);
 
-	if (update_invalid_user_pages(process_info, mm))
+	ret = update_invalid_user_pages(process_info, mm);
+	if (ret)
 		goto unlock_out;
 	/* userptr_inval_list can be empty if all evicted userptr BOs
 	 * have been freed. In that case there is nothing to validate
 	 * and we can just restart the queues.
 	 */
 	if (!list_empty(&process_info->userptr_inval_list)) {
-		if (validate_invalid_user_pages(process_info))
+		ret = validate_invalid_user_pages(process_info);
+		if (ret)
 			goto unlock_out;
 	}
 	/* Final check for concurrent evicton and atomic update. If
@@ -2724,11 +2727,14 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 	 * reference counting inside KFD will handle this case.
 	 */
 	mutex_lock(&process_info->notifier_lock);
-	if (process_info->evicted_bos != evicted_bos)
+	if (process_info->evicted_bos != evicted_bos) {
+		ret = -EAGAIN;
 		goto unlock_notifier_out;
+	}
 
 	if (confirm_valid_user_pages_locked(process_info)) {
 		WARN(1, "User pages unexpectedly invalid");
+		ret = -EINVAL;
 		goto unlock_notifier_out;
 	}
 
@@ -2746,8 +2752,10 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 unlock_out:
 	mutex_unlock(&process_info->lock);
 
-	/* If validation failed, reschedule another attempt */
-	if (evicted_bos) {
+	/* If validation failed, reschedule another attempt, unless the
+	 * device is gone for good
+	 */
+	if (evicted_bos && ret != -ENODEV) {
 		queue_delayed_work(system_freezable_wq,
 			&process_info->restore_userptr_work,
 			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 988c9da95bf54..f8d2dfcaeb6e6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1821,7 +1821,7 @@ static void svm_range_restore_work(struct work_struct *work)
 	struct mm_struct *mm;
 	int evicted_ranges;
 	int invalid;
-	int r;
+	int r = 0;
 
 	svms = container_of(dwork, struct svm_range_list, restore_work);
 	evicted_ranges = atomic_read(&svms->evicted_ranges);
@@ -1895,8 +1895,10 @@ static void svm_range_restore_work(struct work_struct *work)
 	mmap_write_unlock(mm);
 	mutex_unlock(&process_info->lock);
 
-	/* If validation failed, reschedule another attempt */
-	if (evicted_ranges) {
+	/* If validation failed, reschedule another attempt, unless the
+	 * device is gone for good
+	 */
+	if (evicted_ranges && r != -ENODEV) {
 		pr_debug("reschedule to restore svm range\n");
 		queue_delayed_work(system_freezable_wq, &svms->restore_work,
 			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
-- 
2.53.0

