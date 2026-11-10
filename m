Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317409;
	b=5n9G6OPiDPCqgv+qpwSZ9TOKnq5BfeIGktW6Beg3xPoCR2vxvFr35869Nu8B7rFy1nxf
	 197e8bV+ZfXep8OWPunEzjM/NNJe0PXNlVvlq1CH0yGoU2pkpMQQmq8aWQvi+8Hfd9HRx
	 vshXxOwTjDkeh1Oe/KbZiLEIW4RoO4EXG7qoPPb/KTMGMqexcisFfR35G/9v4FuCfoB1D
	 fo/8LaYsAqHdQPnqIb+I8+epKNjFIN/WUpPnYUDbDSj8Xd/Q+3EpZdBGxwrUV8MGQZwiV
	 mMZjJdLC/n7KC6Wg5OOyfKc0zwQ5SKR0Y/CqrscTzUif9kWqtOS8qNAilatQmCB+E3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317409;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sxY8nLPSMpvvUkGkquhocNs3ZUm1MgWHGNfSYt/qF4M=;
	b=lmilGpuD1IKS+mSvf1h/dcnHMxpMS6srv+itPHedocP6fo94PFV5LUsEA3F/lX4fZmMz
	 nUWNa4Lr+kIpLJR2iJ6AkT2ymjnjGXiO9z4tgrcFHSnHIWXraVzAeyn5zU038xpOvztuO
	 FK9HCwb0jue+PhjNRp+h5k+eCwE8e/NODGlr1WJBYCbcgHLg7VgyJW6Nbfqb5pRhk/Hky
	 j3fW3ZY0wivxCxxhdg6P+F+TEuYLtRl6iRSWGTTQdVahfFicnRXpcAvJbAZSDSXms1X8z
	 hLDocyHNx64cDk+LWHRj5iKHAsH6qUkJjuOv0pJqKHghVHf4FaJ0x054fR9ozl0KAtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+JR4QiH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C9D606A7ED
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+JR4QiH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C585E1F008BE;
	Tue, 10 Nov 2026 13:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794317408;
	bh=sxY8nLPSMpvvUkGkquhocNs3ZUm1MgWHGNfSYt/qF4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X+JR4QiHhUyRtaRCqaqgtB+DvvJ2D1C2UK6KGxEvbUCv0nd1nOS0hqbKgE3YLMPBG
	 ob+EEx1BMXzukN8cfAY/0/I0vZIf+E0md7KDmC6d5Ev/kxaNUqLYTgeCqqNTO8AzzX
	 K+1SLqvDz5FiiVPUJnEWmwHv33jzMOtSwK7dmNIZXqdtuVrIXbAItTsIrTcA38qCBv
	 n7FlvbMudt70qgHitmCgyxCSg7pxIw2rLHz7haioEMfO/zu8rAnOJIbGiVRxfw8By8
	 Q6pNaFQNY+QoyX10lGUuQfDGBW3R6X9UuNutCXZ/u9cdWnc6xB51m8E1/CL/mwDtBU
	 R3pPNdzdhJaNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] dmaengine: qcom: bam_dma: free interrupt before the clock in error path
Date: Tue, 10 Nov 2026 08:30:05 -0500
Message-ID: <20261110132958.1741998-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110132958.1741998-1-sashal@kernel.org>
References: <20261107054538-failed-6.1-82eed160cfa7@kernel.org>
 <20261110132958.1741998-1-sashal@kernel.org>
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
index a8cf834867353..188c3b716138d 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1324,8 +1324,8 @@ static int bam_dma_probe(struct platform_device *pdev)
 	for (i = 0; i < bdev->num_channels; i++)
 		bam_channel_init(bdev, &bdev->channels[i], i);
 
-	ret = devm_request_irq(bdev->dev, bdev->irq, bam_dma_irq,
-			IRQF_TRIGGER_NONE, "bam_dma", bdev);
+	ret = request_irq(bdev->irq, bam_dma_irq, IRQF_TRIGGER_NONE,
+			  "bam_dma", bdev);
 	if (ret)
 		goto err_bam_channel_exit;
 
@@ -1362,7 +1362,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	ret = dma_async_device_register(&bdev->common);
 	if (ret) {
 		dev_err(bdev->dev, "failed to register dma async device\n");
-		goto err_bam_channel_exit;
+		goto err_free_irq;
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node, bam_dma_xlate,
@@ -1381,6 +1381,8 @@ static int bam_dma_probe(struct platform_device *pdev)
 
 err_unregister_dma:
 	dma_async_device_unregister(&bdev->common);
+err_free_irq:
+	free_irq(bdev->irq, bdev);
 err_bam_channel_exit:
 	for (i = 0; i < bdev->num_channels; i++)
 		tasklet_kill(&bdev->channels[i].vc.task);
@@ -1406,7 +1408,7 @@ static int bam_dma_remove(struct platform_device *pdev)
 	/* mask all interrupts for this execution environment */
 	writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));
 
-	devm_free_irq(bdev->dev, bdev->irq, bdev);
+	free_irq(bdev->irq, bdev);
 
 	for (i = 0; i < bdev->num_channels; i++) {
 		bam_dma_terminate_all(&bdev->channels[i].vc.chan);
-- 
2.53.0

