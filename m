Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31C53DD505;
	Thu, 25 Jun 2026 11:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782387958; cv=none; b=c9QGwpOIKeg4bhSm/wLv0PUcJu2B8nr0odL9xC8YuRAdnKc6T1sh86F+V2kkvSG2opsxuGvoqqAtdvimPNfJ+SpDWMZMxuUeSy2oy0365NV+pAU6VdunrBqgJOfVquUw5pe1PO8fWYGG1FDbofuD9J4U3gE0k+6rUl+KFvVBfeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782387958; c=relaxed/simple;
	bh=pwQshbRYceQ8XyloeoHFmKrmRx+S/ubRuGKHrG5BZQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HTAoQbin2ZEBYoCiis5JHxVrAi9orbw4GOsOL+y/LhvZ+fZdzFRPtdA5IKoZ1nDi+GA+3VAMZAN+nKmvCNbRK/eTMT/6kPWvsTXSJM5Wp8Us8iR1pdZ9DpjhSxMNCUtUsf2FyXXzA0RXuvdXbBf+8dteFlH08+irjBxMB+c0JP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-05 (Coremail) with SMTP id zQCowAAnoPPtFD1qrYw0FQ--.21749S2;
	Thu, 25 Jun 2026 19:45:50 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: robh@kernel.org,
	tomeu@tomeuvizoso.net,
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] accel/ethosu: Fix use-after-free and memory leak in ioctl_submit_job
Date: Thu, 25 Jun 2026 19:45:47 +0800
Message-Id: <20260625114547.50649-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAnoPPtFD1qrYw0FQ--.21749S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1fZw43AF4xXw17KryUWrg_yoW8ZF43pa
	1rW3yjgrZ8Xa10gayDAw4jgF15Ka12gryIkr4kuw4avFn5Xr12qa1rCr92qFy8ZrZ7t3Wx
	XFW2kw1rWa4rAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU18sqtUUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgoJA2o835HLRQAAsQ

Two bugs exist in ethosu_ioctl_submit_job():

1. Use-after-free via NULL pointer dereference: When done_fence
   allocation fails, the error path jumps to out_cleanup_job which calls
   drm_sched_job_cleanup() on an uninitialized struct, dereferencing the
   NULL s_fence pointer.

2. Memory leak of done_fence: The done_fence struct is allocated
   separately with kzalloc() but is never freed on any error path that
   occurs after successful allocation (including drm_sched_job_init
   failure, BO lookup failures, etc.). It cannot be freed via
   dma_fence_put() because dma_fence_init() is not called until
   ethosu_job_run().

Fix by:
- Changing the done_fence allocation failure goto target from
  out_cleanup_job to out_put_job, which skips the uninitialized
  drm_sched_job_cleanup() call.
- Adding kfree(job->done_fence) in ethosu_job_err_cleanup() to ensure
  the separately allocated fence struct is released on all error paths.

Cc: stable@vger.kernel.org
Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/accel/ethosu/ethosu_job.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
index ec85f4156744..9a8164a54454 100644
--- a/drivers/accel/ethosu/ethosu_job.c
+++ b/drivers/accel/ethosu/ethosu_job.c
@@ -150,6 +150,7 @@ static void ethosu_job_err_cleanup(struct ethosu_job *job)
 	for (i = 0; i < job->region_cnt; i++)
 		drm_gem_object_put(job->region_bo[i]);
 
+	kfree(job->done_fence);
 	drm_gem_object_put(job->cmd_bo);
 
 	kfree(job);
@@ -393,7 +394,7 @@ static int ethosu_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
 	ejob->done_fence = kzalloc_obj(*ejob->done_fence);
 	if (!ejob->done_fence) {
 		ret = -ENOMEM;
-		goto out_cleanup_job;
+		goto out_put_job;
 	}
 
 	ret = drm_sched_job_init(&ejob->base,
-- 
2.39.5 (Apple Git-154)

