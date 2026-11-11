Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409396;
	b=ja+IpBYfovTtJsPHIw6Vw79TCvIKglV6iiTFGzMenmFJ5IwmAQ6DFK4GTWBMknMEuzm5
	 wWO6VMI4758lm2vui7FY8NacnEH959XhYWIUPAxY53dyEaudPOrrmRnsnGPvgwhcbipAr
	 4W+r7D7+SmZejwjVoCGkJU1/081S9ysnm+2j4Z97vLYG2UTgE4QkyKjazAzdI/bqOxJUK
	 +ZeYLdBqCEIWyZxNcCPBbig3io6ykMwsJJT2wAaqKG8752acLF1yyl9M+d1EbKbqi/S2Y
	 P60L5hE2CeHzeYeRNPfQ887josJC1PxUte5vlyJ8+n/pqLhwmvS8qzmXu1J0UnGo6PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409396;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=t+qmtTdiyxQtBFoTTZBCPpZZrZvOKEuPOnc8aIKKjp8=;
	b=zVO8JWR/8hpDfuN36d60CDQW1w8QOqlpR1vXmU4mL2MOc3Q55F4/ZDUTfAfHN8q3eiX6
	 EhfHSrTrF5CqabzrNUu3TjetaLL+0Gm5Q0l/ZM6SJvWyTjaKDjRmyPHitdUqVcQlYk1eA
	 dhR8KqoTo0Q7lSIcz/DZS1CialZx73yxaWk2B0S3pPZjrhrAlKfSFUV4cihG+CBXUux+t
	 5EUFxDzXosJiTpHPR0kLXwvl5mZMQUhQMR1xb46OtGOkeBU2/PIXMNin1+DfXSJw6szFX
	 /RVQ91GLQ7gyQk+QhOHjXlbpxgjsljyE40V036yZpWvTf6XBXUXMw814dk7K5Qmub2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYF5aX4e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC57606B201
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYF5aX4e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CF91F00A05;
	Wed, 11 Nov 2026 15:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794409396;
	bh=t+qmtTdiyxQtBFoTTZBCPpZZrZvOKEuPOnc8aIKKjp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UYF5aX4el3ow9zDAMB96Iec5tVjI2UhzHsSY2WeJl6AqLkxjtvlr2VcPflGsAouV4
	 4MVdM3cskdeaI88LUHyqnO+BVd52jJ1V/rRNNzhcpEVQBEIQCD61LVuTwXzpjGeLj5
	 8BQfbrUXyNPo9ISQ0tn+7guMD20lvo8cOQGS1448WXjTT+2snLqgbpeVVruQAHXzrr
	 YL7OGiksp0j74gJW1+bfMNHS9W9yw4QzHMJZTrhMWlZAq9iV8Xl18cFRDtznNLGIsy
	 +4HNeuyYDl1KeJXhcoGGlwS8Rx+B28tIMvLmdzmKaUX4LdvklBhv5Uumn0SYGir5wJ
	 MD1PD7BSNUWrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Linmao Li <lilinmao@kylinos.cn>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Aksh Garg <a-garg7@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] PCI: cadence: Store the core controller in platform drvdata
Date: Wed, 11 Nov 2026 10:03:14 -0500
Message-ID: <20261111150257.2485799-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060636-failed-5.15-cfe96ce583c5@kernel.org>
References: <20261107060636-failed-5.15-cfe96ce583c5@kernel.org>
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
[ sashal: Moved driver-data assignment before PHY initialization to preserve pointer availability when the existing probe error path returns success. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../controller/cadence/pcie-cadence-plat.c    | 36 ++++++-------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index a224afadbcc00..181b36a5d159d 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -15,17 +15,6 @@
 
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
@@ -44,10 +33,10 @@ static const struct cdns_pcie_ops cdns_plat_ops = {
 static int cdns_plat_pcie_probe(struct platform_device *pdev)
 {
 	const struct cdns_plat_pcie_of_data *data;
-	struct cdns_plat_pcie *cdns_plat_pcie;
 	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
 	struct pci_host_bridge *bridge;
+	struct cdns_pcie *pcie;
 	struct cdns_pcie_ep *ep;
 	struct cdns_pcie_rc *rc;
 	int phy_count;
@@ -62,11 +51,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
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
@@ -78,10 +62,10 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 		rc = pci_host_bridge_priv(bridge);
 		rc->pcie.dev = dev;
 		rc->pcie.ops = &cdns_plat_ops;
-		cdns_plat_pcie->pcie = &rc->pcie;
-		cdns_plat_pcie->is_rc = is_rc;
+		pcie = &rc->pcie;
+		platform_set_drvdata(pdev, pcie);
 
-		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
+		ret = cdns_pcie_init_phy(dev, pcie);
 		if (ret) {
 			dev_err(dev, "failed to init phy\n");
 			return ret;
@@ -106,10 +90,10 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 
 		ep->pcie.dev = dev;
 		ep->pcie.ops = &cdns_plat_ops;
-		cdns_plat_pcie->pcie = &ep->pcie;
-		cdns_plat_pcie->is_rc = is_rc;
+		pcie = &ep->pcie;
+		platform_set_drvdata(pdev, pcie);
 
-		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
+		ret = cdns_pcie_init_phy(dev, pcie);
 		if (ret) {
 			dev_err(dev, "failed to init phy\n");
 			return ret;
@@ -133,10 +117,10 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
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

