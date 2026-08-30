Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C4D3F104C;
	Sun, 30 Aug 2026 05:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788068011; cv=none; b=CAUT1zIKGSfw/drxNrS6af5GUhdYLT6OhGNjVKsAXd0DU+BJz2zJEzBSXPJAgST0DDBBhA+LhYhS/BvJ3DQRE/elHYsQWHUYxC6fCKnqJHFSzVCBDNiWCKFURfszUpPYer+E8s49B2xIGmuOd+WjHlF41FiXLC37NdaB6FUpTbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788068011; c=relaxed/simple;
	bh=O78nh4Oy88bdxh0L5QHYz6/ZtqAoeZreiA6jvLqxCjI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bihk03mmeyHTMCIJHPWrwhdw0rVBURV3+XKdPUaTBw7zXnHwsjkp7chlubCNB7E5r+oLUx3gqEB/6cQg1J2UtuZJLFsHx8hkKdAJSgG5kDZ//1pFdPl+ZEjE8+op0DUjTqYQBIB/2NuLZmZ8/5vyqsh6bJEWnzRkEiJ0lrXtUk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=YDUGWOIB; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="YDUGWOIB"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4bd32454f;
	Sun, 30 Aug 2026 13:33:16 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: adrian.ho.yin.ng@altera.com
Cc: sr@denx.de,
	vkoul@kernel.org,
	Frank.Li@kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn
Subject: [PATCH] dmaengine: altera-msgdma: initialize state before requesting IRQ
Date: Sun, 30 Aug 2026 13:33:08 +0800
Message-Id: <20260830053308.2190597-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa05128620303a1kunm7db0cc95f00cd
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSB1IVk1MGU9KGh5NQkhPGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=YDUGWOIBUuI4RkfDe1fWwL0BKP/27UC+JSqtDwNPMlQIrjmd0WRCDuXCLwd7jmEDxr1WykH9OAJRB2wgVbQmzMPk1xFLk15qsMmrYgzcmEJFw78Uw3DXKMYfkbmno8gZcwrEZSE+KLd+X90lV7KnTHOgYELE7wf8fy752YIfNgQ=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=6JjjVTLXLJgetoxNznReCDPIj5+X9IifVHzbbQlKJjw=;
	h=date:mime-version:subject:message-id:from;

msgdma_probe() registers the IRQ before initializing the tasklet, lock,
and descriptor lists used by the interrupt handler. A pending interrupt
can access incomplete state during probe.

Initialize the handler state before requesting the IRQ so the interrupt
path observes ready software state.

Fixes: a85c6f1b2921 ("dmaengine: Add driver for Altera / Intel mSGDMA IP core")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/dma/altera-msgdma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index e23e5b441..412f4bce1 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -847,11 +847,6 @@ static int msgdma_probe(struct platform_device *pdev)
 	if (mdev->irq < 0)
 		return -ENXIO;
 
-	ret = devm_request_irq(&pdev->dev, mdev->irq, msgdma_irq_handler,
-			       0, dev_name(&pdev->dev), mdev);
-	if (ret)
-		return ret;
-
 	tasklet_setup(&mdev->irq_tasklet, msgdma_tasklet);
 
 	dma_cookie_init(&mdev->dmachan);
@@ -863,6 +858,11 @@ static int msgdma_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&mdev->done_list);
 	INIT_LIST_HEAD(&mdev->free_list);
 
+	ret = devm_request_irq(&pdev->dev, mdev->irq, msgdma_irq_handler,
+			       0, dev_name(&pdev->dev), mdev);
+	if (ret)
+		return ret;
+
 	dma_dev = &mdev->dmadev;
 
 	/* Set DMA capabilities */
-- 
2.34.1
