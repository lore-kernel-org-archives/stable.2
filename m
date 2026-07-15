Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39537379C5A
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 01:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784078579; cv=none; b=TcwPGbsICUNo3r3vp50dRdoIgI4K55H8ahiy//aetQ48gmw9nuaXkXZFc2iBpiQfl67bq7HQftNWlmo4oAD6bAeI2KyYz6St9NzVjC0KieJ+WbxVChveasjgrfw1ZI8Ptag61t+SNNqTs86RLUIIPoLud7aRXcFbwhU3m0ZOKJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784078579; c=relaxed/simple;
	bh=coaMwINbLGmrucgwgwJlmdJH78FUX2BceVnxkbtdPQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPrhhVrEiL8bEG7jTQ+9ZA47LmcdybV2RIOFjCXlrWq4BWROjJzbS1iHUYwHEiu/SJ4Xkz1XmTbUbmgGGBEw7Zfu1UW6QrkB7doCUntXKlgRiur8p1VkaQCOCDGITTmbAi5x2CV+JuSGYPm3rD0q2qd1FUkxVvXvOQlNoH8P3SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeArWA75; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeArWA75"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474B71F000E9;
	Wed, 15 Jul 2026 01:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784078577;
	bh=Z/ySNf9g/aFD7PQApPSMfRv67nD7tF6sKdw/IxhwqA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jeArWA75jV26xMGy5riN+Q1BUBhnC2x/4A/T/MeNexDeAXZUIXTbtXZPqwyIgSu24
	 hNeQAPvZWb8Zjlt7bJ8hzdPbBTxDkuH0WbFVyqfRMveZDL9JN0fDhpzjlL/VSm+huq
	 ATLTMZuWKwFYoB0utUf/wMmpIxTOn67EZFCyFyv62ge8hbgbmAfSsSXVUoNKpVzzp+
	 sgSZ5kSdqJA3TvPxB0ZlfbnAfTPYUsbu5VagSCuevkwobJfL1HVVXdzSa6LhvLb8tA
	 GnNOlBd+lkZ6lA6JqviZkIdlIFbS80exIffGVvyU2UPWDUHN6gejgQ7Zp6F8MzR8j2
	 R083VUuz4dcfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] PCI: controller: Use dev_fwnode() instead of of_fwnode_handle()
Date: Tue, 14 Jul 2026 21:22:53 -0400
Message-ID: <20260715012255.4073217-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071332-nectar-acre-e146@gregkh>
References: <2026071332-nectar-acre-e146@gregkh>
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
 drivers/pci/controller/pcie-mediatek.c               | 2 +-
 drivers/pci/controller/pcie-xilinx-nwl.c             | 2 +-
 6 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 42d8116a4a0021..f38c248da44984 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -233,7 +233,7 @@ static const struct irq_domain_ops dw_pcie_msi_domain_ops = {
 int dw_pcie_allocate_domains(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);
+	struct fwnode_handle *fwnode = dev_fwnode(pci->dev);
 
 	pp->irq_domain = irq_domain_create_linear(fwnode, pp->num_vectors,
 					       &dw_pcie_msi_domain_ops, pp);
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index a2632d02ce8f8c..613dc2bad1e146 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -452,7 +452,7 @@ static const struct irq_domain_ops msi_domain_ops = {
 static int mobiveil_allocate_msi_domains(struct mobiveil_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
-	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct mobiveil_msi *msi = &pcie->rp.msi;
 
 	mutex_init(&msi->lock);
@@ -478,13 +478,11 @@ static int mobiveil_allocate_msi_domains(struct mobiveil_pcie *pcie)
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
index e1636f7714ca70..6da6b14181d978 100644
--- a/drivers/pci/controller/pcie-altera-msi.c
+++ b/drivers/pci/controller/pcie-altera-msi.c
@@ -173,7 +173,7 @@ static const struct irq_domain_ops msi_domain_ops = {
 
 static int altera_allocate_domains(struct altera_msi *msi)
 {
-	struct fwnode_handle *fwnode = of_node_to_fwnode(msi->pdev->dev.of_node);
+	struct fwnode_handle *fwnode = dev_fwnode(&msi->pdev->dev);
 
 	msi->inner_domain = irq_domain_add_linear(NULL, msi->num_of_vectors,
 					     &msi_domain_ops, msi);
diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 523bd928b380a4..a7ed08a7d34193 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -672,10 +672,9 @@ static void altera_pcie_isr(struct irq_desc *desc)
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
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index bab962ec7ab468..3e4b0882ee3350 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -494,7 +494,7 @@ static struct msi_domain_info mtk_msi_domain_info = {
 
 static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
 {
-	struct fwnode_handle *fwnode = of_node_to_fwnode(port->pcie->dev->of_node);
+	struct fwnode_handle *fwnode = dev_fwnode(port->pcie->dev);
 
 	mutex_init(&port->lock);
 
diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index bf9c30776087ca..696f0aacce5198 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -515,7 +515,7 @@ static int nwl_pcie_init_msi_irq_domain(struct nwl_pcie *pcie)
 {
 #ifdef CONFIG_PCI_MSI
 	struct device *dev = pcie->dev;
-	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct nwl_msi *msi = &pcie->msi;
 
 	msi->dev_domain = irq_domain_add_linear(NULL, INT_PCI_MSI_NR,
-- 
2.53.0

