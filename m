Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317663;
	b=n3kOklvabxuPOnTsYxllFhkQlWGj/3Bpk/9eGzgbnfvXtYPq/qYK0h1FHxY11XW0LJO6
	 X5U4Ga03gpczm2/kr/H5Rd+CMqSMfDi8K0Z5/rj2GWpvFLVrka6go9E/RDkYN5A2X+zDl
	 aPLfBFQskSKI9isaWaMU57/teRtpBeYDUq5YfvtqYXiKYyDqz9xSxP8Bdf6KiNJ9HnPJi
	 3ozKEwRcIz4B8FJOGH4sGPmOZZlfIJhZJSkWY6MIQqNCAP9OqhyBi/xcVGbJPbysvqzg0
	 6j1YXGWsGVBPS1NEHV8lL0Zg2fp2CYMiNJFfEwNyvE8OBjd0lSC8H9NmM0Tgp4QMc1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317663;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hGWe7ccThQohQGAYIY/6ujwiXNfkKZK0NgxBYRcnAhE=;
	b=Jx+Wf9NNveUDwOtMJxwI9EMSXXqXF3iIOCr8tuDyPHXtIXz4xSNbtfYfb9If+0P/CYmJ
	 OtUFFGuN1L0uthDQdNir4UMD6dbi+QWp8TTMwvWe50DsyFBkU/RbRjsVO/RAoNknhAKol
	 KCMRmHfwuso1cXgnRa2o7DwMYnrAvkiiy0bS6VCydv9zNg0GSZ7+VRIa6V1uTi/C5alFZ
	 +ZjTGIHElWAeKF7BMebvCVHSs41LzjtYivy1VV3pRoQ1kQVo0JTFKR6goSw55OeRpglcd
	 jcI4UTo8XYm4hU1/6OmV2KNIKA3v8EtM6cdYzwRQRtRg+LK3xuwd1pHm+f3jctDpNng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mda73Z9k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ED5606BFF0
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mda73Z9k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755A81F008A1;
	Tue, 10 Nov 2026 13:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794317663;
	bh=hGWe7ccThQohQGAYIY/6ujwiXNfkKZK0NgxBYRcnAhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mda73Z9kAi4K/4W2Sd4slgtBAN13ZSrAQ9l1sEqAFIZE1RBi9LPphEH7TqKoCADWK
	 +0wabRkvwcLHq+/t7bwjwNO8hX5uD9nD6dXTZrB1Nwk2L9sA3gDy+PoXUrMu7gy+MW
	 3FLbsPiuhUfvkJ2xn19dO0u855CGz15E2vifrgPXI3GE3idyH6jefqZ1QX/RtV4SeS
	 NSnI3m2J9YBVffcu15XqGMgEDEn47nblVY4GH2QREmcrCR68R34AvhyikfBUNSxy+Q
	 KHLd8/NoKLoWfqbUcQ63pDXa3+IPRNiTn3kl9UqbnoQweYxHrRHYB1YScbWDWmT4U1
	 ZybMeOTyVsJ3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] dmaengine: qcom: bam_dma: free interrupt before the clock in error path
Date: Tue, 10 Nov 2026 08:34:20 -0500
Message-ID: <20261110133411.1751833-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110133411.1751833-1-sashal@kernel.org>
References: <20261107060303-failed-5.15-82eed160cfa7@kernel.org>
 <20261110133411.1751833-1-sashal@kernel.org>
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
index 91a0669881c9c..a417d749f27f1 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1300,8 +1300,8 @@ static int bam_dma_probe(struct platform_device *pdev)
 	for (i = 0; i < bdev->num_channels; i++)
 		bam_channel_init(bdev, &bdev->channels[i], i);
 
-	ret = devm_request_irq(bdev->dev, bdev->irq, bam_dma_irq,
-			IRQF_TRIGGER_NONE, "bam_dma", bdev);
+	ret = request_irq(bdev->irq, bam_dma_irq, IRQF_TRIGGER_NONE,
+			  "bam_dma", bdev);
 	if (ret)
 		goto err_bam_channel_exit;
 
@@ -1338,7 +1338,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	ret = dma_async_device_register(&bdev->common);
 	if (ret) {
 		dev_err(bdev->dev, "failed to register dma async device\n");
-		goto err_bam_channel_exit;
+		goto err_free_irq;
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node, bam_dma_xlate,
@@ -1357,6 +1357,8 @@ static int bam_dma_probe(struct platform_device *pdev)
 
 err_unregister_dma:
 	dma_async_device_unregister(&bdev->common);
+err_free_irq:
+	free_irq(bdev->irq, bdev);
 err_bam_channel_exit:
 	for (i = 0; i < bdev->num_channels; i++)
 		tasklet_kill(&bdev->channels[i].vc.task);
@@ -1382,7 +1384,7 @@ static int bam_dma_remove(struct platform_device *pdev)
 	/* mask all interrupts for this execution environment */
 	writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));
 
-	devm_free_irq(bdev->dev, bdev->irq, bdev);
+	free_irq(bdev->irq, bdev);
 
 	for (i = 0; i < bdev->num_channels; i++) {
 		bam_dma_terminate_all(&bdev->channels[i].vc.chan);
-- 
2.53.0

