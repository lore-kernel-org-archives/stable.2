Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C9038DC65;
	Fri, 28 Aug 2026 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787893709; cv=none; b=ha7kHss6+ZU6TbGbEyevty8GMslPxYacHn3gHJ8iZnnnHiPDZPTGvNcuv3qFwuAPtwx7CS1axnP8DPj/7baxUQEi5vW3AhyGaUwF5/rhWcSGP6sZwxUEOsKgqUawrzcsve4GmwZx20zTKcJmjcHyi40hh1bNASkyGi371l6mKEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787893709; c=relaxed/simple;
	bh=2oeiR7BUymHocFrGjsFW8hZN9wopW0mVnjdDPX+1IQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIU1JHQ7K+73a5elbbdKKdf/jEao477WF5sA3V2n+vxWbR0PwR3ihan025Z1S/nhQYhmbIMjJl1jo1ZGjb1CO/DOWztZJK5RsynfFoagFJWpuHVH53lwke+2jSHEJn89T7C9yMl5ULJ1t5ewDEzWPc5EE08HGBp08cD5hGOBIG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn; spf=pass smtp.mailfrom=whut.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whut.edu.cn
Received: from Mogu.localdomain (unknown [223.73.65.69])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4ba72fe22;
	Fri, 28 Aug 2026 13:08:22 +0800 (GMT+08:00)
From: MoGGuU <Naixumogu@whut.edu.cn>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Sidong Yang <sidong.yang@furiosa.ai>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 2/3] accel/rocket: Collect job dependencies before arming
Date: Fri, 28 Aug 2026 13:08:04 +0800
Message-ID: <20260828050805.38548-3-Naixumogu@whut.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828050805.38548-1-Naixumogu@whut.edu.cn>
References: <20260828050805.38548-1-Naixumogu@whut.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa046c4de0603a1kunma5b495348836d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHxhLVktPGkIYSUsfSE9MSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVTEhVTU5VTUJZV1kWGg8SFR0UWUFZS1VLVUtVS1kG

rocket_job_push() arms the scheduler job before collecting its implicit
dependencies. Dependency collection can fail with -ENOMEM, but an armed
job must be pushed and must not be aborted with drm_sched_job_cleanup().

Collect dependencies before taking the scheduler lock and arming the job.
Only operations that cannot fail remain after drm_sched_job_arm().

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Cc: stable@vger.kernel.org
Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
Signed-off-by: MoGGuU <Naixumogu@whut.edu.cn>
---
 drivers/accel/rocket/rocket_job.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index e6052d1973afa..b55e12aecfe64 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -206,19 +206,21 @@ static int rocket_job_push(struct rocket_job *job)
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
 
 		job->inference_done_fence = dma_fence_get(&job->base.s_fence->finished);
 
-		ret = rocket_acquire_object_fences(job->in_bos, job->in_bo_count, &job->base, false);
-		if (ret)
-			goto err_unlock;
-
-		ret = rocket_acquire_object_fences(job->out_bos, job->out_bo_count, &job->base, true);
-		if (ret)
-			goto err_unlock;
-
 		kref_get(&job->refcount); /* put by scheduler job completion */
 
 		drm_sched_entity_push_job(&job->base);
-- 
2.43.0

