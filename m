Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DC139F184;
	Wed, 16 Sep 2026 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573843; cv=none; b=pPRRfGzqxXFXevxDGGfNz5c3L/OE1+4L9mZl+Wg5hyzxvw25CnQ60wM9dH1AjItJr6+G1RFcnoT+uWar4kQVlkcRnHWyIRljzm4LJsadLAuM7vXLgBAJuYQavhGVK7w+f7NewLOUeynvgJt/ehOszduh7A9hCspcq4J4EL4YH3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573843; c=relaxed/simple;
	bh=jCGP939IZtbxCKBVN1WZunNKbEuXeppACIPZex0umX4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y+X507+HSJGz/m7puF1WHTW0Y7CGAxH+JF8tfBQhYO1FI1QYoipNEJMx9KUI9JTJPW+DqhWNvR8W3oJ5WkV83ZBClAYcejiEhxo3y9o8kfIPBspN6Bu+cTySjQjgyutfrzk5/SKVUo4rhFtvdSKPo9TlcmsD9oyXuWMFR/kr498=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACnFUDLuqpqnSJtCA--.22117S2;
	Wed, 16 Sep 2026 23:50:35 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	mperttunen@nvidia.com,
	simona@ffwll.ch,
	thierry.reding@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] gpu: host1x: Fix buffer object mapping leak in pin_job()
Date: Wed, 16 Sep 2026 15:50:07 +0000
Message-Id: <20260916155007.2068376-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnFUDLuqpqnSJtCA--.22117S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyrAryDZw13CF1kur1Dtrb_yoW8XFWDpF
	WFvry5tr4vyr40g3WqyayFvF1aka1qqFWUCr4fX343urn8tr17Zr1DGay3Z34Uur97Wa1a
	vFs8Cw45Ga4Ut3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWx
	JVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VU1
	1rW7UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQMA2qqozU+YwABsY

If a buffer is pinned successfully but the mapping is never recorded in
job->unpins, host1x_job_unpin() cannot release it. This happens when a
relocation buffer is discontiguous (map->chunks > 1) and when
alloc_iova() or iommu_map_sgtable() fail while mapping a gather
buffer's IOVA, leaking the mapping and the buffer object reference it
holds.

Unpin the mapping before jumping to the shared error labels.

Fixes: c6aeaf56f468 ("drm/tegra: Implement correct DMA-BUF semantics")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/host1x/job.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/host1x/job.c b/drivers/gpu/host1x/job.c
index 3ed49e1fd933..675e7dde7e38 100644
--- a/drivers/gpu/host1x/job.c
+++ b/drivers/gpu/host1x/job.c
@@ -193,6 +193,7 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 		 * contiguous chunk of I/O virtual memory.
 		 */
 		if (map->chunks > 1) {
+			host1x_bo_unpin(map);
 			err = -EINVAL;
 			goto unpin;
 		}
@@ -244,6 +245,7 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 			alloc = alloc_iova(&host->iova, gather_size >> shift,
 					   host->iova_end >> shift, true);
 			if (!alloc) {
+				host1x_bo_unpin(map);
 				err = -ENOMEM;
 				goto put;
 			}
@@ -252,6 +254,7 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 						map->sgt, IOMMU_READ);
 			if (err == 0) {
 				__free_iova(&host->iova, alloc);
+				host1x_bo_unpin(map);
 				err = -EINVAL;
 				goto put;
 			}
-- 
2.34.1

