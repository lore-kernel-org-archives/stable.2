Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0305E4C8FFD
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059353; cv=none; b=C+pLQDk9hqwNngHopvOsNsmO2gAvPny8mKNpAKp2F2a2M1yi4FYJP4CRUpqq9qfLV+u+DYc/mtC97QfPcRKQqYbg95BX9U4afUXdJUogBQtRFlyBRBY1mjjTfWGxkSGpa+iUr9Zl/adSTvpWAASbiyRkr/yy9XSB5ZXDusmQYF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059353; c=relaxed/simple;
	bh=rclWcM5QRFLBqWzHopl0KzVW/LdI76BpQr5SSrS4fms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxfemEMbCOPyABpjdK/u376Mdyz8/b3bmHhkQS4pFuk7+plRudY/MuKY04dH19QXOxOG0WwqkmUnADZPBZWu9VNcUI73UQwF0hu9iQjq0Vnb3rx2jjZXiJZK7aTUaHOEVI+VWaxrp46erx4wSTyW+V0JQB1zc5ZdvG0Q2EoY6UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTlr3j8e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTlr3j8e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1FC1F00A3F;
	Tue, 14 Jul 2026 20:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059342;
	bh=qWYkKpODIi7DVjT4zuS8XsqbwNWMfXKf/Wynv7q7fzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FTlr3j8eyjx0nU5cjBVIziwE0pZp6DADiuBVuZOJAFUqcHXiRgGtyCVbnSheU28MZ
	 Q+rcI6XOZhKiAVKuOyDpcacnkl1Fz4gDZLzgJJhvMFtEXJ21ouSyRf25Ucc6UigHG/
	 gHT1Ii6J/4Ls+RWV7gllZU1DZdgN6WL+ckYFvQ0vMErT8ubGtsKTP9i1iarRK4FYrN
	 VNSS3QubjURcV7WJeMG8yHH1ytrJ0FPLPomv0Tjg5/2eDw29Lbp4cF3WwkzQTDPnqc
	 RMKDntRScnGzBiNxVHRBdwARacl75tjYtW9RCq39TL1fJbaH0g8q0jf0ajghMwIrLh
	 9UiBI/vE8lRGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] PCI: imx6: Fix IMX6SX_GPR12_PCIE_TEST_POWERDOWN handling
Date: Tue, 14 Jul 2026 16:02:20 -0400
Message-ID: <20260714200220.3152632-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071350-dealmaker-sliding-cb76@gregkh>
References: <2026071350-dealmaker-sliding-cb76@gregkh>
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
index 7766b5b1492903..20f7d3f6db160f 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -430,9 +430,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 			dev_err(dev, "unable to enable pcie_axi clock\n");
 			break;
 		}
-
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
 		break;
 	case IMX6QP:
 	case IMX6Q:
@@ -559,6 +556,8 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
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

