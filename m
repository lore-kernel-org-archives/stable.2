Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E1A364059;
	Wed,  9 Sep 2026 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945526; cv=none; b=e5+NsvmApBqBqETjGt/KxLmvtdcXtk6zrik0GhXiIAtQNU5cFkiDm3lqU3o9YXJih9+lPQ4MZx7CKtOhzGpfuBb0PQOgAulJwJIh2hAQpVXTy4VPLPHHGBOIuDR4oe1eUyS4rVxB4gHvZb0NSFTqbO7gQlnN9/z8MvwuZd+OFP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945526; c=relaxed/simple;
	bh=yhrFW+3kGZ0pGU5TBdj1d7QID7v1jJv0vQjN0/b1PUU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JVr5J23CyAeIoxn6sDHSRz+GMinD/7WQo2dcEu6zC/ir3EATU2B0lNEzgPP27iqprrOP3/gJt1vp3s7Sui792OuTkR8GLYtNc8mis8IWgI2H0TEYvIJBrcocLmoI0HwXQJQAuLGKYZoaQaCD3eimM6r7KlaEIdXrJ/OzfhWmeR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wAH4X1fJKFqbbkCAQ--.34327S3;
	Wed, 09 Sep 2026 17:18:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app1 (Coremail) with SMTP id yy_KCgD3i6ZfJKFqPbdpBA--.64532S2;
	Wed, 09 Sep 2026 17:18:23 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: Roy.Pledge@nxp.com
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] soc: fsl: dpio: fix use-after-free of the net DIM work
Date: Wed,  9 Sep 2026 09:16:57 +0000
Message-Id: <20260909091657.688054-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgD3i6ZfJKFqPbdpBA--.64532S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?H+lqsQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVCjTgEH9dVomQuWcozCBBEAYUevbp5ILYeQ+fQBlsYzIeo02Hu3BvP8Ss+4j4TU5KQr
	QrzjC4K1bE1MpcYamrup9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7WF1UAw4fAFW8Jr1fKw4Utrc_yoW8Cr4fpF
	Z8GryFyFykXF43Kw1q9aykAry5ur97CF4fCFs7GayrXrs0ya4rKr17t3s8AFZIyrWkAw1j
	vFyrtFy3uF15ArXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Xo7JUUUUU==

dpaa2_io_create() registers a work handler for the receive dynamic
interrupt moderation (INIT_WORK(&obj->rx_dim.work, dpaa2_io_dim_work)).
When adaptive RX coalescing is enabled, the receive path calls
dpaa2_io_update_net_dim(), and net_dim() schedules rx_dim.work on the
system workqueue whenever the moderation profile changes. The worker
recovers the owning dpaa2_io with container_of() and programs the
interrupt coalescing through d->swp.

dpaa2_io_down() removes the object from the service list and frees it
without waiting for this work, so a moderation update that is still
pending or running when the DPIO device is removed dereferences freed
memory.

Fix this by cancelling rx_dim.work in dpaa2_io_down() before the object
is freed, so a pending or running moderation update finishes while the
dpaa2_io it dereferences is still alive.

This issue was found by an in-house static analysis tool.

Fixes: 69651bd8d303 ("soc: fsl: dpio: add Net DIM integration")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/soc/fsl/dpio/dpio-service.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
index 317ca50b0c2b..1ea185f8a4bd 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -205,6 +205,8 @@ struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc,
  */
 void dpaa2_io_down(struct dpaa2_io *d)
 {
+	cancel_work_sync(&d->rx_dim.work);
+
 	spin_lock(&dpio_list_lock);
 	dpio_by_cpu[d->dpio_desc.cpu] = NULL;
 	list_del(&d->node);
-- 
2.34.1

