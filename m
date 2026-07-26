Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF5328C854
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785072122; cv=none; b=rcICH72PdniYFnnkkIgbhfjMS7VrQevIu3uk6WAf6wI3OmDMCkse7T7Kvd+f2RmKMvReMpVpAQuA6PCxWhv3g7VglD/tPj1sNhd+5XwwuZWFDNRECcyYdYXKIhLHTOBMmZcdaxoDx4xI39a/kB8Yy5tgW2X7HcoumCSTcZS1tZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785072122; c=relaxed/simple;
	bh=g5Wk5Gmy3l5P4sAubvf7wPYGTZ4ka5u+XQ/R1fcDXps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVYiUyoU7MtRXYb4y29XD7ovj1VMoeiHRV6B2ONBvX4JQO2nPF233uqkJzmfgCxdHUyU0LdWD+xNahQ/pOGmuTaxCZDIj1xaD8Mid3x/D0w/AbgmIlS0ughqOD3nnxa9peIehXkDi71uSNVxN2BA1SUqTaPsUKp+WIAb1kuVe34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxkmF/zC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxkmF/zC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9AA1F00A3D;
	Sun, 26 Jul 2026 13:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785072117;
	bh=8sp5neIjNU+L8ol7VdBJ2jHq6+qSfH6+VojW9Z9j4WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VxkmF/zCr3u+HYDlofMc5BjuGB8UnWwiiIGgkifo1XMp5B0YofJt4CPHY1caYg+C9
	 bZ7mktx/Y52l6TTubdYeTdCPDB4u5N9w0YlYeHgnT00mVSB5d16z5HobLMxGHKVhdN
	 jBmx30T/B4r0oniZ4MaQeRKUeTrVb618emloJuk65brblw0IEYn+iFM5hsvhlFfqG2
	 AwR8viW7IjxSrWnODmtIfqRsvO0/bbsMhdJxLTdyUA4pEsK3q3k8H7tXYAW1U9eRHp
	 uZQK0wfHmk2VYF7W9a4zvEeksFwRrvRTVF9ee2urPH0KO33Skh9WxTDzEh3bUr705w
	 0eDoXtTi5/n6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] dmaengine: dw-edma: Fix confusing cleanup.h syntax
Date: Sun, 26 Jul 2026 09:21:53 -0400
Message-ID: <20260726132154.327006-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726132154.327006-1-sashal@kernel.org>
References: <2026072011-gratified-dealmaker-699d@gregkh>
 <20260726132154.327006-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

[ Upstream commit f9ef8dedee34e2d7828d5a6a0643cd969aaa8437 ]

Initializing automatic __free variables to NULL without need (e.g.
branches with different allocations), followed by actual allocation is
in contrary to explicit coding rules guiding cleanup.h:

"Given that the "__free(...) = NULL" pattern for variables defined at
the top of the function poses this potential interdependency problem the
recommendation is to always define and assign variables in one statement
and not group variable definitions at the top of the function when
__free() is used."

Code does not have a bug, but is less readable and uses discouraged
coding practice, so fix that by moving declaration to the place of
assignment.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/20251208020729.4654-2-krzysztof.kozlowski@oss.qualcomm.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: 11d7cfe0c119 ("dmaengine: dw-edma-pcie: Reject devices without driver data")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 157af858bbab01..ae1bbca7da93fe 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -160,13 +160,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *pid)
 {
 	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
-	struct dw_edma_pcie_data *vsec_data __free(kfree) = NULL;
 	struct device *dev = &pdev->dev;
 	struct dw_edma_chip *chip;
 	int err, nr_irqs;
 	int i, mask;
 
-	vsec_data = kmalloc(sizeof(*vsec_data), GFP_KERNEL);
+	struct dw_edma_pcie_data *vsec_data __free(kfree) =
+		kmalloc(sizeof(*vsec_data), GFP_KERNEL);
 	if (!vsec_data)
 		return -ENOMEM;
 
-- 
2.53.0

