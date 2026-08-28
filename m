Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E353CC9F2;
	Fri, 28 Aug 2026 06:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787899331; cv=none; b=cFV22eMKVfqpDxf+gAhoDGlO7R91noM3jg5xEzEuKX5yDR0RBw2bn0M38dTytGlftSXQmjOk9wNjNR/QYIoDw8fp7y0AQKyv8Bb9t92ePW5dkUQ/8SxmCOwwiE4djGzjBPozKN6Kdy4EVudFr9OlFaftYpLGBmZ6s2tRUkuOctM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787899331; c=relaxed/simple;
	bh=Ma0n0LLajuwqcX2u4vBvkkqmcwmsAHbP8K0mAAiq4m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oL6e6PxpvO7YWAsQkEnEoB7Dhy75zTnZxNdOYSHr71BBlZs9U1kBlFj1fRyB7R0o6CwzTy+1lxpqRl5QOB6PFCvg40yzXihXu2PwCzQqvzTfARvu0SMgFSB3FXRbR33tCHLQbUiqcOZtWrkW3ahju3/G9S0XBkF24X0dXVLYy9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn; spf=pass smtp.mailfrom=whut.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whut.edu.cn
Received: from Mogu.localdomain (unknown [223.73.65.69])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4baa740d7;
	Fri, 28 Aug 2026 14:42:05 +0800 (GMT+08:00)
From: Haoming Gao <Naixumogu@whut.edu.cn>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Sidong Yang <sidong.yang@furiosa.ai>,
	Greg KH <greg@kroah.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5 1/3] accel/rocket: Validate BO handle counts on job submission
Date: Fri, 28 Aug 2026 14:41:50 +0800
Message-ID: <20260828064152.37822-2-Naixumogu@whut.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828064152.37822-1-Naixumogu@whut.edu.cn>
References: <20260828064152.37822-1-Naixumogu@whut.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0471aabdd03a1kunmd9ea7a958c2ac
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSkMZVkxITB8aSRkZQxgZQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVTEhVTU5VTUJZV1kWGg8SFR0UWUFZS1VLVUtVS1kG

The input and output BO handle counts are __u32, while GEM lookup and
reservation helpers take int counts. A count above INT_MAX cannot be
represented safely by the GEM lookup helper.

Reject each count above INT_MAX before looking up the BOs.

rocket_job_push() already uses check_add_overflow() for the combined count,
but stores the result in u32, so it only detects unsigned wraparound. Store
the result in int so sums above INT_MAX are rejected before the count is
passed to the reservation helpers.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Cc: stable@vger.kernel.org
Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
Reviewed-by: Sidong Yang <sidong.yang@furiosa.ai>
Signed-off-by: Haoming Gao <Naixumogu@whut.edu.cn>
---
 drivers/accel/rocket/rocket_job.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index bb77b6bf0f231..e6052d1973afa 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -190,7 +190,7 @@ static int rocket_job_push(struct rocket_job *job)
 	struct rocket_device *rdev = job->rdev;
 	struct drm_gem_object **bos;
 	struct ww_acquire_ctx acquire_ctx;
-	u32 bo_count;
+	int bo_count;
 	int ret = 0;
 
 	if (check_add_overflow(job->in_bo_count, job->out_bo_count, &bo_count))
@@ -556,6 +556,11 @@ static int rocket_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
 	if (job->task_count == 0)
 		return -EINVAL;
 
+	/* GEM lookup takes a signed object count. */
+	if (job->in_bo_handle_count > INT_MAX ||
+	    job->out_bo_handle_count > INT_MAX)
+		return -EINVAL;
+
 	rjob = kzalloc_obj(*rjob);
 	if (!rjob)
 		return -ENOMEM;
-- 
2.43.0

