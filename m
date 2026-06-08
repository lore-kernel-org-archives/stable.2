Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6789D3793CA
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926177; cv=none; b=HhxGhON8stXa/apORUwvBMB1hzEHSxrK+kVLtRo2zgXEkY9o02YRyMMG3ps6+EY3B5IzdGQJ7Ub7+BqFcKCizuRPxJeaGIssu1GP3fk6lLh9/Pjb4sCXn3rGxTmZmcEnGsiBTwagCGsEB7V+PzAHXNiT+3lGDBJUU4gDN0unoGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926177; c=relaxed/simple;
	bh=ol/bMPFe45MQO+UCJ386TULE3Q+J/mFtsQe7luYmHYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=isK6YAdhSN1eKhYJ7xYjs4U9yiRD/NXEOL/5E6ojOupVbjvrWTk1B6SptUjrmdXMGJSx41WYFZcHl24i/UpolG2wKUrazJiJQKiY3OEYV7P6rUhjuMLAdcfM0DH0R3X6hgRuAlE9IolXLG984/Ct3HXw3hTtVGXUYBKamVfOKGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1Mh+MhT2; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1Mh+MhT2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 34FA3C5147F;
	Mon,  8 Jun 2026 13:42:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2E4AB5FFB7;
	Mon,  8 Jun 2026 13:42:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 95BC0106A294C;
	Mon,  8 Jun 2026 15:42:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780926172; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MbgIXAnKHSpP8Crwf7E8qU96JrYErz4nOc7/iu0L3ek=;
	b=1Mh+MhT2TIdBOl0RXM+/c4mczQrA+EdVWijJzz7awBBC3PvETMP+q7wTXOVfMxPDHbxw8a
	XK/xs0K7R6Gueur0ghzopw9Eg80rYzJZI9VSqemUpyvRrigN51r+AQrsWgHjwOBW2Fx9z1
	sqyRRctckF/tCAPBTT6+mEkiJBfRzedJf5a9Rd5HYlihxx0wbPIc69ElzJk2GuaQkgrPYw
	BK8UoAWI7MbJSQv5spSWiDqNHYbB4CkfrH7kMr/zVO8l0M/GfXnewBxf+Ej4uMLLMXcQxZ
	iChQKjGP0wdzbZ2cUMsTrDYCsUoX3nOZwsehdy/th8zxWEfl8cbk8XZ+2YkVGg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 08 Jun 2026 15:42:43 +0200
Subject: [PATCH v3 1/2] nvmem: layouts: Add fixed-layout driver
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-mathieu-nvmem-fixed-layout-v3-1-12ddc69f4c51@bootlin.com>
References: <20260608-mathieu-nvmem-fixed-layout-v3-0-12ddc69f4c51@bootlin.com>
In-Reply-To: <20260608-mathieu-nvmem-fixed-layout-v3-0-12ddc69f4c51@bootlin.com>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780926170; l=7364;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=ol/bMPFe45MQO+UCJ386TULE3Q+J/mFtsQe7luYmHYI=;
 b=mc8SU0VJ8JO+VxCszvZwTwDJbYupzLdiCZtLUch9WkaneCGQZKgTHnMCRjAeiZY3rJAqBdcTR
 /R8Wfm7p9QDDSBMa4voVeTxoljt3TfCjMaN6Kh4iizpw5CeMzayNEM2
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3

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
---
 MAINTAINERS                          |  5 ++++
 drivers/nvmem/core.c                 | 24 ++-------------
 drivers/nvmem/internals.h            |  2 ++
 drivers/nvmem/layouts.c              | 11 -------
 drivers/nvmem/layouts/Makefile       |  1 +
 drivers/nvmem/layouts/fixed-layout.c | 58 ++++++++++++++++++++++++++++++++++++
 include/linux/nvmem-provider.h       |  6 ++++
 7 files changed, 74 insertions(+), 33 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e035a3be797c..d44f601c1dc1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10031,6 +10031,11 @@ F:	drivers/base/firmware_loader/
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
index 311cb2e5a5c0..594180d4b889 100644
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
2.47.3

