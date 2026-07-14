Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DB74F797E
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059355; cv=none; b=Cc1A470NH+l63PB9faLPFNAbL9ddSqVW4fBkqCc+hK817Z4Cb7bAzdYHbuSmmCnbI+D4zb7L8CHermGFp5BbuiZFKube6LqLEHDHgXC1/QDTv62yvYob+4ZsUmXYl4WmgRsi5OCBKKOB/nruxpPs4TDIZeCBYMw6vnvg3my/NqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059355; c=relaxed/simple;
	bh=dGlAjBUem1g2zyLkhTog4bEwuyqPzQ5VoMpDBhjyZDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbH0apMg6z48Mg1Vhw0JSPfg0TVwUkH9AmAhAAMrTlkJHnoRsM6ZwS5+XidBPd5QHEBZkY6pXcd8KwEm79eVQLSUIOAwcsoHholTMJskA1OQSGB33nlic/jjdhtr55sPWiKvCi8gD1jlwe6Z0SilOfiod85E6L3cPqQ/ArRmDRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iA7CdUU5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iA7CdUU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADE31F00A3D;
	Tue, 14 Jul 2026 20:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059349;
	bh=6GgVxYjEmFnLmlgmmjJPV1cd8ISn/k4MHOwITtQGC5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iA7CdUU5ewNlbZaFYfs1HKo6cP74FeRIJfD40uXdcJvfiDM0OzOM+lBCixVg5SsBl
	 Rp66YTEdigBlDjrj7ksJMGxxg5Q5fyMDXzQmpShB3PNvKmCafpImW9CgtYvkaWBU7F
	 0KFik99pTC3pfA0DfeQFxZSkXgO7XDDc74fEgXIn4aOsDqtDX8BF09Fj6/q48V40is
	 5uA/MzJopW3BEaX99YjdzMUPyt/RmEkxeQmoVtK8cXF4GMp0Sq1lQTWSWZoLaStGHE
	 X7SQBvnBweFilZ2xbWB3QnChAHtMOMT9vHyOkl2da38bLdztviayyme+xVHUr/LpXX
	 G+O7g/so9NWew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/5] PCI: mediatek: Convert bool to single quirks entry and bitmap
Date: Tue, 14 Jul 2026 16:02:24 -0400
Message-ID: <20260714200226.3152882-3-sashal@kernel.org>
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

From: Christian Marangi <ansuelsmth@gmail.com>

[ Upstream commit 04305367fab7ec9c98eeba315ad09c8b20abce93 ]

To clean Mediatek SoC PCIe struct, convert all the bool to a bitmap and
use a single quirks to reference all the values. This permits cleaner
addition of new quirk without having to define a new bool in the struct.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://patch.msgid.link/20251020111121.31779-4-ansuelsmth@gmail.com
Stable-dep-of: f865a57896bd ("PCI: mediatek: Fix IRQ domain leak when port fails to enable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-mediatek.c | 33 ++++++++++++++++----------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 487cfdf9115ffa..8483d854e6d1ee 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -142,24 +142,32 @@
 
 struct mtk_pcie_port;
 
+/**
+ * enum mtk_pcie_quirks - MTK PCIe quirks
+ * @MTK_PCIE_FIX_CLASS_ID: host's class ID needed to be fixed
+ * @MTK_PCIE_FIX_DEVICE_ID: host's device ID needed to be fixed
+ * @MTK_PCIE_NO_MSI: Bridge has no MSI support, and relies on an external block
+ */
+enum mtk_pcie_quirks {
+	MTK_PCIE_FIX_CLASS_ID = BIT(0),
+	MTK_PCIE_FIX_DEVICE_ID = BIT(1),
+	MTK_PCIE_NO_MSI = BIT(2),
+};
+
 /**
  * struct mtk_pcie_soc - differentiate between host generations
- * @need_fix_class_id: whether this host's class ID needed to be fixed or not
- * @need_fix_device_id: whether this host's device ID needed to be fixed or not
- * @no_msi: Bridge has no MSI support, and relies on an external block
  * @device_id: device ID which this host need to be fixed
  * @ops: pointer to configuration access functions
  * @startup: pointer to controller setting functions
  * @setup_irq: pointer to initialize IRQ functions
+ * @quirks: PCIe device quirks.
  */
 struct mtk_pcie_soc {
-	bool need_fix_class_id;
-	bool need_fix_device_id;
-	bool no_msi;
 	unsigned int device_id;
 	struct pci_ops *ops;
 	int (*startup)(struct mtk_pcie_port *port);
 	int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
+	enum mtk_pcie_quirks quirks;
 };
 
 /**
@@ -705,7 +713,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	writel(val, port->base + PCIE_RST_CTRL);
 
 	/* Set up vendor ID and class code */
-	if (soc->need_fix_class_id) {
+	if (soc->quirks & MTK_PCIE_FIX_CLASS_ID) {
 		val = PCI_VENDOR_ID_MEDIATEK;
 		writew(val, port->base + PCIE_CONF_VEND_ID);
 
@@ -713,7 +721,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 		writew(val, port->base + PCIE_CONF_CLASS_ID);
 	}
 
-	if (soc->need_fix_device_id)
+	if (soc->quirks & MTK_PCIE_FIX_DEVICE_ID)
 		writew(soc->device_id, port->base + PCIE_CONF_DEVICE_ID);
 
 	/* 100ms timeout value should be enough for Gen1/2 training */
@@ -1106,7 +1114,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 
 	host->ops = pcie->soc->ops;
 	host->sysdata = pcie;
-	host->msi_domain = pcie->soc->no_msi;
+	host->msi_domain = !!(pcie->soc->quirks & MTK_PCIE_NO_MSI);
 
 	err = pci_host_probe(host);
 	if (err)
@@ -1194,9 +1202,9 @@ static const struct dev_pm_ops mtk_pcie_pm_ops = {
 };
 
 static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
-	.no_msi = true,
 	.ops = &mtk_pcie_ops,
 	.startup = mtk_pcie_startup_port,
+	.quirks = MTK_PCIE_NO_MSI,
 };
 
 static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
@@ -1206,19 +1214,18 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
 };
 
 static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
-	.need_fix_class_id = true,
 	.ops = &mtk_pcie_ops_v2,
 	.startup = mtk_pcie_startup_port_v2,
 	.setup_irq = mtk_pcie_setup_irq,
+	.quirks = MTK_PCIE_FIX_CLASS_ID,
 };
 
 static const struct mtk_pcie_soc mtk_pcie_soc_mt7629 = {
-	.need_fix_class_id = true,
-	.need_fix_device_id = true,
 	.device_id = PCI_DEVICE_ID_MEDIATEK_7629,
 	.ops = &mtk_pcie_ops_v2,
 	.startup = mtk_pcie_startup_port_v2,
 	.setup_irq = mtk_pcie_setup_irq,
+	.quirks = MTK_PCIE_FIX_CLASS_ID | MTK_PCIE_FIX_DEVICE_ID,
 };
 
 static const struct of_device_id mtk_pcie_ids[] = {
-- 
2.53.0

