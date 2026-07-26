Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E9C2AD0C
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785070064; cv=none; b=DcaHa8XuQ7y5ifimFScV7/OMvrAxqDzMEGII/Kp0Avzr+znDlhhQ1i6rMmYUN2fFfkWBgyeq7y+aDT0JIDSPGXqSt7ECm4Dm81igrdoFhbni0Qu4XG645RUrpVMv1BsjoVNYdX7U/TkB9Im7ntMFuxJL1QNeTETkeucP+/7lTxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785070064; c=relaxed/simple;
	bh=X8g7LE6uy0sE43XDsg504E20U8gxtnStmTwuHEp0rXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0KRLZKrAIwsHQW9VbsxfJhCmVSZ/08ykmRZgKpahRRoazn97H/Nkl+I1tLLyt2YPQH1YPhmOkU9LgrxRTXiZv8tet+3WpwLu7EOVQHk+5/AY2PyKRXGTJis6h+M+2T8Q/Mo2JoIfAHSKE4pQXKwQIZrEAXn/zbEd7XES6wT97s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSrC8dd7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSrC8dd7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD33A1F000E9;
	Sun, 26 Jul 2026 12:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785070063;
	bh=ad0hVABLUMRyj4UbhMIoAZJKb8KU8J4BEdOqU/6IvxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WSrC8dd7VVihvZphaiw1d7oGsywVcyOLwyj1xJnpXAi6/EeQKimORcpL72KUufVz3
	 KQEoBWu0cIYjC6tbGMIgHAKadBJAovOkdAbXyCDMbg9RUeDmYthougf8/k52HSxKZN
	 QAN/yX7u/yA3QAfsfXXbdVJPctfk0a56lTYIH29D4r0jKnTdZOPIEUqHSILkngNwUU
	 txBquHG0eV4RW6nVilMmdX9YjrWjdSbl3mj8yfWbAnlaQi+PELa0HulV/l4i/+tvxE
	 7ZhNix7Lm6abh0Ln0uu7RcVXHp9rjAKhV4oeGR93H+aDo3+pzR714PviF6jPMivkoX
	 sVvvSl1jL38kQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] dmaengine: dw-edma: Fix confusing cleanup.h syntax
Date: Sun, 26 Jul 2026 08:47:40 -0400
Message-ID: <20260726124741.149009-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072010-latter-greyhound-42b0@gregkh>
References: <2026072010-latter-greyhound-42b0@gregkh>
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
index 3371e0a76d3ca1..e9caf8adca1fca 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -161,13 +161,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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

