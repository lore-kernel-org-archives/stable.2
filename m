Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046820;
	b=iDa+Pz80FtQDV2IF1JDTgZjL6kp6zii6jZbJKpSWjqrCkrWQwdBekdYUSSCUtrS6fTEr
	 NeN/s7aq8jvYDUpFvo0P4agPUOwUX+VOePafBM3Md/cMAq7NlexPtBIkJRT+8Xe72uEvO
	 pont90INFCOIUXjDydFg+jdTUJIUpOGvwZi/Mzzogi4avxockAv2jyuSEJNK6rswf7Cvt
	 kXo2L/7Bspcct+MxsmpJtFk99SGjN6K1rr5NRI+uBl74wokqwgc26nwluJ5FTZYcuDv7c
	 s5rJC9Bf64kqo7EW2ZO/N/Et0Y5Cr44cZ9CkySAhfuUM4mwO32gN8L65ehcp2/hzNjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046820;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=05JAFfqns/a4WR97LMJaWxHTdQVCaPxWJl9jKWOmwD0=;
	b=QHFXva7ibF/ej0j3Jh4+KIr86oj4OPhlFppjwgioyRec0CMgVP2Bjviw6j1ne0uvmdHQ
	 psQyFg8IPwPaQVux4HOzumwv0TsWhKlISKaYJl20d/ANo8Yt1hqFFNNsCLa90JOa6iOZJ
	 wFTbdfIYeok1v7UfiDBxs6usXAqLQrHvphEidGbXCyLoQId4tGxC+fRppAXthnvCvjzEC
	 GcWGy4NJF7LNFutcUxQZ2enHztrOtzBB5LLdr8A8HKM3WSPvoXshimbv1/8/V20zEoy0W
	 lv/1GwDb9YyZiPF1D/xRs02IEKGU7AjXX/2Vm8fD2xriDrnQ8xwzCvVWxyU/8A2N4Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TvUpjtjt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004E4606A8C7
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TvUpjtjt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459D71F0089F;
	Sat,  7 Nov 2026 10:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046819;
	bh=05JAFfqns/a4WR97LMJaWxHTdQVCaPxWJl9jKWOmwD0=;
	h=From:To:Cc:Subject:Date;
	b=TvUpjtjtvdZd7stK5p/K1E9g8VnKfksnL6zSx0hSNjVH08RxrDdE59gRJnWgvGyUs
	 L1C1gSkpu9VDJsaELxUI8obbv+rRW6EigRfL/jObnb6yWsdhcsZR24BQsKJShcaLmP
	 t27Kb1YDr3JNibZdgThkln33qTb/NmUsfOHX+WNasZcKc14tuWcfXFFw+eSFUU41nQ
	 zZLbLTP6o/nn7N+Q7e1+z5+iVmrPQR5yy2Rm3HPYxy8jZWnx6W4FIMkbvvWd3IeXH/
	 l6p/nyYeN8dribfx1/qppJjDq+JMQnFVEPkS2sRPguSNQEGY7kQ6mrf5BVFIpbSoBZ
	 j3F/6gYf8JqZA==
From: Sasha Levin <sashal@kernel.org>
To: bartosz.golaszewski@oss.qualcomm.com,
	sashiko-bot@kernel.org,
	mani@kernel.org,
	vkoul@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] dmaengine: qcom: bam_dma: free interrupt before the clock in error path" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:20:18 -0500
Message-ID: <20261107052018-failed-6.12-82eed160cfa7@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 82eed160cfa7a296ae4eb5acb8dd8f493323eea7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052018-failed-6.12-82eed160cfa7@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




