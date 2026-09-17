Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1754218A4;
	Thu, 17 Sep 2026 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636904; cv=none; b=OBnpQhcLMykSLLif7ZE0ZThzrTh6qAOqZ6UzTZ6uG1Xf4uj/FHS5Vct+55KR2xq1ssFnHjqRVQHedg02V1HbqsXIIgAVsphqjnLb17OrDRPuMg010kRB6UpUp8Xb7Ljxfo3S5MH6LILsDHmTBMK1Zzvc8eBeiRpPXEAqLiD32mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636904; c=relaxed/simple;
	bh=TKrUfdqbOaMPp3zQB4OFASqcVwJfuM1xemQSU6AIWLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YN0d3v7AGv6sjmu4TcYURpoZ7zzDzGte18BVTv38+jgSBKINEfjPrjTL6EK4IqvVZ16hZucqc/4G6F5AwE7ytlGPeT4+jbiLfoE9fvbmVNzHPzNuVMO+Ekj0kbmUYUzbkAsdSUsMFgVxbt/J2TtwZfKXt1/w5IlZdKt3ihT7lKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wD30TYYsatqmwAeAQ--.5918S3;
	Thu, 17 Sep 2026 17:21:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgCH1MgYsatqsnODBA--.34081S2;
	Thu, 17 Sep 2026 17:21:28 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: yuq825@gmail.com
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] drm/lima: fix use-after-free of recover work on device removal
Date: Thu, 17 Sep 2026 09:20:27 +0000
Message-Id: <20260917092027.192956-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgCH1MgYsatqsnODBA--.34081S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?VeqC8QXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI0dvn6aTENDNEmsUZkanIgm921XPgm3eaDoLwzr+9UMsFo8
	8bZphDB8iZwlN7zx3o2p9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxXry7WF4Utr15Gw4UtF13Awc_yoWrXFy7pF
	sxAa90y3yrJF43K3srZa4xZFy3twn2yayfuFW8GasI9rn0yry5K345JryUXFy5Jryxt3Wx
	tFsrK34Uur13t3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==

A recoverable GP error, reported by the GP or the GP MMU interrupt,
queues the pipe's recover_work on the system workqueue. Nothing drains
it on device removal: the worker can run after the GP task slab has
been destroyed, call drm_sched_fault() on a scheduler that
drm_sched_fini() has already torn down, or outlive the devm allocation
that embeds struct lima_device.

Free the GP and GP MMU interrupts, the only sources of recover_work,
before the GP pipe teardown, and drain the work while the task slab and
the scheduler are still alive. Stop the GP with a final reset after
drm_sched_fini(): nothing can restart the job anymore. Free the error
task list only after both schedulers are fini'd, as the timeout
handler locks it.

This issue was found by an in-house static analysis tool.

Fixes: 2081e8dcf1ee ("drm/lima: recover task by enlarging heap buffer")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/gpu/drm/lima/lima_device.c | 22 +++++++++++++++++-----
 drivers/gpu/drm/lima/lima_gp.c     |  7 +++++++
 drivers/gpu/drm/lima/lima_gp.h     |  1 +
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_device.c b/drivers/gpu/drm/lima/lima_device.c
index 0bf7105c8748..5f728230fce4 100644
--- a/drivers/gpu/drm/lima/lima_device.c
+++ b/drivers/gpu/drm/lima/lima_device.c
@@ -297,8 +297,14 @@ static void lima_fini_gp_pipe(struct lima_device *dev)
 {
 	struct lima_sched_pipe *pipe = dev->pipe + lima_pipe_gp;
 
-	lima_gp_pipe_fini(dev);
+	cancel_work_sync(&pipe->recover_work);
+
 	lima_sched_pipe_fini(pipe);
+
+	/* a recovery may have restarted the GP job */
+	lima_gp_stop(dev->ip + lima_ip_gp);
+
+	lima_gp_pipe_fini(dev);
 }
 
 static int lima_init_pp_pipe(struct lima_device *dev)
@@ -442,17 +448,23 @@ void lima_device_fini(struct lima_device *ldev)
 	int i;
 	struct lima_sched_error_task *et, *tmp;
 
+	lima_fini_pp_pipe(ldev);
+
+	/* free the IRQ sources of recover_work before the GP pipe drain */
+	lima_fini_ip(ldev, lima_ip_gp);
+	lima_fini_ip(ldev, lima_ip_gpmmu);
+	lima_fini_gp_pipe(ldev);
+
+	/* the timeout handlers lock it: free after both schedulers */
 	list_for_each_entry_safe(et, tmp, &ldev->error_task_list, list) {
 		list_del(&et->list);
 		kvfree(et);
 	}
 	mutex_destroy(&ldev->error_task_list_lock);
 
-	lima_fini_pp_pipe(ldev);
-	lima_fini_gp_pipe(ldev);
-
 	for (i = lima_ip_num - 1; i >= 0; i--)
-		lima_fini_ip(ldev, i);
+		if (i != lima_ip_gp && i != lima_ip_gpmmu)
+			lima_fini_ip(ldev, i);
 
 	if (ldev->dlbu_cpu)
 		dma_free_wc(ldev->dev, LIMA_PAGE_SIZE,
diff --git a/drivers/gpu/drm/lima/lima_gp.c b/drivers/gpu/drm/lima/lima_gp.c
index 3282997a0358..7287af7829f8 100644
--- a/drivers/gpu/drm/lima/lima_gp.c
+++ b/drivers/gpu/drm/lima/lima_gp.c
@@ -350,6 +350,13 @@ void lima_gp_fini(struct lima_ip *ip)
 	devm_free_irq(dev->dev, ip->irq, ip);
 }
 
+/* keep the irq masked: hard_reset() re-enables it */
+void lima_gp_stop(struct lima_ip *ip)
+{
+	lima_gp_hard_reset(ip);
+	gp_write(LIMA_GP_INT_MASK, 0);
+}
+
 int lima_gp_pipe_init(struct lima_device *dev)
 {
 	int frame_size = sizeof(struct drm_lima_gp_frame);
diff --git a/drivers/gpu/drm/lima/lima_gp.h b/drivers/gpu/drm/lima/lima_gp.h
index 02ec9af78a51..c2a1e54ea567 100644
--- a/drivers/gpu/drm/lima/lima_gp.h
+++ b/drivers/gpu/drm/lima/lima_gp.h
@@ -11,6 +11,7 @@ int lima_gp_resume(struct lima_ip *ip);
 void lima_gp_suspend(struct lima_ip *ip);
 int lima_gp_init(struct lima_ip *ip);
 void lima_gp_fini(struct lima_ip *ip);
+void lima_gp_stop(struct lima_ip *ip);
 
 int lima_gp_pipe_init(struct lima_device *dev);
 void lima_gp_pipe_fini(struct lima_device *dev);

