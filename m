Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407315;
	b=O7koY0COX3AmTlJBNEi379w5bCYGseX97jwixz0SbufOU/RRNvSetjjpeWnktW4EsBM0
	 /hg37DrKDdmmiUSHTpNDBGWjN1EhiFPEoC2YAOSFtmt9DPXShwBjN8q9QmEsxAe02YZcm
	 XwHjyab0ToQ6nJ9hsJpI2iP0QZdrsRGsvV8qk1Vrw7dxplCVmIGkTb5rOsj3KdwZFoF67
	 wx85uaU6QqXgnlLpJm+gO2mKUEpvi6gxKsN/Zs3exGcsEZTu9Cew3mpE/u/7b44E7Turo
	 7UQvpAt2XN0glKLcgG9pQ/sLwSCt4Pyvkebr1WoV244s3kWjC1Jz4bgd67yspG2aG2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407315;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HsiZBOPfv0VyvXuJqbg+xI6yQZLQgrx7s1DCfaSLVq0=;
	b=VJNGcYURyPdDMXtS0pfkASRBrc2PAD6bIUOSgSjHUEQJx7ufyBQjYoNTEeihJ8k3ShG3
	 QHgeAgNQDtwLmuQb8VCjiQjLCn4fEW+Xw+1MEaN6H8xKW7FYY4EsRYfptDJDW8bHlECwT
	 hoeFMzouF4dgDw0hqgdYWYTI8AJmrsF94EIj4SU4Irnn1OiRDQNbkb2KmYwS0Gc/VnLMo
	 DeaPf28SajAUw2/EVTtuw5JWQ2QAdeQwf4cFVl1W+eNrHAzLFB9zLLNN8Jp/HcZzVlArG
	 avD+PULuKEEKmejWIviIJ1UzFEcwVlZ5VK5ZThBSEBMx6oIFHGJaTqJKY2LXBjproOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g3E71j74;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021A7606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g3E71j74
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352971F00A05;
	Wed, 11 Nov 2026 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794407314;
	bh=HsiZBOPfv0VyvXuJqbg+xI6yQZLQgrx7s1DCfaSLVq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g3E71j74Or2X+Em2kjz7efVj0z6jvbdrLx4tzsajJ7Hovu06NA80WtSyuX0F3McdO
	 3bc/mfbGdDB9JUvwJzUbITFN380tFES5FV+cLyjk5izHcPAWrDThefE7zFI2YvcYjy
	 M538itWG27gUn0fZwbPIvSCspz/N6yXcjj6yf8EW+P6NQ+7fBTh7o1a3VWxNX93tiY
	 FSmRZHy5j/I/+5hHTl7lfsgtsJlTtvFXSRAqG8zbx+7DT16s68gKBcWPfEDi/ZHNMH
	 NN/jO+ArpbJN8uR0UszNjxb9kVBeRI1Uy2LGIW7Y8Q2Owk586A86YHDUCDFQyIXO9h
	 2FIUo7drJe7oQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Linmao Li <lilinmao@kylinos.cn>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Aksh Garg <a-garg7@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] PCI: cadence: Store the core controller in platform drvdata
Date: Wed, 11 Nov 2026 09:28:32 -0500
Message-ID: <20261111142805.2347807-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052250-failed-6.12-cfe96ce583c5@kernel.org>
References: <20261107052250-failed-6.12-cfe96ce583c5@kernel.org>
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

From: Linmao Li <lilinmao@kylinos.cn>

[ Upstream commit cfe96ce583c51bf6e034d4038c652a1e8227867c ]

cdns_plat_pcie_probe() stores a struct cdns_plat_pcie pointer with
platform_set_drvdata(). cdns_plat_pcie_shutdown() and the callbacks in
cdns_pcie_pm_ops retrieve the same pointer with dev_get_drvdata() but use
it as a struct cdns_pcie pointer. This makes them read phy_count and phy
beyond the wrapper.

struct cdns_plat_pcie only contains a pointer to struct cdns_pcie. Drop
the redundant wrapper and store the struct cdns_pcie pointer directly.

Fixes: bd22885aa188 ("PCI: cadence: Refactor driver to use as a core library")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Aksh Garg <a-garg7@ti.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260915082826.4135665-1-lilinmao@kylinos.cn
[ sashal: adapted probe error cleanup to access PHY device links through pcie ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../controller/cadence/pcie-cadence-plat.c    | 33 +++++++------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index 0456845dabb96..c1ec619ab0a4e 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -14,14 +14,6 @@
 
 #define CDNS_PLAT_CPU_TO_BUS_ADDR	0x0FFFFFFF
 
-/**
- * struct cdns_plat_pcie - private data for this PCIe platform driver
- * @pcie: Cadence PCIe controller
- */
-struct cdns_plat_pcie {
-	struct cdns_pcie        *pcie;
-};
-
 struct cdns_plat_pcie_of_data {
 	bool is_rc;
 };
@@ -40,9 +32,9 @@ static const struct cdns_pcie_ops cdns_plat_ops = {
 static int cdns_plat_pcie_probe(struct platform_device *pdev)
 {
 	const struct cdns_plat_pcie_of_data *data;
-	struct cdns_plat_pcie *cdns_plat_pcie;
 	struct device *dev = &pdev->dev;
 	struct pci_host_bridge *bridge;
+	struct cdns_pcie *pcie;
 	struct cdns_pcie_ep *ep;
 	struct cdns_pcie_rc *rc;
 	int phy_count;
@@ -56,11 +48,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 	is_rc = data->is_rc;
 
 	pr_debug(" Started %s with is_rc: %d\n", __func__, is_rc);
-	cdns_plat_pcie = devm_kzalloc(dev, sizeof(*cdns_plat_pcie), GFP_KERNEL);
-	if (!cdns_plat_pcie)
-		return -ENOMEM;
-
-	platform_set_drvdata(pdev, cdns_plat_pcie);
 	if (is_rc) {
 		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_PLAT_HOST))
 			return -ENODEV;
@@ -72,9 +59,9 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 		rc = pci_host_bridge_priv(bridge);
 		rc->pcie.dev = dev;
 		rc->pcie.ops = &cdns_plat_ops;
-		cdns_plat_pcie->pcie = &rc->pcie;
+		pcie = &rc->pcie;
 
-		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
+		ret = cdns_pcie_init_phy(dev, pcie);
 		if (ret) {
 			dev_err(dev, "failed to init phy\n");
 			return ret;
@@ -99,9 +86,9 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 
 		ep->pcie.dev = dev;
 		ep->pcie.ops = &cdns_plat_ops;
-		cdns_plat_pcie->pcie = &ep->pcie;
+		pcie = &ep->pcie;
 
-		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
+		ret = cdns_pcie_init_phy(dev, pcie);
 		if (ret) {
 			dev_err(dev, "failed to init phy\n");
 			return ret;
@@ -119,18 +106,20 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 			goto err_init;
 	}
 
+	platform_set_drvdata(pdev, pcie);
+
 	return 0;
 
  err_init:
  err_get_sync:
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
-	cdns_pcie_disable_phy(cdns_plat_pcie->pcie);
-	phy_count = cdns_plat_pcie->pcie->phy_count;
+	cdns_pcie_disable_phy(pcie);
+	phy_count = pcie->phy_count;
 	while (phy_count--)
-		device_link_del(cdns_plat_pcie->pcie->link[phy_count]);
+		device_link_del(pcie->link[phy_count]);
 
-	return 0;
+	return ret;
 }
 
 static void cdns_plat_pcie_shutdown(struct platform_device *pdev)
-- 
2.53.0

