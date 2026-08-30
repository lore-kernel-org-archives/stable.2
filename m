Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2B73839AE;
	Sun, 30 Aug 2026 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100801; cv=none; b=hQc/Auu1GJyzMPO2eDcktSlDaYIjQ7V9wrRkLE50IQiRAyfyqZWka/B7kFNZ0wLiex2wbZR536HM8IM9OE9Vmj37wf43IeUYSQiJXzEMOp4BZO3d6yxPdICcRMtLq6hv4uVbH+bueYvEPgaTyPWKM4fm0x4/3NDh+EeBltUS0h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100801; c=relaxed/simple;
	bh=xqXUMWAY5SKNN4Ajdp8I28NFr5JFFE8343fZ0Yr/8Ek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r7mm6aHu5D+Brye86WWwNHJXzWKt/+G2VxERO6P6FRx1jUz9GzmLxPLcw6jH64bTlAgbwjU+SNDvHKOOJxqrnhFPNPS83Ju6trkEEHiy9V8vjSxDiW4pXhaUsSCF/r7+bSm+Qv9DbvvohrJ/3B3YkNdIqwvA04XcDjiczvgTcak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=NNAur5Ud; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="NNAur5Ud"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4bd75f804;
	Sun, 30 Aug 2026 22:39:53 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: keke.li@amlogic.com
Cc: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH] media: platform: c3-isp: Register IRQ after video state init
Date: Sun, 30 Aug 2026 22:39:45 +0800
Message-Id: <20260830143945.2700038-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0531cd50e03a1kunm07366b50103c8e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGBpOVk1PGkkfSEpMH0MaTlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=NNAur5UdY6Mlpo8TjiMDIVDQHOWvw/KcYuUVqfkP/H70FFoytchKQm31LU8nasFL0YTrNkC6C1lO29PzdSlC85rghS007/NipRdbPTcn4aElE9nTzho5XoXlyZi5A7f72WwleGC0s7lV/ewolv3/3jrpZ30kH+f+geUT3EfMiWk=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=0vQV9rUtvsRcLcvsN0sR8Ty8ET3YeX/jTGpWqL9MH2Q=;
	h=date:mime-version:subject:message-id:from;

c3_isp_probe() requests the shared IRQ before
c3_isp_videos_register() initializes the capture, statistics, and
parameter state used by the IRQ handler. request_irq() permits the
handler to run as soon as registration completes, so a frame-end
interrupt can acquire an uninitialized buffer lock.

Register the video state before requesting the IRQ and free the managed
IRQ before tearing that state down. Store the IRQ number for the remove
path and preserve the existing probe error unwinding.

Fixes: fb2e135208f3 ("media: platform: Add C3 ISP driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 .../media/platform/amlogic/c3/isp/c3-isp-common.h  |  2 ++
 drivers/media/platform/amlogic/c3/isp/c3-isp-dev.c | 14 +++++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/amlogic/c3/isp/c3-isp-common.h b/drivers/media/platform/amlogic/c3/isp/c3-isp-common.h
index cb470802e..56b7d48e1 100644
--- a/drivers/media/platform/amlogic/c3/isp/c3-isp-common.h
+++ b/drivers/media/platform/amlogic/c3/isp/c3-isp-common.h
@@ -293,6 +293,7 @@ struct c3_isp_info {
  * @stats: ISP stats device
  * @params: ISP params device
  * @caps: array of ISP capture device
+ * @irq: ISP interrupt number
  * @frm_sequence: used to record frame id
  * @info: version-specific ISP information
  */
@@ -312,6 +313,7 @@ struct c3_isp_device {
 	struct c3_isp_params params;
 	struct c3_isp_capture caps[C3_ISP_NUM_CAP_DEVS];
 
+	int irq;
 	u32 frm_sequence;
 	const struct c3_isp_info *info;
 };
diff --git a/drivers/media/platform/amlogic/c3/isp/c3-isp-dev.c b/drivers/media/platform/amlogic/c3/isp/c3-isp-dev.c
index c3b779f63..66242544e 100644
--- a/drivers/media/platform/amlogic/c3/isp/c3-isp-dev.c
+++ b/drivers/media/platform/amlogic/c3/isp/c3-isp-dev.c
@@ -330,6 +330,7 @@ static int c3_isp_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
+	isp->irq = irq;
 
 	ret = c3_isp_get_clocks(isp);
 	if (ret)
@@ -355,18 +356,20 @@ static int c3_isp_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_resizers_unregister;
 
-	ret = devm_request_irq(dev, irq,
-			       c3_isp_irq_handler, IRQF_SHARED,
-			       dev_driver_string(dev), isp);
+	ret = c3_isp_videos_register(isp);
 	if (ret)
 		goto err_nf_unregister;
 
-	ret = c3_isp_videos_register(isp);
+	ret = devm_request_irq(dev, irq,
+			       c3_isp_irq_handler, IRQF_SHARED,
+			       dev_driver_string(dev), isp);
 	if (ret)
-		goto err_nf_unregister;
+		goto err_videos_unregister;
 
 	return 0;
 
+err_videos_unregister:
+	c3_isp_videos_unregister(isp);
 err_nf_unregister:
 	c3_isp_async_nf_unregister(isp);
 err_resizers_unregister:
@@ -384,6 +387,7 @@ static void c3_isp_remove(struct platform_device *pdev)
 {
 	struct c3_isp_device *isp = platform_get_drvdata(pdev);
 
+	devm_free_irq(isp->dev, isp->irq, isp);
 	c3_isp_videos_unregister(isp);
 	c3_isp_async_nf_unregister(isp);
 	c3_isp_core_unregister(isp);
-- 
2.34.1
