Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB2545041A;
	Thu,  8 Oct 2026 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791461694; cv=none; b=FD07NpWMkWmBeRIYbuJRAE4p6uEvtGRcCZ0OTCSP8aWbSstox2omRK3y4rx4WRBkYuzd+w3RHVvccp4UggFGdHQkNWF954DMdY0Fmxp/Tl8794B/q3ENfXRCp0PWAjQKAkUexOZAZ5ZnnYOklBkVmvuMvCphjKxYyLmu7YG1mLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791461694; c=relaxed/simple;
	bh=0J7kj8ZCzMw5Of+yHkAfng/RvMnu7WG468MR8rGe3f8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QPff0XxeXDu6wk+z+glT6dZWhSc64MLP4KUVjlUOVadBGND2Q2uxDevpfAoUQpucw2yor76RgC0uUkZOiHLQ2t9lHHPIyO0nhrBHbzPbsiWYM8ywz+Ezet7cDxSenBUQgMUPHqfFGye3vvfVrqXT2WuK84FeQUkhZNDxCIzAcKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=mpuap6vT; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="mpuap6vT"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 504fceb6b;
	Thu, 8 Oct 2026 20:14:40 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Tiffany Lin <tiffany.lin@mediatek.com>
Cc: Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Nicolas Dufresne <nicolas@ndufresne.ca>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>
Subject: [PATCH v2] media: mediatek: vcodec: Initialize context lock before firmware setup
Date: Thu,  8 Oct 2026 20:14:34 +0800
Message-Id: <20261008121434.946927-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260830144827.2701887-1-runyu.xiao@seu.edu.cn>
References: <20260830144827.2701887-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa11b6fe35d03a1kunmde41a01640d4ff
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQ09NVh0eT0NMHRpLHx8ZTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=mpuap6vTn5/8zckoWW8m1AHNs9/lrcC5dOJcyxI7o3wqlyxDpZbUynix5R3jV5E4QP1TlxqiCAxXdXkKBLNY9VZXCngNlD9zOFScb1XilepNqRMu5m94NNs+MR9yEckFVuS8w+HDfSmfLLLg6nrgKxqKO7TSfvVKra+weDvEtzU=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=bZAo94LpO2B0yElRNSLGBz0NRZ8kLHR1Iz17jxI1zUg=;
	h=date:mime-version:subject:message-id:from;

The normal encoder open path cannot take dev_ctx_lock before
video_register_device(), but there is another path during probe.

On VPU-backed devices, mtk_vcodec_probe() selects firmware before it
initializes dev_ctx_lock. VPU firmware setup registers the encoder watchdog
callback during this selection. A watchdog timeout on the shared VPU
queues reset work, which invokes the registered callbacks. If it runs
before spin_lock_init(), the encoder callback takes the uninitialized lock.

With CONFIG_DEBUG_SPINLOCK=y, an x86_64 QEMU test used a zeroed lock,
initialized an empty context list, and invoked a callback with matching
lock and list operations. It reported:

    [    1.761312] BUG: spinlock bad magic on CPU#0, busybox/58

The lock dump showed .magic: 00000000.

The test reproduces the debug lock diagnostic, not a real VPU watchdog
timeout or its timing during probe. The context list is initialized but
remains empty until video registration, so this shows invalid lock use, not
list corruption or a user-visible failure.

Initialize dev_ctx_lock before firmware setup registers the callback.

Fixes: afaaf3a0f647 ("media: mediatek: vcodec: adding lock to protect encoder context list")
Cc: stable@vger.kernel.org
Assisted-by: LLM
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
