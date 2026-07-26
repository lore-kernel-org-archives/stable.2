Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C40231832
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785072922; cv=none; b=E1n9EXKmuTYYYIpHmaYzbn4TBx1haVkkB7sg1wqJ8/978skGEGuq+/LkBhJdyoESD/BMiWzkrfuI5l4pdOLdJVC+eDN8/s+3YzrzdSnoIy25ooBIjkwp/ppvm4vf0ObdY+Q0qyVukwlTxlXmEFH8TfJm6i4m1QSYuvtGCLFuRZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785072922; c=relaxed/simple;
	bh=g5Wk5Gmy3l5P4sAubvf7wPYGTZ4ka5u+XQ/R1fcDXps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCKFnfs3XTvcYCN2L9roAToogB0og82QCxyKYZ8e1JHtLPMObJz7bo+0E8mEajRWgi/eZVjtNVG1XAUKrd6iyNCuUCTtXxa2nbXHJReQGVitivIHQYqlcO40YF9dn4Rq6LqcAWaWEXpfb7Rl2jnxtZpQCxcohV/CeHEVr+mH0O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoLQQDvi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoLQQDvi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EEB1F00A3A;
	Sun, 26 Jul 2026 13:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785072921;
	bh=8sp5neIjNU+L8ol7VdBJ2jHq6+qSfH6+VojW9Z9j4WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CoLQQDviwBk12u5qgAd6VGjUEdx1Sm7CWhELy3vFsIFsy8VdGazrZAY7wZ2cdIgbV
	 vOxAZUhX+9ytsapwckJIbOB5Gm0k5z87Einjkg2LW0jV1/VlHQivIA4fe/6rp84aT9
	 XNPONPO8m1cdS/ahQaBjx5K59AkmBuugnFGcnmzPZ9Pt5cEFOucOgYYQJT12TAhCBY
	 YaDfE7t+u8OWc7DUKIlJFUaApK/RBzXzWEFJSdalxzPNSk+WNuxidiISpPjBXYx5se
	 VKLnC9BhQ8rdQ5xc/JX1yY6iQ6Sa/hQRZLRM9hCKF12T20kcaU7rtuD18jhDBZHp1o
	 1iKPJcRGMJaPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] dmaengine: dw-edma: Fix confusing cleanup.h syntax
Date: Sun, 26 Jul 2026 09:35:16 -0400
Message-ID: <20260726133517.364299-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726133517.364299-1-sashal@kernel.org>
References: <2026072011-company-agreed-60ea@gregkh>
 <20260726133517.364299-1-sashal@kernel.org>
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

