Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405876;
	b=vuoaAuV5G4DqwFqufhbk+N8Lvrd5K6bm5p7w9trLXUrHLvHGr4KKl56kmaqgWLfeUHIL
	 bTRjmUzbv+OEgOZMZ4B2J8++GKr89A40N/jvk1QlC8RDWnlEE7oX7QX0lG1zK3+waNS3o
	 TFqsyD+mas86AssW0F4B4NmI9AJja2nChXPYEt/8if5Hd7qV40AEqb6QRwkax/yHfpdi2
	 yZU7j1eHkI7A0VCCp0j9v7163vhNxvaBImNKjV0Ae7NUN3W0Gz4QEeJX1Yn7mO8gccGT+
	 5pe3tIopbS9R7axoaAZbKrJaI5Yd2at9VXuclKgyhf/uTM6PS6sefm+JYryCGPduDgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405876;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=o/3/7YwdNvnfhiJsfdYc5wPcT1t2X0L5LeZ7MOQ0H4s=;
	b=33W2gc0iI430L1WQYirw31n+nnJd4FrgADXTpvN65buJl+7IbMko5tP1dgmR4rUSU8Jz
	 y6oPe4PgehQ78gS75UZzCo1EUMqtvo3tJrCmWwVT8RVL/zkDshtg9XOjxXQjgxvQqXCOz
	 uYCC3PNkWjE/jAvTxSnZtYz64VKODf2aB8Ro+0b9O3mQdubuAGBwNmtF0xl+lIPpBet2d
	 hH0itk8feddRuKtQNQyxJdh3svegNS9UmsPo6zAgLDrKhPCtzkzpvgAuyICe2GnJgH82B
	 ROQWFc+kHhpr2p8pyIiSLTj/UswGPCstRpkvO6hvyurlcrKGpwl1+Uxmg8CVq5o5iZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V1beubmx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B6D606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V1beubmx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4821F00A05;
	Wed, 11 Nov 2026 14:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405876;
	bh=o/3/7YwdNvnfhiJsfdYc5wPcT1t2X0L5LeZ7MOQ0H4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V1beubmx0gULtHTK9iZ6ZUie27vhLloRfLrNdbL6BBdHT9FkvegMR8avjNbRl5Cno
	 xLM30h7xUYamqyMqtXjHaRUkqLoniqKUjopIVK6109V8SzL0/7h8BTFlDoSm2+jQFl
	 tR+KxZyCufADL+1kdb8aCsQRj0J738d2YX8Ga7l0MDw4ap4jqvM8pLLUHIhflndTyC
	 bgD/ntXETKXbtIojLZ+LVgLoF7CsPhtiV7IKaO4zXNlHkX53imPp0Ru/AytMEYo6kq
	 3SSZWNEQJ/SAFD0MigRxnoy2B7937lt52LnGUU2FoNgebQ2kqaYsszxDVQF5EExM3s
	 ZYlC3YW9vW/pg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Aksh Garg <a-garg7@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] PCI: cadence: Remove device links to PHY
Date: Wed, 11 Nov 2026 09:04:32 -0500
Message-ID: <20261111140404.2184541-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050451-failed-7.3-cfe96ce583c5@kernel.org>
References: <20261107050451-failed-7.3-cfe96ce583c5@kernel.org>
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

From: "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>

[ Upstream commit b59e98ae3841f84d0fb21dbf80e69e6c241a29d9 ]

This is a partial revert of the device link pieces from commit
dfb80534692d ("PCI: cadence: Add generic PHY support to host and EP
drivers").

The trouble with this is that a PHY consumer driver dereferences fields
from struct phy, which will become no longer possible.

Since commit 987351e1ea77 ("phy: core: Add consumer device link support")
from 2019, the PHY core also adds a device link to order PHY provider and
consumer suspend/resume operations. The reverted functionality is from
2018 and is redundant with the PHY core now.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Aksh Garg <a-garg7@ti.com>
Link: https://patch.msgid.link/20260912161440.1032188-2-vladimir.oltean@nxp.com
Stable-dep-of: cfe96ce583c5 ("PCI: cadence: Store the core controller in platform drvdata")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../pci/controller/cadence/pcie-cadence-plat.c   |  4 ----
 drivers/pci/controller/cadence/pcie-cadence.c    | 16 +---------------
 drivers/pci/controller/cadence/pcie-cadence.h    |  2 --
 3 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index a1ea24fc3b63f..5900d68c6e83a 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -41,7 +41,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 	struct pci_host_bridge *bridge;
 	struct cdns_pcie_ep *ep;
 	struct cdns_pcie_rc *rc;
-	int phy_count;
 	bool is_rc;
 	int ret;
 
@@ -122,9 +121,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 	cdns_pcie_disable_phy(cdns_plat_pcie->pcie);
-	phy_count = cdns_plat_pcie->pcie->phy_count;
-	while (phy_count--)
-		device_link_del(cdns_plat_pcie->pcie->link[phy_count]);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index a1eada56edba7..0ac9802499414 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -222,7 +222,6 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 	struct device_node *np = dev->of_node;
 	int phy_count;
 	struct phy **phy;
-	struct device_link **link;
 	int i;
 	int ret;
 	const char *name;
@@ -238,10 +237,6 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 	if (!phy)
 		return -ENOMEM;
 
-	link = devm_kcalloc(dev, phy_count, sizeof(*link), GFP_KERNEL);
-	if (!link)
-		return -ENOMEM;
-
 	for (i = 0; i < phy_count; i++) {
 		of_property_read_string_index(np, "phy-names", i, &name);
 		phy[i] = devm_phy_get(dev, name);
@@ -249,17 +244,10 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 			ret = PTR_ERR(phy[i]);
 			goto err_phy;
 		}
-		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
-		if (!link[i]) {
-			devm_phy_put(dev, phy[i]);
-			ret = -EINVAL;
-			goto err_phy;
-		}
 	}
 
 	pcie->phy_count = phy_count;
 	pcie->phy = phy;
-	pcie->link = link;
 
 	ret =  cdns_pcie_enable_phy(pcie);
 	if (ret)
@@ -268,10 +256,8 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 	return 0;
 
 err_phy:
-	while (--i >= 0) {
-		device_link_del(link[i]);
+	while (--i >= 0)
 		devm_phy_put(dev, phy[i]);
-	}
 
 	return ret;
 }
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index b4d51adefea53..4a96e1869e535 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -260,7 +260,6 @@ struct cdns_plat_pcie_of_data {
  * @is_hpa: indicates if the architecture is HPA
  * @phy_count: number of supported PHY devices
  * @phy: list of pointers to specific PHY control blocks
- * @link: list of pointers to corresponding device link representations
  * @ops: Platform-specific ops to control various inputs from Cadence PCIe
  *       wrapper
  * @cdns_pcie_reg_offsets: Register bank offsets for different SoC
@@ -276,7 +275,6 @@ struct cdns_pcie {
 	bool				     is_hpa;
 	int			             phy_count;
 	struct phy		             **phy;
-	struct device_link	             **link;
 	const  struct cdns_pcie_ops          *ops;
 	const  struct cdns_plat_pcie_of_data *cdns_pcie_reg_offsets;
 	int				     max_link_speed;
-- 
2.53.0

