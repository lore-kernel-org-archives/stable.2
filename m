Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050995;
	b=GlD1omJ+KrNkIxoWAd/AJo9jZ/ad/jNUm/grfQaXSY1N58SrXisVw0uBfKy0dH0jidxx
	 xeTKIXn+szKBcM7YJGQxZOBzot5nLIvscXHSL9Ux+J8PEMQo81zvoN6QmTITksAA2asZ/
	 8rXqUaRkaBgKc4t6ZTBgy73TKx0BbZZmpThxCfAt5dNv352DmV2+9noX3hBuFwxv+Gect
	 q/bse6MxOESe1D9oN7G7hs4xXHWhm46m8LS4vhbPSyoM46Q6oB7oNpXMiGV0liyleiWhw
	 GS2CzbjNIrTHc0pNB5HjOoUaaqitN5mR5dAabQvpPs39PGZqW3WQy62Ozn2xIkfnbPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050995;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZRs8KKclIFtm6tqUrj4DvjP0dG97ixsXPfzYm2JqaH8=;
	b=k+HYi3xBGkDg78kGDoHeElHbhIb0r9Vt3HmtCFVD/3X+1WvmQVqageDkcceKHJhGfRDF
	 mlEHux9XB1udXr3OYrGUn6vuI6TsUHAJ2YktXwVJaCm9NZDnAj8DE1+V4SHsjyDZZBYDs
	 hcYHOjhLfU4wKIY3rxp+qtNSDC5+hjv8UThF9K+t42JXIFUqRJeAz3eZnPP7uGBmAkBlh
	 PORIUF8AX6JEWmEMSt34IfVNixNoP8JxD8J0EKT1Ow+2fe4vQbqQNFhDjotoi1G3exjl9
	 V/P9e3l9uWfCQwwST4LGazd2H8/SA1r/TQ+j8Y4VnWIfoFKGCUsNmz1ye2ODBTiDn5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WaCfy3Gc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670E9606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WaCfy3Gc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EB91F0089F;
	Sat,  7 Nov 2026 11:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050995;
	bh=ZRs8KKclIFtm6tqUrj4DvjP0dG97ixsXPfzYm2JqaH8=;
	h=From:To:Cc:Subject:Date;
	b=WaCfy3Gc0+9ItV6Oll947NB9zzgxip9B37aECwUKNYr9PFNtY/+GGzCidBciUnvXj
	 KzrFMCb5+rakeF0sfPoZzsTt0dxJaqwFZ5JwdpDGeof1PbyuXoJxzPUs24y9z476Yz
	 9O6oQ4PnYsVpBrBxXtlaRrX3l98z1fD+xSimRAmMJ8Vz/TEzXC5mVIAjsXPnQP6W0c
	 XZkuVqy0fapxi2HnxOrGLrtKk5KmxHgPf/iPZ3H5RkZOVL+d5FmvKTIlL1+2gltdig
	 2jIRU1OF0jGCgSXSXZySVrrIwOrU9V3/s1u4hGZEccspCMxZxjrco9PXpX40QQ1Shk
	 lZx7pgWnFrTTg==
From: Sasha Levin <sashal@kernel.org>
To: olivier.kaloudoff@gmail.com,
	xiaogang.chen@amd.com,
	felix.kuehling@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdkfd: stop restore retries on device unplug" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:29:53 -0500
Message-ID: <20261107062953-failed-5.10-3254ed0b15f2@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 3254ed0b15f2fe656c9cb36ccb59b92422440bf8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062953-failed-5.10-3254ed0b15f2@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 3254ed0b15f2fe656c9cb36ccb59b92422440bf8 Mon Sep 17 00:00:00 2001
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Date: Tue, 13 Oct 2026 20:53:12 +0200
Subject: [PATCH] drm/amdkfd: stop restore retries on device unplug

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
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 18 +++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c           |  8 +++++---
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index ff77e8ae9fe6f..3a4b3424b5b29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2854,6 +2854,7 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 	struct task_struct *usertask;
 	struct mm_struct *mm;
 	uint32_t evicted_bos;
+	int ret;
 
 	mutex_lock(&process_info->notifier_lock);
 	evicted_bos = process_info->evicted_bos;
@@ -2873,14 +2874,16 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 
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
@@ -2889,11 +2892,14 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
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
 
@@ -2911,8 +2917,10 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
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
index 1f5d73f0ebce3..a4ce54b06975b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1963,7 +1963,7 @@ static void svm_range_restore_work(struct work_struct *work)
 	struct mm_struct *mm;
 	int evicted_ranges;
 	int invalid;
-	int r;
+	int r = 0;
 
 	svms = container_of(dwork, struct svm_range_list, restore_work);
 	evicted_ranges = atomic_read(&svms->evicted_ranges);
@@ -2037,8 +2037,10 @@ static void svm_range_restore_work(struct work_struct *work)
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




