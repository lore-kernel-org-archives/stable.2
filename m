Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D6026D4DD
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066657; cv=none; b=GsKhdJ5ieNOan8mfPMOQkgKNwTn8aSXIkRmFDZQj3dLQELQc8MwQ5nEEKI0wdoYrF5SI8gLEkra7JEaOgiBocRCdkfmQxv6uHCbS1GFuy38Q9mTTglVE5dDhonnoOlayHxAjZ7fqkno8ufZ84qdK9VF4hMsbODnHD4UdoW10+HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066657; c=relaxed/simple;
	bh=OS0ag4j7C9JvHfwmEnACSlK649h+wyCfVeqxRfwcyIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYGFsG6VwCwOb7JgqqbHjotmUEew7x7v77kL9FpzGCyLW/DlzgyBVr8FnBXOsVqjuFR/58I4yqRPhTOMCHEj+Bw5l4xb8/SO0qHnbHDReoG2ij/+1qbLut2x1VkwedMJDWcZPI4Tw7UXpawVIuFOErDAijJslCKzwtx4OBGMfpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkomFVIb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkomFVIb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F431F000E9;
	Tue, 14 Jul 2026 22:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784066656;
	bh=97Z42/pLFNCiuUbM9ZCVtRUPMgMF425kimaA3QuDwy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QkomFVIbZgZ2I1l60q2csfBZoqhFwfZXs5y/ag2VmaD3OfoOPrHMdazscvQHWkRWm
	 off0nVidFl6zB9wjL0oEjWJw3o18g+Xswiw+9tziiWUvYk1oWP7oGaaPGRhaZBqeff
	 3jenVjoGwthjkdBFGkDYB7zYcG1xsSzjKCZGfMcmmXuXKBx4d9EWYb9zGui84UwHRo
	 Bdap+M4ZjPRBu+cnapwZ22T0u0FFoceXRINzvkE3ZCSsu2b5Sy5RdMQy4gotEp3SeW
	 vav7cFSlcTRUcaMqlYv/ns/HvQs7evqT0e3zf3VVISzKw9AeRfZZSqkMRTeHyQbf4l
	 RPQloO6VU2uWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] PCI: controller: Use dev_fwnode() instead of of_fwnode_handle()
Date: Tue, 14 Jul 2026 18:04:11 -0400
Message-ID: <20260714220414.3333873-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071354-duvet-skimming-764e@gregkh>
References: <2026071354-duvet-skimming-764e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>

[ Upstream commit a103d2dede5683dabbac2c3374bc24b6a9434478 ]

All irq_domain functions now accept fwnode instead of of_node. But many
PCI controllers still extract dev to of_node and then of_node to fwnode.

Instead, clean this up and simply use the dev_fwnode() helper to extract
fwnode directly from dev. Internally, it still does dev => of_node =>
fwnode steps, but it's now hidden from the users.

