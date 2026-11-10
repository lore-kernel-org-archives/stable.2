Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316829;
	b=mc9MR3DMujv16Wlm4sWEMiljMW5v4OVNOwgnQxc8FkwUyJ9pZTRbtHNtlRh65zgEa6oj
	 QMbv3OfZZxbuM501FrEqwuLicOxD1JnMvBRprn5O2QpRMf/MBk/0Jko1cbjOjeKgu04Tn
	 cuVegXSF0NIQi6jqH6sBYsotVGb7Okl+/fq0u5mLJrCjAJw/JVIq0HC5i7iOvhy4hqsFi
	 R1yq7uvvgGWEmzkSND3MMlzAN2Z64lwQgxioYisi4R/2mvQviKPWQwQmbDgi/SPj8EBMY
	 4/oczksolR+S7x1i/Gggj0v56P25m7x6XW0EW/3sCecjFqbyDL8b0En04VG79Ylm6CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316829;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ruo6VB1U5tPJ1k1mSBsiQ3FVZ+zJFj4/swlGPGBBf7Q=;
	b=chT+6CNHNI0Xc134UXT6Z4icfoCo04mhXZlYKy1ouoqN0q5QR8dF6+f6ayeM4MWGvB9h
	 bQXAvHofNcI2sdS/c5Q1NeZdB85rygjmjz+F6Ymb6rwXKdC0Rd/J1uT8ekNKHf9MgLhKW
	 SVrk89tInK/1AxsFBNapKvy4OXtBopWOyHhWr2pHrYFQ1C8A1nwZjiJ17aGH3JIKgXEk3
	 ciCpWLEYleJGip4bT50HLreRAYlJHA+Y2eHDxEyjmJbly+yp0InC9As57pqCGdCh4dkpf
	 MSiey/lBnF+3M10QrqA8bl/LVmSmfSBkw2HAMJU0cLBNmcvEMdOpX2xN6x348/jUCtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AY1uCyEj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81083607680A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AY1uCyEj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574951F008BE;
	Tue, 10 Nov 2026 13:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316828;
	bh=ruo6VB1U5tPJ1k1mSBsiQ3FVZ+zJFj4/swlGPGBBf7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AY1uCyEji7YwQwRJ724NN5yrgLzSXPm4Eb3H7yR0uMdxphxxb0RHWqM91VLfWeiF2
	 CTt+BOqc0B5ENpsvFULYw2kfSfqWrsxDa/WmTdshcWHRrMRyBMPltDpLsuc2+DoEDj
	 9FGvNqDn63wQuOk3H/ygkvWTau0Y+qVn/n/If0kMWo9TRulxP5R9Bbceq6KG8wY+wB
	 bRyFTL73cef7k65IPpIlUwPxUyWYTOTXNxz4TQi+Ns6tJR2LFQtz2jyMq6KYli8Stc
	 gkqgKQR52sRMMgncabPgLCehWBVUfKcn5FdHaU1Roefh4XAJkHp37iHmt/gXzg2CdL
	 3hu/zbuk7i9KQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
	Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] dmaengine: qcom: bam_dma: Defer IRQ trigger type to device tree
Date: Tue, 10 Nov 2026 08:20:25 -0500
Message-ID: <20261110132019.1716994-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052018-failed-6.12-82eed160cfa7@kernel.org>
References: <20261107052018-failed-6.12-82eed160cfa7@kernel.org>
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
index cf647662ae81c..9f712e7c7e07f 100644
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

