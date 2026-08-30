Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D251C3BFC;
	Sun, 30 Aug 2026 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788070346; cv=none; b=kyKJ16cjPan/qPY20bVkrttaevzIbCDeEK7lDHwbQLkoTMzxSjg8pifn4Lstd20uiDNFcAW6tQgFYO2HiSXK0hM1I11B6KxGvpuSnxk4RVSD1zSPzzX7+T/78xcZpkqGfWH+Bw2MwkI2ssVDXYZ+inqBFVs21RdqGYfDz84KXF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788070346; c=relaxed/simple;
	bh=yFm75+vqHMjeMLmf0Ng4OqsxOkfDlOgzwvs4ZGGQE54=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LKNFsfyyBoLxjHtvFYEdUdH3gPzel2UZVMLK4AbJWo6Ii6//+1sfVHz2D0wjeurmFPyLD4GLjlM5FORjRQe/frPEIy4LYQqfIwHDMrHMo1jhsNN600i/ONqNCLZExwtLOWgP20FFZuu/QcfHADJ6cUDZ0cqRiS6yn0A86fly/ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=kWczpwrX; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="kWczpwrX"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4bd37c6e9;
	Sun, 30 Aug 2026 14:12:18 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn
Subject: [PATCH] dmaengine: tegra: initialize channel state before requesting IRQ
Date: Sun, 30 Aug 2026 14:12:13 +0800
Message-Id: <20260830061213.2209331-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0514c20d303a1kunm63d52621f1643
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHk5DVh4eSk5ISxhDHUsdGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=kWczpwrXyNgj4nkSas85Ngn5zLoLCt9Q9o93aK+JAx1xL0vJ7NfzTMnVzwD/xVypTJ4KgEecnmQltKdpWuh6fgJg6ht+AF1SggsOdeg07CbN3HC0M6ZFcJU3gcJgKSULqIO7x5Vgu+WqJzAGzdkMdL4aTKEvVhPkwDEBmKgVecE=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=yFauyxo1qyDcbXRiqHJEgqmqqU1JX6+fFECKyidBUEc=;
	h=date:mime-version:subject:message-id:from;

tegra_dma_probe() registers a channel IRQ before initializing the
channel lock, tasklet, waitqueue, and descriptor lists used by the
interrupt path. A pending interrupt can therefore access uninitialized
channel state.

Prepare the channel state before requesting its IRQ so the handler and
tasklet always see initialized synchronization and list objects.

Fixes: ec8a1586780c ("dma: tegra: add dmaengine based dma driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/dma/tegra20-apb-dma.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 640b8a218..23fd294ab 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1494,6 +1494,19 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		}
 
 		snprintf(tdc->name, sizeof(tdc->name), "apbdma.%d", i);
+		tdc->tdma = tdma;
+		tdc->id = i;
+		tdc->slave_id = TEGRA_APBDMA_SLAVE_ID_INVALID;
+
+		tasklet_setup(&tdc->tasklet, tegra_dma_tasklet);
+		spin_lock_init(&tdc->lock);
+		init_waitqueue_head(&tdc->wq);
+
+		INIT_LIST_HEAD(&tdc->pending_sg_req);
+		INIT_LIST_HEAD(&tdc->free_sg_req);
+		INIT_LIST_HEAD(&tdc->free_dma_desc);
+		INIT_LIST_HEAD(&tdc->cb_desc);
+
 		ret = devm_request_irq(&pdev->dev, irq, tegra_dma_isr, 0,
 				       tdc->name, tdc);
 		if (ret) {
@@ -1507,18 +1520,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		dma_cookie_init(&tdc->dma_chan);
 		list_add_tail(&tdc->dma_chan.device_node,
 			      &tdma->dma_dev.channels);
-		tdc->tdma = tdma;
-		tdc->id = i;
-		tdc->slave_id = TEGRA_APBDMA_SLAVE_ID_INVALID;
-
-		tasklet_setup(&tdc->tasklet, tegra_dma_tasklet);
-		spin_lock_init(&tdc->lock);
-		init_waitqueue_head(&tdc->wq);
-
-		INIT_LIST_HEAD(&tdc->pending_sg_req);
-		INIT_LIST_HEAD(&tdc->free_sg_req);
-		INIT_LIST_HEAD(&tdc->free_dma_desc);
-		INIT_LIST_HEAD(&tdc->cb_desc);
 	}
 
 	dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
-- 
2.34.1
