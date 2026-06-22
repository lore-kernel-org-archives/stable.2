Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344733B83E8;
	Mon, 22 Jun 2026 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138194; cv=none; b=nGeCBLnsD6iIXUSK1KtkXnxO0Cxdfri0giaWvHOEck5NLyesmDQMpMKSqwKXqutneThf1jTUeM/VEiSeRtrXpaix9qVLaw67TruyWu9PwSAURn3fURCDpGAEEqyZlUW4/8T9qlHHoBNKpFDIS0nihDI8+6QQXrjAE9EGj6x+E1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138194; c=relaxed/simple;
	bh=BtuQLNyZP6x6ikfOGEXdOiNZkBkKvBxiAtxJKrhZDmc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZB7G2sCyywO4UUqLstD/SFMzgMdn8B1IeF/cFq8QpgmOUpsOFqCs8fqEoq1oI+yEQPcUoU9PC5HHAo15Y8TQ02U5yG8NmHjWHUgxxQkRA4h1uyjbbek8F+Q4jJH3/9InPrpIxbzterV4zjj8NrOTtBI6PZVHDe1ZsXK8NA/zWQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.74.238])
	by APP-01 (Coremail) with SMTP id qwCowADHa9RMRTlqc07AAg--.26720S2;
	Mon, 22 Jun 2026 22:23:10 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/amdgpu: fix cleaner shader IB size and entity cleanup
Date: Mon, 22 Jun 2026 22:23:05 +0800
Message-Id: <20260622142305.45791-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADHa9RMRTlqc07AAg--.26720S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur1fJFW3WF43ZrWfJr15XFb_yoW5Wr18pF
	4Fqr45Jr4UZ3W3Kw1UZ3WDWrn0q3s7Xa4fWr429w109an8XFn5Wa47GFy0grykurW8CFW2
	g34qq3y7W3ZFyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYGA2o5ItJfpgABsU

Fix two issues in amdgpu_gfx_run_cleaner_shader_job():

1. IB buffer overflow: The indirect buffer is hardcoded to 64 bytes,
   but the initialization loop writes up to (align_mask + 1) dwords.
   On modern GFX rings with align_mask = 0xff, this writes 1024 bytes,
   overflowing the 64-byte allocation and corrupting memory.

2. Scheduler entity leak: The drm_sched_entity is not cleaned up on
   the error path after amdgpu_job_alloc_with_ib() fails.

Fix by:
- Dynamically calculating IB size based on ring->funcs->align_mask
- Adding drm_sched_entity_destroy() to the error path

Cc: stable@vger.kernel.org
Fixes: d361ad5d2fc0 ("drm/amdgpu: Add sysfs interface for running cleaner shader")
Fixes: 256576ed6895 ("drm/amdgpu: give each kernel job a unique id")
Fixes: 559a285816af ("drm/amdgpu: Replace 'amdgpu_job_submit_direct' with 'drm_sched_entity' in cleaner shader")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b8ca876694ff..b50ec1a5c645 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1651,6 +1651,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	void *owner;
+	unsigned int ib_size;
 	int i, r;
 
 	/* Initialize the scheduler entity */
@@ -1658,7 +1659,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 				  &sched, 1, NULL);
 	if (r) {
 		dev_err(adev->dev, "Failed setting up GFX kernel entity.\n");
-		goto err;
+		return r;
 	}
 
 	/*
@@ -1668,8 +1669,15 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	 */
 	owner = (void *)(unsigned long)atomic_inc_return(&counter);
 
+	/*
+	 * Allocate IB with enough space for align_mask + 1 dwords.
+	 * The initialization loop below writes exactly this many dwords.
+	 * Each dword is 4 bytes.
+	 */
+	ib_size = (ring->funcs->align_mask + 1) * sizeof(uint32_t);
+
 	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
-				     64, 0, &job,
+				     ib_size, 0, &job,
 				     AMDGPU_KERNEL_JOB_ID_CLEANER_SHADER);
 	if (r)
 		goto err;
@@ -1686,8 +1694,6 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	f = amdgpu_job_submit(job);
 
 	r = dma_fence_wait(f, false);
-	if (r)
-		goto err;
 
 	dma_fence_put(f);
 
@@ -1696,6 +1702,8 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	return 0;
 
 err:
+	/* Clean up the scheduler entity */
+	drm_sched_entity_destroy(&entity);
 	return r;
 }
 
-- 
2.39.5 (Apple Git-154)