In the case of altera, this also removes an unused 'node' variable that is
only used when CONFIG_OF is enabled:

  drivers/pci/controller/pcie-altera.c: In function 'altera_pcie_init_irq_domain':
  drivers/pci/controller/pcie-altera.c:855:29: error: unused variable 'node' [-Werror=unused-variable]
    855 |         struct device_node *node = dev->of_node;

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>	# altera
[bhelgaas: squash together, rebase to precede msi-parent]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20250521163329.2137973-1-arnd@kernel.org
Link: https://patch.msgid.link/20250611104348.192092-16-jirislaby@kernel.org
Link: https://patch.msgid.link/20250723065907.1841758-1-jirislaby@kernel.org
Stable-dep-of: f865a57896bd ("PCI: mediatek: Fix IRQ domain leak when port fails to enable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c    | 2 +-
 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 8 +++-----
 drivers/pci/controller/pcie-altera-msi.c             | 2 +-
 drivers/pci/controller/pcie-altera.c                 | 3 +--
 drivers/pci/controller/pcie-mediatek-gen3.c          | 4 ++--
 drivers/pci/controller/pcie-mediatek.c               | 2 +-
 drivers/pci/controller/pcie-xilinx-nwl.c             | 2 +-
 7 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index a7170fd0e847ad..84ed77a44d6dd0 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -233,7 +233,7 @@ static const struct irq_domain_ops dw_pcie_msi_domain_ops = {
 int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);
+	struct fwnode_handle *fwnode = dev_fwnode(pci->dev);
 
 	pp->irq_domain = irq_domain_create_linear(fwnode, pp->num_vectors,
 					       &dw_pcie_msi_domain_ops, pp);
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index 45b97a4b14dbd0..ac0881659e7643 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -442,7 +442,7 @@ static const struct irq_domain_ops msi_domain_ops = {
 static int mobiveil_allocate_msi_domains(struct mobiveil_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
-	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct mobiveil_msi *msi = &pcie->rp.msi;
 
 	mutex_init(&msi->lock);
@@ -468,13 +468,11 @@ static int mobiveil_allocate_msi_domains(struct mobiveil_pcie *pcie)
 static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
-	struct device_node *node = dev->of_node;
 	struct mobiveil_root_port *rp = &pcie->rp;
 
 	/* setup INTx */
-	rp->intx_domain = irq_domain_add_linear(node, PCI_NUM_INTX,
-						&intx_domain_ops, pcie);
-
+	rp->intx_domain = irq_domain_create_linear(dev_fwnode(dev), PCI_NUM_INTX, &intx_domain_ops,
+						   pcie);
 	if (!rp->intx_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
 		return -ENOMEM;
diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
index 6ad5427490b524..7f2115f35e997c 100644
--- a/drivers/pci/controller/pcie-altera-msi.c
+++ b/drivers/pci/controller/pcie-altera-msi.c
@@ -171,7 +171,7 @@ static const struct irq_domain_ops msi_domain_ops = {
 
 static int altera_allocate_domains(struct altera_msi *msi)
 {
-	struct fwnode_handle *fwnode = of_node_to_fwnode(msi->pdev->dev.of_node);
+	struct fwnode_handle *fwnode = dev_fwnode(&msi->pdev->dev);
 
 	msi->inner_domain = irq_domain_add_linear(NULL, msi->num_of_vectors,
 					     &msi_domain_ops, msi);
diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index a9536dc4bf96bc..a90486e1084e26 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -667,10 +667,9 @@ static void altera_pcie_isr(struct irq_desc *desc)
 static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
-	struct device_node *node = dev->of_node;
 
 	/* Setup INTx */
-	pcie->irq_domain = irq_domain_add_linear(node, PCI_NUM_INTX,
+	pcie->irq_domain = irq_domain_create_linear(dev_fwnode(dev), PCI_NUM_INTX,
 					&intx_domain_ops, pcie);
 	if (!pcie->irq_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 822d9b8e09f60d..e0733a7219256b 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -661,8 +661,8 @@ static int mtk_pcie_init_irq_domains(struct mtk_gen3_pcie *pcie)
 	/* Setup MSI */
 	mutex_init(&pcie->lock);
 
-	pcie->msi_bottom_domain = irq_domain_add_linear(node, PCIE_MSI_IRQS_NUM,
-				  &mtk_msi_bottom_domain_ops, pcie);
+	pcie->msi_bottom_domain = irq_domain_create_linear(dev_fwnode(dev), PCIE_MSI_IRQS_NUM,
+							   &mtk_msi_bottom_domain_ops, pcie);
 	if (!pcie->msi_bottom_domain) {
 		dev_err(dev, "failed to create MSI bottom domain\n");
 		ret = -ENODEV;
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 82e575e4d3877a..bff186c8270e52 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -493,7 +493,7 @@ static struct msi_domain_info mtk_msi_domain_info = {
 
 static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
 {
-	struct fwnode_handle *fwnode = of_node_to_fwnode(port->pcie->dev->of_node);
+	struct fwnode_handle *fwnode = dev_fwnode(port->pcie->dev);
 
 	mutex_init(&port->lock);
 
diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 5b82098f32b7c7..61bbd169bcb270 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -502,7 +502,7 @@ static int nwl_pcie_init_msi_irq_domain(struct nwl_pcie *pcie)
 {
 #ifdef CONFIG_PCI_MSI
 	struct device *dev = pcie->dev;
-	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct nwl_msi *msi = &pcie->msi;
 
 	msi->dev_domain = irq_domain_add_linear(NULL, INT_PCI_MSI_NR,
-- 
2.53.0

