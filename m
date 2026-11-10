Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316589;
	b=LNXekhMgzkIm4jwzlzHonLYtbLW6S3PxGL0YSgW8e+2QZT2UtPMqkaCyGpefQ0h/akU5
	 bTQyEa3vNJFCyRhnXfQQ9pI99pPfbaJO9JdLhGiRC+PDPm2hEN8NgAZjYDmP8VapmDZSk
	 LY2KMx7Aoo0S7hHjaukrI5zSSGV/dpBbF1ygoX/b2gRWSNERCtQZ4W9Uym+Snjkpe6use
	 j9F1/StgH9B+3919cFU9hrADhk3L5n2SO5bO8BvcI/JxqRmhYXP5hqfsG/bnLJ9PIb+Nm
	 fkQcMkf89rmvYPDtMe1HtH40hAND/KjkdS7lOYJuAb0DppmlZlfx4RBjkyxUML0IpGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316589;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=z+69h2YOK6KjqD7rEV9DkKlWr2NJZCATk7MaiGTlHRs=;
	b=t/38xP0nlHBu1yDek8aCp0gh4jxccn+p7iLG6VS37PIVYzzOTgoH2NdM46YFm3xm/QbD
	 vwriXlrf6oULX4zU+YD37CTqNnyO2jw1TSmKOzLqDawLPkS7N6ig0xoc3n6Ngq+21hYo3
	 FAcC51esy3XAeyFKiI6Fvy0lvsVldWZW3dRrYKR80RWZIkIxB4kpOnsRcMfhgoHThgI14
	 Hm+/GykUvQpN6By3h6Ld0JC2BfHIlrU2m4Mh2wsDRS83KujEcwa2+xr99UbOH2b2PQZyH
	 qB3fcFGQNks1Nb2+yEQNyv4EEe2RgwdLyTbtH7Xk4Htd6AJ+HJIrorybVnYIdHH8WaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDCBz6IH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794F5606BFE5
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDCBz6IH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1E31F008A6;
	Tue, 10 Nov 2026 13:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316589;
	bh=z+69h2YOK6KjqD7rEV9DkKlWr2NJZCATk7MaiGTlHRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kDCBz6IHpDxK7AwDDVQBVy5ADPBqhAj1Ph4PBUZTCPz+2CJoUlnnp4X1J8WRNsvjf
	 S6qcpTjSISdx8hQu1q+kZqKvM54/rwLZv35tIC3tVydaKG2KfIkb84FySeTyjlcrfu
	 ZeRcI1hNmJomckl9dnCOasPjAHUMIPjgVVGtx353mj+u0+7bezvk1yzdBy+IB0i33z
	 qVO0K9g0WvMpVOv5PpR4h4X3cmRkRY2m6+l2roxOWYcF24bLgS3I3N/JUg4Cr08wBz
	 uJUZDE4OtxCNpszb3RHxYfAW9A0vxAo1GXT9eU5aUOaHRc0p30f3Xf2YEbgBhmdpEM
	 NHVHWcbJoOk2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] dmaengine: qcom: bam_dma: free interrupt before the clock in error path
Date: Tue, 10 Nov 2026 08:16:25 -0500
Message-ID: <20261110131618.1701335-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110131618.1701335-1-sashal@kernel.org>
References: <20261107050930-failed-6.18-82eed160cfa7@kernel.org>
 <20261110131618.1701335-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

[ Upstream commit 82eed160cfa7a296ae4eb5acb8dd8f493323eea7 ]

The BAM interrupt is requested with a devres helper and so on error it's
freed after probe() returns. We disable the clock before freeing or
masking it so it may still fire and we may end up reading BAM registers
with clock disabled.

Stop using devres for interrupts as we free it in remove() manually
anyway. Add an appropriate label and free the interrupt before disabling
the clock in error path and in remove().

Cc: stable@vger.kernel.org
Fixes: e7c0fe2a5c84 ("dmaengine: add Qualcomm BAM dma driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc%40oss.qualcomm.com?part=2
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Link: https://patch.msgid.link/20261008-bam-dma-free-irq-v28-1-5e5b10de441e@oss.qualcomm.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/qcom/bam_dma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index c8cd6112f9003..9f514f9201bcc 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1322,8 +1322,8 @@ static int bam_dma_probe(struct platform_device *pdev)
 	for (i = 0; i < bdev->num_channels; i++)
 		bam_channel_init(bdev, &bdev->channels[i], i);
 
-	ret = devm_request_irq(bdev->dev, bdev->irq, bam_dma_irq,
-			IRQF_TRIGGER_NONE, "bam_dma", bdev);
+	ret = request_irq(bdev->irq, bam_dma_irq, IRQF_TRIGGER_NONE,
+			  "bam_dma", bdev);
 	if (ret)
 		goto err_bam_channel_exit;
 
@@ -1356,7 +1356,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	ret = dma_async_device_register(&bdev->common);
 	if (ret) {
 		dev_err(bdev->dev, "failed to register dma async device\n");
-		goto err_bam_channel_exit;
+		goto err_free_irq;
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node, bam_dma_xlate,
@@ -1375,6 +1375,8 @@ static int bam_dma_probe(struct platform_device *pdev)
 
 err_unregister_dma:
 	dma_async_device_unregister(&bdev->common);
+err_free_irq:
+	free_irq(bdev->irq, bdev);
 err_bam_channel_exit:
 	for (i = 0; i < bdev->num_channels; i++)
 		tasklet_kill(&bdev->channels[i].vc.task);
@@ -1400,7 +1402,7 @@ static void bam_dma_remove(struct platform_device *pdev)
 	/* mask all interrupts for this execution environment */
 	writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));
 
-	devm_free_irq(bdev->dev, bdev->irq, bdev);
+	free_irq(bdev->irq, bdev);
 
 	for (i = 0; i < bdev->num_channels; i++) {
 		bam_dma_terminate_all(&bdev->channels[i].vc.chan);
-- 
2.53.0

