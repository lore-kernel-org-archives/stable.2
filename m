Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7407342E007
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949178; cv=none; b=fvc1epfpqvyS/z+v286wVANSPXg7nmk+F+c7GcaqewsRKCTar4WTj4euBAxqCwpQiSYHFoyyICLJ07aZQHXaYu2O4BOy22ZOdGT2qbrKyd9Hoyk9FUD7b2pV6rEM/345zfYpgkXiB2y6ykpvQlnEbW5R1v9JSO/urpcCe7eZB0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949178; c=relaxed/simple;
	bh=M7NcNTHDhWFD8ZzDpWOE3wg1PnF+6DU2RA0RF2+cgYk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UNO5ZbZgneXrAaL7K3f70n5opO+SAGfMvohcpqkzku6m0x2zPRVodEq7N1AS6Btb3a3jcXUu5umXcC1n2FWyCaq/ye0XEDsEsx5QgQLJ/+oEIcqOx2OcRntsPrG0AKV/vHevdWpn4fhFdBMJmWDb2RoLovjYJEF6iYXRImZJfGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2NdEhUw1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2NdEhUw1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35491F000E9;
	Mon, 13 Jul 2026 13:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783949177;
	bh=5VJynlIiGtBszwb0ikpuPJ8/lm2ZDVY0kUwedtNcd1A=;
	h=Subject:To:Cc:From:Date;
	b=2NdEhUw10L5aeuGyTxuIIb7UKythtBFMdVSr8Mi7lc2Khwv2Dweji/jBVXp+wxQ9Y
	 f2vmXhfcoOKFf/fKptH2pNpY5lBiL1JyUXHXCuMZXZo6fiOuv1urYy7/t4Ibypppi2
	 NOV2e4FISo7sZ5ZSVnBhVr6gy/eCa5bPmLNeavl4=
Subject: FAILED: patch "[PATCH] PCI: imx6: Fix IMX6SX_GPR12_PCIE_TEST_POWERDOWN handling" failed to apply to 6.1-stable tree
To: hongxing.zhu@nxp.com,Frank.Li@nxp.com,bhelgaas@google.com,mani@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:21:31 +0200
Message-ID: <2026071331-starfish-handgun-6882@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x aad953fb4eed0df5486cd54ccad80ac197678e01
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071331-starfish-handgun-6882@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

