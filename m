Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B3A36894B
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785072923; cv=none; b=qxDqpU/mYDF9WVcKbKAq6n/QBF51JX4GtraVMtqgn8l+cx0XAvShQt8EP2vWM/XsVURtEdUMt3VYayzikPMOHai5VhkyfVEDRJgx4m7HCZ/iWVJsWDBHvpBO+PeAJIKdB2eu5jJMWRIZqCuCntm6ahlUUtb5QHJfyahQvnZEseE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785072923; c=relaxed/simple;
	bh=JQOQ6yS4xsXFdeuonQs8PhBaWqcfj0FCzAiN2cBAyrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSq6SpB1ITLjCc6mY46g+ZKImb1l6uSXFni5yx/b0gLWKTcXKpKh5tdH7/LXoi2vFma/I+MV5PNH3MDtCxKDCpt8YyyLr+ZaN/Y3cTqRS8rK8wap+yGimLriFQ5aMicmrPOmY7r7ydnrI76dtmzhVcFEvgF+DBvKFdAJ1vOWiIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXyFup8j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXyFup8j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0890A1F00A3E;
	Sun, 26 Jul 2026 13:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785072922;
	bh=QpMj4LBu78KFGGAwLfBm6hP1u97bvlT0mRsqGiBnnI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UXyFup8jWR20NdXmr2aMOKyeKXC9M2b5cGolLLzU+tYgzTTHTGGYwzQYzsITq/WKx
	 8iMc5poZLLZb2aEOy0rVEf3l5rf6oVyGgFe8JfHJe+x/puZWqgWw6xgmzteFNn5D2j
	 3TZKR3tjqrV45QEowo/O72IyDrwBDz7BhUhC0UO0Ode/wu/u8mhVapq6A7Y3YwRES5
	 A1NJt8mEAumjEtl/bD9fzBgCgiehhD2N21LIbTwlINOigGoZcvCde680dUn20sGNcP
	 NPEwToanyb2r4Mn6Zw8KmgrFs8/8dhkqVtlZwG48qA9drRyAODwMA7bVN5OpyxqatS
	 C+Vpy3xXdlEMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Koichiro Den <den@valinux.co.jp>,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] dmaengine: dw-edma-pcie: Reject devices without driver data
Date: Sun, 26 Jul 2026 09:35:17 -0400
Message-ID: <20260726133517.364299-3-sashal@kernel.org>
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
index ae1bbca7da93fe..b3f2653862a8a5 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -165,6 +165,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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

