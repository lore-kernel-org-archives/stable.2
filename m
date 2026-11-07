Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046172;
	b=PT/2pmIO2IDqVeaq9D7K7NTnUpvJM8YJrvRsErO64z6QqRasTuvL3XVPFUkESEYeZ1FZ
	 Vs4Fi3Xp6THLcB7id1M7fA9XhHwylURXHkOZPV8YrXCclTzMWYqGZdW9sQ0FCKsUFQ7Tt
	 d0edCaJu5KYsF3MUxK8y95Vn7H78z3NJY3lgx3jAcYC0OdIzPbttjud108/3YK7439tIJ
	 09hLWqP6m1X+RjVV1ATn1OyzhrEIsxSpjetiaNce9n0Cge69bEoDDItxL1VIe+LLw8Nax
	 uPWds638ipGi9cRcukgUF4hdfGxkshKa8OkfEy5cU9qF6uLKT2p7Xm+esEVwYDQKFsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046172;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BB2sF0Zd/qhB6g2/hWDJSaefjxyfwm4LAKFSF+Vxwec=;
	b=bYgxP0E4to3qfDBDGUW/HN9iREn9u/qqe2LQJCXsxNkwrz81/NPkU+w+Mz/BXRDXwrNd
	 l0wO4hyPsCceCoyhWAMciZaos2naZpACHjnTZh2WQqCAEkUR3Yz2DdYjkHglsK76zhCFv
	 KpTUcHCNrlxPmVq0wi/xbcEX8DLZ5K0AY8O/GVEMvGVAyoV79SRFy8HsU9vJdH/d9LIEf
	 TAgKu3fIk9hYuWN2xZyPm5QFI+iIwu0LDIUPBmEC3EqousgME3XlJNwq/Mg1wQPqt/V3T
	 P7T/4J9fgoKTAdxcPjdMio+KygxZ5azN6rjx0V5UZdQ1dV1i/iLfJQdVUD+MIUUXZ1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ksNNvscg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0592606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ksNNvscg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18ABA1F0089F;
	Sat,  7 Nov 2026 10:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046171;
	bh=BB2sF0Zd/qhB6g2/hWDJSaefjxyfwm4LAKFSF+Vxwec=;
	h=From:To:Cc:Subject:Date;
	b=ksNNvscg8FQmAQsht1iwElwnFm0RAxDd7SO6mYNdqlTkEzey6WAa5lxX7NxPSDzZy
	 J65cGLh3VxwV09J3Eib+2Ba1jgRIheNDvb9CzXYL5xZ0g+QgkOP8U0L2Wgyr7BzJBC
	 kcJENLthKXbXhfqK8Rkt3rlv5Xt2DbNHT+sJBr7V/JGKovVvku0QkcQ7t0iz3URxQF
	 9hGVbenkaCm1VxhfX4jEJRPDgqhB7y52DMcEJjK4NL6CggiVzLL2b9ChCJzkLKUGrT
	 xroPq2zyq0cc1S6t+bH9HeZrjxJGUG+T5/aVmpbnqkIDVC553XcmX43NObkFfwURn0
	 eRF9U8VZBan2g==
From: Sasha Levin <sashal@kernel.org>
To: bartosz.golaszewski@oss.qualcomm.com,
	sashiko-bot@kernel.org,
	mani@kernel.org,
	vkoul@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] dmaengine: qcom: bam_dma: free interrupt before the clock in error path" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:09:30 -0500
Message-ID: <20261107050930-failed-6.18-82eed160cfa7@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 82eed160cfa7a296ae4eb5acb8dd8f493323eea7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050930-failed-6.18-82eed160cfa7@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




