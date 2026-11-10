Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316289;
	b=HcZ+L/MF2/JbnjjuKSFmrOHnc9QAEeFSc3zPYwB661StO4MJdbMq6hM+QixwRNQaqbxT
	 4p+3aTvjMQ6QTm9k8ts4V/RjCNdwEFkC3awYuQB9UhhrvoFu1vSNoh+gEByfNywKjeBAU
	 DQn875eOVsz4FElSoAuHMyzHJI3I8dWJJ3K3Ippw8LOenAjzhxfHjKOAKySntSU+sMSkV
	 68Rra7RI5XttBrff6ZBIkZPfr/ZiCYOxSaD3IfEkCPOEjA4Ye+wh7uNXVH6PbZ7rjkZ+C
	 UEEdoutU1Nex7RRrfxN73Ya8xMpWm4B3I7A3x22qldTWo13MQgMla8gJOnR0vnqKgRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316289;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YT/A2uORiz05DvX931y67/6/Yh84kLLkhN08w9DyWxo=;
	b=Rvl22xAl3CTuTQMfRIMHYOsQZGhMhHsvpt74qKulpYgWVMQkFis8zkCzdftUlmK2fjV3
	 iBSsNIsrlZMp8d/xTBejeUEScrpDyFPrFvK0jefIJmjsOvecYmCtHxW8/dPL69Of2izQr
	 asCON01Az71lfQyovoidIVaN9Pf0R3BnMatFPeDrwRk2/mzO7WIw/WRlrM1Qy82jYNESp
	 H0ZmwaIK7ctGDaC0qjDtLvpPQj5FyKmhM29tGktU9RP+PTvGU+cJMgvJfYrUB6WBfNBIp
	 K6aQpcNTH01vR19dL4XfS0lOJ7u8pugGLCZg+YPxCNzjB2PXBu5A/yUJz/X1JgFbo5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqhPiJDT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BDF606A77F
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqhPiJDT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFC61F0089F;
	Tue, 10 Nov 2026 13:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316289;
	bh=YT/A2uORiz05DvX931y67/6/Yh84kLLkhN08w9DyWxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nqhPiJDT+GmqpMeHHBQTehZt16PEx5nNR2FnzWWDniA1NpvqR1tGYjkEeQeeKkBoV
	 6b9WzKTR1WXHKV4iN47k1ZD/UdHIZxtdML9f9PYv8i7DZO6Lj472uCXszUe2qpKmuS
	 jjuEuTp2a3B2I/N7c/y8Z5SHM/RMKzKpoj9VfPGqNwCYo0GGQYu6UIWmYih8e6W6af
	 VY9J2H1qMrX2fTm0e1JP3gymhBG8p9nCtYuwi7kQakPkQQsfqXBHI4VlWQBBj6gJjY
	 dkwafMvfyRCf0F/tKaF9Iyp6FSWYvZ4M14J7WDJWW+tFOYze7LIJz7BKeSXO+zu/xT
	 0lMb6DCCgPeyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
	Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] dmaengine: qcom: bam_dma: Defer IRQ trigger type to device tree
Date: Tue, 10 Nov 2026 08:11:26 -0500
Message-ID: <20261110131121.1652499-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050416-failed-7.3-82eed160cfa7@kernel.org>
References: <20261107050416-failed-7.3-82eed160cfa7@kernel.org>
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
index 05a3b1f9e0c23..94cb957d4b187 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1333,7 +1333,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 		bam_channel_init(bdev, &bdev->channels[i], i);
 
 	ret = devm_request_irq(bdev->dev, bdev->irq, bam_dma_irq,
-			IRQF_TRIGGER_HIGH, "bam_dma", bdev);
+			IRQF_TRIGGER_NONE, "bam_dma", bdev);
 	if (ret)
 		goto err_bam_channel_exit;
 
-- 
2.53.0

