Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71DC3FF1BC;
	Thu, 16 Jul 2026 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197024; cv=none; b=lRhYEJP9GqCsEiBhplPbI3IHWRM3l90To4BQPsL4QqE7miuPqV/ogJHiklv34G2prT4UTPFaKyeS+jD7QsTZ5Jg29dtvs8Vkek3x/gAH3ZsEnW3FsYrRX8G+82aKu0UV2g5mzA9YeB9I81NfNA9KzccDbmvbcnlk4la7blDPDhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197024; c=relaxed/simple;
	bh=N0S9er2LGR8GbaReji/9Gp961ULE7zW/LAoxiRd+OVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sc5qkZhd6DnyM+UjPfGZIcdQIgzQe9W9nBHskvJJ0/2LEO2p2fNmqQ7cePo2XJqNBvqGUzEk2SYO+16ue0T5wGiDxc4i4Pla/dOpHiexAPyi1sXN+6qZy34YRibh5zPsCmXHa3dIEIdnMHF2S8Ulj71gtU8N40NHiUAX06M40NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wB3F8SHr1hqgcdeAA--.12602S3;
	Thu, 16 Jul 2026 18:16:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgCHcneHr1hqM+o5Aw--.20469S2;
	Thu, 16 Jul 2026 18:16:39 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: kwliu@nuvoton.com,
	kflin@nuvoton.com
Cc: hverkuil@kernel.org,
	mchehab@kernel.org,
	linux-media@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH v2] media: nuvoton: npcm-video: quiesce VCD IRQ before teardown
Date: Thu, 16 Jul 2026 10:15:39 +0000
Message-Id: <20260716101539.3129478-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <04a332fc-2025-4a74-ae4d-1d8f30fe20bf@kernel.org>
References: <04a332fc-2025-4a74-ae4d-1d8f30fe20bf@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgCHcneHr1hqM+o5Aw--.20469S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?sWMI7AXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WN26x6ymw/Gzm2rA1oErI67BnJnJgK4NPimhNDjoe6B4OQI
	PUV2ixKyJRdXsuy+OHTN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoWxAF18Jw15KFykZr17KFWxGrX_yoW5tw4kpF
	W8Ga4SkrWftF1I93ZrJw4UZFy3Xr4xKw4FyFyjk34fA3s8JryFqF109Fy8tFWrArykWasr
	taySvwsruFWYqacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==

The VCD IRQ is devm-requested, but npcm_video_remove() frees the video
object before devres releases that IRQ.  The threaded handler dereferences
video->vcd_regmap before checking VIDEO_STREAMING, so an interrupt in that
interval can access freed memory.

Request the IRQ with IRQF_NO_AUTOEN.  Enable it after starting capture and
setting VIDEO_STREAMING, and disable it first in stop_streaming().
disable_irq() waits for an in-flight threaded handler to finish, after
which stop_streaming() can mask and reset the VCD without a handler
re-enabling it.

Use vb2_video_unregister_device() during remove.  It releases the vb2
queue and calls stop_streaming() for an active stream, ensuring that the
IRQ is disabled before the video object is freed.  Do not release the queue
separately.

If streaming is never started, IRQF_NO_AUTOEN keeps the IRQ disabled
until devres releases it.

This issue was found by an in-house static analysis tool.

Fixes: 46c15a4ff1f4 ("media: nuvoton: Add driver for NPCM video capture and encoding engine")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
Changes since v1:
- Follow Hans Verkuil's suggestion to tie IRQ enablement to the streaming
  lifecycle (IRQF_NO_AUTOEN + enable_irq/disable_irq) and to use
  vb2_video_unregister_device() for teardown.

Compile-tested only; I do not have NPCM hardware, so runtime testing by
the Nuvoton maintainers would be appreciated.
---
 drivers/media/platform/nuvoton/npcm-video.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/nuvoton/npcm-video.c b/drivers/media/platform/nuvoton/npcm-video.c
index 52505af35c08..c28d9d7edd83 100644
--- a/drivers/media/platform/nuvoton/npcm-video.c
+++ b/drivers/media/platform/nuvoton/npcm-video.c
@@ -120,6 +120,7 @@ struct npcm_video {
 
 	struct list_head buffers;
 	struct mutex buffer_lock; /* buffer list lock */
+	int irq;
 	unsigned long flags;
 	unsigned int sequence;
 
@@ -1486,6 +1487,7 @@ static int npcm_video_start_streaming(struct vb2_queue *q, unsigned int count)
 	}
 
 	set_bit(VIDEO_STREAMING, &video->flags);
+	enable_irq(video->irq);
 	return 0;
 }
 
@@ -1494,6 +1496,7 @@ static void npcm_video_stop_streaming(struct vb2_queue *q)
 	struct npcm_video *video = vb2_get_drv_priv(q);
 	struct regmap *vcd = video->vcd_regmap;
 
+	disable_irq(video->irq);
 	clear_bit(VIDEO_STREAMING, &video->flags);
 	regmap_write(vcd, VCD_INTE, 0);
 	regmap_write(vcd, VCD_STAT, VCD_STAT_CLEAR);
@@ -1707,9 +1710,10 @@ static int npcm_video_init(struct npcm_video *video)
 		dev_err(dev, "Failed to find VCD IRQ\n");
 		return -ENODEV;
 	}
+	video->irq = irq;
 
 	rc = devm_request_threaded_irq(dev, irq, NULL, npcm_video_irq,
-				       IRQF_ONESHOT, DEVICE_NAME, video);
+				       IRQF_ONESHOT | IRQF_NO_AUTOEN, DEVICE_NAME, video);
 	if (rc < 0) {
 		dev_err(dev, "Failed to request IRQ %d\n", irq);
 		return rc;
@@ -1807,8 +1811,7 @@ static void npcm_video_remove(struct platform_device *pdev)
 	struct v4l2_device *v4l2_dev = dev_get_drvdata(dev);
 	struct npcm_video *video = to_npcm_video(v4l2_dev);
 
-	video_unregister_device(&video->vdev);
-	vb2_queue_release(&video->queue);
+	vb2_video_unregister_device(&video->vdev);
 	v4l2_ctrl_handler_free(&video->ctrl_handler);
 	v4l2_device_unregister(v4l2_dev);
 	if (video->ece.enable)
-- 
2.34.1

