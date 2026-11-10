Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317920;
	b=4pOBjG8K+o3i6K8wSiNQmIUPAfAX8PEPt2DlAnJr2JLigSv0v1g4x4mYgS9SURxPXU6I
	 +iAGjxM4qcC1Ea0Q4emaF7xqEL+2hbtkCqQsceU7vU7noXUyEmwn2dgSOXm2X6NWm8Z1T
	 kuVGpXxzX60QEeiOb2ReZdgsROJyaw2tFLy9SGUXZ7hlExNnITbfmmeJ8TA97tPj6cQKm
	 0YiKZB2RfUVSF+4keOuKqZWFPVXFHqo93cyK9FGTQscwmrD3J7lWjXKElRcPvDOiuYa7P
	 21scM4nWv/pDY+pKii8jSlw4rMuJUCPKgNZ4o+rWCVIIEDYpnWuGkm9uRYhWQBPeZiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317920;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EXF8DtFxXRDIHdqOZZHQMbT0zAS7n+l/xOVYsTiwyQc=;
	b=QQ/24uCBjTbW+bOkR5KQvK+0Ugae41G5EQm91IhkzUthmKbK0nWz7/GaCiGbyYEuZWJr
	 8mR7m4ZcyoR4jgzErmKTsnofQaYDtCXRaT4anNEXAbsY63v35iGNDP1+DwJ9+zUUqtkyU
	 F7tz78pdNqE/9+u5SONk7C9sfjoSXZJzMMnroBaQvd/GJEy4Rnesl5RRvxZgA1bc/2L9U
	 VzGu4ebpYDtJuvPPL0nYM5VAIf02xcVWG+UMj9BU8eKc9b3LQ7Bei2sKHV/2euKTcYkNR
	 Hlzxbpahd9g2Pox7nEskBrN7lqnb3VSZX3/MYTXr3Tvu6MOSqGpwnhgAIkZQbV0cMuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fcOlqXqU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940E3606A333
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fcOlqXqU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709E11F0089F;
	Tue, 10 Nov 2026 13:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794317920;
	bh=EXF8DtFxXRDIHdqOZZHQMbT0zAS7n+l/xOVYsTiwyQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fcOlqXqUU1dAMCdnGU+rWjdvg3jorYnrU613g99a/3k6VDTce1zbrXZ/PuvSRsCQZ
	 TPnyIbpYhEy8zPH1KTJZS9kQny+o2BZt6Zs+EWXkG3iK4QTAjQN04rV9ga9gVb/ykV
	 1KlMWjqvXaLbIefHcRF1yzzhghtN1O2vBGc+nsx1O3bJSwv8u4eiPKvm2yutCc7fA+
	 7ujBCkQHkzZtMtdtef1Rr6el6nOkyANN6v2eb/r/uBCGFWTqGSxvC1GcE53QIk8gIc
	 y30txUqkqUeBTZ3JDhlezCIKQOyEctBGtZc9cn094323xvgtsobyeMgyEKYK0HB4wi
	 wVZ9wQaNHhs7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
	Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] dmaengine: qcom: bam_dma: Defer IRQ trigger type to device tree
Date: Tue, 10 Nov 2026 08:38:37 -0500
Message-ID: <20261110133832.1761148-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061942-failed-5.10-82eed160cfa7@kernel.org>
References: <20261107061942-failed-5.10-82eed160cfa7@kernel.org>
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
index db9359d259e24..f931f074dcdb8 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1313,7 +1313,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 		bam_channel_init(bdev, &bdev->channels[i], i);
 
 	ret = devm_request_irq(bdev->dev, bdev->irq, bam_dma_irq,
-			IRQF_TRIGGER_HIGH, "bam_dma", bdev);
+			IRQF_TRIGGER_NONE, "bam_dma", bdev);
 	if (ret)
 		goto err_bam_channel_exit;
 
-- 
2.53.0

