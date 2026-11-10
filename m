Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317141;
	b=uunr8BCsTErQeaEroGVfMLf3OT9LnlgW7BYnbdZvE1JlQt7tn+txrTOdxKBp9IqWlweG
	 c9IWSUytvm/PVS9Qy5DdhKKdkJLetK51MUnYOdjYbUWUEnmGuJRHNnLYR8l2H7uNke0hc
	 RhnoKRQ7fOPQuDX+fJ6P+tx4+fTIIUzmUX38yqOlcBPvKdMXI/8yuZy588VWHXZosgWTx
	 7X32+0PRN/B53N8T99JPGn/IE83cshahBSIlPGhdzU2QR/tt1yRD4rjaMNMMXrMaP7Kyu
	 W9JUJZe7ywoVzlx4CkELYIN8JLUPD+tmDrhmMFKlHa0Wagjud9vePbiAvIV/Y33Nx2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317141;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CzhHa1rflaFEVKzMmfGGqTqksLPLiWxd2uVEBscU088=;
	b=kXF2j+S8Tc+Ev6+XhPu6rRE8Y3OqbAgQBCzK+ptbP36KfQjuICGreXVgxuUpllCrTvV6
	 FzkXqD5vI/UwSRR9d4HffLd6Z48TUidjjBG9CEwjDy1tryfmZqXBATSYrNccBVQ9c0SPH
	 0yptBrMl6NooNEjrGq7PYgCsPOT37aGLnBrZpOUZM2v/2tQ/SmwE9fjWZ47CmCufkviIy
	 zJbA1oHkbh9by9vOiE1ol9ub9Wmtu2nC5w5+2T/va67upPiqVyMJKggpsNYjheWRWEKBC
	 cGRw4eXtvBRxh9rbYGMuUs56Unys41EkBrkmAJ+dBWoHba8nx95b2yhZX/TTo6Nw6FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GerQvSgs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFE8606BFEB
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GerQvSgs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15961F008A6;
	Tue, 10 Nov 2026 13:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794317140;
	bh=CzhHa1rflaFEVKzMmfGGqTqksLPLiWxd2uVEBscU088=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GerQvSgs+aYLgy3sNVcWpVZ76hnFQ4ng6Glh01H1YXafqAYecCkY8DRo3D7cjsTco
	 YRKUK9JjhdCDUs0WGmhJYMa7PbDSGq2v4d4L6pNtWDzLb6lG7CwwC7H2AtlHFOcGHR
	 fj3VsLkEgZBpbJCKyQFKWOn+UqSksOaCiDYx9bsHmH8oZF31Yy9wVPup3axxSYMPFY
	 8RDc7PT3V+WX+e6aOGCbBC9xgtfsF/UuHVKAN2UX3VWLy5pqHEdaA2ZCiiRL6za65k
	 4+71SyWpkOWRXpl4BAQi54Tplebjn2IUbbhWv6y5HXzZau9ODcvbvef/WNCIfnsYiU
	 Ngd+Dp8sptT9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
	Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] dmaengine: qcom: bam_dma: Defer IRQ trigger type to device tree
Date: Tue, 10 Nov 2026 08:25:37 -0500
Message-ID: <20261110132532.1732443-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053248-failed-6.6-82eed160cfa7@kernel.org>
References: <20261107053248-failed-6.6-82eed160cfa7@kernel.org>
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
index f931e63e1884f..03638e4f505ca 100644
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

