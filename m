Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163903161A1;
	Thu, 13 Aug 2026 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630881; cv=none; b=kfAlf/qPCYYMJo/rY4b3mHF+S7OSER4j9sl/m3psfgu3VyYOfuRdGr49ZZTlv7+GIE6tVmcaiTTJHcPvtvcjFIv3hMeYfT8OdQw9/u3CXR72/c0Vd0Be9T6ns2OlSxURg89UVQP6ZukWELhVidka2AIlEwfhrAIMY0KsrsdF7e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630881; c=relaxed/simple;
	bh=Bb8hhDEq3stlr7cGSyGhNCzQjZJ78qa01xeCWPofUDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DescXpRX2f5oVWthIO1kd6Ze6JDRdwnm5EYs7pwhcPh22qIHKbGnsBXv33OjtpY1zsDH7eJrD3TEtB+frTtpTZ0lh7+cE8KPlHNaV9qGkK9aMKzXmqRiOoMSiyOJ7ABS8gprvVMZCcvBFSNXyq9k7gaLloYrzpzNdOEWQGoXe08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn; spf=pass smtp.mailfrom=whut.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whut.edu.cn
Received: from Mogu.localdomain (unknown [223.73.65.85])
	by smtp.qiye.163.com (Hmail) with ESMTP id 49e36c71e;
	Thu, 13 Aug 2026 22:21:03 +0800 (GMT+08:00)
From: MoGGuU <Naixumogu@whut.edu.cn>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Naixumogu@whut.edu.cn
Subject: [PATCH] accel/rocket: Fix job submit error handling
Date: Thu, 13 Aug 2026 22:20:59 +0800
Message-ID: <20260813142059.151644-1-Naixumogu@whut.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ffb7f7b4a03a1kunm0ebce40633f04
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGUhNVkMYQklOSx9LS0xJQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVTEhVTU5VQ05ZV1kWGg8SFR0UWUFZS1VLVUtVS1kG

Several error paths in the job submission path can be triggered by
unprivileged userspace through malformed DRM_ROCKET_SUBMIT requests.

First, the input and output BO handle counts are __u32, but GEM lookup and
reservation helpers take int counts.  Values outside the signed range can
become negative.  A combined count above INT_MAX can also overflow at the
call sites.  Reject counts that cannot be represented safely before looking
up the BOs.

Second, rocket_job_push() arms the scheduler job before collecting its
implicit dependencies.  Dependency collection can fail with -ENOMEM, but
drm_sched_job_arm() is a point of no return.  An armed job must be pushed;
it must not be aborted with drm_sched_job_cleanup().  Collect dependencies
before taking the scheduler lock and arming the job.  Only operations that
cannot fail remain after arm().

Finally, rocket_ioctl_submit() discards each job's return value and reports
success even when every job fails.  Return the first error
and stop submitting the remaining jobs.  Jobs queued before an error remain
queued, giving the ioctl ordered partial-submit semantics.

Tested on RK3588 with zero task counts, invalid task pointers, invalid BO
handles, and oversized BO counts.  The requests returned the expected error
codes without warnings or errors in the kernel log.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Cc: stable@vger.kernel.org
Signed-off-by: MoGGuU <Naixumogu@whut.edu.cn>
---
 drivers/accel/rocket/rocket_job.c | 34 +++++++++++++++++++------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index bb77b6bf0..c42bbf486 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -206,21 +206,20 @@ static int rocket_job_push(struct rocket_job *job)
 	if (ret)
 		goto err;
 
+	ret = rocket_acquire_object_fences(job->in_bos, job->in_bo_count,
+					   &job->base, false);
+	if (ret)
+		goto err_unlock;
+
+	ret = rocket_acquire_object_fences(job->out_bos, job->out_bo_count,
+					   &job->base, true);
+	if (ret)
+		goto err_unlock;
+
 	scoped_guard(mutex, &rdev->sched_lock) {
 		drm_sched_job_arm(&job->base);
-
 		job->inference_done_fence = dma_fence_get(&job->base.s_fence->finished);
-
-		ret = rocket_acquire_object_fences(job->in_bos, job->in_bo_count, &job->base, false);
-		if (ret)
-			goto err_unlock;
-
-		ret = rocket_acquire_object_fences(job->out_bos, job->out_bo_count, &job->base, true);
-		if (ret)
-			goto err_unlock;
-
 		kref_get(&job->refcount); /* put by scheduler job completion */
-
 		drm_sched_entity_push_job(&job->base);
 	}
 
@@ -556,6 +555,12 @@ static int rocket_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
 	if (job->task_count == 0)
 		return -EINVAL;
 
+	/* GEM lookup and reservation helpers take signed object counts. */
+	if (job->in_bo_handle_count > INT_MAX ||
+	    job->out_bo_handle_count > INT_MAX ||
+	    job->in_bo_handle_count > INT_MAX - job->out_bo_handle_count)
+		return -EINVAL;
+
 	rjob = kzalloc_obj(*rjob);
 	if (!rjob)
 		return -ENOMEM;
@@ -639,8 +644,11 @@ int rocket_ioctl_submit(struct drm_device *dev, void *data, struct drm_file *fil
 	}
 
 
-	for (i = 0; i < args->job_count; i++)
-		rocket_ioctl_submit_job(dev, file, &jobs[i]);
+	for (i = 0; i < args->job_count; i++) {
+		ret = rocket_ioctl_submit_job(dev, file, &jobs[i]);
+		if (ret)
+			goto exit;
+	}
 
 exit:
 	kvfree(jobs);

base-commit: d85a5e9dfb42449d9f37b0ddc6ec30b129f481ce
-- 
2.43.0

