Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC77F426693
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949184; cv=none; b=EDIsrQbXGacGcALVv03n9YGQBijgcRTw1X7NZdv+fhweOd6OFNxcp+dQEBBFbgRPtSncpd9z2i/suYVmaaMPa4NUx0a0B1GjY3BjflZN1QCCH4/I8C5NLGq3A+apfZk2SRS/MDr9Zy4SSTDOAxNBo6UiZtc3OvUeiDFm9FI1cjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949184; c=relaxed/simple;
	bh=Lbu4XNzJV623IvIa2zaOEiz/d9HLBORs7xtTZlPyl9s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VUiBwsJbFvWJDyhfOuL+fciBUrE5Ap9HGMxjbdmaAtQpfs8FGnwcWqfrjS/s2cgSP+J0oAFagm91pS2kSx8+QIUBPJq2RB8WSrndtlcc/WVFs2yfLJuuseUgDo3QMASGVVFOujl8P4E8/XSckB+f8/Xt6SWquywLgks0yOqfybM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JCqK7S90; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JCqK7S90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1661F00A3D;
	Mon, 13 Jul 2026 13:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783949182;
	bh=9RzSUT5BbDxX8xqN6pF3MHYy+RoDSqC8b/KLvAOIHjc=;
	h=Subject:To:Cc:From:Date;
	b=JCqK7S90ESlIRQ+hutbcduf3vzlNdpcMOjk+CBQSiYnKgOnflc8M8GwJ0vcVkFE/8
	 kkaIgDdIk328XYSGeZ5uTFrgyVC9uqdyufqn7WY5JXs/92vKR5sveXz+QzZpNB4iiL
	 h7riARAQ0lDYWTcT/o4eX131VGcKdbwFfXd+P6s4=
Subject: FAILED: patch "[PATCH] PCI: imx6: Fix IMX6SX_GPR12_PCIE_TEST_POWERDOWN handling" failed to apply to 5.10-stable tree
To: hongxing.zhu@nxp.com,Frank.Li@nxp.com,bhelgaas@google.com,mani@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:22:12 +0200
Message-ID: <2026071312-buffalo-salvation-f750@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x aad953fb4eed0df5486cd54ccad80ac197678e01
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071312-buffalo-salvation-f750@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aad953fb4eed0df5486cd54ccad80ac197678e01 Mon Sep 17 00:00:00 2001
From: Richard Zhu <hongxing.zhu@nxp.com>
Date: Thu, 19 Mar 2026 17:08:44 +0800
Subject: [PATCH] PCI: imx6: Fix IMX6SX_GPR12_PCIE_TEST_POWERDOWN handling

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

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index e35044cc5218..1034ac5c5f5c 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -665,14 +665,6 @@ static int imx_pcie_attach_pd(struct device *dev)
 	return 0;
 }
 
-static int imx6sx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
-{
-	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-			   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
-			   enable ? 0 : IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
-	return 0;
-}
-
 static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
 	if (enable) {
@@ -786,6 +778,9 @@ static int imx6sx_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 	if (assert)
 		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
+	else
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				  IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
 
 	/* Force PCIe PHY reset */
 	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5, IMX6SX_GPR5_PCIE_BTNRST_RESET,
@@ -1877,7 +1872,6 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx6sx_pcie_init_phy,
-		.enable_ref_clk = imx6sx_pcie_enable_ref_clk,
 		.core_reset = imx6sx_pcie_core_reset,
 		.ops = &imx_pcie_host_ops,
 	},

