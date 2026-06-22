Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4C5370D47;
	Mon, 22 Jun 2026 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142551; cv=none; b=FPAc9ktubFhERSHNW2SV+Y5nu1jhT6GkzsnkJKpWsMSLTPSKlD88MOw0Jne5fFNxmWJ2NxYGv/8bpfYF3cwBvkTkUU4nwDAQEyErcI/LBYBu91/VMGGbkQh23/QyVqS4eIikTsZoWlv9y3Rk7v6kGO9Doo/nsYvKl2JoonH+yuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142551; c=relaxed/simple;
	bh=eFMmrwvzbdxP0BwngNN9xMq4UHWzKar3WK/CDwLTjyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SmwW+GxV7WL2RWoy15dUDEAiFWkJa8/JiRRVrojHQ11At+7zBRe8RUWn3hqoZdOS5LtmR5rjDu5fYmHfjyaO3HAmQRp8X/znqCH56N9rLa8ua4DJlaksUcYqet2WDtgz2MJsOPC9duYf7QtLLWpHbg9Zk1RvivXIVkvpWSFIUjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.74.238])
	by APP-01 (Coremail) with SMTP id qwCowADXb8hRVjlqMdHBAg--.32501S2;
	Mon, 22 Jun 2026 23:35:47 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] drm/amdgpu: fix scheduler entity leak in cleaner shader job
Date: Mon, 22 Jun 2026 23:35:43 +0800
Message-Id: <20260622153543.50169-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADXb8hRVjlqMdHBAg--.32501S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AryfJr1rJry8ZFWDWF48WFg_yoW8WF4rpF
	sYgryUtr18Za17K3yUAF1kXF98Ka4fXa48Wr1I9w1F93Z8JFn5JF15JFy0qrykurWkCa17
	Kryqq3y7X3ZIvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUf8nOUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAUGA2o5T2kPrAAAsa

In amdgpu_gfx_run_cleaner_shader_job(), if amdgpu_job_alloc_with_ib()
fails, the function returns without destroying the scheduler entity,
causing a resource leak.

Fix this by adding drm_sched_entity_destroy() to the error path.

Also remove the unnecessary error check for dma_fence_wait() since
it never fails with intr=false and infinite timeout.

Cc: stable@vger.kernel.org
Fixes: 559a285816af ("drm/amdgpu: Replace 'amdgpu_job_submit_direct' with 'drm_sched_entity' in cleaner shader")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b8ca876694ff..523b681d0da9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1658,7 +1658,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 				  &sched, 1, NULL);
 	if (r) {
 		dev_err(adev->dev, "Failed setting up GFX kernel entity.\n");
-		goto err;
+		return r;
 	}
 
 	/*
@@ -1685,9 +1685,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 
 	f = amdgpu_job_submit(job);
 
-	r = dma_fence_wait(f, false);
-	if (r)
-		goto err;
+	dma_fence_wait(f, false);
 
 	dma_fence_put(f);
 
@@ -1696,6 +1694,8 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	return 0;
 
 err:
+	/* Clean up the scheduler entity */
+	drm_sched_entity_destroy(&entity);
 	return r;
 }
 
-- 
2.39.5 (Apple Git-154)

