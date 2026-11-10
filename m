Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337494;
	b=n0W1SPdeztL2JQRCzFMZ5VDEuO9LMWYxnrMQLZCexdPnpwUPaTZBRzF0OZX12gBrkIwm
	 BIqWy0zpdQy9ex+h3vptY6ZDFcUdCEcWQQ7zPSWBqEVcpIVd2ymm8lkUUMDjOeA/aPJUS
	 BLXqYrZDbfUCa2LdmB40T7f7qwOsfByF3T4S8/E/lbvc5w8WCfcw+veAnuMWMQg3TdQZi
	 nyOeHCG6zm4kkFZGchnWPKkXN79hKkxsoOG2/FnW5EzsvHI7mgjcaNP1SMdJqEyS6zE0p
	 pitNJJG7ftYFeWpvkHr2E81c6XtD7Anle6kFlzoaxzQKK5IKw2D3EL3Lz5b078qle+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337494;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ltk5Cl9nHyL78Vy2SEPkcVeO7MGczi6TaQBW2DvXXK4=;
	b=RaFg+cds1357MtGvBdYsza/R784rIURDe18FiE1fn/tW9hNXaO7+nRoql0cW0db0m8UO
	 vf3oISDVMK/Z7jZ7AK0xMGq07bfzok27it5BOtsF9wy8kFcdsnksInKCODkPgnoDRPnjh
	 Hc+4tXAH937EQWUlE9vnWMdjEn1DiIgEwmmKdmeTKd1X9TJA6Qh1esZaq40lp53Tu3zM/
	 z3Ov3Lbr3iDYYC20mVRxjJeHqAWPo+4y1eq+eLlJrhzq75pDPPhM7+Ztap/vwIolf/8W2
	 5PzOkhHPIJloVpeZYXs2PFstnUpb4gc029EWUZNrAQQ2aq8NEPNeWSS8zxFFaX+58PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JQqr2IuP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC602606A333
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JQqr2IuP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AFB1F008A1;
	Tue, 10 Nov 2026 19:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794337493;
	bh=Ltk5Cl9nHyL78Vy2SEPkcVeO7MGczi6TaQBW2DvXXK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JQqr2IuPdfbtU3/s9ICect4nVUrrsbE9JfUKPYgfGsBn9CNtqyHByjOCLDNIBQ46Q
	 zkwJL/O8bdQCv3wyxZpBDnw6iKgsPU86BMfmwKN1t6Fm10LduOHHIaziFvvx5U7Vs3
	 6jB+oZu4FhslJmhkEeXIGeYJoxl+yvWxL4HKDkidwRWncBCgTnoCfcklIUWg0nuDQz
	 KL4t/uKyS+8f7z1/K35PDCFaOtnmMcx2rZAq6Rk6Y06pp3nzhcHr/lAAHl8nNEanKL
	 z7s2RHLnthrFS373pYC7Mqt3mppbl8xq7WxyWcGMS1j3mrwVECwDE85XQdYuMrhsug
	 iweuvapb8f+Mg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geraldo Nascimento <geraldogabriel@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] PCI: rockchip: Drive at 2.5 GT/s, error other speeds
Date: Tue, 10 Nov 2026 14:04:50 -0500
Message-ID: <20261110190256.3444362-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052207-failed-6.12-84d08ff902f1@kernel.org>
References: <20261107052207-failed-6.12-84d08ff902f1@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geraldo Nascimento <geraldogabriel@gmail.com>

[ Upstream commit 84d08ff902f1ec01177fef1a21a38934927f5aee ]

Configure the core to be driven at 2.5 GT/s Link Speed and ignore any other
speed with a warning. Also drop the 5.0 GT/s Link Speed defines from
Rockchip PCIe header.

The reason is that Shawn Lin from Rockchip has reiterated that there may be
danger of "catastrophic failure" in using their PCIe with 5.0 GT/s speeds.

While Rockchip has done so informally without issuing a proper errata, and
the particulars are thus unknown, this may cause data loss or worse.

This change is corroborated by RK3399 official datasheet [1], which states
maximum link speed for this platform is 2.5 GT/s.

[1] https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datasheet_V2.1-20200323.pdf

Fixes: 956cd99b35a8 ("PCI: rockchip: Separate common code from RC driver")
Reported-by: Dragan Simic <dsimic@manjaro.org>
Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com/
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/7421df7a7b7778ee99363cccfdfabbfa8aa6ab5e.1781622998.git.geraldogabriel@gmail.com
[ sashal: Adjusted context to preserve existing HIWORD_UPDATE macros instead of upstream HWORD macros. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip.c | 14 ++++++--------
 drivers/pci/controller/pcie-rockchip.h |  3 ---
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index c07d7129f1c7c..6a970dc766d4d 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -66,8 +66,10 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 	}
 
 	rockchip->link_gen = of_pci_get_max_link_speed(node);
-	if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
-		rockchip->link_gen = 2;
+	if (rockchip->link_gen < 0 || rockchip->link_gen >= 2) {
+		rockchip->link_gen = 1;
+		dev_warn(dev, "invalid max-link-speed, limited to 2.5 GT/s\n");
+	}
 
 	rockchip->core_rst = devm_reset_control_get_exclusive(dev, "core");
 	if (IS_ERR(rockchip->core_rst)) {
@@ -237,12 +239,8 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		goto err_exit_phy;
 	}
 
-	if (rockchip->link_gen == 2)
-		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_2,
-				    PCIE_CLIENT_CONFIG);
-	else
-		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_1,
-				    PCIE_CLIENT_CONFIG);
+	rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_1,
+			    PCIE_CLIENT_CONFIG);
 
 	regs = PCIE_CLIENT_LINK_TRAIN_ENABLE | PCIE_CLIENT_ARI_ENABLE |
 	       PCIE_CLIENT_CONF_LANE_NUM(rockchip->lanes);
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index d916fcc8badb8..5629ac4a7439b 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -37,7 +37,6 @@
 #define   PCIE_CLIENT_MODE_RC		  HIWORD_UPDATE_BIT(0x0040)
 #define   PCIE_CLIENT_MODE_EP            HIWORD_UPDATE(0x0040, 0)
 #define   PCIE_CLIENT_GEN_SEL_1		  HIWORD_UPDATE(0x0080, 0)
-#define   PCIE_CLIENT_GEN_SEL_2		  HIWORD_UPDATE_BIT(0x0080)
 #define PCIE_CLIENT_LEGACY_INT_CTRL	(PCIE_CLIENT_BASE + 0x0c)
 #define   PCIE_CLIENT_INT_IN_ASSERT		HIWORD_UPDATE_BIT(0x0002)
 #define   PCIE_CLIENT_INT_IN_DEASSERT		HIWORD_UPDATE(0x0002, 0)
@@ -183,8 +182,6 @@
 	(((x) & PCIE_CLIENT_DEBUG_LTSSM_MASK) == PCIE_CLIENT_DEBUG_LTSSM_L2)
 #define PCIE_LINK_UP(x) \
 	(((x) & PCIE_CLIENT_LINK_STATUS_MASK) == PCIE_CLIENT_LINK_STATUS_UP)
-#define PCIE_LINK_IS_GEN2(x) \
-	(((x) & PCIE_CORE_PL_CONF_SPEED_MASK) == PCIE_CORE_PL_CONF_SPEED_5G)
 
 #define RC_REGION_0_ADDR_TRANS_H		0x00000000
 #define RC_REGION_0_ADDR_TRANS_L		0x00000000
-- 
2.53.0

