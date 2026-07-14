Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C7E4DC553
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048172; cv=none; b=D4VRuz3MuyYvXDj5TU4kFroH5Ab9pt9Lb2Ehb4Q69+2zyb90gifjvhhBCT4/GU0USlfvxGn7OQ/1bCltGXCwzE7v2AGhyiWu9qQTJd6WXi26wzICFKqqE7ljWKD5871uQzA/y5ZeoyVUqQoS2lzPxnUl80GYRAaW8WVSbAX+48w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048172; c=relaxed/simple;
	bh=HfD3UXgA8j2sNsfDGNO0eQWjksdCEkLAyZVu/l2SDbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Np4DHsC3vld0Tq0aCQNtF6aUoe/S/p48rzAP5HqVyblHj8yshLwX6yCks2bZAAAVhx7p+ElAzn3JDPhfoZ48jnH4/cuJYE21dKB6s3TEbpTybPhuk+VvUxHX0fb+wDRh1tAgPJJLG+/cacQyE9FK0pJPuPCdx8CFIONgQqgCBsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dS87ptNH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dS87ptNH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44DC1F000E9;
	Tue, 14 Jul 2026 16:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784048171;
	bh=2j5ZD1/smCLNH46b3+YCpBjeolUorThzhQQECuWSDjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dS87ptNHlmdDRC2kIH0nuZYAHwPg0Se1rBDpOAqwSm1BfxlDtrpeetHX150yqYRv3
	 vA2kPFfEY4AuKpCvclo+96j30XhPRr1cxDtbYNUZm2NNKamI21TyoMhhBhx0ijwVnU
	 nXt3PIuQpDh+2lvswt6S0iDyv0hN6cMlD3Y7yfvv24pQDb8bMl/IiNk4/FLvxW4J6y
	 /Fnome4IG9uxRkabsad6DkqJOrg3TgSGbJYX3iou/UfaA95FiHAP9JZYV5qcpBswge
	 Vwy3zI0LkPiIUnFPXW4ZAs/jWwbN1B+vCHioveDasU9dywnrwnd0w6DJ/3VI0dtdBU
	 IMRWWCS8gqUyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] PCI: imx6: Fix IMX6SX_GPR12_PCIE_TEST_POWERDOWN handling
Date: Tue, 14 Jul 2026 12:56:09 -0400
Message-ID: <20260714165609.2885969-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071323-justify-shawl-172f@gregkh>
References: <2026071323-justify-shawl-172f@gregkh>
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
 drivers/pci/controller/dwc/pci-imx6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 23b8dda70cb2f0..c438cf888ad575 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -560,8 +560,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
 		break;
 	case IMX6QP:
 	case IMX6Q:
@@ -733,6 +731,8 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
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

