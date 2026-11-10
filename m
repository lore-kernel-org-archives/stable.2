Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344510;
	b=lwtgbuFn0OrJzba8k9FKYqVhVbcPmRJ7U1HuqNtoIIu7LppEoZebr8QprbQ3kxYEKrQf
	 L58IcD2Au9CTZCNXfFnw9vgcgHcjrDVLu80P6JMo3XsFtvbuCM/rU8K0pw+8Pbk0N5aTq
	 kK3o37UrO2SPidh2MquJDGTbpn7S1YnpZPV7C2HgkeVtPYKl7KYr1mqZ4v+0PeBDx7HLR
	 zOj7frlnc46LhOgJC1NRt2h6CXC7zSPSr0rqTk/WeLuQdKQ5zGiImDdjDIgtNWZotklWP
	 5Ze7+i8ioOJyWWXC+7BLNMUJRzUHCpND3u+VS02UuCYxGlqGDC21lAKqsqLO5jWeOig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344510;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Vv52BUu+yHpTKvDsYRFb7+TNMQbw5WkkSHERM8Z9L2Q=;
	b=HvhKPW6fco+GvDCIcOXxlV9B/jM1AZUmev4mvA3kCHJveimKg7ymJqcRCptFpx6Fd7Vu
	 3by8P21IrCCCLhM9ckeEkju6rl2nPf1yL2Hw0MDZaLLzAwPWrVFX9Eqm+j5206KOb/lkF
	 MFb2HoTjtCzNFARvARSYhYjyT/XM9E3BWBphBdTrahVpkgUqBt5ehF8lWO98KgVdUT2YX
	 dnWux5MMU8hgENAgYpM/CdmwYINNZk3q8//vCBSR3LNlDQrq15brMNYDP2C7kb8ntk2Zr
	 duQPlyBgDLzvQKatBX7Fv3fgdZ/P6qeFT3zbeFknNM2H9t52wCy4uVj5XtevM6Tbocg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S2faPJcv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EF2606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S2faPJcv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D05E1F0089F;
	Tue, 10 Nov 2026 21:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344509;
	bh=Vv52BUu+yHpTKvDsYRFb7+TNMQbw5WkkSHERM8Z9L2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S2faPJcvgE3oDeV9f80ZvGNRW/gks9Sh1RkKtxF1Vki+Mhzoo7yFAAaa85bU+0+HS
	 A9hZYIN633H1j7zJjYO4kOlJfIgBiC++vPmC1v6UUQ7mrYvAv1LmcqJybg1YXftF5r
	 Zmrt58nO3yiB+HlUzllqGzNdRaUdhLJTceU36Ki7r9cBYzW7ut/7o9gBnoDLT8nGYZ
	 EIxV3li5snS9H58OlUnExFWsxj41MH378yCFzVKdqJ/BhH5HAOIupGn0LjFS2hfcnI
	 U1cBtSEvS1UTfoX4n5HAPWjHKnyhPuiZtX3qylTmCy6SJY/dUmY/76ZY8Up31lWNk8
	 4YJdCs8u9C9yw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geraldo Nascimento <geraldogabriel@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] PCI: rockchip: Drive at 2.5 GT/s, error other speeds
Date: Tue, 10 Nov 2026 16:01:47 -0500
Message-ID: <20261110210127.3796812-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062224-failed-5.10-84d08ff902f1@kernel.org>
References: <20261107062224-failed-5.10-84d08ff902f1@kernel.org>
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
[ sashal: adapted header cleanup to existing HIWORD_UPDATE macros where PCIE_LINK_IS_GEN2 is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip.c | 14 ++++++--------
 drivers/pci/controller/pcie-rockchip.h |  1 -
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index bdce1ba7c1bc0..c1567a2ef1890 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -65,8 +65,10 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
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
@@ -236,12 +238,8 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
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
index de78a3091b6a1..1708a5cc750fd 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -36,7 +36,6 @@
 #define   PCIE_CLIENT_MODE_RC		  HIWORD_UPDATE_BIT(0x0040)
 #define   PCIE_CLIENT_MODE_EP            HIWORD_UPDATE(0x0040, 0)
 #define   PCIE_CLIENT_GEN_SEL_1		  HIWORD_UPDATE(0x0080, 0)
-#define   PCIE_CLIENT_GEN_SEL_2		  HIWORD_UPDATE_BIT(0x0080)
 #define PCIE_CLIENT_LEGACY_INT_CTRL	(PCIE_CLIENT_BASE + 0x0c)
 #define   PCIE_CLIENT_INT_IN_ASSERT		HIWORD_UPDATE_BIT(0x0002)
 #define   PCIE_CLIENT_INT_IN_DEASSERT		HIWORD_UPDATE(0x0002, 0)
-- 
2.53.0

