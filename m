Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657653DC4A4
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 22:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066652; cv=none; b=WoHb5WuCVdxZ+RqLhLvlZlUqLtugU3ZI9ngL8LvFCSUZwhoGX3ByKNRvg+55ld2yzIfC+lymgLi6aZ7pi7HaH5MvzxkhtQWHgOpc4KRYABag9ODrGKeNLtEuotai9RemjbGq8cjCV2W7K9e+t10JMmvKr576ttcsXQ6sj4if8ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066652; c=relaxed/simple;
	bh=/87EZRullkkGi1XwD4I/Pzwm+sj5PzwkmmWH2vKcYRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOlb9QcJWSkxti1H7Vo6uoGMIGpwyvbCrIi1NXMBzhGE4QsS/1vSy1BoJn9TfiR4d1ioOMEuva/DRB4F0J//79jse9vBO3g84kwUksdIBWtwiT21zigQYYiCneNA3G1BsoLUywrOM8aC9rlB1WS5/tkaiRDslO5i9kLvTN+fBnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMFGHblt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMFGHblt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4C01F00A3F;
	Tue, 14 Jul 2026 22:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784066651;
	bh=VZNIZk+Hf5P9w8M5f27VDcIyZSzBYW3lcVvRgzDmAZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GMFGHbltRCt/MkDJ5Cy4KiW8gmCshXlNKMFLMNgE5DJTY6YwB557Pu1yVuB3vqRkT
	 ouUSD5QJzWxYP89BGUJij7WsGeqGelyEACgNqsUL8ziiDaONc17LQa4CaRrVK7qGfN
	 wVVqadotqVailmHHWBcqcL9/vxurgPidf+b+J6jwEQsLH3Hcnay8EcWoQbdvGkSBkw
	 9Mwektl4zhbOdMo8eQoBV6l9+MryO3F/cVZ0Gl6yFkIf7TatHf7dSKe6729rQ2qlWu
	 uNL/JI1pdN/HfhTWqllxRc4h2PUJwfnfjlMTfBX/syjTXdbiBUawKbPRX8rpvqnCLq
	 OzpDdn5daSscQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] PCI: imx6: Fix IMX6SX_GPR12_PCIE_TEST_POWERDOWN handling
Date: Tue, 14 Jul 2026 18:04:08 -0400
Message-ID: <20260714220408.3333635-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071312-buffalo-salvation-f750@gregkh>
References: <2026071312-buffalo-salvation-f750@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Zhu <hongxing.zhu@nxp.com>

[ Upstream commit aad953fb4eed0df5486cd54ccad80ac197678e01 ]

The IMX6SX_GPR12_PCIE_TEST_POWERDOWN bit does not control the PCIe
reference clock on i.MX6SX. Instead, it is part of i.MX6SX PCIe core
reset sequence.

Move the IMX6SX_GPR12_PCIE_TEST_POWERDOWN assertion/deassertion into
the core reset functions to properly reflect its purpose. Remove the
.enable_ref_clk() callback for i.MX6SX since it was incorrectly
manipulating this bit.

Fixes: e3c06cd063d6 ("PCI: imx6: Add initial imx6sx support")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260319090844.444987-1-hongxing.zhu@nxp.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index a68c7e273586af..c239a9117dfede 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -428,9 +428,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 			dev_err(dev, "unable to enable pcie_axi clock\n");
 			break;
 		}
-
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
 		break;
 	case IMX6QP:
 	case IMX6Q:
@@ -557,6 +554,8 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 		imx7d_pcie_wait_for_phy_pll_lock(imx6_pcie);
 		break;
 	case IMX6SX:
+		regmap_clear_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				  IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
 				   IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
 		break;
-- 
2.53.0

