Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6875342E007
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949186; cv=none; b=oRxp1vllSY4Bule7kYSIkavg3tZNvRvoDiptbyAnOszQ7Xn279dCrfk6jqh3ta9Q3tjh7/c/fqdCgZqj08h84ayElC9abm3jYIW7V/N/2RylIUxdCygTW9VFBy5djTKci7aD+t4GNstqPlo8dYl3cgD6/BzzRZ2nkrcy7Ud9ZmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949186; c=relaxed/simple;
	bh=fbVRtXN+R6V9Vlodm+5mqK5DQAHuoxSPyPG/+tJkpwI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=q0+qKxqBSXgYcC6MG75PrfreBzT1TfETP3tzOocBWdfgwjeJDILgE4pdsAV/ZmoJbF3geDtA5p08JN4awbP6bqQ9vo9npg5WWzrK7kQic0H/Qmbb60YYRIwGwCsZmwyoF5oQJqSYw/SoptofGaOTSY48WU5C76EQPYX5Q5PUEC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ICcxKNp9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ICcxKNp9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3291F000E9;
	Mon, 13 Jul 2026 13:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783949185;
	bh=9sM71cY5avL12fFA7UQF15qvCzj+6A1aKyOSTAV95KY=;
	h=Subject:To:Cc:From:Date;
	b=ICcxKNp97ipoEPIlTDrSoh1hW/v5paACclUhSqnspBzztk79KOtuzd+vFhBnzXu6e
	 yK4Z3Bm3B7FrQGyc5VYR8YnTzn88oTrjwUBzWL9vYbXAdK/Z5mzJ1MayLPkmCZx+Um
	 Cre2wtV72fOWIncSGosO8NEOSgU3fZcoOHBGz8a0=
Subject: FAILED: patch "[PATCH] PCI: imx6: Configure REF_USE_PAD before PHY reset for i.MX95" failed to apply to 6.18-stable tree
To: hongxing.zhu@nxp.com,mani@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:22:31 +0200
Message-ID: <2026071331-exit-kinfolk-e3f9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 0c26b1c34d12d4debfb5363cc0be6cdf68e87ba2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071331-exit-kinfolk-e3f9@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0c26b1c34d12d4debfb5363cc0be6cdf68e87ba2 Mon Sep 17 00:00:00 2001
From: Richard Zhu <hongxing.zhu@nxp.com>
Date: Mon, 18 May 2026 15:27:14 +0800
Subject: [PATCH] PCI: imx6: Configure REF_USE_PAD before PHY reset for i.MX95

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

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 773ab65b2afa..b32748816ac8 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -138,6 +138,7 @@ struct imx_pcie_drvdata {
 	const u32 mode_off[IMX_PCIE_MAX_INSTANCES];
 	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
 	const struct pci_epc_features *epc_features;
+	int (*select_ref_clk_src)(struct imx_pcie *pcie);
 	int (*init_phy)(struct imx_pcie *pcie);
 	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
 	int (*core_reset)(struct imx_pcie *pcie, bool assert);
@@ -249,6 +250,24 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
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
@@ -271,9 +290,6 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 			IMX95_PCIE_PHY_CR_PARA_SEL,
 			IMX95_PCIE_PHY_CR_PARA_SEL);
 
-	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_GEN_CTRL,
-			   IMX95_PCIE_REF_USE_PAD,
-			   ext ? IMX95_PCIE_REF_USE_PAD : 0);
 	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
 			   IMX95_PCIE_REF_CLKEN,
 			   ext ? 0 : IMX95_PCIE_REF_CLKEN);
@@ -1351,6 +1367,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->bridge->disable_device = imx_pcie_disable_device;
 	}
 
+	if (imx_pcie->drvdata->select_ref_clk_src)
+		imx_pcie->drvdata->select_ref_clk_src(imx_pcie);
+
 	imx_pcie_assert_core_reset(imx_pcie);
 
 	if (imx_pcie->drvdata->init_phy)
@@ -2051,6 +2070,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
 		.core_reset = imx95_pcie_core_reset,
 		.init_phy = imx95_pcie_init_phy,
+		.select_ref_clk_src = imx95_pcie_select_ref_clk_src,
 		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
 		.enable_ref_clk = imx95_pcie_enable_ref_clk,
 		.clr_clkreq_override = imx95_pcie_clr_clkreq_override,
@@ -2106,6 +2126,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
 		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
+		.select_ref_clk_src = imx95_pcie_select_ref_clk_src,
 		.init_phy = imx95_pcie_init_phy,
 		.core_reset = imx95_pcie_core_reset,
 		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,

