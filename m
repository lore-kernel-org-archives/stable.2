Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856C14EA386
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059356; cv=none; b=V3E8G6NYXWq/CdC5WiKWCgA4TI65y5uPmcvEVblpMUX6BFmYbAgCrPXykMBf8k+95OWulPKyQjdykguAjbBGXUjGnwf92ILyVh4s8W9v5s/r5APr12Vng+RJi7JUV7Ui+Vl+HKIYYvrtoXBdaMUFHn2lhHvkSaZjJ0EXq9kv/1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059356; c=relaxed/simple;
	bh=U7oDHrCVb8qUwHA6J6vmZF9vCsElj/mQJvzqoEZpTxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+XPCYORc9P3EXxj0i8chuTWirQ8lFaeGTDGzvko0nCXpc5tV1jC+n6Gi6tfEejnzNBmp9G1twQ3ERmMb0xn3aUEe+ksJb3/gjAcsNEZGKNa84vCImXebhz7r9VgoHhjUpXSef8zwkvb0HRcWZlZJoeMVfDn8FH75Ce77qe6nEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haQPkS1W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haQPkS1W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A961F00ACF;
	Tue, 14 Jul 2026 20:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059349;
	bh=v90dfg4Gvc4pe6EseqWyG9ZyFoQBXbpGPMBckMGnqQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=haQPkS1Wx2zcLiegH56E3QUeBprwDq8rYVZd8nZU80PC9FhENKWJi8WRy7GijZv34
	 Hn9C+rokYNu6BivaYIGFKxjRhawtLpqWmX5i84AtCHRd1f/X7PH/b2svS+7YD6msmF
	 mcsiHtvrDpf/mnXmC7iJapfJ8fPZ7tFmFsfJezY4dDVDLs2v7GTFcj9VILeUGx7+nG
	 VTvW/t/ViH+aYO9U8i77CFU4HzQ438r92uymOI7omCM7hpACLT52syu5dJbqXN835Z
	 4+bCHKQJJxS/yfWAryGUiNSY6E2USiLO1feEPuUdc5455gx/eGeZq87tjjG/JVSbGf
	 y/XPu3P+IRpgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/5] PCI: mediatek: Switch to msi_create_parent_irq_domain()
Date: Tue, 14 Jul 2026 16:02:23 -0400
Message-ID: <20260714200226.3152882-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714200226.3152882-1-sashal@kernel.org>
References: <2026071353-appointee-tactful-9ca3@gregkh>
 <20260714200226.3152882-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nam Cao <namcao@linutronix.de>

[ Upstream commit e449cb9afc963cf9cf47139bb873c412605c83e7 ]

Switch to msi_create_parent_irq_domain() from pci_msi_create_irq_domain()
which was using legacy MSI domain setup.

Signed-off-by: Nam Cao <namcao@linutronix.de>
[mani: reworded commit message]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
[bhelgaas: rebase on dev_fwnode() conversion, drop fwnode local var]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/76f6e6ce6021607cd0fdfd79fef7d2eb69d9f361.1750858083.git.namcao@linutronix.de
Stable-dep-of: f865a57896bd ("PCI: mediatek: Fix IRQ domain leak when port fails to enable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/Kconfig         |  1 +
 drivers/pci/controller/pcie-mediatek.c | 48 ++++++++++++--------------
 2 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 481acb03af80d5..a44f0d46b26a45 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -190,6 +190,7 @@ config PCIE_MEDIATEK
 	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI
+	select IRQ_MSI_LIB
 	help
 	  Say Y here if you want to enable PCIe controller support on
 	  MediaTek SoCs.
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 37495b8cabd234..487cfdf9115ffa 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -12,6 +12,7 @@
 #include <linux/iopoll.h>
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
@@ -180,7 +181,6 @@ struct mtk_pcie_soc {
  * @irq: GIC irq
  * @irq_domain: legacy INTx IRQ domain
  * @inner_domain: inner IRQ domain
- * @msi_domain: MSI IRQ domain
  * @lock: protect the msi_irq_in_use bitmap
  * @msi_irq_in_use: bit map for assigned MSI IRQ
  */
@@ -200,7 +200,6 @@ struct mtk_pcie_port {
 	int irq;
 	struct irq_domain *irq_domain;
 	struct irq_domain *inner_domain;
-	struct irq_domain *msi_domain;
 	struct mutex lock;
 	DECLARE_BITMAP(msi_irq_in_use, MTK_MSI_IRQS_NUM);
 };
@@ -470,40 +469,39 @@ static const struct irq_domain_ops msi_domain_ops = {
 	.free	= mtk_pcie_irq_domain_free,
 };
 
-static struct irq_chip mtk_msi_irq_chip = {
-	.name		= "MTK PCIe MSI",
-	.irq_ack	= irq_chip_ack_parent,
-	.irq_mask	= pci_msi_mask_irq,
-	.irq_unmask	= pci_msi_unmask_irq,
-};
+#define MTK_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS	| \
+				MSI_FLAG_USE_DEF_CHIP_OPS	| \
+				MSI_FLAG_NO_AFFINITY)
+
+#define MTK_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK		| \
+				 MSI_FLAG_PCI_MSIX)
 
-static struct msi_domain_info mtk_msi_domain_info = {
-	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_NO_AFFINITY | MSI_FLAG_PCI_MSIX,
-	.chip	= &mtk_msi_irq_chip,
+static const struct msi_parent_ops mtk_msi_parent_ops = {
+	.required_flags		= MTK_MSI_FLAGS_REQUIRED,
+	.supported_flags	= MTK_MSI_FLAGS_SUPPORTED,
+	.bus_select_token	= DOMAIN_BUS_PCI_MSI,
+	.chip_flags		= MSI_CHIP_FLAG_SET_ACK,
+	.prefix			= "MTK-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
 };
 
 static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
 {
-	struct fwnode_handle *fwnode = dev_fwnode(port->pcie->dev);
-
 	mutex_init(&port->lock);
 
-	port->inner_domain = irq_domain_create_linear(fwnode, MTK_MSI_IRQS_NUM,
-						      &msi_domain_ops, port);
+	struct irq_domain_info info = {
+		.fwnode		= dev_fwnode(port->pcie->dev),
+		.ops		= &msi_domain_ops,
+		.host_data	= port,
+		.size		= MTK_MSI_IRQS_NUM,
+	};
+
+	port->inner_domain = msi_create_parent_irq_domain(&info, &mtk_msi_parent_ops);
 	if (!port->inner_domain) {
 		dev_err(port->pcie->dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
 
-	port->msi_domain = pci_msi_create_irq_domain(fwnode, &mtk_msi_domain_info,
-						     port->inner_domain);
-	if (!port->msi_domain) {
-		dev_err(port->pcie->dev, "failed to create MSI domain\n");
-		irq_domain_remove(port->inner_domain);
-		return -ENOMEM;
-	}
-
 	return 0;
 }
 
@@ -532,8 +530,6 @@ static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
 			irq_domain_remove(port->irq_domain);
 
 		if (IS_ENABLED(CONFIG_PCI_MSI)) {
-			if (port->msi_domain)
-				irq_domain_remove(port->msi_domain);
 			if (port->inner_domain)
 				irq_domain_remove(port->inner_domain);
 		}
-- 
2.53.0

