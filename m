Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5340C3C1A;
	Sun, 30 Aug 2026 02:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788057179; cv=none; b=NvfUrAqIrn8BbKD64fBhCUlUpt/QYtEw/1MrNprj0AdaEKbqA+lAIwt1zcqY0kdXyASYWULcptIK/SLED44ULySLykZfox13XNzOtGrXQoo4Sdh5q6W56FIja0A5DxnXw+TZj8JaR9HeyIoMEEHVsbrv/jTAHQC5nTjiNx1e1vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788057179; c=relaxed/simple;
	bh=CSpmp1honZHXYMftpQYMUjd716V99aaLb3g8cYykKdU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JHG3wctYjYg8FRyWiPvRUwDezjqbCkKbcufSTyZuLl4bxaDwUurlYZuGiZyvQcTjKw+tIEA5AIK1OwDEb5TJvIdbPkX8abWKqdtTsOHmivBhqdDfMBE4LfpP2Vb74SiFWTit+HxU3BrSK6flSsqI5ixqveQLuPNg9u4dSZUJRlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ItQwSlKH; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="ItQwSlKH"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4bd1f0987;
	Sun, 30 Aug 2026 10:32:50 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: ehristev@kernel.org
Cc: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn
Subject: [PATCH] media: microchip: isc: Initialize DMA lock before requesting IRQ
Date: Sun, 30 Aug 2026 10:32:28 +0800
Message-Id: <20260830023228.2054498-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa05083332f03a1kunm2e16ab45e9a05
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZQkxDVhlNGh4ZGkwfSx5NHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ItQwSlKHsxAp9Z/SmZktG7Ol6QjlZTDV3LZ1UjNnsOb8TzYokPAwO0iWW4x29DoMtu/5O3VrZi1T7PX2AePNWc3IHLLBKcrH0Du+CB9AoHQ5SPCcKOdcwPP4JlnNS8XBHI8VvhBaWswd3RiUIGuIcQ4MbS0haDJSEubfmaLbdqw=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=3Z+KrHk9I4Y9R48UeckShe886/mSEw3vwNvJjEBo1B4=;
	h=date:mime-version:subject:message-id:from;

The ISC interrupt can run before asynchronous subdevice completion, but the DMA queue lock was initialized from isc_async_complete().  Initialize it in each SoC probe before requesting the auto-enabled IRQ and remove the late initialization from the asynchronous completion path.

Fixes: 91b4e487b0c6 ("media: microchip: add ISC driver as Microchip ISC")

Cc: stable@vger.kernel.org

Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/media/platform/microchip/microchip-isc-base.c    | 1 -
 drivers/media/platform/microchip/microchip-sama5d2-isc.c | 2 ++
 drivers/media/platform/microchip/microchip-sama7g5-isc.c | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index a7cdc743f..a2534d8eb 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -1792,7 +1792,6 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 
 	/* Init video dma queues */
 	INIT_LIST_HEAD(&isc->dma_queue);
-	spin_lock_init(&isc->dma_queue_lock);
 	spin_lock_init(&isc->awb_lock);
 
 	ret = isc_set_default_fmt(isc);
diff --git a/drivers/media/platform/microchip/microchip-sama5d2-isc.c b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
index 66d3d7891..f0f7ca47f 100644
--- a/drivers/media/platform/microchip/microchip-sama5d2-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
@@ -432,6 +432,8 @@ static int microchip_isc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	spin_lock_init(&isc->dma_queue_lock);
+
 	ret = devm_request_irq(dev, irq, microchip_isc_interrupt, 0,
 			       "microchip-sama5d2-isc", isc);
 	if (ret < 0) {
diff --git a/drivers/media/platform/microchip/microchip-sama7g5-isc.c b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
index 7383341ec..b1aa3fe55 100644
--- a/drivers/media/platform/microchip/microchip-sama7g5-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
@@ -421,6 +421,8 @@ static int microchip_xisc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	spin_lock_init(&isc->dma_queue_lock);
+
 	ret = devm_request_irq(dev, irq, microchip_isc_interrupt, 0,
 			       "microchip-sama7g5-xisc", isc);
 	if (ret < 0) {
-- 
2.34.1

