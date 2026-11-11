Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408222;
	b=KjmsYuKUF58iCIidWUeluCC4sN3BZ2FDo8sJjtBgPA7afzV/Nn3SxHJKMm0eIz4gTbWG
	 LTVniCBVp7KyMSYwY9R+CLPN2Ik94c3rNo6mUm7ZHXnuflIsAC9uqKEICy7xqkfwU0lB7
	 0KD9xPREP223ryeIFSKecLjAcDz3d3Gl8Y5NIRmw35q5+C+H9SvDIvA8QpD8/jj2GoTU6
	 uAbIZrHqQ6AxVUIiyvGQ62ddnggARJj3s5gKWe9IRlhCqBPUK2E/3ImAFf83ac/yBd/oR
	 nftlskp/jtKCcfeVD9DFSuIH/QTCZnArjGLjtTTgE7M9jyHuBvyvlRgqfV7dQhf93vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408222;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=H0BLqPOV/ISEaLPKSj+VfTDQ/slE8BKRhpoVqiHrFOQ=;
	b=cmSvXr+oBPOjiMR/oGuSHu63AxC3nZ0kMyx/rgwZJhMD75J6Kony8d1OV1Dlqt2jcO8J
	 oON/ff8Nyb6obWOQCj26+PcMGQUxGxSXfPMYHhlR4XqyPgU/bq6za2U4fzcUNkizYG2C6
	 i9y/YW0ec6064d6XjPRFUWNIIL0QqYcuOvtyj+yqpmDrvx3/cNi03zyQjIlrZbEo6r3KW
	 nl5Nn1tMFh8VJhTFjwQz3YqI4rDxcsWtFPaDXBFMPFnCI3yqHz/aBK510n5I/uK4BEAdi
	 RtS7GAIHcbHRb5f9yNEqgO7YahlgckI8Afsl3BwfxYbEaH6URSx17aNmQoYqsGbPDkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PK9DZ7G6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05987606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PK9DZ7G6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B811F00A05;
	Wed, 11 Nov 2026 14:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794408221;
	bh=H0BLqPOV/ISEaLPKSj+VfTDQ/slE8BKRhpoVqiHrFOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PK9DZ7G6GfbWCNeefuW5ovH8/XqhjYZmjZWS/hZ7ou5MvDW81qZiqtzGS5vkncFw8
	 dz8byweebadVeASppiHV4wmStyb7+iqkF1lWinLt37JzR+JnArNLzWhmQiBYSEuvNQ
	 1nJMDNJWtM+CRGx4DGvp8143KhYaS569bBhfCKT4cIt8oaw5dEW2CWxCq0w9cMAfV9
	 TqPWinr1UkT1eCFQhJTen3FrUXdE0GVJ4cQNo8Mz9g+UEyf32XxXPDioKE+j5E3kfT
	 qHmw9eRXL+BH9e9AU7qnXzUutOEiOunBwoiWfMlqdp9GDZz+8/zRURnKK9rmvq04nR
	 4P5Sj1AmjxGgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Linmao Li <lilinmao@kylinos.cn>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Aksh Garg <a-garg7@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] PCI: cadence: Store the core controller in platform drvdata
Date: Wed, 11 Nov 2026 09:43:39 -0500
Message-ID: <20261111144236.2384264-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053523-failed-6.6-cfe96ce583c5@kernel.org>
References: <20261107053523-failed-6.6-cfe96ce583c5@kernel.org>
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
[ sashal: Retained the existing PHY-link cleanup loop using the core controller pointer directly. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../controller/cadence/pcie-cadence-plat.c    | 36 ++++++-------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index 371ffc1f00f86..528038f926c13 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -14,17 +14,6 @@
 
 #define CDNS_PLAT_CPU_TO_BUS_ADDR	0x0FFFFFFF
 
-/**
- * struct cdns_plat_pcie - private data for this PCIe platform driver
- * @pcie: Cadence PCIe controller
- * @is_rc: Set to 1 indicates the PCIe controller mode is Root Complex,
- *         if 0 it is in Endpoint mode.
- */
-struct cdns_plat_pcie {
-	struct cdns_pcie        *pcie;
-	bool is_rc;
-};
-
 struct cdns_plat_pcie_of_data {
 	bool is_rc;
 };
@@ -43,9 +32,9 @@ static const struct cdns_pcie_ops cdns_plat_ops = {
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
@@ -59,11 +48,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
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
@@ -75,10 +59,9 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 		rc = pci_host_bridge_priv(bridge);
 		rc->pcie.dev = dev;
 		rc->pcie.ops = &cdns_plat_ops;
-		cdns_plat_pcie->pcie = &rc->pcie;
-		cdns_plat_pcie->is_rc = is_rc;
+		pcie = &rc->pcie;
 
-		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
+		ret = cdns_pcie_init_phy(dev, pcie);
 		if (ret) {
 			dev_err(dev, "failed to init phy\n");
 			return ret;
@@ -103,10 +86,9 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 
 		ep->pcie.dev = dev;
 		ep->pcie.ops = &cdns_plat_ops;
-		cdns_plat_pcie->pcie = &ep->pcie;
-		cdns_plat_pcie->is_rc = is_rc;
+		pcie = &ep->pcie;
 
-		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
+		ret = cdns_pcie_init_phy(dev, pcie);
 		if (ret) {
 			dev_err(dev, "failed to init phy\n");
 			return ret;
@@ -124,16 +106,18 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
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
 
 	return 0;
 }
-- 
2.53.0

