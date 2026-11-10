Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317142;
	b=g061r1GrPPp9Rv/wRNnvfnGxSb5Oyq/QVvrDmZtXALziUBpiWoIhd1mk5aA8qdWGumed
	 Dnz5HeW6lPrij9NIkZuxyaQHEihcQcqO0NiVT0V9tRgSyChtTdFhRtNKVVfgQd5lsoY9r
	 m9+UCIw1rJRW92rHc1VRW0aEw7e8MRyU+z3fcUVCMbvE/wUvIvLqXYYucCGnQ9pG22sFP
	 1hrSNsFifr0eNslz7mPNouak9mnNM15Dv4kyNv+MPRSF/p/HlvffK8sEbelK58NQIuLSL
	 4MIZEl4ZW6lGZqKh9wyxGKVIk4n9BnnxKt1VBRKKTDKALrZxahWIqbcOEVnGalmE3WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317142;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cN2gXsWbGJ+9b4OwofzelOLJIEFtVd3YAn1ozwG9Q3U=;
	b=o8bBzW5HTMC9e3fUQ5vsEzoNV38+M2adBaeOZNz/jZVNW5X/gqdyQaVlSBNEvuafkkOm
	 yFIHrPAVFk3m6unvAGw6SuN+I9N0bgi5AzPLIx1j+hCOGwgtOupy1uNWfMH6e/MO6yXKJ
	 nhS4q1XQaRxKsOxOyroQFJKJiQ2+EmNN6wfpa0drEHSqiJgvEDnTZQw+VaP1BIGLvTEfu
	 qusp9PvBEqz5RqYpxaieYVpXZKLXDuG+oiyV8yIxpZpKKRWH5WcdoSau4fWcsSB+Zg/4H
	 f2vugcFlBGsGEwd6DbMuLrilMary99Le0nYdNo5e4HsLukjojXhbwt+M0ul9swlLbhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RdJI9Gm2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF5F60727B1
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RdJI9Gm2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60481F008A7;
	Tue, 10 Nov 2026 13:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794317141;
	bh=cN2gXsWbGJ+9b4OwofzelOLJIEFtVd3YAn1ozwG9Q3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RdJI9Gm2e6ZBs6T2pQrhI+0eWs+VxrL4TdKeAR04/cGkcVzySqYM4uuM5Tj/6Xow6
	 eQnXlNYy5+8jnEEtDQ1F6XO0t/ON30uJBryOoRR3C7u3WkrYQiLddAYw9tkAvX3mqx
	 SEq5mW4nfbu86ueMijoFR74AsXl8qOXxBoLkM3nlmGvMUq2BM6l6BWP8BispHzy4py
	 YhxcWrRzCY1RD4vv24pdy9/lIY3MpVINB6RLVcINQqN9dAU/YnUDgA45t1HhhuJr7r
	 Ssueddv4cDupeeUxMqeaUGAU5eO4+6v53Tb5j/Hh/8aAqVBTNjmqeGmtipj7PXNDds
	 c+hjH2Z1JyH8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] dmaengine: qcom: bam_dma: free interrupt before the clock in error path
Date: Tue, 10 Nov 2026 08:25:38 -0500
Message-ID: <20261110132532.1732443-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110132532.1732443-1-sashal@kernel.org>
References: <20261107053248-failed-6.6-82eed160cfa7@kernel.org>
 <20261110132532.1732443-1-sashal@kernel.org>
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
index 03638e4f505ca..3b713d760a1cb 100644
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
 
@@ -1360,7 +1360,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	ret = dma_async_device_register(&bdev->common);
 	if (ret) {
 		dev_err(bdev->dev, "failed to register dma async device\n");
-		goto err_bam_channel_exit;
+		goto err_free_irq;
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node, bam_dma_xlate,
@@ -1379,6 +1379,8 @@ static int bam_dma_probe(struct platform_device *pdev)
 
 err_unregister_dma:
 	dma_async_device_unregister(&bdev->common);
+err_free_irq:
+	free_irq(bdev->irq, bdev);
 err_bam_channel_exit:
 	for (i = 0; i < bdev->num_channels; i++)
 		tasklet_kill(&bdev->channels[i].vc.task);
@@ -1404,7 +1406,7 @@ static int bam_dma_remove(struct platform_device *pdev)
 	/* mask all interrupts for this execution environment */
 	writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));
 
-	devm_free_irq(bdev->dev, bdev->irq, bdev);
+	free_irq(bdev->irq, bdev);
 
 	for (i = 0; i < bdev->num_channels; i++) {
 		bam_dma_terminate_all(&bdev->channels[i].vc.chan);
-- 
2.53.0

