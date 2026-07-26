Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8922264A8D
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785070065; cv=none; b=hsNdoD83lGuvoZ0w9iotINx6jqWskKheF3/rrp9I8vH2BNTnEcwwQDN5hoRKZSbVICOgwTHtFgyIIXB8Nzr50ZTQtixGsbhPrdK8Z/u34h3QFw9D4HMMNpRZxnxQyvQSdzM3Cd8ByVR0zzRgk39DQoPSG5qF6h/hLCl+jVdb7h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785070065; c=relaxed/simple;
	bh=ICpakKy4veRLAbPE3VLxBEY7D/KK+dSPw3yMUcLtRSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEPB5Xa8u0NaxngVUdmYYFAbHwGjzbc+4Y3B+lBLnmgT/S1y/pklTi9bT7V7DgrZwQ8NSdYAy+MRaDVjlPoLMzUcQXqU3xwDOGV38yGKLMkslkUDHHTojA7x3w5C5rjPN3ripFGje/B9wyN0PSiwILSKNbs8kXJt9LaDDG7qtpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbLpfeQW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbLpfeQW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46721F00A3A;
	Sun, 26 Jul 2026 12:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785070064;
	bh=vY1Ke2zdxz4MaId4sV+GTShgsrcJG8tlnzlT4/fafC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YbLpfeQW7YfE4Im7sVy7sCzryEXu0m/1L869UAIrvPnb43Ovef9wgSEm7lscrf8C5
	 HWN/uTXdEpIlHwlDVvv1Aziu/5gAaLw1qQ4ldSKrCZeWwtTN1VUBwLyO3wUw82Gzju
	 o8S0S1ijWkSZtSWg/WzKIYNYnon8tVeQDrC/tUlN7qMiCszCdC/qThUDK/aM95gPgG
	 xRFFS8LR7o/o3fs6XIl43NUV7RGfdZ2nKQnP8UhZzIIkG6z8IvMui2TNMg7ULbsDCS
	 Opk5hp/kMQ3u95je7Z4L0DRBDEGK9sufJTKnI88yretYI6Im7gfP8oMb7CEWw5Rgd6
	 Ki/ryXI4m2Oxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Koichiro Den <den@valinux.co.jp>,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] dmaengine: dw-edma-pcie: Reject devices without driver data
Date: Sun, 26 Jul 2026 08:47:41 -0400
Message-ID: <20260726124741.149009-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726124741.149009-1-sashal@kernel.org>
References: <2026072010-latter-greyhound-42b0@gregkh>
 <20260726124741.149009-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Koichiro Den <den@valinux.co.jp>

[ Upstream commit 11d7cfe0c119691b2dafbb699bbca90258c678aa ]

dw_edma_pcie_probe() treats the PCI device ID driver_data as the
template for the controller layout and copies it unconditionally. A
device bound dynamically via sysfs can match the driver without that
data, which leads to a NULL pointer dereference.

Reject such matches before enabling the device.

Fixes: 41aaff2a2ac0 ("dmaengine: Add Synopsys eDMA IP PCIe glue-logic")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260521142153.2957432-3-den@valinux.co.jp
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index e9caf8adca1fca..dc6ffb6941ade7 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -166,6 +166,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	int err, nr_irqs;
 	int i, mask;
 
+	if (!pdata)
+		return -ENODEV;
+
 	struct dw_edma_pcie_data *vsec_data __free(kfree) =
 		kmalloc(sizeof(*vsec_data), GFP_KERNEL);
 	if (!vsec_data)
-- 
2.53.0

