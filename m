Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCD6385D6B;
	Thu, 27 Aug 2026 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787850384; cv=none; b=EKovnTLHTgkZlG9WZ4ublPzE3+Uh8MQAx9yXjrEHPwtv0qN4EpDRAfdrjMyKZlizzKJcYAAOw1KxnwRfbfUBxYiXyxl5tuhWI6kOi4ET/jxIX3RHN3kynGS/WXs+xaO/GY5SQSjPute2G3E11sRTj4AQIrWZaQ360uwDAjqipAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787850384; c=relaxed/simple;
	bh=grhNMjXscsuBDTkvaUO64cIyMjU5vdstBwr3L94tIsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvw7ipb6Tf+KN+XMnxAkSHSfHVBIFqdPVz/9DHSuU0e79ibdJEYnRmEQKS0oun1NcSIOPSgbqxRRxpN4ZmhI0Fh7R5Nse4YgFSC2kZe6fXbOvNXVCSkX1AbfkRmS0nh05xTConTPjU1uvVdtyeSSFpLcJR3Qis5d21TMXbgW1W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn; spf=pass smtp.mailfrom=whut.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whut.edu.cn
Received: from Mogu.localdomain (unknown [223.73.65.69])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4b9692dd0;
	Fri, 28 Aug 2026 01:06:17 +0800 (GMT+08:00)
From: MoGGuU <Naixumogu@whut.edu.cn>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Sidong Yang <sidong.yang@furiosa.ai>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] accel/rocket: Collect job dependencies before arming
Date: Fri, 28 Aug 2026 01:06:07 +0800
Message-ID: <20260827170608.39511-3-Naixumogu@whut.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827170608.39511-1-Naixumogu@whut.edu.cn>
References: <20260827170608.39511-1-Naixumogu@whut.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0442fca0203a1kunmddadd30e6f5a8
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQ0IaVh1KTRhDTkgfQhlIQ1YeHw
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
index 7e3d123afc5ad..51e8b43c05131 100644
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

