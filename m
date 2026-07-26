Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74182BE644
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785069270; cv=none; b=qriH4yS9H80CFIyFAQur8ldhrAX1F7zSBK2pE2tZDPvAaH1pG4ma17oqx81V7xVSGBiINo9TiZkM9KJUEzVdXPoTlfNweO5QNQQG3HhwQzSQOuboEQ9K5JxFi6YIJF7CSPmamTXAZKJNlp2t9J6etj/Xil7VERjb1K4gWzQHFD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785069270; c=relaxed/simple;
	bh=l9OeC3ptkbqjBrJ70Y4/M2ShUbN1dCT++XgyyHHm8rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qO1Pmrbf0XA11z3h5taB/1fH8IlFt3PCGmBpwjEiAu8eSEwOafEC/qsHSXbvA+f4UNAYWtDjRWjGCBQyvdbduGPDKMpQA24TidwK3KrzEu4w/ThYO0T450oj0QfX1+XJBMQUaKMI0YY+7aRMs8Bhn3Hhan4kRTJvlEW0vdU6t/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=colSNeLh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="colSNeLh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725B51F000E9;
	Sun, 26 Jul 2026 12:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785069269;
	bh=VF4KJup8kHCviRwW/tfNEVWYd8TvFq1Kslg8NsFEw6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=colSNeLhnQddXTLGwbdqgxwh7e6LNQaRJZwr6zf3Sc4pNmd1egcK2ixYDhUgQ61zI
	 nB6E56IIqK7m28H61XVRU5qZlYjx04Ex3Oc0wTGMgkuNe3VUH+1bZ770xflEF2QmA/
	 KG/SywG2GBLe/m7AZieUKA4XQyj99ZvSo4anXmwkNi+YHHIgcS/tRCm0o4HfMplkX+
	 wOD3io9Xsc5Aiyf2E8yG5aiu+A1OeJIWne6nvxQDEpU52IJJdtiz14obf9/GLGHg/i
	 Jt7Vx5O9joH+ZqeRQMrd6gqH7HU03ZVW1xsj8PJyq+HS4Ps989Nh41DL84qMVgkbAH
	 6uKUhJ4cmK3Xw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] dmaengine: dw-edma: Remove unused irq field in struct dw_edma_chip
Date: Sun, 26 Jul 2026 08:34:24 -0400
Message-ID: <20260726123426.18949-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072058-move-penny-29fb@gregkh>
References: <2026072058-move-penny-29fb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

[ Upstream commit 5a0e4529d9aee8ce348f628ad476c9ddb6cf457d ]

The "irq" field of struct dw_edma_chip was never used. Remove it.

Link: https://lore.kernel.org/r/20220524152159.2370739-2-Frank.Li@nxp.com
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-By: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: 8ffba0171c6b ("dmaengine: dw-edma: Add spinlock to protect DONE_INT_MASK and ABORT_INT_MASK")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 1 -
 include/linux/dma/edma.h           | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 44f6e09bdb5315..b8f52ca10fa911 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -231,7 +231,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->dw = dw;
 	chip->dev = dev;
 	chip->id = pdev->devfn;
-	chip->irq = pdev->irq;
 
 	dw->mf = vsec_data.mf;
 	dw->nr_irqs = nr_irqs;
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index cab6e18773dadd..d4333e721588d8 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -18,13 +18,11 @@ struct dw_edma;
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
  * @id:			 instance ID
- * @irq:		 irq line
  * @dw:			 struct dw_edma that is filed by dw_edma_probe()
  */
 struct dw_edma_chip {
 	struct device		*dev;
 	int			id;
-	int			irq;
 	struct dw_edma		*dw;
 };
 
-- 
2.53.0

