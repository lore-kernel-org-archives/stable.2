Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE4540682C;
	Tue, 15 Sep 2026 04:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789445484; cv=none; b=Al494qaly3ak10VKYhpeemIYLKV/SiTGotgMLiD2DEUrquGuLI9fk8/KXHimQklOFBtn7K67+9T+o4KOl4S4X/lBhFDR+Jxp/D8+ez9ro8zsCkDLlxw3Xe4H5oy4qLGTuTOAeMLLjIA8jaPJEGyrrXkpPFIDY67xqWRFYkEBbJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789445484; c=relaxed/simple;
	bh=S7J8qiruJw0j9ntmICQRqDKX6zY/1QCG66QhT9ttpuc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rDMmvjHIWRRvyhr3WSrUjwhpvH79Xvb3NjFYy5eampSsDsJFCx8u8o3AJw4Tb1UbQccZAeHE0IT80z8jJK/L757hymHD7/0xonE1NHogAV41je7k8JyWuvOsGFlw4d4jfm7fpHR5F8UaNgGIQc9xYB34lEj6ZiYkEBeCm0/8Big=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAD3y+9kxahquy0ICA--.49844S2;
	Tue, 15 Sep 2026 12:11:16 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: dri-devel@lists.freedesktop.org
Cc: jeff.hugo@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	ogabbay@kernel.org,
	tomeu@tomeuvizoso.net,
	lkml@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] accel/rocket: fix runtime PM refcount leak in rocket_job_run()
Date: Tue, 15 Sep 2026 04:10:47 +0000
Message-Id: <20260915041047.1724928-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAD3y+9kxahquy0ICA--.49844S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF47tryUWr1UtrWDWF18Grg_yoW8Ar13pF
	WSgFW7tr9Ig3yFgrWvvr4YqFyrK3savry8Wry8Xa45ZFs3Ga4rta1rtryaqF10yFZ7GF45
	trnrKa13ZFyayFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUFOzVUU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwMLA2qowpAK0wABsE

rocket_job_run() powers the NPU core up with pm_runtime_get_sync(),
which increments the runtime PM usage counter even when it fails, and
then returns the fence without dropping the reference on both the
pm_runtime_get_sync() and the iommu_attach_group() failure paths.

At that point core->in_flight_job is still unset, so neither
rocket_job_handle_irq() nor rocket_reset() will balance the counter
later, and the core can never runtime suspend again.

Use pm_runtime_resume_and_get() instead, which does not bump the usage
counter on failure, and drop the reference with
pm_runtime_put_autosuspend() if iommu_attach_group() fails.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/accel/rocket/rocket_job.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index ac51bff39833..ce7acf728367 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -310,13 +310,15 @@ static struct dma_fence *rocket_job_run(struct drm_sched_job *sched_job)
 		dma_fence_put(job->done_fence);
 	job->done_fence = dma_fence_get(fence);
 
-	ret = pm_runtime_get_sync(core->dev);
+	ret = pm_runtime_resume_and_get(core->dev);
 	if (ret < 0)
 		return fence;
 
 	ret = iommu_attach_group(job->domain->domain, core->iommu_group);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(core->dev);
 		return fence;
+	}
 
 	scoped_guard(mutex, &core->job_lock) {
 		core->in_flight_job = job;
-- 
2.34.1

