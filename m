Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048957;
	b=SlAM3lEOOUDa712jO08KQN+T7i4+lKI2H93pHzqa1XrzRxNZI6JqhMxILc5CmI3QW5l4
	 Nw8sNpzR5UT+C8cSAe/fGpTrK7kWLZJDLj5LQdOE0QH+4XcfrfyfzFbUpyDt+6ji/Ofdj
	 xa8ae7mhGwmQ3z2tbYCl23l4zppZ5wX1OVuFpXuVizJgdFocvtyWZGpAJ90WPFdr90r0U
	 3uAhxUL/E3sQGRnK6w5dL8ismMRHDgzdGf08OWlKbnQ1jQD5AkU8sFuYLj3Esu9pNDQ5z
	 2F3lUImaCb0nFCpKbxoolo9V/shhDgOjqdr1o/qPZuWHmSarYosC8/YEeqOyY/b+E2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048957;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=flOtRqnC8Y0hWkg6qrTMNmPgSYApzQMaS2cNcMS/4tw=;
	b=2mrfTrzb0E3zGvZ2PXowzT7lmC5vMPZ5P1LcWmdSeMs+fQuvgS+g00BURVDoj00g07My
	 eb4nSYGhZgzFovIVjx/IhAPTY4zj4WB1gVA7tfuZeavf5rF1EQexuw3NcaEo87zWFzTVd
	 WYduEtwxyqolHF6P8cYiK1BbhldVAp1BbllNiEjZ+TmTlbAFW4IDCDgfVt+vMgmZgmjBl
	 yoAA3piB1wSBK6S9TScL/GBBoqouhPFHMdm1oHUfwmBbxpvr9gbxOd+xjjLUeUhc3rQe2
	 O5l8AaQ6DWXCFzRfP/c7KNC8wcERM1VSU7tAnlHBJj4AkGchlEi98k7VqmWmy/C1+Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Q97/DF5E";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C310F606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q97/DF5E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194F71F008A1;
	Sat,  7 Nov 2026 10:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048956;
	bh=flOtRqnC8Y0hWkg6qrTMNmPgSYApzQMaS2cNcMS/4tw=;
	h=From:To:Cc:Subject:Date;
	b=Q97/DF5EK9539MhsrLyC4f7ZfiByI1OwiG3G3Y+eTjrGOm+5YSk0+NCIYwVg5QMdr
	 J/oNtIwg0T41KEaFZ4aHjQa5rq1kLGAGWgZFZXoroz0TiQJN1UxsIGoO6VlcXDhSah
	 PzIqNeVfOAfHOzjs+/tZtN5zNHjTLzDY9ItREZZsyJIhB3BjznZxvEmZvDCow8BaBu
	 /MDhRgxvl4KI3/9VjF0rhvm4xSj6gpRsA9TR2gvknaQNgXex3HaYfFzuSA2L1slZD7
	 +N6v7lkC0fVVZP/+m/VviVSixX776PvI70B7WAe0ATLg0OtIrtv3Jx5XMfPeHgU2d9
	 r1QkWVbF9LarQ==
From: Sasha Levin <sashal@kernel.org>
To: olivier.kaloudoff@gmail.com,
	xiaogang.chen@amd.com,
	felix.kuehling@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdkfd: stop restore retries on device unplug" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:55:54 -0500
Message-ID: <20261107055554-failed-6.1-3254ed0b15f2@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3254ed0b15f2fe656c9cb36ccb59b92422440bf8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055554-failed-6.1-3254ed0b15f2@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




