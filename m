Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316588;
	b=KwVs2VhE0eEmVKViZ/qgc1/kGszNiAj56gBKNIJ5RUSzg745tR+TinzQR2e/My07kvEo
	 Srv8TaqC/g4gP3G2ocfk4pfWl7F3uGO7PIAKIrRj4Lu3rVg27UO6RluW5q/pUlccBJlVh
	 9yR0RX3QTZ/AZQij8c1BOyug1QY/WY1axJOHOScVK4yF3Y3KEXFzEr1i7+yV9K8ztfxtt
	 g8y1a06qBs67r729sU4e1UQw5yamcv45l9gHQkr4lO0wZEwAPQ1L50amR4ST+nW9FPzv4
	 D4pZGmTaiTWULbhJVFz9LtSntv0RaMFK54HZ92/yuQud9alP51vZ3X1svD0PyQmTWjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316588;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gigllrOwzM95tLhpBL7gKY3FKha8kawcJa87XHJqLLA=;
	b=KKX65vNa1W3tHd+nnJdcHY6fpYoC/QiWGhhIoZW1sy26dXCS4q3LfdAkfN9uelSCKTLT
	 nBqmFGDGUUJkWIn6CdRPSnvODSmiah187FuiT+ZAKWtIl8lI6+Swqlbdyx498y/FAc+dq
	 qvt3spMM0zVHjlQP/c42P82YICBzcNQAMb1q6s3RHkMiDSYdeAo1hrZnT/jRvKWJjkXhg
	 Ed7WJd9TX4W6RcO81D2/NAhOBrd3MW4QtA6IKjmA6xW8LUt8EGJ64MhWlU8SOfOwjL77S
	 7sNScf7H0t30K92BuTLi7uC1RpD8KxDAb0Xs5R93OBEMsKir+PNtQxgK2zTtSFxmAOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nBBIygyh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE1E60A3832
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nBBIygyh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351391F0089F;
	Tue, 10 Nov 2026 13:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316588;
	bh=gigllrOwzM95tLhpBL7gKY3FKha8kawcJa87XHJqLLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nBBIygyh76JI3UH2FG2aUHxRt0crdh4RxSco5VWG0j9FoDeMfg69dtIJk+IchVlLt
	 MpwotpZsyg+AsMG3YvexGfU8PL3jEeBO2yAyc7d76XcwGAMAEWLuSYH537ILn1NaGT
	 PVM1bDI4aiU15ylj2v2J4FB1BI0SNsvkkbHDAQeaFnoojauN2TGx+tBasvhF2h/sb7
	 2DP/5wO8wHD1TWgesMWlWTmIfa8qE/Tqxc3KnYSvbLxdILpvvVt3V51NSU6hoEFTI2
	 tHVAqKvd/ULp4oVTMjAgtNlvKah46MhohGTUzhk5mQ2lPYTizGbLRE4ZsGQudFQjcf
	 aIfvuRRQ+tfSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
	Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] dmaengine: qcom: bam_dma: Defer IRQ trigger type to device tree
Date: Tue, 10 Nov 2026 08:16:24 -0500
Message-ID: <20261110131618.1701335-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050930-failed-6.18-82eed160cfa7@kernel.org>
References: <20261107050930-failed-6.18-82eed160cfa7@kernel.org>
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

From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>

[ Upstream commit 3cee6f79553202d7d3954555560ac38d719344b8 ]

The driver hardcodes IRQF_TRIGGER_HIGH when registering the BAM
interrupt, which overrides the trigger type specified in the device
tree. On Qualcomm Shikra SoC, the A2 BAM signals an edge interrupt
to the apps processor; registering it as level-high causes the
interrupt to not fire, resulting in missed DMA completions.

Use IRQF_TRIGGER_NONE instead, which causes the kernel to use the
trigger type already configured by platform_get_irq() when it parsed
the device tree interrupts property. This makes the driver
platform-agnostic.

Fixes: e7c0fe2a5c84 ("dmaengine: add Qualcomm BAM dma driver")
Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260717-qcom-bam-dma-irq-trigger-v1-1-6405eac86f00@oss.qualcomm.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: 82eed160cfa7 ("dmaengine: qcom: bam_dma: free interrupt before the clock in error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/qcom/bam_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 781cea16196f5..c8cd6112f9003 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1323,7 +1323,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 		bam_channel_init(bdev, &bdev->channels[i], i);
 
 	ret = devm_request_irq(bdev->dev, bdev->irq, bam_dma_irq,
-			IRQF_TRIGGER_HIGH, "bam_dma", bdev);
+			IRQF_TRIGGER_NONE, "bam_dma", bdev);
 	if (ret)
 		goto err_bam_channel_exit;
 
-- 
2.53.0

