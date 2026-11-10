Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316291;
	b=cVi7h7Wl6nGUNWbjqu+or37R3usvtHwYxVEk3/ah3ROtoa7dIo2re74WW/6GJ+IuYGOe
	 THyV3Q0GfSnMc/T/YGOfuT1X5IewprldIq8zjpW3DdjqiAC3P7qtVYkL0XrGYcJkISHn+
	 4Vvv2HOJ8BWxBXKdXdNK0Ih+Ui5f7vI+QFxgrlDUooPLPTTpYmZisdCaMGMkX/0EHUFwi
	 ZbSWE4bKA2BQuR/UVDJu4eDpVKj3hfkKgHNoXbGzwZRSl1DyfBRCQS4+Qv2M1r1M9KgeH
	 7o0QyhAJd4snnMv0CDYtLNIbICaNheFNgkDP36L2FVmtKnVFSwcCv5qG+rrPhGNBVEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316291;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2MEFNZXV0Hnj22RW5jl/YifyHrLuxyoT3kyorSPGDr4=;
	b=Gj59lCONgANMP1Pj5UdwDceXVsm8W5RCjI7sUco2GgwzhEjxbH3qYwwyQoaI+q/wIUX7
	 Wsv05iVaDCcWmnT0IDJIS7+ggZk4ugItowBM7YOaZyz0ftcCWAYbzd0tv48fmudDaDNwS
	 xlj7KCRMnypTU05yACrtCjk5yg/0PRpiRGRUvIein5PB1CBosPRXKA8eyj9vf0GspqlSK
	 BFbIVzBrMDuEqaaTPsFLcRNKRS/w1IR/AXyF90cadsXGkxjDw2BC7aYGUiKqe95F9afR1
	 9fYh79rQyYVbVrB5hFTKVZ9ihT0lmtGNqb0Rx6dWasa2qRnrMLEQnWRD4HAmV0tLOIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IfaTr9CA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C6B606B2DE
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IfaTr9CA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6771F008A3;
	Tue, 10 Nov 2026 13:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316290;
	bh=2MEFNZXV0Hnj22RW5jl/YifyHrLuxyoT3kyorSPGDr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IfaTr9CAijlAnzS3WWKA3osOeFBiRvowuTTrRh38bBbkPJPjqKB4tXial8qrfSyC9
	 4Bf7V6O8WNqtaC3SbN/tw6wcQU+6VmbBriKe9UtLhAMYsijH9foO9K3TXlLEIDdCFn
	 qEHrEJuQ8xXS6v00SmYNgSIzQgJwsuphkKS/HSWYnK0Gn0VMv0GZPJIBgpdYXlGrVj
	 LOV78voJoSRrhHVTeHUS5VAl9PN8qVVG0dH+dfkv6264SXNAxUtROJsNwCjd8Fohj7
	 G7rM+OGW/HRg/LwzNr3GVN7sK6V/Ur8AFC0v7tt+CdTomyrf4zAtFi2AWw4j2G4yaC
	 pfSGRHp/de/vg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] dmaengine: qcom: bam_dma: free interrupt before the clock in error path
Date: Tue, 10 Nov 2026 08:11:27 -0500
Message-ID: <20261110131121.1652499-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110131121.1652499-1-sashal@kernel.org>
References: <20261107050416-failed-7.3-82eed160cfa7@kernel.org>
 <20261110131121.1652499-1-sashal@kernel.org>
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
index 94cb957d4b187..f67a93a37d48c 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1332,8 +1332,8 @@ static int bam_dma_probe(struct platform_device *pdev)
 	for (i = 0; i < bdev->num_channels; i++)
 		bam_channel_init(bdev, &bdev->channels[i], i);
 
-	ret = devm_request_irq(bdev->dev, bdev->irq, bam_dma_irq,
-			IRQF_TRIGGER_NONE, "bam_dma", bdev);
+	ret = request_irq(bdev->irq, bam_dma_irq, IRQF_TRIGGER_NONE,
+			  "bam_dma", bdev);
 	if (ret)
 		goto err_bam_channel_exit;
 
@@ -1366,7 +1366,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	ret = dma_async_device_register(&bdev->common);
 	if (ret) {
 		dev_err(bdev->dev, "failed to register dma async device\n");
-		goto err_bam_channel_exit;
+		goto err_free_irq;
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node, bam_dma_xlate,
@@ -1385,6 +1385,8 @@ static int bam_dma_probe(struct platform_device *pdev)
 
 err_unregister_dma:
 	dma_async_device_unregister(&bdev->common);
+err_free_irq:
+	free_irq(bdev->irq, bdev);
 err_bam_channel_exit:
 	for (i = 0; i < bdev->num_channels; i++)
 		tasklet_kill(&bdev->channels[i].vc.task);
@@ -1410,7 +1412,7 @@ static void bam_dma_remove(struct platform_device *pdev)
 	/* mask all interrupts for this execution environment */
 	writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));
 
-	devm_free_irq(bdev->dev, bdev->irq, bdev);
+	free_irq(bdev->irq, bdev);
 
 	for (i = 0; i < bdev->num_channels; i++) {
 		bam_dma_terminate_all(&bdev->channels[i].vc.chan);
-- 
2.53.0

