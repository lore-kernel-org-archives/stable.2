Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406926;
	b=zyltGCd862prb2lDUAld11SFpC3yjgU30PvE8ibZ56LykJGsZmli6lD7yzzSDJEdarT8
	 0AVXw/QwTgtRIGc+HWJyVHMlTxp5QREM3EKDs6x+GQxJbIVxCvQHdRJHvnA1ekcTqJu9C
	 3cTSld2fe40rYFXCtw0ZNj01ZLmADOzqsVjB9kbMmYn8Dh0VeTicgQSYMotRBzvMQCIEt
	 iWSKZCJT0nRaIoO9sHsc4CBAyxeOe4b691RYyovgTWZTMK0OWAgf/48lTm/z5fG+WyGpF
	 p1/Lj4OMEfHNcDxmv1n0UpY3tmJEgavHUlunsvrvH16xxZCZnroP9tumNl/AybSSzDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406926;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XZeUCFLVt556rsgDShpPgGAGUfMYGGncMw138KlVoSw=;
	b=W2nGh0o7xY1OxfmV9/eAgumTWVhEMVpRbuB+f+XCc9DieRvEBXgOoIBd5Fb534aY9waD
	 E6k0j5ngdPYFYLRm9Kygitbmf2qJdHl9h9vrfWFKj3GgjnvOCe1YMyHFTWo7WLYL9i6Zs
	 VZz6SwBoC4b8c/4oneXR/wg9nzFWwxOdQKqLc7YXl7O9KsTcLY4pc7OLis9ocpmd9k23E
	 EWIRhcIwGXja/ZkcSrlsSgR230vUSZ4+N/4+dhzjHQ3sCmR5QFshpM6SxnNLFgUsWPCUw
	 dAnyMyFmkGJJuOjwCKTBxw+fH9DKUtrKfXwXM+wS0yecEJZK32TKpJNFEzF7B1oilHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pb2f5qUC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77842606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pb2f5qUC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71ED71F00A07;
	Wed, 11 Nov 2026 14:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794406926;
	bh=XZeUCFLVt556rsgDShpPgGAGUfMYGGncMw138KlVoSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pb2f5qUC+nOhbfRfHAFebIizXcj5693SuJlZCn9prc4jHudxZLhCJVyewDV8UUnMz
	 RTuSLELuqB+mkk6JCagKqLlyAQHZPck3hnQ4pttCjlifJvxTC1Z/HOKfV64A7rOU6i
	 KjhFCm9FTW0fyT9UbrJJloGhJfPDmPiyYSEOsRtzW9sRPtb4VXK4Y2Gg52pQsRvCku
	 J88pTeM/byZ8OUBYXDHrdocgJsJCZrJHkG+yOuhcx5qgJ7gRWQkc8UM4iFVqod8KnB
	 Ft3R/lu2HQ8vVI+NUTFA7tNYNfDuG3CSJwxZzejs8YkGwPz1vUKRNDIo/jLy/wHWbl
	 v1+/PKYYkMpFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Linmao Li <lilinmao@kylinos.cn>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Aksh Garg <a-garg7@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] PCI: cadence: Store the core controller in platform drvdata
Date: Wed, 11 Nov 2026 09:22:03 -0500
Message-ID: <20261111142124.2292367-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051138-failed-6.18-cfe96ce583c5@kernel.org>
References: <20261107051138-failed-6.18-cfe96ce583c5@kernel.org>
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
[ sashal: adapted the retained PHY-link cleanup loop to use pcie directly instead of the removed wrapper ]
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

