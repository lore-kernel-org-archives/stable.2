Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FE72D0C92
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 17:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051386; cv=none; b=MEX50oIBR1aN/L4kDweEqLxO/RNhIpDOR+QEHgGMNnXjJNEt1iGB1k1C//l/LGdFRKvQ9EYQiV8GS0HEtqU4Aw4ar8Ns6jp5hx7qpiLgTAeWy+RcwmI3uMGkf1pNa0LuBlnNBz49zH0r+VDdc65QEzJSFynzh2A4Hm6DBfRIiHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051386; c=relaxed/simple;
	bh=6sel/MvMW4EwFl/kJR6hEcfHTYrI5K2nOQ+hotgGbyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mmbp+iUuY3Ueli7/XelKpG5kSHLm7pHKv2RnJnO7DpxC0EuniO0GgbsPuDccoa3wDtb7sNMp8IPDw6V/3yFW6ZIb5CQD4JcuZArfMb6kHaD0peSpykx3EepQh8l/7w1r5rqHKsi7jtP/fAOOznVek3Qsuiehd2AijrCyKTLPNWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfSfyIdW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfSfyIdW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621111F00A3E;
	Tue, 14 Jul 2026 17:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784051365;
	bh=5FujlfPyD6VJytbI4NIX9wvjGakLlM+TmCT+nVGASGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SfSfyIdWe64MY7q0BS8O7Yz6fuKv/l/CEAdnNmpYQ8Nmz5wAzxfuQwriLhC3GUB5O
	 gm7vFf6SC57rbrMEYkRJkrhdT4KUlHAKxW+91P46yonk+MrATHKZejVl1MlswfTnyW
	 WyVGBY8W20UGmsJWZrQ5GSNVbB9cKHToALwFlriZSHg3/6LAtyOYGxNoi2DPva2S1W
	 y1UNj/joLEXYtQoK2+qme3zwc0nBPXqw7xIH/JwSUXM4cUcmwL1BvePEJ/WYMplx6K
	 u6he+EgnGYKQAee+VmUt0NWO3Tn9hNC1nNUqSrl3IBhcMSyXUmeimdxXWrJ9e2ruaV
	 ftmT3b+dLHrxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] PCI: imx6: Configure REF_USE_PAD before PHY reset for i.MX95
Date: Tue, 14 Jul 2026 13:49:21 -0400
Message-ID: <20260714174921.3041761-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714174921.3041761-1-sashal@kernel.org>
References: <2026071331-exit-kinfolk-e3f9@gregkh>
 <20260714174921.3041761-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Zhu <hongxing.zhu@nxp.com>

[ Upstream commit 0c26b1c34d12d4debfb5363cc0be6cdf68e87ba2 ]

According to the i.MX95 PCIe PHY Databook, the ref_use_pad signal in the
Common Block Signals section selects the reference clock source connected
to the PHY pads. Per the specification, any change to this input must be
followed by a PHY reset assertion to take effect.

Move the REF_USE_PAD configuration before the PHY reset toggle to comply
with the required initialization sequence.

Fixes: 47f54a902dcd ("PCI: imx6: Toggle the core reset for i.MX95 PCIe")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
[mani: renamed the callback and helper to match the usecase]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260518072715.3166514-2-hongxing.zhu@nxp.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 942fa61d13ef3c..1dbb502157074b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -135,6 +135,7 @@ struct imx_pcie_drvdata {
 	const u32 mode_off[IMX_PCIE_MAX_INSTANCES];
 	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
 	const struct pci_epc_features *epc_features;
+	int (*select_ref_clk_src)(struct imx_pcie *pcie);
 	int (*init_phy)(struct imx_pcie *pcie);
 	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
 	int (*core_reset)(struct imx_pcie *pcie, bool assert);
@@ -243,6 +244,24 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
 	return imx_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
 }
 
+static int imx95_pcie_select_ref_clk_src(struct imx_pcie *imx_pcie)
+{
+	bool ext = imx_pcie->enable_ext_refclk;
+
+	/*
+	 * Regarding the Signal Descriptions of i.MX95 PCIe PHY, ref_use_pad is
+	 * used to select reference clock connected to a pair of pads.
+	 *
+	 * Any change in this input must be followed by phy_reset assertion.
+	 */
+
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_GEN_CTRL,
+			   IMX95_PCIE_REF_USE_PAD,
+			   ext ? IMX95_PCIE_REF_USE_PAD : 0);
+
+	return 0;
+}
+
 static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
 	bool ext = imx_pcie->enable_ext_refclk;
@@ -265,9 +284,6 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 			IMX95_PCIE_PHY_CR_PARA_SEL,
 			IMX95_PCIE_PHY_CR_PARA_SEL);
 
-	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_GEN_CTRL,
-			   IMX95_PCIE_REF_USE_PAD,
-			   ext ? IMX95_PCIE_REF_USE_PAD : 0);
 	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
 			   IMX95_PCIE_REF_CLKEN,
 			   ext ? 0 : IMX95_PCIE_REF_CLKEN);
@@ -1237,6 +1253,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->bridge->disable_device = imx_pcie_disable_device;
 	}
 
+	if (imx_pcie->drvdata->select_ref_clk_src)
+		imx_pcie->drvdata->select_ref_clk_src(imx_pcie);
+
 	imx_pcie_assert_core_reset(imx_pcie);
 
 	if (imx_pcie->drvdata->init_phy)
@@ -1938,6 +1957,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
 		.core_reset = imx95_pcie_core_reset,
 		.init_phy = imx95_pcie_init_phy,
+		.select_ref_clk_src = imx95_pcie_select_ref_clk_src,
 		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
 		.enable_ref_clk = imx95_pcie_enable_ref_clk,
 	},
@@ -1992,6 +2012,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
 		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
+		.select_ref_clk_src = imx95_pcie_select_ref_clk_src,
 		.init_phy = imx95_pcie_init_phy,
 		.core_reset = imx95_pcie_core_reset,
 		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
-- 
2.53.0

