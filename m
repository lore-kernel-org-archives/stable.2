Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316829;
	b=UBbFPtz4ZkJOPisqX5xX2pTNL8dqhv+IfXm8wMRyMrY1rhy1Wv2fObmKmBRLBXEoGPdY
	 VsnGmTjz1syAribRS1CVW0/wCDqTJMm8x4NrekDRdGuiPvlp3wifX0jrCYj0yuIq8w7yf
	 ZQpyU58O388OGsPfTBe9J6c2RGKACo+JIg8Lt/melUxZCJCf6JTVDTwEern75UEgJPdoX
	 KDA+qPNi4Fm4cccyRGZJCEmrh0ZVXI/iCE5gB7CgP937G99G5wSuIQqGHogL5x3jfbIll
	 uBs0+axBjzSZOZM0UwIKnDQzRllnRgAdX8HyCo36GL5znRMZBNU6CU7EElR0fw4ceyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316829;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gTHDsOKF1binJYCbeOk+Sfsv5oPiczj4gdpsZsnpp2o=;
	b=ubCyVOzRpmvBFAXlqOVRZSG1ol21Z472XnG1+DxgveXNXr19d3uCfzUgDvG10cQHDDqJ
	 x9w1EL6QkYWeROL6KGrJr5hOzmphgOUThJce98Mv8xY2L7adtBVQ6CpJkQRkyuS8qX+Mi
	 jy6MTQ2j0VtC/l06NE/eJkjah8LZ4LOowBz2UxbXo0yvIbnzmIVEN2NEXS8hMv+qno4ps
	 mexP+jG6cyQjld/8t7lJZh9SL1UeUmf8JAt0EB6Clt2lvl0silDqAUZ0zXT9s6D2u2N4R
	 3u9KdRJYGDDwFwbsr5D2bJr+pUP3Ad4DqKaOUQQoRDQn9qL83bFhUUllK1s6YO/dXaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CqGtQNYD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807B0607681F
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CqGtQNYD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A10A1F0092F;
	Tue, 10 Nov 2026 13:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316829;
	bh=gTHDsOKF1binJYCbeOk+Sfsv5oPiczj4gdpsZsnpp2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CqGtQNYDN4KRkQV3OueDa/sDy54Ht1r1+KmOTQmbT9GeS75vxwS8XvmEt7v4Ee5xt
	 r8x2lnuXSFmTxzW0HQCBA2iJpkXaH3O/+LSSBAZhHHrhqPCa/cmIMky00C0PdumIzl
	 8Su5xtS/64MfCfuA8nCZZ/zraxocU9yhGEnU80ItjFXO9oGdz+ZvRAg3oYOECQ6W2+
	 Sgf0JiXJdB2v12KOUES9kVXd87o4c0JFyuNPg2T3oDbx+2nqb5D41EMcmn3UD7hej8
	 f74j43WJcLuJMLQX/7OhyIzP9v0kmJXS8nyXhKZMo9hFmDpp/b5xN/sAUw3iCglCqV
	 GmdekUMjD/OGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] dmaengine: qcom: bam_dma: free interrupt before the clock in error path
Date: Tue, 10 Nov 2026 08:20:26 -0500
Message-ID: <20261110132019.1716994-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110132019.1716994-1-sashal@kernel.org>
References: <20261107052018-failed-6.12-82eed160cfa7@kernel.org>
 <20261110132019.1716994-1-sashal@kernel.org>
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
index 9f712e7c7e07f..d06f95f7868c1 100644
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

