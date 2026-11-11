Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405877;
	b=UkWfdkyyY4c1OffSaDOvz1o+n1OopPDEDugpyyEdUsYb0m1kVdHCOCOQrjNNWCbL7BB6
	 6cfWrpqaF3lZHbizdaYmiAclGyswEzycaOfOxs5mpdLTqscchMxgb03SQ7cTPT3r7jPIY
	 4j90624fGYgBbAhGsVzv/k3A0kVhAVsZUBYrulMfQ4Lqx706dMayaZsLidMtI3TsnAu0S
	 ulOV8Wl+6T2ro5GO8brblDeoHoChMtm1trAxICRG+kirgBpDcDmwkkxoSGmpXivK/tKoy
	 Pr+z/G9oKsU7egbCNIuzCsHVm2MPXeJKKCZIN1zNQPBnp+9cMuLr4Aevha3gqQm2AZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405877;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LOZQ4fQdFUcv/PlfQjG/zUDCnb/okhW5hs+VuRsHR6s=;
	b=3g8l2PF9Ywck8+th7kX6wTXRS0A1IC3iV1k8gzZ3ucYiiJNsb+KgS2yIoZoF3YSmxBVw
	 QkZAnDsWEpvBXNiobOHvjE+tt2weTYBrq6eZKoxe0/rAwTUJn3TMK6vLgCwDB+TCWE1kZ
	 0iGHP7KVaSHVGnhejJ8TMeIpAc0Gw/VfPxtKlo75m25Gns1V30M+9VD6nKv279LU7uGtO
	 iIynRF/v88ISPnunLgDGKYfCLsGdLfHLKJuyVqRVAVKEoqxWDdUQ6YDUhyRBb24/dmkGm
	 //ShHGBHgyedClvrdSrl+DLNqhTE/p2eqtClZ+V/g+cLymO691ApX+ZLUjcSOrPr9fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dAs+0zG3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2E7606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dAs+0zG3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554AE1F00A06;
	Wed, 11 Nov 2026 14:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405877;
	bh=LOZQ4fQdFUcv/PlfQjG/zUDCnb/okhW5hs+VuRsHR6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dAs+0zG3PYX+FKZLLD5TzFZkgYqlA58uR7Veqm0X1CmjhniPVnKMe3gebSpzlJ5sq
	 OSZ5EP5sxAIA0we6JOaQ8L9zcMnxFahBXmuT6vsuJ9LA5qO1jgiXS/UuwnBCBbwZ1X
	 udhp9OMf4wolEfvNK6ES+BBRV/1/JsfETq3Tgn6e7CBhVDo63PEFBif4NyKsmP5Ut/
	 aAfkIvNdhDU05N5dRqizs1cGJnaTaSY6rXssK1/pyT5CtnPd5u0RHHR24tT359MVm2
	 MTqlUmYw7mld1Nw4aEwy241cYECJQZ8UNa4aq+yQ3XL/aX6tc4xyB7En7OVspyJfS+
	 izSey5WHfv9WA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Linmao Li <lilinmao@kylinos.cn>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Aksh Garg <a-garg7@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] PCI: cadence: Store the core controller in platform drvdata
Date: Wed, 11 Nov 2026 09:04:33 -0500
Message-ID: <20261111140404.2184541-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111140404.2184541-1-sashal@kernel.org>
References: <20261107050451-failed-7.3-cfe96ce583c5@kernel.org>
 <20261111140404.2184541-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../controller/cadence/pcie-cadence-plat.c    | 27 ++++++-------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index 5900d68c6e83a..abda260543c8b 100644
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
 static const struct of_device_id cdns_plat_pcie_of_match[];
 
 static u64 cdns_plat_cpu_addr_fixup(struct cdns_pcie *pcie, u64 cpu_addr)
@@ -36,9 +28,9 @@ static const struct cdns_pcie_ops cdns_plat_ops = {
 static int cdns_plat_pcie_probe(struct platform_device *pdev)
 {
 	const struct cdns_plat_pcie_of_data *data;
-	struct cdns_plat_pcie *cdns_plat_pcie;
 	struct device *dev = &pdev->dev;
 	struct pci_host_bridge *bridge;
+	struct cdns_pcie *pcie;
 	struct cdns_pcie_ep *ep;
 	struct cdns_pcie_rc *rc;
 	bool is_rc;
@@ -51,11 +43,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
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
@@ -67,9 +54,9 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
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
@@ -94,9 +81,9 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 
 		ep->pcie.dev = dev;
 		ep->pcie.ops = &cdns_plat_ops;
-		cdns_plat_pcie->pcie = &ep->pcie;
+		pcie = &ep->pcie;
 
-		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
+		ret = cdns_pcie_init_phy(dev, pcie);
 		if (ret) {
 			dev_err(dev, "failed to init phy\n");
 			return ret;
@@ -114,13 +101,15 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
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
+	cdns_pcie_disable_phy(pcie);
 
 	return 0;
 }
-- 
2.53.0

