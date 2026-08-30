Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34823FFD;
	Sun, 30 Aug 2026 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788101324; cv=none; b=Gu4gZT1kU9mxraAw9IxXw1xyvClB6e0QwIQ6lOslOxIoqqQr8sjGi2oLF8uWg2AjBK1odbV66P1WPEjIYEBi8T7wpny7l+hQkeXbYhURPuDUf2JKh6S74vonQzoFnuTRz0ow+XJ0lw5PvejD9IvTObJVhXHpYfVkTGGRv79Zmy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788101324; c=relaxed/simple;
	bh=mQVJ7zDvrT6sNKYopfcwhYtHg5BubOvImcbeGOJdQyM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VKxy7mvIj5LBeZrgr1dBg7eWKjZTV0C+pL6t8LTQGfP0In08SX9YjrBuV8j3YNegy4CFTmcqz6CvwTD3x72XdlQpV2HJHUZqE8z++2cgTMJgqIfn1ZlBRZ5kHnqM4kRepc3VrcYDcgs7vhIFzLXYtCDg3hAwESyt9lFKuHR4lM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=gUXhzYXJ; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="gUXhzYXJ"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4bd75f902;
	Sun, 30 Aug 2026 22:48:35 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: tiffany.lin@mediatek.com
Cc: andrew-ct.chen@mediatek.com,
	yunfei.dong@mediatek.com,
	mchehab@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH] media: mediatek: vcodec: Initialize context lock before firmware setup
Date: Sun, 30 Aug 2026 22:48:27 +0800
Message-Id: <20260830144827.2701887-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa05324ca4503a1kunm748a56ff10419f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHhlLVhhDT04aTUsdTR0ZSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=gUXhzYXJL1n6Ohtr4BC7UXBxUc8olWj4achRmmp4nPcWG2WD2SAWhEdkAF6ljCVtb8YPKhsZJQ+ePDT6TpRcpga4JN+Zb4F4qiAy0VGpJDPANw8WNJUfa41P2DGJwc0cw3zeR0uVFn+wMhFHte4KruOPTKs/ZIhCazFFx/5Nf6c=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=s3dZ8lISZQr52REE7ec1HbSkTDws0HKFv6UJz6Thh6A=;
	h=date:mime-version:subject:message-id:from;

The VPU firmware setup registers a watchdog callback that accesses the
encoder context lock. Initialize the lock before selecting the firmware
implementation so the callback cannot observe an uninitialized lock during
probe.

Fixes: afaaf3a0f647 ("media: mediatek: vcodec: adding lock to protect encoder context list")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 .../media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
index 4e4541b2f..e6cd3817a 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
@@ -255,6 +255,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&dev->ctx_list);
 	dev->plat_dev = pdev;
+	spin_lock_init(&dev->dev_ctx_lock);
 
 	if (!of_property_read_u32(pdev->dev.of_node, "mediatek,vpu",
 				  &rproc_phandle)) {
@@ -308,7 +309,6 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 
 	mutex_init(&dev->enc_mutex);
 	mutex_init(&dev->dev_mutex);
-	spin_lock_init(&dev->dev_ctx_lock);
 	spin_lock_init(&dev->irqlock);
 
 	snprintf(dev->v4l2_dev.name, sizeof(dev->v4l2_dev.name), "%s",
-- 
2.34.1

