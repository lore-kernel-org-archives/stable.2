Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DD747142C;
	Fri, 24 Jul 2026 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784932457; cv=none; b=jBRMk2MmwtMrEcuNjKHcxlvHAIG4Mc3budQJ+3VSKR74TDMi4uFVWDaRCX2oits4TMsDsgyWO4H5dLxxR0KGdot9IyDpNfoBJ2SdztHNmGYlnFGPnj47C4ru8sTiMot5y9S4lPwMIl9s1IW2D3/Fx7naDg5ST6EorLFGx4bwil8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784932457; c=relaxed/simple;
	bh=XxI+985wFLQUFhEGA/zj1RpQMYqEAODftqtccOs5fWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsYG2Lz5ih2wbFWWGYXyQ34pghA5ev8vMd3Mnb05aJ/erX49KJZF+g7mg0CE3asOrX01LuYv2UkUlvPoZH4FewHac50DM8kYyBXPp7Zuk6nlDAMGMNNhS5vVe+z+vlTcFoOAoQgDsMrBLxFSfkyPHSgEF8nrvEZtv5mBgoWwFFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXefIjHi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXefIjHi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A37F1F000E9;
	Fri, 24 Jul 2026 22:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784932454;
	bh=7soi1q8d+++SKLakRqkKcoj+2Bc1NYWX8VVB+ErMchM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WXefIjHimg0dbegMBTl6Qktec02r9+kMLoSGiQXtnKlnabKDR+UHayPddrjR4B/3H
	 eIssKtNXPIFqknH0iASr9K13p+VZqy4sVrJl6K6zCzFteBHDk7IXVO9C565Ll7UbSg
	 gkLHQ3Tgr42hEx65nAuBi/hqvmha0g4aLoPdZnzRetRnD12GiAlhboI25JLeDX9D3x
	 7w6BACBkbLwLRCYKO3gMvIsJ1PWXGLG68AXIgB/6SP0Th3NlqcA93a+oNLaev3cTaR
	 vuoFjU36TM5Vfo/W8sjf0XmnkVuCUvL/gud7nc4fwUtq2d2FOBCzZc9+jEU9oJ7UOp
	 VFByMceXZPDGA==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	stable@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 2/2] nvmem: layouts: Add fixed-layout driver
Date: Fri, 24 Jul 2026 23:34:04 +0100
Message-ID: <20260724223404.629248-3-srini@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724223404.629248-1-srini@kernel.org>
References: <20260724223404.629248-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

Current implementation isn't working well when device tree nodes have a
phandle on a fixed-layout nvmem node. As the fixed layout is handled in
nvmem core, no driver is ever associated with the layout, and the device
consumer driver probe is deferred indefinitely.

Remove the specific handling of fixed-layout and add a layout driver.
This makes the fixed-layout similar to all other layouts, fixing the
whole issue.

Fixes: fc29fd821d9a ("nvmem: core: Rework layouts to become regular devices")
Cc: stable@vger.kernel.org
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 MAINTAINERS                          |  5 +++
 drivers/nvmem/core.c                 | 24 +-----------
 drivers/nvmem/internals.h            |  2 +
 drivers/nvmem/layouts.c              | 11 ------
 drivers/nvmem/layouts/Makefile       |  1 +
 drivers/nvmem/layouts/fixed-layout.c | 58 ++++++++++++++++++++++++++++
 include/linux/nvmem-provider.h       |  6 +++
 7 files changed, 74 insertions(+), 33 deletions(-)
 create mode 100644 drivers/nvmem/layouts/fixed-layout.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..c3bb5b5d1add 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10133,6 +10133,11 @@ F:	drivers/base/firmware_loader/
 F:	rust/kernel/firmware.rs
 F:	include/linux/firmware.h
 
+FIXED-LAYOUT NVMEM LAYOUT DRIVER
+M:	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+S:	Maintained
+F:	drivers/nvmem/layouts/fixed-layout.c
+
 FLEXTIMER FTM-QUADDEC DRIVER
 M:	Patrick Havelange <patrick.havelange@essensium.com>
 L:	linux-iio@vger.kernel.org
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index e871181751f3..2f971b059704 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -786,7 +786,7 @@ static int nvmem_validate_keepouts(struct nvmem_device *nvmem)
 	return 0;
 }
 
