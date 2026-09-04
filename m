Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B2A32D0EE
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532370; cv=none; b=FW89sYkuhDOLE+C0KSxh30uvfIp6eUdtNFbegowMr40DNH9p6lW97x6z1u1DHYwyulum6R8+HizfF03hf7TZDmsNjAFKTSNgIo4TNF30mFVmM+HwN0p8UUYy6/m/4mCvh9gNhmgtTojo4HZlA0IrSH9nJ9BbIt47YGmfMMTx08o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532370; c=relaxed/simple;
	bh=fAlDZsp1CdEKdqMfepnT7GyWpt3Bpsx/5ZgrkdvxWg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaiv5BY5MT9YKe3Hx1K5x/XG5O8kpscbH5LPjZhiPqr2VQboZeeLpFY5VKhQfauIWEK11OIgOEQenemLtaRAeFk96x4hmTyaXSAwA3ugzqyF7I4in+14a4YtciqNrlvqUVxEgkz+1oHQm2bvnhcPXBE9jVR6rI0CqWBmvHHEb0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KykdLqKR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KykdLqKR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAD51F00A3D;
	Fri,  4 Sep 2026 14:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788532369;
	bh=neJUaXkTMVRRn+E207iOyJpOZp1vLcWSmHuJiNEYne0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KykdLqKRWJuJVMsLAhdrDp82mytl19L8cjkPIAXTTz4yAhTz6UeZGDSKiLwfNb+59
	 brTN9Yp0s9Lyw1nPNieoq2SFOZBdLqJecGkq7BHB9F8bf8m/S8l09F2C6Ygb8t86Jl
	 9VpI421wEbieVjv1LMOAqRf+y5jZE4IgEzyUjvOVZA4v//ieJUPEyHg6tGJHVjs62r
	 kGDykHxHttByvZCxjpSZ1AnjO/cJhX4NWYgulfiMPMa47QL1+IF78qpdKwzCciddeK
	 vJG2szDbAeQGq8ehybVYSSzfs4mIp4dzBhbF9q6JYz4uUAfctzUiqGr2vMPd6vNoQe
	 7fnQTX+BTxzwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Terry Bowman <terry.bowman@amd.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] cxl/pci: Move CXL driver's RCH error handling into core/ras_rch.c
Date: Fri,  4 Sep 2026 10:32:45 -0400
Message-ID: <20260904143246.806214-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090316-wildfowl-boasting-efe0@gregkh>
References: <2026090316-wildfowl-boasting-efe0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Terry Bowman <terry.bowman@amd.com>

[ Upstream commit 0ff60f2ec3e4043a442e805f80f8a2445113ec8f ]

Restricted CXL Host (RCH) protocol error handling uses a procedure distinct
from the CXL Virtual Hierarchy (VH) handling. This is because of the
differences in the RCH and VH topologies. Improve the maintainability and
add ability to enable/disable RCH handling.

Move and combine the RCH handling code into a single block conditionally
compiled with the CONFIG_CXL_RCH_RAS kernel config.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://patch.msgid.link/20260114182055.46029-9-terry.bowman@amd.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Stable-dep-of: 29458e62d082 ("cxl/ras: Fix cxl_rch_get_aer_info() out-of-bounds AER register read")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/Makefile  |   1 +
 drivers/cxl/core/core.h    |  11 +---
 drivers/cxl/core/pci.c     | 115 -----------------------------------
 drivers/cxl/core/ras_rch.c | 121 +++++++++++++++++++++++++++++++++++++
 tools/testing/cxl/Kbuild   |   1 +
 5 files changed, 126 insertions(+), 123 deletions(-)
 create mode 100644 drivers/cxl/core/ras_rch.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index b2930cc54f8ba..b37f38d502d8c 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -20,3 +20,4 @@ cxl_core-$(CONFIG_CXL_MCE) += mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
 cxl_core-$(CONFIG_CXL_RAS) += ras.o
