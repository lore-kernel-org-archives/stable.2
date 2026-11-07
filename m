Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050385;
	b=pGfT+DnwGJSBX+K73UNtFUQrqzsiYLYjYJbIT2D6fwbT5Wd9uIXQXtGIRo9ewNAOXEB6
	 QOo1JpGGwSF/AH4WrVLbcZGQqUrYwxLKBKHIwfmhOBUjOAbiktQyr+WStK3nU7khQpbDd
	 Vd+2E0/+QPqGfSwfyLRLg6Y089Ja82sRvaycn0MLpG+vDNRPlX3szxLhkvY+AkkFxvGcw
	 1ACz+u8KrqdK26u/z3CKDDYxN4HylM0sY1DEStgCee127SLx6eAoVNc9JTconeA4I5YHU
	 lL21AQUNcCJa7Ws45bnVYiOadaSwnGznZiM/PYzBq2DsqLNkpc8zqVlxaluklQEJCCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050385;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sqKsGUHCHOnVbdU1LmtwGXHxCBweN6M+q388qUI23pU=;
	b=sFfqBi0DsVOdMGIkj0KZdlYOa1b5TfS1pKKsQCpEUBC7wviucrlhQ7AWzQ/8n7+/TMRQ
	 AtLUh44hDzJXQw1Bx3CvGfzCtHbuFMA1t3/AJTQOAzd5rd7je0FDjRRl0gxFoeUwYzcrD
	 tjrSRwDoB7ysP5j11YBL0Y5jKBOE91GaHDUHYqZtTfg4F7E21vUerhgHbayrG6ZiHtmyM
	 FvGYmuC2xjrJA6Z9+8VsQkNNSFafoek1VDbEIfarrTPJlkcPScf1X3fexgnlRVzprIC2s
	 Op+MNb2+W3R4pBDUIjFY8u9Z/Z1+YmReeOW/2kJf/WLkQeI3lIAGNevImjyf8KmA1wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="l/WR/WXr";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D93606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l/WR/WXr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6211F008A2;
	Sat,  7 Nov 2026 11:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050384;
	bh=sqKsGUHCHOnVbdU1LmtwGXHxCBweN6M+q388qUI23pU=;
	h=From:To:Cc:Subject:Date;
	b=l/WR/WXrTXFRCvhxix/jmtj2yim9qeektXNdYLcnoQcnWhE3qzvRVUgpgWZbEEdhP
	 6ZlWXPhkC2f1LlUmt6/cWxJss5WZizkFviApLXELChw4UUVAzFVOBaOMZ5AeCXFjms
	 aLOs3wlemq5liexmb7dd4WHAdZhBX7wqwnZ1ZR5bBl/DrjRl3Acl15LM/owdmWohkH
	 IuZBIVegukRHg5sL5P0Ubx/W2nG0sKdEfZL7JKW/kuKG4ULlsYL8uhp4v7GTAepsH5
	 SWVn/p6BVx6FB4ttN8bNEujYk1i0PkX3O0XAe3pDnRb/EE8K0LFmzOr8biEDHUsYWh
	 TSi3bGxwjUeXA==
From: Sasha Levin <sashal@kernel.org>
To: bartosz.golaszewski@oss.qualcomm.com,
	sashiko-bot@kernel.org,
	mani@kernel.org,
	vkoul@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] dmaengine: qcom: bam_dma: free interrupt before the clock in error path" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:19:43 -0500
Message-ID: <20261107061942-failed-5.10-82eed160cfa7@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 82eed160cfa7a296ae4eb5acb8dd8f493323eea7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061942-failed-5.10-82eed160cfa7@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




