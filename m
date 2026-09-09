Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4A554A7C5
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954047; cv=none; b=PS/noydD8B/QojXaG0j11Z1FaqJb9MGhiavtMh+ITMnuxRR2RJIMYM/0cyY95QKS/pyIdndJ/fJs8PVeAhpZFUCQZrJ99kAuEPq5e0PFF5mnDrlJMSTz+hkPwhl2QMGlekm6TNPjHojGA6qGV8jS9Li2eSQWAOKLcOP5cIIWGiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954047; c=relaxed/simple;
	bh=LfqtaAh19sCpusPkKbPhppo212XwgLW7qJK3/HK4K34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3gEmaQW8bdwLVxTNNSVN8jgb2KuoIJFIMqp1m5yjd+7Hxry0SVQm79h4x5EFDbJ2MCGq1MDBOaqHlo2W6d9+WH7QTsqE7DYS7bCbmnsx+6zoEBz4fCwgGyGWi0TitQNll8H45Tih6HkwQnJmIeHWsph2Ethr+Seq9OK4EFma/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBscbvEk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBscbvEk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B803C1F00A3D;
	Wed,  9 Sep 2026 11:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788954045;
	bh=at6CTEMIxcMbEbh4WSHvBgJjdYqJf8B/57Y1XxUfVC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jBscbvEkg04EwkElkZmZjEdgG8u8uVGnr1olKPbYM+Skm6emVKJtg5dee9XADRs9s
	 8/vb61HfGjaPKAsTjBxiHr39K4DH4N541k2NwdKFPXdbrQGUM+x0n75Hv2iD/bv6Wa
	 kifjtNnSyxKMzS936+oyrd144ieEciS6CV9fTZGYz6CASF67tV1AWZESlOF7yUBNVE
	 DMNt0t1iHWFZcytJvj7oaeuWUbhd3B3WW6n7C8AmjuEmMbbgdxIG4qHoh/K7nNZalv
	 oMIzxg2cpYMpvYNNlNA0Cr54BNcgF7U2D0LcR34IqDnKS05Txpu9aQhJNQf+lvY3zS
	 PIja4wC7YaDgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hal Feng <hal.feng@starfivetech.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] PCI: starfive: Use regulator APIs to control the 3v3 power supply of PCIe slots
Date: Wed,  9 Sep 2026 07:40:42 -0400
Message-ID: <20260909114043.1916582-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090319-enviably-stuck-b18b@gregkh>
References: <2026090319-enviably-stuck-b18b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hal Feng <hal.feng@starfivetech.com>

[ Upstream commit 05a75df4182e301a1b0059606f77b65c74deaa9b ]

The driver has been using the "enable-gpios" property to control the 3v3
power supply of PCIe slots. But it is not documented in the dt-bindings and
also using GPIO APIs is not a standard way to control PCIe slot power, so
use the documented "vpcie3v3-supply" property and regulator APIs to control
the slot supply.

This change will break the DTs which used "enable-gpio" or "enable-gpios"
property under the controller node. Since these properties were not defined
in the bindings, it is safe to switch to "vpcie3v3-supply". Any out-of-tree
DTS impacted by this change should migrate to "vpcie3v3-supply" instead.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
[mani: reworded description]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Acked-by: Kevin Xie <kevin.xie@starfivetech.com>
Link: https://patch.msgid.link/20251218102149.28062-1-hal.feng@starfivetech.com
Stable-dep-of: 22877a061f81 ("PCI: starfive: Fix resource leaks on error paths in host_init()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/plda/pcie-starfive.c | 25 ++++++++++++---------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index 3caf53c6c0823..298036c3e7f94 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -55,7 +55,7 @@ struct starfive_jh7110_pcie {
 	struct reset_control *resets;
 	struct clk_bulk_data *clks;
 	struct regmap *reg_syscon;
-	struct gpio_desc *power_gpio;
+	struct regulator *vpcie3v3;
 	struct gpio_desc *reset_gpio;
 	struct phy *phy;
 
@@ -153,11 +153,13 @@ static int starfive_pcie_parse_dt(struct starfive_jh7110_pcie *pcie,
 		return dev_err_probe(dev, PTR_ERR(pcie->reset_gpio),
 				     "failed to get perst-gpio\n");
 
-	pcie->power_gpio = devm_gpiod_get_optional(dev, "enable",
-						   GPIOD_OUT_LOW);
-	if (IS_ERR(pcie->power_gpio))
-		return dev_err_probe(dev, PTR_ERR(pcie->power_gpio),
-				     "failed to get power-gpio\n");
+	pcie->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
+	if (IS_ERR(pcie->vpcie3v3)) {
+		if (PTR_ERR(pcie->vpcie3v3) != -ENODEV)
+			return dev_err_probe(dev, PTR_ERR(pcie->vpcie3v3),
+					     "failed to get vpcie3v3 regulator\n");
+		pcie->vpcie3v3 = NULL;
+	}
 
 	return 0;
 }
@@ -270,8 +272,8 @@ static void starfive_pcie_host_deinit(struct plda_pcie_rp *plda)
 		container_of(plda, struct starfive_jh7110_pcie, plda);
 
 	starfive_pcie_clk_rst_deinit(pcie);
-	if (pcie->power_gpio)
-		gpiod_set_value_cansleep(pcie->power_gpio, 0);
+	if (pcie->vpcie3v3)
+		regulator_disable(pcie->vpcie3v3);
 	starfive_pcie_disable_phy(pcie);
 }
 
@@ -304,8 +306,11 @@ static int starfive_pcie_host_init(struct plda_pcie_rp *plda)
 	if (ret)
 		return ret;
 
-	if (pcie->power_gpio)
-		gpiod_set_value_cansleep(pcie->power_gpio, 1);
+	if (pcie->vpcie3v3) {
+		ret = regulator_enable(pcie->vpcie3v3);
+		if (ret)
+			dev_err_probe(dev, ret, "failed to enable vpcie3v3 regulator\n");
+	}
 
 	if (pcie->reset_gpio)
 		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
-- 
2.53.0

