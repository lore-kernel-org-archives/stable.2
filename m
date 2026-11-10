Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317662;
	b=o80xh6OpVZSJa9ijjhUSGxfMmXV51qrRmW5DBEFK9oo3+ORQ3xCiX+1+c6YPGYh9lEMs
	 wKwRRy+npoIEtmGdq6Bel4nu280mBord4NA7UYOgzPYWGANGCBeHDL9GLMMeIPLzGdpJk
	 cnQJ5QBU71rZgx0gkNs0xdRf/SdniqzI4KrZPE1WZXoR3hdenOZCVe8ZU5NJSOpeAcGwD
	 mDr7ez2X/8DfaK3LHyOPK+dqgwBFs/tHFJVTbSKe+Hbmvl13xQMHIB+m/SFZcPHrsvVwS
	 kZoIwO9RQ0/BATt0Kfx39VA3KE+1+sNUHIH1NQnkgZ+RNuvVeqxczGJ0/rnjXP/va5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317662;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=O+P2nsJBd3D8xlHepzwQhC/T5HsClagZ4EJhIrbNXKk=;
	b=aoa2xvwsGsoRLV15WTjBFih1w8U4iAy2VP5YkSXPQ/ZjKAQRMbJ8Zo3j9KWkvt/9B25s
	 ezDjd8a2V5gRkTw09JhXwFbIH/+53Zc+o1GncN0FM3DDwVHpniyLV0+OBouk4L+kTMti/
	 eBqVD5mngf8hL9blucP5UGS9+ZPYqTQUOKynXktw0Fk7mJEI96l6eJdGdjZnDDKM9+c+Z
	 mm77Y9XshLBahrn2B0jma39FtDm6xvULPk6ALWh39ydmTvT18ewzv+xXJ1RLy4vrYM9xM
	 DEsLp3OgzN5BL/iPQAGWx+VBZWnzp2snXJKvt0g0UvoKOu28w/ES1gFMlJR8Z0liqNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TqZ/mPhR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA95606A338
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TqZ/mPhR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AD11F0089F;
	Tue, 10 Nov 2026 13:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794317662;
	bh=O+P2nsJBd3D8xlHepzwQhC/T5HsClagZ4EJhIrbNXKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TqZ/mPhRYD/1GVyauI78UHCaJtMn3o482/zGwQT4cLGseWOer96NbLQxkW4g9Ff/6
	 0jLbqvnsXSXZVa7Uxoxas6FHTTQZJtU9bTxfWocVhqQDF0HyvrXg7ZTSHZJNvfx/Y8
	 3867aw0kHJ60GNW71+NUwMiMBJjsc64mMpan2iY327cxDnAetzrkxgoEcUF/+UxDvM
	 jdZJoNKxbZfJIUKxNfiWi4SaFj8luUuVoxlWJjGgyZDpYwTum0XhwHwb6X1Y3xb4ln
	 Gxdh2Xc5NnasOPYW8u4ope6qU/cVa6m05YU4Beaprxy50+dzJCmXR6D/6NnLQ33HQa
	 fDF/legm8iZFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
	Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] dmaengine: qcom: bam_dma: Defer IRQ trigger type to device tree
Date: Tue, 10 Nov 2026 08:34:19 -0500
Message-ID: <20261110133411.1751833-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060303-failed-5.15-82eed160cfa7@kernel.org>
References: <20261107060303-failed-5.15-82eed160cfa7@kernel.org>
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
index 51c9e7c6b2abe..91a0669881c9c 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1301,7 +1301,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 		bam_channel_init(bdev, &bdev->channels[i], i);
 
 	ret = devm_request_irq(bdev->dev, bdev->irq, bam_dma_irq,
-			IRQF_TRIGGER_HIGH, "bam_dma", bdev);
+			IRQF_TRIGGER_NONE, "bam_dma", bdev);
 	if (ret)
 		goto err_bam_channel_exit;
 
-- 
2.53.0