+cxl_core-$(CONFIG_CXL_RAS) += ras_rch.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index bc818de87cccc..724361195057e 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -149,6 +149,9 @@ int cxl_ras_init(void);
 void cxl_ras_exit(void);
 bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
 void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
+void cxl_dport_map_rch_aer(struct cxl_dport *dport);
+void cxl_disable_rch_root_ints(struct cxl_dport *dport);
+void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
 #else
 static inline int cxl_ras_init(void)
 {
@@ -164,14 +167,6 @@ static inline bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras
 	return false;
 }
 static inline void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base) { }
-#endif /* CONFIG_CXL_RAS */
-
-/* Restricted CXL Host specific RAS functions */
-#ifdef CONFIG_CXL_RAS
-void cxl_dport_map_rch_aer(struct cxl_dport *dport);
-void cxl_disable_rch_root_ints(struct cxl_dport *dport);
-void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
-#else
 static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
 static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
 static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index bd7d7e382d041..68859eba30db3 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -711,121 +711,6 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
 
-#ifdef CONFIG_CXL_RAS
-void cxl_dport_map_rch_aer(struct cxl_dport *dport)
-{
-	resource_size_t aer_phys;
-	struct device *host;
-	u16 aer_cap;
-
-	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
-	if (aer_cap) {
-		host = dport->reg_map.host;
-		aer_phys = aer_cap + dport->rcrb.base;
-		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
-						sizeof(struct aer_capability_regs));
-	}
-}
-
-void cxl_disable_rch_root_ints(struct cxl_dport *dport)
-{
-	void __iomem *aer_base = dport->regs.dport_aer;
-	u32 aer_cmd_mask, aer_cmd;
-
-	if (!aer_base)
-		return;
-
-	/*
-	 * Disable RCH root port command interrupts.
-	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
-	 *
-	 * This sequence may not be necessary. CXL spec states disabling
-	 * the root cmd register's interrupts is required. But, PCI spec
-	 * shows these are disabled by default on reset.
-	 */
-	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
-			PCI_ERR_ROOT_CMD_NONFATAL_EN |
-			PCI_ERR_ROOT_CMD_FATAL_EN);
-	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
-	aer_cmd &= ~aer_cmd_mask;
-	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
-}
-
-/*
- * Copy the AER capability registers using 32 bit read accesses.
- * This is necessary because RCRB AER capability is MMIO mapped. Clear the
- * status after copying.
- *
- * @aer_base: base address of AER capability block in RCRB
- * @aer_regs: destination for copying AER capability
- */
-static bool cxl_rch_get_aer_info(void __iomem *aer_base,
-				 struct aer_capability_regs *aer_regs)
-{
-	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
-	u32 *aer_regs_buf = (u32 *)aer_regs;
-	int n;
-
-	if (!aer_base)
-		return false;
-
-	/* Use readl() to guarantee 32-bit accesses */
-	for (n = 0; n < read_cnt; n++)
-		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
-
-	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
-	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
-
-	return true;
-}
-
-/* Get AER severity. Return false if there is no error. */
-static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
-				     int *severity)
-{
-	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
-		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
-			*severity = AER_FATAL;
-		else
-			*severity = AER_NONFATAL;
-		return true;
-	}
-
-	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
-		*severity = AER_CORRECTABLE;
-		return true;
-	}
-
-	return false;
-}
-
-void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
-{
-	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
-	struct aer_capability_regs aer_regs;
-	struct cxl_dport *dport;
-	int severity;
-
-	struct cxl_port *port __free(put_cxl_port) =
-		cxl_pci_find_port(pdev, &dport);
-	if (!port)
-		return;
-
-	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
-		return;
-
-	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
-		return;
-
-	pci_print_aer(pdev, severity, &aer_regs);
-
-	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(cxlds, dport->regs.ras);
-	else
-		cxl_handle_ras(cxlds, dport->regs.ras);
-}
-#endif
-
 static int cxl_flit_size(struct pci_dev *pdev)
 {
 	if (cxl_pci_flit_256(pdev))
diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
new file mode 100644
index 0000000000000..ed58afd18ecc9
--- /dev/null
+++ b/drivers/cxl/core/ras_rch.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
+
+#include <linux/types.h>
+#include <linux/aer.h>
+#include "cxl.h"
+#include "core.h"
+#include "cxlmem.h"
+
+void cxl_dport_map_rch_aer(struct cxl_dport *dport)
+{
+	resource_size_t aer_phys;
+	struct device *host;
+	u16 aer_cap;
+
+	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
+	if (aer_cap) {
+		host = dport->reg_map.host;
+		aer_phys = aer_cap + dport->rcrb.base;
+		dport->regs.dport_aer =
+			devm_cxl_iomap_block(host, aer_phys,
+					     sizeof(struct aer_capability_regs));
+	}
+}
+
+void cxl_disable_rch_root_ints(struct cxl_dport *dport)
+{
+	void __iomem *aer_base = dport->regs.dport_aer;
+	u32 aer_cmd_mask, aer_cmd;
+
+	if (!aer_base)
+		return;
+
+	/*
+	 * Disable RCH root port command interrupts.
+	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
+	 *
+	 * This sequence may not be necessary. CXL spec states disabling
+	 * the root cmd register's interrupts is required. But, PCI spec
+	 * shows these are disabled by default on reset.
+	 */
+	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
+			PCI_ERR_ROOT_CMD_NONFATAL_EN |
+			PCI_ERR_ROOT_CMD_FATAL_EN);
+	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
+	aer_cmd &= ~aer_cmd_mask;
+	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
+}
+
+/*
+ * Copy the AER capability registers using 32 bit read accesses.
+ * This is necessary because RCRB AER capability is MMIO mapped. Clear the
+ * status after copying.
+ *
+ * @aer_base: base address of AER capability block in RCRB
+ * @aer_regs: destination for copying AER capability
+ */
+static bool cxl_rch_get_aer_info(void __iomem *aer_base,
+				 struct aer_capability_regs *aer_regs)
+{
+	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
+	u32 *aer_regs_buf = (u32 *)aer_regs;
+	int n;
+
+	if (!aer_base)
+		return false;
+
+	/* Use readl() to guarantee 32-bit accesses */
+	for (n = 0; n < read_cnt; n++)
+		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
+
+	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
+	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
+
+	return true;
+}
+
+/* Get AER severity. Return false if there is no error. */
+static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
+				     int *severity)
+{
+	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
+		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
+			*severity = AER_FATAL;
+		else
+			*severity = AER_NONFATAL;
+		return true;
+	}
+
+	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
+		*severity = AER_CORRECTABLE;
+		return true;
+	}
+
+	return false;
+}
+
+void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct aer_capability_regs aer_regs;
+	struct cxl_dport *dport;
+	int severity;
+
+	struct cxl_port *port __free(put_cxl_port) =
+		cxl_pci_find_port(pdev, &dport);
+	if (!port)
+		return;
+
+	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
+		return;
+
+	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
+		return;
+
+	pci_print_aer(pdev, severity, &aer_regs);
+	if (severity == AER_CORRECTABLE)
+		cxl_handle_cor_ras(cxlds, dport->regs.ras);
+	else
+		cxl_handle_ras(cxlds, dport->regs.ras);
+}
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 927fbb6c061f3..950335b3c128f 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -64,6 +64,7 @@ cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
 cxl_core-$(CONFIG_CXL_RAS) += $(CXL_CORE_SRC)/ras.o
+cxl_core-$(CONFIG_CXL_RAS) += $(CXL_CORE_SRC)/ras_rch.o
 cxl_core-y += config_check.o
 cxl_core-y += cxl_core_test.o
 cxl_core-y += cxl_core_exports.o
-- 
2.53.0

