Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045859;
	b=h5iZC3N7Uc2mPxhmRwnEJuA7fPfpnfoVlaG8uAeV1Lqr0/IOKUCbCklqdPD5NeEvuJbR
	 fwNVlT/62zTDnBHXYY2APBKaLrjmjVuspbTXgbc3CAI6bfcuBfQn8PxC1+OMrjeEnAI4f
	 Cg5Il3v2WQLb/H3TFyI0lHZIsSGJ+lWrcsEOkF+qF1fuP4GG8fd1hf1EDQdMLhVmEqRwW
	 vLYaGh5ZCJhdO8/YFNtqCJtm3jcn8JYv0+Kk1QdRQvuh/6eJ7pN7dWKDmNBWoFUqsQjBh
	 fGpMoUlVL6F7EPP83b9b+dcBtZdrI76BzY0YvuRGA9ZBbY3jLPqFQRQYIQeh/owcAbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045859;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rlDWeTdWhi8f1EZ8y3vh9ZuSFkpO8kFqmgmdP2eJeSQ=;
	b=KZWMkXkN/CgJK00UzFZjqwy3EG5UbLc9BsVUohfOGBeCdaqKkc6hPT13E9xTatb5/Kqo
	 xBiU6yWXji9dQ8EOWt73yQICzPjSFbDq1uCYBVk+ccm2HrBgiSACogyLwnqKEGUV/pCmm
	 0i4xJ+rVNzVSPcsXitWs0uh5+j6baMZqL026C39S6j5hsLf/B9spiGeZZ1HdNR3FiLzdJ
	 m3zSVy8qIg0oaGBTmOlQp/4aBNNhcv64bEd7SUMuMclDXs/m6XatVObfj/s0DH9JS6PmK
	 Vo1BZIRChhKR2ba5bXH2K4cCaP4M9owwdk67zEXmVOginsMNhGWxvaKFhh8ocCSOMRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kq0Iyd3H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99FB606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kq0Iyd3H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A17F1F0089F;
	Sat,  7 Nov 2026 10:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045858;
	bh=rlDWeTdWhi8f1EZ8y3vh9ZuSFkpO8kFqmgmdP2eJeSQ=;
	h=From:To:Cc:Subject:Date;
	b=kq0Iyd3HCAvrgVj7Cwb+WZRpRS4wnmXb1U6UhKdnQ3GNz9+Y/cevGXdlk3njQibgi
	 eLALP9MbCHwrsE/6kT7YKG/74Auh7C6mMt0hMnYqQCk/ItAa+vIos7eHM4gymuZe9v
	 9PTxJWNuC9yKm2jtab0K2R9/jZIdTNrn0a/5j2jJMbxh0iAwE4evjbinlVWKZUPHUW
	 7eZpTI7pNJNN9Js6Fv0FX4rSzvA1SI3FNAgHcuVj7bYZLOteEVRmPrfkHTGWHQhViQ
	 lInx3O5VvmLzRMGgiBGAWMPJtYrxcLuxt8M34yA7ebJ6ylL38SJtMrJmM3FvAknUAO
	 JdJwXnqQ6BzZw==
From: Sasha Levin <sashal@kernel.org>
To: bartosz.golaszewski@oss.qualcomm.com,
	sashiko-bot@kernel.org,
	mani@kernel.org,
	vkoul@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] dmaengine: qcom: bam_dma: free interrupt before the clock in error path" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:04:17 -0500
Message-ID: <20261107050416-failed-7.3-82eed160cfa7@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 82eed160cfa7a296ae4eb5acb8dd8f493323eea7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050416-failed-7.3-82eed160cfa7@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 82eed160cfa7a296ae4eb5acb8dd8f493323eea7 Mon Sep 17 00:00:00 2001
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 11:54:35 +0200
Subject: [PATCH] dmaengine: qcom: bam_dma: free interrupt before the clock in
 error path

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