-static int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_node *np)
+int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_node *np)
 {
 	struct device *dev = &nvmem->dev;
 	const __be32 *addr;
@@ -834,29 +834,13 @@ static int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_nod
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(nvmem_add_cells_from_dt);
 
 static int nvmem_add_cells_from_legacy_of(struct nvmem_device *nvmem)
 {
 	return nvmem_add_cells_from_dt(nvmem, nvmem->dev.of_node);
 }
 
-static int nvmem_add_cells_from_fixed_layout(struct nvmem_device *nvmem)
-{
-	struct device_node *layout_np;
-	int err = 0;
-
-	layout_np = of_nvmem_layout_get_container(nvmem);
-	if (!layout_np)
-		return 0;
-
-	if (of_device_is_compatible(layout_np, "fixed-layout"))
-		err = nvmem_add_cells_from_dt(nvmem, layout_np);
-
-	of_node_put(layout_np);
-
-	return err;
-}
-
 int nvmem_layout_register(struct nvmem_layout *layout)
 {
 	int ret;
@@ -1005,10 +989,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 			goto err_remove_cells;
 	}
 
-	rval = nvmem_add_cells_from_fixed_layout(nvmem);
-	if (rval)
-		goto err_remove_cells;
-
 	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
 
 	rval = device_add(&nvmem->dev);
diff --git a/drivers/nvmem/internals.h b/drivers/nvmem/internals.h
index 18fed57270e5..f6d452b6a28f 100644
--- a/drivers/nvmem/internals.h
+++ b/drivers/nvmem/internals.h
@@ -35,6 +35,8 @@ struct nvmem_device {
 	bool			sysfs_cells_populated;
 };
 
+int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_node *np);
+
 #if IS_ENABLED(CONFIG_OF)
 int nvmem_layout_bus_register(void);
 void nvmem_layout_bus_unregister(void);
diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
index b90584e1b99e..07a34be9669c 100644
--- a/drivers/nvmem/layouts.c
+++ b/drivers/nvmem/layouts.c
@@ -125,11 +125,6 @@ static int nvmem_layout_create_device(struct nvmem_device *nvmem,
 	return 0;
 }
 
-static const struct of_device_id of_nvmem_layout_skip_table[] = {
-	{ .compatible = "fixed-layout", },
-	{}
-};
-
 static int nvmem_layout_bus_populate(struct nvmem_device *nvmem,
 				     struct device_node *layout_dn)
 {
@@ -142,12 +137,6 @@ static int nvmem_layout_bus_populate(struct nvmem_device *nvmem,
 		return 0;
 	}
 
-	/* Fixed layouts are parsed manually somewhere else for now */
-	if (of_match_node(of_nvmem_layout_skip_table, layout_dn)) {
-		pr_debug("%s() - skipping %pOF node\n", __func__, layout_dn);
-		return 0;
-	}
-
 	if (of_node_check_flag(layout_dn, OF_POPULATED_BUS)) {
 		pr_debug("%s() - skipping %pOF, already populated\n",
 			 __func__, layout_dn);
diff --git a/drivers/nvmem/layouts/Makefile b/drivers/nvmem/layouts/Makefile
index 4940c9db0665..dd6c6c70b1a9 100644
--- a/drivers/nvmem/layouts/Makefile
+++ b/drivers/nvmem/layouts/Makefile
@@ -3,6 +3,7 @@
 # Makefile for nvmem layouts.
 #
 
+obj-$(CONFIG_NVMEM_LAYOUTS) += fixed-layout.o
 obj-$(CONFIG_NVMEM_LAYOUT_SL28_VPD) += sl28vpd.o
 obj-$(CONFIG_NVMEM_LAYOUT_ONIE_TLV) += onie-tlv.o
 obj-$(CONFIG_NVMEM_LAYOUT_U_BOOT_ENV) += u-boot-env.o
diff --git a/drivers/nvmem/layouts/fixed-layout.c b/drivers/nvmem/layouts/fixed-layout.c
new file mode 100644
index 000000000000..635d448b3dd2
--- /dev/null
+++ b/drivers/nvmem/layouts/fixed-layout.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2026 Bootlin
+ *
+ * Authors: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+ */
+
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+
+#include "../internals.h"
+
+static int fixed_layout_add_cells(struct nvmem_layout *layout)
+{
+	struct device_node *np;
+	int ret;
+
+	np = of_nvmem_layout_get_container(layout->nvmem);
+	if (!np)
+		return -ENOENT;
+
+	ret = nvmem_add_cells_from_dt(layout->nvmem, np);
+	of_node_put(np);
+
+	return ret;
+}
+
+static int fixed_layout_probe(struct nvmem_layout *layout)
+{
+	layout->add_cells = fixed_layout_add_cells;
+
+	return nvmem_layout_register(layout);
+}
+
+static void fixed_layout_remove(struct nvmem_layout *layout)
+{
+	nvmem_layout_unregister(layout);
+}
+
+static const struct of_device_id fixed_layout_of_match_table[] = {
+	{ .compatible = "fixed-layout", },
+	{},
+};
+
+static struct nvmem_layout_driver fixed_layout_layout = {
+	.driver = {
+		.name = "fixed-layout",
+		.of_match_table = fixed_layout_of_match_table,
+	},
+	.probe = fixed_layout_probe,
+	.remove = fixed_layout_remove,
+};
+module_nvmem_layout_driver(fixed_layout_layout);
+
+MODULE_AUTHOR("Mathieu Dubois-Briand");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, fixed_layout_of_match_table);
+MODULE_DESCRIPTION("NVMEM fixed-layout driver");
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index f3b13da78aac..6063fe5b7784 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -214,6 +214,12 @@ static inline int nvmem_layout_register(struct nvmem_layout *layout)
 
 static inline void nvmem_layout_unregister(struct nvmem_layout *layout) {}
 
+static inline int nvmem_add_cells_from_dt(struct nvmem_device *nvmem,
+					  struct device_node *np)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_NVMEM */
 
 #if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
-- 
2.53.0

