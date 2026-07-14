Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A1D327C18
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 17:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051377; cv=none; b=pjmUaZjcrO6E7QzDEAnfyfUSm0WCv9XiOU7+He6OIxIkAlyufLPmQAEy6r3ZBYAeVhp9KZpW6pIuw+F3uR0LC80f8vmrwa9CxciK8DWk67ZWDwoHeO9dnNZR+Y08CPp3MUSe2oOPGgAssebOgh/EfVjcyMGtjC6jDiiMOeAx/e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051377; c=relaxed/simple;
	bh=R0cjrhKP4uvuqW/SFu+R7boP99UaQZm200QFj7WLHbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/l+ZLfpnwGTrDwTQV66ICGH4rgu221V0AnTmQafQsje7a1b0T+BAkwpVrIX+N+aw8mfEX/b3dgC3QXOn3KgX4J0yosOUNWPBXqmzLsTdUqoN3Z0BvqLVw5xkVyC5YDT+dFVH06blvX2fflhoQu3qZYCHvQbvl3990RCW6VGS2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lxgu2iYW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lxgu2iYW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287841F00A3A;
	Tue, 14 Jul 2026 17:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784051365;
	bh=5Tj0yJQKIcXCmtT+bt2xhtrLYx3dSjChfWqiOiHWk0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lxgu2iYWZDp7/ifSXcz8o6cs3dqxwRRktYWGtKy1pZMKOXfRiYvueNAMotQGJMNMD
	 HbILV45FpOEYLeGJYUkMyRF5MlcpInpy7kgiF32wzdvgzUFglPRibYE5FBT0ugZWbn
	 +I15cvJEF6QRAxTRgs1HeWd91sL1UYja7SgBMZaRllPaGdtJJN9h5iDyKknq1KznqY
	 Q805QDtX1aM06wDEIiFuemTPHWUJ/KxOQGx4NIfnYkcP+yyghLLxjInu68EHrnt8qp
	 lC68tTEMrKLEo+goVWXCzdwef61QZSgYlzRGkh4hzYvnU15Y4JRR4DRjgHCnGhfYKO
	 fZ5xC5UEsl5VA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Franz Schnyder <franz.schnyder@toradex.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] PCI: imx6: Fix reference clock source selection for i.MX95
Date: Tue, 14 Jul 2026 13:49:20 -0400
Message-ID: <20260714174921.3041761-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071331-exit-kinfolk-e3f9@gregkh>
References: <2026071331-exit-kinfolk-e3f9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Franz Schnyder <franz.schnyder@toradex.com>

[ Upstream commit 88cc4cbe08bba27bb58888d25d336774aa0ccab1 ]

In the PCIe PHY init for the i.MX95, the reference clock source selection
uses a conditional instead of always passing the mask. This currently
breaks functionality if the internal refclk is used.

To fix this issue, always pass IMX95_PCIE_REF_USE_PAD as the mask and clear
bit if external refclk is not used. This essentially swaps the parameters.

Fixes: d8574ce57d76 ("PCI: imx6: Add external reference clock input mode support")
Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260325093118.684142-1-fra.schnyder@gmail.com
Stable-dep-of: 0c26b1c34d12 ("PCI: imx6: Configure REF_USE_PAD before PHY reset for i.MX95")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 9083658a4287f7..942fa61d13ef3c 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -150,6 +150,7 @@ struct imx_lut_data {
 struct imx_pcie {
 	struct dw_pcie		*pci;
 	struct gpio_desc	*reset_gpiod;
+	bool			enable_ext_refclk;
 	struct clk_bulk_data	*clks;
 	int			num_clks;
 	struct regmap		*iomuxc_gpr;
@@ -244,6 +245,8 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
 
 static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
+	bool ext = imx_pcie->enable_ext_refclk;
+
 	/*
 	 * ERR051624: The Controller Without Vaux Cannot Exit L23 Ready
 	 * Through Beacon or PERST# De-assertion
@@ -262,13 +265,12 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 			IMX95_PCIE_PHY_CR_PARA_SEL,
 			IMX95_PCIE_PHY_CR_PARA_SEL);
 
-	regmap_update_bits(imx_pcie->iomuxc_gpr,
-			   IMX95_PCIE_PHY_GEN_CTRL,
-			   IMX95_PCIE_REF_USE_PAD, 0);
-	regmap_update_bits(imx_pcie->iomuxc_gpr,
-			   IMX95_PCIE_SS_RW_REG_0,
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_GEN_CTRL,
+			   IMX95_PCIE_REF_USE_PAD,
+			   ext ? IMX95_PCIE_REF_USE_PAD : 0);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
 			   IMX95_PCIE_REF_CLKEN,
-			   IMX95_PCIE_REF_CLKEN);
+			   ext ? 0 : IMX95_PCIE_REF_CLKEN);
 
 	return 0;
 }
-- 
2.53.0

