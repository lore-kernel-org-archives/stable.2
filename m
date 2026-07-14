Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE344EA395
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059361; cv=none; b=Yg/dqsmJYv42duvxM1Y6ePwe5hveob2C92ySwHOnGHTKPsXsuZ0xpoXCLY2a+E1+EEbTfYW0kWRREMGWplU/aXIhm640aAcELr0wwN2YX0cH8G6YcsOsOiaE5Y6xuvjlF5Yg0UKymLXWy/Y9IO/VyfCJd+j4ZYOZyoOY1TeJsW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059361; c=relaxed/simple;
	bh=xFgSuMp6Y7uCyAWXbqhvExUVLaWmAhUwKmAWjXN11vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVNnYusXcXA7GyXM0Kz6RgaV/IO3/DZ6iwVu4/eit+G0oTvITpqk/8+C48iZ3aQT11ztGHd3az0IJjs5bxZhivclgfmWpaeDgCF64zLo+V1qi6EZCR6UG69CZHLTj5nx3CIdJ+7ciqfnVyVVm9/bCfz22b78o1oWS4NPwLqsrOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojX1KEcQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojX1KEcQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927821F00A3E;
	Tue, 14 Jul 2026 20:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059348;
	bh=b4i5Qh6oHATRmjnMZ8M9s0KqtUMvPADi6HHmLlNXaZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ojX1KEcQSvQOrAmXPEO0TR7wkHL0eCJXkxgrn7At6BVWqTelKZpV5ZcYRBsWAxKwT
	 +TH6PyRx5hWd5yFlcEgdbrdzekwA9x8CzpA6aMFKxObAiVocmdephEgG0P3WyvhCID
	 EQIfNixcxsfmXtOWuAeLwunt+pR6p/7YAS2eFR6vu3MkDeh5FjFn44XldtTozrOlHQ
	 jcTyxb722iOGjXibImwuc1GKhNj5Mp/yDOf+s1JK2ILJrfnmodxkSaMdVsX8Ha00Hc
	 JPir4ISyf7cxVXt0xybaUg2Zf+CCLjQb+CglOSTHfMVmeeZtnegbmwuokNXBNZhGkT
	 dHyuVqLX/lGqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/5] PCI: controller: Use dev_fwnode() instead of of_fwnode_handle()
Date: Tue, 14 Jul 2026 16:02:22 -0400
Message-ID: <20260714200226.3152882-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071353-appointee-tactful-9ca3@gregkh>
References: <2026071353-appointee-tactful-9ca3@gregkh>
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
 drivers/pci/controller/pcie-xilinx-dma-pl.c          | 2 +-
 drivers/pci/controller/pcie-xilinx-nwl.c             | 2 +-
 drivers/pci/controller/plda/pcie-plda-host.c         | 2 +-
 9 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index deda5b040d7a0e..79c9bb64abd4bb 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -227,7 +227,7 @@ static const struct irq_domain_ops dw_pcie_msi_domain_ops = {
 int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);
+	struct fwnode_handle *fwnode = dev_fwnode(pci->dev);
 
 	pp->irq_domain = irq_domain_create_linear(fwnode, pp->num_vectors,
 					       &dw_pcie_msi_domain_ops, pp);
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index 0e088e74155d3b..910b589cb09636 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -435,7 +435,7 @@ static const struct irq_domain_ops msi_domain_ops = {
 static int mobiveil_allocate_msi_domains(struct mobiveil_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
-	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct mobiveil_msi *msi = &pcie->rp.msi;
 
 	mutex_init(&msi->lock);
@@ -461,13 +461,11 @@ static int mobiveil_allocate_msi_domains(struct mobiveil_pcie *pcie)
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
index e36a6e158d23c1..ae5a7e70882168 100644
--- a/drivers/pci/controller/pcie-altera-msi.c
+++ b/drivers/pci/controller/pcie-altera-msi.c
@@ -164,7 +164,7 @@ static const struct irq_domain_ops msi_domain_ops = {
 
 static int altera_allocate_domains(struct altera_msi *msi)
 {
-	struct fwnode_handle *fwnode = of_node_to_fwnode(msi->pdev->dev.of_node);
+	struct fwnode_handle *fwnode = dev_fwnode(&msi->pdev->dev);
 
 	msi->inner_domain = irq_domain_add_linear(NULL, msi->num_of_vectors,
 					     &msi_domain_ops, msi);
diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 650b2dd81c4822..fac9d27342cf8a 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -666,10 +666,9 @@ static void altera_pcie_isr(struct irq_desc *desc)
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
index b373ece9542c4e..86da2046533a4c 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -695,8 +695,8 @@ static int mtk_pcie_init_irq_domains(struct mtk_gen3_pcie *pcie)
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
index c4cc9d76b42a09..37495b8cabd234 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -485,7 +485,7 @@ static struct msi_domain_info mtk_msi_domain_info = {
 
 static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
 {
-	struct fwnode_handle *fwnode = of_node_to_fwnode(port->pcie->dev->of_node);
+	struct fwnode_handle *fwnode = dev_fwnode(port->pcie->dev);
 
 	mutex_init(&port->lock);
 
diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
index dd117f07fc95b6..116c6e0e71457d 100644
--- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
+++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
@@ -470,7 +470,7 @@ static int xilinx_pl_dma_pcie_init_msi_irq_domain(struct pl_dma_pcie *port)
 	struct device *dev = port->dev;
 	struct xilinx_msi *msi = &port->msi;
 	int size = BITS_TO_LONGS(XILINX_NUM_MSI_IRQS) * sizeof(long);
-	struct fwnode_handle *fwnode = of_node_to_fwnode(port->dev->of_node);
+	struct fwnode_handle *fwnode = dev_fwnode(port->dev);
 
 	msi->dev_domain = irq_domain_add_linear(NULL, XILINX_NUM_MSI_IRQS,
 						&dev_msi_domain_ops, port);
diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 2e7356c28b5e40..4f01602ad9f1ab 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -495,7 +495,7 @@ static int nwl_pcie_init_msi_irq_domain(struct nwl_pcie *pcie)
 {
 #ifdef CONFIG_PCI_MSI
 	struct device *dev = pcie->dev;
-	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct nwl_msi *msi = &pcie->msi;
 
 	msi->dev_domain = irq_domain_add_linear(NULL, INT_PCI_MSI_NR,
diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index 4153214ca41038..d2bdc774f0c359 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -150,7 +150,7 @@ static struct msi_domain_info plda_msi_domain_info = {
 static int plda_allocate_msi_domains(struct plda_pcie_rp *port)
 {
 	struct device *dev = port->dev;
-	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct plda_msi *msi = &port->msi;
 
 	mutex_init(&port->msi.lock);
-- 
2.53.0

