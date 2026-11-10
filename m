Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317408;
	b=MCN00Sjm2VmqOjMSdnpIqnYB7AsDvLfzP71XSRow1A/NYoD4L/0yg7seR50l2PKe7XR3
	 +lVcJQzUUKDBboeWvqV+YTNcoOAqUM5jm+PZA5z3s7y3+MxvVEPAGiDFEReNSwixB5n8f
	 1AIXQ3yP73E0X8y2b7rBtXiS0PraYT+4g2wQ/bMUsH8crluxfF1rvHrA4QT8zM9LIMvUP
	 8HmpalitMj+w5TfAq/VTcTk4fbrc9i8stQ63aOHXb2Hx53mTXMBjfcQkXfaPtLAW/8gJV
	 XaOXBY3TumfajNVvml8idoh4Qe2F8fSt9hxRnXPsRBIq4TBLqWGPxly593/pf0wsy3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317408;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=79qoMMpetyvxIRqmWTEM0hbHVUwFSfC3T3e5lGU3hAI=;
	b=N+WrspqEAdajZGdI9fYtqJea+CI9FXk/XkqdXJ8gRp6hk4ehuv1LFkYr2LcWD/Abd45y
	 j2nQV1JoZ7yCTRscMlvCUlFtlOlggzLFnmesJnBEQ7bove0czQDIe2F3yb99vERuGRyQj
	 AjjIBMo+QNzQcHW3833a8rFNuogvEJ8F5+YvlrQS3EURG+kb1Y7IxdyiNfgYfHcRC/Oy3
	 BJq6cCWajTkvJAO97VYDU+bpUA9Zzw9vrgxFnTwhe9dw1OkHID+nNefbtGt0uCpyLsO+p
	 70seDjK+L0RToLYdCHBBF+wtJtmi0PH5SDhIi/6Hm26E78yfsR1boREfGAW2/yKQQ8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxyIXi2B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B003B606B1AB
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxyIXi2B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C363E1F008BD;
	Tue, 10 Nov 2026 13:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794317407;
	bh=79qoMMpetyvxIRqmWTEM0hbHVUwFSfC3T3e5lGU3hAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RxyIXi2B1UhsYb61TiY5649HzAlYY3KX0NvqWkvGDJnXM5LLGhulp+Y5fGJUS3TH+
	 iIqeukVFx3L9gLe8vIo1iv7L+a/UH8bF5KxOJ/hBhpo+fRhTO8fcJ659NeHDCxvEdo
	 +tOt4Rg8bb3Uue+dxMBo7E3QRo0IzmjJx2s9nLeMnvnVLhzEFplRIqId072w/Gre5H
	 mGpvMGlAlNez0TtyPcJhkUzcU/qzN7vOGlQB8u1q0hWuESR1fkwkQ8keI76wpw2tRL
	 JoEoFUCwH091IdHCG+97z075fe7X4qwVJmpzi0gzh0dRodguUARY50YpoGrtnM8Bt/
	 re9QOjNN5lfQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
	Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] dmaengine: qcom: bam_dma: Defer IRQ trigger type to device tree
Date: Tue, 10 Nov 2026 08:30:04 -0500
Message-ID: <20261110132958.1741998-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054538-failed-6.1-82eed160cfa7@kernel.org>
References: <20261107054538-failed-6.1-82eed160cfa7@kernel.org>
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
index 68295eed43d8e..a8cf834867353 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1325,7 +1325,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 		bam_channel_init(bdev, &bdev->channels[i], i);
 
 	ret = devm_request_irq(bdev->dev, bdev->irq, bam_dma_irq,
-			IRQF_TRIGGER_HIGH, "bam_dma", bdev);
+			IRQF_TRIGGER_NONE, "bam_dma", bdev);
 	if (ret)
 		goto err_bam_channel_exit;
 
-- 
2.53.0

