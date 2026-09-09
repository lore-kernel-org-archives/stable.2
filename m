Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB8032B124
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954338; cv=none; b=noYNYCBGGs/9ryKYFZey3Q7JyGgpRgo3KbHvZcpsWiXGISaIYqzY8+b+8K3ry9jh+FdmZgne/9/YsS2k9K4Ur1VxIuowjwrbEQkr6HXIBTPLcYP+KOpXCMJdwWmPolDKO3Yna3jBDbUDjTJ8TPVxmwTunKI65QVn33M+j5tow4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954338; c=relaxed/simple;
	bh=HWzIbtmQT+7Rk4hnVVZzBay+ffsBoG0eN4L05XTN6lY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXLWPu+c2BMS7E8OFglNrCPr9+QpvH7GyNEQjWMO68XEGvEq9jhCC7MzkpLkx0Ji6FuVcpIamnN0n1iE58IVIHBpzs7brBRAdMlPgiXXbBub3XFQeB/BlRizcGZ0OgHuY4hW5xVrbtjsx0B9JLVNpBM2gU6AZn8Mni1c3jJeikY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKSlTVN3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKSlTVN3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D95F1F00A3A;
	Wed,  9 Sep 2026 11:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788954337;
	bh=LY+4QVJm4IP3q7Wts4BxyHjGmww2LsNjqBpgdPxFbF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SKSlTVN3WhLjjqx/wGVPGZbIlTP6O0O25icu84HU49wRp4ckHf7SD7Ib7zlSFU0sX
	 5/8H0F9H8gW72zUOXvKqd0GVsKC/ggE94deSGxzGEJO4BTFxGOUaupLiwWiw45f4dr
	 uCTkRUB67z9LaHMg+kT9/kwQW7mLaBHTxg3u0Kvs6bdqv1Gvh3Y03ex64LmQj4Jv0R
	 xZGn2P1zqOukURD2qZxi/KDJIQ4/2THQq+yKonXB/7uW0k9MLnZYjj/JFnUnoydHOH
	 1VJOLZaUbcuqwGJUB7KvquJxayeAdQ42o2oFfvvyScp3T2OMWvvjpToii2mgAoFRp2
	 852umQxtnEj6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hal Feng <hal.feng@starfivetech.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] PCI: starfive: Use regulator APIs to control the 3v3 power supply of PCIe slots
Date: Wed,  9 Sep 2026 07:45:34 -0400
Message-ID: <20260909114535.1984399-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090319-aground-reaffirm-2ce7@gregkh>
References: <2026090319-aground-reaffirm-2ce7@gregkh>
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
index 0a0b5a7d84d7e..3234151a29702 100644
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

