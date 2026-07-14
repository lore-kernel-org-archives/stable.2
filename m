Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36F93CF204
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053276; cv=none; b=sHwOD4U4fLMxrWVIvYAKcxOZ3rmo+gTYWPwYnp/8DaupcN9e1y9m7DlCieSit3wF8SZ3lk+tIGcixEp3DD8mEYnYE9TYFfMEuUkiG+2P9TdAAHRIK+jFLrkvzM8mLpo/Tk2UCZdQXQyl+fY1GbSB9ranyUmnU7tJxbiqgq4vACI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053276; c=relaxed/simple;
	bh=1ppw4XdZA8uVbAbcxpD99MmvyLgsgvCe2DbzUdCCiOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmV3S+KKRdmxjZ+W3tLuKaGC90suDXc8ptTpOkwlLUkpb7BU57l8mJ55DYFnphvTsCwD7QkNSueEgOSYC8oQwQ5n8mwMrutbnj4OeIu0Nd0Xnkf0mVyqlXMahpTo3wWvFGpSGzJO70ZyZnp/x3+z2Hy0TLcQw/hDfKekOTvvsWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjgJ/JWK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjgJ/JWK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57451F000E9;
	Tue, 14 Jul 2026 18:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784053275;
	bh=biQMdFE+SIuK38t6fw9ISLz//c8kIWIueIbLhn4ss1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QjgJ/JWKCU0eCAdK+7OAh1WjgrWyhAuCbb/4Kbnz2zwCNKOC4KmE61ky+wGeg5F+J
	 oKCilH8DcMDcRw9BNMbivvIo0qzIZoozOGoIIeibt1Ys9KdWxV0zzx6PGyR9hPozHr
	 1Jfx2YhztAYKfr1zMgRpV6tixDX5SaAYAYn1C/xhr9tbR7LXnSzozqjkQH+BIfIxY1
	 q4pmjbgg5cU17LkiYkY9K0PDd3TcuZS8PIoN1tgN1QN+zd8Ppc+VJcqq1cuBoa7WcI
	 Q72eauxlQ/FyFNiXy7oAj/vcgDbYdJNIq5yXTkuupbf6YupJR2RwI7M64+Yz7DGPVs
	 isP4AntrGaewQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] PCI: imx6: Fix IMX6SX_GPR12_PCIE_TEST_POWERDOWN handling
Date: Tue, 14 Jul 2026 14:21:13 -0400
Message-ID: <20260714182113.3081792-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071331-starfish-handgun-6882@gregkh>
References: <2026071331-starfish-handgun-6882@gregkh>
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
index 4f20094faee532..7ebf5889687597 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -539,9 +539,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 			dev_err(dev, "unable to enable pcie_axi clock\n");
 			break;
 		}
-
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
 		break;
 	case IMX6QP:
 	case IMX6Q:
@@ -740,6 +737,8 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
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

