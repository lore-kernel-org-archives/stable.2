Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317921;
	b=NSYM0WcactqYbmCIDTHoj1E69ckuN+1vNHkgJM+7DbhV+b71hi3Qqx+xITKrpjIGsoy9
	 nZRBipIivThHxAdpk/auUeHAJ9k1FH6hxTvfW8NKs9/YRK/Ze3wTBoHr7ST6ON+04GZlE
	 ogk1BRH4eGUCx61JSzBZjj4VGPGlRw95evfawvRDtDFR4nKKPrTH3v1bQMb9J39rBQDSa
	 UxAb+CCowl3MJ1EuAfkKnpqQSDC+yv+4F3i4x4sbjDvQ0tEikvYwzetBObhpnyqSy0/Uq
	 Uk5dNBnhLCFEnN3Sj9RqARw1tj/9YM7A4hZZtwIGUTQn0sO9qfb/OqM9Zyu34vRdylA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317921;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Cqe1vLZO7s7N4r0BOAraVo7ptaxEroJXReVM8o3IbOg=;
	b=xaF2TYlQyho10ZCReIBVI4RDtoEm6fO3i/SPUWi19s06s2gC8D5Vc3+VYBry5vh3J2iY
	 qmDzkhmjZRtACpRTey/0BcR28hLbeMNiCygc2qDq8QoLz4qVXpAR4dCSXFj0GNM8FFIPp
	 iApd/VaqnMQr82Xd45IyPsNtMYED16IyWj0kjUT7ZLboQPc7hIdHCSXvAlajGBJLUU6Kr
	 anf3ZRTSuBI5hVNPs4HPylp7PVrb0caIMFEaWbVKl0QG01YnVhaH8oln3hifsNTwW1FLh
	 /7h4HO6jfLZVzIQnPts/mfL0tTAt/gKLDkqbdTyLecyo+XSwapEb6usnLS7nxeAMpRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GrbCiu3Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7EF606A76D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GrbCiu3Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFC01F008A2;
	Tue, 10 Nov 2026 13:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794317921;
	bh=Cqe1vLZO7s7N4r0BOAraVo7ptaxEroJXReVM8o3IbOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GrbCiu3ZRmx0cMbi5shqQQCWY+zDMtbwu4VE+8GDaRsFOnILbXTUxTWk/Ir2MxaTC
	 nuqXDqwZuiIHQP5qj0RwuMcCIPI74gscAKGps2a7qUrH4GC9iXU/cQA0Uyd53DIOn4
	 Nea5pjnk3Z8/yDj66OZnOwMV3KoaHO5zhswtIRRYNlkdukpDYIbpkj78OYoO5A2Fe7
	 /5GpsGfjBgdGVyu6Rr2GRcD9BUt5zrqH75JVYYVSonXXMCjOdPp3ne/K5n5Nb4MKbw
	 nDIIV3jD/EiU9h31aaGXcDPynRFVt+LtYBlpNGatUJIGNLU5pmSynUir2jvdy4ugv6
	 qnXVNjr3IWuWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] dmaengine: qcom: bam_dma: free interrupt before the clock in error path
Date: Tue, 10 Nov 2026 08:38:38 -0500
Message-ID: <20261110133832.1761148-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110133832.1761148-1-sashal@kernel.org>
References: <20261107061942-failed-5.10-82eed160cfa7@kernel.org>
 <20261110133832.1761148-1-sashal@kernel.org>
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
index f931f074dcdb8..f6e38ff973a66 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1312,8 +1312,8 @@ static int bam_dma_probe(struct platform_device *pdev)
 	for (i = 0; i < bdev->num_channels; i++)
 		bam_channel_init(bdev, &bdev->channels[i], i);
 
-	ret = devm_request_irq(bdev->dev, bdev->irq, bam_dma_irq,
-			IRQF_TRIGGER_NONE, "bam_dma", bdev);
+	ret = request_irq(bdev->irq, bam_dma_irq, IRQF_TRIGGER_NONE,
+			  "bam_dma", bdev);
 	if (ret)
 		goto err_bam_channel_exit;
 
@@ -1350,7 +1350,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	ret = dma_async_device_register(&bdev->common);
 	if (ret) {
 		dev_err(bdev->dev, "failed to register dma async device\n");
-		goto err_bam_channel_exit;
+		goto err_free_irq;
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node, bam_dma_xlate,
@@ -1374,6 +1374,8 @@ static int bam_dma_probe(struct platform_device *pdev)
 
 err_unregister_dma:
 	dma_async_device_unregister(&bdev->common);
+err_free_irq:
+	free_irq(bdev->irq, bdev);
 err_bam_channel_exit:
 	for (i = 0; i < bdev->num_channels; i++)
 		tasklet_kill(&bdev->channels[i].vc.task);
@@ -1399,7 +1401,7 @@ static int bam_dma_remove(struct platform_device *pdev)
 	/* mask all interrupts for this execution environment */
 	writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));
 
-	devm_free_irq(bdev->dev, bdev->irq, bdev);
+	free_irq(bdev->irq, bdev);
 
 	for (i = 0; i < bdev->num_channels; i++) {
 		bam_dma_terminate_all(&bdev->channels[i].vc.chan);
-- 
2.53.0

