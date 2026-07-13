Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D43F4252CB
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949189; cv=none; b=uScq7sGAwEJOkuVNZp6TzqN8jWoLgNyY7j3h68CtnLKSNV7UgkM40Dpq35Njjex/FGrd8tufS2ekzpkzhmwxwuM6IZzndsybhPtB6MlEdOMegv0oR2kig+FmxUPAA0GZ2Cp2XHBIJu4YeXyDFvOQn5hcPiVeJGt55b2M65NHwpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949189; c=relaxed/simple;
	bh=CE3ju7MT9WtKAUZkN+VYHhr+PpBj2Xrxsjrph327m24=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cfOngxccz1I+9EwCrONzESxnTyMqHx22E+M7NGI1sOIT7IOCnvlaHchufgBHHKbj2eXxpUvcdVE0J1jh4D+MP4BmHTR2M8qbSfg+qcwz8oCIcVGYnABrxBEoUaGyx5TVn5KDPUuU0N+rnG6sBk3YLnoLx+Z531Gb7hVmakxp4Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FhdeVJ7F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FhdeVJ7F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C721F000E9;
	Mon, 13 Jul 2026 13:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783949187;
	bh=FPXt6J+TdAfQ3Bf60kIuzOEjw+oIJfgqD2vgwavdWRo=;
	h=Subject:To:Cc:From:Date;
	b=FhdeVJ7FDzzhc93kBiMxRD56Qi0imVb2gpvlZmgrDZu0oqeNhK9b6OYD3NKeLx3h9
	 aKJK6Vt4RcOtoa375mxZ6BxWSy9tszOqFBhN6pdRbtd9rSiy5YI+ksyHmY2Brck+2X
	 naZNRSsYTdgZxr8m91qWqg8JzvSV5Pp4OleCjx54=
Subject: FAILED: patch "[PATCH] PCI: mediatek: Fix IRQ domain leak when port fails to enable" failed to apply to 6.12-stable tree
To: manivannan.sadhasivam@oss.qualcomm.com,cjd@cjdns.fr,mani@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:22:53 +0200
Message-ID: <2026071353-appointee-tactful-9ca3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f865a57896bd92d7662eb2818d8f48872e2cbbc7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071353-appointee-tactful-9ca3@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f865a57896bd92d7662eb2818d8f48872e2cbbc7 Mon Sep 17 00:00:00 2001
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Thu, 21 May 2026 23:16:17 +0530
Subject: [PATCH] PCI: mediatek: Fix IRQ domain leak when port fails to enable

When mtk_pcie_enable_port() fails, mtk_pcie_port_free() removes the port
from pcie->ports and frees the port structure. However, the IRQ domains set
up earlier by mtk_pcie_init_irq_domain() are never freed.

Fix this by refactoring mtk_pcie_irq_teardown() into a per-port helper,
mtk_pcie_irq_teardown_port(), and calling it from mtk_pcie_setup() when
mtk_pcie_enable_port() fails. Since the IRQ teardown must only happen in
the probe error path (during resume, child devices may have active MSI
mappings and the NOIRQ context prohibits sleeping locks),
mtk_pcie_enable_port() is changed to return an error code so callers can
distinguish the two paths and act accordingly.

This issue was reported by Sashiko while reviewing the EcoNet EN7528 SoC
support series.

Fixes: b099631df160 ("PCI: mediatek: Add controller support for MT2712 and MT7622")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Cc: stable@vger.kernel.org # 5.10
Cc: Caleb James DeLisle <cjd@cjdns.fr>
Link: https://patch.msgid.link/20260521174617.17692-1-mani@kernel.org

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index dcfc7408340f..f34d91e495bc 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -530,23 +530,27 @@ static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
 	writel(val, port->base + PCIE_INT_MASK);
 }
 
+static void mtk_pcie_irq_teardown_port(struct mtk_pcie_port *port)
+{
+	irq_set_chained_handler_and_data(port->irq, NULL, NULL);
+
+	if (port->irq_domain)
+		irq_domain_remove(port->irq_domain);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		if (port->inner_domain)
+			irq_domain_remove(port->inner_domain);
+	}
+
+	irq_dispose_mapping(port->irq);
+}
+
 static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
 {
 	struct mtk_pcie_port *port, *tmp;
 
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
-		irq_set_chained_handler_and_data(port->irq, NULL, NULL);
-
-		if (port->irq_domain)
-			irq_domain_remove(port->irq_domain);
-
-		if (IS_ENABLED(CONFIG_PCI_MSI)) {
-			if (port->inner_domain)
-				irq_domain_remove(port->inner_domain);
-		}
-
-		irq_dispose_mapping(port->irq);
-	}
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+		mtk_pcie_irq_teardown_port(port);
 }
 
 static int mtk_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
@@ -866,7 +870,7 @@ static int mtk_pcie_startup_port_an7583(struct mtk_pcie_port *port)
 	return mtk_pcie_startup_port_v2(port);
 }
 
-static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
+static int mtk_pcie_enable_port(struct mtk_pcie_port *port)
 {
 	struct mtk_pcie *pcie = port->pcie;
 	struct device *dev = pcie->dev;
@@ -875,7 +879,7 @@ static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
 	err = clk_prepare_enable(port->sys_ck);
 	if (err) {
 		dev_err(dev, "failed to enable sys_ck%d clock\n", port->slot);
-		goto err_sys_clk;
+		return err;
 	}
 
 	err = clk_prepare_enable(port->ahb_ck);
@@ -923,11 +927,15 @@ static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
 		goto err_phy_on;
 	}
 
-	if (!pcie->soc->startup(port))
-		return;
+	err = pcie->soc->startup(port);
+	if (err) {
+		dev_info(dev, "Port%d link down\n", port->slot);
+		goto err_soc_startup;
+	}
 
-	dev_info(dev, "Port%d link down\n", port->slot);
+	return 0;
 
+err_soc_startup:
 	phy_power_off(port->phy);
 err_phy_on:
 	phy_exit(port->phy);
@@ -943,8 +951,8 @@ static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
 	clk_disable_unprepare(port->ahb_ck);
 err_ahb_clk:
 	clk_disable_unprepare(port->sys_ck);
-err_sys_clk:
-	mtk_pcie_port_free(port);
+
+	return err;
 }
 
 static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
@@ -1110,8 +1118,13 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
 		return err;
 
 	/* enable each port, and then check link status */
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
-		mtk_pcie_enable_port(port);
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+		err = mtk_pcie_enable_port(port);
+		if (err) {
+			mtk_pcie_irq_teardown_port(port);
+			mtk_pcie_port_free(port);
+		}
+	}
 
 	/* power down PCIe subsys if slots are all empty (link down) */
 	if (list_empty(&pcie->ports))
@@ -1210,14 +1223,18 @@ static int mtk_pcie_resume_noirq(struct device *dev)
 {
 	struct mtk_pcie *pcie = dev_get_drvdata(dev);
 	struct mtk_pcie_port *port, *tmp;
+	int err;
 
 	if (list_empty(&pcie->ports))
 		return 0;
 
 	clk_prepare_enable(pcie->free_ck);
 
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
-		mtk_pcie_enable_port(port);
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+		err = mtk_pcie_enable_port(port);
+		if (err)
+			mtk_pcie_port_free(port);
+	}
 
 	/* In case of EP was removed while system suspend. */
 	if (list_empty(&pcie->ports))

