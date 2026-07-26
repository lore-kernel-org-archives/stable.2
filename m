Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8444F37E5CE
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785101304; cv=none; b=QJMssCohAhdoS7gjnz944qWIgHFVCRQ97zw1LcblzSlFnEPYEnE1oJPgUzCodNPiMfoAISoTpB2jcXhvYqyJPNsFMKAlGbrjHhnpUAEZJ3unnzTuTP47nCw6GY2nA0BrxO0stsTCEHggKfq0hscIuYhutxtd9aWyqDjDVKPcPqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785101304; c=relaxed/simple;
	bh=CR1mMCNhfVhy7Yv9mjXyoOokT3LekjwN6bpy/3Y5pSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m85R5LS6/Hdx6SjDFlY0z5YuIfZ65dQjMu+q9ptqEipU/JF1BEVUqjccnY5NN5IsBp1ThkULPYRVgnNNatrVocIaqrrLyS01NBRm58bxttg7spVvwCQUWaL6X/qs5bpBmsDrX74RIewiuwI3gZX01LgBEutx3l/Ky0GZbn1GZds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUx1ekWi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUx1ekWi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD08D1F00A3F;
	Sun, 26 Jul 2026 21:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785101303;
	bh=0gbPz6DYKFMVyi06Ff3fVuyGkXu7pt+KvO1SpxuIPG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lUx1ekWi6V2oDcL6M5woX5vXDv03tdyv87XgAGIt/uzpUoxzWHQBROVQSeOIus0gX
	 PTA3j1Za3FOuQ0jepddsq5tjNIoNp1LUxLRjTODIhkkDFh51LLl2ZmjaJnsUtz4eYS
	 fPn6vuP8BeAEwOtGnlxVe5Hy6oESKQza7KrySV9rg0BRkCA2JPSoXkGlD83wekmNaV
	 r04fDmfvA282+ZYeW6CzhxPo/KWavzouLBfjxQKnVzLMQZ/d15iulAE/k9VkfWgJP3
	 D9tvTs+O33gcEvJ20YeqaM2V5VsyE1ZJP9YWCRq8znZI2K4bzS7sFpK4kd5adzt5tk
	 QuszkCV39NYIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] dmaengine: dw-edma: Remove unused irq field in struct dw_edma_chip
Date: Sun, 26 Jul 2026 17:28:18 -0400
Message-ID: <20260726212819.4022652-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726212819.4022652-1-sashal@kernel.org>
References: <2026072058-sadly-hatchery-b25e@gregkh>
 <20260726212819.4022652-1-sashal@kernel.org>
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
index 0830bdd91e0c93..987ede1087dddf 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -175,7 +175,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->dw = dw;
 	chip->dev = dev;
 	chip->id = pdev->devfn;
-	chip->irq = pdev->irq;
 
 	dw->chip = chip;
 	dw->version = pdata->version;
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

