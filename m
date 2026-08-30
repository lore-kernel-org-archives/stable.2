Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188721E1A3D;
	Sun, 30 Aug 2026 06:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788069876; cv=none; b=gJEUH/7Jv5ZXLu7sc07kt3akR2H5jk0qqW4EuE8wnBJp2JpGTXfe1UoALAeKAI7Kow7tSaUkxiL3bjYiVkBRoIKpKQebxO99L0JbMlE/yc48ratJLwieS0IDzmQKE7uQEAxMlizdc7so5Ks46dPy9YMu6XEIlpVVHuVezn2WDZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788069876; c=relaxed/simple;
	bh=xo1dMyg+/Rd5ThGZUqqfd+WM/Q7yVLItecLF3QdgL8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=evkGkJ7C8AS5N503JtTUQE9In+XMLnVU4G8puFkcTMjsurrqiCs/d0jN2Xu4X7jSo2lo1PPWaCLHbzsJIYOhZG3F46NMUzYmVzi7KONSs0mn6samhVaL51VSac1hS0lfLksFWIDQRPgE/laaRlrwfC8FsKPZRK3VxtDoPvceE0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=MAHrKP+b; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="MAHrKP+b"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4bd37c65a;
	Sun, 30 Aug 2026 14:04:27 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn
Subject: [PATCH] dmaengine: mediatek: initialize tasklets before requesting IRQs
Date: Sun, 30 Aug 2026 14:04:22 +0800
Message-Id: <20260830060422.2204459-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa05144ef1b03a1kunm1ce9fc29f1215
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHR9KVhhKTU1OHhhLHhgaTlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=MAHrKP+bvsVpW3fN+Ty/oTRyRsGZp0Z0QLt0ZTL5mTVkcarHO9dcuaxXk79N07DhQJWWn4HIYvNAsyUJYB/0mQOTd2BOk61CftNUpjSUo08FMAaErzuO8VQT44L35H2UHvjd2SZDCFNcnobcpKooxV2U4KCIx2cQOSzesLl5wQQ=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=i7KZYx3u2m5meljaWToLKg2o1Rh8mtUpTkTyuFW8LYE=;
	h=date:mime-version:subject:message-id:from;

The CQDMA probe registers each physical-channel IRQ before initializing
the tasklet scheduled by the interrupt handler. A pending interrupt can
schedule an uninitialized tasklet while probe is still running.

Initialize each tasklet when its physical channel is allocated, before
registering the corresponding IRQ.

Fixes: b1f01e48df5a ("dmaengine: Add MediaTek Command-Queue DMA controller for MT6765 SoC")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/dma/mediatek/mtk-cqdma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index 80791e30a..8038f14d1 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -815,6 +815,7 @@ static int mtk_cqdma_probe(struct platform_device *pdev)
 		INIT_LIST_HEAD(&cqdma->pc[i]->queue);
 		spin_lock_init(&cqdma->pc[i]->lock);
 		refcount_set(&cqdma->pc[i]->refcnt, 0);
+		tasklet_setup(&cqdma->pc[i]->tasklet, mtk_cqdma_tasklet_cb);
 		cqdma->pc[i]->base = devm_platform_ioremap_resource(pdev, i);
 		if (IS_ERR(cqdma->pc[i]->base))
 			return PTR_ERR(cqdma->pc[i]->base);
@@ -869,10 +870,6 @@ static int mtk_cqdma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, cqdma);
 
-	/* initialize tasklet for each PC */
-	for (i = 0; i < cqdma->dma_channels; ++i)
-		tasklet_setup(&cqdma->pc[i]->tasklet, mtk_cqdma_tasklet_cb);
-
 	dev_info(&pdev->dev, "MediaTek CQDMA driver registered\n");
 
 	return 0;
-- 
2.34.1
