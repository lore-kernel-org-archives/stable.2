Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE321A5B90;
	Sun,  5 Jul 2026 08:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783239681; cv=none; b=Z3dSL5Revxa9oCbQlgAbZUDJL56IEI/So5lVFIZaJi25pIis3hiP/yKB2F/8B63NpLxUoXUeYDfpINV0CwobHBJrEasWdy0g8dA1svLIXuXFiVzd/YzNXlThQlORrRxAWgRHqleKvL6+bbV2qPN15kmYoYtR7aZKseNHuWtkNPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783239681; c=relaxed/simple;
	bh=YbdgeRuX3ynm03Agwub6U+huy0SG0DYvhedvkV8qgHw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WQdy/WOtxM4pl0r2n5wPRr9CUUI3ilYTdiEkErZJr2YQ7sJ3zzZBA0/rc326DcKu9yB5VT8uV0YwvK1srB0Kfm7/GEaQQlXpIsPYl9TJIbi58NuPbUKkTBOWSyhzOYLfLvcR3XHIHzG+7Bi2TcCYYgDgXJj8+itFapoZa2ptteo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7a7b9f32784a11f1aa26b74ffac11d73-20260705
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a6398748-fa9e-407b-8b50-4517535e9794,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-50
X-CID-META: VersionHash:e7bac3a,CLOUDID:58474abc3c0e55c9a55465de6d67677f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7a7b9f32784a11f1aa26b74ffac11d73-20260705
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1580939437; Sun, 05 Jul 2026 16:21:10 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	wens@kernel.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org
Cc: dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: sun6i: Fix potential deadlock in dma_terminate_all and pause
Date: Sun,  5 Jul 2026 16:21:05 +0800
Message-Id: <20260705082105.13325-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sun6i_dma_terminate_all() and sun6i_dma_pause() acquire sdev->lock
with plain spin_lock() from process context. If a DMA interrupt fires
on the same CPU while the lock is held, the interrupt handler schedules
sun6i_dma_tasklet(), which runs in softirq context and attempts to
acquire the same lock with spin_lock_irq(), causing a deadlock.

Fix by using spin_lock_irq() to disable interrupts while holding
sdev->lock, consistent with other call sites.

Fixes: ba489fd46ab6 ("dmaengine: sun6i: Add support for Allwinner A31 DMA controller")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 drivers/dma/sun6i-dma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index a9a254dbf8cb..37b143a8f75e 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -898,9 +898,9 @@ static int sun6i_dma_pause(struct dma_chan *chan)
 		writel(DMA_CHAN_PAUSE_PAUSE,
 		       pchan->base + DMA_CHAN_PAUSE);
 	} else {
-		spin_lock(&sdev->lock);
+		spin_lock_irq(&sdev->lock);
 		list_del_init(&vchan->node);
-		spin_unlock(&sdev->lock);
+		spin_unlock_irq(&sdev->lock);
 	}
 
 	return 0;
@@ -939,9 +939,9 @@ static int sun6i_dma_terminate_all(struct dma_chan *chan)
 	unsigned long flags;
 	LIST_HEAD(head);
 
-	spin_lock(&sdev->lock);
+	spin_lock_irq(&sdev->lock);
 	list_del_init(&vchan->node);
-	spin_unlock(&sdev->lock);
+	spin_unlock_irq(&sdev->lock);
 
 	spin_lock_irqsave(&vchan->vc.lock, flags);
 
-- 
2.25.1

